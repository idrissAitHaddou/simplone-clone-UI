package simplone.example.simplonecloneui.promotion;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.ParseException;

@WebServlet({"/promotion/get", "/promotion/create", "/promotion/update", "/promotion/delete"})
@MultipartConfig
public class PromotionServlet extends HttpServlet {
    @Override
    public void init() throws ServletException {}
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) {
        try {
            Mapping(request, response);
        } catch (SQLException | ParseException | IOException e) {
            throw new RuntimeException(e);
        }
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) {
        try {
            Mapping(request, response);
        } catch (SQLException | ParseException | IOException e) {
            throw new RuntimeException(e);
        }
    }

    public void Mapping(HttpServletRequest request, HttpServletResponse response) throws SQLException, ParseException, IOException {
        String path = request.getServletPath()!=null?request.getServletPath():"";
        switch(path) {
            case "/promotion/get": getAllPromotionsController(request,response); break;
            case "/promotion/create": createPromoController(request,response); break;
            case "/promotion/update": updatePromoController(request,response); break;
            case "/promotion/delete": deletePromoController(request,response); break;
        }
    }

    public void getAllPromotionsController(HttpServletRequest request, HttpServletResponse response) {

    }

    public void createPromoController(HttpServletRequest request, HttpServletResponse response) throws IOException {
    }

    public void updatePromoController(HttpServletRequest request, HttpServletResponse response) {

    }

    public void deletePromoController(HttpServletRequest request, HttpServletResponse response) {

    }
}
