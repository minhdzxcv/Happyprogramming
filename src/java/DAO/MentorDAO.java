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
import java.util.HashMap;
import model.Mentor;
import model.MentorDetail;
import model.MentorStatistic;


/**
 *
 * @author ADMIN
 */
public class MentorDAO {
      public static HashMap<Mentor, MentorDetail> getAllWithDetail() throws Exception {
        Connection dbo = DatabaseUtil.getConn();
        HashMap<Mentor, MentorDetail> arr = new HashMap();
        try {
            PreparedStatement ps = dbo.prepareStatement("SELECT * FROM [Mentor]");
            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                PreparedStatement ps2 = dbo.prepareStatement("SELECT AVG([Star]) AS Rate FROM [Rating] WHERE [MentorID] = ?");
                ps2.setInt(1, rs.getInt("UserID"));
                ResultSet rs2 = ps2.executeQuery();
                int rate = 0;
                if(rs2.next()) {
                    rate = rs2.getInt("Rate");
                }
                rs2.close();
                ps2.close();
                ps2 = dbo.prepareStatement("SELECT Count([RequestID]) as [accept]  FROM [Request] WHERE [UserID] = ? AND ([RequestStatus] = 'Confirmed' OR [RequestStatus] = 'Done' OR [RequestStatus] = 'Processing')");
                ps2.setInt(1, rs.getInt("UserID"));
                rs2 = ps2.executeQuery();
                int accept = 0;
                if(rs2.next()) {
                    accept = rs2.getInt("accept");
                }
                rs2.close();
                ps2.close();
                ps2 = dbo.prepareStatement("SELECT Count([RequestID]) as [done]  FROM [Request] WHERE [UserID] = ? AND ([RequestStatus] = 'Confirmed' OR [RequestStatus] = 'Done')");
                ps2.setInt(1, rs.getInt("UserID"));
                rs2 = ps2.executeQuery();
                int done = 0;
                if(rs2.next()) {
                    done = rs2.getInt("done");
                }
                rs2.close();
                ps2.close();
                ps2 = dbo.prepareStatement("SELECT * FROM [User] WHERE [UserID] = ?");
                ps2.setInt(1, rs.getInt("UserID"));
                rs2 = ps2.executeQuery();
                boolean active = false;
                String account = "";
                String fullname = "";
                String avatar = "";
                if(rs2.next()) {
                    account = rs2.getString("email");
                    active = rs2.getInt("activeStatus") == 1;
                    fullname = rs2.getString("fullname");
                    avatar = rs2.getString("Avatar");
                }
                rs2.close();
                ps2.close();
                ps2 = dbo.prepareStatement("SELECT [ProfessionIntro] FROM [CV] WHERE [CvID] = ?");
                ps2.setInt(1, rs.getInt("CvID"));
                rs2 = ps2.executeQuery();
                String profession = "";
                if(rs2.next()) {
                    profession = rs2.getString("ProfessionIntro");
                }
                arr.put(new Mentor(rs.getString("status"), rs.getString("Achivement"), rs.getString("Description"), rs.getInt("UserID"), rs.getInt("CvID"), fullname, avatar), new MentorDetail(rs.getInt("UserID"), rate, accept, (accept > 0 ? (int)((float)done / ((float)accept / 100)) : 0), account, profession, active));
            }
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            dbo.close();
        }
        return arr;
    }
      public static ArrayList<Mentor> searchMentor(String name, String city, String skill, String gender, String ready) throws Exception {
        ArrayList<Mentor> arr = new ArrayList();
        String sql = "SELECT s.[UserID] ,m.[Description] ,m.[CvID] ,m.[Achivement] ,m.[status], s.[Avatar], s.[fullname] FROM Mentor m INNER JOIN [User] s ON s.[UserID] = m.[UserID] WHERE ";
        int filter = 0;
        if(name != null) {
            sql += "(s.[username] LIKE N'%"+name+"%' OR s.[fullname] LIKE N'%"+name+"%')";
            filter++;
        }
        if(city != null) {
            if(filter > 0) {
                sql += " AND ";
            }
            sql += "(s.[address] LIKE N'%"+city+"%')";
            filter++;
        }
        if(gender != null) {
            if(filter > 0) {
                sql += " AND ";
            }
            sql += "(s.[gender] = "+ (gender.equalsIgnoreCase("female") ? 1 : 0 ) +")";
            filter++;
        }
        if(ready != null) {
            if(filter > 0) {
                sql += " AND ";
            }
            sql += "(m.[status] "+ (ready.equalsIgnoreCase("true") ? "= N'Accepted'" : "!= N'Accepted'" ) +")";
            filter++;
        }
        if(skill != null) {
            if(filter > 0) {
                sql += " AND ";
            }
            sql += skill + " IN ( SELECT [SkillID]  FROM  [MentorOfSkills] WHERE [MentorID] = m.[UserID])";
        }
        Connection dbo = DatabaseUtil.getConn();
        PreparedStatement ps = dbo.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        while(rs.next()) {
            arr.add(new Mentor(rs.getString("status"), rs.getString("Achivement"), rs.getString("Description"), rs.getInt("UserID"), rs.getInt("CvID"), rs.getString("fullname"), rs.getString("Avatar")));
        }
        dbo.close();
        return arr;
    }

