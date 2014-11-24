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
        id = self.get_argument("id",None)
        redirect_id = self.get_argument("did",None)
        if module == "record":
            if fun == "ch_status":
                self.db.execute("update xk_record set status = %s where id = %s",value,id)
                self.redirect("/dns/record?did="+redirect_id)
            elif fun == "del":
                self.db.execute("delete from xk_record where id = %s",id)
                self.redirect("/dns/record?did="+redirect_id)
        elif module == "domain":
            if fun == "ch_status":
                self.db.execute("update xk_domain set status = %s where id = %s",value,id)
                self.redirect("/dns/domain")
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
                records = self.db.query("select r.record,d.domain,r.value,d.file,d.file_md5,r.type,r.priority from xk_record as r left join xk_domain as d on r.did = d.id where r.status = 'yes' and d.status = 'yes' and r.did = %s order by d.domain,inet_aton(r.value)",id)
                # A记录
                file_content = ''
                for i in records:
                    if i['type'] == "A":
                        file_content += "address=/" + i['record']  + "." + i['domain'] + "/" + i['value'] + "\n"
                    elif i['type'] == "MX":
                        file_content += "mx-host=" + i["domain"] + "," + i["value"] + "," + str(i['priority']) + "\n"
                    elif i['type'] == "TXT":
                        file_content += "txt-record="
                        if i["record"] != "@":
                            file_content += i['record'] + "."
                        file_content += i["domain"] + ',"' + i["value"] + '"\n'
                    elif i['type'] == "CNAME":
                        file_content += "cname=" + i['record'] + "." + i["domain"] + "," + i["value"] + "\n"

                force = self.get_argument("force","no")
                check_md5 = i['file_md5']
                if force == "no":
                    check_md5 = self.get_md5("/etc/dnsmasq.d/" + i['file'])
                if check_md5 == i['file_md5']:
                    f = open("/etc/dnsmasq.d/" + i['file'],"w")
                    f.write(file_content)
                    f.close()
                    sv_rt = os.system("/etc/init.d/dnsmasq restart")
                    if sv_rt == 0:
                        update_md5 = self.get_md5("/etc/dnsmasq.d/" + i['file'])
                        self.db.execute("update xk_domain set file_md5 = %s where id = %s",update_md5,id)
                        self.write("0") # 成功
                    else:
                        self.write("1") # 服务重启失败
                else: # md5匹配不上
                    self.write("2") # 校验配置文件失败

            elif fun in ("reload","restart","start","stop"):
                sv_rt = os.system("/etc/init.d/dnsmasq " + fun)
                if sv_rt == 0:
                    self.write("0") # 成功
                else:
                    self.write("1") # 失败
        elif module == "dhcp_host":
            if fun == "ch_status":
                self.db.execute("update xk_dhcp_host set status = %s where id = %s",value,id)
                self.redirect("/dhcp/host?id="+redirect_id)
            elif fun == "del":
                self.db.execute("delete from xk_dhcp_host where id = %s",id)
                self.redirect("/dhcp/host?id="+redirect_id)
        elif module == "dhcp_pool":
            if fun == "ch_status":
                self.db.execute("update xk_dhcp_pool set status = %s where id = %s",value,id)
                self.redirect("/dhcp/pool")
            elif fun == "del":
                self.db.execute("delete from xk_dhcp_host where pool = %s",id)
                self.db.execute("delete from xk_dhcp_pool where id = %s",id)
                self.redirect("/dhcp/pool")