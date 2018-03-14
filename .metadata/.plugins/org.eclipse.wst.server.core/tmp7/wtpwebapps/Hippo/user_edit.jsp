<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ page import="java.util.HashMap"%>
<%@ page import="jp.co.lsij.p16590004.common.Error" %>
<%@ page import="java.util.ArrayList" %>

<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<meta name="format-detection" content="telephone=no">

<script src="InputPatternDef.js"></script>
<script src="LimitDef.js"></script>
<script src="ObjUtil.js"></script>
<script src="BrowserBackPrevent.js"></script>
<script src="displayFrameTitle.js"></script>
<script src="InputTextCheck.js"></script>
<script src="button_util.js"></script>
<script src="user_edit.js"></script>

<link href="CSS/Normalize.css" rel="stylesheet" type="text/css">
<link href="CSS/p16590004.css" rel="stylesheet" type="text/css">
<link href="CSS/user_edit.css" rel="stylesheet" type="text/css">

<c:if test="${formID == 'add'}" var="Add"/>
<c:if test="${Add}">
<title>ユーザー追加</title>
</c:if>
<c:if test="${formID == 'edit'}" var="Edit"/>
<c:if test="${Edit}">
<title>ユーザー編集</title>
<%--
<title>ユーザー情報編集</title>
--%>
</c:if>

<%
//例外処理をまとめるのに使用
ArrayList<String> errorMessageList = new ArrayList<String>();
%>

</head>
<body>
<c:if test="${Add}">
  <h3 class="page_title">ユーザー追加</h3>
<%--
  <h3 class="user_edit_title">ユーザー追加</h3>
--%>
</c:if>
<c:if test="${Edit}">
  <h3 class="page_title">ユーザー編集</h3>
<%--
  <h3 class="user_edit_title">ユーザー情報編集</h3>
--%>
</c:if>

<%--エラー表示を行う箇所 --%>
<c:choose>
  <c:when test="${error.isError}">
    <p class="error_message"><c:out value="${error.errorInfo}" /></p>
<%-- エスケープさせるため
    <p class="error_message">${error.errorInfo}</p>
--%>
  </c:when>
  <c:otherwise></c:otherwise>
</c:choose>
<br>
<form id="Mainform" name="Useredit" action="./SystemOptionController" method="POST">
<table class="user_edit_out_table">
  <tr>
    <td>
      <table class="user_edit_table">
        <tr>
          <th class="user_edit_table">社員番号　※</th>
          <%--新規追加時の処理 --%>
          <c:choose>
            <c:when test="${Add}">
              <td class="user_edit_table">
                <INPUT type="text" name="user_number" class="user_edit_table"
                  <c:choose>
                    <c:when test="${error.isError}">value="<c:out value="${userMap.user_number[0]}" />"</c:when>
<%-- エスケープさせるため
                    <c:when test="${error.isError}">value="${userMap.user_number[0]}"</c:when>
--%>
                    <c:otherwise>value=""</c:otherwise>
                  </c:choose>
                >
              </td>
            </c:when>
            <%--編集時の処理 --%>
            <c:when test="${Edit}">
              <td class="user_edit_table">
                <input type="text" name="user_number" class="edit_readonly"
                  <c:choose>
                    <c:when test="${error.isError}">value="<c:out value="${userMap.user_number[0]}" />" readonly</c:when>
                    <c:otherwise>value="<c:out value="${user.employeeNum}" />" readonly</c:otherwise>
<%-- エスケープさせるため
                    <c:when test="${error.isError}">value="${userMap.user_number[0]}" readonly</c:when>
                    <c:otherwise>value="${user.employeeNum}" readonly</c:otherwise>
