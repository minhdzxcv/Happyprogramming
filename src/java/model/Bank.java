/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

/**
 *
 * @author TGDD
 */
public class Bank {
    int id;
    String UserBank, NoBank, TypeBank;

    public Bank() {
    }

    public Bank(int id, String UserBank, String NoBank, String TypeBank) {
        this.id = id;
        this.UserBank = UserBank;
        this.NoBank = NoBank;
        this.TypeBank = TypeBank;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUserBank() {
        return UserBank;
    }

    public void setUserBank(String UserBank) {
        this.UserBank = UserBank;
    }

    public String getNoBank() {
        return NoBank;
    }

    public void setNoBank(String NoBank) {
        this.NoBank = NoBank;
    }

    public String getTypeBank() {
        return TypeBank;
    }

    public void setTypeBank(String TypeBank) {
        this.TypeBank = TypeBank;
    }

}