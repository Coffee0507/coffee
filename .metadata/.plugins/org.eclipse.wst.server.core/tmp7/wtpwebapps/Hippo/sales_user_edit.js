/**
 * @fileOverview 営業担当追加・編集に使用する関数を記述するファイルです。
 * @author maezawa
 * @version 1.0
 */

var INPUT_TEXT_CONTENT = {
  // 氏名を入力するテキストボックスのname値
  'SALES_EDIT_USER_NAME': 'sales_user_name',
  // 売上目標値を入力するテキストボックスのname値
  'SALES_EDIT_GOAL_NAME': 'sales_user_goal',
  // 売上目標値を入力するテキストボックスのid値
  'SALES_EDIT_GOAL_ID': 'sales_user_goal',
  // 注残目標値を入力するテキストボックスのname値
  'SALES_EDIT_REMARK_NAME': 'sales_user_remark',
  // 注残目標値を入力するテキストボックスのid値
  'SALES_EDIT_REMARK_ID': 'sales_user_remark'
}

/**
 * @returns
 */
function Sales_User_Add() {
  try {
    var nameChecked = sales_user_name_check(
            INPUT_TEXT_CONTENT.SALES_EDIT_USER_NAME, INPUT_PATTERN.SPACE_ONLY);
    var goalChecked = sales_user_goal_check(
            INPUT_TEXT_CONTENT.SALES_EDIT_GOAL_NAME,
            AMOUNT_AND_TARGET_LIMIT.MAX_LIMIT_VAL,
            AMOUNT_AND_TARGET_LIMIT.MIN_LIMIT_VAL, INPUT_PATTERN.NUMBER_ONLY);
    var remarkChecked = sales_user_remark_check(
            INPUT_TEXT_CONTENT.SALES_EDIT_REMARK_NAME,
            AMOUNT_AND_TARGET_LIMIT.MAX_LIMIT_VAL,
            AMOUNT_AND_TARGET_LIMIT.MIN_LIMIT_VAL, INPUT_PATTERN.NUMBER_ONLY);

    if (nameChecked == false || goalChecked == false || remarkChecked == false) { return false; }
  } catch (e) {
    alert("例外発生:" + e);
    return false;
  }
  return true;
}

/**
 * @returns
 */
function Sales_User_Edit() {
  try {
    var goalChecked = sales_user_goal_check(
            INPUT_TEXT_CONTENT.SALES_EDIT_GOAL_NAME,
            AMOUNT_AND_TARGET_LIMIT.MAX_LIMIT_VAL,
            AMOUNT_AND_TARGET_LIMIT.MIN_LIMIT_VAL, INPUT_PATTERN.NUMBER_ONLY);
    var remarkChecked = sales_user_remark_check(
            INPUT_TEXT_CONTENT.SALES_EDIT_REMARK_NAME,
            AMOUNT_AND_TARGET_LIMIT.MAX_LIMIT_VAL,
            AMOUNT_AND_TARGET_LIMIT.MIN_LIMIT_VAL, INPUT_PATTERN.NUMBER_ONLY);
    if (goalChecked == false || remarkChecked == false) { return false; }
  } catch (e) {
    alert("例外発生:" + e);
    return false;
  }
  return true;
}

/**
 * @returns
 */
function sales_user_name_check(salesusername_partName, pattern) {
  try {
    var ObjUtilobj = new ObjUtil();
    if (ObjUtilobj.valueNullUndefinedCheck(salesusername_partName) == false
            || salesusername_partName == "") { throw new Error(
            "内容:bunruiName_partNameの値が無い"); }
    if (ObjUtilobj.valueNullUndefinedCheck(pattern) == false || pattern == "") { throw new Error(
            "内容:patternの値が無い"); }
    var checkInputTextobj = new Checkinputtext();
    var salesuserName = document.getElementsByName(salesusername_partName);
    var salesuserNameValue = salesuserName[0].value;
    if (checkInputTextobj.isEmpty(salesuserNameValue) == true) {
      alert("氏名が未入力です");
      return false;
    } else if (checkInputTextobj.isPatternMatch(salesuserNameValue, pattern) == true) {
      alert("氏名にスペースが入っています。");
      return false;
    }
  } catch (e) {
    alert("例外発生 発生個所：sales_user_name_check" + e);
    return false;
  }
  return true;
}

/**
 * @returns
 */
function sales_user_goal_check(salesusergoal_partName, maxval, minval, pattern) {
  try {
    // 値が渡されているかの確認
    var ObjUtilobj = new ObjUtil();
    if (ObjUtilobj.valueNullUndefinedCheck(salesusergoal_partName) == false
            || salesusergoal_partName == "") { throw new Error(
            "内容:bunruiName_partNameの値が無い"); }
    if (ObjUtilobj.valueNullUndefinedCheck(pattern) == false || pattern == "") { throw new Error(
            "内容:patternの値が無い"); }
    var checkInputTextobj = new Checkinputtext();
    var salesusergoal = document.getElementsByName(salesusergoal_partName);
    var salesusergoalValue = salesusergoal[0].value;
    if (checkInputTextobj.isEmpty(salesusergoalValue) == true) {
      alert("売上目標値が未入力です");
      return false;
    } else if (checkInputTextobj.isPatternMatch(salesusergoalValue, pattern) == true) {
      alert("売上目標値に半角数字以外の文字が入っています。");
      return false;
    }
    if (checkInputTextobj.valueLimitCheck(salesusergoalValue, maxval, minval) == false) {
      window.alert("売上目標値に入力された値が有効ではありません。\n " + minval + "～" + maxval
              + "までの値を入力してください。");
      return false;
    }
  } catch (e) {
    alert("例外発生 発生個所：bunrui_name_check" + e);
    return false;
  }
  return true;
}

/**
 * @returns
 */
function sales_user_remark_check(salesuserremark_partName, maxval, minval,
        pattern) {
  try {
    // 値が渡されているかの確認
    var ObjUtilobj = new ObjUtil();
    if (ObjUtilobj.valueNullUndefinedCheck(salesuserremark_partName) == false
            || salesuserremark_partName == "") { throw new Error(
            "内容:salesuserremark_partNameの値が無い"); }
    if (ObjUtilobj.valueNullUndefinedCheck(maxval) == false || maxval == "") { throw new Error(
            "内容:maxvalの値が無い"); }
    if (ObjUtilobj.valueNullUndefinedCheck(minval) == false || minval == "") { throw new Error(
            "内容:minvalの値が無い"); }
    if (ObjUtilobj.valueNullUndefinedCheck(pattern) == false || pattern == "") { throw new Error(
            "内容:patternの値が無い"); }

    var checkInputTextobj = new Checkinputtext();
    var salesuserremark = document.getElementsByName(salesuserremark_partName);
    var salesuserremarkValue = salesuserremark[0].value;
    if (checkInputTextobj.isEmpty(salesuserremarkValue) == true) {
      alert("注残目標値が未入力です");
      return false;
    } else if (checkInputTextobj.isPatternMatch(salesuserremarkValue, pattern) == true) {
      alert("注残目標値に半角数字以外の文字が入っています。");
      return false;
    }
    if (checkInputTextobj.valueLimitCheck(salesuserremarkValue, maxval, minval) == false) {
      window.alert("注残目標値に入力された値が有効ではありません。\n " + minval + "～" + maxval
              + "までの値を入力してください。");
      return false;
    }
  } catch (e) {
    alert("例外発生 発生個所：bunrui_goal_check" + e);
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
