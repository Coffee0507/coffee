<%@ page session="false"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="jp.co.lsij.p16590004.common.Error"%>
<%@ page import="java.util.ArrayList"%>

<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<meta name="format-detection" content="telephone=no">

<script src="JS_LIB/jQuery/jquery-3.2.1.min.js" type="text/javascript"></script>

<script src="SelectBoxUtil.js"></script>
<script src="InputPatternDef.js"></script>
<script src="LimitDef.js"></script>
<script src="ObjUtil.js"></script>
<script src="BrowserBackPrevent.js"></script>
<script src="displayFrameTitle.js"></script>
<script src="InputTextCheck.js"></script>
<script src="button_util.js"></script>
<script src="user_group_edit.js"></script>

<link href="CSS/Normalize.css" rel="stylesheet" type="text/css">
<link href="CSS/p16590004.css" rel="stylesheet" type="text/css">
<link href="CSS/user_group_edit.css" rel="stylesheet" type="text/css">

<c:if test="${formID == 'add'}" var="Add" />
<c:if test="${Add}">
  <title>グループリスト追加</title>
</c:if>
<c:if test="${formID == 'edit'}" var="Edit" />
<c:if test="${Edit}">
  <title>グループリスト編集</title>
</c:if>

<%
  //例外処理をまとめるのに使用
  ArrayList<String> errorMessageList = new ArrayList<String>();
%>

</head>
<body>
  <c:if test="${Add}">
    <h3 class="page_title">グループリスト追加</h3>
  </c:if>
  <c:if test="${Edit}">
    <h3 class="page_title">グループリスト編集</h3>
  </c:if>

  <%--エラー表示を行う箇所 --%>
  <c:choose>
    <c:when test="${error.isError}">
      <p class="error_message">
        <c:out value="${error.errorInfo}" />
      </p>
    </c:when>
    <c:otherwise></c:otherwise>
  </c:choose>
  <br>

  <%--情報を表示、編集する箇所--%>
  <form id="Mainform" name="Usergroupedit"
    action="./SystemOptionController" method="POST">
    <table class="user_group_edit_out_table">
      <tr>
        <td>
          <table class="user_group_edit_table">
            <tr>
              <th class="user_group_edit_table">ユーザーグループ名 ※</th>
              <%--新規追加時の処理 --%>
              <c:choose>
                <c:when test="${Add}">
                  <td class="user_group_edit_table"><input
                    type="text" name="user_group_name" id="user_group_name"
                    class="user_group_edit_table" /></td>
                </c:when>
                <%--編集時の処理 --%>
                <c:when test="${Edit}">
                  <td class="user_group_edit_table"><input
                    type="text" name="user_group_name" id="user_group_name"
                    class="edit_readonly"
                    value="<c:out value="${userGroup.userGroupName}" />" readonly/>
                    <input type="hidden" name="user_group_id"
                    value="<c:out value="${userGroup.id}" />" /></td>
                </c:when>
              </c:choose>
            </tr>
          </table>
          <table>
            <tr>
              <td><br>
                <table class="user_group_edit_table">
                  <tr>
                    <th>メンバー</th>
                    <td>
                      <table class="selected_user_group_member_table">
                        <tr>
                          <td>
                            <select id="selected_user_group_member_all_id"
                              name="selected_user_group_member_all"
                              multiple="multiple" class="notiuser">
                              <c:forEach var="lUserBean"
                                items="${userList}">
                                <option
                                  value='<c:out value="${lUserBean.employeeNum}"></c:out>'>
                                  <c:out value="${lUserBean.secondName}"></c:out>
                                  <c:out value="${lUserBean.firstName}"></c:out></option>
                              </c:forEach>
                          </select>
                          </td>
                          <td><input type="button" name="right"
                            value="≫" /><br> <br> <input
                            type="button" name="left" value="≪" /></td>
                          <td><select
                            name="selected_user_group_member"
                            id="selected_user_group_member_id"
                            multiple="multiple" class="notiuser">
                              <c:choose>
                                <c:when test="${error.isError}">
                                  <c:forEach var="groupMember"
                                    items="${userGroup.userGroupMemberList}">
                                    <c:forEach var="aUserBean"
                                      items="${userList}">
                                      <c:if
                                        test="${groupMember.employeeNum eq eUserBean.employeeNum}">
                                        <option
                                          value="${groupMember.employeeNum}"><c:out
                                            value="${aUserBean.secondName} ${aUserBean.firstName}" /></option>
                                      </c:if>
                                    </c:forEach>
                                  </c:forEach>
                                </c:when>
                                <c:otherwise>
                                  <c:choose>
                                    <c:when test="${!Add}">
                                      <c:forEach var="groupMember"
                                        items="${userGroup.userGroupMemberList}">
                                        <c:forEach var="aUserBean"
                                          items="${userList}">
                                          <c:if
                                            test="${groupMember.employeeNum eq aUserBean.employeeNum}">
                                            <option
                                              value="${groupMember.employeeNum}"><c:out
                                                value="${aUserBean.secondName} ${aUserBean.firstName}" /></option>
                                          </c:if>
                                        </c:forEach>
                                      </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                    </c:otherwise>
                                  </c:choose>
                                </c:otherwise>
                              </c:choose>
                          </select></td>
                        </tr>
                      </table>
                    </td>
                  </tr>
                </table>
                <div class="user_group_edit_button">
                  <br>
                  <%--新規追加時の処理 --%>
                  <c:choose>
                    <c:when test="${Add}">
                      <button type="button" value="user_group_add"
                        onClick="check() && setActionToHidden(this) && submit();">追加</button>
                    </c:when>
                    <c:when test="${Edit}">
                      <button type="button" value="user_group_edit"
                        onClick="check() && setActionToHidden(this) && submit();">変更</button>
                    </c:when>
                  </c:choose>
                  <button type="button"
                    onClick="return setActionToHidden(this) && submit();"
                    <c:choose>
                      <c:when test="${Add}"> value="user_group_add_return" </c:when>
                      <c:when test="${Edit}">value="user_group_edit_return" </c:when>
                    </c:choose>>戻る
                  </button>
                </div></td>
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
  <jsp:include page="include_error_message.jsp" flush="true" />
</body>
</html>
