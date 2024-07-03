/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller;

import DAO.SkillDAO;
import DAO.UserDAO;
import Service.AuthorizationService;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import model.Mentee;
import model.Mentor;
import model.Skill;
import model.User;

/**
 *
 * @author ADMIN
 */
public class ViewSkillController extends HttpServlet {
   
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

            ArrayList<Skill> a = SkillDAO.getAll();
            a.sort((s1, s2) -> s1.getName().compareToIgnoreCase(s2.getName()));

            if (request.getParameter("search") != null) {
                String s = request.getParameter("search");
                a.removeIf(skill -> !skill.getName().toLowerCase().contains(s.toLowerCase()));
            }

            request.setAttribute("skills", a); // All skills

        } catch (Exception e) {
            e.printStackTrace();
        }
        User u = (User) request.getSession().getAttribute("email");
        if (u != null) {
            if (UserDAO.isMentee(u)) {
                Mentee r = (Mentee) UserDAO.getRole(u.getId(), u.getRole());
                request.getSession().setAttribute("Mentee", r);
            } else {
                Mentor r = (Mentor) UserDAO.getRole(u.getId(), u.getRole());
                request.getSession().setAttribute("Mentor", r);
            }
        }
        request.getRequestDispatcher("ViewSkill.jsp").forward(request, response);
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
