/**
 * @fileOverview ユーザー追加・編集に使用する関数を記述するファイルです。
 * @author maezawa
 * @version 1.0
 */

var INPUT_TEXT_CONTENT = {
  // 社員番号を入力するテキストボックスのname値
  'USER_EDIT_NUMBER_NAME': 'user_number',
  // 氏名：性を入力するテキストボックスのname値
  'USER_EDIT_SEI_NAME': 'user_sei',
  // 氏名：名を入力するテキストボックスのname値
  'USER_EDIT_MEI_NAME': 'user_mei',
  // パスワードを入力するテキストボックスのname値
  'USER_EDIT_PASS_NAME': 'user_pass',
  // メールアドレスを入力するテキストボックスのname値
  'USER_EDIT_MAIL_NAME': 'user_mail'
}

/**
 * 追加時に実行される関数
 * 
 * @returns
 */
function user_add() {
  try {
    var empNumberChecked = emp_num_check(
            INPUT_TEXT_CONTENT.USER_EDIT_NUMBER_NAME,
            INPUT_PATTERN.NUMBER_ONLY, AMOUNT_AND_TARGET_LIMIT.MAX_EMP_NUM_VAL,
            AMOUNT_AND_TARGET_LIMIT.MIN_EMP_NUM_VAL);
    var seiNameChecked = sei_name_input_check(INPUT_TEXT_CONTENT.USER_EDIT_SEI_NAME);
    var meiNameChecked = mei_name_input_check(INPUT_TEXT_CONTENT.USER_EDIT_MEI_NAME);
    var passChecked = pass_input_check(INPUT_TEXT_CONTENT.USER_EDIT_PASS_NAME,
            INPUT_PATTERN.PASS_TYPE);
    var mailChecked = mail_input_check(INPUT_TEXT_CONTENT.USER_EDIT_MAIL_NAME,
            INPUT_PATTERN.MAIL_TYPE);
    if (empNumberChecked == false || seiNameChecked == false
            || meiNameChecked == false || passChecked == false
            || mailChecked == false) { return false; }
  } catch (e) {
    alert("例外発生" + e);
    return false;
  }
  return true;
}

/**
 * 編集時に実行される関数
 * 
 * @returns
 */
function user_edit() {
  try {
    var passChecked = pass_input_check(INPUT_TEXT_CONTENT.USER_EDIT_PASS_NAME,
            INPUT_PATTERN.PASS_TYPE);
    var mailChecked = mail_input_check(INPUT_TEXT_CONTENT.USER_EDIT_MAIL_NAME,
            INPUT_PATTERN.MAIL_TYPE);
    if (passChecked == false || mailChecked == false) { return false; }
  } catch (e) {
    alert("例外発生" + e);
    return false;
  }
  return true;
}

/**
 * 社員番号のチェックを行う関数
 * 
 * @param empNumber_partName
 * @param pattern
 * @returns
 */
function emp_num_check(empNumber_partName, pattern, maxval, minval) {
  try {
    // 値が渡されているかの確認
    var ObjUtilobj = new ObjUtil();
    if (ObjUtilobj.valueNullUndefinedCheck(empNumber_partName) == false
            || empNumber_partName == "") { throw new Error(
            "内容:empNumber_partNameの値が無い"); }
    if (ObjUtilobj.valueNullUndefinedCheck(pattern) == false || pattern == "") { throw new Error(
            "内容:patternの値が無い"); }
    if (ObjUtilobj.valueNullUndefinedCheck(maxval) == false || maxval == "") { throw new Error(
            "内容:patternの値が無い"); }
    if (ObjUtilobj.valueNullUndefinedCheck(minval) == false || minval == "") { throw new Error(
            "内容:patternの値が無い"); }
    // 入力チェック
    var checkInputTextobj = new Checkinputtext();
    var empNumber = document.getElementsByName(empNumber_partName);
    var empNumberValue = empNumber[0].value;

    if (checkInputTextobj.isEmpty(empNumberValue) == true) {
      alert("社員番号が未入力です");
      return false;
    } else if (checkInputTextobj.isPatternMatch(empNumberValue, pattern) == true) {
      alert("社員番号に半角数字以外の文字が入っています。");
      return false;
    }
    if (checkInputTextobj.valueLimitCheck(empNumberValue, maxval, minval) == false) {
      window.alert("社員番号に入力された値が有効ではありません。\n " + minval + "～" + maxval
              + "までの値を入力してください。");
      return false;
    }
    // パターン（半角数値チェック
  } catch (e) {
    alert("例外発生 発生個所:emp_num_check" + e);
    return false;
  }
  return true;
}

