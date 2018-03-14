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
<title>インポート</title>

<%
//例外処理をまとめるのに使用
ArrayList<String> errorMessageList = new ArrayList<String>();
%>

<script src="BrowserBackPrevent.js"></script>
<script src="displayFrameTitle.js"></script>
<script src="proj_import.js"></script>

<link href="CSS/Normalize.css" rel="stylesheet" type="text/css">
<link href="CSS/p16590004.css" rel="stylesheet" type="text/css">
<link href="CSS/proj_import.css" rel="stylesheet" type="text/css">

</head>
<body>
  <br>
  <h3 class="page_title">インポート</h3>
  <%-- 修正・追加：インターノウスここから --%>
  <c:choose>
    <c:when test="${importError.isError}">
      <c:forEach items="${importError.errorInfoList}" var="error">
        <p class="error_message"><c:out value="${error}"/></p>
      </c:forEach>
    </c:when>
    <c:when test="${projImportProcessComplete}">
      <p class="complete_message">インポート正常終了しました</p>
    </c:when>
  </c:choose>
  <%-- 修正・追加：インターノウスここまで --%>

  <%--エラー表示を行う箇所 --%>
  <c:choose>
    <c:when test="${error.isError}">
      <p class="error_message"><c:out value="${error.errorInfo}"/></p>
    </c:when>
    <c:otherwise>
    </c:otherwise>
  </c:choose>
  <form name="Mainform" id="Mainform" action="./ProjController" method="POST" enctype="multipart/form-data">
    <table class="proj_import_out_table">
      <tr>
        <td>
          <table class="proj_import_table">
            <tr>
              <%-- <th>csvファイル</th> --%>
              <td><input type="file" name="p_imp_file" id="p_imp_file_id" class="import_file_box"></td>
            </tr>
          </table>
        </td>
      </tr>
      <tr>
        <td><br>
          <div class="proj_import_button">
            <button type="submit" name="action" value="p_imp_start" onClick=" return uploadFileCheck()">インポート開始</button>
            <button type="submit" name="action" value="p_imp_return">戻る</button>
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