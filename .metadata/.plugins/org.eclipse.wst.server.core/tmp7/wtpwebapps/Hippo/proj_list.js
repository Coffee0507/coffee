/**
 * @fileOverview P番一覧に使用する関数を記述するファイルです。
 * @author maezawa
 * @varsion
 */

var PROJ_INPUT_TEXT_CONTENT = {
  //formタグのid
  'PROJ_LIST_FORM_ID': 'Mainform',
  //年度を入力するテキストボックスのid
  'PROJ_LIST_YEAR_ID':'p_year',
  //1つ目の検索項目のセレクトボックスのid
  'FIRST_SEARCH_SECTION' : 'search_sec_1',
  //2つ目の検索項目のセレクトボックスのid
  'SECOND_SEARCH_SECTION' : 'search_sec_2',
  //hiddenのnameに設定するためのパラメータ
  'ACTION':'action',
  //hiddenのvalueに設定するためのパラメータ
  'NAME':'name',
  //P番のタグからpidを取得する際に使用するパラメータ
  'TITLE':'title',
  //詳細遷移の際に使用するpidをセットし送るhiddenのid
  'PROJ_NUM_ID':'proj_num_id',
  //P番詳細をさすactionパラメータ
  'P_DATAIL':'p_detail',
  //検索項目内の選択肢「メンバーアサイン」に設定されているvalue値
  'SEC_ASSIGN':'sec_assign',
  //検索項目内の選択肢「発行日」に設定されているvalue値
  'SEC_ISSUE':'sec_issue',
  //1つ目の検索文字を入力するテキストボックスのid
  'FIRST_SEARCH_TEXT':'search_word_text1',
  //1つ目の検索日時を入力するテキストボックスのid
  'FIRST_SEARCH_DATE':'search_word_date1',
  //1つ目の入力された検索文字を送る際に使用するhiddenのid
  'FIRST_INPUT_WORD':'search_word_1',
  //1つ目の検索項目でメンバーアサインが選ばれた際に表示されるラジオボタンのname
  'FIRST_RADIO_BUTTON':'search_word_radio_1',
  //2つ目の検索文字を入力するテキストボックスのid
  'SECOND_SEARCH_TEXT':'search_word_text2',
  //2つ目の検索日時を入力するテキストボックスのid
  'SECOND_SEARCH_DATE':'search_word_date2',
  //2つ目の入力された検索文字を送る際に使用するhiddenのid
  'SECOND_INPUT_WORD':'search_word_2',
  //2つ目の検索項目でメンバーアサインが選ばれた際に表示されるラジオボタンのname
  'SECOND_RADIO_BUTTON':'search_word_radio_2',
  //検索条件１のラジオボタンを囲むdivのid
  'SEARCH1_RADIO':'search1_radio',
  //検索条件2のラジオボタンを囲むdivのid
  'SEARCH2_RADIO':'search2_radio'
}

window.addEventListener("load",function(){
  try {
	display_title_set();
	changeDisInputBoxType();
	//attachOnKeyPressToText(PROJ_INPUT_TEXT_CONTENT.PROJ_LIST_FORM_ID);
  } catch (e) {
    alert("例外" + e);
  }
},false);

/**
 * 表示ボタンが押された際に動く年度の入力確認を行う関数
 * @returns
 */
function inputYearCheck () {
  try {
    //入力された文字が半角数字かの確認
    var inputChecked = yearCheck(PROJ_INPUT_TEXT_CONTENT.PROJ_LIST_YEAR_ID, INPUT_PATTERN.NUMBER_ONLY, AMOUNT_AND_TARGET_LIMIT.MAX_YEAR_LIMIT_VAL, AMOUNT_AND_TARGET_LIMIT.MIN_YEAR_LIMIT_VAL);
    if (inputChecked == false){
      return false;
    }
  } catch(e) {
    alert("例外発生"+ e);
    return false;
  }
  return true;
}

