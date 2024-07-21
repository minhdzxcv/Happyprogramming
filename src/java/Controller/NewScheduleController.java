/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.ScheduleDAO;
import DAO.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Schedule;
import model.User;

/**
 *
 * @author HP
 */
@WebServlet(name = "NewScheduleController", urlPatterns = {"/new-schedule"})
public class NewScheduleController extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet NewScheduleController</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet NewScheduleController at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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
        try {
            User u = (User) request.getSession().getAttribute("email");
            if (u == null) {
                response.sendRedirect("signin");
                return;
            }
            UserDAO userDao = new UserDAO();
            ScheduleDAO scheduleDao = new ScheduleDAO();
            List<Schedule> schedules = scheduleDao.getAllSchedulesWithNewSlots(u.id);
            request.setAttribute("schedulesNew", schedules);
            request.getRequestDispatcher("schedulesNew.jsp").forward(request, response);
        } catch (Exception e) {

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
        try {
            String action = request.getParameter("action");
            action = action != null ? action : "";
            String[] selectedScheduleIDs = request.getParameterValues("scheduleID");
            ScheduleDAO scheduleDao = new ScheduleDAO();
            switch (action) {
                case "delete":
                    if (selectedScheduleIDs != null) {
                        for (String scheduleID : selectedScheduleIDs) {
                            scheduleDao.deleteSchedule(Integer.parseInt(scheduleID));
                        }
                    }
                    response.sendRedirect("new-schedule?success=Delete shedule successfully");
                    break;
                default:
                    if (selectedScheduleIDs != null) {
                        for (String scheduleID : selectedScheduleIDs) {
                            scheduleDao.SendToAdminSchedule(Integer.parseInt(scheduleID));
                        }
                    }
                    response.sendRedirect("new-schedule?success=Send to admin successfully");
            }
        } catch (Exception e) {
            response.sendRedirect("new-schedule?error=Error while process");
        }
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
