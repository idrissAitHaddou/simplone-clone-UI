package simplone.example.simplonecloneui.router;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
@WebServlet({"/former/logout", "/former/login", "/former/dashboard",
              "/fromer/profile", "/former/learners", "/former/breifs",
              "/learner/logout", "/learner/login", "/learner/dashboard",
              "/learner/profile", "/learner/breifs", "/learner/breifs-description"})
public class RouterUserServlet extends HttpServlet {
    private HttpSession checkSession;
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath()!=null?request.getServletPath():"";
        checkSession = request.getSession();
        switch(path) {
            case "/former/logout":
//                HttpSession removeSession = request.getSession();
//                removeSession.removeAttribute("sessionsAdmin");
//                response.sendRedirect("/admin/login");
                RequestDispatcher toLogin = request.getRequestDispatcher("../app/views/login/index.jsp");
                toLogin.include( request, response );
                break;
            case "/former/login":
//                HttpSession session = request.getSession();
//                if(session.getAttribute("sessionsAdmin") == null) {
                RequestDispatcher login = request.getRequestDispatcher("../app/views/login/index.jsp");
                login.include( request, response );
//                    return;
//                }
//                response.sendRedirect("/admin/dashboard");
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
                HttpSession session = request.getSession();
                session.setAttribute("idBreif", Integer.parseInt(request.getParameter("id")));
                System.out.println("------- id breif -------------");
                System.out.println(session.getAttribute("idBreif"));
                view(request, response, "../app/views/breifDescription/index.jsp");
                break;
        }
    }

    public void view(HttpServletRequest request, HttpServletResponse response, String pathView) throws ServletException, IOException  {
//        if(checkSession.getAttribute("sessionsAdmin") != null) {
        RequestDispatcher header = request.getRequestDispatcher("../app/component/header.jsp");
        header.include( request, response );
        RequestDispatcher sidebar = request.getRequestDispatcher("../app/component/sidebar.jsp");
        sidebar.include( request, response );
        RequestDispatcher main = request.getRequestDispatcher(pathView);
        main.include( request, response );
        RequestDispatcher footer = request.getRequestDispatcher("../app/component/footer.jsp");
        footer.include( request, response );
//            return;
//        }
//        response.sendRedirect("/admin/login");
//        RequestDispatcher login = request.getRequestDispatcher("../app/views/login/index.jsp");
//        login.include( request, response );
    }
}
