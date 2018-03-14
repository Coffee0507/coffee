

var PROJ_DAT_CONTENT = {
	// 対象のオブジェクトのvalue値
	'VALUE': 'value',
	// 対象のオブジェクトのname値
	'NAME': 'name',
	// 変更ボタンに割り当てられているvalue値
	'P_DAT_CHANGE': 'p_dat_change',
	// アクションパラメータを入れるhiddenのid値
	'P_TURNING': 'proj_turning',
	// 添付ファイルのaタグに割り当てられているtitle値（添付ファイルのリンクの箇所）
	'TITLE': 'title',
	// 添付ファイルのaタグに割り当てられているname値（添付ファイルのリンクの箇所）
	'P_DAT_DOC': 'p_dat_doc',
	// ファイルidを入れるhiddenのid値
	'P_DAT_INC_DOC': 'p_dat_inc_doc',
	//戻るボタンに割り当てられているvalue値
	'P_DAT_RETURN': 'p_dat_return',
	// 追加：インターノウス
	// 更新ボタンに割り当てられているvalue値
	'P_DAT_MODIFY_TOTAL_WORKING_TIME_EDIT':'p_dat_modify_total_working_time',
}


window.addEventListener("load",function(){
	try {
	  display_title_set();
	} catch (e) {
	  alert("例外発生"+ e);
	}
},false);


/**
 *
 * @param obj
 * @returns
 */
function setActionParam (obj) {

  try {
    //値が渡されているかの確認
    var ObjUtilobj = new ObjUtil();
    if (ObjUtilobj.valueNullUndefinedCheck(obj) == false || obj == "") {
      throw new Error("内容:objの値が無い");
    }
    var title = null;
    var value = obj.getAttribute(PROJ_DAT_CONTENT.VALUE);
    var getname = obj.getAttribute(PROJ_DAT_CONTENT.NAME);

    //変更ボタン
    if (value == PROJ_DAT_CONTENT.P_DAT_CHANGE) {
      //value値に入るアクションパラメータを渡す
      document.getElementById(PROJ_DAT_CONTENT.P_TURNING).value = value;
    //ファイルDL
    } else if (getname == PROJ_DAT_CONTENT.P_DAT_DOC){
      //titleに設定されているファイルidを取得
      title = obj.getAttribute(PROJ_DAT_CONTENT.TITLE);
      //ファイルidを渡す
      document.getElementById(PROJ_DAT_CONTENT.P_DAT_INC_DOC).value = title;
      //value値に入るアクションパラメータを渡す
      document.getElementById(PROJ_DAT_CONTENT.P_TURNING).value = getname;
      //戻るボタン
    } else if (value == PROJ_DAT_CONTENT.P_DAT_RETURN) {
      //value値に入るアクションパラメータを渡す
      document.getElementById(PROJ_DAT_CONTENT.P_TURNING).value = value;
    // 追加：インターノウス
    // ここから
    // 更新ボタン
    } else if (value == PROJ_DAT_CONTENT.P_DAT_MODIFY_TOTAL_WORKING_TIME_EDIT) {
      //value値に入るアクションパラメータを渡す
      document.getElementById(PROJ_DAT_CONTENT.P_TURNING).value = value;
    }
    // ここまで

  } catch (e) {
    alert("例外発生" + e);
    return false;
  }
  return true;
}

function Print(){

  try {
    //自画面を印刷
    window.print();
  } catch (e) {
    alert("例外発生" + e);
  }
}
