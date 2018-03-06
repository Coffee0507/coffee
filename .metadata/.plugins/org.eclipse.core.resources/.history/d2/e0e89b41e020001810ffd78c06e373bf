<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List"%>
<%@ page import="jp.co.lsij.p16590004.e_77.model.analyze.PieBKColorType" %>
<%@ page import="jp.co.lsij.p16590004.e_77.model.analyze.PieBKColorMakerFactory" %>
<%@ page import="jp.co.lsij.p16590004.e_77.model.analyze.IPieBKColorMaker" %>

<!-- 
        担当別グラフ
        呼び出し側で、
   "sales_staff_data(String[])"（担当営業なしの場合、String[].length = 0 を設定）
   "sales_by_charge_data(String[])"（担当営業なしの場合、String[].length = 0 を設定）
        に値を設定しておく 

            【課題】
      ※例外メッセージを設定するのが課題
           呼び出し側で、本コードを呼び出す前に request.setAttribute() で、現在のエラーメッセージリストを設定し
           本コード内で、getAttribute() し、取得したオブジェクトへ add していく？！
            ー＞リクエストスコープに"byChargeErrorMessageList"として設定するので、呼び出し側で、空か否かで、エラーリストにマージするか判断

      ※グラフの背景色の生成が課題（なるべく重ならないように）
     ※getRed() 等の java の関数が重複している（共通化したい）
        ー＞取りあえず、対応
-->

<!-- java のデータをjavascriptへ渡す方法 （ここから）-->
<%
/** 担当営業数 */
int nNumberOfSalesStaff = 0;
/** 担当営業データ */
String[] salesStaff = null;
/** 担当営業単位の受注＋売上額データ */
String[] salesByCharge = null;

/** 例外処理をまとめるのに使用 */
List<String> byChargeErrorMessageList = new ArrayList<String>();
%>

<%
//担当営業データ取得
try {
  salesStaff = (String[])request.getAttribute("sales_staff_data");
  if (null == salesStaff) {
    throw new IllegalStateException("sales_staff_data==null");
    //nNumberOfSalesStaff = 0;
  } else {
    nNumberOfSalesStaff = salesStaff.length;
  }
} catch (Exception err){
  try {
    byChargeErrorMessageList.add("例外発生（担当営業取得部）（" + err.getMessage() + "）");
  } catch (Exception err_2) {}
  salesStaff = null;
}

//担当営業単位の受注＋売上データ取得
try {
  if (0 < nNumberOfSalesStaff) {
  //担当営業未設定でない場合
    salesByCharge = new String[nNumberOfSalesStaff];
    for (int nIndex = 0; nIndex < salesByCharge.length; nIndex++){
      salesByCharge[nIndex] = "0";
    }
    String[] works = null;
    works = (String[])request.getAttribute("sales_by_charge_data");
    if (null == works) {
      throw new IllegalStateException("sales_by_charge_data==null");
    } else {
      for (int nIndex = 0; nIndex < salesByCharge.length; nIndex++){
        if (nIndex < works.length) {
          salesByCharge[nIndex] = works[nIndex];
        } else {
          throw new IllegalStateException("sales_by_charge_data" + "のデータが不足しています");
          //salesByCharge[nIndex] = "0";
        }
      }
    }
  }
} catch (Exception err){
  try {
    byChargeErrorMessageList.add("例外発生（担当営業受注＋売上取得部）（" + err.getMessage() + "）");
  } catch (Exception err_2) {}
  salesStaff = null;
  salesByCharge = null;
}

//本モジュール用エラーリストをリクエストスコープにセット
request.setAttribute("byChargeErrorMessageList", byChargeErrorMessageList);
%>

  <script>
  var jsArraySalesStaff = [<%
                             if (null == salesStaff) {
                               //※円グラフは表示されない
                               out.print("\"\"");
                             } else {
                               for (int nIndex = 0; nIndex < salesStaff.length; nIndex++ ) {
                                 if (0 != nIndex) {
                                   out.print(",");
                                 }
                                 out.print("\"" + salesStaff[nIndex] + "\"");
                               }
                             }
                           %>];
  
  var jsArraySalesByCharge = [<%
                                if (null == salesByCharge) {
                                  //※円グラフは表示されない
                                  out.print("\"0\"");
                                } else {
                                  for (int nIndex = 0; nIndex < salesByCharge.length; nIndex++ ) {
                                    if (0 != nIndex) {
                                      out.print(",");
                                    }
                                    out.print("\"" + salesByCharge[nIndex] + "\"");
                                  }
                                }
                              %>];

  var jsArrayByChargeBackgroundColor = [<%
                                          if (null == salesStaff) {
                                            out.print("\"#ffffff\"");
                                          } else {
                                            for (int nIndex = 0; nIndex < salesStaff.length; nIndex++ ) {
                                              if (0 != nIndex) {
                                                out.print(",");
                                              }
                                              IPieBKColorMaker iPieBKColorMaker = PieBKColorMakerFactory.getInstance(PieBKColorType.STANDARD);
                                              String strRGB = iPieBKColorMaker.getColorString(nIndex);
                                              out.print("\"#" + strRGB + "\"");
                                            }
                                          }
                                %>];
  </script>
<!-- java のデータをjavascriptへ渡す方法（ここまで） -->


  <script>
  /**
   * 担当別グラフ用 javascript 定義
   */
  var BY_CHARGE_GRAPH_CONSTANTS = {
    //キャンバスのid
    'CANVAS_ID':'by_charge_graph_id',
  }
  </script>

  <!-- 担当別（人・金額） -->
  <canvas id="by_charge_graph_id" width="250" height="250"></canvas>

  <script>
  //データ設定
  //※オブジェクトに対し、key と値を設定している
  var byChargeGraphData = {
    //キー名(key)： 値(value)
    //で初期化している
    labels: jsArraySalesStaff,
    datasets: [{
      backgroundColor: jsArrayByChargeBackgroundColor,
      data: jsArraySalesByCharge
    }],
  };
  </script>
  
  <script>
  //オプション設定
  var byChargeGraphOption = {
    responsive: false,//画面サイズに合わせるか
  };
  </script>
  
  <script>
<%
if ((null != salesStaff) && (null != salesByCharge)) {
%>
  var objByChargeGraph = document.getElementById(BY_CHARGE_GRAPH_CONSTANTS.CANVAS_ID).getContext('2d');
  
  var chartByCharge = new Chart(objByChargeGraph, {
    // 作成するグラフの種類
    type: 'pie',

    // ラベルとデータセットを設定
    data: byChargeGraphData,

    // オプション設定
    options: byChargeGraphOption
    //options: {}
  });
<%
}
%>
  </script>
