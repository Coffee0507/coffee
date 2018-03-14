/**
 * @fileOverview テキストボックス関連ユーティリティファイル
 * @author dai
 * @version 1.0
 */

/**
 * Enterキーか判定
 * 
 * @param keyCode
 *          キーコード
 * @return Enterキーの場合、true その他の場合、false を返す
 */
function isEnterkey(keyCode) {
  if (13 == keyCode || 3 == keyCode) {
    // Enter(3) キーの場合
    return true;
  }
  return false;
}

/**
 * BackSpaceキーか判定
 * 
 * @param keyCode
 *          キーコード
 * @return BackSpaceキーの場合、true その他の場合、false を返す
 */
/*
 * function isBackSpacekey(keyCode) { if (8 == keyCode) { // BackSpace(8) キーの場合
 * return true; } return false; }
 */

/**
 * キープレスインベント処理ハンドラ
 * 
 * @param evt
 *          イベントオブジェクト or 引数なし
 * @return Enterキーの場合、false その他の場合、true を返す
 */
function keyPressHandler(evt) {
  try {
    evt = (evt) ? evt : event;
    var charCode = (evt.charCode) ? evt.charCode : ((evt.which) ? evt.which
            : evt.keyCode);
    var keyCode = Number(charCode);
    if (false != isEnterkey(keyCode)) {
      // if (false != isEnterkey(keyCode) || false != isBackSpacekey(keyCode)) {
      return false;
    }
  } catch (e) {
    alert("例外発生:" + e);
    return true;
  }
  return true;
}

/**
 * 指定のフォーム内の全ての Textbox にキープレス処理を追加
 * 
 * @param formid
 *          フォームタグのID
 */
function attachOnKeyPressToText(formid) {
  var elements = document.forms[formid].elements;
  for (var nIndex = 0; nIndex < elements.length; nIndex++) {
    var e = elements[nIndex];
    if (e.type == "text") {
      e.onkeypress = keyPressHandler;
    }
  }
}
