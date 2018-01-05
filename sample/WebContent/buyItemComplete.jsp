<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Content-Style-Type" content="text/css">
<meta http-equiv="Content-Script-Type" content="text/javascript">
<meta http-equiv="imagetoolbar" content="no">
<meta http-equiv="keywords" content="">
<meta http-equiv="description" content="">
<title>buyItem画面</title>
<style type="text/css">
body {
	margin: 0;
	padding: 0;
	letter-spacing: 1px;
	line-height: 1.6;
	font-familly: Verdana, Helvetica<sans-serif;
	font-size: 12px;
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
	text-align: center;
	width: 100%;
	height: 500px;
}

#top {
	margin: 80px auto;
	width: 200px;
	border: 1px solid black;
}

#footer {
	width: 100%;
	height: 30px;
	background-color: #333;
	clear: both;
}
</style>
</head>
<body>
	<div id="header">
		<div id="pr"></div>
	</div>
	<div id="main">
		<div id="top">BuyItemCompleteAction</div>
		<div>
			<a href='<s:url action="BuyItemCompleteAction"/>'>マイページ</a><span>から購入履歴の確認ができます</span>
		</div>
	</div>
	<div id="footer">
		<div id="pr"></div>
	</div>
</body>
</html>