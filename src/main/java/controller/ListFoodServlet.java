package controller;

import entity.Category;
import entity.Food;
import repository.GenericRepository;
import service.CategoryService;
import service.FoodService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "ListFood", urlPatterns = "/food/list")
public class ListFoodServlet extends HttpServlet {
    private CategoryService categoryService = new CategoryService();
    private FoodService foodService = new FoodService();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        List<Category> categories = categoryService.findByCondition();
        int first = 0, last = 0, pages = 1;
        if (req.getParameter("pages") != null) {
            pages = (int) Integer.parseInt(req.getParameter("pages"));
        }
        int total = new GenericRepository<>(Food.class).getCountFood();
        if (total < 5) {
            first = 0;
            last = total;
        } else {
            first = (pages - 1) * 5;
            last = 5;
        }
        List<Food> food = foodService.getList(first, last);
        req.setAttribute("foods", foodService.getList(first, last));
        req.setAttribute("total", total);
        req.setAttribute("categories", categories);
        req.setAttribute("pages", pages);
        req.getRequestDispatcher("/food/list.jsp").forward(req, resp);
    }
}
