/**
 * 管理職会議用のjsファイル
 */

var INPUT_MEETING_GOAL_CONTENT = {
	//formタグのid
	'MEETING_GOAL_FORM_ID': 'Mainform',
    //Q1の売上目標値を入力するテキストボックスのname値
    'Q1_SALES':'q1_sales_goal_id',
    'Q2_SALES':'q2_sales_goal_id',
    'Q3_SALES':'q3_sales_goal_id',
    'Q4_SALES':'q4_sales_goal_id',
    'BEFORE_ORDER':'before_order_goal_id',
    'Q1_ORDER':'q1_order_goal_id',
    'Q2_ORDER':'q2_order_goal_id',
    'Q3_ORDER':'q3_order_goal_id',
    'Q4_ORDER':'q4_order_goal_id',
    
    'PLACE_SALES':'売上目標',
    'PLACE_ORDER':'受注目標',
    'PLACE_BEFORE':'前期注残',
    'PLACE_Q1':'Q1',
    'PLACE_Q2':'Q2',
    'PLACE_Q3':'Q3',
    'PLACE_Q4':'Q4',
}

function meeting_goal_add () {
  try {
    var q1_sales_checked = goal_check(INPUT_MEETING_GOAL_CONTENT.Q1_SALES, AMOUNT_AND_TARGET_LIMIT.MAX_LIMIT_VAL, AMOUNT_AND_TARGET_LIMIT.MIN_LIMIT_VAL, INPUT_PATTERN.NUMBER_ONLY, INPUT_MEETING_GOAL_CONTENT.PLACE_Q1, INPUT_MEETING_GOAL_CONTENT.PLACE_SALES);
    var q2_sales_checked = goal_check(INPUT_MEETING_GOAL_CONTENT.Q2_SALES, AMOUNT_AND_TARGET_LIMIT.MAX_LIMIT_VAL, AMOUNT_AND_TARGET_LIMIT.MIN_LIMIT_VAL, INPUT_PATTERN.NUMBER_ONLY, INPUT_MEETING_GOAL_CONTENT.PLACE_Q2, INPUT_MEETING_GOAL_CONTENT.PLACE_SALES);
    var q3_sales_checked = goal_check(INPUT_MEETING_GOAL_CONTENT.Q3_SALES, AMOUNT_AND_TARGET_LIMIT.MAX_LIMIT_VAL, AMOUNT_AND_TARGET_LIMIT.MIN_LIMIT_VAL, INPUT_PATTERN.NUMBER_ONLY, INPUT_MEETING_GOAL_CONTENT.PLACE_Q3, INPUT_MEETING_GOAL_CONTENT.PLACE_SALES);
    var q4_sales_checked = goal_check(INPUT_MEETING_GOAL_CONTENT.Q4_SALES, AMOUNT_AND_TARGET_LIMIT.MAX_LIMIT_VAL, AMOUNT_AND_TARGET_LIMIT.MIN_LIMIT_VAL, INPUT_PATTERN.NUMBER_ONLY, INPUT_MEETING_GOAL_CONTENT.PLACE_Q4, INPUT_MEETING_GOAL_CONTENT.PLACE_SALES);
    
    var before_order_checked = goal_check(INPUT_MEETING_GOAL_CONTENT.BEFORE_ORDER, AMOUNT_AND_TARGET_LIMIT.MAX_LIMIT_VAL, AMOUNT_AND_TARGET_LIMIT.MIN_LIMIT_VAL, INPUT_PATTERN.NUMBER_ONLY, INPUT_MEETING_GOAL_CONTENT.PLACE_BEFORE, INPUT_MEETING_GOAL_CONTENT.PLACE_ORDER);
    var q1_order_checked = goal_check(INPUT_MEETING_GOAL_CONTENT.Q1_ORDER, AMOUNT_AND_TARGET_LIMIT.MAX_LIMIT_VAL, AMOUNT_AND_TARGET_LIMIT.MIN_LIMIT_VAL, INPUT_PATTERN.NUMBER_ONLY, INPUT_MEETING_GOAL_CONTENT.PLACE_Q1, INPUT_MEETING_GOAL_CONTENT.PLACE_ORDER);
    var q2_order_checked = goal_check(INPUT_MEETING_GOAL_CONTENT.Q2_ORDER, AMOUNT_AND_TARGET_LIMIT.MAX_LIMIT_VAL, AMOUNT_AND_TARGET_LIMIT.MIN_LIMIT_VAL, INPUT_PATTERN.NUMBER_ONLY, INPUT_MEETING_GOAL_CONTENT.PLACE_Q2, INPUT_MEETING_GOAL_CONTENT.PLACE_ORDER);
    var q3_order_checked = goal_check(INPUT_MEETING_GOAL_CONTENT.Q3_ORDER, AMOUNT_AND_TARGET_LIMIT.MAX_LIMIT_VAL, AMOUNT_AND_TARGET_LIMIT.MIN_LIMIT_VAL, INPUT_PATTERN.NUMBER_ONLY, INPUT_MEETING_GOAL_CONTENT.PLACE_Q3, INPUT_MEETING_GOAL_CONTENT.PLACE_ORDER);
    var q4_order_checked = goal_check(INPUT_MEETING_GOAL_CONTENT.Q4_ORDER, AMOUNT_AND_TARGET_LIMIT.MAX_LIMIT_VAL, AMOUNT_AND_TARGET_LIMIT.MIN_LIMIT_VAL, INPUT_PATTERN.NUMBER_ONLY, INPUT_MEETING_GOAL_CONTENT.PLACE_Q4, INPUT_MEETING_GOAL_CONTENT.PLACE_ORDER);
    
    //上の確認結果を判定する処理を入れる
    if (q1_sales_checked == false || q2_sales_checked == false || q3_sales_checked == false || q4_sales_checked == false ||
        before_order_checked == false || q1_order_checked == false || q2_order_checked == false || q3_order_checked == false || q4_order_checked == false) {
      return false;
    }
    
  } catch(e) {
    alert("例外発生" + e);
    return false;
  }
  return true;
}



