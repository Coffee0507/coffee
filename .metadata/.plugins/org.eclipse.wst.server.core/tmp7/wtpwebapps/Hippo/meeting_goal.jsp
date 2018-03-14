<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.util.List"%>
<%@ page import="jp.co.lsij.p16590004.common.Error"%>
<%@ page import="jp.co.lsij.p16590004.common.ScopeNameConstants"%>
<%@ page import="jp.co.lsij.p16590004.common.MeetingDataConstants"%>
<%@ page import="jp.co.lsij.p16590004.e_200.model.analyze.beans.MeetingDataTargetOrder"%>
<%@ page import="jp.co.lsij.p16590004.e_200.model.analyze.beans.MeetingDataTargetSales"%>
<%@ page import="jp.co.lsij.p16590004.e_200.model.analyze.beans.MeetingDataTarget"%>
<%@ page import="jp.co.lsij.p16590004.e_77.util.StringHelper"%>
<!DOCTYPE html>

<html lang="ja">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name="format-detection" content="telephone=no">

  <link href="CSS/Normalize.css" rel="stylesheet" type="text/css">
  <link href="CSS/p16590004.css" rel="stylesheet" type="text/css">
  <link href="CSS/meeting_goal.css" rel="stylesheet" type="text/css">

  <script src="LimitDef.js"></script>
  <script src="InputPatternDef.js"></script>
  <script src="displayFrameTitle.js"></script>
  <script src="BrowserBackPrevent.js"></script>
  <script src="ObjUtil.js"></script>
  <script src="InputTextCheck.js"></script>
  <%-- <script src="TextBoxUtil.js"></script> --%><%-- Added by dai --%>
  <script src="button_util.js"></script>
  <script src="meeting_goal.js"></script>

  <title>目標値設定</title>

