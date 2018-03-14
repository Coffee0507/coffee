<%@ page session="false" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
  pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.List" %>
<%@ page import="java.time.Month"%>
<%@ page import="jp.co.lsij.p16590004.common.Error"%>
<%@ page import="jp.co.lsij.p16590004.common.QuarterType"%>
<%@ page import="jp.co.lsij.p16590004.common.UWCalcType"%>
<%@ page import="jp.co.lsij.p16590004.common.ScopeNameConstants"%>
<%@ page import="jp.co.lsij.p16590004.common.MeetingDataConstants"%>
<%@ page import="jp.co.lsij.p16590004.e_200.model.analyze.beans.MeetingDataTarget"%>
<%@ page import="jp.co.lsij.p16590004.e_200.model.analyze.beans.MeetingDataTargetSales"%>
<%@ page import="jp.co.lsij.p16590004.e_200.model.analyze.beans.MeetingDataTargetOrder"%>
<%@ page import="jp.co.lsij.p16590004.e_200.model.analyze.beans.MeetingData"%>
<%@ page import="jp.co.lsij.p16590004.e_200.model.analyze.beans.TotalAmountBySalesStatus"%>
<%@ page import="jp.co.lsij.p16590004.e_77.util.StringHelper"%>
<%@ page import="jp.co.lsij.p16590004.e_77.util.MathHelper"%>
<!DOCTYPE html>

<html lang="ja">
<head>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta name="format-detection" content="telephone=no">
  
  <link href="CSS/Normalize.css" rel="stylesheet" type="text/css">
  <link href="CSS/p16590004.css" rel="stylesheet" type="text/css">
  <link href="CSS/print.css" rel="stylesheet" type="text/css" media="print">
  <link href="CSS/meeting_data.css" rel="stylesheet" type="text/css">

  <script src="displayFrameTitle.js"></script>
  <script src="BrowserBackPrevent.js"></script>
  <script src="meeting_data.js"></script>

  <title>管理職会議用</title>

<%
/** 月の並び順配列 */
int[] nMonthArray = {4, 5, 6, 7, 8, 9, 10, 11, 12, 1, 2, 3};

/** 管理職会議設定オブジェクト */
MeetingDataTarget meetingDataTarget = null;
/** 集計結果オブジェクト */
MeetingData     meetingData = null;

/** 例外処理をまとめるのに使用 */
List<String> errorMessageList = new ArrayList<String>();
%>

<%!
/**
 * 本年度売上/受注目標への進捗の１～２行文字列生成
 * 
 * @param mtgDataTarget　設定データオブジェクト
 * @param isOrderTarget 受注用
 * @return １～２行文字列
 */
