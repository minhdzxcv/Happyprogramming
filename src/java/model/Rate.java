/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.sql.Timestamp;

/**
 *
 * @author TGDD
 */
public class Rate {
    int sendID, mentorID;
    int noStar;
    String sendName, sendAvatar;
    String content;
    Timestamp rateTime;
    int requestID;

    public Rate(int sendID, int mentorID, int noStar, String sendName, String sendAvatar, String content, Timestamp rateTime, int requestID) {
        this.sendID = sendID;
        this.mentorID = mentorID;
        this.noStar = noStar;
        this.sendName = sendName;
        this.sendAvatar = sendAvatar;
        this.content = content;
        this.rateTime = rateTime;
        this.requestID = requestID;
    }

    public int getRequestID() {
        return requestID;
    }

    public void setRequestID(int requestID) {
        this.requestID = requestID;
    }

    public int getSendID() {
        return sendID;
    }

    public void setSendID(int sendID) {
        this.sendID = sendID;
    }

    public int getMentorID() {
        return mentorID;
    }

    public void setMentorID(int mentorID) {
        this.mentorID = mentorID;
    }

    public int getNoStar() {
        return noStar;
    }

    public void setNoStar(int noStar) {
        this.noStar = noStar;
    }

    public String getSendName() {
        return sendName;
    }

    public void setSendName(String sendName) {
        this.sendName = sendName;
    }

    public String getSendAvatar() {
        return sendAvatar;
    }

    public void setSendAvatar(String sendAvatar) {
        this.sendAvatar = sendAvatar;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Timestamp getRateTime() {
        return rateTime;
    }

    public void setRateTime(Timestamp rateTime) {
        this.rateTime = rateTime;
    }
}
