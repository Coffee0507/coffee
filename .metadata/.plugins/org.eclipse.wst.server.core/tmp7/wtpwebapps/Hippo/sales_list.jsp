<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="java.time.ZoneId"%>
<%@ page import="java.time.LocalDate"%>
<%@ page import="jp.co.lsij.p16590004.common.ScopeNameConstants"%>
<%@ page import="jp.co.lsij.p16590004.common.UWConstants"%>
<%@ page import="jp.co.lsij.p16590004.common.Error" %>
<%@ page import="jp.co.lsij.p16590004.e_77.model.master.beans.SortBean" %>
<%@ page import="jp.co.lsij.p16590004.e_77.model.master.beans.PageBean" %>
<%@ page import="jp.co.lsij.p16590004.e_77.model.sales.beans.SalesBean"%>
<%@ page import="jp.co.lsij.p16590004.e_77.model.sales.beans.AddProjNumBean" %>
<%@ page import="jp.co.lsij.p16590004.e_77.model.sales.beans.SearchCondForSalesBean"%>
<%@ page import="jp.co.lsij.p16590004.e_77.model.sales.beans.SearchDateCondForSalesBean"%>
<%@ page import="jp.co.lsij.p16590004.e_77.model.sales.beans.SearchTextCondForSalesBean"%>
<%@ page import="jp.co.lsij.p16590004.e_77.util.DateHelper"%>
<%@ page import="jp.co.lsij.p16590004.e_77.util.StringHelper"%>
<%@ page import="jp.co.lsij.p16590004.e_77.util.MathHelper"%>

<!DOCTYPE html>
<html lang="ja">
<head>
  <meta charset="UTF-8">
  <meta name="format-detection" content="telephone=no">
  
  <!-- ※順序注意（Normalize.css->p16590004.css->...の順） -->
  <link href="CSS/Normalize.css" rel="stylesheet" type="text/css">
  <link href="CSS/p16590004.css" rel="stylesheet" type="text/css">
  <link href="CSS/sales_list.css" rel="stylesheet" type="text/css">
  <link href="CSS/print.css" rel="stylesheet" type="text/css" media="print">

  <script src="CheckBoxDef.js"></script>
  <script src="displayFrameTitle.js"></script>
  <script src="BrowserBackPrevent.js"></script>
  <script src="ObjUtil.js"></script>
  <script src="CheckboxUtil.js"></script>
  <script src="list.js"></script>
  <script src="TextBoxUtil.js"></script>
  <script src="sales_list.js"></script>
  <script src="Page.js"></script>

  <title>案件一覧</title>

<%!
//JSP内で追加するリクエストスコープ
//req_scope_isInvalidState・・・無効な状態
//OrderCountTotal・・・合計値
//allList・・・全体検索文字列リスト
//generalList・・・汎用検索文字列リスト
//salesList・・・営業検索文字列リスト
//statusList・・・ステータス検索文字列リスト
//categoryList・・・分類検索文字列リスト
//customerList・・・売上先検索文字列リスト
//enduserList・・・エンドユーザー検索文字列リスト
//nowYear・・・現年度（サーバ日時で）
//orderyearList・・・受注月（年）検索値リスト
//salesyearList・・・売上月（年）検索値リスト
//paymentyearList・・・入金月（年）検索値リスト
//ordermonthList・・・受注月（月）検索値リスト
//salesmonthList・・・売上月（月）検索値リスト
//paymentmonthList・・・入金月（月）検索値リスト
//remarksWithBRTag・・・備考改行表示用文字列
%>

<%!
//LocalDateをDateに変換
Date localDateToDate(final LocalDate localDate) {
  return Date.from(localDate.atStartOfDay(ZoneId.systemDefault()).toInstant());
}

