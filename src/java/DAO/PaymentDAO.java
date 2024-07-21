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

    public static void confirmPayment(int id) throws Exception {
        Connection dbo = DatabaseUtil.getConn();
        PreparedStatement ps = dbo.prepareStatement("UPDATE [User] SET [wallet] = [wallet] + (SELECT [Balance] FROM [Payment] WHERE [ID] = ?) WHERE [UserID] = (SELECT [ReceiverID] FROM [Payment] WHERE [ID] = ?)");
        ps.setInt(1, id);
        ps.setInt(2, id);
        ps.executeUpdate();
        ps = dbo.prepareStatement("UPDATE [Payment] SET [Status] = N'Received' WHERE [ID] = ?");
        ps.setInt(1, id);
        ps.executeUpdate();
        dbo.commit();
        dbo.close();
    }

    public static ArrayList<payment> getPayments() throws Exception {
        ArrayList<payment> arr = new ArrayList();
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("SELECT *, (SELECT [fullname] FROM [User] WHERE [UserID] = [Payment].[UserID]) as [Mentee], (SELECT [fullname] FROM [User] WHERE [UserID] = [Payment].[ReceiverID]) as [Mentor], (SELECT [RequestStatus] FROM [Request] WHERE [RequestID] = [Payment].[RequestID]) as [isDone] FROM [Payment]");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                payment p = new payment(rs.getInt("ID"), rs.getString("Status"), rs.getInt("Balance"), rs.getInt("UserID"), rs.getInt("ReceiverID"), rs.getDate("Time"), rs.getInt("RequestID"), rs.getString("Mentee"), rs.getString("Mentor"));
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
