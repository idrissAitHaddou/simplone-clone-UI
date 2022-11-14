package simplone.example.simplonecloneui.admin;

import com.google.gson.Gson;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import simplone.example.simplonecloneui.former.Formateurs;
import simplone.example.simplonecloneui.former.FormerService;
import simplone.example.simplonecloneui.learner.Apprenants;
import simplone.example.simplonecloneui.learner.LearnerRepository;
import simplone.example.simplonecloneui.learner.LearnerService;
import simplone.example.simplonecloneui.promotion.Promos;
import simplone.example.simplonecloneui.promotion.PromotionService;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.HashMap;
import java.util.List;

@WebServlet({"/admin/create-user", "/admin/update-user", "/admin/delete-user", "/admin/get-users", "/admin/get-user", "/admin/get-formers", "/admin/get-learners",
             "/admin/create-promotion", "/admin/get-promotions", "/admin/delete-promotion", "/admin/search-promotions", "/admin/get-promotion", "/admin/update-promotion",
             "/admin/get-profile", "/admin/update-profile", "/admin/check-password-profile", "/admin/change-password-profile"})
@MultipartConfig
public class AdminServlet extends HttpServlet {
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
            case "/admin/get-users": getAllUsersController(request,response); break;
            case "/admin/get-user": getUserController(request,response); break;
            case "/admin/get-formers": getAllFormesController(request,response); break;
            case "/admin/get-learners": getAllLearnersController(request,response); break;
            case "/admin/create-user": createUserController(request,response); break;
            case "/admin/update-user": updateUserController(request,response); break;
            case "/admin/delete-user": deleteUserController(request,response); break;

            case "/admin/create-promotion": createPromoController(request,response); break;
            case "/admin/get-promotions": getAllPromotionsController(request,response); break;
            case "/admin/get-promotion": getPromotionController(request,response); break;
            case "/admin/delete-promotion": deletePromotionsController(request,response); break;
            case "/admin/search-promotions": searchPromotionsController(request,response); break;
            case "/admin/update-promotion": updatePromotionsController(request,response); break;

