<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List"%>
<%@ page import="jp.co.lsij.p16590004.common.Error"%>
<%@ page import="jp.co.lsij.p16590004.common.ScopeNameConstants"%>
<%@ page import="jp.co.lsij.p16590004.common.UWAnalysisConstants"%>
<%@ page import="jp.co.lsij.p16590004.e_77.model.analyze.beans.TotalAnalyzeBean"%>
<%@ page import="jp.co.lsij.p16590004.e_77.model.analyze.beans.TotalByCategoryAnalyzeBean"%>
<%@ page import="jp.co.lsij.p16590004.e_77.model.analyze.beans.TotalBySalesStaffAnalyzeBean"%>
<%@ page import="jp.co.lsij.p16590004.e_77.model.analyze.beans.NextYearOrdersBySalesStaffAnalyzeBean"%>
<%@ page import="jp.co.lsij.p16590004.e_77.util.StringHelper"%>
<!DOCTYPE html>

<html lang="ja">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name="format-detection" content="telephone=no">
  
  <link href="CSS/Normalize.css" rel="stylesheet" type="text/css">
  <link href="CSS/p16590004.css" rel="stylesheet" type="text/css">
  <link href="CSS/another_type_total_year.css" rel="stylesheet" type="text/css">
  <link href="CSS/print.css" rel="stylesheet" type="text/css" media="print">

  <script src="BrowserBackPrevent.js"></script>
  <script src="displayFrameTitle.js"></script>
  <script src="SelectBoxUtil.js"></script>
  <script src="another_type_total_year.js"></script>

  <script src="JS_LIB/chart/Chart.min.js" type="text/javascript"></script>

  <title>総計分類別</title>

<%
/** 過去表示実行後か（or メニューからの表示か） */
boolean         isExistTotalAnalyzeBean = false;
/** 集計結果オブジェクト */
TotalAnalyzeBean    totalAnalyzeBean = null;
/** 分類別オブジェクト */
List<TotalByCategoryAnalyzeBean> totalByCategoryAnalyzeList = null;
/** 担当別オブジェクト */
List<TotalBySalesStaffAnalyzeBean> totalBySalesStaffAnalyzeList = null;
/** 担当別来年度案件状況オブジェクト */
List<NextYearOrdersBySalesStaffAnalyzeBean> nextYearOrdersBySalesStaffAnalyzeList = null;

/** 分類別の先頭列の文字列 */
String[] strArrayFirstColumnForTotalByCategory = {"―", "目標値", "受注済分", "売上済分", "合計", "差異", "分類別達成率"};
/** 担当別の先頭列の文字列 */
String[] strArrayFirstColumnForTotalBySalesStaff = {"―", "売上目標値", "合計", "差異", "個人達成率"};
/** 来年度案件状況の先頭列の文字列 */
String[] strArrayFirstColumnForNextYearOrdersBySalesStaff = {"―", "注残目標値", "受注済", "見込み"};
/** 例外処理をまとめるのに使用 */
List<String> errorMessageList = new ArrayList<String>();
%>

<%!
/**
 * 分類別の行文字列生成
 * 
 * @param strArrayFirstColumn　先頭行文字列配列
 * @param list　分類別データリストオブジェクト
 * @param nLine　行インデックス
 * @return 行文字列
 */
