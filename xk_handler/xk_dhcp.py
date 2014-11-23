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

class DhcpHostHandler(BaseHandler):
    @Auth
    def get(self):
        pool_id = self.get_argument("id",0)
        pool = self.db.get("select * from xk_dhcp_pool where id = %s",pool_id)
        pools = self.db.query("select * from xk_dhcp_pool")
        sql = "select h.id,h.pool as pool_id,h.hostname,h.mac,h.ip,h.comment,h.status,h.action,p.name as pool_name,p.range_start,p.range_end from xk_dhcp_host as h left join xk_dhcp_pool as p on h.pool=p.id"
        if pool_id != 0 :
            sql += " where pool = %s" % pool_id
        dhcp_hosts = self.db.query(sql)
        self.render2("xk_dhcp_host.html",dhcp_hosts=dhcp_hosts,dhcp_pool="active",pool=pool,pools=pools)

    @Auth
    def post(self):
        pool = self.get_argument("pool")
        hostname = self.get_argument("hostname")
        mac = self.get_argument("mac")
        ip = self.get_argument("ip")
        action = self.get_argument("action")
        comment = self.get_argument("comment")
        self.db.execute(" insert into xk_dhcp_host (pool,hostname,mac,ip,action,comment) values (%s,%s,%s,%s,%s,%s) ",pool,hostname,mac,ip,action,comment)
        self.write("1")

