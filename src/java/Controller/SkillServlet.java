/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller;

import DAO.SkillDAO;
import Service.AuthorizationService;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import model.Skill;

/**
 *
 * @author ADMIN
 */
public class SkillServlet extends HttpServlet {
   
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
            ArrayList<Skill> arr = SkillDAO.getAll(true);
            request.setAttribute("skills", arr);
            ArrayList<Skill> az = (ArrayList)arr.clone();
            for (int i = 0; i < az.size(); i++) {
                for (int j = i; j < az.size(); j++) {
                    if (az.get(i).getName().compareTo(az.get(j).getName()) > 0) {
                        Skill temp = az.get(i);
                        az.set(i, az.get(j));
                        az.set(j, temp);
                    }
                }
            }
            request.setAttribute("a-z", az);
            ArrayList<Skill> za = (ArrayList)arr.clone();
            for (int i = 0; i < za.size(); i++) {
                for (int j = i; j < za.size(); j++) {
                    if (za.get(i).getName().compareTo(za.get(j).getName()) < 0) {
                        Skill temp = za.get(i);
                        za.set(i, za.get(j));
                        za.set(j, temp);
                    }
                }
            }
            request.setAttribute("z-a", za);
        } catch (Exception e) {
        }
        
        request.getRequestDispatcher("skill.jsp").forward(request, response);
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
        processRequest(request, response);
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
