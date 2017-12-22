<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta http-equiv="Content-Style-Type" content="text/css" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="imagetoolbar" content="no" />
<meta name="description" content="" />
<meta name="keywords" content="">
<meta charset="UTF-8">
<title>購入画面</title>
<style type="text/css">
body {
	margin: 0;
	padding: 0;
	line-height: 1.6;
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
	text-align: center;
}

#top {
	margin: 80 auto;
	padding: 200px;
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
		<div id="pr"></div>
		<p>BuyItem</p>
		<s:form action="BuyItemAction">
			<table>
				<tr>
					<td><span>商品名</span></td>
					<td><s:property value="session.buyItemName" /></td>
				</tr>
				<tr>
					<td>値段</td>
					<td><s:property value="session.buyItemPrice" /><span>円</span></td>
				</tr>
				<tr>
					<td>在庫</td>
					<td><select name="stock">
							<option value="1" selected="selected">1</option>
							<option value="2">2</option>
							<option value="3">3</option>
							<option value="4">4</option>
							<option value="5">5</option>
					</select></td>
				</tr>
				<tr>
					<td><span>支払い方法</span></td>
					<td><input type="radio" name="pay" value="1" checked="checked">現金払い
						<input type="radio" name="pay" value="2">クレジットカード</td>
				</tr>
				<tr>
					<td><s:submit value="購入" /></td>
				</tr>
				<tr>
					<td><span>前画面に戻る場合は<a
							href='<s:url action="HomeAction"/>'>こちら</a></span></td>
				<tr>
			</table>
		</s:form>
	</div>
	<div id="footer">
		<div id="pr"></div>
	</div>
</body>
</html>