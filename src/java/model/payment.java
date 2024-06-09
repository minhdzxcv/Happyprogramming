/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Date;

/**
 *
 * @author TGDD
 */
public class payment {
    int id;
    String status;
    int price;
    int uid;
    int rid;
    Date time;
    int requestID;
    String mentee, mentor;
    boolean requestDone = false;

    public payment() {
    }

    public payment(int id, String status, int price, int uid, int rid, Date time, int requestID, String mentee, String mentor) {
        this.id = id;
        this.status = status;
        this.price = price;
        this.uid = uid;
        this.rid = rid;
        this.time = time;
        this.requestID = requestID;
        this.mentee = mentee;
        this.mentor = mentor;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getPrice() {
        return price;
    }

    public void setPrice(int price) {
        this.price = price;
    }

    public int getUid() {
        return uid;
    }

    public void setUid(int uid) {
        this.uid = uid;
    }

    public int getRid() {
        return rid;
    }

    public void setRid(int rid) {
        this.rid = rid;
    }

    public Date getTime() {
        return time;
    }

    public void setTime(Date time) {
        this.time = time;
    }

    public int getRequestID() {
        return requestID;
    }

    public void setRequestID(int requestID) {
        this.requestID = requestID;
    }

    public String getMentee() {
        return mentee;
    }

    public void setMentee(String mentee) {
        this.mentee = mentee;
    }

    public String getMentor() {
        return mentor;
    }

    public void setMentor(String mentor) {
        this.mentor = mentor;
    }

    public boolean isRequestDone() {
        return requestDone;
    }

    public void setRequestDone(boolean requestDone) {
        this.requestDone = requestDone;
    }

}