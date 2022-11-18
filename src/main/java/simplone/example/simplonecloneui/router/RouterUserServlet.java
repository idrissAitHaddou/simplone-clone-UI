package simplone.example.simplonecloneui.router;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
@WebServlet({"/email/new-password", "/email/enter-password", "/email/reset-password", "/learner/login","/learner/logout", "/former/logout", "/former/login", "/former/dashboard",
              "/fromer/profile", "/former/learners", "/former/breifs",
              "/learner/dashboard", "/learner/profile", "/learner/breifs", "/learner/breifs-description"})
public class RouterUserServlet extends HttpServlet {
    private HttpSession checkSession;
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath()!=null?request.getServletPath():"";
        checkSession = request.getSession();
        switch(path) {
            case "/learner/logout":
                HttpSession removeSession = request.getSession();
                removeSession.removeAttribute("role");
                removeSession.removeAttribute("id");
                response.sendRedirect("/learner/login");
                RequestDispatcher toLogin = request.getRequestDispatcher("../app/views/loginLearner/index.jsp");
                toLogin.include( request, response );
                break;
            case "/learner/login":
                HttpSession session = request.getSession();
                if(session.getAttribute("role") != "learner") {
                    RequestDispatcher login = request.getRequestDispatcher("../app/views/loginLearner/index.jsp");
                    login.include( request, response );
                    return;
                }
                response.sendRedirect("/learner/dashboard");
                break;

            case "/former/logout":
                HttpSession formerSession = request.getSession();
                formerSession.removeAttribute("role");
                formerSession.removeAttribute("id");
                response.sendRedirect("/former/login");
                RequestDispatcher formerLogin = request.getRequestDispatcher("../app/views/loginFormer/index.jsp");
                formerLogin.include( request, response );
                break;
            case "/former/login":
                HttpSession formersession = request.getSession();
                if(formersession.getAttribute("role") != "former") {
                    RequestDispatcher login = request.getRequestDispatcher("../app/views/loginFormer/index.jsp");
                    login.include( request, response );
                    return;
                }
                response.sendRedirect("/former/learners");
                break;
            case "/former/dashboard":
                view(request, response, "../app/views/dashboard/index.jsp");
                break;
            case "/former/profile":
                view(request, response, "../app/views/profile/index.jsp");
                break;
            case "/former/learners":
                view(request, response, "../app/views/learners/index.jsp");
                break;
            case "/former/breifs":
                view(request, response, "../app/views/breif/index.jsp");
                break;
            case "/learner/dashboard":
                view(request, response, "../app/views/homeLearner/index.jsp");
                break;
            case "/learner/profile":
                view(request, response, "../app/views/profile/index.jsp");
                break;
            case "/learner/breifs":
                view(request, response, "../app/views/leanerBreif/index.jsp");
                break;
            case "/learner/breifs-description":
                HttpSession isSession = request.getSession();
                isSession.setAttribute("idBreif", Integer.parseInt(request.getParameter("id")));
                view(request, response, "../app/views/breifDescription/index.jsp");
                break;
            case "/email/reset-password":
                HttpSession sessionRole = request.getSession();
                if(sessionRole.getAttribute("roleResetPassword") != null) sessionRole.removeAttribute("roleResetPassword");
                sessionRole.setAttribute("roleResetPassword", request.getParameter("role"));
                RequestDispatcher resetPassword = request.getRequestDispatcher("../app/views/resetPassword/getEmail.jsp");
                resetPassword.include( request, response );
                break;
            case "/email/enter-password":
                RequestDispatcher enterPassword = request.getRequestDispatcher("../app/views/resetPassword/enterCodeGenerate.jsp");
                enterPassword.include( request, response );
                break;
            case "/email/new-password":
                RequestDispatcher newPassword = request.getRequestDispatcher("../app/views/resetPassword/newPassword.jsp");
                newPassword.include( request, response );
                break;
        }
    }

    public void view(HttpServletRequest request, HttpServletResponse response, String pathView) throws ServletException, IOException  {
        if(checkSession.getAttribute("role") != null) {
        RequestDispatcher header = request.getRequestDispatcher("../app/component/header.jsp");
        header.include( request, response );
        RequestDispatcher sidebar = request.getRequestDispatcher("../app/component/sidebar.jsp");
        sidebar.include( request, response );
        RequestDispatcher main = request.getRequestDispatcher(pathView);
        main.include( request, response );
        RequestDispatcher footer = request.getRequestDispatcher("../app/component/footer.jsp");
        footer.include( request, response );
        return;
        }
        response.sendRedirect("/learner/login");
        RequestDispatcher login = request.getRequestDispatcher("../app/views/loginLearner/index.jsp");
        login.include( request, response );
    }
}
