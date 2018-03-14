<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.Map"%>
<%@ page import="jp.co.lsij.p16590004.common.CodeEnum.Form"%>
<%@ page import="jp.co.lsij.p16590004.common.ScopeNameConstants"%>
<%@ page import="jp.co.lsij.p16590004.common.UWConstants"%>
<%@ page import="jp.co.lsij.p16590004.common.Error" %>
<%@ page import="jp.co.lsij.p16590004.e_200.model.sales.SalesBeanBuilder" %>
<%@ page import="jp.co.lsij.p16590004.e_77.model.sales.beans.SalesBean" %>
<%@ page import="jp.co.lsij.p16590004.e_77.model.sales.beans.AddProjNumBean" %>
<!DOCTYPE html>

<html lang="ja">
<head>
  <meta charset="UTF-8">
  <meta name="format-detection" content="telephone=no">
  
  <script src="InputPatternDef.js"></script>
  <script src="LimitDef.js"></script>
  <script src="displayFrameTitle.js"></script>
  <script src="BrowserBackPrevent.js"></script>
  <script src="ObjUtil.js"></script>
  <script src="InputTextCheck.js"></script>
  <script src="button_util.js"></script>
  <script src="sales_edit.js"></script>

  <!-- jQuery -->
  <script src="JS_LIB/jQuery/jquery-3.2.1.min.js" type="text/javascript"></script>
  <!-- bootstrap -->
  <link href="JS_LIB/bootstrap/bootstrap.css" type="text/css" rel="stylesheet"></link>
  <script src="JS_LIB/bootstrap/bootstrap.js" type="text/javascript"></script>
  <!-- bootstrap-datepicker -->
  <link href="JS_LIB/bootstrap/bootstrap-datepicker.css" type="text/css" rel="stylesheet"></link>
  <script src="JS_LIB/bootstrap/bootstrap-datepicker.js" type="text/javascript"></script>
  <!-- 日本語化スクリプト -->
  <script src="JS_LIB/bootstrap/bootstrap-datepicker.ja.min.js" type="text/javascript"></script>

  <script src="datepicker-configuration.js"></script>

  <!-- ※順序注意（Normalize.css->p16590004.css->...の順） -->
  <link href="CSS/Normalize.css" rel="stylesheet" type="text/css">
  <link href="CSS/p16590004.css" rel="stylesheet" type="text/css">
  <link href="CSS/sales_edit.css" rel="stylesheet" type="text/css">

  <title>
  <c:choose>
    <%--enum はstringで比較する模様 --%>
    <c:when test="${formID == 'add'}">新規案件追加</c:when>
    <c:when test="${formID == 'edit'}">案件編集</c:when>
    <c:otherwise>不明</c:otherwise>
  </c:choose>
  </title>

