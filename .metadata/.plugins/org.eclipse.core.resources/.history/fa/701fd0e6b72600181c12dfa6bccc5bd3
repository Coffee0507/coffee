/**
 * @fileOverview セレクトボックス関連ユーティリティファイル
 * @author dai
 * @version 1.0
 */

/**
 * @class SelectBoxUtil
 * @constructor
 */
var SelectBoxUtil = function() {
}

/**
 * select box が選択状態かチェック
 *
 * @param id
 *          セレクトボックスのID
 * @returns 選択状態の場合、true その他の場合、false を返す
 */
SelectBoxUtil.prototype.isSelected = function(id) {
  var selectObj = document.getElementById(id);
  if (-1 == selectObj.selectedIndex) {
    // selectedIndex 選択されている最初のoption要素のインデックス。何も選択されていない場合は-1
    return false;
  }

  return true;
}

/**
 * 追加：インターノウス
 * メンバーの右側の選択肢を選択済みにする関数
 * @param name
 * @returns
 */
function selectAll(name){
  try {
    var ObjUtilobj = new ObjUtil();
    if (ObjUtilobj.valueNullUndefinedCheck(name) == false || name == "") {
      throw new Error("内容:nameの値がありません");
    }
    var obj = document.getElementById(name);
    for(i=0;i<obj.options.length;i++){
        obj.options[i].selected = true;
    }
  } catch (e) {
    alert("例外発生 発生個所：selectAll" + e);
  }
}
