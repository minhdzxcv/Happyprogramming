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
import model.Role;

/**
 *
 * @author TGDD
 */
public class RoleDAO {
    
    
    public static ArrayList<Role> getRoles() throws Exception {
        Connection dbo = DatabaseUtil.getConn();
        ArrayList<Role> arr = new ArrayList();
        PreparedStatement ps = dbo.prepareStatement("SELECT * FROM Role");
        ResultSet rs = ps.executeQuery();
        while(rs.next()) {
            arr.add(new Role(rs.getInt("roleID"), rs.getString("roleName")));
        }
        dbo.close();
        return arr;
        
    }
}