function goal_check (partid, maxval, minval, pattern, row, column){
  try{
    //値が渡されているかの確認
    var ObjUtilobj = new ObjUtil();
    if (ObjUtilobj.valueNullUndefinedCheck(partid) == false || partid == "") {
      throw new Error("内容:partidの値が無い");
    }
    if (ObjUtilobj.valueNullUndefinedCheck(maxval) == false || maxval == "") {
      throw new Error("内容:maxvalの値が無い");
    }
    if (ObjUtilobj.valueNullUndefinedCheck(minval) == false || minval == "") {
      throw new Error("内容:minvalの値が無い");
    }
    if (ObjUtilobj.valueNullUndefinedCheck(pattern) == false || pattern == "") {
      throw new Error("内容:patternの値が無い");
    }
    
    var place = null;
    
    if (row == INPUT_MEETING_GOAL_CONTENT.PLACE_BEFORE) {
      place = (row);
    } else {
      place = (row + "の" + column);
    }
    
    //idから入力内容の取得
    var checkTargetValue = document.getElementById(partid).value;
    //入力内容の確認
    var checkInputTextobj = new Checkinputtext();
    if (checkInputTextobj.isEmpty(checkTargetValue) == true) {
      alert(place + "が未入力です");
      return false;
    } else if (checkInputTextobj.isPatternMatch(checkTargetValue, pattern) == true) {
      alert(place + "に半角数字以外の文字が入っています。");
      return false;
    }
    //上限値・下限値の確認
    if (checkInputTextobj.valueLimitCheck(checkTargetValue, maxval, minval) == false) {
      window.alert(place + "に入力された値が有効ではありません。\n " + minval + "～" + maxval + "までの値を入力してください。");
      return false;
    }
    
  } catch(e) {
    alert("例外発生" + e);
    return false;
  }
  return true;
}

window.addEventListener("load",function(){
  try {
    display_title_set();
    //attachOnKeyPressToText(INPUT_MEETING_GOAL_CONTENT.MEETING_GOAL_FORM_ID);
  } catch (e) {
    alert("例外発生"+ e);
  }
},false);