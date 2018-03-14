/**
 * 
 */
var INPUT_TEXT_CONTENT = {
  //現在のパスワードを入力するテキストボックスのname値
    'PASS_NOW_NAME':'pass_now',
  //新しいパスワードを入力するテキストボックスのname値
    'PASS_NEW_NAME':'pass_new',
  //新しいパスワード（確認用）を入力するテキストボックスのname値
    'PASS_NEW_CON_NAME':'pass_new_con'
}


function pass_change() {
  try {
    var newPassChecked = pass_new_check(INPUT_TEXT_CONTENT.PASS_NEW_NAME, INPUT_PATTERN.PASS_TYPE);
    var newconPassChecked = pass_new_con_check(INPUT_TEXT_CONTENT.PASS_NEW_CON_NAME, INPUT_PATTERN.PASS_TYPE);
    var newAndconPassEqualchecked = pass_equal_check(INPUT_TEXT_CONTENT.PASS_NEW_NAME, INPUT_TEXT_CONTENT.PASS_NEW_CON_NAME);
    if (newPassChecked == false || newconPassChecked == false || newAndconPassEqualchecked == false ) {
      return false;
    }
  } catch(e) {
    alert("例外発生" + e);
    return false;
  }
  return true;
}

function pass_equal_check(passNew_partName, passNewCon_partName) {
  try {
    var ObjUtilobj = new ObjUtil();
    if (ObjUtilobj.valueNullUndefinedCheck(passNew_partName) == false || passNew_partName == "") {
      throw new Error("内容:passNew_partNameの値が無い");
    }
    if (ObjUtilobj.valueNullUndefinedCheck(passNewCon_partName) == false || passNewCon_partName == "") {
      throw new Error("内容:passNewCon_partNameの値が無い");
    }
    
    //新しいパスワード欄と確認用パスワード欄とで入力された値を比較
    var passNew = document.getElementsByName(passNew_partName);
    var passNewValue = passNew[0].value;
    var passNewCon = document.getElementsByName(passNewCon_partName);
    var passNewConValue = passNewCon[0].value;
    
    if (passNewValue != passNewConValue) {
      alert("新しいパスワード欄の入力内容が確認用パスワード欄の入力内容と合致しません。");
      return false;
    }
  } catch(e) {
	alert("例外発生" + e);
    return false;
  }
  return true;
}

function pass_new_check(passNew_partName, pattern) {
  try {
    var ObjUtilobj = new ObjUtil();
    if (ObjUtilobj.valueNullUndefinedCheck(passNew_partName) == false || passNew_partName == "") {
      throw new Error("内容:passNew_partNameの値が無い");
    }
    if (ObjUtilobj.valueNullUndefinedCheck(pattern) == false || pattern == "") {
      throw new Error("内容:patternの値が無い");
    }
    var checkInputTextobj = new Checkinputtext();
    var passNew = document.getElementsByName(passNew_partName);
    var passNewValue = passNew[0].value;
    //空でなかった場合にパターンチェック
    if (checkInputTextobj.isEmpty(passNewValue) == false) {
      if (checkInputTextobj.isPatternMatch(passNewValue, pattern) == false) {
        alert("新しいのパスワード欄に使用できない文字が入力されています。\nスペース \\ ( ) ~ は使用できません。");
        return false;
      }
    }
  } catch(e) {
    alert("例外発生" + e);
    return false;
  }
  return true;
}

function pass_new_con_check(passNewCon_partName, pattern) {
  try {
    var ObjUtilobj = new ObjUtil();
    if (ObjUtilobj.valueNullUndefinedCheck(passNewCon_partName) == false || passNewCon_partName == "") {
      throw new Error("内容:passNewCon_partNameの値が無い");
    }
    if (ObjUtilobj.valueNullUndefinedCheck(pattern) == false || pattern == "") {
      throw new Error("内容:patternの値が無い");
    }
    var checkInputTextobj = new Checkinputtext();
    var passNewCon = document.getElementsByName(passNewCon_partName);
    var passNewConValue = passNewCon[0].value;
    //空でなかった場合にパターンチェック
    if (checkInputTextobj.isEmpty(passNewConValue) == false) {
      if (checkInputTextobj.isPatternMatch(passNewConValue, pattern) == false) {
        alert("新しいパスワード（確認用）欄に使用できない文字が入力されています。\nスペース \\ ( ) ~ は使用できません。");
        return false;
      }
    }
    
  } catch(e) {
    alert("例外発生" + e);
    return false;
  }
  return true;
}

window.addEventListener("load",function(){
  try {
    display_title_set();
  } catch (e) {
    alert("例外発生"+ e);
  }
},false);