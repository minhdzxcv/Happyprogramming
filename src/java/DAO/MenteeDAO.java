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
import model.MenteeStatistic;
import model.Mentor;

/**
 *
 * @author TGDD
 */
public class MenteeDAO {
    
    
    public static MenteeStatistic getMenteeStatistic(int uid) {
        MenteeStatistic ms = null;
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("SELECT \n" +
"    [UserID],\n" +
"    [gender],\n" +
"    [status],\n" +
"    [username],\n" +
"    [password],\n" +
"    [dob],\n" +
"    [email],\n" +
"    [phoneNumber],\n" +
"    [wallet],\n" +
"    [address],\n" +
"    [roleID],\n" +
"    [isValidate],\n" +
"    [Avatar],\n" +
"    [fullname], \n" +
"    (SELECT COUNT([RequestID]) \n" +
"     FROM [Request] \n" +
"     WHERE [SendID] = [User].[UserID]) AS TotalRequest, \n" +
"    (SELECT COUNT([SkillID]) \n" +
"     FROM [Slots] \n" +
"     WHERE [MenteeID] = [User].[UserID]) AS TotalSkill, \n" +
"    (SELECT SUM([Time]) \n" +
"     FROM [Slots] \n" +
"     WHERE [MenteeID] = [User].[UserID]) AS TotalHour, \n" +
"    (SELECT COUNT([RequestID]) \n" +
"     FROM [RejectRequest] \n" +
"     WHERE [RequestID] IN \n" +
"         (SELECT [RequestID] \n" +
"          FROM [Request] \n" +
"          WHERE [SendID] = [User].[UserID])) AS RejectedRequest, \n" +
"    (SELECT COUNT([RequestID]) \n" +
"     FROM [Request] \n" +
"     WHERE [SendID] = [User].[UserID] \n" +
"     AND [RequestStatus] != N'Open' \n" +
"     AND [RequestStatus] != N'Close' \n" +
"     AND [RequestStatus] != N'Reject') AS AcceptedRequest, \n" +
"    (SELECT COUNT([UserID]) \n" +
"     FROM [Request] \n" +
"     WHERE [SendID] = [User].[UserID]) AS TotalMentor \n" +
"FROM \n" +
"    [User] \n" +
"WHERE \n" +
"    [UserID] = ?");
            ps.setInt(1, uid);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                ms = new MenteeStatistic();
                ms.setId(rs.getInt("UserID"));
                ms.setName(rs.getString("username"));
                ms.setFullname(rs.getString("fullname"));
                ms.setTotalHours(rs.getFloat("TotalHour"));
                ms.setTotalRequest(rs.getInt("TotalRequest"));
                ms.setTotalSkill(rs.getInt("TotalSkill"));
                ms.setAcceptedRequest(rs.getInt("AcceptedRequest"));
                ms.setRejectedRequest(rs.getInt("RejectedRequest"));
                ms.setTotalMentor(rs.getInt("TotalMentor"));
            }
            dbo.close();
        } catch(Exception e) {}
        return ms;
    }
    
    public static ArrayList<MenteeStatistic> getMenteeStatistic() {
        ArrayList<MenteeStatistic> arr = new ArrayList();
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("SELECT \n" +
"    [UserID],\n" +
"    [gender],\n" +
"    [status],\n" +
"    [username],\n" +
"    [password],\n" +
"    [dob],\n" +
"    [email],\n" +
"    [phoneNumber],\n" +
"    [wallet],\n" +
"    [address],\n" +
"    [roleID],\n" +
"    [isValidate],\n" +
"    [Avatar],\n" +
"    [fullname], \n" +
"    (SELECT COUNT([RequestID]) \n" +
"     FROM [Request] \n" +
"     WHERE [SendID] = [User].[UserID]) AS TotalRequest, \n" +
"    (SELECT COUNT([SkillID]) \n" +
"     FROM [Slots] \n" +
"     WHERE [MenteeID] = [User].[UserID]) AS TotalSkill, \n" +
"    (SELECT SUM([Time]) \n" +
"     FROM [Slots] \n" +
"     WHERE [MenteeID] = [User].[UserID]) AS TotalHour, \n" +
"    (SELECT COUNT([RequestID]) \n" +
"     FROM [RejectRequest] \n" +
"     WHERE [RequestID] IN \n" +
"         (SELECT [RequestID] \n" +
"          FROM [Request] \n" +
"          WHERE [SendID] = [User].[UserID])) AS RejectedRequest, \n" +
"    (SELECT COUNT([RequestID]) \n" +
"     FROM [Request] \n" +
"     WHERE [SendID] = [User].[UserID] \n" +
"     AND [RequestStatus] != N'Open' \n" +
"     AND [RequestStatus] != N'Close' \n" +
"     AND [RequestStatus] != N'Reject') AS AcceptedRequest \n" +
"FROM \n" +
"    [User] \n" +
"WHERE \n" +
"    [UserID] IN (SELECT [UserID] FROM [Mentee])");
            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                MenteeStatistic ms = new MenteeStatistic();
                ms.setId(rs.getInt("UserID"));
                ms.setName(rs.getString("username"));
                ms.setFullname(rs.getString("fullname"));
                ms.setTotalHours(rs.getFloat("TotalHour"));
                ms.setTotalRequest(rs.getInt("TotalRequest"));
                ms.setTotalSkill(rs.getInt("TotalSkill"));
                ms.setAcceptedRequest(rs.getInt("AcceptedRequest"));
                ms.setRejectedRequest(rs.getInt("RejectedRequest"));
                arr.add(ms);
            }
            dbo.close();
        } catch(Exception e) {}
        return arr;
    }
}