String createTRSentenceForTotalByCategory(String[] strArrayFirstColumn, List<TotalByCategoryAnalyzeBean> list, int nLine){
//  assert(null != strArrayFirstColumn);
//  assert(null != list);
//    aseert(0 <= nLine);

  if (null == strArrayFirstColumn) {
    throw new IllegalArgumentException("strArrayFirstColumn == null");
  }
  if (null == list) {
    throw new IllegalArgumentException("list == null");
  }
  if (0 > nLine) {
    throw new IllegalArgumentException("nLine < 0");
  }
   StringBuilder trSentenceBuilder = new StringBuilder();

   trSentenceBuilder.append("<tr");
   if (0 == nLine) {
     //trSentenceBuilder.append("align='center' bgcolor='#C4E2FD'");
   }
   trSentenceBuilder.append(">");
   
   if (0 == nLine) {
     //trSentenceBuilder.append("<th style='width: 100px'>");
     trSentenceBuilder.append("<th class='left_side_column'>");
   } else {
     trSentenceBuilder.append("<td class='left_side_column'>");
   }
   if ((nLine + 1 <= strArrayFirstColumn.length) && (null != strArrayFirstColumn[nLine])) {
     trSentenceBuilder.append(strArrayFirstColumn[nLine]);
   } else {
     trSentenceBuilder.append("null");
   }
   if (0 == nLine) {
     trSentenceBuilder.append("</th>");
   } else {
     trSentenceBuilder.append("</td>");
   }
   
   for (TotalByCategoryAnalyzeBean totalByCategoryAnalyze : list) {
     if (0 == nLine) {
       /*trSentenceBuilder.append("<th style='width: 100px'>");*/
     } else {
       /*trSentenceBuilder.append("<td align='right'>");*/
     }
     if (null == totalByCategoryAnalyze) {
       if (0 == nLine) {
         //trSentenceBuilder.append("<th class='1行目と同じ'>");
         trSentenceBuilder.append("<th>");
       } else {
         //trSentenceBuilder.append("<td class='1行目と同じ'>");
         trSentenceBuilder.append("<td>");
       }
       trSentenceBuilder.append("null");
       if (0 == nLine) {
         trSentenceBuilder.append("</th>");
       } else {
         trSentenceBuilder.append("</td>");
       }
       continue;
     }
     String strCell = "Invalid";
     switch (nLine) {
       case 0://１行目
         //trSentenceBuilder.append("<th style='width: 100px'>");
         trSentenceBuilder.append("<th>");
         if (null == totalByCategoryAnalyze.getCategoryName()) {
           strCell = "null";
         } else {
           strCell = totalByCategoryAnalyze.getCategoryName();
           strCell = StringHelper.htmlEscape(strCell);//エスケープ処理追加
         }
         break;
       case 1://２行目
         //trSentenceBuilder.append("<td align='right'>");
         trSentenceBuilder.append("<td>");
         strCell = StringHelper.toNumberStringWithComma(totalByCategoryAnalyze.getTargetVal());
         break;
       case 2://３行目
         //trSentenceBuilder.append("<td align='right'>");
         trSentenceBuilder.append("<td>");
         strCell = StringHelper.toNumberStringWithComma(totalByCategoryAnalyze.getTotalOrderAmount());
         break;
       case 3://４行目
         //trSentenceBuilder.append("<td align='right'>");
         trSentenceBuilder.append("<td>");
         strCell = StringHelper.toNumberStringWithComma(totalByCategoryAnalyze.getTotalSalesAmount());
         break;
       case 4://５行目
         //trSentenceBuilder.append("<td align='right'>");
         trSentenceBuilder.append("<td>");
         totalByCategoryAnalyze.calc();
         strCell = StringHelper.toNumberStringWithComma(totalByCategoryAnalyze.getTotalAmount());
         break;
       case 5://６行目
         totalByCategoryAnalyze.calc();
         strCell = StringHelper.toNumberStringWithComma(totalByCategoryAnalyze.getVariance());
         if (totalByCategoryAnalyze.getVariance() <= 0) {
           trSentenceBuilder.append("<td class='minus_value'>");
         } else {
           trSentenceBuilder.append("<td class='plus_value'>");
//           trSentenceBuilder.append("<td align='plus_value'>");
         }
         break;
       case 6://７行目
         //trSentenceBuilder.append("<td align='right'>");
         trSentenceBuilder.append("<td>");
         totalByCategoryAnalyze.calc();
         strCell = StringHelper.toNumberStringWithPercent(totalByCategoryAnalyze.getAchievementRate());
         break;
     }
     if (0 == nLine) {
       trSentenceBuilder.append(strCell + "</th>");
     } else {
       trSentenceBuilder.append(strCell + "</td>");
     }
   }
   
   trSentenceBuilder.append("</tr>");
   
   String strTRSentence = trSentenceBuilder.toString();
   
   return strTRSentence;
}

/**
 * 担当別の行文字列生成
 * 
 * @param strArrayFirstColumn　先頭行文字列配列
 * @param list　担当別データリストオブジェクト
 * @param nLine　行インデックス
 * @return 行文字列
 */