--%>
                  </c:choose>
                >
              </td>
            </c:when>
          </c:choose>
        </tr>
        <tr>
          <th rowspan="2" class="user_edit_table">氏名　※</th>
          <%--新規追加時の処理 --%>
          <c:choose>
            <c:when test="${Add}">
              <td class="user_edit_table">姓：
                <INPUT type="text" name="user_sei" size="10" class="name"
                  <c:choose>
                    <c:when test="${error.isError}">value="<c:out value="${userMap.user_sei[0]}" />"</c:when>
<%-- エスケープさせるため
                    <c:when test="${error.isError}">value="${userMap.user_sei[0]}"</c:when>
--%>
                    <c:otherwise>value=""</c:otherwise>
                  </c:choose>
                >
              </td>
            </c:when>
            <%--編集時の処理 --%>
            <c:when test="${Edit}">
              <td class="user_edit_table">姓：
                <INPUT type="text" name="user_sei" size="10" class="name edit_readonly"
                  <c:choose>
                    <c:when test="${error.isError}">value="<c:out value="${userMap.user_sei[0]}" />" readonly</c:when>
                    <c:otherwise>value="<c:out value="${user.secondName}" />" readonly</c:otherwise>
<%-- エスケープさせるため
                    <c:when test="${error.isError}">value="${userMap.user_sei[0]}" readonly</c:when>
                    <c:otherwise>value="${user.secondName}" readonly</c:otherwise>
--%>
                  </c:choose>
                >
              </td>
            </c:when>
          </c:choose>
        </tr>
        <tr>
          <%--新規追加時の処理 --%>
          <c:choose>
            <c:when test="${Add}">
              <td class="user_edit_table">名：
                <INPUT type="text" name="user_mei" size="10" class="name"
                  <c:choose>
                    <c:when test="${error.isError}">value="<c:out value="${userMap.user_mei[0]}" />"</c:when>
<%-- エスケープさせるため
                    <c:when test="${error.isError}">value="${userMap.user_mei[0]}"</c:when>
--%>
                    <c:otherwise>value=""</c:otherwise>
                  </c:choose>
                >
              </td>
            </c:when>
            <%--編集時の処理 --%>
            <c:when test="${Edit}">
              <td class="user_edit_table">名：
                <INPUT type="text" name="user_mei" size="10" class="name edit_readonly"
                  <c:choose>
                    <c:when test="${error.isError}">value="<c:out value="${userMap.user_mei[0]}" />" readonly</c:when>
                    <c:otherwise>value="<c:out value="${user.firstName}" />" readonly</c:otherwise>
<%-- エスケープさせるため
                    <c:when test="${error.isError}">value="${userMap.user_mei[0]}" readonly</c:when>
                    <c:otherwise>value="${user.firstName}" readonly</c:otherwise>
--%>
                  </c:choose>
                >
              </td>
            </c:when>
          </c:choose>
          </tr>
          <tr>
            <th class="user_edit_table">権限　※</th>
              <td class="user_edit_table">
                <c:choose>
                  <%--新規追加時の処理 --%>
                  <c:when test="${Add}">
                    <select name="user_authority" class="user_authority">
                      <c:choose>
                        <c:when test="${error.isError}">
                          <option value="Administrator" <c:if test="${userMap.user_authority[0] eq 'Administrator'}">selected="selected"</c:if> >Administrator</option>
                          <option value="Poweruser" <c:if test="${userMap.user_authority[0] eq 'Poweruser'}">selected="selected"</c:if> >Poweruser</option>
                          <option value="User" <c:if test="${userMap.user_authority[0] eq 'User'}">selected="selected"</c:if> >User</option>
                        </c:when>
                        <c:otherwise>
                          <option value="Administrator" selected="selected">Administrator</option>
                          <option value="Poweruser">Poweruser</option>
                          <option value="User">User</option>
<%--不具合(Modified by dai)
                          <option value="Administrator" <c:if test="${userMap.user_authority[0] eq 'Administrator'}">selected="selected"</c:if> >Administrator</option>
                          <option value="Poweruser" <c:if test="${userMap.user_authority[0] eq 'Poweruser'}">selected="selected"</c:if> >Poweruser</option>
                          <option value="User" <c:if test="${userMap.user_authority[0] eq 'User'}">selected="selected"</c:if> >User</option>
