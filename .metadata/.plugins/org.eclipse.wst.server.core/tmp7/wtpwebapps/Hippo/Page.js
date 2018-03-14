


var PAGE_CONTENT = {
  //actionパラメータをセットするhidden要素のclass名※1つのjspに対して1つのタグにのみ使用可
  'HIDDEN_ACTION_PARAM':'hidden_action_param',
  //actionパラメータのvalueがセットされている属性
  'NAME':'name',
  //offsetがセットされている属性
  'TITLE':'title',
  //offsetをセットするhiddenタグのid
  'HIDDEN_OFFSET':'hidden_offset'
};

/**
 * ページ遷移時に使用する関数
 * @param obj
 * @returns
 */
function page_action(obj){
	//actionパラメータをhiddenタグにセットする
	var resultOfPageAction = set_pageAction_to_hidden(obj);
	//offsetをhiddenタグにセットする
	var resultOfOffset = set_offset_to_hidden(obj);
	
	if(!resultOfPageAction || !resultOfOffset){
		return false;
	}
	return true;
}

/**
 * actionをhiddenタグにセットする関数
 * @param obj
 * @returns
 */
function set_pageAction_to_hidden(obj){
	try {
	    //引数チェック
	    if (obj == undefined || obj == null) {
	      throw new Error("Page.js/set_pageAction_to_hidden():argument");
	    }
	    //actionパラメータのvalueを取得
	    var actionVal = obj.getAttribute(PAGE_CONTENT.NAME);
	    
	    //actionパラメータをセットするhidden要素を取得(class="hidden_action_param"のもの)
	    var hiddenObj = document.getElementsByClassName(PAGE_CONTENT.HIDDEN_ACTION_PARAM);
	    if(hiddenObj.length != 1){//取得した要素数が1以外のとき...class="hidden_action_param"は1つのタグにのみ使用しているのが前提となっているため
	    	throw new Error("Page.js/set_pageAction_to_hidden():length");
	    }
	    //hiddenObjのvalueにactionパラメータをセットする
	    hiddenObj[0].value = actionVal;
	  
	} catch (e) {
	    alert("例外発生" + e);
	    return false;
	}
	
	return true;
}

/**
 * offsetをhiddenタグにセットする関数
 * @param obj
 * @returns
 */
function set_offset_to_hidden(obj){
	try{
		//引数チェック
	    if (obj == undefined || obj == null) {
	      throw new Error("Page.js/set_offset_to_hidden():argument");
	    }
	    //offsetを取得
	    var offset = obj.getAttribute(PAGE_CONTENT.TITLE);
	    //offsetをhiddenタグのvalueにセットする
	    document.getElementById(PAGE_CONTENT.HIDDEN_OFFSET).value = offset;
	}catch(e){
		alert("例外発生" + e);
		return false;
	}
	return true;
}
