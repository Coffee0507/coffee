<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List"%>
<%@ page import="jp.co.lsij.p16590004.e_77.model.analyze.PieBKColorType" %>
<%@ page import="jp.co.lsij.p16590004.e_77.model.analyze.PieBKColorMakerFactory" %>
<%@ page import="jp.co.lsij.p16590004.e_77.model.analyze.IPieBKColorMaker" %>

<!-- 
        分類別グラフ
        呼び出し側で、
   "category_data(String[])"（分類なしの場合、null を設定）
   "sales_by_category_data(String[])"（分類なしの場合、null を設定）
        に値を設定しておく 

            【課題】
      ※例外メッセージを設定するのが課題
           呼び出し側で、本コードを呼び出す前に request.setAttribute() で、現在のエラーメッセージリストを設定し
           本コード内で、getAttribute() し、取得したオブジェクトへ add していく？！
            ー＞リクエストスコープに"classificationErrorMessageList"として設定するので、呼び出し側で、空か否かで、エラーリストにマージするか判断

      ※グラフの背景色の生成が課題（なるべく重ならないように）
     ※getRed() 等の java の関数が重複している（共通化したい）
        ー＞取りあえず、対応
-->

<!-- java のデータをjavascriptへ渡す方法 （ここから）-->
<%
/** 分類数 */
int nNumberOfCategory = 0;
/** 分類データ */
String[] category = null;
/** 分類単位の受注＋売上額データ */
String[] salesByCategory = null;

/** 例外処理をまとめるのに使用 */
List<String> classificationErrorMessageList = new ArrayList<String>();
%>

<%
//分類データ取得
try {
  category = (String[])request.getAttribute("category_data");
  if (null == category) {
    throw new IllegalStateException("category_data==null");
    //nNumberOfCategory = 0;
  } else {
    nNumberOfCategory = category.length;
  }
} catch (Exception err){
  try {
    classificationErrorMessageList.add("例外発生（分類取得部）（" + err.getMessage() + "）");
  } catch (Exception err_2) {}
  category = null;
}

//分類単位の受注＋売上データ取得
try {
  if (0 < nNumberOfCategory) {
  //分類未設定でない場合
    salesByCategory = new String[nNumberOfCategory];
    for (int nIndex = 0; nIndex < salesByCategory.length; nIndex++){
      salesByCategory[nIndex] = "0";
    }
    String[] works = null;
    works = (String[])request.getAttribute("sales_by_category_data");
    if (null == works) {
      throw new IllegalStateException("sales_by_category_data==null");
    } else {
      for (int nIndex = 0; nIndex < salesByCategory.length; nIndex++){
        if (nIndex < works.length) {
          salesByCategory[nIndex] = works[nIndex];
        } else {
          throw new IllegalStateException("sales_by_category_data" + "のデータが不足しています");
          //salesByCategory[nIndex] = "0";
        }
      }
    }
  }
} catch (Exception err){
  try {
    classificationErrorMessageList.add("例外発生（担当営業受注＋売上取得部）（" + err.getMessage() + "）");
  } catch (Exception err_2) {}
  category = null;
  salesByCategory = null;
}

//本モジュール用エラーリストをリクエストスコープにセット
request.setAttribute("classificationErrorMessageList", classificationErrorMessageList);
%>

  <script>
  var jsArrayCategory = [<%
                           if (null == category) {
                             //※円グラフは表示されない
                             out.print("\"\"");
                           } else {
                             for (int nIndex = 0; nIndex < category.length; nIndex++ ) {
                               if (0 != nIndex) {
                                 out.print(",");
                               }
                               out.print("\"" + category[nIndex] + "\"");
                             }
                           }
                         %>];
  
  var jsArraySalesByCategory = [<%
                                  if (null == salesByCategory) {
                                    //※円グラフは表示されない
                                    out.print("\"0\"");
                                  } else {
                                    for (int nIndex = 0; nIndex < salesByCategory.length; nIndex++ ) {
                                      if (0 != nIndex) {
                                        out.print(",");
                                      }
                                      out.print("\"" + salesByCategory[nIndex] + "\"");
                                    }
                                  }
                                %>];

  var jsArrayByCategoryBackgroundColor = [<%
                                            if (null == category) {
                                              out.print("\"#ffffff\"");
                                            } else {
                                              for (int nIndex = 0; nIndex < category.length; nIndex++ ) {
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
   * 分類別グラフ用 javascript 定義
   */
  var BY_CATEGORY_GRAPH_CONSTANTS = {
    //キャンバスのid
    'CANVAS_ID':'by_category_graph_id',
  }
  </script>

  <!-- 分類別（分類・金額（％）） -->
  <canvas id="by_category_graph_id" width="250" height="250"></canvas>

  <script>
  //データ設定
  //※オブジェクトに対し、key と値を設定している
  var byCategoryGraphData = {
    //キー名(key)： 値(value)
    //で初期化している
    labels: jsArrayCategory,
    datasets: [{
      backgroundColor: jsArrayByCategoryBackgroundColor,
      data: jsArraySalesByCategory
    }],
  };
  </script>
  <script>
  //オプション設定
  
  var byCategoryGraphOption = {
    responsive: false,//画面サイズに合わせるか
  };
  </script>
  <script>
<%
if ((null != category) && (null != salesByCategory)) {
%>
  var objByCategoryGraph = document.getElementById(BY_CATEGORY_GRAPH_CONSTANTS.CANVAS_ID).getContext('2d');
  
  var jsArraySalesByCategory = new Chart(objByCategoryGraph, {
    // 作成するグラフの種類
    type: 'pie',

    // ラベルとデータセットを設定
    data: byCategoryGraphData,

    // オプション設定
    options: byCategoryGraphOption
    //options: {}
  });
  <%
}
%>
  </script>
