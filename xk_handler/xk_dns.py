#!/usr/bin/python
#-*- coding:utf8 -*-
# Desgin By Xiaok
from xk_application.xk_main import *

class DnsDomainHandler(BaseHandler):
    @Auth
    def get(self):
        #print self.get_login_url()
        #print self.current_user
        #print self.user_info()
        domains = self.db.query("select * from xk_domain")
        self.render2("xk_domain.html",domain="active",domains=domains)

    @Auth
    def post(self):
        domain = self.get_argument("domain")
        file = self.get_argument("file")
        comment = self.get_argument("comment")
        fun = self.get_argument("fun","add")
        if fun == "add":
            if_domain = self.db.get("select id,domain from xk_domain where domain = %s",domain)
            if if_domain:
                self.write("2")
                return
            f = open("/etc/dnsmasq.d/" + file,'w')
            f.write("# "+domain+"\n")
            f.close()
            file_md5 = self.get_md5("/etc/dnsmasq.d/"+file)
            self.db.execute("insert into xk_domain (domain,file,file_md5,create_time,comment) values (%s,%s,%s,%s,%s)",domain,file,file_md5,self.get_time(),comment)
            self.write("1")
        elif fun == "edit":
            id_  = self.get_argument("id")
            self.db.execute("update xk_domain set domain = %s, file = %s, comment = %s where id = %s",domain,file,comment,id_)
            self.write("1")

class DnsRecordHandler(BaseHandler):
    @Auth
    def get(self):
        did = self.get_argument("did",0)
        domains = self.db.query("select id,domain from xk_domain where status = 'yes'")
        cur_domain = self.db.get("select * from xk_domain where id = %s",did)
        records = self.db.query("select * from xk_record where did = %s",did)
        self.render2("xk_record.html",record="active",domains=domains,did=int(did),records=records,cur_domain=cur_domain)

    @Auth
    def post(self):
        did = self.get_argument("did")
        record = self.get_argument("record")
        type = self.get_argument("type")
        value = self.get_argument("value")
        priority = self.get_argument("priority")
        comment = self.get_argument("comment")
        fun = self.get_argument("fun","add")
        if type == "MX":
            priority = int(priority)
        else:
            priority = None
        if fun == "add":
            self.db.execute("insert into xk_record (did,record,type,value,priority,comment,create_time) values (%s,%s,%s,%s,%s,%s,%s)",did,record,type,value,priority,comment,self.get_time())
            self.write("1")
        elif fun == "edit":
            id = self.get_argument("id")
            self.db.execute("update xk_record set record = %s, type = %s, value = %s, priority = %s, comment = %s where id = %s",record,type,value,priority,comment,id)
            self.write("1")