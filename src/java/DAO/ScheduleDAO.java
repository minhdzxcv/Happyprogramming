/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import DataConnector.DatabaseUtil;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Comparator;
import model.Schedule;
import model.Slot;
import model.User;

/**
 *
 * @author TGDD
 */
public class ScheduleDAO {

    public ScheduleDAO() {
    }

    public static int getPercentByRequest(int id) {
        int percent = 0;
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("SELECT Count([SlotID]) as Total, (SELECT Count([SlotID]) FROM [Slots] WHERE [SlotID] in (SELECT [SlotID] FROM [RequestSlots] WHERE [RequestID] = ?) AND [Status] = N'Done') as Done FROM [RequestSlots] WHERE [RequestID] = ?");
            ps.setInt(1, id);
            ps.setInt(2, id);
            ResultSet rs = ps.executeQuery();
            rs.next();
            percent = (int) ((rs.getInt("Total") > 0 ? ((double) rs.getInt("Done") / (double) rs.getInt("Total")) : 0) * 100);
            dbo.close();
        } catch (Exception e) {
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
        } catch (Exception e) {
            e.printStackTrace();
        }
        dbo.close();
    }

    public static void updateSlotSchedule(int id, String link, float hour, Timestamp start, int scheduleId) throws Exception {
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("UPDATE [Slots] SET [Link] = ?, [Time] = ?, [startAt] = ?, Status='Pending' WHERE [SlotID] = ?");
            ps.setString(1, link);
            ps.setFloat(2, hour);
            ps.setTimestamp(3, start);
            ps.setInt(4, id);
            ps.executeUpdate();
            PreparedStatement ps2 = dbo.prepareStatement("UPDATE [Schedule] SET Status = N'New' WHERE [ScheduleId] = ?");
            ps2.setInt(1, scheduleId);
            ps2.executeUpdate();
            dbo.commit();
        } catch (Exception e) {
            e.printStackTrace();
        }
        dbo.close();
    }

    public boolean deleteSchedule(int scheduleID) {
        Connection dbo = DatabaseUtil.getConn();
        try {
            dbo.setAutoCommit(false);

            PreparedStatement ps = dbo.prepareStatement("DELETE FROM [RequestSlots] WHERE [SlotID] IN (SELECT [SlotID] FROM [Slots] WHERE [ScheduleID] = ?)");
            ps.setInt(1, scheduleID);
            ps.executeUpdate();

            ps = dbo.prepareStatement("DELETE FROM [Slots] WHERE [ScheduleID] = ?");
            ps.setInt(1, scheduleID);
            ps.executeUpdate();

            ps = dbo.prepareStatement("DELETE FROM [Schedule] WHERE [ScheduleID] = ?");
            ps.setInt(1, scheduleID);
            ps.executeUpdate();

            dbo.commit();
            return true;
        } catch (Exception e) {
            try {
                if (dbo != null) {
                    dbo.rollback();
                }
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
            e.printStackTrace();
            return false;
        } finally {
            try {
                if (dbo != null) {
                    dbo.close();
                }
            } catch (SQLException closeEx) {
                closeEx.printStackTrace();
            }
        }
    }

    public static boolean deleteSlot(int id) throws Exception {
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("SELECT * FROM [Request] WHERE [RequestID] = (SELECT [RequestID] FROM [RequestSlots] WHERE [SlotID] = ?) AND [RequestStatus] = N'Accept'");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
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
        } catch (Exception e) {
            e.printStackTrace();
        }
        dbo.close();
        return true;
    }

    public boolean deleteScheduleSlot(int id) {
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("SELECT * FROM [Request] WHERE [RequestID] = (SELECT [RequestID] FROM [RequestSlots] WHERE [SlotID] = ?) AND [RequestStatus] = N'Accept'");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                dbo.close();
                return false;
            } else {
                ps = dbo.prepareStatement("DELETE FROM [RequestSlots] WHERE [SlotID] = ?");
                ps.setInt(1, id);
                ps.executeUpdate();
                ps = dbo.prepareStatement("DELETE FROM [Slots] WHERE [SlotID] = ?");
                ps.setInt(1, id);
                ps = dbo.prepareStatement("DELETE FROM [Slots] WHERE [SlotID] = ?");
                ps.executeUpdate();
                dbo.commit();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return true;
    }

    public boolean deleteSlotPending(int id) {
        Connection dbo = DatabaseUtil.getConn();
        try {
            PreparedStatement ps = dbo.prepareStatement("SELECT * FROM [Request] WHERE [RequestID] = (SELECT [RequestID] FROM [RequestSlots] WHERE [SlotID] = ?) AND [RequestStatus] = N'Accept'");
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
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
        } catch (Exception e) {
            System.out.println("Delete slot: " + e);
        }
        return true;
    }

    public static Slot getSlotById(int id) {
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
            if (rs.next()) {
                s = new Slot(rs.getInt("SlotID"), rs.getTimestamp("startAt"), rs.getFloat("Time"), rs.getString("Link"), rs.getString("Mentor"), rs.getInt("MentorID"));
                s.setStatus(rs.getString("Status"));
                s.setMenteeId(rs.getInt("MenteeID"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
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
            if (array.get(0).getSlotTime().before(new java.util.Date())) {
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
            String status = rs.getString("Status").toLowerCase();
            System.out.println(status);
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
                        ps = dbo.prepareStatement("UPDATE [Request] SET [RequestStatus] = N'Done' WHERE [RequestID] = (SELECT [RequestID] FROM [RequestSlots] WHERE SlotID = ?)");
                        ps.setInt(1, sid);
                        ps.executeUpdate();
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
                        ps = dbo.prepareStatement("UPDATE [Request] SET [RequestStatus] = N'Done' WHERE [RequestID] = (SELECT [RequestID] FROM [RequestSlots] WHERE SlotID = ?)");
                        ps.setInt(1, sid);
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
            PreparedStatement ps = dbo.prepareStatement("SELECT \n"
                    + "    [SlotID],\n"
                    + "    [Time],\n"
                    + "    [startAt],\n"
                    + "    [Link],\n"
                    + "    [ScheduleID],\n"
                    + "    [SkillID],\n"
                    + "    [MenteeID], \n"
                    + "    [Status], \n"
                    + "    (SELECT [fullname] FROM [User] WHERE [UserID] = ?) as [Mentor], \n"
                    + "    (SELECT [fullname] FROM [User] WHERE [UserID] = [Slots].[MenteeID]) as [Mentee], \n"
                    + "    (SELECT [SkillName] FROM [Skills] WHERE [SkillID] = [Slots].[SkillID]) as [Skill] \n"
                    + "FROM \n"
                    + "    [Slots] \n"
                    + "WHERE \n"
                    + "    [SkillID] IS NULL \n"
                    + "    AND [startAt] > ? \n"
                    + "    AND [ScheduleID] IN (SELECT [ScheduleID] FROM [Schedule] WHERE [MentorID] = ?) \n"
                    + "    AND [Status] = 'Not Confirm'  \n"
                    + "ORDER BY \n"
                    + "    [startAt];");
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
                    + "      ,[MenteeID], [Status], (SELECT [fullname] FROM [User] WHERE [User].[UserID] = (SELECT [MentorID] FROM [Schedule] WHERE [ScheduleID] = [Slots].[ScheduleID])) as [Mentor], (SELECT [fullname] FROM [User] WHERE [UserID] = [Slots].[MenteeID]) as [Mentee], (SELECT [SkillName] FROM [Skills] WHERE [SkillID] = [Slots].[SkillID]) as [Skill], (SELECT [MentorID] FROM [Schedule] WHERE [ScheduleID] = [Slots].[ScheduleID]) as [MentorID] FROM [Slots] WHERE [SlotID] in (SELECT [SlotID] FROM [RequestSlots] WHERE [RequestID] = ?) ORDER BY [StartAt]");
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
                ps = dbo.prepareStatement("INSERT INTO [Slots] ([Link], [Time], [startAt], [ScheduleID] , [Status]) VALUES (?, ?, ?, (SELECT ScheduleID FROM Schedule WHERE [Year] = ? AND [Week] = ? AND [MentorID] = ?) , N'Pending')");
                ps.setString(1, link);
                ps.setFloat(2, hour);
                ps.setTimestamp(3, date);
                ps.setInt(4, year);
                ps.setInt(5, week);
                ps.setInt(6, uid);
                ps.executeUpdate();
                dbo.commit();
            } else {
                ps = dbo.prepareStatement("INSERT INTO Schedule ([Year], [Week], [MentorID] , [Status]) VALUES (?, ?, ? , N'New')");
                ps.setInt(1, year);
                ps.setInt(2, week);
                ps.setInt(3, uid);
                ps.executeUpdate();
                ps = dbo.prepareStatement("INSERT INTO [Slots] ([Link], [Time], [startAt], [ScheduleID] , [Status]) VALUES (?, ?, ?, (SELECT ScheduleID FROM Schedule WHERE [Year] = ? AND [Week] = ? AND [MentorID] = ? AND [Status] = N'New'), N'Pending')");
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

//    public static void confirmSchedule(int id) throws Exception {
//        Connection dbo = DatabaseUtil.getConn();
//        PreparedStatement ps = dbo.prepareStatement("UPDATE slots\n"
//                + "SET Status = 'Not Confirm'\n"
//                + "FROM slots a\n"
//                + "INNER JOIN schedule s ON a.ScheduleID = s.ScheduleID\n"
//                + "WHERE s.MentorID = ?");
//        ps.setInt(1, id);
//        ps.setInt(2, id);
//        ps.executeUpdate();
//        ps = dbo.prepareStatement("UPDATE [Slots] SET [Status] = N'Not Confirm' WHERE [SlotID] = ?");
//        ps.setInt(1, id);
//        ps.executeUpdate();
//        dbo.commit();
//        dbo.close();
//    }
    public static void rejectSchedule(int id, String rejectReason) {
        Connection dbo = null;
        PreparedStatement psSlotsUpdate = null;
        PreparedStatement psScheduleDelete = null;

        try {
            dbo = DatabaseUtil.getConn();
            dbo.setAutoCommit(false); // Start transaction

            // Step 1: Update status to 'Reject' in Slots table
            psSlotsUpdate = dbo.prepareStatement("UPDATE SLOTS\n"
                    + "SET [status] = N'Reject'\n"
                    + "WHERE ScheduleID IN (SELECT ScheduleID FROM Schedule WHERE MentorID = ? and Status = 'Pending')");
            psSlotsUpdate.setInt(1, id);
            psSlotsUpdate.executeUpdate();

            psScheduleDelete = dbo.prepareStatement("Update Schedule set [status] = 'Reject', rejectReason=? where MentorID = ? and Status = 'Pending'");
            psScheduleDelete.setString(1, rejectReason);
            psScheduleDelete.setInt(2, id);

            psScheduleDelete.executeUpdate();

            // Commit the transaction
            dbo.commit();
        } catch (SQLException e) {
            // Rollback in case of any SQL exception
            try {
                if (dbo != null) {
                    dbo.rollback();
                }
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
            e.printStackTrace();
        } finally {
            // Close resources in finally block to ensure they are always closed
            try {
                if (psSlotsUpdate != null) {
                    psSlotsUpdate.close();
                }
                if (psScheduleDelete != null) {
                    psScheduleDelete.close();
                }
                if (dbo != null) {
                    dbo.close();
                }
            } catch (SQLException closeEx) {
                closeEx.printStackTrace();
            }
        }
    }

    public static void confirmSchedule(int id) {
        Connection dbo = null;
        PreparedStatement psSchedule = null;
        PreparedStatement psSlots = null;

        try {
            dbo = DatabaseUtil.getConn();

            // Step 1: Update Schedule table
            psSchedule = dbo.prepareStatement("UPDATE S\n"
                    + "SET S.[status] = N'Active'\n"
                    + "FROM [Schedule] S\n"
                    + "JOIN [slots] sl ON S.[ScheduleID] = sl.[ScheduleID]\n"
                    + "WHERE S.[MentorID] = ? and S.Status = 'Pending' and sl.Status = 'Pending';");
            psSchedule.setInt(1, id);
            psSchedule.executeUpdate();

            // Step 2: Update Slots table
            psSlots = dbo.prepareStatement("UPDATE S\n"
                    + "SET S.[status] = N'Not Confirm'\n"
                    + "FROM [SLOTS] S\n"
                    + "JOIN [Schedule] sl ON S.[ScheduleID] = sl.[ScheduleID]\n"
                    + "WHERE sl.[MentorID] = ? and s.Status = 'Pending' and sl.Status = 'Active'");
            psSlots.setInt(1, id);
            psSlots.executeUpdate();

            // Commit the transaction
            dbo.commit();
        } catch (Exception e) {
            // Rollback in case of any exception
            try {
                if (dbo != null) {
                    dbo.rollback();
                }
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
            e.printStackTrace();
        } finally {
            // Close resources in finally block to ensure they are always closed
            try {
                if (psSchedule != null) {
                    psSchedule.close();
                }
                if (psSlots != null) {
                    psSlots.close();
                }
                if (dbo != null) {
                    dbo.close();
                }
            } catch (SQLException closeEx) {
                closeEx.printStackTrace();
            }
        }
    }

    public static void SendToAdminSchedule(int id) {
        Connection dbo = null;
        PreparedStatement psSchedule = null;
        PreparedStatement psSlots = null;

        try {
            dbo = DatabaseUtil.getConn();
            psSchedule = dbo.prepareStatement("UPDATE S\n"
                    + "SET S.[status] = N'Pending'\n"
                    + "FROM [Schedule] S\n"
                    + "JOIN [slots] sl ON S.[ScheduleID] = sl.[ScheduleID]\n"
                    + "WHERE S.[ScheduleID] = ?;");
            psSchedule.setInt(1, id);
            psSchedule.executeUpdate();
            psSlots = dbo.prepareStatement("UPDATE S\n"
                    + "SET S.[status] = N'Pending'\n"
                    + "FROM [SLOTS] S\n"
                    + "JOIN [Schedule] sl ON S.[ScheduleID] = sl.[ScheduleID]\n"
                    + "WHERE sl.[ScheduleID] = ?;");
            psSlots.setInt(1, id);
            psSlots.executeUpdate();
            dbo.commit();
        } catch (Exception e) {
            // Rollback in case of any exception
            try {
                if (dbo != null) {
                    dbo.rollback();
                }
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
            e.printStackTrace();
        } finally {
            // Close resources in finally block to ensure they are always closed
            try {
                if (psSchedule != null) {
                    psSchedule.close();
                }
                if (psSlots != null) {
                    psSlots.close();
                }
                if (dbo != null) {
                    dbo.close();
                }
            } catch (SQLException closeEx) {
                closeEx.printStackTrace();
            }
        }
    }

    public void sendSlotToAdmin(int id) {
        Connection dbo = null;
        PreparedStatement psSchedule = null;
        PreparedStatement psSlots = null;

        try {
            dbo = DatabaseUtil.getConn();
            psSlots = dbo.prepareStatement("UPDATE Slots\n"
                    + "SET [status] = N'Pending'\n"
                    + "WHERE [SlotID] = ?;");
            psSlots.setInt(1, id);
            psSlots.executeUpdate();
            dbo.commit();
        } catch (Exception e) {
            try {
                if (dbo != null) {
                    dbo.rollback();
                }
            } catch (SQLException rollbackEx) {
                rollbackEx.printStackTrace();
            }
            e.printStackTrace();
        } finally {
            try {
                if (psSchedule != null) {
                    psSchedule.close();
                }
                if (psSlots != null) {
                    psSlots.close();
                }
                if (dbo != null) {
                    dbo.close();
                }
            } catch (SQLException closeEx) {
                closeEx.printStackTrace();
            }
        }
    }

    public static ArrayList<Schedule> getAllSchedulesWithPendingSlots() throws SQLException {
        ArrayList<Schedule> schedules = new ArrayList<>();
        Connection dbo = DatabaseUtil.getConn();
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            String query = "SELECT DISTINCT sch.ScheduleID, sch.MentorID, sch.Year, sch.Week, sch.Status "
                    + "FROM SCHEDULE sch "
                    + "JOIN SLOTS s ON sch.ScheduleId = s.ScheduleId "
                    + "WHERE s.Status = 'Pending';";
            ps = dbo.prepareStatement(query);
            rs = ps.executeQuery();

            while (rs.next()) {
                int scheduleID = rs.getInt("ScheduleID");
                int mentorID = rs.getInt("MentorID");
                int year = rs.getInt("Year");
                int week = rs.getInt("Week");
                String status = rs.getString("Status");
                Schedule schedule = new Schedule(scheduleID, mentorID, year, week, status);
                schedules.add(schedule);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (dbo != null) {
                try {
                    dbo.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        return schedules;
    }

    public Schedule getScheduleById(int mentorID) {
        ArrayList<Schedule> schedules = new ArrayList<>();
        Connection dbo = DatabaseUtil.getConn();
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            String query = "SELECT top 1 * "
                    + "FROM SCHEDULE sch "
                    + "WHERE sch.MentorID = ?";
            ps = dbo.prepareStatement(query);
            ps.setInt(1, mentorID);
            rs = ps.executeQuery();
            if (rs.next()) {
                int scheduleID = rs.getInt("ScheduleID");
                int year = rs.getInt("Year");
                int week = rs.getInt("Week");
                String status = rs.getString("Status");
                String rejectReason = rs.getString("rejectReason");
                Schedule schedule = new Schedule(scheduleID, mentorID, year, week, status);
                schedule.setRejectReason(rejectReason);
                return schedule;
            }
        } catch (SQLException e) {
            System.out.println("Get schedule by id: " + e);
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (dbo != null) {
                try {
                    dbo.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        return null;
    }

    public ArrayList<Schedule> getAllSchedulesWithNewSlots(int mentorId) throws SQLException {
        ArrayList<Schedule> schedules = new ArrayList<>();
        Connection dbo = DatabaseUtil.getConn();
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            String query = "SELECT DISTINCT sch.rejectReason, sch.ScheduleID, sch.MentorID, sch.Year, sch.Week, sch.Status "
                    + "FROM SCHEDULE sch "
                    + "JOIN SLOTS s ON sch.ScheduleId = s.ScheduleId "
                    + "WHERE (sch.Status = 'New' or sch.Status = 'Pending' Or sch.Status = 'Reject') and sch.MentorID = ?;";
            ps = dbo.prepareStatement(query);
            ps.setInt(1, mentorId);
            rs = ps.executeQuery();

            while (rs.next()) {
                int scheduleID = rs.getInt("ScheduleID");
                int mentorID = rs.getInt("MentorID");
                int year = rs.getInt("Year");
                int week = rs.getInt("Week");
                String status = rs.getString("Status");
                String rejectReason = rs.getString("rejectReason");
                Schedule schedule = new Schedule(scheduleID, mentorID, year, week, status);
                schedule.setRejectReason(rejectReason);
                schedules.add(schedule);
            }
        } catch (SQLException e) {
            e.printStackTrace();
            throw e;
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (dbo != null) {
                try {
                    dbo.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        return schedules;
    }

    public static ArrayList<User> getAllUserWithPendingSlots() throws SQLException {
        ArrayList<User> mentors = new ArrayList<>();
        Connection dbo = DatabaseUtil.getConn();
        PreparedStatement ps = null;
        ResultSet resultSet = null;
        try {
            String query = "SELECT DISTINCT sch.MentorID, u.*"
                    + "FROM SCHEDULE sch "
                    + "JOIN SLOTS s ON sch.ScheduleId = s.ScheduleId "
                    + "join [User] as U on U.UserID = sch.MentorID ";
            ps = dbo.prepareStatement(query);
            resultSet = ps.executeQuery();

            while (resultSet.next()) {
                User user = new User();
                user.id = resultSet.getInt("UserID");
                user.username = resultSet.getString("username");
                user.password = resultSet.getString("password");
                user.email = resultSet.getString("email");
                user.phone = resultSet.getString("phoneNumber");
                user.address = resultSet.getString("address");
                user.role = resultSet.getString("roleID");
                user.avatar = resultSet.getString("Avatar");
                user.fullname = resultSet.getString("fullname");
                user.Dob = resultSet.getDate("dob");
                user.wallet = resultSet.getInt("wallet");
                user.status = resultSet.getBoolean("status");
                user.gender = resultSet.getBoolean("gender");
                user.isValidate = resultSet.getBoolean("isValidate");
                mentors.add(user);
            }
        } catch (SQLException e) {
            System.out.println("Get by mentor: " + e);
        }
        return mentors;
    }

    public static ArrayList<Slot> getSlotsForScheduleById(int scheduleId) {
        ArrayList<Slot> slots = new ArrayList<>();
        Connection dbo = DatabaseUtil.getConn();
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            String query = "SELECT s.slotID, s.ScheduleID, s.Time, s.startAt, s.Link, s.Status, SC.* "
                    + "FROM SLOTS s "
                    + "join Schedule as SC on Sc.ScheduleID = S.ScheduleID "
                    + "join Mentor as M on M.UserID = Sc.MentorID "
                    + "WHERE SC.ScheduleID = ?";

            ps = dbo.prepareStatement(query);
            ps.setInt(1, scheduleId);
            rs = ps.executeQuery();

            while (rs.next()) {
                int schedID = rs.getInt("ScheduleID");
                int slotId = rs.getInt("slotID");
                float time = rs.getFloat("Time");
                Timestamp startAt = rs.getTimestamp("startAt");
                String link = rs.getString("Link");
                String status = rs.getString("Status");
                String fullName = "";
                Slot slot = new Slot(schedID, startAt, time, link, fullName, status);
                slot.setId(slotId);
                slots.add(slot);
            }
        } catch (SQLException e) {
            System.out.println("Get by schedule: " + e);
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (dbo != null) {
                try {
                    dbo.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        return slots;
    }

    public static ArrayList<Slot> getSlotsForSchedule(int mentorId) {
        ArrayList<Slot> slots = new ArrayList<>();
        Connection dbo = DatabaseUtil.getConn();
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            String query = "SELECT S.slotID, s.ScheduleID, s.Time, s.startAt, s.Link, s.Status, SC.* "
                    + "FROM SLOTS s "
                    + "join Schedule as SC on Sc.ScheduleID = S.ScheduleID "
                    + "join Mentor as M on M.UserID = Sc.MentorID "
                    + "WHERE SC.MentorID = ? AND (SC.status = 'Pending' and s.status = 'Pending')";

            ps = dbo.prepareStatement(query);
            ps.setInt(1, mentorId);
            rs = ps.executeQuery();

            while (rs.next()) {
                int schedID = rs.getInt("ScheduleID");
                float time = rs.getFloat("Time");
                Timestamp startAt = rs.getTimestamp("startAt");
                String link = rs.getString("Link");
                String status = rs.getString("Status");
                int slotId = rs.getInt("slotID");
                String fullName = "";

                Slot slot = new Slot(schedID, startAt, time, link, fullName, status);
                slot.setId(slotId);
                slots.add(slot);
            }
        } catch (SQLException e) {
            System.out.println("Get by schedule: " + e);
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (dbo != null) {
                try {
                    dbo.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        return slots;
    }
    
    public ArrayList<Slot> getSlotsForCheck(int mentorId) {
        ArrayList<Slot> slots = new ArrayList<>();
        Connection dbo = DatabaseUtil.getConn();
        PreparedStatement ps = null;
        ResultSet rs = null;
        try {
            String query = "SELECT S.slotID, s.ScheduleID, s.Time, s.startAt, s.Link, s.Status, SC.* "
                    + "FROM SLOTS s "
                    + "join Schedule as SC on Sc.ScheduleID = S.ScheduleID "
                    + "join Mentor as M on M.UserID = Sc.MentorID "
                    + "WHERE SC.MentorID = ? AND (SC.status = 'Pending' and s.status = 'Pending')";

            ps = dbo.prepareStatement(query);
            ps.setInt(1, mentorId);
            rs = ps.executeQuery();

            while (rs.next()) {
                int schedID = rs.getInt("ScheduleID");
                float time = rs.getFloat("Time");
                Timestamp startAt = rs.getTimestamp("startAt");
                String link = rs.getString("Link");
                String status = rs.getString("Status");
                int slotId = rs.getInt("slotID");
                String fullName = "";

                Slot slot = new Slot(schedID, startAt, time, link, fullName, status);
                slot.setId(slotId);
                slots.add(slot);
            }
        } catch (SQLException e) {
            System.out.println("Get by schedule: " + e);
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (ps != null) {
                try {
                    ps.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
            if (dbo != null) {
                try {
                    dbo.close();
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        }
        return slots;
    }

    public static void main(String[] args) {
        int mentorId = 5; // Replace with a valid mentor ID from your database

        try {
            // Call rejectSchedule method
//            rejectSchedule(mentorId);

            // If no exceptions were thrown, print success message
            System.out.println("Schedule rejection process completed successfully.");
        } catch (Exception e) {
            // Handle any exceptions thrown during the rejection process
            System.err.println("Error rejecting schedule:");
            e.printStackTrace();
        }
    }

}
