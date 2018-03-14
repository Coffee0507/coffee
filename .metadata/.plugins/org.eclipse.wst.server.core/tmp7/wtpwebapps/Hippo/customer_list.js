/**
 * @fileOverview 顧客リストに使用する関数を記述するファイルです。
 * @author maezawa
 * @version 1.0
 */

var INPUT_CUSTOMER_TEXT_CONTENT = {
  'CUSTOMER_LIST_FORM_ID': 'Mainform',// Added by dai
  // 顧客名を入力するテキストボックスのname値
  'CUSTOMER_NAME': 'cus_name'
}

/**
 * 顧客追加時に実行されるもの
 * 
 * @returns
 */
function customer_Add() {
  try {
    var inputChecked = customer_name_check(INPUT_CUSTOMER_TEXT_CONTENT.CUSTOMER_NAME);
    if (inputChecked == false) { return false; }
  } catch (e) {
    alert("例外発生" + e);
    return false;
  }
  return true;
}

/**
 * @param customer_partname
 * @returns
 */
function customer_name_check(customer_partname) {
  try {
    var ObjUtilobj = new ObjUtil();
    if (ObjUtilobj.valueNullUndefinedCheck(customer_partname) == false
            || customer_partname == "") { throw new Error(
            "内容:customer_name_checkの値が無い"); }
    var checkInputTextobj = new Checkinputtext();
    var customerName = document.getElementsByName(customer_partname);
    var customerNameValue = customerName[0].value;
    if (checkInputTextobj.isEmpty(customerNameValue) == true) {
      alert("顧客名が未入力です");
      return false;
    }
  } catch (e) {
    alert("例外発生 発生個所：customer_name_check" + e);
    return false;
  }
  return true;
}

window.addEventListener("load", function() {
  try {
    display_title_set();
    attachOnKeyPressToText(INPUT_CUSTOMER_TEXT_CONTENT.CUSTOMER_LIST_FORM_ID);
    // Added by dai
  } catch (e) {
    alert("例外発生" + e);
  }
}, false);
