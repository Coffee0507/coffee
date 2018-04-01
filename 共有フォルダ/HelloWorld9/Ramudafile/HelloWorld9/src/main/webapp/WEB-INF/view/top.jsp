<!DOCTYPE html>

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<html lang="ja">
<head>
<meta charset="UTF-8">
<title>トップ</title>
</head>
<body>
	ようこそ
	<c:out value="${departmentName}" />の<c:out value="${userName}"></c:out>
	さん
</body>
</html>