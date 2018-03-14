<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="jp.co.lsij.p16590004.common.UWConstants"%>
<%@ page import="jp.co.lsij.p16590004.e_77.model.sales.beans.SearchContentsForSalesBean"%>
<%@ page import="jp.co.lsij.p16590004.e_77.model.sales.beans.SearchCondForSalesBean"%>
<%@ page import="jp.co.lsij.p16590004.e_77.model.sales.beans.SearchTextCondForSalesBean" %>
<%@ page import="jp.co.lsij.p16590004.e_77.model.sales.beans.SearchDateCondForSalesBean" %>
<%@ page import="jp.co.lsij.p16590004.e_77.util.DateHelper" %>
<!DOCTYPE html>
<html lang="ja">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name="format-detection" content="telephone=no">

  <!-- ※順序注意（Normalize.css->p16590004.css->...の順） -->
  <link href="CSS/Normalize.css" rel="stylesheet" type="text/css">
  <link href="CSS/p16590004.css" rel="stylesheet" type="text/css">
  <link href="CSS/sales_search.css" rel="stylesheet" type="text/css">

  <script src="displayFrameTitle.js"></script>
  <script src="BrowserBackPrevent.js"></script>
  <script src="ObjUtil.js"></script>
  <script src="button_util.js"></script>
  <script src="sales_search.js"></script>

  <title>案件検索設定</title>

<%
  //無効な状態
  boolean isInvalidState = false;//不要かも

  //例外処理をまとめるのに使用
  List<String> errorMessageList = new ArrayList<String>();
%>

</head>
<body>
<%
//---表示用情報を設定---
try {
  SearchContentsForSalesBean searchContentsForSales =
        (SearchContentsForSalesBean)request.getAttribute(UWConstants.SCOPE_UW_SEARCH_OPTION);//"uwSearchOption"
  if (null == searchContentsForSales) {
    isInvalidState = true;
    errorMessageList.add("uwSearchOption==null");
  } else {
    //営業担当
    request.setAttribute("salesStaffNameList", searchContentsForSales.getSalesStaffNameList());
    //ステータス
    request.setAttribute("salesStatusNameList", searchContentsForSales.getSalesStatusNameList());
    //分類
    request.setAttribute("categoryNameList", searchContentsForSales.getCategoryNameList());
    //売上先
    request.setAttribute("customerNameList", searchContentsForSales.getCustomerNameList());
    //エンドユーザー
    request.setAttribute("endUserNameList", searchContentsForSales.getEndUserNameList());
    //受注月（年度）
    request.setAttribute("dateOfOrdersList", searchContentsForSales.getDateOfOrdersList());
    //売上月（年度）
    request.setAttribute("dateOfSalesList", searchContentsForSales.getDateOfSalesList());
    //入金月（年度）
    request.setAttribute("dayOfPaymentList", searchContentsForSales.getDayOfPaymentList());
    //月リスト
    List<Integer> defaultmonthList = new ArrayList<Integer>();
    int[] arryMonth = {4, 5, 6, 7, 8, 9, 10, 11, 12, 1, 2, 3};
    for (int nMonth : arryMonth) {
      defaultmonthList.add(nMonth);
    }
    request.setAttribute("defaultmonthList", defaultmonthList);
  }
} catch (Exception err) {
  isInvalidState = true;
  errorMessageList.add("検索条件処理エラー（" + err.toString() + "）");
}

