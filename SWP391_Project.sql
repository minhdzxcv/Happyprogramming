CREATE DATABASE [SWP391_Project]
GO
USE [SWP391_Project]
GO
/****** Object:  Table [dbo].[AuthorizeMap]    Script Date: 6/27/2024 1:03:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AuthorizeMap](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[path] [nvarchar](255) NOT NULL,
	[user] [nvarchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Bank]    Script Date: 6/27/2024 1:03:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Bank](
	[UserID] [int] NULL,
	[UserBank] [nvarchar](255) NULL,
	[TypeBank] [nvarchar](100) NULL,
	[NoBank] [nvarchar](100) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Conversation]    Script Date: 6/27/2024 1:03:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Conversation](
	[ConversationID] [int] IDENTITY(1,1) NOT NULL,
	[MentorID] [int] NULL,
	[MenteeID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ConversationID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[CV]    Script Date: 6/27/2024 1:03:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[CV](
	[CvID] [int] IDENTITY(1,1) NOT NULL,
	[ProfessionIntro] [nvarchar](255) NULL,
	[Description] [nvarchar](255) NULL,
	[MoneyOfSlot] [int] NOT NULL,
	[rejectReason] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[CvID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Follow]    Script Date: 6/27/2024 1:03:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Follow](
	[FollowID] [int] IDENTITY(1,1) NOT NULL,
	[MentorID] [int] NULL,
	[MenteeID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[FollowID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[FollowRequest]    Script Date: 6/27/2024 1:03:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FollowRequest](
	[RequestID] [int] IDENTITY(1,1) NOT NULL,
	[RequestTime] [date] NULL,
	[DeadLineTime] [date] NULL,
	[Subject] [nvarchar](255) NULL,
	[Content] [nvarchar](255) NULL,
	[Status] [nvarchar](20) NULL,
	[MentorID] [int] NULL,
	[SendID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[RequestID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Mentee]    Script Date: 6/27/2024 1:03:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Mentee](
	[UserID] [int] NULL,
	[status] [nvarchar](10) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Mentor]    Script Date: 6/27/2024 1:03:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Mentor](
	[UserID] [int] NULL,
	[Description] [nvarchar](255) NULL,
	[CvID] [int] NULL,
	[Achivement] [nvarchar](255) NULL,
	[status] [nvarchar](10) NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[MentorOfSkills]    Script Date: 6/27/2024 1:03:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[MentorOfSkills](
	[SkillID] [int] NULL,
	[MentorID] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Message]    Script Date: 6/27/2024 1:03:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Message](
	[MessageID] [int] IDENTITY(1,1) NOT NULL,
	[ConversationID] [int] NULL,
	[sendID] [int] NULL,
	[sentAt] [datetime] NULL,
	[Content] [ntext] NULL,
PRIMARY KEY CLUSTERED 
(
	[MessageID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Payment]    Script Date: 6/27/2024 1:03:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Payment](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Status] [nvarchar](255) NULL,
	[price] [int] NULL,
	[UserID] [int] NULL,
	[ReceiverID] [int] NULL,
	[Time] [datetime] NULL,
	[RequestID] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Rating]    Script Date: 6/27/2024 1:03:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Rating](
	[MentorID] [int] NULL,
	[MenteeID] [int] NULL,
	[Star] [int] NULL,
	[Comment] [ntext] NULL,
	[Time] [datetime] NOT NULL,
	[RequestID] [int] NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RejectRequest]    Script Date: 6/27/2024 1:03:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RejectRequest](
	[RequestID] [int] NULL,
	[Reason] [nvarchar](255) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Report]    Script Date: 6/27/2024 1:03:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Report](
	[ReportContent] [text] NULL,
	[reportTime] [datetime] NULL,
	[UserID] [int] NULL,
	[Status] [nchar](10) NULL,
	[ReportID] [int] IDENTITY(1,1) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ReportID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Request]    Script Date: 6/27/2024 1:03:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Request](
	[RequestID] [int] IDENTITY(1,1) NOT NULL,
	[SendID] [int] NULL,
	[UserID] [int] NULL,
	[RequestReason] [nvarchar](255) NULL,
	[RequestStatus] [nvarchar](255) NULL,
	[RequestTime] [datetime] NOT NULL,
	[DeadlineTime] [datetime] NOT NULL,
	[RequestSubject] [nvarchar](255) NULL,
	[SkillID] [int] NULL,
	[rejectReason] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[RequestID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RequestSlots]    Script Date: 6/27/2024 1:03:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RequestSlots](
	[RequestID] [int] NULL,
	[SlotID] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RequestStatus]    Script Date: 6/27/2024 1:03:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RequestStatus](
	[id] [int] IDENTITY(1,1) NOT NULL,
	[status] [nvarchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 6/27/2024 1:03:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[roleID] [int] IDENTITY(1,1) NOT NULL,
	[roleName] [nvarchar](255) NULL,
PRIMARY KEY CLUSTERED 
(
	[roleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Schedule]    Script Date: 6/27/2024 1:03:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Schedule](
	[MentorID] [int] NULL,
	[Year] [int] NULL,
	[Week] [int] NULL,
	[Status] [nvarchar](255) NULL,
	[ScheduleID] [int] IDENTITY(1,1) NOT NULL,
	[rejectReason] [nvarchar](max) NULL,
 CONSTRAINT [PK__Schedule__9C8A5B69F7CD8C26] PRIMARY KEY CLUSTERED 
(
	[ScheduleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Skills]    Script Date: 6/27/2024 1:03:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Skills](
	[SkillID] [int] IDENTITY(1,1) NOT NULL,
	[SkillName] [nvarchar](255) NULL,
	[enable] [bit] NOT NULL,
	[Description] [ntext] NULL,
	[image] [nvarchar](max) NULL,
PRIMARY KEY CLUSTERED 
(
	[SkillID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Slots]    Script Date: 6/27/2024 1:03:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Slots](
	[SlotID] [int] IDENTITY(1,1) NOT NULL,
	[Time] [float] NULL,
	[startAt] [datetime] NULL,
	[Link] [nvarchar](max) NULL,
	[ScheduleID] [int] NULL,
	[SkillID] [int] NULL,
	[MenteeID] [int] NULL,
	[Status] [nchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SlotID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Transaction]    Script Date: 6/27/2024 1:03:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transaction](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[UserID] [int] NULL,
	[price] [int] NULL,
	[Type] [nvarchar](1) NULL,
	[Content] [nvarchar](255) NULL,
	[Time] [date] NULL,
	[Status] [nvarchar](20) NULL,
	[Code] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 6/27/2024 1:03:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[UserID] [int] IDENTITY(1,1) NOT NULL,
	[username] [varchar](255) NULL,
	[password] [varchar](255) NULL,
	[fullname] [nvarchar](255) NULL,
	[gender] [bit] NULL,
	[dob] [date] NULL,
	[email] [varchar](255) NULL,
	[phoneNumber] [varchar](10) NULL,
	[Avatar] [nvarchar](255) NULL,
	[address] [nvarchar](255) NULL,
	[roleID] [int] NULL,
	[isValidate] [bit] NULL,
	[wallet] [int] NULL,
	[status] [bit] NULL,
PRIMARY KEY CLUSTERED 
(
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[AuthorizeMap] ON 

INSERT [dbo].[AuthorizeMap] ([id], [path], [user]) VALUES (1, N'/admin/authorization', N'admin')
INSERT [dbo].[AuthorizeMap] ([id], [path], [user]) VALUES (2, N'/admin/request', N'admin, manager')
INSERT [dbo].[AuthorizeMap] ([id], [path], [user]) VALUES (3, N'/admin/skill', N'admin')
INSERT [dbo].[AuthorizeMap] ([id], [path], [user]) VALUES (4, N'/admin/mentor', N'admin')
INSERT [dbo].[AuthorizeMap] ([id], [path], [user]) VALUES (5, N'/profile', N'all user')
INSERT [dbo].[AuthorizeMap] ([id], [path], [user]) VALUES (6, N'/forgot', N'guest')
INSERT [dbo].[AuthorizeMap] ([id], [path], [user]) VALUES (7, N'/home', N'guest')
INSERT [dbo].[AuthorizeMap] ([id], [path], [user]) VALUES (8, N'/signin', N'guest')
INSERT [dbo].[AuthorizeMap] ([id], [path], [user]) VALUES (9, N'/logout', N'guest')
INSERT [dbo].[AuthorizeMap] ([id], [path], [user]) VALUES (10, N'/signup', N'guest')
INSERT [dbo].[AuthorizeMap] ([id], [path], [user]) VALUES (11, N'/profile', N'all user')
INSERT [dbo].[AuthorizeMap] ([id], [path], [user]) VALUES (12, N'/setting', N'all user')
INSERT [dbo].[AuthorizeMap] ([id], [path], [user]) VALUES (13, N'/request', N'mentee, mentor')
INSERT [dbo].[AuthorizeMap] ([id], [path], [user]) VALUES (14, N'/cv', N'mentor')
INSERT [dbo].[AuthorizeMap] ([id], [path], [user]) VALUES (15, N'/follow', N'mentor')
INSERT [dbo].[AuthorizeMap] ([id], [path], [user]) VALUES (16, N'/schedule', N'mentor, mentee')
INSERT [dbo].[AuthorizeMap] ([id], [path], [user]) VALUES (17, N'/admin/mentee', N'manager')
INSERT [dbo].[AuthorizeMap] ([id], [path], [user]) VALUES (18, N'/statistics', N'mentee, mentor')
INSERT [dbo].[AuthorizeMap] ([id], [path], [user]) VALUES (19, N'/admin/report', N'manager')
INSERT [dbo].[AuthorizeMap] ([id], [path], [user]) VALUES (20, N'/bank', N'mentor, mentee')
INSERT [dbo].[AuthorizeMap] ([id], [path], [user]) VALUES (21, N'/wallet', N'mentor, mentee')
INSERT [dbo].[AuthorizeMap] ([id], [path], [user]) VALUES (22, N'/admin/cv', N'manager')
INSERT [dbo].[AuthorizeMap] ([id], [path], [user]) VALUES (23, N'/transaction', N'mentor, mentee')
INSERT [dbo].[AuthorizeMap] ([id], [path], [user]) VALUES (24, N'/admin/transaction', N'manager')
INSERT [dbo].[AuthorizeMap] ([id], [path], [user]) VALUES (25, N'/admin/withdraw', N'manager')
INSERT [dbo].[AuthorizeMap] ([id], [path], [user]) VALUES (26, N'/chat', N'all user')
SET IDENTITY_INSERT [dbo].[AuthorizeMap] OFF
GO
INSERT [dbo].[Bank] ([UserID], [UserBank], [TypeBank], [NoBank]) VALUES (3, N'Nguyen Van Huy', N'Vietcombank', N'0987579738')
INSERT [dbo].[Bank] ([UserID], [UserBank], [TypeBank], [NoBank]) VALUES (4, N'Doan Nhat Minh', N'Vietinbank', N'0928839183')
GO
SET IDENTITY_INSERT [dbo].[Conversation] ON 

INSERT [dbo].[Conversation] ([ConversationID], [MentorID], [MenteeID]) VALUES (1, 4, 9)
SET IDENTITY_INSERT [dbo].[Conversation] OFF
GO
SET IDENTITY_INSERT [dbo].[CV] ON 

INSERT [dbo].[CV] ([CvID], [ProfessionIntro], [Description], [MoneyOfSlot], [rejectReason]) VALUES (1, N'Có kinh nghiệm 5 năm trong việc dạy học tại trường đại học FPT.', N'Vui vẻ nhiệt tình giải đáp mọi câu hỏi của bạn.', 500001, N'Tuyệt')
INSERT [dbo].[CV] ([CvID], [ProfessionIntro], [Description], [MoneyOfSlot], [rejectReason]) VALUES (2, N'Tôi là một Mentor và chuyên gia trong lĩnh vực ngôn ngữ lập trình, với sự chú tâm đặc biệt đến việc phát triển kỹ năng và hiểu biết của học viên.', N'Hỗ trợ cá nhân cho học viên với nhiều cấp độ kỹ năng, từ người mới học đến những người muốn nâng cao.', 50000, NULL)
INSERT [dbo].[CV] ([CvID], [ProfessionIntro], [Description], [MoneyOfSlot], [rejectReason]) VALUES (3, N'Lập trình viên chuyên nghiệp với khả năng giải quyết vấn đề và sáng tạo trong việc phát triển ứng dụng.', N'Hướng Dẫn Cá Nhân:  Hỗ trợ cá nhân cho học viên ở mọi cấp độ, từ người mới học đến những người muốn nâng cao.', 50000, NULL)
INSERT [dbo].[CV] ([CvID], [ProfessionIntro], [Description], [MoneyOfSlot], [rejectReason]) VALUES (4, N'Freelancer tập trung vào xây dựng giao diện người dùng đẹp và chức năng hiệu quả.', N'Đưa ra sự hỗ trợ đặc biệt cho nhóm và dự án, giúp họ áp dụng kiến thức vào tình huống thực tế.', 50000, NULL)
INSERT [dbo].[CV] ([CvID], [ProfessionIntro], [Description], [MoneyOfSlot], [rejectReason]) VALUES (5, N'Chuyên gia tối ưu hóa công cụ tìm kiếm, tăng cường hiệu suất trang web.', N'Khóa học đặc biệt về ReactJS, giúp học viên xây dựng ứng dụng web hiệu quả.', 50000, NULL)
SET IDENTITY_INSERT [dbo].[CV] OFF
GO
SET IDENTITY_INSERT [dbo].[Follow] ON 

INSERT [dbo].[Follow] ([FollowID], [MentorID], [MenteeID]) VALUES (1, 4, 9)
SET IDENTITY_INSERT [dbo].[Follow] OFF
GO
INSERT [dbo].[Mentee] ([UserID], [status]) VALUES (8, N'Active')
INSERT [dbo].[Mentee] ([UserID], [status]) VALUES (9, N'Active')
GO
INSERT [dbo].[Mentor] ([UserID], [Description], [CvID], [Achivement], [status]) VALUES (3, N'Người sáng tạo trò chơi điện tử, chuyên về phát triển trò chơi di động và trải nghiệm người chơi.', 1, N'Phát triển ứng dụng di động giúp theo dõi sức khỏe cá nhân, nhận được sự đánh giá cao từ người dùng.', N'Reject')
INSERT [dbo].[Mentor] ([UserID], [Description], [CvID], [Achivement], [status]) VALUES (4, N'Chuyên gia DevOps, tập trung vào việc tối ưu hóa quy trình phát triển và triển khai liên tục.', 2, N'Đóng góp vào dự án mã nguồn mở về phần mềm quản lý dự án, được đánh giá cao về đóng góp.', N'Accepted')
INSERT [dbo].[Mentor] ([UserID], [Description], [CvID], [Achivement], [status]) VALUES (5, N'Lập trình viên Python đam mê giải quyết vấn đề, có kinh nghiệm xây dựng ứng dụng web và tự động hóa công việc.', 3, N'Giành giải Nhì tại cuộc thi Hackathon với ứng dụng sử dụng trí tuệ nhân tạo giúp giải quyết vấn đề xã hội.', N'Accepted')
INSERT [dbo].[Mentor] ([UserID], [Description], [CvID], [Achivement], [status]) VALUES (6, N'Chuyên viên UX/UI Design, tập trung vào việc tạo ra trải nghiệm người dùng tốt nhất.', 4, N'Thực tập tại bộ phận thiết kế của Google, có cơ hội làm việc với các chuyên gia thiết kế hàng đầu.', N'Accepted')
INSERT [dbo].[Mentor] ([UserID], [Description], [CvID], [Achivement], [status]) VALUES (7, N'Học viên nghiên cứu khoa học máy tính, chuyên về học máy và xử lý ngôn ngữ tự nhiên.', 5, N'Đạt giải Nhất tại cuộc thi CodeJam với giải thuật hiệu quả và mã nguồn sáng tạo.', N'Accepted')
GO
INSERT [dbo].[MentorOfSkills] ([SkillID], [MentorID]) VALUES (1, 3)
INSERT [dbo].[MentorOfSkills] ([SkillID], [MentorID]) VALUES (2, 3)
INSERT [dbo].[MentorOfSkills] ([SkillID], [MentorID]) VALUES (2, 4)
INSERT [dbo].[MentorOfSkills] ([SkillID], [MentorID]) VALUES (3, 3)
INSERT [dbo].[MentorOfSkills] ([SkillID], [MentorID]) VALUES (5, 4)
INSERT [dbo].[MentorOfSkills] ([SkillID], [MentorID]) VALUES (11, 4)
INSERT [dbo].[MentorOfSkills] ([SkillID], [MentorID]) VALUES (12, 4)
INSERT [dbo].[MentorOfSkills] ([SkillID], [MentorID]) VALUES (13, 4)
INSERT [dbo].[MentorOfSkills] ([SkillID], [MentorID]) VALUES (8, 5)
INSERT [dbo].[MentorOfSkills] ([SkillID], [MentorID]) VALUES (9, 5)
INSERT [dbo].[MentorOfSkills] ([SkillID], [MentorID]) VALUES (10, 5)
INSERT [dbo].[MentorOfSkills] ([SkillID], [MentorID]) VALUES (7, 5)
INSERT [dbo].[MentorOfSkills] ([SkillID], [MentorID]) VALUES (8, 6)
INSERT [dbo].[MentorOfSkills] ([SkillID], [MentorID]) VALUES (9, 6)
INSERT [dbo].[MentorOfSkills] ([SkillID], [MentorID]) VALUES (12, 6)
INSERT [dbo].[MentorOfSkills] ([SkillID], [MentorID]) VALUES (13, 6)
INSERT [dbo].[MentorOfSkills] ([SkillID], [MentorID]) VALUES (14, 3)
INSERT [dbo].[MentorOfSkills] ([SkillID], [MentorID]) VALUES (5, 7)
INSERT [dbo].[MentorOfSkills] ([SkillID], [MentorID]) VALUES (11, 7)
GO
SET IDENTITY_INSERT [dbo].[Message] ON 

INSERT [dbo].[Message] ([MessageID], [ConversationID], [sendID], [sentAt], [Content]) VALUES (1, 1, 3, CAST(N'2024-05-01T01:02:39.063' AS DateTime), N'hello anh?')
INSERT [dbo].[Message] ([MessageID], [ConversationID], [sendID], [sentAt], [Content]) VALUES (2, 1, 6, CAST(N'2024-05-01T09:03:35.703' AS DateTime), N' Chào em')
INSERT [dbo].[Message] ([MessageID], [ConversationID], [sendID], [sentAt], [Content]) VALUES (3, 1, 3, CAST(N'2024-05-01T09:05:39.063' AS DateTime), N'Anh có dạy môn C++ không ạ?')
INSERT [dbo].[Message] ([MessageID], [ConversationID], [sendID], [sentAt], [Content]) VALUES (4, 1, 6, CAST(N'2024-05-01T09:08:35.703' AS DateTime), N' Có nha em')
SET IDENTITY_INSERT [dbo].[Message] OFF
GO
SET IDENTITY_INSERT [dbo].[Payment] ON 

INSERT [dbo].[Payment] ([ID], [Status], [price], [UserID], [ReceiverID], [Time], [RequestID]) VALUES (1, N'Received', 150000, 8, 3, CAST(N'2024-05-28T15:13:48.410' AS DateTime), 1)
INSERT [dbo].[Payment] ([ID], [Status], [price], [UserID], [ReceiverID], [Time], [RequestID]) VALUES (2, N'Received', 100000, 9, 3, CAST(N'2024-05-12T15:37:19.647' AS DateTime), 2)
INSERT [dbo].[Payment] ([ID], [Status], [price], [UserID], [ReceiverID], [Time], [RequestID]) VALUES (3, N'Received', 150000, 8, 4, CAST(N'2024-05-03T21:50:03.077' AS DateTime), 3)
SET IDENTITY_INSERT [dbo].[Payment] OFF
GO
INSERT [dbo].[Rating] ([MentorID], [MenteeID], [Star], [Comment], [Time], [RequestID]) VALUES (6, 8, 5, N'Rất bổ ích', CAST(N'2024-05-28T15:18:48.563' AS DateTime), 1)
INSERT [dbo].[Rating] ([MentorID], [MenteeID], [Star], [Comment], [Time], [RequestID]) VALUES (7, 9, 4, N'Tuyệt vời, chị này 8/10', CAST(N'2024-05-19T21:52:27.503' AS DateTime), 2)
INSERT [dbo].[Rating] ([MentorID], [MenteeID], [Star], [Comment], [Time], [RequestID]) VALUES (5, 9, 5, N'Quá tuyệt vời đánh giá 10/10', CAST(N'2024-05-19T21:52:27.503' AS DateTime), 3)
INSERT [dbo].[Rating] ([MentorID], [MenteeID], [Star], [Comment], [Time], [RequestID]) VALUES (4, 8, 4, N'Thầy này dạy hay quá ạ', CAST(N'2024-05-19T21:52:27.503' AS DateTime), 4)
GO
INSERT [dbo].[RejectRequest] ([RequestID], [Reason]) VALUES (1, N'Demo')
GO
SET IDENTITY_INSERT [dbo].[Request] ON 

INSERT [dbo].[Request] ([RequestID], [SendID], [UserID], [RequestReason], [RequestStatus], [RequestTime], [DeadlineTime], [RequestSubject], [SkillID], [rejectReason]) VALUES (1, 8, 6, N' em muốn đăng kí học ngôn ngữ C', N'Reject', CAST(N'2024-01-01T01:04:51.617' AS DateTime), CAST(N'2024-06-28T01:04:00.000' AS DateTime), N'học C', 3, NULL)
INSERT [dbo].[Request] ([RequestID], [SendID], [UserID], [RequestReason], [RequestStatus], [RequestTime], [DeadlineTime], [RequestSubject], [SkillID], [rejectReason]) VALUES (2, 8, 7, N'Anh cho em đăng kí học java với', N'Done', CAST(N'2024-02-17T13:29:53.180' AS DateTime), CAST(N'2024-05-20T13:29:00.000' AS DateTime), N'học Java', 2, NULL)
INSERT [dbo].[Request] ([RequestID], [SendID], [UserID], [RequestReason], [RequestStatus], [RequestTime], [DeadlineTime], [RequestSubject], [SkillID], [rejectReason]) VALUES (3, 9, 5, N'Em cần tìm gia sư hỏi đáp về MySQL', N'Done', CAST(N'2024-01-03T21:49:24.890' AS DateTime), CAST(N'2024-05-04T21:48:00.000' AS DateTime), N'Thuê gia sư', 12, NULL)
INSERT [dbo].[Request] ([RequestID], [SendID], [UserID], [RequestReason], [RequestStatus], [RequestTime], [DeadlineTime], [RequestSubject], [SkillID], [rejectReason]) VALUES (4, 9, 4, N'Em cần tìm gia sư hỏi đáp về CSS', N'Done', CAST(N'2024-03-03T21:49:24.890' AS DateTime), CAST(N'2024-03-04T21:48:00.000' AS DateTime), N'Thuê gia sư', 7, NULL)






SET IDENTITY_INSERT [dbo].[Request] OFF
GO
INSERT [dbo].[RequestSlots] ([RequestID], [SlotID]) VALUES (1, 1)
INSERT [dbo].[RequestSlots] ([RequestID], [SlotID]) VALUES (2, 2)
INSERT [dbo].[RequestSlots] ([RequestID], [SlotID]) VALUES (3, 3)
INSERT [dbo].[RequestSlots] ([RequestID], [SlotID]) VALUES (4, 4)



GO
SET IDENTITY_INSERT [dbo].[RequestStatus] ON 

INSERT [dbo].[RequestStatus] ([id], [status]) VALUES (1, N'Open')
INSERT [dbo].[RequestStatus] ([id], [status]) VALUES (2, N'Close')
INSERT [dbo].[RequestStatus] ([id], [status]) VALUES (3, N'Processing')
INSERT [dbo].[RequestStatus] ([id], [status]) VALUES (4, N'Done')
INSERT [dbo].[RequestStatus] ([id], [status]) VALUES (5, N'Reject')
INSERT [dbo].[RequestStatus] ([id], [status]) VALUES (6, N'Accept')
INSERT [dbo].[RequestStatus] ([id], [status]) VALUES (7, N'Reopen')
SET IDENTITY_INSERT [dbo].[RequestStatus] OFF
GO
SET IDENTITY_INSERT [dbo].[Role] ON 

INSERT [dbo].[Role] ([roleID], [roleName]) VALUES (1, N'Admin')
INSERT [dbo].[Role] ([roleID], [roleName]) VALUES (2, N'Manager')
INSERT [dbo].[Role] ([roleID], [roleName]) VALUES (3, N'Mentor')
INSERT [dbo].[Role] ([roleID], [roleName]) VALUES (4, N'Mentee')
SET IDENTITY_INSERT [dbo].[Role] OFF
GO
SET IDENTITY_INSERT [dbo].[Schedule] ON 

INSERT [dbo].[Schedule] ([MentorID], [Year], [Week], [Status], [ScheduleID], [rejectReason]) VALUES (6, 2024, 2, N'Active', 1, NULL)
INSERT [dbo].[Schedule] ([MentorID], [Year], [Week], [Status], [ScheduleID], [rejectReason]) VALUES (7, 2024, 8, N'Active', 2, NULL)
INSERT [dbo].[Schedule] ([MentorID], [Year], [Week], [Status], [ScheduleID], [rejectReason]) VALUES (5, 2024, 13, N'Active', 3, NULL)
INSERT [dbo].[Schedule] ([MentorID], [Year], [Week], [Status], [ScheduleID], [rejectReason]) VALUES (4, 2024, 13, N'Active', 4, NULL)


SET IDENTITY_INSERT [dbo].[Schedule] OFF
GO
SET IDENTITY_INSERT [dbo].[Skills] ON 

INSERT [dbo].[Skills] ([SkillID], [SkillName], [enable], [Description], [image]) VALUES (1, N'Lập trình Python', 1, N'Python là ngôn ngữ lập trình đa năng, nhẹ nhàng và dễ đọc. Mentor sẽ hướng dẫn mentee cách sử dụng Python trong phân tích dữ liệu, trí tuệ nhân tạo và phát triển web, giúp họ xây dựng ứng dụng hiệu quả và linh hoạt.', N'https://upload.wikimedia.org/wikipedia/commons/thumb/c/c3/Python-logo-notext.svg/1869px-Python-logo-notext.svg.png')
INSERT [dbo].[Skills] ([SkillID], [SkillName], [enable], [Description], [image]) VALUES (2, N'Lập trình Java', 1, N'Java là ngôn ngữ mạnh mẽ, chủ yếu sử dụng trong phát triển ứng dụng đa nền tảng. Mentor sẽ hỗ trợ mentee trong việc nắm vững Java để xây dựng các ứng dụng lớn, an toàn và hiệu quả.', N'https://tuyendung.kfcvietnam.com.vn/Data/Sites/1/media/blog/java-la-gi.jpg')
INSERT [dbo].[Skills] ([SkillID], [SkillName], [enable], [Description], [image]) VALUES (3, N'Lập trình C', 1, N'Ngôn ngữ C là cơ sở của nhiều hệ điều hành và ứng dụng nhúng. Mentor sẽ giúp mentee hiểu sâu về C, từ cơ bản đến nâng cao, để họ có khả năng xây dựng các hệ thống nhúng và ứng dụng hiệu quả.', N'https://webimages.mongodb.com/_com_assets/cms/l3etz1z9tduxvdoni-c.svg?auto=format%252Ccompress')
INSERT [dbo].[Skills] ([SkillID], [SkillName], [enable], [Description], [image]) VALUES (4, N'Lập trình Ruby', 1, N'Ruby là ngôn ngữ linh hoạt và dễ đọc, thường được sử dụng trong phát triển web. Mentor sẽ hướng dẫn mentee về Ruby để họ có thể xây dựng các ứng dụng web động và mạnh mẽ.', N'https://media.geeksforgeeks.org/wp-content/cdn-uploads/20190902124355/ruby-programming-language.png')
INSERT [dbo].[Skills] ([SkillID], [SkillName], [enable], [Description], [image]) VALUES (5, N'Lập trình PHP', 1, N'PHP là ngôn ngữ lập trình phổ biến cho phát triển web. Mentor sẽ hỗ trợ mentee trong việc hiểu sâu về PHP, giúp họ xây dựng các trang web động và ứng dụng mạnh mẽ.', N'https://upload.wikimedia.org/wikipedia/commons/thumb/2/27/PHP-logo.svg/1200px-PHP-logo.svg.png')
INSERT [dbo].[Skills] ([SkillID], [SkillName], [enable], [Description], [image]) VALUES (6, N'HTML', 1, N'HTML là ngôn ngữ đánh dấu cơ bản cho phát triển web. Mentor sẽ giúp mentee hiểu cách sử dụng HTML để tạo ra cấu trúc cơ bản của trang web, là bước quan trọng trong việc xây dựng giao diện người dùng.', N'https://play-lh.googleusercontent.com/RslBy1o2NEBYUdRjQtUqLbN-ZM2hpks1mHPMiHMrpAuLqxeBPcFSAjo65nQHbTA53YYn')
INSERT [dbo].[Skills] ([SkillID], [SkillName], [enable], [Description], [image]) VALUES (7, N'CSS', 1, N'CSS là ngôn ngữ kiểu trang cho phát triển web. Mentor sẽ hướng dẫn mentee về CSS để họ có khả năng thiết kế và tùy chỉnh giao diện người dùng của trang web một cách chuyên nghiệp.', N'https://funix.edu.vn/wp-content/uploads/2021/12/m%C6%B0%CC%81c-%C4%91%C3%B4%CC%A3-%C6%B0u-ti%C3%AAn-khi-a%CC%81p-du%CC%A3ng-nhi%C3%AA%CC%80u-CSS-1.jpg')
INSERT [dbo].[Skills] ([SkillID], [SkillName], [enable], [Description], [image]) VALUES (8, N'React', 1, N'React là thư viện JavaScript phổ biến cho phát triển giao diện người dùng. Mentor sẽ giúp mentee hiểu cách sử dụng React để xây dựng ứng dụng web động và linh hoạt.', N'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a7/React-icon.svg/1200px-React-icon.svg.png')
INSERT [dbo].[Skills] ([SkillID], [SkillName], [enable], [Description], [image]) VALUES (9, N'Bootstrap', 1, N'Bootstrap là một framework CSS phổ biến giúp tạo giao diện web một cách nhanh chóng và dễ dàng. Mentor sẽ hướng dẫn mentee cách sử dụng Bootstrap để tối ưu hóa quá trình phát triển.', N'https://vinadesigndanang.vn/uploads/image/images/bootstrap.png')
INSERT [dbo].[Skills] ([SkillID], [SkillName], [enable], [Description], [image]) VALUES (10, N'Node.js', 1, N'Node.js là một môi trường thực thi JavaScript ở phía máy chủ. Mentor sẽ giúp mentee hiểu cách sử dụng Node.js để xây dựng ứng dụng máy chủ hiệu quả và có khả năng mở rộng.', N'https://cdn-clekk.nitrocdn.com/tkvYXMZryjYrSVhxKeFTeXElceKUYHeV/assets/images/optimized/rev-49e2c5e/litslink.com/wp-content/uploads/2020/12/node.js-logo-image.png')
INSERT [dbo].[Skills] ([SkillID], [SkillName], [enable], [Description], [image]) VALUES (11, N'Spring Boot', 1, N'Spring Boot là một framework phổ biến cho phát triển ứng dụng Java. Mentor sẽ hỗ trợ mentee trong việc xây dựng ứng dụng Java hiệu quả với Spring Boot', N'https://akdemy.net/wp-content/uploads/2023/04/Spring-Boot-Framework.png')
INSERT [dbo].[Skills] ([SkillID], [SkillName], [enable], [Description], [image]) VALUES (12, N'MySQL', 1, N'MySQL là hệ quản trị cơ sở dữ liệu quan hệ mạnh mẽ. Mentor sẽ giúp mentee hiểu cách sử dụng MySQL để quản lý và tối ưu hóa cơ sở dữ liệu của họ.', N'https://techvccloud.mediacdn.vn/2020/9/17/mysql-1-1600340047538868003500-crop-160034079526453914971.png')
INSERT [dbo].[Skills] ([SkillID], [SkillName], [enable], [Description], [image]) VALUES (13, N'Lập trình JavaScript', 1, N'JavaScript là ngôn ngữ lập trình chạy ở phía client, thường được sử dụng trong phát triển web. Mentor sẽ hướng dẫn mentee cách sử dụng JavaScript để tạo ra trang web động và tương tác.', N'https://logos-world.net/wp-content/uploads/2023/02/JavaScript-Logo.png')
INSERT [dbo].[Skills] ([SkillID], [SkillName], [enable], [Description], [image]) VALUES (14, N'Lập trình C#', 1, N'C# là ngôn ngữ lập trình đa nền tảng của Microsoft. Mentor sẽ giúp mentee hiểu cách sử dụng C# để xây dựng ứng dụng Windows và ứng dụng web ASP.NET.', N'https://lotusacademy.edu.vn/api/media/download/547/c-sharp.jpg')
INSERT [dbo].[Skills] ([SkillID], [SkillName], [enable], [Description], [image]) VALUES (15, N'Lập trình C++', 1, N'C++ là ngôn ngữ lập trình mạnh mẽ, thường được sử dụng trong phát triển phần mềm và game. Mentor sẽ hỗ trợ mentee hiểu cách sử dụng C++ để xây dựng ứng dụng hiệu quả và có khả năng mở rộng.', N'https://upload.wikimedia.org/wikipedia/commons/thumb/1/18/ISO_C%2B%2B_Logo.svg/150px-ISO_C%2B%2B_Logo.svg.png')
SET IDENTITY_INSERT [dbo].[Skills] OFF
GO
SET IDENTITY_INSERT [dbo].[Slots] ON 

INSERT [dbo].[Slots] ([SlotID], [Time], [startAt], [Link], [ScheduleID], [SkillID], [MenteeID], [Status]) VALUES (1, 1.3333333730697632, CAST(N'2024-01-08T07:30:00.000' AS DateTime), N'https://meet.google.com/dam-hjrj-ozc              ', 1, 6, 8, N'Done                ')
INSERT [dbo].[Slots] ([SlotID], [Time], [startAt], [Link], [ScheduleID], [SkillID], [MenteeID], [Status]) VALUES (2, 1.3333333730697632, CAST(N'2024-01-10T07:30:00.000' AS DateTime), N'https://meet.google.com/dam-hjrj-ozc              ', 2, 7, 8, N'Not Confirm         ')
INSERT [dbo].[Slots] ([SlotID], [Time], [startAt], [Link], [ScheduleID], [SkillID], [MenteeID], [Status]) VALUES (3, 1.3333333730697632, CAST(N'2024-01-12T07:30:00.000' AS DateTime), N'https://meet.google.com/dam-hjrj-ozc              ', 3, 5, 9, N'Not Confirm         ')
INSERT [dbo].[Slots] ([SlotID], [Time], [startAt], [Link], [ScheduleID], [SkillID], [MenteeID], [Status]) VALUES (4, 1.3333333730697632, CAST(N'2024-02-20T12:50:00.000' AS DateTime), N'https://meet.google.com/dam-hjrj-ozc              ', 4, 4, 9, N'Reject              ')


SET IDENTITY_INSERT [dbo].[Slots] OFF
GO
SET IDENTITY_INSERT [dbo].[Transaction] ON 

INSERT [dbo].[Transaction] ([ID], [UserID], [price], [Type], [Content], [Time], [Status], [Code]) VALUES (1, 3, 200000, N'+', N'Thanh toan don hang:49104421', CAST(N'2024-02-06' AS Date), N'Pending', 49104421)
INSERT [dbo].[Transaction] ([ID], [UserID], [price], [Type], [Content], [Time], [Status], [Code]) VALUES (2, 3, 300000, N'+', N'Thanh toan don hang:80833131', CAST(N'2024-03-28' AS Date), N'Pending', 80833131)
INSERT [dbo].[Transaction] ([ID], [UserID], [price], [Type], [Content], [Time], [Status], [Code]) VALUES (3, 3, 300000, N'+', N'Thanh toan don hang:80010974', CAST(N'2024-03-28' AS Date), N'Success', 80010974)
INSERT [dbo].[Transaction] ([ID], [UserID], [price], [Type], [Content], [Time], [Status], [Code]) VALUES (4, 3, 150000, N'-', N'Nộp tiền request id 1', CAST(N'2024-03-28' AS Date), N'Success', NULL)
INSERT [dbo].[Transaction] ([ID], [UserID], [price], [Type], [Content], [Time], [Status], [Code]) VALUES (5, 4, 400000, N'+', N'Thanh toan don hang:11204253', CAST(N'2024-02-17' AS Date), N'Pending', 11204253)
INSERT [dbo].[Transaction] ([ID], [UserID], [price], [Type], [Content], [Time], [Status], [Code]) VALUES (6, 4, 400000, N'+', N'Thanh toan don hang:79638128', CAST(N'2024-03-28' AS Date), N'Pending', 79638128)
INSERT [dbo].[Transaction] ([ID], [UserID], [price], [Type], [Content], [Time], [Status], [Code]) VALUES (7, 4, 500000, N'+', N'Thanh toan don hang:56500801', CAST(N'2024-03-28' AS Date), N'Pending', 56500801)
INSERT [dbo].[Transaction] ([ID], [UserID], [price], [Type], [Content], [Time], [Status], [Code]) VALUES (8, 4, 300000, N'+', N'Thanh toan don hang:07129439', CAST(N'2024-03-28' AS Date), N'Pending', 7129439)
INSERT [dbo].[Transaction] ([ID], [UserID], [price], [Type], [Content], [Time], [Status], [Code]) VALUES (9, 4, 300000, N'+', N'Thanh toan don hang:45291188', CAST(N'2024-03-28' AS Date), N'Success', 45291188)
INSERT [dbo].[Transaction] ([ID], [UserID], [price], [Type], [Content], [Time], [Status], [Code]) VALUES (10, 4, 100000, N'-', N'Nộp tiền request id 2', CAST(N'2024-02-12' AS Date), N'Success', NULL)
INSERT [dbo].[Transaction] ([ID], [UserID], [price], [Type], [Content], [Time], [Status], [Code]) VALUES (11, 3, 150000, N'-', N'Nộp tiền request id 3', CAST(N'2024-01-03' AS Date), N'Success', NULL)
INSERT [dbo].[Transaction] ([ID], [UserID], [price], [Type], [Content], [Time], [Status], [Code]) VALUES (12, 3, 5000000, N'+', N'Thanh toan don hang:18902976', CAST(N'2024-03-29' AS Date), N'Success', 18902976)
INSERT [dbo].[Transaction] ([ID], [UserID], [price], [Type], [Content], [Time], [Status], [Code]) VALUES (13, 4, 1800000, N'+', N'Thanh toan don hang:42783375', CAST(N'2024-03-29' AS Date), N'Success', 42783375)
SET IDENTITY_INSERT [dbo].[Transaction] OFF
GO
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([UserID], [username], [password], [fullname], [gender], [dob], [email], [phoneNumber], [Avatar], [address], [roleID], [isValidate], [wallet], [status]) VALUES (1, N'Dung', N'1234', N'Duong Tien Dung', 0, CAST(N'2003-07-08' AS Date), N'dungdthe172311@fpt.edu.vn', N'0961326910', N'avatar/thachhao.jpg', N'Ha Noi', 1, 0, 0, 1)
INSERT [dbo].[User] ([UserID], [username], [password], [fullname], [gender], [dob], [email], [phoneNumber], [Avatar], [address], [roleID], [isValidate], [wallet], [status]) VALUES (2, N'DTD', N'1234', N'DrDYNew', 0, CAST(N'2003-08-02' AS Date), N'dungbd07@gmail.com', N'0972182912', N'avatar/nobita.jpg', N'Ha Noi', 2, 0, 0, 1)
INSERT [dbo].[User] ([UserID], [username], [password], [fullname], [gender], [dob], [email], [phoneNumber], [Avatar], [address], [roleID], [isValidate], [wallet], [status]) VALUES (3, N'Huy', N'1234', N'Nguyen Van Huy', 0, CAST(N'2003-03-02' AS Date), N'huy123@gmail.com', N'0937193738', N'avatar/xeko.jpg', N'Nghe An', 3, 0, 500000, 1)
INSERT [dbo].[User] ([UserID], [username], [password], [fullname], [gender], [dob], [email], [phoneNumber], [Avatar], [address], [roleID], [isValidate], [wallet], [status]) VALUES (4, N'Minh', N'1234', N'Doan Nhat Minh', 0, CAST(N'2003-07-06' AS Date), N'minhngu@gmail.com', N'0372182198', N'avatar/jaiko.jpg', N'Ha Noi', 3, 0, 0, 1)
INSERT [dbo].[User] ([UserID], [username], [password], [fullname], [gender], [dob], [email], [phoneNumber], [Avatar], [address], [roleID], [isValidate], [wallet], [status]) VALUES (5, N'Linh', N'1234', N'Nguyen Mai Linh', 1, CAST(N'2003-01-04' AS Date), N'linhxinhdep@gmail.com', N'0926182910', N'avatar/hihi.jpg', N'Thanh Hoa', 3, 0, 200000, 1)
INSERT [dbo].[User] ([UserID], [username], [password], [fullname], [gender], [dob], [email], [phoneNumber], [Avatar], [address], [roleID], [isValidate], [wallet], [status]) VALUES (6, N'Trang', N'1234', N'Pham Thuy Trang', 1, CAST(N'2004-07-06' AS Date), N'trang1111@gmail.com', N'0732918019', N'avatar/vanhi.jpg', N'Ha Noi', 3, 0, 0, 1)
INSERT [dbo].[User] ([UserID], [username], [password], [fullname], [gender], [dob], [email], [phoneNumber], [Avatar], [address], [roleID], [isValidate], [wallet], [status]) VALUES (7, N'Thanh', N'1234', N'Nguyen Duc Thanh', 0, CAST(N'2003-09-04' AS Date), N'thanh111@gmail.com', N'0982918310', N'avatar/sewashi.jpg', N'Ha Noi', 3, 0, 200000, 1)
INSERT [dbo].[User] ([UserID], [username], [password], [fullname], [gender], [dob], [email], [phoneNumber], [Avatar], [address], [roleID], [isValidate], [wallet], [status]) VALUES (8, N'Hien', N'1234', N'Nguyen Thi Hien', 1, CAST(N'2004-03-02' AS Date), N'hien123@gmail.com', N'0982919127', N'avatar/doremon.jpg', N'Ha Noi', 4, 0, 0, 1)
INSERT [dbo].[User] ([UserID], [username], [password], [fullname], [gender], [dob], [email], [phoneNumber], [Avatar], [address], [roleID], [isValidate], [wallet], [status]) VALUES (9, N'Dat', N'1234', N'Nguyen Van Dat', 0, CAST(N'2003-12-09' AS Date), N'dat1234@gmail.com', N'0982912893', N'avatar/jaian.jpg', N'Ha Noi', 4, 0, 200000, 1)
SET IDENTITY_INSERT [dbo].[User] OFF
GO
SET ANSI_PADDING ON
GO
/****** Object:  Index [UQ__User__AB6E61648F5CA7CD]    Script Date: 6/27/2024 1:03:20 PM ******/
ALTER TABLE [dbo].[User] ADD UNIQUE NONCLUSTERED 
(
	[email] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, IGNORE_DUP_KEY = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
GO
ALTER TABLE [dbo].[CV] ADD  CONSTRAINT [DF_CV_MoneyOfSlot]  DEFAULT ((50000)) FOR [MoneyOfSlot]
GO
ALTER TABLE [dbo].[FollowRequest] ADD  DEFAULT (getdate()) FOR [RequestTime]
GO
ALTER TABLE [dbo].[FollowRequest] ADD  DEFAULT (dateadd(day,(7),getdate())) FOR [DeadLineTime]
GO
ALTER TABLE [dbo].[Mentee] ADD  CONSTRAINT [DF_Mentee_status]  DEFAULT (N'Active') FOR [status]
GO
ALTER TABLE [dbo].[Mentor] ADD  CONSTRAINT [DF_Mentor_status]  DEFAULT (N'Active') FOR [status]
GO
ALTER TABLE [dbo].[Payment] ADD  CONSTRAINT [DF_Payment_Time]  DEFAULT (getdate()) FOR [Time]
GO
ALTER TABLE [dbo].[Rating] ADD  CONSTRAINT [DF_Rating_Time]  DEFAULT (getdate()) FOR [Time]
GO
ALTER TABLE [dbo].[Report] ADD  CONSTRAINT [DF_Report_reportTime]  DEFAULT (getdate()) FOR [reportTime]
GO
ALTER TABLE [dbo].[Report] ADD  CONSTRAINT [DF_Report_Status]  DEFAULT (N'Pending') FOR [Status]
GO
ALTER TABLE [dbo].[Request] ADD  DEFAULT (getdate()) FOR [RequestTime]
GO
ALTER TABLE [dbo].[Skills] ADD  DEFAULT ((1)) FOR [enable]
GO
ALTER TABLE [dbo].[Slots] ADD  CONSTRAINT [DF_Slot_Status]  DEFAULT (N'Not Confirm') FOR [Status]
GO
ALTER TABLE [dbo].[Transaction] ADD  DEFAULT (getdate()) FOR [Time]
GO
ALTER TABLE [dbo].[User] ADD  DEFAULT ((0)) FOR [isValidate]
GO
ALTER TABLE [dbo].[Bank]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Conversation]  WITH CHECK ADD FOREIGN KEY([MenteeID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Conversation]  WITH CHECK ADD FOREIGN KEY([MentorID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Follow]  WITH CHECK ADD FOREIGN KEY([MenteeID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Follow]  WITH CHECK ADD FOREIGN KEY([MentorID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[FollowRequest]  WITH CHECK ADD FOREIGN KEY([MentorID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[FollowRequest]  WITH CHECK ADD FOREIGN KEY([SendID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Mentee]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Mentor]  WITH CHECK ADD FOREIGN KEY([CvID])
REFERENCES [dbo].[CV] ([CvID])
GO
ALTER TABLE [dbo].[Mentor]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[MentorOfSkills]  WITH CHECK ADD FOREIGN KEY([MentorID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[MentorOfSkills]  WITH CHECK ADD FOREIGN KEY([SkillID])
REFERENCES [dbo].[Skills] ([SkillID])
GO
ALTER TABLE [dbo].[Message]  WITH CHECK ADD FOREIGN KEY([ConversationID])
REFERENCES [dbo].[Conversation] ([ConversationID])
GO
ALTER TABLE [dbo].[Message]  WITH CHECK ADD FOREIGN KEY([sendID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Payment]  WITH CHECK ADD FOREIGN KEY([RequestID])
REFERENCES [dbo].[Request] ([RequestID])
GO
ALTER TABLE [dbo].[Payment]  WITH CHECK ADD FOREIGN KEY([RequestID])
REFERENCES [dbo].[Request] ([RequestID])
GO
ALTER TABLE [dbo].[Payment]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Rating]  WITH CHECK ADD FOREIGN KEY([MenteeID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Rating]  WITH CHECK ADD FOREIGN KEY([MentorID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Rating]  WITH CHECK ADD FOREIGN KEY([RequestID])
REFERENCES [dbo].[Request] ([RequestID])
GO
ALTER TABLE [dbo].[RejectRequest]  WITH CHECK ADD FOREIGN KEY([RequestID])
REFERENCES [dbo].[Request] ([RequestID])
GO
ALTER TABLE [dbo].[Report]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Request]  WITH CHECK ADD FOREIGN KEY([SendID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Request]  WITH CHECK ADD FOREIGN KEY([SkillID])
REFERENCES [dbo].[Skills] ([SkillID])
GO
ALTER TABLE [dbo].[Request]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[RequestSlots]  WITH CHECK ADD FOREIGN KEY([RequestID])
REFERENCES [dbo].[Request] ([RequestID])
GO
ALTER TABLE [dbo].[RequestSlots]  WITH CHECK ADD FOREIGN KEY([SlotID])
REFERENCES [dbo].[Slots] ([SlotID])
GO
ALTER TABLE [dbo].[Schedule]  WITH CHECK ADD FOREIGN KEY([MentorID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Slots]  WITH CHECK ADD  CONSTRAINT [FK__Slot__ScheduleID__797309D9] FOREIGN KEY([ScheduleID])
REFERENCES [dbo].[Schedule] ([ScheduleID])
GO
ALTER TABLE [dbo].[Slots] CHECK CONSTRAINT [FK__Slot__ScheduleID__797309D9]
GO
ALTER TABLE [dbo].[Slots]  WITH CHECK ADD FOREIGN KEY([MenteeID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[Slots]  WITH CHECK ADD FOREIGN KEY([SkillID])
REFERENCES [dbo].[Skills] ([SkillID])
GO
ALTER TABLE [dbo].[Transaction]  WITH CHECK ADD FOREIGN KEY([UserID])
REFERENCES [dbo].[User] ([UserID])
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD FOREIGN KEY([roleID])
REFERENCES [dbo].[Role] ([roleID])
GO
