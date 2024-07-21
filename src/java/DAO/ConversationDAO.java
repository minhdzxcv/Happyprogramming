/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DataConnector.DatabaseUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import model.Conversation;
import model.Message;

/**
 *
 * @author TGDD
 */
public class ConversationDAO {
    
    public static void CreateConversation(int uid, int id, boolean isMentor) throws Exception {
        Connection dbo = DatabaseUtil.getConn();
            PreparedStatement ps = dbo.prepareStatement("INSERT INTO [Conversation] VALUES (?, ?)");
        if(isMentor) {
            ps.setInt(1, uid);
            ps.setInt(2, id);
        } else {
            ps.setInt(1, id);
            ps.setInt(2, uid);
        }
        ps.executeUpdate();
        dbo.commit();
        dbo.close();
    }
    
    public static void createMessage(int sid, int cid, String msg) throws Exception {
        Connection dbo = DatabaseUtil.getConn();
        PreparedStatement ps = dbo.prepareStatement("INSERT INTO [Message] ([conversationID], [SenderID], [msgContent], [sentAt]) VALUES (?, ?, ?, ?)");
        ps.setInt(1, cid);
        ps.setInt(2, sid);
        ps.setString(3, msg);
        ps.setTimestamp(4, Timestamp.from(new java.util.Date().toInstant()));
        ps.executeUpdate();
        dbo.commit();
        dbo.close();
    }
    
    public static ArrayList<Message> getMessagesByCID(int cid) throws Exception {
        ArrayList<Message> arr = new ArrayList();
        Connection dbo = DatabaseUtil.getConn();
        PreparedStatement ps = dbo.prepareStatement("SELECT * FROM [Message] WHERE [conversationID] = ?");
        ps.setInt(1, cid);
        ResultSet rs = ps.executeQuery();
        while(rs.next()) {
            arr.add(new Message(rs.getInt("MessageID"), rs.getInt("conversationID"), rs.getInt("SenderID"), rs.getTimestamp("sentAt"), rs.getString("msgContent")));
        }
        dbo.close();
        return arr;
    }
    
    public static Conversation getLastConversation(int uid) throws Exception {
        Conversation c = null;
        Connection dbo = DatabaseUtil.getConn();
        PreparedStatement ps = dbo.prepareStatement("SELECT TOP (1) *, (SELECT TOP (1) [msgContent] FROM [Message] WHERE [Message].conversationID = [Conversation].conversationID ORDER BY [sentAt] DESC) as LastMsg, (SELECT TOP (1) [sentAt] FROM [Message] WHERE [Message].conversationID = [Conversation].conversationID  ORDER BY [sentAt] DESC) as LastTime FROM [Conversation] WHERE ([MentorID] = ? ) OR ([MenteeID] = ?) ORDER BY LastTime DESC");
        ps.setInt(1, uid);
        ps.setInt(2, uid);
        ResultSet rs = ps.executeQuery();
        if(rs.next()) {
            c = new Conversation(rs.getInt("conversationID"), rs.getInt("MentorID"), rs.getInt("MenteeID"));
            c.setLastMsg(rs.getString("LastMsg"));
            c.setLastTime(rs.getTimestamp("LastTime"));
            ps = dbo.prepareStatement("SELECT * FROM [User] WHERE [UserID] = ?");
            if(rs.getInt("MentorID") == uid) {
                ps.setInt(1, rs.getInt("MenteeID"));
                c.setUserID(rs.getInt("MenteeID"));
            } else {
                ps.setInt(1, rs.getInt("MentorID"));
                c.setUserID(rs.getInt("MentorID"));
            }
            ResultSet rs2 = ps.executeQuery();
            if(rs2.next()) {
                c.setAvatar(rs2.getString("Avatar"));
                c.setFullName(rs2.getString("fullname"));
            }
        }
        dbo.close();
        return c;
    }
    
