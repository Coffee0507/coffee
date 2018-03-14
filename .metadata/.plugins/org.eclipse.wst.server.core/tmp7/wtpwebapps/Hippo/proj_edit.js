/**
 * @fileOverview proj_eidt.jspで共通で使用するjsファイル
 * @author maezawa
 * @version 1.0
 */

var PROJ_EDIT_CONTENT = {
  //formタグのid
  'PROJ_EDIT_FORM_ID': 'Mainform',
  //P番を入力するテキストボックスのname値
  'PROJ_NUMBER_NAME':'p_number',
  //分類を選択するセレクトボックスのid値
  'PROJ_CAT_ID':'p_type',
  //営業を選択するセレクトボックスのid値
  'PROJ_SALES_ID':'p_sales',
  //ステータスを選択するセレクトボックスのid値
  'PROJ_STATUS_ID':'p_status',
  //売上先を入力するテキストボックスのname値
  'PROJ_CLIENT_NAME':'p_cus',
  //受注金額を入力するテキストボックスのname値
  'PROJ_ORDER_MONEY_NAME':'p_order_money',
  //発行日を入力するテキストボックスのid値
  'PROJ_ISSUE_DAY_ID':'p_issue_day',
  //開発期間の開始日を入力するテキストボックスのid値
  'PROJ_DEV_START_ID':'p_dev_start',
  //開発期間の終了日を入力するテキストボックスのid値
  'PROJ_DEV_END_ID':'p_dev_end',
  //開発予算を入力するテキストボックスのname値
  'PROJ_DEV_BUDGET_NAME':'p_dev_budget',
  //送信する通知ユーザーが表示されているセレクトボックスのname値
  'PROJ_NOTICE_LIST_NAME':'p_notice_choice',
  //編集時に表示されるアップロード済みのファイルを囲むdiv要素のid値
  'PROJ_UPLOADED_FILE_DIV_ID':'file_area',

  // 追加：インターノウス
  // ここから
  //送信する通知ユーザーが表示されているセレクトボックスのid値
  'PROJ_NOTICE_LIST_ID':'p_notice_choice_id',
  // ここまで

  //inputタグの要素
  'INPUT_TAG':'input',
  //添付ファイルを追加した後に表示されるファイル名を囲むdiv要素のid値
  'PROJ_ADD_UPLOAD_FILE_DIV_ID':'files_list',
  //divタグの要素
  'DIV_TAG':'div',
  //ファイルの上限数
  'FILE_MAX_LIMIT':'10',
  //アップロード済み添付ファイルのチェックボックスに指定しているクラス名
  'UPLOADED_FILE_CHECKBOX':'input_file_checkbox',
  //ファイル添付を行うinput要素のid値
  'ADD_FILE_INPUT_ID':'my_file_element'
}


window.addEventListener("load",function(){
	try {
	  display_title_set();
	  //attachOnKeyPressToText(PROJ_EDIT_CONTENT.PROJ_EDIT_FORM_ID);
	} catch (e) {
	  alert("例外発生"+ e);
	}
},false);


/**
 * P番新規追加時に実行される関数
 * @return {Boolean} P番、売上先、受注金額、発行日、開発予算の入力チェックのいずれもtrueの場合にtrueを返す、どれかがfalseの場合はfalseを返す
 */
