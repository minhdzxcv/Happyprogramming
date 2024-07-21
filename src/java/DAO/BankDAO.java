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

    public static void createNewTrans(String Code, String Content, int uid, int price, boolean type) throws Exception {
        Connection dbo = DatabaseUtil.getConn();
        PreparedStatement ps = dbo.prepareStatement("INSERT INTO [Transaction] ([UserID]\n"
                + "      ,[price]\n"
                + "      ,[Type]\n"
                + "      ,[Content]\n"
                + "      ,[Status]\n"
                + "      ,[Code]) VALUES (?, ?, ?, ?, ?, " + Code + ")");
        ps.setInt(1, uid);
        ps.setInt(2, price);
        ps.setString(3, type ? "+" : "-");
        ps.setString(4, Content);
        ps.setString(5, "Pending");
        ps.executeUpdate();
        dbo.commit();
        dbo.close();
    }

    public static int UpdateTrans(String Code, String status) throws Exception {
        Connection dbo = DatabaseUtil.getConn();
        PreparedStatement ps = dbo.prepareStatement("SELECT [UserID] FROM [Transaction] WHERE [Code] = " + Code + " AND [Status] = N'Pending'");
        ResultSet rs = ps.executeQuery();
        int uid = -1;
        if (rs.next()) {
            uid = rs.getInt("UserID");
        }
        ps = dbo.prepareStatement("UPDATE [Transaction] SET [Status] = ? WHERE [Code] = " + Code + " AND [Status] = N'Pending'");
        ps.setString(1, status);
        ps.executeUpdate();
        dbo.commit();
        dbo.close();
        return uid;
    }

    public static void updateBank(int id, String UserBank, String BankNo, String BankType) throws Exception {
        boolean insert = (getBank(id) == null);
        String sql = "INSERT INTO [Bank] ([UserID], [UserBank], [NoBank], [TypeBank]) VALUES (?, ?, ?, ?)";
        if (!insert) {
            sql = "UPDATE [Bank]\n"
                    + "SET \n"
                    + "    UserBank = ?,\n"
                    + "    NoBank = ?,\n"
                    + "    TypeBank = ?\n"
                    + "WHERE \n"
                    + "    UserID = ?";
        }
        Connection dbo = DatabaseUtil.getConn();
        PreparedStatement ps = dbo.prepareStatement(sql);
        if (!insert) {
            ps.setString(1, UserBank);
            ps.setString(2, BankNo);
            ps.setString(3, BankType);
            ps.setInt(4, id);
        } else {
            ps.setInt(1, id);
            ps.setString(2, UserBank);
            ps.setString(3, BankNo);
            ps.setString(4, BankType);
        }
        ps.executeUpdate();
        dbo.commit();
        dbo.close();
    }

    public static boolean checkingTransCode(String code) throws Exception {
        Connection dbo = DatabaseUtil.getConn();
        PreparedStatement ps = dbo.prepareStatement("SELECT * FROM [Transaction] WHERE [Code] = " + code);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            dbo.close();
            return true;
        }
        dbo.close();
        return false;
    }

    public static Bank getBank(int id) throws Exception {
        Connection dbo = DatabaseUtil.getConn();
        PreparedStatement ps = dbo.prepareStatement("SELECT * FROM [Bank] WHERE [UserID] = ?");
        ps.setInt(1, id);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            Bank b = new Bank(id, rs.getString("UserBank"), rs.getString("NoBank"), rs.getString("TypeBank"));
            dbo.close();
            return b;
        }
        dbo.close();
        return null;
    }

    public static void main(String[] args) {
        // Hard-coded data for demonstration purposes
        int id = 4; // Example User ID
        String bankName = "Doan Nhat Minh";
        String bankNo = "123456789";
        String bankType = "MB Bank";

        try {
            updateBank(id, bankName, bankNo, bankType);
            System.out.println("Bank record updated successfully.");
        } catch (Exception e) {
            System.err.println("Error updating bank record: " + e.getMessage());
        }

    }
}