/**
 * 年度の入力内容の確認
 * @param inputval
 * @param pattern
 * @returns
 */
function yearCheck (proj_list_year_id, pattern, maxval, minval){
  try {
    //値が渡されているかの確認
    var ObjUtilobj = new ObjUtil();
    if (ObjUtilobj.valueNullUndefinedCheck(proj_list_year_id) == false || proj_list_year_id == "") {
      throw new Error("内容:proj_list_year_idの値が無い");
    }
    if (ObjUtilobj.valueNullUndefinedCheck(pattern) == false || pattern == "") {
      throw new Error("内容:patternの値が無い");
    }
    if (ObjUtilobj.valueNullUndefinedCheck(maxval) == false || maxval == "") {
      throw new Error("内容:maxvalの値が無い");
    }
    if (ObjUtilobj.valueNullUndefinedCheck(minval) == false || minval == "") {
      throw new Error("内容:minvalの値が無い");
    }
    
    var checkInputTextobj = new Checkinputtext();
    var projListYear = document.getElementById(proj_list_year_id);
    var projListYearValue = projListYear.value;
    
    if (checkInputTextobj.isEmpty(projListYearValue) == true) {
      alert("年度が未入力です");
      return false;
    } else if (checkInputTextobj.isPatternMatch(projListYearValue, pattern) == true) {
      alert("年度に半角数字以外の文字が使用されています。");
      return false;
    }
    
    if (checkInputTextobj.valueLimitCheck(projListYearValue, maxval, minval) == false) {
      window.alert("年度欄に入力された値が有効ではありません。\n " + minval + "～" + maxval + "までの値を入力してください。");
      return false;
    }

  } catch(e) {
    alert("例外発生 発生個所：yearCheck" + e);
    return false;
  }
  return true;
}


/**
 * 編集を押した際に実行される関数
 * @param obj
 * @returns
 */
function proj_Edit(obj){
  try {
    //チェックボックスの選択数をみる関数
    var checked = checkbox_changecheck();
    if (checked == false){
      return false;
    }
    //パラメータ取得の関数
    setActionParam(obj);
  } catch (e) {
    alert("例外発生" + e);
    return false;
  }
  return true;
}

/**
 * 削除を押した際に実行される関数
 * @param obj
 * @returns
 */
function proj_Del(obj){
  try {
    //チェックボックスの選択数をみる関数
    var checked = checkbox_delcheck();
    if (checked == false){
      return false;
    }
    //パラメータ取得の関数
    setActionParam(obj);
  } catch (e) {
    alert("例外発生" + e);
    return false;
  }
  return true;
}

/**
 * 再利用を押した際に実行される関数
 * @param obj
 * @returns
 */
function proj_Copy(obj){
  try {
    //チェックボックスの選択数を見る関数
    var checked = checkbox_changecheck();
    if (checked == false){
      return false;
    }
    //パラメータ取得の関数
    setActionParam(obj);
  } catch (e) {
    alert("例外発生" + e);
    return false;
  }
  return true;
}

/**
 * 表示ボタンを押した時の処理
 * @param obj
 * @returns
 */
function proj_search_year(obj){
  try{
	//入力値チェック
	var result = inputYearCheck();
	if (result == false){
	  return false;
	}
	//アクションパラメータをセットする
	setActionParam(obj);
  }catch(e){
	alert("例外発生" + e);
	return false;
  }
  return true;
}

/**
 * actionパラメータの設定を行う関数（詳細時のみactionパラメータとpidの2つを設定）
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
    var value = obj.getAttribute(PROJ_INPUT_TEXT_CONTENT.NAME);
    if (value == PROJ_INPUT_TEXT_CONTENT.P_DATAIL) {
      title = obj.getAttribute(PROJ_INPUT_TEXT_CONTENT.TITLE);
      document.getElementById(PROJ_INPUT_TEXT_CONTENT.PROJ_NUM_ID).value = title;
      document.getElementById(BUTTON_UTIL_CONSTANTS.HIDDEN_ACTION_ID).value = value;
    } else {
      document.getElementById(BUTTON_UTIL_CONSTANTS.HIDDEN_ACTION_ID).value = value;
    }
  } catch (e) {
    alert("例外発生" + e);
    return false;
  }
  return true;
}

/**
 * 検索ボタンを押した時の処理
 * @param obj
 * @returns
 */
