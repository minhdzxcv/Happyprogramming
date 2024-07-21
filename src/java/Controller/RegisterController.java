/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Service.AuthorizationService;
import DAO.UserDAO;
import Service.MailService;
import Service.RandomStringService;
import model.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.nio.charset.Charset;
import java.sql.Date;
import java.util.Random;
import model.Mentor;

/**
 *
 * @author TGDD
 */
@WebServlet(name = "Register", urlPatterns = {"/register"})
public class RegisterController extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            if (!AuthorizationService.gI().Authorization(request, response)) {
                return;
            }
        } catch(Exception e) {}
        request.getRequestDispatcher("SignUp.jsp").forward(request, response);
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
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
     *
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
        } catch(Exception e) {}
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String dob = request.getParameter("dob");
        String address = request.getParameter("address");
        String fullname = request.getParameter("fullname");
        String gender = request.getParameter("gender");
        String repass = request.getParameter("repass");
        String role = request.getParameter("role");
        if (repass.equals(password)) {
            try {
                Date d = Date.valueOf(dob);
                if(d.after(Date.from(new java.util.Date().toInstant()))) {
                    request.getSession().setAttribute("alert", "Ngày sinh không được vượt quá hiện tại!");
                } else {
                User u = UserDAO.register(username, password, email, phone, address, role, gender, fullname, dob);
                if (u != null) {
                    String generatedString = RandomStringService.random(20);
                    request.getSession().setAttribute("VerifyCode", generatedString);
                    final String tempMail = u.getEmail();
                    final String url = (request.getRequestURL()+"").replace(request.getServletPath(), "")+"/email?verify="+generatedString;
                    //System.out.println(url);
                    Thread thread = new Thread() {
                        @Override
                        public void run() {
                                try {
                                    MailService.sendMail(tempMail, "Verify Your Email", "Click on this link to verify your password:\n "+url+" \nIf you did not do this please avoid this email!");
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                        }
                    };
                    thread.start();
                    request.getSession().setAttribute("User", u);
                    if(u.getRole().equalsIgnoreCase("mentor")) {
                        Mentor r = (Mentor) UserDAO.getRole(u.getId(), u.getRole());
                        request.getSession().setAttribute("Mentor", r);
                        response.sendRedirect("cv");
                        return;
                    }
                    response.sendRedirect("index");
                    return;
                } else {
                    request.getSession().setAttribute("alert", "Email or username has been registered!");
                }
                }
            } catch (Exception e) {
                request.getSession().setAttribute("alert", e.getMessage());
            }
        } else {
            request.getSession().setAttribute("alert", "Password not match!");
        }
        request.getRequestDispatcher("SignUp.jsp").forward(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
