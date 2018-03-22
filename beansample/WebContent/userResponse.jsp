<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<jsp:useBean id="user" scope="request" class="beansample.UserBean" />

<!DOCTYPE html>
<html>
    <head>
        <title>Sample Bean</title>
    </head>
    <body>
        <h1>リクエスト結果</h1>
        <%--一般権限の場合はIDと年齢を非表示にする--%>
        <% if (user.getAuth() == 1) {%>
        <p>ID:<%=user.getId()%></p>
        <% }%>

        <p>名前:<%=user.getName()%></p>

        <% if (user.getAuth() == 1) {%>
        <p>年齢:<%=user.getAge()%></p>
        <% }%>

        <br>
        <% if (user.getAuth() == 1) { %>
        <p>ID:<jsp:getProperty property="id" name="user"/></p>
        <% } %>

        <p>名前:<jsp:getProperty property="name" name="user"/></p>

        <% if (user.getAuth() == 1) { %>
        <p>年齢:<jsp:getProperty property="age" name="user"/></p>
        <% }%>

        <form>
            <input type="button" onclick="location.href = './userRequest.jsp'" value="戻る">
        </form>
    </body>
</html>