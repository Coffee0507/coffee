<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>

<script>

 function myCheck(){
    var flag = false;


    for(var i=0; i<document.form1.fruits.length-1;i++){


        if(document.form1.fruits[i].checked){
            flag = true;
            alert(document.form1.fruits[i].value + "が選択されました。");
        }
    }


    if(!flag){
        alert("項目が選択されていません。");
    }
}


</script>












</head>
<body>
	★お気に入りリスト★
	<p>
		<s:form id="form" name="form" action="FavoriteAction">
			<table border="0" cellspacing="0">
				<thead id="hoge-head">
					<tr>
						<td>チェック</td>
						<td>商品名</td>
						<td>画像</td>
						<td>値段</td>
						<td>会社</td>
						<td>販売月</td>
					</tr>
				</thead>

				<s:iterator value="favoriteList">
					<tr>
						<td><s:checkbox name="checkList" value="1" fieldValue="%{product_id}" /></td>
						<td><span><s:property value="productName" /></span></td>
						<td><span><s:property value="imageFilePath" /></span></td>
						<td><span><s:property value="price" /></span></td>
						<td><span><s:property value="releaseCompany" /></span></td>
						<td><span><s:property value="releaseDate" /></span></td>
					</tr>

				</s:iterator>
				<tr>

						<td>
						<s:submit value="一括削除" >
						<input type="hidden" name="deleteFlg" value="1"/>
						</s:submit>
						</td>
					</tr>

			</table>
		</s:form>

		<div>
		<a href='<s:url action="StartAction" />'>Home画面に戻る</a>
		</div>
</body>
</html>