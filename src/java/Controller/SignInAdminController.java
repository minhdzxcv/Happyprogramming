/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller;

import DAO.UserDAO;
import Service.AuthorizationService;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;

/**
 *
 * @author ADMIN
 */
public class SignInAdminController extends HttpServlet {
   
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet SignInAdminController</title>");  
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet SignInAdminController at " + request.getContextPath () + "</h1>");
            out.println("</body>");
            out.println("</html>");
        }
    } 

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /** 
     * Handles the HTTP <code>GET</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
        processRequest(request, response);
    } 

    /** 
     * Handles the HTTP <code>POST</code> method.
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
    throws ServletException, IOException {
    try {
        if (!AuthorizationService.gI().Authorization(request, response)) {
            return;
        }
        
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String remember = request.getParameter("remember");
        
        User u = UserDAO.getUser(email, password);
        
        if (u != null) {
            if (remember != null) {
                Cookie c = new Cookie("email", "Email|" + email + "_Pass|" + password);
                c.setMaxAge(60 * 24 * 7);
                response.addCookie(c);
            } else {
                Cookie[] cs = request.getCookies();
                if (cs != null) {
                    for (Cookie cookie : cs) {
                        if (cookie.getName().equals("email")) {
                            cookie.setMaxAge(0);
                            response.addCookie(cookie);
                            break;
                        }
                    }
                }
            }
            
            if (u.getRole().equalsIgnoreCase("mentor") || u.getRole().equalsIgnoreCase("mentee")) {
                request.getSession().setAttribute("error", "The account is not authorized to access, please log in as user");
            } else {
                response.sendRedirect("admin/request");
                return;
            }
        } else {
            request.getSession().setAttribute("error", "Invalid email or password");
        }
    } catch (Exception e) {
        // Log or display the error message appropriately
        request.getSession().setAttribute("error", "An error occurred: " + e.getMessage());
    }
    
    // If the user is not authenticated, set email and password attributes
    Cookie[] cs = request.getCookies();
    if (cs != null) {
        for (Cookie cookie : cs) {
            if (cookie.getName().equals("email")) {
                String[] atr = cookie.getValue().split("_");
                request.setAttribute("email", atr[0].replace("Email|", ""));
                request.setAttribute("password", atr[1].replace("Pass|", ""));
                break;
            }
        }
    }
    
    request.getRequestDispatcher("SignInAdmin.jsp").forward(request, response);
}

    /** 
     * Returns a short description of the servlet.
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
