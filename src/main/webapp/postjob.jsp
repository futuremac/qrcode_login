<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<html lang="utf-8">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
    <title>发布职位</title>

    <!-- Bootstrap -->
    <link rel="stylesheet" href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css">
    <link rel="stylesheet" href="//cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap-theme.min.css">
    <script src="//cdn.bootcss.com/jquery/1.11.3/jquery.min.js"></script>
    <script src="//cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js"></script>
    <script src="//cdn.bootcss.com/1000hz-bootstrap-validator/0.9.0/validator.min.js"></script>
    <script>
        //从from获取数据，转为对象
        function formToJson(form) {
            var result = {};
            var fieldArray = $('#' + form).serializeArray();
            for (var i = 0; i < fieldArray.length; i++) {
                var field = fieldArray[i];
                if (field.name in result) {
                    result[field.name] += ',' + field.value;
                } else {
                    result[field.name] = field.value;
                }
            }
            return result;
        }
        function postJob(){
            var userinfo_str = localStorage.getItem("17NEITUI_LOGIN_INFO");
            if(userinfo_str){
                var jobinfo = formToJson("jobform");
                var userinfo = eval('(' + userinfo_str + ')');
                console.log(userinfo);
                jobinfo.userId = Number(userinfo.userId);
                jobinfo.userName = userinfo.userName;
                jobinfo.companyId = Number(userinfo.companyId);
                jobinfo.companyName = userinfo.companyName;
                $.ajax({
                    url:"http://www.17neitui.com/api/jobs/",
                    type:"POST",
                    data:JSON.stringify(jobinfo),
                    dataType:"json",
                    headers:{
                        "Content-Type":"application/json",
                        "X-AUTH-TOKEN": userinfo.token
                    },
                    success:function(data){
                        alert("职位发布成功！");
                    },
                    error:function(error){
                        alert("职位发布失败！");
                    }
                });
            }else{
                alert("扫描登录失败，请重新登录之后发布职位!");
            }
        }
    </script>