function p_add() {
  try {
    //P番の確認
    var projNumberChecked = proj_number_check(PROJ_EDIT_CONTENT.PROJ_NUMBER_NAME, INPUT_PATTERN.NUMBER_HYPHEN_ONLY);
    //分類の確認
    var projCatChecked = proj_cat_check(PROJ_EDIT_CONTENT.PROJ_CAT_ID);
    //営業の確認
    var projSalesChecked = proj_sales_check(PROJ_EDIT_CONTENT.PROJ_SALES_ID);
    //ステータスの確認
    var projStatusChecked = proj_status_check(PROJ_EDIT_CONTENT.PROJ_STATUS_ID);
    //売上先の確認
    var projClientChecked = proj_client_check(PROJ_EDIT_CONTENT.PROJ_CLIENT_NAME);
    //受注金額の確認
    var projOrderMoneyChecked = proj_order_money_check(PROJ_EDIT_CONTENT.PROJ_ORDER_MONEY_NAME, INPUT_PATTERN.NUMBER_ONLY, AMOUNT_AND_TARGET_LIMIT.MAX_LIMIT_VAL, AMOUNT_AND_TARGET_LIMIT.MIN_LIMIT_VAL);
    //発行日の確認
    var projIssueDayChecked = proj_issue_day_check(PROJ_EDIT_CONTENT.PROJ_ISSUE_DAY_ID);
    //開発期間の確認
    var devPeriodChecked = proj_dev_date_check(PROJ_EDIT_CONTENT.PROJ_DEV_START_ID, PROJ_EDIT_CONTENT.PROJ_DEV_END_ID)
    //開発予算の確認
    var projDevbudgetChecked = proj_dev_budget_check(PROJ_EDIT_CONTENT.PROJ_DEV_BUDGET_NAME, INPUT_PATTERN.NUMBER_ONLY, AMOUNT_AND_TARGET_LIMIT.MAX_LIMIT_VAL, AMOUNT_AND_TARGET_LIMIT.MIN_LIMIT_VAL);
    //確認内容にfalseがあった場合にfalseを返し進ませない
    //if (projNumberChecked == false || projCatChecked == false || projSalesChecked == false || projStatusChecked == false || projClientChecked == false || projOrderMoneyChecked == false || projIssueDayChecked == false || projDevbudgetChecked == false){
    if (projNumberChecked == false || projCatChecked == false || projSalesChecked == false || projStatusChecked == false || projClientChecked == false || projOrderMoneyChecked == false || projIssueDayChecked == false || projDevbudgetChecked == false || devPeriodChecked == false){
    return false;
    }
  } catch (e) {
    alert("例外発生:" + e);
    return false;
  }

  // 追加：インターノウス
  // ここから
  //通知ユーザーの右側のリスト内を選択済みにするもの
  selectAll(PROJ_EDIT_CONTENT.PROJ_NOTICE_LIST_ID);
  // ここまで
  return true;
}


/**
 * P番編集時に実行される関数
 * @returns {Boolean} 売上先、受注金額、開発予算の入力チェックのいずれもtrueの場合にtrueを返す、どれかがfalseの場合はfalseを返す
 */
function p_edit(){
  try {
    //■■■ チェック結果の判定がまだ入っていない falseを返すやつ ■■■
    //分類の確認
    var projCatChecked = proj_cat_check(PROJ_EDIT_CONTENT.PROJ_CAT_ID);
    //営業の確認
    var projSalesChecked = proj_sales_check(PROJ_EDIT_CONTENT.PROJ_SALES_ID);
    //ステータスの確認
    var projStatusChecked = proj_status_check(PROJ_EDIT_CONTENT.PROJ_STATUS_ID);
    //売上先の確認
    var projClientChecked = proj_client_check(PROJ_EDIT_CONTENT.PROJ_CLIENT_NAME);
    //受注金額の確認
    var projOrderMoneyChecked = proj_order_money_check(PROJ_EDIT_CONTENT.PROJ_ORDER_MONEY_NAME, INPUT_PATTERN.NUMBER_ONLY, AMOUNT_AND_TARGET_LIMIT.MAX_LIMIT_VAL, AMOUNT_AND_TARGET_LIMIT.MIN_LIMIT_VAL);
    //発行日の確認
    var projIssueDayChecked = proj_issue_day_check(PROJ_EDIT_CONTENT.PROJ_ISSUE_DAY_ID);
    //開発期間の確認
    var devPeriodChecked = proj_dev_date_check(PROJ_EDIT_CONTENT.PROJ_DEV_START_ID, PROJ_EDIT_CONTENT.PROJ_DEV_END_ID)
    //開発予算の確認
    var projDevbudgetChecked = proj_dev_budget_check(PROJ_EDIT_CONTENT.PROJ_DEV_BUDGET_NAME, INPUT_PATTERN.NUMBER_ONLY, AMOUNT_AND_TARGET_LIMIT.MAX_LIMIT_VAL, AMOUNT_AND_TARGET_LIMIT.MIN_LIMIT_VAL);
    //添付ファイルの上限確認
    var filecountChecked = attachmentFileLimitCheck();
    //確認内容にfalseがあった場合にfalseを返し進ませない
    //if (projCatChecked == false || projSalesChecked == false || projStatusChecked == false || projClientChecked == false || projOrderMoneyChecked == false || projIssueDayChecked == false || projDevbudgetChecked == false || filecountChecked == false) {
    if (projCatChecked == false || projSalesChecked == false || projStatusChecked == false || projClientChecked == false || projOrderMoneyChecked == false || projIssueDayChecked == false || projDevbudgetChecked == false || filecountChecked == false || devPeriodChecked ==false) {
      return false;
    }
  } catch (e) {
    alert("例外発生：" + e);
    return false;
  }

  // 追加：インターノウス
  // ここから
  //通知ユーザーの右側のリスト内を選択済みにするもの
  selectAll(PROJ_EDIT_CONTENT.PROJ_NOTICE_LIST_ID);
  // ここまで
  return true;
}


