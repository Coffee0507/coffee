/*
 * Generated by the Jasper component of Apache Tomcat
 * Version: Apache Tomcat/8.0.32
 * Generated at: 2018-03-16 01:43:39 UTC
 * Note: The last modified time of this file was set to
 *       the last modified time of the source file after
 *       generation to assist with modification tracking.
 */
package org.apache.jsp;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.*;
import jp.co.lsij.p16590004.e_77.model.master.beans.UserBean;

public final class menu_jsp extends org.apache.jasper.runtime.HttpJspBase
    implements org.apache.jasper.runtime.JspSourceDependent,
                 org.apache.jasper.runtime.JspSourceImports {

  private static final javax.servlet.jsp.JspFactory _jspxFactory =
          javax.servlet.jsp.JspFactory.getDefaultFactory();

  private static java.util.Map<java.lang.String,java.lang.Long> _jspx_dependants;

  private static final java.util.Set<java.lang.String> _jspx_imports_packages;

  private static final java.util.Set<java.lang.String> _jspx_imports_classes;

  static {
    _jspx_imports_packages = new java.util.HashSet<>();
    _jspx_imports_packages.add("javax.servlet");
    _jspx_imports_packages.add("javax.servlet.http");
    _jspx_imports_packages.add("javax.servlet.jsp");
    _jspx_imports_classes = new java.util.HashSet<>();
    _jspx_imports_classes.add("jp.co.lsij.p16590004.e_77.model.master.beans.UserBean");
  }

  private volatile javax.el.ExpressionFactory _el_expressionfactory;
  private volatile org.apache.tomcat.InstanceManager _jsp_instancemanager;

  public java.util.Map<java.lang.String,java.lang.Long> getDependants() {
    return _jspx_dependants;
  }

  public java.util.Set<java.lang.String> getPackageImports() {
    return _jspx_imports_packages;
  }

  public java.util.Set<java.lang.String> getClassImports() {
    return _jspx_imports_classes;
  }

  public javax.el.ExpressionFactory _jsp_getExpressionFactory() {
    if (_el_expressionfactory == null) {
      synchronized (this) {
        if (_el_expressionfactory == null) {
          _el_expressionfactory = _jspxFactory.getJspApplicationContext(getServletConfig().getServletContext()).getExpressionFactory();
        }
      }
    }
    return _el_expressionfactory;
  }

  public org.apache.tomcat.InstanceManager _jsp_getInstanceManager() {
    if (_jsp_instancemanager == null) {
      synchronized (this) {
        if (_jsp_instancemanager == null) {
          _jsp_instancemanager = org.apache.jasper.runtime.InstanceManagerFactory.getInstanceManager(getServletConfig());
        }
      }
    }
    return _jsp_instancemanager;
  }

  public void _jspInit() {
  }

  public void _jspDestroy() {
  }

  public void _jspService(final javax.servlet.http.HttpServletRequest request, final javax.servlet.http.HttpServletResponse response)
        throws java.io.IOException, javax.servlet.ServletException {

final java.lang.String _jspx_method = request.getMethod();
if (!"GET".equals(_jspx_method) && !"POST".equals(_jspx_method) && !"HEAD".equals(_jspx_method) && !javax.servlet.DispatcherType.ERROR.equals(request.getDispatcherType())) {
response.sendError(HttpServletResponse.SC_METHOD_NOT_ALLOWED, "JSPs only permit GET POST or HEAD");
return;
}

    final javax.servlet.jsp.PageContext pageContext;
    javax.servlet.http.HttpSession session = null;
    final javax.servlet.ServletContext application;
    final javax.servlet.ServletConfig config;
    javax.servlet.jsp.JspWriter out = null;
    final java.lang.Object page = this;
    javax.servlet.jsp.JspWriter _jspx_out = null;
    javax.servlet.jsp.PageContext _jspx_page_context = null;


    try {
      response.setContentType("text/html; charset=UTF-8");
      pageContext = _jspxFactory.getPageContext(this, request, response,
      			null, true, 8192, true);
      _jspx_page_context = pageContext;
      application = pageContext.getServletContext();
      config = pageContext.getServletConfig();
      session = pageContext.getSession();
      out = pageContext.getOut();
      _jspx_out = out;

      out.write("\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("<!DOCTYPE html>\r\n");
      out.write("<html lang=\"ja\">\r\n");
      out.write("<head>\r\n");
      out.write("<meta charset=\"UTF-8\">\r\n");
      out.write("<meta name=\"format-detection\" content=\"telephone=no\">\r\n");
      out.write("<title>メニュー</title>\r\n");
      out.write("\r\n");

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

      out.write("\r\n");
      out.write("\r\n");
      out.write("  <script src=\"BrowserBackPrevent.js\"></script>\r\n");
      out.write("  <script src=\"menu.js\"></script>\r\n");
      out.write("\r\n");
      out.write("  <link href=\"CSS/Normalize.css\" rel=\"stylesheet\" type=\"text/css\">\r\n");
      out.write("  <link href=\"CSS/p16590004.css\" rel=\"stylesheet\" type=\"text/css\">\r\n");
      out.write("  <link href=\"CSS/menu.css\" rel=\"stylesheet\" type=\"text/css\">\r\n");
      out.write("\r\n");
      out.write("</head>\r\n");
      out.write("<body>\r\n");
      out.write("  <br>\r\n");
      out.write("  <fieldset class=\"high_area\">\r\n");
      out.write("    <legend>\r\n");
      out.write("      <b class=\"high_index\">P番</b>\r\n");
      out.write("    </legend>\r\n");
      out.write("    <table class=\"all_width\">\r\n");
      out.write("      <tr id=\"S0\">\r\n");
      out.write("        <td class=\"p_list content_title\">\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("          <form name=\"p_number_list\" method=\"POST\"\r\n");
      out.write("            action=\"./MenuController\" Target=\"right\">\r\n");
      out.write("            <input type=\"hidden\" name=\"action\" value=\"p_number_list\">\r\n");
      out.write("            <a href=\"javascript:document.p_number_list.submit()\">P番一覧</a>\r\n");
      out.write("          </form>\r\n");
      out.write("\r\n");
      out.write("        </td>\r\n");
      out.write("      </tr>\r\n");
      out.write("      <tr id=\"SS0\">\r\n");
      out.write("        <td class=\"p_list content_title\">\r\n");
      out.write("\r\n");
      out.write("          <form name=\"p_number_list_limit\" method=\"POST\"\r\n");
      out.write("            action=\"./MenuController\" Target=\"right\">\r\n");
      out.write("            <input type=\"hidden\" name=\"action\"\r\n");
      out.write("              value=\"p_number_list_limit\"> <a\r\n");
      out.write("              href=\"javascript:document.p_number_list_limit.submit()\">P番一覧</a>\r\n");
      out.write("          </form>\r\n");
      out.write("\r\n");
      out.write("        </td>\r\n");
      out.write("      </tr>\r\n");
      out.write("\r\n");
      out.write("      <!-- 追加：インターノウス -->\r\n");
      out.write("      <!-- ここから -->\r\n");
      out.write("      <tr id=\"purchase_import_area\">\r\n");
      out.write("        <td class=\"purchase_import content_title\">\r\n");
      out.write("          <form name=\"p_purchase_import\" method=\"POST\"\r\n");
      out.write("            action=\"./MenuController\" Target=\"right\">\r\n");
      out.write("            <input type=\"hidden\" name=\"action\"\r\n");
      out.write("              value=\"p_purchase_import\"> <a\r\n");
      out.write("              href=\"javascript:document.p_purchase_import.submit()\">仕入れデータ</a>\r\n");
      out.write("          </form>\r\n");
      out.write("        </td>\r\n");
      out.write("      </tr>\r\n");
      out.write("      <!-- ここまで -->\r\n");
      out.write("    </table>\r\n");
      out.write("  </fieldset>\r\n");
      out.write("  <br>\r\n");
      out.write("  <fieldset class=\"middle_area\">\r\n");
      out.write("    <legend>\r\n");
      out.write("      <b class=\"middle_index\">売りwin</b>\r\n");
      out.write("    </legend>\r\n");
      out.write("    <table class=\"all_width\">\r\n");
      out.write("      <tr id=\"S1\">\r\n");
      out.write("\r\n");
      out.write("        <td class=\"sales_list content_title\">\r\n");
      out.write("          <form name=\"win_list\" method=\"POST\"\r\n");
      out.write("            action=\"./MenuController\" Target=\"right\">\r\n");
      out.write("            <input type=\"hidden\" name=\"action\" value=\"win_list\">\r\n");
      out.write("            <a href=\"javascript:document.win_list.submit()\">案件一覧</a>\r\n");
      out.write("          </form>\r\n");
      out.write("        </td>\r\n");
      out.write("\r\n");
      out.write("      </tr>\r\n");
      out.write("      <tr id=\"SS1\">\r\n");
      out.write("\r\n");
      out.write("        <td class=\"sales_list content_title\">\r\n");
      out.write("          <form name=\"win_list_limit\" method=\"POST\"\r\n");
      out.write("            action=\"./MenuController\" Target=\"right\">\r\n");
      out.write("            <input type=\"hidden\" name=\"action\" value=\"win_list_limit\">\r\n");
      out.write("            <a href=\"javascript:document.win_list_limit.submit()\">案件一覧</a>\r\n");
      out.write("          </form>\r\n");
      out.write("        </td>\r\n");
      out.write("\r\n");
      out.write("      </tr>\r\n");
      out.write("\r\n");
      out.write("      <tr id=\"S2\">\r\n");
      out.write("        <td class=\"summary content_title\">総計</td>\r\n");
      out.write("\r\n");
      out.write("        <td class=\"summary table_type\">\r\n");
      out.write("          <form name=\"summary\" method=\"POST\"\r\n");
      out.write("            action=\"./MenuController\" Target=\"right\">\r\n");
      out.write("            <input type=\"hidden\" name=\"action\" value=\"summary\">\r\n");
      out.write("            <a href=\"javascript:document.summary.submit()\">現在</a>\r\n");
      out.write("          </form>\r\n");
      out.write("        </td>\r\n");
      out.write("\r\n");
      out.write("        <td class=\"summary table_type\">\r\n");
      out.write("          <form name=\"summary_old\" method=\"POST\"\r\n");
      out.write("            action=\"./MenuController\" Target=\"right\">\r\n");
      out.write("            <input type=\"hidden\" name=\"action\" value=\"summary_old\">\r\n");
      out.write("            <a href=\"javascript:document.summary_old.submit()\">過去</a>\r\n");
      out.write("          </form>\r\n");
      out.write("        </td>\r\n");
      out.write("\r\n");
      out.write("      </tr>\r\n");
      out.write("      <tr id=\"S3\">\r\n");
      out.write("        <td class=\"another_total content_title\">受注・売上月別合計</td>\r\n");
      out.write("\r\n");
      out.write("        <td class=\"another_total table_type\">\r\n");
      out.write("          <form name=\"another_total\" method=\"POST\"\r\n");
      out.write("            action=\"./MenuController\" Target=\"right\">\r\n");
      out.write("            <input type=\"hidden\" name=\"action\" value=\"another_total\">\r\n");
      out.write("            <a href=\"javascript:document.another_total.submit()\">現在</a>\r\n");
      out.write("          </form>\r\n");
      out.write("        </td>\r\n");
      out.write("\r\n");
      out.write("        <td class=\"another_total table_type\">\r\n");
      out.write("          <form name=\"another_total_old\" method=\"POST\"\r\n");
      out.write("            action=\"./MenuController\" Target=\"right\">\r\n");
      out.write("            <input type=\"hidden\" name=\"action\" value=\"another_total_old\">\r\n");
      out.write("            <a href=\"javascript:document.another_total_old.submit()\">過去</a>\r\n");
      out.write("          </form>\r\n");
      out.write("        </td>\r\n");
      out.write("\r\n");
      out.write("      </tr>\r\n");
      out.write("      <tr id=\"S4\">\r\n");
      out.write("        <td class=\"all_total content_title\">受注・売上総計</td>\r\n");
      out.write("\r\n");
      out.write("        <td class=\"all_total table_type\">\r\n");
      out.write("          <form name=\"all_total\" method=\"POST\"\r\n");
      out.write("            action=\"./MenuController\" Target=\"right\">\r\n");
      out.write("            <input type=\"hidden\" name=\"action\" value=\"all_total\">\r\n");
      out.write("            <a href=\"javascript:document.all_total.submit()\">現在</a>\r\n");
      out.write("          </form>\r\n");
      out.write("        </td>\r\n");
      out.write("\r\n");
      out.write("        <td class=\"all_total table_type\">\r\n");
      out.write("          <form name=\"all_total_old\" method=\"POST\"\r\n");
      out.write("            action=\"./MenuController\" Target=\"right\">\r\n");
      out.write("            <input type=\"hidden\" name=\"action\" value=\"all_total_old\">\r\n");
      out.write("            <a href=\"javascript:document.all_total_old.submit()\">過去</a>\r\n");
      out.write("          </form>\r\n");
      out.write("        </td>\r\n");
      out.write("\r\n");
      out.write("      </tr>\r\n");
      out.write("      <tr id=\"S5\">\r\n");
      out.write("        <td class=\"another_type_total content_title\">総計分類別</td>\r\n");
      out.write("\r\n");
      out.write("        <td class=\"another_type_total table_type\">\r\n");
      out.write("          <form name=\"another_type_total\" method=\"POST\"\r\n");
      out.write("            action=\"./MenuController\" Target=\"right\">\r\n");
      out.write("            <input type=\"hidden\" name=\"action\"\r\n");
      out.write("              value=\"another_type_total\"> <a\r\n");
      out.write("              href=\"javascript:document.another_type_total.submit()\">現在</a>\r\n");
      out.write("          </form>\r\n");
      out.write("        </td>\r\n");
      out.write("\r\n");
      out.write("        <td class=\"another_type_total table_type\">\r\n");
      out.write("          <form name=\"another_type_total_old\" method=\"POST\"\r\n");
      out.write("            action=\"./MenuController\" Target=\"right\">\r\n");
      out.write("            <input type=\"hidden\" name=\"action\"\r\n");
      out.write("              value=\"another_type_total_old\"> <a\r\n");
      out.write("              href=\"javascript:document.another_type_total_old.submit()\">過去</a>\r\n");
      out.write("          </form>\r\n");
      out.write("        </td>\r\n");
      out.write("\r\n");
      out.write("      </tr>\r\n");
      out.write("      <tr id=\"S6\">\r\n");
      out.write("\r\n");
      out.write("        <td class=\"meeting content_title\">\r\n");
      out.write("          <form name=\"meeting_data\" method=\"POST\"\r\n");
      out.write("            action=\"./MenuController\" Target=\"right\">\r\n");
      out.write("            <input type=\"hidden\" name=\"action\" value=\"meeting_data\">\r\n");
      out.write("            <a href=\"javascript:document.meeting_data.submit()\">管理職会議用</a>\r\n");
      out.write("          </form>\r\n");
      out.write("        </td>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("      </tr>\r\n");
      out.write("    </table>\r\n");
      out.write("  </fieldset>\r\n");
      out.write("\r\n");
      out.write("  <br>\r\n");
      out.write("  <fieldset class=\"low_area\">\r\n");
      out.write("    <legend>\r\n");
      out.write("      <b class=\"low_index\">設定・その他</b>\r\n");
      out.write("    </legend>\r\n");
      out.write("    <table class=\"all_width\">\r\n");
      out.write("      <tr id=\"S7\">\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("        <td class=\"cat content_title\">\r\n");
      out.write("          <form name=\"master_bunruiList\" method=\"POST\"\r\n");
      out.write("            action=\"./MenuController\" Target=\"right\">\r\n");
      out.write("            <input type=\"hidden\" name=\"action\" value=\"master_bunruiList\">\r\n");
      out.write("            <a href=\"javascript:document.master_bunruiList.submit()\">分類設定</a>\r\n");
      out.write("          </form>\r\n");
      out.write("        </td>\r\n");
      out.write("\r\n");
      out.write("      </tr>\r\n");
      out.write("      <tr id=\"S8\">\r\n");
      out.write("\r\n");
      out.write("        <td class=\"status content_title\">\r\n");
      out.write("          <form name=\"master_statusList\" method=\"POST\"\r\n");
      out.write("            action=\"./MenuController\" Target=\"right\">\r\n");
      out.write("            <input type=\"hidden\" name=\"action\" value=\"master_statusList\">\r\n");
      out.write("            <a href=\"javascript:document.master_statusList.submit()\">ステータス設定</a>\r\n");
      out.write("          </form>\r\n");
      out.write("        </td>\r\n");
      out.write("\r\n");
      out.write("      </tr>\r\n");
      out.write("      <tr id=\"S9\">\r\n");
      out.write("\r\n");
      out.write("        <td class=\"customer content_title\">\r\n");
      out.write("          <form name=\"master_clientList\" method=\"POST\"\r\n");
      out.write("            action=\"./MenuController\" Target=\"right\">\r\n");
      out.write("            <input type=\"hidden\" name=\"action\" value=\"master_clientList\">\r\n");
      out.write("            <a href=\"javascript:document.master_clientList.submit()\">顧客登録</a>\r\n");
      out.write("          </form>\r\n");
      out.write("        </td>\r\n");
      out.write("\r\n");
      out.write("      </tr>\r\n");
      out.write("      <tr id=\"S10\">\r\n");
      out.write("        <td class=\"user content_title\">\r\n");
      out.write("          <form name=\"user_list\" method=\"POST\"\r\n");
      out.write("            action=\"./MenuController\" Target=\"right\">\r\n");
      out.write("            <input type=\"hidden\" name=\"action\" value=\"user_list\">\r\n");
      out.write("            <a href=\"javascript:document.user_list.submit()\">ユーザー一覧</a>\r\n");
      out.write("          </form>\r\n");
      out.write("        </td>\r\n");
      out.write("\r\n");
      out.write("      </tr>\r\n");
      out.write("      <tr id=\"SS10\">\r\n");
      out.write("        <td class=\"user content_title\">\r\n");
      out.write("          <form name=\"user_list_limit\" method=\"POST\"\r\n");
      out.write("            action=\"./MenuController\" Target=\"right\">\r\n");
      out.write("            <input type=\"hidden\" name=\"action\" value=\"user_list_limit\">\r\n");
      out.write("            <a href=\"javascript:document.user_list_limit.submit()\">ユーザー一覧</a>\r\n");
      out.write("          </form>\r\n");
      out.write("        </td>\r\n");
      out.write("      </tr>\r\n");
      out.write("      <!-- 追加：インターノウス -->\r\n");
      out.write("      <!-- ここから -->\r\n");
      out.write("      <tr id=\"user_group_area\">\r\n");
      out.write("        <td class=\"user_group content_title\">\r\n");
      out.write("          <form name=\"user_group_list\" method=\"POST\"\r\n");
      out.write("            action=\"./MenuController\" Target=\"right\">\r\n");
      out.write("            <input type=\"hidden\" name=\"action\" value=\"user_group_list\">\r\n");
      out.write("            <a href=\"javascript:document.user_group_list.submit()\">ユーザーグループ設定</a>\r\n");
      out.write("          </form>\r\n");
      out.write("        </td>\r\n");
      out.write("      </tr>\r\n");
      out.write("      <!-- ここまで -->\r\n");
      out.write("      <tr id=\"S11\">\r\n");
      out.write("\r\n");
      out.write("        <td class=\"sales_user content_title\">\r\n");
      out.write("          <form name=\"sales_user_list\" method=\"POST\"\r\n");
      out.write("            action=\"./MenuController\" Target=\"right\">\r\n");
      out.write("            <input type=\"hidden\" name=\"action\" value=\"sales_user_list\">\r\n");
      out.write("            <a href=\"javascript:document.sales_user_list.submit()\">営業担当目標設定</a>\r\n");
      out.write("          </form>\r\n");
      out.write("        </td>\r\n");
      out.write("\r\n");
      out.write("      </tr>\r\n");
      out.write("      <tr id=\"S12\">\r\n");
      out.write("\r\n");
      out.write("        <td class=\"pass content_title\">\r\n");
      out.write("          <form name=\"pass_option\" method=\"POST\"\r\n");
      out.write("            action=\"./MenuController\" Target=\"right\">\r\n");
      out.write("            <input type=\"hidden\" name=\"action\" value=\"pass_option\">\r\n");
      out.write("            <a href=\"javascript:document.pass_option.submit()\">パスワード設定</a>\r\n");
      out.write("          </form>\r\n");
      out.write("        </td>\r\n");
      out.write("\r\n");
      out.write("      </tr>\r\n");
      out.write("      <tr id=\"S13\">\r\n");
      out.write("\r\n");
      out.write("        <td class=\"log content_title\">\r\n");
      out.write("          <form name=\"log\" method=\"POST\"\r\n");
      out.write("            action=\"./MenuController\" Target=\"right\">\r\n");
      out.write("            <input type=\"hidden\" name=\"action\" value=\"log\"> <a\r\n");
      out.write("              href=\"javascript:document.log.submit()\">操作ログ</a>\r\n");
      out.write("          </form>\r\n");
      out.write("        </td>\r\n");
      out.write("\r\n");
      out.write("      </tr>\r\n");
      out.write("    </table>\r\n");
      out.write("  </fieldset>\r\n");
      out.write("\r\n");
      out.write("\r\n");
      out.write("  <br>\r\n");
      out.write("\r\n");
      out.write("  <form action=\"./MenuController\" method=\"post\"\r\n");
      out.write("    Target=\"right\">\r\n");
      out.write("    <button type=\"submit\" name=\"action\" value=\"logout\">ログアウト</button>\r\n");
      out.write("\r\n");

out.println("<input type='hidden' name='useraut' id='useraut' value='" + useraut + "'/>");

      out.write("\r\n");
      out.write("\r\n");
      out.write("  </form>\r\n");
      out.write("  <br>\r\n");
      out.write("</body>\r\n");
      out.write("</html>");
    } catch (java.lang.Throwable t) {
      if (!(t instanceof javax.servlet.jsp.SkipPageException)){
        out = _jspx_out;
        if (out != null && out.getBufferSize() != 0)
          try {
            if (response.isCommitted()) {
              out.flush();
            } else {
              out.clearBuffer();
            }
          } catch (java.io.IOException e) {}
        if (_jspx_page_context != null) _jspx_page_context.handlePageException(t);
        else throw new ServletException(t);
      }
    } finally {
      _jspxFactory.releasePageContext(_jspx_page_context);
    }
  }
}