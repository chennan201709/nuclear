<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://" + request.getServerName() + ":" + request.getServerPort() + path + "/";
%>
<!DOCTYPE html>
<html>
<head>
    <base href="<%=basePath%>">

    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <%-- 说明 --%>
    <title>管理商品</title>
    <meta name="description" content="使用bootstrap-table实现对所有商品的增加，删除，查询">

    <%-- css引用 --%>
    <link rel="shortcut icon" href="favicon.ico"> <link href="css/bootstrap.min14ed.css?v=3.3.6" rel="stylesheet">
    <link href="css/font-awesome.min93e3.css?v=4.4.0" rel="stylesheet">
    <link href="css/plugins/bootstrap-table/bootstrap-table.min.css" rel="stylesheet">
    <link href="css/animate.min.css" rel="stylesheet">
    <link href="css/style.min862f.css?v=4.1.0" rel="stylesheet">
    <link href="css/plugins/sweetalert/sweetalert.css" rel="stylesheet">
    <link href="https://cdn.bootcss.com/bootstrap-validator/0.5.3/css/bootstrapValidator.min.css" rel="stylesheet">
    <link href="head/cropper.min.css" rel="stylesheet">
    <link href="head/sitelogo.css" rel="stylesheet">
    <style type="text/css">
        .avatar-btns button {
            height: 35px;
        }
    </style>
