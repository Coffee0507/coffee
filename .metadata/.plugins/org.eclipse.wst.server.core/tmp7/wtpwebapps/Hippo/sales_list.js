/**
 * @fileOverview 販売一覧に使用する関数を記述するファイルです。
 * @author maezawa
 * @varsion
 */

var SALES_LIST_CONTENT = {
  //formタグのid
  'SALES_LIST_FORM_ID': 'Mainform',
  //アクションパラメータを入れるhiddenのid
  'ACTION_PARAM_CONTAINER_ID':'sales_action_ctrl_id',
  //渡されたオブジェクトのname
  'OBJ_NAME':'name'
}



/**
 * 新規追加クリック処理関数
 * 
 * @param newCtrlObj
 *          新規追加ボタンオブジェクト
 * @returns 処理成功の場合、true、その他の場合、false を返す
 */
function newSales(newCtrlObj) {
  try {
    // パラメータ取得の関数
    setActionParam(newCtrlObj);
  } catch (e) {
    alert("例外発生" + e);
    return false;
  }
  return true;
}

/**
 * 変更クリック処理関数
 * 
 * @param modifyCtrlObj
 *          変更ボタンオブジェクト
 * @returns 処理成功の場合、true、その他の場合、false を返す ※チェックボックスON が１つ以外の場合も、false を返す
 */
function editSales(modifyCtrlObj) {
  try {
    // チェックボックスの選択数をみる関数
    var checked = checkbox_changecheck();
    if (checked == false) { return false; }
    // パラメータ取得の関数
    setActionParam(modifyCtrlObj);
  } catch (e) {
    alert("例外発生" + e);
    return false;
  }
  return true;
}

/**
 * 削除クリック処理関数
 * 
 * @param deleteCtrlObj
 *          削除ボタンオブジェクト
 * @returns 処理成功の場合、true、その他の場合、false を返す ※チェックボックスON が0の場合も、false を返す
 */
function delSales(deleteCtrlObj) {
  try {
    // チェックボックスの選択数をみる関数
    var checked = checkbox_delcheck();
    if (checked == false) { return false; }
    // パラメータ取得の関数
    setActionParam(deleteCtrlObj);
  } catch (e) {
    alert("例外発生" + e);
    return false;
  }
  return true;
}

/**
 * コピークリック処理関数
 * 
 * @param copyCtrlObj
 *          コピーボタンオブジェクト
 * @returns 処理成功の場合、true、その他の場合、false を返す ※チェックボックスON が0の場合も、false を返す
 */
function copySales(copyCtrlObj) {
  try {
    // チェックボックスの選択数を見る関数
    var checked = checkbox_changecheck();
    if (checked == false) { return false; }
    // パラメータ取得の関数
    setActionParam(copyCtrlObj);
  } catch (e) {
    alert("例外発生" + e);
    return false;
  }
  return true;
}

/**
 * 検索クリック処理関数
 * 
 * @param searchCtrlObj
 *          検索ボタンオブジェクト
 * @returns 処理成功の場合、true、その他の場合、false を返す
 */
function searchSales(searchCtrlObj) {
  try {
    // パラメータ取得の関数
    setActionParam(searchCtrlObj);
  } catch (e) {
    alert("例外発生" + e);
    return false;
  }
  return true;
}

/**
 * actionパラメータの設定を行う関数（詳細時のみactionパラメータとpidの2つを設定）
 * 
 * @param ctrlObj
 *          コントロールオブジェクト
 * @returns 処理成功の場合、true、その他の場合、false を返す
 */
function setActionParam(ctrlObj) {
  try {
    //値が渡されているかの確認
    var ObjUtilobj = new ObjUtil();
    if (ObjUtilobj.valueNullUndefinedCheck(ctrlObj) == false || ctrlObj == "") {
      throw new Error("内容:ctrlObjの値が無い");
    }
    
    //渡されたオブジェクトのnameを取得
    var value = ctrlObj.getAttribute(SALES_LIST_CONTENT.OBJ_NAME);
    actionCtrlObj = document.getElementById(SALES_LIST_CONTENT.ACTION_PARAM_CONTAINER_ID);
    actionCtrlObj.name = "action";
    actionCtrlObj.value = value;
  } catch (e) {
    alert("例外発生" + e);
    return false;
  }
  return true;
}

window.addEventListener("load",function(){
  try {
    display_title_set();
    attachOnKeyPressToText(SALES_LIST_CONTENT.SALES_LIST_FORM_ID);
  } catch (e) {
    alert("例外発生"+ e);
  }
},false);
