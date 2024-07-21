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
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import model.Mentor;
import model.Request;
import model.Skill;

/**
 *
 * @author TGDD
 */
public class RequestDAO {
    
    
    public static int getSlots(int id) {
        int cash = 0;
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("SELECT Count([SlotID]) as Count FROM [RequestSlot] WHERE [RequestID] = ?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            rs.next();
            cash = rs.getInt("Count");
            dbo.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
        return cash;
    }

    public static boolean deleteAll(int uid) throws Exception {
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps =  dbo.prepareStatement("UPDATE [Request] SET [RequestStatus] = N'Close' WHERE [SenderID] = ? AND ([RequestStatus] = N'Open' OR [RequestStatus] = N'Reopen' OR [RequestStatus] = N'Reject')");
            ps.setInt(1, uid);
            int k = ps.executeUpdate();
            dbo.commit();
            if (k > 0) {
                dbo.close();
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            dbo.close();
        }
        return false;
    }

    public static void rejectRequest(int rid, int uid, String reason) throws Exception {
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("SELECT * FROM [RejectRequest] WHERE [RequestID] = ?");
            ps.setInt(1, rid);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                ps = dbo.prepareStatement("UPDATE [RejectRequest] SET [Reason] = ? WHERE [RequestID] = (SELECT [RequestID] FROM [Request] WHERE [RequestID] = ? AND [UserID] = ?)");
                ps.setString(1, reason);
                ps.setInt(2, rid);
                ps.setInt(3, uid);
                ps.executeUpdate();
                ps = dbo.prepareStatement("UPDATE [Request] SET [RequestStatus] = 'Reject' WHERE [RequestID] = (SELECT [RequestID] FROM [Request] WHERE [RequestID] = ? AND [UserID] = ?)");
                ps.setInt(1, rid);
                ps.setInt(2, uid);
                ps.executeUpdate();
            } else {
                ps = dbo.prepareStatement("INSERT INTO [RejectRequest] ([RequestID], [Reason]) VALUES ((SELECT [RequestID] FROM [Request] WHERE [RequestID] = ? AND [UserID] = ?), ?)");
                ps.setInt(1, rid);
                ps.setInt(2, uid);
                ps.setString(3, reason);
                ps.executeUpdate();
                ps = dbo.prepareStatement("UPDATE [Request] SET [RequestStatus] = 'Reject' WHERE [RequestID] = (SELECT [RequestID] FROM [Request] WHERE [RequestID] = ? AND [UserID] = ?)");
                ps.setInt(1, rid);
                ps.setInt(2, uid);
                ps.executeUpdate();
            }
            dbo.commit();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            dbo.close();
        }
    }

    public static boolean deleteRequest(int rid, int uid) throws Exception {
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("UPDATE [Request] SET [RequestStatus] = N'Close' WHERE [RequestID] = ? AND [SenderID] = ? AND ([RequestStatus] = N'Open' OR [RequestStatus] = N'Reopen' OR [RequestStatus] = N'Reject')");
            ps.setInt(1, rid);
            ps.setInt(2, uid);
            int k = ps.executeUpdate();
            dbo.commit();
            if (k > 0) {
                dbo.close();
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            dbo.close();
        }
        return false;
    }
    
    public static void payment(int rid, int oid, int uid) throws Exception {
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("UPDATE [User] SET [wallet] = [wallet] - ((SELECT Count([SlotID]) FROM [RequestSlot] WHERE [RequestID] = ?) * (SELECT [CashPerSlot] FROM [CV] WHERE [CvID] = (SELECT [CvID] FROM [Mentor] WHERE [UserID] = ?))) WHERE [UserID] = ?");
            ps.setInt(1, rid);
            ps.setInt(2, oid);
            ps.setInt(3, uid);
            ps.executeUpdate();
            ps = dbo.prepareStatement("INSERT INTO [Transaction] ([UserID], [Balance], [Type], [Content], [Status]) VALUES (?, ((SELECT Count([SlotID]) FROM [RequestSlot] WHERE [RequestID] = ?) * (SELECT [CashPerSlot] FROM [CV] WHERE [CvID] = (SELECT [CvID] FROM [Mentor] WHERE [UserID] = ?))), N'-', N'Nộp tiền request id "+rid+"', N'Success')");
            ps.setInt(1, uid);
            ps.setInt(2, rid);
            ps.setInt(3, oid);
            ps.executeUpdate();
            ps = dbo.prepareStatement("UPDATE [Request] SET [RequestStatus] = N'Processing' WHERE [RequestID] = ?");
            ps.setInt(1, rid);
            ps.executeUpdate();
            ps = dbo.prepareStatement("UPDATE [Slot] SET [Status] = N'Not Confirm' WHERE [SlotID] in (SELECT [SlotID] FROM [RequestSlot] WHERE [RequestID] = ?)");
            ps.setInt(1, rid);
            ps.executeUpdate();
            ps = dbo.prepareStatement("INSERT INTO [Payment] ([Status], [Balance], [UserID], [ReceiverID], [RequestID]) VALUES (N'Sent', ((SELECT Count([SlotID]) FROM [RequestSlot] WHERE [RequestID] = ?) * (SELECT [CashPerSlot] FROM [CV] WHERE [CvID] = (SELECT [CvID] FROM [Mentor] WHERE [UserID] = ?))), ?, ?, ?)");
            ps.setInt(1, rid);
            ps.setInt(2, oid);
            ps.setInt(3, uid);
            ps.setInt(4, oid);
            ps.setInt(5, rid);
            int k = ps.executeUpdate();
            dbo.commit();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            dbo.close();
        }
    }
    
    public static int completeRequest(int rid, int oid) throws Exception {
        int cash = 0;
        Connection dbo = DatabaseUtil.getConn();
        try {
            //PreparedStatement ps = dbo.prepareStatement("UPDATE [User] SET [wallet] = [wallet] + (SELECT [Balance] FROM [Payment] WHERE [RequestID] = ?) WHERE [UserID] = ?");
            //ps.setInt(1, rid);
            //ps.setInt(2, oid);
            //ps.executeUpdate();
//            ps = dbo.prepareStatement("UPDATE [Payment] SET [Status] = N'Received' WHERE [RequestID] = ?");
//            ps.setInt(1, rid);
//            ps.executeUpdate();
            PreparedStatement ps = dbo.prepareStatement("UPDATE [Request] SET [RequestStatus] = N'Done' WHERE [RequestID] = ?");
            ps.setInt(1, rid);
            ps.executeUpdate();
            ps = dbo.prepareStatement("SELECT [Balance] FROM [Payment] WHERE [RequestID] = ?");
            ps.setInt(1, rid);
            ResultSet rs = ps.executeQuery();
            rs.next();
            cash = rs.getInt("Balance");
            dbo.commit();
        } catch(Exception e) {
            e.printStackTrace();
        }
        dbo.close();
        return cash;
    }

    public static void acceptRequest(int rid, int oid) throws Exception {
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("DELETE FROM [RejectRequest] WHERE [RequestID] = ?");
            ps.setInt(1, rid);
            ps.executeUpdate();
            ps = dbo.prepareStatement("UPDATE [Request] SET [RequestStatus] = 'Accept' WHERE [RequestID] = ? AND [UserID] = ?");
            ps.setInt(1, rid);
            ps.setInt(2, oid);
            ps.executeUpdate();
            ps = dbo.prepareStatement("UPDATE [Slot] SET [Status] = N'Not Paid', [SkillID] = (SELECT [SkillID] FROM [Request] WHERE [RequestID] = ? AND [UserID] = ?), MenteeID = (SELECT [SenderID] FROM [Request] WHERE [RequestID] = ? AND [UserID] = ?) WHERE [SlotID] in (SELECT [SlotID] FROM [RequestSlot] WHERE [RequestID] = ?)");
            ps.setInt(1, rid);
            ps.setInt(2, oid);
            ps.setInt(3, rid);
            ps.setInt(4, oid);
            ps.setInt(5, rid);
            int k = ps.executeUpdate();
            dbo.commit();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            dbo.close();
        }
    }

    public static Request getRequest(int rid) throws Exception {
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("SELECT * FROM [Request] WHERE [RequestID] = ?");
            ps.setInt(1, rid);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                Request r = new Request(rs.getInt("RequestID"), rs.getInt("SenderID"), rs.getInt("UserID"), rs.getString("RequestReason"), rs.getString("RequestStatus"), rs.getString("RequestSubject"), rs.getTimestamp("RequestTime"), rs.getTimestamp("DeadlineTime"));
                ps = dbo.prepareStatement("SELECT [fullname] FROM [User] WHERE [UserID] = ?");
                ps.setInt(1, r.getUserID());
                ResultSet rs2 = ps.executeQuery();
                rs2.next();
                r.setMentor(rs2.getString("fullname"));
                if(r.getStatus().equalsIgnoreCase("reject")) {
                    ps = dbo.prepareStatement("SELECT * FROM [RejectRequest] WHERE [RequestID] = ?");
                    ps.setInt(1, rs.getInt("RequestID"));
                    rs2 = ps.executeQuery();
                    if(rs2.next()) {
                        r.setRejectReason(rs2.getString("Reason"));
                    }
                }
                ps = dbo.prepareStatement("SELECT * FROM [Skills] WHERE [SkillID] in (SELECT [SkillID] FROM [Request] WHERE [RequestID] = ?");
                ps.setInt(1, rs.getInt("RequestID"));
                rs2 = ps.executeQuery();
                while (rs2.next()) {
                    r.getSkills().add(new Skill(rs2.getInt("SkillID"), rs2.getString("SkillName"), rs2.getInt("enable") == 1, rs2.getString("Imageskill"), rs2.getString("Skilldescription")));
                }
                dbo.close();
                return r;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            dbo.close();
        }
        return null;
    }

    public static ArrayList<Request> getMentorRequests(int uid) throws Exception {
        Connection dbo = DatabaseUtil.getConn();
        ArrayList<Request> arr = new ArrayList();
        try {
            PreparedStatement ps = dbo.prepareStatement("SELECT * FROM [Request] WHERE [UserID] = ? AND ((([RequestStatus] = N'Open' OR [RequestStatus] = N'Reopen' OR [RequestStatus] = N'Reject'  OR [RequestStatus] = N'Close') AND [DeadlineTime] > GETDATE()) OR ([RequestStatus] = N'Accept' OR [RequestStatus] = N'Processing' OR [RequestStatus] = N'Done'))");
            ps.setInt(1, uid);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Request r = new Request(rs.getInt("RequestID"), rs.getInt("SenderID"), rs.getInt("UserID"), rs.getString("RequestReason"), rs.getString("RequestStatus"), rs.getString("RequestSubject"), rs.getTimestamp("RequestTime"), rs.getTimestamp("DeadlineTime"));
                ps = dbo.prepareStatement("SELECT [fullname] FROM [User] WHERE [UserID] = ?");
                ps.setInt(1, r.getSenderID());
                ResultSet rs2 = ps.executeQuery();
                rs2.next();
                r.setSender(rs2.getString("fullname"));
                if(r.getStatus().equalsIgnoreCase("reject")) {
                    ps = dbo.prepareStatement("SELECT * FROM [RejectRequest] WHERE [RequestID] = ?");
                    ps.setInt(1, rs.getInt("RequestID"));
                    rs2 = ps.executeQuery();
                    if(rs2.next()) {
                        r.setRejectReason(rs2.getString("Reason"));
                    }
                }
                ps = dbo.prepareStatement("SELECT * FROM [Skills] WHERE [SkillID] in (SELECT [SkillID] FROM [Request] WHERE [RequestID] = ?)");
                ps.setInt(1, rs.getInt("RequestID"));
                rs2 = ps.executeQuery();
                while (rs2.next()) {
                    r.getSkills().add(new Skill(rs2.getInt("SkillID"), rs2.getString("SkillName"), rs2.getInt("enable") == 1, rs2.getString("Imageskill"), rs2.getString("Skilldescription")));
                }
                arr.add(r);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            dbo.close();
        }
        return arr;
    }

    public static ArrayList<Request> getMenteeRequests(int uid) throws Exception {
        Connection dbo = DatabaseUtil.getConn();
        ArrayList<Request> arr = new ArrayList();
        try {
            PreparedStatement ps = dbo.prepareStatement("SELECT * FROM [Request] WHERE [SenderID] = ? AND ((([RequestStatus] = N'Open' OR [RequestStatus] = N'Reopen' OR [RequestStatus] = N'Reject'  OR [RequestStatus] = N'Close') AND [DeadlineTime] > GETDATE()) OR ([RequestStatus] = N'Accept' OR [RequestStatus] = N'Processing' OR [RequestStatus] = N'Done'))");
            ps.setInt(1, uid);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Request r = new Request(rs.getInt("RequestID"), rs.getInt("SenderID"), rs.getInt("UserID"), rs.getString("RequestReason"), rs.getString("RequestStatus"), rs.getString("RequestSubject"), rs.getTimestamp("RequestTime"), rs.getTimestamp("DeadlineTime"));
                ps = dbo.prepareStatement("SELECT [fullname] FROM [User] WHERE [UserID] = ?");
                ps.setInt(1, r.getUserID());
                ResultSet rs2 = ps.executeQuery();
                rs2.next();
                r.setMentor(rs2.getString("fullname"));
                if(r.getStatus().equalsIgnoreCase("reject")) {
                    ps = dbo.prepareStatement("SELECT * FROM [RejectRequest] WHERE [RequestID] = ?");
                    ps.setInt(1, rs.getInt("RequestID"));
                    rs2 = ps.executeQuery();
                    if(rs2.next()) {
                        r.setRejectReason(rs2.getString("Reason"));
                    }
                } else if(r.getStatus().equalsIgnoreCase("done")) {
                    ps = dbo.prepareStatement("SELECT * FROM [Rating] WHERE [RequestID] = ?");
                    ps.setInt(1, rs.getInt("RequestID"));
                    rs2 = ps.executeQuery();
                    if(rs2.next()) {
                        r.setRated(true);
                    }
                }
                ps = dbo.prepareStatement("SELECT * FROM [Skills] WHERE [SkillID] in (SELECT [SkillID] FROM [Request] WHERE [RequestID] = ?)");
                ps.setInt(1, rs.getInt("RequestID"));
                rs2 = ps.executeQuery();
                while (rs2.next()) {
                    r.getSkills().add(new Skill(rs2.getInt("SkillID"), rs2.getString("SkillName"), rs2.getInt("enable") == 1, rs2.getString("Imageskill"), rs2.getString("Skilldescription")));
                }
                arr.add(r);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            dbo.close();
        }
        return arr;
    }

    public static ArrayList<Request> getRequests() throws Exception {
        Connection dbo = DatabaseUtil.getConn();
        ArrayList<Request> arr = new ArrayList();
        try {
            PreparedStatement ps = dbo.prepareStatement("SELECT * FROM [Request]");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Request r = new Request(rs.getInt("RequestID"), rs.getInt("SenderID"), rs.getInt("UserID"), rs.getString("RequestReason"), rs.getString("RequestStatus"), rs.getString("RequestSubject"), rs.getTimestamp("RequestTime"), rs.getTimestamp("DeadlineTime"));
                ps = dbo.prepareStatement("SELECT [fullname] FROM [User] WHERE [UserID] = ?");
                ps.setInt(1, r.getUserID());
                ResultSet rs2 = ps.executeQuery();
                rs2.next();
                r.setMentor(rs2.getString("fullname"));
                ps = dbo.prepareStatement("SELECT [username] FROM [User] WHERE [UserID] = ?");
                ps.setInt(1, r.getSenderID());
                rs2 = ps.executeQuery();
                rs2.next();
                r.setSender(rs2.getString("username"));
                if(r.getStatus().equalsIgnoreCase("reject")) {
                    ps = dbo.prepareStatement("SELECT * FROM [RejectRequest] WHERE [RequestID] = ?");
                    ps.setInt(1, rs.getInt("RequestID"));
                    rs2 = ps.executeQuery();
                    if(rs2.next()) {
                        r.setRejectReason(rs2.getString("Reason"));
                    }
                }
                ps = dbo.prepareStatement("SELECT * FROM [Skills] WHERE [SkillID] in (SELECT [SkillID] FROM [Request] WHERE [RequestID] = ?)");
                ps.setInt(1, rs.getInt("RequestID"));
                rs2 = ps.executeQuery();
                while (rs2.next()) {
                    r.getSkills().add(new Skill(rs2.getInt("SkillID"), rs2.getString("SkillName"), rs2.getInt("enable") == 1, rs2.getString("Imageskill"), rs2.getString("Skilldescription")));
                }
                arr.add(r);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            dbo.close();
        }
        return arr;
    }

    public static boolean updateRequest(String[] skills, Timestamp deadline, String subject, String reason, int sid, String status, int rid) throws Exception {
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("UPDATE [Request] SET [SenderID] = ?, [RequestSubject] = ?, [RequestReason] = ?, [DeadlineTime] = ?, [RequestStatus] = ?, [SkillID] = ? WHERE [RequestID] = ?");
            ps.setInt(1, sid);
            ps.setString(2, subject);
            ps.setString(3, reason);
            ps.setTimestamp(4, deadline);
            ps.setString(5, status);
            ps.setInt(6, Integer.parseInt(skills[0]));
            ps.setInt(7, rid);
            int k = ps.executeUpdate();
            dbo.commit();
            if (k > 0) {
                dbo.close();
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            dbo.close();
        }
        return false;
    }

    public static boolean createRequest(String[] skills, Timestamp deadline, String subject, String reason, int sid, int uid, String[] slots) throws Exception {
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("INSERT INTO [Request] ([SenderID], [UserID], [RequestSubject], [RequestReason], [DeadlineTime], [RequestStatus], [SkillID]) VALUES (?, ?, ?, ?, ?, 'Open', ?)");
            ps.setInt(1, sid);
            ps.setInt(2, uid);
            ps.setString(3, subject);
            ps.setString(4, reason);
            ps.setTimestamp(5, deadline);
            ps.setInt(6, Integer.parseInt(skills[0]));
            int k = ps.executeUpdate();
            for (int i = 0; i < slots.length; i++) {
                ps = dbo.prepareStatement("INSERT INTO [RequestSlot] ([RequestID], [SlotID]) VALUES ((SELECT Top (1) [RequestID] FROM [Request] ORDER BY [RequestID] DESC), ?)");
                ps.setInt(1, Integer.parseInt(slots[i]));
                ps.executeUpdate();
            }
            dbo.commit();
            if (k > 0) {
                dbo.close();
                return true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            dbo.close();
        }
        return false;
    }
}
