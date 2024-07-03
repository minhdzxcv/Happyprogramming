/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.ScheduleDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;
import model.Slot;
import model.User;

/**
 *
 * @author HP
 */
public class NewScheduleDetails extends HttpServlet {

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
            out.println("<title>Servlet NewScheduleDetails</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet NewScheduleDetails at " + request.getContextPath() + "</h1>");
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
        User u = (User) request.getSession().getAttribute("email");
        if (u == null) {
            response.sendRedirect("signin");
            return;
        }
        int scheduleID = 0;
        try {
            scheduleID = Integer.parseInt(request.getParameter("scheduleID"));
        } catch (Exception e) {
            System.out.println("");
        }
        int slotId = 0;
        try {
            slotId = Integer.parseInt(request.getParameter("slotID"));
        } catch (Exception e) {
            System.out.println("");
        }
        String action = request.getParameter("action");
        action = action != null ? action : "";
        ScheduleDAO scheduleDao = new ScheduleDAO();
        switch (action) {
            case "edit":
//                Schedule schedule = scheduleDao.getScheduleById(scheduleID);
//                request.setAttribute("schedule", schedule);
//                request.getRequestDispatcher("editSchedule.jsp").forward(request, response);
                break;
            case "delete":
                scheduleDao.deleteSlotPending(slotId);
                response.sendRedirect("new-schedule-detail?scheduleID=" + scheduleID);
                break;
            default:
                List<Slot> slots = scheduleDao.getSlotsForScheduleById(scheduleID);
                request.setAttribute("scheduleID", scheduleID);
                request.setAttribute("slots", slots);
                request.getRequestDispatcher("scheduleNewDetails.jsp").forward(request, response);
                break;
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
        String[] selectedSlots = request.getParameterValues("selectedSlots");
        String scheduleId = request.getParameter("scheduleId");
        if (selectedSlots != null) {
            ScheduleDAO scheduleDAO = new ScheduleDAO();
            for (String slotId : selectedSlots) {
                int id = Integer.parseInt(slotId);
                scheduleDAO.deleteScheduleSlot(id);
            }
        }
        response.sendRedirect("new-schedule-detail?scheduleID=" + scheduleId);
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
