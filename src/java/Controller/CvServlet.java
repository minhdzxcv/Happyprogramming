/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.CvDAO;
import DAO.MentorDAO;
import DAO.SkillDAO;
import DAO.UserDAO;
import Service.AuthorizationService;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import model.Mentor;
import model.Skill;
import model.User;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "CvServlet", urlPatterns = {"/cv"})
public class CvServlet extends HttpServlet {

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
        } catch (Exception e) {
        }
        User u = (User) request.getSession().getAttribute("email");
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
            if (type.equalsIgnoreCase("create")) {
                String ProfessionIntro = request.getParameter("profession");
                String Description = request.getParameter("service");
                String[] skills = request.getParameterValues("skills");
                String sMoney = request.getParameter("cash");
                int money = Integer.parseInt(sMoney);
                try {
                    CvDAO.createCV(u.getId(), ProfessionIntro, Description, skills, money);
                } catch (Exception e) {
                }
            }
            if (type.equals("sendToAdmim")) {
                String cvid = request.getParameter("id");
                System.out.println(cvid);
                try {
                    CvDAO.sendToAdmim(cvid);
                } catch (Exception e) {
                    System.out.println("Send to admin: " + e);
                }
            } else if (type.equalsIgnoreCase("update")) {
                String Profession = request.getParameter("profession");
                String Descrip = request.getParameter("descrip");
                String MoneyOfSlot = request.getParameter("MoneyOfSlot");
                if (Profession != null && !Profession.isEmpty() && Descrip != null && !Descrip.isEmpty() && MoneyOfSlot != null && !MoneyOfSlot.isEmpty()) {
                    try {
                        int Money = Integer.parseInt(MoneyOfSlot);
                        CvDAO.updateCV(m.getCvID(), Profession, Descrip, Money);
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            } else if (type.equalsIgnoreCase("delete")) {
                String sid = request.getParameter("id");
                int id = Integer.parseInt(sid);
                try {
                    CvDAO.removeSkill(u.getId(), id);
                } catch (Exception e) {

                }
            } else if (type.equalsIgnoreCase("add")) {
                String sid = request.getParameter("id");
                int id = Integer.parseInt(sid);
                try {
                    CvDAO.addSkill(u.getId(), id);
                } catch (Exception e) {

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
