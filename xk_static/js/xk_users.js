/*
 *
 *  For User Page
 *  Desgin By Xiaok
 *  2014-12-10 23:22:54
 *
*/

function add_user() {
    username = $("#username").val();
    name = $("#name").val();
    email = $("#email").val();
    mobile = $("#mobile").val();
    password = $("#password").val();
    password2 = $("#password2").val();
    comment = $("#comment").val();
    if (username == '') {
        alert("请输入用户名！");
        $("#username").focus();
        return false;
    };
    if (name == '') {
        alert("请输入姓名！");
        $("#name").focus();
        return false;
    };
    if (password == '') {
        alert("请输入密码！");
        $("#password").focus();
        return false;
    };
    if (password2 == '') {
        alert("请再次输入密码！");
        $("#password2").focus();
        return false;
    };
    if (password != password2) {
        alert("密码不一致！");
        $("#password").val("");
        $("#password2").val("");
        $("#password").focus();
        return false;
    };
    $.ajax({
        type: "POST",
        url: "/users",
        data: {
            'username': username,
            'name': name,
            "email": email,
            "mobile": mobile,
            "password": password,
            'comment': comment,
            "fun": "add"
        },
        dataType: "text",
        success: function(msg) {
            if (msg == "1") {
                alert("添加成功！");
                window.location.href = "/users";
            } else if (msg == "2") {
                alert("用户已存在！");
                $("#username").focus();
            } else {
                alert("提示：添加用户失败！");
            }
        },
        error: function() {
            alert("提示：服务器内部错误！");
        },
    });
};
function show_add() {
    $("#add_line").removeClass("display_no");
    $("#domain").focus();
};
function cancel_add() {
    $("#add_line").addClass("display_no");
};
function to_edit(id) {
    show_id = "#line_" + id;
    edit_id = "#edit_line_" + id;
    $(show_id).addClass("display_no");
    $(edit_id).removeClass("display_no");
};
function to_line(id) {
    show_id = "#line_" + id;
    edit_id = "#edit_line_" + id;
    $(show_id).removeClass("display_no");
    $(edit_id).addClass("display_no");
};
/* 编辑保存记录 */
function save_info(id) {
    //username = $("#username_"+id).val();
    name = $("#name_" + id).val();
    email = $("#email_" + id).val();
    mobile = $("#mobile_" + id).val();
    comment = $("#comment_" + id).val();
    $.ajax({
        type: "POST",
        url: "/users",
        data: {
            "id": id,
            "name": name,
            "email": email,
            "mobile": mobile,
            "comment": comment,
            "fun": "edit"
        },
        dataType: "text",
        success: function(msg) {
            if (msg == "1") {
                alert("修改成功！");
                location.href = "/users";
            } else {
                alert("提示：修改失败！");
                return false;
            }
        },
        error: function() {
            alert("提示：服务器内部错误！");
            return false;
        },
    });
};
function ch_pass(id, username) {
    $("#cur_uid").val(id);
    $("#cur_user").val(username);
    $("#oldpass").val("**********");
    $("#userlist").addClass("display_no");
    $("#pass_form").removeClass("display_no");
};
function cancel_pass() {
    $("#pass_form").addClass("display_no");
    $("#userlist").removeClass("display_no");
};
function save_pass() {
    uid = $("#cur_uid").val();
    username = $("#cur_user").val();
    pass1 = $("#newpass").val();
    pass2 = $("#newpass2").val();
    if (pass1 == '' || pass2 == '') {
        alert("密码不能为空！");
        return false;
    }
    if (pass1 != pass2) {
        alert("两次输入密码不一致！！");
        return false;
    };
    $.ajax({
        type: "POST",
        url: "/users",
        data: {
            "id": uid,
            "password": pass1,
            "fun": "pass"
        },
        dataType: "text",
        success: function(msg) {
            if (msg == "1") {
                alert("修改密码成功！");
                location.href = "/users";
            } else {
                alert("提示：修改密码失败！");
                return false;
            }
        },
        error: function() {
            alert("提示：服务器内部错误！");
            return false;
        },
    });
};

/*
 *
 *  For User Page
 *  Desgin By Xiaok
 *  2014-12-10 23:22:54
 *
*/