function proj_search_action(obj){
  try{
	//actionパラメータをセットする
	var result1 = setActionParam(obj);
	//検索条件をセットする
	var result2 = setValue();
	
	if(!result1 || !result2){
		return false;
	}
	return true;
	
  }catch(e){
	alert("例外発生" + e);
	return false;
  }
}



//検索ボタンを押した時、hiddenに入力された検索条件をセットする
function setValue() {
  try {
    inputValCheck = inputYearCheck ();
    if (inputValCheck == false) {
      return false;
    } else {
      var getvalue1 = null;
      var check1 = false;
      var type1 = document.getElementById(PROJ_INPUT_TEXT_CONTENT.FIRST_SEARCH_SECTION).value;
      var getradio1 = null;
      var getradiovalue1 = null;

      var getvalue2 = null;
      var check2 = false;
      var type2 = document.getElementById(PROJ_INPUT_TEXT_CONTENT.SECOND_SEARCH_SECTION).value;
      var getradio2 = null;
      var getradiovalue2 = null;

      //検索項目がメンバーアサインでない場合
      if (type1 != PROJ_INPUT_TEXT_CONTENT.SEC_ASSIGN) {
        if (type1 != PROJ_INPUT_TEXT_CONTENT.SEC_ISSUE) {
          getvalue1 = document.getElementById(PROJ_INPUT_TEXT_CONTENT.FIRST_SEARCH_TEXT).value;
          document.getElementById(PROJ_INPUT_TEXT_CONTENT.FIRST_INPUT_WORD).value = getvalue1;
        } else {
          getvalue1 = document.getElementById(PROJ_INPUT_TEXT_CONTENT.FIRST_SEARCH_DATE).value;
          document.getElementById(PROJ_INPUT_TEXT_CONTENT.FIRST_INPUT_WORD).value = getvalue1;
        }
      } else {
        check1 = document.Mainform.assignfin1.checked;
        getradio1 = document.getElementsByName(PROJ_INPUT_TEXT_CONTENT.FIRST_RADIO_BUTTON);
        //trueの場合はアサイン済み
        if (check1 == true){
          getradiovalue1 = getradio1[0].value;
          document.getElementById(PROJ_INPUT_TEXT_CONTENT.FIRST_INPUT_WORD).value = getradiovalue1;
        } else {
          getradiovalue2 = getradio1[1].value;
          document.getElementById(PROJ_INPUT_TEXT_CONTENT.FIRST_INPUT_WORD).value = getradiovalue2;
        }
      }

      if(type2 != PROJ_INPUT_TEXT_CONTENT.SEC_ASSIGN) {
        if (type2 != PROJ_INPUT_TEXT_CONTENT.SEC_ISSUE) {
          getvalue2 = document.getElementById(PROJ_INPUT_TEXT_CONTENT.SECOND_SEARCH_TEXT).value;
          document.getElementById(PROJ_INPUT_TEXT_CONTENT.SECOND_INPUT_WORD).value = getvalue2;
        } else {
          getvalue2 = document.getElementById(PROJ_INPUT_TEXT_CONTENT.SECOND_SEARCH_DATE).value;
          document.getElementById(PROJ_INPUT_TEXT_CONTENT.SECOND_INPUT_WORD).value = getvalue2;
        }
      } else {
        check2 = document.Mainform.assignfin2.checked;
        getradio2 = document.getElementsByName(PROJ_INPUT_TEXT_CONTENT.SECOND_RADIO_BUTTON);
        //trueの場合はアサイン済み
        if (check2 == true){
          getradiovalue1 = getradio2[0].value;
          document.getElementById(PROJ_INPUT_TEXT_CONTENT.SECOND_INPUT_WORD).value = getradiovalue1;
        } else {
          getradiovalue2 = getradio2[1].value;
          document.getElementById(PROJ_INPUT_TEXT_CONTENT.SECOND_INPUT_WORD).value = getradiovalue2;
        }
      }
    }
  } catch(e) {
    alert("例外発生" + e);
    return false;
  }
  return true;
}


