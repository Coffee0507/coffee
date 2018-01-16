<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="imagetoolbar" content="no" />
<meta name="description" content="" />
<meta name="keywords" content="" />
<meta charset="utf-8">
<title>Result画面</title>
<style type="text/css">
body {
	margin: 0;
	padding: 0;
	line-height: 1.6;
	letter-spacing: 1px;
	font-family: Verdana, Helvetica, sans-serif;
	font-size: 12px;
	color: #333;
	background: #fff;
}

table {
	text-align: center;
	margin: 0 auto;
}

#top {
	width: 400px;
	margin: 30px auto;
	border: 1px solid #333;
}

#header {
	width: 400px;
	height: 80px;
	background-color: black;
}

#main {
	width: 400px;
	height: 500px;
	text-align: center;
}

#footer {
	width: 400px;
	height: 80px;
	background-color: black;
	clear: both;
}
</style>
</head>
<body>
	<div id="header">
		<div id="pr"></div>
	</div>
	<div id="main">
		<div id="top">
			<p>result</p>
		</div>
		<div>
			<s:property value="session.total" />
		</div>
		<div>
			<s:form action="NumberInputAction">
				<s:submit value="再計算" />
			</s:form>
			<span>ログイン画面に戻る場合は</span><a href='<s:url value="HomeAction"/>'>こちら</a>
		</div>
	</div>
	<div id="footer">
		<div id="pr"></div>
	</div>
</body>
</html>