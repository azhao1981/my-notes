# ansible

## 安装

```bash
pip install --upgrade pip
pip install ansible
```

## 运行脚本或可执行文件

ansible模块command、shell、raw、script
https://blog.51cto.com/lansgg/1745009

```bash
# command模块 [执行远程命令]
ansible testservers -m command -a 'uname -n'
# script模块 [在远程主机执行主控端的shell/python脚本 ]  （使用相对路径）
ansible testservers -m script -a '/etc/ansible/test.sh'
# shell模块 [执行远程主机的shell/python脚本]
ansible testservers -m shell -a 'bash /root/test.sh'
# raw模块 [类似于command模块、支持管道传递]
ansible testservers -m raw -a "ifconfig eth0 |sed -n 2p |awk '{print \$2}' |awk -F: '{print \$2}'"
```

```yaml
  tasks:
    - name: 安装 wazuh-agent
      script: /etc/ansible/playbooks/wazuh-agent/shell/init.sh
```

## 结果输出到文件

```yaml
# 这个会 copy 到远程主机的文件里,不是本地
- copy: content="{{ your_json_feed }}" dest=/path/to/destination/file
- copy:
    content: "{{ your_json_feed }}"
    dest: "/path/to/destination/file"

- name: copy upstart script
  template: 
    src: myCompany-service.conf.j2
    dest: "/etc/init/myCompany-service.conf"

# 这个不能, 不能放task 里
dest: /tmp/repo_version_file
```

https://stackoverflow.com/questions/26732241/ansible-save-registered-variable-to-file

copy
https://docs.ansible.com/ansible/latest/modules/copy_module.html

## 输出并重定向

将标准输出重定向到一个文件的同时并在屏幕上显示
https://blog.csdn.net/edonlii/article/details/24319561

ansible-playbook playbook/xxx.yml 2>&1 | tee log/canal.txt

## sudo 卡住

如果没有 become*,在 shell 里直接加 sudo 会卡住不动

```yaml
  - name: 查看 redis 是否安装
    become: yes
    become_user: root
    become_method: sudo
    shell: '/bin/ps axu | /bin/grep -E "redis" | /bin/grep -v grep'
    register: check
```

ansible-playbook之sudo密码
https://www.jianshu.com/p/50d2bf6a5b73

https://www.middlewareinventory.com/blog/ansible-sudo-ansible-become-example/

手把手教你在python中运行ansible-playbook
https://blog.csdn.net/u013613428/article/details/92837916?depth_1-utm_source=distribute.pc_relevant.none-task&utm_source=distribute.pc_relevant.none-task
使用python开发ansible自定义模块的简单案例
https://www.cnblogs.com/lovesKey/p/10923458.html

在 ansible 里跑  py
https://serverfault.com/questions/536908/ansible-playbook-to-upload-and-execute-a-python-script

好像也不行
https://stackoverflow.com/questions/32429259/ansible-fails-with-bin-sh-1-usr-bin-python-not-found