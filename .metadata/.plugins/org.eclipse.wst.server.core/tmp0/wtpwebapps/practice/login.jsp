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
<title>ログイン画面</title>
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
</head>
<body>
	<div id="header">
		<div id="pr"></div>
	</div>
	<div id="main">
		<div id="top">
			<p>ログイン</p>
		</div>
		<div>
			<h3>商品を購入するにはログインしてください</h3>
			<s:form action="LoginAction">
				<s:textfield name="user_name" />
				<s:password name="login_password" />
				<s:submit value="ログイン" />
			</s:form>
			<br />
			<div>
				<span>新規ユーザー登録は<a href='<s:url action="UserCreateAction"/>'>こちら</a></span>
			</div>
		</div>
	</div>
	<div id="footer">
		<div id="pr"></div>
	</div>
</body>
</html>