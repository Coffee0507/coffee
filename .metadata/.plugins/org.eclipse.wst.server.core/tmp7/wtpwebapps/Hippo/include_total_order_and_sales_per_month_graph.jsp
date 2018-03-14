<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List"%>
<%@ page import="java.time.Month"%>

<!-- 
        受注･売上総計グラフ
        呼び出し側で、
   "total_order_per_month_data(String[])"（４月から３月まで１２ヶ月分（累計で））
   "total_sales_per_month_data(String[])"（４月から３月まで１２ヶ月分（累計で））
        に値を設定しておく 

            【課題】
      ※例外メッセージを設定するのが課題
           呼び出し側で、本コードを呼び出す前に request.setAttribute() で、現在のエラーメッセージリストを設定し
           本コード内で、getAttribute() し、取得したオブジェクトへ add していく？！
            ー＞リクエストスコープに"totalOrderAndSalesPerMonthErrorMessageList"として設定するので、呼び出し側で、空か否かで、エラーリストにマージするか判断
-->

<!-- java のデータをjavascriptへ渡す方法 （ここから）-->
<%
/** １年の月数 */
int nMonthLength = 0;
/** 12ヶ月分の各月の（累計）受注額データ */
String[] totalOrderPerMonth = null;
/** 12ヶ月分の各月の（累計）売上額データ */
String[] totalSalesPerMonth = null;

/** 例外処理をまとめるのに使用 */
List<String> totalOrderAndSalesPerMonthErrorMessageList = new ArrayList<String>();
%>

<%!
/**
 * 指定の属性名で１２ヶ月分の各月の（累計）データを取得
 * 
 * @param request　リクエストオブジェクト
 * @param strAttrName　属性名
 * @param nMonthLength　１年の月数
 * @return １２ヶ月分の各月の（累計）データ配列
 */
String[] getTotalAmountByMonth(HttpServletRequest request, String strAttrName, int nMonthLength) {
  String[] totalAmountPerMonth = null;

  try {
    totalAmountPerMonth = new String[nMonthLength];
    for (int nIndex = 0; nIndex < totalAmountPerMonth.length; nIndex++){
      totalAmountPerMonth[nIndex] = "0";
    }
    String[] works = null;

    works = (String[])request.getAttribute(strAttrName);
    if (null == works) {
      throw new IllegalStateException(strAttrName + "=null");
    } else {
      for (int nIndex = 0; nIndex < totalAmountPerMonth.length; nIndex++){
        if (nIndex < works.length) {
          totalAmountPerMonth[nIndex] = works[nIndex];
        } else {
          throw new IllegalStateException(strAttrName + "のデータが不足しています");
          //totalAmountPerMonth[nIndex] = "0";
        }
      }
    }
  } catch (Exception err) {
    throw err;
  }
  
  return totalAmountPerMonth;
}
%>

<%
nMonthLength = Month.values().length;
try {
  totalOrderPerMonth = getTotalAmountByMonth(request, "total_order_per_month_data", nMonthLength);
} catch (Exception err) {
  try {
    totalOrderAndSalesPerMonthErrorMessageList.add("例外発生（（累計）受注額取得部）（" + err.getMessage() + "）");
  } catch (Exception err_2) {}
  totalOrderPerMonth = null;
}
try {
  totalSalesPerMonth = getTotalAmountByMonth(request, "total_sales_per_month_data", nMonthLength);
} catch (Exception err) {
  try {
    totalOrderAndSalesPerMonthErrorMessageList.add("例外発生（（累計）売上額取得部）（" + err.getMessage() + "）");
  } catch (Exception err_2) {}
  totalSalesPerMonth = null;
}

//本モジュール用エラーリストをリクエストスコープにセット
request.setAttribute("totalOrderAndSalesPerMonthErrorMessageList", totalOrderAndSalesPerMonthErrorMessageList);
%>

  <script>
  var jsArrayTotalOrderPerMonth = [<%
                                     if (null == totalOrderPerMonth) {
                                       for (int nIndex = 0; nIndex < nMonthLength; nIndex++ ) {
                                         if (0 != nIndex) {
                                           out.print(",");
                                         }
                                         out.print("\"0\"");
                                       }
                                     } else {
                                       for (int nIndex = 0; nIndex < totalOrderPerMonth.length; nIndex++ ) {
                                         if (0 != nIndex) {
                                           out.print(",");
                                         }
                                         out.print("\"" + totalOrderPerMonth[nIndex] + "\"");
                                       }
                                     }
                                   %>];
  
  var jsArrayTotalSalesPerMonth = [<%
                                     if (null == totalSalesPerMonth) {
                                       for (int nIndex = 0; nIndex < nMonthLength; nIndex++ ) {
                                         if (0 != nIndex) {
                                           out.print(",");
                                         }
                                         out.print("\"0\"");
                                       }
                                     } else {
                                       for (int nIndex = 0; nIndex < totalSalesPerMonth.length; nIndex++ ) {
                                         if (0 != nIndex) {
                                           out.print(",");
                                         }
                                         out.print("\"" + totalSalesPerMonth[nIndex] + "\"");
                                       }
                                     }
                                   %>];

  </script>
