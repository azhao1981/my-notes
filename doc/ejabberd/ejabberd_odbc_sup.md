% ejabberd_odbc_sup
%%% Purpose : ODBC connections supervisor
% http://erlang.org/doc/efficiency_guide/tablesDatabases.html mnesia的文档
start_link(Host) ->
	% 建表/备份
    mnesia:create_table(sql_pool,
			[{ram_copies, [node()]}, {type, bag},
			 {local_content, true},
			 {attributes, record_info(fields, sql_pool)}]),
    mnesia:add_table_copy(sql_pool, node(), ram_copies),
    F = fun () -> mnesia:delete({sql_pool, Host}) end,
    mnesia:ets(F),
    supervisor:start_link({local,
			   gen_mod:get_module_proc(Host, ?MODULE)},
			  ?MODULE, [Host]).

init([Host]) ->
    PoolSize = ejabberd_config:get_option(
                 {odbc_pool_size, Host},
                 fun(I) when is_integer(I), I>0 -> I end,
                 ?DEFAULT_POOL_SIZE),
    StartInterval = ejabberd_config:get_option(
                      {odbc_start_interval, Host},
                      fun(I) when is_integer(I), I>0 -> I end,
                      ?DEFAULT_ODBC_START_INTERVAL),
    Type = ejabberd_config:get_option({odbc_type, Host},
                                      fun(mysql) -> mysql;
                                         (pgsql) -> pgsql;
                                         (sqlite) -> sqlite;
					 (mssql) -> mssql;
                                         (odbc) -> odbc
                                      end, odbc),
    {ok,
     {{one_for_one, PoolSize * 10, 1},
      lists:map(fun (I) ->
			{I,
			 {ejabberd_odbc, start_link,
			  [Host, StartInterval * 1000]},
			 transient, 2000, worker, [?MODULE]}
		end,
		lists:seq(1, PoolSize))}}.

get_pids(Host) ->
    Rs = mnesia:dirty_read(sql_pool, Host),
    [R#sql_pool.pid || R <- Rs].

get_random_pid(Host) ->
    case get_pids(Host) of
      [] -> none;
      Pids -> lists:nth(erlang:phash(p1_time_compat:unique_integer(), length(Pids)), Pids)
    end.

add_pid(Host, Pid) ->
    F = fun () ->
		mnesia:write(#sql_pool{host = Host, pid = Pid})
	end,
    mnesia:ets(F).

remove_pid(Host, Pid) ->
    F = fun () ->
		mnesia:delete_object(#sql_pool{host = Host, pid = Pid})
	end,
    mnesia:ets(F).

transform_options(Opts) ->
    lists:foldl(fun transform_options/2, [], Opts).

transform_options({odbc_server, {Type, Server, Port, DB, User, Pass}}, Opts) ->
    [{odbc_type, Type},
     {odbc_server, Server},
     {odbc_port, Port},
     {odbc_database, DB},
     {odbc_username, User},
     {odbc_password, Pass}|Opts];
transform_options({odbc_server, {mysql, Server, DB, User, Pass}}, Opts) ->
    transform_options({odbc_server, {mysql, Server, ?MYSQL_PORT, DB, User, Pass}}, Opts);
transform_options({odbc_server, {pgsql, Server, DB, User, Pass}}, Opts) ->
    transform_options({odbc_server, {pgsql, Server, ?PGSQL_PORT, DB, User, Pass}}, Opts);
transform_options({odbc_server, {sqlite, DB}}, Opts) ->
    transform_options({odbc_server, {sqlite, DB}}, Opts);
transform_options(Opt, Opts) ->
    [Opt|Opts].

check_sqlite_db(Host) ->
    DB = ejabberd_odbc:sqlite_db(Host),
    File = ejabberd_odbc:sqlite_file(Host),
    Ret = case filelib:ensure_dir(File) of
	      ok ->
		  case sqlite3:open(DB, [{file, File}]) of
		      {ok, _Ref} -> ok;
		      {error, {already_started, _Ref}} -> ok;
		      {error, R} -> {error, R}
		  end;
	      Err ->
		  Err
	  end,
    case Ret of
        ok ->
	    sqlite3:sql_exec(DB, "pragma foreign_keys = on"),
            case sqlite3:list_tables(DB) of
                [] ->
                    create_sqlite_tables(DB),
                    sqlite3:close(DB),
                    ok;
                [_H | _] ->
                    ok
            end;
        {error, Reason} ->
            ?INFO_MSG("Failed open sqlite database, reason ~p", [Reason])
    end.

create_sqlite_tables(DB) ->
    SqlDir = case code:priv_dir(ejabberd) of
                 {error, _} ->
                     ?SQL_DIR;
                 PrivDir ->
                     filename:join(PrivDir, "sql")
             end,
    File = filename:join(SqlDir, "lite.sql"),
    case file:open(File, [read, binary]) of
        {ok, Fd} ->
            Qs = read_lines(Fd, File, []),
            ok = sqlite3:sql_exec(DB, "begin"),
            [ok = sqlite3:sql_exec(DB, Q) || Q <- Qs],
            ok = sqlite3:sql_exec(DB, "commit");
        {error, Reason} ->
            ?INFO_MSG("Failed to read SQLite schema file: ~s",
		      [file:format_error(Reason)])
    end.

read_lines(Fd, File, Acc) ->
    case file:read_line(Fd) of
        {ok, Line} ->
            NewAcc = case str:strip(str:strip(Line, both, $\r), both, $\n) of
                         <<"--", _/binary>> ->
                             Acc;
                         <<>> ->
                             Acc;
                         _ ->
                             [Line|Acc]
                     end,
            read_lines(Fd, File, NewAcc);
        eof ->
            QueryList = str:tokens(list_to_binary(lists:reverse(Acc)), <<";">>),
            lists:flatmap(
              fun(Query) ->
                      case str:strip(str:strip(Query, both, $\r), both, $\n) of
                          <<>> ->
                              [];
                          Q ->
                              [<<Q/binary, $;>>]
                      end
              end, QueryList);
        {error, _} = Err ->
            ?ERROR_MSG("Failed read from lite.sql, reason: ~p", [Err]),
            []
    end.

opt_type(odbc_pool_size) ->
    fun (I) when is_integer(I), I > 0 -> I end;
opt_type(odbc_start_interval) ->
    fun (I) when is_integer(I), I > 0 -> I end;
opt_type(odbc_type) ->
    fun (mysql) -> mysql;
	(pgsql) -> pgsql;
	(sqlite) -> sqlite;
	(mssql) -> mssql;
	(odbc) -> odbc
    end;
opt_type(_) ->
    [odbc_pool_size, odbc_start_interval, odbc_type].