/**
 * 氏名(性)のチェックを行う関数
 * 
 * @param seiName_partName
 * @returns
 */
function sei_name_input_check(seiName_partName) {
  try {
    // 値が渡されているかの確認
    var ObjUtilobj = new ObjUtil();
    if (ObjUtilobj.valueNullUndefinedCheck(seiName_partName) == false
            || seiName_partName == "") { throw new Error(
            "内容:empNumber_partNameの値が無い"); }

    // 入力チェック
    var checkInputTextobj = new Checkinputtext();
    var seiName = document.getElementsByName(seiName_partName);
    var seiNameValue = seiName[0].value;

    if (checkInputTextobj.isEmpty(seiNameValue) == true) {
      alert("氏名：姓が未入力です");
      return false;
    }
  } catch (e) {
    alert("例外発生 発生個所:sei_name_input_check" + e);
    return false;
  }
  return true;
}

/**
 * 氏名(名)のチェックを行う関数
 * 
 * @param meiName_partName
 * @returns
 */
function mei_name_input_check(meiName_partName) {
  try {
    // 値が渡されているかの確認
    var ObjUtilobj = new ObjUtil();
    if (ObjUtilobj.valueNullUndefinedCheck(meiName_partName) == false
            || meiName_partName == "") { throw new Error(
            "内容:meiName_partNameの値が無い"); }

    // 入力チェック
    var checkInputTextobj = new Checkinputtext();
    var meiName = document.getElementsByName(meiName_partName);
    var meiNameValue = meiName[0].value;

    if (checkInputTextobj.isEmpty(meiNameValue) == true) {
      alert("氏名：名が未入力です");
      return false;
    }
  } catch (e) {
    alert("例外発生 発生個所:mei_name_input_check" + e);
    return false;
  }
  return true;
}

/**
 * パスワードのチェックを行う関数
 * 
 * @param pass_partName
 * @param pattern
 * @returns
 */
function pass_input_check(pass_partName, pattern) {
  try {
    var ObjUtilobj = new ObjUtil();
    if (ObjUtilobj.valueNullUndefinedCheck(pass_partName) == false
            || pass_partName == "") { throw new Error("内容:pass_partNameeの値が無い"); }
    if (ObjUtilobj.valueNullUndefinedCheck(pattern) == false || pattern == "") { throw new Error(
            "内容:patternの値が無い"); }

    // 入力チェック
    var checkInputTextobj = new Checkinputtext();
    var pass = document.getElementsByName(pass_partName);
    var passValue = pass[0].value;

    // 空でなかった場合にパターンチェック
    if (checkInputTextobj.isEmpty(passValue) == false) {
      if (checkInputTextobj.isPatternMatch(passValue, pattern) == false) {
        alert("パスワード欄に使用できない文字が入力されています。\nスペース \\ ( ) ~ は使用できません。");
        return false;
      }
    }

  } catch (e) {
    alert("例外発生 発生個所:pass_input_check" + e);
    return false;
  }
  return true;
}

/**
 * メールアドレスのチェックを行う関数
 * 
 * @param mail_partName
 * @param pattern
 * @returns
 */
function mail_input_check(mail_partName, pattern) {
  try {
    var ObjUtilobj = new ObjUtil();
    if (ObjUtilobj.valueNullUndefinedCheck(mail_partName) == false
            || mail_partName == "") { throw new Error("内容:mail_partNameの値が無い"); }

    if (ObjUtilobj.valueNullUndefinedCheck(pattern) == false || pattern == "") { throw new Error(
            "内容:patternの値が無い"); }

    // 入力チェック
    var checkInputTextobj = new Checkinputtext();
    var mail = document.getElementsByName(mail_partName);
    var mailValue = mail[0].value;

    // 空でなかった場合にパターンチェック
    if (checkInputTextobj.isEmpty(mailValue) == true) {
      alert("メールアドレスが未入力です。");
      return false;
    } else if (checkInputTextobj.isPatternMatch(mailValue, pattern) == false) {
      alert("メールアドレスが正しくありません。");
      return false;
    }
  } catch (e) {
    alert("例外発生 発生個所:mail_input_check" + e);
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
