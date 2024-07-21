/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DataConnector.DatabaseUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import model.Bank;

/**
 *
 * @author TGDD
 */
public class BankDAO {
    
    public static void createNewTrans(String TransCode, String Content, int uid, int balance, boolean type) throws Exception {
        Connection dbo = DatabaseUtil.getConn();
        PreparedStatement ps = dbo.prepareStatement("INSERT INTO [Transaction] ([UserID]\n" +
"      ,[Balance]\n" +
"      ,[Type]\n" +
"      ,[Content]\n" +
"      ,[Status]\n" +
"      ,[TransCode]) VALUES (?, ?, ?, ?, ?, "+TransCode+")");
        ps.setInt(1, uid);
        ps.setInt(2, balance);
        ps.setString(3, type ? "+" : "-");
        ps.setString(4, Content);
        ps.setString(5, "Pending");
        ps.executeUpdate();
        dbo.commit();
        dbo.close();
    }
    
    public static int UpdateTrans(String TransCode, String status) throws Exception {
        Connection dbo = DatabaseUtil.getConn();
        PreparedStatement ps = dbo.prepareStatement("SELECT [UserID] FROM [Transaction] WHERE [TransCode] = " + TransCode + " AND [Status] = N'Pending'");
        ResultSet rs = ps.executeQuery();
        int uid = -1;
        if(rs.next()) {
            uid = rs.getInt("UserID");
        }
        ps = dbo.prepareStatement("UPDATE [Transaction] SET [Status] = ? WHERE [TransCode] = " + TransCode + " AND [Status] = N'Pending'");
        ps.setString(1, status);
        ps.executeUpdate();
        dbo.commit();
        dbo.close();
        return uid;
    }

    public static void updateBank(int id, String BankName, String BankNo, String BankType) throws Exception {
        boolean insert = (getBank(id) == null);
        String sql = "INSERT INTO [UserBank] ([UserID], [BankName], [BankNo], [BankType]) VALUES (?, ?, ?, ?)";
        if (!insert) {
            sql = "UPDATE [UserBank] [BankName] = ?, [BankNo] = ?, [BankType] = ? WHERE [UserID] = ?";
        }
        Connection dbo = DatabaseUtil.getConn();
        PreparedStatement ps = dbo.prepareStatement(sql);
        if (!insert) {
            ps.setString(1, BankName);
            ps.setString(2, BankNo);
            ps.setString(3, BankType);
            ps.setInt(4, id);
        } else {
            ps.setInt(1, id);
            ps.setString(2, BankName);
            ps.setString(3, BankNo);
            ps.setString(4, BankType);
        }
        ps.executeUpdate();
        dbo.commit();
        dbo.close();
    }
    
    public static boolean checkingTransCode(String code) throws Exception  {
        Connection dbo = DatabaseUtil.getConn();
        PreparedStatement ps = dbo.prepareStatement("SELECT * FROM [Transaction] WHERE [TransCode] = "+code);
        ResultSet rs = ps.executeQuery();
        if(rs.next()) {
            dbo.close();
            return true;
        }
        dbo.close();
        return false;
    }

    public static Bank getBank(int id) throws Exception {
        Connection dbo = DatabaseUtil.getConn();
        PreparedStatement ps = dbo.prepareStatement("SELECT * FROM [UserBank] WHERE [UserID] = ?");
        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            Bank b = new Bank(id, rs.getString("BankName"), rs.getString("BankNo"), rs.getString("BankType"));
            dbo.close();
            return b;
        }
        dbo.close();
        return null;
    }

}