String createTRSentenceForTotalBySalesStaff(String[] strArrayFirstColumn, List<TotalBySalesStaffAnalyzeBean> list, int nLine){
//  assert(null != strArrayFirstColumn);
//  assert(null != list);
//    aseert(0 <= nLine);

  if (null == strArrayFirstColumn) {
    throw new IllegalArgumentException("strArrayFirstColumn == null");
  }
  if (null == list) {
    throw new IllegalArgumentException("list == null");
  }
  if (0 > nLine) {
    throw new IllegalArgumentException("nLine < 0");
  }
   StringBuilder trSentenceBuilder = new StringBuilder();

   trSentenceBuilder.append("<tr");
   if (0 == nLine) {
     //trSentenceBuilder.append(" align='center' bgcolor='#C4E2FD'");
   }
   trSentenceBuilder.append(">");
   
   if (0 == nLine) {
     //trSentenceBuilder.append("<th style='width: 100px'>");
     trSentenceBuilder.append("<th class='left_side_column'>");
   } else {
     trSentenceBuilder.append("<td class='left_side_column'>");
   }
   if ((nLine + 1 <= strArrayFirstColumn.length) && (null != strArrayFirstColumn[nLine])) {
     trSentenceBuilder.append(strArrayFirstColumn[nLine]);
   } else {
     trSentenceBuilder.append("null");
   }
   if (0 == nLine) {
     trSentenceBuilder.append("</th>");
   } else {
     trSentenceBuilder.append("</td>");
   }
   
   for (TotalBySalesStaffAnalyzeBean totalBySalesStaffAnalyze : list) {
     if (0 == nLine) {
       //trSentenceBuilder.append("<th style='width: 100px'>");
       //trSentenceBuilder.append("<th>");
     } else {
       //trSentenceBuilder.append("<td align='right'>");
       //trSentenceBuilder.append("<td>");
     }
     if (null == totalBySalesStaffAnalyze) {
       if (0 == nLine) {
         trSentenceBuilder.append("<th>");
       } else {
         trSentenceBuilder.append("<td>");
       }
       trSentenceBuilder.append("null");
       if (0 == nLine) {
         trSentenceBuilder.append("</th>");
       } else {
         trSentenceBuilder.append("</td>");
       }
       continue;
     }
     String strCell = "Invalid";
     switch (nLine) {
       case 0://１行目
         //trSentenceBuilder.append("<th style='width: 100px'>");
         trSentenceBuilder.append("<th>");
         if (null == totalBySalesStaffAnalyze.getSalesStaffName()) {
           strCell = "null";
         } else {
           strCell = totalBySalesStaffAnalyze.getSalesStaffName();
           strCell = StringHelper.htmlEscape(strCell);//エスケープ処理追加
         }
         break;
       case 1://２行目
         //trSentenceBuilder.append("<td align='right'>");
         trSentenceBuilder.append("<td>");
         strCell = StringHelper.toNumberStringWithComma(totalBySalesStaffAnalyze.getTargetVal());
         break;
       case 2://３行目
         //trSentenceBuilder.append("<td align='right'>");
         trSentenceBuilder.append("<td>");
         strCell = StringHelper.toNumberStringWithComma(totalBySalesStaffAnalyze.getTotalAmount());
         break;
       case 3://４行目
         
         totalBySalesStaffAnalyze.calc();
         strCell = StringHelper.toNumberStringWithComma(totalBySalesStaffAnalyze.getVariance());
         if (totalBySalesStaffAnalyze.getVariance() <= 0) {
           trSentenceBuilder.append("<td class='minus_value'>");
         } else {
           trSentenceBuilder.append("<td class='plus_value'>");
//           trSentenceBuilder.append("<td align='plus_value'>");
         }
         break;
       case 4://５行目
         //trSentenceBuilder.append("<td align='right'>");
         trSentenceBuilder.append("<td>");
         totalBySalesStaffAnalyze.calc();
         strCell = StringHelper.toNumberStringWithPercent(totalBySalesStaffAnalyze.getAchievementRate());
         break;
     }
     if (0 == nLine) {
       trSentenceBuilder.append(strCell + "</th>");
     } else {
       trSentenceBuilder.append(strCell + "</td>");
     }
   }
   
   trSentenceBuilder.append("</tr>");
   
   String strTRSentence = trSentenceBuilder.toString();
   
   return strTRSentence;
}

/**
 * 来年度案件状況の行文字列生成
 * 
 * @param strArrayFirstColumn　先頭行文字列配列
 * @param list　来年度案件状況データリストオブジェクト
 * @param nLine　行インデックス
 * @return 行文字列
 */
