<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List"%>
<%@ page import="java.time.Month"%>

<!-- 
         受注・売上月別合計グラフ
        呼び出し側で、
   "order_per_month_data(String[])"（４月から３月まで１２ヶ月分）
   "sales_per_month_data(String[])"（４月から３月まで１２ヶ月分）
   "breakeven_point_data(String)"（本ソースの bBreakevenPointEnable にて、使用するか否か設定）
   "target_data(String)"（本ソースの bTargetEnable にて、使用するか否か設定）
        に値を設定しておく 
   
            【課題】
       ※例外メッセージを設定するのが課題
           呼び出し側で、本コードを呼び出す前に request.setAttribute() で、現在のエラーメッセージリストを設定し
           本コード内で、getAttribute() し、取得したオブジェクトへ add していく？！
            ー＞リクエストスコープに"orderAndSalesPerMonthErrorMessageList"として設定するので、呼び出し側で、空か否かで、エラーリストにマージするか判断
            
       ※損益分岐点、目標値を有効／無効にできるようにしたい
           ー＞bBreakevenPointEnable, bTargetEnable のフラグを使用する)
-->

<!-- java のデータをjavascriptへ渡す方法 （ここから）-->
<%
/** 有効／無効フラグ（ハードコーディング） */
boolean bBreakevenPointEnable = false;//）
/** 有効／無効フラグ（ハードコーディング） */
boolean bTargetEnable = false;

/** １年の月数 */
int nMonthLength = 0;
/** 12ヶ月分の各月の受注額データ */
String[] orderPerMonth = null;
/** 12ヶ月分の各月の売上額データ */
String[] salesPerMonth = null;
/** 損益分岐点データ */
String[] breakevenPoint = null;
/** 目標値データ */
String[] target = null;

/** 例外処理をまとめるのに使用 */
List<String> orderAndSalesPerMonthErrorMessageList = new ArrayList<String>();
%>

<%!
/**
 * 指定の属性名で１２ヶ月分の各月のデータを取得
 * 
 * @param request　リクエストオブジェクト
 * @param strAttrName　属性名
 * @param nMonthLength　１年の月数
 * @return １２ヶ月分の各月のデータ配列
 */
String[] getAmountByMonth(HttpServletRequest request, String strAttrName, int nMonthLength) {
  String[] amountPerMonth = null;

  try {
    amountPerMonth = new String[nMonthLength];
    for (int nIndex = 0; nIndex < amountPerMonth.length; nIndex++){
      amountPerMonth[nIndex] = "0";
    }
    String[] works = null;

    works = (String[])request.getAttribute(strAttrName);
    if (null == works) {
      throw new IllegalStateException(strAttrName + "=null");
    } else {
      for (int nIndex = 0; nIndex < amountPerMonth.length; nIndex++){
        if (nIndex < works.length) {
          amountPerMonth[nIndex] = works[nIndex];
        } else {
          throw new IllegalStateException(strAttrName + "のデータが不足しています");
          //amountPerMonth[nIndex] = "0";
        }
      }
    }
  } catch (Exception err) {
    throw err;
  }
  
  return amountPerMonth;
}

/**
 * 指定の属性名で１２ヶ月分の定数データを取得
 * 
 * @param request　リクエストオブジェクト
 * @param strAttrName　属性名
 * @param nMonthLength　１年の月数
 * @return １２ヶ月分の定数データ配列
 */
String[] getConstant(HttpServletRequest request, String strAttrName, int nMonthLength) {
  String[] constant = null;

  try {
    constant = new String[nMonthLength];
    for (int nIndex = 0; nIndex < constant.length; nIndex++){
      constant[nIndex] = "0";
    }
    String work = null;

    work = (String)request.getAttribute(strAttrName);
    if (null == work) {
      throw new IllegalStateException(strAttrName + "=null");
    } else {
      for (int nIndex = 0; nIndex < constant.length; nIndex++){
        constant[nIndex] = work;
      }
    }
  } catch (Exception err) {
    throw err;
  }
  
  return constant;
}
%>

<%
nMonthLength = Month.values().length;
try {
  orderPerMonth = getAmountByMonth(request, "order_per_month_data", nMonthLength);
} catch (Exception err) {
  try {
    orderAndSalesPerMonthErrorMessageList.add("例外発生（受注額取得部）（" + err.getMessage() + "）");
  } catch (Exception err_2) {}
  orderPerMonth = null;
}
try {
  salesPerMonth = getAmountByMonth(request, "sales_per_month_data", nMonthLength);
} catch (Exception err) {
  try {
    orderAndSalesPerMonthErrorMessageList.add("例外発生（売上額取得部）（" + err.getMessage() + "）");
  } catch (Exception err_2) {}
  salesPerMonth = null;
}
try {
  if (false != bBreakevenPointEnable) {
    breakevenPoint = getConstant(request, "breakeven_point_data", nMonthLength);
  }
} catch (Exception err) {
  try {
    orderAndSalesPerMonthErrorMessageList.add("例外発生（損益分岐点取得部）（" + err.getMessage() + "）");
  } catch (Exception err_2) {}
  breakevenPoint = null;
}
try {
  if (false != bTargetEnable) {
    target = getConstant(request, "target_data", nMonthLength);
  }
} catch (Exception err) {
  try {
    orderAndSalesPerMonthErrorMessageList.add("例外発生（目標取得部）（" + err.getMessage() + "）");
  } catch (Exception err_2) {}
  target = null;
}

