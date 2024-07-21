/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */

package Controller.admin;

import Service.AuthorizationService;
import DAO.RequestDAO;
import DAO.RequestStatusDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import model.Request;
import model.RequestStatus;
import model.User;

/**
 *
 * @author TGDD
 */
public class AdminRequestController extends HttpServlet {
   
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
            ArrayList<Request> requests = (ArrayList)RequestDAO.getRequests();
            ArrayList<RequestStatus> status = (ArrayList)RequestStatusDAO.getStatus();
            request.setAttribute("requests", requests);
            request.setAttribute("status", status);
        } catch(Exception e) {
        }
        request.getRequestDispatcher("request.jsp").forward(request, response);
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
            ArrayList<Request> requests = (ArrayList)RequestDAO.getRequests();
            ArrayList<RequestStatus> status = (ArrayList)RequestStatusDAO.getStatus();
            if(request.getParameter("search") != null && !request.getParameter("search").isEmpty()) {
                for (int i = 0; i < requests.size(); i++) {
                    if(!requests.get(i).getSubject().contains(request.getParameter("search"))) {
                        requests.remove(i);
                        i--;
                    }
                }
            }
            if(request.getParameter("status") != null && !request.getParameter("status").isEmpty()) {
                for (int i = 0; i < requests.size(); i++) {
                    if(!requests.get(i).getStatus().equalsIgnoreCase(request.getParameter("status"))) {
                        requests.remove(i);
                        i--;
                    }
                }
            }
            if(request.getParameter("start") != null && !request.getParameter("start").isEmpty()) {
                SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd'T'hh:mm");
                Timestamp tm = Timestamp.from(formatter.parse(request.getParameter("start")).toInstant());
                for (int i = 0; i < requests.size(); i++) {
                    if(requests.get(i).getRequestTime().before(tm)) {
                        requests.remove(i);
                        i--;
                    }
                }
            }
            if(request.getParameter("end") != null && !request.getParameter("end").isEmpty()) {
                SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd'T'hh:mm");
                Timestamp tm = Timestamp.from(formatter.parse(request.getParameter("end")).toInstant());
                for (int i = 0; i < requests.size(); i++) {
                    if(requests.get(i).getDeadlineTime().after(tm)) {
                        requests.remove(i);
                        i--;
                    }
                }
            }
            request.setAttribute("requests", requests);
            request.setAttribute("status", status);
        } catch(Exception e) {
            e.printStackTrace();
        }
        request.getRequestDispatcher("request.jsp").forward(request, response);
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
