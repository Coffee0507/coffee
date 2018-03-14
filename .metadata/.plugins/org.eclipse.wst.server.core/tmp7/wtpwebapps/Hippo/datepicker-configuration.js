/**
 * 
 */

/**
 * 年月の日付選択で使用
 * ()内はクラス名 ※.クラス名を入れる
 */
$(function() {
  $('.dp1').datepicker({
    format: 'yyyy-mm',
    language: 'ja',       // カレンダー日本語化のため
    minViewMode : 1,
    autoclose: true,      //自動クローズ
    clearBtn: true        //クリアボタン　有効
  });
});


/**
 * 年月日の日付選択で使用
 * ()内はクラス名 ※.クラス名を入れる
 */
$(function() {
  $('.dp2').datepicker({
   format: 'yyyy-mm-dd',
   language: 'ja',       // カレンダー日本語化のため
   todayHighlight: true, //今日ハイライト
   autoclose: true,      //自動クローズ
   //todayBtn: true,       //今日ボタン 有効
   clearBtn: true        //クリアボタン 有効
 });
});