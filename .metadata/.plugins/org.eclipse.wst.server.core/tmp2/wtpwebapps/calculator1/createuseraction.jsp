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
<title>createuseraction画面</title>
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
			<p>createuseraction</p>
		</div>
		<div>
			<s:form action="CreateUserConfirmAction">
				<table>
					<tr>
						<td>苗字:</td>
						<td><s:textfield name="name1" value="takahashi" /></td>
					</tr>
					<tr>
						<td>名前:</td>
						<td><s:textfield name="name2" value="yuuri"/></td>
					</tr>
					<tr>
						<td>生年月日:</td>
						<td><select name="birthyear">
								<option value="1991" selected="selected">1991</option>
						</select></td>
					</tr>
					<tr>
						<td></td>
						<td><select name="birthmonth">
								<option value="5" selected="selected">5</option>
						</select></td>
					</tr>
					<tr>
						<td></td>
						<td><select name="birthday">
								<option value="7" selected="selected">7</option>
						</select></td>
					</tr>
				</table>
				<tr>
					<td>性別</td>
					<td></td>
				</tr>
				<input type="radio" name="sex" value="1" checked="checked">男性
						<input type="radio" name="sex" value="2">女性
			<s:submit value="確認" />
			</s:form>
		</div>
	</div>
	<div id="footer">
		<div id="pr"></div>
	</div>
</body>
</html>