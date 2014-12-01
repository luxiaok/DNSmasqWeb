/*  Gen By Xiaok  */
function reload_dhcp(force) {
    $.ajax({
                    type: "GET",
                    url: "/public/api",
                    data: { "module":"dhcp","fun":"reload","value":force},
                    dataType: "text",
                    success: function(msg){
                        if (msg == "2") {
                            alert("刷新DHCP配置成功！");
                            location.reload();
                        } else if (msg == "1") {
                            // 配置文件MD5校验失败，是否强制执行？
                            if ( confirm("配置文件MD5校验失败，是否强制执行？") ) {
                                reload_dhcp("force");
                                return true;
                            };
                            return false;
                        } else if (msg == "3") {
                            // 重启服务失败
                            alert("重启DNSmasq服务失败！");
                            return false;
                        } else if (msg == "4") {
                            // 写入配置失败
                            alert("写入DHCP配置失败！");
                            return false;
                        } else {
                            alert("提示：操作失败！");
                            return false;
                        }
                        },
                    error:function(){
                        alert("提示：服务器内部错误！");
                        return false;
                        },
    });
};
