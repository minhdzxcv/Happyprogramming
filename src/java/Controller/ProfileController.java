/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.FollowDAO;
import Service.AuthorizationService;
import DAO.UserDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.awt.image.BufferedImage;
import java.io.File;
import java.util.ArrayList;
import javax.imageio.ImageIO;
import model.Mentee;
import model.Mentor;
import model.User;

/**
 *
 * @author TGDD
 */
@WebServlet(name = "ProfileController", urlPatterns = {"/profile"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 1,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 100
)
public class ProfileController extends HttpServlet {

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
        User u = (User) request.getSession().getAttribute("User");
        if (!UserDAO.isMentor(u)) {
            Mentee r = (Mentee) UserDAO.getRole(u.getId(), u.getRole());
            request.getSession().setAttribute("Mentee", r);
            request.setAttribute("following", FollowDAO.getFollowing(u.getId()));
            request.setAttribute("follower", new ArrayList());
        } else {
            Mentor r = (Mentor) UserDAO.getRole(u.getId(), u.getRole());
            request.getSession().setAttribute("Mentor", r);
            request.setAttribute("follower", FollowDAO.getFollower(u.getId()));
            request.setAttribute("following", new ArrayList());
        }
        request.getRequestDispatcher("profile.jsp").forward(request, response);
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
        //Update fullname
        String fullname = request.getParameter("fullname");
        if (fullname != null && !fullname.isEmpty()) {
            try {
                UserDAO.updateFullname(u.getId(), fullname);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        //Update Phone
        String sdt = request.getParameter("sdt");
        if (sdt != null && !(sdt.isEmpty() || u.getPhone().equals(sdt))) {
            //Phone validate
            boolean isPhone = true;
            for (int i = 0; i < sdt.length(); i++) {
                if (!(sdt.charAt(i) >= '0' && sdt.charAt(i) <= '9')) {
                    isPhone = false;
                    break;
                }
            }
            //End Phone validate
            if (isPhone) {
                try {
                    UserDAO.updatePhone(u.getId(), sdt);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
        //Update Date Of Birth
        String dob = request.getParameter("dob");
        if (dob != null && !(dob.isEmpty() || u.getDob().equals(dob))) {
            try {
                UserDAO.updateDob(u.getId(), dob);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        //Update address
        String address = request.getParameter("address");
        if (address != null && !(address.isEmpty() || u.getAddress().equals(address))) {

            try {
                UserDAO.updateAddress(u.getId(), address);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        //Update gender
        String gender = request.getParameter("gender");
        if (gender != null && !gender.isEmpty()) {
            if (gender.equalsIgnoreCase("male") && u.isGender()) {
                try {
                    UserDAO.updateGender(u.getId(), false);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            } else if (gender.equalsIgnoreCase("female") && !u.isGender()) {
                try {
                    UserDAO.updateGender(u.getId(), true);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }
        //Update avatar
        if(request.getPart("avt") != null) {
            try {
                Part avt = request.getPart("avt");
                BufferedImage img = ImageIO.read(avt.getInputStream());
                String path = request.getServletContext().getRealPath("/avatar");
                String realpath = request.getServletContext().getRealPath("/avatar").replace("\\build\\web\\avatar", "\\web\\avatar");
                File outputfile = new File(path+"/"+u.getUsername()+"_"+u.getId()+".png");
                ImageIO.write(img, "png", outputfile);
                File realoutputfile = new File(realpath+"/"+u.getUsername()+"_"+u.getId()+".png");
                ImageIO.write(img, "png", realoutputfile);
                try {
                    UserDAO.updateAvatar(u.getId(), "avatar"+"/"+u.getUsername()+"_"+u.getId()+".png");
                    u.setAvatar("avatar"+"/"+u.getUsername()+"_"+u.getId()+".png");
                    request.getSession().setAttribute("User", u);
                } catch (Exception e) {
                }
                response.sendRedirect("profile");
                return;
            } catch(Exception e) {
                request.setAttribute("alert", "Vui lòng lòng chọn file hợp lệ");
            }
        }
        try {
            u = UserDAO.getUser(u.getUsername(), u.getPassword());
            request.getSession().setAttribute("User", u);
        } catch(Exception e) {
            
        }
        response.sendRedirect("profile");
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
