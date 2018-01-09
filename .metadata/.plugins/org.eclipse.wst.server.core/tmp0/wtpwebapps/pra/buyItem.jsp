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
<meta name="keywords" content="">
<meta name="description" content="">
<title>BuyItem画面</title>
<style type="text/css">
body {
	margin: 0;
	padding: 0;
	line-height: 1.6;
	letter-spacing: 1px;
	font-familly: Verdana, Helvetica, sans-serif;
	font-size: 12px;
	color: #333;
	background: #fff;
}

table {
	margin: 0 auto;
	text-align: center;
	margin: 0 auto;
}

#header {
	width: 100%;
	height: 80px;
	background-color: #333;
}

#main {
	height: 500px;
	width: 100%;
	text-align: center;
}

#top {
	height: 30px;
	margin: 80px auto;
	width: 200px;
	border: 1px solid #333;
}

#footer {
	width: 100%;
	height: 80px;
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
			<p>BuyItem</p>
		</div>
		<div>
			<table>
				<s:form action="BuyItemAction">
					<tr>
						<td><span>商品名</span></td>
						<td><s:property value="session.itemName" /></td>
					</tr>
					<tr>
						<td><span>値段</span></td>
						<td><s:property value="session.itemPrice" /><span>円</span></td>
					</tr>
					<tr>
						<td><span>在庫</span></td>
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
							<input type="radio" name="pay" value="2">クレジット</td>
					</tr>
					<tr>
						<td><s:submit value="購入確認" /></td>
					</tr>
				</s:form>
			</table>
			<span>前画面に戻る場合は<a href='<s:url action="HomeAction"/>'>こちら</a></span>
		</div>
	</div>
	<div id="footer">
		<div id="pr"></div>
	</div>
</body>
</html>