//---前回検索用情報を設定---
SearchCondForSalesBean searchCondForSalesBean = null;
try {
  //営業
  List<String> selectStaffList = new ArrayList<String>();
  //ステータス
  List<String> selectStatusList = new ArrayList<String>();
  //分類
  List<String> selectCategoryList = new ArrayList<String>();
  //売上先
  List<String> selectCustomerList = new ArrayList<String>();
  //エンドユーザー
  List<String> selectEndUserList = new ArrayList<String>();
  
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
          request.setAttribute("all", strTextCond);
        } else if (SearchTextCondForSalesBean.TARGET_TYPE_OF_GENERAL_WORDS == nTargetType) {
          request.setAttribute("general", strTextCond);
        } else if (SearchTextCondForSalesBean.TARGET_TYPE_OF_SALES_STAFF == nTargetType) {
          selectStaffList.add(strTextCond);
        } else if (SearchTextCondForSalesBean.TARGET_TYPE_OF_SALES_STATUS == nTargetType) {
          selectStatusList.add(strTextCond);
        } else if (SearchTextCondForSalesBean.TARGET_TYPE_OF_CATEGORY == nTargetType) {
          selectCategoryList.add(strTextCond);
        } else if (SearchTextCondForSalesBean.TARGET_TYPE_OF_CUSTOMER == nTargetType) {
          selectCustomerList.add(strTextCond);
        } else if (SearchTextCondForSalesBean.TARGET_TYPE_OF_END_USER == nTargetType) {
          selectEndUserList.add(strTextCond);
        }
      }
    }
  }
  request.setAttribute("selectStaffList", selectStaffList);
  request.setAttribute("selectStatusList", selectStatusList);
  request.setAttribute("selectCategoryList", selectCategoryList);
  request.setAttribute("selectCustomerList", selectCustomerList);
  request.setAttribute("selectEndUserList", selectEndUserList);
} catch (Exception err) {
  isInvalidState = true;
  errorMessageList.add("前回検索テキスト条件処理エラー（" + err.toString() + "）");
}

