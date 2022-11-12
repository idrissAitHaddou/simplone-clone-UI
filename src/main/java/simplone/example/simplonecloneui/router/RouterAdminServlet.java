package simplone.example.simplonecloneui.router;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;

@WebServlet({"/admin/logout", "/admin/login", "/admin/dashboard", "/admin/profile", "/admin/promotion", "/admin/users", "/admin/fromer-promotion"})
public class RouterAdminServlet extends HttpServlet {
    private HttpSession checkSession;
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String path = request.getServletPath()!=null?request.getServletPath():"";
        checkSession = request.getSession();
        switch(path) {
            case "/admin/logout":
//                HttpSession removeSession = request.getSession();
//                removeSession.removeAttribute("sessionsAdmin");
//                response.sendRedirect("/admin/login");
                RequestDispatcher toLogin = request.getRequestDispatcher("../app/views/login/index.jsp");
                toLogin.include( request, response );
                break;
            case "/admin/login":
//                HttpSession session = request.getSession();
//                if(session.getAttribute("sessionsAdmin") == null) {
                    RequestDispatcher login = request.getRequestDispatcher("../app/views/login/index.jsp");
                    login.include( request, response );
//                    return;
//                }
//                response.sendRedirect("/admin/dashboard");
                break;
            case "/admin/dashboard":
                view(request, response, "../app/views/dashboard/index.jsp");
                break;
            case "/admin/profile":
                view(request, response, "../app/views/profile/index.jsp");
                break;
            case "/admin/promotion":
                view(request, response, "../app/views/promotion/index.jsp");
                break;
            case "/admin/users":
                view(request, response, "../app/views/users/index.jsp");
                break;
            case "/admin/fromer-promotion":
                view(request, response, "../app/views/managerPromotion/index.jsp");
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
