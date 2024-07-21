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

    public static boolean acceptedCv(int id) {
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("SELECT * FROM [Mentor] WHERE [Status] = N'Accepted' AND [UserID] = ?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                dbo.close();
                return true;
            }
            dbo.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return false;

    }

    public static HashMap<Mentor, MentorDetail> getAllWithDetail() throws Exception {
        Connection dbo = DatabaseUtil.getConn();
        HashMap<Mentor, MentorDetail> arr = new HashMap();
        try {
            PreparedStatement ps = dbo.prepareStatement("SELECT * FROM [Mentor]");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                PreparedStatement ps2 = dbo.prepareStatement("SELECT AVG([Star]) AS Rate FROM [Rating] WHERE [MentorID] = ?");
                ps2.setInt(1, rs.getInt("UserID"));
                ResultSet rs2 = ps2.executeQuery();
                int rate = 0;
                if (rs2.next()) {
                    rate = rs2.getInt("Rate");
                }
                rs2.close();
                ps2.close();
                ps2 = dbo.prepareStatement("SELECT Count([RequestID]) as [accept]  FROM [Request] WHERE [UserID] = ? AND ([RequestStatus] = 'Confirmed' OR [RequestStatus] = 'Done' OR [RequestStatus] = 'Processing')");
                ps2.setInt(1, rs.getInt("UserID"));
                rs2 = ps2.executeQuery();
                int accept = 0;
                if (rs2.next()) {
                    accept = rs2.getInt("accept");
                }
                rs2.close();
                ps2.close();
                ps2 = dbo.prepareStatement("SELECT Count([RequestID]) as [done]  FROM [Request] WHERE [UserID] = ? AND ([RequestStatus] = 'Confirmed' OR [RequestStatus] = 'Done')");
                ps2.setInt(1, rs.getInt("UserID"));
                rs2 = ps2.executeQuery();
                int done = 0;
                if (rs2.next()) {
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
                if (rs2.next()) {
                    account = rs2.getString("email");
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
                if (rs2.next()) {
                    profession = rs2.getString("ProfessionIntro");
                }
                arr.put(new Mentor(rs.getString("status"), rs.getString("Achivement"), rs.getString("Description"), rs.getInt("UserID"), rs.getInt("CvID"), fullname, avatar), new MentorDetail(rs.getInt("UserID"), rate, accept, (accept > 0 ? (int) ((float) done / ((float) accept / 100)) : 0), account, profession, active));
            }
        } catch (Exception e) {
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
        if (name != null) {
            sql += "(s.[username] LIKE N'%" + name + "%' OR s.[fullname] LIKE N'%" + name + "%')";
            filter++;
        }
        if (city != null) {
            if (filter > 0) {
                sql += " AND ";
            }
            sql += "(s.[address] LIKE N'%" + city + "%')";
            filter++;
        }
        if (gender != null) {
            if (filter > 0) {
                sql += " AND ";
            }
            sql += "(s.[gender] = " + (gender.equalsIgnoreCase("female") ? 1 : 0) + ")";
            filter++;
        }
        if (ready != null) {
            if (filter > 0) {
                sql += " AND ";
            }
            sql += "(m.[status] " + (ready.equalsIgnoreCase("true") ? "= N'Accepted'" : "!= N'Accepted'") + ")";
            filter++;
        }
        if (skill != null) {
            if (filter > 0) {
                sql += " AND ";
            }
            sql += skill + " IN ( SELECT [SkillID]  FROM  [MentorOfSkills] WHERE [MentorID] = m.[UserID])";
        }
        Connection dbo = DatabaseUtil.getConn();
        PreparedStatement ps = dbo.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
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
            while (rs.next()) {
                PreparedStatement ps2 = dbo.prepareStatement("SELECT AVG([Star]) AS Rate FROM [Rating] WHERE [MentorID] = ?");
                ps2.setInt(1, rs.getInt("UserID"));
                ResultSet rs2 = ps2.executeQuery();
                int rate = 0;
                if (rs2.next()) {
                    rate = rs2.getInt("Rate");
                }
                rs2.close();
                ps2.close();
                ps2 = dbo.prepareStatement("SELECT Count([RequestID]) as [accept]  FROM [Request] WHERE [UserID] = ? AND ([RequestStatus] = 'Confirmed' OR [RequestStatus] = 'Done' OR [RequestStatus] = 'Processing')");
                ps2.setInt(1, rs.getInt("UserID"));
                rs2 = ps2.executeQuery();
                int accept = 0;
                if (rs2.next()) {
                    accept = rs2.getInt("accept");
                }
                rs2.close();
                ps2.close();
                ps2 = dbo.prepareStatement("SELECT Count([RequestID]) as [done]  FROM [Request] WHERE [UserID] = ? AND ([RequestStatus] = 'Confirmed' OR [RequestStatus] = 'Done')");
                ps2.setInt(1, rs.getInt("UserID"));
                rs2 = ps2.executeQuery();
                int done = 0;
                if (rs2.next()) {
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
                if (rs2.next()) {
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
                if (rs2.next()) {
                    profession = rs2.getString("ProfessionIntro");
                }
                rs2.close();
                ps2.close();
                ps2 = dbo.prepareStatement("SELECT Count([RequestID]) as [requests]  FROM [Request] WHERE [UserID] = ?");
                ps2.setInt(1, rs.getInt("UserID"));
                rs2 = ps2.executeQuery();
                int request = 0;
                if (rs2.next()) {
                    request = rs2.getInt("requests");
                }
                rs2.close();
                ps2.close();
                MentorDetail md = new MentorDetail(rs.getInt("UserID"), rate, accept, (accept > 0 ? ((accept) == 0 ? 0 : (int) ((float) done / (float) (accept / 100))) : 0), account, profession, active);
                md.setRequests(request);
                arr.put(new Mentor(rs.getString("status"), rs.getString("Achivement"), rs.getString("Description"), rs.getInt("UserID"), rs.getInt("CvID"), fullname, avatar), md);
            }
        } catch (Exception e) {
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
            if (rs.next()) {
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
        } catch (Exception e) {
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
            if (rs.next()) {
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
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            dbo.close();
        }
    }

    public static boolean toggle(boolean type, int id) throws Exception {
        Connection dbo = DatabaseUtil.getConn();
        PreparedStatement ps = dbo.prepareStatement("UPDATE [User] SET [status] = " + (type ? 1 : 0) + " WHERE [UserID] = ?");
        ps.setInt(1, id);
        int k = ps.executeUpdate();
        dbo.commit();
        if (k > 0) {
            dbo.close();
            return true;
        }
        dbo.close();
        return false;
    }

    public static int getTotalMentor() throws Exception {
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("  Select count(*) from Mentor");

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            System.err.println(e.getMessage());
        }
        return 0;
    }

    public static MentorStatistic getMentorStatistic(int id) {
        MentorStatistic ms = null;
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("  SELECT \n"
                    + "    COUNT([RequestID]) AS TotalRequest, \n"
                    + "    (SELECT COUNT([RequestID]) \n"
                    + "     FROM [Request] \n"
                    + "     WHERE [UserID] = ? \n"
                    + "       AND ([RequestStatus] = N'Accept' \n"
                    + "        OR [RequestStatus] = N'Processing' \n"
                    + "        OR [RequestStatus] = N'Done')) AS TotalAccepted, \n"
                    + "    (SELECT COUNT([RequestID]) \n"
                    + "     FROM [Request] \n"
                    + "     WHERE [UserID] = ? \n"
                    + "       AND [RequestStatus] = N'Reject') AS TotalRejected, \n"
                    + "    (SELECT AVG(CAST([Star] AS FLOAT)) \n"
                    + "     FROM [Rating] \n"
                    + "     WHERE [MentorID] = ?) AS Rating, \n"
                    + "    (SELECT COUNT([RequestID]) \n"
                    + "     FROM [Request] \n"
                    + "     WHERE [UserID] = ? \n"
                    + "       AND [RequestStatus] = N'Done') AS TotalDone \n"
                    + "FROM \n"
                    + "    [Request] \n"
                    + "WHERE \n"
                    + "    [UserID] = ?");
            ps.setInt(1, id);
            ps.setInt(2, id);
            ps.setInt(3, id);
            ps.setInt(4, id);
            ps.setInt(5, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                ms = new MentorStatistic();
                ms.setId(id);
                ms.setInvitedRequest(rs.getInt("TotalRequest"));
                ms.setAccepedRequest(rs.getInt("TotalAccepted"));
                ms.setRejectedRequest(rs.getInt("TotalRejected"));
                ms.setRating(rs.getFloat("Rating"));
                if (ms.getInvitedRequest() > 0) {
                    ms.setRejectPercent((float) ms.getRejectedRequest() / (float) ms.getInvitedRequest());
                } else {
                    ms.setRejectPercent(0);
                }
                if (ms.getAccepedRequest() > 0) {
                    ms.setCompletePercent((float) rs.getInt("TotalDone") / (float) ms.getAccepedRequest());
                } else {
                    ms.setCompletePercent(0);
                }
                dbo.close();
            }
        } catch (Exception e) {
        }
        return ms;
    }

    public static Mentor getMentor(int id) {
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("SELECT * FROM [Mentor] WHERE [UserID] = ?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                ps = dbo.prepareStatement("SELECT * FROM [User] WHERE [UserID] = ?");
                ps.setInt(1, id);
                ResultSet rs2 = ps.executeQuery();
                rs2.next();
                Mentor m = new Mentor(rs.getString("status"), rs.getString("Achivement"), rs.getString("Description"), rs.getInt("UserID"), rs.getInt("CvID"), rs2.getString("fullname"), rs2.getString("Avatar"));
                ps = dbo.prepareStatement("SELECT Count([FollowID]) as Follow FROM [Follow] WHERE [MentorID] = ?");
                ps.setInt(1, id);
                rs2 = ps.executeQuery();
                rs2.next();
                m.setFollow(rs2.getInt("Follow"));
                ps = dbo.prepareStatement("SELECT Count(*) as ratingTime, AVG(Cast([Star] as Float)) as Rate FROM [Rating] WHERE MentorID = ?");
                ps.setInt(1, id);
                rs2 = ps.executeQuery();
                rs2.next();
                m.setRatingTime(rs2.getInt("ratingTime"));
                m.setRate(rs2.getFloat("Rate"));
                dbo.close();
                return m;
            }
        } catch (Exception e) {
        }
        return null;
    }

    public static Mentor getMentorByCVID(int cvId) {
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("SELECT * FROM [Mentor] WHERE [CvID] = ?");
            ps.setInt(1, cvId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                int userId = rs.getInt("UserID"); 
                ps = dbo.prepareStatement("SELECT * FROM [User] WHERE [UserID] = ?");
                ps.setInt(1, userId);
                ResultSet rs2 = ps.executeQuery();
                rs2.next();
                Mentor m = new Mentor(
                        rs.getString("status"),
                        rs.getString("Achivement"),
                        rs.getString("Description"),
                        userId,
                        cvId,
                        rs2.getString("fullname"),
                        rs2.getString("Avatar")
                );

                ps = dbo.prepareStatement("SELECT Count([FollowID]) as Follow FROM [Follow] WHERE [MentorID] = ?");
                ps.setInt(1, userId);
                rs2 = ps.executeQuery();
                rs2.next();
                m.setFollow(rs2.getInt("Follow"));

                ps = dbo.prepareStatement("SELECT Count(*) as ratingTime, AVG(Cast([Star] as Float)) as Rate FROM [Rating] WHERE MentorID = ?");
                ps.setInt(1, userId);
                rs2 = ps.executeQuery();
                rs2.next();
                m.setRatingTime(rs2.getInt("ratingTime"));
                m.setRate(rs2.getFloat("Rate"));

                dbo.close();
                return m;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public static int getSlotCash(int id) {
        int cash = 0;
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("SELECT [MoneyOfSlot] FROM [CV] WHERE [CvID] = (SELECT [CvID] FROM [Mentor] WHERE [UserID] = ?)");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            rs.next();
            cash = rs.getInt("MoneyOfSlot");
            dbo.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return cash;
    }

    public static void main(String[] args) {
        // Replace with a valid mentor ID for testing
        int mentorId = 4;

        // Get the mentor statistics
        MentorStatistic stats = getMentorStatistic(mentorId);

        // Check if the statistics are successfully retrieved
        if (stats != null) {
            // Print out the mentor statistics
            System.out.println("Mentor ID: " + stats.getId());
            System.out.println("Total Invited Requests: " + stats.getInvitedRequest());
            System.out.println("Total Accepted Requests: " + stats.getAccepedRequest());
            System.out.println("Total Rejected Requests: " + stats.getRejectedRequest());
            System.out.println("Average Rating: " + stats.getRating());
            System.out.println("Rejection Percentage: " + stats.getRejectPercent() * 100 + "%");
            System.out.println("Completion Percentage: " + stats.getCompletePercent() * 100 + "%");
        } else {
            System.out.println("No statistics found for mentor with ID: " + mentorId);
        }
    }

}
