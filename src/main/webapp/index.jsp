<%@ page import="com.yiqineitui.QRCodeUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>招聘数据统计系统</title>

    <!-- Bootstrap -->
    <link rel="stylesheet" href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css">
    <link rel="stylesheet" href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap-theme.min.css">
    <script src="//cdn.bootcss.com/jquery/1.11.3/jquery.min.js"></script>
    <script src="//cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>

</head>
<body>
<%
    String sessionid = session.getId();
    out.print(sessionid);
    String path = QRCodeUtil.generateQRCode(sessionid);
    out.print("<img src=\"image/" + path + "\">");
%>

<script>
    function getSessionId(){
        var c_name = 'JSESSIONID';
        if(document.cookie.length>0){
            var c_start=document.cookie.indexOf(c_name + "=")
            if(c_start!=-1){
                c_start=c_start + c_name.length+1
                var c_end=document.cookie.indexOf(";",c_start)
                if(c_end==-1) c_end=document.cookie.length
                return document.cookie.substring(c_start,c_end);
            }
        }
    }
    function getLoginStatus(){
        var sessionid = getSessionId();
        console.log(sessionid);
        $.ajax({
            url:"http://www.17neitui.com/users/getScanLogin?sid=" + sessionid,
            success:function(data){
                console.log(data);
                var url = 'postjob.jsp?uid=' + data.uid;
                window.location.href=url;
            }
        });
    }
    setInterval("getLoginStatus()",3000);//3秒一次执行
</script>

</body>
</html>
