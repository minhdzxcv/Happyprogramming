/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.RequestDAO;
import Service.AuthorizationService;

import DAO.UserDAO;
import model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author ADMIN
 */
public class SignInController extends HttpServlet {

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
        Cookie[] cs = request.getCookies();
        for (int i = 0; i < cs.length; i++) {
            if (cs[i].getName().equals("email")) {
                String[] atr = cs[i].getValue().split("_");
                request.setAttribute("email", atr[0].replace("email|", ""));
                request.setAttribute("password", atr[1].replace("Pass|", ""));
                break;
            }
        }
        request.getRequestDispatcher("SignIn.jsp").forward(request, response);
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
        Cookie[] cs = request.getCookies();
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String remember = request.getParameter("remember");
        try {
            User u = UserDAO.getUser(email, password);
            if (u != null) {
                if (!u.isStatus()) {
                    throw new Exception("Tài khoản của bạn đã bị khóa bởi admin!");
                }
                request.getSession().setAttribute("email", u);
                if (remember != null) {
                    Cookie c = new Cookie("email", "email|" + email + "_Pass|" + password);
                    c.setMaxAge(60 * 24 * 7);
                    response.addCookie(c);
                } else {
                    for (int i = 0; i < cs.length; i++) {
                        if (cs[i].getName().equals("email")) {
                            cs[i].setMaxAge(0);
                            response.addCookie(cs[i]);
                            break;
                        }
                    }
                }
                if (u.getRole().equalsIgnoreCase("admin") || u.getRole().equalsIgnoreCase("manager")) {
                    request.setAttribute("error", "Please click on SignIn as administrator");
                } else {
                    RequestDAO requestDao = new RequestDAO();
                    double totalMustPay = requestDao.getMustPayAmountHold(u.getId());
                    double walletShow = u.getWallet() - totalMustPay < 0 ? 0 : u.getWallet() - totalMustPay;
                    request.getSession().setAttribute("holdMoney", walletShow);
                    response.sendRedirect("home");
                    return;
                }
            } else {
                request.setAttribute("error", "Invalid email or password");
            }
        } catch (Exception e) {
            request.setAttribute("error", e.getMessage());
        }
        for (int i = 0; i < cs.length; i++) {
            if (cs[i].getName().equals("email")) {
                String[] atr = cs[i].getValue().split("_");
                request.setAttribute("email", atr[0].replace("email|", ""));
                request.setAttribute("password", atr[1].replace("Pass|", ""));
                break;
            }
        }
        request.getRequestDispatcher("SignIn.jsp").forward(request, response);
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
