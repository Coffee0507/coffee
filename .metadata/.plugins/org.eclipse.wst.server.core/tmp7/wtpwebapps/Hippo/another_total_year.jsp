<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List"%>
<%@ page import="java.time.Month"%>
<%@ page import="jp.co.lsij.p16590004.common.Error"%>
<%@ page import="jp.co.lsij.p16590004.common.ScopeNameConstants"%>
<%@ page import="jp.co.lsij.p16590004.common.UWAnalysisConstants"%>
<%@ page import="jp.co.lsij.p16590004.common.UWCalcType"%>
<%@ page import="jp.co.lsij.p16590004.common.QuarterType"%>
<%@ page import="jp.co.lsij.p16590004.e_200.model.analyze.beans.UWAnalysisData"%>
<%@ page import="jp.co.lsij.p16590004.e_77.util.StringHelper"%>
<!DOCTYPE html>

<html lang="ja">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name="format-detection" content="telephone=no">
  
  <link href="CSS/Normalize.css" rel="stylesheet" type="text/css">
  <link href="CSS/p16590004.css" rel="stylesheet" type="text/css">
  <link href="CSS/another_total_year.css" rel="stylesheet" type="text/css">
  <link href="CSS/print.css" rel="stylesheet" type="text/css" media="print">

  <script src="BrowserBackPrevent.js"></script>
  <script src="displayFrameTitle.js"></script>
  <script src="SelectBoxUtil.js"></script>
  <script src="another_total_year.js"></script>

  <script src="JS_LIB/chart/Chart.min.js" type="text/javascript"></script>

  <title>受注・売上月別合計</title>
  
<%
/** 月の並び順配列 */
int[] nMonthArray = {4, 5, 6, 7, 8, 9, 10, 11, 12, 1, 2, 3};

/** 集計結果オブジェクト */
UWAnalysisData  uwAnalysisData = null;

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
  <h3 class="page_title">受注・売上月別合計
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
    <table class="another_total_year_out_table">
      <tr>
        <td>
          <table>
            <tr>
              <%-- コンボボックス処理--%>
              <%--JSTL使用するように変更 --%>
              <c:if test="${isPast != false}">
                <td>
                  <select id="total_date_select_box_id" class="noprint" name="search_yearmonth">
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
                  <button type="submit" class="noprint" name="action" value="another_total_year_dis" onClick="return clickDispProc()">表示</button>
<%-- コンボボックスが選択されていない場合に、チェックがない
                  <button type="submit" class="noprint" name="action" value="another_total_year_dis">表示</button>
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
        <td>　</td>
      </tr>

      <tr>
        <td>月別受注合計</td>
      </tr>

      <tr>
        <td>
          <table class="another_total_year_order_table">
            <tr>
              <th>前期分</th>
              <c:forEach var="month" items="${month_array}">
                <th>${month}月</th>
              </c:forEach>
              <th>来期分</th>
              <th>合計</th>
            </tr>

            <%--JSTL使用するように変更 --%>
            <c:if test="${dataExists != false}">
              <tr>
                <td>
                  <fmt:formatNumber value="${dataOfUWAnalysis.orderPrev}" />
                </td>
                <c:forEach items="${month_array}" var="order_month">
                  <td>
                    <fmt:formatNumber value="${dataOfUWAnalysis.uwAnalysisByMonth[order_month].sumOfOrder}" />
                  </td>
                </c:forEach>
                <td>
                  <fmt:formatNumber value="${dataOfUWAnalysis.orderNext}" />
                </td>
                <td class="hyphen_area">―</td>
<%-- 合計を下の行に出すように変更
                <td>
                  <c:if test="${!empty dataOfUWAnalysis}">
                    <fmt:formatNumber value="<%=uwAnalysisData.sumByYear(UWCalcType.ORDER_ONLY)%>" />
                  </c:if>
                </td>
--%>
              </tr>
              <tr>
                <td class="hyphen_area">―</td>
                <td colspan="3">
                  <c:if test="${!empty dataOfUWAnalysis}">
                    <fmt:formatNumber value="<%=uwAnalysisData.sumByQuarter(QuarterType.FIRST, UWCalcType.ORDER_ONLY)%>" />
                  </c:if>
                </td>
                <td colspan="3">
                  <c:if test="${!empty dataOfUWAnalysis}">
                    <fmt:formatNumber value="<%=uwAnalysisData.sumByQuarter(QuarterType.SECOND, UWCalcType.ORDER_ONLY)%>" />
                  </c:if>
                </td>
                <td colspan="3">
                  <c:if test="${!empty dataOfUWAnalysis}">
                    <fmt:formatNumber value="<%=uwAnalysisData.sumByQuarter(QuarterType.THIRD, UWCalcType.ORDER_ONLY)%>" />
                  </c:if>
                </td>
                <td colspan="3">
                  <c:if test="${!empty dataOfUWAnalysis}">
                    <fmt:formatNumber value="<%=uwAnalysisData.sumByQuarter(QuarterType.FOURTH, UWCalcType.ORDER_ONLY)%>" />
                  </c:if>
                </td>
                <td class="hyphen_area">―</td>
                <td>
                  <c:if test="${!empty dataOfUWAnalysis}">
                    <fmt:formatNumber value="<%=uwAnalysisData.sumByYear(UWCalcType.ORDER_ONLY)%>" />
                  </c:if>
                </td>
<%-- 合計を下の行に出すように変更
                <td class="hyphen_area">―</td>
