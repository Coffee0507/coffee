<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="jp.co.lsij.p16590004.common.Error" %>
<%@ page import="jp.co.lsij.p16590004.e_77.model.master.beans.CategoryBean" %>
<%@ page import="jp.co.lsij.p16590004.e_77.model.master.beans.SalesStaffBean" %>
<%@ page import="jp.co.lsij.p16590004.e_77.model.master.beans.SalesStatusBean" %>
<%@ page import="jp.co.lsij.p16590004.e_77.model.p_num.beans.ProjNumBean" %>
<%@ page import="jp.co.lsij.p16590004.common.ProjConstants"%>
<%@ page import="jp.co.lsij.p16590004.common.ScopeNameConstants"%>
<%@ page import="jp.co.lsij.p16590004.e_77.model.master.beans.UserBean" %>
<%@ page import="jp.co.lsij.p16590004.e_77.model.p_num.beans.NotiUserBean" %>
<%@ page import="jp.co.lsij.p16590004.e_77.model.p_num.beans.AttachFileBean" %>
<%@ page import="jp.co.lsij.p16590004.e_77.model.BeanDataList" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.HashMap"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.util.List"%>
<%@ page import="java.util.ArrayList"%>
<%@ page import="java.text.DateFormat"%>
<%@ page import="java.sql.Timestamp"%>
<%@ page import="java.util.Map"%>
<%@ page import="jp.co.lsij.p16590004.common.CodeEnum.Form"%>

<%@ page import="java.text.SimpleDateFormat"%>


<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<meta name="format-detection" content="telephone=no">
<script src="multifile.js"></script>

<!-- 追加：インターノウス  -->
<!-- ここから  -->
<script src="SelectBoxUtil.js"></script>
<!-- ここまで  -->
<script src="LimitDef.js"></script>
<script src="InputTextCheck.js"></script>
<script src="InputPatternDef.js"></script>
<script src="ObjUtil.js"></script>
<script src="BrowserBackPrevent.js"></script>
<link href="CSS/proj_edit.css" rel="stylesheet" type="text/css">

<script src="JS_LIB/jQuery/jquery-3.2.1.min.js" type="text/javascript"></script>
<!-- bootstrap -->
<link href="JS_LIB/bootstrap/bootstrap.css" type="text/css" rel="stylesheet"></link>
<script src="JS_LIB/bootstrap/bootstrap.js" type="text/javascript"></script>
<!-- bootstrap-datepicker -->
<link href="JS_LIB/bootstrap/bootstrap-datepicker.css" type="text/css" rel="stylesheet"></link>
<script src="JS_LIB/bootstrap/bootstrap-datepicker.js" type="text/javascript"></script>
<!-- 日本語対応用スクリプト -->
<script src="JS_LIB/bootstrap/bootstrap-datepicker.ja.min.js" type="text/javascript"></script>

<link href="CSS/Normalize.css" rel="stylesheet" type="text/css">
<link href="CSS/p16590004.css" rel="stylesheet" type="text/css">
<!-- 追加：インターノウス -->
<!-- ここから -->
<script src="ConnectedSelect.js"></script>
<!-- ここまで -->
<script src="displayFrameTitle.js"></script>
<%-- <script src="TextBoxUtil.js"></script> --%><%-- Added by dai --%>
<script src="button_util.js"></script>
<script src="proj_edit.js"></script>
<script src="datepicker-configuration.js"></script>

<!-- 追加：インターノウス -->
<!-- ここから -->
<script type="text/javascript">
$(function() {
	ConnectedSelect(['userGroupList','p_notice_all_id']);
	ConnectedSelectDefault(['userGroupList','p_notice_all_id']);
});
</script>
<!-- ここまで -->

<%
//例外処理をまとめるのに使用
ArrayList<String> errorMessageList = new ArrayList<String>();
%>

<c:if test="${formID == 'add'}" var="Add"/>
<c:if test="${formID == 'edit'}" var="Edit"/>
<c:if test="${formID == 'copy'}" var="Copy"/>

<c:choose>
	<c:when test="${Add or Copy}"><title>P番発行</title></c:when>
	<c:when test="${Edit}"><title>P番編集</title></c:when>
</c:choose>

</head>
<body>

