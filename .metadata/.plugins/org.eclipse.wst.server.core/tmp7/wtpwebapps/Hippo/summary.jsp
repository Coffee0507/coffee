<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="jp.co.lsij.p16590004.common.Error"%>
<%@ page import="jp.co.lsij.p16590004.common.ScopeNameConstants"%>
<%@ page import="jp.co.lsij.p16590004.common.UWAnalysisConstants"%>
<%@ page import="jp.co.lsij.p16590004.common.UWCalcType"%>
<%@ page import="jp.co.lsij.p16590004.common.QuarterType"%>
<%@ page import="jp.co.lsij.p16590004.e_200.model.analyze.beans.UWAnalysisData"%>
<!DOCTYPE html>

<html lang="ja">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name="format-detection" content="telephone=no">
  
  <link href="CSS/Normalize.css" rel="stylesheet" type="text/css">
  <link href="CSS/p16590004.css" rel="stylesheet" type="text/css">
  <link href="CSS/summary.css" rel="stylesheet" type="text/css">
  <link href="CSS/print.css" rel="stylesheet" type="text/css" media="print">

  <script src="BrowserBackPrevent.js"></script>
  <script src="displayFrameTitle.js"></script>
  <script src="SelectBoxUtil.js"></script>
  <script src="summary.js"></script>

  <title>総計</title>

<%
/** 月の並び順配列 */
int[] nMonthArray = {4, 5, 6, 7, 8, 9, 10, 11, 12, 1, 2, 3};

/** 集計結果オブジェクト */
UWAnalysisData      uwAnalysisData = null;

/** 例外処理をまとめるのに使用 */
List<String> errorMessageList = new ArrayList<String>();
%>
</head>
<body>
<%
try {
  request.setAttribute("month_array", nMonthArray);

  //コントローラからの各種情報の取得
  Error  error = null;
  error = (Error)request.getAttribute(ScopeNameConstants.SCOPE_ERROR_CLASS);
  if (null == error) {
    errorMessageList.add("error==null");
  }
  boolean  isPast = false;
  isPast = (boolean)request.getAttribute(UWAnalysisConstants.SCOPE_UW_ANALYSIS_PAST_OR_NOT);
  boolean  isExistUWAnalysisData = false;
  if (false == isPast) {
    isExistUWAnalysisData = true;
  } else {
    isExistUWAnalysisData = (boolean)request.getAttribute(UWAnalysisConstants.SCOPE_DATA_EXISTS);
  }
  if (false != isExistUWAnalysisData) {
    uwAnalysisData = (UWAnalysisData)request.getAttribute(UWAnalysisConstants.SCOPE_DATA_OF_UW_ANALYSIS);
    if (null == uwAnalysisData) {
      errorMessageList.add("dataOfUWAnalysis==null");
    }
  }
} catch (Exception err) {
  try {
    errorMessageList.add("例外発生（データ取得部）（" + err.getMessage() + "）");
  } catch (Exception err_2) {}
}
%>
  <br>
  <h3 class="page_title">総計
    <%--JSTL使用するように変更 --%>
    <c:if test="${dataExists != false}">
      ―<fmt:formatDate value="${dataOfUWAnalysis.dateOfCalculation}" pattern="yyyy年MM月dd日"/>
    </c:if>
  </h3>

  <%--エラー表示を行う箇所 --%>
  <c:choose>
    <c:when test="${error.isError}"><p class="error_message noprint">${error.errorInfo}</p></c:when>
    <c:otherwise></c:otherwise>
  </c:choose>

  <form id="Mainform" name="Mainform" action="./UWAnalysisController" method="POST">
    <table>
      <tr>
        <td>
          <table>
            <tr>
              <%-- コンボボックス処理--%>
              <%--JSTL使用するように変更 --%>
              <c:if test="${isPast != false}">
                <td>
                  <select id="summary_date_select_box_id" class="noprint" name="search_yearmonth">
<%-- コンボボックスが選択されていない場合に、チェックがない
                  <select class="noprint" name="search_yearmonth">
