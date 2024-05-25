








/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DataConnector.DatabaseUtil;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import model.Mentee;
import model.Mentor;

import model.User;

/**
 *
 * @author TGDD
 */
public class UserDAO {

    public static int getWallet(int uid) throws Exception {
        Connection dbo = DatabaseUtil.getConn();
        int wallet = 0;
        try {
            PreparedStatement ps = dbo.prepareStatement("SELECT [wallet] FROM [User] WHERE [UserID] = ?");
            ps.setInt(1, uid);
            ResultSet rs = ps.executeQuery();
            rs.next();
            wallet = rs.getInt("wallet");
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            dbo.close();
        }
        return wallet;
    }

    public static boolean verifyAccount(int uid, String email) throws Exception {
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("UPDATE [User] SET [isValidate] = 1, [email] = ? WHERE [UserID] = ?");
            ps.setString(1, email);
            ps.setInt(2, uid);
            int k = ps.executeUpdate();
            dbo.commit();
            dbo.close();
            if (k > 0) {
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            dbo.close();
        }
        return false;
    }

   

    public static boolean changePass(int id, String old, String newPass) throws Exception {
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("SELECT [password] FROM [User] WHERE [UserID] = ?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            rs.next();
            if (old.equals(rs.getString("password"))) {
                ps.close();
                ps = dbo.prepareStatement("UPDATE [User] SET [password] = ? WHERE [UserID] = ?");
                ps.setString(1, newPass);
                ps.setInt(2, id);
                ps.executeUpdate();
                dbo.commit();
                rs.close();
                ps.close();
                dbo.close();
                return true;
            }
            rs.close();
            ps.close();
            dbo.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;
    }

   

    public static boolean changePassword(String email, String password) throws Exception {
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("SELECT * FROM [User] WHERE [email] = ?");
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                if (rs.getString("password").equals(password)) {
                    ps.close();
                    rs.close();
                    dbo.close();
                    return false;
                }
            }
            ps.close();
            rs.close();
            ps = dbo.prepareStatement("UPDATE [User] SET [password] = ? WHERE [email] = ?");
            ps.setString(1, password);
            ps.setString(2, email);
            int k = ps.executeUpdate();
            dbo.commit();
            if (k > 0) {
                ps.close();
                dbo.close();
                return true;
            }
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            dbo.close();
        }
        return false;
    }

    public static boolean isMentor(User u) {
        if (u.getRole().equalsIgnoreCase("Mentor")) {
            return true;
        }
        return false;
    }

    public static boolean isMentee(User u) {
        if (u.getRole().equalsIgnoreCase("Mentee")) {
            return true;
        }
        return false;
    }

    public static void updateAddress(int id, String address) throws Exception {
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("UPDATE [User] SET [address] = ? WHERE [UserID] = ?");
            ps.setString(1, address);
            ps.setInt(2, id);
            ps.executeUpdate();
            dbo.commit();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            dbo.close();
        }
    }

    public static void updateAvatar(int id, String avatar) throws Exception {
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("UPDATE [User] SET [Avatar] = ? WHERE [UserID] = ?");
            ps.setString(1, avatar);
            ps.setInt(2, id);
            ps.executeUpdate();
            dbo.commit();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            dbo.close();
        }
    }

    public static void updateFullname(int id, String fullname) throws Exception {
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("UPDATE [User] SET [fullname] = ? WHERE [UserID] = ?");
            ps.setString(1, fullname);
            ps.setInt(2, id);
            ps.executeUpdate();
            dbo.commit();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            dbo.close();
        }
    }

    public static void updateGender(int id, boolean gender) throws Exception {
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("UPDATE [User] SET [gender] = ? WHERE [UserID] = ?");
            ps.setInt(1, gender ? 1 : 0);
            ps.setInt(2, id);
            ps.executeUpdate();
            dbo.commit();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            dbo.close();
        }
    }

  

    public static void updateDob(int id, String Dob) throws Exception {
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("UPDATE [User] SET [dob] = ? WHERE [UserID] = ?");
             ps.setDate(1, Date.valueOf(Dob));
            ps.setInt(2, id);
            ps.executeUpdate();
             dbo.commit();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            dbo.close();
        }
    }


    public static void updatePhone(int id, String phone) throws Exception {
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("UPDATE [User] SET [phoneNumber] = ? WHERE [UserID] = ?");
            ps.setString(1, phone);
            ps.setInt(2, id);
            ps.executeUpdate();
            dbo.commit();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            dbo.close();
        }
    }

    public static boolean isRegistered(String email, String username) throws Exception {
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("SELECT * FROM [User] WHERE [email] = ? AND [username] = ?");
            ps.setString(1, email);
            ps.setString(2, username);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                rs.close();
                ps.close();
                dbo.close();
                return true;
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            dbo.close();
        }
        return false;
    }
    
    public static boolean isSignInAdmin(String email, String username) throws Exception {
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("SELECT * FROM [User] WHERE [email] = ? AND [username] = ? AND [roleID] IN (1,2); ");
            ps.setString(1, email);
            ps.setString(2, username);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                rs.close();
                ps.close();
                dbo.close();
                return true;
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            dbo.close();
        }
        return false;
    }

    public static User getUser(String email, String password) throws Exception {
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("SELECT * FROM [User] WHERE [email] = ? AND [password] = ?");
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                PreparedStatement ps2 = dbo.prepareStatement("SELECT * FROM [Role] WHERE [roleID] = ?");
                ps2.setInt(1, rs.getInt("RoleID"));
                ResultSet rs2 = ps2.executeQuery();
                rs2.next();
                User u = new User(rs.getString("username"), password, email, rs.getString("phoneNumber"), rs.getString("address"), rs2.getString("roleName"), rs.getDate("dob"), rs.getInt("wallet"), rs.getInt("UserID"), rs.getInt("status") == 1 ? true : false, rs.getInt("gender") == 1 ? true : false);

                u.setFullname(rs.getString("fullname"));
                u.setAvatar(rs.getString("Avatar"));
                if (rs.getInt("isValidate") != 0) {
                    u.setValidate(true);
                }
                return u;
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            dbo.close();
        }
        return null;
    }

    public static Object getRole(int id, String role) {
        Connection dbo = DatabaseUtil.getConn();
        try {
            if (role.equalsIgnoreCase("mentee")) {
                PreparedStatement ps = dbo.prepareStatement("SELECT * FROM [Mentee] WHERE [UserID] = ?");
                ps.setInt(1, id);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    return new Mentee(rs.getString("status"), id);
                }
            } else if (role.equalsIgnoreCase("mentor")) {
                PreparedStatement ps = dbo.prepareStatement("SELECT * FROM [Mentor] WHERE [UserID] = ?");
                ps.setInt(1, id);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    ps = dbo.prepareStatement("SELECT * FROM [User] WHERE [UserID] = ?");
                    ps.setInt(1, id);
                    ResultSet rs2 = ps.executeQuery();
                    rs2.next();
                    return new Mentor(rs.getString("status"), rs.getString("Achivement"), rs.getString("Description"), id, rs.getInt("CvID"), rs2.getString("fullname"), rs2.getString("Avatar"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static void updateMoney(int uid, int price) throws Exception {
        Connection dbo = DatabaseUtil.getConn();
        PreparedStatement ps = dbo.prepareStatement("UPDATE [User] SET [wallet] = ? WHERE [UserID] = ?");
        ps.setInt(1, price);
        ps.setInt(2, uid);
        ps.executeUpdate();
        dbo.commit();
        dbo.close();
    }

    public static User register(String username, String password, String email, String phone, String address, String role, String gender, String fullname, String dob) throws Exception {
        Connection dbo = DatabaseUtil.getConn();
        try {
            if (address == null) {
                address = "";
            }
            PreparedStatement ps = dbo.prepareStatement("SELECT * FROM [User] WHERE [username] = ? OR [email] = ?");
            ps.setString(1, username);
            ps.setString(2, email);
            ResultSet rs = ps.executeQuery();
            if (!rs.next()) {
                ps = dbo.prepareStatement("INSERT INTO [User] ([username], [password], [email], [gender], [dob], [phoneNumber], [address], [RoleID], [wallet], [status], [fullname]) VALUES (?, ?, ?, ?, ?, ?, ?, (SELECT [roleID] FROM [Role] WHERE [roleName] = ?), 0, 1, ?)");
                ps.setString(1, username);
                ps.setString(2, password);
                ps.setString(3, email);
                ps.setInt(4, gender.equals("f") ? 1 : 0);
                ps.setDate(5, Date.valueOf(dob));
                ps.setString(6, phone);
                ps.setString(7, address);
                ps.setString(8, role);
                ps.setString(9, fullname);
                int k = ps.executeUpdate();
                dbo.commit();
                User u = UserDAO.getUser(email, password);
                if (role.equalsIgnoreCase("mentor")) {
                    ps = dbo.prepareStatement("INSERT INTO [Mentor] ([UserID]) VALUES (?)");
                    ps.setInt(1, u.getId());
                    ps.executeUpdate();
                    dbo.commit();
                } else {
                    ps = dbo.prepareStatement("INSERT INTO [Mentee] ([UserID]) VALUES (?)");
                    ps.setInt(1, u.getId());
                    ps.executeUpdate();
                    dbo.commit();
                }
                if (k > 0) {
                    return u;
                }
            }
            rs.close();
            ps.close();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            dbo.close();
        }
        return null;
    }

    public static List<User> getTopUsersWithRoleID3() throws Exception {
        List<User> users = new ArrayList<>();
        Connection dbo = DatabaseUtil.getConn();

        try {
            String sql = "SELECT TOP (4) u.[Avatar] , u.[fullname] , r.[Star]  FROM [User] u JOIN Rating r ON u.UserID = r.MentorID Where roleID = '3' ORDER BY r.[Star] desc";
            PreparedStatement ps = dbo.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                User mentor = new User(rs.getString(1) , rs.getString(2) , rs.getInt(3) );
                users.add(mentor);
            }

        } catch (Exception e) {
            System.out.println(e);
        }
        return users;
    }

    public static void main(String[] args) {
        int userId = 10;
        String newDob = "2003-01-02"; // Use double quotes for the date string

        try {
            updateDob(userId, newDob);
            System.out.println("Date of birth updated successfully for user ID: " + userId);
        } catch (Exception e) {
            System.err.println("Error updating date of birth: " + e.getMessage());
        }
    }




//     public static void main(String[] args) {
//        try {
//            List<User> users = getTopUsersWithRoleID3();
//            for (User user : users) {
//                System.out.println(user);
//            }
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//    }

   
    }



