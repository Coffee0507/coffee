<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
<meta http-equiv="Content-Style-Type" content="text/css" />

<title>購入履歴</title>

	<div>
		<s:if test="purchaseHistoryList == null">
			<h2>購入履歴はありません。</h2>
		</s:if>
		<s:elseif test ="message == null">
			<caption>購入情報は以下になります。</caption>
		</s:elseif>
	</div>
<div class="purchaseHistoryList">
	<h1>新着商品一覧</h1>




	<s:iterator value="purchaseHistoryList">
		<div id="purchaseHistoryList">
		<a href="<s:url action="PurchaseHistoryAction"></s:url>">
			商品名:<s:property value="product_Name" />
			ふりがな:<s:property value="product_Name_Nana" />
			値段:<s:property value="price" />
			個数:<s:property value="count" />
			発売会社名:<s:property value="release_Company" />
			発売年月日:<s:property value="release_Date" />

			<img class="image" src="<s:property value='image_File_Path'/>" >
			<input type="hidden" value="<s:property value='product_id'/>" name="product_id"/>

		</a>
		</div>
	</s:iterator>
</div>


</head>
<body>

</body>
</html>