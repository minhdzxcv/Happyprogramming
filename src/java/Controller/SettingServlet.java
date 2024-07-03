/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller;

import DAO.UserDAO;
import Service.AuthorizationService;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;

/**
 *
 * @author ADMIN
 */
@WebServlet(name="SettingServlet", urlPatterns={"/setting"})
public class SettingServlet extends HttpServlet {
   
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
        request.getRequestDispatcher("setting.jsp").forward(request, response);
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
        String confirm = request.getParameter("confirmNewPassword");
        String password = request.getParameter("newPassword");
        String OldPassword = request.getParameter("oldpass");
        String username = request.getParameter("username");
        
        if(!password.equals(confirm)) {
            request.setAttribute("error", "Confirm password not match!");
        }       
        else {
            if(OldPassword.equals(password)) {
                request.setAttribute("error", "New password cannot be the same as old password!");
                request.getRequestDispatcher("setting.jsp").forward(request, response);
                return;
            }
            User u = (User)request.getSession().getAttribute("email");
            
            if(!u.getUsername().equals(username)){
            request.setAttribute("error", "account not match!");
        }       else{
            
            try {
                boolean check = UserDAO.changePass(u.getId(), OldPassword, password);
                if(check) {
                    request.setAttribute("error", "Change password successfully!");
                    request.getRequestDispatcher("setting.jsp").forward(request, response);
                    return;
                }
            } catch(Exception e) {
                e.printStackTrace();
            }
            request.setAttribute("error", "Old password not match!");
            request.getRequestDispatcher("setting.jsp").forward(request, response);
            return;
        }}
        request.getRequestDispatcher("setting.jsp").forward(request, response);
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
