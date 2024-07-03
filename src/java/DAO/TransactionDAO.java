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
import model.Transaction;
import model.Withdraw;

/**
 *
 * @author TGDD
 */
public class TransactionDAO {
    
    public static ArrayList<Withdraw> getWithdraw() throws Exception {
        ArrayList<Withdraw> arr = new ArrayList();
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("SELECT t.ID , u.email ,  u.fullname , b.TypeBank , b.UserBank ,  b.NoBank , t.Price , t.Status FROM [Transaction] t JOIN [User] U On t.UserID = u.UserID JOIN Bank b ON b.UserID = u.UserID WHERE [Content] = N'Rút tiền' ORDER BY t.[Status] ASC");
            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                arr.add(new Withdraw(rs.getInt("ID"), rs.getString("email"), rs.getString("fullname"), rs.getString("TypeBank"), rs.getString("UserBank"), rs.getString("NoBank"), rs.getInt("price"), rs.getString("Status")));
            }
        } catch(Exception e) {
            e.printStackTrace();
        }
        dbo.close();
        return arr;
    }
    
    public static void acceptWithdraw(int id) throws Exception {
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("UPDATE [Transaction] SET [Status] = N'Success' WHERE [ID] = ?");
            ps.setInt(1, id);
            ps.executeUpdate();
            dbo.commit();
        } catch(Exception e) {
            e.printStackTrace();
        }
        dbo.close();
        
    }
    
    public static void withdraw(int uid, int money) throws Exception {
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("INSERT INTO [Transaction] ([UserID], [price], [Type], [Content], [Status]) VALUES (?, ?, N'-', N'Rút tiền', N'Pending')");
            ps.setInt(1, uid);
            ps.setInt(2, money);
            ps.executeUpdate();
            ps = dbo.prepareStatement("UPDATE [User] SET [wallet] = [wallet] - ? WHERE [UserID] = ?");
            ps.setInt(1, money);
            ps.setInt(2, uid);
            ps.executeUpdate();
            dbo.commit();
        } catch(Exception e) {
            e.printStackTrace();
        }
        dbo.close();
    }
    
    public static ArrayList<Transaction> getTransactionById(int id) throws Exception {
        ArrayList<Transaction> arr = new ArrayList();
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("SELECT * FROM [Transaction] WHERE [UserID] = ?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                arr.add(new Transaction(rs.getInt("ID"), rs.getInt("UserID"), rs.getInt("price"), rs.getString("Type"), rs.getString("Content"), rs.getDate("Time"), rs.getString("Status")));
            }
        } catch(Exception e) {
            e.printStackTrace();
        }
        return arr;
    }
}
