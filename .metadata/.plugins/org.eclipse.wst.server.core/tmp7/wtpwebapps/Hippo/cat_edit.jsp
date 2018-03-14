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

<%--判定の値を数値（1,2)から文字(add,edit)へ変更する --%>
<c:if test="${formID == 'add'}" var="Add"/>
<c:if test="${Add}">
<title>分類追加</title>
</c:if>
<c:if test="${formID == 'edit'}" var="Edit"/>
<c:if test="${Edit}">
<title>分類編集</title>
</c:if>

<%
//例外処理をまとめるのに使用
ArrayList<String> errorMessageList = new ArrayList<String>();
%>


<script src="LimitDef.js"></script>
<script src="InputPatternDef.js"></script>
<script src="ObjUtil.js"></script>
<script src="InputTextCheck.js"></script>
<script src="BrowserBackPrevent.js"></script>
<script src="displayFrameTitle.js"></script>
<%-- <script src="TextBoxUtil.js"></script> --%><%-- Added by dai --%>
<script src="button_util.js"></script>
<script src="cat_edit.js"></script>

<link href="CSS/Normalize.css" rel="stylesheet" type="text/css">
<link href="CSS/p16590004.css" rel="stylesheet" type="text/css">
<link href="CSS/cat_edit.css" rel="stylesheet" type="text/css">

</head>
<body>
  <br>
  <c:if test="${Add}">
    <h3 class="page_title">分類追加</h3>
<%--
    <h3 class="cat_edit_title">分類追加</h3>
--%>
  </c:if>
  <c:if test="${Edit}">
    <h3 class="page_title">分類編集</h3>
<%--
    <h3 class="cat_edit_title">分類編集</h3>
--%>
  </c:if>
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
  <form id="cat_edit_form_id" name="Bunruiedit" action="./UWOptionController" method="POST">
<%-- enter backspace 抑制対応
  <form name="Bunruiedit" action="./UWOptionController" method="POST">
--%>
    <table class="cat_edit_out_table">
      <tr>
        <td>
          <table class="cat_edit_table">
            <%-- 変更側のvalueには変数が入る --%>
            <tr>
              <th>分類名　※</th>
              <%-- 分類名の表示を新規と編集で切り替える箇所 --%>
              <%-- 新規追加時の処理 --%>
              <c:choose>
                <c:when test="${Add}">
                  <td class="cat_edit_table">
                    <input type="text" name="bunrui_name"
                    <c:choose>
                      <c:when test="${error.isError}">value="<c:out value="${categoryMap.bunrui_name[0]}" />"</c:when>
<%-- エスケープさせるため
                      <c:when test="${error.isError}">value="${categoryMap.bunrui_name[0]}"</c:when>
--%>
                      <c:otherwise>value=""</c:otherwise>
                    </c:choose>>
                    <%--inputタグの閉じのため消さない --%>
                  </td>
                </c:when>
                <c:when test="${Edit}">
                  <td><input type="text" class="edit_readonly" readonly name="bunrui_name"
                    <c:choose>
                      <c:when test="${error.isError}">value="<c:out value="${categoryMap.bunrui_name[0]}" />"</c:when>
                      <c:otherwise> value="<c:out value="${category.name}" />"</c:otherwise>
<%-- エスケープさせるため
                      <c:when test="${error.isError}">value="${categoryMap.bunrui_name[0]}"</c:when>
                      <c:otherwise> value="${category.name}"</c:otherwise>
--%>
                    </c:choose>>
                  </td>
                </c:when>
              </c:choose>
            </tr>
            <%-- 目標値の表示を新規と編集で切り替える箇所 --%>
            <tr>
              <th>目標値　※</th>
              <%-- 新規追加時の処理 --%>
              <c:choose>
                <c:when test="${Add}">
                  <td><input type="text" name="bunrui_goal"
                    <c:choose>
                          <c:when test="${error.isError}">value="${categoryMap.bunrui_goal[0]}"</c:when>
                          <c:otherwise>value=""</c:otherwise>
                        </c:choose>>
                  </td>
                </c:when>
                <c:when test="${Edit}">
                  <td><input type="text" name="bunrui_goal"
                    <c:choose>
                          <c:when test="${error.isError}">value="${categoryMap.bunrui_goal[0]}"</c:when>
                          <c:otherwise>value="${category.targetVal}"</c:otherwise>
                        </c:choose>>
                  </td>
                </c:when>
              </c:choose>
            </tr>
          </table> <%--レイアウト調整のためのもの --%>
        </td>
      </tr>
      <tr>
        <td>
          <div class="cat_edit_button">
            <c:choose>
              <c:when test="${Add}">
                <br>
                <button type="button" value="bunrui_add" onClick="return Bunrui_Add() && setActionToHidden(this) && submit();">追加</button>
              </c:when>
              <c:when test="${Edit}">
                <br>
                <button type="button" value="bunrui_edit" onClick="return Bunrui_Edit() && setActionToHidden(this) && submit();">変更</button>
                <%-- 変更のみhiddenでidを渡すためBeansから渡される値をvalueに入れる --%>
                <c:choose>
                  <%-- エラー時 --%>
                  <c:when test="${error.isError}">
                    <input type="hidden" name="bunrui_id" value="${categoryMap.bunrui_id[0]}">
                  </c:when>
                  <%-- 通常時 --%>
                  <c:otherwise>
                    <input type="hidden" name="bunrui_id" value="${category.id}">
                  </c:otherwise>
                </c:choose>
                
              </c:when>
            </c:choose>
            <button type="button" onClick="return setActionToHidden(this) && submit();"
              <c:choose>
                <c:when test="${Add}">value="bunrui_add_return"</c:when>
                <c:when test="${Edit}">value="bunrui_edit_return"</c:when>
              </c:choose>
            >戻る
            <%-- 戻る左側の「>」はbuttonタグの閉じのため消さない --%>
            </button>
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
