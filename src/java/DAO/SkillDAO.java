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
 * @author TGDD
 */
public class SkillDAO {
    
 
    public static boolean createSkill(String name, boolean active) throws Exception {
        Connection dbo = DatabaseUtil.getConn();
        PreparedStatement ps = dbo.prepareStatement("INSERT INTO Skills (SkillName, enable) VALUES (?, ?)");
        ps.setString(1, name);
        ps.setInt(2, active ? 1 : 0);
        int k = ps.executeUpdate();
        dbo.commit();
        dbo.close();
        if(k > 0)
            return true;
        return false;
        
    }
    

    
    public static int skillCount() throws Exception {
        Connection dbo = DatabaseUtil.getConn();
        PreparedStatement ps = dbo.prepareStatement("SELECT Count(SkillID) as count FROM Skills");
        ResultSet rs = ps.executeQuery();
        rs.next();
        int rel = rs.getInt("count");
        dbo.close();
        return rel;
    }
    
 
    public static boolean UpdateSkill(int id, String name, boolean active) throws Exception {
        Connection dbo = DatabaseUtil.getConn();
        PreparedStatement ps = dbo.prepareStatement("UPDATE Skills SET SkillName = ?, enable = ? WHERE SkillID = ?");
        ps.setString(1, name);
        ps.setInt(2, active ? 1 : 0);
        ps.setInt(3, id);
        int k = ps.executeUpdate();
        dbo.commit();
        dbo.close();
        if(k > 0)
            return true;
        return false;
        
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
    
    public static ArrayList<Skill> getLimit(int limit, boolean enable) throws Exception {
        ArrayList<Skill> arr = new ArrayList();
        Connection dbo = DatabaseUtil.getConn();
        PreparedStatement ps = dbo.prepareStatement("SELECT TOP ("+limit+") * FROM Skills WHERE enable = "+(enable ? 1 : 0));
        ResultSet rs = ps.executeQuery();
        while(rs.next()) {
            arr.add(new Skill(rs.getInt("SkillID"), rs.getString("SkillName"), rs.getInt("enable") == 1, rs.getString("image"), rs.getString("Description")));
        }
        dbo.close();
        return arr;
    }
    
    public static boolean toggle(boolean type,int id) throws Exception {
        Connection dbo = DatabaseUtil.getConn();
        PreparedStatement ps = dbo.prepareStatement("UPDATE Skills SET enable = "+(type ? 1 : 0)+" WHERE SkillID = ?");
        ps.setInt(1, id);
        int k = ps.executeUpdate();
        dbo.commit();
        if(k > 0) {
            dbo.close();
            return true;
        }
        dbo.close();
        return false;
    }
    
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
}
