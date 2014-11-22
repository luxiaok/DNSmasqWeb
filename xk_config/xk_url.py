#!/usr/bin/python
#-*- coding:utf8 -*-
#Design By Xiaok

from xk_handler import xk_login
from xk_handler import xk_index
from xk_handler import xk_test
from xk_handler import xk_public

HandlersURL = [
    (r"/(|login)/?", xk_login.LoginHandler),
    (r"/logout", xk_login.LogoutHandler),
    (r"/dashboard/?", xk_index.IndexHandler),
    (r"/domain", xk_index.DomainHandler),
    (r"/record", xk_index.RecordHandler),
    (r"/public/api", xk_public.PublicAPIHandler),
    (r"/test", xk_test.TestHandler),
    #(r"/(favicon\.ico)", tornado.web.StaticFileHandler, dict(path=settings['static_path']+"images/icon")),
]