<%!
//JSP内で追加するリクエストスコープ
//req_scope_isInvalidState・・・無効な状態
//Listcount・・子Ｐ番数・
//AddProjNumBeanList・・・子Ｐ番リスト
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
Error error = (Error)request.getAttribute(ScopeNameConstants.SCOPE_ERROR_CLASS);//"error"
if (null == error) {
  isInvalidState = true;
  errorMessageList.add("error==null");
}
Form mode = (Form)request.getAttribute(ScopeNameConstants.SCOPE_FORM_ID);//"formID"
if (null == mode) {
  isInvalidState = true;
  errorMessageList.add("formID==null");
}
if (false == isInvalidState) {
//上記でエラーが発生していない場合
  if (false == error.isIsError()) {
    if (mode == Form.edit) {
      try {
        SalesBean salesBean = (SalesBean)request.getAttribute(UWConstants.SCOPE_UW_DATA);//"uwData"
        if (salesBean == null){
          isInvalidState = true;
          errorMessageList.add("uwData==null");
        } else {
          request.setAttribute("AddProjNumBeanList", salesBean.getAddProjNumList());
          request.setAttribute("Listcount", salesBean.getAddProjNumList().size());
        }
      } catch (Exception err) {
        isInvalidState = true;
        errorMessageList.add("子P番の処理でエラー（" + err.toString() + "）");
      }
    }
  } else {
    Map<String, String[]> map = null;
    
    try{
      //エラー時にマップを取得する
      map = (Map<String, String[]>)request.getAttribute(UWConstants.SCOPE_UW_INPUT_VALUE);//"uwDataMap"
      if (null == map) {
        isInvalidState = true;
        errorMessageList.add("uwDataMap==null");
      } else {
        if (0 == map.size()) {
          isInvalidState = true;
          errorMessageList.add("uwDataMap.size==0");
        } else {
          //子Ｐ番の情報を取得
          String[] arrySubPNum = map.get(SalesBeanBuilder.MAP_KEY_PROJ_ID_SUB);//"uw_p_number"
          if (null == arrySubPNum) {
            request.setAttribute("Listcount", 0);
          } else {
            List<AddProjNumBean> addProjNumBeanList = new ArrayList <AddProjNumBean>();
            request.setAttribute("Listcount", arrySubPNum.length);
            if (0 < arrySubPNum.length) {
              for(String strSubPNum : arrySubPNum){
                AddProjNumBean addProjNum = new AddProjNumBean();
                addProjNum.setProjNum(strSubPNum);
                addProjNumBeanList.add(addProjNum);
              }
              request.setAttribute("AddProjNumBeanList", addProjNumBeanList);
            }
          }
        }
      }
    } catch (Exception err) {
      isInvalidState = true;
      errorMessageList.add("子P番の処理でエラー（" + err.toString() + "）");
    }
  }
}
request.setAttribute("req_scope_isInvalidState", isInvalidState);
%>

  <br>
  <h3 class="page_title">
  <c:choose>
    <%--enum はstringで比較する模様 --%>
    <c:when test="${formID == 'add'}">新規案件追加</c:when>
    <c:when test="${formID == 'edit'}">案件編集</c:when>
    <c:otherwise>不明</c:otherwise>
  </c:choose>
  </h3>
 
  <%--エラー表示を行う箇所 --%>
  <c:choose>
    <c:when test="${error.isError}">
      <p class="error_message"><c:out value="${error.errorInfo}"/></p>
    </c:when>
    <c:otherwise></c:otherwise>
  </c:choose>

  <form id="Mainform" action="./UWController" method="POST">
    <%-- レイアウト調整用 --%>
    <table class="sales_edit_out_table">
      <tr>
        <td>

          <table class="proj_edit_table">
            <tr>
              <th >Ｐ　　番　※</th>
              <td>
                <%-- 親Ｐ番をdiv で囲む --%>
                <div class="pnum_area">
                  <input type="text" id="uw_p_number_first_id" name="uw_p_number_first" 
                  <%-- class 指定 --%>
                  <c:choose>
                    <c:when test="${formID == 'add'}">
                      class="pnum" 
                    </c:when>
                    <c:when test="${formID == 'edit'}">
                      class="edit_readonly pnum" 
                    </c:when>
                    <c:otherwise></c:otherwise>
                  </c:choose>
                  
                  <%-- value 指定 --%>
                  <%-- whenタグが上から順に評価され、trueになった要素が出力されます。そのwhenタグから下の要素は評価されません。 --%>
                  <%-- 例 error.isError == true で  formID == add の場合、error.isError の条件文だけ実行される--%>
                  <c:choose>
                    <c:when test="${error.isError}">
                      value="${(uwDataMap.uw_p_number_first)[0]}" 
                    </c:when>
                    <c:when test="${formID == 'edit'}">
                      value="${uwData.projNum}" 
                    </c:when>
                    <c:otherwise></c:otherwise>
                  </c:choose>
                  
                  <%-- readonly 指定 --%>
                  <c:choose>
                    <c:when test="${formID == 'edit'}">readonly </c:when>
                    <c:otherwise></c:otherwise>
                  </c:choose>
                  > <%--inputタグの閉じのため消さない --%>
                  <input type="button" value="＋" onClick="pushedPlusButton();" id="plusButton" class="plusbutton"/> 
                </div>
                <%--以下のdiv内に子Ｐ番が挿入される（必須） --%>
                <div id="here">
                </div>
              </td>
            </tr>

            <tr>
              <th>分　　類　※</th>
              <td>
                <select id="uw_type_id" class="selectbox_size" name="uw_type">
                  <option value=""></option><%--空白 --%>
                  <c:forEach items="${categoryList}" var="cat">
                    <option value="<c:out value="${cat.name}" />" 
<%-- エスケープさせるため
                    <option value="${cat.name}" 
--%>
                    <c:choose>
                      <c:when test="${error.isError}">
                        <c:if test="${(uwDataMap.uw_type)[0] eq cat.name}">
                          selected="selected" 
                        </c:if>
                        <%-- <c:if test="${uwDataMap.uw_type[0] eq cat.name}">selected="selected"</c:if> --%>
                      </c:when>
                      <c:when test="${formID == 'edit'}">
                        <c:if test="${uwData.catName eq cat.name}">
                          selected="selected" 
                        </c:if>
                      </c:when>
                      <c:otherwise></c:otherwise>
                    </c:choose>
                    > <%--optionタグの閉じのため消さない --%>
                    <c:out value="${cat.name}" /></option>