String createTRSentenceForNextYearOrdersBySalesStaff(String[] strArrayFirstColumn, List<NextYearOrdersBySalesStaffAnalyzeBean> list, int nLine){
//  assert(null != strArrayFirstColumn);
//  assert(null != list);
//    aseert(0 <= nLine);

  if (null == strArrayFirstColumn) {
    throw new IllegalArgumentException("strArrayFirstColumn == null");
  }
  if (null == list) {
    throw new IllegalArgumentException("list == null");
  }
  if (0 > nLine) {
    throw new IllegalArgumentException("nLine < 0");
  }
   StringBuilder trSentenceBuilder = new StringBuilder();

   trSentenceBuilder.append("<tr");
   if (0 == nLine) {
     //trSentenceBuilder.append(" align='center' bgcolor='#C4E2FD'");
   }
   trSentenceBuilder.append(">");
   
   if (0 == nLine) {
     //trSentenceBuilder.append("<th style='width: 100px'>");
     trSentenceBuilder.append("<th class='left_side_column'>");
   } else {
     trSentenceBuilder.append("<td class='left_side_column'>");
   }
   if ((nLine + 1 <= strArrayFirstColumn.length) && (null != strArrayFirstColumn[nLine])) {
     trSentenceBuilder.append(strArrayFirstColumn[nLine]);
   } else {
     trSentenceBuilder.append("null");
   }
   if (0 == nLine) {
     trSentenceBuilder.append("</th>");
   } else {
     trSentenceBuilder.append("</td>");
   }
   
   for (NextYearOrdersBySalesStaffAnalyzeBean nextYearOrdersBySalesStaffAnalyze : list) {
     if (0 == nLine) {
       //trSentenceBuilder.append("<th style='width: 100px'>");
     } else {
       //trSentenceBuilder.append("<td align='right'>");
     }
     if (null == nextYearOrdersBySalesStaffAnalyze) {
       if (0 == nLine) {
         trSentenceBuilder.append("<th>");
       } else {
         trSentenceBuilder.append("<td>");
       }
       trSentenceBuilder.append("null");
       if (0 == nLine) {
         trSentenceBuilder.append("</th>");
       } else {
         trSentenceBuilder.append("</td>");
       }
       continue;
     }
     String strCell = "Invalid";
     switch (nLine) {
       case 0://１行目
         //trSentenceBuilder.append("<th style='width: 100px'>");
         trSentenceBuilder.append("<th>");
         if (null == nextYearOrdersBySalesStaffAnalyze.getSalesStaffName()) {
           strCell = "null";
         } else {
           strCell = nextYearOrdersBySalesStaffAnalyze.getSalesStaffName();
           strCell = StringHelper.htmlEscape(strCell);//エスケープ処理追加
         }
         break;
       case 1://２行目
         //trSentenceBuilder.append("<td align='right'>");
         trSentenceBuilder.append("<td>");
         strCell = StringHelper.toNumberStringWithComma(nextYearOrdersBySalesStaffAnalyze.getNextYearTargetVal());
         break;
       case 2://３行目
         strCell = StringHelper.toNumberStringWithComma(nextYearOrdersBySalesStaffAnalyze.getTotalOrderAmount());
         if (nextYearOrdersBySalesStaffAnalyze.getTotalOrderAmount() <= 0) {
           trSentenceBuilder.append("<td class='minus_value'>");
         } else {
           trSentenceBuilder.append("<td class='plus_value'>");
//           trSentenceBuilder.append("<td align='plus_value'>");
         }
         break;
       case 3://４行目
         //trSentenceBuilder.append("<td align='right'>");
         trSentenceBuilder.append("<td>");
         strCell = StringHelper.toNumberStringWithComma(nextYearOrdersBySalesStaffAnalyze.getTotalForecastAmount());
         break;
     }
     if (0 == nLine) {
       trSentenceBuilder.append(strCell + "</th>");
     } else {
       trSentenceBuilder.append(strCell + "</td>");
     }
   }
   
   trSentenceBuilder.append("</tr>");
   
   String strTRSentence = trSentenceBuilder.toString();
   
   return strTRSentence;
}

%>

