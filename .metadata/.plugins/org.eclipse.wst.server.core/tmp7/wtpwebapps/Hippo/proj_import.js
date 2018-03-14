/**
 * 
 */

var PROJ_IMPORT_CONTENT = {
    //Q1の売上目標値を入力するテキストボックスのname値
    'INPUT_FILE_ID':'p_imp_file_id',
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
    var fileSelectStatus = document.getElementById(PROJ_IMPORT_CONTENT.INPUT_FILE_ID).value;
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