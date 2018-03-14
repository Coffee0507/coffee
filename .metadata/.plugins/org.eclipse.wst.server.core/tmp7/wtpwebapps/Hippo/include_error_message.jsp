<%@ page session="false" %>
<%@ page contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<c:forEach var="errorMessage" items="${errorMessageList}">
	<p class="error_message"><c:out value="${errorMessage}"/></p>
</c:forEach>