</head>
<body>
<%
try {
  //コントローラからの各種情報の取得
  Error  error = null;
  error = (Error)request.getAttribute(ScopeNameConstants.SCOPE_ERROR_CLASS);
  if (null == error) {
    errorMessageList.add("error==null");
  }
  boolean  isPast = false;
  isPast = (boolean)request.getAttribute(UWAnalysisConstants.SCOPE_UW_ANALYSIS_PAST_OR_NOT);
  if (false == isPast) {
    isExistTotalAnalyzeBean = true;
  } else {
    isExistTotalAnalyzeBean = (boolean)request.getAttribute(UWAnalysisConstants.SCOPE_DATA_EXISTS);
  }
  if (false != isExistTotalAnalyzeBean) {
    totalAnalyzeBean = (TotalAnalyzeBean)request.getAttribute(UWAnalysisConstants.SCOPE_DATA_OF_UW_ANALYSIS);
    if (null == totalAnalyzeBean) {
      errorMessageList.add("dataOfUWAnalysis==null");
    } else {
      totalByCategoryAnalyzeList = totalAnalyzeBean.getTotalByCategoryAnalyzeList();
      if (null == totalByCategoryAnalyzeList) {
        errorMessageList.add("totalByCategoryAnalyzeList==null");
      }
      totalBySalesStaffAnalyzeList = totalAnalyzeBean.getTotalBySalesStaffAnalyzeList();
      if (null == totalBySalesStaffAnalyzeList) {
        errorMessageList.add("totalBySalesStaffAnalyzeList==null");
      }
      nextYearOrdersBySalesStaffAnalyzeList = totalAnalyzeBean.getNextYearOrdersBySalesStaffAnalyzeList();
      if (null == nextYearOrdersBySalesStaffAnalyzeList) {
        errorMessageList.add("nextYearOrdersBySalesStaffAnalyzeList==null");
      }
    }
  }
} catch (Exception err) {
  try {
    errorMessageList.add("例外発生（データ取得部）（"+ err.getMessage() + "）");
  } catch (Exception err_2) {}
}
%>
  <br>
  <h3 class="page_title">総計分類別
    <%--JSTL使用するように変更 --%>
    <c:if test="${dataExists != false}">
      ―<fmt:formatDate value="${dataOfUWAnalysis.aggregateDate}" pattern="yyyy年MM月dd日"/>
    </c:if>
  </h3>

  <%--エラー表示を行う箇所 --%>
  <c:choose>
    <c:when test="${error.isError}">
      <p class="error_message noprint"><c:out value="${error.errorInfo}" /></p>
    </c:when>
<%-- エスケープさせるため
    <c:when test="${error.isError}"><p class="error_message noprint">${error.errorInfo}</p></c:when>
--%>
    <c:otherwise></c:otherwise>
  </c:choose>

  <form id="Mainform" name="Mainform" action="./UWAnalysisController" method="POST">
    <table class="another_type_total_year_out_table">
      <tr>
        <td>
          <table class="search_area_table">
            <tr>
              <%-- コンボボックス処理--%>
              <%--JSTL使用するように変更 --%>
              <c:if test="${isPast != false}">
                <td class="search_area_select">
                  <select id="total_by_category_date_select_box_id" class="noprint" name="search_yearmonth">
<%-- コンボボックスが選択されていない場合に、チェックがない
                  <select class="noprint" name="search_yearmonth">
--%>
                  <c:forEach var="aggregateDate" items="${dateOfCalculation}" varStatus="loopStatus">
                    <option value="${aggregateDate.id}" 
                    <c:if test="${loopStatus.first != false}">selected</c:if>
                    > <%--optionタグの閉じのため消さない --%>
                    <fmt:formatDate value="${aggregateDate.aggregateDate}" pattern="yyyy年MM月dd日"/>
                    </option>
                  </c:forEach>
                  </select>
                </td>
              </c:if>
              <c:if test="${isPast}">
                <td class="search_area_button">
                  <button type="submit" class="noprint" name="action" value="another_type_total_year_dis" onClick="return clickDispProc()">表示</button>
<%-- コンボボックスが選択されていない場合に、チェックがない
                  <button type="submit" class="noprint" name="action" value="another_type_total_year_dis">表示</button>
--%>
                </td>
              </c:if>
              <td class="search_area_button">
                <button type="button" class="noprint" onClick="print()">印刷</button>
              </td>
            </tr>
          </table>
        </td>
      </tr>
      <tr>
        <td>　</td>
      </tr>
      <tr>
        <td>分類別</td>
      </tr>

      <tr>
        <td>
        <%--if文で振り分けを入れる箇所　（過去の初回だった場合にclassを指定しない） --%>
          <table class="another_type_total_year_cat_table">