public static HashMap<Mentor, MentorDetail> getAllBySkillId(int id) throws Exception {
        Connection dbo = DatabaseUtil.getConn();
        HashMap<Mentor, MentorDetail> arr = new HashMap();
        try {
            PreparedStatement ps = dbo.prepareStatement("SELECT * FROM [Mentor] WHERE [UserID] in (SELECT [MentorID] FROM [MentorOfSkills] WHERE [SkillID] = ?) AND (SELECT [status] FROM [User] WHERE [UserID] = [Mentor].[UserID]) = 1 AND (SELECT Count(*) as FreeSlot FROM [Slots] WHERE (Select MentorID FROM Schedule WHERE [Slots].ScheduleID = Schedule.ScheduleID) = [Mentor].[UserID] AND SkillID IS NULL) > 0 AND [status] = N'Accepted'");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                PreparedStatement ps2 = dbo.prepareStatement("SELECT AVG([Star]) AS Rate FROM [Rating] WHERE [MentorID] = ?");
                ps2.setInt(1, rs.getInt("UserID"));
                ResultSet rs2 = ps2.executeQuery();
                int rate = 0;
                if(rs2.next()) {
                    rate = rs2.getInt("Rate");
                }
                rs2.close();
                ps2.close();
                ps2 = dbo.prepareStatement("SELECT Count([RequestID]) as [accept]  FROM [Request] WHERE [UserID] = ? AND ([RequestStatus] = 'Confirmed' OR [RequestStatus] = 'Done' OR [RequestStatus] = 'Processing')");
                ps2.setInt(1, rs.getInt("UserID"));
                rs2 = ps2.executeQuery();
                int accept = 0;
                if(rs2.next()) {
                    accept = rs2.getInt("accept");
                }
                rs2.close();
                ps2.close();
                ps2 = dbo.prepareStatement("SELECT Count([RequestID]) as [done]  FROM [Request] WHERE [UserID] = ? AND ([RequestStatus] = 'Confirmed' OR [RequestStatus] = 'Done')");
                ps2.setInt(1, rs.getInt("UserID"));
                rs2 = ps2.executeQuery();
                int done = 0;
                if(rs2.next()) {
                    done = rs2.getInt("done");
                }
                rs2.close();
                ps2.close();
                ps2 = dbo.prepareStatement("SELECT * FROM [User] WHERE [UserID] = ?");
                ps2.setInt(1, rs.getInt("UserID"));
                rs2 = ps2.executeQuery();
                boolean active = false;
                String account = "";
                String fullname = "";
                String avatar = "";
                if(rs2.next()) {
                    account = rs2.getString("username");
                    active = rs2.getInt("status") == 1;
                    fullname = rs2.getString("fullname");
                    avatar = rs2.getString("Avatar");
                }
                rs2.close();
                ps2.close();
                ps2 = dbo.prepareStatement("SELECT [ProfessionIntro] FROM [CV] WHERE [CvID] = ?");
                ps2.setInt(1, rs.getInt("CvID"));
                rs2 = ps2.executeQuery();
                String profession = "";
                if(rs2.next()) {
                    profession = rs2.getString("ProfessionIntro");
                }
                rs2.close();
                ps2.close();
                ps2 = dbo.prepareStatement("SELECT Count([RequestID]) as [requests]  FROM [Request] WHERE [UserID] = ?");
                ps2.setInt(1, rs.getInt("UserID"));
                rs2 = ps2.executeQuery();
                int request = 0;
                if(rs2.next()) {
                    request = rs2.getInt("requests");
                }
                rs2.close();
                ps2.close();
                MentorDetail md = new MentorDetail(rs.getInt("UserID"), rate, accept, (accept > 0 ? ((accept) == 0 ? 0 : (int)((float)done / (float)(accept / 100))) : 0), account, profession, active);
                md.setRequests(request);
                arr.put(new Mentor(rs.getString("status"), rs.getString("Achivement"), rs.getString("Description"), rs.getInt("UserID"), rs.getInt("CvID"), fullname, avatar), md);
            }
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            dbo.close();
        }
        return arr;
    }

   public static void updateAchivement(int id, String achivement) throws Exception {
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("SELECT * FROM [Mentor] WHERE [UserID] = ?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                rs.close();
                ps.close();
                ps = dbo.prepareStatement("UPDATE [Mentor] SET [Achivement] = ? WHERE [UserID] = ?");
                ps.setInt(2, id);
                ps.setString(1, achivement);
                ps.executeUpdate();
            } else {
                rs.close();
                ps.close();
                ps = dbo.prepareStatement("INSERT INTO [Mentor] ([Achivement], [UserID]) VALUES (?, ?)");
                ps.setInt(2, id);
                ps.setString(1, achivement);
                ps.executeUpdate();
            }
            dbo.commit();
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            dbo.close();
        }
    }
   public static void updateDescription(int id, String description) throws Exception {
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("SELECT * FROM [Mentor] WHERE [UserID] = ?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                rs.close();
                ps.close();
                ps = dbo.prepareStatement("UPDATE [Mentor] SET [Description] = ? WHERE [UserID] = ?");
                ps.setInt(2, id);
                ps.setString(1, description);
                ps.executeUpdate();
            } else {
                rs.close();
                ps.close();
                ps = dbo.prepareStatement("INSERT INTO [Mentor] ([Description], [UserID]) VALUES (?, ?)");
                ps.setInt(2, id);
                ps.setString(1, description);
                ps.executeUpdate();
            }
            dbo.commit();
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            dbo.close();
        }
    }
}
