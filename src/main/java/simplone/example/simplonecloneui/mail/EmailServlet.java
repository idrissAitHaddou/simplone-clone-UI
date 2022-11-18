package simplone.example.simplonecloneui.mail;

import com.google.gson.Gson;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import simplone.example.simplonecloneui.learner.LearnerService;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.text.ParseException;
import java.util.HashMap;

@WebServlet({"/email/generate-code", "/email/validate-code", "/email/change-password"})
@MultipartConfig
public class EmailServlet extends HttpServlet {
    @Override
    public void init() throws ServletException {}
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
            case "/email/generate-code": generateCodeController(request,response); break;
            case "/email/validate-code": validateCodeController(request,response); break;
            case "/email/change-password": changePassowrdForgetController(request,response); break;
        }
    }

    public void changePassowrdForgetController(HttpServletRequest request, HttpServletResponse response) throws IOException {
        boolean checkStatus = false;
        HttpSession session = request.getSession();
        String password = request.getParameter("password");
        String email = (String) session.getAttribute("emailToValidate");
        checkStatus = EmailService.changePasswordForgetService(request, email, password);
        response.setContentType("application/json");
        HashMap<String, String> responseStatus = new HashMap<>();
        if(checkStatus == true) responseStatus.put("status", "success");
        else responseStatus.put("status", "error");
        responseStatus.put("role", (String) session.getAttribute("roleResetPassword"));
        String json = new Gson().toJson(responseStatus);
        PrintWriter out = response.getWriter();
        out.println(json);
        out.flush();
    }

    public void validateCodeController(HttpServletRequest request, HttpServletResponse response) throws IOException {
        boolean checkStatus = false;
        HttpSession session = request.getSession();
        String code = request.getParameter("code");
        String codeSession = (String) session.getAttribute("codeGenerate");
        if(code.equals(codeSession)) checkStatus = true;
        response.setContentType("application/json");
        HashMap<String, String> responseStatus = new HashMap<>();
        if(checkStatus == true) responseStatus.put("status", "success");
        else responseStatus.put("status", "error");
        String json = new Gson().toJson(responseStatus);
        PrintWriter out = response.getWriter();
        out.println(json);
        out.flush();
    }

    public void generateCodeController(HttpServletRequest request, HttpServletResponse response) throws IOException {
        boolean checkStatus = false;
        try {
          ForgetPassword.sendCodeValidateEmail(request, request.getParameter("email"));
          checkStatus = true;
        }catch (Exception e) {
            checkStatus = false;
        }
        response.setContentType("application/json");
        HashMap<String, String> responseStatus = new HashMap<>();
        if(checkStatus == true) responseStatus.put("status", "success");
        else responseStatus.put("status", "error");
        String json = new Gson().toJson(responseStatus);
        PrintWriter out = response.getWriter();
        out.println(json);
        out.flush();
    }
}
