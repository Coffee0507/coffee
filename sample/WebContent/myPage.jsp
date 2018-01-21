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
<title>MyPage画面</title>
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
		<div id="top">MyPage</div>
		<s:if test="session.message == ''">
			<table>
				<tr>
					<td>商品名</td>
					<td>session.myItemName</td>
				</tr>
				<tr>
					<td>値段</td>
					<td>session.myItemPrice</td>
				</tr>
				<tr>
					<td>購入個数</td>
					<td>session.myItemStock</td>
				</tr>
				<tr>
					<td>支払い方法</td>
					<td>session.myItemPay</td>
				</tr>
			</table>
			<s:form action="MyPageAction">
				<input type="hidden" name="deleteFlg" value="1">
				<s:submit value="削除" />
			</s:form>
		</s:if>
		<s:if test="session.message != null">
			<h3>
				<s:property value="session.message" />
			</h3>
		</s:if>
		<div>
			<br> <span>前画面に戻る場合は<a
				href='<u:url action="HomeAction"/>'>ログアウト</a>をお願いします
			</span>
		</div>
	</div>
	<div id="footer">
		<div id="pr"></div>
	</div>
</body>
</html>