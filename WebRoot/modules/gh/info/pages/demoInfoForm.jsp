<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ page import="com.sunrise.framework.core.LoginUserSession" %>
<%@ taglib prefix="r" uri="http://www.sunrisetech.com/rdcp/" %>
<%@ page import="com.sunrise.framework.core.LoginUserSession" %>
<%
    String path = request.getContextPath()+ "/";;
    String port = (request.getServerPort() == 80 || request.getServerPort() == 443) ? "" : ":" + String.valueOf(request.getServerPort());
    String basePath = request.getScheme() + "://" + request.getServerName() + port +  path.replace("//","");
    String curUserName = LoginUserSession.getLoginUserInfo() == null ? "null" : LoginUserSession.getLoginUserInfo().getName();
    request.setAttribute("_basePath", basePath);
    request.setAttribute("_curUserId", curUserName);
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <base href="${_basePath}"/>
    <r:include resource="!rdcp/pages/listBase.jsp"/>
    <script type="text/javascript" src="!rdcp/script/src/rdcp.js"></script>
    <script type="text/javascript" src="!rdcp/script/lib/jquery/jquery-1.8.0.min.js"></script>
    <link href="!service/file/~/css/editfile.css" rel="stylesheet" type="text/css">
    <title>历史文化</title>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <link href="themes/default/css/index.css" rel="stylesheet" type="text/css">
    <link href="themes/default/css/sunrise.css" rel="stylesheet" type="text/css">
    <link href="themes/brisk_orange/css/commonbtn.css" rel="stylesheet" type="text/css">
    <script type="text/javascript" src="!comm/~/scripts/getParamsFromPaCode.js"></script>
    <script type="text/javascript" src="scripts/editor/kindeditor.js"></script>
    <link href="!service/file/~/css/editfile.css" rel="stylesheet" type="text/css"/>
    <%
        String option = request.getParameter("option");
        String info_id = request.getParameter("info_id");
    %>
</head>
<body style="background:#f4f4f4;">
<div class="SR_Space">
    <div class="SR_moduleBox">
        <div class="SR_moduleTitle">基础信息</div>
    </div>
    <div align="center">
        <!-- 搜索标头开始-->
        <div class="SR_searchTableBox">
            <div class="barquerycontent">
                <form id="demoInfoForm" name="demoInfoForm">
                    <textarea style="display:none;" id="content" name="content"></textarea>
                    <table border="0">
                        <tr>
                            <td class="SR_searchTitle" style="width: 100px;">标题:</td>
                            <td  style="width: 300px;">
                                <input type="text" name="title" id="title" class="SR_pureInput"  style="width: 280px;"/>
                            </td>
                            <td class="SR_searchTitle" style="width: 100px;">信息类别:</td>
                            <td>
                                <select id="type" name="type">
                                    <option value="">--请选择--</option>
                                    <option value="4">4</option>
                                    <option value="5">5</option>
                                    <option value="6">6</option>
                                    <option value="7">7</option>
                                    <option value="8">8</option>
                                </select>
                            </td>
                            <td>
                                <input type="hidden" name="info_id" id="info_id"/>
                            </td>
                            <td class="SR_searchTitle" style="width: 100px;">发布日期:</td>
                            <td style="width: 300px;">
                                <input type="text" name="create_time" id="create_time"  class="easyui-datetimebox"/>

                            </td>
                        </tr>
                    </table>
                </form>
            </div>
        </div>
    </div>

    <div id="publicUploadDlg" style="display:none;">
        <input type="hidden" id="publicBusiId"/>
        <input type="hidden" id="publicBusiType"/>
        <input type="hidden" id="publicDivId"/>
        <div id="publicUploader"></div>
    </div>

    <div class="SR_moduleBox">
        <div class="SR_moduleTitle">信息内容</div>
        <div class="SR_moduleRight">
        </div>
    </div>
    <div id="myEditor"></div>
    <textarea id="editor_id" name="body" style="width:700px;height:300px;"></textarea>

    <div class="SR_moduleBox">
        <div class="SR_moduleTitle">附件列表</div>
    </div>
    <div align="center">
        <div id="uploader2"></div>
    </div>

    <div class="floatSmallBtn" style="width: 500px;" align="center">
        <a class="btn_commit" href="javascript:void(0);"
           onclick="sureBtn();" title="">提交</a>
        <a class="btn_cancel" href="javascript:void(0);"
           onclick="cancel()" title="">取消</a>
    </div>
</div>
<div id="uploadDlg">
    <div id="uploader"></div>
    <input type="hidden" id="fileUrl"/>
