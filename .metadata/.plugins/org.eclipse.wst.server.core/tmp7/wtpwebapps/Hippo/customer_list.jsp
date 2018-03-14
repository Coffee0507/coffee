<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="jp.co.lsij.p16590004.common.Error"%>
<%@ page import="jp.co.lsij.p16590004.e_77.model.master.beans.PageBean"%>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<meta name="format-detection" content="telephone=no">
<title>顧客登録</title>

<%
//例外処理をまとめるのに使用
ArrayList<String> errorMessageList = new ArrayList<String>();
%>


<script src="CheckboxUtil.js"></script>
<script src="CheckBoxDef.js"></script>
<script src="ObjUtil.js"></script>
<script src="InputTextCheck.js"></script>
<script src="Page.js"></script>
<script src="BrowserBackPrevent.js"></script>
<script src="list.js"></script>
<script src="displayFrameTitle.js"></script>
<script src="TextBoxUtil.js"></script><%-- Added by dai --%>
<script src="customer_list.js"></script>

<link href="CSS/Normalize.css" rel="stylesheet" type="text/css">
<link href="CSS/p16590004.css" rel="stylesheet" type="text/css">
<link href="CSS/customer_list.css" rel="stylesheet" type="text/css">
<%--　入力文字列の確認を入れる --%>

</head>
<body>

  <br>
  <h3 class="page_title">顧客登録</h3>
<%--
  <h3 class="customer_list_title">顧客登録</h3>
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

  <form id="Mainform" name="Mainform"
    action="./UWOptionController" method="POST">
    <%--レイアウト整えるためのもの --%>
    <table class="customer_edit_out_table">
      <tr>
        <td>
          <table class="customer_edit_table">
            <tr>
              <td class="customer_edit_table">顧客名</td>
              <td class="customer_edit_table"><input type="text" name="cus_name" class="customer_list_textbox"
                <c:choose>
                <%-- エラーがある状態に表示するもの --%>
                  <c:when test="${error.isError}">value="<c:out value="${customerMap.cus_name[0]}" />"</c:when>
<%-- エスケープさせるため
                  <c:when test="${error.isError}">value="${customerMap.cus_name[0]}"</c:when>
--%>
                <%-- エラーが無い状態に表示するもの --%>
                  <c:otherwise>value=""</c:otherwise>
                </c:choose>>
              <%--閉じタグのため消さない --%></td>
              <td class="customer_edit_table">
                <button type="submit" name="action" value="cus_add" onClick="return customer_Add()">追加</button>
              </td>
            </tr>
          </table> <br>
        </td>
      </tr>
      <tr>
        <td>
          <div class="customer_edit_move_button">
            <button type="submit" name="action" value="cus_del" onClick="return checkbox_delcheck();">削除</button>
          </div>
        </td>
      </tr>
      <tr>
        <td>
          <table class="customer_list_table">
            <tr>
              <th class="checkbox_area"><input type="checkbox" id="all" name="all" onClick="checkbox_ctrlAllcheckbox();">
              </th>
              <th class="customer_name">顧客名</th>
            </tr>
            <c:forEach items="${customerList}" var="cl">
              <tr>
                <td class="checkbox_area"><input type="checkbox" id="content" name="content" value="${cl.id}" onClick="checkbox_ctrlTopcheckbox();"></td>
                <td class="customer_name"><c:out value="${cl.customerName}" /></td>
<%-- エスケープさせるため
                <td class="customer_name">${cl.customerName}</td>
--%>
              </tr>
            </c:forEach>
          </table>
        </td>
      </tr>
      <tr>
        <td>
          <div class="page_portion">
            <jsp:include page="include_page_info.jsp" flush="true">
              <jsp:param name="forward_action" value="customer_list_next" />
              <jsp:param name="back_action" value="customer_list_back" />
			</jsp:include>
          </div>
        </td>
      </tr>
    </table>
    <!-- actionパラメータをセットするhiddenタグ-->
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