/**p_add()と同じため不使用
 * P番再利用時に実行される関数
 * @returns {Boolean} P番、売上先、受注金額、発行日、開発予算の入力チェックのいずれもtrueの場合にtrueを返す、どれかがfalseの場合はfalseを返す

function p_copy(){
  try {
    //■■■ 確認する箇所が足りていないため新規追加と合わせる ■■■
    //■■■ チェック結果の判定がまだ入っていない falseを返すやつ ■■■
    //P番の確認
    var projNumberChecked = proj_number_check(PROJ_EDIT_CONTENT.PROJ_NUMBER_NAME, INPUT_PATTERN.NUMBER_HYPHEN_ONLY);
    //分類の確認
    var projCatChecked = proj_cat_check(PROJ_EDIT_CONTENT.PROJ_CAT_ID);
    //営業の確認
    var projSalesChecked = proj_sales_check(PROJ_EDIT_CONTENT.PROJ_SALES_ID);
    //ステータスの確認
    var projStatusChecked = proj_status_check(PROJ_EDIT_CONTENT.PROJ_STATUS_ID);
    //売上先の確認
    var projClientChecked = proj_client_check(PROJ_EDIT_CONTENT.PROJ_CLIENT_NAME)
    //受注金額の確認
    var projOrderMoneyChecked = proj_order_money_check(PROJ_EDIT_CONTENT.PROJ_ORDER_MONEY_NAME, INPUT_PATTERN.NUMBER_ONLY, AMOUNT_AND_TARGET_LIMIT.MAX_LIMIT_VAL, AMOUNT_AND_TARGET_LIMIT.MIN_LIMIT_VAL);
    //発行日の確認
    var projIssueDayChecked = proj_issue_day_check(PROJ_EDIT_CONTENT.PROJ_ISSUE_DAY_ID);
    //開発期間の確認
    var devPeriodChecked = proj_dev_date_check(PROJ_EDIT_CONTENT.PROJ_DEV_START_ID, PROJ_EDIT_CONTENT.PROJ_DEV_END_ID)
    //開発予算の確認
    var projDevbudgetChecked = proj_dev_budget_check(PROJ_EDIT_CONTENT.PROJ_DEV_BUDGET_NAME, INPUT_PATTERN.NUMBER_ONLY, AMOUNT_AND_TARGET_LIMIT.MAX_LIMIT_VAL, AMOUNT_AND_TARGET_LIMIT.MIN_LIMIT_VAL);
    //確認内容にfalseがあった場合にfalseを返し進ませない
    //if (projNumberChecked == false || projCatChecked == false || projSalesChecked == false || projStatusChecked == false || projClientChecked == false || projOrderMoneyChecked == false || projIssueDayChecked == false || projDevbudgetChecked == false){
    if (projNumberChecked == false || projCatChecked == false || projSalesChecked == false || projStatusChecked == false || projClientChecked == false || projOrderMoneyChecked == false || projIssueDayChecked == false || projDevbudgetChecked == false || devPeriodChecked ==false){
      return false;
    }
  } catch(e) {
    alert("例外発生:" + e);
    return false;
  }
  //通知ユーザーの右側のリストに誰か入っていた場合
  var noticeUser = document.getElementsByName(PROJ_EDIT_CONTENT.PROJ_NOTICE_LIST_NAME)[0];
  var noticeUserOptions = noticeUser.length;
  if (noticeUserOptions != 0) {
    //通知ユーザーの右側のリスト内を選択済みにするもの
    selectNoticeAll(PROJ_EDIT_CONTENT.PROJ_NOTICE_LIST_NAME);
  }
  return true;
}
 */