<c:if test="${!Add and !error.isError}">
	<%
	//通知ユーザーのリストを取得してリクエストスコープに保存
	ProjNumBean projBean = (ProjNumBean)request.getAttribute(ProjConstants.SCOPE_PROJ_DATA);
	List<NotiUserBean> notiUserBeanList = projBean.getNotiUserList();
	request.setAttribute("notiUserBeanList", notiUserBeanList);
	%>
</c:if>

<c:if test="${Edit}">
	<%
	//以下、アップロード済み添付ファイル(List<AttachFileBean>)をリクエストスコープに保存する処理
	List<AttachFileBean> attachFileBeanList = new ArrayList<AttachFileBean>();
	%>
	<c:choose>
		<c:when test="${error.isError}">
			<%
			try{
				//projMapから、添付ファイルの数を取得
				Map<String, String[]> projMap = (Map<String, String[]>) request.getAttribute(ProjConstants.SCOPE_PROJ_INPUT_VALUE);
				String strAttachFileBeanListSize = (projMap.get("fileSize"))[0];
				int attachFileBeanListSize = Integer.parseInt(strAttachFileBeanListSize);

				if(attachFileBeanListSize != 0){
					for(int i = 1; i <= attachFileBeanListSize; i++) {

						String mapKeyFileID = "fileID" + i; //projMapから添付ファイルのIDを取得するkey
						String mapKeyFileName = "fileName" + i; //projMapから添付ファイルの名前を取得するkey

						if(!projMap.containsKey(mapKeyFileID) || !projMap.containsKey(mapKeyFileName)){
							errorMessageList.add("指定したkeyがprojMapにありません");
						}else{//projMapから添付ファイルのIDと名前を取得し、AttachFileBeanにセットしたものを、attachFileBeanListに追加
						  		String strFileID = (projMap.get(mapKeyFileID))[0];
						  		long fileID = Long.parseLong(strFileID); //ID
								String fileName = (projMap.get(mapKeyFileName))[0];

						  		AttachFileBean attachFileBean = new AttachFileBean();
								attachFileBean.setId(fileID);
								attachFileBean.setFileName(fileName);
								attachFileBeanList.add(attachFileBean);
						}
					}
				}
			}catch(Exception e){
			  errorMessageList.add("エラー時再表示用、アップロード済み添付ファイルの情報の取得処理");
			}

			%>
		</c:when>
		<c:otherwise>
			<%
			ProjNumBean projBean = (ProjNumBean)request.getAttribute(ProjConstants.SCOPE_PROJ_DATA);
			//添付ファイルのリストを取得
			attachFileBeanList = projBean.getAttachFileList();
			%>
		</c:otherwise>
	</c:choose>
	<%
	//添付ファイルのリスト(List<AttachFileBean>)をリクエストスコープに保存
    request.setAttribute("attachFileBeanList", attachFileBeanList);
	%>
</c:if>

<c:choose>
	<c:when test="${Add or Copy}">
		<h3 class="page_title">P番発行</h3>
	</c:when>
	<c:when test="${Edit}">
		<h3 class="page_title">P番編集</h3>
	</c:when>
</c:choose>

<%--改行含めたエラー処理 --%>
<c:if test="${error.isError}">
	<p class="error_message"><pre class="reset_style pre_error_message"><c:out value="${error.errorInfo}"/></pre></p>
</c:if>

