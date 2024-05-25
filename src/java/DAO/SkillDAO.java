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
import model.Skill;

/**
 *
 * @author ADMIN
 */
public class SkillDAO {
    public static ArrayList<Skill> getAll() throws Exception {
        ArrayList<Skill> arr = new ArrayList();
        Connection dbo = DatabaseUtil.getConn();
        PreparedStatement ps = dbo.prepareStatement("SELECT * FROM Skills");
        ResultSet rs = ps.executeQuery();
        while(rs.next()) {
            arr.add(new Skill(rs.getInt("SkillID"), rs.getString("SkillName"), rs.getInt("enable") == 1, rs.getString("image"), rs.getString("Description")));
        }
        dbo.close();
        return arr;
    }
    public static boolean contains(ArrayList<Skill> arr, Skill i) {
        for (int j = 0; j < arr.size(); j++) {
            if(arr.get(j).getId() == i.getId()) {
                return true;
            }
        }
        return false;
    }
    public static ArrayList<Skill> getAll(boolean enable) throws Exception {
        ArrayList<Skill> arr = new ArrayList();
        Connection dbo = DatabaseUtil.getConn();
        PreparedStatement ps = dbo.prepareStatement("SELECT * FROM Skills WHERE enable = "+(enable ? 1 : 0));
        ResultSet rs = ps.executeQuery();
        while(rs.next()) {
            arr.add(new Skill(rs.getInt("SkillID"), rs.getString("SkillName"), rs.getInt("enable") == 1, rs.getString("image"), rs.getString("Description")));
        }
        dbo.close();
        return arr;
    }
    
    
       
    

}
