          <select id="user_id" name="user_id" class="input_box">
            <option value=""></option>
            <c:forEach items="${userList}" var="account">
              <option value="<c:out value="${account.id}"/>"
              <c:if test="${error.isError and account.id eq accountMap.user_id[0] and account.employeeNum eq userGroupList.userGroupMemberBeanList[0].employeeNum }"> selected="selected"</c:if>
              ><c:out value="${account.secondName} ${account.firstName} ${userGroupList}"/></option>
            </c:forEach>
          </select>