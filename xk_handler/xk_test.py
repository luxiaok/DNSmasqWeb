#!/usr/bin/python
#-*- coding:utf8 -*-
# Desgin By Xiaok
from xk_application.xk_main import *

class TestHandler(BaseHandler):
    #@Auth
    def get(self):
        self.render2("xk_test.html")