//受注月、売上月、入金月の表示形式に変換
String transMonthFormatString(Date dt, int nCurrentYear) {
//  assert(null != dt);
//  assert(0 <= nCurrentYear);
  
  if (null == dt) {
    throw new IllegalArgumentException();
  }
  if (0 > nCurrentYear) {
    throw new IllegalArgumentException();
  }
  String str = null;
  int nYear = DateHelper.dateToYear(dt);
  if (nYear == nCurrentYear) {
  //同年度の場合
    int nMonth = DateHelper.getFieldFromDate(dt, Calendar.MONTH);
    str = StringHelper.valueOf(nMonth);
  } else {
    str = StringHelper.valueOf(nYear) + "年度";
  }
  return str;
}
%>

<%
  //無効な状態
  boolean isInvalidState = false;//不要かも

  //例外処理をまとめるのに使用
  List<String> errorMessageList = new ArrayList<String>();
%>

</head>
<body>
<%
//---合計表示処理用---
List<SalesBean> salesBeanList = null;
long lSumValueOfOrder = 0;
try {
  salesBeanList = (List<SalesBean>)request.getAttribute(UWConstants.SCOPE_UW_DATA_LIST);//"uwDataList"
  if (null == salesBeanList) {
    isInvalidState = true;
    errorMessageList.add("uwDataList == null");
  } else {
    for (SalesBean salesBean : salesBeanList) {
      long lValueOfOrder = salesBean.getValueOfOrder();
      try {
        lSumValueOfOrder = MathHelper.safeAdd(lSumValueOfOrder, lValueOfOrder);
      } catch (ArithmeticException err) {
        lSumValueOfOrder = Long.MAX_VALUE;
        break;
      }
    }
  }
} catch (Exception err) {
  isInvalidState = true;
  errorMessageList.add("合計値算出処理エラー（" + err.toString() + "）");
}
if (false == isInvalidState) {
  request.setAttribute("OrderCountTotal", lSumValueOfOrder);
}

//---検索条件表示処理用---
SearchCondForSalesBean searchCondForSalesBean = null;
try{
  //全体用のリスト
  List<String> allList = new ArrayList<String>();
  //汎用項目用のリスト
  List<String> generalList = new ArrayList<String>();
  //営業用のリスト
  List<String> salesList = new ArrayList<String>();
  //ステータス用のリスト
  List<String> statusList = new ArrayList<String>();
  //分類用のリスト
  List<String> categoryList = new ArrayList<String>();
  //売上先用のリスト
  List<String> customerList = new ArrayList<String>();
  //エンドユーザー用のリスト
  List<String> enduserList = new ArrayList<String>();

  searchCondForSalesBean = (SearchCondForSalesBean)request.getAttribute(UWConstants.SCOPE_SEARCH_UW);//"uwSearch"
  if (null == searchCondForSalesBean) {
    isInvalidState = true;
    errorMessageList.add("uwSearch==null");
  } else {
    List<SearchTextCondForSalesBean> searchTextCondlist = searchCondForSalesBean.getSearchTextCondForSalesList();
    if (null == searchTextCondlist) {
      isInvalidState = true;
      errorMessageList.add("searchTextCondlist==null");
    } else {
      for (SearchTextCondForSalesBean searchTextCondForSalesBean : searchTextCondlist) {
        int nTargetType = searchTextCondForSalesBean.getTargetType();
        String strTextCond = searchTextCondForSalesBean.getCond();
        if (SearchTextCondForSalesBean.TARGET_TYPE_OF_ALL == nTargetType) {
          allList.add(strTextCond);
        } else if (SearchTextCondForSalesBean.TARGET_TYPE_OF_GENERAL_WORDS == nTargetType) {
          generalList.add(strTextCond);
        } else if (SearchTextCondForSalesBean.TARGET_TYPE_OF_SALES_STAFF == nTargetType) {
          salesList.add(strTextCond);
        } else if (SearchTextCondForSalesBean.TARGET_TYPE_OF_SALES_STATUS == nTargetType) {
          statusList.add(strTextCond);
        } else if (SearchTextCondForSalesBean.TARGET_TYPE_OF_CATEGORY == nTargetType) {
          categoryList.add(strTextCond);
        } else if (SearchTextCondForSalesBean.TARGET_TYPE_OF_CUSTOMER == nTargetType) {
          customerList.add(strTextCond);
        } else if (SearchTextCondForSalesBean.TARGET_TYPE_OF_END_USER == nTargetType) {
          enduserList.add(strTextCond);
        }
      }
    }
  }
  request.setAttribute("allList", allList);
  request.setAttribute("generalList", generalList);
  request.setAttribute("salesList", salesList);
  request.setAttribute("statusList", statusList);
  request.setAttribute("categoryList", categoryList);
  request.setAttribute("customerList", customerList);
  request.setAttribute("enduserList", enduserList);
} catch (Exception err) {
  isInvalidState = true;
  errorMessageList.add("検索テキスト条件表示処理エラー（" + err.toString() + "）");
}

