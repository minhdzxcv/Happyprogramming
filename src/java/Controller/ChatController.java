/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.ConversationDAO;
import Service.AuthorizationService;
import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import model.Conversation;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.ArrayList;
import model.Message;
import model.User;

/**
 *
 * @author TGDD
 */
@WebServlet(name = "ChatController", urlPatterns = {"/chat"})
public class ChatController extends HttpServlet {

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
            User u = (User) request.getSession().getAttribute("email");
            if (request.getParameter("id") != null) {
                int id = Integer.parseInt(request.getParameter("id"));
                Conversation c = ConversationDAO.getConversation(u.getId(), id);
                if (c == null) {
                    ConversationDAO.CreateConversation(u.getId(), id, u.getRole().equalsIgnoreCase("mentor"));
                    c = ConversationDAO.getConversation(u.getId(), id);
                }
                request.setAttribute("currConver", c);
                ArrayList<Message> Msg = ConversationDAO.getMessages(u.getId(), id);
                request.setAttribute("message", Msg);
            } else {
                Conversation c = ConversationDAO.getLastConversation(u.getId());
                request.setAttribute("currConver", c);
                ArrayList<Message> Msg = ConversationDAO.getMessages(c.getMentorID(), c.getMenteeID());
                request.setAttribute("message", Msg);
            }
            ArrayList<Conversation> arr = ConversationDAO.getConversation(u.getId());
            request.setAttribute("conversation", arr);
        } catch (Exception e) {
        }
        request.getRequestDispatcher("chat.jsp").forward(request, response);
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
        response.setContentType("application/json");
        if (request.getParameter("getMsg") == null && request.getParameter("getCon") == null) {
            String msg = request.getParameter("msg");
            String cid = request.getParameter("cid");
            String sid = request.getParameter("sid");
            Gson gson = new Gson();
            try {
                ConversationDAO.createMessage(Integer.parseInt(sid), Integer.parseInt(cid), msg);
                ArrayList<Message> arr = ConversationDAO.getMessagesByCID(Integer.parseInt(cid));
                PrintWriter print = response.getWriter();
                print.println(gson.toJson(arr));
            } catch (Exception e) {
            }
        } else if (request.getParameter("getMsg") == null) {
            String sid = request.getParameter("sid");
            Gson gson = new Gson();
            try {
                ArrayList<Conversation> arr = ConversationDAO.getConversation(Integer.parseInt(sid));
                PrintWriter print = response.getWriter();
                print.println(gson.toJson(arr));
            } catch (Exception e) {
            }
        } else {
            String cid = request.getParameter("cid");
            Gson gson = new Gson();
            try {
                ArrayList<Message> arr = ConversationDAO.getMessagesByCID(Integer.parseInt(cid));
                PrintWriter print = response.getWriter();
                print.println(gson.toJson(arr));
            } catch (Exception e) {
            }
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