--%>
                        </c:otherwise>
                      </c:choose>
                    </select>
                  </c:when>
                  <c:when test="${Edit}">
                    <select name="user_authority" class="user_authority">
                      <c:choose>
                        <c:when test="${error.isError}">
                          <option value="Administrator" <c:if test="${userMap.user_authority[0] eq 'Administrator'}">selected="selected"</c:if> >Administrator</option>
                          <option value="Poweruser" <c:if test="${userMap.user_authority[0] eq 'Poweruser'}">selected="selected"</c:if> >Poweruser</option>
                          <option value="User" <c:if test="${userMap.user_authority[0] eq 'User'}">selected="selected"</c:if> >User</option>
                        </c:when>
                        <c:otherwise>
                          <option value="Administrator" <c:if test="${user.userCategory eq 'Administrator'}">selected="selected"</c:if> >Administrator</option>
                          <option value="Poweruser" <c:if test="${user.userCategory eq 'Poweruser'}">selected="selected"</c:if> >Poweruser</option>
                          <option value="User" <c:if test="${user.userCategory eq 'User'}">selected="selected"</c:if> >User</option>
                        </c:otherwise>
                      </c:choose>
                    </select>
                  </c:when>
                </c:choose>
              </td>
            </tr>
            <tr>
              <th class="user_edit_table">パスワード</th>
              <c:choose>
              <%--新規追加時の処理 --%>
                <c:when test="${Add}">
                  <td class="user_edit_table">
                    <INPUT type="password" name="user_pass" class="user_edit_table"
<%-- パスワード非表示に変更
                    <INPUT type="text" name="user_pass" class="user_edit_table"
--%>
                      <c:choose>
                        <c:when test="${error.isError}">value="<c:out value="${userMap.user_pass[0]}" />"</c:when>
<%-- エスケープさせるため
                        <c:when test="${error.isError}">value="${userMap.user_pass[0]}"</c:when>
--%>
                        <c:otherwise>value=""</c:otherwise>
                      </c:choose>
                    >
                  </td>
                </c:when>
                <c:when test="${Edit}">
                  <td class="user_edit_table">
                    <INPUT type="password" name="user_pass" class="user_edit_table"
<%-- パスワード非表示に変更
                    <INPUT type="text" name="user_pass" class="user_edit_table"
--%>
                      <c:choose>
                        <c:when test="${error.isError}">value="<c:out value="${userMap.user_pass[0]}" />"</c:when>
                        <c:otherwise>value="<c:out value="${user.empPassword}" />"</c:otherwise>
<%-- エスケープさせるため
                        <c:when test="${error.isError}">value="${userMap.user_pass[0]}"</c:when>
                        <c:otherwise>value="${user.empPassword}"</c:otherwise>
--%>
                      </c:choose>
                    >
                  </td>
                </c:when>
              </c:choose>
            </tr>
            <tr>
              <th class="user_edit_table">メールアドレス　※</th>
              <c:choose>
                <%--新規追加時の処理 --%>
                  <c:when test="${Add}">
                  <td class="user_edit_table">
                    <input type="text" name="user_mail" class="user_edit_table"
                      <c:choose>
                        <c:when test="${error.isError}">value="<c:out value="${userMap.user_mail[0]}" />"</c:when>
<%-- エスケープさせるため
                        <c:when test="${error.isError}">value="${userMap.user_mail[0]}"</c:when>
--%>
                        <c:otherwise>value=""</c:otherwise>
                      </c:choose>
                    >
                    </td>
                  </c:when>
                  <c:when test="${Edit}">
                  <td class="user_edit_table">
                    <input type="text" name="user_mail" class="user_edit_table"
                      <c:choose>
                        <c:when test="${error.isError}">value="<c:out value="${userMap.user_mail[0]}" />"</c:when>
                        <c:otherwise>value="<c:out value="${user.mailAddress}" />"</c:otherwise>
