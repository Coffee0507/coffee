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
<title>home画面</title>
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
	margin:0 auto;
}

#header {
	width: 100%;
	height: 80px;
	background-color:#333;

}

#main {
	height:500px;
	width: 100%;
	text-align:center;
}

#top {
	height: 30px;
	margin:80px auto;
	width: 200px;
	border: 1px solid #333;
}

#footer {
	width: 100%;
	height: 80px;
	background-color:#333;
	clear: both;
}
</style>
</head>
<body>
	<div id="header">
		<div id="pr"></div>
	</div>
	<div id="main">
		<div id="top"><p>Home</p></div>
		<div>
			<s:form action="HomeAction">
				<s:submit value="商品購入" />
			</s:form>
		</div>
	</div>
	<div id="footer">
		<div id="pr"></div>
	</div>
</body>
</html>