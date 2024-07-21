/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.ScheduleDAO;
import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import model.Schedule;
import model.Slot;
import model.User;

/**
 *
 * @author HP
 */
@WebServlet(name = "ScheduleApiController", urlPatterns = {"/getSlotToEditNew"})
public class ScheduleApiServlet extends HttpServlet {

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
            out.println("<title>Servlet ScheduleApiServlet</title>");
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet ScheduleApiServlet at " + request.getContextPath() + "</h1>");
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
        ScheduleDAO scheduleDao = new ScheduleDAO();
        int slotId = Integer.parseInt(request.getParameter("sid"));
        Slot slot = scheduleDao.getSlotById(slotId);

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();
        Gson gson = new Gson();
        String json = gson.toJson(slot);
        out.print(json);
        out.flush();
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
            User u = (User) request.getSession().getAttribute("email");
            String sid = request.getParameter("id");
            String scheduleId = request.getParameter("scheduleId");
            int id = Integer.parseInt(sid);
            int scheduleIdNumber = Integer.parseInt(scheduleId);
            String link = request.getParameter("link");
            String start = request.getParameter("start");
            String hour = request.getParameter("hour");
            String time = request.getParameter("time");
            start += "T" + time;
            float hours = Float.parseFloat(hour);
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd'T'hh:mm");
            java.util.Date startDate = format.parse(start);
            Timestamp startTime = Timestamp.from(startDate.toInstant());
            int weekOfYear = ScheduleDAO.weekOfYear(startDate);
            Schedule schedule = ScheduleDAO.getScheduleByIdAndSlot(u.getId(), scheduleIdNumber);
            Calendar c = Calendar.getInstance();
            int year = c.get(Calendar.YEAR);
            if (schedule.getWeek() == weekOfYear && year == schedule.getYear()) {
                ScheduleDAO.updateSlotSchedule(id, link, hours, startTime, scheduleIdNumber);
            } else {
                Schedule sche = new Schedule(id, u.getId(), year, weekOfYear, "New");
                int scheId = ScheduleDAO.createSchedule(sche);
                ScheduleDAO.updateSlotNew(id, link, hours, startTime, scheId);
            }
            response.sendRedirect("new-schedule-detail?scheduleID=" + scheduleId);
        } catch (Exception e) {
            System.out.println("Ex: " + e);
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