try{
  //年度のリスト
  List<Integer> orderyearList = new ArrayList<Integer>();
  List<Integer> salesyearList = new ArrayList<Integer>();
  List<Integer> paymentyearList = new ArrayList<Integer>();
  //月のリスト
  List<Integer> ordermonthList = new ArrayList<Integer>();
  List<Integer> salesmonthList = new ArrayList<Integer>();
  List<Integer> paymentmonthList = new ArrayList<Integer>();

  if (null != searchCondForSalesBean) {
    LocalDate nowDate = (LocalDate)request.getAttribute(ScopeNameConstants.SCOPE_DATE_TODAY);//"dateToday"・
    int nowYear = DateHelper.dateToYear(localDateToDate(nowDate));
    request.setAttribute("nowYear",nowYear);

    List<SearchDateCondForSalesBean> searchDateCondlist = searchCondForSalesBean.getSearchDateCondForSalesList();
    if (null == searchDateCondlist) {
      isInvalidState = true;
      errorMessageList.add("searchDateCondlist==null");
    } else {
      for (SearchDateCondForSalesBean searchDateCondForSalesBean : searchDateCondlist) {
        int nTargetType = searchDateCondForSalesBean.getTargetType();
        Date dtDateCond = searchDateCondForSalesBean.getDateVal();
        int nYear = DateHelper.dateToYear(dtDateCond);
        int nMonth = DateHelper.getFieldFromDate(dtDateCond, (int)Calendar.MONTH);

        if (SearchDateCondForSalesBean.TARGET_TYPE_OF_DATE_OF_ORDERS == nTargetType) {
          if (-1 == orderyearList.indexOf(nYear)) {
          //重複していない場合
            orderyearList.add(nYear);
          }
          if (-1 == ordermonthList.indexOf(nMonth)) {
            ordermonthList.add(nMonth);
          }
        } else if (SearchDateCondForSalesBean.TARGET_TYPE_OF_DATE_OF_SALES == nTargetType) {
          if (-1 == salesyearList.indexOf(nYear)) {
            salesyearList.add(nYear);
          }
          if (-1 == salesmonthList.indexOf(nMonth)) {
            salesmonthList.add(nMonth);
          }
        } else if (SearchDateCondForSalesBean.TARGET_TYPE_OF_DAY_OF_PAYMENT == nTargetType) {
          if (-1 == paymentyearList.indexOf(nYear)) {
            paymentyearList.add(nYear);
          }
          if (-1 == paymentmonthList.indexOf(nMonth)) {
            paymentmonthList.add(nMonth);
          }
        }
      }
    }
  }
  request.setAttribute("orderyearList", orderyearList);
  request.setAttribute("salesyearList", salesyearList);
  request.setAttribute("paymentyearList", paymentyearList);
  request.setAttribute("ordermonthList", ordermonthList);
  request.setAttribute("salesmonthList", salesmonthList);
  request.setAttribute("paymentmonthList", paymentmonthList);
} catch (Exception err) {
  isInvalidState = true;
  errorMessageList.add("検索日付条件表示処理エラー（" + err.toString() + "）");
}
%>

  <br>
  <h3 class="page_title">案件一覧</h3>
  <%--エラー表示を行う箇所 --%>
  <c:choose>
    <c:when test="${error.isError}"><p class="error_message noprint"><c:out value="${error.errorInfo}"/></p></c:when>
    <c:otherwise></c:otherwise>
  </c:choose>

    <form id="Mainform" name="Mainform" action="./UWController" method="POST">
    <%--レイアウト調整のためのテーブル --%>
      <table>
        <tr>
          <td>
          <%--新規追加～印刷ボタンまでのレイアウト調整--%>
            <div class="noprint">
              <table>
                <tr>
                  <c:if test="${canEdit}">
                  <%-- 編集権限あり --%>
                    <td>
                      <button type="submit" name="uw_new" onClick="return newSales(this);">新規追加</button>
                    </td>
                    <td>
                      <button type="submit" name="uw_change" onClick="return editSales(this);">変更</button>
                    </td>
                    <td>
                      <button type="submit" name="uw_copy" onClick="return copySales(this);">コピー</button>
                    </td>
                    <td class="print_space">
                      <button type="submit" name="uw_del" onClick="return delSales(this);">削除</button>
                    </td>
                  </c:if>
                  <td>
                    <button type="button" onClick="print()">印刷</button>
                  </td>
                </tr>
              </table>
            </div>
            <table>
              <tr>
                <td class="search_setting_button">
                  <button type="submit" class="noprint" name="uw_search" onClick="return searchSales(this);">検索設定</button>
                </td>
                <td>
                  <table class="noprint">
                    <tr>
                      <%-- 検索条件表示 --%>
                      <td class="search_setting_title">検索条件：</td>
                      <td>
                        <c:if test="${!empty uwSearch}">
                          <c:if test="${!empty allList}">全体 [
                            <c:forEach items="${allList}" var="all">
                              <c:out value="${all}"/>
                            </c:forEach>]　<%-- 意味のある全角なので注意 --%>
                          </c:if>
                          <c:if test="${!empty generalList}">汎用項目 [
                            <c:forEach items="${generalList}" var="general">
                              <c:out value="${general}"/>
                            </c:forEach>]　<%-- 意味のある全角なので注意 --%>
                          </c:if>
                          <c:if test="${!empty salesList}">営業 [
                            <c:forEach items="${salesList}" var="sales" varStatus="salesLoop">
                              <c:if test="${salesLoop.first eq false}">,</c:if>
                              <c:out value="${sales}"/>
                            </c:forEach>]　<%-- 意味のある全角なので注意 --%>
                          </c:if>
                          <c:if test="${!empty statusList}">ステータス [
                            <c:forEach items="${statusList}" var="status" varStatus="statusLoop">
                              <c:if test="${statusLoop.first eq false}">,</c:if>
                              <c:out value="${status}"/>
                            </c:forEach>]　<%-- 意味のある全角なので注意 --%>
                          </c:if>
                          <c:if test="${!empty categoryList}">分類 [
                            <c:forEach items="${categoryList}" var="category" varStatus="categoryLoop">
                              <c:if test="${categoryLoop.first eq false}">,</c:if>
                              <c:out value="${category}"/>
                            </c:forEach>]　<%-- 意味のある全角なので注意 --%>
                          </c:if>
                          <c:if test="${!empty customerList}">売上先 [
                            <c:forEach items="${customerList}" var="customer" varStatus="customerLoop">
                              <c:if test="${customerLoop.first eq false}">,</c:if>
                              <c:out value="${customer}"/>
                            </c:forEach>]　<%-- 意味のある全角なので注意 --%>
                          </c:if>
                          <c:if test="${!empty enduserList}">エンドユーザー [
                            <c:forEach items="${enduserList}" var="enduser" varStatus="enduserLoop">
                              <c:if test="${enduserLoop.first eq false}">,</c:if>
                              <c:out value="${enduser}"/>
                            </c:forEach>]　<%-- 意味のある全角なので注意 --%>
                          </c:if>
                          <c:if test="${!empty orderyearList}">受注月 [
                            <c:forEach items="${orderyearList}" var="orderyear" varStatus="orderyearhLoop">
                              <c:if test="${orderyearhLoop.first eq false}">,</c:if>
                              ${orderyear}年度
                            </c:forEach>　<%-- 意味のある全角なので注意 --%>
                            <c:forEach items="${ordermonthList}" var="ordermonth" varStatus="salesLoop">
                              <c:if test="${orderyearhLoop.first eq false}">,</c:if>
                              ${ordermonth}月
                            </c:forEach>]　<%-- 意味のある全角なので注意 --%>
                          </c:if>
                          <c:if test="${!empty salesyearList}">売上月 [
                            <c:forEach items="${salesyearList}" var="salesyear" varStatus="salesyearLoop">
                              <c:if test="${salesyearLoop.first eq false}">,</c:if>
                              ${salesyear}年度
                            </c:forEach>　<%-- 意味のある全角なので注意 --%>
                            <c:forEach items="${salesmonthList}" var="salesmonth" varStatus="salesmonthLoop">
                              <c:if test="${salesmonthLoop.first eq false}">,</c:if>
                              ${salesmonth}月
                            </c:forEach>]　<%-- 意味のある全角なので注意 --%>
                          </c:if>
                          <c:if test="${!empty paymentyearList}">入金月 [
                            <c:forEach items="${paymentyearList}" var="paymentyear" varStatus="paymentyearLoop">
                              <c:if test="${paymentyearLoop.first eq false}">,</c:if>
                              ${paymentyear}年度
                            </c:forEach>
                            <c:forEach items="${paymentmonthList}" var="paymentmonth" varStatus="paymentmonthLoop">
                              <c:if test="${paymentyearLoop.first eq false}">,</c:if>
                              ${paymentmonth}月
                            </c:forEach>]　<%-- 意味のある全角なので注意 --%>
                          </c:if>
                        </c:if>
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
              
              
              <tr>
                <td></td>
                <%-- 金額合計表示 --%>
                <td>
                  <table border="0">
                    <tr>
                      <td class="search_setting_title">金額合計：</td>
                      <td>
                        <fmt:formatNumber value="${OrderCountTotal}" groupingUsed="true"/>円
                      </td>
                    </tr>
                  </table>
                </td>
              </tr>
            </table>
          </td>
        </tr>
        
        
        <tr>
          <td>
            <%--表の表示を行う箇所 --%>
            <table  class="sales_list_table">
              <tr>
                <c:if test="${canEdit}">
                  <th class="checkbox_area noprint"><%-- checkbox->checkbox_area にクラス名を変更 --%>
                    <input type="checkbox" id="all" class="noprint" name="all" onClick="checkbox_ctrlAllcheckbox();"/>
                  </th>
                </c:if>
                <th class="proj_num">P番</th>
                <th class="cat">分類</th>
                <th class="sales">営業</th>
                <th class="status">ステータス</th>
                <th class="pname">プロジェクト名</th>
                <th class="customer">売上先</th>
                <th class="enduser">エンドユーザー</th>
                <th class="ordermoney">受注金額</th>
                <th class="ordermonth">受注月</th>
                <th class="salesmonth">売上月</th>
                <th class="paymentmonth">入金月</th>
                <th class="generalwords">汎用</th>
                <th class="remarks">備考</th>
                <%-- <th>登録者</th>--%>
                <%--<th>更新者</th>--%>
              </tr>
              <c:forEach items="${uwDataList}" var="sales">
              <tr>
                <c:if test="${canEdit}">
                  <td class="checkbox_area noprint"><%-- checkbox->checkbox_area にクラス名を変更 --%>
                    <input type="checkbox" id="content" class="noprint" name="content" value="${sales.id}" onClick="checkbox_ctrlTopcheckbox();"/>
                  </td>
                </c:if>
              
                <%-- P番 --%>
                <td class="proj_num">${sales.projNum}