/**
 * 通知ユーザーの処理(矢印ボタンをクリックしたときの)
 */
$(document).ready(function() {
  $('input[name=right]').on('click', function() {
      moveToRight('p_notice_all', 'p_notice_choice');
  });

  $('input[name=left]').on('click', function() {
      moveToLeft('p_notice_choice', 'p_notice_all');
  });

  var moveToRight = function(_this, target) {
      var rightObj = $("#p_notice_choice_id").children(); //右側のボックスのオブジェクトを取得(全要素を取得するため)

      if(rightObj.length == null || rightObj.length == 0){//右側のボックスが空のとき
          $('select[name=' + target + ']').append($("#p_notice_all_id option:selected").clone());//右側のボックスに要素追加

      }else{
          $('select[name=' + _this + '] option:selected').each(function() {//選択された要素を一つずつ取得
              var leftVal = $(this).val();//選択された要素のvalue
              var isSame = false;//識別フラグ
              for(var i=0; i<rightObj.length; i++){//右側のボックスの要素を一つずつ取得
                  var rightVal = rightObj.eq(i).val()//valueを取得
                  if(leftVal == rightVal){
                      isSame = true;
                      break;
                  }
              }
              if(isSame == false){
                  $('select[name=' + target + ']').append($(this).clone());//右側のボックスに要素追加
              }
          });
      }
  };

  var moveToLeft = function(_this, target) {
      $('select[name=' + _this + '] option:selected').each(function() {
          $(this).remove();
      });
  };
});




/**
 * P番の入力内容を確認する関数
 * @param p_number_name
 * @param pattern
 * @returns
 */
