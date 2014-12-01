#!/usr/bin/python
#-*- coding:utf8 -*-
# Desgin By Xiaok
from xk_application.xk_main import *
import os

class PublicAPIHandler(BaseHandler):
    def reload_dhcp(self,file,force=False):
        dhcp_conf = self.db.query("select * from xk_options where type = 'dhcp'")
        d = {}
        for i in dhcp_conf:
            d[i['name']] = i['value']
        if force is False:
            check_md5 = self.get_md5(file)
            if check_md5 != d['xk_dhcp_conf_md5']:
                return 1 # MD5校验失败
        if not d['xk_dhcp_pool_domain']:
            d['xk_dhcp_pool_domain'] = 'luxiaok.com'
        if not d['xk_dhcp_pool_dns2']:
            d['xk_dhcp_pool_dns2'] = "8.8.8.8"
        conf = '''# Gen By Luxiaok
# Address Pool
dhcp-range=%s,%s,%s,%s
# Gateway,3
dhcp-option=option:router,%s
# DNS Server
dhcp-option=6,%s,%s
# NTP Server,4 or 42
#dhcp-option=42,202.120.2.101
# DNS Domain
dhcp-option=15,%s\n''' % (d['xk_dhcp_pool_start'],d['xk_dhcp_pool_stop'],d['xk_dhcp_pool_netmask'],d['xk_dhcp_pool_lease'],d['xk_dhcp_pool_gw'],d['xk_dhcp_pool_dns1'],d['xk_dhcp_pool_dns2'],d['xk_dhcp_pool_domain'])
        dhcp_hosts = self.db.query("select * from xk_dhcp_host where status = 'yes'")
        if dhcp_hosts:
            for i in dhcp_hosts:
                if i['action'] == 'allow':
                    conf += "#%s\ndhcp-host=%s,%s\n" % (i['hostname'],i['mac'],i['ip'])
                else:
                    conf += "#%s\ndhcp-host=%s,ignore\n" % (i['hostname'],i['mac'])
        try:
            f = open(file,'w')
            f.write(conf)
            self.db.execute("update xk_options set value = %s where name = 'xk_dhcp_conf_md5' and type = 'dhcp'",self.get_md5(file))
        except:
            return 4 # 写入配置失败
        finally:
            f.close()
        sv_rt = os.system("/etc/init.d/dnsmasq restart")
        if sv_rt == 0:
            return 2 # 写入文件成功，重新加载配置成功
        else:
            return 3 # 重启服务失败

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
                self.redirect("/dhcp/host")
            elif fun == "del":
                self.db.execute("delete from xk_dhcp_host where id = %s",id)
                self.redirect("/dhcp/host")
            elif fun == "ch_action":
                self.db.execute("update xk_dhcp_host set action = %s where id = %s",value,id)
                self.redirect("/dhcp/host")
        elif module == "dhcp":
            if fun == "reload":
                # Test URL: http://www.yourdomain.com:9886/public/api?module=dhcp&fun=reload&value=force
                if value == "force":
                    force = True
                else:
                    force = False
                rt = self.reload_dhcp("/etc/dnsmasq.d/dhcp.conf",force)
                self.write(str(rt))
                return

