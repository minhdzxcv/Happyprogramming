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
import model.Rate;

/**
 *
 * @author TGDD
 */
public class RateDAO {
    public static void Rating(int rid, int noStar, String comment) throws Exception {
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("INSERT INTO [Rating] ([MentorID], [MenteeID], [noStar], [ratingComment], [RequestID]) VALUES ((SELECT [UserID] FROM [Request] WHERE [RequestID] = ?), (SELECT [SenderID] FROM [Request] WHERE [RequestID] = ?), ?, ?, ?)");
            ps.setInt(1, rid);
            ps.setInt(2, rid);
            ps.setInt(3, noStar);
            ps.setString(4, comment);
            ps.setInt(5, rid);
            ps.executeUpdate();
            dbo.commit();
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            dbo.close();
        }
    }
    public static ArrayList<Rate> getRates(int uid) throws Exception {
        ArrayList<Rate> arr = new ArrayList();
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("SELECT [MentorID]\n" +
"      ,[MenteeID]\n" +
"      ,[Star]\n" +
"      ,[Comment]\n" +
"      ,[Time]\n" +
"      ,[RequestID], (SELECT [username] FROM [User] WHERE [UserID] = [Rating].[MenteeID]) as [fullname], (SELECT [Avatar] FROM [User] WHERE [UserID] = [Rating].[MenteeID]) as [Avatar] FROM [Rating] WHERE [MentorID] = ?");
            ps.setInt(1, uid);
            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                arr.add(new Rate(rs.getInt("MenteeID"), rs.getInt("MentorID"), rs.getInt("Star"), rs.getString("fullname"), rs.getString("Avatar"), rs.getString("Comment"), rs.getTimestamp("Time"), rs.getInt("RequestID")));
            }
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            dbo.close();
        }
        return arr;
    }
}