--%>
                  <c:forEach var="aggregateDate" items="${dateOfCalculation}" varStatus="loopStatus">
                    <option value="${aggregateDate.id}" 
                    <c:if test="${loopStatus.first != false}">selected</c:if>
                    > <%--optionタグの閉じのため消さない --%>
                    <fmt:formatDate value="${aggregateDate.aggregateDate}" pattern="yyyy年MM月dd日"/>
                    </option>
                  </c:forEach>
                  </select>
                </td>
              </c:if>
              <c:if test="${isPast}">
                <td>
                  <button type="submit" class="noprint" name="action" value="summary_year_dis" onClick="return clickDispProc()">表示</button>
<%-- コンボボックスが選択されていない場合に、チェックがない
                  <button type="submit" class="noprint" name="action" value="summary_year_dis">表示</button>
--%>
                </td>
              </c:if>
              <td>
                <button type="button" class="noprint" onClick="print()">印刷</button>
              </td>
            </tr>
          </table>
        </td>
      </tr>

      <tr>
        <td>
          <table class="summary_table">
            <tr>
              <th class="month_area">月</th>
              <th class="summary_head">受注済</th>
              <th class="summary_head">売上済</th>
              <th class="summary_head">合計</th>
            </tr>
            <%--JSTL使用するように変更 --%>
            <c:if test="${dataExists != false}">
              <c:forEach items="${month_array}" var="month">
                <tr>
                  <td class="month_area">${month}</td>
                  <td>
                    <fmt:formatNumber value="${dataOfUWAnalysis.uwAnalysisByMonth[month].sumOfOrder}" />
                  </td>
                  <td>
                    <fmt:formatNumber value="${dataOfUWAnalysis.uwAnalysisByMonth[month].sumOfSales}" />
                  </td>
                  <td>
                    <fmt:formatNumber value="${dataOfUWAnalysis.uwAnalysisByMonth[month].sum()}" />
                  </td>
                </tr>
              </c:forEach>
              <tr>
                <th colspan="3">本日までの売上済合計</th>
                <td>
                  <c:if test="${!empty dataOfUWAnalysis}">
                    <fmt:formatNumber value="<%=uwAnalysisData.sumByYear(UWCalcType.SALES_ONLY)%>" />
                  </c:if>
                </td>
              </tr>
              <tr>
                <th colspan="3">総計</th>
                <td>
                  <c:if test="${!empty dataOfUWAnalysis}">
                    <fmt:formatNumber value="<%=uwAnalysisData.sumByYear(UWCalcType.ORDER_AND_SALES)%>" />
                  </c:if>
                </td>
              </tr>
              <tr>
                <th colspan="3">1Q 合計</th>
                <td>
                  <c:if test="${!empty dataOfUWAnalysis}">
                    <fmt:formatNumber value="<%=uwAnalysisData.sumByQuarter(QuarterType.FIRST, UWCalcType.ORDER_AND_SALES)%>" />
                  </c:if>
                </td>
              </tr>
              <tr>
                <th colspan="3">2Q 合計</th>
                <td>
                  <c:if test="${!empty dataOfUWAnalysis}">
                    <fmt:formatNumber value="<%=uwAnalysisData.sumByQuarter(QuarterType.SECOND, UWCalcType.ORDER_AND_SALES)%>" />
                  </c:if>
                </td>
              </tr>
              <tr>
                <th colspan="3">3Q 合計</th>
                <td>
                  <c:if test="${!empty dataOfUWAnalysis}">
                    <fmt:formatNumber value="<%=uwAnalysisData.sumByQuarter(QuarterType.THIRD, UWCalcType.ORDER_AND_SALES)%>" />
                  </c:if>
                </td>
              </tr>
              <tr>
                <th colspan="3">4Q 合計</th>
                <td>
                  <c:if test="${!empty dataOfUWAnalysis}">
                    <fmt:formatNumber value="<%=uwAnalysisData.sumByQuarter(QuarterType.FOURTH, UWCalcType.ORDER_AND_SALES)%>" />
                  </c:if>
                </td>
              </tr>
            </c:if>
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