<%-- エスケープさせるため
                    ${cat.name}</option>
--%>
                  </c:forEach>
                </select>
              </td>
            </tr>
            
            <tr>
              <th>営　　業　※</th>
              <td>
                <select id="uw_sales_id" class="selectbox_size" name="uw_sales">
                  <option value=""></option><%--空白 --%>
                  <c:forEach items="${salesStaffList}" var="staff">
                    <option value="<c:out value="${staff.salesStaff}" />" 
<%-- エスケープさせるため
                    <option value="${staff.salesStaff}" 
--%>
                    <c:choose>
                      <c:when test="${error.isError}">
                        <c:if test="${(uwDataMap.uw_sales)[0] eq staff.salesStaff}">
                          selected="selected" 
                        </c:if>
                        <%-- <c:if test="${uwDataMap.uw_sales[0] eq staff.salesStaff}">selected="selected"</c:if> --%>
                      </c:when>
                      <c:when test="${formID == 'edit'}">
                        <c:if test="${uwData.salesStaffName eq staff.salesStaff}">
                          selected="selected" 
                        </c:if>
                      </c:when>
                      <c:otherwise></c:otherwise>
                    </c:choose>
                    > <%--optionタグの閉じのため消さない --%>
                    <c:out value="${staff.salesStaff}" /></option>
<%-- エスケープさせるため
                    ${staff.salesStaff}</option>
--%>
                  </c:forEach>
                </select>
              </td>
            </tr>
            
            <tr>
              <th>ステータス　※</th>
              <td>
                <select id="uw_status_id" class="selectbox_size" name="uw_status">
                  <option value=""></option><%--空白 --%>
                  <c:forEach items="${salesStatusList}" var="status">
                    <option value="<c:out value="${status.statusName}" />" 
<%-- エスケープさせるため
                    <option value="${status.statusName}" 
--%>
                    <c:choose>
                      <c:when test="${error.isError}">
                        <c:if test="${(uwDataMap.uw_status)[0] eq status.statusName}">
                          selected="selected" 
                        </c:if>
                        <%-- <c:if test="${uwDataMap.uw_status[0] eq status.statusName}">selected="selected"</c:if> --%>
                      </c:when>
                      <c:when test="${formID == 'edit'}">
                        <c:if test="${uwData.salesStatusName eq status.statusName}">
                          selected="selected" 
                        </c:if>
                      </c:when>
                      <c:otherwise></c:otherwise>
                    </c:choose>
                    > <%--optionタグの閉じのため消さない --%>
                    <c:out value="${status.statusName}" /></option>
<%-- エスケープさせるため
                    ${status.statusName}</option>
