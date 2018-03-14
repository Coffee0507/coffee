<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="jp.co.lsij.p16590004.e_77.model.master.beans.PageBean"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="jp.co.lsij.p16590004.common.Error"%>
<%@ page import="java.util.ArrayList" %>

<%-- ソートのクラスをインポート 
<%@ page import="jp.co.lsij.p16590004." %>
--%>

<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<meta name="format-detection" content="telephone=no">
<title>ユーザーグループ設定</title>

<script src="CheckboxUtil.js"></script>
<script src="CheckBoxDef.js"></script>
<script src="ObjUtil.js"></script>
<script src="list.js"></script>
<script src="displayFrameTitle.js"></script>

<script src="user_group_list.js"></script>

<script src="Page.js"></script>
<script src="BrowserBackPrevent.js"></script>

<link href="CSS/Normalize.css" rel="stylesheet" type="text/css">
<link href="CSS/p16590004.css" rel="stylesheet" type="text/css">
<link href="CSS/user_group_list.css" rel="stylesheet" type="text/css">

<%
  //例外処理をまとめるのに使用
  ArrayList<String> errorMessageList = new ArrayList<String>();
%>

</head>
<body>
  <br>
  <h3 class="page_title">ユーザーグループ設定</h3>
<%--
  <h3 class="user_list_title">ユーザーグループ設定</h3>
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

  <form id="Mainform" name="Mainform" action="./SystemOptionController" method="POST">
    <table>
      <tr>
        <td>
          <table>
            <tr>
              <c:if test="${canEdit}">
                <td  class="print_space">
                  <button type="submit" name="action" value="user_group_new">新規追加</button>
                </td>
                <td>
                  <button type="submit" name="action" value="user_group_change" onClick="return checkbox_changecheck();">変更</button>
                </td>
                <td>
                  <button type="submit" name="action" value="user_group_del" onClick="return checkbox_delcheck();">削除</button>
                </td>
              </c:if>
            </tr>
          </table>
        </td>
      </tr>
      <tr>
        <td>
          <table class="user_group_list_table">
            <tr>
              <c:if test="${canEdit}">
              <th class="checkbox_area"><input type="checkbox" id="all" name="all" onClick="checkbox_ctrlAllcheckbox();" /></th>
              </c:if>
              <th class="group_name">グループ名</th>
            </tr>

            <c:forEach items="${userGroupList}" var="group">
              <tr>
                <c:if test="${canEdit}">
                  <td class="checkbox_area"><input type="checkbox" id="content" name="content" value="${group.id}" onClick="checkbox_ctrlTopcheckbox();" /></td>
                </c:if>
                <td class="group_name"><c:out value="${group.userGroupName}" /></td>
              </tr>
            </c:forEach>
          </table>
        </td>
      </tr>
    </table>
    <input type="hidden" name="action" value="" class="hidden_action_param">
  </form>
  <br>
  <%
  //共通モジュールに渡すエラーリストをリクエストスコープにセット
  request.setAttribute("errorMessageList", errorMessageList);
  %>
  <jsp:include page="include_error_message.jsp" flush="true"/>
</body>
</html>