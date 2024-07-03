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
public class FollowRequest {
    int id;
    String title, content, status;
    int SendID, MentorID;
    String Send, Mentor;
    Timestamp deadline, createAt;

    public FollowRequest(int id, String title, String content, int SendID, int MentorID, String Send, String Mentor, Timestamp deadline, Timestamp createAt, String status) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.SendID = SendID;
        this.MentorID = MentorID;
        this.Send = Send;
        this.Mentor = Mentor;
        this.deadline = deadline;
        this.createAt = createAt;
        this.status = status;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getSendID() {
        return SendID;
    }

    public void setSendID(int SendID) {
        this.SendID = SendID;
    }

    public int getMentorID() {
        return MentorID;
    }

    public void setMentorID(int MentorID) {
        this.MentorID = MentorID;
    }

    public String getSend() {
        return Send;
    }

    public void setSend(String Send) {
        this.Send = Send;
    }

    public String getMentor() {
        return Mentor;
    }

    public void setMentor(String Mentor) {
        this.Mentor = Mentor;
    }

    public Timestamp getDeadline() {
        return deadline;
    }

    public void setDeadline(Timestamp deadline) {
        this.deadline = deadline;
    }

    public Timestamp getCreateAt() {
        return createAt;
    }

    public void setCreateAt(Timestamp createAt) {
        this.createAt = createAt;
    }

    @Override
    public String toString() {
        return "FollowRequest{" + "id=" + id + ", title=" + title + ", content=" + content + ", status=" + status + ", SendID=" + SendID + ", MentorID=" + MentorID + ", Send=" + Send + ", Mentor=" + Mentor + ", deadline=" + deadline + ", createAt=" + createAt + '}';
    }
    
    
    
    
}