--%>
                  </c:forEach>
                </select>
              </td>
            </tr>
            
            <tr>
              <th>プロジェクト名</th>
              <td>
                <input type="text" class="p_name" name="uw_name" 
                <c:choose>
                  <c:when test="${error.isError}">
                    value="<c:out value="${uwDataMap.uw_name[0]}"/>"
                  </c:when>
                  <c:when test="${formID == 'edit'}">
                    value="<c:out value="${uwData.projName}"/>"
                  </c:when>
                  <c:otherwise></c:otherwise>
                </c:choose>
                > <%--inputタグの閉じのため消さない --%>
              </td>
            </tr>
             
            <tr>
              <th>売上先　※</th>
              <td>
                <input type="text" id="uw_cus_id" class="customer" list="uw_cus_list_id" name="uw_cus" autocomplete="off" 
                <c:choose>
                  <c:when test="${error.isError}">
                    value="<c:out value="${uwDataMap.uw_cus[0]}"/>"
                  </c:when>
                  <c:when test="${formID == 'edit'}">
                    value="<c:out value="${uwData.customerName}"/>"
                  </c:when>
                </c:choose>
                > <%--inputタグの閉じのため消さない --%>
                <datalist id="uw_cus_list_id"><%--ここはコンボボックスの中身 --%>
                  <c:forEach items="${customerList}" var="customer">
                    <option value="<c:out value="${customer.customerName}"/>"></option>
                  </c:forEach>
                </datalist>
              </td>
            </tr>
             
            <tr>
              <th>エンドユーザー</th>
              <td>
                <input type="text" id="uw_end_user_id" class="customer" list="uw_end_user_list_id" name="uw_end_user" autocomplete="off" 
                <c:choose>
                  <c:when test="${error.isError}">
                    value="<c:out value="${uwDataMap.uw_end_user[0]}"/>"
                  </c:when>
                  <c:when test="${formID == 'edit'}">
                    value="<c:out value="${uwData.endUserName}"/>"
                  </c:when>
                </c:choose>
                > <%--inputタグの閉じのため消さない --%>
                <datalist id="uw_end_user_list_id"><%--ここはコンボボックスの中身 --%>
                  <c:forEach items="${customerList}" var="customer">
                    <option value="<c:out value="${customer.customerName}"/>"></option>
                  </c:forEach>
                </datalist>
              </td>
            </tr>
             
            <tr>
              <th>受注金額</th>
              <td>
                <input type="text" name="uw_order_money" 
                <c:choose>
                  <c:when test="${error.isError}">
                    value="${uwDataMap.uw_order_money[0]}"
                  </c:when>
                  <c:when test="${formID == 'edit'}">
                    value="${uwData.valueOfOrder}"
                  </c:when>
                </c:choose>
                >円 <%-- inputタグの閉じのため消さない --%>
              </td>
            </tr>
             
            <tr>
              <th>受注月</th>
              <td>
                <input type="text" id="uw_order_month_id" class="dp1 monthsize" name="uw_order_month" readonly 
                <c:choose>
                  <c:when test="${error.isError}">
                    value="${uwDataMap.uw_order_month[0]}"
                  </c:when>
                  <c:when test="${formID == 'edit'}">
                    value=<fmt:formatDate value="${uwData.dateOfOrders}" pattern="yyyy-MM"/>
                  </c:when>
                </c:choose>
                > <%-- inputタグの閉じのため消さない --%>
              </td>
            </tr>
             
            <tr>
              <th>売上月</th>
              <td>
                <input type="text" id="uw_sales_month_id" class="dp1 monthsize" name="uw_sales_month" readonly 
                <c:choose>
                  <c:when test="${error.isError}">
                    value="${uwDataMap.uw_sales_month[0]}"
                  </c:when>
                  <c:when test="${formID == 'edit'}">
                    value=<fmt:formatDate value="${uwData.dateOfSales}" pattern="yyyy-MM"/>
                  </c:when>
                </c:choose>
                > <%-- inputタグの閉じのため消さない --%>
              </td>
            </tr>
             
            <tr>
              <th>入金月</th>
              <td>
                <input type="text" id="uw_pay_month_id" class="dp1 monthsize" name="uw_pay_month" readonly 
                <c:choose>
                  <c:when test="${error.isError}">
                    value="${uwDataMap.uw_pay_month[0]}"
                  </c:when>
                  <c:when test="${formID == 'edit'}">
                    value=<fmt:formatDate value="${uwData.dayOfPayment}" pattern="yyyy-MM"/>
                  </c:when>
                </c:choose>
                > <%-- inputタグの閉じのため消さない --%>
              </td>
            </tr>
             
            <tr>
              <th>汎　　用</th>
              <td>
                <input type="text" class="generalwords" name="uw_general" 
                <c:choose>
                  <c:when test="${error.isError}">
                    value="<c:out value="${uwDataMap.uw_general[0]}"/>"
                  </c:when>
                  <c:when test="${formID == 'edit'}">
                    value="<c:out value="${uwData.generalWords}"/>"
                  </c:when>
                </c:choose>
                > <%-- inputタグの閉じのため消さない --%>
              </td>
            </tr>
             
            <tr>
              <th>備　　考</th>
              <td>
              <%-- 備考データの前後にスペースが入ってしまうので、ダメ（＜textarea＞スペースuwData.remarksスペース＜/textarea＞）
                <textarea class="remarks" name="uw_remarks" cols=40 rows=5>
                <c:choose>
                  <c:when test="${error.isError}">
                    <c:out value="${uwDataMap.uw_remarks[0]}" />
                  </c:when>
                  <c:when test="${formID == 'edit'}">
                    <c:out value="${uwData.remarks}" />
                  </c:when>
                </c:choose>
                </textarea>
              --%>
                <c:choose>
                  <c:when test="${error.isError}">
                    <textarea class="remarks" name="uw_remarks" cols=40 rows=5><c:out value="${uwDataMap.uw_remarks[0]}"/></textarea>
                  </c:when>
                  <c:when test="${formID == 'edit'}">
                    <textarea class="remarks" name="uw_remarks" cols=40 rows=5><c:out value="${uwData.remarks}"/></textarea>
                  </c:when>
                  <c:otherwise><textarea class="remarks" name="uw_remarks" cols=40 rows=5></textarea></c:otherwise>
                </c:choose>
              </td>
            </tr>
             
            <c:if test="${formID == 'edit'}">
            <tr>
              <th>P番反映　※</th>
              <td>
                <input type="checkbox" id="uw_res_id" name="uw_res" value="true" 
                <c:if test="${ !error.isError or (error.isError and !empty uwDataMap.uw_res[0]) }">
                  checked
                </c:if>
                >P番に反映させる
              </td>
            </tr>
            </c:if>
          </table>
          
        </td>
      </tr>
      <tr>
        <td>
          <br>
          <div class="sales_edit_button">
            <button type="button" 
            <c:choose>
              <c:when test="${formID == 'add'}">
                value="uw_add" onClick="return uw_add() && setActionToHidden(this) && submit();"
              </c:when>
              <c:when test="${formID == 'edit'}">
                value="uw_edit" onClick="return uw_edit() && setActionToHidden(this) && submit();"
              </c:when>
            </c:choose>
            > <%--buttonタグの閉じのため消さない --%>
            <c:choose>
              <c:when test="${formID == 'add'}">追加</c:when>
              <c:when test="${formID == 'edit'}">変更</c:when>
              <c:otherwise></c:otherwise>
            </c:choose>
            </button>
            <button type="button" onClick="return setActionToHidden(this) && submit();" 
              <c:choose>
                <c:when test="${formID == 'add'}">value="uw_add_return"</c:when>
                <c:when test="${formID == 'edit'}">value="uw_edit_return"</c:when>
                <c:otherwise></c:otherwise>
              </c:choose>
            >戻る
            </button><%-- 戻る左側の「>」はbuttonタグの閉じのため消さない --%>
          </div>
        </td>
      </tr>
    </table>
    
    <c:if test="${formID == 'edit'}">
      <input type="hidden" name="uw_id" 
      <c:choose>
        <c:when test="${error.isError}">value="${(uwDataMap.uw_id)[0]}"</c:when>
        <c:otherwise>value="${uwData.id}"</c:otherwise>
      </c:choose>
      > <%--inputタグの閉じのため消さない --%>
    </c:if>
    
    <%-- javascript 用にエラー状態を設定 --%>
    <input type="hidden" id="errModeFlag" name="errModeFlag" 
    <c:choose>
      <c:when test="${error.isError}" >value="true"</c:when>
      <c:otherwise>value="false"</c:otherwise>
    </c:choose>
    ><%--inputタグの閉じのため消さない --%>
    
    <%-- javascript 用に編集モードを設定（正常時のみ使用） --%>
    <c:if test="${!error.isError}">
      <input type="hidden" id="selectmode" name="selectmode" 
      <c:choose>
        <c:when test="${formID == 'add'}">value="add"</c:when>
        <c:when test="${formID == 'edit'}">value="edit"</c:when>
        <c:otherwise></c:otherwise>
      </c:choose>
      ><%--inputタグの閉じのため消さない --%>
    </c:if>
    
    <br><br>
    <%-- エラー時と正常編集時のみ、子Ｐ番数／子Ｐ番群の hidden を設定している --%>
    <c:choose>
      <c:when test="${error.isError}">
        <input type='hidden' id='listcounted' name='listcounted' value="${Listcount}" />
        <c:forEach var="subProjNum" items="${AddProjNumBeanList}" varStatus="loopStatus"><%-- varStatus：現在のループの状態を表すステータス変数。 --%>
          <input type="hidden" id='setval<c:out value="${loopStatus.index}"/>' name='val<c:out value="${loopStatus.index}"/>' value="<c:out value="${subProjNum.projNum}"/>" />
        </c:forEach>
      </c:when>
      <c:otherwise>
        <c:if test="${formID == 'edit'}">
          <input type='hidden' id='listcounted' name='listcounted' value="${Listcount}" />
          <c:forEach var="subProjNum" items="${AddProjNumBeanList}" varStatus="loopStatus"><%-- varStatus：現在のループの状態を表すステータス変数。 --%>
            <input type="hidden" id='setval<c:out value="${loopStatus.index}"/>' name='val<c:out value="${loopStatus.index}"/>' value="<c:out value="${subProjNum.projNum}"/>" />
          </c:forEach>
        </c:if>
      </c:otherwise>
    </c:choose>
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
