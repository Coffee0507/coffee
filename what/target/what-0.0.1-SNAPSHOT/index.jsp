<!DOCTYPE html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form" %>

<html>
<head>
<meta charset="utf-8">
<title>Welcome</title>
</head>
<body>
	<f:form modelAttribute="firstForm" action="second" method="post">
		名前：<input type="text" id="loginName" name="loginName" /><br>
		<br>
		パス：<input type="text" id="loginPassword" name="loginPassword"/><br>
		<br>
		<input type="submit" value="login" />
	</f:form>
</body>
</html>