try {
  //受注月
  List<Integer> selectOrderYearList = new ArrayList<Integer>();
  List<Integer> selectOrderMonthList = new ArrayList<Integer>();
  //売上月
  List<Integer> selectSalesYearList = new ArrayList<Integer>();
  List<Integer> selectSalesMonthList = new ArrayList<Integer>();
  //入金月
  List<Integer> selectPaymentYearList = new ArrayList<Integer>();
  List<Integer> selectPaymentMonthList = new ArrayList<Integer>();
  
  if (null != searchCondForSalesBean) {
    List<SearchDateCondForSalesBean> searchDateCondlist = searchCondForSalesBean.getSearchDateCondForSalesList();
    if (null == searchDateCondlist) {
      isInvalidState = true;
      errorMessageList.add("searchDateCondlist==null");
    } else {
      for (SearchDateCondForSalesBean searchDateCondForSalesBean : searchDateCondlist) {
        int nTargetType= searchDateCondForSalesBean.getTargetType();
        Date dtDateCond = searchDateCondForSalesBean.getDateVal();
        int nYear = DateHelper.dateToYear(dtDateCond);
        int nMonth = DateHelper.getFieldFromDate(dtDateCond, Calendar.MONTH);

        if (SearchDateCondForSalesBean.TARGET_TYPE_OF_DATE_OF_ORDERS == nTargetType) {
        //受注月
          if (-1 == selectOrderYearList.indexOf(nYear)) {
          //重複していない場合
            selectOrderYearList.add(nYear);
          }
          if (-1 == selectOrderMonthList.indexOf(nMonth)) {
            selectOrderMonthList.add(nMonth);
          }
        } else if (SearchDateCondForSalesBean.TARGET_TYPE_OF_DATE_OF_SALES == nTargetType) {
        //売上月
          if (-1 == selectSalesYearList.indexOf(nYear)) {
            selectSalesYearList.add(nYear);
          }
          if (-1 == selectSalesMonthList.indexOf(nMonth)) {
            selectSalesMonthList.add(nMonth);
          }
        } else if (SearchDateCondForSalesBean.TARGET_TYPE_OF_DAY_OF_PAYMENT == nTargetType) {
        //入金月
          if (-1 == selectPaymentYearList.indexOf(nYear)) {
            selectPaymentYearList.add(nYear);
          }
          if (-1 == selectPaymentMonthList.indexOf(nMonth)) {
            selectPaymentMonthList.add(nMonth);
          }
        }
      }
    }
  }
  request.setAttribute("selectOrderYearList", selectOrderYearList);
  request.setAttribute("selectOrderMonthList", selectOrderMonthList);
  request.setAttribute("selectSalesYearList", selectSalesYearList);
  request.setAttribute("selectSalesMonthList", selectSalesMonthList);
  request.setAttribute("selectPaymentYearList", selectPaymentYearList);
  request.setAttribute("selectPaymentMonthList", selectPaymentMonthList);
} catch (Exception err) {
  isInvalidState = true;
  errorMessageList.add("前回検索日付条件処理エラー（" + err.toString() + "）");
}
%>

  <h3 class="page_title">案件検索設定</h3>
  <%--エラー表示を行う箇所 --%>
  <c:choose>
    <c:when test="${error.isError}"><p class="error_message"><c:out value="${error.errorInfo}"/></p></c:when>
    <c:otherwise></c:otherwise>
  </c:choose>

  <form id="Mainform" action="./UWController" method="POST">
    <%--レイアウト調整 一番外側 --%>
    <table>
      <tr>
        <td>
          <table class="search_title">
            <tr>
              <th>ソート：</th>
              <td>
                <select id="uw_s_sort_sec_id" class="search_sort_select" name="uw_s_sort_sec">
                  <c:choose>
                    <c:when test="${error.isError}">uwSearchMap
                      <option value="uw_sort_pnum" <c:if test="${uwSearchMap.uw_s_sort_sec[0] eq 'uw_sort_pnum'}"> selected="selected"</c:if>>P番</option>
                      <option value="uw_sort_type" <c:if test="${uwSearchMap.uw_s_sort_sec[0] eq 'uw_sort_type'}"> selected="selected"</c:if>>分類</option>
                      <option value="uw_sort_sales" <c:if test="${uwSearchMap.uw_s_sort_sec[0] eq 'uw_sort_sales'}"> selected="selected"</c:if>>営業</option>
                      <option value="uw_sort_status" <c:if test="${uwSearchMap.uw_s_sort_sec[0] eq 'uw_sort_status'}"> selected="selected"</c:if>>ステータス</option>
                      <option value="uw_sort_pname" <c:if test="${uwSearchMap.uw_s_sort_sec[0] eq 'uw_sort_pname'}"> selected="selected"</c:if>>プロジェクト名</option>
                      <option value="uw_sort_cus" <c:if test="${uwSearchMap.uw_s_sort_sec[0] eq 'uw_sort_cus'}"> selected="selected"</c:if>>売上先</option>
                      <option value="uw_sort_enduser" <c:if test="${uwSearchMap.uw_s_sort_sec[0] eq 'uw_sort_enduser'}"> selected="selected"</c:if>>エンドユーザー</option>
                      <option value="uw_sort_ordermoney" <c:if test="${uwSearchMap.uw_s_sort_sec[0] eq 'uw_sort_ordermoney'}"> selected="selected"</c:if>>受注金額</option>
                      <option value="uw_sort_ordermonth" <c:if test="${uwSearchMap.uw_s_sort_sec[0] eq 'uw_sort_ordermonth'}"> selected="selected"</c:if>>受注月</option>
                      <option value="uw_sort_salesmonth" <c:if test="${uwSearchMap.uw_s_sort_sec[0] eq 'uw_sort_salesmonth'}"> selected="selected"</c:if>>売上月</option>
                      <option value="uw_sort_paymonth" <c:if test="${uwSearchMap.uw_s_sort_sec[0] eq 'uw_sort_paymonth'}"> selected="selected"</c:if>>入金月</option>
                    </c:when>
                    <c:otherwise>
                      <option value="uw_sort_pnum" <c:if test="${uwSearch.sortName eq 'uw_sort_pnum'}"> selected="selected"</c:if>>P番</option>
                      <option value="uw_sort_type" <c:if test="${uwSearch.sortName eq 'uw_sort_type'}"> selected="selected"</c:if>>分類</option>
                      <option value="uw_sort_sales" <c:if test="${uwSearch.sortName eq 'uw_sort_sales'}"> selected="selected"</c:if>>営業</option>
                      <option value="uw_sort_status" <c:if test="${uwSearch.sortName eq 'uw_sort_status'}"> selected="selected"</c:if>>ステータス</option>
                      <option value="uw_sort_pname" <c:if test="${uwSearch.sortName eq 'uw_sort_pname'}"> selected="selected"</c:if>>プロジェクト名</option>
                      <option value="uw_sort_cus" <c:if test="${uwSearch.sortName eq 'uw_sort_cus'}"> selected="selected"</c:if>>売上先</option>
                      <option value="uw_sort_enduser" <c:if test="${uwSearch.sortName eq 'uw_sort_enduser'}"> selected="selected"</c:if>>エンドユーザー</option>
                      <option value="uw_sort_ordermoney" <c:if test="${uwSearch.sortName eq 'uw_sort_ordermoney'}"> selected="selected"</c:if>>受注金額</option>
                      <option value="uw_sort_ordermonth" <c:if test="${uwSearch.sortName eq 'uw_sort_ordermonth'}"> selected="selected"</c:if>>受注月</option>
                      <option value="uw_sort_salesmonth" <c:if test="${uwSearch.sortName eq 'uw_sort_salesmonth'}"> selected="selected"</c:if>>売上月</option>
                      <option value="uw_sort_paymonth" <c:if test="${uwSearch.sortName eq 'uw_sort_paymonth'}"> selected="selected"</c:if>>入金月</option>
                    </c:otherwise>
                  </c:choose>
                </select>
                <select id="uw_s_sort_order_id" name="uw_s_sort_order">
                  <c:choose>
                    <c:when test="${error.isError}">
                      <option value="asc" <c:if test="${uwSearchMap.uw_s_sort_order[0] eq 'asc'}"> selected="selected"</c:if>>昇順</option>
                      <option value="desc" <c:if test="${uwSearchMap.uw_s_sort_order[0] eq 'desc'}"> selected="selected"</c:if>>降順</option>
                    </c:when>
                    <c:otherwise>
                      <option value="asc" <c:if test="${uwSearch.ascSort eq 'asc'}"> selected="selected"</c:if>>昇順</option>
                      <option value="desc" <c:if test="${uwSearch.ascSort eq 'desc'}"> selected="selected"</c:if>>降順</option>
                    </c:otherwise>
                  </c:choose>
                </select>
              </td>
            </tr>
            
            <tr>
              <th>全体：</th>
              <td>
                <input type="text" class="search_text" name="uw_s_all" 
                <c:choose>
                  <c:when test="${error.isError}">
                    value="<c:out value="${uwSearchMap.uw_s_all[0]}"/>"
                  </c:when>
                  <c:otherwise>value="<c:out value="${all}"/>"</c:otherwise>
                </c:choose>
                > <%-- inputタグの閉じのため消さない --%>
              </td>
            </tr>
            <tr>
              <th>汎用項目：</th>
              <td>
                <input type="text" class="search_text" name="uw_s_general_sec" 
                <c:choose>
                  <c:when test="${error.isError}">
                    value="<c:out value="${uwSearchMap.uw_s_general_sec[0]}"/>"
                  </c:when>
                  <c:otherwise>value="<c:out value="${general}"/>"</c:otherwise>
                </c:choose>
                > <%-- inputタグの閉じのため消さない --%>
              </td>
            </tr>
          </table>
        </td>
      </tr>
      
      <%--レイアウト調整 --%>
      <tr>
        <td>
        
          <%--画面中部レイアウト調整用 --%>
          <table>
            <tr class="main_select">
              <td>
                <table class="sales_search_table">
                  <tr>
                    <th>営業</th>
                  </tr>
                  <tr>
                    <td>
                      <select id="uw_s_sales_id" class="sales_user" name="uw_s_sales" multiple>
