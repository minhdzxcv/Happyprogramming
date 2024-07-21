/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DataConnector.DatabaseUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import model.CV;
import model.Skill;

/**
 *
 * @author TGDD
 */
public class CvDAO {
    
    public static String getMentorByCvID(int id) {
        String idName = "";
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("SELECT [UserID], (SELECT [fullname] FROM [User] WHERE [UserID] = [Mentor].[UserID]) as [fullname] FROM [Mentor] WHERE [CvID] = ?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                idName = rs.getInt("UserID") + ";" + rs.getString("fullname");
            }
            dbo.close();
        } catch(Exception e) {}
        return idName;
    }
    
    public static void confirmCv(int id) throws Exception {
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("UPDATE [Mentor] SET [MentorStatus] = N'Accepted' WHERE CvID = ?");
            ps.setInt(1, id);
            ps.executeUpdate();
            dbo.commit();
            dbo.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
    }
    
    public static void rejectCv(int id) throws Exception {
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("UPDATE [Mentor] SET [CvID] = null WHERE CvID = ?");
            ps.setInt(1, id);
            ps.executeUpdate();
            ps = dbo.prepareStatement("DELETE FROM [Cv] WHERE CvID = ?");
            ps.setInt(1, id);
            ps.executeUpdate();
            dbo.commit();
            dbo.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
    }
    
    public static ArrayList<CV> getAllNotConfirmedCV() throws Exception {
        ArrayList<CV> arr = new ArrayList();
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("SELECT * FROM [CV] WHERE (SELECT [MentorStatus] FROM [Mentor] WHERE CvID = [CV].CvID) = N'Active'");
            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                ps = dbo.prepareStatement("SELECT [UserID] FROM [Mentor] WHERE [CvID] = ?");
                ps.setInt(1, rs.getInt("CvID"));
                ResultSet rs2 = ps.executeQuery();
                rs2.next();
                ps = dbo.prepareStatement("SELECT * FROM [MentorSkills] WHERE [MentorID] = ?");
                ps.setInt(1, rs2.getInt("UserID"));
                rs2 = ps.executeQuery();
                CV cv = new CV(rs.getInt("CvID"), rs.getString("ProfessionIntroduction"), rs.getString("ServiceDescription"));
                cv.setCashPerSlot(rs.getInt("CashPerSlot"));
                while(rs2.next()) {
                    ps = dbo.prepareStatement("SELECT * FROM [Skills] WHERE [SkillID] = ?");
                    ps.setInt(1, rs2.getInt("SkillID"));
                    ResultSet rs3 = ps.executeQuery();
                    rs3.next();
                    cv.getSkills().add(new Skill(rs2.getInt("SkillID"), rs3.getString("SkillName"), rs3.getInt("enable") == 1, rs3.getString("Imageskill"), rs3.getString("Skilldescription")));
                }
                arr.add(cv);
            }
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            dbo.close();
        }
        return arr;
    }
    
    public static boolean createCV(int userID, String ProfessionIntroduction, String ServiceDescription, String[] skills, int cash) throws Exception {
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("INSERT INTO [CV] ([ProfessionIntroduction], [ServiceDescription], [CashPerSlot]) VALUES (?, ?, ?)");
            ps.setString(1, ProfessionIntroduction);
            ps.setString(2, ServiceDescription);
            ps.setInt(3, cash);
            ps.executeUpdate();
            dbo.commit();
            ps = dbo.prepareStatement("SELECT TOP (1) [CvID] FROM [CV] ORDER BY [CvID] DESC");
            ResultSet rs = ps.executeQuery();
            rs.next();
            ps = dbo.prepareStatement("UPDATE [Mentor] SET [CvID] = ? WHERE [UserID] = ?");
            ps.setInt(1, rs.getInt("CvID"));
            ps.setInt(2, userID);
            ps.executeUpdate();
            dbo.commit();
            for (int i = 0; i < skills.length; i++) {
                int id = Integer.parseInt(skills[i]);
                ps = dbo.prepareStatement("INSERT INTO [MentorSkills] ([SkillID], [MentorID]) VALUES (?, ?)");
                ps.setInt(1, id);
                ps.setInt(2, userID);
                ps.executeUpdate();
            }
            dbo.commit();
            dbo.close();
            return true;
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            dbo.close();
        }
        return false;
    }
    
    public static CV getCV(int id) throws Exception {
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("SELECT * FROM [CV] WHERE [CvID] = ?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                ps = dbo.prepareStatement("SELECT [UserID] FROM [Mentor] WHERE [CvID] = ?");
                ps.setInt(1, id);
                ResultSet rs2 = ps.executeQuery();
                rs2.next();
                ps = dbo.prepareStatement("SELECT * FROM [MentorSkills] WHERE [MentorID] = ?");
                ps.setInt(1, rs2.getInt("UserID"));
                rs2 = ps.executeQuery();
                CV cv = new CV(rs.getInt("CvID"), rs.getString("ProfessionIntroduction"), rs.getString("ServiceDescription"));
                cv.setCashPerSlot(rs.getInt("CashPerSlot"));
                while(rs2.next()) {
                    ps = dbo.prepareStatement("SELECT * FROM [Skills] WHERE [SkillID] = ?");
                    ps.setInt(1, rs2.getInt("SkillID"));
                    rs = ps.executeQuery();
                    rs.next();
                    cv.getSkills().add(new Skill(rs2.getInt("SkillID"), rs.getString("SkillName"), rs.getInt("enable") == 1, rs.getString("Imageskill"), rs.getString("Skilldescription")));
                }
                dbo.close();
                return cv;
            }
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            dbo.close();
        }
        return null;
    }
    
    public static boolean updateCV(int CvID, String ProfessionIntroduction, String ServiceDescription, int CashPerSlot) throws Exception {
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("UPDATE [CV] SET [ProfessionIntroduction] = ?, [ServiceDescription] = ?, [CashPerSlot] = ? WHERE [CvID] = ?");
            ps.setString(1, ProfessionIntroduction);
            ps.setString(2, ServiceDescription);
            ps.setInt(3, CashPerSlot);
            ps.setInt(4, CvID);
            ps.executeUpdate();
            dbo.commit();
            dbo.close();
            return true;
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            dbo.close();
        }
        return false;
    }
    
    public static boolean removeSkill(int userID, int skillID) throws Exception {
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("DELETE FROM [MentorSkills] WHERE [MentorID] = ? AND SkillID = ?");
            ps.setInt(1, userID);
            ps.setInt(2, skillID);
            int k = ps.executeUpdate();
            dbo.commit();
            if(k > 0) {
                dbo.close();
                return true;
            }
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            dbo.close();
        }
        return false;
    }
    
    public static boolean addSkill(int userID, int skillID) throws Exception {
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("SELECT * FROM [MentorSkills] WHERE [MentorID] = ? AND [SkillID] = ?");
            ps.setInt(1, userID);
            ps.setInt(2, skillID);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) return false;
            ps = dbo.prepareStatement("INSERT INTO [MentorSkills] ([MentorID], [SkillID]) VALUES (?, ?)");
            ps.setInt(1, userID);
            ps.setInt(2, skillID);
            int k = ps.executeUpdate();
            dbo.commit();
            if(k > 0) {
                dbo.close();
                return true;
            }
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            dbo.close();
        }
        return false;
    }
}
