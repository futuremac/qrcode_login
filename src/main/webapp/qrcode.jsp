<%@ page import="pers.futuremac.utils.QRCodeUtil" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="zh-CN">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>扫描登录</title>

    <!-- Bootstrap -->
    <link rel="stylesheet" href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css">
    <link rel="stylesheet" href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap-theme.min.css">
    <script src="//cdn.bootcss.com/jquery/1.11.3/jquery.min.js"></script>
    <script src="//cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>

</head>
<body>
<%
    String sessionid = session.getId();
    String path = QRCodeUtil.generateQRCode(sessionid);
    out.print("<center><img src=\"http://www.17neitui.com/img/qrcode/" + path + "\"></center>");
%>

<script>
    function getLoginStatus(){
        var sid = '<%=sessionid%>';
        console.log(sid);
        $.ajax({
            url:"http://localhost:8081/login/getscanlogin?uid=" + sid,
            success:function(data){
                if(data && data.info) {
                    console.log(data);
                    var info = eval('(' + data.info + ')');
                    if(info.userId){
                        var url = 'http://localhost:8081/postjob?uid=' + info.userId;
                        localStorage.setItem("17NEITUI_LOGIN_INFO",data.info);
                        window.location.href = url;
                    }
                }
            }
        });
    }
    setInterval("getLoginStatus()",3000);//3秒一次执行
</script>

</body>
</html>
