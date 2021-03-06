USE [HungTest]
GO
ALTER TABLE [dbo].[UserTokens] DROP CONSTRAINT [FK_UserTokens_Users_UserId]
GO
ALTER TABLE [dbo].[UserRoles] DROP CONSTRAINT [FK_UserRoles_Users_UserId]
GO
ALTER TABLE [dbo].[UserRoles] DROP CONSTRAINT [FK_UserRoles_Roles_RoleId]
GO
ALTER TABLE [dbo].[UserLogins] DROP CONSTRAINT [FK_UserLogins_Users_UserId]
GO
ALTER TABLE [dbo].[UserClaims] DROP CONSTRAINT [FK_UserClaims_Users_UserId]
GO
ALTER TABLE [dbo].[TransactionDetail] DROP CONSTRAINT [FK_TransactionDetail_Transaction_TransactionId]
GO
ALTER TABLE [dbo].[TransactionDetail] DROP CONSTRAINT [FK_TransactionDetail_Product_ProductId]
GO
ALTER TABLE [dbo].[RoleClaims] DROP CONSTRAINT [FK_RoleClaims_Roles_RoleId]
GO
ALTER TABLE [dbo].[ProductHistory] DROP CONSTRAINT [FK_ProductHistory_Product_ProductId]
GO
ALTER TABLE [dbo].[Product] DROP CONSTRAINT [FK_Product_Unit_UnitId]
GO
ALTER TABLE [dbo].[Product] DROP CONSTRAINT [FK_Product_Supplier_SupplierId]
GO
ALTER TABLE [dbo].[Product] DROP CONSTRAINT [FK_Product_Category_CategoryId]
GO
/****** Object:  Table [dbo].[UserTokens]    Script Date: 2022/02/22 16:30:42 ******/
DROP TABLE [dbo].[UserTokens]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 2022/02/22 16:30:42 ******/
DROP TABLE [dbo].[Users]
GO
/****** Object:  Table [dbo].[UserRoles]    Script Date: 2022/02/22 16:30:42 ******/
DROP TABLE [dbo].[UserRoles]
GO
/****** Object:  Table [dbo].[UserLogins]    Script Date: 2022/02/22 16:30:42 ******/
DROP TABLE [dbo].[UserLogins]
GO
/****** Object:  Table [dbo].[UserClaims]    Script Date: 2022/02/22 16:30:42 ******/
DROP TABLE [dbo].[UserClaims]
GO
/****** Object:  Table [dbo].[Unit]    Script Date: 2022/02/22 16:30:42 ******/
DROP TABLE [dbo].[Unit]
GO
/****** Object:  Table [dbo].[TransactionDetail]    Script Date: 2022/02/22 16:30:42 ******/
DROP TABLE [dbo].[TransactionDetail]
GO
/****** Object:  Table [dbo].[Transaction]    Script Date: 2022/02/22 16:30:42 ******/
DROP TABLE [dbo].[Transaction]
GO
/****** Object:  Table [dbo].[Supplier]    Script Date: 2022/02/22 16:30:42 ******/
DROP TABLE [dbo].[Supplier]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 2022/02/22 16:30:42 ******/
DROP TABLE [dbo].[Roles]
GO
/****** Object:  Table [dbo].[RoleClaims]    Script Date: 2022/02/22 16:30:42 ******/
DROP TABLE [dbo].[RoleClaims]
GO
/****** Object:  Table [dbo].[ProductHistory]    Script Date: 2022/02/22 16:30:42 ******/
DROP TABLE [dbo].[ProductHistory]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 2022/02/22 16:30:42 ******/
DROP TABLE [dbo].[Product]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 2022/02/22 16:30:42 ******/
DROP TABLE [dbo].[Customer]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 2022/02/22 16:30:42 ******/
DROP TABLE [dbo].[Category]
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 2022/02/22 16:30:42 ******/
DROP TABLE [dbo].[__EFMigrationsHistory]
GO
/****** Object:  Table [dbo].[__EFMigrationsHistory]    Script Date: 2022/02/22 16:30:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[__EFMigrationsHistory](
	[MigrationId] [nvarchar](150) NOT NULL,
	[ProductVersion] [nvarchar](32) NOT NULL,
 CONSTRAINT [PK___EFMigrationsHistory] PRIMARY KEY CLUSTERED 
(
	[MigrationId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Category]    Script Date: 2022/02/22 16:30:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Category](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreatedBy] [nvarchar](max) NULL,
	[UpdatedBy] [nvarchar](max) NULL,
	[CreatedAt] [datetime2](7) NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[CategoryName] [nvarchar](100) NOT NULL,
	[Description] [nvarchar](max) NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Customer]    Script Date: 2022/02/22 16:30:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Customer](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreatedBy] [nvarchar](max) NULL,
	[UpdatedBy] [nvarchar](max) NULL,
	[CreatedAt] [datetime2](7) NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[Name] [nvarchar](100) NULL,
	[Address] [nvarchar](max) NULL,
	[Telephone] [nvarchar](max) NULL,
	[HomePhone] [nvarchar](max) NULL,
 CONSTRAINT [PK_Customer] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Product]    Script Date: 2022/02/22 16:30:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Product](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreatedBy] [nvarchar](max) NULL,
	[UpdatedBy] [nvarchar](max) NULL,
	[CreatedAt] [datetime2](7) NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[Barcode] [nvarchar](16) NOT NULL,
	[CategoryId] [int] NULL,
	[SupplierId] [int] NULL,
	[Name] [nvarchar](max) NOT NULL,
	[Quantity] [int] NOT NULL,
	[Price] [money] NOT NULL,
	[PriceBuy] [money] NOT NULL,
	[ExpRange] [int] NULL,
	[ExpirationDate] [datetime2](7) NULL,
	[UnitId] [int] NOT NULL,
	[ImageUrl] [nvarchar](max) NULL,
	[Pin] [bit] NOT NULL,
	[Disable] [bit] NOT NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ProductHistory]    Script Date: 2022/02/22 16:30:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ProductHistory](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ProductId] [int] NOT NULL,
	[AttributeName] [nvarchar](max) NULL,
	[FromValue] [nvarchar](max) NULL,
	[ToValue] [nvarchar](max) NULL,
	[CreateBy] [nvarchar](max) NULL,
	[CreateAt] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_ProductHistory] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[RoleClaims]    Script Date: 2022/02/22 16:30:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[RoleClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[RoleId] [nvarchar](450) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_RoleClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Roles]    Script Date: 2022/02/22 16:30:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Roles](
	[Id] [nvarchar](450) NOT NULL,
	[Name] [nvarchar](256) NULL,
	[NormalizedName] [nvarchar](256) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
 CONSTRAINT [PK_Roles] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Supplier]    Script Date: 2022/02/22 16:30:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Supplier](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreatedBy] [nvarchar](max) NULL,
	[UpdatedBy] [nvarchar](max) NULL,
	[CreatedAt] [datetime2](7) NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[Name] [nvarchar](100) NULL,
	[EmployeeName] [nvarchar](100) NULL,
	[Address] [nvarchar](max) NULL,
	[Telephone] [nvarchar](max) NULL,
	[HomePhone] [nvarchar](max) NULL,
	[Note] [nvarchar](max) NULL,
 CONSTRAINT [PK_Supplier] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Transaction]    Script Date: 2022/02/22 16:30:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Transaction](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreatedBy] [nvarchar](max) NULL,
	[UpdatedBy] [nvarchar](max) NULL,
	[CreatedAt] [datetime2](7) NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[Type] [int] NOT NULL,
	[CustomerId] [int] NOT NULL,
	[SupplierId] [int] NOT NULL,
	[Status] [int] NOT NULL,
	[Ammount] [int] NOT NULL,
	[Payment] [int] NOT NULL,
	[PayBack] [int] NOT NULL,
	[BillNumber] [nvarchar](max) NULL,
	[Note] [nvarchar](max) NULL,
 CONSTRAINT [PK_Transaction] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TransactionDetail]    Script Date: 2022/02/22 16:30:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TransactionDetail](
	[TransactionId] [int] NOT NULL,
	[ProductId] [int] NOT NULL,
	[CreatedBy] [nvarchar](max) NULL,
	[UpdatedBy] [nvarchar](max) NULL,
	[CreatedAt] [datetime2](7) NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[Quantity] [int] NOT NULL,
 CONSTRAINT [PK_TransactionDetail] PRIMARY KEY CLUSTERED 
(
	[TransactionId] ASC,
	[ProductId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Unit]    Script Date: 2022/02/22 16:30:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Unit](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[CreatedBy] [nvarchar](max) NULL,
	[UpdatedBy] [nvarchar](max) NULL,
	[CreatedAt] [datetime2](7) NULL,
	[UpdatedAt] [datetime2](7) NULL,
	[Name] [nvarchar](200) NOT NULL,
 CONSTRAINT [PK_Unit] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserClaims]    Script Date: 2022/02/22 16:30:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](450) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL,
 CONSTRAINT [PK_UserClaims] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserLogins]    Script Date: 2022/02/22 16:30:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserLogins](
	[LoginProvider] [nvarchar](450) NOT NULL,
	[ProviderKey] [nvarchar](450) NOT NULL,
	[ProviderDisplayName] [nvarchar](max) NULL,
	[UserId] [nvarchar](450) NOT NULL,
 CONSTRAINT [PK_UserLogins] PRIMARY KEY CLUSTERED 
(
	[LoginProvider] ASC,
	[ProviderKey] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserRoles]    Script Date: 2022/02/22 16:30:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserRoles](
	[UserId] [nvarchar](450) NOT NULL,
	[RoleId] [nvarchar](450) NOT NULL,
 CONSTRAINT [PK_UserRoles] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[RoleId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Users]    Script Date: 2022/02/22 16:30:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Users](
	[Id] [nvarchar](450) NOT NULL,
	[UserName] [nvarchar](256) NULL,
	[NormalizedUserName] [nvarchar](256) NULL,
	[Email] [nvarchar](256) NULL,
	[NormalizedEmail] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[ConcurrencyStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEnd] [datetimeoffset](7) NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
 CONSTRAINT [PK_Users] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[UserTokens]    Script Date: 2022/02/22 16:30:42 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[UserTokens](
	[UserId] [nvarchar](450) NOT NULL,
	[LoginProvider] [nvarchar](450) NOT NULL,
	[Name] [nvarchar](450) NOT NULL,
	[Value] [nvarchar](max) NULL,
 CONSTRAINT [PK_UserTokens] PRIMARY KEY CLUSTERED 
(
	[UserId] ASC,
	[LoginProvider] ASC,
	[Name] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20211203065102_Init', N'3.1.21')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20220106052921_referenceHostoryWithProduct', N'3.1.21')
INSERT [dbo].[__EFMigrationsHistory] ([MigrationId], [ProductVersion]) VALUES (N'20220113074024_20220113', N'3.1.21')
SET IDENTITY_INSERT [dbo].[Category] ON 

INSERT [dbo].[Category] ([Id], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [CategoryName], [Description]) VALUES (1, NULL, N'Administrator', CAST(N'2022-01-13T16:40:23.9843277' AS DateTime2), CAST(N'2021-12-17T13:10:36.2970247' AS DateTime2), N'Thực phẩm', N'Mô tả Thực phẩm')
INSERT [dbo].[Category] ([Id], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [CategoryName], [Description]) VALUES (2, N'Administrator', NULL, CAST(N'2022-01-13T16:40:23.9857148' AS DateTime2), NULL, N'Mỹ phẩm', NULL)
INSERT [dbo].[Category] ([Id], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [CategoryName], [Description]) VALUES (3, N'Administrator', NULL, CAST(N'2022-01-13T16:40:23.9857192' AS DateTime2), NULL, N'Bánh kẹo', NULL)
INSERT [dbo].[Category] ([Id], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [CategoryName], [Description]) VALUES (4, N'Administrator', NULL, CAST(N'2022-01-13T16:40:23.9857194' AS DateTime2), NULL, N'Rượu bia', NULL)
INSERT [dbo].[Category] ([Id], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [CategoryName], [Description]) VALUES (5, N'Administrator', NULL, CAST(N'2022-01-13T16:40:23.9857196' AS DateTime2), NULL, N'Khác', NULL)
INSERT [dbo].[Category] ([Id], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [CategoryName], [Description]) VALUES (9, N'Administrator', N'Administrator', CAST(N'2021-12-17T13:16:40.3887971' AS DateTime2), CAST(N'2021-12-17T13:16:47.8314101' AS DateTime2), N'Tên danh mục', N'Mô tả2')
SET IDENTITY_INSERT [dbo].[Category] OFF
SET IDENTITY_INSERT [dbo].[Customer] ON 

INSERT [dbo].[Customer] ([Id], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Name], [Address], [Telephone], [HomePhone]) VALUES (1, N'Administrator', N'Administrator', CAST(N'2021-12-17T13:31:16.6898551' AS DateTime2), CAST(N'2021-12-17T13:42:47.3273513' AS DateTime2), N'Nguyễn Trọng Hưng', N'Số 139 gần nhà văn hoá thôn 4', N'0369714415', N'0704493120')
INSERT [dbo].[Customer] ([Id], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Name], [Address], [Telephone], [HomePhone]) VALUES (2, N'Administrator', NULL, CAST(N'2021-12-17T13:31:36.9968710' AS DateTime2), NULL, N'フーン グエンチョン', N'34番地の１', N'0963123192', NULL)
INSERT [dbo].[Customer] ([Id], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Name], [Address], [Telephone], [HomePhone]) VALUES (4, N'Administrator', NULL, CAST(N'2022-01-14T14:41:21.8901231' AS DateTime2), NULL, N'1Khách vãng lai', N'Số 139 gần nhà văn hoá thôn 4', N'0369714415', N'0369714415')
SET IDENTITY_INSERT [dbo].[Customer] OFF
SET IDENTITY_INSERT [dbo].[Product] ON 

INSERT [dbo].[Product] ([Id], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Barcode], [CategoryId], [SupplierId], [Name], [Quantity], [Price], [PriceBuy], [ExpRange], [ExpirationDate], [UnitId], [ImageUrl], [Pin], [Disable]) VALUES (1, NULL, NULL, NULL, NULL, N'8004800008152', 1, 1, N'Bánh Sampa Balocco Savoiardi 200g', 11, 59000.0000, 55000.0000, NULL, CAST(N'2030-01-01T00:00:00.0000000' AS DateTime2), 11, N'image/product/18004800008152.jpeg', 1, 0)
INSERT [dbo].[Product] ([Id], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Barcode], [CategoryId], [SupplierId], [Name], [Quantity], [Price], [PriceBuy], [ExpRange], [ExpirationDate], [UnitId], [ImageUrl], [Pin], [Disable]) VALUES (2, NULL, NULL, CAST(N'2022-01-13T16:40:23.9871753' AS DateTime2), NULL, N'8934637514871', 1, 1, N'Sốt ướp thịt nướng', 48, 10000.0000, 9000.0000, NULL, CAST(N'2030-01-01T00:00:00.0000000' AS DateTime2), 1, N'image/product/28934637514871.png', 1, 0)
INSERT [dbo].[Product] ([Id], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Barcode], [CategoryId], [SupplierId], [Name], [Quantity], [Price], [PriceBuy], [ExpRange], [ExpirationDate], [UnitId], [ImageUrl], [Pin], [Disable]) VALUES (3, NULL, NULL, CAST(N'2022-01-13T16:40:23.9871826' AS DateTime2), NULL, N'8934752060109', 1, 1, N'Dấm trung thành 500ml', 17, 10500.0000, 8000.0000, NULL, CAST(N'2030-01-01T00:00:00.0000000' AS DateTime2), 1, N'image/no-image-icon.png', 1, 0)
INSERT [dbo].[Product] ([Id], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Barcode], [CategoryId], [SupplierId], [Name], [Quantity], [Price], [PriceBuy], [ExpRange], [ExpirationDate], [UnitId], [ImageUrl], [Pin], [Disable]) VALUES (4, NULL, NULL, CAST(N'2022-01-13T16:40:23.9871828' AS DateTime2), NULL, N'8934804004044', 1, 1, N'Dầu hào 350g', 19, 5000.0000, 4500.0000, NULL, CAST(N'2030-01-17T00:00:00.0000000' AS DateTime2), 1, N'image/no-image-icon.png', 1, 0)
INSERT [dbo].[Product] ([Id], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Barcode], [CategoryId], [SupplierId], [Name], [Quantity], [Price], [PriceBuy], [ExpRange], [ExpirationDate], [UnitId], [ImageUrl], [Pin], [Disable]) VALUES (6, NULL, NULL, NULL, NULL, N'8004800008153', 1, 1, N'Bánh Sampa Balocco Savoiardi 200g(dừng bán)', 80, 59000.0000, 55000.0000, NULL, NULL, 1, N'image/no-image-icon.png', 0, 1)
INSERT [dbo].[Product] ([Id], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Barcode], [CategoryId], [SupplierId], [Name], [Quantity], [Price], [PriceBuy], [ExpRange], [ExpirationDate], [UnitId], [ImageUrl], [Pin], [Disable]) VALUES (7, NULL, NULL, NULL, NULL, N'8936036020380', 1, 1, N'chocopie đỏ 393g', 20, 46000.0000, 43000.0000, NULL, NULL, 11, N'image/no-image-icon.png', 0, 0)
INSERT [dbo].[Product] ([Id], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Barcode], [CategoryId], [SupplierId], [Name], [Quantity], [Price], [PriceBuy], [ExpRange], [ExpirationDate], [UnitId], [ImageUrl], [Pin], [Disable]) VALUES (8, NULL, NULL, NULL, NULL, N'8938506260678', 1, 1, N'bánh vòng dừa G&G 150g', 18, 13000.0000, 10000.0000, NULL, NULL, 10, N'image/no-image-icon.png', 0, 0)
INSERT [dbo].[Product] ([Id], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Barcode], [CategoryId], [SupplierId], [Name], [Quantity], [Price], [PriceBuy], [ExpRange], [ExpirationDate], [UnitId], [ImageUrl], [Pin], [Disable]) VALUES (9, NULL, NULL, NULL, NULL, N'8938500282119', 1, 1, N'bánh sampa 200g', 20, 15000.0000, 12000.0000, NULL, NULL, 10, N'image/no-image-icon.png', 0, 0)
INSERT [dbo].[Product] ([Id], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Barcode], [CategoryId], [SupplierId], [Name], [Quantity], [Price], [PriceBuy], [ExpRange], [ExpirationDate], [UnitId], [ImageUrl], [Pin], [Disable]) VALUES (10, NULL, NULL, NULL, NULL, N'8938500282140', 1, 1, N'bánh star 170g', 19, 10000.0000, 7000.0000, NULL, NULL, 11, N'image/no-image-icon.png', 0, 0)
INSERT [dbo].[Product] ([Id], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Barcode], [CategoryId], [SupplierId], [Name], [Quantity], [Price], [PriceBuy], [ExpRange], [ExpirationDate], [UnitId], [ImageUrl], [Pin], [Disable]) VALUES (11, N'Administrator', NULL, CAST(N'2022-01-14T14:32:50.5345549' AS DateTime2), NULL, N'8852047139210', 1, 1, N'xốp jumbo thái đỏ 320g', 20, 30000.0000, 2700.0000, NULL, NULL, 1, N'image/no-image-icon.png', 0, 0)
INSERT [dbo].[Product] ([Id], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Barcode], [CategoryId], [SupplierId], [Name], [Quantity], [Price], [PriceBuy], [ExpRange], [ExpirationDate], [UnitId], [ImageUrl], [Pin], [Disable]) VALUES (12, N'Administrator', NULL, CAST(N'2022-01-14T14:32:50.5345546' AS DateTime2), NULL, N'8852047139227', 1, 1, N'xốp jumbo thái xanh 320g', 19, 30000.0000, 2700.0000, NULL, NULL, 1, N'image/no-image-icon.png', 0, 0)
INSERT [dbo].[Product] ([Id], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Barcode], [CategoryId], [SupplierId], [Name], [Quantity], [Price], [PriceBuy], [ExpRange], [ExpirationDate], [UnitId], [ImageUrl], [Pin], [Disable]) VALUES (13, N'Administrator', NULL, CAST(N'2022-01-14T14:32:50.5345544' AS DateTime2), NULL, N'8938508191123', 1, 1, N'giấy ăn vuông Omia', 20, 11000.0000, 9000.0000, NULL, NULL, 1, N'image/no-image-icon.png', 0, 0)
INSERT [dbo].[Product] ([Id], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Barcode], [CategoryId], [SupplierId], [Name], [Quantity], [Price], [PriceBuy], [ExpRange], [ExpirationDate], [UnitId], [ImageUrl], [Pin], [Disable]) VALUES (14, N'Administrator', NULL, CAST(N'2022-01-14T14:32:50.5345542' AS DateTime2), NULL, N'28935049502245', 1, 1, N'cocacola thùng 24 lon x 320ml', 20, 185000.0000, 175000.0000, NULL, NULL, 1, N'image/no-image-icon.png', 0, 0)
INSERT [dbo].[Product] ([Id], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Barcode], [CategoryId], [SupplierId], [Name], [Quantity], [Price], [PriceBuy], [ExpRange], [ExpirationDate], [UnitId], [ImageUrl], [Pin], [Disable]) VALUES (15, N'Administrator', NULL, CAST(N'2022-01-14T14:32:50.5345540' AS DateTime2), NULL, N'8935049501503', 1, 1, N'cocacola lon 320ml', 20, 9000.0000, 7300.0000, NULL, NULL, 1, N'image/no-image-icon.png', 0, 0)
INSERT [dbo].[Product] ([Id], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Barcode], [CategoryId], [SupplierId], [Name], [Quantity], [Price], [PriceBuy], [ExpRange], [ExpirationDate], [UnitId], [ImageUrl], [Pin], [Disable]) VALUES (16, NULL, NULL, NULL, NULL, N'8934680027557', 1, 1, N'bánh cá mặn kinh đô 350g', 20, 22000.0000, 19688.0000, NULL, NULL, 10, N'image/no-image-icon.png', 0, 0)
INSERT [dbo].[Product] ([Id], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Barcode], [CategoryId], [SupplierId], [Name], [Quantity], [Price], [PriceBuy], [ExpRange], [ExpirationDate], [UnitId], [ImageUrl], [Pin], [Disable]) VALUES (17, NULL, NULL, NULL, NULL, N'8804312901152', 1, 1, N'bánh quy bơ Geum Pung new HQ 250g', 20, 29000.0000, 23925.0000, NULL, NULL, 11, N'image/no-image-icon.png', 0, 0)
INSERT [dbo].[Product] ([Id], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Barcode], [CategoryId], [SupplierId], [Name], [Quantity], [Price], [PriceBuy], [ExpRange], [ExpirationDate], [UnitId], [ImageUrl], [Pin], [Disable]) VALUES (18, NULL, NULL, NULL, NULL, N'8804312000015', 1, 1, N'bánh quy bơ Geum Pung love ball HQ 250g', 20, 29000.0000, 23925.0000, NULL, NULL, 11, N'image/no-image-icon.png', 0, 0)
INSERT [dbo].[Product] ([Id], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Barcode], [CategoryId], [SupplierId], [Name], [Quantity], [Price], [PriceBuy], [ExpRange], [ExpirationDate], [UnitId], [ImageUrl], [Pin], [Disable]) VALUES (19, N'Administrator', NULL, CAST(N'2022-01-14T14:32:50.5345529' AS DateTime2), NULL, N'8935049501626', 1, 1, N'sprite 320ml', 170, 6875.0000, 8000.0000, NULL, NULL, 1, N'image/no-image-icon.png', 0, 0)
INSERT [dbo].[Product] ([Id], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Barcode], [CategoryId], [SupplierId], [Name], [Quantity], [Price], [PriceBuy], [ExpRange], [ExpirationDate], [UnitId], [ImageUrl], [Pin], [Disable]) VALUES (20, N'Administrator', NULL, CAST(N'2022-01-14T14:32:50.5345527' AS DateTime2), NULL, N'8936136161662', 1, 1, N'kokomi đại tôm chua cay thường ngày', 19, 4000.0000, 3600.0000, NULL, NULL, 1, N'image/no-image-icon.png', 0, 0)
INSERT [dbo].[Product] ([Id], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Barcode], [CategoryId], [SupplierId], [Name], [Quantity], [Price], [PriceBuy], [ExpRange], [ExpirationDate], [UnitId], [ImageUrl], [Pin], [Disable]) VALUES (21, N'Administrator', NULL, CAST(N'2022-01-14T14:32:50.5345524' AS DateTime2), NULL, N'8936136160894', 1, 1, N'kokomi đại tôm chua cay', 20, 4000.0000, 3600.0000, NULL, NULL, 1, N'image/no-image-icon.png', 0, 0)
INSERT [dbo].[Product] ([Id], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Barcode], [CategoryId], [SupplierId], [Name], [Quantity], [Price], [PriceBuy], [ExpRange], [ExpirationDate], [UnitId], [ImageUrl], [Pin], [Disable]) VALUES (22, N'Administrator', NULL, CAST(N'2022-01-14T14:32:50.5345522' AS DateTime2), NULL, N'8936034875241', 1, 1, N'xúc xích heo cao bồi 40g', 18, 11000.0000, 8500.0000, NULL, NULL, 1, N'image/no-image-icon.png', 0, 0)
INSERT [dbo].[Product] ([Id], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Barcode], [CategoryId], [SupplierId], [Name], [Quantity], [Price], [PriceBuy], [ExpRange], [ExpirationDate], [UnitId], [ImageUrl], [Pin], [Disable]) VALUES (23, N'Administrator', NULL, CAST(N'2022-01-14T14:32:50.5345518' AS DateTime2), NULL, N'8936152691181', 1, 1, N'omeli gấc 288g', 20, 38000.0000, 35000.0000, NULL, NULL, 1, N'image/no-image-icon.png', 0, 0)
INSERT [dbo].[Product] ([Id], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Barcode], [CategoryId], [SupplierId], [Name], [Quantity], [Price], [PriceBuy], [ExpRange], [ExpirationDate], [UnitId], [ImageUrl], [Pin], [Disable]) VALUES (24, N'Administrator', NULL, CAST(N'2022-01-14T14:32:50.5345474' AS DateTime2), NULL, N'8934609212200', 1, 1, N'jamy dâu 200g', 19, 20000.0000, 17000.0000, NULL, NULL, 1, N'image/no-image-icon.png', 0, 0)
INSERT [dbo].[Product] ([Id], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Barcode], [CategoryId], [SupplierId], [Name], [Quantity], [Price], [PriceBuy], [ExpRange], [ExpirationDate], [UnitId], [ImageUrl], [Pin], [Disable]) VALUES (25, N'Administrator', NULL, CAST(N'2022-01-14T14:32:50.5345471' AS DateTime2), NULL, N'8934680025799', 1, 1, N'cosy tết 576g', 20, 57000.0000, 55000.0000, NULL, NULL, 1, N'image/no-image-icon.png', 0, 0)
INSERT [dbo].[Product] ([Id], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Barcode], [CategoryId], [SupplierId], [Name], [Quantity], [Price], [PriceBuy], [ExpRange], [ExpirationDate], [UnitId], [ImageUrl], [Pin], [Disable]) VALUES (26, N'Administrator', NULL, CAST(N'2022-01-14T14:32:50.5345469' AS DateTime2), NULL, N'8934680033084', 1, 1, N'cosy quế dâu 135g', 19, 12000.0000, 9000.0000, NULL, NULL, 1, N'image/no-image-icon.png', 0, 0)
INSERT [dbo].[Product] ([Id], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Barcode], [CategoryId], [SupplierId], [Name], [Quantity], [Price], [PriceBuy], [ExpRange], [ExpirationDate], [UnitId], [ImageUrl], [Pin], [Disable]) VALUES (27, N'Administrator', NULL, CAST(N'2022-01-14T14:32:50.5345466' AS DateTime2), NULL, N'8934680033107', 1, 1, N'cosy quế lá dứa 135g', 17, 12000.0000, 9000.0000, NULL, NULL, 1, N'image/no-image-icon.png', 0, 0)
INSERT [dbo].[Product] ([Id], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Barcode], [CategoryId], [SupplierId], [Name], [Quantity], [Price], [PriceBuy], [ExpRange], [ExpirationDate], [UnitId], [ImageUrl], [Pin], [Disable]) VALUES (28, N'Administrator', NULL, CAST(N'2022-01-14T14:32:50.5345464' AS DateTime2), NULL, N'8934680113830', 1, 1, N'cosy 144g', 20, 14000.0000, 11000.0000, NULL, NULL, 1, N'image/no-image-icon.png', 0, 0)
INSERT [dbo].[Product] ([Id], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Barcode], [CategoryId], [SupplierId], [Name], [Quantity], [Price], [PriceBuy], [ExpRange], [ExpirationDate], [UnitId], [ImageUrl], [Pin], [Disable]) VALUES (29, N'Administrator', NULL, CAST(N'2022-01-14T14:32:50.5345462' AS DateTime2), NULL, N'8934680113861', 1, 1, N'cosy 336g', 20, 33000.0000, 31000.0000, NULL, NULL, 1, N'image/no-image-icon.png', 0, 0)
INSERT [dbo].[Product] ([Id], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Barcode], [CategoryId], [SupplierId], [Name], [Quantity], [Price], [PriceBuy], [ExpRange], [ExpirationDate], [UnitId], [ImageUrl], [Pin], [Disable]) VALUES (30, N'Administrator', NULL, CAST(N'2022-01-14T14:32:50.5345460' AS DateTime2), NULL, N'8934680113885', 1, 1, N'cosy 576g', 18, 44000.0000, 41000.0000, NULL, NULL, 1, N'image/no-image-icon.png', 0, 0)
INSERT [dbo].[Product] ([Id], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Barcode], [CategoryId], [SupplierId], [Name], [Quantity], [Price], [PriceBuy], [ExpRange], [ExpirationDate], [UnitId], [ImageUrl], [Pin], [Disable]) VALUES (31, N'Administrator', NULL, CAST(N'2022-01-14T14:32:50.5345456' AS DateTime2), NULL, N'8936036020137', 1, 1, N'custas 329g', 20, 50000.0000, 47000.0000, NULL, NULL, 1, N'image/no-image-icon.png', 0, 0)
INSERT [dbo].[Product] ([Id], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Barcode], [CategoryId], [SupplierId], [Name], [Quantity], [Price], [PriceBuy], [ExpRange], [ExpirationDate], [UnitId], [ImageUrl], [Pin], [Disable]) VALUES (32, N'Administrator', NULL, CAST(N'2022-01-14T14:32:50.5345453' AS DateTime2), NULL, N'8936036024135', 1, 1, N'goute 36g', 19, 40000.0000, 37000.0000, NULL, NULL, 1, N'image/no-image-icon.png', 0, 0)
INSERT [dbo].[Product] ([Id], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Barcode], [CategoryId], [SupplierId], [Name], [Quantity], [Price], [PriceBuy], [ExpRange], [ExpirationDate], [UnitId], [ImageUrl], [Pin], [Disable]) VALUES (33, NULL, NULL, NULL, NULL, N'8936036025170', 1, 1, N'chocopie dark 360g', 64, 43000.0000, 46000.0000, NULL, NULL, 11, N'image/no-image-icon.png', 0, 0)
INSERT [dbo].[Product] ([Id], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Barcode], [CategoryId], [SupplierId], [Name], [Quantity], [Price], [PriceBuy], [ExpRange], [ExpirationDate], [UnitId], [ImageUrl], [Pin], [Disable]) VALUES (34, NULL, NULL, NULL, NULL, N'8936036027174', 1, 1, N'chocopie yogurt 360g', 65, 43000.0000, 46000.0000, NULL, NULL, 11, N'image/no-image-icon.png', 0, 0)
INSERT [dbo].[Product] ([Id], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Barcode], [CategoryId], [SupplierId], [Name], [Quantity], [Price], [PriceBuy], [ExpRange], [ExpirationDate], [UnitId], [ImageUrl], [Pin], [Disable]) VALUES (35, NULL, NULL, NULL, NULL, N'8938506260654', 1, 1, N'bánh vòng mè G&G 150g', 20, 13000.0000, 10000.0000, NULL, NULL, 10, N'image/no-image-icon.png', 0, 0)
INSERT [dbo].[Product] ([Id], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Barcode], [CategoryId], [SupplierId], [Name], [Quantity], [Price], [PriceBuy], [ExpRange], [ExpirationDate], [UnitId], [ImageUrl], [Pin], [Disable]) VALUES (36, NULL, NULL, NULL, NULL, N'8938506260661', 1, 1, N'bánh trứng mè gạo lứt G&G 150g', 19, 13000.0000, 10000.0000, NULL, NULL, 10, N'image/no-image-icon.png', 0, 0)
SET IDENTITY_INSERT [dbo].[Product] OFF
SET IDENTITY_INSERT [dbo].[Supplier] ON 

INSERT [dbo].[Supplier] ([Id], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Name], [EmployeeName], [Address], [Telephone], [HomePhone], [Note]) VALUES (1, N'Administrator', NULL, CAST(N'2022-01-13T16:40:23.9867676' AS DateTime2), NULL, N'Bibica', N'Nguyễn Thị Thuỷ', N'183 Hoàng Hoa Thám, Ngọc Hồ, Ba Đình, Hà Nội', N'02437281476', NULL, NULL)
INSERT [dbo].[Supplier] ([Id], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Name], [EmployeeName], [Address], [Telephone], [HomePhone], [Note]) VALUES (2, N'Administrator', NULL, CAST(N'2021-12-17T13:58:53.6254738' AS DateTime2), NULL, N'CÔNG TY CỔ PHẦN KIDS MARKET VIỆT NAM ', N'Nguyễn Hữu Chính', N'Số 8, đường Thôn Nội 1, Thôn Nội, Xã Đức Thượng, Huyện Hoài Đức, Thành phố Hà Nội', N'0966727248', NULL, N'Ngày cấp giấy phép: 16/12/2021 Ngày hoạt động: 16/12/2021 (Đã hoạt động 1 ngày)  Nguồn: https://www.tratencongty.com/company/3faf66c1-cong-ty-co-phan-kids-market-viet-nam/#ixzz7FHGHgn20')
SET IDENTITY_INSERT [dbo].[Supplier] OFF
SET IDENTITY_INSERT [dbo].[Transaction] ON 

INSERT [dbo].[Transaction] ([Id], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Type], [CustomerId], [SupplierId], [Status], [Ammount], [Payment], [PayBack], [BillNumber], [Note]) VALUES (35, N'Administrator', NULL, CAST(N'2022-02-22T11:37:30.3525833' AS DateTime2), NULL, 1, 0, 1, 2, 2960000, 0, -2960000, N'000000001', N'')
INSERT [dbo].[Transaction] ([Id], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Type], [CustomerId], [SupplierId], [Status], [Ammount], [Payment], [PayBack], [BillNumber], [Note]) VALUES (36, N'Administrator', NULL, CAST(N'2022-02-22T11:39:47.5758102' AS DateTime2), NULL, 1, 0, 1, 2, 4400000, 0, -4400000, N'000000035', N'')
INSERT [dbo].[Transaction] ([Id], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Type], [CustomerId], [SupplierId], [Status], [Ammount], [Payment], [PayBack], [BillNumber], [Note]) VALUES (37, N'Administrator', N'Administrator', CAST(N'2022-02-22T11:40:09.6467381' AS DateTime2), CAST(N'2022-02-22T13:11:20.1715842' AS DateTime2), 1, 0, 2, 1, 4400000, 0, -4400000, N'000000036', N'')
INSERT [dbo].[Transaction] ([Id], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Type], [CustomerId], [SupplierId], [Status], [Ammount], [Payment], [PayBack], [BillNumber], [Note]) VALUES (38, N'Administrator', NULL, CAST(N'2022-02-22T11:41:15.4221576' AS DateTime2), NULL, 2, 1, 0, 2, 503000, 0, -503000, N'000000037', N'hung no 503k')
INSERT [dbo].[Transaction] ([Id], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Type], [CustomerId], [SupplierId], [Status], [Ammount], [Payment], [PayBack], [BillNumber], [Note]) VALUES (39, N'Administrator', N'Administrator', CAST(N'2022-02-22T11:41:55.7455235' AS DateTime2), CAST(N'2022-02-22T13:04:44.2665135' AS DateTime2), 2, 2, 0, 1, 74000, 0, -74000, N'000000038', N'fun no 74k')
INSERT [dbo].[Transaction] ([Id], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Type], [CustomerId], [SupplierId], [Status], [Ammount], [Payment], [PayBack], [BillNumber], [Note]) VALUES (40, N'Administrator', NULL, CAST(N'2022-02-22T11:42:16.5313644' AS DateTime2), NULL, 2, 4, 0, 1, 30000, 30000, 0, N'000000039', NULL)
INSERT [dbo].[Transaction] ([Id], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Type], [CustomerId], [SupplierId], [Status], [Ammount], [Payment], [PayBack], [BillNumber], [Note]) VALUES (41, N'Administrator', NULL, CAST(N'2022-02-22T11:42:56.0732587' AS DateTime2), NULL, 2, 1, 0, 2, 10000, 0, -10000, N'000000040', N'hung no 10k')
INSERT [dbo].[Transaction] ([Id], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Type], [CustomerId], [SupplierId], [Status], [Ammount], [Payment], [PayBack], [BillNumber], [Note]) VALUES (42, N'Administrator', N'Administrator', CAST(N'2022-02-22T13:00:46.4767405' AS DateTime2), CAST(N'2022-02-22T13:04:44.2665171' AS DateTime2), 2, 2, 0, 1, 10000, 0, -10000, N'000000041', NULL)
INSERT [dbo].[Transaction] ([Id], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Type], [CustomerId], [SupplierId], [Status], [Ammount], [Payment], [PayBack], [BillNumber], [Note]) VALUES (43, N'Administrator', N'Administrator', CAST(N'2022-02-22T13:03:55.4132019' AS DateTime2), CAST(N'2022-02-22T13:04:44.2665188' AS DateTime2), 2, 2, 0, 1, 59000, 0, -59000, N'000000042', NULL)
INSERT [dbo].[Transaction] ([Id], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Type], [CustomerId], [SupplierId], [Status], [Ammount], [Payment], [PayBack], [BillNumber], [Note]) VALUES (44, N'Administrator', NULL, CAST(N'2022-02-22T14:10:26.6777439' AS DateTime2), NULL, 1, 0, 2, 2, 700000, 0, -700000, N'000000043', N'')
SET IDENTITY_INSERT [dbo].[Transaction] OFF
INSERT [dbo].[TransactionDetail] ([TransactionId], [ProductId], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Quantity]) VALUES (35, 1, N'Administrator', NULL, CAST(N'2022-02-22T11:37:30.4690182' AS DateTime2), NULL, 20)
INSERT [dbo].[TransactionDetail] ([TransactionId], [ProductId], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Quantity]) VALUES (35, 19, N'Administrator', NULL, CAST(N'2022-02-22T11:37:30.4691889' AS DateTime2), NULL, 50)
INSERT [dbo].[TransactionDetail] ([TransactionId], [ProductId], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Quantity]) VALUES (35, 33, N'Administrator', NULL, CAST(N'2022-02-22T11:37:30.4691922' AS DateTime2), NULL, 15)
INSERT [dbo].[TransactionDetail] ([TransactionId], [ProductId], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Quantity]) VALUES (35, 34, N'Administrator', NULL, CAST(N'2022-02-22T11:37:30.4691929' AS DateTime2), NULL, 15)
INSERT [dbo].[TransactionDetail] ([TransactionId], [ProductId], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Quantity]) VALUES (36, 1, N'Administrator', NULL, CAST(N'2022-02-22T11:39:47.6019976' AS DateTime2), NULL, 80)
INSERT [dbo].[TransactionDetail] ([TransactionId], [ProductId], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Quantity]) VALUES (37, 1, N'Administrator', NULL, CAST(N'2022-02-22T11:40:09.6669489' AS DateTime2), NULL, 80)
INSERT [dbo].[TransactionDetail] ([TransactionId], [ProductId], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Quantity]) VALUES (38, 1, N'Administrator', NULL, CAST(N'2022-02-22T11:41:15.4591393' AS DateTime2), NULL, 8)
INSERT [dbo].[TransactionDetail] ([TransactionId], [ProductId], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Quantity]) VALUES (38, 2, N'Administrator', NULL, CAST(N'2022-02-22T11:41:15.4591429' AS DateTime2), NULL, 1)
INSERT [dbo].[TransactionDetail] ([TransactionId], [ProductId], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Quantity]) VALUES (38, 3, N'Administrator', NULL, CAST(N'2022-02-22T11:41:15.4591426' AS DateTime2), NULL, 1)
INSERT [dbo].[TransactionDetail] ([TransactionId], [ProductId], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Quantity]) VALUES (38, 22, N'Administrator', NULL, CAST(N'2022-02-22T11:41:15.4591430' AS DateTime2), NULL, 1)
INSERT [dbo].[TransactionDetail] ([TransactionId], [ProductId], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Quantity]) VALUES (39, 22, N'Administrator', NULL, CAST(N'2022-02-22T11:41:55.7676486' AS DateTime2), NULL, 1)
INSERT [dbo].[TransactionDetail] ([TransactionId], [ProductId], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Quantity]) VALUES (39, 24, N'Administrator', NULL, CAST(N'2022-02-22T11:41:55.7676423' AS DateTime2), NULL, 1)
INSERT [dbo].[TransactionDetail] ([TransactionId], [ProductId], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Quantity]) VALUES (39, 33, N'Administrator', NULL, CAST(N'2022-02-22T11:41:55.7676507' AS DateTime2), NULL, 1)
INSERT [dbo].[TransactionDetail] ([TransactionId], [ProductId], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Quantity]) VALUES (40, 12, N'Administrator', NULL, CAST(N'2022-02-22T11:42:16.5499973' AS DateTime2), NULL, 1)
INSERT [dbo].[TransactionDetail] ([TransactionId], [ProductId], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Quantity]) VALUES (41, 2, N'Administrator', NULL, CAST(N'2022-02-22T11:42:56.0909115' AS DateTime2), NULL, 1)
INSERT [dbo].[TransactionDetail] ([TransactionId], [ProductId], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Quantity]) VALUES (42, 3, N'Administrator', NULL, CAST(N'2022-02-22T13:00:46.6201272' AS DateTime2), NULL, 1)
INSERT [dbo].[TransactionDetail] ([TransactionId], [ProductId], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Quantity]) VALUES (43, 1, N'Administrator', NULL, CAST(N'2022-02-22T13:03:55.4314152' AS DateTime2), NULL, 1)
INSERT [dbo].[TransactionDetail] ([TransactionId], [ProductId], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Quantity]) VALUES (44, 2, N'Administrator', NULL, CAST(N'2022-02-22T14:10:26.8781401' AS DateTime2), NULL, 50)
INSERT [dbo].[TransactionDetail] ([TransactionId], [ProductId], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Quantity]) VALUES (44, 3, N'Administrator', NULL, CAST(N'2022-02-22T14:10:26.8783204' AS DateTime2), NULL, 20)
INSERT [dbo].[TransactionDetail] ([TransactionId], [ProductId], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Quantity]) VALUES (44, 4, N'Administrator', NULL, CAST(N'2022-02-22T14:10:26.8783232' AS DateTime2), NULL, 20)
SET IDENTITY_INSERT [dbo].[Unit] ON 

INSERT [dbo].[Unit] ([Id], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Name]) VALUES (1, NULL, N'Administrator', NULL, CAST(N'2022-01-07T11:18:40.7297220' AS DateTime2), N'Chai')
INSERT [dbo].[Unit] ([Id], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Name]) VALUES (2, N'Administrator', NULL, CAST(N'2022-01-07T11:15:51.8636954' AS DateTime2), NULL, N'Lon')
INSERT [dbo].[Unit] ([Id], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Name]) VALUES (3, N'Administrator', NULL, CAST(N'2022-01-07T11:15:58.7765610' AS DateTime2), NULL, N'Túi')
INSERT [dbo].[Unit] ([Id], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Name]) VALUES (4, N'Administrator', NULL, CAST(N'2022-01-07T11:16:05.2867712' AS DateTime2), NULL, N'Bao')
INSERT [dbo].[Unit] ([Id], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Name]) VALUES (5, N'Administrator', NULL, CAST(N'2022-01-07T11:16:16.8886704' AS DateTime2), NULL, N'Kg')
INSERT [dbo].[Unit] ([Id], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Name]) VALUES (6, N'Administrator', NULL, CAST(N'2022-01-07T11:16:23.5173840' AS DateTime2), NULL, N'Thùng')
INSERT [dbo].[Unit] ([Id], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Name]) VALUES (7, N'Administrator', NULL, CAST(N'2022-01-07T11:16:43.9561784' AS DateTime2), NULL, N'100g')
INSERT [dbo].[Unit] ([Id], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Name]) VALUES (8, N'Administrator', NULL, CAST(N'2022-01-07T11:16:56.7369365' AS DateTime2), NULL, N'Lốc')
INSERT [dbo].[Unit] ([Id], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Name]) VALUES (10, N'Administrator', NULL, CAST(N'2022-01-14T14:33:57.7307933' AS DateTime2), NULL, N'Gói')
INSERT [dbo].[Unit] ([Id], [CreatedBy], [UpdatedBy], [CreatedAt], [UpdatedAt], [Name]) VALUES (11, N'Administrator', NULL, CAST(N'2022-01-14T14:34:02.5682142' AS DateTime2), NULL, N'Hộp')
SET IDENTITY_INSERT [dbo].[Unit] OFF
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Category_CategoryId] FOREIGN KEY([CategoryId])
REFERENCES [dbo].[Category] ([Id])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Category_CategoryId]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Supplier_SupplierId] FOREIGN KEY([SupplierId])
REFERENCES [dbo].[Supplier] ([Id])
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Supplier_SupplierId]
GO
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Unit_UnitId] FOREIGN KEY([UnitId])
REFERENCES [dbo].[Unit] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[Product] CHECK CONSTRAINT [FK_Product_Unit_UnitId]
GO
ALTER TABLE [dbo].[ProductHistory]  WITH CHECK ADD  CONSTRAINT [FK_ProductHistory_Product_ProductId] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[ProductHistory] CHECK CONSTRAINT [FK_ProductHistory_Product_ProductId]
GO
ALTER TABLE [dbo].[RoleClaims]  WITH CHECK ADD  CONSTRAINT [FK_RoleClaims_Roles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Roles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[RoleClaims] CHECK CONSTRAINT [FK_RoleClaims_Roles_RoleId]
GO
ALTER TABLE [dbo].[TransactionDetail]  WITH CHECK ADD  CONSTRAINT [FK_TransactionDetail_Product_ProductId] FOREIGN KEY([ProductId])
REFERENCES [dbo].[Product] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TransactionDetail] CHECK CONSTRAINT [FK_TransactionDetail_Product_ProductId]
GO
ALTER TABLE [dbo].[TransactionDetail]  WITH CHECK ADD  CONSTRAINT [FK_TransactionDetail_Transaction_TransactionId] FOREIGN KEY([TransactionId])
REFERENCES [dbo].[Transaction] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[TransactionDetail] CHECK CONSTRAINT [FK_TransactionDetail_Transaction_TransactionId]
GO
ALTER TABLE [dbo].[UserClaims]  WITH CHECK ADD  CONSTRAINT [FK_UserClaims_Users_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserClaims] CHECK CONSTRAINT [FK_UserClaims_Users_UserId]
GO
ALTER TABLE [dbo].[UserLogins]  WITH CHECK ADD  CONSTRAINT [FK_UserLogins_Users_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserLogins] CHECK CONSTRAINT [FK_UserLogins_Users_UserId]
GO
ALTER TABLE [dbo].[UserRoles]  WITH CHECK ADD  CONSTRAINT [FK_UserRoles_Roles_RoleId] FOREIGN KEY([RoleId])
REFERENCES [dbo].[Roles] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserRoles] CHECK CONSTRAINT [FK_UserRoles_Roles_RoleId]
GO
ALTER TABLE [dbo].[UserRoles]  WITH CHECK ADD  CONSTRAINT [FK_UserRoles_Users_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserRoles] CHECK CONSTRAINT [FK_UserRoles_Users_UserId]
GO
ALTER TABLE [dbo].[UserTokens]  WITH CHECK ADD  CONSTRAINT [FK_UserTokens_Users_UserId] FOREIGN KEY([UserId])
REFERENCES [dbo].[Users] ([Id])
ON DELETE CASCADE
GO
ALTER TABLE [dbo].[UserTokens] CHECK CONSTRAINT [FK_UserTokens_Users_UserId]
GO