<%-- エスケープさせるため
                        <c:when test="${error.isError}">value="${userMap.user_mail[0]}"</c:when>
                        <c:otherwise>value="${user.mailAddress}"</c:otherwise>
--%>
                      </c:choose>
                    >
                    </td>
                  </c:when>
              </c:choose>
            </tr>
            <tr>
            <th>デフォルト通知　※</th>
              <%--新規追加時の処理 --%>
              <%-- <c:if test="${Add}"> --%>
              <c:choose>
                <c:when test="${Add}">
                  <td>
                    <c:choose>
                      <%--エラー時 --%>
                      <c:when test="${error.isError}">
                        <input type="radio" class="radio_button" name="user_default" value="on" <c:if test="${userMap.user_default[0] == 'on' }">checked</c:if>>ON　　
                        <input type="radio" class="radio_button" name="user_default" value="off" <c:if test="${userMap.user_default[0] == 'off' }">checked</c:if>>OFF
                      </c:when>
                      <%--通常時 --%>
                      <c:otherwise>
                        <input type="radio" class="radio_button" name="user_default" value="on">ON　　<input type="radio" class="radio_button" name="user_default" value="off" checked>OFF
                      </c:otherwise>
                    </c:choose>
                  </td>
                </c:when>
              
              
              <%--編集時の処理 --%>
              <%--<c:if test="${Edit}">--%>
                <c:when test="${Edit}">
                  <td>
                    <c:choose>
                      <%--エラー時 --%>
                      <c:when test="${error.isError}">
                        <input type="radio" class="radio_button" name="user_default" value="on" <c:if test="${userMap.user_default[0] == 'on' }">checked</c:if>>ON　　
                        <input type="radio" class="radio_button" name="user_default" value="off" <c:if test="${userMap.user_default[0] == 'off' }">checked</c:if>>OFF
                      </c:when>
                      <c:otherwise>
                        <c:if test="${user.defNotification}" var="defNotification"/>
                        <c:if test="${defNotification}">
                          <input type="radio" class="radio_button" name="user_default" value="on" checked>ON　　<input type="radio" class="radio_button" name="user_default" value="off">OFF
                        </c:if>
                        <c:if test="${!defNotification}">
                          <input type="radio" class="radio_button" name="user_default" value="on">ON　　<input type="radio" class="radio_button" name="user_default" value="off" checked>OFF
                        </c:if>
                      </c:otherwise>
                    </c:choose>
                  </td>
                </c:when>
              </c:choose>
            </tr>
          </table>
        </td>
      </tr>
      <tr>
        <td>
        <div class="user_edit_button">
        <br>
        <%--新規追加時の処理 --%>
          <c:choose>
            <c:when test="${Add}">
              <button type="button" value="user_add" onClick="return user_add() && setActionToHidden(this) && submit();">追加</button>
            </c:when>
            <c:when test="${Edit}">
              <button type="button" value="user_edit" onClick="return user_edit() && setActionToHidden(this) && submit();">変更</button>
              <%-- <input type="hidden" name="user_id" value="${user.id}"> --%>
              
              <c:choose>
                  <%-- エラー時 --%>
                  <c:when test="${error.isError}">
                    <input type="hidden" name="user_id" value="${userMap.user_id[0]}">
                  </c:when>
                  <%-- 通常時 --%>
                  <c:otherwise>
                    <input type="hidden" name="user_id" value="${user.id}">
                  </c:otherwise>
              </c:choose>
              
            </c:when>
          </c:choose>
          <button type="button" onClick="return setActionToHidden(this) && submit();" 
            <c:choose>
              <c:when test="${Add}"> value="user_add_return" </c:when>
              <c:when test="${Edit}">value="user_edit_return" </c:when>
            </c:choose>
          >戻る</button>
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
