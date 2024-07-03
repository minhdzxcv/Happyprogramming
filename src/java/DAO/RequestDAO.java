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
 * @author ADMIN
 */
public class RequestDAO {

    public static int getSlots(int id) {
        int cash = 0;
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("SELECT Count([SlotID]) as Count FROM [RequestSlots] WHERE [RequestID] = ?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            rs.next();
            cash = rs.getInt("Count");
            dbo.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return cash;
    }

    public static boolean deleteAll(int uid) throws Exception {
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("UPDATE [Request] SET [RequestStatus] = N'Close' WHERE [SendID] = ? AND ([RequestStatus] = N'Open' OR [RequestStatus] = N'Reopen' OR [RequestStatus] = N'Reject')");
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

    public static void rejectRequestF(int rid, int uid, String reason) throws Exception {
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("UPDATE [Request] SET [RequestStatus] = 'Reject', rejectReason=? WHERE [RequestID] = ?");
            ps.setString(1, reason);
            ps.setInt(2, rid);
            ps.executeUpdate();
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
            PreparedStatement ps = dbo.prepareStatement("UPDATE [Request] SET [RequestStatus] = N'Close' WHERE [RequestID] = ? AND [SendID] = ? AND ([RequestStatus] = N'Open' OR [RequestStatus] = N'Reopen' OR [RequestStatus] = N'Reject')");
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
            PreparedStatement ps = dbo.prepareStatement("UPDATE [User] SET [wallet] = [wallet] - ((SELECT Count([SlotID]) FROM [RequestSlots] WHERE [RequestID] = ?) * (SELECT [MoneyOfSlot] FROM [CV] WHERE [CvID] = (SELECT [CvID] FROM [Mentor] WHERE [UserID] = ?))) WHERE [UserID] = ?");
            ps.setInt(1, rid);
            ps.setInt(2, oid);
            ps.setInt(3, uid);
            ps.executeUpdate();
            ps = dbo.prepareStatement("INSERT INTO [Transaction] ([UserID], [price], [Type], [Content], [Status]) VALUES (?, ((SELECT Count([SlotID]) FROM [RequestSlots] WHERE [RequestID] = ?) * (SELECT [MoneyOfSlot] FROM [CV] WHERE [CvID] = (SELECT [CvID] FROM [Mentor] WHERE [UserID] = ?))), N'-', N'Nộp tiền request id " + rid + "', N'Success')");
            ps.setInt(1, uid);
            ps.setInt(2, rid);
            ps.setInt(3, oid);
            ps.executeUpdate();
            ps = dbo.prepareStatement("UPDATE [Request] SET [RequestStatus] = N'Processing' WHERE [RequestID] = ?");
            ps.setInt(1, rid);
            ps.executeUpdate();
            ps = dbo.prepareStatement("UPDATE [Slots] SET [Status] = N'Not Confirm' WHERE [SlotID] in (SELECT [SlotID] FROM [RequestSlots] WHERE [RequestID] = ?)");
            ps.setInt(1, rid);
            ps.executeUpdate();
            ps = dbo.prepareStatement("INSERT INTO [Payment] ([Status], [price], [UserID], [ReceiverID], [RequestID]) VALUES (N'Sent', ((SELECT Count([SlotID]) FROM [RequestSlots] WHERE [RequestID] = ?) * (SELECT [MoneyOfSlot] FROM [CV] WHERE [CvID] = (SELECT [CvID] FROM [Mentor] WHERE [UserID] = ?))), ?, ?, ?)");
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
            ps = dbo.prepareStatement("SELECT [price] FROM [Payment] WHERE [RequestID] = ?");
            ps.setInt(1, rid);
            ResultSet rs = ps.executeQuery();
            rs.next();
            cash = rs.getInt("price");
            dbo.commit();
        } catch (Exception e) {
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
            ps = dbo.prepareStatement("UPDATE [Slots] SET [Status] = N'Not Paid', [SkillID] = (SELECT [SkillID] FROM [Request] WHERE [RequestID] = ? AND [UserID] = ?), MenteeID = (SELECT [SendID] FROM [Request] WHERE [RequestID] = ? AND [UserID] = ?) WHERE [SlotID] in (SELECT [SlotID] FROM [RequestSlots] WHERE [RequestID] = ?)");
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
                Request r = new Request(rs.getInt("RequestID"), rs.getInt("SendID"), rs.getInt("UserID"), rs.getString("RequestReason"), rs.getString("RequestStatus"), rs.getString("RequestSubject"), rs.getTimestamp("RequestTime"), rs.getTimestamp("DeadlineTime"));
                ps = dbo.prepareStatement("SELECT [fullname] FROM [User] WHERE [UserID] = ?");
                ps.setInt(1, r.getUserID());
                ResultSet rs2 = ps.executeQuery();
                rs2.next();
                r.setMentor(rs2.getString("fullname"));
                if (r.getStatus().equalsIgnoreCase("reject")) {
                    ps = dbo.prepareStatement("SELECT * FROM [RejectRequest] WHERE [RequestID] = ?");
                    ps.setInt(1, rs.getInt("RequestID"));
                    rs2 = ps.executeQuery();
                    if (rs2.next()) {
                        r.setRejectReason(rs2.getString("Reason"));
                    }
                }
                ps = dbo.prepareStatement("SELECT * FROM [Skills] WHERE [SkillID] in (SELECT [SkillID] FROM [Request] WHERE [RequestID] = ?");
                ps.setInt(1, rs.getInt("RequestID"));
                rs2 = ps.executeQuery();
                while (rs2.next()) {
                    r.getSkills().add(new Skill(rs2.getInt("SkillID"), rs2.getString("SkillName"), rs2.getInt("enable") == 1, rs2.getString("image"), rs2.getString("Description")));
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
                Request r = new Request(rs.getInt("RequestID"), rs.getInt("SendID"), rs.getInt("UserID"), rs.getString("RequestReason"), rs.getString("RequestStatus"), rs.getString("RequestSubject"), rs.getTimestamp("RequestTime"), rs.getTimestamp("DeadlineTime"));
                ps = dbo.prepareStatement("SELECT [fullname] FROM [User] WHERE [UserID] = ?");
                ps.setInt(1, r.getSendID());
                ResultSet rs2 = ps.executeQuery();
                rs2.next();
                r.setSend(rs2.getString("fullname"));
                if (r.getStatus().equalsIgnoreCase("reject")) {
                    ps = dbo.prepareStatement("SELECT * FROM [RejectRequest] WHERE [RequestID] = ?");
                    ps.setInt(1, rs.getInt("RequestID"));
                    rs2 = ps.executeQuery();
                    if (rs2.next()) {
                        r.setRejectReason(rs2.getString("Reason"));
                    }
                }
                ps = dbo.prepareStatement("SELECT * FROM [Skills] WHERE [SkillID] in (SELECT [SkillID] FROM [Request] WHERE [RequestID] = ?)");
                ps.setInt(1, rs.getInt("RequestID"));
                rs2 = ps.executeQuery();
                while (rs2.next()) {
                    r.getSkills().add(new Skill(rs2.getInt("SkillID"), rs2.getString("SkillName"), rs2.getInt("enable") == 1, rs2.getString("image"), rs2.getString("Description")));
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
            PreparedStatement ps = dbo.prepareStatement("SELECT * FROM [Request] WHERE [SendID] = ? AND ((([RequestStatus] = N'Open' OR [RequestStatus] = N'Reopen' OR [RequestStatus] = N'Reject'  OR [RequestStatus] = N'Close') AND [DeadlineTime] > GETDATE()) OR ([RequestStatus] = N'Accept' OR [RequestStatus] = N'Processing' OR [RequestStatus] = N'Done'))");
            ps.setInt(1, uid);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String rejectReason = rs.getString("rejectReason");
                Request r = new Request(rs.getInt("RequestID"), rs.getInt("SendID"), rs.getInt("UserID"), rs.getString("RequestReason"), rs.getString("RequestStatus"), rs.getString("RequestSubject"), rs.getTimestamp("RequestTime"), rs.getTimestamp("DeadlineTime"));
                ps = dbo.prepareStatement("SELECT [fullname] FROM [User] WHERE [UserID] = ?");
                ps.setInt(1, r.getUserID());
                ResultSet rs2 = ps.executeQuery();
                rs2.next();
                r.setMentor(rs2.getString("fullname"));
                r.setRejectReason(rejectReason);
                if (r.getStatus().equalsIgnoreCase("reject")) {
                    ps = dbo.prepareStatement("SELECT * FROM [RejectRequest] WHERE [RequestID] = ?");
                    ps.setInt(1, rs.getInt("RequestID"));
                    rs2 = ps.executeQuery();
                    if (rs2.next()) {
                        r.setRejectReason(rs2.getString("Reason"));
                    }
                } else if (r.getStatus().equalsIgnoreCase("done")) {
                    ps = dbo.prepareStatement("SELECT * FROM [Rating] WHERE [RequestID] = ?");
                    ps.setInt(1, rs.getInt("RequestID"));
                    rs2 = ps.executeQuery();
                    if (rs2.next()) {
                        r.setRated(true);
                    }
                }
                ps = dbo.prepareStatement("SELECT * FROM [Skills] WHERE [SkillID] in (SELECT [SkillID] FROM [Request] WHERE [RequestID] = ?)");
                ps.setInt(1, rs.getInt("RequestID"));
                rs2 = ps.executeQuery();
                while (rs2.next()) {
                    r.getSkills().add(new Skill(rs2.getInt("SkillID"), rs2.getString("SkillName"), rs2.getInt("enable") == 1, rs2.getString("image"), rs2.getString("Description")));
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
                Request r = new Request(rs.getInt("RequestID"), rs.getInt("SendID"), rs.getInt("UserID"), rs.getString("RequestReason"), rs.getString("RequestStatus"), rs.getString("RequestSubject"), rs.getTimestamp("RequestTime"), rs.getTimestamp("DeadlineTime"));
                ps = dbo.prepareStatement("SELECT [fullname] FROM [User] WHERE [UserID] = ?");
                ps.setInt(1, r.getUserID());
                ResultSet rs2 = ps.executeQuery();
                rs2.next();
                r.setMentor(rs2.getString("fullname"));
                ps = dbo.prepareStatement("SELECT [username] FROM [User] WHERE [UserID] = ?");
                ps.setInt(1, r.getSendID());
                rs2 = ps.executeQuery();
                rs2.next();
                r.setSend(rs2.getString("username"));
                if (r.getStatus().equalsIgnoreCase("reject")) {
                    ps = dbo.prepareStatement("SELECT * FROM [RejectRequest] WHERE [RequestID] = ?");
                    ps.setInt(1, rs.getInt("RequestID"));
                    rs2 = ps.executeQuery();
                    if (rs2.next()) {
                        r.setRejectReason(rs2.getString("Reason"));
                    }
                }
                ps = dbo.prepareStatement("SELECT * FROM [Skills] WHERE [SkillID] in (SELECT [SkillID] FROM [Request] WHERE [RequestID] = ?)");
                ps.setInt(1, rs.getInt("RequestID"));
                rs2 = ps.executeQuery();
                while (rs2.next()) {
                    r.getSkills().add(new Skill(rs2.getInt("SkillID"), rs2.getString("SkillName"), rs2.getInt("enable") == 1, rs2.getString("image"), rs2.getString("Description")));
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
            PreparedStatement ps = dbo.prepareStatement("UPDATE [Request] SET [SendID] = ?, [RequestSubject] = ?, [RequestReason] = ?, [DeadlineTime] = ?, [RequestStatus] = ?, [SkillID] = ?, rejectReason=? WHERE [RequestID] = ?");
            ps.setInt(1, sid);
            ps.setString(2, subject);
            ps.setString(3, reason);
            ps.setTimestamp(4, deadline);
            ps.setString(5, status);
            ps.setInt(6, Integer.parseInt(skills[0]));
            ps.setString(7, null);
            ps.setInt(8, rid);
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

    public static double getMustPayAmount(int sendId) {
        double mustPay = 0;
        String sql = "select sum(C.MoneyOfSlot) as mustPay from Request as R\n"
                + "join RequestSlots as RS on RS.RequestID = R.RequestID\n"
                + "join Mentor as M \n"
                + "on M.UserID = R.UserID\n"
                + "join CV as C on C.CvID = M.CvID\n"
                + "where R.SendID = ? and R.RequestStatus != 'Close' and R.RequestStatus != 'Done' AND r.RequestStatus != 'Reject' AND r.RequestStatus != 'Processing'\n"
                + "group by R.SendID";
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement preparedStatement = dbo.prepareStatement(sql);
            preparedStatement.setInt(1, sendId);

            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                mustPay = resultSet.getDouble("mustPay");
            }
        } catch (Exception e) {
            System.out.println("Get total must pay: " + e);
        }
        return mustPay;
    }

    public static boolean createRequest(String[] skills, Timestamp deadline, String subject, String reason, int sid, int uid, String[] slots) throws Exception {
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("INSERT INTO [Request] ([SendID], [UserID], [RequestSubject], [RequestReason], [DeadlineTime], [RequestStatus], [SkillID]) VALUES (?, ?, ?, ?, ?, 'Open', ?)");
            ps.setInt(1, sid);
            ps.setInt(2, uid);
            ps.setString(3, subject);
            ps.setString(4, reason);
            ps.setTimestamp(5, deadline);
            ps.setInt(6, Integer.parseInt(skills[0]));
            int k = ps.executeUpdate();
            for (int i = 0; i < slots.length; i++) {
                ps = dbo.prepareStatement("INSERT INTO [RequestSlots] ([RequestID], [SlotID]) VALUES ((SELECT Top (1) [RequestID] FROM [Request] ORDER BY [RequestID] DESC), ?)");
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

    public static void main(String[] args) {
        try {
            int userId = 8; // Replace with the actual user ID you want to check
            ArrayList<Request> requests = getMenteeRequests(userId);
            for (Request request : requests) {
                System.out.println(request);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

//    public static void main(String[] args){
//        try{
//            ArrayList<Request> requests= getMentorRequests(3);
//            for(Request r:requests){
//                System.out.println(r.getId());
//            }
//        }catch(Exception e){}
//        
//    }
}