    public static Conversation getConversation(int uid, int id) throws Exception {
        Conversation c = null;
        Connection dbo = DatabaseUtil.getConn();
        PreparedStatement ps = dbo.prepareStatement("SELECT *, (SELECT TOP (1) [msgContent] FROM [Message] WHERE [Message].conversationID = [Conversation].conversationID ORDER BY [sentAt] DESC) as LastMsg, (SELECT TOP (1) [sentAt] FROM [Message] WHERE [Message].conversationID = [Conversation].conversationID  ORDER BY [sentAt] DESC) as LastTime FROM [Conversation] WHERE ([MentorID] = ? AND [MenteeID] = ?) OR ([MentorID] = ? AND [MenteeID] = ?)");
        ps.setInt(1, uid);
        ps.setInt(2, id);
        ps.setInt(3, id);
        ps.setInt(4, uid);
        ResultSet rs = ps.executeQuery();
        if(rs.next()) {
            c = new Conversation(rs.getInt("conversationID"), rs.getInt("MentorID"), rs.getInt("MenteeID"));
            c.setLastMsg(rs.getString("LastMsg"));
            c.setLastTime(rs.getTimestamp("LastTime"));
            ps = dbo.prepareStatement("SELECT * FROM [User] WHERE [UserID] = ?");
            if(rs.getInt("MentorID") == uid) {
                ps.setInt(1, rs.getInt("MenteeID"));
                c.setUserID(rs.getInt("MenteeID"));
            } else {
                ps.setInt(1, rs.getInt("MentorID"));
                c.setUserID(rs.getInt("MentorID"));
            }
            ResultSet rs2 = ps.executeQuery();
            if(rs2.next()) {
                c.setAvatar(rs2.getString("Avatar"));
                c.setFullName(rs2.getString("fullname"));
            }
        }
        dbo.close();
        return c;
    }
    
    public static ArrayList<Message> getMessages(int uid, int id) throws Exception {
        ArrayList<Message> arr = new ArrayList();
        Connection dbo = DatabaseUtil.getConn();
        PreparedStatement ps = dbo.prepareStatement("SELECT * FROM [Message] WHERE [conversationID] = (SELECT [conversationID] FROM [Conversation] WHERE ([MentorID] = ? AND [MenteeID] = ?) OR ([MentorID] = ? AND [MenteeID] = ?))");
        ps.setInt(1, uid);
        ps.setInt(2, id);
        ps.setInt(3, id);
        ps.setInt(4, uid);
        ResultSet rs = ps.executeQuery();
        while(rs.next()) {
            arr.add(new Message(rs.getInt("MessageID"), rs.getInt("conversationID"), rs.getInt("SenderID"), rs.getTimestamp("sentAt"), rs.getString("msgContent")));
        }
        dbo.close();
        return arr;
    }
    
    public static ArrayList<Conversation> getConversation(int uid) throws Exception {
        ArrayList<Conversation> arr = new ArrayList();
        Connection dbo = DatabaseUtil.getConn();
        PreparedStatement ps = dbo.prepareStatement("SELECT *, (SELECT TOP (1) [msgContent] FROM [Message] WHERE [Message].conversationID = [Conversation].conversationID ORDER BY [sentAt] DESC) as LastMsg, (SELECT TOP (1) [sentAt] FROM [Message] WHERE [Message].conversationID = [Conversation].conversationID  ORDER BY [sentAt] DESC) as LastTime FROM [Conversation] WHERE [MentorID] = ? OR [MenteeID] = ? ORDER BY LastTime DESC");
        ps.setInt(1, uid);
        ps.setInt(2, uid);
        ResultSet rs = ps.executeQuery();
        while(rs.next()) {
            Conversation c = new Conversation(rs.getInt("conversationID"), rs.getInt("MentorID"), rs.getInt("MenteeID"));
            c.setLastMsg(rs.getString("LastMsg"));
            c.setLastTime(rs.getTimestamp("LastTime"));
            ps = dbo.prepareStatement("SELECT * FROM [User] WHERE [UserID] = ?");
            if(rs.getInt("MentorID") == uid) {
                ps.setInt(1, rs.getInt("MenteeID"));
                
                c.setUserID(rs.getInt("MenteeID"));
            } else {
                ps.setInt(1, rs.getInt("MentorID"));
                
                c.setUserID(rs.getInt("MentorID"));
            }
            ResultSet rs2 = ps.executeQuery();
            if(rs2.next()) {
                c.setAvatar(rs2.getString("Avatar"));
                c.setFullName(rs2.getString("fullname"));
            }
            arr.add(c);
        }
        dbo.close();
        return arr;
    }
}
