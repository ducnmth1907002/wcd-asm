<%@ page import="java.util.ArrayList" %>
<%@ page import="entity.Food" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="entity.Category" %>
<%@ page import="java.util.List" %>
<%@ page import="helper.ConvertHelper" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="mt" tagdir="/WEB-INF/tags" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix = "fmt" uri = "http://java.sun.com/jsp/jstl/fmt" %>

<%
    ArrayList<Food> foods = (ArrayList<Food>) request.getAttribute("foods");
    List<Category> categories = (ArrayList<Category>) request.getAttribute("categories");
    String linkImage = "https://res.cloudinary.com/ducnguyen3156/image/upload/w_100,c_scale/";
%>
<% int currentPage = (int) request.getAttribute("currentPage"); %>
<% int totalPages = (int) request.getAttribute("totalPages"); %>

<c:set var="bodyContent">
    <!-- Nội dung cần thêm -->
    <div class="d-sm-flex align-items-center justify-content-between mb-4">
        <h1 class="h3 mb-0 text-gray-800">List Food</h1>
    </div>
    <hr>
    <h4 class="text-center"><a href="/food/create">Create new</a></h4>
    <table class="table">
        <thead class="table-info">
        <tr  class="text-center">
            <th scope="col">Mã món ăn</th>
            <th scope="col">Tên món ăn</th>
            <th scope="col">Danh mục món ăn</th>
            <th scope="col">Mô tả</th>
            <th scope="col">Ảnh sản phẩm</th>
            <th scope="col">Giá</th>
            <th scope="col">Ngày bắt đầu bán</th>
            <th scope="col">Ngày sửa thông tin</th>
            <th scope="col">Trạng thái</th>
            <th scope="col">Thao tác</th>
        </tr>
        </thead>
        <tbody>
        <% if (foods != null && foods.size() > 0) {
            for (int i = 0; i < foods.size(); i++) {
        %>
        <tr>
            <td scope="col" style="text-align: center"><%=foods.get(i).getId()%>
            </td>
            <td scope="col" style="text-align: center"><%=foods.get(i).getName()%>
            </td>
            <td scope="col" style="text-align: center">
                <%for (Category category : categories) {
                    if (foods.get(i).getCategoryId() == category.getId()){%>
                <%=category.getName()%>
                <%}
                }%>
            </td>
            <td scope="col" style="text-align: center"><%=foods.get(i).getDescription()%>
            </td>
            <td scope="col" style="text-align: center">
                <div style="width: 100px; height: 100px; background-repeat: no-repeat; background-position: center; background-size: cover; background-image:
                        url('<%=linkImage + foods.get(i).getThumbnail() + ".jpg"%>')"></div>
            </td>
            <c:set var = "balance" value = "<%=foods.get(i).getPrice()%>" />
            <td scope="col" style="text-align: center">
                <fmt:formatNumber type = "number" maxFractionDigits = "3" value = "${balance}" />VNĐ
            </td>
            <td scope="col"
                style="text-align: center"><%=foods.get(i).getSaleStartDate()%>
            </td>
            <td scope="col"
                style="text-align: center"><%=foods.get(i).getUpdatedAt()%>
            </td>
            <td scope="col" style="text-align: center"><%=foods.get(i).toStatus(foods.get(i).getStatus())%>
            </td>
            <td scope="col" style="text-align: center">
                <div class="btn-group">
                    <a href="/food/detail?id=<%=foods.get(i).getId()%>" class="btn btn-primary">Xem</a>
                    <a href="/food/edit?id=<%=foods.get(i).getId()%>" class="btn btn-success">Sửa</a>
                    <a href="/food/delete?id=<%=foods.get(i).getId()%>" class="btn btn-danger">Xóa</a>
                </div>
            </td>
        </tr>
        <%
                }
            }%>
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

<mt:layoutAdmin title="List Food">
    <jsp:body>
        ${bodyContent}
    </jsp:body>
</mt:layoutAdmin>