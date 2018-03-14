<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="jp.co.lsij.p16590004.common.Error" %>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<meta name="format-detection" content="telephone=no">
<title>パスワード設定</title>

<%
//例外処理をまとめるのに使用
ArrayList<String> errorMessageList = new ArrayList<String>();
%>

<script src="InputTextCheck.js"></script>
<script src="InputPatternDef.js"></script>
<script src="ObjUtil.js"></script>
<script src="BrowserBackPrevent.js"></script>
<script src="displayFrameTitle.js"></script>
<script src="button_util.js"></script>
<script src="pass.js"></script>

<link href="CSS/Normalize.css" rel="stylesheet" type="text/css">
<link href="CSS/p16590004.css" rel="stylesheet" type="text/css">
<link href="CSS/pass.css" rel="stylesheet" type="text/css">

</head>
<body>
  <br>
  <h3 class="page_title">パスワード設定</h3>
  <%--エラー表示を行う箇所 --%>
  <c:choose>
    <c:when test="${error.isError}">
      <p class="error_message"><c:out value="${error.errorInfo}" /></p>
<%-- エスケープさせるため
      <p class="error_message">${error.errorInfo}</p>
--%>
    </c:when>
    <c:otherwise>
    </c:otherwise>
  </c:choose>
  <form id="Pass" action="./SystemOptionController" method="POST">
    <table class="pass_out_table">
      <tr>
        <td>
          <table class="pass_table">
            <tr>
              <th class="pass_table">現在のパスワード</th>
              <td class="pass_table"><input type="password" name="pass_now" class="pass_textbox"
                <c:choose>
              <c:when test="${error.isError}">value="<c:out value="${passMap.pass_now[0]}" />"</c:when>
<%-- エスケープさせるため
              <c:when test="${error.isError}">value="${passMap.pass_now[0]}"</c:when>
--%>
              <c:otherwise>value=""</c:otherwise>
            </c:choose>>
              </td>
            </tr>
            <tr>
              <th class="pass_table">新しいパスワード</th>
              <td class="pass_table"><input type="password" name="pass_new" class="pass_textbox"
                <c:choose>
              <c:when test="${error.isError}">value="<c:out value="${passMap.pass_new[0]}" />"</c:when>
<%-- エスケープさせるため
              <c:when test="${error.isError}">value="${passMap.pass_new[0]}"</c:when>
--%>
              <c:otherwise>value=""</c:otherwise>
            </c:choose>>
              </td>
            </tr>
            <tr>
              <th class="pass_table">新しいパスワード<br>(確認用)
              </th>
              <td class="pass_table"><input type="password" name="pass_new_con" class="pass_textbox"
                <c:choose>
              <c:when test="${error.isError}">value="<c:out value="${passMap.pass_new_con[0]}" />"</c:when>
<%-- エスケープさせるため
              <c:when test="${error.isError}">value="${passMap.pass_new_con[0]}"</c:when>
--%>
              <c:otherwise>value=""</c:otherwise>
            </c:choose>>
              </td>
            </tr>
          </table>
        </td>
      </tr>
      <tr>
        <td>
          <div class="button_area">
            <br>
            <button type="button" value="pass_change" onClick="return pass_change() && setActionToHidden(this) && submit();">変更</button>
            <input type="hidden" name="pass_id" value="${account.id}">
          </div>
        </td>
      </tr>
    </table>
    <input type="hidden" name="action" value="" id="action_id">
  </form>
  <br>
  <%
  //共通モジュールに渡すエラーリストをリクエストスコープにセット
  request.setAttribute("errorMessageList", errorMessageList);
  %>
  <jsp:include page="include_error_message.jsp" flush="true"/>
</body>
</html>