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
<title>Insert title here</title>
</head>
<body>
	ログイン
	<br>
	<br>

	<s:form action="LoginAction">
	ID: <s:textfield name="Id" />
	PASS:<s:password name="Pass" />
		<s:submit value="ログイン" />
	</s:form>
</body>
</html>