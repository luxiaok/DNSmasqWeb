#!/usr/bin/python
#-*- coding:utf8 -*-
#Design By Xiaok

from xk_handler import *

HandlersURL = [
    (r"/(|login)/?", xk_login.LoginHandler),
    (r"/logout", xk_login.LogoutHandler),
    (r"/dashboard/?", xk_index.IndexHandler),
    (r"/dns/domain", xk_dns.DnsDomainHandler),
    (r"/dns/record", xk_dns.DnsRecordHandler),
    (r"/dhcp/pool", xk_dhcp.DhcpPoolHandler),
    (r"/dhcp/host", xk_dhcp.DhcpHostHandler),
    (r"/public/api", xk_public.PublicAPIHandler),
    (r"/users", xk_users.UsersHandler),
    (r"/users/logs", xk_users.LoginLogsHandler),
    (r"/test", xk_test.TestHandler),
    #(r"/(favicon\.ico)", tornado.web.StaticFileHandler, dict(path=settings['static_path']+"images/icon")),
]