<%--
                      <select id="uw_s_sales_id" class="sales_user" name="uw_s_sales" size="19" multiple>
 --%>
                      <c:forEach items="${salesStaffNameList}" var="salesStaffName">
                        <option value="<c:out value="${salesStaffName}"/>" 
                        <c:choose>
                          <c:when test="${error.isError}">
                            <%-- <c:forEach items="${uwSearchMap.uw_s_sales}" var="selectStaff"> --%>
                            <c:forEach items="${uwSearchMap['uw_s_sales']}" var="selectStaff">
                              <c:if test="${salesStaffName eq selectStaff}">selected</c:if>
                            </c:forEach>
                          </c:when>
                          <c:otherwise>
                            <c:forEach items="${selectStaffList}" var="selectStaff">
                              <c:if test="${salesStaffName eq selectStaff}">selected</c:if>
                            </c:forEach>
                          </c:otherwise>
                        </c:choose>
                        ><c:out value="${salesStaffName}"/></option>
                      </c:forEach>
                      </select>
                    </td>
                  </tr>
                </table>

              </td>
              <%--画面中部 レイアウト調整 --%>
              <td>

                <table class="sales_search_table">
                  <tr>
                    <th>ステータス</th>
                  </tr>
                  <tr>
                    <td>
                      <select id="uw_s_status_id" class="status" name="uw_s_status" multiple>