function proj_number_check(p_number_name, pattern) {
  try {
    //値が渡されているかの確認
    var ObjUtilobj = new ObjUtil();
    if (ObjUtilobj.valueNullUndefinedCheck(p_number_name) == false || p_number_name == "") {
      throw new Error("内容:p_number_nameの値が無い");
    }
    if (ObjUtilobj.valueNullUndefinedCheck(pattern) == false || pattern == "") {
      throw new Error("内容:patternの値が無い");
    }
    //入力文字確認の呼び出し
    var checkInputTextobj = new Checkinputtext();
    var projNunber = document.getElementsByName(p_number_name);
    var projNunberValue = projNunber[0].value;
    //未入力チェック
    if (checkInputTextobj.isEmpty(projNunberValue) == true) {
      alert("P番が未入力です");
      return false;
      //パターンチェック
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
 * @param proj_cat_id
 * @returns
 */
function proj_cat_check(proj_cat_id) {
  try {
    //値が渡されているかの確認
    var ObjUtilobj = new ObjUtil();
    if (ObjUtilobj.valueNullUndefinedCheck(proj_cat_id) == false || proj_cat_id == "") {
      throw new Error("内容:proj_cat_idの値が無い");
    }
    var checkInputTextobj = new Checkinputtext();
    var projCat = document.getElementById(proj_cat_id);
    var projCatSelectedValue = projCat.value;
    if (checkInputTextobj.isEmpty(projCatSelectedValue) == true) {
      alert("分類が未選択です");
      return false;
    }
  } catch (e){
    alert("例外発生 発生個所：proj_cat_check" + e);
    return false;
  }
  return true;
}

/**
 * 営業の選択内容を確認する関数
 * @param proj_sales_id
 * @returns
 */
function proj_sales_check(proj_sales_id) {
  try {
    //値が渡されているかの確認
    var ObjUtilobj = new ObjUtil();
    if (ObjUtilobj.valueNullUndefinedCheck(proj_sales_id) == false || proj_sales_id == "") {
      throw new Error("内容:proj_sales_idの値が無い");
    }
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
 * @param proj_status_id
 * @returns
 */
function proj_status_check(proj_status_id) {
  try {
    //値が渡されているかの確認
    var ObjUtilobj = new ObjUtil();
    if (ObjUtilobj.valueNullUndefinedCheck(proj_status_id) == false || proj_status_id == "") {
      throw new Error("内容:proj_status_idの値が無い");
    }
    var checkInputTextobj = new Checkinputtext();
    var projStatus = document.getElementById(proj_status_id);
    var projStatusSelectedValue = projStatus.value;
    if (checkInputTextobj.isEmpty(projStatusSelectedValue) == true) {
      alert("ステータスが未選択です");
      return false;
    }
  } catch (e){
    alert("例外発生 発生個所：proj_status_check" + e);
    return false;
  }
  return true;
}

/**
 * 売上先の入力確認を行う関数
 * @param proj_client_name
 * @returns
 */
function proj_client_check(proj_client_name) {
  try {
    //値が渡されているかの確認
    var ObjUtilobj = new ObjUtil();
    if (ObjUtilobj.valueNullUndefinedCheck(proj_client_name) == false || proj_client_name == "") {
      throw new Error("内容:proj_client_nameの値が無い");
    }
    //入力文字確認の呼び出し
    var checkInputTextobj = new Checkinputtext();
    var projClient = document.getElementsByName(proj_client_name);
    var projClientValue = projClient[0].value;
    //未入力チェック
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
 * @param p_order_money
 * @param pattern
 * @returns
 */
function proj_order_money_check(p_order_money_name, pattern, maxval, minval) {
  try {
    //値が渡されているかの確認
    var ObjUtilobj = new ObjUtil();
    if (ObjUtilobj.valueNullUndefinedCheck(p_order_money_name) == false || p_order_money_name == "") {
      throw new Error("内容:p_order_moneyの値が無い");
    }
    if (ObjUtilobj.valueNullUndefinedCheck(pattern) == false || pattern == "") {
      throw new Error("内容:patternの値が無い");
    }
    if (ObjUtilobj.valueNullUndefinedCheck(maxval) == false || maxval == "") {
      throw new Error("内容:maxvalの値が無い");
    }
    if (ObjUtilobj.valueNullUndefinedCheck(minval) == false || minval == "") {
      throw new Error("内容:minvalの値が無い");
    }

    //入力文字確認の呼び出し
    var checkInputTextobj = new Checkinputtext();
    var projOrder = document.getElementsByName(p_order_money_name);
    var projOrderValue = projOrder[0].value;
    //未入力チェック
    /*
    if (checkInputTextobj.isEmpty(projOrderValue) == true) {
      alert("受注金額が未入力です");
      return false;
      //パターンチェック
    } else */
    //もし値が空でない場合
    if (projOrderValue != ""){
      if (checkInputTextobj.isPatternMatch(projOrderValue, pattern) == true) {
        alert("受注金額に半角数字以外の文字が入っています");
        return false;
      }
      if (checkInputTextobj.valueLimitCheck(projOrderValue, maxval, minval) == false) {
        window.alert("受注金額に入力された値が有効ではありません。\n " + minval + "～" + maxval + "までの値を入力してください。");
        return false;
      }
    }
  } catch (e) {
    alert("例外発生 発生個所：proj_order_money_check" + e);
    return false;
  }
  return true;
}

/**
 * 開発予算の入力確認
 * @param proj_dev_budget_name
 * @param pattern
 * @returns
 */
function proj_dev_budget_check(proj_dev_budget_name, pattern, maxval, minval) {
  try {
    //値が渡されているかの確認
    var ObjUtilobj = new ObjUtil();
    if (ObjUtilobj.valueNullUndefinedCheck(proj_dev_budget_name) == false || proj_dev_budget_name == "") {
      throw new Error("内容:proj_dev_budget_nameの値が無い");
    }
    if (ObjUtilobj.valueNullUndefinedCheck(pattern) == false || pattern == "") {
      throw new Error("内容:patternの値が無い");
    }
    if (ObjUtilobj.valueNullUndefinedCheck(maxval) == false || maxval == "") {
      throw new Error("内容:maxvalの値が無い");
    }
    if (ObjUtilobj.valueNullUndefinedCheck(minval) == false || minval == "") {
      throw new Error("内容:minvalの値が無い");
    }

    //入力文字確認の呼び出し
    var checkInputTextobj = new Checkinputtext();
    var prodevbudget = document.getElementsByName(proj_dev_budget_name);
    var prodevbudgetValue = prodevbudget[0].value;
    //未入力チェック
    /*
    if (checkInputTextobj.isEmpty(prodevbudgetValue) == true) {
      alert("開発予算が未入力です");
      return false;
      //パターンチェック
    } else */
    if (prodevbudgetValue != ""){
      if (checkInputTextobj.isPatternMatch(prodevbudgetValue, pattern) == true) {
        alert("開発予算に半角数字以外の文字が入っています");
        return false;
      }
      if (checkInputTextobj.valueLimitCheck(prodevbudgetValue, maxval, minval) == false) {
        window.alert("開発予算に入力された値が有効ではありません。\n " + minval + "～" + maxval + "までの値を入力してください。");
        return false;
      }
    }
  } catch (e) {
    alert("例外発生 発生個所：proj_dev_budget_check" + e);
    return false;
  }
  return true;
}

/**
 * 発行日の入力確認
 * @param proj_issue_day_id
 * @returns
 */
function proj_issue_day_check(proj_issue_day_id) {
  try {
    var ObjUtilobj = new ObjUtil();
    if (ObjUtilobj.valueNullUndefinedCheck(proj_issue_day_id) == false || proj_issue_day_id == "") {
      throw new Error("内容:proj_issue_day_idの値が無い");
    }
    var checkInputTextobj = new Checkinputtext();
    var projIssueDay = document.getElementById(proj_issue_day_id);
    var projIssueDayValue = projIssueDay.value;
    if (checkInputTextobj.isEmpty(projIssueDayValue) == true) {
      alert("発行日が未入力です");
      return false;
    }
  } catch (e) {
    alert("例外発生 発生個所：proj_issue_day_check" + e);
    return false;
  }
  return true;
}

function attachmentFileLimitCheck () {
  try {
    var total = 0;
    var notCheckedCount = uploadedFileCount(PROJ_EDIT_CONTENT.PROJ_UPLOADED_FILE_DIV_ID, PROJ_EDIT_CONTENT.INPUT_TAG);
    var addFileCount = addUploadFileCount(PROJ_EDIT_CONTENT.PROJ_ADD_UPLOAD_FILE_DIV_ID, PROJ_EDIT_CONTENT.DIV_TAG);
    if (notCheckedCount == null || addFileCount == null) {
    	throw new Error("attachmentFileLimitCheck():カウント失敗");
      return false;
    } else {
      total = (notCheckedCount + addFileCount);
      if (total > PROJ_EDIT_CONTENT.FILE_MAX_LIMIT) {
        alert("添付ファイルの数が添付上限数 " + PROJ_EDIT_CONTENT.FILE_MAX_LIMIT + "個を超えています")
        return false;
      }
    }
  } catch(e) {
    alert("例外発生:Proj_edit.js.attachmentFileLimitCheck()");
    return false;
  }
  return true;
}

function uploadedFileCount () {
  try {
    var notCheckedCount = 0;
    //既に添付されているファイルがあるかどうか
    if( document.getElementById(PROJ_EDIT_CONTENT.PROJ_UPLOADED_FILE_DIV_ID) != null) {
      //既に添付されているファイル数を取得
      var enclosureUploadedFileDiv = document.getElementById(PROJ_EDIT_CONTENT.PROJ_UPLOADED_FILE_DIV_ID);
      //var uploadedFile = enclosureUploadedFileDiv.getElementsByTagName(PROJ_EDIT_CONTENT.INPUT_TAG);
      var uploadedFile = enclosureUploadedFileDiv.getElementsByClassName(PROJ_EDIT_CONTENT.UPLOADED_FILE_CHECKBOX);
      var uploadedFileCount = uploadedFile.length;
      //未チェック状態のチェックボックスの数を数える
      for (var count = 0; count < uploadedFileCount; count++) {
        var uploadedFileCheckedStatus = uploadedFile[count].checked;
        if (uploadedFileCheckedStatus == false) {
          notCheckedCount++;
        }
      }
    }
  } catch (e) {
    alert("例外発生:Proj_edit.js.uploadedFileCount()");
  }
  return notCheckedCount;
}

function addUploadFileCount () {//これから添付しようといているファイル数を取得
  try {
    var addUploadCount = 0;
    Number(addUploadCount);
    //"File:"の部分を囲むdivを取得
    var enclosureAddUploadFileDiv = document.getElementById(PROJ_EDIT_CONTENT.PROJ_ADD_UPLOAD_FILE_DIV_ID);
    //"File:"の部分を囲むdivの中で、さらにファイルを一つずつを囲むdiv要素を取得
    var div = enclosureAddUploadFileDiv.getElementsByTagName(PROJ_EDIT_CONTENT.DIV_TAG);
    addUploadCount = div.length;
  } catch (e) {
    alert("例外発生:proj_edit.js.addUploadFileCount()");
  }
  return addUploadCount;
}

/**
 *
 * @param devstartid 開発期間の開始日を入力するテキストボックスのid
 * @param devendid 開発期間の終了日を入力するテキストボックスのid
 * @returns
 */
function proj_dev_date_check (devstartid, devendid) {
  try {
    //開始取得
    var start = document.getElementById(devstartid).value;
    //終了取得
    var end = document.getElementById(devendid).value;
    //どちらも入力されていない場合はチェックしない
    if (start == "" || end == "") {
      return true;
    } else {
      var cutedStartYear = cutYear (start);
      var cutedStartMonth = cutMonth (start);
      if (cutedStartMonth.substr(0,1) == "0") {
        cutedStartMonth = cutedStartMonth.substr(1,1);
      }
      var cutedStartDay = cutDay (start);
      if (cutedStartDay.substr(0,1) == "0") {
        cutedStartDay = cutedStartDay.substr(1,1);
      }
      var cutedEndYear = cutYear (end);
      var cutedEndMonth = cutMonth (end);
      if (cutedEndMonth.substr(0,1) == "0") {
        cutedEndMonth = cutedEndMonth.substr(1,1);
      }
      var cutedEndDay = cutDay (end);
      if (cutedEndDay.substr(0,1) == "0") {
        cutedEndDay = cutedEndDay.substr(1,1);
      }

      var result = false;
      if (differenceDateCheck2(cutedEndYear, cutedStartYear) > 0) {
        result = true;
      } else if (differenceDateCheck2(cutedEndYear, cutedStartYear) == 0) {
        if (differenceDateCheck2(cutedEndMonth, cutedStartMonth) > 0) {
          result = true;
        } else if (differenceDateCheck2(cutedEndMonth, cutedStartMonth) == 0) {
          if (differenceDateCheck2(cutedEndDay, cutedStartDay) >= 0) {
            result = true;
          }
        }
      }
      if (result == false) {
        alert("開発期間の終了日が開始日より前の日付になっています。");
        return false;
      }
    }
  } catch (e) {
    alert("例外" + e);
    return false;
  }
  return true;
}

function cutYear (targetDate) {
  try {
    var resultYear = targetDate.substr(0,4);
    return resultYear;
  } catch(e) {
    alert("例外"+ e);
    throw e;
  }
}

function cutMonth (targetDate) {
  try {
    var resultMonth = targetDate.substr(5,2);
    return resultMonth;
  } catch(e) {
    alert("例外"+ e);
    throw e;
  }
}

function cutDay (targetDate) {
  try {
    var resultDay = targetDate.substr(8,2);
    return resultDay;
  } catch(e) {
    alert("例外"+ e);
    throw e;
  }
}

function differenceDateCheck2 (end, start) {
  try {
    var result = -1;
    var startVal = Number(start);
    var endVal = Number(end);
    if (startVal > endVal) {
      result = -1;
    } else if (startVal == endVal) {
      result = 0;
    } else {
      result = 1;
    }
  } catch (e) {
    alert("例外"+ e);
    return -1;
  }
  return result;
}

function differenceDateCheck (end, start) {
  try {
    if (Number(start) > Number(end)) {
      return false;
    }
  } catch (e) {
    alert("例外"+ e);
    return false;
  }
  return true;
}

/**
 * アップロード済み添付ファイルのチェックボックスにチェックを入れた時の処理
 * @returns
 */
$(function() {
	  $(".input_file_checkbox").click(function() {
	    if ($(this).is(":checked"))
	    {
	      $(this).closest("tr").css("text-decoration", "line-through");
	    }
	    else {
	      $(this).closest("tr").css("text-decoration", "none");
	    }
	  });
	});
