function test(){
document.write("1"); 
}

function textcreate() {
    var CONSTANTS = {
    'box' : document.getElementById("box"),
    'p' : document.createElement("p"),
    'text' : document.createTextNode("test"),
    }
    CONSTANTS.box.appendChild(CONSTANTS.p).appendChild(CONSTANTS.text);
}

function textdelete() {
  CONSTANTS.box.removeChild(CONSTANTS.p);
}
function textcolorchange() {
  CONSTANTS.p.style.color = "red";
}
function textchange() {
  CONSTANTS.p.textContent = "書き換えたテキストです";
}