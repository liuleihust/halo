<!DOCTYPE html>
<html lang="zh">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=Edge,chrome=1">
        <meta name="renderer" content="webkit">
        <meta content="width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no" name="viewport">
        <title>Halo-<@spring.message code='install.page.title'/></title>
        <link rel="stylesheet" href="/static/halo-backend/plugins/bootstrap/css/bootstrap.min.css">
        <link rel="stylesheet" href="/static/halo-backend/css/AdminLTE.min.css">
        <link rel="stylesheet" href="/static/halo-backend/plugins/animate/animate.min.css">
        <link rel="stylesheet" href="/static/halo-backend/plugins/bootstrapvalidator/css/bootstrapValidator.min.css">
        <!--[if lt IE 9]>
        <script src="//oss.maxcdn.com/html5shiv/3.7.3/html5shiv.min.js"></script>
        <script src="//oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>
        <![endif]-->
        <style>
            body{
                background-color: #f5f5f5;
            }
            .container{
                max-width: 850px;
            }
            .form-horizontal .control-label{
                text-align: left;
            }
            .logo{font-size:56px;text-align:center;margin-bottom:25px;font-weight:500;color:#444;text-shadow:#b2baba .1em .1em .2em;}
        </style>
    </head>
    <body>
        <div class="container">
            <div class="row" style="padding-top: 50px">
                <div class="col-lg-12 col-xs-12">
                    <div class="logo animated fadeInUp">
                        <#--<@spring.message code  是在message 配置文件中找 install.page.title 的值-->
                        Halo<small style="font-size: 14px;"><@spring.message code='install.page.title'/></small>
                    </div>
                    <#if isInstall==false>
                        <#--当 RequestParameters['lang'] 存在的时候-->
                        <#if RequestParameters['lang']??>
                        <#--设置 lang 变量值为 RequestParameters['lang'] 的值 -->
                        <#assign lang ="${RequestParameters['lang']}">
                        </#if>
                        <#--  表单提交方式 post ， 地址为 /install/do -->
                    <form method="post" action="/install/do" class="form-horizontal" id="installForm">
                        <div class="box box-solid animated" id="installFirst">
                            <div class="box-body" style="padding: 30px;">
                                <div class="form-group animated fadeInUp" style="animation-delay: 0.1s">
                                    <label for="blogLocale" class="col-sm-4 control-label"><@spring.message code='install.form.language'/></label>
                                    <div class="col-sm-8">
                                        <select class="form-control" id="blogLocale" name="blogLocale">
                                            <#--selected 属性规定在页面加载时预先选定该选项。-->
                                            <option value="zh_CN" <#if lang?default('zh_CN') = 'zh_CN'>selected</#if>>简体中文</option>
                                            <option value="en_US" <#if lang?default('zh_CN') = 'en_US'>selected</#if>>English</option>
                                        </select>
                                    </div>
                                </div>
                                <div class="form-group animated fadeInUp" style="animation-delay: 0.2s">
                                    <label for="blogTitle" class="col-sm-4 control-label"><@spring.message code='install.form.blogTitle'/></label>
                                    <div class="col-sm-8">
                                        <input type="text" class="form-control" id="blogTitle" name="blogTitle">
                                    </div>
                                </div>
                                <div class="form-group animated fadeInUp" style="animation-delay: 0.3s">
                                    <label for="blogUrl" class="col-sm-4 control-label"><@spring.message code='install.form.blogUrl'/></label>
                                    <div class="col-sm-8">
                                        <input type="text" class="form-control" id="blogUrl" name="blogUrl">
                                    </div>
                                </div>
                                <div class="form-group animated fadeInUp" style="animation-delay: 0.4s">
                                    <label for="userEmail" class="col-sm-4 control-label"><@spring.message code='install.form.userEmail'/></label>
                                    <div class="col-sm-8">
                                        <input type="text" class="form-control" id="userEmail" name="userEmail">
                                    </div>
                                </div>
                                <div class="form-group animated fadeInUp" style="animation-delay: 0.5s">
                                    <label for="userName" class="col-sm-4 control-label"><@spring.message code='install.form.userName'/></label>
                                    <div class="col-sm-8">
                                        <input type="text" class="form-control" id="userName" name="userName">
                                    </div>
                                </div>
                                <div class="form-group animated fadeInUp" style="animation-delay: 0.6s">
                                    <label for="userDisplayName" class="col-sm-4 control-label"><@spring.message code='install.form.userDisplayName'/></label>
                                    <div class="col-sm-8">
                                        <input type="text" class="form-control" id="userDisplayName" name="userDisplayName">
                                    </div>
                                </div>
                                <div class="form-group animated fadeInUp" style="animation-delay: 0.7s">
                                    <label for="userPwd" class="col-sm-4 control-label"><@spring.message code='install.form.userPwd'/></label>
                                    <div class="col-sm-8">
                                        <input type="password" class="form-control" id="userPwd" name="userPwd">
                                    </div>
                                </div>
                                <div class="form-group animated fadeInUp" style="animation-delay: 0.8s">
                                    <label for="userRePwd" class="col-sm-4 control-label"><@spring.message code='install.form.userRePwd'/></label>
                                    <div class="col-sm-8">
                                        <input type="password" class="form-control" id="userRePwd" name="userRePwd">
                                    </div>
                                </div>
                            </div>
                            <div class="box-footer" style="padding-right: 30px;">
                                <button type="submit" class="btn btn-primary btn-sm btn-flat pull-right animated fadeInUp" style="animation-delay: 1s"><@spring.message code='install.btn.submit'/></button>
                            </div>
                        </div>
                        <div class="box box-solid animated fadeInUp" style="display: none" id="installSuccess">
                            <div class="box-body">
                                <h2><@spring.message code='install.success.title'/></h2>
                                <h4><@spring.message code='install.success.message'/></h4>
                            </div>
                            <div class="box-footer" style="padding-right: 30px;">
                                <a class="btn btn-primary btn-sm btn-flat" href="/"><@spring.message code='install.success.btn.front'/></a>
                                <a class="btn btn-primary btn-sm btn-flat" href="/admin/login"><@spring.message code='install.success.btn.dashboard'/></a>
                            </div>
                        </div>
                        <div class="box box-solid animated fadeInUp" style="display: none" id="installError">
                            <div class="box-body">
                                <h2><@spring.message code='install.error.title'/></h2>
                                <h4><@spring.message code='install.error.message'/></h4>
                            </div>
                            <div class="box-footer" style="padding-right: 30px;">
                                <a class="btn btn-primary btn-sm btn-flat" href="/install"><@spring.message code='install.error.btn.return'/></a>
                            </div>
                        </div>
                    </form>
                    <#else >
                    <div class="animated fadeInUp" style="animation-delay: 0.1s">
                        <h4><@spring.message code='install.installed.message'/></h4>
                    </div>
                    </#if>
                </div>
            </div>
        </div>
    </body>


    <script src="/static/halo-common/jquery/jquery.min.js"></script>
    <script src="/static/halo-backend/plugins/bootstrap/js/bootstrap.min.js"></script>
    <script src="/static/halo-backend/plugins/bootstrapvalidator/js/bootstrapValidator.min.js"></script>
    <script src="/static/halo-backend/plugins/bootstrapvalidator/js/language/zh_CN.js"></script>

    <#if isInstall==false>
    <script>
        <#--
        window.location.href : 整个uri字符串(在浏览器就是完整的地址栏)
        window.location.protocol ： url的协议部分 如 http
        window.location.host : url 的主机部分，带端口号，hostname 不带端口号
        window.location.port ： url的端口部分 如 80
        window.location.pathname: url 的文件地址
        -->
        var domain = window.location.host;
        //  $(function () ) 表示 文档完全加载后才开始执行
        $(function () {
            // 提示工具，具有属性 data-toggle="tooltip" 的组件 都开始提示
            $('[data-toggle="tooltip"]').tooltip()
        });
        /*
        表示文档加载就绪后发生，有三种语法
        1. $(document).ready(function)
        2. $().ready(function)
        3. $(function)
         */
        $(document).ready(function () {
            /* $() 选择器.val (设置值)
                         .text(设置文本内容）
                         .html(设置html)

              加载完毕后，设置当前 blogUrl 为 当前访问的地址
             */
            $('#blogUrl').val("http://"+domain);
            // 选择 installForm ,bootstrapValidator 为 bootstrap 的表单验证插件
            $('#installForm')
                .bootstrapValidator({
                    message: '安装表单验证失败',
                    feedbackIcons: {
                        valid: 'glyphicon glyphicon-ok',
                        invalid: 'glyphicon glyphicon-remove',
                        validating: 'glyphicon glyphicon-refresh'
                    },
                    fields: {
                        blogTitle: {
                            message: '网站标题验证失败',
                            validators: {
                                notEmpty: {
                                    message: '网站标题不能为空'
                                }
                            }
                        },
                        userEmail: {
                            message: '邮箱验证失败',
                            validators: {
                                notEmpty: {
                                    message: '邮箱不能为空'
                                },
                                emailAddress: {
                                    message: '邮箱格式有误'
                                }
                            }
                        },
                        userName: {
                            message: '用户名验证失败',
                            validators: {
                                notEmpty: {
                                    message: '用户名不能为空'
                                },
                                stringLength: {
                                    min: 1,
                                    max: 24,
                                    message: '用户名超出长度限制'
                                }
                            }
                        },
                        userPwd: {
                            message: '密码验证失败',
                            validators: {
                                notEmpty: {
                                    message: '密码不能为空'
                                },
                                stringLength: {
                                    min: 6,
                                    max: 18,
                                    message: '密码长度必须在6到18位之间'
                                }
                            }
                        },
                        userRePwd: {
                            message: '密码验证失败',
                            validators: {
                                notEmpty: {
                                    message: '确认密码不能为空'
                                },
                                identical: {
                                    field: 'userPwd',
                                    message: '两次输入的密码不相符'
                                }
                            }
                        }
                    }
                })
                /*  验证成功后才异步提交

                on() 方法在被选元素及子元素上添加一个或多个事件处理程序。
                   所需参数：
                   1. event : 必选，由空格分割多个事件值或 . ，
                   2. childSelector  ： 可选 ， 子选择器
                   3. data ： 可选，规定传递到函数的额外数据
                   4. function：可选，规定当事件发生时运行的函数

                   success form bv 是三个不同的事件
                   参数：event : Event 对象代表事件的状态，
                   比如事件在其中发生的元素、键盘按键的状态、鼠标的位置、鼠标按钮的状态。

                    事件通常与函数结合使用，函数不会在事件发生前被执行！
                 */
                .on('success.form.bv',function (e) {
                    /*
                    preventDefault() 方法阻止元素发生默认的行为
                    （例如，当点击提交按钮时阻止对表单的提交）。
                     */
                    e.preventDefault();
                    /*
                      target ：返回事件的目标节点（触发该事件的节点）
                      在 jQuery 如果一个变量被$()包裹，那么说明这个变量需要包装成 JQuery 对象才可以使用
                      在JQuery 用 $ 表示 JQuery  对象
                     */
                    var $form = $(e.target);
                    // data() 表示 取出  'bootstrapValidator' 的值，获得表单返回值，true 表示通过验证
                    var bv = $form.data('bootstrapValidator');

                    /*
                    $.post()是jquery一个简单的 POST 请求功能以取代复杂 $.ajax .
                    参数：
                    url:发送请求的URL地址
                    data(Map) : (可选) 要发送给服务器的数据，以 Key/value 的键值对形式表示
                    callback(Function): (可选) 载入成功时回调函数(只有当Response的返回状态是success才是调用该方法)。
                    type ： 表示发送的数据类型
                     */

                    $.post($form.attr('action'),$form.serialize(),function (data) {

                        /*
                          data.code === 1 严格相等，表示 安装成功
                            installSuccess 组件显示
                          否则，安装错误显示
                         */

                        if(data.code === 1){
                            $('#installFirst').hide();
                            $('#installSuccess').show();
                        }else{
                            $('#installFirst').hide();
                            $('#installError').show();
                        }
                    },'JSON');
                });
        });

        $('#blogLocale').on('change',function(){
            var lang = $(this).val();
            window.location.href="/install?lang="+lang;
        });
    </script>
    <#else>
    <noscript>Not have Script!</noscript>
    </#if>
</html>
