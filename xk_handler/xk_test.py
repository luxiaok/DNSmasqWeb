#!/usr/bin/python
#-*- coding:utf8 -*-
# Desgin By Xiaok
from xk_application.xk_main import *

class TestHandler(BaseHandler):
    #@Auth
    def get(self):
        self.write("Hello,Test!")