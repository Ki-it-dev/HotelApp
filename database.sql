USE [master]
GO
/****** Object:  Database [dbFourSeasonHotel]    Script Date: 06/06/2023 9:45:10 CH ******/
CREATE DATABASE [dbFourSeasonHotel]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'dbFourSeasonHotel', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\dbFourSeasonHotel.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'dbFourSeasonHotel_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.MSSQLSERVER\MSSQL\DATA\dbFourSeasonHotel_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [dbFourSeasonHotel] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [dbFourSeasonHotel].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [dbFourSeasonHotel] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [dbFourSeasonHotel] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [dbFourSeasonHotel] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [dbFourSeasonHotel] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [dbFourSeasonHotel] SET ARITHABORT OFF 
GO
ALTER DATABASE [dbFourSeasonHotel] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [dbFourSeasonHotel] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [dbFourSeasonHotel] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [dbFourSeasonHotel] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [dbFourSeasonHotel] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [dbFourSeasonHotel] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [dbFourSeasonHotel] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [dbFourSeasonHotel] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [dbFourSeasonHotel] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [dbFourSeasonHotel] SET  ENABLE_BROKER 
GO
ALTER DATABASE [dbFourSeasonHotel] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [dbFourSeasonHotel] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [dbFourSeasonHotel] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [dbFourSeasonHotel] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [dbFourSeasonHotel] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [dbFourSeasonHotel] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [dbFourSeasonHotel] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [dbFourSeasonHotel] SET RECOVERY FULL 
GO
ALTER DATABASE [dbFourSeasonHotel] SET  MULTI_USER 
GO
ALTER DATABASE [dbFourSeasonHotel] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [dbFourSeasonHotel] SET DB_CHAINING OFF 
GO
ALTER DATABASE [dbFourSeasonHotel] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [dbFourSeasonHotel] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [dbFourSeasonHotel] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [dbFourSeasonHotel] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
EXEC sys.sp_db_vardecimal_storage_format N'dbFourSeasonHotel', N'ON'
GO
ALTER DATABASE [dbFourSeasonHotel] SET QUERY_STORE = ON
GO
ALTER DATABASE [dbFourSeasonHotel] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [dbFourSeasonHotel]
GO
/****** Object:  Table [dbo].[Booking]    Script Date: 06/06/2023 9:45:10 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Booking](
	[BookingId] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [int] NOT NULL,
	[CreateDate] [datetime] NOT NULL,
	[CheckIn] [datetime] NOT NULL,
	[CheckOut] [datetime] NOT NULL,
	[TotalPrice] [money] NOT NULL,
	[Status] [nvarchar](100) NOT NULL,
	[PriceDifference] [decimal](18, 0) NULL,
	[UpdateDate] [datetime] NULL,
	[UpdateCheckIn] [datetime] NULL,
	[UpdateCheckOut] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[BookingId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[BookingDetail]    Script Date: 06/06/2023 9:45:10 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[BookingDetail](
	[BookingDetailId] [int] IDENTITY(1,1) NOT NULL,
	[BookingId] [int] NULL,
	[RoomId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[BookingDetailId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 06/06/2023 9:45:10 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[CategoryId] [int] IDENTITY(1,1) NOT NULL,
	[CategoryName] [nvarchar](255) NOT NULL,
	[MaxPeople] [int] NOT NULL,
	[Size] [float] NOT NULL,
	[Image] [varchar](max) NULL,
	[Description] [nvarchar](max) NULL,
	[Status] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[CategoryId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Role]    Script Date: 06/06/2023 9:45:10 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Role](
	[RoleId] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [nvarchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Room]    Script Date: 06/06/2023 9:45:10 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Room](
	[RoomId] [int] IDENTITY(1,1) NOT NULL,
	[CategoryId] [int] NULL,
	[RoomName] [nvarchar](255) NOT NULL,
	[Price] [money] NOT NULL,
	[Description] [nvarchar](max) NULL,
	[Status] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[RoomId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RoomImg]    Script Date: 06/06/2023 9:45:10 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoomImg](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RoomId] [int] NULL,
	[Image] [varchar](max) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[User]    Script Date: 06/06/2023 9:45:10 CH ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[User](
	[UserId] [int] IDENTITY(1,1) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[Password] [varchar](50) NOT NULL,
	[FullName] [nvarchar](255) NULL,
	[Address] [nvarchar](255) NULL,
	[Phone] [varchar](10) NULL,
	[IDCard] [varchar](12) NULL,
	[BirthDay] [date] NULL,
	[RoleId] [int] NULL,
	[Avatar] [varchar](max) NULL,
	[Status] [varchar](20) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[UserId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([CategoryId], [CategoryName], [MaxPeople], [Size], [Image], [Description], [Status]) VALUES (5, N'Double', 1, 10, N'https://images.unsplash.com/photo-1611892440504-42a792e24d32?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8Mnx8aG90ZWwlMjByb29tfGVufDB8fDB8fHww&w=1000&q=80', N'This charming room overlooks our beautiful tropical garden and the landscaped lagoon pool. Enjoy the view over palm trees, plants and flowers in all kinds of shapes and colours. At night, pool and garden are romantically illuminated. The room features timber floor, attractive sitting area, walk-in closet, twin or kingsize bed and a generous marble bathroom with oversized shower. Standard occupancy is 2 persons. Maximum occupancy is 03 adults and 01 child (under 12 years old) or 02 adults and 02 children (under 12 years old).', 1)
INSERT [dbo].[Category] ([CategoryId], [CategoryName], [MaxPeople], [Size], [Image], [Description], [Status]) VALUES (6, N'Superior Twin', 4, 20, N'https://watermark.lovepik.com/photo/20211121/large/lovepik-hotel-room-picture_500597052.jpg', N'Lying amongst beautiful green foliage and a private swimming pool, this two floor villa features a private rooftop, kitchen, living and dining room, master bedroom and spare room on the first floor. A third room on the rooftop with a chic-designed small window can be used as children’s area. Standard occupancy is 4 persons. Maximum occupancy is 06 adults and 02 children (under 12 years old) or 04 adults and 04 children (under 12 years old).', 1)
INSERT [dbo].[Category] ([CategoryId], [CategoryName], [MaxPeople], [Size], [Image], [Description], [Status]) VALUES (9, N'Deluxe', 8, 30, N'../img/room4.jpg', N'Decorated in muted cool colors and they feature local Cham artifacts and decorative handicrafts.The L-shape soft supple sofa on the lower level of the “split floor level” Suite, visually separates living and sleeping areas of the Suite and so makes for an elegant, lavishly appointed yet homely atmosphere. Silk cushions and new sumptuous bed linen and pillows make it even more plush & seductive.

', 1)
INSERT [dbo].[Category] ([CategoryId], [CategoryName], [MaxPeople], [Size], [Image], [Description], [Status]) VALUES (10, N'Suit', 10, 100, N'../img/room5.jpg', N'The new Presidential Suite decorated in royal style with sea view offers its own unique features with oversized living room, large screen TV, bedroom with king bed, marble bathroom housing with bathtub and electric bidet.', 1)
SET IDENTITY_INSERT [dbo].[Category] OFF
GO
SET IDENTITY_INSERT [dbo].[Role] ON 

INSERT [dbo].[Role] ([RoleId], [RoleName]) VALUES (1, N'Admin')
INSERT [dbo].[Role] ([RoleId], [RoleName]) VALUES (2, N'Manager')
INSERT [dbo].[Role] ([RoleId], [RoleName]) VALUES (3, N'Receptionist')
INSERT [dbo].[Role] ([RoleId], [RoleName]) VALUES (4, N'Guest')
SET IDENTITY_INSERT [dbo].[Role] OFF
GO
SET IDENTITY_INSERT [dbo].[Room] ON 

INSERT [dbo].[Room] ([RoomId], [CategoryId], [RoomName], [Price], [Description], [Status]) VALUES (6, 5, N'Double Room', 100.0000, N'This charming room overlooks our beautiful tropical garden and the landscaped lagoon pool. Enjoy the view over palm trees, plants and flowers in all kinds of shapes and colours. At night, pool and garden are romantically illuminated. The room features timber floor, attractive sitting area, walk-in closet, twin or kingsize bed and a generous marble bathroom with oversized shower. Standard occupancy is 2 persons. Maximum occupancy is 03 adults and 01 child (under 12 years old) or 02 adults and 02 children (under 12 years old).', 1)
INSERT [dbo].[Room] ([RoomId], [CategoryId], [RoomName], [Price], [Description], [Status]) VALUES (8, 5, N'Double Room Ocean', 120.0000, N'This charming room overlooks our beautiful tropical garden and the landscaped lagoon pool. Enjoy the view over palm trees, plants and flowers in all kinds of shapes and colours. At night, pool and garden are romantically illuminated. The room features timber floor, attractive sitting area, walk-in closet, twin or kingsize bed and a generous marble bathroom with oversized shower. Standard occupancy is 2 persons. Maximum occupancy is 03 adults and 01 child (under 12 years old) or 02 adults and 02 children (under 12 years old).', 1)
INSERT [dbo].[Room] ([RoomId], [CategoryId], [RoomName], [Price], [Description], [Status]) VALUES (10, 5, N'Double Room Natural', 150.0000, N'This charming room overlooks our beautiful tropical garden and the landscaped lagoon pool. Enjoy the view over palm trees, plants and flowers in all kinds of shapes and colours. At night, pool and garden are romantically illuminated. The room features timber floor, attractive sitting area, walk-in closet, twin or kingsize bed and a generous marble bathroom with oversized shower. Standard occupancy is 2 persons. Maximum occupancy is 03 adults and 01 child (under 12 years old) or 02 adults and 02 children (under 12 years old).', 1)
INSERT [dbo].[Room] ([RoomId], [CategoryId], [RoomName], [Price], [Description], [Status]) VALUES (12, 6, N'Superior Twin ', 180.0000, N'Lying amongst beautiful green foliage and a private swimming pool, this two floor villa features a private rooftop, kitchen, living and dining room, master bedroom and spare room on the first floor. A third room on the rooftop with a chic-designed small window can be used as children’s area. Standard occupancy is 6 persons. Maximum occupancy is 09 adults and 03 children (under 12 years old) or 06 adults and 06 children (under 12 years old).', 1)
INSERT [dbo].[Room] ([RoomId], [CategoryId], [RoomName], [Price], [Description], [Status]) VALUES (13, 6, N'Superior Twin Vip', 250.0000, N'Lying amongst beautiful green foliage and a private swimming pool, this two floor villa features a private rooftop, kitchen, living and dining room, master bedroom and spare room on the first floor. A third room on the rooftop with a chic-designed small window can be used as children’s area. Standard occupancy is 6 persons. Maximum occupancy is 09 adults and 03 children (under 12 years old) or 06 adults and 06 children (under 12 years old).', 1)
INSERT [dbo].[Room] ([RoomId], [CategoryId], [RoomName], [Price], [Description], [Status]) VALUES (14, 9, N'Deluxe Room', 300.0000, N'You will like this deluxe and spacious room!

The sitting area with an elegant sofa, coffee table, and comfortable armchair will help you relax. The large bathroom decorated with honey-colored marble offers a separate shower and bathtub.', 1)
INSERT [dbo].[Room] ([RoomId], [CategoryId], [RoomName], [Price], [Description], [Status]) VALUES (15, 9, N'Deluxe Room Vip', 400.0000, N'You will like this deluxe and spacious room!

The sitting area with an elegant sofa, coffee table, and comfortable armchair will help you relax. The large bathroom decorated with honey-colored marble offers a separate shower and bathtub.', 1)
INSERT [dbo].[Room] ([RoomId], [CategoryId], [RoomName], [Price], [Description], [Status]) VALUES (16, 10, N'Suit', 10000.0000, N'The new Presidential Suite decorated in royal style with sea view offers its own unique features with oversized living room, large screen TV, bedroom with king bed, marble bathroom housing with bathtub and electric bidet.', 1)
INSERT [dbo].[Room] ([RoomId], [CategoryId], [RoomName], [Price], [Description], [Status]) VALUES (17, 10, N'Suit Vip ', 12000.0000, N'The new Presidential Suite decorated in royal style with sea view offers its own unique features with oversized living room, large screen TV, bedroom with king bed, marble bathroom housing with bathtub and electric bidet.', 1)
SET IDENTITY_INSERT [dbo].[Room] OFF
GO
SET IDENTITY_INSERT [dbo].[RoomImg] ON 

INSERT [dbo].[RoomImg] ([Id], [RoomId], [Image]) VALUES (1, 6, N'https://res.cloudinary.com/dfb1bpw8c/image/upload/v1685523696/Ocean_Suite_bh24k2.jpg')
INSERT [dbo].[RoomImg] ([Id], [RoomId], [Image]) VALUES (3, 6, N'https://res.cloudinary.com/dfb1bpw8c/image/upload/v1685523697/Two_Bedroom_Presidential_Suite_h4i8gq.jpg')
INSERT [dbo].[RoomImg] ([Id], [RoomId], [Image]) VALUES (4, 8, N'https://res.cloudinary.com/dfb1bpw8c/image/upload/v1685523694/Interior_Sofa_hyr9cz.jpg')
INSERT [dbo].[RoomImg] ([Id], [RoomId], [Image]) VALUES (5, 8, N'https://res.cloudinary.com/dfb1bpw8c/image/upload/v1685523693/Interior_Sofa_1__dhcwoj.jpg')
INSERT [dbo].[RoomImg] ([Id], [RoomId], [Image]) VALUES (6, 8, N'https://res.cloudinary.com/dfb1bpw8c/image/upload/v1685523693/Living_Room_dgnprj.jpg')
INSERT [dbo].[RoomImg] ([Id], [RoomId], [Image]) VALUES (7, 10, N'https://res.cloudinary.com/dfb1bpw8c/image/upload/v1685523692/FV_OneBedroom_Masterbedroom__2__r2fkhv.jpg')
INSERT [dbo].[RoomImg] ([Id], [RoomId], [Image]) VALUES (8, 10, N'https://res.cloudinary.com/dfb1bpw8c/image/upload/v1685523692/Kitchen._wmwt8d.jpg')
INSERT [dbo].[RoomImg] ([Id], [RoomId], [Image]) VALUES (9, 10, N'https://res.cloudinary.com/dfb1bpw8c/image/upload/v1685523692/FV_Pool_Two_Bedroom_Villa_d8iwcb.jpg')
INSERT [dbo].[RoomImg] ([Id], [RoomId], [Image]) VALUES (10, 12, N'https://res.cloudinary.com/dfb1bpw8c/image/upload/v1685523692/Garden_Superior_ztmucn.jpg')
INSERT [dbo].[RoomImg] ([Id], [RoomId], [Image]) VALUES (11, 12, N'https://res.cloudinary.com/dfb1bpw8c/image/upload/v1685523692/Interior_Desk_x1xvgx.jpg')
INSERT [dbo].[RoomImg] ([Id], [RoomId], [Image]) VALUES (12, 12, N'https://res.cloudinary.com/dfb1bpw8c/image/upload/v1685523691/FV_DiningArea_Two_Bedroom_Villa_nqcmlk.jpg')
INSERT [dbo].[RoomImg] ([Id], [RoomId], [Image]) VALUES (13, 13, N'https://res.cloudinary.com/dfb1bpw8c/image/upload/v1685523691/FV_OneBedroom_Masterbedroom_xw2xry.jpg')
INSERT [dbo].[RoomImg] ([Id], [RoomId], [Image]) VALUES (14, 13, N'https://res.cloudinary.com/dfb1bpw8c/image/upload/v1685523691/FV_One_Bedroom_fcsvgm.jpg')
INSERT [dbo].[RoomImg] ([Id], [RoomId], [Image]) VALUES (15, 13, N'https://res.cloudinary.com/dfb1bpw8c/image/upload/v1685523691/FV_Inroom_Amenities2_Two_Bedroom_Villa_wqmk94.jpg')
INSERT [dbo].[RoomImg] ([Id], [RoomId], [Image]) VALUES (16, 14, N'https://res.cloudinary.com/dfb1bpw8c/image/upload/v1685523691/FV_Inroom_Amenities1_Two_Bedroom_Villa_itxthy.jpg')
INSERT [dbo].[RoomImg] ([Id], [RoomId], [Image]) VALUES (17, 14, N'https://res.cloudinary.com/dfb1bpw8c/image/upload/v1685523690/FV_OneBedroom_Livingroom_nnvmei.jpg')
INSERT [dbo].[RoomImg] ([Id], [RoomId], [Image]) VALUES (18, 14, N'https://res.cloudinary.com/dfb1bpw8c/image/upload/v1685523689/FV_Bedroom3_Three_Bedroom_Villa_fbqjhy.jpg')
INSERT [dbo].[RoomImg] ([Id], [RoomId], [Image]) VALUES (19, 15, N'https://res.cloudinary.com/dfb1bpw8c/image/upload/v1685523689/FV_Balcony_Three_Bedroom_Villa_hqpdjg.jpg')
INSERT [dbo].[RoomImg] ([Id], [RoomId], [Image]) VALUES (20, 15, N'https://res.cloudinary.com/dfb1bpw8c/image/upload/v1685523689/FV_King_Bedroom_Two_Bedroom_Villa_nmzcby.jpg')
INSERT [dbo].[RoomImg] ([Id], [RoomId], [Image]) VALUES (21, 16, N'https://res.cloudinary.com/dfb1bpw8c/image/upload/v1685523689/FV_Dining_Area_Three_Bedroom_Villa_ewwix6.jpg')
INSERT [dbo].[RoomImg] ([Id], [RoomId], [Image]) VALUES (22, 16, N'https://res.cloudinary.com/dfb1bpw8c/image/upload/v1685523689/FV_King_Bedroom_Two_Bedroom_Villa_nmzcby.jpg')
INSERT [dbo].[RoomImg] ([Id], [RoomId], [Image]) VALUES (25, 17, N'https://res.cloudinary.com/dfb1bpw8c/image/upload/v1685523696/Ocean_Suite_bh24k2.jpg')
INSERT [dbo].[RoomImg] ([Id], [RoomId], [Image]) VALUES (26, 17, N'https://res.cloudinary.com/dfb1bpw8c/image/upload/v1685523697/Two_Bedroom_Presidential_Suite_h4i8gq.jpg')
INSERT [dbo].[RoomImg] ([Id], [RoomId], [Image]) VALUES (27, 17, N'https://res.cloudinary.com/dfb1bpw8c/image/upload/v1685523694/Interior_Sofa_hyr9cz.jpg')
SET IDENTITY_INSERT [dbo].[RoomImg] OFF
GO
SET IDENTITY_INSERT [dbo].[User] ON 

INSERT [dbo].[User] ([UserId], [Email], [Password], [FullName], [Address], [Phone], [IDCard], [BirthDay], [RoleId], [Avatar], [Status]) VALUES (73, N'huynhbaokhuyen123@gmail.com', N'QWJjMTIzNDU2IQ==', N'Khuyen', N'123 Ngo Quyen', N'0905386651', N'123456123456', CAST(N'1997-10-12' AS Date), 1, N'http://res.cloudinary.com/dfb1bpw8c/image/upload/v1685545606/Asset_1_woqkeb.png', N'1')
INSERT [dbo].[User] ([UserId], [Email], [Password], [FullName], [Address], [Phone], [IDCard], [BirthDay], [RoleId], [Avatar], [Status]) VALUES (75, N'khoale548@gmail.com', N'QWJjMTIzNDU2IQ==', N'Le Huu Nhat Khoa', N'56 Hoang Dieu', N'0912983193', N'1234567890', CAST(N'2001-10-28' AS Date), 2, N'https://media.istockphoto.com/id/476085198/photo/businessman-silhouette-as-avatar-or-default-profile-picture.jpg?s=612x612&w=0&k=20&c=GVYAgYvyLb082gop8rg0XC_wNsu0qupfSLtO7q9wu38=', N'1')
INSERT [dbo].[User] ([UserId], [Email], [Password], [FullName], [Address], [Phone], [IDCard], [BirthDay], [RoleId], [Avatar], [Status]) VALUES (76, N'vmhsky@gmail.com', N'QWJjMTIzNDU2IQ==', N'Vo Minh Hieu', N'Da Nang, Viet Nam', N'0901293139', N'1234567899', CAST(N'2001-12-12' AS Date), 3, N'https://media.istockphoto.com/id/476085198/photo/businessman-silhouette-as-avatar-or-default-profile-picture.jpg?s=612x612&w=0&k=20&c=GVYAgYvyLb082gop8rg0XC_wNsu0qupfSLtO7q9wu38=', N'1')
INSERT [dbo].[User] ([UserId], [Email], [Password], [FullName], [Address], [Phone], [IDCard], [BirthDay], [RoleId], [Avatar], [Status]) VALUES (77, N'1162tranthenam@gmail.com', N'QWJjMTIzNDU2IQ==', N'Nam', N'21 Nguyen Van Linh', N'0912874262', N'456456456454', CAST(N'2000-08-05' AS Date), 4, N'http://res.cloudinary.com/dfb1bpw8c/image/upload/v1685547507/Asset_1_bu1h8q.png', N'1')
INSERT [dbo].[User] ([UserId], [Email], [Password], [FullName], [Address], [Phone], [IDCard], [BirthDay], [RoleId], [Avatar], [Status]) VALUES (78, N'ghuynguyen0311@gmail.com', N'QWJjMTIzNDU2IQ==', N'Nguyen Gia Huy', N'200 Truong Chinh', N'0909123456', N'343434343434', CAST(N'2001-07-23' AS Date), 1, N'https://media.istockphoto.com/id/476085198/photo/businessman-silhouette-as-avatar-or-default-profile-picture.jpg?s=612x612&w=0&k=20&c=GVYAgYvyLb082gop8rg0XC_wNsu0qupfSLtO7q9wu38=', N'1')
INSERT [dbo].[User] ([UserId], [Email], [Password], [FullName], [Address], [Phone], [IDCard], [BirthDay], [RoleId], [Avatar], [Status]) VALUES (79, N'Nguyenhungphu010@gmail.com', N'QWJjMTIzNDU2IQ==', N'Nguyen Van Phu', N'20 Pham Van Dong', N'0914982134', N'565656565656', CAST(N'1992-12-12' AS Date), 2, N'https://media.istockphoto.com/id/476085198/photo/businessman-silhouette-as-avatar-or-default-profile-picture.jpg?s=612x612&w=0&k=20&c=GVYAgYvyLb082gop8rg0XC_wNsu0qupfSLtO7q9wu38=', N'1')
INSERT [dbo].[User] ([UserId], [Email], [Password], [FullName], [Address], [Phone], [IDCard], [BirthDay], [RoleId], [Avatar], [Status]) VALUES (91, N'khoa@fourseasons.com', N'12345', N'Khoa', N'Viet Nam', N'0905478562', N'1234567895', CAST(N'2001-10-27' AS Date), 2, N'https://media.istockphoto.com/id/476085198/photo/businessman-silhouette-as-avatar-or-default-profile-picture.jpg?s=612x612&w=0&k=20&c=GVYAgYvyLb082gop8rg0XC_wNsu0qupfSLtO7q9wu38=', N'1')
INSERT [dbo].[User] ([UserId], [Email], [Password], [FullName], [Address], [Phone], [IDCard], [BirthDay], [RoleId], [Avatar], [Status]) VALUES (92, N'khoa2@fourseasons.com', N'12345', N'Khoa', N'Da Nang, Viet Nam', N'0905123584', N'1234567896', CAST(N'2001-10-27' AS Date), 2, N'https://media.istockphoto.com/id/476085198/photo/businessman-silhouette-as-avatar-or-default-profile-picture.jpg?s=612x612&w=0&k=20&c=GVYAgYvyLb082gop8rg0XC_wNsu0qupfSLtO7q9wu38=', N'1')
INSERT [dbo].[User] ([UserId], [Email], [Password], [FullName], [Address], [Phone], [IDCard], [BirthDay], [RoleId], [Avatar], [Status]) VALUES (93, N'tuan@fourseasons.com', N'12345', N'tuan', N'Viet Nam', N'0906325456', N'1234556789', CAST(N'2001-10-27' AS Date), 3, N'https://media.istockphoto.com/id/476085198/photo/businessman-silhouette-as-avatar-or-default-profile-picture.jpg?s=612x612&w=0&k=20&c=GVYAgYvyLb082gop8rg0XC_wNsu0qupfSLtO7q9wu38=', N'1')
INSERT [dbo].[User] ([UserId], [Email], [Password], [FullName], [Address], [Phone], [IDCard], [BirthDay], [RoleId], [Avatar], [Status]) VALUES (94, N'hung@fourseasons.com', N'12345', N'hung', N'Da Nang, Viet Nam', N'0904562365', N'1223355687', CAST(N'2001-12-11' AS Date), 3, N'https://media.istockphoto.com/id/476085198/photo/businessman-silhouette-as-avatar-or-default-profile-picture.jpg?s=612x612&w=0&k=20&c=GVYAgYvyLb082gop8rg0XC_wNsu0qupfSLtO7q9wu38=', N'0')
SET IDENTITY_INSERT [dbo].[User] OFF
GO
ALTER TABLE [dbo].[Booking]  WITH CHECK ADD  CONSTRAINT [FK_User_Booking] FOREIGN KEY([UserId])
REFERENCES [dbo].[User] ([UserId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Booking] CHECK CONSTRAINT [FK_User_Booking]
GO
ALTER TABLE [dbo].[BookingDetail]  WITH CHECK ADD  CONSTRAINT [FK_BookingDetail_Booking] FOREIGN KEY([BookingId])
REFERENCES [dbo].[Booking] ([BookingId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BookingDetail] CHECK CONSTRAINT [FK_BookingDetail_Booking]
GO
ALTER TABLE [dbo].[BookingDetail]  WITH CHECK ADD  CONSTRAINT [FK_BookingDetail_Room] FOREIGN KEY([RoomId])
REFERENCES [dbo].[Room] ([RoomId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[BookingDetail] CHECK CONSTRAINT [FK_BookingDetail_Room]
GO
ALTER TABLE [dbo].[Room]  WITH CHECK ADD  CONSTRAINT [FK_Room_Category] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Category] ([CategoryId])
GO
ALTER TABLE [dbo].[Room] CHECK CONSTRAINT [FK_Room_Category]
GO
ALTER TABLE [dbo].[RoomImg]  WITH CHECK ADD  CONSTRAINT [FK_RoomImg_Room] FOREIGN KEY([RoomId])
REFERENCES [dbo].[Room] ([RoomId])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RoomImg] CHECK CONSTRAINT [FK_RoomImg_Room]
GO
ALTER TABLE [dbo].[User]  WITH CHECK ADD  CONSTRAINT [FK_User_Role] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Role] ([RoleId])
GO
ALTER TABLE [dbo].[User] CHECK CONSTRAINT [FK_User_Role]
GO
USE [master]
GO
ALTER DATABASE [dbFourSeasonHotel] SET  READ_WRITE 
GO