<%--
                      <select id="uw_s_status_id" class="status" name="uw_s_status" size="19" multiple>
--%>
                      <c:forEach items="${salesStatusNameList}" var="salesStatusName">
                        <option value="<c:out value="${salesStatusName}"/>" 
                        <c:choose>
                          <c:when test="${error.isError}">
                            <%-- <c:forEach items="${uwSearchMap.uw_s_status}" var="selectStaff"> --%>
                            <c:forEach items="${uwSearchMap['uw_s_status']}" var="selectStatus">
                              <c:if test="${salesStatusName eq selectStatus}">selected</c:if>
                            </c:forEach>
                          </c:when>
                          <c:otherwise>
                            <c:forEach items="${selectStatusList}" var="selectStatus">
                              <c:if test="${salesStatusName eq selectStatus}">selected</c:if>
                            </c:forEach>
                          </c:otherwise>
                        </c:choose>
                        ><c:out value="${salesStatusName}"/></option>
                      </c:forEach>
                      </select>
                    </td>
                  </tr>
                </table>

              </td>
              <%--画面中部 レイアウト調整 --%>
              <td>

                <table class="sales_search_table">
                  <tr>
                    <th>分類</th>
                  </tr>
                  <tr>
                    <td>
                      <select id="uw_s_type_id" class="cat" name="uw_s_type" multiple>
<%--
                      <select id="uw_s_type_id" class="cat" name="uw_s_type" size="19" multiple>
--%>
                      <c:forEach items="${categoryNameList}" var="categoryName">
                        <option value="<c:out value="${categoryName}"/>" 
                        <c:choose>
                          <c:when test="${error.isError}">
                            <%-- <c:forEach items="${uwSearchMap.uw_s_type}" var="selectCategory"> --%>
                            <c:forEach items="${uwSearchMap['uw_s_type']}" var="selectCategory">
                              <c:if test="${categoryName eq selectCategory}">selected</c:if>
                            </c:forEach>
                          </c:when>
                          <c:otherwise>
                            <c:forEach items="${selectCategoryList}" var="selectCategory">
                              <c:if test="${categoryName eq selectCategory}">selected</c:if>
                            </c:forEach>
                          </c:otherwise>
                        </c:choose>
                        ><c:out value="${categoryName}"/></option>
                      </c:forEach>
                      </select>
                    </td>
                  </tr>
                </table>

              </td>
              <%--画面中部 レイアウト調整 --%>
              <td>

                <table class="sales_search_table">
                  <tr>
                    <th>売上先</th>
                  </tr>
                  <tr>
                    <td>
                      <select id="uw_s_cus_id" class="customer" name="uw_s_cus" multiple>
