<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" language="java" import="java.util.*" isELIgnored="false" %>
<%@ taglib prefix="r" uri="http://www.sunrisetech.com/rdcp/" %>
<%@ page import="com.sunrise.framework.core.LoginUserSession" %>
<%@ page import="com.sunrise.service.security.entity.SysPUser" %>

<%
	String path = request.getContextPath();
	String port = (request.getServerPort() == 80 || request.getServerPort() == 443) ? "" : ":" + String.valueOf(request.getServerPort());
	String basePath = request.getScheme() + "://" + request.getServerName() + port + path + "/";
	request.setAttribute("_basePath", basePath);
%>
<base href="${_basePath}"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
	<meta charset="UTF-8">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport" />
	<meta content="telephone=no" name="format-detection" />
	<title>会籍状态</title>
	<link href="!gh/wechat/~/css/main.css" rel="stylesheet" type="text/css">
	<link href="!gh/wechat/~/css/style.css" rel="stylesheet" type="text/css">
	<link href="!gh/wechat/~/css/shake.css" rel="stylesheet" type="text/css">
	<link href="!gh/wechat/~/css/font-awesome.min.css" rel="stylesheet" type="text/css">
	<link href="!gh/wechat/~/css/animate.min.css" rel="stylesheet" type="text/css">
	<link href="!gh/wechat/~/css/idangerous.swiper.css" rel="stylesheet" type="text/css">
	<script type="text/javascript" src="!rdcp/script/src/rdcp.js"></script>
	<script type="text/javascript" src="!rdcp/script/lib/jquery/jquery-1.8.0.min.js"></script>
	<script type="text/javascript" src="!gh/wechat/~/js/wo.js"></script>


<%--
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.sunrise.framework.core.ApplicationManager" %>
<%@page import="com.sunrise.service.security.entity.SysPUser" %>
<%@ page import="com.sunrise.framework.core.LoginUserSession" %>
<%@taglib prefix="r" uri="http://www.sunrisetech.com/rdcp/" %>

<%
	String path = request.getContextPath();
	String port = (request.getServerPort() == 80 || request.getServerPort() == 443) ? "" : ":" + String.valueOf(request.getServerPort());
	String basePath = request.getScheme() + "://" + request.getServerName() + port + path + "/";
	request.setAttribute("_basePath", basePath);
%>
<base href="${_basePath}"/>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>

	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1"/>
	&lt;%&ndash; <r:include resource="!rdcp/~/pages/listBasePhone.jsp"/>&ndash;%&gt;
	<r:include resource="!rdcp/~/pages/listBase.jsp"/>
	&lt;%&ndash; <link href="!gh/wechat/~/css/moblieIndex.css" rel="stylesheet" type="text/css"/>
     <script type="text/javascript" src="themes/brisk_Orange/js/iepngfix_tilebg.js"></script>&ndash;%&gt;
	&lt;%&ndash;<script type="text/javascript" src="!gh/wechat/~/scripts/login.js"></script>&ndash;%&gt;

		<meta charset="UTF-8">
		<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
		<meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0" name="viewport" />
		<meta content="telephone=no" name="format-detection" />
		<title>会籍状态</title>
		<link href="!gh/wechat/~/css/main.css" rel="stylesheet" type="text/css">
		<link href="!gh/wechat/~/css/style.css" rel="stylesheet" type="text/css">
		<link href="!gh/wechat/~/css/shake.css" rel="stylesheet" type="text/css">
		<link href="!gh/wechat/~/css/font-awesome.min.css" rel="stylesheet" type="text/css">
		<link href="!gh/wechat/~/css/animate.min.css" rel="stylesheet" type="text/css">
		<link href="!gh/wechat/~/css/idangerous.swiper.css" rel="stylesheet" type="text/css">
		<script type="text/javascript" src="!gh/wechat/~/js/jquery-1.8.3.min.js"></script>
		<script type="text/javascript" src="!gh/wechat/~/js/wo.js"></script>
--%>

	<style type="text/css">
		.return1{
			font-size: 1.6rem;
			color: #fff;
			position: absolute;
			left: 1rem;
			top: 0rem;
		}
	</style>
	<%
		String account ="";
		boolean isLogin  = false;
		SysPUser user = (SysPUser) session.getAttribute(LoginUserSession.UserSession_Key);
		if(user != null)
		{
			account = request.getParameter("account")==null?user.getAccount():request.getParameter("account");
			isLogin = true;
		}

	%>
	</head>
<body style="background-color: #fff !important;">
<div class="warpe">
	<div class="head">
		<a href="!gh/wechat/~/pages/hj_info.jsp" class="return1"><i class="icon-chevron-left"></i>返回</a>
		会籍状态

	</div>

	<div class="swiper-container">
		<div class="swiper-wrapper">
			<div class="swiper-slide">
				<div class="content-slide">
					<div class="g-hjzt">
						<p><img src="!gh/wechat/~/img/g-hjzt-icon1.png" width="80px" alt=""></p>
						<p class="g-txt">您是否确认退会？</p>
						<p class="g-btn clearfloatafter">
							<a href="javascript:void(0);"  onclick="quit_submit()">确认</a>
							<a  href="!gh/wechat/~/pages/hj_info.jsp">取消</a>
						</p>
					</div>
					<div class="main g-hdxq-main">
						<div class="postall">
							<div class="post_t post_t2 w_txt">
							<%--	<span class=" icon-file-text"></span>
								退会说明--%>
							</div>
							<div class="post_m">
								<%--<p class="color_g animated fadeInRight">提示：因超过六个月未缴纳会费导致退会，补交后即可恢复会籍，请及时补交</p>--%>
							</div>
						</div>
					</div>
				</div>
			</div>

		</div>
	</div>
</div>
<script type="text/javascript" src="!gh/wechat/~/js/idangerous.swiper.min.js"></script>
<script type="text/javascript">
    rdcp.ready(function(){});

	function quit_submit() {
	    var account ="<%=account%>";

        rdcp.request("!gh/wechat/~query/Q_TRADE_STATUS_QUIT",{"account":account},function(data){
            if(data==1){
                $.messager.alert("提示","操作成功!","info");
                window.location = "!gh/wechat/~/pages/hj_info_quited.jsp";
            }
        });
    }

</script>
</body>
</html>