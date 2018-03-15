<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="jp.co.lsij.p16590004.common.Error" %>
<%@ page import="jp.co.lsij.p16590004.e_77.model.p_num.beans.ProjNumBean" %>
<%@ page import="jp.co.lsij.p16590004.e_77.model.p_num.beans.NotiUserBean" %>
<%@ page import="jp.co.lsij.p16590004.e_77.model.p_num.beans.AttachFileBean" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="jp.co.lsij.p16590004.e_77.model.BeanDataList" %>
<%@ page import="jp.co.lsij.p16590004.common.ProjConstants"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="jp.co.lsij.p16590004.e_77.model.master.beans.UserBean" %>

<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<meta name="format-detection" content="telephone=no">
<title>P番詳細</title>

<%
//例外処理をまとめるのに使用
ArrayList<String> errorMessageList = new ArrayList<String>();
%>
<script src="ObjUtil.js"></script>
<script src="BrowserBackPrevent.js"></script>
<script src="displayFrameTitle.js"></script>
<script src="proj_dat.js"></script>

<link href="CSS/Normalize.css" rel="stylesheet" type="text/css">
<link href="CSS/p16590004.css" rel="stylesheet" type="text/css">
<link href="CSS/proj_dat.css" rel="stylesheet" type="text/css">
<link href="CSS/print.css" rel="stylesheet" type="text/css" media="print">

<!-- 追加：インターノウス -->
<!-- ここから -->
<script type="text/javascript">
<!--
window.onload = function(){
    var calcLossValue = document.getElementById("calcLoss").textContent;
    var value = calcLossValue.substring(0, 1);

    if(value == "-") {
        document.getElementById("calcLoss").style.color = "red";
    }
}
//-->
</script>
<!-- ここまで -->

</head>
<body>
<%
try{
  ProjNumBean projNumBean = (ProjNumBean)request.getAttribute(ProjConstants.SCOPE_PROJ_DATA);
  if (projNumBean == null) {
    errorMessageList.add("projNumBeanがnull");
  } else {
      //添付ファイルのbeanを取得
      List<AttachFileBean> attachFileBeanList = projNumBean.getAttachFileList();
      request.setAttribute("attachFileBeanList",attachFileBeanList);
  }
}catch(Exception e){
  errorMessageList.add("proj_dat.jsp:前処理エラー");
}
%>
  <br>
  <h3 class="page_title">P番詳細</h3>

<%--エラー表示を行う箇所 --%>
<c:if test="${error.isError}">
    <p class="error_message noprint"><c:out value="${error.errorInfo}"/></p>
</c:if>

