/**
 * 
 */

var UW_SEARCH_CONTENT = {
  // 受注月の月部分のセレクトボックスのname値
  'ORDER_MONTH_NAME': 'uw_s_order_month',
  // 売上月の月部分のセレクトボックスのname値
  'SALES_MONTH_NAME': 'uw_s_sales_month',
  // 入金月の月部分のセレクトボックスのname値
  'PAY_MONTH_NAME': 'uw_s_pay_month',

  // 入金月の年部分のセレクトボックスのid値
  'ORDER_YEAR_ID': 'uw_s_order_year_id',
  // 売上月の年部分のセレクトボックスのid値
  'SALES_YEAR_ID': 'uw_s_sales_year_id',
  // 入金月の年部分のセレクトボックスのid値
  'PAY_YEAR_ID': 'uw_s_pay_year_id',

  // 入金月の年部分のセレクトボックスのid値
  'ORDER_MONTH_ID': 'uw_s_order_month_id',
  // 入金月の年部分のセレクトボックスのid値
  'SALES_MONTH_ID': 'uw_s_sales_month_id',
  // 入金月の年部分のセレクトボックスのid値
  'PAY_MONTH_ID': 'uw_s_pay_month_id',

  // 入金月の表示に使用する箇所
  'ORDER_MONTH': '受注月',
  // 入金月の年部分のセレクトボックスのid値
  'SALES_MONTH': '売上月',
  // 入金月の年部分のセレクトボックスのid値
  'PAY_MONTH': '入金月',
}

// 受注月の全選択する関数
function order_month_all_select() {
  try {
    var orderselected = selectAll(UW_SEARCH_CONTENT.ORDER_MONTH_NAME);
  } catch (e) {
    alert("例外発生" + e)
  }
}

// 売上月の全選択する関数
function sales_month_all_select() {
  try {
    var orderselected = selectAll(UW_SEARCH_CONTENT.SALES_MONTH_NAME);
  } catch (e) {
    alert("例外発生" + e)
  }
}

// 入金月の全選択する関数
function pay_month_all_select() {
  try {
    var orderselected = selectAll(UW_SEARCH_CONTENT.PAY_MONTH_NAME);
  } catch (e) {
    alert("例外発生" + e)
  }
}

// セレクトボックスの中身を全選択する関数
// p_editにある右側のセレクトボックスを全選択するものを真似る
function selectAll(targetmonth) {
  try {
    var ObjUtilobj = new ObjUtil();
    if (ObjUtilobj.valueNullUndefinedCheck(targetmonth) == false
            || targetmonth == "") { throw new Error("内容:targetmonthの値が無い"); }
    var obj = document.getElementsByName(targetmonth)[0];
    for (i = 0; i < obj.options.length; i++) {
      obj.options[i].selected = true;
    }
  } catch (e) {
    alert("例外発生" + e);
  }
}

// 検索が押された際に実行する関数
function pushSearchBubbon() {
  try {
    // 受注月
    orderMonthCheck = selectMonthCheck(UW_SEARCH_CONTENT.ORDER_YEAR_ID,
            UW_SEARCH_CONTENT.ORDER_MONTH_ID, UW_SEARCH_CONTENT.ORDER_MONTH);
    // 売上月
    salesMonthCheck = selectMonthCheck(UW_SEARCH_CONTENT.SALES_YEAR_ID,
            UW_SEARCH_CONTENT.SALES_MONTH_ID, UW_SEARCH_CONTENT.SALES_MONTH);
    // 入金月
    paymentMonthCheck = selectMonthCheck(UW_SEARCH_CONTENT.PAY_YEAR_ID,
            UW_SEARCH_CONTENT.PAY_MONTH_ID, UW_SEARCH_CONTENT.PAY_MONTH);

    // 全体の判定を入れる
    if (orderMonthCheck == false || salesMonthCheck == false
            || paymentMonthCheck == false) { return false; }
  } catch (e) {
    alert("例外発生");
    return false;
  }
  return true;
}

function selectMonthCheck(yearId, monthId, disName) {
  try {

    // 値が渡されているかの確認
    var ObjUtilobj = new ObjUtil();
    if (ObjUtilobj.valueNullUndefinedCheck(yearId) == false || yearId == "") { throw new Error(
            "内容:yearIdの値が無い"); }
    if (ObjUtilobj.valueNullUndefinedCheck(monthId) == false || monthId == "") { throw new Error(
            "内容:monthIdの値が無い"); }
    if (ObjUtilobj.valueNullUndefinedCheck(disName) == false || disName == "") { throw new Error(
            "内容:disNameの値が無い"); }

    var selectYear = document.getElementById(yearId).value;
    var selectMonth = document.getElementById(monthId).value;

    if (selectYear != "" || selectMonth != "") {

      if (selectYear == "") {
        alert(disName + "の年度の項目が未選択です。");
        return false;
      }
      if (selectMonth == "") {
        alert(disName + "の月の項目が未選択です。");
        return false;
      }
    }
  } catch (e) {
    alert("例外発生" + e);
    return false;
  }
  return true;
}

window.addEventListener("load", function() {
  try {
    display_title_set();
  } catch (e) {
    alert("例外発生" + e);
  }
}, false);