<%--
                      <select id="uw_s_cus_id" class="customer" name="uw_s_cus" size="19" multiple>
--%>
                      <c:forEach items="${customerNameList}" var="customerName">
                        <option value="<c:out value="${customerName}"/>" 
                        <c:choose>
                          <c:when test="${error.isError}">
                            <%-- <c:forEach items="${uwSearchMap.uw_s_cus}" var="selectCustomer"> --%>
                            <c:forEach items="${uwSearchMap['uw_s_cus']}" var="selectCustomer">
                              <c:if test="${customerName eq selectCustomer}">selected</c:if>
                            </c:forEach>
                          </c:when>
                          <c:otherwise>
                            <c:forEach items="${selectCustomerList}" var="selectCustomer">
                              <c:if test="${customerName eq selectCustomer}">selected</c:if>
                            </c:forEach>
                          </c:otherwise>
                        </c:choose>
                        ><c:out value="${customerName}"/></option>
                      </c:forEach>
                      </select>
                    </td>
                  </tr>
                </table>

              </td>
              <%--画面中部 レイアウト調整 --%>
              <td>

                <table class="sales_search_table">
                  <tr>
                    <th>エンドユーザー</th>
                  </tr>
                  <tr>
                    <td>
                      <select id="uw_s_end_user_id" class="customer" name="uw_s_end_user" multiple >
<%--
                      <select id="uw_s_end_user_id" class="customer" name="uw_s_end_user" size="19" multiple >
--%>
                      <c:forEach items="${endUserNameList}" var="endUserName">
                        <option value="<c:out value="${endUserName}"/>" 
                        <c:choose>
                          <c:when test="${error.isError}">
                            <%-- <c:forEach items="${uwSearchMap.uw_s_end_user}" var="selectEndUser"> --%>
                            <c:forEach items="${uwSearchMap['uw_s_end_user']}" var="selectEndUser">
                              <c:if test="${endUserName eq selectEndUser}">selected</c:if>
                            </c:forEach>
                          </c:when>
                          <c:otherwise>
                            <c:forEach items="${selectEndUserList}" var="selectEndUser">
                              <c:if test="${endUserName eq selectEndUser}">selected</c:if>
                            </c:forEach>
                          </c:otherwise>
                        </c:choose>
                        ><c:out value="${endUserName}"/></option>
                      </c:forEach>
                      </select>
                    </td>
                  </tr>
                </table>

              </td>
              <%--画面中部 レイアウト調整 --%>
              <td>

                <table class="sales_search_table">
                  <tr>
                    <th>受注月</th>
                  </tr>
                  <tr>
                    <td>
                      <select id="uw_s_order_year_id" class="year_month_area" name="uw_s_order_year" multiple >
<%-- 
                      <select id="uw_s_order_year_id" class="year_month_area" name="uw_s_order_year" size="7" multiple >
--%>
                      <c:forEach items="${dateOfOrdersList}" var="dateOfOrders">
                        <option value="${dateOfOrders}" 
                        <c:choose>
                          <c:when test="${error.isError}">
                            <%-- <c:forEach items="${uwSearchMap.uw_s_order_year}" var="selectOrderYear"> --%>
                            <c:forEach items="${uwSearchMap['uw_s_order_year']}" var="selectOrderYear">
                              <c:if test="${dateOfOrders eq selectOrderYear}">selected</c:if>
                            </c:forEach>
                          </c:when>
                          <c:otherwise>
                            <c:forEach items="${selectOrderYearList}" var="selectOrderYear">
                              <c:if test="${dateOfOrders eq selectOrderYear}">selected</c:if>
                            </c:forEach>
                          </c:otherwise>
                        </c:choose>
                        >${dateOfOrders}年度</option>
                      </c:forEach>
                      </select>
                    </td>
                  </tr>

                  <tr>
                    <td>
                      <select id="uw_s_order_month_id" class="month_area" name="uw_s_order_month" multiple >
