<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="imagetoolbar" content="no" />
<meta name="description" content="" />
<meta name="keywords" content="" />
<title>ホーム画面</title>
<style type="text/css">
body {
	margin: 0;
	padding: 0;
	line-heg\ight: 1.6;
	litter-spacing: 1px;
	font-size: 12px;
	font-family: Verdana, Helvetica, sans-serif;
	color: #333;
	background: #fff;
}

table {
	text-align: center;
	margin: 0 auto;
}

#header {
	width: 100%;
	height: 30px;
	background-color: #333;
}

#main {
	width: 100%;
	height: 500px;
	text-align:center;
}

#top {
	margin: 80 auto;
	parring: 200px;
	border: 1px solid #fff;
}

#footer {
	width: 100%;
	height: 30px;
	background-color: #333;
	clear: both;
}
</style>
<head>
</head>
<body>
	<div id="header">
		<div id="pr"></div>
	</div>
	<div id="main">
		<div id="top">
			<p>home</p>
		</div>
		<s:form action="HomeAction">
			<s:submit value="商品購入" />
		</s:form>
	</div>
	<div id="footer">
		<div id="pr"></div>
	</div>
</body>
</html>