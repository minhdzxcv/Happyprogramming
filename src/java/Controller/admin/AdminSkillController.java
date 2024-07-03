/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.admin;

import Service.AuthorizationService;
import DAO.SkillDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import model.Skill;
import jakarta.servlet.http.Part;
import java.awt.image.BufferedImage;
import java.io.File;
import javax.imageio.ImageIO;

/**
 *
 * @author TGDD
 */
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 1,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 100
)
public class AdminSkillController extends HttpServlet {

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
        if (request.getParameter("toggleid") != null && request.getParameter("toggle") != null) {
            try {
                int id = Integer.parseInt(request.getParameter("toggleid"));
                boolean type = request.getParameter("toggle").equalsIgnoreCase("on");
                SkillDAO.toggle(type, id);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        try {
            ArrayList<Skill> skills = (ArrayList) SkillDAO.getAll();
            request.setAttribute("skills", skills);
        } catch (Exception e) {
        }
        request.getRequestDispatcher("skill.jsp").forward(request, response);
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
        if (request.getParameter("id") == null) {
            if (request.getParameter("name") != null && !request.getParameter("name").isEmpty()) {
                String name = request.getParameter("name");
                String status = request.getParameter("status");
                Part avatar = request.getPart("avatar");
                String description = request.getParameter("description");
                BufferedImage img = ImageIO.read(avatar.getInputStream());
                String path = request.getServletContext().getRealPath("/skill");
                String realpath = request.getServletContext().getRealPath("/avatar").replace("\\build\\web\\avatar", "\\web\\avatar");
                File outputfile = new File(path + "/" + name + "_skill.png");
                ImageIO.write(img, "png", outputfile);
                File realoutputfile = new File(realpath + "/" + name + "_skill.png");
                ImageIO.write(img, "png", realoutputfile);
                try {
                    SkillDAO.createSkill(name, status.equalsIgnoreCase("active"), "skill/" + name + "_skill.png", description);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        } else {
            if (request.getParameter("name") != null && !request.getParameter("name").isEmpty()) {
                String sid = request.getParameter("id");
                String name = request.getParameter("name");
                String status = request.getParameter("status");
                Part avatar = request.getPart("avatar");
                String description = request.getParameter("description");
                String avt = null;
                if (avatar != null) {
                    BufferedImage img = ImageIO.read(avatar.getInputStream());
                    String path = request.getServletContext().getRealPath("/skill");
                    String realpath = request.getServletContext().getRealPath("/avatar").replace("\\build\\web\\avatar", "\\web\\avatar");
                    File outputfile = new File(path + "/" + name + "_skill.png");
                    ImageIO.write(img, "png", outputfile);
                    File realoutputfile = new File(realpath + "/" + name + "_skill.png");
                    ImageIO.write(img, "png", realoutputfile);
                    avt = "skill/" + name + "_skill.png";
                }
                try {
                    int id = Integer.parseInt(sid);
                    SkillDAO.UpdateSkill(id, name, status.equalsIgnoreCase("active"), avt, description);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
        try {
            ArrayList<Skill> skills = (ArrayList) SkillDAO.getAll();
            request.setAttribute("skills", skills);
        } catch (Exception e) {
        }
        request.getRequestDispatcher("skill.jsp").forward(request, response);
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
