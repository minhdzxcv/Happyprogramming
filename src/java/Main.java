
import DAO.UserDAO;
import model.User;

public class Main {
    public static void main(String[] args) {
        try {
            int userId = 6;  // Giá trị ID người dùng bạn muốn truy xuất
            UserDAO userDAO = new UserDAO();
            User u = userDAO.getUserById(userId);
            
            if (u != null) {
                System.out.println("User ID: " + u.getId());
                System.out.println("Username: " + u.getFullname());
                // In ra các thuộc tính khác nếu cần
            } else {
                System.out.println("User not found with ID: " + userId);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