String createTRSentenceForFirstAndSecondLine(MeetingDataTarget mtgDataTarget, boolean isOrderTarget){
//  assert(null != mtgDataTarget);

  if (null == mtgDataTarget) {
    throw new IllegalArgumentException("mtgDataTarget == null");
  }
  String strFirstColumn = null;
  
  if (false == isOrderTarget) {
    strFirstColumn = new String("四半期別売上目標");
  } else {
    strFirstColumn = new String("四半期別受注目標");
  }
  StringBuilder trSentenceBuilder = new StringBuilder();
  //１行目
  trSentenceBuilder.append("<tr>");
  trSentenceBuilder.append("<th rowspan='2' class='left_side_name'>");
  trSentenceBuilder.append(strFirstColumn);
  trSentenceBuilder.append("</th>");

  if (false != isOrderTarget) {
    trSentenceBuilder.append("<th class='total'>")
    .append("前期注残")
    .append("</th>");
  }
  String[] strArrayFirstLine = {"Q1", "Q2", "Q3", "Q4", "合計"};
  int[] intArrayColumnSpan   =   {3,     3,   3,     3,      1};
  if (strArrayFirstLine.length != intArrayColumnSpan.length) {
    throw new IllegalStateException("strArrayFirstLine.length != intArrayColumnSpan.length");
  }
  int nIndex = 0;
  for (String str : strArrayFirstLine) {
    if (str == "合計") {
      trSentenceBuilder.append("<th " + "colspan='" + String.valueOf(intArrayColumnSpan[nIndex]) + "' class='total'>");
    } else {
    trSentenceBuilder.append("<th " + "colspan='" + String.valueOf(intArrayColumnSpan[nIndex]) + "' class='quarter'>");
    }
    if (null == str) {
      trSentenceBuilder.append("null");
    } else {
      trSentenceBuilder.append(str);
    }
    trSentenceBuilder.append("</th>");
    nIndex++;
  }
  trSentenceBuilder.append("</tr>");
  
  //２行目
  long lBackLogTarget = 0;
  trSentenceBuilder.append("<tr>");
  if (false != isOrderTarget) {
    trSentenceBuilder.append("<td>");
    MeetingDataTargetOrder meetingDataTargetOrder = mtgDataTarget.getTargetOrder();
    if (null == meetingDataTargetOrder) {
      trSentenceBuilder.append("null");
    } else {
      lBackLogTarget = meetingDataTargetOrder.getBacklog();
      trSentenceBuilder.append(StringHelper.toNumberStringWithComma(meetingDataTargetOrder.getBacklog()));
    }
    trSentenceBuilder.append("</td>");
  }
  long lSum = -1;
  long[] longArryTarget = {-1, -1, -1, -1};//四半期単位
  String[] strArryTarget = {"nill", "nill", "nill", "nill"};//四半期単位
  if (false == isOrderTarget) {
    MeetingDataTargetSales meetingDataTargetSales = mtgDataTarget.getTargetSales();
    if (null != meetingDataTargetSales) {
      lSum = meetingDataTargetSales.sumByYear();
      longArryTarget[0] = meetingDataTargetSales.getQ1();
      longArryTarget[1] = meetingDataTargetSales.getQ2();
      longArryTarget[2] = meetingDataTargetSales.getQ3();
      longArryTarget[3] = meetingDataTargetSales.getQ4();
      nIndex = 0;
      for (long lTarget : longArryTarget) {
        strArryTarget[nIndex] = StringHelper.toNumberStringWithComma(lTarget);
        nIndex++;
      }
    }
  } else {
    MeetingDataTargetOrder meetingDataTargetOrder = mtgDataTarget.getTargetOrder();
    if (null != meetingDataTargetOrder) {
      lSum = meetingDataTargetOrder.sumByYear(true);
      longArryTarget[0] = meetingDataTargetOrder.getQ1();
      longArryTarget[1] = meetingDataTargetOrder.getQ2();
      longArryTarget[2] = meetingDataTargetOrder.getQ3();
      longArryTarget[3] = meetingDataTargetOrder.getQ4();
      nIndex = 0;
      for (long lTarget : longArryTarget) {
        strArryTarget[nIndex] = StringHelper.toNumberStringWithComma(lTarget);
        nIndex++;
      }
    }
  }
  nIndex = 0;
  for (long lTarget : longArryTarget) {
    trSentenceBuilder.append("<td " + "colspan='" + String.valueOf(intArrayColumnSpan[nIndex]) + "'>")
    .append(StringHelper.toNumberStringWithComma(lTarget))
    .append("</td>");
    nIndex++;
  }
  trSentenceBuilder.append("<td>")
  .append(StringHelper.toNumberStringWithComma(lSum))
  .append("</td>");

  trSentenceBuilder.append("</tr>");
  String strTRSentence = trSentenceBuilder.toString();
 
  return strTRSentence;
}

/**
 * 本年度売上/受注目標への進捗の３行文字列生成
 * 
 * @param intArrayMonth 月文字列配列
 * @param isOrderTarget 受注用
 * @return ３行行文字列
 */
