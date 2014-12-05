#!/usr/bin/python
#-*- coding:utf8 -*-
# Desgin By Xiaok
from xk_application.xk_main import *

class UsersHandler(BaseHandler):
    def get(self):
        users = self.db.query("select * from xk_users")
        self.render2("xk_users.html",users=users,users_admin="active")