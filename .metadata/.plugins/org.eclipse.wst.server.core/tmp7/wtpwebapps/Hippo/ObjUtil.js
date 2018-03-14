/**
 * 値が正常に渡されているか確認に使用するための関数を記述するファイル
 * @author maezawa
 * @version 1.0
 */

var ObjUtil = function() {
}

/**
 * inputvalがundefine、もしくはnullかを確認する関数
 * @method valueExceptionCheck
 * @param inputval 確認したいもの
 * @return {Boolean} inputvalがundefine、もしくはnullの場合に、falseを返す
 */
ObjUtil.prototype.valueNullUndefinedCheck = function(inputval) {
  if (inputval == undefined || inputval == null) {
    return false;
  }
  return true;
}