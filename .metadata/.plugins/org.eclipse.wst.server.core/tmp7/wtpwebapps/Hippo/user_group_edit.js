/**
 * @fileOverview ユーザーグループ追加・編集に使用する関数を記述するファイルです。
 * @author インターノウス
 * @version 1.0
 */

var INPUT_TEXT_CONSTANTS = {
  // ユーザーグループ名を入力するテキストボックスのid値
  'USER_GROUP_ID': 'user_group_name',
  //送信するメンバーが表示されているセレクトボックスのid値
  'GROUP_MEMBER_LIST_ID':'selected_user_group_member_id'
}

/**
 * 追加・編集時に実行される関数
 * @return {Boolean} グループ名に値が入力されている場合にtrueを返す、未入力の場合はfalseを返す
 */
function check() {
  // グループ名の入力チェック
  var groupNameChecked = user_group_name_check(INPUT_TEXT_CONSTANTS.USER_GROUP_ID);
  if (groupNameChecked == false) {
      return false;
  }
  // メンバーの右側のリスト内を選択済みにする
  selectAll(INPUT_TEXT_CONSTANTS.GROUP_MEMBER_LIST_ID);

  return true;
}

/**
 * グループ名のチェックを行う関数
 *
 * @param user_group_name
 * @returns
 */
function user_group_name_check(user_group_name) {
      try {
        // 入力チェック
        var checkInputTextobj = new Checkinputtext();
        var groupName = document.getElementById(user_group_name);
        var groupNameValue = groupName.value;

        if (checkInputTextobj.isEmpty(groupNameValue) == true) {
          alert("グループ名が未入力です");
          return false;
        }
      } catch (e) {
        alert("例外発生 発生個所:user_group_name_check" + e);
        return false;
      }
      return true;
    }

/**
 * メンバーの処理(矢印ボタンをクリックしたときの)
 */
$(document).ready(function() {
  $('input[name=right]').on('click', function() {
      moveToRight('selected_user_group_member_all', 'selected_user_group_member');
  });

  $('input[name=left]').on('click', function() {
      moveToLeft('selected_user_group_member', 'selected_user_group_member_all');
  });

  var moveToRight = function(_this, target) {
      var rightObj = $("#selected_user_group_member_id").children(); //右側のボックスのオブジェクトを取得(全要素を取得するため)

      if(rightObj.length == null || rightObj.length == 0){//右側のボックスが空のとき
          $('select[name=' + target + ']').append($("#selected_user_group_member_all_id option:selected").clone());//右側のボックスに要素追加

      }else{
          $('select[name=' + _this + '] option:selected').each(function() {//選択された要素を一つずつ取得
              var leftVal = $(this).val();//選択された要素のvalue
              var isSame = false;//識別フラグ
              for(var i=0; i<rightObj.length; i++){//右側のボックスの要素を一つずつ取得
                  var rightVal = rightObj.eq(i).val()//valueを取得
                  if(leftVal == rightVal){
                      isSame = true;
                      break;
                  }
              }
              if(isSame == false){
                  $('select[name=' + target + ']').append($(this).clone());//右側のボックスに要素追加
              }
          });
      }
  };

  var moveToLeft = function(_this, target) {
      $('select[name=' + _this + '] option:selected').each(function() {
          $(this).remove();
      });
  };
});

window.addEventListener("load", function() {
  try {
    display_title_set();
  } catch (e) {
    alert("例外発生" + e);
  }
}, false);
