package Controller;

import Service.AuthorizationService;
import DAO.UserDAO;
import Service.MailService;
import Service.RandomStringService;
import model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Date;
import java.util.Random;
import java.util.regex.Matcher;
import java.util.regex.Pattern;
import model.Mentor;

@WebServlet("/SignUpController")
public class SignUpController extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            if (!AuthorizationService.gI().Authorization(request, response)) {
                return;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        request.getRequestDispatcher("SignUp.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            if (!AuthorizationService.gI().Authorization(request, response)) {
                return;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        // Retrieve form parameters
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String dob = request.getParameter("dob");
        String address = request.getParameter("address");
        String fullname = request.getParameter("fullname");
        String gender = request.getParameter("gender");
        String repass = request.getParameter("repass");
        String role = request.getParameter("role");

        // Validate passwords match
        if (!repass.equals(password)) {
            request.getSession().setAttribute("alert", "Password does not match");
            request.getRequestDispatcher("SignUp.jsp").forward(request, response);
            return;
        }
         if (!isValidPhoneNumber(phone)) {
            request.getSession().setAttribute("alert", "Invalid phone number");
            request.getRequestDispatcher("SignUp.jsp").forward(request, response);
            return;
        }


        try {
            Date birthDate = Date.valueOf(dob);
            if (birthDate.after(new java.util.Date())) {
                request.getSession().setAttribute("alert", "Date of birth cannot be in the future");
                request.getRequestDispatcher("SignUp.jsp").forward(request, response);
                return;
            }

            // Register the user
            User user = UserDAO.register(username, password, email, phone, address, role, gender, fullname, dob);
            if (user == null) {
                request.getSession().setAttribute("alert", "Email or username has already been registered");
                request.getRequestDispatcher("SignUp.jsp").forward(request, response);
                return;
            }
            

            // Send recovery email
            UserDAO.isRegistered(email, username);
            String otp = generateOTP();
            sendRecoveryEmail(email, otp);

            HttpSession session = request.getSession();
            session.setAttribute("otp", otp);
            session.setAttribute("email", email);
            request.setAttribute("message", "Recovery code has been sent to your email");
            request.getRequestDispatcher("recoveryCodeSignUp.jsp").forward(request, response);

        } catch (Exception e) {
            e.printStackTrace();
            request.getSession().setAttribute("alert", "An error occurred during registration");
            request.getRequestDispatcher("SignUp.jsp").forward(request, response);
        }
    }

    private String generateOTP() {
        Random random = new Random();
        int num = random.nextInt(999999);
        return String.format("%06d", num);
    }

    private void sendRecoveryEmail(String email, String otp) {
        Thread emailThread = new Thread(() -> {
            try {
                MailService.sendMail(email, "Account registration code", "Here is your recovery code: " + otp);
            } catch (Exception e) {
                e.printStackTrace();
            }
        });
        emailThread.start();
    }

    @Override
    public String getServletInfo() {
        return "Sign Up Controller";
    }

    private boolean isValidPhoneNumber(String phone) {
        // Define a regex pattern for a valid phone number
        String regex = "^[+]?[0-9]{10,13}$";
        Pattern pattern = Pattern.compile(regex);
        Matcher matcher = pattern.matcher(phone);
        return matcher.matches();
    }
}