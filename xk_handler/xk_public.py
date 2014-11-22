#!/usr/bin/python
#-*- coding:utf8 -*-
# Desgin By Xiaok
from xk_application.xk_main import *
import os

class PublicAPIHandler(BaseHandler):
    @Auth
    def get(self):
        module = self.get_argument("module")
        fun = self.get_argument("fun")
        value = self.get_argument("value",None)
        id = self.get_argument("id")
        redirect_id = self.get_argument("did",None)
        if module == "record":
            if fun == "ch_status":
                self.db.execute("update xk_record set status = %s where id = %s",value,id)
                self.redirect("/record?did="+redirect_id)
            elif fun == "del":
                self.db.execute("delete from xk_record where id = %s",id)
                self.redirect("/record?did="+redirect_id)
        elif module == "domain":
            if fun == "ch_status":
                self.db.execute("update xk_domain set status = %s where id = %s",value,id)
                self.redirect("/domain")
            elif fun == "del":
                # 获取该域名的配置文件
                domain = self.db.get("select * from xk_domain where id = %s",id)
                file = domain['file']
                file_md5 = domain['file_md5']
                # 删除该域名的DNSmasq的配置文件
                os.remove("/etc/dnsmasq.d/"+file)
                # 同时删除域名的所有记录
                self.db.execute("delete from xk_record where did = %s",id)
                # 删除域名
                self.db.execute("delete from xk_domain where id = %s",id)
                self.redirect("/domain")
        elif module == "dnsmasq":  # 同步解析
            if fun == "update": # 从数据库更新配置文件并重新加载服务
                records = self.db.query("select r.record,d.domain,r.value,d.file,d.file_md5 from xk_record as r left join xk_domain as d on r.did = d.id where r.status = 'yes' and d.status = 'yes' and r.type = 'A' and r.did = %s order by d.domain,inet_aton(r.value)",id)
                # A记录
                file_content = ''
                for i in records:
                    file_content += "address=/" + i['record']  + "." + i['domain'] + "/" + i['value'] + "\n"
                f = open("/etc/dnsmasq.d/" + i['file'],"w")
                f.write(file_content)
                f.close()
                sv_rt = os.system("/etc/init.d/dnsmasq restart")
                if sv_rt == 0:
                    update_md5 = self.get_md5("/etc/dnsmasq.d/" + i['file'])
                    self.db.execute("update xk_domain set file_md5 = %s where id = %s",update_md5,id)
                    self.write("OK")
                else:
                    self.write("Failed")
            elif fun == "reload":
                pass
            elif fun == "restat":
                pass
            elif fun == "stop":
                pass
            elif fun == "start":
                pass