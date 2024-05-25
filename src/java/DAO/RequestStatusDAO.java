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
import model.Request;
import model.RequestStatus;
import model.Skill;

/**
 *
 * @author TGDD
 */
public class RequestStatusDAO {
    public static ArrayList<RequestStatus> getStatus() throws Exception {
        ArrayList<RequestStatus> arr = new ArrayList();
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("SELECT * FROM [RequestStatus]");
            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                arr.add(new RequestStatus(rs.getInt("id"), rs.getString("status")));
            }
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            dbo.close();
        }
        return arr;
    }
}
