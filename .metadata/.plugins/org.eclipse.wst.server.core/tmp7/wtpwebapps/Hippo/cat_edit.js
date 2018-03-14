/**
 * @fileOverview 分類追加・編集に使用する関数を記述するファイルです。
 * @author maezawa
 * @version 1.0
 */

var INPUT_TEXT_CONTENT = {
  // 'CAT_EDIT_FORM_ID': 'cat_edit_form_id',// Added by dai
  // 分類名を入力するテキストボックスのname値
  'CAT_EDIT_BUNRUI_NAME': 'bunrui_name',
  // 目標値を入力するテキストボックスのname値
  'CAT_EDIT_BUNRUI_GOAL': 'bunrui_goal'
}

/**
 * 新規追加時に実行される関数（入力チェックを行う関数を呼び出す）
 * 
 * @return {Boolean} 分類名の入力チェックと目標値の入力チェックのどちらもtrueの場合にtrueを返す
 *         どちらかがfalseの場合はfalseを返す
 */
function Bunrui_Add() {
  try {
    var nameChecked = bunrui_name_check(
            INPUT_TEXT_CONTENT.CAT_EDIT_BUNRUI_NAME, INPUT_PATTERN.SPACE_ONLY);
    var goalChecked = bunrui_goal_check(
            INPUT_TEXT_CONTENT.CAT_EDIT_BUNRUI_GOAL,
            AMOUNT_AND_TARGET_LIMIT.MAX_LIMIT_VAL,
            AMOUNT_AND_TARGET_LIMIT.MIN_LIMIT_VAL, INPUT_PATTERN.NUMBER_ONLY);
    if (nameChecked == false || goalChecked == false) { return false; }
  } catch (e) {
    alert("例外発生:" + e);
    return false;
  }
  return true;
}

/**
 * 編集時に実行される関数（入力チェックを行う関数を呼び出す）
 * 
 * @return {Boolean} 目標値の入力チェックがtrueの場合にtrueを返す falseの場合はfalseを返す
 */
function Bunrui_Edit() {
  try {
    var goalChecked = bunrui_goal_check(
            INPUT_TEXT_CONTENT.CAT_EDIT_BUNRUI_GOAL,
            AMOUNT_AND_TARGET_LIMIT.MAX_LIMIT_VAL,
            AMOUNT_AND_TARGET_LIMIT.MIN_LIMIT_VAL, INPUT_PATTERN.NUMBER_ONLY);
    if (goalChecked == false) { return false; }
  } catch (e) {
    alert("例外発生:" + e);
    return false;
  }
  return true;
}

/**
 * 分類名の入力内容を確認する関数
 * 
 * @param bunruiName_partName
 *          分類名を入力するテキストボックスのname値
 * @param pattern
 *          入力制限に使用するパターン
 * @return {Boolean} 分類名の入力確認を行いいずれの条件にも当てはまらない場合にtrue、当てはまる場合にfalseを返す
 */
function bunrui_name_check(bunruiName_partName, pattern) {
  try {
    // 値が渡されているかの確認
    var ObjUtilobj = new ObjUtil();
    if (ObjUtilobj.valueNullUndefinedCheck(bunruiName_partName) == false
            || bunruiName_partName == "") { throw new Error(
            "内容:bunruiName_partNameの値が無い"); }
    if (ObjUtilobj.valueNullUndefinedCheck(pattern) == false || pattern == "") { throw new Error(
            "内容:patternの値が無い"); }
    var checkInputTextobj = new Checkinputtext();
    var bunruiName = document.getElementsByName(bunruiName_partName);
    var bunruiNameValue = bunruiName[0].value;
    if (checkInputTextobj.isEmpty(bunruiNameValue) == true) {
      alert("分類名が未入力です");
      return false;
    } else if (checkInputTextobj.isPatternMatch(bunruiNameValue, pattern) == true) {
      alert("分類名にスペースが入っています。");
      return false;
    }
  } catch (e) {
    alert("例外発生 発生個所：bunrui_name_check" + e);
    return false;
  }
  return true;
}

/**
 * 目標値の入力内容を確認する関数
 * 
 * @param bunruiGoal_partName
 *          目標値を入力するテキストボックスのname値
 * @param maxval
 *          上限値
 * @param minval
 *          下限値
 * @param pattern
 *          入力制限に使用するパターン
 * @return {Boolean} 目標値の入力確認を行いいずれの条件にも当てはまらない場合にtrue、当てはまる場合にfalseを返す
 */
function bunrui_goal_check(bunruiGoal_partName, maxval, minval, pattern) {
  try {
    // 値が渡されているかの確認
    var ObjUtilobj = new ObjUtil();
    if (ObjUtilobj.valueNullUndefinedCheck(bunruiGoal_partName) == false
            || bunruiGoal_partName == "") { throw new Error(
            "内容:bunruiGoal_partNameの値が無い"); }
    if (ObjUtilobj.valueNullUndefinedCheck(maxval) == false || maxval == "") { throw new Error(
            "内容:maxvalの値が無い"); }
    if (ObjUtilobj.valueNullUndefinedCheck(minval) == false || minval == "") { throw new Error(
            "内容:minvalの値が無い"); }
    if (ObjUtilobj.valueNullUndefinedCheck(pattern) == false || pattern == "") { throw new Error(
            "内容:patternの値が無い"); }
    var checkInputTextobj = new Checkinputtext();
    var bunruiGoal = document.getElementsByName(bunruiGoal_partName);
    var bunruiGoalValue = bunruiGoal[0].value;

    // 入力必須のため
    if (checkInputTextobj.isEmpty(bunruiGoalValue) == true) {
      alert("目標値が未入力です");
      return false;
    } else if (checkInputTextobj.isPatternMatch(bunruiGoalValue, pattern) == true) {

      // 空でなかった場合にパターンチェックを行う 入力必須のためコメントアウト
      alert("目標値に半角数字以外の文字が入っています。");
      return false;
    }
    if (checkInputTextobj.valueLimitCheck(bunruiGoalValue, maxval, minval) == false) {
      window.alert("目標値に入力された値が有効ではありません。\n " + minval + "～" + maxval
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
    // attachOnKeyPressToText(INPUT_TEXT_CONTENT.CAT_EDIT_FORM_ID);// Added by
    // dai
  } catch (e) {
    alert("例外発生" + e);
  }
}, false);