<form id="Mainform" name="Mainform" action="./ProjController" method="POST">
  <table class="proj_dat_out_table">
    <tr>
      <td>
        <button type="button" onClick="Print()" class="noprint">印刷</button>
      </td>
    </tr>
    <tr>
      <td>

        <table class="proj_dat_table">
          <tr>
            <th colspan="2">登録者</th>
            <td><c:out value="${proj.createdBy}"/><br>
              <fmt:formatDate value="${proj.createdAt}" pattern="yyyy/MM/dd HH:mm" />
            </td>
          </tr>
          <tr>
            <th colspan="2">更新者</th>
            <td><c:out value="${proj.changedBy}"/><br>
              <fmt:formatDate value="${proj.changedAt}" pattern="yyyy/MM/dd HH:mm" />
            </td>
          </tr>
          <tr>
            <th colspan="2">P番</th>
            <td><c:out value="${proj.projNum}"/></td>
          </tr>
          <tr>
            <th colspan="2">分類</th>
            <td><c:out value="${proj.catName}"/></td>
          </tr>
          <tr>
            <th colspan="2">プロジェクト名</th>
            <td><c:out value="${proj.projName}"/></td>
          </tr>
          <tr>
            <th colspan="2">売上先</th>
            <td><c:out value="${proj.customerName}"/></td>
          </tr>
          <tr>
            <th colspan="2">エンドユーザー</th>
            <td><c:out value="${proj.endUserName}"/></td>
          </tr>
          <tr>
            <th colspan="2">営業</th>
            <td><c:out value="${proj.salesStaffName}"/></td>
          </tr>
          <tr>
            <th colspan="2">ステータス</th>
            <td><c:out value="${proj.salesStatusName}"/></td>
          </tr>
          <tr>
            <th colspan="2">発行日</th>
            <td><fmt:formatDate value="${proj.issuedDate}" pattern="yyyy/MM/dd" /></td>
          </tr>
          <tr>
            <th colspan="2">開発期間</th>
            <td>
              <fmt:formatDate value="${proj.devStartTime}" pattern="yyyy/MM/dd" />～<fmt:formatDate value="${proj.devEndTime}" pattern="yyyy/MM/dd" />
            </td>
          </tr>
          <tr>
            <th colspan="2">受注月</th>
            <td><fmt:formatDate value="${proj.dateOfOrders}" pattern="yyyy/MM" /></td>
          </tr>
          <tr>
            <th colspan="2">売上月</th>
            <td><fmt:formatDate value="${proj.dateOfSales}" pattern="yyyy/MM" /></td>
          </tr>
          <tr>
            <th colspan="2">入金月</th>
            <td><fmt:formatDate value="${proj.dayOfPayment}" pattern="yyyy/MM" /></td>
          </tr>
          <tr>
            <th colspan="2">開発予算</th>
            <td class="money_type"><fmt:formatNumber value="${proj.devBudgets}" groupingUsed="true"/>円</td>
          </tr>
          <!-- 追加:インターノウス -->
          <!-- ここから -->
          <tr>
            <th colspan="2">工数単価</th>
              <td class="money_type"><fmt:formatNumber value="${proj.unitPrice}" groupingUsed="true"/>円</td>
          </tr>
          <tr>
            <th colspan="2">受注金額</th>
            <td class="money_type"><fmt:formatNumber value="${proj.valueOfOrder}" groupingUsed="true"/>円</td>
          </tr>
          <tr>
              <th rowspan="2">仕入れ</th>
              <td>金額</td>
              <td class="money_type"><fmt:formatNumber value="${proj.calcPurchaseAmount()}" groupingUsed="true"/>円</td>
          </tr>
          <tr>
              <td>更新日</td>
              <td>
              <c:choose>
              <c:when test="${(proj.prePurchaseAmountChangedAt != null) and (proj.newPurchaseAmountChangedAt != null) }">
                  <c:choose>
                      <c:when test="${proj.newPurchaseAmountChangedAt.compareTo(proj.prePurchaseAmountChangedAt) > 0}">
                        <fmt:formatDate value="${proj.newPurchaseAmountChangedAt}" pattern="yyyy/MM/dd HH:ss:mm" />
                      </c:when>
                      <c:when test="${proj.prePurchaseAmountChangedAt.compareTo(proj.newPurchaseAmountChangedAt) > 0}">
                        <fmt:formatDate value="${proj.prePurchaseAmountChangedAt}" pattern="yyyy/MM/dd HH:ss:mm" />
                      </c:when>
                  </c:choose>
              </c:when>
              <c:when test="${proj.prePurchaseAmountChangedAt != null}">
                <fmt:formatDate value="${proj.prePurchaseAmountChangedAt}" pattern="yyyy/MM/dd HH:ss:mm" />
              </c:when>
              <c:when test="${proj.newPurchaseAmountChangedAt != null}">
                <fmt:formatDate value="${proj.newPurchaseAmountChangedAt}" pattern="yyyy/MM/dd HH:ss:mm" />
              </c:when>
              </c:choose>
              </td>
          </tr>
           <tr>
              <th rowspan="2">工数
                <c:if test="${canEdit && !empty proj.id}">
                    <button type="submit"  class="noprint" value="p_dat_modify_total_working_time" onClick="return setActionParam(this)">更新</button>
                </c:if>
              </th>
              <td>金額<br>(時間)</td>
              <td class="money_type"><fmt:formatNumber value="${proj.calcLaborCost()}" groupingUsed="true"/>円
              <br>(<c:out value="${proj.totalWorkingTime}" />)</td>
          </tr>
          <tr>
              <th>更新日</th>
              <td><fmt:formatDate value="${proj.totalWorkingTimeChangedAt}" pattern="yyyy/MM/dd HH:ss:mm" /></td>
          </tr>
          <tr>
            <th colspan="2">損益</th>
            <td class="money_type" id="calcLoss"><fmt:formatNumber value="${proj.calcLoss()}" groupingUsed="true"/>円
          </tr>
          <!-- 追加:インターノウス ここまで -->
          <tr>
            <th colspan="2">添付資料</th>
            <td>
              <c:forEach items="${attachFileBeanList}" var="attachFileBean">
                  <a name="p_dat_doc" href="javascript:document.Mainform.submit()" title="${attachFileBean.id}" onClick="setActionParam(this);"><c:out value="${attachFileBean.fileName}"/></a>
                  <br>
              </c:forEach>
            </td>
          </tr>
          <tr>
            <th colspan="2">備考</th>
            <td><pre class="reset_style pre_remarks"><c:out value="${proj.remarks}"/></pre></td>
          </tr>
          <tr>
            <th colspan="2">リーダー</th>
            <td><c:out value="${proj.projLeader}"/></td>
          </tr>
          <tr>
            <th colspan="2">メンバー</th>
            <td><c:out value="${proj.projMember}"/></td>
          </tr>
          <tr>
            <th colspan="2">通知</th>
            <td>
              <c:forEach items="${notiUserList}" var="notiUser">
                <c:out value="${notiUser.secondName}${notiUser.firstName}"/><br>
              </c:forEach>
            </td>
          </tr>
        </table>
      </td>
    </tr>
    <tr>
      <td>
        <div class="proj_dat_button">
          <c:if test="${canEdit && !empty proj.id}">
<%-- P番beanが空またはidが空の場合も「変更」ボタンを表示させない
          <c:if test="${canEdit}">
--%>
            <button type="submit" value="p_dat_change" onClick="return setActionParam(this)" class="noprint">変更</button>
          </c:if>
          <button type="submit" value="p_dat_return" onClick="return setActionParam(this)" class="noprint">戻る</button>
        </div>
      </td>
    </tr>
  </table>
    <%--p_idを設定する箇所 --%>
    <input type="hidden" id="proj_num_id" name="p_id" value="${proj.id}">
    <%--アクションパラメータを設定する箇所 --%>
    <input type="hidden" id="proj_turning" name="action" value="">
    <%--ファイルidを設定する箇所 --%>
    <input type="hidden" id="p_dat_inc_doc" name="p_dat_inc_doc" value="">
</form>
<%
  //共通モジュールに渡すエラーリストをリクエストスコープにセット
  request.setAttribute("errorMessageList", errorMessageList);
%>
<jsp:include page="include_error_message.jsp" flush="true"/>

</body>
</html>