<form id="Mainform" enctype="multipart/form-data" action="./ProjController" method="POST">
	<%-- レイアウト調整用 --%>
	<table class="proj_edit_out_table">
		<tr>
        	<td>
        		<%-- 一番上のやつ --%>
				<table class="proj_edit_table">
          			<c:if test="${Edit}">
          				<%-- P番編集時にのみ表示させる登録者と最終更新者 --%>
            			<tr>
              				<th>登録者</th>
              				<td>
              					<input type="text" name="p_registrant" readonly class="edit_readonly_name"
              						<c:choose>
              							<c:when test="${error.isError}">value="<c:out value="${projMap.p_registrant[0]}" />"</c:when>
              							<c:otherwise>value="<c:out value="${proj.createdBy}" />"</c:otherwise>
              						</c:choose>
              					>
              					<br>
              					<input type="text" name="p_createdAt" readonly class="edit_readonly_date"
              						<c:choose>
              							<c:when test="${error.isError}">value="${projMap.p_createdAt[0]}"</c:when>
              							<c:otherwise>value="<fmt:formatDate value='${proj.createdAt}' pattern='yyyy/MM/dd HH:mm'/>"</c:otherwise>
              						</c:choose>
              					>
              				</td>
            			</tr>
            			<tr>
              				<th>更新者</th>
              				<td>
              					<input type="text" name="p_updater" readonly class="edit_readonly_name"
              						<c:choose>
              							<c:when test="${error.isError}">value="<c:out value="${projMap.p_updater[0]}"/>"</c:when>
              							<c:otherwise>value="<c:out value="${proj.changedBy}"/>"</c:otherwise>
              						</c:choose>
              					>
              					<br>
              					<input type="text" name="p_changedAt" readonly class="edit_readonly_date"
              						<c:choose>
              							<c:when test="${error.isError}">value="${projMap.p_changedAt[0]}"</c:when>
              							<c:otherwise>value="<fmt:formatDate value='${proj.changedAt}' pattern='yyyy/MM/dd HH:mm'/>"</c:otherwise>
              						</c:choose>
              					>
              				</td>
            			</tr>
          			</c:if>
            			<tr>
              				<th>P　　番　※</th>
              				<td>
              					<input type="text" name="p_number" <c:if test="${Edit}">class="edit_readonly_pnum" readonly</c:if>
              						<c:choose>
              							<c:when test="${error.isError}">value="${projMap.p_number[0]}"</c:when>
              							<c:otherwise>
              								<c:if test="${!Add}">value="${proj.projNum}"</c:if>
              							</c:otherwise>
              						</c:choose>
              					>
              				</td>
            			</tr>
            			<tr>
              				<th>分　　類　※</th>
              				<td>
              					<select id="p_type" name="p_type" class="selectbox_size">
              						<option value=""></option>
              						<c:forEach var="cat" items="${categoryList}">
              							<c:choose>
              								<c:when test="${error.isError}">
              									<option value="<c:out value="${cat.name}"/>" <c:if test="${projMap.p_type[0] eq cat.name}">selected="selected"</c:if>><c:out value="${cat.name}"/></option>
              								</c:when>
              								<c:otherwise>
              									<option value="<c:out value="${cat.name}"/>" <c:if test="${!Add and (proj.catName eq cat.name)}">selected="selected"</c:if>><c:out value="${cat.name}"/></option>
              								</c:otherwise>
              							</c:choose>
              						</c:forEach>
              					</select>
              				</td>
            			</tr>
            			<tr>
              				<th>営　　業　※</th>
              				<td>
              					<select id="p_sales" name="p_sales" class="selectbox_size">
              						<option value=""></option>
              						<c:forEach var="staff" items="${salesStaffList}">
              							<c:choose>
              								<c:when test="${error.isError}">
              									<option value="<c:out value="${staff.salesStaff}"/>" <c:if test="${projMap.p_sales[0] eq staff.salesStaff}">selected="selected"</c:if>><c:out value="${staff.salesStaff}"/></option>
              								</c:when>
              								<c:otherwise>
              									<option value="<c:out value="${staff.salesStaff}"/>" <c:if test="${!Add and (proj.salesStaffName eq staff.salesStaff)}">selected="selected"</c:if>><c:out value="${staff.salesStaff}"/></option>
              								</c:otherwise>
              							</c:choose>
              						</c:forEach>
              					</select>
              				</td>
						</tr>
						<tr>
              				<th>ステータス　※</th>
              				<td>
                				<select id="p_status" name="p_status" class="selectbox_size">
                					<option value=""></option>
                					<c:forEach var="status" items="${salesStatusList}">
              							<c:choose>
              								<c:when test="${error.isError}">
              									<option value="<c:out value="${status.statusName}"/>" <c:if test="${projMap.p_status[0] eq status.statusName}">selected="selected"</c:if>><c:out value="${status.statusName}"/></option>
              								</c:when>
              								<c:otherwise>
              									<option value="<c:out value="${status.statusName}"/>" <c:if test="${!Add and (proj.salesStatusName eq status.statusName)}">selected="selected"</c:if>><c:out value="${status.statusName}"/></option>
              								</c:otherwise>
              							</c:choose>
              						</c:forEach>
                				</select>
               				</td>
            			</tr>
            			<tr>
              				<th>プロジェクト名</th>
               				<td>
               					<input type="text" name="p_name" class="p_name"
              						<c:choose>
              							<c:when test="${error.isError}">value="<c:out value="${projMap.p_name[0]}"/>"</c:when>
              							<c:otherwise>
              								<c:if test="${!Add}">value="<c:out value="${proj.projName}"/>"</c:if>
              							</c:otherwise>
              						</c:choose>
              					>
							</td>
            			</tr>
            			<tr>
              				<th>売上先　※</th>
              				<td>
              					<input type="text" name="p_cus" list="p_cus_list" id="p_cus" class="customer" autocomplete="off"
              						<c:choose>
              							<c:when test="${error.isError}">value="<c:out value="${projMap.p_cus[0]}"/>"</c:when>
              							<c:otherwise>
              								<c:if test="${!Add}">value="<c:out value="${proj.customerName}"/>"</c:if>
              							</c:otherwise>
              						</c:choose>
              					>
              					<datalist id="p_cus_list"> <%--ここはコンボボックスの中身 --%>
              						<c:forEach var="customer" items="${customerList}">
              							<option value="<c:out value="${customer.customerName}"/>"></option>
              						</c:forEach>
              					</datalist>
              				</td>
            			</tr>
            			<tr>
              				<th>エンドユーザー</th>
              				<td>
              					<input type="text" name="p_end_user" list="p_end_user_list" id="p_end_user" class="customer" autocomplete="off"
              						<c:choose>
              							<c:when test="${error.isError}">value="<c:out value="${projMap.p_end_user[0]}"/>"</c:when>
              							<c:otherwise>
              								<c:if test="${!Add}">value="<c:out value="${proj.endUserName}"/>"</c:if>
              							</c:otherwise>
              						</c:choose>
              					>
              					<datalist id="p_end_user_list"> <%--ここはコンボボックスの中身 --%>
              						<c:forEach var="customer" items="${customerList}">
              							<option value="<c:out value="${customer.customerName}"/>"></option>
              						</c:forEach>
              					</datalist>
              				</td>
            			</tr>
            			<tr>
              				<th>受注金額</th>
              				<td>
              					<input type="text" name="p_order_money"
              						<c:choose>
              							<c:when test="${error.isError}">value="${projMap.p_order_money[0]}"</c:when>
              							<c:otherwise>
              								<c:if test="${!Add}">value="${proj.valueOfOrder}"</c:if>
              							</c:otherwise>
              						</c:choose>
              					>円
              				</td>
            			</tr>
            			<tr>
              				<th>受注月</th>
              				<td>
              					<input type="text"  class="dp1 monthsize" name="p_order_month" id="p_order_month" readonly
              						<c:choose>
              							<c:when test="${error.isError}">value="${projMap.p_order_month[0]}"</c:when>
              							<c:otherwise>
              								<c:if test="${!Add}">value="<fmt:formatDate value='${proj.dateOfOrders}' pattern='yyyy-MM'/>"</c:if>
              							</c:otherwise>
              						</c:choose>
              					>
              				</td>
            			</tr>
            			<tr>
              				<th>売上月</th>
              				<td>
              					<input type="text"  class="dp1 monthsize" name="p_sales_month" id="p_sales_month" readonly
              						<c:choose>
              							<c:when test="${error.isError}">value="${projMap.p_sales_month[0]}"</c:when>
              							<c:otherwise>
              								<c:if test="${!Add}">value="<fmt:formatDate value='${proj.dateOfSales}' pattern='yyyy-MM'/>"</c:if>
              							</c:otherwise>
              						</c:choose>
              					>
              				</td>
            			</tr>
            			<tr>
              				<th>入金月</th>
              				<td>
              					<input type="text"  class="dp1 monthsize" name="p_pay_month" id="p_pay_month" readonly
              						<c:choose>
              							<c:when test="${error.isError}">value="${projMap.p_pay_month[0]}"</c:when>
              							<c:otherwise>
              								<c:if test="${!Add}">value="<fmt:formatDate value='${proj.dayOfPayment}' pattern='yyyy-MM'/>"</c:if>
              							</c:otherwise>
              						</c:choose>
              					>
            				</td>
            			</tr>
            			<tr>
              				<th>備　　考</th>
              				<td>
								<c:choose>
									<c:when test="${error.isError}"><!-- <textarea>で囲んだ範囲すべてが表示される(空白として)ため、省略不可 -->
										<textarea name="p_remarks" rows="5" class="remarks"><c:out value="${projMap.p_remarks[0]}"/></textarea>
									</c:when>
									<c:otherwise>
										<c:choose>
											<c:when test="${!Add}"><textarea name="p_remarks" rows="5" class="remarks"><c:out value="${proj.remarks}"/></textarea></c:when>
											<c:otherwise><textarea name="p_remarks" rows="5" class="remarks"></textarea></c:otherwise>
										</c:choose>
									</c:otherwise>
								</c:choose>
              				</td>
            			</tr>
				</table>
			</td>
      	</tr>
      	<tr>
        	<td>
