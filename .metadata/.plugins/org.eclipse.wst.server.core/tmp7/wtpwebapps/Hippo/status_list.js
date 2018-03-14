/**
 * @fileOverview ステータスリストに使用する関数を記述するファイルです。
 * @author maezawa
 * @version 1.0
 */

var INPUT_STATUS_TEXT_CONTENT = {
  // ステータス名を入力するテキストボックスのid値
  'STATUS_NAME': 'status_name'
}

function status_Add() {
  try {
    var inputChecked = status_name_check(INPUT_STATUS_TEXT_CONTENT.STATUS_NAME);
    if (inputChecked == false) { return false; }
  } catch (e) {
    alert("例外発生" + e);
    return false;
  }
  return true;
}

function status_name_check(status_partName) {
  try {
    var ObjUtilobj = new ObjUtil();
    if (ObjUtilobj.valueNullUndefinedCheck(status_partName) == false
            || status_partName == "") { throw new Error(
            "内容:bunruiName_partNameの値が無い"); }
    var checkInputTextobj = new Checkinputtext();
    var statusName = document
            .getElementById(INPUT_STATUS_TEXT_CONTENT.STATUS_NAME);
    var statusNameValue = statusName.value;
    if (checkInputTextobj.isEmpty(statusNameValue) == true) {
      alert("ステータス名が未入力です");
      return false;
    }
  } catch (e) {
    alert("例外発生 発生個所：status_name_check" + e);
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
