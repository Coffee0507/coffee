function ConnectedSelect(selIdList){
  // OptionGroup事に処理を実行
  for(var i=0;selIdList[i];i++) {

    // SelectBoxのコピーを作成するためのオブジェクト
    var CS = new Object();
    // 初期遷移時のSelectBox値を取得
    var obj = document.getElementById(selIdList[i]);

    // P番詳細画面では初期戦時にselectIndexの値が0ではない為以下のロジックに入ってはいけない。
    // 以下のロジックに入ってしまうとSelectBox値を全て取得するためにIF文で条件分岐
    if(obj.selectedIndex == 0) {
      obj.ConnectedSelectDefault = obj.options[obj.selectedIndex].value; //追加
    }

    // 2回目以降のループで処理を実行
    if(i){
      CS.node=document.createElement('select');
      var GR = obj.getElementsByTagName('optgroup');

      while(GR[0]) {
        CS.node.appendChild(GR[0].cloneNode(true));
        obj.removeChild(GR[0]);
      }
      obj.disabled = true;
    }

    // １回目のループで最初に処理を実行
    if(selIdList[i+1]) {
      // 次のOptionGroupのOptionを取得
      CS.nextSelect = document.getElementById(selIdList[i+1]);
      // 値を変更する度にOptionの中身書き換える。
      obj.onchange = function(){ConnectedSelectEnabledSelect(this)};
    } else {
      CS.nextSelect = false;
    }
    obj.ConnectedSelect = CS;
  }
}

function ConnectedSelectEnabledSelect(oSel){
  var oVal = oSel.options[oSel.selectedIndex].value;
  console.log(oSel.options[oSel.selectedIndex].value);
  if(oVal) {
    while(oSel.ConnectedSelect.nextSelect.options[1])oSel.ConnectedSelect.nextSelect.remove(1);
    var eF = false;
    for(var OG=oSel.ConnectedSelect.nextSelect.ConnectedSelect.node.firstChild;OG;OG=OG.nextSibling) {
      if(OG.label == oVal) {
        eF = true;
        for(var OP=OG.firstChild;OP;OP=OP.nextSibling)
          oSel.ConnectedSelect.nextSelect.appendChild(OP.cloneNode(true));
        break;
      }
    }
    oSel.ConnectedSelect.nextSelect.disabled = !eF;
  } else {
    oSel.ConnectedSelect.nextSelect.selectedIndex = 0;
    oSel.ConnectedSelect.nextSelect.disabled = true;
  }
  if(oSel.ConnectedSelect.nextSelect.onchange)oSel.ConnectedSelect.nextSelect.onchange();
}

// デフォルト用追加
function ConnectedSelectDefault(selIdList){
  for(var i=0;selIdList[i];i++) {
    var obj = document.getElementById(selIdList[i]);
    if(i){
      //var obj = document.getElementById(selIdList[i]);
      obj.disabled = true;
      // 1階層上のオブジェクト
      var oSel = document.getElementById(selIdList[i-1])
      // １階層上で記憶されているデフォルトオブジェクト
      var oVal = oSel.ConnectedSelectDefault;
      for(var OG=obj.ConnectedSelect.node.firstChild;OG;OG=OG.nextSibling) {
        if(OG.label != oVal) { continue; }
        for(var OP=OG.firstChild;OP;OP=OP.nextSibling) {
          obj.appendChild(OP.cloneNode(true));
        }
        obj.disabled = false;
        break;
      }
    }

    var DVal = obj.ConnectedSelectDefault;
    for(var j=0; j<obj.options.length; j++ ){
      if ( obj.options[j].value == DVal ) {
        obj.selectedIndex = j;
        break;
      }
    }
  }
}

function backSelectedValue(selIdList) {
	  for(var i=0;selIdList[i];i++) {
		    var obj = document.getElementById(selIdList[i]);
		    if(i){
		      // 1階層上のオブジェクト
		      var oSel = document.getElementById(selIdList[i])
		      // １階層上で記憶されているデフォルトオブジェクト
		      var oVal = oSel.ConnectedSelectDefault;
		      for(var OG=obj.ConnectedSelect.node.firstChild;OG;OG=OG.nextSibling) {
		        if(OG.label != oVal) { continue; }
		        for(var OP=OG.firstChild;OP;OP=OP.nextSibling) {
		          obj.appendChild(OP.cloneNode(true));
		        }
		        break;
		      }
		    }

		    var DVal = obj.ConnectedSelectDefault;
		    for(var j=0; j<obj.options.length; j++ ){
		      if ( obj.options[j].value == DVal ) {
		        obj.selectedIndex = j;
		        break;
		      }
		    }
		  }
}