/**
 * @fileOverview 販売（売りWin）追加・編集に使用する関数を記述するファイルです。
 * @author maezawa
 * @version 1.0
 */

var SALES_EDIT_CONTENT = {
  // P番を入力するテキストボックスのname値
  'PROJ_NUMBER_NAME': 'uw_p_number_first',
  // 分類を選択するセレクトボックスのid値
  'CAT_ID': 'uw_type_id',
  // 営業を選択するセレクトボックスのid値
  'SALES_ID': 'uw_sales_id',
  // ステータスを選択するセレクトボックスのid値
  'STATUS_ID': 'uw_status_id',
  // 売上先を入力するテキストボックスのname値
  'CUSTOMER_NAME': 'uw_cus',
  // 受注金額を入力するテキストボックスのname値
  'ORDER_MONEY': 'uw_order_money',
  // 受注月の値をもたせたhiddenのid値
  'ORDER_MONTH_ID': 'order',
  // 受注月の値をもたせたhiddenのid値
  'SALES_MONTH_ID': 'sales',
  // 受注月の値をもたせたhiddenのid値
  'PAY_MONTH_iD': 'pay',
  // P番反映のチェックボックスのid値
  'P_CHECKBOX_ID': 'uw_res_id',
  // P番の4桁目が3の場合の処理に使用（商品の時）
  'PRODUCT': '3',
  // 親P番を入力するテキストボックスのid値
  'FIRST_P_NUMBER_BOX_ID': 'uw_p_number_first_id',
  // 子P番入力の際に使用するプラスボタンのid値
  'P_ADD_BUTTON': 'plusButton',
  // 子P番を表示させるために入れてあるdivのid
  'P_ADD_AREA': 'here',

  // 子P番を入力するテキストボックスのidの一部
  'P_ADD_BOX_ID': 'textbox',
  // 子P番を表示させる際に使用するbrタグのidの一部
  'P_ADD_BR_ID': 'br',
  // 配列の数を数え保持するhiddenのid
  'HIDDEN_COUNT': 'listcounted',
  // 子P番の中身を保持するhiddenのid
  'HIDDEN_PNUM_COUNT': 'setval',
  // 子P番を入れるテキストボックスを作るための一部
  'P_ADD_PART_INPUT': 'input',
  // 子P番の上限数を見る個数（+ボタンを無効化するタイミングで使用）
  'P_ADD_BOX_MAX_LIMIT': '8',

  // エラー情報を保持しているhiddenのid値
  'ERROR_FLAG': 'errModeFlag',
  // エラー情報がtrueの場合の判定式に使用
  'ERROR_TRUE': 'true',
  // 新規追加、編集のモード情報を保持しているhiddenのid値
  'SELECT_FLAG': 'selectmode',
  // モード情報がeditの場合の判定式に使用
  'SELECT_EDIT': 'edit',
  // 削除ボタン文字
  // 'DEL_BUTTON_ICON':'Ｘ'
  'DEL_BUTTON_ICON': 'x'
}

/**
 * @returns
 */
function uw_add() {
  try {
    // P番の確認
    var projNumberChecked = proj_number_check(
            SALES_EDIT_CONTENT.PROJ_NUMBER_NAME,
            INPUT_PATTERN.NUMBER_HYPHEN_ONLY);
    // 分類の確認
    var projCatChecked = proj_cat_check(SALES_EDIT_CONTENT.CAT_ID);
    // 営業の確認
    var projSalesChecked = proj_sales_check(SALES_EDIT_CONTENT.SALES_ID);
    // ステータスの確認
    var projStatusChecked = proj_status_check(SALES_EDIT_CONTENT.STATUS_ID);
    // 売上先の確認
    var projClientChecked = proj_client_check(SALES_EDIT_CONTENT.CUSTOMER_NAME);
    // 受注金額の確認
    var projOrderMoneyChecked = proj_order_money_check(
            SALES_EDIT_CONTENT.ORDER_MONEY, INPUT_PATTERN.NUMBER_ONLY,
            AMOUNT_AND_TARGET_LIMIT.MAX_LIMIT_VAL,
            AMOUNT_AND_TARGET_LIMIT.MIN_LIMIT_VAL);

    // 確認内容にfalseがあった場合にfalseを返し進ませない
    if (projNumberChecked == false || projCatChecked == false
            || projSalesChecked == false || projStatusChecked == false
            || projClientChecked == false || projOrderMoneyChecked == false) {
      // if (projNumberChecked == false || projCatChecked == false ||
      // projSalesChecked == false ||
      // projStatusChecked == false || projClientChecked == false) {
      return false;
    }
  } catch (e) {
    alert("例外発生:" + e);
    return false;
  }
  return true;
}

