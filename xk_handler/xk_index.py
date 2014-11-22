#!/usr/bin/python
#-*- coding:utf8 -*-
# Desgin By Xiaok
from xk_application.xk_main import *

class IndexHandler(BaseHandler):
    @Auth
    def get(self):
        #print self.get_login_url()
        #print self.current_user
        #print self.user_info()
        self.render2("xk_index.html",dashboard="active",user=self.user_info()['name'])

class DomainHandler(BaseHandler):
    @Auth
    def get(self):
        #print self.get_login_url()
        #print self.current_user
        #print self.user_info()
        self.render2("xk_domain.html",domain="active",user=self.user_info()['name'])