<%
try {
  if (false == isExistTotalAnalyzeBean) {
    boolean bFirst = true;
    for (String strFirstColumn : strArrayFirstColumnForTotalByCategory) {
      if (null == strFirstColumn) {
        out.println("<tr>");
        if (false == bFirst) {
          out.println("<td>null</td>");
        } else {
          out.println("<th>null</th>");
        }
      } else {
        out.println("<tr>");
        if (false == bFirst) {
          out.println("<td class='left_side_column'>" + strFirstColumn + "</td>");
        } else {
          out.println("<th class='left_side_column'>" + strFirstColumn + "</th>");
        }
      }
      out.println("</tr>");
      if (false != bFirst) {
        bFirst = false;
      }
    }
  } else {
    if (null != totalAnalyzeBean) {
      int nLine = 0;
      for (String strFirstColumn : strArrayFirstColumnForTotalByCategory) {
        out.println(createTRSentenceForTotalByCategory(strArrayFirstColumnForTotalByCategory, totalByCategoryAnalyzeList, nLine));
        nLine++;
      }
    }
  }
} catch (Exception err) {
  try {
    errorMessageList.add("例外発生（表生成部（１）（" + err.getMessage() + "）");
  } catch (Exception err_2) {}
}
%>
          </table>
        </td>
      </tr>
      
      <tr>
        <td>　</td>
      </tr>
      
      <tr>
        <td>担当別</td>
      </tr>
      
      <tr>
        <td>
        <%--if文で振り分けを入れる箇所　（過去の初回だった場合にclassを指定しない） --%>
          <table class="another_type_total_year_sales_user_table">

<%
try {
  if (false == isExistTotalAnalyzeBean) {
    boolean bFirst = true;
    for (String strFirstColumn : strArrayFirstColumnForTotalBySalesStaff) {
      if (null == strFirstColumn) {
        out.println("<tr>");
        if (false == bFirst) {
          out.println("<td>null</td>");
        } else {
          out.println("<th>null</th>");
        }
      } else {
        out.println("<tr>");
        if (false == bFirst) {
          out.println("<td class='left_side_column'>" + strFirstColumn + "</td>");
        } else {
          out.println("<th class='left_side_column'>" + strFirstColumn + "</th>");
        }
      }
      out.println("</tr>");
      if (false != bFirst) {
        bFirst = false;
      }
    }
  } else {
    if (null != totalAnalyzeBean) {
      int nLine = 0;
      for (String strFirstColumn : strArrayFirstColumnForTotalBySalesStaff) {
        out.println(createTRSentenceForTotalBySalesStaff(strArrayFirstColumnForTotalBySalesStaff, totalBySalesStaffAnalyzeList, nLine));
        nLine++;
      }
    }
  }
} catch (Exception err) {
  try {
    errorMessageList.add("例外発生（表生成部（２） ）（" + err.getMessage() + "）");
  } catch (Exception err_2) {}
}
%>
          </table>
        </td>
      </tr>
      
      <tr>
        <td>　</td>
      </tr>

      <tr>
        <td>来年度案件状況</td>
      </tr>
      
      <tr>
        <td>
        <%--if文で振り分けを入れる箇所　（過去の初回だった場合にclassを指定しない） --%>
          <table class="another_type_total_year_next_year_table">

<%
try {
  if (false == isExistTotalAnalyzeBean) {
    boolean bFirst = true;
    for (String strFirstColumn : strArrayFirstColumnForNextYearOrdersBySalesStaff) {
      if (null == strFirstColumn) {
        out.println("<tr>");
        if (false == bFirst) {
          out.println("<td>null</td>");
        } else {
          out.println("<th>null</th>");
        }
      } else {
        out.println("<tr>");
        if (false == bFirst) {
          out.println("<td class='left_side_column'>" + strFirstColumn + "</td>");
        } else {
          out.println("<th class='left_side_column'>" + strFirstColumn + "</th>");
        }
      }
      out.println("</tr>");
      if (false != bFirst) {
        bFirst = false;
      }
    }
  } else {
    if (null != totalAnalyzeBean) {
      int nLine = 0;
      for (String strFirstColumn : strArrayFirstColumnForNextYearOrdersBySalesStaff) {
        out.println(createTRSentenceForNextYearOrdersBySalesStaff(strArrayFirstColumnForNextYearOrdersBySalesStaff, nextYearOrdersBySalesStaffAnalyzeList, nLine));
        nLine++;
      }
    }
  }
} catch (Exception err) {
  try {
    errorMessageList.add("例外発生（表生成部（３） ）（" + err.getMessage() + "）");
  } catch (Exception err_2) {}
}
%>
          </table>
        </td>
      </tr>
    </table>
  </form>
  <br>
  <br>
  <br>
