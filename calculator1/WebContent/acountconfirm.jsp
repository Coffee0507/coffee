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
<title>Login画面</title>
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
	height: 300px;
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
			<p>calculator</p>
		</div>
		<div>
		<s:property value="session.message"/>
			<h3>入力された内容をご確認ください</h3>
			<table>
				<tr>
					<td>名前:</td>
					<td><s:property value="session.name1" /></td>
					<td><s:property value="session.name2" /></td>
				</tr>
				<tr>
					<td>年齢:</td>
					<td><s:property value="session.age" /></td>
				</tr>
				<tr>
					<td>性別:</td>
					<td><s:property value="session.sex" /></td>
				</tr>
				<s:property value="message"/>
			</table>
			<s:submit value="確認" />
		</div>
	</div>
	<div id="footer">
		<div id="pr"></div>
	</div>
</body>
</html>