<%
/** 例外処理をまとめるのに使用 */
List<String> errorMessageList = new ArrayList<String>();
%>
</head>
<body>
<%
try {
  Error  error = null;

  //コントローラからの各種情報の取得
  error = (Error)request.getAttribute(ScopeNameConstants.SCOPE_ERROR_CLASS);
  if (null == error) {
    errorMessageList.add("error==null");
  }
  boolean  isExistMeetingDataTarget = false;
  isExistMeetingDataTarget = (boolean)request.getAttribute(MeetingDataConstants.SCOPE_DATA_EXISTS);
  //設定済みの場合
  if (false != isExistMeetingDataTarget) {
    MeetingDataTarget meetingDataTarget = null;

    //※セッションの内容を直接 EL で参照できそうだが、時間がないので今回修正しない
    meetingDataTarget = (MeetingDataTarget)request.getAttribute(MeetingDataConstants.SCOPE_MEETING_DATA_TARGET);
//    meetingDataTarget = (MeetingDataTarget)session.getAttribute(MeetingDataConstants.SCOPE_MEETING_DATA_TARGET);
    MeetingDataTargetOrder meetingDataTargetOrder = meetingDataTarget.getTargetOrder();
    request.setAttribute("meetingDataTargetOrder", meetingDataTargetOrder);
    MeetingDataTargetSales meetingDataTargetSales = meetingDataTarget.getTargetSales();
    request.setAttribute("meetingDataTargetSales", meetingDataTargetSales);
  }
} catch (Exception err) {
  try {
    errorMessageList.add("例外発生（データ取得部）（" + err.getMessage() + "）");
  } catch (Exception err_2) {}
}
%>

  <br>
  <h3 class="page_title">目標値設定</h3>

  <%--エラー表示を行う箇所 --%>
  <c:choose>
    <c:when test="${error.isError}"><p class="error_message">${error.errorInfo}</p></c:when>
    <c:otherwise></c:otherwise>
  </c:choose>
  
  <form id="Mainform" name="Mainform" action="./MeetingDataController" method="POST">
    <table>
      <tr>
        <td>
        
          <table class="meeting_goal_table">
            <tr>
              <th class="left_side_column"></th>
              <th class="target_value_column">売上目標</th>
              <th class="target_value_column">受注目標</th>
            </tr>
            <tr>
              <th>前期注残</th>
              <td> </td>
              <td>
                <input type="text" id="before_order_goal_id" class="width_for_target_cls" name="before_order_goal" 
                <c:choose>
                  <c:when test="${error.isError}">value="${targetValueMap.before_order_goal[0]}"</c:when>
                  <c:when test="${dataExists}">value="${meetingDataTargetOrder.backlog}"</c:when>
                  <c:otherwise></c:otherwise>
                </c:choose>
                > <%--閉じタグのため消さない --%>
              </td>
            </tr>
            <tr>
              <th>Q 1</th>
              <td>
                <input type="text" id="q1_sales_goal_id" class="width_for_target_cls" name="q1_sales_goal" 
                <c:choose>
                  <c:when test="${error.isError}">value="${targetValueMap.q1_sales_goal[0]}"</c:when>
                  <c:when test="${dataExists}">value="${meetingDataTargetSales.q1}"</c:when>
                  <c:otherwise></c:otherwise>
                </c:choose>
                > <%--閉じタグのため消さない --%>
              </td>
              <td>
                <input type="text" id="q1_order_goal_id" class="width_for_target_cls" name="q1_order_goal" 
                <c:choose>
                  <c:when test="${error.isError}">value="${targetValueMap.q1_order_goal[0]}"</c:when>
                  <c:when test="${dataExists}">value="${meetingDataTargetOrder.q1}"</c:when>
                  <c:otherwise></c:otherwise>
                </c:choose>
                > <%--閉じタグのため消さない --%>
              </td>
            </tr>
            <tr>
              <th>Q 2</th>
              <td>
                <input type="text" id="q2_sales_goal_id" class="width_for_target_cls" name="q2_sales_goal" 
                <c:choose>
                  <c:when test="${error.isError}">value="${targetValueMap.q2_sales_goal[0]}"</c:when>
                  <c:when test="${dataExists}">value="${meetingDataTargetSales.q2}"</c:when>
                  <c:otherwise></c:otherwise>
                </c:choose>
                > <%--閉じタグのため消さない --%>
              </td>
              <td>
                <input type="text" id="q2_order_goal_id" class="width_for_target_cls" name="q2_order_goal" 
                <c:choose>
                  <c:when test="${error.isError}">value="${targetValueMap.q2_order_goal[0]}"</c:when>
                  <c:when test="${dataExists}">value="${meetingDataTargetOrder.q2}"</c:when>
                  <c:otherwise></c:otherwise>
                </c:choose>
                > <%--閉じタグのため消さない --%>
              </td>
            </tr>
            <tr>
              <th>Q 3</th>
              <td>
                <input type="text" id="q3_sales_goal_id" class="width_for_target_cls" name="q3_sales_goal" 
                <c:choose>
                  <c:when test="${error.isError}">value="${targetValueMap.q3_sales_goal[0]}"</c:when>
                  <c:when test="${dataExists}">value="${meetingDataTargetSales.q3}"</c:when>
                  <c:otherwise></c:otherwise>
                </c:choose>
                > <%--閉じタグのため消さない --%>
              </td>
              <td>
                <input type="text" id="q3_order_goal_id" class="width_for_target_cls" name="q3_order_goal" 
                <c:choose>
                  <c:when test="${error.isError}">value="${targetValueMap.q3_order_goal[0]}"</c:when>
                  <c:when test="${dataExists}">value="${meetingDataTargetOrder.q3}"</c:when>
                  <c:otherwise></c:otherwise>
                </c:choose>
                > <%--閉じタグのため消さない --%>
              </td>
            </tr>
            <tr>
              <th>Q 4</th>
              <td>
                <input type="text" id="q4_sales_goal_id" class="width_for_target_cls" name="q4_sales_goal" 
                <c:choose>
                  <c:when test="${error.isError}">value="${targetValueMap.q4_sales_goal[0]}"</c:when>
                  <c:when test="${dataExists}">value="${meetingDataTargetSales.q4}"</c:when>
                  <c:otherwise></c:otherwise>
                </c:choose>
                > <%--閉じタグのため消さない --%>
              </td>
              <td>
                <input type="text" id="q4_order_goal_id" class="width_for_target_cls" name="q4_order_goal" 
                <c:choose>
                  <c:when test="${error.isError}">value="${targetValueMap.q4_order_goal[0]}"</c:when>
                  <c:when test="${dataExists}">value="${meetingDataTargetOrder.q4}"</c:when>
                  <c:otherwise></c:otherwise>
                </c:choose>
                > <%--閉じタグのため消さない --%>
              </td>
            </tr>
          </table>
        
        </td>
      </tr>
      <tr>
        <td align="center">
      
          <table>
            <tr align="center">
              <td>
                <button type="button" value="goal_dec" onClick="return meeting_goal_add() && setActionToHidden(this) && submit();">設定</button>
              </td>
              <td>
                <c:if test="${!fromMenu}">
                  <button type="button" value="goal_return" onClick="return setActionToHidden(this) && submit();">戻る</button>
                </c:if>
              </td>
            </tr>
          </table>
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