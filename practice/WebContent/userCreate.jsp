<%@ page language="java" contentType="text/html; charset=UTF-8"
	"pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="imagetoolbar" content="no" />
<meta http-equiv="description" content="" />
<meta http-equiv="keywords" content="" />
<meta charset="UTF-8" />
<title>UserCreate</title>
<style type="text/css">
body {
	margin: 0;
	padding: 0;
	letter-spacing: 1px;
	line-height: 1, 6;
	font-family: Verdana, Helvetica, sans-serif;
	font-size: 12px;
	color: #333;
	background: #fff;
}

table {
	text-align: center;
	marign: 0 auto;
}

#header {
	width: 100%;
	height: 80px;
	background-color: #333;
}

#main {
	widht: 100%;
	height: 500px;
	text-align: center;
}

#top {
	width: 780px;
	margin: 30px auto;
	border: 1px solid #333;
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
			<p>UserCreate</p>
		</div>
		<div>
			<s:if test="errormessage != ''">
				<s:property value="errorMessage" escape="false" />
			</s:if>
			<s:form action="UserCreateConfirmAction">
				<tr>
					<td><label>ログインID</label></td>
					<td><input type="text" name="loginUserId" value="" /></td>
				</tr>
				<tr>
					<td><label>ログインパスワード</label></td>
					<td><input type="text" name="loginPassword" value="" /></td>
				</tr>
				<tr>
					<td>ユーザー名</td>
					<td><input type="text" name="userName" value="" /></td>
					<td></td>
				</tr>
				<s:submit value="登録"/>
			</s:form>
		</div>
		<div>
		<span>前画面に戻る場合は<a href='<s:url action="HomeAction"/>'>こちら</a></span>
		</div>
	</div>
	<div id="footer">
		<div id="pr"></div>
	</div>
</body>
</html>