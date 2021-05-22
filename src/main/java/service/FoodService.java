package service;

import entity.Food;
import repository.GenericRepository;

import java.util.List;

public class FoodService {

    private GenericRepository<Food> foodGenericRepository;
    public FoodService() {
        this.foodGenericRepository = new GenericRepository<>(Food.class);
    }
    java.sql.Date date=new java.sql.Date(System.currentTimeMillis());

    public boolean create(Food food){
        if(food.validate()){
            food.setSaleStartDate(date);
            food.setCreatedAt(date);
            food.setUpdatedAt(date);
            food.setStatus(1);
            return foodGenericRepository.save(food);
        }
        return false;
    };
    public boolean edit(String id, Food food) {
        if (food.validate()) {
            food.setUpdatedAt(date);
             return foodGenericRepository.update(id, food);
        }
        return false;
    }

    public boolean delete(String id, Food obj) {
        obj.setUpdatedAt(date);
        obj.setStatus(0);
        return foodGenericRepository.update(id, obj);
    }

    public List<Food> getList(int a, int b) {
        return foodGenericRepository.findAll(a,b);
    }
    public Food getById(String id) {
        return foodGenericRepository.findById(id);
    }
}