<% 
try {
  //タグライブラリに設定されている"sales"の内容を取得
  //※上記で設定している
  SalesBean salesbean = (SalesBean)pageContext.getAttribute("sales");
  List<AddProjNumBean> addprojnumbeanlist = salesbean.getAddProjNumList();
  for (AddProjNumBean addProj : addprojnumbeanlist) {
    out.println("<br>");
    String pnum = addProj.getProjNum();
    out.print(pnum);
  }
} catch (Exception err) {
  errorMessageList.add("子Ｐ番表示処理エラー（" + err.toString() + "）");
}
%>
                </td>
                <%-- 分類 --%>
                <td class="cat"><c:out value="${sales.catName}"/></td>
                <%-- 営業 --%>
                <td class="sales"><c:out value="${sales.salesStaffName}"/></td>
                <%-- ステータス --%>
                <td  class="status"><c:out value="${sales.salesStatusName}"/></td>
                <%-- プロジェクト名 --%>
                <td class="pname"><c:out value="${sales.projName}"/></td>
                <%-- 売上先 --%>
                <td class="customer"><c:out value="${sales.customerName}"/></td>
                <%-- エンドユーザー --%>
                <td class="enduser"><c:out value="${sales.endUserName}"/></td>
                <%-- 受注金額 --%>
                <td class="ordermoney"><fmt:formatNumber value="${sales.valueOfOrder}" groupingUsed="true"/>円</td>
                <%-- 受注月 --%>
                <td class="ordermonth">
