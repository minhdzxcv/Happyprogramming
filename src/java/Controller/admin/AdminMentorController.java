/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.admin;

import Service.AuthorizationService;
import DAO.MentorDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.HashMap;
import model.Mentor;
import model.MentorDetail;
import model.User;

/**
 *
 * @author TGDD
 */
@WebServlet(name = "AdminMentorController", urlPatterns = {"/admin/mentor"})
public class AdminMentorController extends HttpServlet {

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
        if (request.getParameter("toggleid") != null && request.getParameter("toggle") != null) {
            try {
                int id = Integer.parseInt(request.getParameter("toggleid"));
                boolean type = request.getParameter("toggle").equalsIgnoreCase("on");
                MentorDAO.toggle(type, id);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        try {
            HashMap<Mentor, MentorDetail> mentors = (HashMap) MentorDAO.getAllWithDetail();
            request.setAttribute("mentors", mentors);
        } catch (Exception e) {
            e.printStackTrace();
        }
        request.getRequestDispatcher("mentor.jsp").forward(request, response);
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
        try {
            HashMap<Mentor, MentorDetail> mentors = (HashMap) MentorDAO.getAllWithDetail();
            if (request.getParameter("search") != null && !request.getParameter("search").isEmpty()) {
                ArrayList<Mentor> temp = new ArrayList();
                for (Mentor m : mentors.keySet()) {
                    if (!m.getFullname().contains(request.getParameter("search"))) {
                        if (!mentors.get(m).getAccount().contains(request.getParameter("search"))) {
                            temp.add(m);
                        }
                    }
                }
                for (int i = 0; i < temp.size(); i++) {
                    mentors.remove(temp.get(i));
                }
            }
            request.setAttribute("mentors", mentors);
        } catch (Exception e) {
            e.printStackTrace();
        }
        request.getRequestDispatcher("mentor.jsp").forward(request, response);
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
