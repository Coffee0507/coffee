/**
 *
 */

  /**
   * 複数タブ禁止処理
   *
   * @returns
   */
//session storage用ID発番フラグ（複数タブ禁止用）
  var issuedAlready = false;
  var timer = null;

  function forbidMultiTab() {
    var TAB_ID = "tabID";
    var sesTabID = sessionStorage.getItem(TAB_ID);
    var lclTabID = localStorage.getItem(TAB_ID);

    var newAction = function() {
      var tabID = new Date().getTime();
      sessionStorage.setItem(TAB_ID, tabID);
      localStorage.setItem(TAB_ID, tabID);
      issuedAlready = true;
    };
    var currentAction = function() {
    };
    var oldAction = function() {
  	  clearInterval(timer);
  	  //下記のalertとopenの順番は入れ替えないこと。ブラウザによってalertが表示されなくなるため。(firefoxで確認)
      window.alert('複数タブには対応していません。タブを閉じてください。');
  	  window.open('about:blank', '_parent');
  	  sessionStorage.clear();
    };

    // sessionStorageにタブIDが保存されていないとき
    // もしくはIE8対応として、「新しいタブで開く」から開くと、sessionStorageの値がコピーされているので、発番フラグが立っていないとき
    if (sesTabID == null || (sesTabID == lclTabID && !issuedAlready)) {
  	  newAction();
      // sessionStorageの値とlocalStorageの値が等しいとき
    } else if (sesTabID == lclTabID) {
      currentAction();
    } else {
      oldAction();
    }
  }

window.addEventListener("load",function(){
    //アカウントの権限を入れてメニュー画面の表示切替を行う

  var useraut = document.getElementById("useraut").value;

    if(useraut == "Administrator"){
      document.getElementById("S0").style.display = "";
      document.getElementById("SS0").style.display = "none";
      document.getElementById("S1").style.display = "";
      document.getElementById("SS1").style.display = "none";
      // 追加：インターノウス
      // ここから
      document.getElementById("purchase_import_area").style.display = "none";
      // ここまで
      document.getElementById("S2").style.display = "";
      document.getElementById("S3").style.display = "";
      document.getElementById("S4").style.display = "";
      document.getElementById("S5").style.display = "";
      document.getElementById("S6").style.display = "";
      document.getElementById("S7").style.display = "";
      document.getElementById("S8").style.display = "";
      document.getElementById("S9").style.display = "";
      document.getElementById("S10").style.display = "";
      document.getElementById("SS10").style.display = "none";
      // 追加：インターノウス
      // ここから
      document.getElementById("user_group_area").style.display = "";
      // ここまで
      document.getElementById("S11").style.display = "";
      document.getElementById("S12").style.display = "";
      document.getElementById("S13").style.display = "";


    }else if(useraut == "Poweruser"){

      document.getElementById("S0").style.display = "";
      document.getElementById("SS0").style.display = "none";
      document.getElementById("S1").style.display = "none";
      document.getElementById("SS1").style.display = "";
      // 追加：インターノウス
      // ここから
      document.getElementById("purchase_import_area").style.display = "";
      // ここまで
      document.getElementById("S2").style.display = "";
      document.getElementById("S3").style.display = "";
      document.getElementById("S4").style.display = "";
      document.getElementById("S5").style.display = "";
      document.getElementById("S6").style.display = "";
      document.getElementById("S7").style.display = "none";
      document.getElementById("S8").style.display = "none";
      document.getElementById("S9").style.display = "none";
      document.getElementById("S10").style.display = "";
      document.getElementById("SS10").style.display = "none";
      // 追加：インターノウス
      // ここから
      document.getElementById("user_group_area").style.display = "";
      // ここまで
      document.getElementById("S11").style.display = "none";
      document.getElementById("S12").style.display = "";
      document.getElementById("S13").style.display = "";


    }else if(useraut == "User"){

      document.getElementById("S0").style.display = "none";
      document.getElementById("SS0").style.display = "";
      document.getElementById("S1").style.display = "none";
      document.getElementById("SS1").style.display = "";
      // 追加：インターノウス
      // ここから
      document.getElementById("purchase_import_area").style.display = "none";
      // ここまで
      document.getElementById("S2").style.display = "none";
      document.getElementById("S3").style.display = "none";
      document.getElementById("S4").style.display = "none";
      document.getElementById("S5").style.display = "none";
      document.getElementById("S6").style.display = "none";
      document.getElementById("S7").style.display = "none";
      document.getElementById("S8").style.display = "none";
      document.getElementById("S9").style.display = "none";
      document.getElementById("S10").style.display = "none";
      document.getElementById("SS10").style.display = "";
      // 追加：インターノウス
      // ここから
      document.getElementById("user_group_area").style.display = "none";
      // ここまで
      document.getElementById("S11").style.display = "none";
      document.getElementById("S12").style.display = "";
      document.getElementById("S13").style.display = "none";

    }

    // ここから（複数タブを禁止する）
    forbidMultiTab();
    timer = setInterval(forbidMultiTab, 250);
    // ここまで
},false);

function clearFrame() {
 top.location.href = "login.jsp";
}
