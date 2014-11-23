#!/usr/bin/python
#-*- coding:utf8 -*-
# Desgin By Xiaok
from xk_application.xk_main import *

class IndexHandler(BaseHandler):
    # 获取服务器运行时间
    def get_uptime(self):
        f = open('/proc/uptime','r')
        r = f.read()
        u = r.split()
        f.close()
        uptime = self.format_seconds(int(float(u[0])))
        return uptime

    @Auth
    def get(self):
        #print self.get_login_url()
        #print self.current_user
        #print self.user_info()
        data = {"uptime":self.get_uptime()}
        self.render2("xk_index.html",dashboard="active",data=data)
