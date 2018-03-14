<%-- <%@ page session="false" %> --%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="jp.co.lsij.p16590004.e_77.model.master.beans.UserBean" %>
<!DOCTYPE html>
<html lang="ja">
<head>
<meta charset="UTF-8">
<meta name="format-detection" content="telephone=no">
<title>メニュー</title>

<%
//#if 1//New
//base.jsp を経由して、requestを送れないようなので、
//ここのみセッションを使用する
//UserBean all =(UserBean)request.getAttribute("account");
String useraut = "";
if (null == session) {

} else if( session.getAttribute( "account" ) == null ) {
  session.invalidate();
} else {
  UserBean all =(UserBean)session.getAttribute("account");
  useraut = all.getUserCategory();
}
//#elseオリジナル
//String useraut;
//UserBean all =(UserBean)session.getAttribute("account");
//useraut = all.getUserCategory();
//#endif
%>

  <script src="BrowserBackPrevent.js"></script>
  <script src="menu.js"></script>

  <link href="CSS/Normalize.css" rel="stylesheet" type="text/css">
  <link href="CSS/p16590004.css" rel="stylesheet" type="text/css">
  <link href="CSS/menu.css" rel="stylesheet" type="text/css">

</head>
<body>
  <br>
  <fieldset class="high_area">
    <legend>
      <b class="high_index">P番</b>
    </legend>
    <table class="all_width">
      <tr id="S0">
        <td class="p_list content_title">


          <form name="p_number_list" method="POST"
            action="./MenuController" Target="right">
            <input type="hidden" name="action" value="p_number_list">
            <a href="javascript:document.p_number_list.submit()">P番一覧</a>
          </form>

        </td>
      </tr>
      <tr id="SS0">
        <td class="p_list content_title">

          <form name="p_number_list_limit" method="POST"
            action="./MenuController" Target="right">
            <input type="hidden" name="action"
              value="p_number_list_limit"> <a
              href="javascript:document.p_number_list_limit.submit()">P番一覧</a>
          </form>

        </td>
      </tr>

      <!-- 追加：インターノウス -->
      <!-- ここから -->
      <tr id="purchase_import_area">
        <td class="purchase_import content_title">
          <form name="p_purchase_import" method="POST"
            action="./MenuController" Target="right">
            <input type="hidden" name="action"
              value="p_purchase_import"> <a
              href="javascript:document.p_purchase_import.submit()">仕入れデータ</a>
          </form>
        </td>
      </tr>
      <!-- ここまで -->
    </table>
  </fieldset>
  <br>
  <fieldset class="middle_area">
    <legend>
      <b class="middle_index">売りwin</b>
    </legend>
    <table class="all_width">
      <tr id="S1">

        <td class="sales_list content_title">
          <form name="win_list" method="POST"
            action="./MenuController" Target="right">
            <input type="hidden" name="action" value="win_list">
            <a href="javascript:document.win_list.submit()">案件一覧</a>
          </form>
        </td>

      </tr>
      <tr id="SS1">

        <td class="sales_list content_title">
          <form name="win_list_limit" method="POST"
            action="./MenuController" Target="right">
            <input type="hidden" name="action" value="win_list_limit">
            <a href="javascript:document.win_list_limit.submit()">案件一覧</a>
          </form>
        </td>

      </tr>

      <tr id="S2">
        <td class="summary content_title">総計</td>

        <td class="summary table_type">
          <form name="summary" method="POST"
            action="./MenuController" Target="right">
            <input type="hidden" name="action" value="summary">
            <a href="javascript:document.summary.submit()">現在</a>
          </form>
        </td>

        <td class="summary table_type">
          <form name="summary_old" method="POST"
            action="./MenuController" Target="right">
            <input type="hidden" name="action" value="summary_old">
            <a href="javascript:document.summary_old.submit()">過去</a>
          </form>
        </td>

      </tr>
      <tr id="S3">
        <td class="another_total content_title">受注・売上月別合計</td>

        <td class="another_total table_type">
          <form name="another_total" method="POST"
            action="./MenuController" Target="right">
            <input type="hidden" name="action" value="another_total">
            <a href="javascript:document.another_total.submit()">現在</a>
          </form>
        </td>

        <td class="another_total table_type">
          <form name="another_total_old" method="POST"
            action="./MenuController" Target="right">
            <input type="hidden" name="action" value="another_total_old">
            <a href="javascript:document.another_total_old.submit()">過去</a>
          </form>
        </td>

      </tr>
      <tr id="S4">
        <td class="all_total content_title">受注・売上総計</td>

        <td class="all_total table_type">
          <form name="all_total" method="POST"
            action="./MenuController" Target="right">
            <input type="hidden" name="action" value="all_total">
            <a href="javascript:document.all_total.submit()">現在</a>
          </form>
        </td>

        <td class="all_total table_type">
          <form name="all_total_old" method="POST"
            action="./MenuController" Target="right">
            <input type="hidden" name="action" value="all_total_old">
            <a href="javascript:document.all_total_old.submit()">過去</a>
          </form>
        </td>

      </tr>
      <tr id="S5">
        <td class="another_type_total content_title">総計分類別</td>

        <td class="another_type_total table_type">
          <form name="another_type_total" method="POST"
            action="./MenuController" Target="right">
            <input type="hidden" name="action"
              value="another_type_total"> <a
              href="javascript:document.another_type_total.submit()">現在</a>
          </form>
        </td>

        <td class="another_type_total table_type">
          <form name="another_type_total_old" method="POST"
            action="./MenuController" Target="right">
            <input type="hidden" name="action"
              value="another_type_total_old"> <a
              href="javascript:document.another_type_total_old.submit()">過去</a>
          </form>
        </td>

      </tr>
      <tr id="S6">

        <td class="meeting content_title">
          <form name="meeting_data" method="POST"
            action="./MenuController" Target="right">
            <input type="hidden" name="action" value="meeting_data">
            <a href="javascript:document.meeting_data.submit()">管理職会議用</a>
          </form>
        </td>


      </tr>
    </table>
  </fieldset>

  <br>
  <fieldset class="low_area">
    <legend>
      <b class="low_index">設定・その他</b>
    </legend>
    <table class="all_width">
      <tr id="S7">


        <td class="cat content_title">
          <form name="master_bunruiList" method="POST"
            action="./MenuController" Target="right">
            <input type="hidden" name="action" value="master_bunruiList">
            <a href="javascript:document.master_bunruiList.submit()">分類設定</a>
          </form>
        </td>

      </tr>
      <tr id="S8">

        <td class="status content_title">
          <form name="master_statusList" method="POST"
            action="./MenuController" Target="right">
            <input type="hidden" name="action" value="master_statusList">
            <a href="javascript:document.master_statusList.submit()">ステータス設定</a>
          </form>
        </td>

      </tr>
      <tr id="S9">

        <td class="customer content_title">
          <form name="master_clientList" method="POST"
            action="./MenuController" Target="right">
            <input type="hidden" name="action" value="master_clientList">
            <a href="javascript:document.master_clientList.submit()">顧客登録</a>
          </form>
        </td>

      </tr>
      <tr id="S10">
        <td class="user content_title">
          <form name="user_list" method="POST"
            action="./MenuController" Target="right">
            <input type="hidden" name="action" value="user_list">
            <a href="javascript:document.user_list.submit()">ユーザー一覧</a>
          </form>
        </td>

      </tr>
      <tr id="SS10">
        <td class="user content_title">
          <form name="user_list_limit" method="POST"
            action="./MenuController" Target="right">
            <input type="hidden" name="action" value="user_list_limit">
            <a href="javascript:document.user_list_limit.submit()">ユーザー一覧</a>
          </form>
        </td>
      </tr>
      <!-- 追加：インターノウス -->
      <!-- ここから -->
      <tr id="user_group_area">
        <td class="user_group content_title">
          <form name="user_group_list" method="POST"
            action="./MenuController" Target="right">
            <input type="hidden" name="action" value="user_group_list">
            <a href="javascript:document.user_group_list.submit()">ユーザーグループ設定</a>
          </form>
        </td>
      </tr>
      <!-- ここまで -->
      <tr id="S11">

        <td class="sales_user content_title">
          <form name="sales_user_list" method="POST"
            action="./MenuController" Target="right">
            <input type="hidden" name="action" value="sales_user_list">
            <a href="javascript:document.sales_user_list.submit()">営業担当目標設定</a>
          </form>
        </td>

      </tr>
      <tr id="S12">

        <td class="pass content_title">
          <form name="pass_option" method="POST"
            action="./MenuController" Target="right">
            <input type="hidden" name="action" value="pass_option">
            <a href="javascript:document.pass_option.submit()">パスワード設定</a>
          </form>
        </td>

      </tr>
      <tr id="S13">

        <td class="log content_title">
          <form name="log" method="POST"
            action="./MenuController" Target="right">
            <input type="hidden" name="action" value="log"> <a
              href="javascript:document.log.submit()">操作ログ</a>
          </form>
        </td>

      </tr>
    </table>
  </fieldset>


  <br>
<%-- URLがMenuControllerに書き換わってしまうので変更（"_top" を "right"へ変更）
  <form action="./MenuController" method="post"
    Target="_top">
--%>
  <form action="./MenuController" method="post"
    Target="right">
    <button type="submit" name="action" value="logout">ログアウト</button>

<%
out.println("<input type='hidden' name='useraut' id='useraut' value='" + useraut + "'/>");
%>

  </form>
  <br>
</body>
</html>