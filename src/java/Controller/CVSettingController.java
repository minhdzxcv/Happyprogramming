/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import Service.AuthorizationService;
import DAO.CvDAO;
import DAO.MentorDAO;
import DAO.SkillDAO;
import DAO.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import java.util.Iterator;
import model.Mentor;
import model.Skill;
import model.User;

/**
 *
 * @author TGDD
 */
@WebServlet(name = "CVSettingController", urlPatterns = {"/cv"})
public class CVSettingController extends HttpServlet {

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
        try {
            ArrayList<Skill> a = SkillDAO.getAll(true);
            request.setAttribute("skills", a); //All skill
        } catch (Exception e) {
        }
        request.getRequestDispatcher("cv.jsp").forward(request, response);
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
        User u = (User) request.getSession().getAttribute("User");
        Mentor m = (Mentor) UserDAO.getRole(u.getId(), u.getRole());
        String type = request.getParameter("type");
        if (type == null) {
            String achivement = request.getParameter("achivement");
            if (m == null || (achivement != null && !achivement.isEmpty() && (m.getAchivement() == null || !m.getAchivement().equals(achivement)))) {
                try {
                    MentorDAO.updateAchivement(u.getId(), achivement);
                } catch (Exception e) {
                }
            }
            String descripttion = request.getParameter("description");
            if (m == null || (descripttion != null && !descripttion.isEmpty() && (m.getDescription() == null || !m.getDescription().equals(descripttion)))) {
                try {
                    MentorDAO.updateDescription(u.getId(), descripttion);
                } catch (Exception e) {
                }
            }
        } else {
            if(type.equalsIgnoreCase("create")) {
                String Profession = request.getParameter("profession");
                String Service = request.getParameter("service");
                String[] skills = request.getParameterValues("skills");
                String sCash = request.getParameter("cash");
                int cash = Integer.parseInt(sCash);
                try {
                    CvDAO.createCV(u.getId(), Profession, Service, skills, cash);
                } catch(Exception e) {}
            } else if(type.equalsIgnoreCase("update")) {
                String Profession = request.getParameter("profession");
                String Service = request.getParameter("service");
                String CashPerSlot = request.getParameter("cashPerSlot");
                if(Profession != null && !Profession.isEmpty() && Service != null && !Service.isEmpty() && CashPerSlot != null && !CashPerSlot.isEmpty()) {
                try {
                    int CashPS = Integer.parseInt(CashPerSlot);
                    CvDAO.updateCV(m.getCvID(), Profession, Service, CashPS);
                    
                } catch(Exception e) {
                    e.printStackTrace();
                }
                }
            } else if(type.equalsIgnoreCase("delete")) {
                String sid = request.getParameter("id");
                int id = Integer.parseInt(sid);
                try {
                    CvDAO.removeSkill(u.getId(), id);
                } catch(Exception e) {
                    
                }
            } else if(type.equalsIgnoreCase("add")) {
                String sid = request.getParameter("id");
                int id = Integer.parseInt(sid);
                try {
                    CvDAO.addSkill(u.getId(), id);
                } catch(Exception e) {
                    
                }
            }
        }
        Mentor r = (Mentor) UserDAO.getRole(u.getId(), u.getRole());
        request.getSession().setAttribute("Mentor", r);
        response.sendRedirect("cv");
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