/**
 * @returns
 */
function uw_edit() {
  try {
    // ■■■ チェック結果の判定がまだ入っていない falseを返すやつ ■■■
    // 分類の確認
    var projCatChecked = proj_cat_check(SALES_EDIT_CONTENT.CAT_ID);
    // 営業の確認
    var projSalesChecked = proj_sales_check(SALES_EDIT_CONTENT.SALES_ID);
    // ステータスの確認
    var projStatusChecked = proj_status_check(SALES_EDIT_CONTENT.STATUS_ID);
    // 売上先の確認
    var projClientChecked = proj_client_check(SALES_EDIT_CONTENT.CUSTOMER_NAME);
    // 受注金額の確認
    var projOrderMoneyChecked = proj_order_money_check(
            SALES_EDIT_CONTENT.ORDER_MONEY, INPUT_PATTERN.NUMBER_ONLY,
            AMOUNT_AND_TARGET_LIMIT.MAX_LIMIT_VAL,
            AMOUNT_AND_TARGET_LIMIT.MIN_LIMIT_VAL);

    if (projCatChecked == false || projSalesChecked == false
            || projStatusChecked == false || projClientChecked == false
            || projOrderMoneyChecked == false) {
      // if (projCatChecked == false || projSalesChecked == false ||
      // projStatusChecked == false || projClientChecked == false ) {
      return false;
    }
  } catch (e) {
    alert("例外発生：" + e);
    return false;
  }
  return true;
}

/**
 * P番の入力内容を確認する関数
 * 
 * @param p_number_name
 * @param pattern
 * @returns
 */
function proj_number_check(p_number_name, pattern) {
  try {
    // 値が渡されているかの確認
    var ObjUtilobj = new ObjUtil();
    if (ObjUtilobj.valueNullUndefinedCheck(p_number_name) == false
            || p_number_name == "") { throw new Error("内容:p_number_nameの値が無い"); }
    if (ObjUtilobj.valueNullUndefinedCheck(pattern) == false || pattern == "") { throw new Error(
            "内容:patternの値が無い"); }
    // 入力文字確認の呼び出し
    var checkInputTextobj = new Checkinputtext();
    var projNunber = document.getElementsByName(p_number_name);
    var projNunberValue = projNunber[0].value;
    // 未入力チェック
    if (checkInputTextobj.isEmpty(projNunberValue) == true) {
      alert("P番が未入力です");
      return false;
      // パターンチェック
    } else if (checkInputTextobj.isPatternMatch(projNunberValue, pattern) == true) {
      alert("P番に半角数字とハイフン以外の文字が入っています");
      return false;
    }
  } catch (e) {
    alert("例外発生 発生個所：proj_number_check" + e);
    return false;
  }
  return true;
}

/**
 * 分類の選択内容を確認する関数
 * 
 * @param proj_cat_id
 * @returns
 */
function proj_cat_check(proj_cat_id) {
  try {
    // 値が渡されているかの確認
    var ObjUtilobj = new ObjUtil();
    if (ObjUtilobj.valueNullUndefinedCheck(proj_cat_id) == false
            || proj_cat_id == "") { throw new Error("内容:proj_cat_idの値が無い"); }
    var checkInputTextobj = new Checkinputtext();
    var projCat = document.getElementById(proj_cat_id);
    var projCatSelectedValue = projCat.value;
    if (checkInputTextobj.isEmpty(projCatSelectedValue) == true) {
      alert("分類が未選択です");
      return false;
    }
  } catch (e) {
    alert("例外発生 発生個所：proj_cat_check" + e);
    return false;
  }
  return true;
}

