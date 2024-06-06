/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import DataConnector.DatabaseUtil;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.text.SimpleDateFormat;

/**
 *
 * @author ADMIN
 */
public class User {
    
   public String username, password, email, phone, address, role;
  public  String avatar, fullname;
   public Date Dob;
   public int wallet, id;
   public boolean status;
   public boolean gender;
   public boolean isValidate;
   
   
    
   public User(String username, String password, String email) {
       this.username = username;
       this.password = password;
       this.email = email;
   }

    public User(String avatar, String fullname, int id) {
        this.avatar = avatar;
        this.fullname = fullname;
        this.id = id;
    }

   

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public String getFullname() {
        return fullname;
    }

    public void setFullname(String fullname) {
        this.fullname = fullname;
    }

    public User() {
    }

    public User(String username, String password, String email, String phone, String address, String role, Date Dob, int wallet, int id, boolean status, boolean gender) {
        this.username = username;
        this.password = password;
        this.email = email;
        this.phone = phone;
        this.address = address;
        this.role = role;
        this.Dob = Dob;
        this.wallet = wallet;
        this.id = id;
        this.status = status;
        this.gender = gender;
        this.isValidate = false;
    }

    public boolean isIsValidate() {
        return isValidate;
    }

    public void setValidate(boolean isValidate) {
        this.isValidate = isValidate;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public void setRole(String role) {
        this.role = role;
    }

    public void setDob(Date Dob) {
        this.Dob = Dob;
    }

    public void setWallet(int wallet) {
        this.wallet = wallet;
    }

    public void setId(int id) {
        this.id = id;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    

    public void setGender(boolean gender) {
        this.gender = gender;
    }

    public String getUsername() {
        return username;
    }

    public String getPassword() {
        return password;
    }

    public String getEmail() {
        return email;
    }

    public String getPhone() {
        return phone;
    }

    public String getAddress() {
        return address;
    }

    public String getRole() {
        return role;
    }

    public Date getDob() {
        return Dob;
    }

    public int getWallet() {
        return wallet;
    }

    public int getId() {
        return id;
    }

    public void setIsValidate(boolean isValidate) {
        this.isValidate = isValidate;
    }
    

    

    public boolean isGender() {
        return gender;
    }
    
}