<%--
                      <select id="uw_s_order_month_id" class="month_area" name="uw_s_order_month" size="12" multiple >
--%>
                      <c:forEach items="${defaultmonthList}" var="defaultmonth">
                        <option value="${defaultmonth}" 
                        <c:choose>
                          <c:when test="${error.isError}">
                            <%-- <c:forEach items="${uwSearchMap.uw_s_order_month}" var="selectOrderMonth"> --%>
                            <c:forEach items="${uwSearchMap['uw_s_order_month']}" var="selectOrderMonth">
                              <c:if test="${defaultmonth eq selectOrderMonth}">selected</c:if>
                            </c:forEach>
                          </c:when>
                          <c:otherwise>
                            <c:forEach items="${selectOrderMonthList}" var="selectOrderMonth">
                              <c:if test="${defaultmonth eq selectOrderMonth}">selected</c:if>
                            </c:forEach>
                          </c:otherwise>
                        </c:choose>
                        >${defaultmonth}月</option>
                      </c:forEach>
                      </select>
                    </td>
                  </tr>
                  <tr class="noborder">
                    <td class="noborder">
                      <input type="button" id="select_order_month_all_id" name="select_order_month_all" value="全選択" onClick="order_month_all_select();" />
                    </td>
                  </tr>
                </table>

              </td>
              <%--画面中部 レイアウト調整 --%>
              <td>

                <table class="sales_search_table">
                  <tr>
                    <th>売上月</th>
                  </tr>
                  <tr>
                    <td>
                      <select id="uw_s_sales_year_id" class="year_month_area" name="uw_s_sales_year" multiple >
<%--
                      <select id="uw_s_sales_year_id" class="year_month_area" name="uw_s_sales_year" size="7" multiple >
--%>
                      <c:forEach items="${dateOfSalesList}" var="dateOfSales">
                        <option value="${dateOfSales}" 
                        <c:choose>
                          <c:when test="${error.isError}">
                            <%-- <c:forEach items="${uwSearchMap.uw_s_sales_year}" var="selectSalesYear"> --%>
                            <c:forEach items="${uwSearchMap['uw_s_sales_year']}" var="selectSalesYear">
                              <c:if test="${dateOfSales eq selectSalesYear}">selected</c:if>
                            </c:forEach>
                          </c:when>
                          <c:otherwise>
                            <c:forEach items="${selectSalesYearList}" var="selectSalesYear">
                              <c:if test="${dateOfSales eq selectSalesYear}">selected</c:if>
                            </c:forEach>
                          </c:otherwise>
                        </c:choose>
                        >${dateOfSales}年度</option>
                      </c:forEach>
                      </select>
                    </td>
                  </tr>
                  <tr>
                    <td>
                      <select id="uw_s_sales_month_id" class="month_area" name="uw_s_sales_month" multiple >
<%-- 
                      <select id="uw_s_sales_month_id" class="month_area" name="uw_s_sales_month" size="12" multiple >