/**
 * 営業の選択内容を確認する関数
 * 
 * @param proj_sales_id
 * @returns
 */
function proj_sales_check(proj_sales_id) {
  try {
    // 値が渡されているかの確認
    var ObjUtilobj = new ObjUtil();
    if (ObjUtilobj.valueNullUndefinedCheck(proj_sales_id) == false
            || proj_sales_id == "") { throw new Error("内容:proj_sales_idの値が無い"); }
    var checkInputTextobj = new Checkinputtext();
    var projSales = document.getElementById(proj_sales_id);
    var projSalesSelectedValue = projSales.value;
    if (checkInputTextobj.isEmpty(projSalesSelectedValue) == true) {
      alert("営業が未選択です");
      return false;
    }
  } catch (e) {
    alert("例外発生 発生個所：proj_sales_check" + e);
    return false;
  }
  return true;
}

/**
 * ステータスの選択内容を確認する関数
 * 
 * @param proj_status_id
 * @returns
 */
function proj_status_check(proj_status_id) {
  try {
    // 値が渡されているかの確認
    var ObjUtilobj = new ObjUtil();
    if (ObjUtilobj.valueNullUndefinedCheck(proj_status_id) == false
            || proj_status_id == "") { throw new Error("内容:proj_status_idの値が無い"); }
    var checkInputTextobj = new Checkinputtext();
    var projStatus = document.getElementById(proj_status_id);
    var projStatusSelectedValue = projStatus.value;
    if (checkInputTextobj.isEmpty(projStatusSelectedValue) == true) {
      alert("ステータスが未選択です");
      return false;
    }
  } catch (e) {
    alert("例外発生 発生個所：proj_status_check" + e);
    return false;
  }
  return true;
}

/**
 * 売上先の入力確認を行う関数
 * 
 * @param proj_client_name
 * @returns
 */
function proj_client_check(proj_client_name) {
  try {
    // 値が渡されているかの確認
    var ObjUtilobj = new ObjUtil();
    if (ObjUtilobj.valueNullUndefinedCheck(proj_client_name) == false
            || proj_client_name == "") { throw new Error(
            "内容:proj_client_nameの値が無い"); }
    // 入力文字確認の呼び出し
    var checkInputTextobj = new Checkinputtext();
    var projClient = document.getElementsByName(proj_client_name);
    var projClientValue = projClient[0].value;
    // 未入力チェック
    if (checkInputTextobj.isEmpty(projClientValue) == true) {
      alert("売上先が未入力です");
      return false;
    }
  } catch (e) {
    alert("例外発生 発生個所：proj_client_check" + e);
    return false;
  }
  return true;
}

/**
 * 受注金額の入力確認を行う関数
 * 
 * @param p_order_money
 * @param pattern
 * @returns
 */
function proj_order_money_check(p_order_money_name, pattern, maxval, minval) {
  try {
    // 値が渡されているかの確認
    var ObjUtilobj = new ObjUtil();
    if (ObjUtilobj.valueNullUndefinedCheck(p_order_money_name) == false
            || p_order_money_name == "") { throw new Error(
            "内容:p_order_moneyの値が無い"); }
    if (ObjUtilobj.valueNullUndefinedCheck(pattern) == false || pattern == "") { throw new Error(
            "内容:patternの値が無い"); }
    if (ObjUtilobj.valueNullUndefinedCheck(maxval) == false || maxval == "") { throw new Error(
            "内容:maxvalの値が無い"); }
    if (ObjUtilobj.valueNullUndefinedCheck(minval) == false || minval == "") { throw new Error(
            "内容:minvalの値が無い"); }

    // 入力文字確認の呼び出し
    var checkInputTextobj = new Checkinputtext();
    var projOrder = document.getElementsByName(p_order_money_name);
    var projOrderValue = projOrder[0].value;
    // 未入力チェック
    // もし値が空でない場合
    if (projOrderValue != "") {
      if (checkInputTextobj.isPatternMatch(projOrderValue, pattern) == true) {
        alert("受注金額に半角数字以外の文字が入っています");
        return false;
      }
      if (checkInputTextobj.valueLimitCheck(projOrderValue, maxval, minval) == false) {
        window.alert("受注金額に入力された値が有効ではありません。\n " + minval + "～" + maxval
                + "までの値を入力してください。");
        return false;
      }
    }
  } catch (e) {
    alert("例外発生 発生個所：proj_order_money_check" + e);
    return false;
  }
  return true;
}

