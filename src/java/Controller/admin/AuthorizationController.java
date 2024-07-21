/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller.admin;

import DAO.RoleDAO;
import Service.AuthorizationService;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import model.Role;

/**
 *
 * @author TGDD
 */
@WebServlet(name="AuthorizationController", urlPatterns={"/admin/authorization"})
public class AuthorizationController extends HttpServlet {
   
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
        try {
            HashMap<String, String> maps = AuthorizationService.gI().getMap();
            request.setAttribute("maps", maps);
            ArrayList<Role> roles = RoleDAO.getRoles();
            request.setAttribute("roles", roles);
        } catch (Exception e) {
        }
        request.getRequestDispatcher("authorization.jsp").forward(request, response);
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
        String[] role = request.getParameterValues("role");
        String all = "";
        for (int i = 0; i < role.length - 1; i++) {
            all += role[i].toLowerCase()+", ";
        }
        all += role[role.length - 1].toLowerCase();
        if(request.getParameter("id") != null && !request.getParameter("id").equalsIgnoreCase("/admin/authorization")) {
            AuthorizationService.gI().setAuthorite(request.getParameter("id"), all);
        } else {
            request.setAttribute("message", "You cannot change authorite role of authorization page!");
        }
        try {
            HashMap<String, String> maps = AuthorizationService.gI().getMap();
            request.setAttribute("maps", maps);
            ArrayList<Role> roles = RoleDAO.getRoles();
            request.setAttribute("roles", roles);
        } catch (Exception e) {
        }
        request.getRequestDispatcher("authorization.jsp").forward(request, response);
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
