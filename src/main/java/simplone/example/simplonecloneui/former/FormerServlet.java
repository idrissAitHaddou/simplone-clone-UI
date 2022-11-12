package simplone.example.simplonecloneui.former;

import com.google.gson.Gson;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import simplone.example.simplonecloneui.admin.AdminService;
import simplone.example.simplonecloneui.breif.BreifService;
import simplone.example.simplonecloneui.former.FormerService;
import simplone.example.simplonecloneui.learner.LearnerService;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.HashMap;
import java.util.List;

@WebServlet({"/former/get-learners", "/former/search-learners", "/fromer/delete-learner", "/former/get-learners-no-promo" ,
        "/former/add-learner-to-promo", "/former/create-breif", "/former/get-breifs", "/former/get-breif", "/former/update-breif",
        "/former/delete-breif", "/former/search-breif", "/former/launch-breif"})
@MultipartConfig
public class FormerServlet extends HttpServlet {
    public static final String IMAGES_FOLDER = "assets/images";
    public static String uploadPath;
    @Override
    public void init() throws ServletException {
        uploadPath = getServletContext().getRealPath( IMAGES_FOLDER );
        File uploadDir = new File( uploadPath );
        if ( ! uploadDir.exists() ) uploadDir.mkdir();
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) {
        try {
            Mapping(request, response);
        } catch (SQLException | ParseException | IOException | ServletException e) {
            throw new RuntimeException(e);
        }
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) {
        try {
            Mapping(request, response);
        } catch (SQLException | ParseException | IOException | ServletException e) {
            throw new RuntimeException(e);
        }
    }

    public void Mapping(HttpServletRequest request, HttpServletResponse response) throws SQLException, ParseException, IOException, ServletException {
        String path = request.getServletPath()!=null?request.getServletPath():"";
        switch(path) {
            case "/former/get-learners": getAllLearnersController(request,response); break;
            case "/former/search-learners": searchLearnersController(request,response); break;
            case "/fromer/delete-learner": deleteLearnersController(request,response); break;
            case "/former/get-learners-no-promo": learnersWithoutPromoController(request,response); break;
            case "/former/add-learner-to-promo": addLearnerToPromoController(request,response); break;
            case "/former/create-breif": createBreifController(request,response); break;
            case "/former/get-breifs": getBreifsController(request,response); break;
            case "/former/get-breif": getBreifController(request,response); break;
            case "/former/update-breif": updateBreifController(request,response); break;
            case "/former/delete-breif": deleteBreifController(request,response); break;
            case "/former/search-breif": searchBreifController(request,response); break;
            case "/former/launch-breif": launchBreifController(request,response); break;
        }
    }

    public void launchBreifController(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        boolean deleteStatus = false;
        deleteStatus = BreifService.launchBriefService(Integer.parseInt(request.getParameter("id")));
        response.setContentType("application/json");
        HashMap<String, String> responseStatus = new HashMap<>();
        if(deleteStatus == true) responseStatus.put("status", "success");
        else responseStatus.put("status", "error");
        String json = new Gson().toJson(responseStatus);
        PrintWriter out = response.getWriter();
        out.println(json);
        out.flush();
    }

    public void searchBreifController(HttpServletRequest request, HttpServletResponse response) throws IOException {
        List brief = BreifService.searchBreifService(request.getParameter("name"));
        String json = new Gson().toJson(brief);
        PrintWriter out = response.getWriter();
        out.println(json);
        out.flush();
    }

    public void deleteBreifController(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        boolean deleteStatus = false;
        deleteStatus = BreifService.deleteBriefService(Integer.parseInt(request.getParameter("id")), uploadPath);
        response.setContentType("application/json");
        HashMap<String, String> responseStatus = new HashMap<>();
        if(deleteStatus == true) responseStatus.put("status", "success");
        else responseStatus.put("status", "error");
        String json = new Gson().toJson(responseStatus);
        PrintWriter out = response.getWriter();
        out.println(json);
        out.flush();
    }

    public void updateBreifController(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        boolean deleteStatus = false;
        deleteStatus = BreifService.updateBriefService(request, request.getPart("file"), uploadPath);
        response.setContentType("application/json");
        HashMap<String, String> responseStatus = new HashMap<>();
        if(deleteStatus == true) responseStatus.put("status", "success");
        else responseStatus.put("status", "error");
        String json = new Gson().toJson(responseStatus);
        PrintWriter out = response.getWriter();
        out.println(json);
        out.flush();
    }

    public void getBreifController(HttpServletRequest request, HttpServletResponse response) throws IOException {
        List brief = BreifService.getbreifByIdService(Integer.parseInt(request.getParameter("id")));
        String json = new Gson().toJson(brief);
        PrintWriter out = response.getWriter();
        out.println(json);
        out.flush();
    }

    public void getBreifsController(HttpServletRequest request, HttpServletResponse response) throws IOException {
        List learners = BreifService.getMyBreifsService();
        String json = new Gson().toJson(learners);
        PrintWriter out = response.getWriter();
        out.println(json);
        out.flush();
    }

    public void createBreifController(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        boolean deleteStatus = false;
        deleteStatus = BreifService.createBriefService(request, uploadPath);
        response.setContentType("application/json");
        HashMap<String, String> responseStatus = new HashMap<>();
        if(deleteStatus == true) responseStatus.put("status", "success");
        else responseStatus.put("status", "error");
        String json = new Gson().toJson(responseStatus);
        PrintWriter out = response.getWriter();
        out.println(json);
        out.flush();
    }

    public void addLearnerToPromoController(HttpServletRequest request, HttpServletResponse response) throws IOException {
        boolean deleteStatus = false;
        deleteStatus = FormerService.addLearnerToPromoService(Integer.parseInt(request.getParameter("idLearner")));
        response.setContentType("application/json");
        HashMap<String, String> responseStatus = new HashMap<>();
        if(deleteStatus == true) responseStatus.put("status", "success");
        else responseStatus.put("status", "error");
        String json = new Gson().toJson(responseStatus);
        PrintWriter out = response.getWriter();
        out.println(json);
        out.flush();
    }

    public void learnersWithoutPromoController(HttpServletRequest request, HttpServletResponse response) throws IOException {
        List learners = FormerService.learnersWithoutPromoService();
        System.out.println(learners.toString());
        String json = new Gson().toJson(learners);
        PrintWriter out = response.getWriter();
        out.println(json);
        out.flush();
    }

    public void deleteLearnersController(HttpServletRequest request, HttpServletResponse response) throws IOException {
        boolean deleteStatus = false;
        deleteStatus = FormerService.deleteMyLearnerService(Integer.parseInt(request.getParameter("id")));
        response.setContentType("application/json");
        HashMap<String, String> responseStatus = new HashMap<>();
        if(deleteStatus == true) responseStatus.put("status", "success");
        else responseStatus.put("status", "error");
        String json = new Gson().toJson(responseStatus);
        PrintWriter out = response.getWriter();
        out.println(json);
        out.flush();
    }

    public void searchLearnersController(HttpServletRequest request, HttpServletResponse response) throws IOException {
        List learners = FormerService.searchLearnersService(request.getParameter("name"));
        String json = new Gson().toJson(learners);
        PrintWriter out = response.getWriter();
        out.println(json);
        out.flush();
    }

    public void getAllLearnersController(HttpServletRequest request, HttpServletResponse response) throws IOException {
        List learners = FormerService.getMyLearnersService();
        String json = new Gson().toJson(learners);
        PrintWriter out = response.getWriter();
        out.println(json);
        out.flush();
    }
}