</div>
</div>
<!--style给定宽度可以影响编辑器的最终宽度-->
</body>
<script type="text/javascript">
    var uploadDlgOpt =
        {
            title: "上传文件",
            id: "publicUploadDlg",
            width: "550",
            height: "320",
            modal: true,
            buttons: [
                {
                    text: '确定',
                    handler: function () {
                        var busiId = $("#publicBusiId").val();
                        var busiType = $("#publicBusiType").val();
                        var divId = $("#publicDivId").val();
                        publicShowFiles(busiId, busiType, divId);
                        $("#publicUploadDlg").dialog("close");
                    }
                },
                {
                    text: '返回',
                    handler: function () {
                        $("#publicUploadDlg").dialog("close");
                    }
                }]
        };
    function publicUploadFile(busiId, busiType, divId) {
        $("#publicUploader").html("");
        $("#publicBusiId").val(busiId);
        $("#publicBusiType").val(busiType);
        $("#publicDivId").val(divId);
        rdcp.uploader("publicUploader", {busiId: busiId, busiType: busiType}, {
            onSuccess: function (file) {
            }
        });
        rdcp.dialog(uploadDlgOpt);
    }
    function publicShowFiles(busiId, busiType, div_id) {
        rdcp.request("!service/file/~query/Q_FILE_GET_FILE_LIST", {
            "busiId": busiId,
            "busiType": busiType
        }, function (data) {
            var files = data.body.rows;
            $("#" + div_id).html("");
            for (var i = 0; i < files.length; i++) {
                var name = files[i].cell[3];
                var id = files[i].cell[0];
                var $TR = $("<TR>");
                $TR.append();
                $TR.append("<td>" + name + "</td>");
                var html = "<tr id='file_" + id + "'>";
                html += "<td>" + name + "</td>";
                html = "<td><a href=\"javascript:void(0);\" onclick=\"publicDownloadFile('" + id + "');\" class=\"btn_leading_out\">下载</a>";
                html += "<a href=\"javascript:void(0);\" class=\"btn_delete\" onclick=\"publicDelFile('" + id + "');\">删除</a></td></tr>";
                $TR.append(html);
                $("#" + div_id).append($TR);
            }
        });
    }

    function publicDownloadFile(id) {
        var url = "!service/file/~java/Downloader.get?id=" + id;
        window.open(url);
    }

    function publicDelFile(id) {
        if (confirm("确定要删除文件吗？"))
            rdcp.request("!service/file/~java/Uploader.del?id=" + id, {}, function () {
                $("#file_" + id).remove();
            });
    }

    //获取操作类型 add or edit
    var option = "<%=option%>";
    //获取history_id
    var info_id = "<%=info_id%>";
    //获取服务器根路径
    var serverBasePath = "<%=basePath%>";
    //定义编辑器
    var editor;
    //初始化编辑器
    KindEditor.ready(function(K) {
        //创建一个编辑器
        editor = K.create('textarea[id="editor_id"]', {
            allowFileManager : true,//是否打开文件管理功能
            allowImageRemote : false,//是否允许上传网络图片
            pasteType : 2,//粘贴类型为HTML粘贴
            height : "400",//高度
            width : "100%"//宽度
        });
    });
    //rdcp.JS初始化
    rdcp.ready(function () {
        //填充历史文化类型下拉列表getParamsByPaCode(id,code_table,code_fields,callback)
        getParamsByPaCode("type", "BI_DEMO_INFO", "TYPE", function () {
            if (option == "add") {
                rdcp.request("!gh/info/~query/Q_GET_INFO_ID",{"seq":"bi_demo_info_seq"},function(data){
                    info_id = data.body.seq;
                    $("#info_id").val(info_id);
                    //初始化上传控件
                    initUpload();
                });
            }
            else if (option == "edit") {
                //如果option为edit，则加载表单
                rdcp.form.load("demoInfoForm", "!gh/info/~query/Q_GET_DEMO_INFO", 'info_id=' + info_id, function (data) {
                    editor.insertHtml(data.body.content);
                    initUpload();
                    if(data.body.attach_ids != ""){
                        //加载附件列表
                        loadFiles(data.body.attach_ids, data.body.attach_names,"attach");
                    }
                });
            }
        });
    });
    function initUpload(){
        rdcp.uploader("uploader2", {busiId: info_id, busiType: "BI_DEMO_INFO_ATTACH"}, {
            onSuccess: function (file) {
            }
        });
    }
    function loadFiles(file_ids,file_names,type) {
        var ids = file_ids.split(",");
        var names = file_names.split(",");
        for (var i = 0; i < ids.length; i++) {
            var html = "<li id='file_" + ids[i] + "' class='SR_uploadFileBox'><div class='SR_uploadFileBoxBtn'>" +
                    "<div class='SR_imgName'><h2>" + names[i] + "</h2></div><input class='SR_uploaderDel' type='button' onclick=\"publicDelFile('" + ids[i] + "')\"></div><div class='SR_uploadImg'>";
            if (type == "attach") {
                html += "<img src='!service/file/~/images/defaults.png'/></div></li>";
                $("#uploader2").find(".SR_uploadFileList ul").append(html);
            }
        }
    }
    //提交方法
    function sureBtn() {
        //获取编辑器内容
        var title = $("#title").val();
        var type = $("#type").val();
        var content = editor.html();
        var text = editor.text();
        $("#content_text").val(text);
        $("#content").val(content);
        if (title == "" || title == null) {
            $.messager.alert('提示', '请输入民主管理标题！', 'info');
            return false;
        }
        if (type == "" || type == null){
            $.messager.alert('提示', '请选择信息类别！', 'info');
            return false;
        }
        if (content == "" || content == null) {
            $.messager.alert('提示', '请编辑民主管理内容！', 'info');
            return false;
        }
        if (option == "add") {
            rdcp.form.submit("demoInfoForm", {
                url: "!gh/info/~query/Q_ADD_DEMO_INFO",
                success: function (data) {
                    $.messager.alert('提示', '民主管理信息发布成功！', 'info',function () {
                        cancel();
                    });
                }
            }, {"mask": true});
        }
        else if (option == "edit"){
            $("#info_id").val(info_id);
            rdcp.form.submit("demoInfoForm", {
                url: "!gh/info/~query/Q_UPDATE_DEMO_INFO" ,
                success: function (data) {
                    $.messager.alert('提示', '民主管理信息修改成功！', 'info',function () {
                        cancel();
                    });
                }
            }, {"mask": true});
        }
    }
    function cancel()
    {
        if (option == "add") {
            CloseTab("addDemoInfo", "发布信息");
        }
        else if (option == "edit"){
            CloseTab("editDemoInfo", "修改信息");
        }

    }
</script>
</html>