<!-- java のデータをjavascriptへ渡す方法（ここまで） -->


  <script>
  /**
   * 受注･売上総計グラフ用 javascript 定義
   */
  var TOTAL_ORDER_AND_SALES_PER_MONTH_GRAPH_CONSTANTS = {
    //キャンバスのid
    'CANVAS_ID':'total_order_and_sales_per_month_graph_id',
    //受注総計のラベル名
    'TOTAL_ORDER_GRAPH_LABEL':'受注',
    //売上総計のラベル名
    'TOTAL_SALES_GRAPH_LABEL':'売上',
    //受注総計の境界色
    'TOTAL_ORDER_GRAPH_BORDER_COLOR':'rgba(254,97,132,0.8)',
    //受注総計の背景色
    'TOTAL_ORDER_GRAPH_BACK_GROUND_COLOR':'rgba(254,97,132,0.5)',
    //売上総計の境界色
    'TOTAL_SALES_GRAPH_BORDER_COLOR':'rgba(54,164,235,0.8)',
    //売上総計の背景色
    'TOTAL_SALES_GRAPH_BACK_GROUND_COLOR':'rgba(54,164,235,0.5)',
  }
  </script>

  <script>
  //横軸
  var jsArrayTotalOrderAndSalesPerMonthGraphHorizontal = ['４月', '５月', '６月', '７月', '８月', '９月', '１０月', '１１月', '１２月', '１月', '２月', '３月'];
  </script>

  <!-- 受注･売上総計 -->
  <canvas id="total_order_and_sales_per_month_graph_id" width="1400" height="400"></canvas>

  <script>
  var totalOrderAndSalesPerMonthGraphData = {
    labels: jsArrayTotalOrderAndSalesPerMonthGraphHorizontal,
    datasets: [
    {
      label: TOTAL_ORDER_AND_SALES_PER_MONTH_GRAPH_CONSTANTS.TOTAL_ORDER_GRAPH_LABEL,
      data: jsArrayTotalOrderPerMonth,//<--事前に　jsArrayTotalOrderPerMonth　へ設定しておく 
       borderColor : TOTAL_ORDER_AND_SALES_PER_MONTH_GRAPH_CONSTANTS.TOTAL_ORDER_GRAPH_BORDER_COLOR,
      backgroundColor : TOTAL_ORDER_AND_SALES_PER_MONTH_GRAPH_CONSTANTS.TOTAL_ORDER_GRAPH_BACK_GROUND_COLOR,
      tension: 0,//直線
    },
    {
      label: TOTAL_ORDER_AND_SALES_PER_MONTH_GRAPH_CONSTANTS.TOTAL_SALES_GRAPH_LABEL,
      data: jsArrayTotalSalesPerMonth,//<--事前に　jsArrayTotalOrderPerMonth　へ設定しておく 
      borderColor : TOTAL_ORDER_AND_SALES_PER_MONTH_GRAPH_CONSTANTS.TOTAL_SALES_GRAPH_BORDER_COLOR,
      backgroundColor : TOTAL_ORDER_AND_SALES_PER_MONTH_GRAPH_CONSTANTS.TOTAL_SALES_GRAPH_BACK_GROUND_COLOR,
      tension: 0,//直線
    },
    ],
  };
  </script>
  
  <script>
  var totalOrderAndSalesPerMonthGraphOption = {
    responsive: false,//画面サイズに合わせるか
  };
  </script>
  <script>
  var objTotalOrderAndSalesPerMonthGraph = document.getElementById(TOTAL_ORDER_AND_SALES_PER_MONTH_GRAPH_CONSTANTS.CANVAS_ID).getContext('2d');
  
  var chartTotalOrderAndSalesPerMonth = new Chart(objTotalOrderAndSalesPerMonthGraph, {
    // 作成するグラフの種類
    type: 'line',
    // ラベルとデータセットを設定
    data: totalOrderAndSalesPerMonthGraphData,
    // オプション設定
    options: totalOrderAndSalesPerMonthGraphOption
  });
  </script>
