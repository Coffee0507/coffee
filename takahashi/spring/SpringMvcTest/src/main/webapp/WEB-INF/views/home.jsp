<!DOCTYPE html>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="f" uri="http://www.springframework.org/tags/form"%>
<html>
<head>
<title>Home</title>
</head>
<body>
	<h1>Hello world!</h1>

	<p>${serverTime }.</p>

<f:form modelAttribute="loginForm" action="login2" method="post">
	<input type="text" name="name" id="name"/>
	<br>
	<input type="text" name="pass" id="pass"/>
	<br>
	<input type="submit" value="login"/>
</f:form>
</body>
</html>