//本モジュール用エラーリストをリクエストスコープにセット
request.setAttribute("orderAndSalesPerMonthErrorMessageList", orderAndSalesPerMonthErrorMessageList);
%>

  <script>
  var jsArrayOrderPerMonth = [<%
                                if (null == orderPerMonth) {
                                  for (int nIndex = 0; nIndex < nMonthLength; nIndex++ ) {
                                    if (0 != nIndex) {
                                      out.print(",");
                                    }
                                    out.print("\"0\"");
                                  }
                                } else {
                                  for (int nIndex = 0; nIndex < orderPerMonth.length; nIndex++ ) {
                                    if (0 != nIndex) {
                                      out.print(",");
                                    }
                                    out.print("\"" + orderPerMonth[nIndex] + "\"");
                                  }
                                }
                              %>];
  
  var jsArraySalesPerMonth = [<%
                                if (null == salesPerMonth) {
                                  for (int nIndex = 0; nIndex < nMonthLength; nIndex++ ) {
                                    if (0 != nIndex) {
                                      out.print(",");
                                    }
                                    out.print("\"0\"");
                                  }
                                } else {
                                  for (int nIndex = 0; nIndex < salesPerMonth.length; nIndex++ ) {
                                    if (0 != nIndex) {
                                      out.print(",");
                                    }
                                    out.print("\"" + salesPerMonth[nIndex] + "\"");
                                  }
                                }
                              %>];
  
<%
if (false != bBreakevenPointEnable) {
%>
  var jsArrayBreakevenPoint = [<%
                                 if (null == breakevenPoint) {
                                   for (int nIndex = 0; nIndex < nMonthLength; nIndex++ ) {
                                     if (0 != nIndex) {
                                       out.print(",");
                                     }
                                     out.print("\"0\"");
                                   }
                                 } else {
                                   for (int nIndex = 0; nIndex < breakevenPoint.length; nIndex++ ) {
                                     if (0 != nIndex) {
                                       out.print(",");
                                     }
                                     out.print("\"" + breakevenPoint[nIndex] + "\"");
                                   }
                                 }
                               %>];
<%
}
%>

<%
if (false != bTargetEnable) {
%>
  var jsArrayTarget = [<%
                         if (null == target) {
                           for (int nIndex = 0; nIndex < nMonthLength; nIndex++ ) {
                             if (0 != nIndex) {
                               out.print(",");
                             }
                             out.print("\"0\"");
                           }
                         } else {
                           for (int nIndex = 0; nIndex < target.length; nIndex++ ) {
                             if (0 != nIndex) {
                               out.print(",");
                             }
                             out.print("\"" + target[nIndex] + "\"");
                           }
                         }
                       %>];
<%
}
%>
  </script>
