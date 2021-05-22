package controller;

import entity.Category;
import entity.Food;
import service.CategoryService;
import service.FoodService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "CreateFood", urlPatterns = "/food/create")
public class CreateFoodServlet extends HttpServlet {
    private CategoryService categoryService = new CategoryService();
    private FoodService foodService = new FoodService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<Category> categories = categoryService.findByCondition();
        req.setAttribute("status", "");
        req.setAttribute("categories", categories);
        req.getRequestDispatcher("/food/create.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String name = req.getParameter("name");
        String categoryId = req.getParameter("categoryId");
        String description = req.getParameter("description");
        String price = req.getParameter("price").length()>0?req.getParameter("price"):"0";
        String thumbnail = req.getParameter("thumbnails");
        Food food = new Food();
        food.setName(name);
        food.setCategoryId(Integer.parseInt(categoryId));
        food.setDescription(description);
        food.setThumbnail(thumbnail);
        food.setPrice(Double.valueOf(price));

        boolean result = foodService.create(food);

        if (!result) {
            req.setAttribute("categories",  categoryService.findByCondition());
            req.setAttribute("status", "Tên món ăn không trống và dài hơn 7 ký tự. Giá bán phải lớn hơn 0.");
            req.getRequestDispatcher("/food/create.jsp").forward(req, resp);
            return;
        }
        resp.sendRedirect("/food/list");
    }
}
