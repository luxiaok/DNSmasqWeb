DNSmasqWeb
==========

基于DNSmasq的开源轻量级DNS解析系统

Desgin By [Xiaok](http://github.luxiaok.com)

## 一、应用说明 ##
本DNS系统可以用于机房内网、公司内网、家庭内网等类似内部网络环境

## 二、运行环境 ##
* OS：RHEL 6.5 x64
* Python：2.7.8
* DnsMasq：2.48
* Tornado：4.0.2
* Jinja2：2.7.3

注意：以上是测试运行正常的环境，其他环境请自行测试

## 三、DNSmasq配置说明 ##
* 安装

`yum -y install dnsmasq`

`chkconfig dnsmasq on`

* 主配文件：/etc/dnsmasq.conf

`resolv-file=/etc/dnsmasq.resolv.conf`

`addn-hosts=/etc/dnsmasq.hosts`

`conf-dir=/etc/dnsmasq.d`

## 四、Web配置 ##
* 安装Tornado

`easy_install tornado`

* 安装jinja2

`easy_install tornado`

* 安装数据库驱动

`yum -y install MySQL-python`

`easy_install torndb`

* 导入数据库文件

`mysql> create database xk_dnsmasq;`

`mysql> use xk_dnsmasq;`

`mysql> source xk_db_sql/xk_dnsmasq.sql;`

* 配置Web

`cp xk_config/xk_setting.sample.py xk_config/xk_setting.py`

在文件xk_config/xk_setting.py设置MySQL的主机、端口、用户名、密码

* 启动Web端

`python run.py`

默认用户名/密码：admin/admin

默认端口：9886

## 五、截图 ##
![DnsMasqWeb](https://github.com/luxiaok/DNSmasqWeb/raw/master/xk_screenshot/xk_domain.png)