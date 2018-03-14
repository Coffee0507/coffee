<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="jp.co.lsij.p16590004.common.Error" %>
<%@ page import="jp.co.lsij.p16590004.e_77.model.master.beans.SortBean" %>
<%@ page import="jp.co.lsij.p16590004.e_200.model.bean.SearchBean" %>
<%@ page import="jp.co.lsij.p16590004.common.ProjConstants"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="jp.co.lsij.p16590004.e_77.model.master.beans.PageBean" %>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.ArrayList" %>


<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<meta name="format-detection" content="telephone=no">
<title>P番一覧</title>

<%
//例外処理をまとめるのに使用
ArrayList<String> errorMessageList = new ArrayList<String>();
%>

<script src="CheckboxUtil.js"></script>
<script src="CheckBoxDef.js"></script>
<script src="ObjUtil.js"></script>
<script src="InputTextCheck.js"></script>
<script src="InputPatternDef.js"></script>
<script src="BrowserBackPrevent.js"></script>
<script src="LimitDef.js"></script>
<script src="list.js"></script>
<script src="Page.js"></script>
<script src="displayFrameTitle.js"></script>
<script src="JS_LIB/jQuery/jquery-3.2.1.min.js" type="text/javascript"></script>
<!-- bootstrap -->
<link href="JS_LIB/bootstrap/bootstrap.css" type="text/css" rel="stylesheet"></link>
<script src="JS_LIB/bootstrap/bootstrap.js" type="text/javascript"></script>
<!-- bootstrap-datepicker -->
<link href="JS_LIB/bootstrap/bootstrap-datepicker.css" type="text/css" rel="stylesheet"></link>
<script src="JS_LIB/bootstrap/bootstrap-datepicker.js" type="text/javascript"></script>
<!-- 日本語対応用スクリプト -->
<script src="JS_LIB/bootstrap/bootstrap-datepicker.ja.min.js" type="text/javascript"></script>
<%-- <script src="TextBoxUtil.js"></script> --%><%-- Added by dai --%>
<script src="button_util.js"></script>
<%--P番一覧の年度表示、ソート、検索項目の操作を行うファイル --%>
<script src="proj_list.js"></script>
<script src="datepicker-configuration.js"></script>
<link href="CSS/Normalize.css" rel="stylesheet" type="text/css">
<link href="CSS/p16590004.css" rel="stylesheet" type="text/css">
<link href="CSS/print.css" rel="stylesheet" type="text/css" media="print">
<link href="CSS/proj_list.css" rel="stylesheet" type="text/css">

</head>
<body>

<%
try{
	//SearchBean[]の要素数と検索項目から、検索ワードのinput要素の種別を判別、リクエストスコープに保存する
	SearchBean[] projSearch = (SearchBean[])request.getAttribute(ProjConstants.SCOPE_SEARCH_PROJ);
//	SearchBean[] projSearch = (SearchBean[])session.getAttribute(ProjConstants.SCOPE_SEARCH_PROJ);
	//SearchBean[]の要素数を取得
	int lengthOfProjSearch = projSearch.length;//要素数

	//以下で、検索項目の種別(calendar, textbox, radioButton)を判別
	String elementType1 = null;//検索条件1の種別
	String elementType2 = null;//検索条件2の種別
	//検索条件1の種別(要素数が0以外で条件取得可)
	if((lengthOfProjSearch != 0) && (projSearch[0].getSearchCategory().equals("sec_issue"))){
	  elementType1 = "calendar";
	}else if((lengthOfProjSearch != 0) && (projSearch[0].getSearchCategory().equals("sec_assign"))){
	  elementType1 = "radioButton";
	}else{
	  elementType1 = "textbox";
	}
	//検索条件2の種別(要素数が2のときのみ条件取得可)
	if((lengthOfProjSearch == 2) && (projSearch[1].getSearchCategory().equals("sec_issue"))){
	  elementType2 = "calendar";
	}else if((lengthOfProjSearch == 2) && (projSearch[1].getSearchCategory().equals("sec_assign"))){
	  elementType2 = "radioButton";
	}else{
	  elementType2 = "textbox";
	}
	//リクエストスコープに保存
	request.setAttribute("elementType1", elementType1);
	request.setAttribute("elementType2", elementType2);
}catch(Exception e){
  errorMessageList.add("proj_list.jsp:検索条件判別エラー");
}
%>

  <br>
  <h3 class="page_title">P番一覧</h3>

