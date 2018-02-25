<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="s" uri="/struts-tags"%>

<!DOCTYPE html>
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<meta http-equiv="Content-Style-Type" content="text/css" />
	<meta http-equiv="Content-Script-Type" content="text/javascript" />
	<meta http-equiv="imagetoolbar" content="no" />
	<meta name="description" content="" />
	<meta name="keywords" content="" />
	<meta charset="utf-8">
	<title>MyPage画面</title>

	<style type="text/css">
<%--↑ここまではインターノウスの教材の文脈をそのままコピペしています。↑ --%>


	</style>
</head>
<body>

<%--↓マイページ画面で最低限必要な文脈を記入しています。各機能担当者のクラス名が変更になる場合は都度修正が必要です。↓ --%>

	<h3>マイページ画面</h3>
	<div>
		<s:form action="BuyItemHistoryAction">
			<s:submit value="購入履歴"/>
		</s:form>
	</div>

	<div>
		<s:form action="FavoriteAction">
			<s:submit value="お気に入りリスト"/>
		</s:form>
	</div>

	<div>
		<s:form action="UserInfoChangeAction">
			<s:submit value="ユーザー情報変更"/>
		</s:form>
	</div>


</body>
</html>