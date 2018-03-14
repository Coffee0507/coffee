/**
 * @fileOverview チェックボックス関連の関数を記述するファイルです。
 * @author maezawa
 * @version 1.0
 */

/*
 * var LIST_CONTENT = { //inputタグ 'OTHER_CHECKBOX_ID' : 'content', };
 */

/**
 * チェックボックスの全選択、全解除を行う関数
 */
function checkbox_ctrlAllcheckbox() {
  try {
    if (document.getElementById(CHECKBOX_CONTENT.CHECK_BOX_ID) != null) {
      var checkboxUtilobj = new CheckboxUtil();
      // allチェックボックスの状態取得
      var isAllChecked = checkboxUtilobj
              .getTopCheckboxStatus(CHECKBOX_CONTENT.CHECK_BOX_ALL);
      // 取得したallチェックボックスの値確認
      checkboxUtilobj.putAllcheck(CHECKBOX_CONTENT.INPUT_TAG,
              CHECKBOX_CONTENT.CHECK_BOX_NAME, isAllChecked);
    } else {

      var allCheckbox_status = document
              .getElementById(CHECKBOX_CONTENT.CHECK_BOX_ALL).checked;
      if (allCheckbox_status == true) {
        // alert("チェック済みにする対象がありません");//modified by dai メッセージ出力不要
        return false;
      } else {
        // alert("チェックを外す対象がありません");//modified by dai メッセージ出力不要
        return false;
      }

    }
  } catch (e) {
    alert("例外発生 発生個所：checkbox_ctrlAllcheckbox" + e);
  }
}

/**
 * allチェックボックスの操作を行う関数
 */
function checkbox_ctrlTopcheckbox() {
  try {
    var checkboxUtilobj = new CheckboxUtil();
    var isChecked = false;
    // allチェックボックスを除く全チェックボックス数を取得
    var checkboxcount = checkboxUtilobj.getCheckBoxCount(
            CHECKBOX_CONTENT.CHECK_BOX_FORM, CHECKBOX_CONTENT.CHECK_BOX_NAME);
    // allチェックボックスを除くチェック済みのチェックボックス数を取得
    var checkedcount = checkboxUtilobj.getCheckedCount(
            CHECKBOX_CONTENT.CHECK_BOX_FORM, CHECKBOX_CONTENT.CHECK_BOX_NAME);
    // allチェックボックスを除いたチェックボックスの数とチェック済のチェックボックスの数が同じとき
    if (checkboxcount == checkedcount) {
      isChecked = true;
      // allチェックボックスを除いたチェックボックスの数よりチェック済のチェックボックスの数が少ないとき
    } else if (checkboxcount > checkedcount) {
      isChecked = false;
    } else {
      throw new Error("内容：チェック数がチェックボックスの数より多いです");
    }
    checkboxUtilobj.setAllCheckBox(CHECKBOX_CONTENT.CHECK_BOX_ALL, isChecked);
  } catch (e) {
    alert("例外発生：checkbox_ctrlTopcheckbox" + e);
  }
}

/**
 * 削除ボタンを押した際にチェックが1つ以上入っているか確認する関数
 * 
 * @return {boolean} チェックが1つ以上入っている場合に、ture、1つも入っていない場合に、falseを返す
 */
function checkbox_delcheck() {
  try {
    // リスト横のチェックボックスが存在しているかどうかの判定
    if (document.getElementById(CHECKBOX_CONTENT.CHECK_BOX_ID)) {
      var checkboxUtilobj = new CheckboxUtil();
      // allチェックボックスを除くチェック済みのチェックボックス数を取得
      var checkedcount = checkboxUtilobj.getCheckedCount(
              CHECKBOX_CONTENT.CHECK_BOX_FORM, CHECKBOX_CONTENT.CHECK_BOX_NAME);
      // チェックが0以下の時
      if (checkedcount <= 0) {
        alert("チェックを入れてください。");
        return false;
      }
      // 件数を確認文言と合わせて表示させ確認を行う 確認結果をresに入れる
      var res = confirm(checkedcount + '件選択されています。削除してよろしいですか？');
      if (res == false) { return false; }
    } else {
      alert("データがありません");
      return false;
    }
  } catch (e) {
    alert("例外発生： 発生個所：checkbox_delcheck" + e);
    return false;
  }
  return true;
}

/**
 * 変更ボタンを押した際にチェックが1つだけ入っているか確認する関数
 * 
 * @return {boolean} チェックが1つだけ入っている場合に、true、1つも入っていない場合と2つ以上入っている場合に、falseを返す
 */
function checkbox_changecheck() {
  try {
    // リスト横のチェックボックスが存在しているかどうかの判定
    if (document.getElementById(CHECKBOX_CONTENT.CHECK_BOX_ID)) {
      var checkboxUtilobj = new CheckboxUtil();
      // allチェックボックスを除くチェック済みのチェックボックス数を取得
      var checkedcount = checkboxUtilobj.getCheckedCount(
              CHECKBOX_CONTENT.CHECK_BOX_FORM, CHECKBOX_CONTENT.CHECK_BOX_NAME);
      // チェック済のチェックボックスがが以下の場合
      if (checkedcount <= 0) {
        alert("チェックを入れてください。");
        return false;
        // チェック済のチェックボックスが1より大きい場合
      } else if (checkedcount > 1) {
        alert("複数チェックが入っています。");
        return false;
      }
    } else {
      alert("データがありません");
      return false;
    }
  } catch (e) {
    alert("例外発生 発生個所：checkbox_changecheck" + e);
  }
  return true;
}