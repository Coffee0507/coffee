/**
 * インポートファイルのIDの定数
 */

// CONSTANTSに変更
var PURCHASE_IMPORT_CONSTANTS = {
    //仕入れ総額CSVデータのID値
    'INPUT_FILE_ID':'purchase_import_file_id',
}


window.addEventListener("load",function(){
    try {
      display_title_set();
    } catch (e) {
      alert("例外発生"+ e);
    }
},false);


/**
 * インポートするファイルが選択されているか確認する関数
 */
function uploadFileCheck() {
  try {
    var fileSelectStatus = document.getElementById(PURCHASE_IMPORT_CONSTANTS.INPUT_FILE_ID).value;
    if (fileSelectStatus == "") {
      alert("インポートするファイルを選択してください");
      return false;
    }
  } catch (e) {
    alert("例外発生");
    return false;
  }
  return true;
}

