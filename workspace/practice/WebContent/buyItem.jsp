<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charser=utf-8" />
<meta http-equiv="Content-Stle-Type" content="text/css" />
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<meta http-equiv="imagetoolbar" content="no" />
<meta name="description" content="" />
<meta name="keywords" content="" />
<meta charset="utf-8" />
<title>商品購入画面</title>
<style type="text/css">
bosy {
	margin: 0;
	padding: 0;
	letter-spacing: 1px;
	line-height: 1.6;
	font-family: Verdana, Helvetica, sens-serif;
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
	background-color: black;
}

#main {
	text-align: center;
	width: 100%;
	height: 500px;
}

#top {
	text-align: center;
	margin: 80 auto;
	padding: 200;
	border: 1px solid black;
}

#footer {
	width: 100%;
	height: 30px;
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
			<p>BuyItem</p>
		</div>
		<div>
			<s:form action="BuyItemAction">
				<table>
					<tr>
						<td><span>商品名</span></td>
						<td><s:property value="session.buyItem_name" /></td>
					</tr>
					<tr>
						<td><span>値段</span></td>
						<td><s:property value="session.buyItem_price" /><span>円</span>
						</td>
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
						<td><input type="radio" name="pay" value="1"
							checked="checked">現金払い <input type="radio" name="pay"
							value="2">クレジットカード</td>
					</tr>
					<tr>
						<td><s:submit value="購入" />
						<td>
					</tr>
				</table>
			</s:form>
			<div>
				前画面に戻るには<a href='<s:url action="HomeAction"/>'>こちら</a>
			</div>
		</div>
	</div>
	<div id="footer">
		<div id="pr"></div>
	</div>
</body>
</html>