// 新規のみ使用
var num = 0;
/**
 * 新規時に呼び出されるP番の入力箇所を増減を操作する関数
 * 
 * @returns
 */
function pushedPlusButton() {
  try {
    var patternChecked = null;
    // 親P番を入力するテキストボックス
    var projID1 = document
            .getElementById(SALES_EDIT_CONTENT.FIRST_P_NUMBER_BOX_ID);
    if (projID1.value == '') {
      // 親P番を入力するテキストボックスが未入力の時はアラート
      window.alert("未入力のテキストボックスがあります");
    } else {
      patternChecked = projID_check(projID1.value,
              INPUT_PATTERN.NUMBER_HYPHEN_ONLY);
      if (patternChecked == false) {
        return;
      } else {
        // P番入力ダイアログを表示
        projID = window.prompt("P番を入力してください", "");
        if (projID == '') {
          // 入力値が空文字の時
          // 再度ダイアログ表示
          pushedPlusButton();
        } else if (projID == null) {// キャンセルボタンが押された時
          // 何もしない
          return;
        } else {
          // 何かしら入力された時
          // 入力された文字が許可された値かどうかを判定
          patternChecked = projID_check(projID,
                  INPUT_PATTERN.NUMBER_HYPHEN_ONLY);
          if (patternChecked == false) {
            // 再度ダイアログ表示
            pushedPlusButton();
          } else {
            ctrlAddpNumTextBox(num, projID);
          }
        }
      }
    }
  } catch (e) {
    alert("例外発生 発生個所：pushedPlusButton" + e);
  }
  return;
}

function projID_check(projID, pattern) {
  try {
    // 値が渡されているかの確認
    var ObjUtilobj = new ObjUtil();
    if (ObjUtilobj.valueNullUndefinedCheck(projID) == false || projID == "") { throw new Error(
            "内容:projIDの値が無い"); }
    if (ObjUtilobj.valueNullUndefinedCheck(pattern) == false || pattern == "") { throw new Error(
            "内容:patternの値が無い"); }
    var checkInputTextobj = new Checkinputtext();
    if (checkInputTextobj.isPatternMatch(projID, pattern) == true) {
      alert("半角数値、半角ハイフン以外の文字が使用されています");
      return false;
    }

  } catch (e) {
    alert("例外発生 発生個所：projID_value_check" + e);
    return false;
  }
  return true;
}

function digit_check(proj_num_name, p_checkbox_id) {
  try {
    // 値が渡されているかの確認
    var ObjUtilobj = new ObjUtil();
    if (ObjUtilobj.valueNullUndefinedCheck(proj_num_name) == false
            || proj_num_name == "") { throw new Error("内容:proj_num_nameの値が無い"); }
    if (ObjUtilobj.valueNullUndefinedCheck(p_checkbox_id) == false
            || p_checkbox_id == "") { throw new Error("内容:p_checkbox_idの値が無い"); }
    // P番を取得
    var inputbox = document.getElementsByName(proj_num_name);
    var inputboxvalue = inputbox[0].value;
    // 4桁目を取得
    var getval = inputboxvalue.substr(3, 1);
    // P番の4桁目が3の場合に最下部のチェックを外す
    if (getval == SALES_EDIT_CONTENT.PRODUCT) {
      var p_checkbox = document.getElementById(p_checkbox_id);
      document.getElementById(p_checkbox_id).checked = false;
      document.getElementById(p_checkbox_id).disabled = true;
    }

  } catch (e) {
    alert("例外発生：発生個所:" + e);
    return false;
  }
  return true;
}

/**
 * 編集画面遷移時に読み込まれる予定の関数
 * 
 * @returns
 */