</head>
<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="ibox float-e-margins">
            <div class="col-sm-12">
                <!-- Example Events -->
                <div class="example-wrap">
                    <h4 class="example-title">事件</h4>
                    <div class="example">
                        <div class="btn-group hidden-xs" id="exampleTableEventsToolbar" role="group">
                            <button type="button" class="btn btn-outline btn-default" id="NuManageadd" data-toggle="modal" data-target="#myModal2">
                                <i class="glyphicon glyphicon-plus" aria-hidden="true">新增</i>
                            </button>
                            <button type="button" class="btn btn-outline btn-default">
                                <i class="glyphicon glyphicon-trash" aria-hidden="true">删除</i>
                            </button>
                        </div>
                        <table id="exampleTableEvents" data-height="400" data-mobile-responsive="true">
                        </table>
                    </div>
                </div>
                <!-- End Example Events -->
            </div>
        </div>
    </div>

    <%--modal 添加开始--%>
    <div class="modal inmodal" id="myModal2" tabindex="-1" role="dialog" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content animated flipInY">
                <form id="form1" action="/useradd" method="post">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
                        <h4 class="modal-title">添加商品</h4>
                        <small class="font-bold" />
                    </div>
                    <div class="modal-body">
                        <div class="form-group">
                            <div class="form-group">
                                <label>商品名称</label>
                                <input type="text" placeholder="请输入商品名称" class="form-control" name="gname">
                            </div>
                            <div class="form-group">
                                <label>商品单价</label>
                                <input type="text" placeholder="请输入商品单价" class="form-control" name="gprice">
                            </div>
                            <div class="form-group">
                                <label>商品库存</label>
                                <input type="text" placeholder="请输入库存数量" class="form-control" name="gintro">
                            </div>
                            <div class="form-group">
                                <label>上传展示</label>
                                <img src="">
                                <button type="button" class="btn btn-primary"  data-toggle="modal" data-target="#avatar-modal" style="margin: 10px;">
                                    修改头像
                                </button>
                                <div class="row">
                                    <div class="col-md-3">
                                        <div class="avatar-wrapper preview-lg" id="imgreal"></div>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label>商品简介</label>
                                <textarea id="ccomment" name="grepertory" class="form-control" required="" aria-required="true" placeholder="请输入商品简介(不多于50字)"></textarea>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-white" data-dismiss="modal" id="btnclose">关闭</button>
                        <button type="submit" class="btn btn-primary" id="btnadd">保存</button>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <%--modal 添加结束--%>

    <%-- 裁剪图片modal开始 --%>
    <div class="modal fade" id="avatar-modal" aria-hidden="true" aria-labelledby="avatar-modal-label" role="dialog" tabindex="-1">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <!--<form class="avatar-form" action="upload-logo.php" enctype="multipart/form-data" method="post">-->
                <form class="avatar-form">
                    <div class="modal-header">
                        <button class="close" data-dismiss="modal" type="button">&times;</button>
                        <h4 class="modal-title" id="avatar-modal-label">上传图片</h4>
                    </div>
                    <div class="modal-body">
                        <div class="avatar-body">
                            <div class="avatar-upload">
                                <input class="avatar-src" name="avatar_src" type="hidden">
                                <input class="avatar-data" name="avatar_data" type="hidden">
                                <label for="avatarInput" style="line-height: 35px;">图片上传</label>
                                <button class="btn btn-danger"  type="button" style="height: 35px;" onclick="$('input[id=avatarInput]').click();">请选择图片</button>
                                <span id="avatar-name"></span>
                                <input class="avatar-input hide" id="avatarInput" name="avatar_file" type="file">
                            </div>
                            <div class="row">
                                <div class="col-md-9">
                                    <div class="avatar-wrapper"></div>
                                </div>
                                <div class="col-md-3">
                                    <div class="avatar-preview preview-lg" id="imageHead"></div>
                                </div>
                            </div>
                            <div class="row avatar-btns">
                                <div class="col-md-4">
                                    <div class="btn-group">
                                        <button class="btn btn-danger fa fa-undo" data-method="rotate" data-option="-90" type="button" title="Rotate -90 degrees"> 向左旋转</button>
                                    </div>
                                    <div class="btn-group">
                                        <button class="btn  btn-danger fa fa-repeat" data-method="rotate" data-option="90" type="button" title="Rotate 90 degrees"> 向右旋转</button>
                                    </div>
                                </div>
                                <div class="col-md-5" style="text-align: right;">
                                    <button class="btn btn-danger fa fa-arrows" data-method="setDragMode" data-option="move" type="button" title="移动">
                                            <span class="docs-tooltip" data-toggle="tooltip" title="" data-original-title="$().cropper(&quot;setDragMode&quot;, &quot;move&quot;)">
                                            </span>
                                    </button>
                                    <button type="button" class="btn btn-danger fa fa-search-plus" data-method="zoom" data-option="0.1" title="放大图片">
                                            <span class="docs-tooltip" data-toggle="tooltip" title="" data-original-title="$().cropper(&quot;zoom&quot;, 0.1)">
                                              <!--<span class="fa fa-search-plus"></span>-->
                                            </span>
                                    </button>
                                    <button type="button" class="btn btn-danger fa fa-search-minus" data-method="zoom" data-option="-0.1" title="缩小图片">
                                            <span class="docs-tooltip" data-toggle="tooltip" title="" data-original-title="$().cropper(&quot;zoom&quot;, -0.1)">
                                              <!--<span class="fa fa-search-minus"></span>-->
                                            </span>
                                    </button>
                                    <button type="button" class="btn btn-danger fa fa-refresh" data-method="reset" title="重置图片">
                                                <span class="docs-tooltip" data-toggle="tooltip" title="" data-original-title="$().cropper(&quot;reset&quot;)" aria-describedby="tooltip866214">
                                                </span>
                                    </button>
                                </div>
                                <div class="col-md-3">
                                    <button class="btn btn-danger btn-block avatar-save fa fa-save" type="button" data-dismiss="modal"> 保存修改</button>
                                </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
        </div>
    </div>
    <%-- 裁剪图片modal结束 --%>

    <%--<script src="js/jquery.min.js?v=2.1.4"></script>--%>
    <script src="http://cdn.bootcss.com/jquery/1.11.1/jquery.min.js"></script>
    <script src="js/bootstrap.min.js?v=3.3.6"></script>
    <script src="js/content.min.js?v=1.0.0"></script>
    <script src="js/plugins/bootstrap-table/bootstrap-table.min.js"></script>
    <%--<script src="https://cdn.bootcss.com/bootstrap-table/1.2.2/bootstrap-table.js"></script>--%>
    <script src="js/plugins/bootstrap-table/bootstrap-table-mobile.min.js"></script>
    <script src="js/plugins/bootstrap-table/locale/bootstrap-table-zh-CN.min.js"></script>
    <script src="https://cdn.bootcss.com/bootstrap-validator/0.5.3/js/bootstrapValidator.min.js"></script>
    <script src="https://cdn.bootcss.com/bootstrap-validator/0.5.3/js/language/zh_CN.js"></script>
    <script src="js/plugins/sweetalert/sweetalert.min.js"></script>
    <script src="https://cdn.bootcss.com/jquery.form/4.2.1/jquery.form.js"></script>
    <script src="head/cropper.js"></script>
    <script src="head/sitelogo.js"></script>
    <script src="head/html2canvas.min.js" type="text/javascript" charset="utf-8"></script>
    <%--<script src="js/demo/bootstrap-table-demo.min.js"></script>--%>
    <%--<script type="text/javascript" src="http://tajs.qq.com/stats?sId=9051096" charset="UTF-8"></script>--%>