            case "/admin/get-profile": getProfileUsreController(request,response); break;
            case "/admin/update-profile": updateProfileUsreController(request,response); break;
            case "/admin/check-password-profile": checkPasswordUsreController(request,response); break;
            case "/admin/change-password-profile": changePasswordUsreController(request,response); break;
        }
    }

    public void changePasswordUsreController(HttpServletRequest request, HttpServletResponse response) throws IOException {
        boolean checkStatus = false;
        HttpSession session = request.getSession();
        session.setAttribute("role", "former");
        session.setAttribute("id", 23);
        if(session.getAttribute("role") == "former")
            checkStatus = FormerService.changeFormerPasswordService(request.getParameter("password"), (Integer)session.getAttribute("id"));
        else if(session.getAttribute("role") == "learner")
            checkStatus = LearnerService.changeLearnerPasswordService(request.getParameter("password"), (Integer)session.getAttribute("id"));
        else if(session.getAttribute("role") == "admin")
            checkStatus = AdminService.changeAdminPasswordService(request.getParameter("password"),(Integer)session.getAttribute("id"));
        response.setContentType("application/json");
        HashMap<String, String> responseStatus = new HashMap<>();
        if(checkStatus == true) responseStatus.put("status", "success");
        else responseStatus.put("status", "error");
        String json = new Gson().toJson(responseStatus);
        PrintWriter out = response.getWriter();
        out.println(json);
        out.flush();
    }

    public void checkPasswordUsreController(HttpServletRequest request, HttpServletResponse response) throws IOException {
        boolean checkStatus = false;
        HttpSession session = request.getSession();
        session.setAttribute("role", "former");
        session.setAttribute("id", 23);
        if(session.getAttribute("role") == "former")
            checkStatus = FormerService.checkFormerPasswordService(request.getParameter("password"), (Integer)session.getAttribute("id"));
        else if(session.getAttribute("role") == "learner")
            checkStatus = LearnerService.checkLearnerPasswordService(request.getParameter("password"), (Integer)session.getAttribute("id"));
        else if(session.getAttribute("role") == "admin")
            checkStatus = AdminService.checkAdminPasswordService(request.getParameter("password"),(Integer)session.getAttribute("id"));
        response.setContentType("application/json");
        HashMap<String, String> responseStatus = new HashMap<>();
        if(checkStatus == true) responseStatus.put("status", "success");
        else responseStatus.put("status", "error");
        String json = new Gson().toJson(responseStatus);
        PrintWriter out = response.getWriter();
        out.println(json);
        out.flush();
    }

    public void updateProfileUsreController(HttpServletRequest request, HttpServletResponse response) throws IOException {
        boolean updateStatus = false;
        HttpSession session = request.getSession();
        session.setAttribute("role", "former");
        session.setAttribute("id", 23);
        if(session.getAttribute("role") == "former")
            updateStatus = FormerService.updateFormerProfileService(request, (Integer)session.getAttribute("id"));
        else if(session.getAttribute("role") == "learner")
            updateStatus = LearnerService.updateLearnerProfileService(request, (Integer)session.getAttribute("id"));
        else if(session.getAttribute("role") == "admin")
            updateStatus = AdminService.updateAdminService(request,(Integer)session.getAttribute("id"));

        response.setContentType("application/json");
        HashMap<String, String> responseStatus = new HashMap<>();
        if(updateStatus == true) responseStatus.put("status", "success");
        else responseStatus.put("status", "error");
        String json = new Gson().toJson(responseStatus);
        PrintWriter out = response.getWriter();
        out.println(json);
        out.flush();
    }

    public void getProfileUsreController(HttpServletRequest request, HttpServletResponse response) throws IOException {
        List user = null;
        HttpSession session = request.getSession();
        session.setAttribute("role", "former");
        session.setAttribute("id", 23);
        if(session.getAttribute("role") == "former")
            user = FormerService.getFormerService((Integer)session.getAttribute("id"));
        if(session.getAttribute("role") == "learner")
            user = LearnerService.getLearnerService((Integer)session.getAttribute("id"));
        if(session.getAttribute("role") == "admin")
            user = AdminService.getProfileService((Integer)session.getAttribute("id"));
        String json = new Gson().toJson(user);
        PrintWriter out = response.getWriter();
        out.println(json);
        out.flush();
    }

    public void updatePromotionsController(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        boolean updateStatus = false;
        Promos promotion = new Promos();
        promotion.setId(Integer.parseInt(request.getParameter("id")));
        promotion.setNom(request.getParameter("name"));
        promotion.setAnnescolaire(request.getParameter("year"));
        promotion.setNiveau(request.getParameter("niveaux"));
        updateStatus = PromotionService.updatePromotionService(promotion, request.getPart("image"), Integer.parseInt(request.getParameter("oldFormer")), Integer.parseInt(request.getParameter("newFormer")), uploadPath);
        response.setContentType("application/json");
        HashMap<String, String> responseStatus = new HashMap<>();
        if(updateStatus == true) responseStatus.put("status", "success");
        else responseStatus.put("status", "error");
        String json = new Gson().toJson(responseStatus);
        PrintWriter out = response.getWriter();
        out.println(json);
        out.flush();
    }

    public void getPromotionController(HttpServletRequest request, HttpServletResponse response) throws IOException {
        List<Promos> promotion = PromotionService.getPromotionService(Integer.parseInt(request.getParameter("id")));
        String json = new Gson().toJson(promotion);
        PrintWriter out = response.getWriter();
        out.println(json);
        out.flush();
    }

    public void searchPromotionsController(HttpServletRequest request, HttpServletResponse response) throws IOException {
        List<Formateurs> formers = FormerService.getAllFormersService();
        List<Promos> promotions = PromotionService.searchPromotionsService(request.getParameter("name"));
        HashMap<String, List> data = new HashMap<>();
        data.put("promotions", promotions);
        data.put("formers", formers);
        String json = new Gson().toJson(data);
        PrintWriter out = response.getWriter();
        out.println(json);
        out.flush();
    }

    public void deletePromotionsController(HttpServletRequest request, HttpServletResponse response) throws IOException {
        boolean deleteStatus = false;
        if(PromotionService.deletePromotionService(Integer.parseInt(request.getParameter("idPromo")), Integer.parseInt(request.getParameter("idFormer")), uploadPath))
            deleteStatus = true;
        response.setContentType("application/json");
        HashMap<String, String> responseStatus = new HashMap<>();
        if(deleteStatus == true) responseStatus.put("status", "success");
        else responseStatus.put("status", "error");
        String json = new Gson().toJson(responseStatus);
        PrintWriter out = response.getWriter();
        out.println(json);
        out.flush();
    }

    public void getAllPromotionsController(HttpServletRequest request, HttpServletResponse response) throws IOException {
        List<Formateurs> formers = FormerService.getAllFormersService();
        List<Promos> promotions = PromotionService.getAllPromotionsService();
        HashMap<String, List> data = new HashMap<>();
        data.put("promotions", promotions);
        data.put("formers", formers);
        String json = new Gson().toJson(data);
        PrintWriter out = response.getWriter();
        out.println(json);
        out.flush();
    }

    public void createPromoController(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        boolean createStatus = false;
        Promos promotion = new Promos();
        promotion.setNom(request.getParameter("name"));
        promotion.setAnnescolaire(request.getParameter("year"));
        promotion.setNiveau(request.getParameter("niveau"));
        if(PromotionService.creatPromotionService(request.getPart("file"), promotion, Integer.parseInt(request.getParameter("former")), uploadPath)) { createStatus = true; }
        response.setContentType("application/json");
        HashMap<String, String> responseStatus = new HashMap<>();
        if(createStatus == true) responseStatus.put("status", "success");
        else responseStatus.put("status", "error");
        String json = new Gson().toJson(responseStatus);
        PrintWriter out = response.getWriter();
        out.println(json);
        out.flush();
    }

    public void getAllUsersController(HttpServletRequest request, HttpServletResponse response) throws IOException {
        List users = AdminService.getAllUsresService();
        String json = new Gson().toJson(users);
        PrintWriter out = response.getWriter();
        out.println(json);
        out.flush();
    }

    public void getUserController(HttpServletRequest request, HttpServletResponse response) throws IOException {
        List user = null;
        if(request.getParameter("role").equals("1"))
            user = FormerService.getFormerService(Integer.parseInt(request.getParameter("id")));
        else if(request.getParameter("role").equals("2"))
            user = LearnerService.getLearnerService(Integer.parseInt(request.getParameter("id")));
        String json = new Gson().toJson(user);
        PrintWriter out = response.getWriter();
        out.println(json);
        out.flush();
    }

    public void getAllFormesController(HttpServletRequest request, HttpServletResponse response) throws IOException {
        List users = FormerService.getAllFormersService();
        String json = new Gson().toJson(users);
        PrintWriter out = response.getWriter();
        out.println(json);
        out.flush();
    }

    public void getAllLearnersController(HttpServletRequest request, HttpServletResponse response) throws IOException {
        List users = LearnerService.getAllLearnersService();
        String json = new Gson().toJson(users);
        PrintWriter out = response.getWriter();
        out.println(json);
        out.flush();
    }

    public void createUserController(HttpServletRequest request, HttpServletResponse response) throws IOException {
        boolean createStatus = false;
        if(Integer.parseInt(request.getParameter("userType")) == 1) {
            Formateurs formateurs = new Formateurs();
            formateurs.setEmail(request.getParameter("email"));
            formateurs.setNom(request.getParameter("lastname"));
            formateurs.setPrenom(request.getParameter("firstname"));
            formateurs.setPassword(request.getParameter("password"));
            formateurs.setRole(Integer.parseInt(request.getParameter("userType")));
            createStatus = FormerService.createFormerService(formateurs);
        } else if(Integer.parseInt(request.getParameter("userType")) == 2) {
            Apprenants apprenants = new Apprenants();
            apprenants.setEmail(request.getParameter("email"));
            apprenants.setNom(request.getParameter("lastname"));
            apprenants.setPrenom(request.getParameter("firstname"));
            apprenants.setPassword(request.getParameter("password"));
            apprenants.setRole(Integer.parseInt(request.getParameter("userType")));
            createStatus = LearnerService.createLearnerService(apprenants);
        }
        response.setContentType("application/json");
        HashMap<String, String> responseStatus = new HashMap<>();
        if(createStatus == true) responseStatus.put("status", "success");
        else responseStatus.put("status", "error");
        String json = new Gson().toJson(responseStatus);
        PrintWriter out = response.getWriter();
        out.println(json);
        out.flush();
    }

    public void updateUserController(HttpServletRequest request, HttpServletResponse response) throws IOException {
        boolean updateStatus = false;
        if(Integer.parseInt(request.getParameter("userType")) == 1) {
            Formateurs formateurs = new Formateurs();
            formateurs.setEmail(request.getParameter("email"));
            formateurs.setNom(request.getParameter("lastname"));
            formateurs.setPrenom(request.getParameter("firstname"));
            formateurs.setPassword(request.getParameter("password"));
            formateurs.setId(Integer.parseInt(request.getParameter("id")));
            updateStatus = FormerService.updateFormerService(formateurs);
        } else if(Integer.parseInt(request.getParameter("userType")) == 2) {
            Apprenants apprenants = new Apprenants();
            apprenants.setEmail(request.getParameter("email"));
            apprenants.setNom(request.getParameter("lastname"));
            apprenants.setPrenom(request.getParameter("firstname"));
            apprenants.setPassword(request.getParameter("password"));
            apprenants.setId(Integer.parseInt(request.getParameter("id")));
            updateStatus = LearnerService.updateLearnerService(apprenants);
        }
        response.setContentType("application/json");
        HashMap<String, String> responseStatus = new HashMap<>();
        if(updateStatus == true) responseStatus.put("status", "success");
        else responseStatus.put("status", "error");
        String json = new Gson().toJson(responseStatus);
        PrintWriter out = response.getWriter();
        out.println(json);
        out.flush();
    }

    public void deleteUserController(HttpServletRequest request, HttpServletResponse response) throws IOException {
        boolean deleteStatus = false;
        System.out.println(request.getParameter("role"));
        try {
            if(request.getParameter("role").equals("1"))
                deleteStatus = FormerService.deleteService(Integer.parseInt(request.getParameter("id")));
            else if(request.getParameter("role").equals("2"))
                deleteStatus = LearnerService.deleteService(Integer.parseInt(request.getParameter("id")));
        } catch (Exception e) {
            System.out.println(e.getMessage());
        }
        response.setContentType("application/json");
        HashMap<String, String> responseStatus = new HashMap<>();
        if(deleteStatus == true) responseStatus.put("status", "success");
        else responseStatus.put("status", "error");
        String json = new Gson().toJson(responseStatus);
        PrintWriter out = response.getWriter();
        out.println(json);
        out.flush();
    }
}
