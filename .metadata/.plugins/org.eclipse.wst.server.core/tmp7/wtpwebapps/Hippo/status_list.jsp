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
<title>ステータス設定</title>

<%
//例外処理をまとめるのに使用
ArrayList<String> errorMessageList = new ArrayList<String>();
%>

<script src="CheckboxUtil.js"></script>
<script src="CheckBoxDef.js"></script>
<script src="ObjUtil.js"></script>
<script src="InputTextCheck.js"></script>
<script src="BrowserBackPrevent.js"></script>
<script src="list.js"></script>
<script src="displayFrameTitle.js"></script>
<script src="status_list.js"></script>

<link href="CSS/Normalize.css" rel="stylesheet" type="text/css">
<link href="CSS/p16590004.css" rel="stylesheet" type="text/css">
<link href="CSS/status_list.css" rel="stylesheet" type="text/css">

</head>
<body>
  <br>
  <h3 class="page_title">ステータス設定</h3>
<%--
  <h3 class="status_list_title">ステータス設定</h3>
--%>
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
  <form id="Mainform" name="status" action="./UWOptionController" method="POST">
    <table class="status_edit_out_table">
      <tr>
        <td>
          <table class="status_edit_table">
            <tr>
              <td class="status_edit_table">ステータス名</td>
              <td class="status_edit_table">
              <input type="text" id="status_name" name="status_name" class="status_list_textbox"
              <c:choose>
                <c:when test="${error.isError}">value="<c:out value="${salesStatusMap.status_name[0]}" />"</c:when>
<%-- エスケープさせるため
                <c:when test="${error.isError}">value="${salesStatusMap.status_name[0]}"</c:when>
--%>
                <c:otherwise>value=""</c:otherwise>
              </c:choose>
              ><%--閉じタグのため消さない --%></td>
              <td class="status_edit_table">
                <button type="submit" name="action" value="status_add" onClick="return status_Add();">追加</button>
              </td>
            </tr>
          </table>
        </td>
      </tr>
      <tr>
        <td><br>
          <div class="status_edit_move_button">
            <button type="submit" name="action" value="status_del" onClick="return checkbox_delcheck();">削除</button>
            <br>
          </div></td>
      </tr>
      <tr>
        <td>
          <table class="status_list_table">
            <tr>
              <th class="checkbox_area"><input type="checkbox" id="all" name="all" onClick="checkbox_ctrlAllcheckbox();"></th>
              <th>ステータス</th>
            </tr>
            <c:forEach items="${salesStatusList}" var="st">
              <tr>
                <td class="checkbox_area">
                  <input type="checkbox" id="content" name="content" value="${st.id}" onClick="checkbox_ctrlTopcheckbox();">
                </td>
                <td class="status_list_table_not_money"><c:out value="${st.statusName}" /></td>
<%-- エスケープさせるため
                <td class="status_list_table_not_money">${st.statusName}</td>
--%>
              </tr>
            </c:forEach>
          </table>
        </td>
      </tr>
    </table>
  </form>
  <br>
  <%
  //共通モジュールに渡すエラーリストをリクエストスコープにセット
  request.setAttribute("errorMessageList", errorMessageList);
  %>
  <jsp:include page="include_error_message.jsp" flush="true"/>
</body>
</html>