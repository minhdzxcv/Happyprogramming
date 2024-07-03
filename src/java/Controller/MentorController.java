/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Service.AuthorizationService;
import DAO.CvDAO;
import DAO.FollowDAO;
import DAO.MentorDAO;
import DAO.RateDAO;
import DAO.RequestDAO;
import DAO.ScheduleDAO;
import DAO.UserDAO;
import com.google.gson.Gson;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import model.CV;
import model.Mentor;
import model.Slot;
import model.User;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "MentorController", urlPatterns = {"/mentor"})
public class MentorController extends HttpServlet {

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
        } catch (Exception e) {
        }
        String sid = request.getParameter("id");
        String skillid = request.getParameter("sid");
        if (sid == null) {
            response.sendRedirect("home");
            return;
        }
        try {
            int id = Integer.parseInt(sid);
            Mentor m = MentorDAO.getMentor(id);
            UserDAO userDAO = new UserDAO();
            User um = userDAO.getUserById(id);
            String rate = "";
            int c = 0;
            for (int i = 1; i < m.getRate(); i++) {
                rate += "<i class=\"fas fa-star\"></i>\n";
                c++;
            }
            if (m.getRate() - Math.floor(m.getRate()) >= 0.5) {
                rate += "<i class=\"fas fa-star-half-alt\"></i>";
                c++;
            }
            while (c < 5) {
                rate += "<i class=\"far fa-star\"></i>";
                c++;
            }
            request.setAttribute("Rate", rate);
            request.setAttribute("CurrMentor", m);
            request.setAttribute("um", um);
            request.setAttribute("skillid", skillid);

            CV cv = CvDAO.getCV(m.getCvID());
            request.setAttribute("CurrCV", cv);
            java.util.Date today = new java.util.Date();
            Calendar calendar = Calendar.getInstance();
            calendar.setTime(today);
            int year = calendar.get(Calendar.YEAR);
            int week = ScheduleDAO.weekOfYear(today);
            request.setAttribute("year", year);
            request.setAttribute("week", week);
            Calendar firstDay = ScheduleDAO.FirstDateOfWeek(year, week);
            request.setAttribute("firstOfWeek", firstDay);
            request.setAttribute("Rates", RateDAO.getRates(id));
            ArrayList<Slot> arr = ScheduleDAO.getFreeSlots(new java.util.Date(), id);
            request.setAttribute("FreeSlot", arr);
            Gson gson = new Gson();
            request.setAttribute("jsonSlots", gson.toJson(arr));

        } catch (Exception e) {
            response.sendRedirect("home");
            return;
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
        } catch (Exception e) {
        }
        String sid = request.getParameter("id");
        if (sid == null) {
            response.sendRedirect("home");
            return;
        }
        User u = (User) request.getSession().getAttribute("email");
        if (u == null || !u.getRole().equalsIgnoreCase("mentee")) {
            request.setAttribute("status", "Bạn chưa đăng nhập hoặc không phải mentee!");
            request.getRequestDispatcher("mentor.jsp").forward(request, response);
            return;
        }
        String[] skills = request.getParameterValues("skill");
        String[] slots = request.getParameterValues("slot");
        String deadline = request.getParameter("deadline");
        String subject = request.getParameter("subject");
        String reason = request.getParameter("reason");
        try {
            int id = Integer.parseInt(sid);
            Mentor m = MentorDAO.getMentor(id);
            String rate = "";
            int c = 0;
            for (int i = 1; i < m.getRate(); i++) {
                rate += "<i class=\"fas fa-star\"></i>\n";
                c++;
            }
            if (m.getRate() - Math.floor(m.getRate()) >= 0.5) {
                rate += "<i class=\"fas fa-star-half-alt\"></i>";
                c++;
            }
            while (c < 5) {
                rate += "<i class=\"far fa-star\"></i>";
                c++;
            }
            request.setAttribute("Rate", rate);
            request.setAttribute("CurrMentor", m);
            CV cv = CvDAO.getCV(m.getCvID());
            request.setAttribute("CurrCV", cv);
            if (request.getParameter("type") != null) {
                if (request.getParameter("type").equalsIgnoreCase("follow")) {
                    String title = request.getParameter("title");
                    String FollowReason = request.getParameter("reason");
                    FollowDAO.sendRequest(id, title, FollowReason, u.getId());
                    request.getSession().setAttribute("alert", "Yêu cầu follow thành công!");
                } else if (request.getParameter("type").equalsIgnoreCase("unfollow")) {
                    FollowDAO.unFollow(id, u.getId());
                } else if (request.getParameter("type").equalsIgnoreCase("cancel follow")) {
                    FollowDAO.cancelFollowRequest(id, u.getId());
                }
                response.sendRedirect("mentor?id=" + id);
                return;
            } else {
                double amoutPay = RequestDAO.getMustPayAmount(u.getId());
                double totalForRequest = cv.getMoneyofslot() * slots.length;
                double amoutTotalMustPay = amoutPay + totalForRequest;
                if (u.getWallet() >= amoutTotalMustPay) {
                    SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd'T'hh:mm");
                    Timestamp tm = Timestamp.from(formatter.parse(deadline).toInstant());
                    boolean check = RequestDAO.createRequest(skills, tm, subject, reason, u.getId(), id, slots);
                    if (check) {
                        request.getSession().setAttribute("alert", "Gửi request thành công!");
                    } else {
                        request.getSession().setAttribute("alert", "Gửi request thất bại!");
                    }
                } else {
                    request.getSession().setAttribute("alert", "Số tiền của bạn không đủ để thực hiện. Vui lòng nạp thêm tiền vào tài khoản!");
                }
                response.sendRedirect("mentor?id=" + id);
                return;
            }
        } catch (Exception e) {
            request.getSession().setAttribute("alert", "Gửi request thất bại!");
        }
        response.sendRedirect("mentor?id=" + sid);
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