String createTRSentenceForThirdLine(int[] intArrayMonth, boolean isOrderTarget){
//  assert(null != intArrayMonth);

  if (null == intArrayMonth) {
    throw new IllegalArgumentException("mtgDataTarget == null");
  }
  StringBuilder trSentenceBuilder = new StringBuilder();

  //３行目
  String strFirstColumn = new String("　");

  trSentenceBuilder.append("<tr>");
//  trSentenceBuilder.append("<tr align='center' bgcolor='#C4E2FD'>");
  trSentenceBuilder.append("<th>");
  trSentenceBuilder.append(strFirstColumn);
  trSentenceBuilder.append("</th>");

  if (false != isOrderTarget) {
    trSentenceBuilder.append("<th>")
    .append("前期")
    .append("</th>");
  }
  for (int nMonth : intArrayMonth) {
    trSentenceBuilder.append("<th class='month'>");
    trSentenceBuilder.append(String.valueOf(nMonth) + "月");
    trSentenceBuilder.append("</th>");
  }
  trSentenceBuilder.append("<th>")
  .append("合計")
  .append("</th>");
  
  trSentenceBuilder.append("</tr>");

  String strTRSentence = trSentenceBuilder.toString();
  
  return strTRSentence;
}

/**
 * 本年度売上目標への進捗の４行目以降行文字列生成
 * 
 * @param intArrayMonth 月文字列配列
 * @param mtgDataTargetSales　売上目標設定データオブジェクト
 * @param mtgData　進捗データオブジェクト
 * @return ４行目以降文字列
 */
