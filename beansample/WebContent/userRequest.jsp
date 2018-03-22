<%@ page language="java" contentType="text/html; charset=UTF-8" %>

<%-- MVCモデル V（ビュー） --%>
<%-- ID入力画面 --%>
<!DOCTYPE html>
<html>
    <head>
        <title>Bean Sample</title>
    </head>
    <body>
        <h1>インプットフォーム</h1>
        <%-- POSTメソッドでテキストを送信 --%>
        <form action="./ControllerServlet" method="post">
            <p>IDを入力してください：<input type="text" name="id"></p>
            <p>IDはweb01またはweb02です</p>
            <input type="submit" value="リクエスト">
        </form>
    </body>
</html>