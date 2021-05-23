<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="mt" tagdir="/WEB-INF/tags" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%
    String status = (String) request.getAttribute("status");
%>
<c:set var="bodyContent">
    <div style="width: 80vw; margin: 0 auto">
        <h1 class="h3 mb-0 text-gray-800">Create Category</h1>
        <p class="text-danger"><%=status%></p>
        <form method="post" action="/category/create">
            <div class="form-group">
                <label for="name">Tên Danh mục </label>
                <input type="text" class="form-control" id="name" placeholder="Nhập tên danh mục" name="name">
            </div>
            <button type="submit" class="btn btn-primary">Tạo Danh mục</button>
        </form>
    </div>
</c:set>
<mt:layoutAdmin title="Create Category">
    <jsp:body>
        ${bodyContent}
    </jsp:body>
</mt:layoutAdmin>

