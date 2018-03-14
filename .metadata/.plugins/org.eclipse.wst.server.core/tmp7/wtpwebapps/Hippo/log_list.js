

var LOG_LIST_CONTENT = {
  'LOG_LIST_FORM_ID': 'Mainform',// Added by dai
  //検索項目のセレクトボックスのid
  'FIRST_SEARCH_SECTION' : 'search_sec_1',
  //検索項目内の日時をさすvalue
  'SECTION_TIME' : 'c_search_time',
  //検索文字を入力するテキストボックスのid
  'TEXT_AREA' : 'search_word_text',
  //検索日時を入力する日時ボックスのid
  'DATE_AREA' : 'search_word_date',
  //検索の際に入力された値を保持するhiddenのid
  'FIRST_INPUT_WORD' : 'search_word_1'
};

window.addEventListener("load",function(){
  try {
    display_title_set();
    var changeselect = document.getElementById(LOG_LIST_CONTENT.FIRST_SEARCH_SECTION);
    change(changeselect);
  } catch (e) {
    alert("例外発生"+ e);
  }
  //try {
    //attachOnKeyPressToText(LOG_LIST_CONTENT.LOG_LIST_FORM_ID);// Added by dai
  //} catch (e) {
    //alert("例外発生"+ e);
  //}
},false);


/**
 * 検索ボタンが押された際に実行される関数
 * @returns
 */
function doLogSearch () {
  try {
    //hiddenに値をセットする
    setValue();
    //値をセットしたhiddenを使用し入力確認をする
    var checkInputTextobj = new Checkinputtext();
    var searchWord = document.getElementById(LOG_LIST_CONTENT.FIRST_INPUT_WORD).value;
    //値が入っているかの確認
    if (checkInputTextobj.isEmpty(searchWord) == true) {
      alert("検索条件が未入力です");
      return false;
    }
  } catch(e) {
    alert("例外発生"+ e);
    return false
  }
  return true;
}


/**
 * 実行された際にhiddenへ検索ワードの値を設定する
 * @returns
 */
function setValue() {
  try {
    var getvalue = null;
    var type = document.getElementById(LOG_LIST_CONTENT.FIRST_SEARCH_SECTION).value;
    
    if (type != LOG_LIST_CONTENT.SECTION_TIME) {
      getvalue = document.getElementById(LOG_LIST_CONTENT.TEXT_AREA).value;
    } else {
      getvalue = document.getElementById(LOG_LIST_CONTENT.DATE_AREA).value;
    }
    document.getElementById(LOG_LIST_CONTENT.FIRST_INPUT_WORD).value = getvalue;
    
  } catch (e) {
    alert("例外発生" + e);
  }
}

function change(obj){
  try {
    //値が渡されているかの確認
    var ObjUtilobj = new ObjUtil();
    if (ObjUtilobj.valueNullUndefinedCheck(obj) == false || obj == "") {
      throw new Error("内容:objの値が無い");
    }
    //indexの取得
    var index = obj.selectedIndex;
    if (index != 0) {
      document.getElementById(LOG_LIST_CONTENT.DATE_AREA).style.display = "none";
      document.getElementById(LOG_LIST_CONTENT.TEXT_AREA).style.display = "inline";
    } else {
      document.getElementById(LOG_LIST_CONTENT.DATE_AREA).style.display = "inline";
      document.getElementById(LOG_LIST_CONTENT.TEXT_AREA).style.display = "none";
    }
  } catch(e) {
    alert("例外" + e);
  }
}
