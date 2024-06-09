package Controller;

import DAO.FollowDAO;
import DAO.UserDAO;
import Service.AuthorizationService;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import model.Mentee;
import model.Mentor;
import model.User;
import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "ProfileServlet", urlPatterns = {"/profile"})
@MultipartConfig(
        fileSizeThreshold = 1024 * 1024 * 1,
        maxFileSize = 1024 * 1024 * 10,
        maxRequestSize = 1024 * 1024 * 100
)
public class ProfileServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            if (!AuthorizationService.gI().Authorization(request, response)) {
                return;
            }
        } catch (Exception e) {
        }
        User user = (User) request.getSession().getAttribute("email");
        if (!UserDAO.isMentor(user)) {
            Mentee mentee = (Mentee) UserDAO.getRole(user.getId(), user.getRole());
            request.getSession().setAttribute("Mentee", mentee);
            request.setAttribute("following", FollowDAO.getFollowing(user.getId()));
            request.setAttribute("follower", new ArrayList());
        } else {
            Mentor mentor = (Mentor) UserDAO.getRole(user.getId(), user.getRole());
            request.getSession().setAttribute("Mentor", mentor);
            request.setAttribute("follower", FollowDAO.getFollower(user.getId()));
            request.setAttribute("following", new ArrayList());
        }
        request.getRequestDispatcher("profile.jsp").forward(request, response);
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
    } catch(Exception e) {}

    User u = (User) request.getSession().getAttribute("email");
    // Cập nhật thông tin người dùng trong cơ sở dữ liệu

    // Cập nhật thông tin người dùng
    String updatedFullName = request.getParameter("fullname");
    String updatedPhone = request.getParameter("phone");
    String updatedDob = request.getParameter("dob");
    String updatedAddress = request.getParameter("address");
    String updatedGender = request.getParameter("gender");
        System.out.println("date: "+updatedDob);

    // Cập nhật họ và tên nếu có
    if (updatedFullName != null && !updatedFullName.isEmpty()) {
        try {
            UserDAO.updateFullname(u.getId(), updatedFullName);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Cập nhật số điện thoại nếu có
    if (updatedPhone != null && !updatedPhone.isEmpty() && !u.getPhone().equals(updatedPhone)) {
        // Kiểm tra xem số điện thoại có chứa ký tự không phải số không
        boolean isPhone = true;
        for (int i = 0; i < updatedPhone.length(); i++) {
            if (!(updatedPhone.charAt(i) >= '0' && updatedPhone.charAt(i) <= '9')) {
                isPhone = false;
                break;
            }
        }
        // Nếu số điện thoại hợp lệ, tiến hành cập nhật
        if (isPhone) {
            try {
                UserDAO.updatePhone(u.getId(), updatedPhone);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    // Cập nhật ngày sinh nếu có
     if (updatedDob != null && !updatedDob.isEmpty() && !u.getDob().equals(updatedDob)) {
            try {
                UserDAO.updateDob(u.getId(), updatedDob);
             
            } catch (Exception e) {
              
            }
        }

    // Cập nhật địa chỉ nếu có
    if (updatedAddress != null && !updatedAddress.isEmpty() && !u.getAddress().equals(updatedAddress)) {
        try {
            UserDAO.updateAddress(u.getId(), updatedAddress);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // Cập nhật giới tính nếu có
    if (updatedGender != null && !updatedGender.isEmpty()) {
        boolean isFemale = updatedGender.equalsIgnoreCase("female");
        if (isFemale != u.isGender()) {
            try {
                UserDAO.updateGender(u.getId(), isFemale);
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    }

    // Cập nhật ảnh đại diện nếu có
     if (request.getPart("avatar") != null) {
    try {
        Part avatarPart = request.getPart("avatar");
        
        // Check file size
        long fileSize = avatarPart.getSize();
        if (fileSize > 800 * 1024) { // 800KB limit
            throw new IllegalArgumentException("File size exceeds the limit.");
        }
        
        // Read the image from the input stream
        BufferedImage img = ImageIO.read(avatarPart.getInputStream());
        
        // Define file paths
        String relativePath = "avatar";
        String absolutePath = request.getServletContext().getRealPath(relativePath);
        
        // Ensure the directory exists
        File directory = new File(absolutePath);
        if (!directory.exists()) {
            directory.mkdirs(); // Create directories if not exist
        }
        
        // Generate unique file name based on user info
        String fileName = u.getUsername() + "_" + u.getId() + ".jpg";
        
        // Write the image to the file
        File outputFile = new File(directory, fileName);
        ImageIO.write(img, "jpg", outputFile);
        
        // Update the user's avatar path in the database
        String avatarPath = relativePath + "/" + fileName;
        UserDAO.updateAvatar(u.getId(), avatarPath);
        
        // Update user object
        u.setAvatar(avatarPath);
        
        // Update session attribute
        request.getSession().setAttribute("email", u);
        
        // Redirect to profile page
        response.sendRedirect("profile");
        return;
    } catch (Exception e) {
        e.printStackTrace(); // Log the error for debugging
        request.setAttribute("alert", "Vui lòng chọn file hợp lệ (JPG, GIF, hoặc PNG, kích thước tối đa 800KB).");
    }
     }

// If the code reaches here, either no avatar was uploaded or an error occurred
// Handle accordingly


    // Cập nhật thông tin người dùng trong session nếu có
    try {
        u = UserDAO.getUser(u.getEmail(), u.getPassword());
        request.getSession().setAttribute("email", u);
    } catch(Exception e) {
        e.printStackTrace();
    }

    // Chuyển hướng về trang profile
    response.sendRedirect("profile");
}

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
