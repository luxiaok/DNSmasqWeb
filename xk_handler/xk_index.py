#!/usr/bin/python
#-*- coding:utf8 -*-
# Desgin By Xiaok
from xk_application.xk_main import *
import platform,os

class IndexHandler(BaseHandler):
    # 获取服务器运行时间
    def get_uptime(self):
        f = open('/proc/uptime','r')
        r = f.read()
        u = r.split()
        f.close()
        uptime = self.format_seconds(int(float(u[0])))
        cpu_num = os.popen("cat /proc/cpuinfo  | grep processor | wc -l")
        cpu_num = int(cpu_num.read().strip())
        free = int(float(u[1])) * 100 / (int(float(u[0]))*cpu_num)
        uptime['free'] = free
        return uptime

    def get_ip(self):
        r = os.popen("ip a | grep inet | grep -Ev 'inet6|127.0.0.1' | awk -F'[ /]+' '{print $3}'")
        r = r.read()
        ip = r.split()
        if len(ip) > 1:
            ip = ', '.join(ip)
        else:
            ip = ip[0]
        return ip

    def get_load(self):
        f = open('/proc/loadavg')
        l = f.read().split()
        f.close()
        loadavg_1 = l[0]
        loadavg_5 = l[1]
        loadavg_15 = l[2]
        return [loadavg_1,loadavg_5,loadavg_15]

    def get_mem(self):
        f = open('/proc/meminfo')
        m = f.readlines()
        f.close()
        mem = {}
        for n in m:
            if len(n) < 2 : continue
            name = n.split(':')[0]
            var = n.split()[1]
            mem[name] = int(var) * 1024 # 单位默认是K，乘以1024转换为字节
        mem['MemUsed'] = mem['MemTotal'] - mem['MemFree'] - mem['Buffers'] - mem['Cached']
        MemUsedPercent = mem['MemUsed'] * 100 / mem['MemTotal']
        mem['MemUsedPercent'] = MemUsedPercent
        return mem

    def get_hdd(self):
        d = os.statvfs('/')
        all = d.f_frsize * d.f_blocks
        free = d.f_frsize * d.f_bavail
        used = ( d.f_blocks - d.f_bavail ) * d.f_frsize
        usedPercent = ( d.f_blocks - d.f_bavail ) * 100 / d.f_blocks
        return {"all":all, "free":free, "used":used, "usedPercent":usedPercent}

    def net_stat(self):
        net = {}
        f = open("/proc/net/dev")
        lines = f.readlines()
        f.close()
        i = 1
        for line in lines:
            if i < 3 :
               i += 1
               continue
            con = line.split(':')
            name = con[0].split()[0]
            var = con[1].split()
            net[name] = var
            i += 1
        net_in = 0
        net_out = 0
        for i in net:
            if i == 'lo':continue
            net_in += int(net[i][0])
            net_out += int(net[i][8])
        #net_in = net_in / 1024 / 1024
        #net_out = net_out / 1024 /1024
        return {"in":net_in,"out":net_out}

    def get_os_version(self):
        OS = platform.linux_distribution()
        os_arch = platform.machine()
        if 'Red Hat Enterprise Linux Server' in OS:
            os_name = 'RHEL'
        else:
            os_name = OS[0]
        os_version = OS[1]
        return "%s %s %s" % ( os_name,os_version,os_arch)

    @Auth
    def get(self):
        #print self.get_login_url()
        #print self.current_user
        #print self.user_info()
        data = {
            "uptime":self.get_uptime(),
            "ip":self.get_ip(),
            "net":self.net_stat(),
            "mem":self.get_mem(),
            "load":self.get_load(),
            "os":self.get_os_version(),
            "hdd":self.get_hdd()
        }
        #print data
        self.render2("xk_index.html",dashboard="active",data=data)
