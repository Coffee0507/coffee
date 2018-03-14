<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<meta name="format-detection" content="telephone=no">
<title>ログイン</title>

<%
//例外処理をまとめるのに使用
ArrayList<String> errorMessageList = new ArrayList<String>();
%>

<script src="BrowserBackPrevent.js"></script>
<script src="displayFrameTitle.js"></script>
<script src="InputTextCheck.js"></script>
<script src="login.js"></script>
<!-- 追加：インターノウス jQuery追加  -->
<!-- ここから -->
<script src="JS_LIB/jQuery/jquery-3.2.1.min.js" type="text/javascript"></script>
<script src="ConnectedSelect.js"></script>
<script type="text/javascript">
$(function() {
	ConnectedSelect(['usergroup_id','user_id']);
	ConnectedSelectDefault(['usergroup_id','user_id']);
});
</script>
<!-- ここまで -->



<!-- <link href="CSS/Normalize.css" rel="stylesheet" type="text/css"> login_decoration.cssを入れたため、例外的にコメントアウト -->
<link href="CSS/p16590004.css" rel="stylesheet" type="text/css">
<link href="CSS/login_decoration.css" rel="stylesheet" type="text/css">
<link href="CSS/login.css" rel="stylesheet" type="text/css">

</head>
<body>
  <div class="title_logo">
    <span class="letter" data-letter="hippo">hippo</span>
    <img id="hippo_img" src="./IMAGE/hippo_black.png"/>
  </div>

  <noscript>
    <br>
    <p class="error_message login_error_message">JavaScriptを有効にしてください</p>
  </noscript>

  <div class="form_area">
  <form id="Mainform" action="./LoginController" method="POST" Target="_top">
    <%--エラー表示を行う箇所 --%>
    <%--テーブルで真ん中表示させてるのでここに記述 --%>
	<c:if test="${error.isError}">
      <p class="error_message login_error_message"><c:out value="${error.errorInfo}"/></p>
    </c:if>
    <table class="user_content">
    <!-- 追加：インターノウス -->
    <!-- ここから -->
      <tr>
      	<th>所属：</th>
      	<td>
      	<%--
      		<select id="usergroup_id" name="usergroup_id" class="input_box">
      			<option value="" selected>全て</option>
      			<c:forEach items="${userGroupList}" var="group">
                  <option value="<c:out value="${group.id}"/>"
                  <c:if test="${error.isError and group.id eq accountMap.usergroup_id[0]}"> selected="selected"</c:if>
                  ><c:out value="${group.userGroupName}"/></option>
                </c:forEach>
      		</select>
      	--%>
	      	<select id="usergroup_id" name="usergroup_id" class="input_box">
				<option value="0">全て</option>
				<c:forEach items="${userGroupList}" var="group" varStatus="status">
				<c:out value="${status.index}" />
					<option value="<c:out value="${group.id}"/>"><c:out value="${group.userGroupName}"/></option>
				</c:forEach>
			</select>
      	</td>
      </tr>
      <tr>
        <th>ユーザー：</th>
        <td>
        <%--
          <select id="user_id" name="user_id" class="input_box">
            <option value=""></option>
            <c:forEach items="${userList}" var="account">
              <option value="<c:out value="${account.id}"/>"
              <c:if test="${error.isError and account.id eq accountMap.user_id[0] and account.employeeNum eq userGroupList.userGroupMemberBeanList[0].employeeNum }"> selected="selected"</c:if>
              ><c:out value="${account.secondName} ${account.firstName}"/></option>
            </c:forEach>
          </select>
         --%>
	         <select id="user_id" name="user_id" class="input_box">
	         	<option value=""></option>
				<optgroup label="0">
				 <c:forEach items="${userList}" var="account">
				 	<option value='<c:out value="${account.id}"></c:out>'><c:out value="${account.secondName}"></c:out> <c:out value="${account.firstName}"></c:out></option>
				 </c:forEach>
				</optgroup>
				<c:forEach items="${userGroupList}" var="group" varStatus="status">
					<optgroup label="<c:out value="${group.id}"/>">
					<c:forEach items="${group.getUserGroupMemberList()}" var="userGroupMember">
						<c:forEach items="${userList}" var="account">
							<c:if test="${userGroupMember.employeeNum == account.employeeNum and userGroupMember.userGroupTblId == group.id}">
				                <option value='<c:out value="${account.id}"></c:out>'><c:out value="${account.secondName}"></c:out> <c:out value="${account.firstName}"></c:out></option>
							</c:if>
						</c:forEach>
					</c:forEach>
					</optgroup>
				</c:forEach>
				<!-- ここまで -->
			</select>
        </td>
      </tr>
      <tr>
        <th>パスワード：</th>
        <c:choose>
          <c:when test="${error.isError}">
            <td><input type="password" class="input_box" name="login_pass" value="<c:out value="${accountMap.login_pass[0]}"/>"></td>
          </c:when>
          <c:otherwise>
            <td><input type="password" class="input_box" name="login_pass"></td>
          </c:otherwise>
        </c:choose>
      </tr>
      <tr class="login_button_area">
        <td colspan="2"><br>
          <button type="submit" name="action" value="login" onClick="return loginProc()">ログイン</button>
        </td>
      </tr>
    </table>
  </form>
  </div>
  <br>
<%
  //共通モジュールに渡すエラーリストをリクエストスコープにセット
  request.setAttribute("errorMessageList", errorMessageList);
%>
  <jsp:include page="include_error_message.jsp" flush="true"/>
</body>
</html>