String createTRSentenceForSalesTarget(int[] intArrayMonth, MeetingDataTargetSales mtgDataTargetSales, MeetingData mtgData){
//  assert(null != intArrayMonth);
//  assert(null != mtgDataTargetSales);
//  assert(null != mtgData);
  
  if (null == intArrayMonth) {
    throw new IllegalArgumentException("intArrayMonth == null");
  }
  if (null == mtgDataTargetSales) {
    throw new IllegalArgumentException("mtgDataTargetSales == null");
  }
  if (null == mtgData) {
    throw new IllegalArgumentException("mtgData == null");
  }
  long[] longArryTarget = {mtgDataTargetSales.getQ1(), mtgDataTargetSales.getQ2(),
      mtgDataTargetSales.getQ3(), mtgDataTargetSales.getQ4()};//Q1～Q4
  long[] longArrySubTotal = {0, 0, 0, 0};//Q1～Q4
  String[] strArryFirstColumn = {
      "売上済",   null, "GAP 0",
      "受注済",   null, "Sub Total 1", "GAP 1",
      "内示"/*"内示案件"*/, null, "Sub Total 2", "GAP 2",
      "見込み"/*"見込案件"*/, null, "Sub Total 3", "GAP 3",
      "引合い"/*"引合案件"*/, null, "Sub Total 4", "GAP 4"};//null はスパンのため処理しない行を表す

  UWCalcType[] arryUWCalcType = {
      UWCalcType.SALES_ONLY, UWCalcType.SALES_ONLY, null,
      UWCalcType.ORDER_ONLY, UWCalcType.ORDER_ONLY, null, null,
      UWCalcType.UNOFFICIAL_ORDER_ONLY, UWCalcType.UNOFFICIAL_ORDER_ONLY, null, null,
      UWCalcType.PROSPECT_ONLY, UWCalcType.PROSPECT_ONLY, null, null,
      UWCalcType.INQUIRY_ONLY, UWCalcType.INQUIRY_ONLY, null, null};

  if (strArryFirstColumn.length != arryUWCalcType.length) {
    assert(false);
    throw new IllegalStateException("strArryFirstColumn.length != arryUWCalcType.length");
  }
  StringBuilder trSentenceBuilder = new StringBuilder();

  int nIndex = 0;
  for (String strFirstColumn : strArryFirstColumn) {
    trSentenceBuilder.append("<tr>");
    
    if (null == strFirstColumn) {
//クォータ表示
     //  スパン部分のセルを追加しない
      int nQuarterTypeIndex = 0;
      for (QuarterType quarterType : QuarterType.values()) {
        long lQuarterValue = mtgData.sumByQuarter(quarterType, arryUWCalcType[nIndex], true);
        trSentenceBuilder.append("<td colspan='3'>")
        .append(StringHelper.toNumberStringWithComma(lQuarterValue))
        .append("</td>");
        try {
          //longArrySubTotal[nQuarterTypeIndex] += lQuarterValue;
          longArrySubTotal[nQuarterTypeIndex] = MathHelper.safeAdd(longArrySubTotal[nQuarterTypeIndex], lQuarterValue);
        } catch (ArithmeticException err) {
          longArrySubTotal[nQuarterTypeIndex] = Long.MAX_VALUE;
        } catch (Exception err) {
          throw err;
        }
        nQuarterTypeIndex++;
      }
    } else if (-1 != strFirstColumn.indexOf("GAP")) {
//GAP 表示
      trSentenceBuilder.append("<th>")
      .append(strFirstColumn)
      .append("</th>");

      long lSumGap = 0;
      int nQuarterTypeIndex = 0;
      for (QuarterType quarterType : QuarterType.values()) {
//#if 1//2017/08/22 小計-目標
        long lGap = 0;
        try {
          lGap = MathHelper.safeSubtract(longArrySubTotal[nQuarterTypeIndex], longArryTarget[nQuarterTypeIndex]);
        } catch (ArithmeticException err) {
          lGap = Long.MIN_VALUE;
        } catch (Exception err) {
          throw err;
        }
//#else//org 目標ー小計
//        long lGap = longArryTarget[nQuarterTypeIndex] - longArrySubTotal[nQuarterTypeIndex];
//#endif
        //0815
        //trSentenceBuilder.append("<td colspan='3' align='right'>")
        //.append(StringHelper.toNumberStringWithComma(lGap))
        //.append("</td>");
        
        if (lGap <= 0) {
          trSentenceBuilder.append("<td colspan='3' class='mincheck'>")
          .append(StringHelper.toNumberStringWithComma(lGap))
          .append("</td>");
        } else {
          trSentenceBuilder.append("<td colspan='3' class='pluscheck'>")
          .append(StringHelper.toNumberStringWithComma(lGap))
          .append("</td>");
        }
        
        try {
          //lSumGap += lGap;
          lSumGap = MathHelper.safeAdd(lSumGap, lGap);
        } catch (ArithmeticException err) {
          lSumGap = Long.MAX_VALUE;//<--未完成
        } catch (Exception err) {
          throw err;
        }
        nQuarterTypeIndex++;
      }
      //0815
      //trSentenceBuilder.append("<td align='right'>")
      //.append(StringHelper.toNumberStringWithComma(lSumGap))
      //.append("</td>");
      
      if (lSumGap <= 0) {
        trSentenceBuilder.append("<td class='mincheck'>")
        .append(StringHelper.toNumberStringWithComma(lSumGap))
        .append("</td>");
      } else {
        trSentenceBuilder.append("<td class='pluscheck'>")
        .append(StringHelper.toNumberStringWithComma(lSumGap))
        .append("</td>");
      }
      
    } else if (-1 != strFirstColumn.indexOf("Sub")) {
//Sub Total 表示
      trSentenceBuilder.append("<th>")
      .append(strFirstColumn)
      .append("</th>");

      long lSumSubTotal = 0;
      int nQuarterTypeIndex = 0;
      for (QuarterType quarterType : QuarterType.values()) {
        trSentenceBuilder.append("<td colspan='3'>")
        .append(StringHelper.toNumberStringWithComma(longArrySubTotal[nQuarterTypeIndex]))
        .append("</td>");
        try {
//          lSumSubTotal += longArrySubTotal[nQuarterTypeIndex];
          lSumSubTotal = MathHelper.safeAdd(lSumSubTotal, longArrySubTotal[nQuarterTypeIndex]);
        } catch (ArithmeticException err) {
          lSumSubTotal = Long.MAX_VALUE;
        } catch (Exception err) {
          throw err;
        }
        nQuarterTypeIndex++;
      }
      trSentenceBuilder.append("<td>")
      .append(StringHelper.toNumberStringWithComma(lSumSubTotal))
      .append("</td>");
    } else {
//各月データ表示
      trSentenceBuilder.append("<th rowspan='2'>")
      .append(strFirstColumn)
      .append("</th>");
      for (int nMonth : intArrayMonth) {
        long lValue = mtgData.getSumByMonth(Month.of(nMonth), arryUWCalcType[nIndex], true);
        trSentenceBuilder.append("<td>")
        .append(StringHelper.toNumberStringWithComma(lValue))
        .append("</td>");
      }
      long lTotal = mtgData.sumByYear(arryUWCalcType[nIndex], true);
      trSentenceBuilder.append("<td rowspan='2'>")
      .append(StringHelper.toNumberStringWithComma(lTotal))
      .append("</td>");
    }
    trSentenceBuilder.append("</tr>");
    nIndex++;
  }
  String strTRSentence = trSentenceBuilder.toString();
  
  return strTRSentence;
}

