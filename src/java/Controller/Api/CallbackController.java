/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller.Api;

import DAO.BankDAO;
import DAO.UserDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.User;

/**
 *
 * @author TGDD
 */
@WebServlet(name = "CallbackController", urlPatterns = {"/callback"})
public class CallbackController extends HttpServlet {

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

        String sAmount = request.getParameter("vnp_Amount");
        String vpn_TxnRef = request.getParameter("vnp_TxnRef");
        String status = request.getParameter("vnp_ResponseCode");
        String vnp_TransactionStatus = request.getParameter("vnp_TransactionStatus");
        int returnVal = 0;
        if (status.equals("00") && vnp_TransactionStatus.equals("00")) {
            returnVal = 1;
            try {
                int uid = BankDAO.UpdateTrans(vpn_TxnRef, "Success");
                if (uid != -1) {
                    User u = (User) request.getSession().getAttribute("email");
                    if (u != null && u.getId() == uid) {
                        UserDAO.updateMoney(uid, u.getWallet() + (Integer.parseInt(sAmount) / 100));
                        u.setWallet(u.getWallet() + (Integer.parseInt(sAmount) / 100));
                    } else {
                        UserDAO.updateMoney(uid, UserDAO.getWallet(uid) + (Integer.parseInt(sAmount) / 100));
                    }
                } else {
                    returnVal = 0;
                }
            } catch (Exception e) {
                try {
                    BankDAO.UpdateTrans(vpn_TxnRef, "Fail");
                } catch (Exception ex) {
                }
            }
        } else {
            try {
                BankDAO.UpdateTrans(vpn_TxnRef, "Fail");
            } catch (Exception e) {
            }
        }
        response.sendRedirect("wallet?callback=" + returnVal);
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
     * @param request servlet requests
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
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
