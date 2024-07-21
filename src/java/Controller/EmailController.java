/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller;

import Service.AuthorizationService;
import DAO.UserDAO;
import Service.MailService;
import Service.RandomStringService;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.nio.charset.Charset;
import java.util.Random;
import model.User;

/**
 *
 * @author TGDD
 */
@WebServlet(name="EmailController", urlPatterns={"/email"})
public class EmailController extends HttpServlet {
    
    /** 
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code> methods.
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
        User u = (User)request.getSession().getAttribute("User");
        String verify = request.getParameter("verify");
        if(verify != null) {
            String code = (String)request.getSession().getAttribute("VerifyCode");
            if(code != null) {
                if(code.equals(verify)) {
                    try {
                        boolean check = UserDAO.verifyAccount(u.getId(), u.getEmail());
                        if(check) {
                            u.setValidate(true);
                            request.getSession().setAttribute("User", u);
                            request.getSession().removeAttribute("VerifyCode");
                        }
                    } catch(Exception e) {}
                } else {
                    request.setAttribute("alert", "Something went wrong! Maybe the verify code had expired");
                }
            } else {
                request.setAttribute("alert", "Something went wrong! Maybe the verify code had expired");
            }
        }
        request.getRequestDispatcher("email.jsp").forward(request, response);
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
        } catch(Exception e) {}
                    String generatedString = RandomStringService.random(20);
                    String email = request.getParameter("emailValue");
                    User u = (User)request.getSession().getAttribute("User");
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
                    u.setEmail(email);
                    request.getSession().setAttribute("User", u);
                    request.getSession().setAttribute("VerifyCode", generatedString);
                    request.setAttribute("alert", "We has sent you a verify email, please check your email");
        processRequest(request, response);
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
