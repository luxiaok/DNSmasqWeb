#!/usr/bin/python
#-*- coding:utf8 -*-
# Desgin By Xiaok
from xk_application.xk_main import *

class DhcpPoolHandler(BaseHandler):
    @Auth
    def get(self):
        #
        dhcp_options = self.db.query('''select * from xk_options where type = "dhcp"''')
        dhcp = {}
        for i in dhcp_options:
            dhcp[i['name']] = i['value']
        self.render2("xk_dhcp_pool.html",dhcp=dhcp,dhcp_pool="active")

    @Auth
    def post(self):
        status = self.get_argument("status")
        range_start = self.get_argument("range_start")
        range_end = self.get_argument("range_end")
        netmask = self.get_argument("netmask")
        lease = self.get_argument("lease")
        router = self.get_argument("router")
        dns1 = self.get_argument("dns1")
        dns2 = self.get_argument("dns2")
        domain = self.get_argument("domain")
        ntp = self.get_argument("ntp",'')
        comment = self.get_argument("comment")
        #self.db.execute('''insert into xk_dhcp_pool ( name,range_start,range_end,netmask,router,dns1,dns2,domain,lease,comment )
        #    values (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)''',name,range_start,range_end,netmask,router,dns1,dns2,domain,lease,comment)
        self.db.execute('''
            insert into xk_options (name,value,comment) values
            ('xk_dhcp_status',%s,'DHCP开关'),
            ('xk_dhcp_pool_start',%s,'DHCP地址池开始地址'),
            ('xk_dhcp_pool_stop',%s,'DHCP地址池结束地址'),
            ('xk_dhcp_pool_netmask',%s,'DHCP地址池子网掩码'),
            ('xk_dhcp_pool_lease',%s,'DHCP租约'),
            ('xk_dhcp_pool_gw',%s,'DHCP默认网关'),
            ('xk_dhcp_pool_dns1',%s,'DHCP主DNS服务器'),
            ('xk_dhcp_pool_dns2',%s,'DHCP辅助DNS服务器'),
            ('xk_dhcp_pool_domain',%s,'DHCP缺省域名'),
            ('xk_dhcp_pool_ntp',%s,'DHCP时间服务器'),
            ('xk_dhcp_pool_comment',%s,'DHCP地址池备注')
            ON DUPLICATE KEY UPDATE name=values(name),value=values(value),comment=values(comment)
         ''',status,range_start,range_end,netmask,lease,router,dns1,dns2,domain,ntp,comment)
        self.write("1")

class DhcpHostHandler(BaseHandler):
    @Auth
    def get(self):
        dhcp_hosts = self.db.query("select * from xk_dhcp_host")
        self.render2("xk_dhcp_host.html",dhcp_hosts=dhcp_hosts,dhcp_pool="active")

    @Auth
    def post(self):
        hostname = self.get_argument("hostname")
        mac = self.get_argument("mac")
        ip = self.get_argument("ip")
        action = self.get_argument("action")
        comment = self.get_argument("comment")
        check_mac = self.db.query("select id,mac from xk_dhcp_host where mac = %s",mac.lower())
        check_ip = self.db.query("select id,ip from xk_dhcp_host where ip = %s",ip)
        if check_mac:
            self.write("2")  # MAC地址冲突
            return
        if check_ip:
            self.write("3")  # IP地址冲突
            return
        self.db.execute(" insert into xk_dhcp_host (hostname,mac,ip,action,comment) values (%s,%s,%s,%s,%s) ",hostname,mac.lower(),ip,action,comment)
        self.write("1")

