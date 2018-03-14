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

<c:if test="${formID == 'add'}" var="Add" />
<c:if test="${Add}">
  <title>営業担当追加</title>
</c:if>
<c:if test="${formID == 'edit'}" var="Edit" />
<c:if test="${Edit}">
  <title>営業担当編集</title>
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
<script src="button_util.js"></script>
<script src="sales_user_edit.js"></script>

<link href="CSS/Normalize.css" rel="stylesheet" type="text/css">
<link href="CSS/p16590004.css" rel="stylesheet" type="text/css">
<link href="CSS/sales_user_edit.css" rel="stylesheet" type="text/css">

</head>
<body>
  <c:if test="${formID == 'add'}" var="Add" />
  <c:if test="${Add}">
    <h3 class="page_title">営業担当追加</h3>
<%--
    <h3 class="sales_user_edit_title">営業担当追加</h3>
--%>
  </c:if>
  <c:if test="${formID == 'edit'}" var="Edit" />
  <c:if test="${Edit}">
    <h3 class="page_title">営業担当編集</h3>
<%--
    <h3 class="sales_user_edit_title">営業担当編集</h3>
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

  <form id="Mainform" name="Salesuseredit" action="./UWOptionController" method="POST">
    <table class="sales_user_edit_out_table">
      <tr>
        <td>
          <table class="sales_user_edit_table">
            <tr>
              <th class="sales_user_edit_table">氏名　※</th>
              <c:choose>
                <c:when test="${Add}">
                  <td><input type="text" name="sales_user_name"
                    <c:choose>
                    <c:when test="${error.isError}">value="<c:out value="${salesStaffMap.sales_user_name[0]}" />"</c:when>
<%-- エスケープさせるため
                    <c:when test="${error.isError}">value="${salesStaffMap.sales_user_name[0]}"</c:when>
--%>
                    <c:otherwise>value=""</c:otherwise>
                  </c:choose>>
                  </td>
                </c:when>
                <c:when test="${Edit}">
                  <td><input type="text" name="sales_user_name" readonly class="edit_readonly"
                    <c:choose>
                    <c:when test="${error.isError}">value="<c:out value="${salesStaffMap.sales_user_name[0]}" />"</c:when>
                    <c:otherwise>value="<c:out value="${salesStaff.salesStaff}" />"</c:otherwise>
<%-- エスケープさせるため
                    <c:when test="${error.isError}">value="${salesStaffMap.sales_user_name[0]}"</c:when>
                    <c:otherwise>value="${salesStaff.salesStaff}"</c:otherwise>
--%>
                  </c:choose>>
                  </td>
                </c:when>
              </c:choose>
            </tr>
            <tr>
              <th class="sales_user_edit_table">売上目標値　※</th>
              <c:choose>
                <c:when test="${Add}">
                  <td><input type="text" name="sales_user_goal" id="sales_user_goal"
                    <c:choose>
                    <c:when test="${error.isError}">value="${salesStaffMap.sales_user_goal[0]}"</c:when>
                    <c:otherwise>value=""</c:otherwise>
                  </c:choose>>
                  </td>
                </c:when>
                <c:when test="${Edit}">
                  <td><input type="text" name="sales_user_goal" id="sales_user_goal"
                    <c:choose>
                    <c:when test="${error.isError}">value="${salesStaffMap.sales_user_goal[0]}"</c:when>
                    <c:otherwise>value="${salesStaff.targetVal}"</c:otherwise>
                  </c:choose>>
                  </td>
                </c:when>
              </c:choose>
            </tr>
            <tr>
              <th class="sales_user_edit_table">注残目標値　※</th>
              <c:choose>
                <c:when test="${Add}">
                  <td><input type="text" name="sales_user_remark" id="sales_user_remark"
                    <c:choose>
                    <c:when test="${error.isError}">value="${salesStaffMap.sales_user_remark[0]}"</c:when>
                    <c:otherwise>value=""</c:otherwise>
                  </c:choose>>
                  </td>
                </c:when>
                <c:when test="${Edit}">
                  <td><input type="text" name="sales_user_remark" id="sales_user_remark"
                    <c:choose>
                    <c:when test="${error.isError}">value="${salesStaffMap.sales_user_remark[0]}"</c:when>
                    <c:otherwise>value="${salesStaff.nextYearTargetVal}"</c:otherwise>
                  </c:choose>>
                  </td>
                </c:when>
              </c:choose>
            </tr>
          </table>
        </td>
      </tr>
      <tr>
        <td>
          <div class="sales_user_edit_button">
            <c:choose>
              <c:when test="${Add}">
                <br>
                <button type="button" value="sales_user_add" onClick="return Sales_User_Add() && setActionToHidden(this) && submit();">追加</button>
              </c:when>
              <c:when test="${Edit}">
                <br>
                <button type="button" value="sales_user_edit" onClick="return Sales_User_Edit() && setActionToHidden(this) && submit();">変更</button>
                <%-- <input type="hidden" name="sales_user_id" value="${salesStaff.id}"> --%>
                <c:choose>
                  <%-- エラー時 --%>
                  <c:when test="${error.isError}">
                    <input type="hidden" name="sales_user_id" value="${salesStaffMap.sales_user_id[0]}">
                  </c:when>
                  <%-- 通常時 --%>
                  <c:otherwise>
                    <input type="hidden" name="sales_user_id" value="${salesStaff.id}">
                  </c:otherwise>
                </c:choose>
              </c:when>
            </c:choose>
            <button type="button" onClick="return setActionToHidden(this) && submit();"
              <c:choose>
                <c:when test="${Add}">value="sales_user_add_return"</c:when>
                <c:when test="${Edit}">value="sales_user_edit_return"</c:when>
              </c:choose>>戻る
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