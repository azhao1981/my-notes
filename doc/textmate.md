# textmate 编译

## https://github.com/textmate/textmate

```bash
xbrew install ragel boost multimarkdown hg ninja capnp google-sparsehash libressl
./configure && ninja
```

A CA file has been bootstrapped using certificates from the SystemRoots
keychain. To add additional certificates (e.g. the certificates added in
the System keychain), place .pem files in
  /usr/local/etc/libressl/certs

and run
  /usr/local/opt/libressl/bin/openssl certhash /usr/local/etc/libressl/certs

libressl is keg-only, which means it was not symlinked into /usr/local,
because LibreSSL is not linked to prevent conflict with the system OpenSSL.

If you need to have libressl first in your PATH run:
  echo 'export PATH="/usr/local/opt/libressl/bin:$PATH"' >> ~/.bash_profile

For compilers to find libressl you may need to set:
  export LDFLAGS="-L/usr/local/opt/libressl/lib"
  export CPPFLAGS="-I/usr/local/opt/libressl/include"

For pkg-config to find libressl you may need to set:
  export PKG_CONFIG_PATH="/usr/local/opt/libressl/lib/pkgconfig"

==> Summary
🍺  /usr/local/Cellar/libressl/2.9.2: 2,894 files, 9.8MB
==> Caveats
==> openssl@1.1
A CA file has been bootstrapped using certificates from the system
keychain. To add additional certificates, place .pem files in
  /usr/local/etc/openssl@1.1/certs

and run
  /usr/local/opt/openssl@1.1/bin/c_rehash

openssl@1.1 is keg-only, which means it was not symlinked into /usr/local,
because openssl/libressl is provided by macOS so don't link an incompatible version.

If you need to have openssl@1.1 first in your PATH run:
  echo 'export PATH="/usr/local/opt/openssl@1.1/bin:$PATH"' >> ~/.bash_profile

For compilers to find openssl@1.1 you may need to set:
  export LDFLAGS="-L/usr/local/opt/openssl@1.1/lib"
  export CPPFLAGS="-I/usr/local/opt/openssl@1.1/include"

For pkg-config to find openssl@1.1 you may need to set:
  export PKG_CONFIG_PATH="/usr/local/opt/openssl@1.1/lib/pkgconfig"

==> readline
readline is keg-only, which means it was not symlinked into /usr/local,
because macOS provides the BSD libedit library, which shadows libreadline.
In order to prevent conflicts when programs look for libreadline we are
defaulting this GNU Readline installation to keg-only.

For compilers to find readline you may need to set:
  export LDFLAGS="-L/usr/local/opt/readline/lib"
  export CPPFLAGS="-I/usr/local/opt/readline/include"

For pkg-config to find readline you may need to set:
  export PKG_CONFIG_PATH="/usr/local/opt/readline/lib/pkgconfig"

==> sqlite
sqlite is keg-only, which means it was not symlinked into /usr/local,
because macOS provides an older sqlite3.

If you need to have sqlite first in your PATH run:
  echo 'export PATH="/usr/local/opt/sqlite/bin:$PATH"' >> ~/.bash_profile

For compilers to find sqlite you may need to set:
  export LDFLAGS="-L/usr/local/opt/sqlite/lib"
  export CPPFLAGS="-I/usr/local/opt/sqlite/include"

For pkg-config to find sqlite you may need to set:
  export PKG_CONFIG_PATH="/usr/local/opt/sqlite/lib/pkgconfig"

==> python
Python has been installed as
  /usr/local/bin/python3

Unversioned symlinks `python`, `python-config`, `pip` etc. pointing to
`python3`, `python3-config`, `pip3` etc., respectively, have been installed into
  /usr/local/opt/python/libexec/bin

If you need Homebrew's Python 2.7 run
  brew install python@2

You can install Python packages with
  pip3 install <package>
They will install into the site-package directory
  /usr/local/lib/python3.7/site-packages

See: https://docs.brew.sh/Homebrew-and-Python
==> mercurial
Bash completion has been installed to:
  /usr/local/etc/bash_completion.d

zsh completions have been installed to:
  /usr/local/share/zsh/site-functions
==> libressl
A CA file has been bootstrapped using certificates from the SystemRoots
keychain. To add additional certificates (e.g. the certificates added in
the System keychain), place .pem files in
  /usr/local/etc/libressl/certs

and run
  /usr/local/opt/libressl/bin/openssl certhash /usr/local/etc/libressl/certs

libressl is keg-only, which means it was not symlinked into /usr/local,
because LibreSSL is not linked to prevent conflict with the system OpenSSL.

If you need to have libressl first in your PATH run:
  echo 'export PATH="/usr/local/opt/libressl/bin:$PATH"' >> ~/.bash_profile

For compilers to find libressl you may need to set:
  export LDFLAGS="-L/usr/local/opt/libressl/lib"
  export CPPFLAGS="-I/usr/local/opt/libressl/include"

For pkg-config to find libressl you may need to set:
  export PKG_CONFIG_PATH="/usr/local/opt/libressl/lib/pkgconfig"