function uw_edit_pnum_box_ctrl() {
  try {
    // 子P番の要素があるかどうかの確認
    if (document.getElementById(SALES_EDIT_CONTENT.HIDDEN_COUNT) != null) {
      // hiddenに入っている配列の数を取得
      var countlength = document
              .getElementById(SALES_EDIT_CONTENT.HIDDEN_COUNT).value;
      // 子P番がある場合
      if (countlength != null) {
        // countに加える countは0から始まるため-1している
        var max = Number(countlength);
        if (isNaN(max) == true) { throw new Error("P番の数が数値になっていない"); }
        // 配列の数だけループする
        for (i = 0; i < max; i++) {
          var projId = document
                  .getElementById(SALES_EDIT_CONTENT.HIDDEN_PNUM_COUNT + i).value;
          ctrlAddpNumTextBox(i, projId);
        }
      }
    } else {

    }
  } catch (e) {
    alert("例外発生：発生個所:uw_edit_pnum_box_ctrl" + e);
  }
}

/**
 * 編集の画面読み込み時に実行される関数 P番の数に応じてテキストボックスを作る関数を呼んでいる
 */
window.addEventListener("load", function() {
  try {
    display_title_set();
    // 最初にエラーかどうかの判断
    var errflag = document.getElementById(SALES_EDIT_CONTENT.ERROR_FLAG);
    var errflagvalue = errflag.value;
    if (errflagvalue == SALES_EDIT_CONTENT.ERROR_TRUE) {
      uw_edit_pnum_box_ctrl();
      // エラーでない場合は編集か新規追加の判断
    } else {
      var modeflag = document.getElementById(SALES_EDIT_CONTENT.SELECT_FLAG);
      var modeflagvalue = modeflag.value;
      if (modeflagvalue == SALES_EDIT_CONTENT.SELECT_EDIT) {
        digit_check(SALES_EDIT_CONTENT.PROJ_NUMBER_NAME,
                SALES_EDIT_CONTENT.P_CHECKBOX_ID);
        uw_edit_pnum_box_ctrl();
      }
    }
  } catch (e) {
    alert("例外発生：発生個所:window.addEventListener" + e);
  }
}, false);

/*
 * function ctrlAddpNumTextBox (id, pNumber) { try { //値が渡されているかの確認 var
 * ObjUtilobj = new ObjUtil(); if (ObjUtilobj.valueNullUndefinedCheck(id) ==
 * false ) { throw new Error("内容:idの値が無い"); }
 * 
 * if (ObjUtilobj.valueNullUndefinedCheck(pNumber) == false || pNumber == "") {
 * throw new Error("内容:pNumberの値が無い"); } this.num++; //追加テキストボックス var text =
 * document.createElement(SALES_EDIT_CONTENT.P_ADD_PART_INPUT); text.type =
 * 'text'; text.id = 'textbox' + id; text.name = 'uw_p_number'; text.value =
 * pNumber; text.readOnly = true;
 * 
 * //brタグ var brTag = document.createElement(SALES_EDIT_CONTENT.P_ADD_BR_ID);
 * brTag.id = 'br' + id;
 * 
 * //削除ボタン var minusButton =
 * document.createElement(SALES_EDIT_CONTENT.P_ADD_PART_INPUT); minusButton.type =
 * 'button'; minusButton.id = id; //minusButton.value = 'Ｘ'; minusButton.value =
 * SALES_EDIT_CONTENT.DEL_BUTTON_ICON; minusButton.onclick =
 * function(){//ボタンを押された時の処理 num--; //alert(num); var div =
 * document.getElementById(SALES_EDIT_CONTENT.P_ADD_AREA); //親要素取得 var
 * removeTextbox = document.getElementById(SALES_EDIT_CONTENT.P_ADD_BOX_ID +
 * minusButton.id);//削除するテキストボックス var removeButton =
 * document.getElementById(minusButton.id);//削除するボタン var removeBR =
 * document.getElementById(SALES_EDIT_CONTENT.P_ADD_BR_ID +
 * minusButton.id);//削除するbrタグ
 * 
 * div.removeChild(removeTextbox); div.removeChild(removeButton);
 * div.removeChild(removeBR);
 * 
 * if (num > 8) {//テキストボックスが４つより多くなったら、機能しないようにする
 * document.getElementById(SALES_EDIT_CONTENT.P_ADD_BUTTON).disabled = 'true'; }
 * else { document.getElementById(SALES_EDIT_CONTENT.P_ADD_BUTTON).disabled =
 * ''; } }
 * 
 * //テキストボックス、削除ボタン、brタグを表示させる var div =
 * document.getElementById(SALES_EDIT_CONTENT.P_ADD_AREA);
 * div.appendChild(text); div.appendChild(minusButton); div.appendChild(brTag);
 * 
 * if(num > 8){//テキストボックスが４つより多くなったら、機能しないようにする
 * document.getElementById(SALES_EDIT_CONTENT.P_ADD_BUTTON).disabled = 'true';
 * }else{ document.getElementById(SALES_EDIT_CONTENT.P_ADD_BUTTON).disabled =
 * ''; } } catch (e) { alert("例外発生：発生個所:ctrlAddpNumTextBox"+ e); } }
 */

