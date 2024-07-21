/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.MentorDAO;
import DAO.RateDAO;
import DAO.RequestDAO;
import DAO.ScheduleDAO;
import DAO.UserDAO;
import Service.AuthorizationService;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import model.MentorStatistic;
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
            if (!AuthorizationService.gI().Authorization(request, response)) {
                return;
            }
        } catch (Exception e) {
        }
        User u = (User) request.getSession().getAttribute("email");
        String type = request.getParameter("type");
        if (type != null) {
            switch (type) {
                case "cancel": {
                    if (u.getRole().equalsIgnoreCase("mentee")) {
                        if (request.getParameterValues("id") != null && request.getParameterValues("id").length < 2) {
                            String sid = request.getParameter("id");
                            if (sid != null && sid.equalsIgnoreCase("all")) {
                                try {
                                    RequestDAO.deleteAll(u.getId());
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                            } else if (sid != null) {
                                int id = Integer.parseInt(sid);
                                try {
                                    RequestDAO.deleteRequest(id, u.getId());
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                            }
                        } else if (request.getParameterValues("id") != null) {
                            String[] sid = request.getParameterValues("id");
                            for (int i = 0; i < sid.length; i++) {
                                int id = Integer.parseInt(sid[i]);
                                try {
                                    RequestDAO.deleteRequest(id, u.getId());
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                            }
                        }
                    }
                    break;
                }
                case "accept": {
                    if (u.getRole().equalsIgnoreCase("mentor")) {
                            String sid = request.getParameter("id");
                                try {
                                    int id = Integer.parseInt(sid);
                                    RequestDAO.acceptRequest(id, u.getId());
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                    }
                    break;
                }
                case "complete": {
                    if (u.getRole().equalsIgnoreCase("mentor")) {
                            String sid = request.getParameter("id");
                                try {
                                    int id = Integer.parseInt(sid);
                                    if(ScheduleDAO.getPercentByRequest(id) == 100) {
                                        int cash = RequestDAO.completeRequest(id, u.getId());
                                        //u.setWallet(u.getWallet() + cash);
                                    }
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }
                    }
                    break;
                }
            }
        }
        try {
            if (u.getRole().equalsIgnoreCase("mentee")) {
                ArrayList<Request> arr = RequestDAO.getMenteeRequests(u.getId());
                request.setAttribute("requests", arr);
            } else {
                MentorStatistic ms = MentorDAO.getMentorStatistic(u.getId());
                request.setAttribute("mstatistic", ms);
                ArrayList<Request> arr = RequestDAO.getMentorRequests(u.getId());
                request.setAttribute("requests", arr);
                request.getRequestDispatcher("mentorofrequest.jsp").forward(request, response);
                return;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        request.getRequestDispatcher("request.jsp").forward(request, response);
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
            response.sendRedirect("request");
            return;
        }
        String type = request.getParameter("type");
        if (type != null && type.equalsIgnoreCase("update")) {
            User u = (User) request.getSession().getAttribute("email");
            if (u == null || !u.getRole().equalsIgnoreCase("mentee")) {
                response.sendRedirect("home");
                return;
            }
            String[] skills = request.getParameterValues("skill");
            String deadline = request.getParameter("deadline");
            String subject = request.getParameter("subject");
            String reason = request.getParameter("reason");
            String status = request.getParameter("status");
            try {
                int id = Integer.parseInt(sid);
                SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd'T'hh:mm");
                Timestamp tm = Timestamp.from(formatter.parse(deadline).toInstant());
                boolean check = RequestDAO.updateRequest(skills, tm, subject, reason, u.getId(), status, id);
                if (check) {
                    request.setAttribute("status", "Success");
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("request");
                return;
            }
        } else if(type != null && type.equalsIgnoreCase("reject")) {
            User u = (User) request.getSession().getAttribute("email");
            if (u == null || !u.getRole().equalsIgnoreCase("mentor")) {
                response.sendRedirect("home");
                return;
            }
            try {
                int id = Integer.parseInt(sid);
                String reason = request.getParameter("reason");
                RequestDAO.rejectRequestF(id, u.getId(), reason);
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("request");
                return;
            }
        } else if(type != null && type.equalsIgnoreCase("rate")) {
            User u = (User) request.getSession().getAttribute("email");
            if (u == null || !u.getRole().equalsIgnoreCase("mentee")) {
                response.sendRedirect("request");
                return;
            }
            try {
                int id = Integer.parseInt(sid);
                String noStar = request.getParameter("noStar");
                int star = Integer.parseInt(noStar);
                String comment = request.getParameter("comment");
                RateDAO.Rating(id, star, comment);
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("request");
                return;
            }
        }  else if(type != null && type.equalsIgnoreCase("pay")) {
            User u = (User) request.getSession().getAttribute("email");
            if (u == null || !u.getRole().equalsIgnoreCase("mentee")) {
                response.sendRedirect("request");
                return;
            }
            try {
                int rid = Integer.parseInt(sid);
                int uid = Integer.parseInt(request.getParameter("uid"));
                int oid = Integer.parseInt(request.getParameter("oid"));
                RequestDAO.payment(rid, oid, uid);
                int slotCash = MentorDAO.getSlotCash(oid);
                int slots = RequestDAO.getSlots(rid);
                u.setWallet(u.getWallet() - (slotCash * slots));
                    request.getSession().setAttribute("email", u);
                UserDAO userDAO = new UserDAO();
                userDAO.updateWalletForRole2(slotCash * slots);
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect("request");
                return;
            }
        }
        response.sendRedirect("request");
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
