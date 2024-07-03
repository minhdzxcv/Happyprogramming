/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DataConnector.DatabaseUtil;
import Service.AuthorizationService;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import model.Slot;

/**
 *
 * @author TGDD
 */
public class ScheduleDAO {
    
    public static int getPercentByRequest(int id) {
        int percent = 0;
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("SELECT Count([SlotID]) as Total, (SELECT Count([SlotID]) FROM [Slots] WHERE [SlotID] in (SELECT [SlotID] FROM [RequestSlots] WHERE [RequestID] = ?) AND [Status] = N'Done') as Done FROM [RequestSlots] WHERE [RequestID] = ?");
            ps.setInt(1, id);
            ps.setInt(2, id);
            ResultSet rs = ps.executeQuery();
            rs.next();
            percent = (int)((rs.getInt("Total") > 0 ? ( (double)rs.getInt("Done") / (double)rs.getInt("Total") ) : 0) * 100);
            dbo.close();
        } catch(Exception e) {
            e.printStackTrace();
        }
        return percent;
    }
    
    public static void updateSlot(int id, String link, float hour, Timestamp start) throws Exception {
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("UPDATE [Slots] SET [Link] = ?, [Time] = ?, [startAt] = ? WHERE [SlotID] = ?");
            ps.setString(1, link);
            ps.setFloat(2, hour);
            ps.setTimestamp(3, start);
            ps.setInt(4, id);
            ps.executeUpdate();
            dbo.commit();
        } catch(Exception e) {
            e.printStackTrace();
        }
        dbo.close();
    }
    
    public static boolean deleteSlot(int id) throws Exception {
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("SELECT * FROM [Request] WHERE [RequestID] = (SELECT [RequestID] FROM [RequestSlots] WHERE [SlotID] = ?) AND [RequestStatus] = N'Accept'");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                dbo.close();
                return false;
            } else {
                ps = dbo.prepareStatement("DELETE FROM [RequestSlots] WHERE [SlotID] = ?");
                ps.setInt(1, id);
                ps.executeUpdate();
                ps = dbo.prepareStatement("DELETE FROM [Slots] WHERE [SlotID] = ?");
                ps.setInt(1, id);
                ps.executeUpdate();
                dbo.commit();
            }
        } catch(Exception e) {
            e.printStackTrace();
        }
        dbo.close();
        return true;
    }

    public static Slot getSlotById(int id) throws Exception {
        Slot s = null;
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("SELECT [SlotID]\n"
                    + "      ,[Time]\n"
                    + "      ,[startAt]\n"
                    + "      ,[Link]\n"
                    + "      ,[ScheduleID]\n"
                    + "      ,[SkillID]\n"
                    + "      ,[MenteeID], [Status],\n"
                    + " (SELECT [fullname] FROM [User] WHERE [UserID] = (SELECT [MentorID] FROM [Schedule] WHERE [ScheduleID] = [Slots].[ScheduleID])) as Mentor, (SELECT [MentorID] FROM [Schedule] WHERE [ScheduleID] = [Slots].[ScheduleID]) as MentorID FROM [Slots] WHERE [SlotID] = ?");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if(rs.next()) {
                s = new Slot(rs.getInt("SlotID"), rs.getTimestamp("startAt"), rs.getFloat("Time"), rs.getString("Link"), rs.getString("Mentor"), rs.getInt("MentorID"));
                s.setStatus(rs.getString("Status"));
                s.setMenteeId(rs.getInt("MenteeID"));
            }
        } catch(Exception e) {
            e.printStackTrace();
        }
        dbo.close();
        return s;
    }
    
   public static int weekCount(ArrayList<Slot> array) {
        Collections.sort(array, new Comparator<Slot>() {
            @Override
            public int compare(Slot o1, Slot o2) {
                return o1.getSlotTime().before(o2.getSlotTime()) ? -1 : 1;
            }
        });
        int r = 1;
        if (array.size() > 0) {
            if(array.get(0).getSlotTime().before(new java.util.Date())) {
                int firstWeek = weekOfYear(array.get(0).getSlotTime());
                int lastWeek = weekOfYear(new java.util.Date(array.get(array.size() - 1).getSlotTime().toInstant().toEpochMilli()));
                r = lastWeek - firstWeek + 1;
            } else {
                int firstWeek = weekOfYear(new java.util.Date());
                int lastWeek = weekOfYear(new java.util.Date(array.get(array.size() - 1).getSlotTime().toInstant().toEpochMilli()));
                r = lastWeek - firstWeek + 1;
            }
        }
        return r;
    }
    public static boolean confirmSlot(int sid, int uid, String role) throws Exception {
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("SELECT Status FROM Slots WHERE SlotID = ? ");
            ps.setInt(1, sid);
            ResultSet rs = ps.executeQuery();
            rs.next();
            String status = rs.getString("Status");
            if (status.toLowerCase().contains("not confirm")) {
                if (role.equalsIgnoreCase("mentor")) {
                    ps = dbo.prepareStatement("UPDATE Slots SET Status = N'Mentor Confirm' WHERE SlotID = ? AND ScheduleID in (SELECT ScheduleID From Schedule WHERE MentorID = ?)");
                    ps.setInt(1, sid);
                    ps.setInt(2, uid);
                    ps.executeUpdate();
                } else {
                    ps = dbo.prepareStatement("UPDATE Slots SET Status = N'Mentee Confirm' WHERE SlotID = ? AND MenteeID = ?");
                    ps.setInt(1, sid);
                    ps.setInt(2, uid);
                    ps.executeUpdate();
                }
            } else {
                if (status.toLowerCase().contains("mentor confirm")) {
                    if (role.equalsIgnoreCase("mentee")) {
                        ps = dbo.prepareStatement("UPDATE Slots SET Status = N'Done' WHERE SlotID = ? AND MenteeID = ?");
                        ps.setInt(1, sid);
                        ps.setInt(2, uid);
                        ps.executeUpdate();
//                        ps = dbo.prepareStatement("SELECT Count([SlotID]) as [NotDone] FROM [Slot] WHERE [Status] != N'Done' AND [Status] != N'Reject' AND [SlotID] in (SELECT [SlotID] FROM [RequestSlot] WHERE [RequestID] = (SELECT [RequestID] FROM [RequestSlot] WHERE SlotID = ?))");
//                        ps.setInt(1, sid);
//                        ResultSet rs2 = ps.executeQuery();
//                        rs2.next();
//                        if(rs2.getInt("NotDone") == 0) {
//                            ps = dbo.prepareStatement("UPDATE [Request] SET [RequestStatus] = N'Done' WHERE [RequestID] = (SELECT [RequestID] FROM [RequestSlot] WHERE SlotID = ?)");
//                            ps.setInt(1, sid);
//                            ps.executeUpdate();
//                            ps = dbo.prepareStatement("UPDATE [User] SET [wallet] = [wallet] + (SELECT [Balance] FROM [Payment] WHERE [RequestID] = (SELECT [RequestID] FROM [RequestSlot] WHERE [SlotID] = ?) AND [Status] != N'Done') WHERE [UserID] = (SELECT [UserID] FROM [Request] WHERE [SlotID] = ?)");
//                            ps.setInt(1, sid);
//                            ps.setInt(2, sid);
//                            ps.executeUpdate();
//                            ps = dbo.prepareStatement("UPDATE [Payment] SET [Status] = N'Done' WHERE [RequestID] = (SELECT [RequestID] FROM [RequestSlot] WHERE [SlotID] = ?)");
//                            ps.setInt(1, sid);
//                            ps.executeUpdate();
//                        }
                    } else {
                        dbo.close();
                        return false;
                    }
                } else if (status.toLowerCase().contains("mentee confirm")) {
                    if (role.equalsIgnoreCase("mentor")) {
                        ps = dbo.prepareStatement("UPDATE Slots SET Status = N'Done' WHERE SlotID = ? AND ScheduleID in (SELECT ScheduleID From Schedule WHERE MentorID = ?)");
                        ps.setInt(1, sid);
                        ps.setInt(2, uid);
                        ps.executeUpdate();
                    } else {
                        dbo.close();
                        return false;
                    }
                } else {
                    dbo.close();
                    return false;
                }
            }
            dbo.commit();
        } catch (Exception e) {
            e.printStackTrace();
            dbo.close();
            return false;
        } finally {
            dbo.close();
        }
        return true;
    }

    public static int numberOfWeek(int year) {
        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.YEAR, year);
        cal.set(Calendar.MONTH, Calendar.DECEMBER);
        cal.set(Calendar.DAY_OF_MONTH, 31);

        int ordinalDay = cal.get(Calendar.DAY_OF_YEAR);
        int weekDay = cal.get(Calendar.DAY_OF_WEEK) - 1; // Sunday = 0
        int numberOfWeeks = (ordinalDay - weekDay + 10) / 7;
        return numberOfWeeks;
    }

    public static int weekOfYear(java.util.Date day) {
        Calendar c = Calendar.getInstance();
        c.setTime(day);
        return c.get(Calendar.DAY_OF_WEEK) >= 2 ? c.get(Calendar.WEEK_OF_YEAR) : c.get(Calendar.WEEK_OF_YEAR) - 1;
    }

    public static Calendar FirstDateOfWeek(int year, int weekOfYear) throws ParseException {
        SimpleDateFormat format1 = new SimpleDateFormat("dd/MM/yyyy");
        java.util.Date jan1 = format1.parse("01/01/" + year);
        Calendar c = Calendar.getInstance();
        c.setTime(jan1);
        int dayOfWeek = c.get(Calendar.DAY_OF_WEEK);
        int dayOffset = 2 - dayOfWeek;
        if (dayOffset == 1) {
            dayOffset = -6;
        }
        c.add(Calendar.DATE, dayOffset);
        c.add(Calendar.DATE, 7 * (weekOfYear - 1));
        return c;
    }

    public static ArrayList<Slot> sortByWeek(Calendar first, Calendar last, ArrayList<Slot> array) {
        ArrayList<Slot> copy = (ArrayList) array.clone();
        first.set(Calendar.HOUR_OF_DAY, 0);
        first.set(Calendar.MINUTE, 0);
        first.set(Calendar.SECOND, 0);
        last.set(Calendar.HOUR_OF_DAY, 23);
        last.set(Calendar.MINUTE, 59);
        last.set(Calendar.SECOND, 59);
        for (int i = 0; i < copy.size(); i++) {
            if (copy.get(i).getSlotTime().after(last.getTime()) || copy.get(i).getSlotTime().before(first.getTime())) {
                copy.remove(i);
                i--;
            }
        }
        Collections.sort(copy, new Comparator<Slot>() {
            @Override
            public int compare(Slot o1, Slot o2) {
                return o1.getSlotTime().before(o2.getSlotTime()) ? -1 : 1;
            }
        });
        return copy;
    }
    public static ArrayList<Slot> getFreeSlots(java.util.Date date, int uid) throws Exception {
        ArrayList<Slot> arr = new ArrayList();
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("SELECT [SlotID]\n"
                    + "      ,[Time]\n"
                    + "      ,[startAt]\n"
                    + "      ,[Link]\n"
                    + "      ,[ScheduleID]\n"
                    + "      ,[SkillID]\n"
                    + "      ,[MenteeID], [Status], (SELECT [fullname] FROM [User] WHERE [UserID] = ?) as [Mentor], (SELECT [fullname] FROM [User] WHERE [UserID] = [Slots].[MenteeID]) as [Mentee], (SELECT [SkillName] FROM [Skills] WHERE [SkillID] = [Slots].[SkillID]) as [Skill] FROM [Slots] WHERE [SkillID] IS NULL AND [startAt] > ? AND [ScheduleID] in (SELECT [ScheduleID] FROM [Schedule] WHERE [MentorID] = ?) ORDER BY [StartAt]");
            ps.setInt(1, uid);
            ps.setTimestamp(2, Timestamp.from(date.toInstant()));
            ps.setInt(3, uid);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Slot slot = new Slot(rs.getInt("SlotID"), rs.getTimestamp("startAt"), rs.getFloat("Time"), rs.getString("Link"), rs.getString("Mentor"), uid);
                slot.setSkill(rs.getString("Skill"));
                slot.setMentee(rs.getString("Mentee"));
                slot.setMenteeId(rs.getInt("MenteeID"));
                slot.setStatus(rs.getString("Status"));
                arr.add(slot);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            dbo.close();
        }
        return arr;
    }
    
    
    public static ArrayList<Integer> getSlotsIDByRequest(int rid) throws Exception {
        ArrayList<Integer> arr = new ArrayList();
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("SELECT [SlotID]\n"
                    + "      ,[Time]\n"
                    + "      ,[startAt]\n"
                    + "      ,[Link]\n"
                    + "      ,[ScheduleID]\n"
                    + "      ,[SkillID]\n"
                    + "      ,[MenteeID], [Status], (SELECT [fullname] FROM [User] WHERE [User].[UserID] = (SELECT [MentorID] FROM [Schedule] WHERE [ScheduleID] = [Slots].[ScheduleID])) as [Mentor], (SELECT [fullname] FROM [User] WHERE [UserID] = [Slots].[MenteeID]) as [Mentee], (SELECT [SkillName] FROM [Skills] WHERE [SkillID] = [Slots].[SkillID]) as [Skill], (SELECT [MentorID] FROM [Schedule] WHERE [ScheduleID] = [Slots].[ScheduleID]) as [MentorID] FROM [Slots] WHERE [SlotID] in (SELECT [SlotID] FROM [RequestSlots] WHERE [RequestID] = ?)");
            ps.setInt(1, rid);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                arr.add(rs.getInt("SlotID"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            dbo.close();
        }
        return arr;
    }

    public static ArrayList<Slot> getSlotsByRequest(int rid) throws Exception {
        ArrayList<Slot> arr = new ArrayList();
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("SELECT [SlotID]\n"
                    + "      ,[Time]\n"
                    + "      ,[startAt]\n"
                    + "      ,[Link]\n"
                    + "      ,[ScheduleID]\n"
                    + "      ,[SkillID]\n"
                    + "      ,[MenteeID], [Status], (SELECT [fullname] FROM [User] WHERE [User].[UserID] = (SELECT [MentorID] FROM [Schedule] WHERE [ScheduleID] = [Slots].[ScheduleID])) as [Mentor], (SELECT [fullname] FROM [User] WHERE [UserID] = [Slots].[MenteeID]) as [Mentee], (SELECT [SkillName] FROM [Skills] WHERE [SkillID] = [Slots].[SkillID]) as [Skill], (SELECT [MentorID] FROM [Schedule] WHERE [ScheduleID] = [Slots].[ScheduleID]) as [MentorID] FROM [Slots] WHERE [SlotID] in (SELECT [SlotID] FROM [RequestSlot] WHERE [RequestID] = ?) ORDER BY [StartAt]");
            ps.setInt(1, rid);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Slot slot = new Slot(rs.getInt("SlotID"), rs.getTimestamp("startAt"), rs.getFloat("Time"), rs.getString("Link"), rs.getString("Mentor"), rs.getInt("MentorID"));
                slot.setSkill(rs.getString("Skill"));
                slot.setMentee(rs.getString("Mentee"));
                slot.setMenteeId(rs.getInt("MenteeID"));
                slot.setStatus(rs.getString("Status"));
                arr.add(slot);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            dbo.close();
        }
        return arr;
    }
    
    public static ArrayList<Slot> getSlots(int year, int week, int uid) throws Exception {
        ArrayList<Slot> arr = new ArrayList();
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("SELECT [SlotID]\n"
                    + "      ,[Time]\n"
                    + "      ,[startAt]\n"
                    + "      ,[Link]\n"
                    + "      ,[ScheduleID]\n"
                    + "      ,[SkillID]\n"
                    + "      ,[MenteeID], [Status], (SELECT [fullname] FROM [User] WHERE [UserID] = ?) as [Mentor], (SELECT [fullname] FROM [User] WHERE [UserID] = [Slots].[MenteeID]) as [Mentee], (SELECT [SkillName] FROM [Skills] WHERE [SkillID] = [Slots].[SkillID]) as [Skill] FROM [Slots] WHERE ScheduleID = (SELECT ScheduleID FROM Schedule WHERE [Year] = ? AND [Week] = ? AND [MentorID] = ?) ORDER BY [StartAt]");
            ps.setInt(1, uid);
            ps.setInt(2, year);
            ps.setInt(3, week);
            ps.setInt(4, uid);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Slot slot = new Slot(rs.getInt("SlotID"), rs.getTimestamp("startAt"), rs.getFloat("Time"), rs.getString("Link"), rs.getString("Mentor"), uid);
                slot.setSkill(rs.getString("Skill"));
                slot.setMentee(rs.getString("Mentee"));
                slot.setMenteeId(rs.getInt("MenteeID"));
                slot.setStatus(rs.getString("Status"));
                arr.add(slot);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            dbo.close();
        }
        return arr;
    }

    public static ArrayList<Slot> menteeGetSlots(int year, int week, int uid) throws Exception {
        ArrayList<Slot> arr = new ArrayList();
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("SELECT [SlotID]\n"
                    + "      ,[Time]\n"
                    + "      ,[startAt]\n"
                    + "      ,[Link]\n"
                    + "      ,[ScheduleID]\n"
                    + "      ,[SkillID]\n"
                    + "      ,[MenteeID], [Status], (SELECT [fullname] FROM [User] WHERE [UserID] = ?) as [Mentee], (SELECT [fullname] FROM [User] WHERE [UserID] = (SELECT [MentorID] FROM [Schedule] WHERE [ScheduleID] = [Slots].[ScheduleID])) as [Mentor], (SELECT [SkillName] FROM [Skills] WHERE [SkillID] = [Slots].[SkillID]) as [Skill], (SELECT [MentorID] FROM [Schedule] WHERE [ScheduleID] = [Slots].[ScheduleID]) as [MentorID] FROM [Slots] WHERE ScheduleID in (SELECT ScheduleID FROM Schedule WHERE [Year] = ? AND [Week] = ?) AND [MenteeID] = ?");
            ps.setInt(1, uid);
            ps.setInt(2, year);
            ps.setInt(3, week);
            ps.setInt(4, uid);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Slot slot = new Slot(rs.getInt("SlotID"), rs.getTimestamp("startAt"), rs.getFloat("Time"), rs.getString("Link"), rs.getString("Mentor"), rs.getInt("MentorID"));
                slot.setSkill(rs.getString("Skill"));
                slot.setMentee(rs.getString("Mentee"));
                slot.setMenteeId(rs.getInt("MenteeID"));
                slot.setStatus(rs.getString("Status"));
                arr.add(slot);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            dbo.close();
        }
        return arr;
    }

    public static void addSlot(String link, float hour, java.util.Date start, int week, int year, int uid) throws Exception {
        Timestamp date = Timestamp.from(start.toInstant());
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("SELECT ScheduleID FROM Schedule WHERE [Year] = ? AND [Week] = ? AND [MentorID] = ?");
            ps.setInt(1, year);
            ps.setInt(2, week);
            ps.setInt(3, uid);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                ps = dbo.prepareStatement("INSERT INTO [Slots] ([Link], [Time], [startAt], [ScheduleID]) VALUES (?, ?, ?, (SELECT ScheduleID FROM Schedule WHERE [Year] = ? AND [Week] = ? AND [MentorID] = ?))");
                ps.setString(1, link);
                ps.setFloat(2, hour);
                ps.setTimestamp(3, date);
                ps.setInt(4, year);
                ps.setInt(5, week);
                ps.setInt(6, uid);
                ps.executeUpdate();
                dbo.commit();
            } else {
                ps = dbo.prepareStatement("INSERT INTO Schedule ([Year], [Week], [MentorID]) VALUES (?, ?, ?)");
                ps.setInt(1, year);
                ps.setInt(2, week);
                ps.setInt(3, uid);
                ps.executeUpdate();
                ps = dbo.prepareStatement("INSERT INTO [Slots] ([Link], [Time], [startAt], [ScheduleID]) VALUES (?, ?, ?, (SELECT ScheduleID FROM Schedule WHERE [Year] = ? AND [Week] = ? AND [MentorID] = ?))");
                ps.setString(1, link);
                ps.setFloat(2, hour);
                ps.setTimestamp(3, date);
                ps.setInt(4, year);
                ps.setInt(5, week);
                ps.setInt(6, uid);
                ps.executeUpdate();
                dbo.commit();
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            dbo.close();
        }
    }
    
       public static void main(String[] args) {
        try {
            // Define the parameters
            int year = 2024;
            int week = 2;
            int uid = 3; // Example user ID

            // Call the getSlots method
            ArrayList<Slot> slots = getSlots(year, week, uid);

            // Display the results
            for (Slot slot : slots) {
               
                System.out.println("Link: " + slot.getLink());
                System.out.println("Mentor: " + slot.getMentor());
                System.out.println("Skill: " + slot.getSkill());
                System.out.println("Mentee: " + slot.getMentee());
                System.out.println("Status: " + slot.getStatus());
                System.out.println("--------------------------------");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