--%>
                      <c:forEach items="${defaultmonthList}" var="defaultmonth">
                        <option value="${defaultmonth}" 
                        <c:choose>
                          <c:when test="${error.isError}">
                            <%-- <c:forEach items="${uwSearchMap.uw_s_sales_month}" var="selectOrderMonth"> --%>
                            <c:forEach items="${uwSearchMap['uw_s_sales_month']}" var="selectSalesMonth">
                              <c:if test="${defaultmonth eq selectSalesMonth}">selected</c:if>
                            </c:forEach>
                          </c:when>
                          <c:otherwise>
                            <c:forEach items="${selectSalesMonthList}" var="selectSalesMonth">
                              <c:if test="${defaultmonth eq selectSalesMonth}">selected</c:if>
                            </c:forEach>
                          </c:otherwise>
                        </c:choose>
                        >${defaultmonth}月</option>
                      </c:forEach>
                      </select>
                    </td>
                  </tr>
                  <tr class="noborder">
                    <td class="noborder">
                      <input type="button" id="select_sales_month_all_id" name="select_sales_month_all" value="全選択" onClick="sales_month_all_select ();" />
                    </td>
                  </tr>
                </table>

              </td>
              <%--画面中部 レイアウト調整 --%>
              <td>

                <table class="sales_search_table">
                  <tr>
                    <th>入金月</th>
                  </tr>
                  <tr>
                    <td>
                      <select id="uw_s_pay_year_id" class="year_month_area" name="uw_s_pay_year" multiple >
<%--
                      <select id="uw_s_pay_year_id" class="year_month_area" name="uw_s_pay_year" size="7" multiple >
--%>
                      <c:forEach items="${dayOfPaymentList}" var="dayOfPayment">
                        <option value="${dayOfPayment}" 
                        <c:choose>
                          <c:when test="${error.isError}">
                            <%-- <c:forEach items="${uwSearchMap.uw_s_pay_year}" var="selectPaymentYear"> --%>
                            <c:forEach items="${uwSearchMap['uw_s_pay_year']}" var="selectPaymentYear">
                              <c:if test="${dayOfPayment eq selectPaymentYear}">selected</c:if>
                            </c:forEach>
                          </c:when>
                          <c:otherwise>
                            <c:forEach items="${selectPaymentYearList}" var="selectPaymentYear">
                              <c:if test="${dayOfPayment eq selectPaymentYear}">selected</c:if>
                            </c:forEach>
                          </c:otherwise>
                        </c:choose>
                        >${dayOfPayment}年度</option>
                      </c:forEach>
                      </select>
                    </td>
                  </tr>
                  <tr>
                    <td>
                      <select id="uw_s_pay_month_id" name="uw_s_pay_month" multiple class="month_area">
<%--
                      <select id="uw_s_pay_month_id" name="uw_s_pay_month" size="12" multiple class="month_area">
--%>
                      <c:forEach items="${defaultmonthList}" var="defaultmonth">
                        <option value="${defaultmonth}" 
                        <c:choose>
                          <c:when test="${error.isError}">
                            <%-- <c:forEach items="${uwSearchMap.uw_s_pay_month}" var="selectPaymentMonth"> --%>
                            <c:forEach items="${uwSearchMap['uw_s_pay_month']}" var="selectPaymentMonth">
                              <c:if test="${defaultmonth eq selectPaymentMonth}">selected</c:if>
                            </c:forEach>
                          </c:when>
                          <c:otherwise>
                            <c:forEach items="${selectPaymentMonthList}" var="selectPaymentMonth">
                              <c:if test="${defaultmonth eq selectPaymentMonth}">selected</c:if>
                            </c:forEach>
                          </c:otherwise>
                        </c:choose>
                        >${defaultmonth}月</option>
                      </c:forEach>
                      </select>
                    </td>
                  </tr>
                  <tr class="noborder">
                    <td class="noborder">
                      <input type="button" id="select_pay_month_all_id" name="select_pay_month_all" value="全選択" onClick="pay_month_all_select ();" />
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
          <div class="sales_search_button">
            <button type="button" value="uw_s_search" onClick="return pushSearchBubbon() && setActionToHidden(this) && submit();">検索</button>
            <button type="button" value="uw_s_return" onClick="return setActionToHidden(this) && submit();">戻る</button>
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