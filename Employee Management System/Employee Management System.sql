USE [master]
GO
/****** Object:  Database [Database_Task]    Script Date: 12/17/2024 10:28:56 PM ******/
CREATE DATABASE [Database_Task]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Database_Task', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\Database_Task.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Database_Task_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL16.SQLEXPRESS\MSSQL\DATA\Database_Task_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT, LEDGER = OFF
GO
ALTER DATABASE [Database_Task] SET COMPATIBILITY_LEVEL = 160
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Database_Task].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Database_Task] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Database_Task] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Database_Task] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Database_Task] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Database_Task] SET ARITHABORT OFF 
GO
ALTER DATABASE [Database_Task] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [Database_Task] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Database_Task] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Database_Task] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Database_Task] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Database_Task] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Database_Task] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Database_Task] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Database_Task] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Database_Task] SET  ENABLE_BROKER 
GO
ALTER DATABASE [Database_Task] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Database_Task] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Database_Task] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Database_Task] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Database_Task] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Database_Task] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Database_Task] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Database_Task] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Database_Task] SET  MULTI_USER 
GO
ALTER DATABASE [Database_Task] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Database_Task] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Database_Task] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Database_Task] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Database_Task] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Database_Task] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Database_Task] SET QUERY_STORE = ON
GO
ALTER DATABASE [Database_Task] SET QUERY_STORE (OPERATION_MODE = READ_WRITE, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30), DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_STORAGE_SIZE_MB = 1000, QUERY_CAPTURE_MODE = AUTO, SIZE_BASED_CLEANUP_MODE = AUTO, MAX_PLANS_PER_QUERY = 200, WAIT_STATS_CAPTURE_MODE = ON)
GO
USE [Database_Task]
GO
/****** Object:  Table [dbo].[Departments]    Script Date: 12/17/2024 10:28:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Departments](
	[DepartmentID] [int] NOT NULL,
	[DepartmentName] [varchar](100) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[DepartmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Employees]    Script Date: 12/17/2024 10:28:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Employees](
	[EmployeeID] [int] NOT NULL,
	[Name] [varchar](100) NOT NULL,
	[DepartmentID] [int] NULL,
	[HireDate] [date] NULL,
PRIMARY KEY CLUSTERED 
(
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Salaries]    Script Date: 12/17/2024 10:28:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Salaries](
	[EmployeeID] [int] NOT NULL,
	[BaseSalary] [decimal](10, 2) NULL,
	[Bonus] [decimal](10, 2) NULL,
	[Deductions] [decimal](10, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[EmployeeID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[EmployeeSalaryView]    Script Date: 12/17/2024 10:28:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- EmployeeSalaryView
CREATE VIEW [dbo].[EmployeeSalaryView] AS
SELECT 
    E.EmployeeID, 
    E.Name, 
    D.DepartmentName, 
    S.BaseSalary, 
    S.Bonus, 
    S.Deductions, 
    (S.BaseSalary + S.Bonus - S.Deductions) AS NetSalary
FROM Employees E
JOIN Departments D ON E.DepartmentID = D.DepartmentID
JOIN Salaries S ON E.EmployeeID = S.EmployeeID;
GO
/****** Object:  View [dbo].[HighEarnerView]    Script Date: 12/17/2024 10:28:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[HighEarnerView] AS
SELECT 
    E.EmployeeID, 
    E.Name, 
    D.DepartmentName, 
    (S.BaseSalary + S.Bonus - S.Deductions) AS NetSalary
FROM Employees E
JOIN Departments D ON E.DepartmentID = D.DepartmentID
JOIN Salaries S ON E.EmployeeID = S.EmployeeID
WHERE (S.BaseSalary + S.Bonus - S.Deductions) > 50000;
GO
/****** Object:  Table [dbo].[SalaryHistory]    Script Date: 12/17/2024 10:28:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SalaryHistory](
	[HistoryID] [int] IDENTITY(1,1) NOT NULL,
	[EmployeeID] [int] NULL,
	[UpdateDate] [datetime] NULL,
	[BaseSalary] [decimal](10, 2) NULL,
	[Bonus] [decimal](10, 2) NULL,
	[Deductions] [decimal](10, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[HistoryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Employees]  WITH CHECK ADD FOREIGN KEY([DepartmentID])
REFERENCES [dbo].[Departments] ([DepartmentID])
GO
ALTER TABLE [dbo].[Salaries]  WITH CHECK ADD FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employees] ([EmployeeID])
GO
ALTER TABLE [dbo].[SalaryHistory]  WITH CHECK ADD FOREIGN KEY([EmployeeID])
REFERENCES [dbo].[Employees] ([EmployeeID])
GO
/****** Object:  StoredProcedure [dbo].[AddEmployee]    Script Date: 12/17/2024 10:28:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddEmployee] (
    @EmployeeID INT,
    @Name VARCHAR(100),
    @DepartmentID INT,
    @HireDate DATE
)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Departments WHERE DepartmentID = @DepartmentID)
    BEGIN
        INSERT INTO Employees (EmployeeID, Name, DepartmentID, HireDate)
        VALUES (@EmployeeID, @Name, @DepartmentID, @HireDate);
    END
    ELSE
    BEGIN
        THROW 50000, 'Invalid DepartmentID.', 1;
    END
END;
GO
/****** Object:  StoredProcedure [dbo].[CalculatePayroll]    Script Date: 12/17/2024 10:28:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- Calculate Payroll
CREATE PROCEDURE [dbo].[CalculatePayroll] (
    @DepartmentID INT = NULL
)
AS
BEGIN
    IF @DepartmentID IS NULL
    BEGIN
        SELECT SUM(BaseSalary + Bonus - Deductions) AS TotalPayroll
        FROM Salaries;
    END
    ELSE
    BEGIN
        SELECT SUM(BaseSalary + Bonus - Deductions) AS TotalPayroll
        FROM Salaries S
        JOIN Employees E ON S.EmployeeID = E.EmployeeID
        WHERE E.DepartmentID = @DepartmentID;
    END
END;
GO
/****** Object:  StoredProcedure [dbo].[UpdateSalary]    Script Date: 12/17/2024 10:28:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateSalary] (
    @EmployeeID INT,
    @BaseSalary DECIMAL(10, 2),
    @Bonus DECIMAL(10, 2),
    @Deductions DECIMAL(10, 2)
)
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Salaries WHERE EmployeeID = @EmployeeID)
    BEGIN
        UPDATE Salaries
        SET BaseSalary = @BaseSalary, Bonus = @Bonus, Deductions = @Deductions
        WHERE EmployeeID = @EmployeeID;

        INSERT INTO SalaryHistory (EmployeeID, UpdateDate, BaseSalary, Bonus, Deductions)
        VALUES (@EmployeeID, GETDATE(), @BaseSalary, @Bonus, @Deductions);
    END
    ELSE
    BEGIN
        THROW 50000, 'Employee does not exist.', 1;
    END
END;
GO
USE [master]
GO
ALTER DATABASE [Database_Task] SET  READ_WRITE 
GO
