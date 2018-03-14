<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="jp.co.lsij.p16590004.common.Error" %>
<%@ page import="jp.co.lsij.p16590004.e_77.model.master.beans.PageBean" %>
<%@ page import="jp.co.lsij.p16590004.e_77.model.master.beans.SortBean" %>
<%@ page import="jp.co.lsij.p16590004.e_200.model.bean.SearchBean" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.ArrayList" %>


<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<meta name="format-detection" content="telephone=no">
<title>操作ログ</title>


<%
//ソート、検索に使用する変数群
//ソート項目を入れる変数
String sortItem = null;
//ソートの昇順、降順を入れる変数
boolean sortOrder = false;
//検索項目を入れる変数
String searchItem = null;
//検索ワードを入れる変数
String searchWord = null;
//フラグ判定
boolean textboxFlag = false;

//例外処理をまとめるのに使用
ArrayList<String> errorMessageList = new ArrayList<String>();
%>
<script src="BrowserBackPrevent.js"></script>
<script src="Page.js"></script>

<script src="ObjUtil.js"></script>
<script src="InputTextCheck.js"></script>
<script src="displayFrameTitle.js"></script>
<%--<script src="TextBoxUtil.js"></script> Added by dai --%>
<script src="button_util.js"></script>
<script src="log_list.js"></script>
<script src="JS_LIB/jQuery/jquery-3.2.1.min.js" type="text/javascript"></script>
<!-- bootstrap -->
<link href="JS_LIB/bootstrap/bootstrap.css" type="text/css" rel="stylesheet"></link>
<script src="JS_LIB/bootstrap/bootstrap.js" type="text/javascript"></script>
<!-- bootstrap-datepicker -->
<link href="JS_LIB/bootstrap/bootstrap-datepicker.css" type="text/css" rel="stylesheet"></link>
<script src="JS_LIB/bootstrap/bootstrap-datepicker.js" type="text/javascript"></script>
<!-- 日本語対応用スクリプト -->
<script src="JS_LIB/bootstrap/bootstrap-datepicker.ja.min.js" type="text/javascript"></script>

<script src="datepicker-configuration.js"></script>

<link href="CSS/Normalize.css" rel="stylesheet" type="text/css">
<link href="CSS/p16590004.css" rel="stylesheet" type="text/css">
<link href="CSS/log_list.css" rel="stylesheet" type="text/css">

</head>
<body>
<%
//ソートに関する処理
SortBean sort = (SortBean) request.getAttribute("logSort");
//SortBean sort = (SortBean) session.getAttribute("logSort");
if (sort == null) {
  //out.println("sort null");
  errorMessageList.add("sort null");
} else {
  try {
    //ソート項目を取得
    sortItem = sort.getColumnName();
    request.setAttribute("searchItem", searchItem);
    //ソートの昇順、降順を取得
    sortOrder = sort.isAsc();
    request.setAttribute("sortOrder", sortOrder);
  } catch (Exception error) {
    errorMessageList.add("ソート項目のセット処理の処理でエラー");
  }
}

//検索に関する処理
SearchBean search = (SearchBean)request.getAttribute("logSearch");
//SearchBean search = (SearchBean)session.getAttribute("logSearch");
try {
  if (search == null) {
    searchItem = "none";
    request.setAttribute("searchItem1", searchItem);
    searchWord = "";
    request.setAttribute("searchWord1", searchWord);
    textboxFlag = true;
    request.setAttribute("textboxFlag", textboxFlag);
    //配列が1つの時
  } else if(search != null) {
    SearchBean searchbean1 = (SearchBean) search;
    searchItem = searchbean1.getSearchCategory();
    request.setAttribute("searchItem1", searchItem);
    //フラグを立てる処理
    if (searchItem.equals("c_search_time")){
      textboxFlag = true;
      request.setAttribute("textboxFlag", textboxFlag);
      searchWord = searchbean1.getSearchWord();
      request.setAttribute("searchWord1", searchWord);
    } else {
      textboxFlag = false;
      request.setAttribute("textboxFlag", textboxFlag);
      searchWord = searchbean1.getSearchWord();
      request.setAttribute("searchWord1", searchWord);
    }
  }
} catch (Exception error){
  errorMessageList.add("検索項目のセット処理でエラー");
}
%>

  <br>
  <h3 class="page_title">操作ログ</h3>
<%--
  <h3 class="log_list_title">操作ログ</h3>
