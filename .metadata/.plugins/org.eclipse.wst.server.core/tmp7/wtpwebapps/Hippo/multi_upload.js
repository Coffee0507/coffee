/**
 * 
 */

//javascriptの読み込み場所に注意
  var multi_selector = new MultiSelector( document.getElementById(PROJ_EDIT_CONTENT.PROJ_ADD_UPLOAD_FILE_DIV_ID), PROJ_EDIT_CONTENT.FILE_MAX_LIMIT );
  multi_selector.addElement( document.getElementById(PROJ_EDIT_CONTENT.ADD_FILE_INPUT_ID) );