/**
 * 受注・売上月別合計用 javascript ファイル
 */

/**
 * 受注・売上月別合計用 javascript 定義
 */
// Added by dai
var TOTAL_CONSTANTS = {
  // （過去用）日付セレクトボックスのid値
  'TOTAL_DATE_SELECT_BOX_ID': 'total_date_select_box_id'
}

window.addEventListener("load", function() {
  try {
    display_title_set();
  } catch (e) {
    alert("例外発生" + e);
  }
}, false);

/**
 * （過去）表示ボタンクリック処理
 * 
 * @returns 表示実行可能な場合、true その他の場合、false を返す
 */
// Added by dai
function clickDispProc() {
  try {
    var selectBoxUtilObj = new SelectBoxUtil();
    var isSelectedDateCombo = selectBoxUtilObj
            .isSelected(TOTAL_CONSTANTS.TOTAL_DATE_SELECT_BOX_ID);
    if (false == isSelectedDateCombo) {
      alert("表示するデータがありません");
    }
    if (false == isSelectedDateCombo) { return false; }
  } catch (e) {
    alert("例外発生" + e);
    return false;
  }
  return true;
}
