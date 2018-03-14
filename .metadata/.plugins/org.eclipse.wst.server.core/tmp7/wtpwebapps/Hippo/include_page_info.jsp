<%@ page session="false" %>
<%@ page contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%--左側の矢印の処理開始 --%>
<c:choose>
	<%--offsetが0より大きい場合に左矢印を表示させる --%>
	<c:when test="${page.offset > 0}">
		<a name=${param.back_action} href="javascript:document.Mainform.submit()" title="${page.offset - page.limit}" onClick="return page_action(this)">←</a>
   </c:when>
</c:choose>
 
<%--件数表示処理　開始 --%>
${page.total}件<c:if test="${page.total > 0}">中 ${page.offset + 1}～<%--if文の前で改行するとEdgeでの表示が崩れる --%>
                 <c:choose>
                   <c:when test="${page.offset + page.limit <= page.total}">
                     ${page.offset + page.limit}件
                   </c:when>
                   <c:otherwise>${page.total}件</c:otherwise>
                 </c:choose>
               </c:if>

<%--右矢印の表示処理　開始 --%>
<c:if test="${(page.offset + page.limit) < page.total}">
  <a name=${param.forward_action} href="javascript:document.Mainform.submit()" title="${page.offset + page.limit}" onClick="return page_action(this)">→</a>
</c:if>

<%--offsetをセットするhiddenタグ --%>
<input type="hidden" name="offset" id="hidden_offset" value="">