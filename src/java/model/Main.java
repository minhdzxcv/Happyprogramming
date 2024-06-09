import model.Mentor;
import DAO.MentorDAO;

public class Main {
    public static void main(String[] args) {
        // ID của mentor bạn muốn lấy thông tin (thay đổi ID cho phù hợp với cơ sở dữ liệu của bạn)
        int mentorId = 6;
        
        // Lấy thông tin mentor từ cơ sở dữ liệu
        Mentor mentor = MentorDAO.getMentor(mentorId);
        
        // Kiểm tra nếu mentor tồn tại và in ra tên của mentor
        if (mentor != null) {
            System.out.println("Tên của mentor là: " + mentor.getFullname());
        } else {
            System.out.println("Không tìm thấy mentor với ID: " + mentorId);
        }
    }
}