function ctrlAddpNumTextBox(id, pNumber) {
  try {
    // 値が渡されているかの確認
    var ObjUtilobj = new ObjUtil();
    if (ObjUtilobj.valueNullUndefinedCheck(id) == false) { throw new Error(
            "内容:idの値が無い"); }

    if (ObjUtilobj.valueNullUndefinedCheck(pNumber) == false || pNumber == "") { throw new Error(
            "内容:pNumberの値が無い"); }
    this.num++;
    // 追加テキストボックス
    var text = document.createElement(SALES_EDIT_CONTENT.P_ADD_PART_INPUT);
    text.className = 'pnum';
    text.type = 'text';
    text.id = 'textbox' + id;
    text.name = 'uw_p_number';
    text.value = pNumber;
    text.readOnly = true;

    // brタグ
    var brTag = document.createElement(SALES_EDIT_CONTENT.P_ADD_BR_ID);
    brTag.id = 'br' + id;

    // 削除ボタン
    var minusButton = document
            .createElement(SALES_EDIT_CONTENT.P_ADD_PART_INPUT);
    minusButton.type = 'button';
    minusButton.id = id;
    minusButton.className = 'minusbutton'
    // minusButton.value = 'Ｘ';
    minusButton.value = SALES_EDIT_CONTENT.DEL_BUTTON_ICON;
    minusButton.onclick = function() {// ボタンを押された時の処理
      num--;
      // alert(num);
      var div = document.getElementById(SALES_EDIT_CONTENT.P_ADD_AREA); // 親要素取得
      var removeTextbox = document
              .getElementById(SALES_EDIT_CONTENT.P_ADD_BOX_ID + minusButton.id);// 削除するテキストボックス
      var removeButton = document.getElementById(minusButton.id);// 削除するボタン
      var removeBR = document.getElementById(SALES_EDIT_CONTENT.P_ADD_BR_ID
              + minusButton.id);// 削除するbrタグ

      div.removeChild(removeTextbox);
      div.removeChild(removeButton);
      div.removeChild(removeBR);

      // if (num > 8) {//テキストボックスが9つより多くなったら、機能しないようにする(10個表示された時点で機能しないようにする）
      if (num <= SALES_EDIT_CONTENT.P_ADD_BOX_MAX_LIMIT) {
        document.getElementById(SALES_EDIT_CONTENT.P_ADD_BUTTON).disabled = '';
      }
    }

    // テキストボックス、削除ボタン、brタグを表示させる
    var div = document.getElementById(SALES_EDIT_CONTENT.P_ADD_AREA);
    div.appendChild(text);
    div.appendChild(minusButton);
    div.appendChild(brTag);

    // if(num > 8){//テキストボックスが9つより多くなったら、機能しないようにする(10個表示された時点で機能しないようにする）
    if (num > SALES_EDIT_CONTENT.P_ADD_BOX_MAX_LIMIT) {
      document.getElementById(SALES_EDIT_CONTENT.P_ADD_BUTTON).disabled = 'true';
    }
  } catch (e) {
    alert("例外発生：発生個所:ctrlAddpNumTextBox" + e);
  }
}