function changeDisInputBoxType(){
  try{
    //選択されている検索項目を入れるための変数
    var secvalue1 = document.Mainform.search_sec_1.value;
    var secvalue2 = document.Mainform.search_sec_2.value;
    	
     if (secvalue1 == PROJ_INPUT_TEXT_CONTENT.SEC_ASSIGN){ //メンバーアサインが選ばれていた場合
        document.getElementById(PROJ_INPUT_TEXT_CONTENT.SEARCH1_RADIO).style.display = "inline";
        document.getElementById(PROJ_INPUT_TEXT_CONTENT.FIRST_SEARCH_DATE).style.display = "none";
        document.getElementById(PROJ_INPUT_TEXT_CONTENT.FIRST_SEARCH_TEXT).style.display = "none";
        
      } else if (secvalue1 == PROJ_INPUT_TEXT_CONTENT.SEC_ISSUE) {//発行日が選ばれていた場合
    	document.getElementById(PROJ_INPUT_TEXT_CONTENT.SEARCH1_RADIO).style.display = "none";
        document.getElementById(PROJ_INPUT_TEXT_CONTENT.FIRST_SEARCH_DATE).style.display = "inline";
        document.getElementById(PROJ_INPUT_TEXT_CONTENT.FIRST_SEARCH_TEXT).style.display = "none";
      } else {
    	document.getElementById(PROJ_INPUT_TEXT_CONTENT.SEARCH1_RADIO).style.display = "none";
        document.getElementById(PROJ_INPUT_TEXT_CONTENT.FIRST_SEARCH_DATE).style.display = "none";
        document.getElementById(PROJ_INPUT_TEXT_CONTENT.FIRST_SEARCH_TEXT).style.display = "inline";
      }
      
      //2つ目の選択された検索項目のvalue値を取得	
      //secvalue2 = document.Mainform.search_sec_2.value;
      if (secvalue2 == PROJ_INPUT_TEXT_CONTENT.SEC_ASSIGN){
    	document.getElementById(PROJ_INPUT_TEXT_CONTENT.SEARCH2_RADIO).style.display = "inline";
        document.getElementById(PROJ_INPUT_TEXT_CONTENT.SECOND_SEARCH_DATE).style.display = "none";
        document.getElementById(PROJ_INPUT_TEXT_CONTENT.SECOND_SEARCH_TEXT).style.display = "none";
      } else if (secvalue2 == PROJ_INPUT_TEXT_CONTENT.SEC_ISSUE) {
    	document.getElementById(PROJ_INPUT_TEXT_CONTENT.SEARCH2_RADIO).style.display = "none";
        document.getElementById(PROJ_INPUT_TEXT_CONTENT.SECOND_SEARCH_DATE).style.display = "inline";
        document.getElementById(PROJ_INPUT_TEXT_CONTENT.SECOND_SEARCH_TEXT).style.display = "none";
      } else {
    	document.getElementById(PROJ_INPUT_TEXT_CONTENT.SEARCH2_RADIO).style.display = "none";
        document.getElementById(PROJ_INPUT_TEXT_CONTENT.SECOND_SEARCH_DATE).style.display = "none";
        document.getElementById(PROJ_INPUT_TEXT_CONTENT.SECOND_SEARCH_TEXT).style.display = "inline";
      }
  } catch(e) {
    alert("例外" + e);
  }
}
