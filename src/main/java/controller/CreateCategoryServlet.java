package controller;

import entity.Category;
import service.CategoryService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "CreateCategory", urlPatterns = "/category/create")
public class CreateCategoryServlet extends HttpServlet {
    private CategoryService categoryService = new CategoryService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setAttribute("status", "");
        req.getRequestDispatcher("/category/create.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        Category category = new Category();
        category.setName(req.getParameter("name"));
        boolean result = categoryService.create(category);
        if (!result) {
            req.setAttribute("status", "Không để trống tên category");
            req.getRequestDispatcher("/category/create.jsp").forward(req, resp);
            return;
        }
        resp.sendRedirect("/category/list");
    }
}
