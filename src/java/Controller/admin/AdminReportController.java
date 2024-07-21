/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller.admin;

import DAO.ReportDAO;
import Service.AuthorizationService;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import model.Report;

/**
 *
 * @author TGDD
 */
@WebServlet(name="AdminReportController", urlPatterns={"/admin/report"})
public class AdminReportController extends HttpServlet {
   
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
        if(request.getParameter("type") != null && request.getParameter("type").equalsIgnoreCase("solved")) {
            String sid = request.getParameter("id");
            int id = Integer.parseInt(sid);
            ReportDAO.solvedReport(id);
        }
            request.setAttribute("reports", ReportDAO.getReports());
        } catch(Exception e) {}
        request.getRequestDispatcher("report.jsp").forward(request, response);
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
        try {
    ArrayList<Report> arr = ReportDAO.getReports();
       if(request.getParameter("search") != null) {
    String search = request.getParameter("search");
    for (int i = 0; i < arr.size(); i++) {
        if(!arr.get(i).getContent().contains(search)) {
            arr.remove(i);
            i--;
        }
    }
}
if(request.getParameter("status") != null) {
    String status = request.getParameter("status");
    for (int i = 0; i < arr.size(); i++) {
        if(!arr.get(i).getStatus().equalsIgnoreCase(status)) {
            arr.remove(i);
            i--;
        }
    }
}

            request.setAttribute("reports", arr);
        } catch(Exception e) {}
        request.getRequestDispatcher("report.jsp").forward(request, response);
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
