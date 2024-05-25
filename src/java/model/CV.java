/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package model;

import java.text.DecimalFormat;
import java.util.ArrayList;

/**
 *
 * @author TGDD
 */
public class CV {
    int id;
    String ProfessionIntro;
    String Description;
    int Moneyofslot;
    ArrayList<Skill> skills = new ArrayList();

    public CV(int id, String ProfessionIntro, String Description, int Moneyofslot) {
        this.id = id;
        this.ProfessionIntro = ProfessionIntro;
        this.Description = Description;
        this.Moneyofslot = Moneyofslot;
    }

    public CV(int id, String ProfessionIntro, String Description) {
        this.id = id;
        this.ProfessionIntro = ProfessionIntro;
        this.Description = Description;
    }
    
    

    
    
    public String MoneyFormat() {
        DecimalFormat decimalFormat = new DecimalFormat("#,##0");
        return decimalFormat.format(Moneyofslot);
    }

    public int getMoneyofslot() {
        return Moneyofslot;
    }

    public void setMoneyofslot(int Moneyofslot) {
        this.Moneyofslot = Moneyofslot;
    }

    

    public ArrayList<Skill> getSkills() {
        return skills;
    }
    
    public String getSkillString() {
        String ret = "";
        for (int i = 0; i < skills.size(); i++) {
            ret += skills.get(i).getName();
            if(i != skills.size() - 1) {
                ret += ", ";
            }
        }
        return ret;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getProfessionIntro() {
        return ProfessionIntro;
    }

    public void setProfessionIntro(String ProfessionIntro) {
        this.ProfessionIntro = ProfessionIntro;
    }

    public String getDescription() {
        return Description;
    }

    public void setDescription(String Description) {
        this.Description = Description;
    }

    
}