--%>
              </tr>
            </c:if>

          </table>
        </td>
      </tr>
      
      <tr>
        <td>　</td>
      </tr>

      <tr>
        <td>月別売上合計</td>
      </tr>
      
      <tr>
        <td>
          <table class="another_total_year_sales_table">
            <tr>
              <th class="nodisplay"></th>
              <c:forEach var="month" items="${month_array}">
                <th>${month}月</th>
              </c:forEach>
              <th>合計</th>
              <th class="nodisplay"></th>
            </tr>

            <%--JSTL使用するように変更 --%>
            <c:if test="${dataExists != false}">
              <tr>
                <td class="nodisplay"></td>
                <c:forEach items="${month_array}" var="sales_month">
                  <td>
                    <fmt:formatNumber value="${dataOfUWAnalysis.uwAnalysisByMonth[sales_month].sumOfSales}" />
                  </td>
                </c:forEach>
                <td>
                  <c:if test="${!empty dataOfUWAnalysis}">
                    <fmt:formatNumber value="<%=uwAnalysisData.sumByYear(UWCalcType.SALES_ONLY)%>" />
                  </c:if>
                </td>
                <td class="nodisplay"></td>
              </tr>
              <%-- クォータを表示させるように変更--%>
              <tr>
                <td class="nodisplay"></td>
                <td colspan="3">
                  <c:if test="${!empty dataOfUWAnalysis}">
                    <fmt:formatNumber value="<%=uwAnalysisData.sumByQuarter(QuarterType.FIRST, UWCalcType.SALES_ONLY)%>" />
                  </c:if>
                </td>
                <td colspan="3">
                  <c:if test="${!empty dataOfUWAnalysis}">
                    <fmt:formatNumber value="<%=uwAnalysisData.sumByQuarter(QuarterType.SECOND, UWCalcType.SALES_ONLY)%>" />
                  </c:if>
                </td>
                <td colspan="3">
                  <c:if test="${!empty dataOfUWAnalysis}">
                    <fmt:formatNumber value="<%=uwAnalysisData.sumByQuarter(QuarterType.THIRD, UWCalcType.SALES_ONLY)%>" />
                  </c:if>
                </td>
                <td colspan="3">
                  <c:if test="${!empty dataOfUWAnalysis}">
                    <fmt:formatNumber value="<%=uwAnalysisData.sumByQuarter(QuarterType.FOURTH, UWCalcType.SALES_ONLY)%>" />
                  </c:if>
                </td>
                <td class="hyphen_area">―</td>
                <td class="nodisplay"></td>
              </tr>
              <%-- クォータを表示させるように変更（ここまで）--%>
            </c:if>
            
          </table>
        </td>
      </tr>
    </table>
  </form>
  <br>
  <br>
  <br>
<%
String[] orderTotalData = null;

try {
  if (null == uwAnalysisData) {
  } else {
    orderTotalData = new String[nMonthArray.length];
    for (int nIndex = 0; nIndex < nMonthArray.length; nIndex++) {
      orderTotalData[nIndex] = StringHelper.valueOf(uwAnalysisData.getSumOfOrderByMonth(Month.of(nMonthArray[nIndex])));
    }
  }
  request.setAttribute("order_per_month_data", orderTotalData);
} catch (Exception err) {
  try {
    errorMessageList.add("例外発生（グラフ生成部（受注データ））（" + err.getMessage() + "）");
  } catch (Exception err_2) {}
}
String[] salesTotalData = null;

try {
  if (null == uwAnalysisData) {
  } else {
    salesTotalData = new String[nMonthArray.length];
    for (int nIndex = 0; nIndex < nMonthArray.length; nIndex++) {
      salesTotalData[nIndex] = StringHelper.valueOf(uwAnalysisData.getSumOfSalesByMonth(Month.of(nMonthArray[nIndex])));
    }
  }
  request.setAttribute("sales_per_month_data", salesTotalData);
} catch (Exception err) {
  try {
    errorMessageList.add("例外発生（グラフ生成部（売上データ））（" + err.getMessage() + "）");
  } catch (Exception err_2) {}
}

try {
  //仮
  String breakevenPointData = new String("75000000");
  request.setAttribute("breakeven_point_data", breakevenPointData);
} catch (Exception err) {
  try {
    errorMessageList.add("例外発生（グラフ生成部（損益分岐点データ））（" + err.getMessage() + "）");
  } catch (Exception err_2) {}
}

try {
  //仮
  String targetData = new String("110000000");
  request.setAttribute("target_data", targetData);
} catch (Exception err) {
  try {
    errorMessageList.add("例外発生（グラフ生成部（目標データ））（" + err.getMessage() + "）");
  } catch (Exception err_2) {}
}
%>
<%
  if (null != uwAnalysisData) {
%>
  <table>
      <tr>
        <td>
          <jsp:include page="include_order_and_sales_per_month_graph.jsp" flush="true" />
<%
try {
  //include_order_and_sales_per_month_graph.jsp 内のエラーをコピー
  List<String> orderAndSalesPerMonthErrorMessageList = (List<String>)request.getAttribute("orderAndSalesPerMonthErrorMessageList");
  if (null != orderAndSalesPerMonthErrorMessageList) {
    for (String orderAndSalesPerMonthErrorMessage : orderAndSalesPerMonthErrorMessageList) {
      errorMessageList.add(orderAndSalesPerMonthErrorMessage);
    }
  }
} catch (Exception err) {
  try {
    errorMessageList.add("例外発生（グラフエラー設定部）（" + err.getMessage() + "）");
  } catch (Exception err_2) {}
}
%>
        </td>
      </tr>
  </table>
<%
  }
%>

  <br>
<%
  //共通モジュールに渡すエラーリストをリクエストスコープにセット
  request.setAttribute("errorMessageList", errorMessageList);
%>
  <jsp:include page="include_error_message.jsp" flush="true"/>
</body>
</html>
