package controller;

import entity.Food;
import service.CategoryService;
import service.FoodService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet(name = "EditFood", urlPatterns = "/food/edit")
public class EditFoodServlet extends HttpServlet {
    private FoodService foodService = new FoodService();
    private CategoryService categoryService = new CategoryService();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String sid = req.getParameter("id");
        Food existFood = foodService.getById(sid);
        if (existFood == null){
            resp.sendRedirect("/food/list");
            return;
        }
        req.setAttribute("status", "");
        req.setAttribute("list", existFood);
        req.setAttribute("categories",  categoryService.findByCondition());
        req.getRequestDispatcher("/food/edit.jsp").forward(req,resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException, ServletException {
        req.setCharacterEncoding("UTF-8"); // lỗi Utf8 ngoài view
        String sid = req.getParameter("id");
        String name = req.getParameter("name");
        String categoryId = req.getParameter("categoryId");
        String description = req.getParameter("description");
        String thumbnail = "";
        String price = req.getParameter("price").length()>0?req.getParameter("price"):"0";
        thumbnail = req.getParameter("thumbnails");
        String status = req.getParameter("status");
        Food exist = foodService.getById(sid);
        if (exist == null){
            resp.sendRedirect("/food/list");
            return;
        }
        exist.setName(name);
        exist.setCategoryId(Integer.parseInt(categoryId));
        exist.setDescription(description);
        exist.setThumbnail(thumbnail);
        exist.setPrice(Double.valueOf(price));
        exist.setStatus(Integer.parseInt(status));

        boolean result = foodService.edit(sid,exist);

        if (!result) {
            Food existFood = foodService.getById(sid);
            req.setAttribute("list", existFood);
            req.setAttribute("categories",  categoryService.findByCondition());
            req.setAttribute("status", "Tên món ăn không trống và dài hơn 7 ký tự. Giá bán phải lớn hơn 0.");
            req.getRequestDispatcher("/food/edit.jsp").forward(req, resp);
            return;
        }
        resp.sendRedirect("/food/list");
    }
}