<% 
try {
  SalesBean salesbean = (SalesBean)pageContext.getAttribute("sales");
  int nCurrentYear = (int)request.getAttribute("nowYear");

  Date dtDateOfOrders = salesbean.getDateOfOrders();
  if (null != dtDateOfOrders) {
    out.println(transMonthFormatString(dtDateOfOrders, nCurrentYear));
  }
} catch (Exception err) {
  errorMessageList.add("受注月表示処理エラー（" + err.toString() + "）");
}
%>
                </td>
                <%-- 売上月 --%>
                <td class="salesmonth">
<%
try {
  SalesBean salesbean = (SalesBean)pageContext.getAttribute("sales");
  int nCurrentYear = (int)request.getAttribute("nowYear");

  Date dtDateOfSales = salesbean.getDateOfSales();
  if (null != dtDateOfSales) {
    out.println(transMonthFormatString(dtDateOfSales, nCurrentYear));
  }
} catch (Exception err) {
  errorMessageList.add("売上月表示処理エラー（" + err.toString() + "）");
}
%>
                </td>
                <%-- 入金月 --%>
                <td class="paymentmonth">
<%
try {
  SalesBean salesbean = (SalesBean)pageContext.getAttribute("sales");
  int nCurrentYear = (int)request.getAttribute("nowYear");

  Date dtDateOfPayment = salesbean.getDayOfPayment();
  if (null != dtDateOfPayment) {
    out.println(transMonthFormatString(dtDateOfPayment, nCurrentYear));
  }
} catch (Exception err) {
  errorMessageList.add("入金月表示処理エラー（" + err.toString() + "）");
}
%>
                </td>
                <%-- 汎用 --%>
                <td class="generalwords"><c:out value="${sales.generalWords}"/></td>
                <%-- 備考 --%>