</body>
<!-- 图片上传的js -->
<script type="text/javascript">
    //做个下简易的验证  大小 格式
    $('#avatarInput').on('change', function(e) {
        var filemaxsize = 1024 * 5;//5M
        var target = $(e.target);
        var Size = target[0].files[0].size / 1024;
        if(Size > filemaxsize) {
            alert('图片过大，请重新选择!');
            $(".avatar-wrapper").childre().remove;
            return false;
        }
        if(!this.files[0].type.match(/image.*/)) {
            alert('请选择正确的图片!')
        } else {
            var filename = document.querySelector("#avatar-name");
            var texts = document.querySelector("#avatarInput").value;
            var teststr = texts; //你这里的路径写错了
            testend = teststr.match(/[^\\]+\.[^\(]+/i); //直接完整文件名的
            filename.innerHTML = testend;
        }

    });

    $(".avatar-save").on("click", function() {
        var img_lg = document.getElementById('imageHead');
        alert("2");
        // 截图小的显示框内的内容
        html2canvas(img_lg, {
            allowTaint: true,
            taintTest: false,
            onrendered: function(canvas) {
                alert("3");
                canvas.id = "mycanvas";
                //生成base64图片数据
                var dataUrl = canvas.toDataURL("image/jpeg");
                var newImg = document.createElement("img");
                newImg.src = dataUrl;
                alert(dataUrl);
                imagesAjax(dataUrl)
            }
        });
    });

    function imagesAjax(src) {
        alert("5");
        var data = {};
        data.img = src;
        alert(src);
        data.jid = $('#jid').val();
        $.ajax({
            url: "updateUserMess",
            data: data,
            type: "POST",
            dataType: 'json',
            success: function(re) {
                alert("1");
                alert(re.toString());
            },
            error: function (re) {
                alert("2");
                alert(re);
                $("#imgreal").append("<img src='"+"' id='logo1' class='img-responsive center-block'/>");

            }
        });
    }
</script>
<script type="text/javascript">
    $(function () {
        alert("1");
        //1.初始化Table
        var oTable = new TableInit();
        oTable.Init();
        alert("2");
        //2.初始化Button的点击事件
        var oButtonInit = new ButtonInit();
        oButtonInit.Init();
    });
    $(function () {
        $("#form1").bootstrapValidator({
            message: 'This value is not valid',
            feedbackIcons: {
                valid: 'glyphicon glyphicon-ok',
                invalid: 'glyphicon glyphicon-remove',
                validating: 'glyphicon glyphicon-refresh'
            },
            fields: {
                uname: {
                    message: '账户名验证失败',
                    validators: {
                        notEmpty: {
                            message: '账户名不能为空'
                        },
                        stringLength: {
                            min: 6,
                            max: 18,
                            message: '账户名长度必须在6到18位之间'
                        },
                        regexp: {
                            regexp: /^[a-zA-Z0-9_]+$/,
                            message: '账户名由字母、数字、下划线组成'
                        },
                        remote: {
                            message: '该账户名以被注册',
                            url: "checkExist",
                            type: 'post',
                            data: function (validator) {
                                return {
                                    maccont: $("#uname").val()
                                };
                            },
                            delay: 1000
                        }
                    }
                },
                upassword: {
                    validators: {
                        notEmpty: {
                            message: '密码不能为空'
                        }
                    }
                },
                upassword1: {
                    validators: {
                        notEmpty: {
                            message: '密码不能为空'
                        },
                        identical: {
                            field: 'upassword',
                            message: '两次密码不一致'
                        }
                    }
                }
            }
        });
    });

    $(function () {
        $("#form1").ajaxForm(function (data) {
            alert("2");
            if(-1 < data.indexOf("success")){
                alert("1");
                swal({
                    title:"太帅了",
                    text:"小手一抖就打开了一个框",
                    type:"success"
                });
                $("#form1").resetForm();
                $("#btnclose").click();
            }else{
                alert("添加失败");
            }
        });
    });
    //    $("#btnadd").click(function(){
    //        swal({
    //            title:"太帅了",
    //            text:"小手一抖就打开了一个框",
    //            type:"success"
    //        })
    //        $("#btnclose").click();
    //    });


    var TableInit = function () {
        var oTableInit = new Object();
        alert("3");
        //初始化Table
        oTableInit.Init = function () {
            $('#exampleTableEvents').bootstrapTable({
                url: '/userquery',         //请求后台的URL（*）
                method: 'post',                      //请求方式（*）
                toolbar: '#exampleTableEventsToolbar',                //工具按钮用哪个容器
                striped: true,                      //是否显示行间隔色
                cache: false,                       //是否使用缓存，默认为true，所以一般情况下需要设置一下这个属性（*）
                pagination: true,                   //是否显示分页（*）
                sortable: false,                     //是否启用排序
                sortOrder: "asc",                   //排序方式
                queryParams: oTableInit.queryParams,//传递参数（*）
                sidePagination: "client",           //分页方式：client客户端分页，server服务端分页（*）
                pageNumber:1,                       //初始化加载第一页，默认第一页
                pageSize: 10,                       //每页的记录行数（*）
                pageList: [10, 25, 50, 100],        //可供选择的每页的行数（*）
                search: true,                       //是否显示表格搜索，此搜索是客户端搜索，不会进服务端，所以，个人感觉意义不大
                strictSearch: true,
                showColumns: true,                  //是否显示所有的列
                showRefresh: true,                  //是否显示刷新按钮
                minimumCountColumns: 1,             //最少允许的列数
                clickToSelect: true,                //是否启用点击选中行
                height: 500,                        //行高，如果没有设置height属性，表格自动根据记录条数觉得表格高度
                uniqueId: "ID",                     //每一行的唯一标识，一般为主键列
                showToggle:true,                    //是否显示详细视图和列表视图的切换按钮
                cardView: false,                    //是否显示详细视图
                detailView: false,                   //是否显示父子表
                columns: [{
                    checkbox: true
                },{
                    field: 'uname',
                    title: '管理员帐号'
                }, {
                    field: 'upic',
                    title: '管理员头像'
                }, {
                    field: 'usex',
                    title: '管理员头像'
                }, {
                    field: 'ubirthday',
                    title: '管理员头像'
                }, {
                    field: 'ulimits',
                    title: '管理员头像'
                }, {
                    field: 'uphone',
                    title: '管理员头像'
                }]
            });
        };
        //得到查询的参数
        oTableInit.queryParams = function (params) {
            var temp = {   //这里的键的名字和控制器的变量名必须一直，这边改动，控制器也需要改成一样的
                limit: params.limit,   //页面大小
                offset: params.offset,  //页码
                uname: $("#uname").val()
            };
            return temp;
        };
        return oTableInit;
    };


    var ButtonInit = function () {
        var oInit = new Object();
        var postdata = {};

        oInit.Init = function () {
            //初始化页面上面的按钮事件
        };
        return oInit;
    };
</script>

</html>