<%
String[] categoryData = null;
String[] salesByCategoryData = null;
try {
  if (false == isExistTotalAnalyzeBean) {
  } else {
    if (null != totalAnalyzeBean) {
      categoryData = new String[totalByCategoryAnalyzeList.size()];
      salesByCategoryData = new String[totalByCategoryAnalyzeList.size()];
      for (int nIndex = 0; nIndex < totalByCategoryAnalyzeList.size(); nIndex++) {
        categoryData[nIndex] = totalByCategoryAnalyzeList.get(nIndex).getCategoryName();
        salesByCategoryData[nIndex] = StringHelper.valueOf(totalByCategoryAnalyzeList.get(nIndex).getTotalAmount());
      }
    }
  }
  request.setAttribute("category_data", categoryData);
  request.setAttribute("sales_by_category_data", salesByCategoryData);
} catch (Exception err) {
  try {
    errorMessageList.add("例外発生（グラフ生成部（分類データ））（" + err.getMessage() + "）");
  } catch (Exception err_2) {}
}
%>

<%
String[] salesStaffData = null;
String[] salesByChargeData = null;
try {
  if (false == isExistTotalAnalyzeBean) {
  } else {
    if (null != totalAnalyzeBean) {
      salesStaffData = new String[totalBySalesStaffAnalyzeList.size()];
      salesByChargeData = new String[totalBySalesStaffAnalyzeList.size()];
      for (int nIndex = 0; nIndex < totalBySalesStaffAnalyzeList.size(); nIndex++) {
        salesStaffData[nIndex] = totalBySalesStaffAnalyzeList.get(nIndex).getSalesStaffName();
        salesByChargeData[nIndex] = StringHelper.valueOf(totalBySalesStaffAnalyzeList.get(nIndex).getTotalAmount());
      }
    }
  }
  request.setAttribute("sales_staff_data", salesStaffData);
  request.setAttribute("sales_by_charge_data", salesByChargeData);
} catch (Exception err) {
  try {
    errorMessageList.add("例外発生（グラフ生成部（担当営業データ））（" + err.getMessage() + "）");
  } catch (Exception err_2) {}
}
%>
<%
if (null != totalAnalyzeBean) {
%>
  <table>
      <tr>
        <td>分類別</td>
        <td>担当別</td>
      </tr>
      <tr>
        <td>
          <jsp:include page="include_classification_graph.jsp" flush="true" />
<%
try {
  //include_classification_graph.jsp 内のエラーをコピー
  List<String> classificationErrorMessageList = (List<String>)request.getAttribute("classificationErrorMessageList");
  if (null != classificationErrorMessageList) {
    for (String classificationErrorMessage : classificationErrorMessageList) {
      errorMessageList.add(classificationErrorMessage);
    }
  }
} catch (Exception err) {
  try {
    errorMessageList.add("例外発生（グラフエラー設定部（１））（" + err.getMessage() + "）");
  } catch (Exception err_2) {}
}
%>
        </td>
        <td>
          <jsp:include page="include_by_charge_graph.jsp" flush="true" />
<%
try {
  //include_by_charge_graph.jsp 内のエラーをコピー
  List<String> byChargeErrorMessageList = (List<String>)request.getAttribute("byChargeErrorMessageList");
  if (null != byChargeErrorMessageList) {
    for (String byChargeErrorMessage : byChargeErrorMessageList) {
      errorMessageList.add(byChargeErrorMessage);
    }
  }
} catch (Exception err) {
  try {
    errorMessageList.add("例外発生（グラフエラー設定部（２））（" + err.getMessage() + "）");
  } catch (Exception err_2) {}
}
%>
        </td>
      </tr>
<%
}
%>
  </table>
  <br>

<%
//共通モジュールに渡すエラーリストをリクエストスコープにセット
request.setAttribute("errorMessageList", errorMessageList);
%>
  <jsp:include page="include_error_message.jsp" flush="true"/>
</body>
</html>