<%
//---備考の改行コードを<BR>に置換---
/*
try {
  SalesBean salesbean = (SalesBean)pageContext.getAttribute("sales");
  String strRemarks = salesbean.getRemarks();
  String strRemarksWithBRTag = strRemarks.replace(System.getProperty("line.separator"), "<br>");
  request.setAttribute("remarksWithBRTag", strRemarksWithBRTag);
} catch (Exception err) {
  errorMessageList.add("備考処理エラー（" + err.toString() + "）");
}
*/
%>
                <td class="remarks"><pre class="reset_style pre_remarks"><c:out value="${sales.remarks}"/></pre></td>
<%--改行されない
                <td class="remarks"><c:out value="${remarksWithBRTag}"/></td>
--%>
<%--
                <td class="remarks">${sales.remarks}</td>
--%>
              </tr>
              </c:forEach>
            </table>

            <%-- コントローラに渡すアクション情報を設定する(name="action" value="xxx") --%>
            <input type="hidden" id="sales_action_ctrl_id" name="action" value="" class="hidden_action_param">
          
            <%--レイアウト調整 --%>
          </td>
        </tr>
        
        <tr>
          <td>
            <div class="page_portion noprint"> 
              <jsp:include page="include_page_info.jsp" flush="true">
                <jsp:param name="forward_action" value="sales_list_next" />
                <jsp:param name="back_action" value="sales_list_back" />
			  </jsp:include>
            </div>
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