<br>
          		<table class="proj_edit_table">
            		<tr>
              			<th>発行日　※</th>
              			<td>
              				<input type="text" class="dp2 monthsize" name="p_issue_day"  id="p_issue_day" readonly
              					<c:choose>
              						<c:when test="${error.isError}">value="${projMap.p_issue_day[0]}"</c:when>
              						<c:otherwise>
              							<c:choose>
              								<c:when test="${Edit}">value="<fmt:formatDate value='${proj.issuedDate}' pattern='yyyy-MM-dd'/>"</c:when>
              								<c:otherwise>value="${dateToday}"</c:otherwise>
              							</c:choose>
              						</c:otherwise>
              					</c:choose>
              				>
              			</td>
            		</tr>
          			<tr>
              			<th>開発期間</th>
              			<td>
              				<input type="text"  class="dp2 monthsize" name="p_dev_start" id="p_dev_start" readonly
              					<c:choose>
              						<c:when test="${error.isError}">value="${projMap.p_dev_start[0]}"</c:when>
              						<c:otherwise>
              							<c:if test="${!Add}">value="${proj.devStartTime}"</c:if>
              						</c:otherwise>
              					</c:choose>
              				>～
              				<input type="text"  class="dp2 monthsize" name="p_dev_end" id="p_dev_end" readonly
              					<c:choose>
              						<c:when test="${error.isError}">value="${projMap.p_dev_end[0]}"</c:when>
              						<c:otherwise>
              							<c:if test="${!Add}">value="${proj.devEndTime}"</c:if>
              						</c:otherwise>
              					</c:choose>
              				>
              			</td>
            		</tr>
            		<tr>
              			<th>開発予算</th>
              			<td>
              				<input type="text" name="p_dev_budget"
              					<c:choose>
              						<c:when test="${error.isError}">value="${projMap.p_dev_budget[0]}"</c:when>
              						<c:otherwise>
              							<c:if test="${!Add}">value="${proj.devBudgets}"</c:if>
              						</c:otherwise>
              					</c:choose>
              				>円
              			</td>
            		</tr>
            		<!-- 追加：インターノウス -->
            		<!-- ここから -->
            		<tr>
              			<th>工数単価</th>
              			<td>
              				<input type="text" name="p_unit_price"
              					<c:choose>
              						<c:when test="${error.isError}">value="${projMap.p_unit_price[0]}"</c:when>
              						<c:otherwise>
              							<c:if test="${!Add and Edit}">value="${proj.unitPrice}"</c:if>
              							<c:if test="${Add or !Edit}">value="${defaultUnitPrice}"</c:if>
              						</c:otherwise>
              					</c:choose>
              				>円
              			</td>
            		</tr>
            		<!-- ここまで -->
            		<tr>
            			<th>添付資料</th>
            			<td>
            				<c:if test="${Edit}">
            					<c:if test="${!empty attachFileBeanList}">
            						<div class="file_area" id="file_area">
            							<b>アップロード済み</b>
            							<table class="filearea">
            								<c:forEach var="attachment" items="${attachFileBeanList}" varStatus="status">
            									<tr>
            										<td class="filecheckbox"><input type="checkbox" name="p_doc_box" value="${attachment.id}" class="input_file_checkbox"></td>
            										<td class="filename"><c:out value="${attachment.fileName}"/></td>
            									</tr>
            									<!-- hiddenに添付ファイルのid,nameをセットする -->
            									<input type="hidden" name="fileID${status.count}" value="${attachment.id}"/>
            									<input type="hidden" name="fileName${status.count}" value="<c:out value="${attachment.fileName}"/>"/>
            								</c:forEach>
            							</table>
            						</div>
            					</c:if>
            					<!-- 添付ファイルの数をhiddenにセットする -->
            					<input type="hidden" name="fileSize" value="${fn:length(attachFileBeanList)}">
            				</c:if>
            				<input id="my_file_element" type="file" name="p_doc_1"><br>
            				Files:
            				<div id="files_list"></div>
            			</td>
            		</tr>
            		<tr>
              			<th>リーダー</th>
              			<td>
              				<input type="text" name="p_leader" class="member"
              					<c:choose>
             						<c:when test="${error.isError}">value="<c:out value="${projMap.p_leader[0]}"/>"</c:when>
              						<c:otherwise>
              							<c:if test="${!Add}">value="<c:out value="${proj.projLeader}"/>"</c:if>
              						</c:otherwise>
              					</c:choose>
              				>
              			</td>
            		</tr>
            		<tr>
              			<th>メンバー</th>
              			<td>
              				<input type="text" name="p_member" class="member"
              					<c:choose>
             						<c:when test="${error.isError}">value="<c:out value="${projMap.p_member[0]}"/>"</c:when>
              						<c:otherwise>
              							<c:if test="${!Add}">value="<c:out value="${proj.projMember}"/>"</c:if>
              						</c:otherwise>
              					</c:choose>
              				>
              			</td>
            		</tr>
          		</table>
			</td>
      	</tr>
      	<tr>
        	<td>
