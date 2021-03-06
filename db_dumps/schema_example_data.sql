USE [master]
GO
/****** Object:  Database [TvPad2-dev]    Script Date: 28/01/2015 23:57:36 ******/
CREATE DATABASE [TvPad2-dev]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'TvPad2-dev', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\TvPad2-dev.mdf' , SIZE = 5120KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'TvPad2-dev_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\TvPad2-dev_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [TvPad2-dev] SET COMPATIBILITY_LEVEL = 120
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [TvPad2-dev].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [TvPad2-dev] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [TvPad2-dev] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [TvPad2-dev] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [TvPad2-dev] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [TvPad2-dev] SET ARITHABORT OFF 
GO
ALTER DATABASE [TvPad2-dev] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [TvPad2-dev] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [TvPad2-dev] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [TvPad2-dev] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [TvPad2-dev] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [TvPad2-dev] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [TvPad2-dev] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [TvPad2-dev] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [TvPad2-dev] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [TvPad2-dev] SET  DISABLE_BROKER 
GO
ALTER DATABASE [TvPad2-dev] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [TvPad2-dev] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [TvPad2-dev] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [TvPad2-dev] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [TvPad2-dev] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [TvPad2-dev] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [TvPad2-dev] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [TvPad2-dev] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [TvPad2-dev] SET  MULTI_USER 
GO
ALTER DATABASE [TvPad2-dev] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [TvPad2-dev] SET DB_CHAINING OFF 
GO
ALTER DATABASE [TvPad2-dev] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [TvPad2-dev] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
ALTER DATABASE [TvPad2-dev] SET DELAYED_DURABILITY = DISABLED 
GO
USE [TvPad2-dev]
GO
/****** Object:  Table [dbo].[FACEBOOK_DATA]    Script Date: 28/01/2015 23:57:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[FACEBOOK_DATA](
	[ID] [numeric](19, 0) IDENTITY(1,1) NOT NULL,
	[AUTHOR_ID] [numeric](28, 0) NULL,
	[CAPTION] [varchar](max) NULL,
	[CREATION_DATE] [datetime] NOT NULL,
	[DESCRIPTION] [varchar](max) NULL,
	[FEED_REF] [varchar](max) NULL,
	[LIKES] [numeric](28, 0) NULL,
	[LINK] [varchar](max) NULL,
	[MESSAGE] [varchar](max) NULL,
	[PICTURE] [varchar](max) NULL,
	[SN_ID] [varchar](max) NULL,
	[TYPE] [varchar](255) NULL,
	[REQUEST_ID] [numeric](19, 0) NOT NULL,
	[SOURCE_ID] [numeric](19, 0) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[HASHTAG]    Script Date: 28/01/2015 23:57:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[HASHTAG](
	[ID] [numeric](19, 0) IDENTITY(1,1) NOT NULL,
	[TEXT] [varchar](255) NOT NULL,
	[TWEET_ID] [numeric](19, 0) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[MEDIA]    Script Date: 28/01/2015 23:57:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[MEDIA](
	[ID] [numeric](19, 0) IDENTITY(1,1) NOT NULL,
	[EXPANDED_URL] [varchar](255) NOT NULL,
	[TYPE] [varchar](255) NOT NULL,
	[TWEET_ID] [numeric](19, 0) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[REQUEST]    Script Date: 28/01/2015 23:57:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[REQUEST](
	[ID] [numeric](19, 0) NOT NULL,
	[DESCRIPTION] [varchar](255) NULL,
	[KEYWORD_FILTER] [varchar](255) NOT NULL,
	[LANGUAGE_FILTER] [varchar](255) NULL,
	[LOCATION_FILTER] [varchar](255) NULL,
	[NAME] [varchar](255) NOT NULL,
	[START_DATE] [datetime] NOT NULL,
	[STOP_DATE] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SOURCE]    Script Date: 28/01/2015 23:57:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[SOURCE](
	[ID] [numeric](19, 0) NOT NULL,
	[INFO_LEVEL] [varchar](255) NULL,
	[SOCIAL_NETWORK] [varchar](255) NOT NULL,
	[SRC_SN_ID] [varchar](255) NULL,
	[SRC_SN_NAME] [varchar](255) NULL,
	[TYPE] [varchar](255) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[SOURCES_REQUEST]    Script Date: 28/01/2015 23:57:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SOURCES_REQUEST](
	[ID] [numeric](19, 0) IDENTITY(1,1) NOT NULL,
	[REQUEST_ID] [numeric](19, 0) NOT NULL,
	[SOURCE_ID] [numeric](19, 0) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[TWEET]    Script Date: 28/01/2015 23:57:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[TWEET](
	[ID] [numeric](19, 0) IDENTITY(1,1) NOT NULL,
	[CREATION_DATE] [datetime] NOT NULL,
	[FAVORITES_COUNT] [int] NOT NULL,
	[LANGUAGE] [varchar](255) NOT NULL,
	[LATITUDE] [float] NULL,
	[LONGITUDE] [float] NULL,
	[TEXT] [varchar](255) NOT NULL,
	[TWEET_ID] [numeric](28, 0) NOT NULL,
	[USER_FOLLOWER_COUNT] [int] NOT NULL,
	[USER_ID] [numeric](28, 0) NOT NULL,
	[USER_LISTED_COUNT] [int] NOT NULL,
	[USER_LOCATION] [varchar](255) NULL,
	[REQUEST_ID] [numeric](19, 0) NULL,
	[SOURCE_ID] [numeric](19, 0) NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[URL]    Script Date: 28/01/2015 23:57:36 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[URL](
	[ID] [numeric](19, 0) IDENTITY(1,1) NOT NULL,
	[EXPANDED_URL] [varchar](255) NOT NULL,
	[TWEET_ID] [numeric](19, 0) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
SET IDENTITY_INSERT [dbo].[FACEBOOK_DATA] ON 

INSERT [dbo].[FACEBOOK_DATA] ([ID], [AUTHOR_ID], [CAPTION], [CREATION_DATE], [DESCRIPTION], [FEED_REF], [LIKES], [LINK], [MESSAGE], [PICTURE], [SN_ID], [TYPE], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(1 AS Numeric(19, 0)), CAST(132707500076838 AS Numeric(28, 0)), N'www.ilfattoquotidiano.it', CAST(N'2015-01-28 22:49:35.000' AS DateTime), N'Sulla questione democrazia interna al Movimento 5 Stelle non siamo mai stati teneri. Più volte abbiamo denunciato il rischio che il movimento scivolasse in', NULL, CAST(579 AS Numeric(28, 0)), N'http://bit.ly/1CzTELk', N'BLOG GOMEZ
Quirinale, se il M5s si tura il naso e vota Prodi salta il patto Renzi-Berlusconi
LEGGI: http://bit.ly/1CzTELk', N'https://fbexternal-a.akamaihd.net/safe_image.php?d=AQByqtQOWmtZWIbC&w=158&h=158&url=http%3A%2F%2Fst.ilfattoquotidiano.it%2Fwp-content%2Fimg%2Fautori%2FPGomez.jpg', N'132707500076838_1036513576362888', N'FEED', CAST(1 AS Numeric(19, 0)), CAST(2 AS Numeric(19, 0)))
INSERT [dbo].[FACEBOOK_DATA] ([ID], [AUTHOR_ID], [CAPTION], [CREATION_DATE], [DESCRIPTION], [FEED_REF], [LIKES], [LINK], [MESSAGE], [PICTURE], [SN_ID], [TYPE], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(2 AS Numeric(19, 0)), CAST(939560849401915 AS Numeric(28, 0)), NULL, CAST(N'2015-01-28 23:00:49.000' AS DateTime), NULL, N'132707500076838_1036513576362888', CAST(24 AS Numeric(28, 0)), NULL, N'Non e difficile da capire!!!xo siamo in Italia..gente che capiscono solo il calcio..votare Prodi o Bersani vuol dire fare saltare il patto Renzi-B. Se non capite ste cose elementari,fatte bene a non votare il M5S', NULL, N'1036513576362888_1036518766362369', N'COMMENT', CAST(1 AS Numeric(19, 0)), CAST(2 AS Numeric(19, 0)))
INSERT [dbo].[FACEBOOK_DATA] ([ID], [AUTHOR_ID], [CAPTION], [CREATION_DATE], [DESCRIPTION], [FEED_REF], [LIKES], [LINK], [MESSAGE], [PICTURE], [SN_ID], [TYPE], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(3 AS Numeric(19, 0)), CAST(10204994652538224 AS Numeric(28, 0)), NULL, CAST(N'2015-01-28 23:25:03.000' AS DateTime), NULL, N'132707500076838_1036513576362888', CAST(4 AS Numeric(28, 0)), NULL, N'Se i grillini votano per Imposimato o chicchessia è inutile, fanno solo il gioco di Renzi e B. Non è difficile da capire ragazzi: i grillini votano Prodi o Bersani per rompere il patto del Nazareno, per fare qualcosa di concreto. Scelgono il male minore e decidono di non lasciare che venga votato Amato. Se viene votato Amato o qualche altro nome gradito dal duo Renzi e B. è un casino. Essi vogliono proprio che continuate a sognare un presidente della Repubblica deciso unicamente da voi ma ovviamente accordandosi vi mettono fuori gioco. Svegliatevi invece di criticare', NULL, N'1036513576362888_1036530659694513', N'COMMENT', CAST(1 AS Numeric(19, 0)), CAST(2 AS Numeric(19, 0)))
INSERT [dbo].[FACEBOOK_DATA] ([ID], [AUTHOR_ID], [CAPTION], [CREATION_DATE], [DESCRIPTION], [FEED_REF], [LIKES], [LINK], [MESSAGE], [PICTURE], [SN_ID], [TYPE], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(4 AS Numeric(19, 0)), CAST(932250603454494 AS Numeric(28, 0)), NULL, CAST(N'2015-01-28 23:02:11.000' AS DateTime), NULL, N'132707500076838_1036513576362888', CAST(2 AS Numeric(28, 0)), NULL, N'votate voto non e'' il massimo ma meglio di Amato senza''altro  il movimento rientra in gioco e molte cose che ha fatto Renzi rientrerebbero,quando Prodi prelvo'' 60 euro per entrare nell''euro disse che le avrebbe restituite cosa che fece qualche anno dopo,date una speranza e'' la speranza e'' Prodi.', NULL, N'1036513576362888_1036519456362300', N'COMMENT', CAST(1 AS Numeric(19, 0)), CAST(2 AS Numeric(19, 0)))
INSERT [dbo].[FACEBOOK_DATA] ([ID], [AUTHOR_ID], [CAPTION], [CREATION_DATE], [DESCRIPTION], [FEED_REF], [LIKES], [LINK], [MESSAGE], [PICTURE], [SN_ID], [TYPE], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(5 AS Numeric(19, 0)), CAST(10204342570318890 AS Numeric(28, 0)), NULL, CAST(N'2015-01-28 23:23:58.000' AS DateTime), NULL, N'132707500076838_1036513576362888', CAST(1 AS Numeric(28, 0)), NULL, N'Di sicuro ora come ora, la partita è già cominciata! Votare quei nomi illustri ( che darebbero tanto Pregio al Nostro Paese) NON VERRANNO MAI ELETTI, quindi qui e durante il game si devono fare tatticismi ( anche se è disgustoso pensare di avere Prodi com Presidente della Rep per 7 anni) . Ora si deve far saltare il patto del nazareno smascherare Renzi ed eliminarlo al più presto.
I 5 s devono fare solo questo. È schifoso fare tattica quando il paese è a rotoli, ma il PROBKEMA È CHE GLI ALTRI PARTITI STANNO FACENDO QUALCOSA DI PIÙ SPORCO, NN POSSIAMO PERMETTERGLIELO DI FARLO,', NULL, N'1036513576362888_1036530243027888', N'COMMENT', CAST(1 AS Numeric(19, 0)), CAST(2 AS Numeric(19, 0)))
INSERT [dbo].[FACEBOOK_DATA] ([ID], [AUTHOR_ID], [CAPTION], [CREATION_DATE], [DESCRIPTION], [FEED_REF], [LIKES], [LINK], [MESSAGE], [PICTURE], [SN_ID], [TYPE], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(6 AS Numeric(19, 0)), CAST(10205596047642446 AS Numeric(28, 0)), NULL, CAST(N'2015-01-28 22:33:31.000' AS DateTime), NULL, N'132707500076838_1036411673039745', CAST(34 AS Numeric(28, 0)), NULL, N'Per fottere Renzi e Berlusca, Gargamella va benissimo!', NULL, N'1036411673039745_1036504513030461', N'COMMENT', CAST(1 AS Numeric(19, 0)), CAST(2 AS Numeric(19, 0)))
INSERT [dbo].[FACEBOOK_DATA] ([ID], [AUTHOR_ID], [CAPTION], [CREATION_DATE], [DESCRIPTION], [FEED_REF], [LIKES], [LINK], [MESSAGE], [PICTURE], [SN_ID], [TYPE], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(7 AS Numeric(19, 0)), CAST(888616721183015 AS Numeric(28, 0)), NULL, CAST(N'2015-01-28 22:55:56.000' AS DateTime), NULL, N'132707500076838_1036411673039745', CAST(3 AS Numeric(28, 0)), NULL, N'Molta gente ha la memoria corta! Nominare Prodi e Bersani è di una incoerenza vergognosa, ma se tutto ciò serve a levarci dalle balle Renzi e Berlu ben venga!', NULL, N'1036411673039745_1036516626362583', N'COMMENT', CAST(1 AS Numeric(19, 0)), CAST(2 AS Numeric(19, 0)))
SET IDENTITY_INSERT [dbo].[FACEBOOK_DATA] OFF
SET IDENTITY_INSERT [dbo].[HASHTAG] ON 

INSERT [dbo].[HASHTAG] ([ID], [TEXT], [TWEET_ID]) VALUES (CAST(1 AS Numeric(19, 0)), N'Napolitano', CAST(3 AS Numeric(19, 0)))
INSERT [dbo].[HASHTAG] ([ID], [TEXT], [TWEET_ID]) VALUES (CAST(2 AS Numeric(19, 0)), N'renzi', CAST(3 AS Numeric(19, 0)))
INSERT [dbo].[HASHTAG] ([ID], [TEXT], [TWEET_ID]) VALUES (CAST(3 AS Numeric(19, 0)), N'Cossiga', CAST(3 AS Numeric(19, 0)))
INSERT [dbo].[HASHTAG] ([ID], [TEXT], [TWEET_ID]) VALUES (CAST(4 AS Numeric(19, 0)), N'news', CAST(8 AS Numeric(19, 0)))
INSERT [dbo].[HASHTAG] ([ID], [TEXT], [TWEET_ID]) VALUES (CAST(5 AS Numeric(19, 0)), N'News', CAST(14 AS Numeric(19, 0)))
INSERT [dbo].[HASHTAG] ([ID], [TEXT], [TWEET_ID]) VALUES (CAST(6 AS Numeric(19, 0)), N'Astronomia', CAST(14 AS Numeric(19, 0)))
INSERT [dbo].[HASHTAG] ([ID], [TEXT], [TWEET_ID]) VALUES (CAST(7 AS Numeric(19, 0)), N'mattarella', CAST(16 AS Numeric(19, 0)))
INSERT [dbo].[HASHTAG] ([ID], [TEXT], [TWEET_ID]) VALUES (CAST(8 AS Numeric(19, 0)), N'quirinale', CAST(16 AS Numeric(19, 0)))
INSERT [dbo].[HASHTAG] ([ID], [TEXT], [TWEET_ID]) VALUES (CAST(9 AS Numeric(19, 0)), N'Quirinale', CAST(17 AS Numeric(19, 0)))
INSERT [dbo].[HASHTAG] ([ID], [TEXT], [TWEET_ID]) VALUES (CAST(10 AS Numeric(19, 0)), N'Renzi', CAST(18 AS Numeric(19, 0)))
INSERT [dbo].[HASHTAG] ([ID], [TEXT], [TWEET_ID]) VALUES (CAST(11 AS Numeric(19, 0)), N'marioMTV', CAST(20 AS Numeric(19, 0)))
INSERT [dbo].[HASHTAG] ([ID], [TEXT], [TWEET_ID]) VALUES (CAST(12 AS Numeric(19, 0)), N'Pd', CAST(25 AS Numeric(19, 0)))
INSERT [dbo].[HASHTAG] ([ID], [TEXT], [TWEET_ID]) VALUES (CAST(13 AS Numeric(19, 0)), N'Renzi', CAST(25 AS Numeric(19, 0)))
INSERT [dbo].[HASHTAG] ([ID], [TEXT], [TWEET_ID]) VALUES (CAST(14 AS Numeric(19, 0)), N'Mattarella', CAST(25 AS Numeric(19, 0)))
INSERT [dbo].[HASHTAG] ([ID], [TEXT], [TWEET_ID]) VALUES (CAST(15 AS Numeric(19, 0)), N'Prodi', CAST(25 AS Numeric(19, 0)))
INSERT [dbo].[HASHTAG] ([ID], [TEXT], [TWEET_ID]) VALUES (CAST(16 AS Numeric(19, 0)), N'M5S', CAST(25 AS Numeric(19, 0)))
INSERT [dbo].[HASHTAG] ([ID], [TEXT], [TWEET_ID]) VALUES (CAST(17 AS Numeric(19, 0)), N'M5S', CAST(28 AS Numeric(19, 0)))
INSERT [dbo].[HASHTAG] ([ID], [TEXT], [TWEET_ID]) VALUES (CAST(18 AS Numeric(19, 0)), N'Quirinale', CAST(28 AS Numeric(19, 0)))
INSERT [dbo].[HASHTAG] ([ID], [TEXT], [TWEET_ID]) VALUES (CAST(19 AS Numeric(19, 0)), N'se', CAST(28 AS Numeric(19, 0)))
INSERT [dbo].[HASHTAG] ([ID], [TEXT], [TWEET_ID]) VALUES (CAST(20 AS Numeric(19, 0)), N'il', CAST(28 AS Numeric(19, 0)))
INSERT [dbo].[HASHTAG] ([ID], [TEXT], [TWEET_ID]) VALUES (CAST(21 AS Numeric(19, 0)), N'Quirinale', CAST(28 AS Numeric(19, 0)))
INSERT [dbo].[HASHTAG] ([ID], [TEXT], [TWEET_ID]) VALUES (CAST(22 AS Numeric(19, 0)), N'GiorniDelColle', CAST(30 AS Numeric(19, 0)))
INSERT [dbo].[HASHTAG] ([ID], [TEXT], [TWEET_ID]) VALUES (CAST(23 AS Numeric(19, 0)), N'tgcomforpresident', CAST(32 AS Numeric(19, 0)))
INSERT [dbo].[HASHTAG] ([ID], [TEXT], [TWEET_ID]) VALUES (CAST(24 AS Numeric(19, 0)), N'PresidenteM5S', CAST(33 AS Numeric(19, 0)))
INSERT [dbo].[HASHTAG] ([ID], [TEXT], [TWEET_ID]) VALUES (CAST(25 AS Numeric(19, 0)), N'renzi', CAST(34 AS Numeric(19, 0)))
INSERT [dbo].[HASHTAG] ([ID], [TEXT], [TWEET_ID]) VALUES (CAST(26 AS Numeric(19, 0)), N'Corona', CAST(34 AS Numeric(19, 0)))
INSERT [dbo].[HASHTAG] ([ID], [TEXT], [TWEET_ID]) VALUES (CAST(27 AS Numeric(19, 0)), N'Mattarella', CAST(36 AS Numeric(19, 0)))
INSERT [dbo].[HASHTAG] ([ID], [TEXT], [TWEET_ID]) VALUES (CAST(28 AS Numeric(19, 0)), N'Renzi', CAST(36 AS Numeric(19, 0)))
INSERT [dbo].[HASHTAG] ([ID], [TEXT], [TWEET_ID]) VALUES (CAST(29 AS Numeric(19, 0)), N'PresidenteM5S', CAST(38 AS Numeric(19, 0)))
INSERT [dbo].[HASHTAG] ([ID], [TEXT], [TWEET_ID]) VALUES (CAST(30 AS Numeric(19, 0)), N'GiorniDelColle', CAST(43 AS Numeric(19, 0)))
INSERT [dbo].[HASHTAG] ([ID], [TEXT], [TWEET_ID]) VALUES (CAST(31 AS Numeric(19, 0)), N'quirinale', CAST(44 AS Numeric(19, 0)))
INSERT [dbo].[HASHTAG] ([ID], [TEXT], [TWEET_ID]) VALUES (CAST(32 AS Numeric(19, 0)), N'PD', CAST(44 AS Numeric(19, 0)))
INSERT [dbo].[HASHTAG] ([ID], [TEXT], [TWEET_ID]) VALUES (CAST(33 AS Numeric(19, 0)), N'belloefake', CAST(44 AS Numeric(19, 0)))
INSERT [dbo].[HASHTAG] ([ID], [TEXT], [TWEET_ID]) VALUES (CAST(34 AS Numeric(19, 0)), N'Nardella', CAST(44 AS Numeric(19, 0)))
INSERT [dbo].[HASHTAG] ([ID], [TEXT], [TWEET_ID]) VALUES (CAST(35 AS Numeric(19, 0)), N'renzi', CAST(44 AS Numeric(19, 0)))
INSERT [dbo].[HASHTAG] ([ID], [TEXT], [TWEET_ID]) VALUES (CAST(36 AS Numeric(19, 0)), N'politica', CAST(50 AS Numeric(19, 0)))
INSERT [dbo].[HASHTAG] ([ID], [TEXT], [TWEET_ID]) VALUES (CAST(37 AS Numeric(19, 0)), N'notizie', CAST(50 AS Numeric(19, 0)))
INSERT [dbo].[HASHTAG] ([ID], [TEXT], [TWEET_ID]) VALUES (CAST(38 AS Numeric(19, 0)), N'notizie', CAST(51 AS Numeric(19, 0)))
INSERT [dbo].[HASHTAG] ([ID], [TEXT], [TWEET_ID]) VALUES (CAST(39 AS Numeric(19, 0)), N'Quirinale', CAST(53 AS Numeric(19, 0)))
INSERT [dbo].[HASHTAG] ([ID], [TEXT], [TWEET_ID]) VALUES (CAST(40 AS Numeric(19, 0)), N'renzi', CAST(53 AS Numeric(19, 0)))
INSERT [dbo].[HASHTAG] ([ID], [TEXT], [TWEET_ID]) VALUES (CAST(41 AS Numeric(19, 0)), N'fb', CAST(56 AS Numeric(19, 0)))
INSERT [dbo].[HASHTAG] ([ID], [TEXT], [TWEET_ID]) VALUES (CAST(42 AS Numeric(19, 0)), N'portaaporta', CAST(59 AS Numeric(19, 0)))
INSERT [dbo].[HASHTAG] ([ID], [TEXT], [TWEET_ID]) VALUES (CAST(43 AS Numeric(19, 0)), N'news', CAST(60 AS Numeric(19, 0)))
INSERT [dbo].[HASHTAG] ([ID], [TEXT], [TWEET_ID]) VALUES (CAST(44 AS Numeric(19, 0)), N'SEL', CAST(61 AS Numeric(19, 0)))
INSERT [dbo].[HASHTAG] ([ID], [TEXT], [TWEET_ID]) VALUES (CAST(45 AS Numeric(19, 0)), N'Prodi', CAST(61 AS Numeric(19, 0)))
INSERT [dbo].[HASHTAG] ([ID], [TEXT], [TWEET_ID]) VALUES (CAST(46 AS Numeric(19, 0)), N'presidentedellarepubblica', CAST(61 AS Numeric(19, 0)))
INSERT [dbo].[HASHTAG] ([ID], [TEXT], [TWEET_ID]) VALUES (CAST(47 AS Numeric(19, 0)), N'Renzi', CAST(61 AS Numeric(19, 0)))
INSERT [dbo].[HASHTAG] ([ID], [TEXT], [TWEET_ID]) VALUES (CAST(48 AS Numeric(19, 0)), N'politica', CAST(62 AS Numeric(19, 0)))
INSERT [dbo].[HASHTAG] ([ID], [TEXT], [TWEET_ID]) VALUES (CAST(49 AS Numeric(19, 0)), N'Quirinale', CAST(65 AS Numeric(19, 0)))
INSERT [dbo].[HASHTAG] ([ID], [TEXT], [TWEET_ID]) VALUES (CAST(50 AS Numeric(19, 0)), N'Mattarella', CAST(65 AS Numeric(19, 0)))
INSERT [dbo].[HASHTAG] ([ID], [TEXT], [TWEET_ID]) VALUES (CAST(51 AS Numeric(19, 0)), N'lavoltabuona', CAST(66 AS Numeric(19, 0)))
INSERT [dbo].[HASHTAG] ([ID], [TEXT], [TWEET_ID]) VALUES (CAST(52 AS Numeric(19, 0)), N'renzi', CAST(66 AS Numeric(19, 0)))
INSERT [dbo].[HASHTAG] ([ID], [TEXT], [TWEET_ID]) VALUES (CAST(53 AS Numeric(19, 0)), N'portaaporta', CAST(67 AS Numeric(19, 0)))
INSERT [dbo].[HASHTAG] ([ID], [TEXT], [TWEET_ID]) VALUES (CAST(54 AS Numeric(19, 0)), N'QuirinalParty', CAST(68 AS Numeric(19, 0)))
INSERT [dbo].[HASHTAG] ([ID], [TEXT], [TWEET_ID]) VALUES (CAST(55 AS Numeric(19, 0)), N'Renzi', CAST(68 AS Numeric(19, 0)))
INSERT [dbo].[HASHTAG] ([ID], [TEXT], [TWEET_ID]) VALUES (CAST(56 AS Numeric(19, 0)), N'Quirinale', CAST(68 AS Numeric(19, 0)))
SET IDENTITY_INSERT [dbo].[HASHTAG] OFF
SET IDENTITY_INSERT [dbo].[MEDIA] ON 

INSERT [dbo].[MEDIA] ([ID], [EXPANDED_URL], [TYPE], [TWEET_ID]) VALUES (CAST(1 AS Numeric(19, 0)), N'http://twitter.com/1001ptsIT/status/560568519222251520/photo/1', N'photo', CAST(22 AS Numeric(19, 0)))
INSERT [dbo].[MEDIA] ([ID], [EXPANDED_URL], [TYPE], [TWEET_ID]) VALUES (CAST(2 AS Numeric(19, 0)), N'http://twitter.com/FantaScooby/status/560568615091843073/photo/1', N'photo', CAST(24 AS Numeric(19, 0)))
INSERT [dbo].[MEDIA] ([ID], [EXPANDED_URL], [TYPE], [TWEET_ID]) VALUES (CAST(3 AS Numeric(19, 0)), N'http://twitter.com/politica24ore/status/560569938185056256/photo/1', N'photo', CAST(62 AS Numeric(19, 0)))
SET IDENTITY_INSERT [dbo].[MEDIA] OFF
INSERT [dbo].[REQUEST] ([ID], [DESCRIPTION], [KEYWORD_FILTER], [LANGUAGE_FILTER], [LOCATION_FILTER], [NAME], [START_DATE], [STOP_DATE]) VALUES (CAST(1 AS Numeric(19, 0)), N'prova', N'renzi,!governo', N'it', NULL, N'prova', CAST(N'2015-01-28 22:00:00.000' AS DateTime), CAST(N'2015-01-28 23:50:00.000' AS DateTime))
INSERT [dbo].[SOURCE] ([ID], [INFO_LEVEL], [SOCIAL_NETWORK], [SRC_SN_ID], [SRC_SN_NAME], [TYPE]) VALUES (CAST(1 AS Numeric(19, 0)), NULL, N'TWITTER', NULL, NULL, N'GENERIC')
INSERT [dbo].[SOURCE] ([ID], [INFO_LEVEL], [SOCIAL_NETWORK], [SRC_SN_ID], [SRC_SN_NAME], [TYPE]) VALUES (CAST(2 AS Numeric(19, 0)), N'COMMENT', N'FACEBOOK', NULL, N'ilFattoQuotidiano', N'PAGE')
INSERT [dbo].[SOURCE] ([ID], [INFO_LEVEL], [SOCIAL_NETWORK], [SRC_SN_ID], [SRC_SN_NAME], [TYPE]) VALUES (CAST(3 AS Numeric(19, 0)), N'COMMENT', N'FACEBOOK', NULL, N'Repubblica', N'PAGE')
SET IDENTITY_INSERT [dbo].[SOURCES_REQUEST] ON 

INSERT [dbo].[SOURCES_REQUEST] ([ID], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(1 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)))
INSERT [dbo].[SOURCES_REQUEST] ([ID], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(2 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)), CAST(2 AS Numeric(19, 0)))
INSERT [dbo].[SOURCES_REQUEST] ([ID], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(4 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)), CAST(3 AS Numeric(19, 0)))
SET IDENTITY_INSERT [dbo].[SOURCES_REQUEST] OFF
SET IDENTITY_INSERT [dbo].[TWEET] ON 

INSERT [dbo].[TWEET] ([ID], [CREATION_DATE], [FAVORITES_COUNT], [LANGUAGE], [LATITUDE], [LONGITUDE], [TEXT], [TWEET_ID], [USER_FOLLOWER_COUNT], [USER_ID], [USER_LISTED_COUNT], [USER_LOCATION], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(1 AS Numeric(19, 0)), CAST(N'2015-01-28 23:38:46.000' AS DateTime), 0, N'it', 0, 0, N'Quirinale, se il M5S si tura il naso e vota Prodi salta il patto Renzi-Berlusconi - Il Fatto Quotidiano http://t.co/yBHjYTVvSs', CAST(560567690554011648 AS Numeric(28, 0)), 20186, CAST(594689707 AS Numeric(28, 0)), 49, N'Paris/Shanghai', CAST(1 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)))
INSERT [dbo].[TWEET] ([ID], [CREATION_DATE], [FAVORITES_COUNT], [LANGUAGE], [LATITUDE], [LONGITUDE], [TEXT], [TWEET_ID], [USER_FOLLOWER_COUNT], [USER_ID], [USER_LISTED_COUNT], [USER_LOCATION], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(2 AS Numeric(19, 0)), CAST(N'2015-01-28 23:38:47.000' AS DateTime), 0, N'it', 0, 0, N'Quirinale: Berlusconi, Renzi rispetti spirito Nazareno, nome va condiviso - Adnkronos http://t.co/swx9WsYxrM', CAST(560567694626652160 AS Numeric(28, 0)), 299, CAST(475817057 AS Numeric(28, 0)), 5, N'Palermo', CAST(1 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)))
INSERT [dbo].[TWEET] ([ID], [CREATION_DATE], [FAVORITES_COUNT], [LANGUAGE], [LATITUDE], [LONGITUDE], [TEXT], [TWEET_ID], [USER_FOLLOWER_COUNT], [USER_ID], [USER_LISTED_COUNT], [USER_LOCATION], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(3 AS Numeric(19, 0)), CAST(N'2015-01-28 23:39:00.000' AS DateTime), 0, N'it', 0, 0, N'@CFenudi Il PdR deve rappresentare il popolo, NON i politici luridi e ladri (#renzi)
No a un altro come #Napolitano - Si a uno come #Cossiga', CAST(560567749353955328 AS Numeric(28, 0)), 157, CAST(2813579953 AS Numeric(28, 0)), 1, N'Italy', CAST(1 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)))
INSERT [dbo].[TWEET] ([ID], [CREATION_DATE], [FAVORITES_COUNT], [LANGUAGE], [LATITUDE], [LONGITUDE], [TEXT], [TWEET_ID], [USER_FOLLOWER_COUNT], [USER_ID], [USER_LISTED_COUNT], [USER_LOCATION], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(4 AS Numeric(19, 0)), CAST(N'2015-01-28 23:39:19.000' AS DateTime), 0, N'it', 0, 0, N'Colle, Berlusconi da Renzi. Guerini: si parte da Mattarella | Inquisitore http://t.co/CKfP5zh7Pj', CAST(560567828496277506 AS Numeric(28, 0)), 40, CAST(1066055040 AS Numeric(28, 0)), 2, N'Londra', CAST(1 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)))
INSERT [dbo].[TWEET] ([ID], [CREATION_DATE], [FAVORITES_COUNT], [LANGUAGE], [LATITUDE], [LONGITUDE], [TEXT], [TWEET_ID], [USER_FOLLOWER_COUNT], [USER_ID], [USER_LISTED_COUNT], [USER_LOCATION], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(5 AS Numeric(19, 0)), CAST(N'2015-01-28 23:39:41.000' AS DateTime), 0, N'it', 0, 0, N'Quirinale, Renzi chiude su Mattarella. E congela il Nazareno ... http://t.co/rdFaaMvRR0', CAST(560567917549342720 AS Numeric(28, 0)), 2968, CAST(2289715063 AS Numeric(28, 0)), 7, N'', CAST(1 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)))
INSERT [dbo].[TWEET] ([ID], [CREATION_DATE], [FAVORITES_COUNT], [LANGUAGE], [LATITUDE], [LONGITUDE], [TEXT], [TWEET_ID], [USER_FOLLOWER_COUNT], [USER_ID], [USER_LISTED_COUNT], [USER_LOCATION], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(6 AS Numeric(19, 0)), CAST(N'2015-01-28 23:39:59.000' AS DateTime), 0, N'it', 0, 0, N'Quirinale, se il M5S si tura il naso e vota Prodi salta il patto Renzi-Berlusconi - Il Fatto... http://t.co/gjlNT43730', CAST(560567995110805504 AS Numeric(28, 0)), 140, CAST(985407582 AS Numeric(28, 0)), 1, N'Utrecht - Roma', CAST(1 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)))
INSERT [dbo].[TWEET] ([ID], [CREATION_DATE], [FAVORITES_COUNT], [LANGUAGE], [LATITUDE], [LONGITUDE], [TEXT], [TWEET_ID], [USER_FOLLOWER_COUNT], [USER_ID], [USER_LISTED_COUNT], [USER_LOCATION], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(7 AS Numeric(19, 0)), CAST(N'2015-01-28 23:40:03.000' AS DateTime), 0, N'it', 0, 0, N'Quirinale, se il M5S si tura il naso e vota Prodi salta il patto Renzi-Berlusconi - Il Fatto Quotidiano http://t.co/ObziMKPLoi', CAST(560568012986937345 AS Numeric(28, 0)), 17522, CAST(632742781 AS Numeric(28, 0)), 51, N'Roma', CAST(1 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)))
INSERT [dbo].[TWEET] ([ID], [CREATION_DATE], [FAVORITES_COUNT], [LANGUAGE], [LATITUDE], [LONGITUDE], [TEXT], [TWEET_ID], [USER_FOLLOWER_COUNT], [USER_ID], [USER_LISTED_COUNT], [USER_LOCATION], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(8 AS Numeric(19, 0)), CAST(N'2015-01-28 23:40:14.000' AS DateTime), 0, N'it', 0, 0, N'http://t.co/Lsjc4HTWED #news Braccio di ferro Renzi-Berlusconi Pd: nostro candidato e'' Mattarella… http://t.co/1FqgpxCUId', CAST(560568057018716160 AS Numeric(28, 0)), 1656, CAST(15750149 AS Numeric(28, 0)), 32, N'', CAST(1 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)))
INSERT [dbo].[TWEET] ([ID], [CREATION_DATE], [FAVORITES_COUNT], [LANGUAGE], [LATITUDE], [LONGITUDE], [TEXT], [TWEET_ID], [USER_FOLLOWER_COUNT], [USER_ID], [USER_LISTED_COUNT], [USER_LOCATION], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(9 AS Numeric(19, 0)), CAST(N'2015-01-28 23:40:27.000' AS DateTime), 0, N'it', 0, 0, N'21:12  Renzi sonda su Mattarella partita Quirinale e'' ancora aperta http://t.co/3SNHyYBWOG', CAST(560568113242992640 AS Numeric(28, 0)), 1194, CAST(234399248 AS Numeric(28, 0)), 34, N'Milano', CAST(1 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)))
INSERT [dbo].[TWEET] ([ID], [CREATION_DATE], [FAVORITES_COUNT], [LANGUAGE], [LATITUDE], [LONGITUDE], [TEXT], [TWEET_ID], [USER_FOLLOWER_COUNT], [USER_ID], [USER_LISTED_COUNT], [USER_LOCATION], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(10 AS Numeric(19, 0)), CAST(N'2015-01-28 23:40:45.000' AS DateTime), 0, N'it', 0, 0, N'@GP_ArieteRosso @fausto_cag non fa ombra a nessuno. Questo è il pregio. In questo momento un presidente forte farebbe crollare Renzi', CAST(560568189739098115 AS Numeric(28, 0)), 30, CAST(2964092691 AS Numeric(28, 0)), 0, N'', CAST(1 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)))
INSERT [dbo].[TWEET] ([ID], [CREATION_DATE], [FAVORITES_COUNT], [LANGUAGE], [LATITUDE], [LONGITUDE], [TEXT], [TWEET_ID], [USER_FOLLOWER_COUNT], [USER_ID], [USER_LISTED_COUNT], [USER_LOCATION], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(11 AS Numeric(19, 0)), CAST(N'2015-01-28 23:40:52.000' AS DateTime), 0, N'it', 0, 0, N'@jacopo_iacoboni fino all''ultimo spero  che Renzi  sparigli  e dica "Bonino"', CAST(560568218516197376 AS Numeric(28, 0)), 3, CAST(2305888924 AS Numeric(28, 0)), 0, N'', CAST(1 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)))
INSERT [dbo].[TWEET] ([ID], [CREATION_DATE], [FAVORITES_COUNT], [LANGUAGE], [LATITUDE], [LONGITUDE], [TEXT], [TWEET_ID], [USER_FOLLOWER_COUNT], [USER_ID], [USER_LISTED_COUNT], [USER_LOCATION], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(12 AS Numeric(19, 0)), CAST(N'2015-01-28 23:40:57.000' AS DateTime), 0, N'it', 45.441794, 9.214032, N'.@Virus1979C @PaolaDiCaro il primo pensiero di Renzi è tenere compatto il pd,e fa bene, memore dei drammi 2013.Il resto si trova,è poca roba', CAST(560568236270714881 AS Numeric(28, 0)), 950, CAST(782138334 AS Numeric(28, 0)), 7, N'Milano', CAST(1 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)))
INSERT [dbo].[TWEET] ([ID], [CREATION_DATE], [FAVORITES_COUNT], [LANGUAGE], [LATITUDE], [LONGITUDE], [TEXT], [TWEET_ID], [USER_FOLLOWER_COUNT], [USER_ID], [USER_LISTED_COUNT], [USER_LOCATION], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(13 AS Numeric(19, 0)), CAST(N'2015-01-28 23:40:59.000' AS DateTime), 0, N'it', 0, 0, N'Quirinale, Guerini: si parte e si arriva con Mattarrella
Giovedì prima votazione. Renzi vede Berlusconi e B... http://t.co/MOdojoXTUv', CAST(560568245480984576 AS Numeric(28, 0)), 151, CAST(1035916334 AS Numeric(28, 0)), 3, N'gf-Spettacolo', CAST(1 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)))
INSERT [dbo].[TWEET] ([ID], [CREATION_DATE], [FAVORITES_COUNT], [LANGUAGE], [LATITUDE], [LONGITUDE], [TEXT], [TWEET_ID], [USER_FOLLOWER_COUNT], [USER_ID], [USER_LISTED_COUNT], [USER_LOCATION], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(14 AS Numeric(19, 0)), CAST(N'2015-01-28 23:41:12.000' AS DateTime), 0, N'it', 0, 0, N'#News e #Astronomia Braccio di ferro Renzi-Berlusconi Si tratta sul nome di Mattarella - ... http://t.co/PZpzU5A9QV Buona visione !  :))', CAST(560568301114253323 AS Numeric(28, 0)), 51192, CAST(213451073 AS Numeric(28, 0)), 39, N'NB.NotFollow MINOR ItalyMarche', CAST(1 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)))
INSERT [dbo].[TWEET] ([ID], [CREATION_DATE], [FAVORITES_COUNT], [LANGUAGE], [LATITUDE], [LONGITUDE], [TEXT], [TWEET_ID], [USER_FOLLOWER_COUNT], [USER_ID], [USER_LISTED_COUNT], [USER_LOCATION], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(15 AS Numeric(19, 0)), CAST(N'2015-01-28 23:41:17.000' AS DateTime), 0, N'it', 0, 0, N'Matteo Salvini
 · 
Nel 2014 hanno chiuso 12.000 negozi e 450.000 artigiani.
Ma Renzi si preoccupa di legge... http://t.co/AML0c0qlVW', CAST(560568322451070977 AS Numeric(28, 0)), 23, CAST(1168824535 AS Numeric(28, 0)), 0, N'', CAST(1 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)))
INSERT [dbo].[TWEET] ([ID], [CREATION_DATE], [FAVORITES_COUNT], [LANGUAGE], [LATITUDE], [LONGITUDE], [TEXT], [TWEET_ID], [USER_FOLLOWER_COUNT], [USER_ID], [USER_LISTED_COUNT], [USER_LOCATION], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(16 AS Numeric(19, 0)), CAST(N'2015-01-28 23:41:22.000' AS DateTime), 0, N'it', 0, 0, N'Cmq la promessa di Renzi al suo insediamento "La politica nn si farà + coi retroscena" è andata bene ma nn benissimo #quirinale #mattarella', CAST(560568343728783360 AS Numeric(28, 0)), 350, CAST(37636708 AS Numeric(28, 0)), 2, N'', CAST(1 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)))
INSERT [dbo].[TWEET] ([ID], [CREATION_DATE], [FAVORITES_COUNT], [LANGUAGE], [LATITUDE], [LONGITUDE], [TEXT], [TWEET_ID], [USER_FOLLOWER_COUNT], [USER_ID], [USER_LISTED_COUNT], [USER_LOCATION], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(17 AS Numeric(19, 0)), CAST(N'2015-01-28 23:41:39.000' AS DateTime), 0, N'it', 0, 0, N'#Quirinale, consultazioni. Renzi: ''PUnto su Mattarella''''. Berlusconi resiste
Casini a Palazzo Chigi, Lega-Fdi per Feltri', CAST(560568413073211395 AS Numeric(28, 0)), 1206, CAST(71206981 AS Numeric(28, 0)), 2, N'Catania Italy', CAST(1 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)))
INSERT [dbo].[TWEET] ([ID], [CREATION_DATE], [FAVORITES_COUNT], [LANGUAGE], [LATITUDE], [LONGITUDE], [TEXT], [TWEET_ID], [USER_FOLLOWER_COUNT], [USER_ID], [USER_LISTED_COUNT], [USER_LOCATION], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(18 AS Numeric(19, 0)), CAST(N'2015-01-28 23:41:43.000' AS DateTime), 0, N'it', 0, 0, N'#Renzi e'' proprio fortunato: c''e'' sempre un evento che distoglie l''attenzione dell''opinione pubblica dai veri e gravi problemi dell''Italia.', CAST(560568430303383552 AS Numeric(28, 0)), 897, CAST(356284926 AS Numeric(28, 0)), 3, N'', CAST(1 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)))
INSERT [dbo].[TWEET] ([ID], [CREATION_DATE], [FAVORITES_COUNT], [LANGUAGE], [LATITUDE], [LONGITUDE], [TEXT], [TWEET_ID], [USER_FOLLOWER_COUNT], [USER_ID], [USER_LISTED_COUNT], [USER_LOCATION], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(19 AS Numeric(19, 0)), CAST(N'2015-01-28 23:41:48.000' AS DateTime), 0, N'it', 0, 0, N'@SalvaCostanzo @PaolaDiCaro è certo renzi ci tiene all''unità del Pd.. basta vedere ultime settimane.. da cofferati a legge eletorale..hahaha', CAST(560568453908930561 AS Numeric(28, 0)), 16773, CAST(332885533 AS Numeric(28, 0)), 78, N'Italia', CAST(1 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)))
INSERT [dbo].[TWEET] ([ID], [CREATION_DATE], [FAVORITES_COUNT], [LANGUAGE], [LATITUDE], [LONGITUDE], [TEXT], [TWEET_ID], [USER_FOLLOWER_COUNT], [USER_ID], [USER_LISTED_COUNT], [USER_LOCATION], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(20 AS Numeric(19, 0)), CAST(N'2015-01-28 23:42:01.000' AS DateTime), 0, N'it', 0, 0, N'#marioMTV G''inetto + @AndreaDipre  = Renzi? 
Tutti famosi...noi saremo... PUGNO DI POLLICE!', CAST(560568505582755841 AS Numeric(28, 0)), 55, CAST(2963043226 AS Numeric(28, 0)), 1, N'Milano', CAST(1 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)))
INSERT [dbo].[TWEET] ([ID], [CREATION_DATE], [FAVORITES_COUNT], [LANGUAGE], [LATITUDE], [LONGITUDE], [TEXT], [TWEET_ID], [USER_FOLLOWER_COUNT], [USER_ID], [USER_LISTED_COUNT], [USER_LOCATION], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(21 AS Numeric(19, 0)), CAST(N'2015-01-28 23:42:03.000' AS DateTime), 0, N'it', 0, 0, N'@SalvaCostanzo @PaolaDiCaro a renzi interessa solo renzi..', CAST(560568513346412544 AS Numeric(28, 0)), 16773, CAST(332885533 AS Numeric(28, 0)), 78, N'Italia', CAST(1 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)))
INSERT [dbo].[TWEET] ([ID], [CREATION_DATE], [FAVORITES_COUNT], [LANGUAGE], [LATITUDE], [LONGITUDE], [TEXT], [TWEET_ID], [USER_FOLLOWER_COUNT], [USER_ID], [USER_LISTED_COUNT], [USER_LOCATION], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(22 AS Numeric(19, 0)), CAST(N'2015-01-28 23:42:04.000' AS DateTime), 0, N'it', 0, 0, N'Quirinale, Renzi chiude su Mattarella. E congela il Nazareno: Berlusconi... http://t.co/EV2AhdUFB4 http://t.co/5oU9Kxi0hZ', CAST(560568519222251520 AS Numeric(28, 0)), 6725, CAST(2228506255 AS Numeric(28, 0)), 38, N'', CAST(1 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)))
INSERT [dbo].[TWEET] ([ID], [CREATION_DATE], [FAVORITES_COUNT], [LANGUAGE], [LATITUDE], [LONGITUDE], [TEXT], [TWEET_ID], [USER_FOLLOWER_COUNT], [USER_ID], [USER_LISTED_COUNT], [USER_LOCATION], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(23 AS Numeric(19, 0)), CAST(N'2015-01-28 23:42:26.000' AS DateTime), 0, N'it', 0, 0, N'Il 16 gennaio 2015 scrivevo:
"Renzi chi proporrà per il Quirinale ?
"Oscar lo sa ma nol dirà" (Verdi Un Ballo in... http://t.co/FJxfFJSEgT', CAST(560568612977926145 AS Numeric(28, 0)), 722, CAST(598494939 AS Numeric(28, 0)), 2, N'Roma', CAST(1 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)))
INSERT [dbo].[TWEET] ([ID], [CREATION_DATE], [FAVORITES_COUNT], [LANGUAGE], [LATITUDE], [LONGITUDE], [TEXT], [TWEET_ID], [USER_FOLLOWER_COUNT], [USER_ID], [USER_LISTED_COUNT], [USER_LOCATION], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(24 AS Numeric(19, 0)), CAST(N'2015-01-28 23:42:27.000' AS DateTime), 0, N'it', 41.840161, 13.044428, N'HAI ROTTO LE SPELOTAS M. RENZI TU CON TUTTA QUELLA MASNADA DI POLITICI PARLAMENTARI E SENATORI A VITA! PARASSITI..! http://t.co/Pq3jhllXnh', CAST(560568615091843073 AS Numeric(28, 0)), 431, CAST(2412507160 AS Numeric(28, 0)), 1, N'', CAST(1 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)))
INSERT [dbo].[TWEET] ([ID], [CREATION_DATE], [FAVORITES_COUNT], [LANGUAGE], [LATITUDE], [LONGITUDE], [TEXT], [TWEET_ID], [USER_FOLLOWER_COUNT], [USER_ID], [USER_LISTED_COUNT], [USER_LOCATION], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(25 AS Numeric(19, 0)), CAST(N'2015-01-28 23:42:34.000' AS DateTime), 0, N'it', 0, 0, N'#M5S propone #Prodi, il #Pd di #Renzi risponde #Mattarella. La politica non e'' una cosa seria', CAST(560568644816863233 AS Numeric(28, 0)), 4854, CAST(379290089 AS Numeric(28, 0)), 49, N'', CAST(1 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)))
INSERT [dbo].[TWEET] ([ID], [CREATION_DATE], [FAVORITES_COUNT], [LANGUAGE], [LATITUDE], [LONGITUDE], [TEXT], [TWEET_ID], [USER_FOLLOWER_COUNT], [USER_ID], [USER_LISTED_COUNT], [USER_LOCATION], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(26 AS Numeric(19, 0)), CAST(N'2015-01-28 23:42:51.000' AS DateTime), 0, N'it', 0, 0, N'renzi fai come il greco : da domani subito aumento retribuzioni di 300 euro mensili per dipendenti e 300 euro mensili per aumento pensioni', CAST(560568716451385344 AS Numeric(28, 0)), 9, CAST(1592478606 AS Numeric(28, 0)), 0, N'', CAST(1 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)))
INSERT [dbo].[TWEET] ([ID], [CREATION_DATE], [FAVORITES_COUNT], [LANGUAGE], [LATITUDE], [LONGITUDE], [TEXT], [TWEET_ID], [USER_FOLLOWER_COUNT], [USER_ID], [USER_LISTED_COUNT], [USER_LOCATION], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(27 AS Numeric(19, 0)), CAST(N'2015-01-28 23:43:08.000' AS DateTime), 0, N'it', 0, 0, N'Tsipras in soli 2 giorni taglia auto blu,privilegi,scorte,voli di stato e ministri.Ricordiamolo a Renzi! http://t.co/biEWw3C720', CAST(560568786575953920 AS Numeric(28, 0)), 1322, CAST(1260171894 AS Numeric(28, 0)), 5, N'', CAST(1 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)))
INSERT [dbo].[TWEET] ([ID], [CREATION_DATE], [FAVORITES_COUNT], [LANGUAGE], [LATITUDE], [LONGITUDE], [TEXT], [TWEET_ID], [USER_FOLLOWER_COUNT], [USER_ID], [USER_LISTED_COUNT], [USER_LOCATION], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(28 AS Numeric(19, 0)), CAST(N'2015-01-28 23:43:09.000' AS DateTime), 0, N'it', 0, 0, N'#Quirinale se il M5S si tura  il naso e vota Prodi salta il patto Renzi-Berlusconi #Quirinale, #se #il #M5S ... http://t.co/ZbnRa3hcf6', CAST(560568790162112514 AS Numeric(28, 0)), 4578, CAST(231726084 AS Numeric(28, 0)), 52, N'', CAST(1 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)))
INSERT [dbo].[TWEET] ([ID], [CREATION_DATE], [FAVORITES_COUNT], [LANGUAGE], [LATITUDE], [LONGITUDE], [TEXT], [TWEET_ID], [USER_FOLLOWER_COUNT], [USER_ID], [USER_LISTED_COUNT], [USER_LOCATION], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(29 AS Numeric(19, 0)), CAST(N'2015-01-28 23:43:28.000' AS DateTime), 0, N'it', 0, 0, N'Tsipras in soli 2 giorni taglia auto blu,privilegi,scorte,voli di stato e ministri.Ricordiamolo a Renzi! http://t.co/Z4n6G13hEA', CAST(560568872626311169 AS Numeric(28, 0)), 18253, CAST(270050737 AS Numeric(28, 0)), 47, N'', CAST(1 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)))
INSERT [dbo].[TWEET] ([ID], [CREATION_DATE], [FAVORITES_COUNT], [LANGUAGE], [LATITUDE], [LONGITUDE], [TEXT], [TWEET_ID], [USER_FOLLOWER_COUNT], [USER_ID], [USER_LISTED_COUNT], [USER_LOCATION], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(30 AS Numeric(19, 0)), CAST(N'2015-01-28 23:43:37.000' AS DateTime), 0, N'it', 0, 0, N'Titolo del Corsera di domani: La sfida di Renzi su Mattarella #GiorniDelColle', CAST(560568908642791424 AS Numeric(28, 0)), 5930, CAST(28382943 AS Numeric(28, 0)), 121, N'Rome', CAST(1 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)))
INSERT [dbo].[TWEET] ([ID], [CREATION_DATE], [FAVORITES_COUNT], [LANGUAGE], [LATITUDE], [LONGITUDE], [TEXT], [TWEET_ID], [USER_FOLLOWER_COUNT], [USER_ID], [USER_LISTED_COUNT], [USER_LOCATION], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(31 AS Numeric(19, 0)), CAST(N'2015-01-28 23:43:38.000' AS DateTime), 0, N'it', 0, 0, N'@albertograssi7 @antonellocapor2 ciao Matteo renzi', CAST(560568914955206656 AS Numeric(28, 0)), 1256, CAST(2864286299 AS Numeric(28, 0)), 4, N'Italia', CAST(1 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)))
INSERT [dbo].[TWEET] ([ID], [CREATION_DATE], [FAVORITES_COUNT], [LANGUAGE], [LATITUDE], [LONGITUDE], [TEXT], [TWEET_ID], [USER_FOLLOWER_COUNT], [USER_ID], [USER_LISTED_COUNT], [USER_LOCATION], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(32 AS Numeric(19, 0)), CAST(N'2015-01-28 23:43:42.000' AS DateTime), 0, N'it', 0, 0, N'#tgcomforpresident in Tv impazza il festival interpreta la mossa di Renzi. Impossibile trovare due opinionisti che la pensino uguale', CAST(560568929714995200 AS Numeric(28, 0)), 205, CAST(86921881 AS Numeric(28, 0)), 5, N'Rome', CAST(1 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)))
INSERT [dbo].[TWEET] ([ID], [CREATION_DATE], [FAVORITES_COUNT], [LANGUAGE], [LATITUDE], [LONGITUDE], [TEXT], [TWEET_ID], [USER_FOLLOWER_COUNT], [USER_ID], [USER_LISTED_COUNT], [USER_LOCATION], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(33 AS Numeric(19, 0)), CAST(N'2015-01-28 23:44:06.000' AS DateTime), 0, N'it', 0, 0, N'Quirinale, se il M5S si tura il naso e vota Prodi salta il patto Renzi-Berlusconi - Il Fatto #PresidenteM5S http://t.co/yrZOcsflyh', CAST(560569030231457792 AS Numeric(28, 0)), 167, CAST(346439957 AS Numeric(28, 0)), 1, N'Tarquinia', CAST(1 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)))
INSERT [dbo].[TWEET] ([ID], [CREATION_DATE], [FAVORITES_COUNT], [LANGUAGE], [LATITUDE], [LONGITUDE], [TEXT], [TWEET_ID], [USER_FOLLOWER_COUNT], [USER_ID], [USER_LISTED_COUNT], [USER_LOCATION], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(34 AS Numeric(19, 0)), CAST(N'2015-01-28 23:44:17.000' AS DateTime), 0, N'it', 0, 0, N'@antonio_bordin a questo #renzi non gli fanno nulla perché a differenza di #Corona , questo è protetto dalla legge.', CAST(560569077908135937 AS Numeric(28, 0)), 83, CAST(1630317788 AS Numeric(28, 0)), 2, N'london', CAST(1 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)))
INSERT [dbo].[TWEET] ([ID], [CREATION_DATE], [FAVORITES_COUNT], [LANGUAGE], [LATITUDE], [LONGITUDE], [TEXT], [TWEET_ID], [USER_FOLLOWER_COUNT], [USER_ID], [USER_LISTED_COUNT], [USER_LOCATION], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(35 AS Numeric(19, 0)), CAST(N'2015-01-28 23:44:31.000' AS DateTime), 0, N'it', 0, 0, N'Se è vero come sento che Renzi e Berlusconi si sono già accordati su Mattarella, vivranno giorni amari, visto il suo rigore di comportamento', CAST(560569134040481792 AS Numeric(28, 0)), 15, CAST(2278848858 AS Numeric(28, 0)), 0, N'Foggia', CAST(1 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)))
INSERT [dbo].[TWEET] ([ID], [CREATION_DATE], [FAVORITES_COUNT], [LANGUAGE], [LATITUDE], [LONGITUDE], [TEXT], [TWEET_ID], [USER_FOLLOWER_COUNT], [USER_ID], [USER_LISTED_COUNT], [USER_LOCATION], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(36 AS Numeric(19, 0)), CAST(N'2015-01-28 23:44:35.000' AS DateTime), 0, N'it', 0, 0, N'#Renzi chiude su #Mattarella: "Non funziona per il mio impasto".', CAST(560569151832719361 AS Numeric(28, 0)), 1084, CAST(46117559 AS Numeric(28, 0)), 10, N'san donato milanese', CAST(1 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)))
INSERT [dbo].[TWEET] ([ID], [CREATION_DATE], [FAVORITES_COUNT], [LANGUAGE], [LATITUDE], [LONGITUDE], [TEXT], [TWEET_ID], [USER_FOLLOWER_COUNT], [USER_ID], [USER_LISTED_COUNT], [USER_LOCATION], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(37 AS Numeric(19, 0)), CAST(N'2015-01-28 23:44:59.000' AS DateTime), 0, N'it', 0, 0, N'Quirinale, se il M5S si tura il naso e vota Prodi salta il patto Renzi-Berlusconi - Il Fatto Quotidiano http://t.co/dbrplbk6gh', CAST(560569254689640448 AS Numeric(28, 0)), 125, CAST(387357851 AS Numeric(28, 0)), 1, N'Roma', CAST(1 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)))
INSERT [dbo].[TWEET] ([ID], [CREATION_DATE], [FAVORITES_COUNT], [LANGUAGE], [LATITUDE], [LONGITUDE], [TEXT], [TWEET_ID], [USER_FOLLOWER_COUNT], [USER_ID], [USER_LISTED_COUNT], [USER_LOCATION], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(38 AS Numeric(19, 0)), CAST(N'2015-01-28 23:45:11.000' AS DateTime), 0, N'it', 0, 0, N'Io lo so che @petergomezblog ha ragione.....
ma votarlo è quasi impossibile.
#PresidenteM5S 
 http://t.co/ok06tVAq8B', CAST(560569303611998208 AS Numeric(28, 0)), 1116, CAST(50338513 AS Numeric(28, 0)), 9, N'', CAST(1 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)))
INSERT [dbo].[TWEET] ([ID], [CREATION_DATE], [FAVORITES_COUNT], [LANGUAGE], [LATITUDE], [LONGITUDE], [TEXT], [TWEET_ID], [USER_FOLLOWER_COUNT], [USER_ID], [USER_LISTED_COUNT], [USER_LOCATION], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(39 AS Numeric(19, 0)), CAST(N'2015-01-28 23:45:20.000' AS DateTime), 0, N'it', 0, 0, N'Quirinale, se il M5S si tura il naso e vota Prodi salta il patto Renzi-Berlusconi - Il Fatto Quotidiano http://t.co/IAjKtvuwaK', CAST(560569340635140096 AS Numeric(28, 0)), 78, CAST(912833226 AS Numeric(28, 0)), 1, N'', CAST(1 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)))
INSERT [dbo].[TWEET] ([ID], [CREATION_DATE], [FAVORITES_COUNT], [LANGUAGE], [LATITUDE], [LONGITUDE], [TEXT], [TWEET_ID], [USER_FOLLOWER_COUNT], [USER_ID], [USER_LISTED_COUNT], [USER_LOCATION], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(40 AS Numeric(19, 0)), CAST(N'2015-01-28 23:45:38.000' AS DateTime), 0, N'it', 0, 0, N'Quirinale, Renzi vede Berlusconi e avverte Forza Italia http://t.co/8xRvCKtgvK', CAST(560569415385616384 AS Numeric(28, 0)), 3892, CAST(1072454316 AS Numeric(28, 0)), 17, N'', CAST(1 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)))
INSERT [dbo].[TWEET] ([ID], [CREATION_DATE], [FAVORITES_COUNT], [LANGUAGE], [LATITUDE], [LONGITUDE], [TEXT], [TWEET_ID], [USER_FOLLOWER_COUNT], [USER_ID], [USER_LISTED_COUNT], [USER_LOCATION], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(41 AS Numeric(19, 0)), CAST(N'2015-01-28 23:45:38.000' AS DateTime), 0, N'it', 0, 0, N'Quirinale, Renzi vede Berlusconi e avverte Forza Italia http://t.co/iudQqwdvJ5', CAST(560569415821824000 AS Numeric(28, 0)), 27398, CAST(1728885823 AS Numeric(28, 0)), 100, N'', CAST(1 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)))
INSERT [dbo].[TWEET] ([ID], [CREATION_DATE], [FAVORITES_COUNT], [LANGUAGE], [LATITUDE], [LONGITUDE], [TEXT], [TWEET_ID], [USER_FOLLOWER_COUNT], [USER_ID], [USER_LISTED_COUNT], [USER_LOCATION], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(42 AS Numeric(19, 0)), CAST(N'2015-01-28 23:45:38.000' AS DateTime), 0, N'it', 0, 0, N'Quirinale, Renzi prosegue gli incontri: "Ancora non c''è il nome" http://t.co/uJDd9g5j8A', CAST(560569417373720576 AS Numeric(28, 0)), 3171, CAST(2236593169 AS Numeric(28, 0)), 10, N'', CAST(1 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)))
INSERT [dbo].[TWEET] ([ID], [CREATION_DATE], [FAVORITES_COUNT], [LANGUAGE], [LATITUDE], [LONGITUDE], [TEXT], [TWEET_ID], [USER_FOLLOWER_COUNT], [USER_ID], [USER_LISTED_COUNT], [USER_LOCATION], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(43 AS Numeric(19, 0)), CAST(N'2015-01-28 23:45:40.000' AS DateTime), 0, N'it', 0, 0, N'Titolo del Messaggero: Renzi va alla conta su Mattarella #GiorniDelColle', CAST(560569423657185280 AS Numeric(28, 0)), 5930, CAST(28382943 AS Numeric(28, 0)), 121, N'Rome', CAST(1 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)))
INSERT [dbo].[TWEET] ([ID], [CREATION_DATE], [FAVORITES_COUNT], [LANGUAGE], [LATITUDE], [LONGITUDE], [TEXT], [TWEET_ID], [USER_FOLLOWER_COUNT], [USER_ID], [USER_LISTED_COUNT], [USER_LOCATION], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(44 AS Numeric(19, 0)), CAST(N'2015-01-28 23:45:43.000' AS DateTime), 0, N'it', 0, 0, N'La nottata sta volgendo al peggio: #renzi sta frustando #Nardella per punirlo perché non ha ancora 50 anni. #quirinale #belloefake #PD', CAST(560569436068143104 AS Numeric(28, 0)), 22457, CAST(1566553698 AS Numeric(28, 0)), 218, N'', CAST(1 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)))
INSERT [dbo].[TWEET] ([ID], [CREATION_DATE], [FAVORITES_COUNT], [LANGUAGE], [LATITUDE], [LONGITUDE], [TEXT], [TWEET_ID], [USER_FOLLOWER_COUNT], [USER_ID], [USER_LISTED_COUNT], [USER_LOCATION], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(45 AS Numeric(19, 0)), CAST(N'2015-01-28 23:46:05.000' AS DateTime), 0, N'it', 0, 0, N'Renzi canticchia''Una splendida giornata'': Dopo incontro con Berlusconi e delegazione Pd a Palazzo Chigi http://t.co/MPdqFCS0qt', CAST(560569531085508608 AS Numeric(28, 0)), 38, CAST(2365783895 AS Numeric(28, 0)), 0, N'', CAST(1 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)))
INSERT [dbo].[TWEET] ([ID], [CREATION_DATE], [FAVORITES_COUNT], [LANGUAGE], [LATITUDE], [LONGITUDE], [TEXT], [TWEET_ID], [USER_FOLLOWER_COUNT], [USER_ID], [USER_LISTED_COUNT], [USER_LOCATION], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(46 AS Numeric(19, 0)), CAST(N'2015-01-28 23:46:06.000' AS DateTime), 0, N'it', 0, 0, N'Colle, il Pd: "Si parte e si arriva a Mattarella". Berlusconi-Renzi: "Niente intesa": Guerini ''investe'' ufficialmente il giudice cost...', CAST(560569533073612800 AS Numeric(28, 0)), 1371, CAST(521031427 AS Numeric(28, 0)), 12, N'', CAST(1 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)))
INSERT [dbo].[TWEET] ([ID], [CREATION_DATE], [FAVORITES_COUNT], [LANGUAGE], [LATITUDE], [LONGITUDE], [TEXT], [TWEET_ID], [USER_FOLLOWER_COUNT], [USER_ID], [USER_LISTED_COUNT], [USER_LOCATION], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(47 AS Numeric(19, 0)), CAST(N'2015-01-28 23:46:06.000' AS DateTime), 0, N'it', 0, 0, N'Colle, il Pd: "Si parte e si arriva a Mattarella". Berlusconi-Renzi: "Niente intesa": Guerini ''investe'' ufficialmente il giudice cost...', CAST(560569533719527425 AS Numeric(28, 0)), 1092, CAST(610246193 AS Numeric(28, 0)), 17, N'Republica Dominicana', CAST(1 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)))
INSERT [dbo].[TWEET] ([ID], [CREATION_DATE], [FAVORITES_COUNT], [LANGUAGE], [LATITUDE], [LONGITUDE], [TEXT], [TWEET_ID], [USER_FOLLOWER_COUNT], [USER_ID], [USER_LISTED_COUNT], [USER_LOCATION], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(48 AS Numeric(19, 0)), CAST(N'2015-01-28 23:46:09.000' AS DateTime), 0, N'it', 0, 0, N'Quirinale, Renzi insiste su Mattarella. Berlusconi: scheda bianca per i primi tre scrutinii: Forse già domani... … http://t.co/SArcetSwZB', CAST(560569546625802242 AS Numeric(28, 0)), 1069, CAST(223076186 AS Numeric(28, 0)), 18, N'London', CAST(1 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)))
INSERT [dbo].[TWEET] ([ID], [CREATION_DATE], [FAVORITES_COUNT], [LANGUAGE], [LATITUDE], [LONGITUDE], [TEXT], [TWEET_ID], [USER_FOLLOWER_COUNT], [USER_ID], [USER_LISTED_COUNT], [USER_LOCATION], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(49 AS Numeric(19, 0)), CAST(N'2015-01-28 23:46:10.000' AS DateTime), 0, N'it', 0, 0, N'Berlusconi: «Non c’è ancora un nome,: «Incontro interlocutorio» tra Renzi e l’ex Cav. Prima, il premier ha par... … http://t.co/u9xmikfayE', CAST(560569550077722624 AS Numeric(28, 0)), 1069, CAST(223076186 AS Numeric(28, 0)), 18, N'London', CAST(1 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)))
INSERT [dbo].[TWEET] ([ID], [CREATION_DATE], [FAVORITES_COUNT], [LANGUAGE], [LATITUDE], [LONGITUDE], [TEXT], [TWEET_ID], [USER_FOLLOWER_COUNT], [USER_ID], [USER_LISTED_COUNT], [USER_LOCATION], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(50 AS Numeric(19, 0)), CAST(N'2015-01-28 23:46:10.000' AS DateTime), 0, N'it', 0, 0, N'#notizie #politica Colle, svolta del Pd: "Si parte e si arriva a Mattarella". Berlusconi-Renzi: "Niente intesa... … http://t.co/TGn4HTzNHW', CAST(560569551642198016 AS Numeric(28, 0)), 1069, CAST(223076186 AS Numeric(28, 0)), 18, N'London', CAST(1 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)))
INSERT [dbo].[TWEET] ([ID], [CREATION_DATE], [FAVORITES_COUNT], [LANGUAGE], [LATITUDE], [LONGITUDE], [TEXT], [TWEET_ID], [USER_FOLLOWER_COUNT], [USER_ID], [USER_LISTED_COUNT], [USER_LOCATION], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(51 AS Numeric(19, 0)), CAST(N'2015-01-28 23:46:11.000' AS DateTime), 0, N'it', 0, 0, N'#notizie Colle, svolta del Pd: "Si parte e si arriva a Mattarella". Berlusconi-Renzi: "Niente intesa": Guerini... … http://t.co/emvhnbJr84', CAST(560569555006005248 AS Numeric(28, 0)), 1069, CAST(223076186 AS Numeric(28, 0)), 18, N'London', CAST(1 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)))
INSERT [dbo].[TWEET] ([ID], [CREATION_DATE], [FAVORITES_COUNT], [LANGUAGE], [LATITUDE], [LONGITUDE], [TEXT], [TWEET_ID], [USER_FOLLOWER_COUNT], [USER_ID], [USER_LISTED_COUNT], [USER_LOCATION], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(52 AS Numeric(19, 0)), CAST(N'2015-01-28 23:46:14.000' AS DateTime), 0, N'it', 0, 0, N'Quirinale, Renzi vede Berlusconi e avverte Forza Italia http://t.co/mBSXlfV3m6', CAST(560569567575932928 AS Numeric(28, 0)), 3612, CAST(2298351038 AS Numeric(28, 0)), 6, N'', CAST(1 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)))
INSERT [dbo].[TWEET] ([ID], [CREATION_DATE], [FAVORITES_COUNT], [LANGUAGE], [LATITUDE], [LONGITUDE], [TEXT], [TWEET_ID], [USER_FOLLOWER_COUNT], [USER_ID], [USER_LISTED_COUNT], [USER_LOCATION], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(53 AS Numeric(19, 0)), CAST(N'2015-01-28 23:46:14.000' AS DateTime), 0, N'it', 0, 0, N'#Quirinale #renzi vuole accelerare le votazioni. Nel week end deve andare a sciare, c''è un volo di Stato già sulla pista che lo aspetta..', CAST(560569568503291904 AS Numeric(28, 0)), 1593, CAST(539445034 AS Numeric(28, 0)), 15, N'', CAST(1 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)))
INSERT [dbo].[TWEET] ([ID], [CREATION_DATE], [FAVORITES_COUNT], [LANGUAGE], [LATITUDE], [LONGITUDE], [TEXT], [TWEET_ID], [USER_FOLLOWER_COUNT], [USER_ID], [USER_LISTED_COUNT], [USER_LOCATION], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(54 AS Numeric(19, 0)), CAST(N'2015-01-28 23:46:45.000' AS DateTime), 0, N'it', 0, 0, N'Quirinale, se il M5S vota Prodi salta il patto Renzi-Berlusconi - Il Fatto Quotidiano http://t.co/QlAcHLAPTn', CAST(560569698191147009 AS Numeric(28, 0)), 67, CAST(318549168 AS Numeric(28, 0)), 1, N'Firenze', CAST(1 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)))
INSERT [dbo].[TWEET] ([ID], [CREATION_DATE], [FAVORITES_COUNT], [LANGUAGE], [LATITUDE], [LONGITUDE], [TEXT], [TWEET_ID], [USER_FOLLOWER_COUNT], [USER_ID], [USER_LISTED_COUNT], [USER_LOCATION], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(55 AS Numeric(19, 0)), CAST(N'2015-01-28 23:46:55.000' AS DateTime), 0, N'it', 0, 0, N'Paola Taverna (M5S) frantuma Babbeo Renzi !!!: http://t.co/k4FMTq0n2u via @YouTube', CAST(560569740356489216 AS Numeric(28, 0)), 48, CAST(604489414 AS Numeric(28, 0)), 0, N'Offanengo(Cr) Italy', CAST(1 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)))
INSERT [dbo].[TWEET] ([ID], [CREATION_DATE], [FAVORITES_COUNT], [LANGUAGE], [LATITUDE], [LONGITUDE], [TEXT], [TWEET_ID], [USER_FOLLOWER_COUNT], [USER_ID], [USER_LISTED_COUNT], [USER_LOCATION], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(56 AS Numeric(19, 0)), CAST(N'2015-01-28 23:46:57.000' AS DateTime), 0, N'it', 0, 0, N'Braccio di ferro Renzi-Berlusconi Si tratta sul nome di Mattarella: (AGI) - Roma, 27 gen. - Un nome credib... http://t.co/d9DaudvneD #fb', CAST(560569747134115844 AS Numeric(28, 0)), 1425, CAST(58835568 AS Numeric(28, 0)), 30, N'', CAST(1 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)))
INSERT [dbo].[TWEET] ([ID], [CREATION_DATE], [FAVORITES_COUNT], [LANGUAGE], [LATITUDE], [LONGITUDE], [TEXT], [TWEET_ID], [USER_FOLLOWER_COUNT], [USER_ID], [USER_LISTED_COUNT], [USER_LOCATION], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(57 AS Numeric(19, 0)), CAST(N'2015-01-28 23:46:57.000' AS DateTime), 0, N'it', 0, 0, N'Qui Radio Londra: Braccio di ferro Renzi-Berlusconi Si tratta sul nome di Mattarella http://t.co/qE8jeu2BRI', CAST(560569748975403008 AS Numeric(28, 0)), 2534, CAST(1590686978 AS Numeric(28, 0)), 23, N'Europa centrale', CAST(1 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)))
INSERT [dbo].[TWEET] ([ID], [CREATION_DATE], [FAVORITES_COUNT], [LANGUAGE], [LATITUDE], [LONGITUDE], [TEXT], [TWEET_ID], [USER_FOLLOWER_COUNT], [USER_ID], [USER_LISTED_COUNT], [USER_LOCATION], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(58 AS Numeric(19, 0)), CAST(N'2015-01-28 23:47:03.000' AS DateTime), 0, N'it', 0, 0, N'@ItalianPolitics @nellina99 @MoniShantiRani @kickmyballs222 così hanno messo in sella Renzi e l''hanno obbligato ad alleanza con Berlusconi.', CAST(560569772459716608 AS Numeric(28, 0)), 1458, CAST(10438412 AS Numeric(28, 0)), 20, N'Italia', CAST(1 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)))
INSERT [dbo].[TWEET] ([ID], [CREATION_DATE], [FAVORITES_COUNT], [LANGUAGE], [LATITUDE], [LONGITUDE], [TEXT], [TWEET_ID], [USER_FOLLOWER_COUNT], [USER_ID], [USER_LISTED_COUNT], [USER_LOCATION], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(59 AS Numeric(19, 0)), CAST(N'2015-01-28 23:47:03.000' AS DateTime), 0, N'it', 0, 0, N'#portaaporta
Un nome a sorpresa che farebbe comodo a Renzi & Co. è Cassese, molto vicino ad Amato e Napolitano.', CAST(560569774716248065 AS Numeric(28, 0)), 3079, CAST(752010888 AS Numeric(28, 0)), 21, N'Angelo di notte e giorni bui', CAST(1 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)))
INSERT [dbo].[TWEET] ([ID], [CREATION_DATE], [FAVORITES_COUNT], [LANGUAGE], [LATITUDE], [LONGITUDE], [TEXT], [TWEET_ID], [USER_FOLLOWER_COUNT], [USER_ID], [USER_LISTED_COUNT], [USER_LOCATION], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(60 AS Numeric(19, 0)), CAST(N'2015-01-28 23:47:25.000' AS DateTime), 0, N'it', 0, 0, N'Braccio di ferro Renzi-Berlusconi Pd: nostro candidato e'' Mattarella… http://t.co/INbtjVx8Hu | http://t.co/m0NlbuTSzG #news', CAST(560569867406163968 AS Numeric(28, 0)), 660, CAST(1270391083 AS Numeric(28, 0)), 34, N'', CAST(1 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)))
INSERT [dbo].[TWEET] ([ID], [CREATION_DATE], [FAVORITES_COUNT], [LANGUAGE], [LATITUDE], [LONGITUDE], [TEXT], [TWEET_ID], [USER_FOLLOWER_COUNT], [USER_ID], [USER_LISTED_COUNT], [USER_LOCATION], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(61 AS Numeric(19, 0)), CAST(N'2015-01-28 23:47:26.000' AS DateTime), 0, N'it', 0, 0, N'@Corriereit infatti #Renzi per me è stronzo ! Continuo a tifare #Prodi #presidentedellarepubblica contro tutto e tutti! W @sinistraelib #SEL', CAST(560569869377490944 AS Numeric(28, 0)), 36, CAST(2219899278 AS Numeric(28, 0)), 0, N'', CAST(1 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)))
INSERT [dbo].[TWEET] ([ID], [CREATION_DATE], [FAVORITES_COUNT], [LANGUAGE], [LATITUDE], [LONGITUDE], [TEXT], [TWEET_ID], [USER_FOLLOWER_COUNT], [USER_ID], [USER_LISTED_COUNT], [USER_LOCATION], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(62 AS Numeric(19, 0)), CAST(N'2015-01-28 23:47:42.000' AS DateTime), 0, N'it', 0, 0, N'La raccolta dei Video di Matteo Renzi che parla inglese. http://t.co/dAQvSdwTbq #politica http://t.co/X2mrkgPzGA', CAST(560569938185056256 AS Numeric(28, 0)), 11082, CAST(14914257 AS Numeric(28, 0)), 91, N'Italia', CAST(1 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)))
INSERT [dbo].[TWEET] ([ID], [CREATION_DATE], [FAVORITES_COUNT], [LANGUAGE], [LATITUDE], [LONGITUDE], [TEXT], [TWEET_ID], [USER_FOLLOWER_COUNT], [USER_ID], [USER_LISTED_COUNT], [USER_LOCATION], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(63 AS Numeric(19, 0)), CAST(N'2015-01-28 23:48:33.000' AS DateTime), 0, N'it', 0, 0, N'@77darior anche un personaggio di fantasia, il vero candidato che piace a Renzi', CAST(560570150416826368 AS Numeric(28, 0)), 4854, CAST(379290089 AS Numeric(28, 0)), 49, N'', CAST(1 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)))
INSERT [dbo].[TWEET] ([ID], [CREATION_DATE], [FAVORITES_COUNT], [LANGUAGE], [LATITUDE], [LONGITUDE], [TEXT], [TWEET_ID], [USER_FOLLOWER_COUNT], [USER_ID], [USER_LISTED_COUNT], [USER_LOCATION], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(64 AS Numeric(19, 0)), CAST(N'2015-01-28 23:48:41.000' AS DateTime), 0, N'it', 0, 0, N'@FluidoGiallo È cmq una partita persa, quindi tanto vale appoggiare chi è più distante da Renzi.', CAST(560570184503943169 AS Numeric(28, 0)), 3079, CAST(752010888 AS Numeric(28, 0)), 21, N'Angelo di notte e giorni bui', CAST(1 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)))
INSERT [dbo].[TWEET] ([ID], [CREATION_DATE], [FAVORITES_COUNT], [LANGUAGE], [LATITUDE], [LONGITUDE], [TEXT], [TWEET_ID], [USER_FOLLOWER_COUNT], [USER_ID], [USER_LISTED_COUNT], [USER_LOCATION], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(65 AS Numeric(19, 0)), CAST(N'2015-01-28 23:48:49.000' AS DateTime), 0, N'it', 0, 0, N'A poche ore da primo voto non hanno nome condiviso.E Dago racconta che il veto su #Mattarella è di Renzi #Quirinale http://t.co/jODIidxLZy', CAST(560570216720371714 AS Numeric(28, 0)), 593, CAST(1092285722 AS Numeric(28, 0)), 1, N'', CAST(1 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)))
INSERT [dbo].[TWEET] ([ID], [CREATION_DATE], [FAVORITES_COUNT], [LANGUAGE], [LATITUDE], [LONGITUDE], [TEXT], [TWEET_ID], [USER_FOLLOWER_COUNT], [USER_ID], [USER_LISTED_COUNT], [USER_LOCATION], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(66 AS Numeric(19, 0)), CAST(N'2015-01-28 23:49:01.000' AS DateTime), 0, N'it', 0, 0, N'"#renzi:Facciamo di più:tagliamo direttamente 1/3 dei parlamentari.#lavoltabuona"e fu così ke rimise i tagliati fuori:b. e i senatori a vita', CAST(560570266393526272 AS Numeric(28, 0)), 216, CAST(956193150 AS Numeric(28, 0)), 2, N'', CAST(1 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)))
INSERT [dbo].[TWEET] ([ID], [CREATION_DATE], [FAVORITES_COUNT], [LANGUAGE], [LATITUDE], [LONGITUDE], [TEXT], [TWEET_ID], [USER_FOLLOWER_COUNT], [USER_ID], [USER_LISTED_COUNT], [USER_LOCATION], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(67 AS Numeric(19, 0)), CAST(N'2015-01-28 23:49:31.000' AS DateTime), 0, N'it', 0, 0, N'A #portaaporta sostengono che Renzi possa fa'' na cazzata. Vedi che novità', CAST(560570392642093056 AS Numeric(28, 0)), 211, CAST(2431805130 AS Numeric(28, 0)), 2, N'', CAST(1 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)))
INSERT [dbo].[TWEET] ([ID], [CREATION_DATE], [FAVORITES_COUNT], [LANGUAGE], [LATITUDE], [LONGITUDE], [TEXT], [TWEET_ID], [USER_FOLLOWER_COUNT], [USER_ID], [USER_LISTED_COUNT], [USER_LOCATION], [REQUEST_ID], [SOURCE_ID]) VALUES (CAST(68 AS Numeric(19, 0)), CAST(N'2015-01-28 23:49:39.000' AS DateTime), 0, N'it', 0, 0, N'Se #Renzi avesse senso dell''umorismo si presenterebbe domani gridando "Regà, il nostro candidato è Napolitano". #Quirinale #QuirinalParty', CAST(560570426112606209 AS Numeric(28, 0)), 133, CAST(109538704 AS Numeric(28, 0)), 2, N'', CAST(1 AS Numeric(19, 0)), CAST(1 AS Numeric(19, 0)))
SET IDENTITY_INSERT [dbo].[TWEET] OFF
SET IDENTITY_INSERT [dbo].[URL] ON 

INSERT [dbo].[URL] ([ID], [EXPANDED_URL], [TWEET_ID]) VALUES (CAST(1 AS Numeric(19, 0)), N'http://www.ilfattoquotidiano.it/2015/01/28/quirinale-se-m5s-si-tura-naso-vota-prodi-salta-patto-renzi-berlusconi/1379373/', CAST(1 AS Numeric(19, 0)))
INSERT [dbo].[URL] ([ID], [EXPANDED_URL], [TWEET_ID]) VALUES (CAST(2 AS Numeric(19, 0)), N'http://www.adnkronos.com/fatti/politica/2015/01/28/berlusconi-renzi-rispetti-spirito-nazareno-nome-condiviso_2wPq0jc1aJc9vdOhWoo52J.html', CAST(2 AS Numeric(19, 0)))
INSERT [dbo].[URL] ([ID], [EXPANDED_URL], [TWEET_ID]) VALUES (CAST(3 AS Numeric(19, 0)), N'http://fb.me/2TbxwxBmX', CAST(4 AS Numeric(19, 0)))
INSERT [dbo].[URL] ([ID], [EXPANDED_URL], [TWEET_ID]) VALUES (CAST(4 AS Numeric(19, 0)), N'http://zpzp.info/?url=http://dlvr.it/8HVP99', CAST(5 AS Numeric(19, 0)))
INSERT [dbo].[URL] ([ID], [EXPANDED_URL], [TWEET_ID]) VALUES (CAST(5 AS Numeric(19, 0)), N'http://fb.me/6rwrMR9ae', CAST(6 AS Numeric(19, 0)))
INSERT [dbo].[URL] ([ID], [EXPANDED_URL], [TWEET_ID]) VALUES (CAST(6 AS Numeric(19, 0)), N'http://www.ilfattoquotidiano.it/2015/01/28/quirinale-se-m5s-si-tura-naso-vota-prodi-salta-patto-renzi-berlusconi/1379373/', CAST(7 AS Numeric(19, 0)))
INSERT [dbo].[URL] ([ID], [EXPANDED_URL], [TWEET_ID]) VALUES (CAST(7 AS Numeric(19, 0)), N'http://goo.gl/fb/Wmtzyz', CAST(8 AS Numeric(19, 0)))
INSERT [dbo].[URL] ([ID], [EXPANDED_URL], [TWEET_ID]) VALUES (CAST(8 AS Numeric(19, 0)), N'http://it.beduac.de', CAST(8 AS Numeric(19, 0)))
INSERT [dbo].[URL] ([ID], [EXPANDED_URL], [TWEET_ID]) VALUES (CAST(9 AS Numeric(19, 0)), N'http://bit.ly/18vQeyj', CAST(9 AS Numeric(19, 0)))
INSERT [dbo].[URL] ([ID], [EXPANDED_URL], [TWEET_ID]) VALUES (CAST(10 AS Numeric(19, 0)), N'http://bit.ly/1ttk27M', CAST(13 AS Numeric(19, 0)))
INSERT [dbo].[URL] ([ID], [EXPANDED_URL], [TWEET_ID]) VALUES (CAST(11 AS Numeric(19, 0)), N'http://bit.ly/1ttk7Zm', CAST(14 AS Numeric(19, 0)))
INSERT [dbo].[URL] ([ID], [EXPANDED_URL], [TWEET_ID]) VALUES (CAST(12 AS Numeric(19, 0)), N'http://fb.me/3Mi6N5pcE', CAST(15 AS Numeric(19, 0)))
INSERT [dbo].[URL] ([ID], [EXPANDED_URL], [TWEET_ID]) VALUES (CAST(13 AS Numeric(19, 0)), N'http://j.mp/1BqCM5H', CAST(22 AS Numeric(19, 0)))
INSERT [dbo].[URL] ([ID], [EXPANDED_URL], [TWEET_ID]) VALUES (CAST(14 AS Numeric(19, 0)), N'http://fb.me/3vooHnZVy', CAST(23 AS Numeric(19, 0)))
INSERT [dbo].[URL] ([ID], [EXPANDED_URL], [TWEET_ID]) VALUES (CAST(15 AS Numeric(19, 0)), N'http://fb.me/1LqXYl5a0', CAST(27 AS Numeric(19, 0)))
INSERT [dbo].[URL] ([ID], [EXPANDED_URL], [TWEET_ID]) VALUES (CAST(16 AS Numeric(19, 0)), N'http://bit.ly/1Di0S54', CAST(28 AS Numeric(19, 0)))
INSERT [dbo].[URL] ([ID], [EXPANDED_URL], [TWEET_ID]) VALUES (CAST(17 AS Numeric(19, 0)), N'http://jedasupport.altervista.org/blog/politica/tsipras-in-2-giorni-spending-review/', CAST(29 AS Numeric(19, 0)))
INSERT [dbo].[URL] ([ID], [EXPANDED_URL], [TWEET_ID]) VALUES (CAST(18 AS Numeric(19, 0)), N'http://www.ilfattoquotidiano.it/2015/01/28/quirinale-se-m5s-si-tura-naso-vota-prodi-salta-patto-renzi-berlusconi/1379373/', CAST(33 AS Numeric(19, 0)))
INSERT [dbo].[URL] ([ID], [EXPANDED_URL], [TWEET_ID]) VALUES (CAST(19 AS Numeric(19, 0)), N'http://www.ilfattoquotidiano.it/2015/01/28/quirinale-se-m5s-si-tura-naso-vota-prodi-salta-patto-renzi-berlusconi/1379373/', CAST(37 AS Numeric(19, 0)))
INSERT [dbo].[URL] ([ID], [EXPANDED_URL], [TWEET_ID]) VALUES (CAST(20 AS Numeric(19, 0)), N'http://www.ilfattoquotidiano.it/2015/01/28/quirinale-se-m5s-si-tura-naso-vota-prodi-salta-patto-renzi-berlusconi/1379373/', CAST(38 AS Numeric(19, 0)))
INSERT [dbo].[URL] ([ID], [EXPANDED_URL], [TWEET_ID]) VALUES (CAST(21 AS Numeric(19, 0)), N'http://www.ilfattoquotidiano.it/2015/01/28/quirinale-se-m5s-si-tura-naso-vota-prodi-salta-patto-renzi-berlusconi/1379373/', CAST(39 AS Numeric(19, 0)))
INSERT [dbo].[URL] ([ID], [EXPANDED_URL], [TWEET_ID]) VALUES (CAST(22 AS Numeric(19, 0)), N'http://zpzp.info/?url=http://dlvr.it/8HVlBx', CAST(40 AS Numeric(19, 0)))
INSERT [dbo].[URL] ([ID], [EXPANDED_URL], [TWEET_ID]) VALUES (CAST(23 AS Numeric(19, 0)), N'http://zpzp.info/?url=http://dlvr.it/8HVfNT', CAST(41 AS Numeric(19, 0)))
INSERT [dbo].[URL] ([ID], [EXPANDED_URL], [TWEET_ID]) VALUES (CAST(24 AS Numeric(19, 0)), N'http://zpzp.info/?url=http://dlvr.it/8HVlLS', CAST(42 AS Numeric(19, 0)))
INSERT [dbo].[URL] ([ID], [EXPANDED_URL], [TWEET_ID]) VALUES (CAST(25 AS Numeric(19, 0)), N'http://dlvr.it/8HVh8y', CAST(45 AS Numeric(19, 0)))
INSERT [dbo].[URL] ([ID], [EXPANDED_URL], [TWEET_ID]) VALUES (CAST(26 AS Numeric(19, 0)), N'http://ift.tt/1uCy7uW', CAST(48 AS Numeric(19, 0)))
INSERT [dbo].[URL] ([ID], [EXPANDED_URL], [TWEET_ID]) VALUES (CAST(27 AS Numeric(19, 0)), N'http://ift.tt/1ttm6wD', CAST(49 AS Numeric(19, 0)))
INSERT [dbo].[URL] ([ID], [EXPANDED_URL], [TWEET_ID]) VALUES (CAST(28 AS Numeric(19, 0)), N'http://ift.tt/1ttm6wI', CAST(50 AS Numeric(19, 0)))
INSERT [dbo].[URL] ([ID], [EXPANDED_URL], [TWEET_ID]) VALUES (CAST(29 AS Numeric(19, 0)), N'http://ift.tt/1ttm6Nb', CAST(51 AS Numeric(19, 0)))
INSERT [dbo].[URL] ([ID], [EXPANDED_URL], [TWEET_ID]) VALUES (CAST(30 AS Numeric(19, 0)), N'http://zpzp.info/?url=http://dlvr.it/8HVlVT', CAST(52 AS Numeric(19, 0)))
INSERT [dbo].[URL] ([ID], [EXPANDED_URL], [TWEET_ID]) VALUES (CAST(31 AS Numeric(19, 0)), N'http://fb.me/3MuNYAWbw', CAST(54 AS Numeric(19, 0)))
INSERT [dbo].[URL] ([ID], [EXPANDED_URL], [TWEET_ID]) VALUES (CAST(32 AS Numeric(19, 0)), N'http://youtu.be/aQH50xppnP0', CAST(55 AS Numeric(19, 0)))
INSERT [dbo].[URL] ([ID], [EXPANDED_URL], [TWEET_ID]) VALUES (CAST(33 AS Numeric(19, 0)), N'http://bit.ly/1zC0KA6', CAST(56 AS Numeric(19, 0)))
INSERT [dbo].[URL] ([ID], [EXPANDED_URL], [TWEET_ID]) VALUES (CAST(34 AS Numeric(19, 0)), N'http://bit.ly/1zdzPr0', CAST(57 AS Numeric(19, 0)))
INSERT [dbo].[URL] ([ID], [EXPANDED_URL], [TWEET_ID]) VALUES (CAST(35 AS Numeric(19, 0)), N'http://goo.gl/fb/lJyW48', CAST(60 AS Numeric(19, 0)))
INSERT [dbo].[URL] ([ID], [EXPANDED_URL], [TWEET_ID]) VALUES (CAST(36 AS Numeric(19, 0)), N'http://it.beduac.de', CAST(60 AS Numeric(19, 0)))
INSERT [dbo].[URL] ([ID], [EXPANDED_URL], [TWEET_ID]) VALUES (CAST(37 AS Numeric(19, 0)), N'http://www.diggita.it/v.php?id=1435545', CAST(62 AS Numeric(19, 0)))
INSERT [dbo].[URL] ([ID], [EXPANDED_URL], [TWEET_ID]) VALUES (CAST(38 AS Numeric(19, 0)), N'http://www.dagospia.com/rubrica-3/politica/renzi-fa-fuori-mattarella-rigorista-forcaiolo-depresso-bocciato-93385.htm', CAST(65 AS Numeric(19, 0)))
SET IDENTITY_INSERT [dbo].[URL] OFF
ALTER TABLE [dbo].[FACEBOOK_DATA]  WITH CHECK ADD  CONSTRAINT [FACEBOOK_DATASOURCE_ID] FOREIGN KEY([SOURCE_ID])
REFERENCES [dbo].[SOURCE] ([ID])
GO
ALTER TABLE [dbo].[FACEBOOK_DATA] CHECK CONSTRAINT [FACEBOOK_DATASOURCE_ID]
GO
ALTER TABLE [dbo].[FACEBOOK_DATA]  WITH CHECK ADD  CONSTRAINT [FACEBOOKDATAREQUEST_ID] FOREIGN KEY([REQUEST_ID])
REFERENCES [dbo].[REQUEST] ([ID])
GO
ALTER TABLE [dbo].[FACEBOOK_DATA] CHECK CONSTRAINT [FACEBOOKDATAREQUEST_ID]
GO
ALTER TABLE [dbo].[HASHTAG]  WITH CHECK ADD  CONSTRAINT [FK_HASHTAG_TWEET_ID] FOREIGN KEY([TWEET_ID])
REFERENCES [dbo].[TWEET] ([ID])
GO
ALTER TABLE [dbo].[HASHTAG] CHECK CONSTRAINT [FK_HASHTAG_TWEET_ID]
GO
ALTER TABLE [dbo].[MEDIA]  WITH CHECK ADD  CONSTRAINT [FK_MEDIA_TWEET_ID] FOREIGN KEY([TWEET_ID])
REFERENCES [dbo].[TWEET] ([ID])
GO
ALTER TABLE [dbo].[MEDIA] CHECK CONSTRAINT [FK_MEDIA_TWEET_ID]
GO
ALTER TABLE [dbo].[SOURCES_REQUEST]  WITH CHECK ADD  CONSTRAINT [SOURCESREQUESTSOURCEID] FOREIGN KEY([SOURCE_ID])
REFERENCES [dbo].[SOURCE] ([ID])
GO
ALTER TABLE [dbo].[SOURCES_REQUEST] CHECK CONSTRAINT [SOURCESREQUESTSOURCEID]
GO
ALTER TABLE [dbo].[SOURCES_REQUEST]  WITH CHECK ADD  CONSTRAINT [SURCESREQUESTREQUESTID] FOREIGN KEY([REQUEST_ID])
REFERENCES [dbo].[REQUEST] ([ID])
GO
ALTER TABLE [dbo].[SOURCES_REQUEST] CHECK CONSTRAINT [SURCESREQUESTREQUESTID]
GO
ALTER TABLE [dbo].[TWEET]  WITH CHECK ADD  CONSTRAINT [FK_TWEET_REQUEST_ID] FOREIGN KEY([REQUEST_ID])
REFERENCES [dbo].[REQUEST] ([ID])
GO
ALTER TABLE [dbo].[TWEET] CHECK CONSTRAINT [FK_TWEET_REQUEST_ID]
GO
ALTER TABLE [dbo].[TWEET]  WITH CHECK ADD  CONSTRAINT [FK_TWEET_SOURCE_ID] FOREIGN KEY([SOURCE_ID])
REFERENCES [dbo].[SOURCE] ([ID])
GO
ALTER TABLE [dbo].[TWEET] CHECK CONSTRAINT [FK_TWEET_SOURCE_ID]
GO
ALTER TABLE [dbo].[URL]  WITH CHECK ADD  CONSTRAINT [FK_URL_TWEET_ID] FOREIGN KEY([TWEET_ID])
REFERENCES [dbo].[TWEET] ([ID])
GO
ALTER TABLE [dbo].[URL] CHECK CONSTRAINT [FK_URL_TWEET_ID]
GO
USE [master]
GO
ALTER DATABASE [TvPad2-dev] SET  READ_WRITE 
GO
