/**
 * @author maezawa
 */

// Added by dai
var LOGIN_CONSTANTS = {
  // ユーザー選択リストの ID 値
  'USER_ID': 'user_id'
}

// ID発番フラグ（複数タブ禁止用）
var issuedAlready = false;
var timer = null;
/**
 * 複数タブ禁止処理
 * 
 * @returns
 */
/* 注意：ブラウザのキャッシュクリアすると複数タブ禁止が効かない場合がある */
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
    // 下記のalertとopenの順番は入れ替えないこと。ブラウザによってalertが表示されなくなるため。(firefoxで確認)
    window.alert('複数タブには対応していません。タブを閉じてください。');
    window.open('about:blank', '_self');
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

/**
 * 読み込み時に実行される関数
 */
window.addEventListener("load", function() {
  try {
    display_title_set();
    if (parent.frames.length <= 0) {
      // ※複数フレームがある場合は、既に監視が開始されているので、監視の実行が不要（メッセージが２回でてしまう）
      // ここから（複数タブを禁止する）
      forbidMultiTab();
      timer = setInterval(forbidMultiTab, 250);
      // ここまで
    }
    menu_release();
  } catch (e) {
    alert("例外" + e);
  }
}, false);

/**
 * メニュー画面の解除を行う関数
 * 
 * @returns
 */
function menu_release() {
  try {
    if (parent.frames.length > 0) {
      parent.document.getElementsByTagName('frameset')[0].cols = '0,*';
    }
  } catch (e) {
    alert("例外" + e);
  }
}

/**
 * ユーザー選択ボックスのチェック
 * 
 * @param userCtrlID
 *          ユーザー選択ボックスのID
 * @returns ユーザーが選択されている場合、true その他の場合、false を返す
 */
// Added by dai
function checkUser(userCtrlID) {
  var userObj = document.getElementById(userCtrlID);
  if (null == userObj) { throw new Error("userCtrlID が無効です"); }
  var checkInputTextObj = new Checkinputtext();
  var userValue = userObj.value;
  if (false != checkInputTextObj.isEmpty(userValue)) { return false; }
  return true;
}

/**
 * ログイン処理
 * 
 * @param なし
 * @returns 正常な場合、true その他の場合、false を返す
 */
// Added by dai
function loginProc() {
  try {
    var bResultOfCheckingUser = checkUser(LOGIN_CONSTANTS.USER_ID);
    if (false == bResultOfCheckingUser) {
      alert("ユーザーが未選択です");
    }
    if (false == bResultOfCheckingUser) { return false; }
  } catch (e) {
    alert("例外発生" + e);
    return false;
  }
  return true;
}
