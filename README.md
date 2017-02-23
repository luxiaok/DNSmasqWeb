DNSmasqWeb
==========

基于DNSmasq的开源轻量级DNS解析、DHCP地址分配的开源系统

Desgin By [Xiaok](http://github.luxiaok.com)


## 【Python运维圈】微信公众号 ##

![Python运维圈](https://raw.githubusercontent.com/luxiaok/SaltAdmin/master/static/images/ops_circle_qrcode.jpg)

>也可以微信搜索 **Python运维圈**


## 技术交流QQ群 ##

**459457262**

>加群时请注明来自 **Github**


## 一、应用说明 ##
* 本系统可同时提供DNS解析功能和DHCP地址分配功能
* 本系统可以用于机房内网、公司内网、家庭内网等类似内部网络环境
* 系统基于DNSmasq，Web端基于Python语言和Tornado框架

## 二、运行环境 ##
* OS：RHEL 6.5 x64
* Python：2.7.8
* DnsMasq：2.72
* Tornado：4.0.2
* Jinja2：2.7.3

注意：以上是测试运行正常的环境，其他环境请自行测试

## 三、DNSmasq配置说明 ##
* 常规安装（版本：2.48）

`yum -y install dnsmasq`

`chkconfig dnsmasq on`

* 编辑安装（版本：2.72）

`wget http://www.thekelleys.org.uk/dnsmasq/dnsmasq-2.72.tar.gz`

`tar zxf dnsmasq-2.72.tar.gz`

`cd dnsmasq-2.72`

`vim Makefile`

`PREFIX = /usr/local/dnsmasq`

`make && make install`

`cp dnsmasq.conf.example /etc/dnsmasq.conf`

`ln -s /usr/local/dnsmasq/sbin/dnsmasq /usr/sbin/`

`dnsmasq --version`

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

* 登录页面

![DnsMasqWeb Login](https://github.com/luxiaok/DNSmasqWeb/raw/master/xk_screenshot/xk_login.png)

* 控制中心

![DnsMasqWeb Dashboard](https://github.com/luxiaok/DNSmasqWeb/raw/master/xk_screenshot/xk_dashboard.png)

* 域名管理

![DnsMasqWeb Domain](https://github.com/luxiaok/DNSmasqWeb/raw/master/xk_screenshot/xk_domain.png)

* DNS记录管理

![DnsMasqWeb Record](https://github.com/luxiaok/DNSmasqWeb/raw/master/xk_screenshot/xk_record.png)

* DHCP管理

![DnsMasqWeb DHCP](https://github.com/luxiaok/DNSmasqWeb/raw/master/xk_screenshot/xk_dhcp.png)