--%>
  <form id="Mainform" name="Mainform" action="./LogController" method="POST">
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
    <table class="log_list_out_table">
      <tr>
        <td>
          <table class="search_area_table">
            <tr>
              <td>ソート：</td>
              <td><select name="sort_sec">
                  <option value="c_sort_time"
                    <c:if test="${logSort.columnName eq 'c_sort_time'}"> selected="selected"</c:if>>日時</option>
                  <option value="c_sort_user"
                    <c:if test="${logSort.columnName eq 'c_sort_user'}"> selected="selected"</c:if>>使用者</option>
                  <option value="c_sort_place"
                    <c:if test="${logSort.columnName eq 'c_sort_place'}"> selected="selected"</c:if>>操作箇所</option>
              </select></td>
              <td><select name="sort_order">
                  <option value="asc"
                    <c:if test="${logSort.asc}"> selected="selected"</c:if>>昇順</option>
                  <option value="desc"
                    <c:if test="${!logSort.asc}"> selected="selected"</c:if>>降順</option>
              </select></td>
            </tr>
            <tr>
              <td>検索条件：</td>
              <td>
                <select name="search_sec_1" id="search_sec_1" onChange="change(this)">
                  <option value="c_search_time" <c:if test="${logSearch.searchCategory eq 'c_search_time'}"> selected="selected"</c:if>>日時</option>
                  <option value="c_search_user" <c:if test="${logSearch.searchCategory eq 'c_search_user'}"> selected="selected"</c:if>>使用者</option>
                  <option value="c_search_place"<c:if test="${logSearch.searchCategory eq 'c_search_place'}"> selected="selected"</c:if>>操作箇所</option>
                </select>
              </td>
              <td><c:if test="${textboxFlag}">
                   <input type="text"  class="dp2 monthsize" id="search_word_date" name="search_word_date" readonly 
                    <c:choose>
                      <c:when test="${error.isError}"> value="<c:out value="${logSearch.searchWord}" />"</c:when>
                      <c:when test="${logSearch.searchWord != null}">value="<c:out value="${logSearch.searchWord}" />"</c:when>
<%-- エスケープさせるため
                      <c:when test="${error.isError}"> value="${logSearch.searchWord}"</c:when>
                      <c:when test="${logSearch.searchWord != null}">value="${logSearch.searchWord}"</c:when>
--%>
                      <c:otherwise>value=""</c:otherwise>
                    </c:choose>>
                  <%--閉じタグのため消さない --%>
                  <input type="text" id="search_word_text" name="search_word_text" class="search_content"
                    <c:choose>
                      <c:when test="${error.isError}"> value=""</c:when>
                      <c:when test="${logSearch.searchWord != null}">value=""</c:when>
                      <c:otherwise>value=""</c:otherwise>
                    </c:choose>>
                </c:if> <c:if test="${!textboxFlag}">
                   <input type="text"  class="dp2 monthsize" id="search_word_date" name="search_word_date" readonly 
                    <c:choose>
                      <c:when test="${error.isError}"> value=""</c:when>
                      <c:when test="${logSearch.searchWord != null}">value=""</c:when>
                      <c:otherwise>value=""</c:otherwise>
                    </c:choose>>
                  <%--閉じタグのため消さない --%>

                  <input type="text" id="search_word_text" name="search_word_text" class="search_content"
                    <c:choose>
                      <c:when test="${error.isError}"> value="<c:out value="${logSearch.searchWord}" />"</c:when>
                      <c:when test="${logSearch.searchWord != null}">value="<c:out value="${logSearch.searchWord}" />"</c:when>
<%-- エスケープさせるため
                      <c:when test="${error.isError}"> value="${logSearch.searchWord}"</c:when>
                      <c:when test="${logSearch.searchWord != null}">value="${logSearch.searchWord}"</c:when>
--%>
                      <c:otherwise>value=""</c:otherwise>
                    </c:choose>>
                  <%-- 閉じタグのため消さない --%>
                </c:if></td>
              <td>
              <button type="button" value="log_search" onClick="return doLogSearch() && setActionToHidden(this) && submit();;">検索</button>
              </td>
            </tr>
          </table>

        </td>
      </tr>
      <tr>
        <td>

          <table class="log_list_table">
            <tr>
              <th class="date">日時</th>
              <th class="user">使用者</th>
              <th class="ctrlplace">操作箇所</th>
              <th class="dat">詳細</th>
            </tr>
            <c:forEach items="${logList}" var="log">
              <tr>
                <td class="date"><fmt:formatDate value="${log.execDatetime}" pattern="yyyy/MM/dd HH:mm:ss" /></td>
                <td class="user"><c:out value="${log.execUserName}" /></td>
                <td class="ctrlplace"><c:out value="${log.execPlace}" /></td>
                <td class="dat"><c:out value="${log.execContent}" /></td>
<%-- エスケープさせるため
                <td class="user">${log.execUserName}</td>
                <td class="ctrlplace">${log.execPlace}</td>
                <td class="dat">${log.execContent}</td>
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
              <jsp:param name="forward_action" value="log_list_next" />
              <jsp:param name="back_action" value="log_list_back" />
			</jsp:include>
          </div>
        </td>
      </tr>
    </table>
    <input type="hidden" id="search_word_1" name="search_word_1" value=""> <%--ページ分割に使用する情報を取得する箇所 javascriptで使用 --%>
    <input type="hidden" name="action" value="" id="action_id" class="hidden_action_param">
  </form>
  <br>
  <%
  //共通モジュールに渡すエラーリストをリクエストスコープにセット
  request.setAttribute("errorMessageList", errorMessageList);
  %>
  <jsp:include page="include_error_message.jsp" flush="true"/>
</body>
</html>