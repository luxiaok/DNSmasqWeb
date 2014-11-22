#!/usr/bin/python
#-*- coding:utf8 -*-
# Jinja2 For Tornado
# Design By Xiaok
# 2014-11-15 22:01:17
import sys 
reload(sys) 
sys.setdefaultencoding('utf8')
import os
from tornado.web import RequestHandler
from tornado.web import authenticated as Auth
from jinja2 import Environment, FileSystemLoader, TemplateNotFound
import datetime
import time
import functools

class TemplateRendering:
    """
    A simple class to hold methods for rendering templates.
    """
    def render_template(self, template_name, **kwargs):
        template_dirs = []
        if self.settings.get('template_path', ''):
            template_dirs.append(
                self.settings["template_path"]
            )

        env = Environment(loader=FileSystemLoader(template_dirs),trim_blocks=True) # trim_blocks去除生成html产生的大量空行

        try:
            template = env.get_template(template_name)
        except TemplateNotFound:
            raise TemplateNotFound(template_name)
        content = template.render(kwargs)
        return content

class BaseHandler(RequestHandler, TemplateRendering):
    # 自定义Header信息
    def set_default_headers(self):
        self.set_header("Server","XK-WebServer/2014")
        self.set_header("X-Powered-By","LuXiaok")
        self.set_header("Date",self.get_time())

    @property
    def db(self):
        return self.application.db

    def get_current_user(self):
        username = self.get_secure_cookie("xk_auth_token")
        if not username: return None
        #return self.db.get("SELECT * FROM xk_users WHERE id = %s", int(user_id))
        return username

    #@property
    def user_info(self):
        if self.current_user:
            user = self.db.get("SELECT id,username,name FROM xk_users WHERE username = %s", self.current_user)
            return user
        else:
            return None

    # 格式化时间
    def get_time(self,s=None):
        return time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(s))

    # 格式化文件大小
    def format_size(self,i):
        i = int(i)
        unit = 'Bytes'
        if i >= 1024:
            i = i / 1024.0
            unit = 'KB'
            if i >= 1024:
                i = i / 1024
                unit = 'MB'
                if i >= 1024:
                    i = i / 1024
                    unit = 'GB'
        else:
            return '%d %s' % (i,unit)
        return '%.2f %s' % (i,unit)

    # 格式化秒
    def format_seconds(self,s):
        s = int(s)
        D = 0
        H = 0
        M = 0
        S = s
        if S > 59:
            M = S / 60
            S = S % 60
            if M > 59:
                H = M / 60
                M = M % 60
                if H > 23:
                    D = H / 24
                    H = H % 24
        return { 'days':D, 'hours':H, 'minutes':M, 'seconds':S }

    """
    RequestHandler already has a `render()` method. I'm writing another
    method `render2()` and keeping the API almost same.
    """
    def render2(self, template_name, **kwargs):
        """
        This is for making some extra context variables available to
        the template
        """
        kwargs.update({
            'settings': self.settings,
            'STATIC_URL': self.settings.get('static_url_prefix', '/xk_static/'),
            'static_url': self.static_url,
            'get_time': self.get_time,
            'format_size': self.format_size,
            'format_seconds': self.format_seconds,
            'request': self.request,
            'xsrf_token': self.xsrf_token,
            'xsrf_form_html': self.xsrf_form_html,
        })
        content = self.render_template(template_name, **kwargs)
        self.write(content)

# 模块权限管理装饰器
def Perm(method):
    @functools.wraps(method)
    def wrapper(self, *args, **kwargs):
        #### 权限控制 ####
        class_name = self.__class__.__name__  #获取类名，其实获取到了待用该方法的类名，方便更加精确的权限判断
        request_method = self.request.method  #获取请求方法名：GET|POST
        #print "Class Name: %s" % class_name
        #print "Method: %s" % request_method
        permission = self.db.get("select is_admin from login_users where username = %s and status = 'yes'",self.current_user)
        if permission:
            is_admin = permission['is_admin']
            if is_admin == "no":
                self.write(''' <script type="text/javascript" >alert("Sorry，您没有权限操作！");</script> Sorry，您没有权限操作！''')
                return
        ###########
        return method(self, *args, **kwargs)
    return wrapper