</head>
<body>
<div class="container">
<form id="jobform" class="form-horizontal" data-toggle="validator" role="form">
    <fieldset>
        <div id="legend" class="">
            <legend class="">发布职位</legend>
        </div>
        <div class="control-group form-group">
            <label id="uinfo" class="control-label col-sm-offset-10 col-sm-2"></label>
        </div>
        <div class="control-group form-group has-feedback">

            <!-- Text input-->
            <label class="control-label col-sm-2" for="input01">职位名称*</label>

            <div class="controls col-sm-10">
                <input type="text" placeholder="Java开发工程师" class="input-xlarge" name="title" maxlength="20" required>
                <span class="glyphicon form-control-feedback" aria-hidden="true"></span>
                <span class="help-block with-errors"></span>
            </div>
        </div>
        <div class="control-group form-group has-feedback">

            <!-- Select Basic -->
            <label class="control-label col-sm-2">最低年薪</label>

            <div class="controls col-sm-10">
                <select class="input-xlarge" name="minSalary">
                    <option value="25">25万</option>
                    <option value="5">5万</option>
                    <option value="10">10万</option>
                    <option value="15">15万</option>
                    <option value="20">20万</option>
                    <option value="30">30万</option>
                    <option value="35">35万</option>
                    <option value="40">40万</option>
                    <option value="45">45万</option>
                    <option value="50">50万</option>
                    <option value="60">60万</option>
                    <option value="80">80万</option>
                    <option value="100">100万</option>
                </select>
            </div>

        </div>
        <div class="control-group form-group has-feedback">

            <!-- Select Basic -->
            <label class="control-label col-sm-2">最高年薪</label>

            <div class="controls col-sm-10">
                <select class="input-xlarge" name="maxSalary">
                    <option value="30">30万</option>
                    <option value="10">10万</option>
                    <option value="15">15万</option>
                    <option value="20">20万</option>
                    <option value="25">25万</option>
                    <option value="35">35万</option>
                    <option value="40">40万</option>
                    <option value="45">45万</option>
                    <option value="50">50万</option>
                    <option value="60">60万</option>
                    <option value="80">80万</option>
                    <option value="100">100万</option>
                </select>
            </div>

        </div>
        <div class="control-group form-group has-feedback">

            <!-- Text input-->
            <label class="control-label col-sm-2" for="input01">所在城市</label>

            <div class="controls col-sm-10">
                <input type="text" placeholder="北京" class="input-xlarge" name="city" maxlength="10" data-match-error="超过长度限制" required>
                <span class="glyphicon form-control-feedback" aria-hidden="true"></span>
                <span class="help-block with-errors"></span>
            </div>
        </div>

        <div class="control-group form-group has-feedback">

            <!-- Text input-->
            <label class="control-label col-sm-2" for="input01">职位亮点</label>

            <div class="controls col-sm-10">
                <input type="text" placeholder="一句话描述" class="input-xlarge" name="highlight" minlength="3" data-error="长度不能小于3" required>
                <span class="glyphicon form-control-feedback" aria-hidden="true"></span>
                <span class="help-block with-errors"></span>
            </div>
        </div>


        <div class="control-group form-group has-feedback">

            <!-- Text input-->
            <label class="control-label col-sm-2" for="input01">同事推荐奖励</label>

            <div class="controls col-sm-10">
                <input type="text" placeholder="5000" class="input-xlarge" name="colleaguePrize" minlength="1" maxlength="5" data-error="奖金不能超过10万" required>
                <span class="glyphicon form-control-feedback" aria-hidden="true"></span>
                <span class="help-block with-errors"></span>
                <p class="help-block">请按照公司政策填写</p>
            </div>
        </div>

        <div class="control-group form-group has-feedback">

            <!-- Text input-->
            <label class="control-label col-sm-2" for="input01">好友推荐奖励</label>

            <div class="controls col-sm-10">
                <input type="text" placeholder="一顿饭" class="input-xlarge" name="friendPrize" required>
                <span class="glyphicon form-control-feedback" aria-hidden="true"></span>
                <span class="help-block with-errors"></span>
            </div>
        </div>


        <div class="control-group form-group has-feedback">

            <!-- Select Basic -->
            <label class="control-label col-sm-2">工作经验</label>

            <div class="controls col-sm-10">
                <select class="input-xlarge" name="years" required>
                    <option>1-3年</option>
                    <option>不限</option>
                    <option>应届毕业生</option>
                    <option>一年以下</option>
                    <option>3-5年</option>
                    <option>5-10年</option>
                </select>
            </div>

        </div>

        <div class="control-group form-group has-feedback">

            <!-- Select Basic -->
            <label class="control-label col-sm-2">学历要求</label>

            <div class="controls col-sm-10">
                <select class="input-xlarge" name="education" required>
                    <option>本科</option>
                    <option>不限</option>
                    <option>专科</option>
                    <option>硕士</option>
                    <option>博士</option>
                </select>
            </div>

        </div>

        <div class="control-group form-group has-feedback">

            <!-- Text input-->
            <label class="control-label col-sm-2" for="input01">技能要求</label>

            <div class="controls col-sm-10">
                <input type="text" placeholder="java" class="input-xlarge" name="skills" required>
                <span class="glyphicon form-control-feedback" aria-hidden="true"></span>
                <span class="help-block with-errors"></span>
            </div>
        </div>

        <div class="control-group form-group has-feedback">

            <!-- Textarea -->
            <label class="control-label col-sm-2">职位描述</label>

            <div class="controls col-sm-10">
                <div class="textarea">
                    <textarea type="" class="" style="margin: 0px; width: 263px; height: 59px;" name="description" required> </textarea>
                </div>
                <span class="glyphicon form-control-feedback" aria-hidden="true"></span>
                <span class="help-block with-errors"></span>
            </div>
        </div>


        <div class="control-group form-group">
            <label class="control-label"></label>
            <!-- Button -->
            <div class="controls col-sm-offset-2 col-sm-10">
                <input type="button" value="发布职位" class="btn btn-success input-xxlarge" onclick="postJob()" ></input>
            </div>
        </div>

    </fieldset>
</form>
</div>
<script>
    $(document).ready(function(){
        var userinfo_show = eval('(' + localStorage.getItem("17NEITUI_LOGIN_INFO") + ')');
        $("#uinfo").html("当前用户:" + userinfo_show.userName);
    });
</script>
</body>
</html>
