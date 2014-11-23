#!/usr/bin/python
#-*- coding:utf8 -*-
# Desgin By Xiaok
import torndb
import tornado.httpserver
import tornado.ioloop
import tornado.web
import tornado.netutil
import tornado.process
import time
from xk_config.xk_setting import *
from xk_config.xk_url import *

MainSetting = dict(
    template_path = 'xk_html',
    static_path = 'xk_static',
    static_url_prefix = '/xk_static/',
    xsrf_cookies = False,
    cookie_secret = "db884468559f4c432bf1c1775f3dc9da",
    login_url = "/login",
    debug = options.debug,
    autoreload = options.debug,
)

class HttpApplication(tornado.web.Application):
    def __init__(self):
        handlers = HandlersURL
        settings = MainSetting
        tornado.web.Application.__init__(self, handlers, **settings)

        # Have one global connection to DB across all handlers
        self.db = torndb.Connection(
            host=options.mysql_host, database=options.mysql_database,
            user=options.mysql_user, password=options.mysql_password,
            time_zone='+8:00',charset='utf8')

        ping_db = lambda: self.db.query("select now()")
        #def print_test():
        #    print "Hello Test"
        # 每3分钟执行一次数据库查询,防止mysql gone away,时间间隔要小于msyql的wait_timeout时长
        tornado.ioloop.PeriodicCallback(ping_db,3 * 60 * 1000).start()
        #tornado.ioloop.PeriodicCallback(print_test,1 * 30 * 1000).start()

def main():
    if options.ipv6:
        host = None
    else:
        host = "0.0.0.0"
    tornado.options.parse_command_line()

    if options.debug:
        http_server = tornado.httpserver.HTTPServer(request_callback=HttpApplication(),xheaders=True)
        http_server.listen(options.port,host)
        now = time.strftime('%Y-%m-%d %H:%M:%S', time.localtime())
        print '[%s] Listen On Port %s' % ( now, options.port )
    else:
        http_sockets = tornado.netutil.bind_sockets(options.port,host)
        tornado.process.fork_processes(num_processes=options.processes)
        http_server = tornado.httpserver.HTTPServer(request_callback=HttpApplication(),xheaders=True)
        http_server.add_sockets(http_sockets)

    tornado.ioloop.IOLoop.instance().start()
