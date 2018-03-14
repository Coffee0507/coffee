/**
 * @fileOverview 入力された値の確認に関するクラスを記述するファイルです。
 * @author maezawa
 * @version 1.0
 */

/**
 * @class Checkinputtext
 * @constructor
 */
var Checkinputtext = function() {
}

/**
 * 未入力かどうか確認を行う関数
 * 
 * @method isEmpty
 * @param inputval テキストボックスに入力された値
 * @return {Boolean} 受け取った値が空の場合はtrue、それ以外はfalseを返す
 */
Checkinputtext.prototype.isEmpty = function(inputval) {
  if (inputval == "") {
    return true;
  }
  return false;
}

/**
 * 入力された値が許可されている内容かどうか確認を行う関数
 * 
 * @method isPatternMatch
 * @param inputval テキストボックスに入力された値
 * @param pattern 入力を許可しない範囲（正規表現）
 * @return {Boolean} 受け取った値が許可しない値だった場合にtrue、許可された値だった場合にfalseを返す
 */
Checkinputtext.prototype.isPatternMatch = function(inputval, patternString) {
  var ObjUtilobj = new ObjUtil();
  if (ObjUtilobj.valueNullUndefinedCheck(inputval) == false || inputval == "") {
    throw new Error("内容:inputvalの値が無い");
  }
  if (ObjUtilobj.valueNullUndefinedCheck(patternString) == false || patternString == "") {
    throw new Error("内容:patternStringの値が無い");
  }
  //文字列を正規表現オブジェクトにする
  var patternobj = new RegExp(patternString);
  if (inputval.match(patternobj)) {
    return true;
  }
  return false;
}

/**
 * 上限値・下限値の確認を行う関数
 * 未確認のため後ほど確認を行う
 * @method valueLimitCheck
 * @param inputval テキストボックスに級力された値
 * @param maxval 上限値
 * @param minval 下限値
 * @return {Boolean} inputvalが上限値、もしくは下限値を超えた値だった場合に、false、超えていないかった場合に、true、を返す
 */
Checkinputtext.prototype.valueLimitCheck = function(inputval, maxval, minval) {
  var ObjUtilobj = new ObjUtil()
  //例外処理
  if (ObjUtilobj.valueNullUndefinedCheck(inputval) == false || inputval == "") {
    throw new Error("内容:inputvalの値が無い");
  } 
  if (ObjUtilobj.valueNullUndefinedCheck(maxval) == false || maxval == "") {
    throw new Error("内容:maxvalの値が無い");
  }  
  if (ObjUtilobj.valueNullUndefinedCheck(minval) == false || minval == "") {
    throw new Error("内容:minvalの値が無い");
  }
  //数値チェックに使用
  var numOnlyPattern = INPUT_PATTERN.NUMBER_ONLY;
  if (this.isPatternMatch(inputval, numOnlyPattern) == true) {
    throw new Error("内容:inputvalが半角数字以外");
  }
  if (this.valueMincheck(inputval, minval) == false || this.valueMaxcheck(inputval, maxval) == false) {
    return false;
  }
  return true;
}

/**
 * 入力された数値が下限値より小さいかどうか確認を行う関数
 * 
 * @method valueMincheck
 * @param inputval テキストボックスに入力された値
 * @param minVal 下限値
 * @return 入力された値が下限値より小さい場合にfalseを返す それ以外はtrue
 */
Checkinputtext.prototype.valueMincheck = function(inputval, minval) {
  var ObjUtilobj = new ObjUtil();
  if (ObjUtilobj.valueNullUndefinedCheck(inputval) == false || inputval == "") {
    throw new Error("内容:inputvalの値が無い");
  }
  if (ObjUtilobj.valueNullUndefinedCheck(minval) == false || minval == "") {
    throw new Error("内容:minvalの値が無い");
  }
  //半角数字のみのパターン（inputvalが半角数字のみか確認するのに使用）
  var numOnlyPattern = INPUT_PATTERN.NUMBER_ONLY;
  //半角数字チェック
  if (this.isPatternMatch(inputval, numOnlyPattern) == true) {
    throw new Error("内容:inputvalが半角数字以外");
  }
  //もし下限の桁数より入力された桁数が小さい場合
  if (minval.length > inputval.length) {
    return false;
  //上限値の桁数と入力された桁数が同じ場合に以下の処理を行う
  } else if (minval.length == inputval.length) {
    //入力された数値の桁数分ループさせる
    for (var i = 0; i < inputval.length; i++) {
      //入力された数字のi文字目が下限の数字のi文字目より小さい
      if (inputval.charAt(i) < minval.charAt(i)) {
        return false;
      //入力された数字のi文字目が下限の数値のi文字目より大きいとき
      } else if (inputval.charAt(i) > minval.charAt(i)) {
        break;
      }
    }
  }
  return true;
}

/**
 * 入力された数値が上限値より大きいかどうか確認を行う関数
 * 
 * @method valueMaxcheck
 * @param inputval テキストボックスに入力された値
 * @param maxval 上限値
 * @return 入力された値が上限値より大きい場合にfalseを返す それ以外はtrue
 */
Checkinputtext.prototype.valueMaxcheck = function(inputval, maxval) {
  var ObjUtilobj = new ObjUtil();
  if (ObjUtilobj.valueNullUndefinedCheck(inputval) == false || inputval == "") {
    throw new Error("内容:inputvalの値が無い");
  }
  if (ObjUtilobj.valueNullUndefinedCheck(maxval) == false || maxval == "") {
    throw new Error("内容:maxvalの値が無い");
  }
  //半角数字のみのパターン
  var numOnlyPattern = INPUT_PATTERN.NUMBER_ONLY;
  //半角数字チェック
  if (this.isPatternMatch(inputval, numOnlyPattern) == true) {
    throw new Error("内容:inputvalが半角数字以外");
  }
  //もし上限の桁数より入力された桁数が大きかった場合
  if (maxval.length < inputval.length) {
    return false;
  //上限値の桁数と入力された桁数が同じ場合に以下の処理を行う
  } else if (maxval.length == inputval.length) {
    //入力された数値の桁数分ループさせる
    for (var i = 0; i < inputval.length; i++) {
      //入力された数字のi文字目が上限の数字のi文字目より大きいとき
      if (inputval.charAt(i) > maxval.charAt(i)) {
        return false;
      //入力された数字のi文字目が上限の数値のi文字目より小さいとき
      } else if (inputval.charAt(i) < maxval.charAt(i)) {
        break;
      }
    }
  }
  return true;
}