/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.RequestDAO;
import DAO.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.ArrayList;
import model.Request;
import model.User;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "RequestServlet", urlPatterns = {"/request"})
public class RequestServlet extends HttpServlet {

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
            HttpSession session = request.getSession(false);
            if (session == null || session.getAttribute("user") == null) {
                // User is not signed in, redirect to the sign-in page
                request.getRequestDispatcher("SignIn.jsp").forward(request, response);
                return;
            }
            String email = (String) request.getSession().getAttribute("email");
            String password = (String) request.getSession().getAttribute("password");
            User user = UserDAO.getUser(email, password);
            int userId = user.getId();
            if (UserDAO.isMentor(user)) {
                // Handle requests from mentors
                handleMentorRequest(request, response, userId);
            } else if (UserDAO.isMentee(user)) {
                // Handle requests from mentees
                handleMenteeRequest(request, response, userId);
            }
        } catch (Exception e) {
        }
    }

    private void handleMentorRequest(HttpServletRequest request, HttpServletResponse response, int userId)
            throws ServletException, IOException {
        // Retrieve all available skills from the SkillDAO
        try {
            request.setAttribute("role", "mentor");
            ArrayList<Request> requests = RequestDAO.getMentorRequests(userId);
            request.setAttribute("requests", requests);
            request.getRequestDispatcher("request.jsp").forward(request, response);
        } catch (Exception e) {
        }

    }

    private void handleMenteeRequest(HttpServletRequest request, HttpServletResponse response, int userId)
            throws ServletException, IOException {
        try {
            request.setAttribute("role", "mentee");
            ArrayList<Request> requests = RequestDAO.getMenteeRequests(userId);
            request.setAttribute("requests", requests);
            request.getRequestDispatcher("request.jsp").forward(request, response);
        } catch (Exception e) {
            e.printStackTrace();
        }
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
        if (request.getSession().getAttribute("email") == null) {
            request.getRequestDispatcher("SignIn.jsp").forward(request, response);
        } else {
            User user = (User) request.getSession().getAttribute("email");
            int userId = ((User) request.getSession().getAttribute("email")).getId();
            if (UserDAO.isMentor(user)) {
                // Handle requests from mentors
                handleMentorRequest(request, response, userId);
            } else if (UserDAO.isMentee(user)) {
                // Handle requests from mentees
                handleMenteeRequest(request, response, userId);
            }
        }

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
