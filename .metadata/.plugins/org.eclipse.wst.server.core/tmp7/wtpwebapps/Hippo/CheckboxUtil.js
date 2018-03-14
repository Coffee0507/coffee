/**
 * @fileOverview チェックボックス関連の操作クラスを記述するファイルです。
 * @author maezawa
 * @version 1.0
 */

/**
 * @class CheckboxUtil
 * @constructor
 */
var CheckboxUtil = function() {
}

/**
 * allチェックボックスの状態を取得する関数
 * @param topCheckboxId allチェックボックスのid値
 * @method getAllStatus
 * @return {boolean} allチェックボックスの状態がonの場合、true、offの場合、false、を返す
 */
CheckboxUtil.prototype.getTopCheckboxStatus = function(topCheckboxId) {
  //値の確認
  var ObjUtilobj = new ObjUtil();
  if (ObjUtilobj.valueNullUndefinedCheck(topCheckboxId) == false　|| topCheckboxId == "") {
    throw new Error("内容:topCheckboxIdの値が無い");
  }
  var isChecked = document.getElementById(topCheckboxId).checked;
  return isChecked;
}

/**
 * チェックボックスの全選択・全解除の操作を行う関数
 * 
 * @method putAllcheck
 * @param {inputTagName}
 *        inputタグのname値
 * @param {checkBoxName}
 *        allチェックボックスを除いたチェックボックスのname値
 * @param {isAllChecked}
 *        allチェックボックスの状態を保持したもの
 */
CheckboxUtil.prototype.putAllcheck = function(inputTagName, checkBoxName, isAllChecked) {
  //値の確認
  var ObjUtilobj = new ObjUtil();
  if (ObjUtilobj.valueNullUndefinedCheck(inputTagName) == false || inputTagName == "") {
    throw new Error("内容:inputTagNameの値が無い");
  }
  if (ObjUtilobj.valueNullUndefinedCheck(checkBoxName) == false || checkBoxName == "") {
    throw new Error("内容:checkBoxNameの値が無い");
  }
  if (ObjUtilobj.valueNullUndefinedCheck(isAllChecked) == false) {
    throw new Error("内容:isAllCheckedの値が無い");
  }
  var checkbox = document.getElementsByTagName(inputTagName);
  var checkboxlength = checkbox.length;
  if (checkboxlength == undefined) {
    if (checkbox.name == checkBoxName) {
      checkbox.checked = isAllChecked;
    }
  } else {
    for (i = 0; i < checkboxlength; i++) {
      if (checkbox[i].name == checkBoxName) {
        checkbox[i].checked = isAllChecked;
      }
    }
  }
}

/**
 * 全体のチェックボックスの数を数える関数
 * 
 * @method getCheckBoxCount
 * @param {checkBoxFormID}
 *        数えたいチェックボックスを囲んでいるFormのid値
 * @param {checkBoxName}
 *        数えたいチェックボックスのname値
 * @return 数えたチェックボックスの数を返す
 */
CheckboxUtil.prototype.getCheckBoxCount = function(checkBoxFormID, checkBoxName) {
  //値の確認
  var ObjUtilobj = new ObjUtil();
  if (ObjUtilobj.valueNullUndefinedCheck(checkBoxFormID) == false || checkBoxFormID == "") {
    throw new Error("内容:checkBoxFormIDの値が無い");
  }
  if (ObjUtilobj.valueNullUndefinedCheck(checkBoxName) == false || checkBoxName == "") {
    throw new Error("内容:checkBoxNameの値が無い");
  }
  //Form要素を取得
  var checkBoxForm = document.getElementById(checkBoxFormID);
  var checkBoxCount = 0;
  //取得したForm要素からnameがcontentの要素の数を取得
  var checkBoxObjs = checkBoxForm.elements[checkBoxName];
  if (checkBoxObjs == null) {
    throw new Error("内容：checkBoxObjsがnull");
  } else {
    checkBoxCount = checkBoxObjs.length;
    //JavaScript上でのフォーム部品は、同名の要素が複数ある場合にのみ、配列として扱われるのだそう。
    //つまり、チェックボックスが1件の時は、document.hogeが配列として扱われない。
    //そのため、「配列」の長さを返すlengthプロパティが動作しないのだそうだ。
    if (checkBoxCount == undefined) {
      checkBoxCount = 1;
    }
  }
  //contentの要素の数を返す
  return checkBoxCount;
}

/**
 * チェックが入っているチェックボックスの数を数える関数
 * 
 * @method getCheckedCount
 * @param {checkBoxFormID}
 *        数えたいチェックボックスを囲んでいるFormのid値
 * @param {checkBoxName}
 *        数えたいチェックボックスのname値
 * @return 数えたチェックが入っているチェックボックスの数を返す
 */
CheckboxUtil.prototype.getCheckedCount = function(checkBoxFormID,checkBoxName) {
  //値の確認
  var ObjUtilobj = new ObjUtil();
  if (ObjUtilobj.valueNullUndefinedCheck(checkBoxFormID) == false || checkBoxFormID == "") {
    throw new Error("内容:checkBoxFormIDの値が無い");
  }
  if (ObjUtilobj.valueNullUndefinedCheck(checkBoxName) == false || checkBoxName == "") {
    throw new Error("内容:checkBoxNameの値が無い");
  }
  //Form要素を取得
  var checkBoxForm = document.getElementById(checkBoxFormID);
  //取得したForm要素から名前がcontentの要素を取得
  var checkBoxObjs = checkBoxForm.elements[checkBoxName];
  //チェック済みのカウントを行う変数の初期化
  var checkedTotal = 0;
  var checkBoxObjsLength = checkBoxObjs.length;
  if (checkBoxObjsLength == undefined) {
    if (checkBoxObjs.checked == true) {
      //カウントを1増やす
      checkedTotal += 1;
    }
  } else {
    //取得したcontentの要素の数より小さい間ループさせる
    for (var i=0; i < checkBoxObjsLength; i++) {
      //contentがチェック済みの場合
      if (checkBoxObjs[i].checked == true) {
        //カウントを1増やす
        checkedTotal += 1;
      }
    }
  }
  //チェック済みのチェックボックスの数を返す
  return checkedTotal;
}

/**
 * allチェックボックスのON,OFFを操作する関数
 * @method setAllCheckBox
 * @param {allCheckBoxID} allチェックボックスのid値
 * @param {isChecked} allチェックボックスを除いた全チェックボックスがチェック済みかどうか（チェック済みならtrue,そうでないならfalse）
 */
CheckboxUtil.prototype.setAllCheckBox = function(allCheckBoxID, isChecked) {
  //値の確認
  var ObjUtilobj = new ObjUtil();
  if (ObjUtilobj.valueNullUndefinedCheck(allCheckBoxID) == false || allCheckBoxID == "") {
    throw new Error("内容:allCheckBoxIDの値が無い");
  }
  if (ObjUtilobj.valueNullUndefinedCheck(isChecked) == false) {
    throw new Error("内容:isCheckedの値が無い");
  }
  //allの要素を取得
  var allCheckBoxObj = document.getElementById(allCheckBoxID);
  //allの状態を変更する
  allCheckBoxObj.checked = isChecked;
}
