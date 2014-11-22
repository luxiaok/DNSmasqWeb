#!/usr/bin/python
#-*- coding:utf8 -*-
# Desgin By Xiaok
from tornado.options import define, options

# HTTP Port Setting
define("port", default=9886, help="Run on the given port", type=int)

# Debug Setting
define("debug", default=True, help="Debug Setting",type=bool)

# IPv6 Setting
define("ipv6", default=False, help="IPv6 Setting",type=bool)

# Worker Processes Setting
define("processes", default=4, help="Worker Processes Setting", type=int)

# MySQL Config Options
define("mysql_host", default="127.0.0.1:3306", help="Database Host and Port")
define("mysql_database", default="xk_dnsmasq", help="Database Name")
define("mysql_user", default="test", help="Database User")
define("mysql_password", default="test", help="Database Password")
