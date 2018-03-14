<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.ArrayList" %>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<meta name="format-detection" content="telephone=no">
<title>仕入れインポート</title>

<%
//例外処理をまとめるのに使用
ArrayList<String> errorMessageList = new ArrayList<String>();
%>

<script src="BrowserBackPrevent.js"></script>
<script src="displayFrameTitle.js"></script>
<script src="purchase_import.js"></script>

<link href="CSS/Normalize.css" rel="stylesheet" type="text/css">
<link href="CSS/p16590004.css" rel="stylesheet" type="text/css">
<link href="CSS/purchase_import.css" rel="stylesheet" type="text/css">

</head>
<body>
  <br>
  <h3 class="page_title">仕入れインポート</h3>
  <c:choose>
  	<c:when test="${importError.isError}">
  	  <c:forEach items="${importError.errorInfoList}" var="error">
  	    <p class="error_message"><c:out value="${error}"/></p>
      </c:forEach>
  	</c:when>
  	<c:when test="${projPurchaseImportProcessComplete}">
  	  <p class="complete_message"><c:out value="${completeMessage}"/></p>
  	</c:when>
  	<c:otherwise>
  	</c:otherwise>
  </c:choose>
  <%--エラー表示を行う箇所 --%>
  <c:choose>
    <c:when test="${error.isError}">
      <p class="error_message"><c:out value="${error.errorInfo}"/></p>
    </c:when>
    <c:otherwise>
    </c:otherwise>
  </c:choose>
  <form name="Mainform" id="Mainform" action="./PurchaseController" method="POST" enctype="multipart/form-data">
    <table class="purchase_import_out_table">
      <tr>
        <td>
          <table class="purchase_import_table">
            <tr>
              <%-- <th>csvファイル</th> --%>
              <td>
              	<input type="file" name="purchase_import_file" id="purchase_import_file_id" class="import_file_box">
              	<div class="system_check">
              	  <input type="checkbox" name="is_proj_pre_purchase" value="true" />旧弥生データ(2017年度以前)
              	</div>
              </td>
            </tr>
          </table>
        </td>
      </tr>
      <tr>
        <td><br>
          <div class="purchase_import_button">
            <button type="submit" name="action" value="proj_purchase_import_start" onClick=" return uploadFileCheck()">インポート開始</button>
          </div></td>
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