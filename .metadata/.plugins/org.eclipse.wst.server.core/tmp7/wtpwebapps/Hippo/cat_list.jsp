<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="jp.co.lsij.p16590004.common.Error" %>
<%@ page import="java.util.ArrayList" %>
<%--金額3桁ごとにカンマを入れるためのクラス --%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<meta name="format-detection" content="telephone=no">
<title>分類設定</title>

<%
//例外処理をまとめるのに使用
ArrayList<String> errorMessageList = new ArrayList<String>();
%>

<script src="CheckboxUtil.js"></script>
<script src="CheckBoxDef.js"></script>
<script src="ObjUtil.js"></script>
<script src="BrowserBackPrevent.js"></script>
<script src="list.js"></script>
<script src="displayFrameTitle.js"></script>
<script src="cat_list.js"></script>

<link href="CSS/Normalize.css" rel="stylesheet" type="text/css">
<link href="CSS/p16590004.css" rel="stylesheet" type="text/css">
<link href="CSS/cat_list.css" rel="stylesheet" type="text/css">

</head>
<body>
  <br>
  <h3 class="page_title">分類設定</h3>
<%--
  <h3 class="cat_list_title">分類設定</h3>
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

  <%--プロジェクト名の変更が必要なところ --%>
  <form id="Mainform" name="Bunrui" action="./UWOptionController" method="POST">
    <table>
      <tr>
        <td>
          <table>
            <tr>
              <td><button type="submit" name="action" value="bunrui_new">新規追加</button></td>
              <td><button type="submit" name="action" value="bunrui_change"
                  onClick="return checkbox_changecheck();">変更</button></td>
              <td><button type="submit" name="action" value="bunrui_del"
                  onClick="return checkbox_delcheck();">削除</button></td>
            </tr>
          </table>
        </td>
      </tr>
      <tr>
        <td><br>
          <table class="cat_list_table">
            <tr>
              <th class="checkbox_area"><input type="checkbox" name="all" id="all" onClick="checkbox_ctrlAllcheckbox();" /></th>
              <th class="cat_name">分類</th>
              <th class="cat_list_table_money">目標値</th>
            </tr>
            <c:forEach items="${categoryList}" var="cat">
              <tr>
                <td class="checkbox_area"><input type="checkbox" id="content" name="content" value="${cat.id}" onClick="checkbox_ctrlTopcheckbox();" /></td>
                <td class="cat_name"><c:out value="${cat.name}" /></td>
<%-- エスケープさせるため
                <td class="cat_name">${cat.name}</td>
--%>
                <td class="cat_list_table_money"><fmt:formatNumber value="${cat.targetVal}" groupingUsed="true" /></td>
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