<br>
          		<table class="proj_edit_table">
            		<tr>
     					<th>通知</th>
              			<td>
                			<table class="proj_edit_notiuser_table">
                  				<tr>
                  					<!-- 追加：インターノウス -->
                  					<tr>
                  						<td>
                  							<span>所属：</span>
                  							<!--
                  							<select name="selected_user_group_member" style="width: 122px;">
                  								<option value="" selected>全て</option>
                  								<c:forEach items="${userGroupList}" var="group">
									                <option value="<c:out value="${group.id}"/>"
									                <c:if test="${error.isError and group.id eq accountMap.usergroup_id[0]}"> selected="selected"</c:if>
									                ><c:out value="${group.userGroupName}"/></option>
									            </c:forEach>
                  							</select>
                  							-->
                  							<select id="userGroupList" name="selected_user_group_member" class="input_box"style="width: 122px;">
												<option value="0">全て</option>
												<c:forEach items="${userGroupList}" var="group" varStatus="status">
												<c:out value="${status.index}" />
													<option value="<c:out value="${group.id}"/>"><c:out value="${group.userGroupName}"/></option>
												</c:forEach>
											</select>
                  						</td>
                  					</tr>
                  					<!-- 追加：インターノウス -->
                  					<!--
                  					<td>
                  						<select name="p_notice_all" id="p_notice_all_id" multiple="multiple" class="notiuser">
                  							<c:forEach var="lUserBean" items="${userList}">
                  								<option value="${lUserBean.employeeNum}"><c:out value="${lUserBean.secondName} ${lUserBean.firstName}"/></option>
                  							</c:forEach>
                  						</select>
                  					</td>
                  					 -->
                  					<td>
                  					  <select id="p_notice_all_id" name="p_notice_all" multiple="multiple" class="notiuser">
										<optgroup label="0">
										 <c:forEach var="lUserBean" items="${userList}">
										 	<option value='<c:out value="${lUserBean.employeeNum}"></c:out>'><c:out value="${lUserBean.secondName}"></c:out> <c:out value="${lUserBean.firstName}"></c:out></option>
										 </c:forEach>
										</optgroup>
										<c:forEach items="${userGroupList}" var="group" varStatus="status">
											<optgroup label="<c:out value="${group.id}"/>">
											<c:forEach items="${group.getUserGroupMemberList()}" var="userGroupMember">
												<c:forEach var="lUserBean" items="${userList}">
													<c:if test="${userGroupMember.employeeNum == lUserBean.employeeNum and userGroupMember.userGroupTblId == group.id}">
										                <option value='<c:out value="${lUserBean.employeeNum}"></c:out>'><c:out value="${lUserBean.secondName}"></c:out> <c:out value="${lUserBean.firstName}"></c:out></option>
													</c:if>
												</c:forEach>
											</c:forEach>
											</optgroup>
										</c:forEach>
										<!-- ここまで -->
									  </select>
                  					</td>
                  					<td>
                  						<input type="button" name="right" value="≫" /><br><br>
                  						<input type="button" name="left" value="≪" />
                  					</td>
                  					<td>
                  						<select name="p_notice_choice" id="p_notice_choice_id" multiple="multiple" class="notiuser">
                  							<c:choose>
                  								<c:when test="${error.isError}">
                  									<c:forEach var="empID" items="${projMap.p_notice_choice}">
                  										<c:forEach var="eUserBean" items="${userList}">
                  											<c:if test="${empID eq eUserBean.employeeNum}">
                  												  <option value="${empID}"><c:out value="${eUserBean.secondName} ${eUserBean.firstName}"/></option>
                  											</c:if>
                  										</c:forEach>
                  									</c:forEach>
                  								</c:when>
                  								<c:otherwise>
                  									<c:choose>
                  										<c:when test="${!Add}">
                  											<c:forEach var="notiUserBean" items="${notiUserBeanList}">
                  												<c:forEach var="naUserBean" items="${userList}">
                  													<c:if test="${notiUserBean.employeeNum eq naUserBean.employeeNum}">
                  														<option value="${notiUserBean.employeeNum}"><c:out value="${naUserBean.secondName} ${naUserBean.firstName}"/></option>
                  													</c:if>
                  												</c:forEach>
                  											</c:forEach>
                  										</c:when>
                  										<c:otherwise>
                  											<c:forEach var="aUserBean" items="${userList}">
                  												<c:if test="${aUserBean.defNotification}">
                  													<option value="${aUserBean.employeeNum}"><c:out value="${aUserBean.secondName} ${aUserBean.firstName}"/></optoin>
                  												</c:if>
                  											</c:forEach>
                  										</c:otherwise>
                  									</c:choose>
                  								</c:otherwise>
                  							</c:choose>
                  						</select>
                  					</td>
                		  		</tr>
                  			</table>
             			</td>
            		</tr>
           			<c:if test="${!Edit}">
            			<tr>
              				<th>売りWin反映　※</th>
              				<td><input type="checkbox"  name="p_winlist_ref" value="true"
              				<c:if test="${ !error.isError or (error.isError and !empty projMap.p_winlist_ref[0]) }">
              				checked
              				</c:if>
              				> 売りWin案件に反映させる</td>
            			</tr>
            		</c:if>
          		</table>
