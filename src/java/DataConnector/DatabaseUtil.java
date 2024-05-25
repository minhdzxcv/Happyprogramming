/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DataConnector;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 *
 * @author ADMIN
 */
public class DatabaseUtil {

    static String dtbName = "SWP391";
    static String username = "sa";
    static String password = "123";

    public static Connection getConn() {
        Connection conn = null;

        try {
            if (conn == null || conn.isClosed()) {
                String connectionString = "jdbc:sqlserver://localhost;databaseName=" + dtbName + ";encrypt=true;trustServerCertificate=true";
                String driverName = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
                Class.forName(driverName);
                conn = DriverManager.getConnection(connectionString, username, password);
                conn.setAutoCommit(false);
            }
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }

        return conn;
    
    }
     public static void main(String[] args){
        try{
            new DatabaseUtil().getConn();
            System.out.println("Ket noi thanh cong");
        } catch(Exception e){
            System.out.println("Ket noi that bai"+e.getLocalizedMessage()+" "+e.getMessage());
        }
    }

}