/**
 * 本年度受注目標への進捗の４行目以降行文字列生成
 * 
 * @param mtgDataTargetOrder　受注目標設定データオブジェクト
 * @param mtgData　進捗データオブジェクト
 * @return ４行目以降文字列
 */
String createTRSentenceForOrderTarget(int[] intArrayMonth, MeetingDataTargetOrder mtgDataTargetOrder, MeetingData mtgData){
//assert(null != intArrayMonth);
//assert(null != mtgDataTargetOrder);
//assert(null != mtgData);

  if (null == intArrayMonth) {
    throw new IllegalArgumentException("intArrayMonth == null");
  }
  if (null == mtgDataTargetOrder) {
    throw new IllegalArgumentException("mtgDataTargetOrder == null");
  }
  if (null == mtgData) {
    throw new IllegalArgumentException("mtgData == null");
  }
  long lbacklogTarget = mtgDataTargetOrder.getBacklog();
  long[] longArryTarget = {mtgDataTargetOrder.getQ1(), mtgDataTargetOrder.getQ2(),
      mtgDataTargetOrder.getQ3(), mtgDataTargetOrder.getQ4()};//Q1～Q4
  long lbacklogSubTotal = 0;
  long[] longArrySubTotal = {0, 0, 0, 0};//Q1～Q4
  String[] strArryFirstColumn = {
      "受注済<BR>（含む売上済）", null, "GAP 0",
      "内示"/*"内示案件"*/,              null, "Sub Total 1", "GAP 1",
      "見込み"/*"見込案件"*/,              null, "Sub Total 2", "GAP 2",
      "引合い"/*"引合案件"*/,              null, "Sub Total 3", "GAP 3"};//null はスパンのため処理しない行を表す

  UWCalcType[] arryUWCalcType = {
    UWCalcType.ORDER_ONLY, UWCalcType.ORDER_ONLY, null,//ORDER_ONLY だが、売上済みも含める必要がある
    UWCalcType.UNOFFICIAL_ORDER_ONLY, UWCalcType.UNOFFICIAL_ORDER_ONLY, null, null,
    UWCalcType.PROSPECT_ONLY, UWCalcType.PROSPECT_ONLY, null, null,
    UWCalcType.INQUIRY_ONLY, UWCalcType.INQUIRY_ONLY, null, null};

  if (strArryFirstColumn.length != arryUWCalcType.length) {
    assert(false);
    throw new IllegalStateException("strArryFirstColumn.length != arryUWCalcType.length");
  }
  StringBuilder trSentenceBuilder = new StringBuilder();

  int nIndex = 0;
  for (String strFirstColumn : strArryFirstColumn) {
    trSentenceBuilder.append("<tr>");
  
    if (null == strFirstColumn) {
  //クォータ表示
     //  スパン部分のセルを追加しない
//#if 1不具合修正（売上済が加算されていない）
     boolean isOrderLine = false;
     if (UWCalcType.ORDER_ONLY == arryUWCalcType[nIndex]) {
       isOrderLine = true;//受注済行の場合
     }
//#endif
      int nQuarterTypeIndex = 0;
      for (QuarterType quarterType : QuarterType.values()) {
        long lQuarterValue = mtgData.sumByQuarter(quarterType, arryUWCalcType[nIndex], false);
//#if 1不具合修正（売上済が加算されていない）
        if (false != isOrderLine) {
          long lQuarterValue_2 = mtgData.sumByQuarter(quarterType, UWCalcType.SALES_ONLY, false);
          try {
            lQuarterValue = MathHelper.safeAdd(lQuarterValue, lQuarterValue_2);
          } catch (ArithmeticException err) {
            lQuarterValue = Long.MAX_VALUE;
          } catch (Exception err) {
            throw err;
          }
        }
//#endif
        trSentenceBuilder.append("<td colspan='3'>")
        .append(StringHelper.toNumberStringWithComma(lQuarterValue))
        .append("</td>");
        try {
          //longArrySubTotal[nQuarterTypeIndex] += lQuarterValue;
          longArrySubTotal[nQuarterTypeIndex] = MathHelper.safeAdd(longArrySubTotal[nQuarterTypeIndex], lQuarterValue);
        } catch (ArithmeticException err) {
          longArrySubTotal[nQuarterTypeIndex] = Long.MAX_VALUE;
        } catch (Exception err) {
          throw err;
        }
        nQuarterTypeIndex++;
      }
    } else if (-1 != strFirstColumn.indexOf("GAP")) {
//GAP 表示
      trSentenceBuilder.append("<th>")
      .append(strFirstColumn)
      .append("</th>");

      long lGap = 0;
      try {
        //lGap = lbacklogTarget - lbacklogSubTotal;//<--未完成
//#if 1//2017/08/22 小計-目標
        lGap = MathHelper.safeSubtract(lbacklogSubTotal, lbacklogTarget);
//#else//org 目標ー小計
//        lGap = MathHelper.safeSubtract(lbacklogTarget, lbacklogSubTotal);
//#endif
      } catch (ArithmeticException err) {
        lGap = Long.MIN_VALUE;
      } catch (Exception err) {
        throw err;
      }
      long lSumGap = lGap;
      //0815コメントアウト　前沢
      //trSentenceBuilder.append("<td align='right'>")
      //.append(StringHelper.toNumberStringWithComma(lGap))
      //.append("</td>");
      
      if (lSumGap <= 0) {
        trSentenceBuilder.append("<td class='mincheck'>")
        .append(StringHelper.toNumberStringWithComma(lGap))
        .append("</td>");
      } else {
        trSentenceBuilder.append("<td class='pluscheck'>")
        .append(StringHelper.toNumberStringWithComma(lGap))
        .append("</td>");
      }
      
      int nQuarterTypeIndex = 0;
      for (QuarterType quarterType : QuarterType.values()) {
//#if 1//2017/08/22 小計-目標
        try {
          lGap = MathHelper.safeSubtract(longArrySubTotal[nQuarterTypeIndex], longArryTarget[nQuarterTypeIndex]);
        } catch (ArithmeticException err) {
          lGap = Long.MIN_VALUE;
        } catch (Exception err) {
          throw err;
        }
//#else//org 目標ー小計
//        lGap = longArryTarget[nQuarterTypeIndex] - longArrySubTotal[nQuarterTypeIndex];//<--未完成
//#endif
        //0815コメントアウト　前沢
        //trSentenceBuilder.append("<td colspan='3' align='right'>")
        //.append(StringHelper.toNumberStringWithComma(lGap))
        //.append("</td>");
        
        if (lGap <= 0) {
          trSentenceBuilder.append("<td colspan='3' class='mincheck'>")
          .append(StringHelper.toNumberStringWithComma(lGap))
          .append("</td>");
        } else {
          trSentenceBuilder.append("<td colspan='3' class='pluscheck'>")
          .append(StringHelper.toNumberStringWithComma(lGap))
          .append("</td>");
        }
        
        try {
          //lSumGap += lGap;
          lSumGap = MathHelper.safeAdd(lSumGap, lGap);
        } catch (ArithmeticException err) {
          lSumGap = Long.MAX_VALUE;//<--未完成
        } catch (Exception err) {
          throw err;
        }
        nQuarterTypeIndex++;
      }
      //trSentenceBuilder.append("<td align='right'>")
      //.append(StringHelper.toNumberStringWithComma(lSumGap))
      //.append("</td>");
      
      if (lSumGap <= 0) {
        trSentenceBuilder.append("<td class='mincheck'>")
        .append(StringHelper.toNumberStringWithComma(lSumGap))
        .append("</td>");
      } else {
        trSentenceBuilder.append("<td class='pluscheck'>")
        .append(StringHelper.toNumberStringWithComma(lSumGap))
        .append("</td>");
      }
    } else if (-1 != strFirstColumn.indexOf("Sub")) {
//Sub Total 表示
      trSentenceBuilder.append("<th>")
      .append(strFirstColumn)
      .append("</th>");

      long lSumSubTotal = lbacklogSubTotal;

      trSentenceBuilder.append("<td>")
      .append(StringHelper.toNumberStringWithComma(lbacklogSubTotal))
      .append("</td>");

      int nQuarterTypeIndex = 0;
      for (QuarterType quarterType : QuarterType.values()) {
        trSentenceBuilder.append("<td colspan='3'>")
        .append(StringHelper.toNumberStringWithComma(longArrySubTotal[nQuarterTypeIndex]))
        .append("</td>");
        
        try {
          //lSumSubTotal += longArrySubTotal[nQuarterTypeIndex];
          lSumSubTotal = MathHelper.safeAdd(lSumSubTotal, longArrySubTotal[nQuarterTypeIndex]);
        } catch (ArithmeticException err) {
          lSumSubTotal = Long.MAX_VALUE;
        } catch (Exception err) {
          throw err;
        }
        nQuarterTypeIndex++;
      }
      trSentenceBuilder.append("<td>")
      .append(StringHelper.toNumberStringWithComma(lSumSubTotal))
      .append("</td>");
    } else {
//各月データ表示
      trSentenceBuilder.append("<th rowspan='2'>")
      .append(strFirstColumn)
      .append("</th>");

      long lBacklogValue = mtgData.getBacklog(arryUWCalcType[nIndex]);
      trSentenceBuilder.append("<td rowspan='2'>")
      .append(StringHelper.toNumberStringWithComma(lBacklogValue))
      .append("</td>");
      try {
        //lbacklogSubTotal += lBacklogValue;
        lbacklogSubTotal = MathHelper.safeAdd(lbacklogSubTotal, lBacklogValue);
      } catch (ArithmeticException err) {
        lbacklogSubTotal = Long.MAX_VALUE;
      } catch (Exception err) {
        throw err;
      }
//#if 1不具合修正（売上済が加算されていない）
      boolean isOrderLine = false;
      if (UWCalcType.ORDER_ONLY == arryUWCalcType[nIndex]) {
        isOrderLine = true;//受注済行の場合
      }
//#endif
      for (int nMonth : intArrayMonth) {
        long lValue = mtgData.getSumByMonth(Month.of(nMonth), arryUWCalcType[nIndex], false);
//#if 1不具合修正（売上済が加算されていない）
        if (false != isOrderLine) {
          long lValue_2 = mtgData.getSumByMonth(Month.of(nMonth), UWCalcType.SALES_ONLY, false);
          try {
            lValue = MathHelper.safeAdd(lValue, lValue_2);
          } catch (ArithmeticException err) {
            lValue = Long.MAX_VALUE;
          } catch (Exception err) {
            throw err;
          }
        }
//#endif
        trSentenceBuilder.append("<td>")
        .append(StringHelper.toNumberStringWithComma(lValue))
        .append("</td>");
      }
      long lTotal = mtgData.sumByYear(arryUWCalcType[nIndex], false);
//#if 1不具合修正（売上済が加算されていない）
      if (false != isOrderLine) {
        long lTotal_2 = mtgData.sumByYear(UWCalcType.SALES_ONLY, false);
        try {
          lTotal = MathHelper.safeAdd(lTotal, lTotal_2);
        } catch (ArithmeticException err) {
          lTotal = Long.MAX_VALUE;
        } catch (Exception err) {
          throw err;
        }
      }
//#endif
      try {
        //lTotal += lBacklogValue;
        lTotal = MathHelper.safeAdd(lTotal, lBacklogValue);
      } catch (ArithmeticException err) {
        lTotal = Long.MAX_VALUE;
      } catch (Exception err) {
        throw err;
      }
      trSentenceBuilder.append("<td rowspan='2'>")
      .append(StringHelper.toNumberStringWithComma(lTotal))
      .append("</td>");
    }
    trSentenceBuilder.append("</tr>");
    nIndex++;
  }
  String strTRSentence = trSentenceBuilder.toString();

  return strTRSentence;
}
%>

