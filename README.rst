rkhunter的安装方法:
salt '节点' state.sls rkhunter
salt '节点' state.sls rkhunter.update

rkhunter安装方法有2中:
使用epel安装,这种安装方法会自动安装1个每天定时任务,配置文件中会自定义一些修改项
可以参考:https://github.com/zajk/rkhunter-formula/

使用tarball安装, 需要手动设置任意时间点定时任务,手动修改配置文件
安装完毕后需要在确保系统安全的情况下,生产rkhunter基准rkhunter --propupd
制作定时任务

备注: 
只是检测后警告,不防御,因此如果确定系统被攻破,建议是重装镜像
手动检测方法:rkhunter -c -sk

feature:
添加到zabbix中


入侵检测工具
chkrootkit
rkhunter (http://rkhunter.cvs.sourceforge.net/viewvc/rkhunter/rkhunter/files/FAQ)
logcheck
其他的常见的入侵检测软件：
1、tripwire--操作比较复杂
2、aide--用以代替tripwire的一款新产品

参考文献
http://www.rackspace.com/knowledge_center/article/scanning-for-rootkits-with-rkhunter
http://www.rackspace.com/knowledge_center/article/scanning-for-rootkits-with-chkrootkit
