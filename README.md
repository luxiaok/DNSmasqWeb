DNSmasqWeb
==========

基于DNSmasq的开源轻量级DNS解析系统

Desgin By [Xiaok](http://github.luxiaok.com)

## 一、环境说明 ##
* 操作系统：RHEL 6.5 x64
* Python：2.7.8
* DnsMasq：2.48
* Tornado：4.0.2
* Jinja2：2.7.3

## 二、DNSmasq配置说明 ##
* 安装
    yum -y install dnsmasq
    chkconfig dnsmasq on

* 主配文件：/etc/dnsmasq.conf
    resolv-file=/etc/dnsmasq.resolv.conf
    addn-hosts=/etc/dnsmasq.hosts
    conf-dir=/etc/dnsmasq.d

## 三、截图 ##
![DnsMasqWeb](https://github.com/luxiaok/DNSmasqWeb/raw/master/xk_screenshot/xk_domain.png)