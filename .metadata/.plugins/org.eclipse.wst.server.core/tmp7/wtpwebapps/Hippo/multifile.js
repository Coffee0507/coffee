/**
 * 
 */


function MultiSelector( list_target, max ){

    // Where to write the list
    this.list_target = list_target;
    // How many elements?
    this.count = 0;
    // How many elements?
    //this.id = 0;
    //もともとあるinputが1から始まるためこちらは2から始める
    //this.id = 2;
    //2から始まるが足された時点でid+1が末尾に割り当てられるためこの時点ではidは1でよい
    this.id =1;
    // Is there a maximum?
    if( max ){
        this.max = max;
    } else {
        this.max = -1;
    };

    /**
     * Add a new file input element
     */
    this.addElement = function( element ){

        // Make sure it's a file input element
        if( element.tagName == 'INPUT' && element.type == 'file' ){

            // Element name -- what number am I?
            //element.name = 'file_' + this.id++;
            //inputタグのnameを変更
            element.name = 'p_doc_' + this.id++;

            // Add reference to this object
            element.multi_selector = this;

            // What to do when a file is selected
            element.onchange = function(){

                // New file input
                var new_element = document.createElement( 'input' );
                new_element.type = 'file';

                // Add new element
                this.parentNode.insertBefore( new_element, this );

                // Apply 'update' to element
                this.multi_selector.addElement( new_element );

                // Update list
                this.multi_selector.addListRow( this );

                // Hide this: we can't use display:none because Safari doesn't like it
                this.style.position = 'absolute';
                this.style.left = '-1000px';

            };
            // If we've reached maximum number, disable input element
            if( this.max != -1 && this.count >= this.max ){
                element.disabled = true;
            };

            // File element counter
            this.count++;
            // Most recent element
            this.current_element = element;

        } else {
            // This can only be applied to file input elements!
            alert( 'Error: not a file input element' );
        };

    };

    /**
     * Add a new row to the list of files
     */
    this.addListRow = function( element ){

        // Row div
        var new_row = document.createElement( 'div' );

        // Delete button
        var new_row_button = document.createElement( 'input' );
        new_row_button.type = 'button';
        new_row_button.value = '×';

        // References
        new_row.element = element;

        // Delete function
        new_row_button.onclick= function(){

            // Remove element from form
            this.parentNode.element.parentNode.removeChild( this.parentNode.element );

            // Remove this row from the list
            this.parentNode.parentNode.removeChild( this.parentNode );

            // Decrement counter
            this.parentNode.element.multi_selector.count--;

            // Re-enable input element (if it's disabled)
            this.parentNode.element.multi_selector.current_element.disabled = false;

            // Appease Safari
            //    without it Safari wants to reload the browser window
            //    which nixes your already queued uploads
            return false;
        };

        // Set row value

        var file_path = element.value;

        new_row.innerHTML = FilePath(file_path);

        // Add button
        new_row.appendChild(new_row_button );

        // Add it to the list
        this.list_target.appendChild( new_row );

    };

};


//ファイル名の取得
function FilePath(str){
    //ローカル用正規表現（拡張子あり）
    var pattern = /(\w+):(?:\\([^\\:\*?\"<>\|]+))*(?:\\(([^:\\\*?\"<>\|]+)\.+([^:\\\*?\"<>\|]+)$))/;
    //ネットワークドライブ正規表現（拡張子あり）
    var pattern3 = /(?:(\w+):|\\)(?:\\([^\\:\*?\"<>\|]+))*(?:\\(([^:\\\*?\"<>\|]+)\.+([^:\\\*?\"<>\|]+)$))/;


    FilePath.result = str.match(pattern);
    FilePath.result3 = str.match(pattern3);

    if(FilePath.result){

        FilePath.FullPath = FilePath.result[0];//フルパス
        FilePath.Drive = FilePath.result[1];//ドライブ
        FilePath.ParentDir = FilePath.result[2];//親のディレクトリ
        FilePath.FileName = FilePath.result[3];//ファイル名
        FilePath.FileNameShort = FilePath.result[4];//拡張子を除いたファイル名
        FilePath.FileExt = FilePath.result[5];//拡張子

        return FilePath.FileName;

    }else if(FilePath.result3){

        FilePath.FileName3 = FilePath.result3[3];//ファイル名

        return FilePath.FileName3;

    }else{
        if(str.lastIndexOf('\\') != -1){
            filename = str.substring(str.lastIndexOf('\\') +1);
        }else if(str.lastIndexOf('/') != -1){
            filename = str.substring(str.lastIndexOf('/') +1);
        }else{
            filename = str;
        }
        return filename;
    }
}