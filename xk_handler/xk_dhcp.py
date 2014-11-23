#!/usr/bin/python
#-*- coding:utf8 -*-
# Desgin By Xiaok
from xk_application.xk_main import *

class DhcpPoolHandler(BaseHandler):
    @Auth
    def get(self):
        #
        dhcps = self.db.query("select * from xk_dhcp_pool")
        self.render2("xk_dhcp_pool.html",dhcps=dhcps,dhcp_pool="active")

    @Auth
    def post(self):
        name = self.get_argument("name")
        range_start = self.get_argument("range_start")
        range_end = self.get_argument("range_end")
        netmask = self.get_argument("netmask")
        router = self.get_argument("router")
        dns1 = self.get_argument("dns1")
        dns2 = self.get_argument("dns2")
        domain = self.get_argument("domain")
        lease = self.get_argument("lease")
        comment = self.get_argument("comment")
        self.db.execute('''insert into xk_dhcp_pool ( name,range_start,range_end,netmask,router,dns1,dns2,domain,lease,comment )
            values (%s,%s,%s,%s,%s,%s,%s,%s,%s,%s)''',name,range_start,range_end,netmask,router,dns1,dns2,domain,lease,comment)
        self.write("1")


