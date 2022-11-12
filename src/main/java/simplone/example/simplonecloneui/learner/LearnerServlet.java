package simplone.example.simplonecloneui.learner;

import com.google.gson.Gson;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import simplone.example.simplonecloneui.breif.BreifService;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.List;

@WebServlet({"/learner/get", "/learner/update", "/learner/get-breifs", "/learner/get-breifs-deatils"})
public class LearnerServlet extends HttpServlet {
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
            case "/learner/get": getAllLearnersController(request,response); break;
            case "/learner/update": updatePromoController(request,response); break;
            case "/learner/get-breifs": getMyBreifsController(request,response); break;
            case "/learner/get-breifs-deatils": getBreifDetailsController(request,response); break;
        }
    }


    public void getBreifDetailsController(HttpServletRequest request, HttpServletResponse response) throws IOException {
        HttpSession session = request.getSession();
        List brief = LearnerService.getBrefiDetailsService((Integer) session.getAttribute("idBreif"));
        String json = new Gson().toJson(brief);
        PrintWriter out = response.getWriter();
        out.println(json);
        out.flush();
    }

    public void getMyBreifsController(HttpServletRequest request, HttpServletResponse response) throws IOException {
        List brief = LearnerService.getMyBrefisService();
        String json = new Gson().toJson(brief);
        PrintWriter out = response.getWriter();
        out.println(json);
        out.flush();
    }

    public void getAllLearnersController(HttpServletRequest request, HttpServletResponse response) {

    }

    public void updatePromoController(HttpServletRequest request, HttpServletResponse response) {

    }

}
