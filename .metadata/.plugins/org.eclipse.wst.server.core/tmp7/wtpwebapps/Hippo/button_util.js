/**
 * @fileOverview ボタン関連の関数を記述するファイルです。
 * @author kakuwa
 * @version 1.0
 */

var BUTTON_UTIL_CONSTANTS = {
  'HIDDEN_ACTION_ID': 'action_id',
}

/**
 * アクションパラメータ設定関数
 * 
 * @param obj
 *          押されたボタンのオブジェクト
 * @returns 処理成功の場合、true その他の場合、false を返す
 */
function setActionToHidden(obj) {
  try {
    // 値が渡されているかの確認
    var ObjUtilobj = new ObjUtil();
    if (ObjUtilobj.valueNullUndefinedCheck(obj) == false || obj == "") { throw new Error(
            "button_util.setActionToHidden()"); }
    // ボタンに設定されているactionパラメータを取得
    var action_value = obj.value;
    // actionパラメータをセットするhiddenタグのオブジェクトを取得
    var hidden_action_obj = document
            .getElementById(BUTTON_UTIL_CONSTANTS.HIDDEN_ACTION_ID);
    // actionパラメータをhiddenタグのvalueにセットする
    hidden_action_obj.value = action_value;

  } catch (e) {
    alert("例外発生" + e);
    return false;
  }
  return true;
}