<br>
        	</td>
      	</tr>
      	<tr>
        	<td>
          		<div class="proj_edit_button">
					<c:choose>
						<c:when test="${!Edit}">
							<button type="button" value="p_add" onClick="return p_add() && setActionToHidden(this) && submit();">P番発行</button>
						</c:when>
						<c:otherwise>
							<button type="button" value="p_edit" onClick="return p_edit() && setActionToHidden(this) && submit();">変更</button>
							<input type="hidden" name="p_id"
								<c:choose>
									<c:when test="${error.isError}">value="${projMap.p_id[0]}"</c:when>
									<c:otherwise>value="${proj.id}"</c:otherwise>
								</c:choose>
							>
						</c:otherwise>
					</c:choose>
         			<button type="button" onClick="return setActionToHidden(this) && submit();"
                		<c:choose>
                  			<%-- P番新規追加 戻るボタン --%>
                  			<c:when test="${!Edit}">value="p_add_return"</c:when>
                  			<%-- P番新規追加 戻るボタン --%>
                  			<c:otherwise> value="p_edit_return"</c:otherwise>
                  		</c:choose>
              		>戻る</button><%-- 戻る左側の「>」はbuttonタグの閉じのため消さない --%>
            	</div>
        	</td>
     	</tr>
    </table>
	<input type="hidden" name="action" value="" id="action_id">
</form>

<%--添付ファイルのjavascript--%>
<script src="multi_upload.js"></script>

<%
  //共通モジュールに渡すエラーリストをリクエストスコープにセット
  request.setAttribute("errorMessageList", errorMessageList);
%>
<jsp:include page="include_error_message.jsp" flush="true"/>
</body>
</html>