<%--エラー表示を行う箇所 --%>
<c:if test="${error.isError}"><p class="error_message noprint"><c:out value="${error.errorInfo}"/></p></c:if>

   <form name="Mainform" id="Mainform" action="./ProjController" method="POST">
    <%--レイアウト調整のためのテーブル --%>
    <table>
      <tr>
        <td>
          <%--表示年度の箇所のテーブル --%>
          <table class="button_group">
            <tr>
              <td>
                <INPUT type="text" id="p_year" name="p_year" class="search_year_box" value="${fiscalYear}">年度
              </td>
              <td>
                <button type="button" name="p_year_dis" class="noprint" onClick="return proj_search_year(this) && submit()">表示</button>
              </td>
            </tr>
          </table>
          <%--レイアウト調整--%>
        </td>
      </tr>
      <tr>
        <td>
          <%--新規追加～インポートボタンまでのレイアウト調整--%>
          <div class="noprint">
            <table class="button_group">
              <tr>
                <c:if test="${canEdit}">
                <td>
                  <button type="button" name="p_new" onClick="return setActionParam(this) && submit();">新規追加</button>
                </td>
                <td>
                  <button type="button" name="p_change" onClick="return proj_Edit(this) && submit();">変更</button>
                </td>
                <td>
                  <button type="button" name="p_copy" onClick="return proj_Copy(this)  && submit();">再利用</button>
                </td>
                <td class="print_space">
                  <button type="button" name="p_del" onClick="return proj_Del(this) && submit();">削除</button>
                </td>
                </c:if>
                <td>
                  <button type="button" onClick="print()">印刷</button>
                </td>
                <c:if test="${canEdit}">
                <td>
                  <button type="button" name="p_import" onClick="return setActionParam(this) && submit();">インポート</button>
                </td>
                </c:if>
              </tr>
            </table>
          </div>
        <%--レイアウト調整 --%>
        </td>
      </tr>
      <tr>
        <td>
          <%--ソート・検索項目のレイアウト調整 --%>
          <div class="noprint">
            <table>
              <tr>
                <td>ソート：</td>
                <td colspan="2">
                  <select id="p_sort_sec" name="sort_sec">
                    <option value="p_sort_pnum" <c:if test="${projSort.columnName eq 'p_sort_pnum'}"> selected="selected"</c:if>>P番</option>
                    <option value="p_sort_pname" <c:if test="${projSort.columnName eq 'p_sort_pname'}"> selected="selected"</c:if>>プロジェクト名</option>
                    <option value="p_sort_cus" <c:if test="${projSort.columnName eq 'p_sort_cus'}"> selected="selected"</c:if>>売上先</option>
                    <option value="p_sort_sales" <c:if test="${projSort.columnName eq 'p_sort_sales'}"> selected="selected"</c:if>>営業</option>
                    <option value="p_sort_status" <c:if test="${projSort.columnName eq 'p_sort_status'}"> selected="selected"</c:if>>ステータス</option>
                    <option value="p_sort_issue" <c:if test="${projSort.columnName eq 'p_sort_issue'}"> selected="selected"</c:if>>発行日</option>
                    <option value="p_sort_assign" <c:if test="${projSort.columnName eq 'p_sort_assign'}"> selected="selected"</c:if>>メンバーアサイン</option>
                  </select>
                  <select name="sort_order" id="p_sort_order">
                    <option value="asc" <c:if test="${projSort.asc eq 'asc'}"> selected="selected"</c:if>>昇順</option>
                    <option value="desc" <c:if test="${projSort.asc eq 'desc'}"> selected="selected"</c:if>>降順</option>
                  </select>
                </td>
              </tr>
              <tr>
                <td rowspan="2">検索条件：</td>
                <td>
                  <select id="search_sec_1" name="search_sec_1" onChange="changeDisInputBoxType()">
                    <option selected="selected" value="none"></option>
                    <option value="sec_all" <c:if test="${(elementType1 eq 'textbox') and (projSearch[0].searchCategory eq 'sec_all')}"> selected="selected"</c:if>>すべて</option>
                    <option value="sec_pnum" <c:if test="${(elementType1 eq 'textbox') and (projSearch[0].searchCategory eq 'sec_pnum')}"> selected="selected"</c:if>>P番</option>
                    <option value="sec_pname" <c:if test="${(elementType1 eq 'textbox') and (projSearch[0].searchCategory eq 'sec_pname')}"> selected="selected"</c:if>>プロジェクト名</option>
                    <option value="sec_cus" <c:if test="${(elementType1 eq 'textbox') and (projSearch[0].searchCategory eq 'sec_cus')}"> selected="selected"</c:if>>売上先</option>
                    <option value="sec_sales" <c:if test="${(elementType1 eq 'textbox') and (projSearch[0].searchCategory eq 'sec_sales')}"> selected="selected"</c:if>>営業</option>
                    <option value="sec_status" <c:if test="${(elementType1 eq 'textbox') and (projSearch[0].searchCategory eq 'sec_status')}"> selected="selected"</c:if>>ステータス</option>
                    <option value="sec_issue" <c:if test="${elementType1 eq 'calendar'}"> selected="selected"</c:if>>発行日</option>
                    <option value="sec_assign" <c:if test="${elementType1 eq 'radioButton'}"> selected="selected"</c:if>>メンバーアサイン</option>
                  </select>
                </td>
                <td>
                  <%--検索ワード　ラジオボタンのとき--%>
				  <div id="search1_radio" class="assign_length noprint"><%-- 非表示にするときに使用するid--%>
                    <input type="radio" id="assignfin1" name="search_word_radio_1" value="assign_fin"  class="noprint" <c:if test="${(elementType1 eq 'radioButton') and (projSearch[0].searchWord eq 'assign_fin')}">checked</c:if>/>アサイン済
                    <input type="radio" id="assignnotfin1" name="search_word_radio_1" value="assign_not_fin" <c:if test="${(elementType1 ne 'radioButton') or ((elementType1 eq 'radioButton') and (projSearch[0].searchWord ne 'assign_fin'))}">checked</c:if>/>未アサイン
                  </div>
				  <%--検索ワード　カレンダーのとき--%>
                  <input type="text"  class="dp2 noprint monthsize" name="search_word_text_1" id="search_word_date1" readonly
					<c:if test="${elementType1 eq 'calendar'}">value="${projSearch[0].searchWord}"</c:if>
                  />
          		  <%--検索ワード　テキストボックスのとき--%>
                  <input type="text" name="search_word_text_1" id="search_word_text1" class="noprint search_word_text_box"
                      <c:if test="${elementType1 eq 'textbox'}">value="<c:out value="${projSearch[0].searchWord}"/>"</c:if>
                  />
                </td>
              </tr>
              <tr>
                <td>
                  <select id="search_sec_2" name="search_sec_2" onChange="changeDisInputBoxType()">
                    <option selected="selected" value="none"></option>
                    <option value="sec_all" <c:if test="${(elementType2 eq 'textbox') and (projSearch[1].searchCategory eq 'sec_all')}"> selected="selected"</c:if>>すべて</option>
                    <option value="sec_pnum" <c:if test="${(elementType2 eq 'textbox') and (projSearch[1].searchCategory eq 'sec_pnum')}"> selected="selected"</c:if>>P番</option>
                    <option value="sec_pname" <c:if test="${(elementType2 eq 'textbox') and (projSearch[1].searchCategory eq 'sec_pname')}"> selected="selected"</c:if>>プロジェクト名</option>
                    <option value="sec_cus" <c:if test="${(elementType2 eq 'textbox') and (projSearch[1].searchCategory eq 'sec_cus')}"> selected="selected"</c:if>>売上先</option>
                    <option value="sec_sales" <c:if test="${(elementType2 eq 'textbox') and (projSearch[1].searchCategory eq 'sec_sales')}"> selected="selected"</c:if>>営業</option>
                    <option value="sec_status" <c:if test="${(elementType2 eq 'textbox') and (projSearch[1].searchCategory eq 'sec_status')}"> selected="selected"</c:if>>ステータス</option>
                    <option value="sec_issue" <c:if test="${elementType2 eq 'calendar'}"> selected="selected"</c:if>>発行日</option>
                    <option value="sec_assign" <c:if test="${elementType2 eq 'radioButton'}"> selected="selected"</c:if>>メンバーアサイン</option>
                  </select>
                </td>
                <td>
                  <%--検索ワード　ラジオボタンのとき--%>
				  <div id="search2_radio" class="assign_length noprint"><%-- 非表示にするときに使用するid--%>
                    <input type="radio" id="assignfin2" name="search_word_radio_2" value="assign_fin" <c:if test="${(elementType2 eq 'radioButton') and (projSearch[1].searchWord eq 'assign_fin')}">checked</c:if>/>アサイン済
                    <input type="radio" id="assignnotfin2" name="search_word_radio_2" value="assign_not_fin" <c:if test="${(elementType2 ne 'radioButton') or ((elementType2 eq 'radioButton') and (projSearch[1].searchWord ne 'assign_fin'))}">checked</c:if>/>未アサイン
                  </div>
				  <%--検索ワード　カレンダーのとき--%>
                  <input type="text"  class="dp2 noprint monthsize" name="search_word_text_2" id="search_word_date2" readonly
					<c:if test="${elementType2 eq 'calendar'}">value="${projSearch[1].searchWord}"</c:if>
                  />
          		  <%--検索ワード　テキストボックスのとき--%>
                  <input type="text" name="search_word_text_2" id="search_word_text2" class="noprint search_word_text_box"
                      <c:if test="${elementType2 eq 'textbox'}">value="<c:out value="${projSearch[1].searchWord}"/>"</c:if>
                  />
                </td>
                <td>
                  <button type="button" name="p_search" onClick="return proj_search_action(this) && submit();">検索</button>
                </td>
              </tr>
            </table>
          </div>
        <%--レイアウト調整用 --%>
        </td>
      </tr>
      <tr>
        <td>
          <%--表の表示を行う箇所 --%>
          <table class="proj_list_table">
            <tr>
              <c:if test="${canEdit}">
                <th class="checkbox_area noprint"><input type="checkbox" id="all" name="all" class="noprint" onClick="checkbox_ctrlAllcheckbox();"/></th>
              </c:if>
              <th class="pnum">P番</th>
              <th class="pname">プロジェクト名</th>
              <th class="customer">売上先</th>
              <th class="sales_user">営業</th>
              <th class="status">ステータス</th>
              <th class="issueddate">発行日</th>
              <th class="period">開発期間</th>
              <th class="order_money">開発予算</th>
              <th class="assign">メンバー<br>アサイン</th>
              <th class="createdby">登録者</th>
              <th class="changedby">更新者</th>
            </tr>
            <c:forEach items="${projList}" var="pr">
            <tr>
              <c:if test="${canEdit}">
                <td class="checkbox_area noprint"><input type="checkbox" id="content" name="content" class="noprint" value="${pr.id}" onClick="checkbox_ctrlTopcheckbox();"/></td>
              </c:if>


              <%-- P番(詳細画面へのリンク) --%>
              <td class="pnum"><a name="p_detail" href="javascript:document.Mainform.submit()" title="${pr.id}" onClick="return setActionParam(this);">${pr.projNum}</a></td>

              <%-- プロジェクト名 --%>
              <td class="pname"><c:out value="${pr.projName}"/></td>
              <%-- 売上先 --%>
              <td class="customer"><c:out value="${pr.customerName}"/></td>
              <%-- 営業 --%>
              <td class="sales_user"><c:out value="${pr.salesStaffName}"/></td>
              <%-- ステータス --%>
              <td class="status"><c:out value="${pr.salesStatusName}"/></td>


              <%-- 発行日 --%>
              <td class="issueddate"><fmt:formatDate value="${pr.issuedDate}" pattern="yyyy/MM/dd"/></td>


              <%-- 開発期間 --%>
              <td class="period">
              <fmt:formatDate value="${pr.devStartTime}" pattern="yyyy/MM/dd"/>～<fmt:formatDate value="${pr.devEndTime}" pattern="yyyy/MM/dd"/>
              </td>
              <%-- 開発予算 --%>
              <!-- 削除：インターノウス -->
              <!-- 余分なダブルクォーテーションを削除 -->
              <td class="order_money"><fmt:formatNumber value="${pr.devBudgets}" groupingUsed="true"/>円</td>

              <%-- メンバーアサイン --%>
              <%-- リーダーかメンバーがいる場合に済にする --%>
              <td class="assign">
			  <c:if test="${(!empty pr.projLeader) or (!empty pr.projMember)}">済</c:if>
              </td>

              <%-- 登録者 --%>
              <td class="createdby">
              <c:out value="${pr.createdBy}"/>
              <br>
              <fmt:formatDate value="${pr.createdAt}" pattern="yyyy/MM/dd"/>
              </td>


              <%-- 更新者 --%>

              <td class="changedby">
              <c:out value="${pr.changedBy}"/>
              <br>
              <fmt:formatDate value="${pr.changedAt}" pattern="yyyy/MM/dd"/>
              </td>
            </tr>
            </c:forEach>
          </table>

          <input type="hidden" id="proj_num_id" name="p_id" value=""/>
          <input type="hidden" id="action_id" name="action" value="" class="hidden_action_param">

          <%--レイアウト調整 --%>
        </td>
      </tr>
      <tr>
        <td>
	      <%--ページ分割処理(インクルード) --%>
          <div class="page_portion noprint">
            <jsp:include page="include_page_info.jsp" flush="true">
              <jsp:param name="forward_action" value="proj_list_next" />
              <jsp:param name="back_action" value="proj_list_back" />
			</jsp:include>
          </div>
        </td>
      </tr>
    </table>
    <%--検索ワードをサーブレット側に渡す際に使用 --%>
    <input type="hidden" id="search_word_1" name="search_word_1" value="<c:out value=""/>">
    <input type="hidden" id="search_word_2" name="search_word_2" value="<c:out value=""/>">
  </form>
  <br>
  <%
  //共通モジュールに渡すエラーリストをリクエストスコープにセット
  request.setAttribute("errorMessageList", errorMessageList);
  %>
  <jsp:include page="include_error_message.jsp" flush="true"/>
</body>
</html>