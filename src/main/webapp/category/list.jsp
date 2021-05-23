<%@ page import="java.util.ArrayList" %>
<%@ page import="entity.Category" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<% ArrayList<Category> categories = (ArrayList<Category>) request.getAttribute("categories"); %>
<% int currentPage = (int) request.getAttribute("currentPage"); %>
<% int totalPages = (int) request.getAttribute("totalPages"); %>
<%@ taglib prefix="mt" tagdir="/WEB-INF/tags" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<c:set var="bodyContent">
    <!-- Nội dung cần thêm -->
    <div class="d-sm-flex align-items-center justify-content-between mb-4">
        <h1 class="h3 mb-0 text-gray-800">List Category</h1>
    </div>
    <hr>
    <h4 class="text-center"><a href="/category/create">Create new</a></h4>
    <table class="table">
        <thead class="table-info">
        <tr  class="text-center">
            <th scope="col">Mã danh mục</th>
            <th scope="col">Tên danh mục</th>
            <th scope="col">Ngày tạo</th>
            <th scope="col">Ngày sửa thông tin</th>
            <th scope="col">Trạng thái</th>
            <th scope="col">Thao tác</th>
        </tr>
        </thead>
        <tbody>
        <% if (categories != null && categories.size() > 0) {
            for (int i = 0; i < categories.size(); i++) {
        %>
        <tr>
            <td scope="col" style="text-align: center"><%=categories.get(i).getId()%>
            </td>
            <td scope="col" style="text-align: center"><%=categories.get(i).getName()%>
            </td>
            <td scope="col" style="text-align: center"><%=categories.get(i).getCreatedAt()%>
            </td>
            <td scope="col" style="text-align: center"><%=categories.get(i).getUpdatedAt()%>
            </td>
            <td scope="col" style="text-align: center"><%=categories.get(i).toStatus(categories.get(i).getStatus())%>
            </td>
            <td scope="col" style="text-align: center">
                <div class="btn-group">
                    <a href="/category/detail?id=<%=categories.get(i).getId()%>" class="btn btn-primary">Xem</a>
                </div>
            </td>
        </tr>
        <%
                }
            }
        %>
        </tbody>
    </table>
    <% if (totalPages > 1) { %>
    <nav aria-label="Page navigation example">
        <ul class="pagination" style="align-content: center">
            <li class="page-item <%= currentPage <= 1 ? "disabled" : ""%>"><a class="page-link" href="list?pages=<%=currentPage - 1%>">Previous</a></li>
            <% for (int i = 1; i < totalPages + 1; i++) { %>
            <li class="page-item <%=  i == currentPage ? "active" : "" %>">
                <a class="page-link" href="list?pages=<%=i%>"> <%=i%>  <%=  i == currentPage ? "<span class=\"sr-only\">(current)</span>" : "" %></a>
            </li>
            <% } %>
            <li class="page-item <%= currentPage >= totalPages ? "disabled" : ""%>"><a class="page-link" href="list?pages=<%=currentPage + 1%>">Next</a></li>
        </ul>
    </nav>
    <% } %>

</c:set>

<mt:layoutAdmin title="List Category">
    <jsp:body>
        ${bodyContent}
    </jsp:body>
</mt:layoutAdmin>

