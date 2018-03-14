<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="jp.co.lsij.p16590004.common.Error" %>
<%@ page import="java.util.ArrayList" %>

<%--金額3桁ごとにカンマを入れるためのクラス --%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<meta name="format-detection" content="telephone=no">
<title>営業担当目標設定</title>

<%
//例外処理をまとめるのに使用
ArrayList<String> errorMessageList = new ArrayList<String>();
%>

<script src="CheckBoxDef.js"></script>
<script src="CheckboxUtil.js"></script>
<script src="ObjUtil.js"></script>
<script src="BrowserBackPrevent.js"></script>
<script src="list.js"></script>
<script src="displayFrameTitle.js"></script>
<script src="sales_user_list.js"></script>

<link href="CSS/Normalize.css" rel="stylesheet" type="text/css">
<link href="CSS/p16590004.css" rel="stylesheet" type="text/css">
<link href="CSS/sales_user_list.css" rel="stylesheet" type="text/css">

<script>
</script>

</head>
<body>
  <br>
  <h3 class=page_title>営業担当目標設定</h3>
<%--
  <h3 class="sales_user_list_title">営業担当目標設定</h3>
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
  <form id="Mainform" name="Salesuser"
    action="./UWOptionController" method="POST">
    <table class="button_area">
      <tr>
        <td class="button_area"><button type="submit" name="action" value="sales_user_new">新規追加</button></td>
        <td class="button_area"><button type="submit" name="action" value="sales_user_change" onClick="return checkbox_changecheck();">変更</button></td>
        <td class="button_area"><button type="submit" name="action" value="sales_user_del" onClick="return checkbox_delcheck();">削除</button></td>
      </tr>
    </table>
    <br>
    <table class="sales_user_list_table">
      <tr>
        <th class="checkbox_area"><input type="checkbox" id="all" name="all" onClick="checkbox_ctrlAllcheckbox();" /></th>
        <th class="name">氏名</th>
        <th class="sales_goal">売上目標値</th>
        <th class="backlog_goal">注残目標値</th>
      </tr>
      <c:forEach items="${salesStaffList}" var="sl">
        <tr>
          <td class="checkbox_area"><input type="checkbox" id="content" name="content" value="${sl.id}" onClick="checkbox_ctrlTopcheckbox();" /></td>
          <td class="name"><c:out value="${sl.salesStaff}" /></td>
<%-- エスケープさせるため
          <td class="name">${sl.salesStaff}</td>
--%>
          <td class="sales_goal"><fmt:formatNumber value="${sl.targetVal}" groupingUsed="true" /></td>
          <td class="backlog_goal"><fmt:formatNumber value="${sl.nextYearTargetVal}" groupingUsed="true" /></td>
        </tr>
      </c:forEach>
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
