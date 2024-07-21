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
import model.payment;

/**
 *
 * @author TGDD
 */
public class PaymentDAO {

    public static void confirmPayment(int paymentId) throws Exception {
        Connection dbo = DatabaseUtil.getConn();
        PreparedStatement ps = null;
        ResultSet rs = null;

        try {
            dbo.setAutoCommit(false);

            ps = dbo.prepareStatement(
                    "SELECT [price], [ReceiverID] FROM [Payment] WHERE [ID] = ?"
            );
            ps.setInt(1, paymentId);
            rs = ps.executeQuery();

            if (!rs.next()) {
                throw new Exception("Payment not found");
            }

            double price = rs.getDouble("price");
            int receiverId = rs.getInt("ReceiverID");

            rs.close();
            ps.close();

            ps = dbo.prepareStatement(
                    "SELECT [UserID] FROM [User] WHERE [roleID] = 2"
            );
            rs = ps.executeQuery();

            if (!rs.next()) {
                throw new Exception("No user with role 2 found");
            }

            int role2UserId = rs.getInt("UserID");

            rs.close();
            ps.close();

            ps = dbo.prepareStatement(
                    "UPDATE [User] SET [wallet] = [wallet] - ? WHERE [UserID] = ?"
            );
            ps.setDouble(1, price);
            ps.setInt(2, role2UserId);
            ps.executeUpdate();
            dbo.commit();
            ps.close();

            ps = dbo.prepareStatement(
                    "UPDATE [User] SET [wallet] = [wallet] + ? WHERE [UserID] = ?"
            );
            ps.setDouble(1, price);
            ps.setInt(2, receiverId);
            ps.executeUpdate();
            dbo.commit();
            ps.close();

            ps = dbo.prepareStatement(
                    "UPDATE [Payment] SET [Status] = N'Received' WHERE [ID] = ?"
            );
            ps.setInt(1, paymentId);
            ps.executeUpdate();
            dbo.commit();

        } catch (Exception e) {
            dbo.rollback();
            throw e;
        } finally {
            // Đóng tài nguyên
            if (rs != null) {
                rs.close();
            }
            if (ps != null) {
                ps.close();
            }
            if (dbo != null) {
                dbo.close();
            }
        }
    }

    public static ArrayList<payment> getPayments() throws Exception {
        ArrayList<payment> arr = new ArrayList();
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("SELECT *, (SELECT [fullname] FROM [User] WHERE [UserID] = [Payment].[UserID]) as [Mentee], (SELECT [fullname] FROM [User] WHERE [UserID] = [Payment].[ReceiverID]) as [Mentor], (SELECT [RequestStatus] FROM [Request] WHERE [RequestID] = [Payment].[RequestID]) as [isDone] FROM [Payment]");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                payment p = new payment(rs.getInt("ID"), rs.getString("Status"), rs.getInt("price"), rs.getInt("UserID"), rs.getInt("ReceiverID"), rs.getDate("Time"), rs.getInt("RequestID"), rs.getString("Mentee"), rs.getString("Mentor"));
                if (rs.getString("isDone").equalsIgnoreCase("done")) {
                    p.setRequestDone(true);
                }
                arr.add(p);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        dbo.close();
        return arr;
    }
}
