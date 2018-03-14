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
<title>ユーザー一覧</title>

<script src="CheckboxUtil.js"></script>
<script src="CheckBoxDef.js"></script>
<script src="ObjUtil.js"></script>
<script src="list.js"></script>
<script src="displayFrameTitle.js"></script>

<script src="user_list.js"></script>

<script src="Page.js"></script>
<script src="BrowserBackPrevent.js"></script>

<link href="CSS/Normalize.css" rel="stylesheet" type="text/css">
<link href="CSS/p16590004.css" rel="stylesheet" type="text/css">
<link href="CSS/user_list.css" rel="stylesheet" type="text/css">

<%
  //例外処理をまとめるのに使用
  ArrayList<String> errorMessageList = new ArrayList<String>();
%>

</head>
<body>
  <br>
  <h3 class="page_title">ユーザー一覧</h3>
<%--
  <h3 class="user_list_title">ユーザー一覧</h3>
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
              <td>
                <select name="sort_sec">
                  <option value="sort_emp_num" <c:if test="${userListSort.columnName eq 'sort_emp_num'}"> selected="selected"</c:if>>社員番号</option>
                  <option value="sort_name" <c:if test="${userListSort.columnName eq 'sort_name'}"> selected="selected"</c:if>>氏名</option>
                  <option value="sort_aut" <c:if test="${userListSort.columnName eq 'sort_aut'}"> selected="selected"</c:if>>権限</option>
                </select>
              </td>
              <td>
                <select name="sort_order">
                  <option value="asc"
                    <c:if test="${userListSort.asc}"> selected="selected"</c:if>>昇順</option>
                  <option value="desc"
                    <c:if test="${!userListSort.asc}"> selected="selected"</c:if>>降順</option>
                </select>
              </td>
              <td>
                <button type="submit" name="action" value="user_sort">ソート</button>
              </td>
              <c:if test="${canEdit}">
                <td  class="print_space">
                  <button type="submit" name="action" value="user_new">新規追加</button>
                </td>
                <td>
                  <button type="submit" name="action" value="user_change" onClick="return checkbox_changecheck();">変更</button>
                </td>
                <td>
                  <button type="submit" name="action" value="user_del" onClick="return checkbox_delcheck();">削除</button>
                </td>
              </c:if>
            </tr>
          </table>
        </td>
      </tr>
      <tr>
        <td>
          <table class="user_list_table">
            <tr>
              <c:if test="${canEdit}">
              <th class="checkbox_area"><input type="checkbox" id="all" name="all" onClick="checkbox_ctrlAllcheckbox();" /></th>
              </c:if>
              <th class="emp_num">社員番号</th>
              <th class="name">氏名</th>
              <th class="authority">権限</th>
              <th class="mail">メールアドレス</th>
              <th class="notice">通知</th>
            </tr>

            <c:forEach items="${userList}" var="account">
              <tr>
                <c:if test="${canEdit}">
                  <td class="checkbox_area"><input type="checkbox" id="content" name="content" value="${account.id}" onClick="checkbox_ctrlTopcheckbox();" /></td>
                </c:if>
                <td class="emp_num"><c:out value="${account.employeeNum}" /></td>
                <td class="name"><c:out value="${account.secondName}" /> <c:out value="${account.firstName}" /></td>
                <td class="authority"><c:out value="${account.userCategory}" /></td>
                <td class="mail"><c:out value="${account.mailAddress}" /></td>
<%-- エスケープさせるため
                <td class="name">${account.secondName} ${account.firstName}</td>
                <td class="authority">${account.userCategory}</td>
                <td class="mail">${account.mailAddress}</td>
--%>

                <%--判定の条件を変更する必要あり　（デフォルト通知ユーザー） --%>
                <c:if test="${account.defNotification}" var="mark" />
                <c:if test="${mark}">
                  <td class="notice">●</td>
                </c:if>
                <c:if test="${!mark}">
                  <td class="notice"></td>
                </c:if>

              </tr>
            </c:forEach>
          </table>
        </td>
      </tr>
      <tr>
        <td>
          <div class="page_portion">
            <jsp:include page="include_page_info.jsp" flush="true">
              <jsp:param name="forward_action" value="user_list_next" />
              <jsp:param name="back_action" value="user_list_back" />
			</jsp:include>
          </div>
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