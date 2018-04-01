var xmlHttp;

xmlHttp = new XMLHttpRequest();
xmlHttp.open("GET","https://www.ajaxtower.jp/sample/plan.txt",false);
xmlHttp.send(null);

alert(xmlHttp.responseText);