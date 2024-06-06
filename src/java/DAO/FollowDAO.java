/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DataConnector.DatabaseUtil;
import Service.AuthorizationService;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import model.FollowRequest;
import model.Mentee;
import model.Mentor;
import model.User;

/**
 *
 * @author TGDD
 */
public class FollowDAO {
    
    public static ArrayList<Mentor> getFollowing(int uid) {
        ArrayList<Mentor> arr = new ArrayList();
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("SELECT * FROM [User] WHERE [UserID] in (SELECT [MentorID] FROM [Follow] WHERE [MenteeID] = ?)");
            ps.setInt(1, uid);
            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                Mentor m = new Mentor();
                m.setAvatar(rs.getString("Avatar"));
                m.setFullname(rs.getString("fullname"));
                m.setId(rs.getInt("UserID"));
                m.setAccount(rs.getString("username"));
                arr.add(m);
            }
            dbo.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
        return arr;
    }
    public static ArrayList<Mentee> getFollower(int uid) {
        ArrayList<Mentee> arr = new ArrayList();
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("SELECT * FROM [User] WHERE [UserID] in (SELECT [MenteeID] FROM [Follow] WHERE [MentorID] = ?)");
            ps.setInt(1, uid);
            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                Mentee m = new Mentee();
                m.setAvatar(rs.getString("Avatar"));
                m.setFullname(rs.getString("fullname"));
                m.setId(rs.getInt("UserID"));
                m.setAccount(rs.getString("username"));
                arr.add(m);
            }
            dbo.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
        return arr;
    }
    
    public static int following(int uid) {
        int following = 0;
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("SELECT Count([FollowID]) as following FROM [Follow] WHERE [MenteeID] = ?");
            ps.setInt(1, uid);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                following = rs.getInt("following");
            }
            dbo.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
        return following;
    }
    
    public static int follower(int uid) {
        int follower = 0;
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("SELECT Count([FollowID]) as follower FROM [Follow] WHERE [MentorID] = ?");
            ps.setInt(1, uid);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                follower = rs.getInt("follower");
            }
            dbo.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
        return follower;
    }
    
    public static int followRequest(int uid) {
        int requests = 0;
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("SELECT Count([RequestID]) as requests FROM [FollowRequest] WHERE [MentorID] = ?");
            ps.setInt(1, uid);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                requests = rs.getInt("requests");
            }
            dbo.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
        return requests;
    }
    
    public static void rejectFollowRequest(int uid, int rid) {
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("DELETE FROM [FollowRequest] WHERE [MentorID] = ? AND [RequestID] = ?");
            ps.setInt(1, uid);
            ps.setInt(2, rid);
            ps.executeUpdate();
            dbo.commit();
            dbo.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
    }
    
    public static void acceptFollowRequest(int uid, int rid) {
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("INSERT INTO [Follow] ([MentorID], [MenteeID]) VALUES (?, (SELECT [SenderID] FROM [FollowRequest] WHERE [RequestID] = ?))");
            ps.setInt(1, uid);
            ps.setInt(2, rid);
            ps.executeUpdate();
            ps = dbo.prepareStatement("DELETE FROM [FollowRequest] WHERE [MentorID] = ? AND [RequestID] = ?");
            ps.setInt(1, uid);
            ps.setInt(2, rid);
            ps.executeUpdate();
            dbo.commit();
            dbo.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
    }
    
    public static void cancelFollowRequest(int uid, int sid) {
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("DELETE FROM [FollowRequest] WHERE [MentorID] = ? AND [SenderID] = ?");
            ps.setInt(1, uid);
            ps.setInt(2, sid);
            ps.executeUpdate();
            dbo.commit();
            dbo.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
    }
    
    public static void unFollow(int uid, int sid) {
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("DELETE FROM [Follow] WHERE [MentorID] = ? AND [MenteeID] = ?");
            ps.setInt(1, uid);
            ps.setInt(2, sid);
            ps.executeUpdate();
            dbo.commit();
            dbo.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
    }
    
    public static ArrayList<FollowRequest> getRequests(int uid) {
        ArrayList<FollowRequest> arr = new ArrayList();
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("SELECT [RequestID],[RequestTime],[DeadLineTime],[Subject],[Content],[Status],[MentorID],[SendID], (SELECT [fullname] FROM [User] WHERE [UserID] = [FollowRequest].[SendID]) as [Send], (SELECT [fullname] FROM [User] WHERE [UserID] = [FollowRequest].[MentorID]) as [Mentor] FROM [FollowRequest] WHERE [MentorID] = ?");
            ps.setInt(1, uid);
            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                arr.add(new FollowRequest(rs.getInt("RequestID"), rs.getString("Subject"), rs.getString("Content"), rs.getInt("SendID"), rs.getInt("MentorID"), rs.getString("Send"), rs.getString("Mentor"), rs.getTimestamp("DeadLineTime"), rs.getTimestamp("RequestTime"), rs.getString("Status")));
            }
            dbo.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
        return arr;
    }
    
    public static boolean onPending(User u, int id) {
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("SELECT * FROM [FollowRequest] WHERE [MentorID] = ? AND [SenderID] = ?");
            ps.setInt(1, id);
            ps.setInt(2, u.getId());
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                dbo.close();
                return true;
            }
            dbo.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public static boolean onFollow(User u, int id) {
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("SELECT * FROM [Follow] WHERE [MentorID] = ? AND [MenteeID] = ?");
            ps.setInt(1, id);
            ps.setInt(2, u.getId());
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                dbo.close();
                return true;
            }
            dbo.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
        return false;
    }
    
    public static void sendRequest(int uid, String title, String reason, int sid) throws Exception {
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("INSERT INTO [FollowRequest] ([Subject], [Content], [Status], [MentorID], [SenderID]) VALUES (?, ?, N'Pending', ?, ?)");
            ps.setString(1, title);
            ps.setString(2, reason);
            ps.setInt(3, uid);
            ps.setInt(4, sid);
            ps.executeUpdate();
            dbo.commit();
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            dbo.close();
        }
    }
}