<!-- java のデータをjavascriptへ渡す方法（ここまで） -->


  <script>
  /**
   * 受注・売上月別合計グラフ用 javascript 定義
   */
  var ORDER_AND_SALES_PER_MONTH_GRAPH_CONSTANTS = {
    //キャンバスのid
    'CANVAS_ID':'order_and_sales_per_month_graph_id',
    //受注月別合計のラベル名
    'ORDER_GRAPH_LABEL':'受注',
    //売上月別合計のラベル名
    'SALES_GRAPH_LABEL':'売上　　',//全角スペースは売上と損益分岐点の間を空けるため
    //損益分岐点のラベル名
    'BREAKEVEN_POINT_GRAPH_LABEL':'損益分岐点',
    //目標のラベル名
    'TARGET_GRAPH_LABEL':'目標',
    //受注月別合計の境界色
    'ORDER_GRAPH_BORDER_COLOR':'rgba(254,97,132,0.8)',
    //受注月別合計の背景色
    'ORDER_GRAPH_BACK_GROUND_COLOR':'rgba(254,97,132,0.5)',
    //売上月別合計の境界色
    'SALES_GRAPH_BORDER_COLOR':'rgba(54,164,235,0.8)',
    //売上月別合計の背景色
    'SALES_GRAPH_BACK_GROUND_COLOR':'rgba(54,164,235,0.5)',
    //損益分岐点の境界色
    'BREAKEVEN_POINT_GRAPH_BORDER_COLOR':'rgba(255,0,0,0.8)',
    //損益分岐点の背景色
    'BREAKEVEN_POINT_GRAPH_BACK_GROUND_COLOR':'rgba(255,0,0,0.5)',
    //目標の境界色
    'TARGET_GRAPH_BORDER_COLOR':'rgba(0,0,0,0.8)',
    //目標の背景色
    'TARGET_GRAPH_BACK_GROUND_COLOR':'rgba(0,0,0,0.5)',
  }
  </script>

  <script>
  //横軸
  var jsArrayOrderAndSalesPerMonthGraphHorizontal = ['４月', '５月', '６月', '７月', '８月', '９月', '１０月', '１１月', '１２月', '１月', '２月', '３月'];
  </script>

  <!-- 受注・売上月別合計 -->
  <canvas id="order_and_sales_per_month_graph_id" width="1400" height="400"></canvas>

  <script>
  //データ設定
  //※オブジェクトに対し、key と値を設定している
  var orderAndSalesPerMonthGraphData = {
    //キー名(key)： 値(value)
    //で初期化している
    labels: jsArrayOrderAndSalesPerMonthGraphHorizontal,
    datasets: [
    {
      label: ORDER_AND_SALES_PER_MONTH_GRAPH_CONSTANTS.ORDER_GRAPH_LABEL,
      data: jsArrayOrderPerMonth,//<--事前に　jsArrayOrderPerMonth　へ設定しておく 
      borderColor : ORDER_AND_SALES_PER_MONTH_GRAPH_CONSTANTS.ORDER_GRAPH_BORDER_COLOR,
      backgroundColor : ORDER_AND_SALES_PER_MONTH_GRAPH_CONSTANTS.ORDER_GRAPH_BACK_GROUND_COLOR,
      tension: 0,//直線
      fill: false,//線の下を塗りつぶさない
    },
    {
      label: ORDER_AND_SALES_PER_MONTH_GRAPH_CONSTANTS.SALES_GRAPH_LABEL,
      data: jsArraySalesPerMonth,//<--事前に　jsArraySalesPerMonth　へ設定しておく 
      borderColor : ORDER_AND_SALES_PER_MONTH_GRAPH_CONSTANTS.SALES_GRAPH_BORDER_COLOR,
      backgroundColor : ORDER_AND_SALES_PER_MONTH_GRAPH_CONSTANTS.SALES_GRAPH_BACK_GROUND_COLOR,
      tension: 0,//直線
      fill: false,//線の下を塗りつぶさない
    },
<%
if (false != bBreakevenPointEnable) {
%>
    {
      label: ORDER_AND_SALES_PER_MONTH_GRAPH_CONSTANTS.BREAKEVEN_POINT_GRAPH_LABEL,
      data: jsArrayBreakevenPoint,//<--事前に　jsArrayBreakevenPoint　へ設定しておく 
      borderColor : ORDER_AND_SALES_PER_MONTH_GRAPH_CONSTANTS.BREAKEVEN_POINT_GRAPH_BORDER_COLOR,
      backgroundColor : ORDER_AND_SALES_PER_MONTH_GRAPH_CONSTANTS.BREAKEVEN_POINT_GRAPH_BACK_GROUND_COLOR,
      tension: 0,//直線
      fill: false,//線の下を塗りつぶさない
      pointStyle: 'line',//点のスタイル
      borderWidth: 1,//線の幅
      borderDash: [5, 5],//破線スタイル
    },
<%
}
%>
<%
if (false != bTargetEnable) {
%>
    {
      label: ORDER_AND_SALES_PER_MONTH_GRAPH_CONSTANTS.TARGET_GRAPH_LABEL,
      data: jsArrayTarget,//<--事前に　jsArrayTarget　へ設定しておく 
      borderColor : ORDER_AND_SALES_PER_MONTH_GRAPH_CONSTANTS.TARGET_GRAPH_BORDER_COLOR,
      backgroundColor : ORDER_AND_SALES_PER_MONTH_GRAPH_CONSTANTS.TARGET_GRAPH_BACK_GROUND_COLOR,
      tension: 0,//直線
      fill: false,//線の下を塗りつぶさない
      pointStyle: 'line',//点のスタイル
      borderWidth: 1,//線の幅
    },
<%
}
%>
    ],
  };
  </script>
  
  <script>
  //オプション設定
  var orderAndSalesPerMonthGraphOption = {
    responsive: false,//画面サイズに合わせるか
    animation:false,//アニメーションをＯＦＦ
  };
  </script>
  
  <script>
  //2d：描画モードが2Dという意味(キャンバスオブジェクト参照)
  var objOrderAndSalesPerMonthGraph = document.getElementById(ORDER_AND_SALES_PER_MONTH_GRAPH_CONSTANTS.CANVAS_ID).getContext('2d');
  
  var chartOrderAndSalesPerMonth = new Chart(objOrderAndSalesPerMonthGraph, {
    // 作成するグラフの種類
    type: 'line',

    // ラベルとデータセットを設定
    // 縦軸5000万単位
    data: orderAndSalesPerMonthGraphData,
    plugins: [{
      afterDatasetsDraw: function (chartOrderAndSalesPerMonth, ease) {
      }
    }],
    // オプション設定
    options: orderAndSalesPerMonthGraphOption
    //options: {}
  });
  </script>