</head>
<body>
<%
try {
  Error  error = null;

  //コントローラからの各種情報の取得
  error = (Error)request.getAttribute(ScopeNameConstants.SCOPE_ERROR_CLASS);
  if (null == error) {
    errorMessageList.add("error==null");
  }
  meetingDataTarget = (MeetingDataTarget)request.getAttribute(MeetingDataConstants.SCOPE_MEETING_DATA_TARGET);//"meetingDataTarget"
//  meetingDataTarget = (MeetingDataTarget)session.getAttribute(MeetingDataConstants.SCOPE_MEETING_DATA_TARGET);//"meetingDataTarget"
  if (null == meetingDataTarget) {
    errorMessageList.add("meetingDataTarget==null");
  }
  meetingData = (MeetingData)request.getAttribute(MeetingDataConstants.SCOPE_MEETING_DATA);//"meetingData"
  if (null == meetingData) {
    errorMessageList.add("meetingData==null");
  }
} catch (Exception err) {
  try {
    errorMessageList.add("例外発生（データ取得部）（" + err.getMessage() + "）");
  } catch (Exception err_2) {}
}
%>
  <br>
  <h3 class="page_title">管理職会議用
    <%--JSTL使用するように変更 --%>
    <c:if test="${!empty meetingData}">
      ―<fmt:formatDate value="${meetingData.dateToday}" pattern="yyyy年MM月dd日"/>
    </c:if>
  </h3>

  <%--エラー表示を行う箇所 --%>
  <c:choose>
    <c:when test="${error.isError}"><p class="error_message noprint">${error.errorInfo}</p></c:when>
    <c:otherwise></c:otherwise>
  </c:choose>

  <form id="Mainform" name="Mainform" action="./MeetingDataController" method="POST">
    <table class="all">
      <tr>
        <td>
          <table>
            <tr>
              <td>
                <button type="submit" name="action" value="meeting_data_goal" class="noprint">目標値設定</button>
              </td>
              <td>
                <button type="button" onClick="print()" class="noprint">印刷</button>
              </td>
            </tr>
          </table>
        </td>
      </tr>

      <tr>
        <td>　</td>
      </tr>

      <tr>
        <td class="table_title">本年度売上目標への進捗</td>
      </tr>

      <tr>
        <td>
          <table class="meeting_data_sales_table">
<%
try {
  out.println(createTRSentenceForFirstAndSecondLine(meetingDataTarget, false));
  out.println(createTRSentenceForThirdLine(nMonthArray, false));
  if (null != meetingData) {
    out.println(createTRSentenceForSalesTarget(nMonthArray, meetingDataTarget.getTargetSales(), meetingData));
  }
} catch (Exception err) {
  try {
    errorMessageList.add("例外発生（表生成部（１） ）（" + err.getMessage() + "）");
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
        <td class="table_title">本年度受注目標への進捗</td>
      </tr>
      
      <tr>
        <td>
          <table class="meeting_data_order_table">
<%
try {
  out.println(createTRSentenceForFirstAndSecondLine(meetingDataTarget, true));
  out.println(createTRSentenceForThirdLine(nMonthArray, true));
  if (null != meetingData) {
    out.println(createTRSentenceForOrderTarget(nMonthArray, meetingDataTarget.getTargetOrder(), meetingData));
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
    </table>
  </form>
  <br>
  <%
  //共通モジュールに渡すエラーリストをリクエストスコープにセット
  request.setAttribute("errorMessageList", errorMessageList);
  %>
  <jsp:include page="include_error_message.jsp" flush="true"/>
</body>
</html>
