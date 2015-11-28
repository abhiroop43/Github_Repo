USE [master]
GO
/****** Object:  Database [GCAAFMS]    Script Date: 11/22/2015 11:37:59 AM ******/
CREATE DATABASE [GCAAFMS]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'GCAAFMS', FILENAME = N'D:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\GCAAFMS.mdf' , SIZE = 4096KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'GCAAFMS_log', FILENAME = N'D:\Program Files\Microsoft SQL Server\MSSQL11.MSSQLSERVER\MSSQL\DATA\GCAAFMS_log.ldf' , SIZE = 1024KB , MAXSIZE = 2048GB , FILEGROWTH = 10%)
GO
ALTER DATABASE [GCAAFMS] SET COMPATIBILITY_LEVEL = 110
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [GCAAFMS].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [GCAAFMS] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [GCAAFMS] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [GCAAFMS] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [GCAAFMS] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [GCAAFMS] SET ARITHABORT OFF 
GO
ALTER DATABASE [GCAAFMS] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [GCAAFMS] SET AUTO_CREATE_STATISTICS ON 
GO
ALTER DATABASE [GCAAFMS] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [GCAAFMS] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [GCAAFMS] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [GCAAFMS] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [GCAAFMS] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [GCAAFMS] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [GCAAFMS] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [GCAAFMS] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [GCAAFMS] SET  DISABLE_BROKER 
GO
ALTER DATABASE [GCAAFMS] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [GCAAFMS] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [GCAAFMS] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [GCAAFMS] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [GCAAFMS] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [GCAAFMS] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [GCAAFMS] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [GCAAFMS] SET RECOVERY FULL 
GO
ALTER DATABASE [GCAAFMS] SET  MULTI_USER 
GO
ALTER DATABASE [GCAAFMS] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [GCAAFMS] SET DB_CHAINING OFF 
GO
ALTER DATABASE [GCAAFMS] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [GCAAFMS] SET TARGET_RECOVERY_TIME = 0 SECONDS 
GO
USE [GCAAFMS]
GO
/****** Object:  StoredProcedure [dbo].[GCAA_VM_SAVEMASTERRECORD]    Script Date: 11/22/2015 11:37:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE Procedure [dbo].[GCAA_VM_SAVEMASTERRECORD]
	@DocumentID				varchar(50) ,
	@ChasisNumber				varchar(50) ,
	@Color					varchar(50) ,
	@Make						varchar(50) ,
	@Name						varchar(150) ,
	@ODOMeter					numeric(18, 0) ,
	@OilChangeDate			date ,
	@RegistrationExpiryDate	 date ,
	@RegistrationNumber		 varchar(50) ,
	@SalikAccountNumber		varchar(100) ,
	@TyreChangeDate			date ,
	@InsuranceCompany			varchar(100) ,
	@InsurancePolicyNumber	varchar(50) ,
	@EngineNumber				varchar(50) ,
	@LastServiceDate			date ,
	@Availability				varchar(50) ,
	@Model					varchar(50),
	@Location					varchar(100),
	 @CreatedBy					varchar(50),
	 @CreatedDate date,
	 @InsuranceExpiryDate	date
AS
INSERT INTO [dbo].[GCAAD0210100]
           (
		   [DocumentID]
           ,[ChasisNumber]
           ,[Color]
           ,[Make]
           ,[Name]
           ,[ODOMeter]
           ,[OilChangeDate]
           ,[RegistrationExpiryDate]
           ,[RegistrationNumber]
           ,[SalikAccountNumber]
           ,[TyreChangeDate]
           ,[InsuranceCompany]
           ,[InsurancePolicyNumber]
           ,[EngineNumber]
           ,[LastServiceDate]
           ,[Availability]
           ,[Model]
		   ,CreatedBy
		   ,CreatedDate
		   ,InsuranceExpiryDate
		   ,Location
		   )
     VALUES
            (
			@DocumentID
           ,@ChasisNumber
           ,@Color
           ,@Make
           ,@Name
           ,@ODOMeter
           ,@OilChangeDate
           ,@RegistrationExpiryDate
           ,@RegistrationNumber
           ,@SalikAccountNumber
           ,@TyreChangeDate
           ,@InsuranceCompany
           ,@InsurancePolicyNumber
           ,@EngineNumber
           ,@LastServiceDate
           ,@Availability
           ,@Model
		   ,@CreatedBy
		   ,@CreatedDate
		   ,@InsuranceExpiryDate
		   ,@Location
		   )






GO
/****** Object:  StoredProcedure [dbo].[GCAA_VM_UPDATEMASTERRECORD]    Script Date: 11/22/2015 11:37:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE Procedure [dbo].[GCAA_VM_UPDATEMASTERRECORD]
	@DocumentID				varchar(50) ,
	@ChasisNumber				varchar(50) ,
	@Color					varchar(50) ,
	@Make						varchar(50) ,
	@Name						varchar(150) ,
	@ODOMeter					numeric(18, 0) ,
	@OilChangeDate			date ,
	@RegistrationExpiryDate	 date ,
	@RegistrationNumber		 varchar(50) ,
	@SalikAccountNumber		varchar(100) ,
	@TyreChangeDate			date ,
	@InsuranceCompany			varchar(100) ,
	@InsurancePolicyNumber	varchar(50) ,
	@EngineNumber				varchar(50) ,
	@LastServiceDate			date ,
	@Availability				varchar(50) ,
	@Model					varchar(50),
	@Location	varchar(50),
	 @CreatedBy					varchar(50),
	 @CreatedDate date,
	 @InsuranceExpiryDate date
AS
UPDATE GCAAD0210100 SET 


           [ChasisNumber] = @ChasisNumber
           ,[Color] = @Color
           ,[Make] =@Make
           ,[Name]=@Name
           ,[ODOMeter]=@ODOMeter
           ,[OilChangeDate]=@OilChangeDate
           ,[RegistrationExpiryDate]=@RegistrationExpiryDate
           ,[RegistrationNumber]=@RegistrationNumber
           ,[SalikAccountNumber]=@SalikAccountNumber
           ,[TyreChangeDate]=@TyreChangeDate
           ,[InsuranceCompany]=@InsuranceCompany
           ,[InsurancePolicyNumber]=@InsurancePolicyNumber
           ,[EngineNumber]=@EngineNumber
           ,[LastServiceDate]=@LastServiceDate
           ,[Availability]=@Availability
           ,[Model]=@Model
		   ,Location=@Location
		   ,InsuranceExpiryDate=@InsuranceExpiryDate

		   WHERE 		   [DocumentID] = @DocumentID


select * from GCAAD0210100

GO
/****** Object:  StoredProcedure [dbo].[GCAA_VR_SAVEMASTERRECORD]    Script Date: 11/22/2015 11:37:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE Procedure [dbo].[GCAA_VR_SAVEMASTERRECORD]
@UserId varchar(50),
@DocumentID  varchar(50),
@DocumentDate  datetime,
@EmployID varchar(50),
@DisplayName  varchar(150),
@Email  varchar(150),
@DivisionCode  varchar(50),
@DepartmentCode  varchar(50),
@MobilePhone  varchar(50),
@VehicleNo  varchar(50),
@From varchar(50),
@To varchar(50),
--@Subject varchar(200),
--@PickupLocation varchar(50),
@DepartureDate date,
@ReturnDate date,
--@SelectedVehcileID varchar(50),
--@SLA_IN_DAYS int,
@TripType  varchar(50),
@Driver varchar(50),
@CreatedBy  varchar(75),
@CreatedDate  varchar(75),
@Comments varchar(75),
@LineManagerEmail varchar(50),
@ApprovalPass varchar(50),
@RejectPass varchar(50),
@Location varchar(50),
@LineManagerName varchar(150),
@DepartureHour varchar(150),
@DepartureMinutes varchar(150),
@ReturnHour varchar(150),
@ReturnMinutes varchar(150)
AS
INSERT INTO [GCAAD0210101]
           (DocumentID,                                          UserId,                                             Date,
		                                           EMPLOYID ,                                          DisplayName, 
												   												   EMail ,                                                                                                                                        
	Division_Code   ,
Department_Code ,
MobilePhone,
SelectedVehicleID,
GoingFrom ,
GoingTo,
Subject ,
PickupLocation,
DepartureDate ,
ReturnDate ,
SLA_IN_DAYS ,
TripType,
DriverRequired ,
CreatedBy  ,
CreatedDate  ,
Comments ,
LineManagerEmail,ApprovalPass,RejectPass,LineManagerName,Location,
DepartureHour,
DepartureMinutes,
ReturnHour ,
ReturnMinutes
)
     VALUES
           (@DocumentID
           ,@UserId
           ,@DocumentDate
           ,@EmployID
           ,@DisplayName
           ,@Email
           ,@DivisionCode
           ,@DepartmentCode
           ,@MobilePhone
           ,@VehicleNo,
@From ,
@To ,
'.' ,
'.',
@DepartureDate ,
@ReturnDate ,
0,
@TripType  ,
@Driver,
@CreatedBy  ,
@CreatedDate,
@Comments ,
		   @LineManagerEmail,
		   @ApprovalPass,@RejectPass,@LineManagerName
		   ,@Location
		    ,@DepartureHour,
			@DepartureMinutes,
			@ReturnHour ,
			@ReturnMinutes
		   )




GO
/****** Object:  StoredProcedure [dbo].[GCAA_VT_SAVEMASTERRECORD]    Script Date: 11/22/2015 11:37:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE Procedure [dbo].[GCAA_VT_SAVEMASTERRECORD]
@UserId varchar(50),
@DocumentID varchar(50),
@Date  date,
@EmployID varchar(50),
@DisplayName  varchar(150),
@Email  varchar(150),
@DivisionCode  varchar(50),
@DepartmentCode  varchar(50),
@MobilePhone  varchar(50),
@SLA_In_Days int,
@CreatedBy  varchar(75),
@CreatedDate  date,
@LineManagerEmail varchar(50),
@LineManagerName varchar(50),
@ApprovalPass varchar(50),
@RejectPass varchar(50),
@Location  varchar(50),
@Remarks  varchar(150),
@ServiceDate  date


AS
INSERT INTO [GCAAD0710100]
           (DocumentID,                                          UserId,                                             Date,
		                                           EMPLOYID ,                                          DisplayName, 
												   												   EMail ,                                                                                                                                        
	Division_Code   ,
Department_Code ,
MobilePhone,
SLA_In_Days,
Location  ,
Remarks  ,
ServiceDate  ,
LineManagerEmail,ApprovalPass,RejectPass,LineManagerName,CreatedBy,CreatedDate
)
     VALUES
           (@DocumentID
           ,@UserId
           ,@Date
           ,@EmployID
           ,@DisplayName
           ,@Email
           ,@DivisionCode
           ,@DepartmentCode
           ,@MobilePhone,
           @SLA_IN_DAYS,
@Location  ,
@Remarks  ,
@ServiceDate  ,

		   @LineManagerEmail,
		   @ApprovalPass,@RejectPass,@LineManagerName,@CreatedBy,@CreatedDate
		   )





GO
/****** Object:  StoredProcedure [dbo].[GCAA_VT_SAVEUSERRECORDS]    Script Date: 11/22/2015 11:37:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




CREATE Procedure [dbo].[GCAA_VT_SAVEUSERRECORDS]
@DocumentId varchar(50),
@UserId varchar(50),
@DivisionCode varchar(50),
@DepartmentCode varchar(50),
@VehicleID VarChar (50),
@RegistrationNumber VarChar (50),
@ServiceSerialNo Int,
@ServiceType VarChar (100),
@Model VarChar (50),
@Amount numeric(18,2),
@KM numeric(18,2)

AS
INSERT INTO GCAAD0710110
           (DocumentId,
		   Userid,
           Division_Code,
           Department_Code,
VehicleID ,
RegistrationNumber ,
ServiceSerialNo ,
ServiceType ,
Model ,
Amount ,
KM 
           )
     VALUES
           (@DocumentId,@Userid, @DivisionCode
           ,@DepartmentCode,
		   @VehicleID ,
@RegistrationNumber ,
@ServiceSerialNo ,
@ServiceType ,
@Model ,
@Amount ,
@KM 
		   )



GO
/****** Object:  StoredProcedure [dbo].[stpApproveDocumentWorkflow]    Script Date: 11/22/2015 11:37:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[stpApproveDocumentWorkflow]
@eServiceID		AS VARCHAR(30),
@WorkflowID		AS VARCHAR(100),
@DocumentNumber	AS VARCHAR(50),
@ActionBy		AS VARCHAR(50),
@Comments		AS VARCHAR(MAX),
@StepNumber		AS NUMERIC
AS

DECLARE @_StepNumber AS NUMERIC, 
        @_UserID AS VARCHAR(30), 
		@_RoleID AS VARCHAR(30), 
		@_DefaultValue AS VARCHAR(30), 
		@_ActionType AS VARCHAR(30),
		@docdate date,
@item varchar(50),
@item2 varchar(50),
@itemdescription varchar(100),
@itemdescription2 varchar(100),
@supplier varchar(50),
@SITEID varchar(50),
@UOM varchar(25),
@quantity int,
@unitcost numeric(18,2),
@extendedcost numeric(18,2),
@extendedcost2 numeric(18,2),
@dailyallowance numeric(18,2),
@AccountNumber varchar(50),
@ACTINDX int,
@BCHTOTAL numeric(18,2),
@BCHCOUNT int,
@SerialNo numeric(18,0),
@SerialNoDetail numeric(18,0),
@Account varchar(50),
@Debit numeric(18,0),
@Credit numeric(18,0),
--@ACTNDX int,
@Amount  numeric(18,0),
@Date date,
@REFERENCE varchar(32),
@Month int,
@Year int,
@SQNCLINE numeric(19,5)



declare @cn varchar(7)
declare @nm numeric(7)
declare @con varchar(7)
declare @len_ int
declare @updateddoc varchar(17)
declare @maxdoc varchar(17)
DECLARE @LOCATNID varchar(50)
DECLARE @LOCATION varchar(50)
DECLARE @currency varchar(50)
DECLARE @currencyindex int

DECLARE @DIV varchar(50)
DECLARE @DEP varchar(50)

DECLARE @BTN varchar(50)


DECLARE @DIVISIONCODE_I varchar(50)
DECLARE @DEPARTMENTCODE_I varchar(50)
DECLARE @POSITIONCODE_I varchar(50)
DECLARE @SUPERVISORCODE_I varchar(50)
DECLARE @STRTDATE DATE
DECLARE @ENDDATE DATE 
DECLARE @OPENINGDATE_I DATE

--SELECT 
--   @_StepNumber = StepNumber,
--   @_UserID = UserID,
--   @_RoleID = RoleID,
--   @_DefaultValue = DefaultValue,
--   @_ActionType = ActionType
--FROM GCAWF0010111
----WHERE WorkflowID = 'PR0101' AND eServiceID = 'PR01MaterialRequest' AND StepNumber = 2
--WHERE WorkflowID = @WorkflowID AND eServiceID = @eServiceID AND StepNumber = @StepNumber + 1


DECLARE @_ManagerLogin as Varchar(100),
		@_ProceedApproval as Bit,
		@_DivCode as Varchar(5),
		@_LineManagerisADG as bit,
		@_ActionTypeADG As Varchar(20)

SET @_LineManagerisADG = 0
SET @_ProceedApproval = 0

SELECT 
   @_StepNumber = StepNumber,
   @_UserID = UserID,
   @_RoleID = RoleID,
   @_DefaultValue = DefaultValue,
   @_ActionType = ActionType
FROM GCAWF0010111
--WHERE WorkflowID = 'PR0101' AND eServiceID = 'PR01MaterialRequest' AND StepNumber = 2
WHERE WorkflowID = @WorkflowID AND eServiceID = @eServiceID AND StepNumber = @StepNumber + 1

--print @_DefaultValue 
IF @_DefaultValue = 'Line Manager' 
BEGIN
	
	SELECT @_ManagerLogin = ManagerLogin FROM GCAA_ESS_ActiveDirectoryUsersList 
	WHERE LoginName IN (SELECT ActionBy FROM GCAWF0010120 
	                    WHERE WorkflowID = @WorkflowID AND eServiceID = @eServiceID AND StepNumber = @StepNumber  And DocumentNumber = @DocumentNumber)
						--print @_ManagerLogin
						--print @ActionBy
	IF @_ManagerLogin = @ActionBy
	BEGIN
		SET @_ProceedApproval = 1
	END
	ELSE
	BEGIN
	   IF LOWER(RTRIM(@_ManagerLogin)) = 'dg' AND LOWER(RTRIM(@ActionBy)) = 'omar'
		   BEGIN
			SET @_ProceedApproval = 1
		   END
	   ELSE
		   BEGIN 
			SET @_ProceedApproval = 0
		   END
	END

	--NEW CODE TO CHECK IF NEXT LEVEL IS ADG AND ADG IS SAME AS LINE MANAGER THAN PROCESS ADG APPROVAL AS WELL.

	SELECT @_ActionTypeADG = ISNULL(DefaultValue, '') FROM GCAWF0010111 WHERE WorkflowID = @WorkflowID AND eServiceID = @eServiceID AND StepNumber = @StepNumber + 2

	IF @_ActionTypeADG = 'ADG'
	BEGIN
		SELECT @_DivCode = GP_DIVCODE FROM GCAA_COMBINE_API_UPR00100 WHERE RTRIM(EMAIL) IN 
		(SELECT RTRIM(EmailAddress) FROM GCAA_ESS_ActiveDirectoryUsersList WHERE LoginName IN 
		(SELECT ActionBy FROM GCAWF0010120 WHERE WorkflowID = @WorkflowID AND eServiceID = @eServiceID AND StepNumber = 1  And DocumentNumber = @DocumentNumber))

		SELECT @_ActionTypeADG = UserId FROM GCAWF0010110 WHERE RoleID = 'ADG' + @_DivCode

		IF @_ActionTypeADG = @ActionBy
		BEGIN
			SET @_LineManagerisADG = 1
		END
		ELSE
		BEGIN
			SET @_LineManagerisADG = 0
		END
	END
END

IF @_DefaultValue = 'ADG' 
BEGIN
	SELECT @_DivCode = GP_DIVCODE FROM GCAA_COMBINE_API_UPR00100 WHERE RTRIM(EMAIL) IN 
	(SELECT RTRIM(EmailAddress) FROM GCAA_ESS_ActiveDirectoryUsersList WHERE LoginName IN 
	(SELECT ActionBy FROM GCAWF0010120 WHERE WorkflowID = @WorkflowID AND eServiceID = @eServiceID AND StepNumber = 1  And DocumentNumber = @DocumentNumber))

	SELECT @_ManagerLogin = UserId FROM GCAWF0010110 WHERE RoleID = 'ADG' + @_DivCode

	IF @_ManagerLogin = @ActionBy
	BEGIN
		SET @_ProceedApproval = 1
	END
	ELSE
	BEGIN
		SET @_ProceedApproval = 0
	END
END
IF @_RoleID <> '' 

--SELECT UserID FROM GCAWF0010110 WHERE RoleID = 'PC01' And UserID = 'mulkarim'

BEGIN
	SELECT @_ManagerLogin = UserID FROM GCAWF0010110 WHERE RoleID = @_RoleID And UserID = @ActionBy
	--PRINT @_ManagerLogin
	IF @_ManagerLogin IS NULL
	BEGIN
		SET @_ProceedApproval = 0
	END
	ELSE
	BEGIN
		SET @_ProceedApproval = 1
	END
END
--print 'count1'

-- ALWAYS PROCESS APPROVAL

--SET @_ProceedApproval = 1

If @_ProceedApproval = 1
Begin
--SELECT @_StepNumber, @_UserID, @_RoleID, @_DefaultValue, @_ActionType

		INSERT INTO GCAWF0010120 (eServiceID,WorkflowID,DocumentNumber,TransactionDate,StepNumber,UserID,
			   RoleID,OtherID,ActionBy,ActionDate,ActionTime,Comments,Action,AttachmentID,CreatedDate,
			   ApprovalPassword,RejectPassword)
		VALUES (@eServiceID, @WorkflowID, @DocumentNumber, GETDATE(), @_StepNumber, @_UserID, 
				@_RoleID, @_DefaultValue, @ActionBy, GETDATE(), CONVERT(VARCHAR(20), GETDATE(), 103),@Comments, @_ActionType, '.', GETDATE(), 0.9999999, 0.8888888  )

		IF @eServiceID = 'AD02Transport' AND @WorkflowID = 'VR0201'
		BEGIN
		  UPDATE GCAAD0210101 SET FinalStatus = @_ActionType WHERE DocumentID = @DocumentNumber
		END

		IF @eServiceID = 'AD07VehicleMaintenance' AND @WorkflowID = 'VT0701'
		BEGIN
		  UPDATE GCAAD0710100 SET FinalStatus = @_ActionType WHERE DocumentID = @DocumentNumber
		  -- code changes from here
		  -- if not admin user
		  IF (@_ActionType = 'Final Approval')
		--BEGIN cursor to be placed here
		--UPDATE GCAAD0210100 SET ODOMeter = (SELECT KM FROM GCAAD0710110 WHERE DocumentID = @DocumentNumber and SerialNo = 83) 
		--WHERE DOCUMENTID = 
		--(SELECT VehicleID FROM GCAAD0710110 WHERE DocumentID = @DocumentNumber and SerialNo = 83)
		--END
		  IF (@_ActionType = 'Final Approval' AND (0 = (SELECT COUNT(*) FROM GCAWF0010110 WHERE ROLEID ='VT01' AND UserID = (SELECT UserID from GCAAD0710100 WHERE DocumentID = @DocumentNumber))))
		  BEGIN
		  SELECT @LOCATNID=ISNULL(LOCATNID,'.') from GCA01..UPR00100 WHERE LOCATNID<> '' and EMPLOYID = (SELECT EMPLOYID FROM GCAAD0710100 WHERE DocumentID =@DocumentNumber)
		IF ltrim(rtrim(@LOCATNID)) = 'Abu Dhabi'
		BEGIN
		SET @LOCATION = 'P999'
		END
		IF ltrim(rtrim(@LOCATNID)) = 'SZC'
		BEGIN
		SET @LOCATION = 'P999'
		END
		IF ltrim(rtrim(@LOCATNID)) = 'DUABI'
		BEGIN
		SET @LOCATION = 'P999'
		END

		  SELECT @maxdoc = ISNULL(MAX(VoucherNo),'PC-2015-0000000') FROM GCAPC0110100 WHERE RIGHT(LEFT(VoucherNo, 7), 4) = Year(getdate())
		  SELECT @nm=cast(right(@maxdoc,7) as numeric(7))
		SET @nm = @nm + 1
		SET @len_ = 7 - len(@nm)
		PRINT @len_
		If @len_ = 1 SET @con = '0'
		If @len_ = 2 SET @con = '00'
		If @len_ = 3 SET @con = '000'
		If @len_ = 4 SET @con = '0000'
		If @len_ = 5 SET @con = '00000'
		If @len_ = 6 SET @con = '000000'
		If @len_ = 7 SET @con = '0000000'
		SET  @updateddoc = 'PC-'+CAST(YEAR(GETDATE()) AS char(4))+'-'+@con+CAST(@nm AS char(7))
		  --PRINT len(@cn)
		  INSERT INTO GCAPC0110100(
			   [VoucherNo]
			  ,[UserId]
			  ,[VoucherDate]
			  ,[EMPLOYID]
			  ,[DisplayName]
			  ,[EMail]
			  ,[Division_Code]
			  ,[Department_Code]
			  ,[MobilePhone]
			  ,[PreferredContact]
			  ,[Location]
			  ,[SLA_In_Days]
			  ,[VoucherSubject]
			  ,[VoucherAmount]
			  ,[LineManagerEmail]
			  ,[ApprovalPass]
			  ,[RejectPass]
			  ,[LineManagerName]
			  ,[FinalStatus])
		  VALUES((@updateddoc),
		  ('SysAdmin'),
		  (SELECT date FROM GCAAD0710100 WHERE DocumentID = @DocumentNumber),
		  ('SysAdmin'),
		  ('SysAdmin'),
		  ('SysAdmin'),
		  (SELECT Division_Code FROM GCAAD0710100 WHERE DocumentID = @DocumentNumber),
		  (SELECT Department_Code FROM GCAAD0710100 WHERE DocumentID = @DocumentNumber),
		  ('-'),
		  (SELECT '.' FROM GCAAD0710100 WHERE DocumentID = @DocumentNumber),
		  (@LOCATION),
		  (SELECT SLA_In_Days FROM GCAAD0710100 WHERE DocumentID = @DocumentNumber),
		  ('VEH  MAINT'),
		  (SELECT ISNULL(SUM(amount),0) FROM GCAAD0710110 WHERE DocumentID = @DocumentNumber),
		  ('SysAdmin'),
		  (SELECT approvalpass FROM GCAAD0710100 WHERE DocumentID = @DocumentNumber),
		  (SELECT rejectpass FROM GCAAD0710100 WHERE DocumentID = @DocumentNumber),
		  ('SysAdmin'),
		  'Final Approval'
		  )

		  INSERT INTO GCAPC0110110 ([VoucherNo]
			  ,[Division_Code]
			  ,[Department_Code]
			  ,[ExpenseCode]
			  ,[Description]
			  ,[CurrencyID]
			  ,[LineManagerEmail]
			  ,[InvoiceNo]
			  ,[InvoiceAmount]
			  ,[IntegratedToGP]
			  ,[IntegratedDate]
			  ,[IntegratedBy]
			  ,[PettyCashVoucherNumber]
			  ,[PettyCashBatchNumber] )
		  VALUES((@updateddoc),
		  (SELECT Division_Code FROM GCAAD0710100 WHERE DocumentID = @DocumentNumber),
		  (SELECT rtrim(Division_Code)+'-'+rtrim(Department_Code) FROM GCAAD0710100 WHERE DocumentID = @DocumentNumber),
		  ('VEH  MAINT'),
		  ('Vehicle  Maintenance'),
		  ('AED'),
		  ('SysAdmin'),
		  (SELECT serialno FROM GCAAD0710100 WHERE DocumentID = @DocumentNumber),
		  (SELECT ISNULL(SUM(amount),0) FROM GCAAD0710110 WHERE DocumentID = @DocumentNumber),
		  NULL,
		  NULL,
		  NULL,
		  NULL,
		  NULL
		  )
  
		  --INSERT INTO GCAPC0110100()
		  --INSERT INTO GCAPC0110110()
		  END
		  -- code changes from here

		END

END

IF @_LineManagerisADG = 1
BEGIN
    SET @StepNumber = @StepNumber + 1
	EXEC stpApproveDocumentWorkflow @eServiceID, @WorkflowID, @DocumentNumber, @ActionBy, @Comments, @StepNumber
END

-- code changes from here
SELECT @_ProceedApproval
-- code changes till here

GO
/****** Object:  StoredProcedure [dbo].[stpRejectDocumentWorkflow]    Script Date: 11/22/2015 11:37:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[stpRejectDocumentWorkflow]
@eServiceID		AS VARCHAR(30),
@WorkflowID		AS VARCHAR(100),
@DocumentNumber	AS VARCHAR(50),
@ActionBy		AS VARCHAR(50),
@Comments		AS VARCHAR(MAX),
@StepNumber		AS NUMERIC
AS


DECLARE @_StepNumber AS NUMERIC, 
        @_UserID AS VARCHAR(30), 
		@_RoleID AS VARCHAR(30), 
		@_DefaultValue AS VARCHAR(30), 
		@_ActionType AS VARCHAR(30)

SELECT 
   @_StepNumber = StepNumber,
   @_UserID = UserID,
   @_RoleID = RoleID,
   @_DefaultValue = DefaultValue,
   @_ActionType = ActionType
FROM GCAWF0010111
--WHERE WorkflowID = 'PR0101' AND eServiceID = 'PR01MaterialRequest' AND StepNumber = 1
WHERE WorkflowID = @WorkflowID AND eServiceID = @eServiceID AND StepNumber = @StepNumber

--SELECT @_StepNumber, @_UserID, @_RoleID, @_DefaultValue, @_ActionType

INSERT INTO GCAWF0010120 (eServiceID,WorkflowID,DocumentNumber,TransactionDate,StepNumber,UserID,
       RoleID,OtherID,ActionBy,ActionDate,ActionTime,Comments,Action,AttachmentID,CreatedDate,
	   ApprovalPassword,RejectPassword)
VALUES (@eServiceID, @WorkflowID, @DocumentNumber, GETDATE(), @StepNumber, @_UserID, 
        @_RoleID, @_DefaultValue, @ActionBy, GETDATE(), CONVERT(VARCHAR(20), GETDATE(), 103),@Comments, 'Reject', '.', GETDATE(), 0.9999999, 0.8888888  )



IF @eServiceID = 'AD07VehicleMaintenance' AND @WorkflowID = 'VT0701'
BEGIN
  UPDATE GCAAD0710100 SET FinalStatus = 'Reject' WHERE DocumentID = @DocumentNumber
END

IF @eServiceID = 'AD02Transport' AND @WorkflowID = 'VR0201'
BEGIN
  UPDATE GCAAD0210101 SET FinalStatus = 'Reject' WHERE DocumentID = @DocumentNumber
END


GO
/****** Object:  StoredProcedure [dbo].[stpSubmitDocumentWorkflow]    Script Date: 11/22/2015 11:37:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE PROCEDURE [dbo].[stpSubmitDocumentWorkflow]
@eServiceID		AS VARCHAR(30),
@WorkflowID		AS VARCHAR(100),
@DocumentNumber	AS VARCHAR(50),
@ActionBy		AS VARCHAR(50),
@Comments		AS VARCHAR(MAX)
AS

DECLARE @_StepNumber AS NUMERIC, 
        @_UserID AS VARCHAR(30), 
		@_RoleID AS VARCHAR(30), 
		@_DefaultValue AS VARCHAR(30), 
		@_ActionType AS VARCHAR(30)

SELECT 
   @_StepNumber = StepNumber,
   @_UserID = UserID,
   @_RoleID = RoleID,
   @_DefaultValue = DefaultValue,
   @_ActionType = ActionType
FROM GCAWF0010111
--WHERE WorkflowID = 'PR0101' AND eServiceID = 'PR01MaterialRequest' AND StepNumber = 1
WHERE WorkflowID = @WorkflowID AND eServiceID = @eServiceID AND StepNumber = 1

--SELECT @_StepNumber, @_UserID, @_RoleID, @_DefaultValue, @_ActionType

INSERT INTO GCAWF0010120 (eServiceID,WorkflowID,DocumentNumber,TransactionDate,StepNumber,UserID,
       RoleID,OtherID,ActionBy,ActionDate,ActionTime,Comments,Action,AttachmentID,CreatedDate,
	   ApprovalPassword,RejectPassword)
VALUES (@eServiceID, @WorkflowID, @DocumentNumber, GETDATE(), @_StepNumber, @_UserID, 
        @_RoleID, @_DefaultValue, @ActionBy, GETDATE(), CONVERT(VARCHAR(20), GETDATE(), 103),@Comments, 'Submit', '.', GETDATE(), 0.9999999, 0.8888888  )

IF @eServiceID = 'AD07VehicleMaintenance' AND @WorkflowID = 'VT0701'
BEGIN
  UPDATE GCAAD0710100 SET FinalStatus = 'Submited' WHERE DocumentID = @DocumentNumber
END

IF @eServiceID = 'AD02Transport' AND @WorkflowID = 'VR0201'
BEGIN
  UPDATE GCAAD0210101 SET FinalStatus = 'Submited' WHERE DocumentID = @DocumentNumber
END

IF @eServiceID = 'AD02Transport' AND @WorkflowID = 'VR0201'
BEGIN
  UPDATE GCAAD0210100 SET Availability = 'No' WHERE DocumentID = @DocumentNumber
END



GO
/****** Object:  UserDefinedFunction [dbo].[GetRoleUserDetails]    Script Date: 11/22/2015 11:37:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GetRoleUserDetails]
(
	-- Add the parameters for the function here
	@RoleId varchar(50)
)
RETURNS varchar(MAX)
AS
BEGIN
	-- Declare the return variable here
	Declare @Cursor CURSOR
	Declare @LoopVar varchar(MAX)
	Declare @RetVal varchar(MAX)

	set @Cursor = cursor for
	select CONCAT(UserName,' - ', EmailAddress) from [GCAWF0010110] where RoleID = @RoleId

	-- Add the T-SQL statements to compute the return value here
	open @Cursor
	FETCH NEXT FROM @Cursor 
    INTO @LoopVar

	WHILE @@FETCH_STATUS = 0
    BEGIN
      FETCH NEXT FROM @Cursor 
      INTO @LoopVar
	  select @RetVal =  Concat(@LoopVar, '<br/>')
    END; 

    CLOSE @Cursor ;
    DEALLOCATE @Cursor;

	-- Return the result of the function
	RETURN @RetVal

END

GO
/****** Object:  Table [dbo].[GCAA_ESS_ActiveDirectoryUsersList]    Script Date: 11/22/2015 11:37:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GCAA_ESS_ActiveDirectoryUsersList](
	[DisplayName] [varchar](100) NOT NULL,
	[EmailAddress] [varchar](100) NULL,
	[MobilePhone] [varchar](100) NULL,
	[ManagerLogin] [varchar](100) NULL,
	[Department] [varchar](50) NULL,
	[LoginName] [varchar](100) NULL,
	[LineManagerName] [varchar](100) NULL,
	[JobTitle] [varchar](150) NULL,
	[EID] [varchar](50) NULL,
 CONSTRAINT [PK_ActiveDirectoryUsersList] PRIMARY KEY CLUSTERED 
(
	[DisplayName] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GCAA_ESS_Leave_Attachments_Transport]    Script Date: 11/22/2015 11:37:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[GCAA_ESS_Leave_Attachments_Transport](
	[DOC_ID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[FILENAME] [varchar](250) NULL,
	[DOCUMENT] [varbinary](max) NULL,
	[REQUESTID] [varchar](15) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GCAA_ESS_Leave_Attachments_VehicleMaintenance]    Script Date: 11/22/2015 11:37:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GCAA_ESS_Leave_Attachments_VehicleMaintenance](
	[DOC_ID] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[FILENAME] [varchar](250) NULL,
	[DOCUMENT] [varbinary](max) NULL,
	[REQUESTID] [varchar](15) NOT NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GCAAD0210100]    Script Date: 11/22/2015 11:37:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING OFF
GO
CREATE TABLE [dbo].[GCAAD0210100](
	[SerialNo] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[DocumentID] [varchar](50) NOT NULL,
	[ChasisNumber] [varchar](50) NOT NULL,
	[Color] [varchar](50) NOT NULL,
	[Make] [varchar](50) NOT NULL,
	[Name] [varchar](150) NOT NULL,
	[ODOMeter] [numeric](18, 0) NOT NULL,
	[OilChangeDate] [date] NOT NULL,
	[RegistrationExpiryDate] [date] NOT NULL,
	[RegistrationNumber] [varchar](50) NOT NULL,
	[SalikAccountNumber] [varchar](100) NOT NULL,
	[TyreChangeDate] [date] NOT NULL,
	[InsuranceCompany] [varchar](100) NOT NULL,
	[InsurancePolicyNumber] [varchar](50) NOT NULL,
	[EngineNumber] [varchar](50) NOT NULL,
	[LastServiceDate] [date] NOT NULL,
	[Availability] [varchar](50) NOT NULL,
	[Model] [varchar](50) NOT NULL,
	[CreatedBy] [varchar](100) NOT NULL,
	[CreatedDate] [date] NOT NULL,
	[InsuranceExpiryDate] [date] NULL,
	[Location] [varchar](50) NULL,
 CONSTRAINT [PK_GCAAD0210100] PRIMARY KEY CLUSTERED 
(
	[SerialNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GCAAD0210101]    Script Date: 11/22/2015 11:37:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GCAAD0210101](
	[SerialNo] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[DocumentID] [varchar](50) NOT NULL,
	[UserId] [varchar](50) NOT NULL,
	[Date] [date] NOT NULL,
	[EMPLOYID] [varchar](50) NOT NULL,
	[DisplayName] [varchar](150) NOT NULL,
	[EMail] [varchar](150) NOT NULL,
	[Division_Code] [varchar](50) NOT NULL,
	[Department_Code] [varchar](50) NOT NULL,
	[MobilePhone] [varchar](50) NOT NULL,
	[SLA_In_Days] [int] NOT NULL,
	[GoingFrom] [varchar](100) NOT NULL,
	[GoingTo] [varchar](100) NOT NULL,
	[Subject] [varchar](100) NOT NULL,
	[PickupLocation] [varchar](100) NOT NULL,
	[DepartureDate] [datetime] NOT NULL,
	[ReturnDate] [datetime] NOT NULL,
	[SelectedVehicleID] [varchar](50) NOT NULL,
	[TripType] [varchar](50) NOT NULL,
	[DriverRequired] [varchar](50) NOT NULL,
	[Comments] [varchar](200) NOT NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[LineManagerEmail] [varchar](50) NOT NULL,
	[ApprovalPass] [varchar](50) NOT NULL,
	[RejectPass] [varchar](50) NOT NULL,
	[LineManagerName] [varchar](50) NOT NULL,
	[FinalStatus] [varchar](50) NULL,
	[Location] [varchar](50) NULL,
	[ReturnHour] [varchar](50) NULL,
	[ReturnMinutes] [varchar](50) NULL,
	[DepartureHour] [varchar](50) NULL,
	[DepartureMinutes] [varchar](50) NULL,
 CONSTRAINT [PK_GCAAD0210101] PRIMARY KEY CLUSTERED 
(
	[SerialNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GCAAD0700100]    Script Date: 11/22/2015 11:37:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GCAAD0700100](
	[SerialNo] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[ServiceType] [varchar](100) NOT NULL,
 CONSTRAINT [PK_GCAAD0700100] PRIMARY KEY CLUSTERED 
(
	[SerialNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GCAAD0710100]    Script Date: 11/22/2015 11:37:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GCAAD0710100](
	[SerialNo] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[DocumentID] [varchar](50) NULL,
	[UserId] [varchar](50) NULL,
	[Date] [datetime] NULL,
	[EMPLOYID] [varchar](50) NULL,
	[DisplayName] [varchar](150) NULL,
	[EMail] [varchar](150) NULL,
	[Division_Code] [varchar](50) NULL,
	[Department_Code] [varchar](50) NULL,
	[MobilePhone] [varchar](50) NULL,
	[SLA_In_Days] [int] NULL,
	[CreatedBy] [varchar](50) NULL,
	[CreatedDate] [date] NULL,
	[ServiceDate] [date] NULL,
	[Location] [varchar](50) NULL,
	[Remarks] [varchar](150) NULL,
	[FinalStatus] [varchar](50) NULL,
	[ApprovalPass] [varchar](50) NULL,
	[RejectPass] [varchar](50) NULL,
	[LineManagerName] [varchar](100) NULL,
	[LineManagerEmail] [varchar](100) NULL,
 CONSTRAINT [PK_GCAAD0710100] PRIMARY KEY CLUSTERED 
(
	[SerialNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GCAAD0710110]    Script Date: 11/22/2015 11:37:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GCAAD0710110](
	[DocumentID] [varchar](50) NOT NULL,
	[SerialNo] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[UserId] [varchar](50) NOT NULL,
	[Division_Code] [varchar](50) NOT NULL,
	[Department_Code] [varchar](50) NOT NULL,
	[ServiceSerialNo] [int] NOT NULL,
	[ServiceType] [varchar](100) NOT NULL,
	[VehicleID] [varchar](50) NOT NULL,
	[RegistrationNumber] [varchar](50) NOT NULL,
	[Model] [varchar](50) NOT NULL,
	[Amount] [numeric](18, 2) NOT NULL,
	[KM] [numeric](18, 2) NOT NULL,
 CONSTRAINT [PK_GCAAD0710110] PRIMARY KEY CLUSTERED 
(
	[DocumentID] ASC,
	[SerialNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GCAWF0010100]    Script Date: 11/22/2015 11:37:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GCAWF0010100](
	[eServiceID] [varchar](50) NOT NULL,
	[eServiceName] [varchar](50) NOT NULL,
	[eServiceDescription] [varchar](100) NOT NULL,
	[OwnerDepartment] [varchar](50) NOT NULL,
	[eServiceWebURL] [varchar](100) NOT NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[CreatedDate] [date] NOT NULL,
	[Autopost] [int] NOT NULL,
 CONSTRAINT [PK_GCAWF0010100] PRIMARY KEY CLUSTERED 
(
	[eServiceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GCAWF0010101]    Script Date: 11/22/2015 11:37:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GCAWF0010101](
	[WorkflowID] [varchar](50) NOT NULL,
	[WorkflowName] [varchar](100) NOT NULL,
	[WorkflowDescription] [varchar](500) NOT NULL,
	[eServiceID] [varchar](50) NOT NULL,
	[Activated] [int] NOT NULL,
	[PowerUser] [varchar](50) NOT NULL,
 CONSTRAINT [PK_GCAWF0010101] PRIMARY KEY CLUSTERED 
(
	[WorkflowID] ASC,
	[eServiceID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GCAWF0010102]    Script Date: 11/22/2015 11:37:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GCAWF0010102](
	[RoleID] [varchar](50) NOT NULL,
	[RoleName] [varchar](150) NOT NULL,
	[RoleDescription] [varchar](500) NOT NULL,
	[RoleStatus] [bit] NOT NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[LastModifiedBy] [varchar](50) NOT NULL,
	[LastModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_GCAWF0010102] PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GCAWF0010110]    Script Date: 11/22/2015 11:37:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GCAWF0010110](
	[RoleID] [varchar](50) NOT NULL,
	[UserID] [varchar](50) NOT NULL,
	[UserName] [varchar](150) NOT NULL,
	[EmployeeID] [varchar](6) NOT NULL,
	[EmailAddress] [varchar](150) NOT NULL,
	[Division] [varchar](2) NOT NULL,
	[Department] [varchar](2) NOT NULL,
	[Section] [varchar](2) NULL,
	[RoleName] [varchar](250) NOT NULL,
	[JobTitle] [varchar](500) NOT NULL,
	[MobileNo] [varchar](50) NULL,
	[RoleDescription] [varchar](500) NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[LastModifiedBy] [varchar](50) NOT NULL,
	[LastModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_GCAWF0010110] PRIMARY KEY CLUSTERED 
(
	[RoleID] ASC,
	[UserID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GCAWF0010111]    Script Date: 11/22/2015 11:37:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GCAWF0010111](
	[WorkflowID] [varchar](50) NOT NULL,
	[eServiceID] [varchar](50) NOT NULL,
	[StepNumber] [int] NOT NULL,
	[UserID] [varchar](50) NULL,
	[RoleID] [varchar](50) NULL,
	[DefaultValue] [varchar](50) NULL,
	[ActionType] [varchar](50) NOT NULL,
	[WorkflowName] [varchar](50) NOT NULL,
	[CreatedBy] [varchar](50) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[LastModifiedBy] [varchar](50) NOT NULL,
	[LastModifiedDate] [datetime] NOT NULL,
 CONSTRAINT [PK_GCAWF0010111] PRIMARY KEY CLUSTERED 
(
	[WorkflowID] ASC,
	[eServiceID] ASC,
	[StepNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GCAWF0010120]    Script Date: 11/22/2015 11:37:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GCAWF0010120](
	[SerialNo] [numeric](18, 0) IDENTITY(1,1) NOT NULL,
	[eServiceID] [varchar](50) NOT NULL,
	[WorkflowID] [varchar](50) NOT NULL,
	[DocumentNumber] [varchar](50) NOT NULL,
	[TransactionDate] [date] NOT NULL,
	[StepNumber] [int] NOT NULL,
	[UserID] [varchar](50) NULL,
	[RoleID] [varchar](50) NULL,
	[OtherID] [varchar](50) NULL,
	[ActionBy] [varchar](50) NOT NULL,
	[ActionDate] [datetime] NOT NULL,
	[ActionTime] [varchar](50) NOT NULL,
	[Comments] [varchar](500) NOT NULL,
	[Action] [varchar](50) NOT NULL,
	[AttachmentID] [varchar](50) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ApprovalPassword] [varchar](50) NOT NULL,
	[RejectPassword] [varchar](50) NOT NULL,
 CONSTRAINT [PK_GCAWF0010120] PRIMARY KEY CLUSTERED 
(
	[SerialNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GCAWF0030120]    Script Date: 11/22/2015 11:37:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GCAWF0030120](
	[SerialNo] [numeric](18, 0) NOT NULL,
	[eServiceID] [varchar](50) NOT NULL,
	[WorkflowID] [varchar](50) NOT NULL,
	[DocumentNumber] [varchar](50) NOT NULL,
	[TransactionDate] [date] NOT NULL,
	[StepNumber] [int] NOT NULL,
	[UserID] [varchar](50) NULL,
	[RoleID] [varchar](50) NULL,
	[OtherID] [varchar](50) NULL,
	[ActionBy] [varchar](50) NOT NULL,
	[ActionDate] [datetime] NOT NULL,
	[ActionTime] [varchar](50) NOT NULL,
	[Comments] [varchar](500) NOT NULL,
	[Action] [varchar](50) NOT NULL,
	[AttachmentID] [varchar](50) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ApprovalPassword] [varchar](50) NOT NULL,
	[RejectPassword] [varchar](50) NOT NULL,
 CONSTRAINT [PK_GCAWF0030120_1] PRIMARY KEY CLUSTERED 
(
	[SerialNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[GCAWF0030320]    Script Date: 11/22/2015 11:37:59 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[GCAWF0030320](
	[SerialNo] [numeric](18, 0) NOT NULL,
	[eServiceID] [varchar](50) NOT NULL,
	[WorkflowID] [varchar](50) NOT NULL,
	[DocumentNumber] [varchar](50) NOT NULL,
	[TransactionDate] [date] NOT NULL,
	[StepNumber] [int] NOT NULL,
	[UserID] [varchar](50) NULL,
	[RoleID] [varchar](50) NULL,
	[OtherID] [varchar](50) NULL,
	[ActionBy] [varchar](50) NOT NULL,
	[ActionDate] [datetime] NOT NULL,
	[ActionTime] [varchar](50) NOT NULL,
	[Comments] [varchar](500) NOT NULL,
	[Action] [varchar](50) NOT NULL,
	[AttachmentID] [varchar](50) NOT NULL,
	[CreatedDate] [datetime] NOT NULL,
	[ApprovalPassword] [varchar](50) NOT NULL,
	[RejectPassword] [varchar](50) NOT NULL
) ON [PRIMARY]

GO
SET ANSI_PADDING OFF
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Aamer Ali', N'aali@gcaa.gov.ae', N'+971557177301', N'mj', N'SUPS>ITD', N'aali', N'Mohammed Jameeluddin', N'Software Engineer', N'001152')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Aashish Nilkanth Kudtarkar', N'akudtarkar@gcaa.gov.ae', NULL, N'walnaqbi', N'HCD>PERC', N'akudtarkar', N'Dr. Waleed Hassan Al Naqbi', N'Employee Relations Officer', N'000036')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Abdelati Ali Al Fadil', N'aalfadil@gcaa.gov.ae', N'+971506672384', N'kalraisi', N'AAIS', N'aalfadil', N'Khalid Walid Al Raisi', N'Senior Air Accident Investigator', N'000368')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Abdul Ali Nissar (SZC)', N'abdul.ali-nissar@gcaa.gov.ae', N'+971506623769', N'jammari', NULL, N'abdul.ali-nissar', N'Jacob Ammari (SZC)', N'Admin Assistant - Facilities Management', N'000052')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Abdul Hakeem Vellam Parambu', N'aparambu@gcaa.gov.ae', N'+971556344221', N'schelakara', N'SUPS>FAPD', N'aparambu', N'Subharaman Chelakara', N'Document Controller', N'001177')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Abdul Rahim Ebrahim Al Buraimi', N'aburaimi@szc.gcaa.ae', N'+971506288011', N'gregkurten', N'ANS>CNS', N'aburaimi', N'Gregory John Kurten (SZC)', N'CNS Engineer', N'000016')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Abdul Rauf Muhammad Rafique (SZC)', N'amrafique@szc.gcaa.ae', N'0509842684', N'gregkurten', N'ANS>CNS', N'amrafique', N'Gregory John Kurten (SZC)', N'CNS Senior Technician', N'000883')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Abdulaziz Suwaiket Al Hajri', N'aalhajri@gcaa.gov.ae', N'+971506147245', N'aaljanahi', N'SAFS>FOPD', N'aalhajri', N'Ahmed Al Janahi', N'Senior Inspector Foreign Operators', N'000363')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Abdulla  Al Shehhi (SZC)', N'AAlshehhi@szc.gcaa.ae', NULL, NULL, N'ANS>Training', N'aalshehhi', NULL, N'ATC Trainee', N'000818')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Abdulla Al Janahi', N'ajanahi@gcaa.gov.ae', N'0506160850', N'aaljanahi', N'SAFS>FOPD', N'ajanahi', N'Ahmed Al Janahi', N'Inspector - Foreign Operators', N'000822')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Abdulla Al Marzooqi', N'amarzooqi@gcaa.gov.ae', NULL, N'vpabraham', N'DAS>ANA', N'amarzooqi', N'Abraham Vadakkekalam Pothen (SZC)', N'ATCA', N'000701')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Abdulla Al Rahma (SZC)', N'aalrahma@szc.gcaa.ae', N'+971508565505', N'htenaiji', N'ANS>ATM', N'aalrahma', N'Hesham Mohamed Al Tenaiji (SZC)', N'ATC Assistant', N'000759')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Abdulla Al Sayed Al Marzouqi (SZC)', N'asmarzouqi@szc.gcaa.ae', N'+971508981181', N'gregkurten', N'ANS>CNS', N'asmarzouqi', N'Gregory John Kurten (SZC)', N'CNS Engineer', N'000749')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Abdulla AlKhateri', N'aalkhateri@gcaa.gov.ae', NULL, N'ialmazmi', N'SIAS', N'aalkhateri', N'Ismail Al Mazmi', N'Call Center Agent', N'000806')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Abdulla Almarri', N'aalmarri@gcaa.gov.ae', NULL, N'malsaadi', N'SAFS>FOPD', N'aalmarri', N'Mohammed Ahmed Al Saadi', N'Flight Operation Inspector', N'1002')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Abdulla Hamza Al Balooshi', N'abalooshi@gcaa.gov.ae', NULL, N'nasser.al-marzouqi', N'SUPS>FAPD', N'abalooshi', N'Nasser Ahmed Al Marzouqi', N'Public Relation officer', N'000245')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Abdulla Rashed Alhmoudi', N'aalhamoudi@gcaa.gov.ae', N'+971504467306', N'hamad.almuhairi', N'Intelligence and Threat Assessment Dept.', N'aalhamoudi', N'Hamad Salem Al Muhairi', N'Director - Intelligence &Threat', N'000421')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Abdulla Salem Al Kaabi', N'askaabi@gcaa.gov.ae', NULL, N'ialmazmi', N'API', N'askaabi', N'Ismail Al Mazmi', N'Call Centre Agent', N'000961')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Abdulla Salim Al Rashidi (SZC)', N'akaabi@szc.gcaa.ae', N'0506119865', N'aljallaf', N'ANS>AIS', N'akaabi', N'Ahmed Ibrahim Al Jallaf', N'Director- Aeronautical Information Services', N'000123')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Abdulla Yousif AlHosany', N'aalhosany@gcaa.gov.ae', N'+971506114895', N'khalid', N'SIAS>ATPD', N'aalhosany', N'Khalid Humaid Al Ali', N'Manager AirTransport Agreement', N'000295')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Abdulrahman Abdulla Al Qemzi', N'aalqemzi@gcaa.gov.ae', N'+971506138712', N'mwoodward', N'SAFS>ANAD', N'aalqemzi', N'Mark Edward Woodward', N'AES & RFFS Inspector (Aeordromes)', N'000539')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Abdulrahman Al Teneiji', N'aalTeneiji@gcaa.gov.ae', NULL, NULL, N'API', N'aalTeneiji', NULL, N'System Administrator', N'000812')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Abeer Al Menhali', N'aalmenhali@gcaa.gov.ae', NULL, N'aalhamoudi', N'AVS>ITA', N'aalmenhali', N'Abdulla Rashed Alhmoudi', N'Admin Assistant', N'000894')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Abhiroop Santra', N'asantra@gcaa.gov.ae', NULL, N'mj', N'SUPS>ITD', N'asantra', N'Mohammed Jameeluddin', N'Software Engineer', N'1186')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Abraham Vadakkekalam Pothen (SZC)', N'vpabraham@szc.gcaa.ae', N'+971508110238', N'frobert', N'ANS>ATM', N'vpabraham', N'Francois Robert (SZC)', N'Chief ATC Assistant', N'000527')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'acac.magazine', N'acac.magazine@gcaa.gov.ae', NULL, NULL, NULL, N'acac.magazine', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Accounts Administrator', N'accounts.admin@gcaa.gov.ae', NULL, NULL, NULL, N'accounts.admin', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'ACRegistry', N'acregistry@gcaa.gov.ae', NULL, NULL, NULL, N'acregistry', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Adam Gustaf Lassen (SZC)', N'alassen@szc.gcaa.ae', N'+971555590793', N'oabdouli', N'ANS>ATM', N'alassen', N'Omar Obaid Al Abdouli (SZC)', N'ATC Officer', N'000567')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'adfsadmin', NULL, NULL, NULL, NULL, N'adfsadmin', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Adil Ahmed Parkar', N'adilp@gcaa.gov.ae', N'+971504436743', N'mj', N'SUPS>ITD', N'adilp', N'Mohammed Jameeluddin', N'IT Technician', N'001010')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Admin.support', N'admin.support@gcaa.gov.ae', NULL, NULL, NULL, N'admin.support', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'adminfa', NULL, NULL, NULL, NULL, N'adminfa', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Adrian Razvan (SZC)', N'arazvan@szc.gcaa.ae', N'+971504425014', N'akaabi', N'ANS>AIS', N'arazvan', N'Abdulla Salim Al Rashidi (SZC)', N'Head – PANS OPS', N'000739')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Aeromedical', N'aeromedical@gcaa.gov.ae', NULL, NULL, NULL, N'aeromedical', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'afc', N'afc@gcaa.gov.ae', NULL, NULL, NULL, N'afc', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Aftncomms', N'aftncomms@gcaa.gov.ae', NULL, NULL, NULL, N'aftncomms', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Ahlam Talib (SZC)', N'atalib@szc.gcaa.ae', NULL, N'hbelushi', N'ANS> ATM', N'atalib', N'Hamad Bin Rashid Al Belushi (SZC)', N'ADMIN OFFICER', N'000996')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Ahmad Ali Belqaizi', N'abelqaizi@gcaa.gov.ae', N'+971566164107', NULL, N'ACRC', N'abelqaizi', NULL, N'Manager - Quality Assurance and Corporate Excellence', N'000592')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Ahmad Mohammed Abu Zahra', N'amazahra@gcaa.gov.ae', N'+971506179027', N'mj', N'SUPS>ITD', N'amazahra', N'Mohammed Jameeluddin', N'Software Engineer', N'001144')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Ahmad Ridzwan', N'aridzwan@gcaa.gov.ae', N'+971564616349', N'szeinal', N'SAFS>FOPD', N'aridzwan', N'Sayed zeinal', N'Inspector - Flight Operations', N'000941')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Ahmed Abdulla Al Najjar (SZC)', N'anajjar@szc.gcaa.ae', N'0509988897', N'htenaiji', N'ANS>TRN', N'anajjar', N'Hesham Mohamed Al Tenaiji (SZC)', N'Senior Pseudo Pilot', N'000249')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Ahmed Al Janahi', N'aaljanahi@gcaa.gov.ae', N'+971506213793', N'malsaadi', N'SAFS>FOPD', N'aaljanahi', N'Mohammed Ahmed Al Saadi', N'Acting Manager Foreign Operators / SAFA', N'000658')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Ahmed Al Khoori (SZC)', N'aalkhoori@szc.gcaa.ae', NULL, N'htenaiji', N'ANS>Training', N'aalkhoori', N'Hesham Mohamed Al Tenaiji (SZC)', N'ATC trainee', N'000859')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Ahmed Al Obeidli', N'aobaidli@gcaa.gov.ae', N'+971566113023', N'michael.hayes', N'SAFS>ANAD', N'aobaidli', N'Michael Edward Hayes', N'Sr. Air Navigation Inspector – CNS - AIRS', N'000660')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Ahmed Al Teneiji', N'ateneiji@gcaa.gov.ae', NULL, N'ialmazmi', N'API', N'ateneiji', N'Ismail Al Mazmi', N'Call Centre Agent', N'000861')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Ahmed Ali AlMansoori (SZC)', N'amansoori@szc.gcaa.ae', N'+971507966695', N'oabdouli', N'ANS>ATM', N'amansoori', N'Omar Obaid Al Abdouli (SZC)', N'ATC Officer', N'000240')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Ahmed Ibrahim Al Jallaf', N'aljallaf@gcaa.gov.ae', N'+971506149065', N'dg', N'ANS', N'aljallaf', N'Director General', N'Asst Dir Genl Air Navi Service', N'000061')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Ahmed Khalfan Al Ketbi (SZC)', N'aketbi@szc.gcaa.ae', N'+971508227718', N'oabdouli', N'ANS>TRN', N'aketbi', N'Omar Obaid Al Abdouli (SZC)', N'AIR TRAFFIC CONTROL OFFICER', N'000503')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Ahmed Saleh Al Shehhi (SZC)', N'ashehhi@szc.gcaa.ae', N'00971528413532', N'oabdouli', N'ANS>ATM', N'ashehhi', N'Omar Obaid Al Abdouli (SZC)', N'ATC Officer', N'000259')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Ahmed Salem Al Sabiri (SZC)', N'aalsabiri@gcaa.gov.ae', N'+971506119357', N'aljallaf', N'ANS>ATM', N'aalsabiri', N'Ahmed Ibrahim Al Jallaf', N'ANS- Quality & Safety Manager', N'000064')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Ahmed Salim Al Hadharim (SZC)', N'aahmed@szc.gcaa.ae', N'+971504273232', N'oabdouli', N'ANS>TRN', N'aahmed', N'Omar Obaid Al Abdouli (SZC)', N'AIR TRAFFIC CONTROL OFFICER', N'000501')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Ahmed Siddiqui', N'msiddiqui@gcaa.gov.ae', N'+971506174905', N'mj', N'SUPS>ITD', N'msiddiqui', N'Mohammed Jameeluddin', N'Senior Consultant', N'001015')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Ahmed Wagih Wahbi', N'awagih@gcaa.gov.ae', N'+971506115385', N'psayeed', N'SECS>OIND', N'awagih', N'Parvez Mohammad Sayeed', N'Chief Aviation Security Investigator', N'000310')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Ahmer Khan', N'akhan@gcaa.gov.ae', N'+971506148087', N'mj', N'SUPS>ITD', N'akhan', N'Mohammed Jameeluddin', N'Network & Security', N'001005')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Ahood Al Makhmary', N'aalmakhmary@gcaa.gov.ae', NULL, N'niqbal', N'ACRC', N'aalmakhmary', N'Nasir Iqbal', N'Admin Assistant', N'000794')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Ahsan Parvez Mohammed', N'ahsanparvez@gcaa.gov.ae', N'+971506148086', N'mj', N'SUPS>ITD', N'ahsanparvez', N'Mohammed Jameeluddin', N'IT Technician', N'001006')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Aidan Mc Enroe (SZC)', N'amenroe@szc.gcaa.ae', NULL, N'oabdouli', N'ANS> ATM', N'amenroe', N'Omar Obaid Al Abdouli (SZC)', N'ATC Officer', N'000807')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Air Accident Investigation', N'aai@gcaa.gov.ae', NULL, NULL, NULL, N'aai', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Air Navigation Services', N'ans@gcaa.gov.ae', NULL, NULL, NULL, N'ans', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'aircrewlicensing', N'aircrewlicensing@gcaa.gov.ae', NULL, NULL, NULL, N'aircrewlicensing', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Airspace', N'airspace@gcaa.gov.ae', NULL, NULL, NULL, N'airspace', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Airtransport', N'airtransport@gcaa.gov.ae', NULL, NULL, NULL, N'airtransport', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Airworthiness', N'Airworthiness@gcaa.gov.ae', NULL, NULL, NULL, N'Airworthiness', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'AirworthinessCAR145', N'AirworthinessCAR145@gcaa.gov.ae', NULL, NULL, NULL, N'AirworthinessCAR145', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'AIS', N'AIS@gcaa.gov.ae', NULL, NULL, NULL, N'AIS', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'AIS Notifications', N'aisnotifications@gcaa.gov.ae', NULL, NULL, NULL, N'aisnotifications', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Alan Alfred Towers (SZC)', N'alant@szc.gcaa.ae', N'+971506425105', N'gregkurten', N'ANS>CNS', N'alant', N'Gregory John Kurten (SZC)', N'Head of CNS Training', N'000538')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Alan Douglas Jones (SZC)', N'adjones@szc.gcaa.ae', N'+971564188901', N'aljallaf', N'ANS', N'adjones', N'Ahmed Ibrahim Al Jallaf', N'ANS Specialist', N'000884')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Alanood Altamimi', N'aaltamimi@gcaa.gov.ae', NULL, N'laila', N'SIA>COC', N'aaltamimi', N'Laila Ali Al Muhairi', N'Manager - Corporate Communication', N'995')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Alcon Numnes (SZC)', N'anunes@szc.gcaa.ae', N'+971504153705', N'vpabraham', N'ANS>ATC', N'anunes', N'Abraham Vadakkekalam Pothen (SZC)', N'ATCA', N'000924')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Alexander Francis Reiken (SZC)', N'areiken@szc.gcaa.ae', N'+971505046326', N'oabdouli', N'ANS>ATM', N'areiken', N'Omar Obaid Al Abdouli (SZC)', N'ATC Officer', N'000499')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Alexandra Jerrebo', N'ajerrebo@gcaa.gov.ae', N'+97150 6427033', N'laila', N'SIAS>COCC', N'ajerrebo', N'Laila Ali Al Muhairi', N'Communications Specialist', N'000824')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Ali Al Janaahi (SZC)', N'aljanaahi@szc.gcaa.ae', N'+971504559440', N'gregkurten', N'ANS>CNS', N'aljanaahi', N'Gregory John Kurten (SZC)', N'Head of CNS IT', N'000700')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Ali Ghulam Ali Balooshi (SZC)', N'ajobanj@szc.gcaa.ae', N'+971552262229', N'vpabraham', N'ANS>ATM', N'ajobanj', N'Abraham Vadakkekalam Pothen (SZC)', N'ATCA', N'000665')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Ali Lari (SZC)', N'alari@szc.gcaa.ae', N'0507288881', N'htenaiji', N'ANS>Training', N'alari', N'Hesham Mohamed Al Tenaiji (SZC)', N'ATC Trainee', N'000856')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Ali Mohamed Al Blooshi', N'alialblooshi@gcaa.gov.ae', N'+971506423264', N'dg', N'DGOO', N'amalblooshi', N'Director General', N'Crisis Management Advisor', N'000771')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Alia Al Shamsi', N'aalshamsi@gcaa.gov.ae', NULL, N'salmuhairi', N'HCD>MPRC', N'aalshamsi', N'Shamsa Al Muhairi', N'Assistant - Recruitment and Manpower Planning', N'000956')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Alia Ali Al Ketbi', N'aalketbi@gcaa.gov.ae', NULL, N'mj', N'SUPS>ITD', N'aalketbi', N'Mohammed Jameeluddin', N'IT Compliance and Quality Officer', N'000792')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Allan Stenberg Jensen (SZC)', N'asjensen@szc.gcaa.ae', N'+971567938091', N'oabdouli', N'ANS>ATM', N'asjensen', N'Omar Obaid Al Abdouli (SZC)', N'ATC Officer', N'000565')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Allen Sanchez (SZC)', N'asanchez@szc.gcaa.ae', NULL, N'vpabraham', N'ANS> ATM', N'asanchez', N'Abraham Vadakkekalam Pothen (SZC)', N'AIR TRAFFIC CONTROL ASSISTANT', N'991')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'AlUnood Abdulla AlAttar', N'unood@gcaa.gov.ae', NULL, N'nasser.al-marzouqi', N'SUPS>FAPD', N'unood', N'Nasser Ahmed Al Marzouqi', N'Receptionist', N'000609')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Alya Al Blooshi (SZC)', N'aalblooshi@szc.gcaa.ae', NULL, N'htenaiji', N'ANS>TRAINING', N'aalblooshi', N'Hesham Mohamed Al Tenaiji (SZC)', N'ATC TRAINEE', N'971')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Amaan Ali', N'amali@gcaa.gov.ae', NULL, N'emesafari', N'SAFS>LICD', N'amali', N'Eman Mohamed Al Mesafri', N'Filing Clerk', N'001134')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Amal Al Mausam', N'aalmausam@gcaa.gov.ae', N'+971 50 6001616', NULL, N'API', N'aalmausam', NULL, N'CARRIER OPERATION OFFICER', N'000734')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Amein Al Blooshi (SZC)', N'ablooshi@szc.gcaa.ae', NULL, N'htenaiji', N'ANS>ATM', N'ablooshi', N'Hesham Mohamed Al Tenaiji (SZC)', N'ATC Trainee', N'000728')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Amina Ahli', N'aahli@gcaa.gov.ae', NULL, N'omar', N'SUP>HCP', N'aahli', N'Omar Ghaleb Bin Ghaleb', N'Human Capital Director', N'1016')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Ammar Al Ali', N'aalali@gcaa.gov.ae', NULL, N'ialmazmi', N'API', N'aalali', N'Ismail Al Mazmi', N'Call Centre Agent', N'000951')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Ammar Al Mazrouei', N'aalmazrouei@gcaa.gov.ae', NULL, N'hamdoon', N'DAS\LIC', N'aalmazrouei', N'Obaid Mohamed Al Mehrezi', N'Engineering Inspector', N'000871')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'ams', N'ams@gcaa.gov.ae', NULL, NULL, NULL, N'ams', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'ANA Admin', N'ANA-Admin@gcaa.gov.ae', NULL, NULL, NULL, N'ANA-Admin', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'ANA Approval', N'ana.approval@gcaa.gov.ae', NULL, NULL, NULL, N'ana.approvals', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Anand Nevrekar', N'anevrekar@gcaa.gov.ae', NULL, N'aaljanahi', N'SAFS>FOPD', N'anevrekar', N'Ahmed Al Janahi', N'Inspector – Foreign Operations', N'000842')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Ananthapadmanabhan Narayan', N'anarayan@gcaa.gov.ae', N'+971503453590', N'schelakara', N'SUP>ASS', N'anarayan', N'Subharaman Chelakara', N'ANS Revenue Accounts Officer', N'000410')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Anas Hamed (SZC)', N'ahamed@szc.gcaa.ae', N'+971563334584', N'gregkurten', N'ANS>CNS', N'ahamed', N'Gregory John Kurten (SZC)', N'Senior CNS Technician', N'000875')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Anaziaz Zikir', N'Azikir@gcaa.gov.ae', N'+971506152931', N'mohamed.butaweel', N'SAFS>FOPD', N'Azikir', N'Mohamed Khamis Butaweel', N'Senior Inspector – Flight Operations', N'000280')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Andreas Mateou', N'Amateou@gcaa.gov.ae', N'+971506434206', NULL, N'SAFS>FOPD', N'Amateou', NULL, N'Inspector – Flight Operations', N'000725')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Andrew Jones (SZC)', N'ajones@szc.gcaa.ae', N'+971553760595', N'oabdouli', N'ANS>ATM', N'ajones', N'Omar Obaid Al Abdouli (SZC)', N'ATC Officer', N'000596')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Angelo Dominic Fernandes (SZC)', N'afernandes@szc.gcaa.ae', N'00971508135338', N'aljallaf', N'ANS', N'afernandes', N'Ahmed Ibrahim Al Jallaf', N'Executive Assistant', N'000043')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Annie Paul', N'apaul@gcaa.gov.ae', N'+971565032018', N'szeinal', N'SAFS>FOPD', N'apaul', N'Sayed zeinal', N'Auditing Inspector', N'1017')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Anthony Mark Lord (SZC)', N'alord@szc.gcaa.ae', NULL, N'oabdouli', N'ANS>ATM', N'alord', N'Omar Obaid Al Abdouli (SZC)', N'ATC Officer', N'000714')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Anthony Simon Newsham (SZC)', N'anewsham@szc.gcaa.ae', N'+971567826821', N'htenaiji', N'ANS/TRN', N'anewsham', N'Hesham Mohamed Al Tenaiji (SZC)', N'Air Traffic Services Instructor', N'000568')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Anthony Soloman', N'asoloman@gcaa.gov.ae', N'971564173260', N'salzara', N'SAFS>LICD', N'asoloman', N'Sultan Mohamed Al Zara', N'Air Crew Inspector', N'000848')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Antonio Sunpongco (SZC)', N'asunpongco@szc.gcaa.ae', N'+971527615777', N'vpabraham', N'ANS>ATM', N'asunpongco', N'Abraham Vadakkekalam Pothen (SZC)', N'ATC Assistant', N'000766')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Anwarul Haque Abbasi (SZC)', N'aabbasi@szc.gcaa.ae', N'0505115615 /0553500633', N'vpabraham', N'ANS>ATM', N'aabbasi', N'Abraham Vadakkekalam Pothen (SZC)', N'ATC Assistant', N'000605')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'AOR', N'aor@gcaa.gov.ae', NULL, NULL, NULL, N'aor', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Appmanager admin', N'Appmgradmin@gcaa.gov.ae', NULL, NULL, NULL, N'Appmgradmin', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Aqeel Ahmed Al Zarouni', N'aalzarouni@gcaa.gov.ae', N'+971506131273', N'emaaa', N'SAFS>AWRD', N'azarouni', N'Ismaeil Mohammed Al Blooshi', N'Acting Director Airworthiness Department', N'000498')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Aqueel Syed Mohammed (SZC)', N'amohammed@szc.gcaa.ae', N'+971501211071', N'gregkurten', N'ANS>ENG', N'amohammed', N'Gregory John Kurten (SZC)', N'Electronics Technician', N'000905')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Arcsight', N'arcsight@gcaa.gov.ae', NULL, NULL, NULL, N'arcsight', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Armando Cordoba', N'acordoba@gcaa.gov.ae', N'+971562192315', N'mcala', N'SECS>OIND', N'acordoba', N'Mladen Cala', N'Sr. Aviation Security Inspector', N'000680')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Arockia JohnPaul Savarimuthu (SZC)', N'jpaul@szc.gcaa.ae', N'+97150267 4568', N'jammari', N'ANS>CNS', N'jpaul', N'Jacob Ammari (SZC)', N'Maintenance Technician', N'000441')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'ASAS_QPulse_Feedback', N'ASAS_QPulse_Feedback@gcaa.gov.ae', NULL, NULL, NULL, N'ASAS_QPulse_Feedback', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'ASAS_ROSI_Feedback', N'ASAS_ROSI_Feedback@gcaa.gov.ae', NULL, NULL, NULL, N'ASAS_ROSI_Feedback', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Ashter Andrew Piedade (SZC)', N'apiedade@szc.gcaa.ae', N'+971506724703', N'vpabraham', N'ANS>ATM', N'apiedade', N'Abraham Vadakkekalam Pothen (SZC)', N'Assistant Supervisor', N'000284')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Asim Mairaj', N'amairaj@gcaa.gov.ae', N'+971506221896', N'salzara', N'SAFS>LICD', N'amairaj', N'Sultan Mohamed Al Zara', N'Air Crew Inspector - General Aviation', N'000430')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Asma Alhalyan Alsuwaidi', N'aalsuwaidi@gcaa.gov.ae', NULL, N'hdibian', N'SAFS>AWRD', N'aalsuwaidi', N'Hatem Mohamed Dibian', N'Admin Assistant', N'1013')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Asma Mohammed Al Suwaidi', N'asma.al-suwaidi@gcaa.gov.ae', N'+971504624333', N'nasser.al-marzouqi', N'SUPS>FAPD', N'asma.al-suwaidi', N'Nasser Ahmed Al Marzouqi', N'Senior  Admin Executive', N'000077')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Asma Suliman Mohmoud', N'asmas@gcaa.gov.ae', N'+971505777624', N'emesafari', N'SAFS>LICD', N'asulaiman', N'Eman Mohamed Al Mesafri', N'Admin Assistant Admin & Exam', N'000334')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Asra khan', N'askhan@gcaa.gov.ae', NULL, N'aaljanahi', N'SAFS>AWRD', N'askhan', N'Ahmed Al Janahi', N'Admin Assistant', N'000955')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'ATC', N'atc@gcaa.gov.ae', NULL, NULL, NULL, N'atc', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'ATC Licensing', N'atclicensing@gcaa.gov.ae', NULL, NULL, NULL, N'atclicensing', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Atcops', N'atcops@gcaa.gov.ae', NULL, NULL, NULL, N'atcops', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'atsinspector', N'atsinspector@gcaa.gov.ae', NULL, NULL, NULL, N'atsinspector', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'atsummit', N'atsummit@gcaa.gov.ae', NULL, NULL, NULL, N'atsummit', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Auditor1', NULL, NULL, NULL, NULL, N'Auditor1', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Auditor2', NULL, NULL, NULL, NULL, N'Auditor2', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Auditor3', NULL, NULL, NULL, NULL, N'Auditor3', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Auditor4', NULL, NULL, NULL, NULL, N'Auditor4', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Augustine Raj (SZC)', N'araj@szc.gcaa.ae', N'+971507412705', N'vpabraham', N'ANS>ATM', N'araj', N'Abraham Vadakkekalam Pothen (SZC)', N'Assistant Supervisor', N'000536')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Auh EMC', N'auhemc@gcaa.gov.ae', NULL, NULL, NULL, N'auhemc', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'AUH STULZ', N'AUH_STULZ@gcaa.gov.ae', NULL, NULL, NULL, N'AUH_STULZ', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'AUH-Approvals', N'auhapprovals@gcaa.gov.ae', NULL, NULL, NULL, N'auhapprovals', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'AVAdmin', NULL, NULL, NULL, NULL, N'avadmin', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Aviation Security', N'avsec@gcaa.gov.ae', NULL, NULL, NULL, N'avsec', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Avinash RajKumar (SZC)', N'arajkumar@szc.gcaa.ae', N'+971501353319', N'oabdouli', N'ANS>ATM', N'arajkumar', N'Omar Obaid Al Abdouli (SZC)', N'ATC Officer', N'000542')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'AVSEC Airlines', N'avsecairlines@gcaa.gov.ae', NULL, NULL, NULL, N'avsecairlines', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'AVSEC Web Board', N'avsecwebboard@gcaa.gov.ae', NULL, NULL, NULL, N'avsecwebboard', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'AVSEC-DI', N'AVSEC-DI@gcaa.gov.ae', NULL, NULL, NULL, N'AVSEC-DI', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Ayat Osamah Bakhoreba', N'aosamah@gcaa.gov.ae', NULL, N'nibrahim', N'SUPS>LGLD', N'aosamah', N'Nadia Ibrahim AlMaazmi', N'Lawyer', N'000845')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Ayeda Khalil', N'akhalil@gcaa.gov.ae', NULL, N'nasser.al-marzouqi', N'SUPS', N'akhalil', N'Nasser Ahmed Al Marzouqi', N'Receptionist', N'998')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Ayesha Abdullatif Al Butih', N'ayesha@gcaa.gov.ae', N'+971508729037', NULL, NULL, N'aabdullatif', NULL, NULL, N'000340')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Ayesha Abdulwahid', N'aabdulwahid@gcaa.gov.ae', NULL, N'malsaadi', N'SAFS>FOPD', N'aabdulwahid', N'Mohammed Ahmed Al Saadi', N'ADMIN ASSISTANT', N'000966')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Ayesha Alfalasi', N'aalfalasi@gcaa.gov.ae', N'nil', N'oghannam', N'SAFS>AWRD', N'aalfalasi', N'Omar Ahmad Bin Ghannam', N'Admin Assistant', N'1012')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Ayesha Butti Al Mheiri', N'aalmuhairi@gcaa.gov.ae', N'+971504435797', N'wrahmani', N'SAFS>PRED', N'aalmuhairi', N'Walid Ibrahim Al Rahmani', N'Specialist - Policy and Regulation', N'000447')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Ayesha Khamis Al Mushrakh', N'akmushrakh@gcaa.gov.ae', NULL, N'aaljanahi', N'SAFS>FOPD', N'akmushrakh', N'Ahmed Al Janahi', N'Admin Assistant', N'000850')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Ayesha Saeed Al Breiki (SZC)', N'aalbreiki@szc.gcaa.ae', NULL, N'nasser.al-marzouqi', N'SUP\ASS', N'aalbreiki', N'Nasser Ahmed Al Marzouqi', N'Receptionist', N'000863')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Aysha Ali Al Nuaimi', N'aalnuaimi@gcaa.gov.ae', NULL, N'ialmazmi', N'SIAS', N'aalnuaimi', N'Ismail Al Mazmi', N'Call Center Agent', N'000799')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Aysha Mohammed Al Hamili', N'ahamili@gcaa.gov.ae', N'+971506114901', N'dg', N'UROO', N'ahamili', N'Director General', N'UAE Representative to ICAO', N'000252')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Aziz Mohamed Al Sulaimani (SZC)', N'asulaimani@szc.gcaa.ae', N'+971509985806', N'oabdouli', N'ANS>ATM', N'asulaimani', N'Omar Obaid Al Abdouli (SZC)', N'ATC Officer', N'000300')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'backupadmin', N'backupadmin@gcaa.gov.ae', NULL, NULL, NULL, N'backupadmin', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Bader Ibrahim Al Hashemi', N'bhashemi@gcaa.gov.ae', N'+971506159539', N'salzara', N'SAFS>LICD', N'bhashemi', N'Sultan Mohamed Al Zara', N'LSA Inspector', N'000182')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Badr Ahmad Al Ali', N'badr@gcaa.gov.ae', N'+971-56-685-2376', N'oghannam', N'SAFS>AWRD', N'badr', N'Omar Ahmad Bin Ghannam', N'Inspector - Airworthiness', N'000610')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Badr Al Hammadi', N'bhammadi@gcaa.gov.ae', N'+971506131936', N'yazizi', N'SAFS>PRED', N'bhammadi', N'Yousuf Hashim Al Azizi', N'Auditing Inspector', N'000768')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Balakrishnan Thalasayanan (SZC)', N'bthalasayanan@szc.gcaa.ae', N'+971501503181', N'dfernandes', N'ANS>AIS', N'bthalasayanan', N'Dean Fernandes (SZC)', N'Publication Assistant', N'000897')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Barry Grant (SZC)', N'bgrant@szc.gcaa.ae', N'+971566735481', N'gregkurten', N'ANS>CNS', N'bgrant', N'Gregory John Kurten (SZC)', N'Senior CNS Engineer', N'000904')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Barry Kurten (SZC)', N'bkurten@szc.gcaa.ae', N'+971507675163', N'gregkurten', N'ANS>CNS', N'bkurten', N'Gregory John Kurten (SZC)', N'CNS Engineer', N'000903')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Barry Maguire (SZC)', N'bmaguire@szc.gcaa.ae', NULL, N'oabdouli', N'ANS>ATM', N'bmaguire', N'Omar Obaid Al Abdouli (SZC)', N'ATC Officer', N'000803')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Bashiruddin Nuruddin Shaikh', N'bashir@gcaa.gov.ae', N'+971508113437', N'mj', N'SUPS>ITD', N'bshaikh', N'Mohammed Jameeluddin', N'IT Technician', N'000269')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'BCPCheck', N'bcpcheck@gcaa.gov.ae', NULL, NULL, NULL, N'bcpcheck', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Benedict Mario Rodrigues', N'brodrigues@szc.gcaa.ae', N'+971505364260', N'akaabi', N'ANS>AIS', N'brodrigues', N'Abdulla Salim Al Rashidi (SZC)', N'Technical Librarian', N'000042')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Benjamin John McCormack (SZC)', N'bjmack@szc.gcaa.ae', N'+971561227255', N'oabdouli', N'ANS>ATM', N'bjmack', N'Omar Obaid Al Abdouli (SZC)', N'ATC Officer', N'000598')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Benny Hansen', N'bhansen@gcaa.gov.ae', N'+971506164058', N'michael.hayes', N'SAFS>ANAD', N'bhansen', N'Michael Edward Hayes', N'ATS Inspector Air Navigation', N'000746')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Bernard Vallejos Acosta (SZC)', N'bvallejos@szc.gcaa.ae', NULL, N'gregkurten', N'ANS>CNS', N'bvallejos', N'Gregory John Kurten (SZC)', N'Senior Maintenance Technician', N'000646')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'bes10ldap', NULL, NULL, NULL, NULL, N'bes10ldap', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'besadmin', N'besadmin@gcaa.gov.ae', NULL, NULL, NULL, N'besadmin', NULL, NULL, N'0000bb')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Bismark J Fonesca (SZC)', N'bfonesca@szc.gcaa.ae', N'+971505117183', N'vpabraham', N'ANS>ATM', N'bfonesca', N'Abraham Vadakkekalam Pothen (SZC)', N'ATCA', N'000925')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'blademgmt', N'blademgmt@gcaa.gov.ae', NULL, NULL, NULL, N'blademgmt', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Bradley miller (SZC)', N'bmiller@szc.gcaa.ae', NULL, N'oabdouli', N'ANS>ATM', N'bmiller', N'Omar Obaid Al Abdouli (SZC)', N'ATC Office', N'000742')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Brian William Stokoe (SZC)', N'bstokoe@szc.gcaa.ae', N'+971506147571', N'oabdouli', N'ANS>ATM', N'bstokoe', N'Omar Obaid Al Abdouli (SZC)', N'ATC Officer', N'000578')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Bryan Saldanha (SZC)', N'bsaldanha@szc.gcaa.ae', N'+971503191675', N'gregkurten', N'ANS>CNS', N'bsaldanha', N'Gregory John Kurten (SZC)', N'CNS Senior Electronics Technician', N'000967')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'buildadmin', NULL, NULL, NULL, NULL, N'buildadmin', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Buthaina Abdul Fattah Al Marzouqi', N'balmarzouqi@gcaa.gov.ae', NULL, N'walnaqbi', N'HCD>PERC', N'balmarzouqi', N'Dr. Waleed Hassan Al Naqbi', N'Senior Employee Relation Officer', N'000426')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'callmgr', N'callmgr@gcaa.gov.ae', NULL, NULL, NULL, N'callmgr', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'CAVAADMIN', NULL, NULL, NULL, NULL, N'CAVAADMIN', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Chacko Joseph Kizhakkearackal (SZC)', N'joseph@szc.gcaa.ae', N'+971505712389', N'jammari', N'ANS>CNS', N'joseph', N'Jacob Ammari (SZC)', N'Maintenance Technician', N'000037')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Chris Esterhuizen (SZC)', N'cesterhuizen@szc.gcaa.ae', N'+971507307834', NULL, N'ANS>ATC', N'cesterhuizen', NULL, N'ATCO', N'003116')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Chris Gerrard (SZC User)', N'cgerrard@szc.gcaa.ae', N'+971551969210', N'oabdouli', N'ANSS/ATMD', N'cgerrard', N'Omar Obaid Al Abdouli (SZC)', N'ATC Officer', N'000854')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Christo Visser (SZC)', N'cvisser@szc.gcaa.ae', N'+971552184276', N'oabdouli', N'ANS>ATM', N'cvisser', N'Omar Obaid Al Abdouli (SZC)', N'ATC Officer', N'000500')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Christopher Allan (SZC)', N'callan@szc.gcaa.ae', N'0506427023', N'mtenaiji', N'ANS>ATM', N'callan', N'Muayyed Al Tenaiji (SZC)', N'Senior Airspace Coordinator', N'000694')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Chrystal Janice Willis', N'cwillis@gcaa.gov.ae', NULL, N'schelakara', N'SUP>ASS', N'cwillis', N'Subharaman Chelakara', N'ANS Revenue Accounts Officer', N'001029')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'cisco presence', NULL, NULL, NULL, NULL, N'ciscopresence', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Ciscoise Admin', NULL, NULL, NULL, NULL, N'ciscoiseadmin', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Citrix Administrator', N'cxadmin@gcaa.gov.ae', NULL, NULL, NULL, N'cxadmin', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'citrix user', N'citrixuser@gcaa.gov.ae', NULL, NULL, NULL, N'citrixuser', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Citrix User2', N'citrixuser2@gcaa.gov.ae', NULL, NULL, NULL, N'citrixuser2', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Clifford William Budd (SZC)', N'cbudd@szc.gcaa.ae', N'+971509052838', N'gregkurten', N'ANS>CNS', N'cbudd', N'Gregory John Kurten (SZC)', N'CNS Engineer', N'000621')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Clive Robbins (SZC)', N'crobbins@szc.gcaa.ae', N'+971566415608', N'htenaiji', N'ANS>ATM', N'crobbins', N'Hesham Mohamed Al Tenaiji (SZC)', N'ATCO Officer', N'000627')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'cluster', NULL, NULL, NULL, NULL, N'cluster', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'colm Ingle (SZC)', N'cingle@szc.gcaa.ae', NULL, N'oabdouli', N'ANS>ATM', N'cingle', N'Omar Obaid Al Abdouli (SZC)', N'ATC Officer', N'000788')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Colum Flanagan (SZC)', N'cflanagan@szc.gcaa.ae', NULL, N'oabdouli', N'ANS>ATM', N'cflanagan', N'Omar Obaid Al Abdouli (SZC)', N'ATC Officer', N'000912')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Communication', N'communication@gcaa.gov.ae', NULL, NULL, NULL, N'communication', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Conor Matthew Croke (SZC)', N'ccroke@szc.gcaa.ae', N'+971501094960', N'oabdouli', N'ANS>ATM', N'ccroke', N'Omar Obaid Al Abdouli (SZC)', N'ATC Officer', N'000626')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Craig Brand (SZC)', N'cbrand@szc.gcaa.ae', NULL, N'oabdouli', N'ANS>ATM', N'cbrand', N'Omar Obaid Al Abdouli (SZC)', N'AIR TRAFFIC CONTROL OFFICER', N'000631')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Cristan Bentilanon Limbasan (SZC)', N'climbasan@szc.gcaa.ae', N'+971504187023', N'vpabraham', N'ANS>ATM', N'climbasan', N'Abraham Vadakkekalam Pothen (SZC)', N'ATC Assistant', N'000283')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Customer Compliants', N'customercompliants@gcaa.gov.ae', NULL, NULL, NULL, N'customercompliants', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Customer Suggestions', N'customersuggestions@gcaa.gov.ae', NULL, NULL, NULL, N'customersuggestions', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Damian Bentancor (SZC)', N'dgonzalez@szc.gcaa.ae', NULL, N'oabdouli', N'ANS>ATM', N'dbentancor', N'Omar Obaid Al Abdouli (SZC)', N'ATCO', N'000767')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'dangerousgoods', N'dangerousgoods@gcaa.gov.ae', NULL, NULL, NULL, N'dangerousgoods', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'DangerousGoodsFAOCertification', N'DangerousGoods.FAOCertification@gcaa.gov.ae', NULL, NULL, NULL, N'fao.dgcertification', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Darren Gregory Straker', N'dstraker@gcaa.gov.ae', N'+971502205342', N'kalraisi', N'AAIS', N'dstraker', N'Khalid Walid Al Raisi', N'Chief Air Accident Investigator', N'000520')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Dass', N'Dass@gcaa.gov.ae', NULL, NULL, NULL, N'Dass', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'DASS Archive', N'dass-archive@gcaa.gov.ae', NULL, NULL, NULL, N'dass-archive', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'DataAccess', N'dataaccess@gcaa.gov.ae', NULL, NULL, NULL, N'dataaccess', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'David  Edward Holmes (SZC)', N'dholmes@szc.gcaa.ae', N'+971561091665', N'oabdouli', N'ANS>ATM', N'dholmes', N'Omar Obaid Al Abdouli (SZC)', N'ATC Officer', N'000525')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'David Glen Thornley (SZC)', N'dthornley@szc.gcaa.ae', N'+971567425879', N'oabdouli', N'ANS>ATM', N'dthornley', N'Omar Obaid Al Abdouli (SZC)', N'ATC Officer', N'000544')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'David Joseph Baratta (SZC)', N'dbaratta@szc.gcaa.ae', N'+971561254285', N'oabdouli', N'ANS>ATM', N'dbaratta', N'Omar Obaid Al Abdouli (SZC)', N'ATCO', N'000913')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'David Raza (SZC)', N'david.raza@szc.gcaa.ae', N'+971564945476', N'oabdouli', N'ANS> ATM', N'draza', N'Omar Obaid Al Abdouli (SZC)', N'ATCO', N'000834')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'David Victor Jackson (SZC)', N'dvjackson@szc.gcaa.ae', N'+971557489376', N'oabdouli', N'ANS>ATM', N'dvjackson', N'Omar Obaid Al Abdouli (SZC)', N'ATC Officer', N'000915')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'David Welter (SZC)', N'dwelter@szc.gcaa.ae', N'+97150111 8176', NULL, N'ANS>ATC', N'dwelter', NULL, N'ATCO', N'003131')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'DBADMIN', N'dbadmin@gcaa.gov.ae', NULL, NULL, NULL, N'dbadmin', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'dbagent', NULL, NULL, NULL, NULL, N'dbagent', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'DBAUAT', NULL, NULL, NULL, NULL, N'DBAUAT', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'dcadmin', NULL, NULL, NULL, NULL, N'dcadmin', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Dean Fernandes (SZC)', N'dfernandes@szc.gcaa.ae', N'+971507811341', N'akaabi', N'ANS>AIS', N'dfernandes', N'Abdulla Salim Al Rashidi (SZC)', N'Design Senior Specialist', N'000119')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Deepak Choudhary', N'dchoudhary@gcaa.gov.ae', N'+971506421854', N'schelakara', N'SUP>ASS', N'dchoudhary', N'Subharaman Chelakara', N'Senior Budget Controller', N'000831')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Denissen Naidoo (SZC)', N'dnaidoo@szc.gcaa.ae', N'+971508491537', N'oabdouli', N'ANS>ATM', N'dnaidoo', N'Omar Obaid Al Abdouli (SZC)', N'ATC Officer', N'000651')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Dennis John Conrad (SZC)', N'dconrad@szc.gcaa.ae', N'+971509047969', N'oabdouli', N'ANS>ATM', N'dconrad', N'Omar Obaid Al Abdouli (SZC)', N'AIR TRAFFIC CONTROL OFFICER', N'000550')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Deputy Chairman', N'deputy.chairman@gcaa.gov.ae', NULL, NULL, N'COP\DGO', N'deputy.chairman', NULL, N'Deputy Chairman', NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'DeskCenAdmin', NULL, NULL, NULL, NULL, N'DeskCenAdmin', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Devarajan Chalappurath (SZC)', N'devarajan@szc.gcaa.ae', N'+971501328677', N'gregkurten', N'ANS>CNS', N'devarajan', N'Gregory John Kurten (SZC)', N'Senior Maintenance Technician', N'000546')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'DeviceLockAdmin', NULL, NULL, NULL, NULL, N'DeviceLockAdmin', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'DG Contacts', N'dgcontact@gcaa.gov.ae', NULL, NULL, NULL, N'dgcontact', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'DG Secretary', N'dg.secretary@gcaa.gov.ae', N'+971504540495', NULL, N'DGOO', N'dg.secretary', NULL, N'DG Secretary', NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'DG Secretary Dubai', N'dgsecdxb@gcaa.gov.ae', N'+971504540495', NULL, N'DGOO', N'dgsecdxb', NULL, N'DG Secretary', NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'DG’s office', N'dgoffice@gcaa.gov.ae', NULL, NULL, N'DG Office', N'dgoffice', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Dhoha Alhammadi', N'dalhammadi@gcaa.gov.ae', NULL, N'laila', N'SIA>COC', N'dalhammadi', N'Laila Ali Al Muhairi', N'Executive Corporate Communication', N'985')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Dirch Jans (SZC)', N'djans@szc.gcaa.ae', N'+971502294085', N'mdolbey', N'ANS>ATM', N'djans', N'Mike Dolbey', N'ATC Officer', N'000613')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Director General', N'dg@gcaa.gov.ae', N'+971506451010', N'dg', N'DGOO', N'dg', N'Director General', N'Director General', N'000316')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Director General dxb', N'dgdxb@gcaa.gov.ae', NULL, NULL, N'COP\DGO', N'dgdxb', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Dirk Kotze (SZC)', N'dkotze@szc.gcaa.ae', NULL, N'oabdouli', N'ANS> ATM', N'dkotze', N'Omar Obaid Al Abdouli (SZC)', N'AIR TRAFFIC CONTROL OFFICER', N'000976')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Discovery Search Mailbox', N'DiscoverySearchMailbox{D919BA05-46A6-415f-80AD-7E09334BB852}@gcaa.gov.ae', NULL, NULL, NULL, N'SM_f59deaca027e436e8', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'dladmin', NULL, NULL, NULL, NULL, N'dladmin', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'DMLDATA', N'dmldata@gcaa.gov.ae', NULL, NULL, NULL, N'dmldata', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Dominic Victoria (SZC)', N'dvictoria@szc.gcaa.ae', N'+971504933375', N'vpabraham', N'ANS>ATC', N'dvictoria', N'Abraham Vadakkekalam Pothen (SZC)', N'ATCA', N'000926')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Don Peduru', N'dpeduru@gcaa.gov.ae', NULL, N'schelakara', N'SUPS>FAPD', N'dpeduru', N'Subharaman Chelakara', N'Accountant', N'001181')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'donotreply@gcaa.gov.ae', N'donotreply@gcaa.gov.ae', NULL, NULL, NULL, N'donotreply', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Dorian Beller (SZC)', N'dbeller@szc.gcaa.ae', N'+971508003623', N'oabdouli', N'ANS>ATM', N'dbeller', N'Omar Obaid Al Abdouli (SZC)', N'ATC Officer', N'000914')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Douglas Ormston (SZC)', N'dormston@szc.gcaa.ae', NULL, NULL, N'ANS>ATM', N'dormston', NULL, N'ATCO', NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Douglas Ridgeway (SZC)', N'douglas.ridgeway@szc.gcaa.ae', N'+971558854285', N'oabdouli', N'ANS> ATM', N'dridgeway', N'Omar Obaid Al Abdouli (SZC)', N'ATCO', N'000835')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'DPMAdmin', NULL, NULL, NULL, NULL, N'DPMAdmin', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'DPMSQLSVCSACCT', NULL, NULL, NULL, NULL, N'DPMSQLSVCSACCT', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Dr. Ismahan Sabt', N'isabt@gcaa.gov.ae', NULL, N'nabila', N'SAFS>LICD', N'isabt', N'Dr. Nabila Mohammd Saeed', N'AEROMEDICAL INSPECTOR', N'1004')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Dr. Luay Yaseen Al Azzawi', N'lalazzawi@gcaa.gov.ae', N'+971504436317', N'nabila', N'SAFS>LICD', N'lalazzawi', N'Dr. Nabila Mohammd Saeed', N'Aeromedical Inspector', N'001136')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Dr. Nabila Mohammd Saeed', N'nabila@gcaa.gov.ae', N'+971508110372', N'salzara', N'SAFS>LICD', N'nabila', N'Sultan Mohamed Al Zara', N'Head - Aeromedical Section', N'000167')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Dr. Safia Anwar', N'sanwar@gcaa.gov.ae', NULL, NULL, N'SAFS>LICD', N'sanwar', NULL, N'Aero Medical Physician', N'000686')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Dr. Waleed Hassan Al Naqbi', N'walnaqbi@gcaa.gov.ae', NULL, N'aahli', N'SUPS>HCD', N'walnaqbi', N'Amina Ahli', N'Manager - Employee Relations and Payroll', N'000952')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Dr. Zeeba Abdulla Al Marzouqi', N'zeeba@gcaa.gov.ae', N'+971506136057', N'nabila', N'SAFS>LICD', N'zeeba', N'Dr. Nabila Mohammd Saeed', N'Aero Medical Physician', N'000404')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Drones', N'drones@gcaa.gov.ae', NULL, NULL, NULL, N'drones', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Dutyinspector', N'dutyinspector@gcaa.gov.ae', N'+971506414667', NULL, NULL, N'dutyinspector', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'DXB-Approvals', N'dxbapprovals@gcaa.gov.ae', NULL, NULL, NULL, N'dxbapprovals', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'dxbtest1', N'dxbtest1@gcaa.gov.ae', NULL, NULL, NULL, N'dxbtest1', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'dxbtest2', N'dxbtest2@gcaa.gov.ae', NULL, NULL, NULL, N'dxbtest2', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'DynaT Admin', NULL, NULL, NULL, NULL, N'dynatadmin', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'E Job', N'ejob@gcaa.gov.ae', NULL, NULL, NULL, N'ejob', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'E-Helpdesk', N'ehelpdesk@gcaa.gov.ae', NULL, NULL, N'DFA\IT', N'e-helpdesk', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'E-Medical', N'emedical@gcaa.gov.ae', NULL, NULL, NULL, N'emedical', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'EAAdmin', NULL, NULL, NULL, NULL, N'eaadmin', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'EAAdmin2', NULL, NULL, NULL, NULL, N'eaadmin2', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'eaadmin3', NULL, NULL, NULL, NULL, N'eaadmin3', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'EDARTI', N'edarti@gcaa.gov.ae', NULL, NULL, NULL, N'edariti', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'EDarti Admin', NULL, NULL, NULL, NULL, N'edartiadmin', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'egadmin', NULL, NULL, NULL, NULL, N'egadmin', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Eisa Al Blooshi (SZC)', N'eblooshi@szc.gcaa.ae', NULL, N'htenaiji', N'ANS> ATM', N'eblooshi', N'Hesham Mohamed Al Tenaiji (SZC)', N'ATC Trainee', N'000787')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Eisa Saeed Al Mesmari', N'emesmari@gcaa.gov.ae', N'+971505407746', N'hdibian', N'SAFS>AWRD', N'emesmari', N'Hatem Mohamed Dibian', N'Inspection Officer - Airworthiness', N'000244')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Electronic Letters', N'eletter@gcaa.gov.ae', NULL, NULL, NULL, N'eletter', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'elg', N'elg@gcaa.gov.ae', NULL, NULL, NULL, N'elg', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Elham Khalil El Khardagi', N'ekhordagui@gcaa.gov.ae', N'+971504540495', N'sshamsi', N'SIAS>EXAC', N'ekhordagui', N'Salem Jassim Al Shamsi', N'Senior Executive - External Affairs', N'000307')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Elias Nikolaidis', N'en@gcaa.gov.ae', N'+971506157002', N'kalraisi', N'AAIS', N'enikolaidis', N'Khalid Walid Al Raisi', N'Chief Air Accident Investigator', N'000422')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'elicensing', N'elicensing@gcaa.gov.ae', NULL, NULL, N' ', N'elicensing', NULL, N'elicensing', NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Elvis Lobo (SZC)', N'elobo@szc.gcaa.ae', N'+971503826367', N'vpabraham', N'ANS>ATC', N'elobo', N'Abraham Vadakkekalam Pothen (SZC)', N'ATCA', N'000927')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'EMAdmin', NULL, NULL, NULL, NULL, N'emadmin', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Eman Alhajeri', N'ealhajeri@gcaa.gov.ae', NULL, N'khalid', N'SIA>ATP', N'ealhajeri', N'Khalid Humaid Al Ali', N'Admin  Assistant', N'994')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Eman Mohamed Al Mesafri', N'eman.almesafri@gcaa.gov.ae', N'+971503700038,+971562192358', N'salzara', N'SAFS>LICD', N'emesafari', N'Sultan Mohamed Al Zara', N'Head - Administration and Examination', N'000254')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'EMCSourceOne', N'EMCSourceOne@gcaa.gov.ae', NULL, NULL, NULL, N'EMCSourceOne', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'EMCSourceOne02', N'EMCSourceOne02@gcaa.gov.ae', NULL, NULL, NULL, N'EMCSourceOne02', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'EMCSourceOne03', N'EMCSourceOne03@gcaa.gov.ae', NULL, NULL, NULL, N'EMCSourceOne03', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'EMCSourceOneDXB', N'EMCSourceOneDXB@gcaa.gov.ae', NULL, NULL, NULL, N'EMCSourceOneDXB', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Emergency Crisis Team', N'ect.ncema@gcaa.gov.ae', NULL, NULL, NULL, N'ect.ncema', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'emirates test', N'smoazzam@gcaa.ae', NULL, NULL, NULL, N'asis1', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Emirates WebService', NULL, NULL, NULL, NULL, N'emirates', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Employee care', N'ec@gcaa.gov.ae', NULL, NULL, NULL, N'ec', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Engineer 1', N'eng1@gcaa.gov.ae', NULL, NULL, NULL, N'eng1', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Engineer 2', N'eng2@gcaa.gov.ae', NULL, NULL, NULL, N'eng2', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Engineer 3', N'eng3@gcaa.gov.ae', NULL, NULL, NULL, N'eng 3', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Engineering Secretary', N'eng-sec@gcaa.gov.ae', NULL, NULL, NULL, N'eng-sec', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Entisar Essa AlFalasi', N'eealfalasi@gcaa.gov.ae', NULL, N'saeed.alsuwaidi', N'DGOO', N'eealfalasi', N'Saeed Mohd Al Suwaidi', N'Manager - Chairman Office', NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'ePayment', N'epayment@gcaa.gov.ae', NULL, NULL, NULL, N'epayment', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'epaymentfss', N'epaymentfss@gcaa.gov.ae', NULL, NULL, NULL, N'epaymentfss', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'epoadmin', NULL, NULL, NULL, NULL, N'epoadmin', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Eral John Lat (SZC)', N'elat@szc.gcaa.ae', N'+971507112470', N'hbelushi', N'ANS>ATM', N'elat', N'Hamad Bin Rashid Al Belushi (SZC)', N'Aircraft Database Assistant', N'000559')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Eric Michael Faulk (SZC)', N'efaulk@szc.gcaa.ae', N'+971566010318', N'oabdouli', N'ANS>ATM', N'efaulk', N'Omar Obaid Al Abdouli (SZC)', N'ATC Officer', N'000583')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Erik Lars Juhlin (SZC)', N'ejuhlin@szc.gcaa.ae', N'+971505960372', N'htenaiji', N'ANS>TRN', N'ejuhlin', N'Hesham Mohamed Al Tenaiji (SZC)', N'ATS Instructor', N'000556')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'erphpsm', N'erphpsm@gcaa.gov.ae', NULL, NULL, NULL, N'erphpsm', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Eservicefees', N'eservicefees@gcaa.gov.ae', NULL, NULL, NULL, N'eservicefees', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'EServices Vendor', NULL, NULL, NULL, NULL, N'esvendor', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Eva Dogg Gudmundsdottir (SZC)', N'eva.gudmundsdottir@szc.gcaa.ae', NULL, N'oabdouli', N'ANS> ATM', N'edgudmundsdottir', N'Omar Obaid Al Abdouli (SZC)', N'ATCO', N'000833')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Events', N'events@gcaa.gov.ae', NULL, NULL, NULL, N'events', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Ex2010Test', N'Ex2010Test@gcaa.gov.ae', NULL, NULL, NULL, N'Ex2010Test', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Example Administrator - UNITY01-DXB', N'EAdmin609f71d5@gcaa.gov.ae', NULL, NULL, NULL, N'EAdmin609f71d5', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Exceed Test', N'exceedtest@gcaa.gov.ae', NULL, NULL, NULL, N'exceedtest', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'exceedtest2', NULL, NULL, NULL, NULL, N'exceedtest2', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Exchadmin', N'Exchadmin@gcaa.gov.ae', NULL, NULL, NULL, N'Exchadmin', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Exchange Master', NULL, NULL, NULL, NULL, N'exchmaster', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Exchange2010 Administrator', NULL, NULL, NULL, NULL, N'exch2010admin', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'ExchCluster', NULL, NULL, NULL, NULL, N'ExchCluster', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Exchservice', NULL, NULL, NULL, NULL, N'exchservice', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'ExternalAffairs', N'ExternalAffairs@gcaa.gov.ae', NULL, NULL, NULL, N'ExternalAffairs', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Fabil Ummer (SZC)', N'fummer@szc.gcaa.ae', NULL, N'gregkurten', N'ANS>CNS', N'fummer', N'Gregory John Kurten (SZC)', N'CNS Senior Electronics Technician', N'987')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Fahad Abdulrahman AlRais', N'fahad@gcaa.gov.ae', N'+97150 2522295', N'sshamsi', N'SIAS>EXAC', N'fahad', N'Salem Jassim Al Shamsi', N'Senior Executive - External Affairs', N'000638')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Faisal Ambalath (SZC)', N'afaisal@szc.gcaa.ae', NULL, N'vpabraham', N'ANS>ATM', N'afaisal', N'Abraham Vadakkekalam Pothen (SZC)', N'ATC Assistant', N'000111')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Faisal Ibrahim Al Khaja (SZC)', N'fkhaja@szc.gcaa.ae', N'+971506424812', N'frobert', N'ANS>ATM', N'fkhaja', N'Francois Robert (SZC)', N'Senior  Specialist Unit Operations', N'000122')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Faisal Salem', N'fsalem@gcaa.gov.ae', NULL, N'ialmazmi', N'API', N'fsalem', N'Ismail Al Mazmi', N'Call Centre Agent', N'000880')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Faizan Shaikh', N'fshaikh@gcaa.gov.ae', N'+971529842787', N'mj', N'SUPS>ITD', N'fshaikh', N'Mohammed Jameeluddin', N'Software Engineer', N'001168')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Farah Al Ali', N'farah@gcaa.gov.ae', NULL, N'saeed.alsuwaidi', N'DG OFFICE', N'farah', N'Saeed Mohd Al Suwaidi', N'Senior Specialist Customer Service', N'1014')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Farid Al Olaqi (SZC)', N'falolaqi@szc.gcaa.ae', N'+971552967132', N'htenaiji', N'ANS>ATM', N'falolaqi', N'Hesham Mohamed Al Tenaiji (SZC)', N'ATC Assistant', NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Fatema Hasan Al Shehhi', N'fshehhi@gcaa.gov.ae', NULL, N'KYousuf', N'API', N'fshehhi', N'Khalid Yousuf', N'API Relation Admin', N'000275')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Faten Mohd Abu Zahra', N'faten.mohd@gcaa.gov.ae', N'+971506389002', N'khalid', N'SIAS>ATPD', N'faten.mohd', N'Khalid Humaid Al Ali', N'Admin officer  - air transport', N'000151')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Fatima Abdalla Al Ali', N'falali@gcaa.gov.ae', N'+971505691123', N'emesafari', N'SAFS>LICD', N'falali', N'Eman Mohamed Al Mesafri', N'Admin Assistant (Licensing)', N'000354')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Fatima Al Alawi', N'falawi@gcaa.gov.ae', NULL, N'nissreen', N'HCD>TNDC', N'falawi', N'Nissreen Ibrahim', N'Senior Training & Development Officer', N'000847')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Fatima Al Darmaki', N'faldarmaki@gcaa.gov.ae', NULL, N'nasser.al-marzouqi', N'SUPS>FAPD', N'faldarmaki', N'Nasser Ahmed Al Marzouqi', N'Receptionist', N'000940')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Fatima Khalifa (SZC)', N'fkhalifa@szc.gcaa.ae', NULL, N'vpabraham', N'ANS> ATM', N'fkhalifa', N'Abraham Vadakkekalam Pothen (SZC)', N'Air Traffic Control Assistant', N'000981')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Fatima Salim Al Mansouri', N'falmansouri@gcaa.gov.ae', N'+971508039335', N'emesafari', N'SAFS>LICD', N'falmansouri', N'Eman Mohamed Al Mesafri', N'Admin Assistant (Admin & Exam)', N'000375')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Fatma Abdulla', N'fabdulla@gcaa.gov.ae', N'+971508411198', N'sqadeer', N'SIAS>CSPD', N'fabdulla', N'Shahid Qadeer', N'Planning Chief officer', N'000757')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Favas P.', N'pfavas@gcaa.gov.ae', N'00971502807058', NULL, N'SAFS>FOPD', N'pfavas', NULL, N'Admin Assistant', N'001025')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Fayaz Ahmed Aboo', N'fayaz@gcaa.gov.ae', N'+971506154336', N'khalid.al-romaithi', N'SUP>ASS', N'fayaz', N'Khaled Sultan Al Romaithi', N'Procurement Assistant', N'000434')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Fazal Mohammed AliBaksh', N'Fazala@gcaa.gov.ae', N'+971566165507', N'kalraisi', N'AAIS', N'Fazala', N'Khalid Walid Al Raisi', N'Sr Air Accident Investigator', N'000656')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'fdoffice', NULL, NULL, NULL, NULL, N'fdoffice', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Felix DcCosta (SZC)', N'fdcosta@szc.gcaa.ae', N'+971503144751', N'vpabraham', N'ANS>ATM', N'fdcosta', N'Abraham Vadakkekalam Pothen (SZC)', N'ATC Assistant', N'000585')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'FileTest', N'Filetest@gcaa.gov.ae', NULL, NULL, NULL, N'Filetest', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Filtering Account', N'filteringacc@gcaa.gov.ae', NULL, NULL, NULL, N'filteringacc', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Finance', N'finance@gcaa.gov.ae', NULL, NULL, NULL, N'finance', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Finance Backup', NULL, NULL, NULL, NULL, N'finbkup', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'finance fax', N'finance-fax@gcaa.gov.ae', NULL, NULL, NULL, N'finance-fax', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Flight Operations', N'fops@gcaa.gov.ae', NULL, NULL, NULL, N'fops', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'FOA', N'foa@gcaa.gov.ae', NULL, NULL, NULL, N'foa', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'foarosi', N'foarosi@gcaa.gov.ae', NULL, NULL, N'SAFS>FOPD', N'foarosi', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'fortigate', NULL, NULL, NULL, NULL, N'fortigate', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Francois Robert (SZC)', N'frobert@szc.gcaa.ae', N'+971564138213', N'hbelushi', N'ANS>ATM', N'frobert', N'Hamad Bin Rashid Al Belushi (SZC)', N'Manager Air Traffic Control', N'000947')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Fransico Demelo', N'fdemelo@szc.gcaa.ae', N'+971508295091', N'jammari', N'ANS>CNS', N'fdemelo', N'Jacob Ammari (SZC)', N'Technician (CNS)', N'000414')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'fsadmin', NULL, NULL, NULL, NULL, N'fsadmin', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Gary Newman', N'gnewman@gcaa.gov.ae', N'+971564186952', N'michael.hayes', N'SAFS>ANAD', N'gnewman', N'Michael Edward Hayes', N'Airspace Inspector - Air Navigation', N'000885')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Gary Toye (SZC)', N'gtoye@szc.gcaa.ae', NULL, N'oabdouli', N'ANS>ATM', N'gtoye', N'Omar Obaid Al Abdouli (SZC)', N'ATC Officer', N'000916')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'GCAA ANA', N'ana@gcaa.gov.ae', NULL, NULL, NULL, N'ans.reg', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'GCAA Chairman', N'chairman@gcaa.gov.ae', NULL, NULL, N'DG office', N'chairman', NULL, N'Chairman', N'000939')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'GCAA Contact Admin', N'contactadmin@gcaa.ae', NULL, NULL, NULL, N'contactadmin', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'GCAA ERP - System Administrator', N'mdgpadmin@gcaa.gov.ae', NULL, NULL, NULL, N'mdgpadmin', NULL, N'GCAA ERP - System Administrator', NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'GCAA Human Resources', N'hrnotification@gcaa.gov.ae', NULL, NULL, NULL, N'hrnotification', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'GCAA Intranet Portal Administrator', N'SPSAdmin@gcaa.gov.ae', NULL, NULL, NULL, N'spsadmin', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'GCAA Leave Request', N'essnotifications@gcaa.gov.ae', NULL, NULL, NULL, N'essnotifications', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'GCAA Newsletter', N'Newsletter@gcaa.gov.ae', NULL, NULL, NULL, N'newsletter', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'GCAA Portal Hotel Request', N'spshotel@gcaa.gov.ae', NULL, NULL, NULL, N'spshotel', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'GCAA Portal Material Request', N'spsmaterial@gcaa.gov.ae', NULL, NULL, NULL, N'spsmaterial', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'GCAA Portal Material Requisition', N'MReqnotifications@gcaa.gov.ae', NULL, NULL, NULL, N'GCAAPortalMaterial', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'GCAA Portal Member', N'gipmember@gcaa.gov.ae', NULL, NULL, N' ', N'gipmember', NULL, N'GCAA Portal Member', NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'GCAA Portal Transport Request', N'spstransport@gcaa.gov.ae', NULL, NULL, NULL, N'spstransport', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Gcaa Portal Visitor', N'gipvisitor@gcaa.gov.ae', NULL, NULL, N' ', N'gipvisitor', NULL, N'Gcaa Portal Visitor', NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'GCAA Recruitment', N'rec.sa@gcaa.gov.ae', NULL, NULL, NULL, N'recsa', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'GCAA SN Account', N'gcaa_sn_account@gcaa.gov.ae', NULL, NULL, NULL, N'gcaa_sn_account', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'GCAA Survey', N'GCAASurvey@gcaa.gov.ae', NULL, NULL, NULL, N'GCAAServey', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'gcaa2ksrv', N'gcaa2ksrv@gcaa.gov.ae', NULL, NULL, NULL, N'gcaa2ksrv', NULL, N'Domain Admin', NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'GCAABOX Notification', N'GCAABOXNotification@gcaa.gov.ae', NULL, NULL, NULL, N'GCAABOXNotification', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'gcaaeservices', N'gcaaeservice@gcaa.gov.ae', NULL, NULL, NULL, N'gcaaeservices', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'gcaafb', N'gcaafb@gcaa.gov.ae', NULL, NULL, NULL, N'gcaafb', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'gcaainsta', N'gcaainsta@gcaa.gov.ae', NULL, NULL, NULL, N'gcaainsta', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'gcaalivedep', NULL, NULL, NULL, NULL, N'gcaalivedep', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'GCAAOUADMIN', NULL, NULL, NULL, NULL, N'GCAAOUADMIN', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'gcaatwitter', N'gcaatwitter@gcaa.gov.ae', NULL, NULL, NULL, N'gcaatwitter', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'gcaayt', N'gcaayt@gcaa.gov.ae', NULL, NULL, NULL, N'gcaayt', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Geoffrey Farley (SZC)', N'gfarley@szc.gcaa.ae', NULL, N'oabdouli', N'ANS>ATM', N'gfarley', N'Omar Obaid Al Abdouli (SZC)', N'ATC Officer', N'000652')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'gfiadmin', N'gfiadmin@gcaa.gov.ae', NULL, NULL, NULL, N'gfiadmin', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Ghada Khalaf', N'gkhalaf@gcaa.gov.ae', NULL, N'walnaqbi', N'SUP>HCP', N'gkhalaf', N'Dr. Waleed Hassan Al Naqbi', N'Employee Relations Assistant', N'1185')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Ghanim Abdulla Hassan', N'gabdulla@gcaa.gov.ae', N'+971506535757', N'malsaadi', N'SAFS>FOPD', N'gabdulla', N'Mohammed Ahmed Al Saadi', N'Senior - Inspector Cabin Safety', N'000174')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Ghaya Eid Abdulla', N'ghayae@gcaa.gov.ae', N'+971505052228', N'emesafari', N'SAFS>LICD', N'ghayae', N'Eman Mohamed Al Mesafri', N'Admin Assistant (Admin & Exam)', N'000463')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Gideon Carstens (SZC)', N'gcarstens@szc.gcaa.ae', N'+971507120836', N'htenaiji', N'ANS>TRN', N'gcarstens', N'Hesham Mohamed Al Tenaiji (SZC)', N'Air Trafic Service Instructor', N'003037')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'gipprofile', NULL, NULL, NULL, NULL, N'gipprofile', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'gipsearch', NULL, NULL, NULL, NULL, N'gipsearch', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'gipservices', NULL, NULL, NULL, NULL, N'gipservices', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Girubashankar Sambandham (SZC)', N'gshankar@szc.gcaa.ae', N'+971551456590', N'hbelushi', N'ANS>ATM', N'gshankar', N'Hamad Bin Rashid Al Belushi (SZC)', N'Flight Data Senior Assistant', N'000618')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Goran Jevtic (SZC)', N'gjevtic@szc.gcaa.ae', N'+971503203919', N'oabdouli', N'ANS>ATM', N'gjevtic', N'Omar Obaid Al Abdouli (SZC)', N'ATC watch Supervisor', N'000953')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Govind Menon', N'gmenon@gcaa.gov.ae', N'+971508592588', N'nibrahim', N'SUPS>LGLD', N'gmenon', N'Nadia Ibrahim AlMaazmi', N'Lawyer', N'000704')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Gregg Bird (SZC)', N'gbird@szc.gcaa.ae', NULL, N'oabdouli', N'ATMD', N'gbird', N'Omar Obaid Al Abdouli (SZC)', N'ATCO', NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Gregg Reven (SZC)', N'greven@szc.gcaa.ae', NULL, N'vpabraham', N'ANS>ATM', N'greven', N'Abraham Vadakkekalam Pothen (SZC)', N'AIR TRAFFIC CONTROL ASSISTANT', N'001003')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Gregory John Kurten (SZC)', N'gregkurten@szc.gcaa.ae', N'+971506148183', N'aljallaf', N'ANS>CNS', N'gregkurten', N'Ahmed Ibrahim Al Jallaf', N'Acting Director -Communication Navigation Surveillance', N'000506')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Gregory Sydney Pereira (SZC)', N'gpereira@szc.gcaa.ae', N'+971507815819', N'gregkurten', N'ANS>CNS', N'gpereira', N'Gregory John Kurten (SZC)', N'Senior Maintenance Technician', N'000358')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Gustavo Barba', N'gbarba@gcaa.gov.ae', N'+971562190118', N'wrahmani', N'SAFS>PRED', N'gbarba', N'Walid Ibrahim Al Rahmani', N'Manager - Policy and Regulation', N'000685')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Habeeba Ali Al Towaiti (SZC)', N'haltowaiti@szc.gcaa.ae', N'+971 50 3747579', N'hbelushi', N'ANS>ATM', N'haltowaiti', N'Hamad Bin Rashid Al Belushi (SZC)', N'Senior Flight Data Assistant', N'000770')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Habib Ahmed Ahmed (SZC)', N'hahmed@szc.gcaa.ae', N'+971504925161', N'vpabraham', N'ANS>ATM', N'hahmed', N'Abraham Vadakkekalam Pothen (SZC)', N'ATC Assistant', N'000109')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Hafsa Abdalla Al Ali', N'hafsa@gcaa.gov.ae', N'+971507374414', N'emesafari', N'SAFS>LICD', N'hafsa', N'Eman Mohamed Al Mesafri', N'Admin Assistant – Admin & Exam', N'000612')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Hajar Ismaeel Al Marazeq', N'hmarazeeq@gcaa.gov.ae', N'+971504664114', N'emesafari', N'SAFS>LICD', N'hmarazeeq', N'Eman Mohamed Al Mesafri', N'Admin Assistant (Licensing)', N'000474')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Hallvard Borsheim (SZC)', N'hborsheim@szc.gcaa.ae', N'+971553039111', N'oabdouli', N'ANS>ATM', N'hborsheim', N'Omar Obaid Al Abdouli (SZC)', N'ATC Officer', N'000919')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Hamad Abdulla Al Braiki', N'halbraiki@gcaa.gov.ae', NULL, N'salzara', N'SAFS>LICD', N'halbraiki', N'Sultan Mohamed Al Zara', N'ATC Licensing Officer', N'000582')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Hamad Al Ali', N'halali@gcaa.gov.ae', N'+971566770859', N'aaljanahi', N'SAFS>FOPD', N'halali', N'Ahmed Al Janahi', N'Inspector - Foreign Operators', N'000791')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Hamad Al Kaabi', N'halkaabi@gcaa.gov.ae', N'+971506199622', N'ialmazmi', N'API', N'halkaabi', N'Ismail Al Mazmi', N'Call Center Officer', N'000849')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Hamad Al Mutawa', N'hmutawa@gcaa.gov.ae', N'+971504436298', N'salzara', N'SAFS>LICD', N'hmutawa', N'Sultan Mohamed Al Zara', N'ATC Inspector', N'000764')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Hamad Al Yammahi', N'halyammahi@gcaa.gov.ae', N'971507766299', N'ialmazmi', N'API', N'halyammahi', N'Ismail Al Mazmi', N'Call Centre Agent', N'000879')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Hamad Bin Rashid Al Belushi (SZC)', N'hbelushi@szc.gcaa.ae', N'+971506164350', N'aljallaf', N'ANS>ATM', N'hbelushi', N'Ahmed Ibrahim Al Jallaf', N'Manager Air Traffic Management', N'000185')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Hamad Rashed Markhan', N'hmarkhan@gcaa.gov.ae', N'+971508844511', N'saeed.alsuwaidi', N'Customer Services', N'hmarkhan', N'Saeed Mohd Al Suwaidi', N'Customer Services Officer', N'000636')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Hamad Salem Al Muhairi', N'hamad.almuhairi@gcaa.gov.ae', N'+971508130142', N'dg', N'SECS>OIND', N'hamad.almuhairi', N'Director General', N'Asst Dir Genl Avi Security Aff', N'000159')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Hamad Suhail Al Awadhi', N'halawadhi@gcaa.gov.ae', N'+971507686767', N'salmuhairi', N'SUPS>HCD', N'halawadhi', N'Shamsa Al Muhairi', N'Manpower and Recruitment Officer', N'000676')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Hamda Tarish Al Qamzi', N'halqamzi@gcaa.gov.ae', NULL, N'khalid.al-romaithi', N'SUP>ASS', N'halqamzi', N'Khaled Sultan Al Romaithi', N'Procurement officer', N'000374')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Hamed Ali Al Zubaid (SZC)', N'hzubaidi@szc.gcaa.ae', N'+971509333360', N'oabdouli', N'ANS>TRN', N'hzubaidi', N'Omar Obaid Al Abdouli (SZC)', N'ATCO', N'000416')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Hamed Sada', N'hsada@gcaa.gov.ae', NULL, NULL, N'SIA>COD', N'hsada', NULL, N'Journalist', N'001180')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Hamid Jamil', N'hjamil@gcaa.gov.ae', N'+971508186040', N'pking', N'SECS>OIND', N'hjamil', N'Paul Ronald King', N'Sr. Security & Dang. Goods Ins', N'000386')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Hamid Maqsood Hayat (SZC)', N'hmaqsood@szc.gcaa.ae', NULL, N'vpabraham', N'ANS>ATC', N'hmaqsood', N'Abraham Vadakkekalam Pothen (SZC)', N'ATCA Supervisor', N'000928')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Hanadi Al Marzooqi', N'halmarzooqi@gcaa.gov.ae', NULL, N'psayeed', N'SECS>OIND', N'halmarzooqi', N'Parvez Mohammad Sayeed', N'Admin Assistant', N'000959')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Hanadi Al Mheiri (SZC)', N'hghlaitah@szc.gcaa.ae', NULL, N'htenaiji', N'ANS>TRAINING', N'halmheiri', N'Hesham Mohamed Al Tenaiji (SZC)', N'Admin Officer', N'000988')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Hanan Mohammed Bahajri', N'hanan.mohd@gcaa.gov.ae', N'+971506159538', NULL, NULL, N'hanan.mohd', NULL, NULL, N'000106')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Hani Tolba', N'htolba@gcaa.gov.ae', N'00971553199199', N'nibrahim', N'SUPS>LGLD', N'htolba', N'Nadia Ibrahim AlMaazmi', N'Lawyer', N'000944')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Harith Al Shamsi (SZC)', N'hhshamsi@szc.gcaa.ae', NULL, N'htenaiji', N'ANS>ATM', N'hhshamsi', N'Hesham Mohamed Al Tenaiji (SZC)', N'ATC Trainee', N'000730')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Harry Kilpe (SZC)', N'hkilpe@szc.gcaa.ae', NULL, N'mdolbey', N'ANS>ATM', N'hkilpe', N'Mike Dolbey', N'ATCO', NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Harun Abdur Rahman', N'harahman@gcaa.gov.ae', N'+971506425204', N'mj', N'SUPS>ITD', N'harahman', N'Mohammed Jameeluddin', N'Business Analyst', N'001166')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Hashem Alhashemi', N'halhashemi@gcaa.gov.ae', NULL, N'walnaqbi', N'SUP>HCP', N'halhashemi', N'Dr. Waleed Hassan Al Naqbi', N'Employee Relations - Officer', N'984')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Hassan Saleh Abdulla', N'habdulla@szc.gcaa.ae', N'+971507711781', N'oabdouli', N'ANS>ATC', N'habdulla', N'Omar Obaid Al Abdouli (SZC)', N'AIR TRAFFIC CONTROL OFFICER', N'000258')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Hatem Mohamed Dibian', N'hdibian@gcaa.gov.ae', N'+971506168835', N'azarouni', N'SAFS>AWRD', N'hdibian', N'Aqeel Ahmed Al Zarouni', N'Manager - Air Operators and CAMO', N'000321')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Hayfaa Abdulla Al Obaidli', N'hobaidli@gcaa.gov.ae', N'+971508128374', N'larandjelovic', N'SECS>PRPD', N'hobaidli', N'Ljiljana Arandjelovic', N'Senior Planning Specialist', N'000231')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Hemat Mostafa', N'hmostafa@gcaa.gov.ae', NULL, N'salmuhairi', N'HCD>MPRC', N'hmostafa', N'Shamsa Al Muhairi', N'Senior Recruitment Officer', N'000896')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Henry Kaiser Angel', N'hangel@gcaa.gov.ae', N'+971504460586', N'hdibian', N'SAFS>AWRD', N'hangel', N'Hatem Mohamed Dibian', N'Senior Inspector - Airworthiness', N'000494')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Herman Johan Groenewald', N'hermang@gcaa.gov.ae', N'+971506150872', N'michael.hayes', N'SAFS>ANAD', N'hermang', N'Michael Edward Hayes', N'Airspace Senior  Inspector -Air Navigation', N'000306')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Hesham Mohamed Al Tenaiji (SZC)', N'htenaiji@szc.gcaa.ae', N'+971507710277', N'aljallaf', N'ANS>ATM', N'htenaiji', N'Ahmed Ibrahim Al Jallaf', N'Acting Manager - ANSPT', N'000170')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Hewage Ravindra Perera (SZC)', N'hrperera@szc.gcaa.ae', N'00971567521431', N'jammari', N'ANS>CNS', N'hrperera', N'Jacob Ammari (SZC)', N'Maintenance Technician', N'000662')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Hind Bu Ali (SZC)', N'hbuali@szc.gcaa.ae', NULL, N'hbelushi', N'ANS> ATM', N'hbali', N'Hamad Bin Rashid Al Belushi (SZC)', N'Database Assistants', N'000870')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Hisham Abdulla Hablail', N'hisham@gcaa.gov.ae', N'+971504432548', N'oghannam', N'SAFS>AWRD', N'hisham', N'Omar Ahmad Bin Ghannam', N'Inspector - Airworthiness', N'000420')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'HPSRVMGMT', N'HPSRVMGMT@gcaa.gov.ae', NULL, N'nkhan', NULL, N'HPSRVMGMT', N'Naveed khan', N'Service Manager Admin', NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'hptest', N'hptest@gcaa.gov.ae', NULL, NULL, NULL, N'hptest', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'HR Capital/Training', N'training@gcaa.gov.ae', NULL, NULL, NULL, N'training', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'hrpolicies', N'HRPOLICIES@gcaa.gov.ae', NULL, NULL, NULL, N'hrpolicies', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Hrvoje Kovac (SZC)', N'hkovac@szc.gcaa.ae', NULL, N'frobert', N'ANS> ATM', N'hkovac', N'Francois Robert (SZC)', N'Air Traffic Control Officer', N'001141')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Huda Hashim Al Muaini', N'halmuaini@gcaa.gov.ae', N'+971507442113', N'emesafari', N'SAFS>LICD', N'halmuaini', N'Eman Mohamed Al Mesafri', N'Admin Assistant (Admin & Exam)', N'000372')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Humaid Al Mansoori (SZC)', N'hmansoori@szc.gcaa.ae', N'+971505410008', N'htenaiji', N'ANS>TRN', N'hmansoori', N'Hesham Mohamed Al Tenaiji (SZC)', N'Pseudo Pilot', N'000286')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Humaid Ali Al Jarwan (SZC)', N'hshamsi@szc.gcaa.ae', N'+971505768777', N'frobert', N'ANS>ATM', N'hshamsi', N'Francois Robert (SZC)', N'Senior ATC Supervisor', N'000149')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Human Capital', N'er@gcaa.gov.ae', NULL, NULL, NULL, N'er', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Human Capital/Awardqueries', N'Awardqueries@gcaa.gov.ae', NULL, NULL, NULL, N'Awardqueries', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Human Capital/Recruitment', N'recruitment@gcaa.gov.ae', NULL, NULL, NULL, N'recruitment', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Human Resources', N'hrd@gcaa.gov.ae', NULL, NULL, NULL, N'hrd', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Ian Mcdonald (SZC)', N'imcdonald@szc.gcaa.ae', N'0562179099', N'oabdouli', N'ANS>ATM', N'Imcdonald', N'Omar Obaid Al Abdouli (SZC)', N'ATC Officer', N'000693')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Ibrahim Ahmed Addasi', N'ialaddasi@gcaa.gov.ae', N'+971504431052', N'kalraisi', N'AAIS', N'ialaddasi', N'Khalid Walid Al Raisi', N'Chief Air Accident Investigator', N'000364')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Ibrahim Ahmed Al Naqbi', N'ianaqbi@gcaa.gov.ae', NULL, N'ialmazmi', N'API', N'ianaqbi', N'Ismail Al Mazmi', N'Call Center Agent', N'000826')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Ibrahim Almheiri', N'ialmheiri@gcaa.gov.ae', N'+971551022987', N'sshamsi', N'SIAS>EXAC', N'ialmheiri', N'Salem Jassim Al Shamsi', N'Assistant External Affairs', N'000963')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Ibrahim Mohammed Al Ali', N'ialali@gcaa.gov.ae', N'+971562192354', N'hdibian', N'SAFS>AWRD', N'ialali', N'Hatem Mohamed Dibian', N'Inspector - Airworthiness', N'000681')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'IDS4MFP2007', N'ids4mfp2007@gcaa.gov.ae', NULL, NULL, NULL, N'ids4mfp2007', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Imran Ali Bhatti', N'iabhatti@gcaa.gov.ae', NULL, N'mj', N'SUPS>ITD', N'iabhatti', N'Mohammed Jameeluddin', N'Software Engineer', N'001163')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Info', N'info@gcaa.gov.ae', NULL, NULL, NULL, N'info', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Info Aeronnovation', N'info@aeronnovation.ae', NULL, NULL, NULL, N'infoaeronnovation', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Info Futureaviators', N'info@futureaviators.ae', NULL, NULL, NULL, N'info_futureaviators', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'infofloxPOC', NULL, NULL, NULL, NULL, N'infobloxpoc', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'INNOVATE', N'innovate@gcaa.gov.ae', NULL, NULL, NULL, N'innovate', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Internal Audit', N'internalaudit@gcaa.gov.ae', NULL, NULL, NULL, N'internalaudit', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Internal System Notifications', N'do-not-reply@gcaa.gov.ae', NULL, NULL, NULL, N'do-not-reply', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Intranet Portal Super User', NULL, NULL, NULL, NULL, N'gipsuper', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'ipaduser1', N'ipaduser1@gcaa.gov.ae', NULL, NULL, NULL, N'ipaduser1', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'ipaduser2', N'ipaduser2@gcaa.gov.ae', NULL, NULL, NULL, N'ipaduser2', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'ipccadmin', NULL, NULL, NULL, NULL, N'ipccadmin', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Irfan Ullah (SZC)', N'iullah@szc.gcaa.ae', N'+97150-4298313', N'vpabraham', N'ANS>ATC', N'iullah', N'Abraham Vadakkekalam Pothen (SZC)', N'ATCA', N'000929')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'IronPort', NULL, NULL, NULL, NULL, N'ironport', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'isafeadmin', NULL, NULL, NULL, NULL, N'isafeadmin', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Isidore Sebastian Cabral (SZC)', N'icabral@szc.gcaa.ae', N'+971558343079', N'htenaiji', N'ANS>TRN', N'icabral', N'Hesham Mohamed Al Tenaiji (SZC)', N'Senior Pseudo Pilot', N'000616')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Ismaeil Mohamed Al Hosani', N'iwahed@gcaa.gov.ae', N'+971506612336', N'dg', N'AAIS', N'ismaeil.abdelwahed', N'Director General', N'Asst Dir Genl Air Accident Inv', N'000116')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Ismaeil Mohammed Al Blooshi', N'iblooshi@gcaa.gov.ae', N'+971506677138', N'dg', N'SAFS', N'emaaa', N'Director General', N'Asst. Dir Genl Avi Safety Aff', N'000100')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Ismail Abdulla Al Mutawa', N'ialmutawa@gcaa.gov.ae', N'+971506524336', N'malsaadi', N'SAFS>FOPD', N'ialmutawa', N'Mohammed Ahmed Al Saadi', N'Senior Inspector – Flight Operations', N'000385')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Ismail Al Mazmi', N'ialmazmi@gcaa.gov.ae', N'+971505522113', N'laila', N'ACRC', N'ialmazmi', N'Laila Ali Al Muhairi', N'API UAE Project Manager', N'001121')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Israe Abdulmonem Abbas', N'iabbas@gcaa.gov.ae', N'+971566164021', N'laila', N'SIAS>COCC', N'iabbas', N'Laila Ali Al Muhairi', N'Senior Executive Communication', N'000637')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Issa Abdel Ahad', N'iaahad@gcaa.gov.ae', N'+971506420560', N'laila', N'SIAS>CODD', N'iaahad', N'Laila Ali Al Muhairi', N'Acting Corporate Development Director & Corporate Development Sp', N'000793')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Issa Khalfan Al Rawahi', N'ialrawahi@gcaa.gov.ae', N'+971506621934', N'oghannam', N'SAFS>AWRD', N'ialrawahi', N'Omar Ahmad Bin Ghannam', N'Senior Inspector - Airworthiness', N'000384')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Issue Tracker', N'Issuetracker@gcaa.gov.ae', NULL, NULL, NULL, N'issuetracker', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'IT Audit', NULL, NULL, NULL, NULL, N'itaudit', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'IT Department', N'itd@gcaa.gov.ae', NULL, N'test1', N' ', N'itd', N'test1', NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'IT Helpdesk', N'helpdesk@gcaa.gov.ae', NULL, NULL, NULL, N'helpdesk', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'IT Helpdesk System', N'ITHelpdeskSystem@gcaa.gov.ae', NULL, NULL, NULL, N'ITHelpdeskSystem', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'IT Helpdesk Systems', N'ITHelpdeskSystems@gcaa.gov.ae', NULL, NULL, NULL, N'ITHelpdeskSystems', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'ITA', N'ITA@gcaa.gov.ae', NULL, NULL, NULL, N'ITA', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'ITtest', N'ittest@gcaa.gov.ae', N'45234235235', NULL, NULL, N'ittest', NULL, N'IT Technician -testing', NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'ittestauh GCAA', N'ittestauh@gcaa.gov.ae', NULL, NULL, NULL, N'ittestauh', NULL, N'Test profile', N'9999')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'ittestdxb GCAA', N'ittestdxb@gcaa.gov.ae', N'+971557765886', NULL, NULL, N'ittestdxb', NULL, NULL, N'999900')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Jabin Ram Jayaram (SZC)', N'jabin@szc.gcaa.ae', N'+971508991261', N'gregkurten', N'ANS>CNS', N'jabin', N'Gregory John Kurten (SZC)', N'Senior Maintenance Technician', N'000537')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Jack Keith Armstrong (SZC)', N'jarmstrong@szc.gcaa.ae', NULL, N'oabdouli', N'ANS>ATM', N'jarmstrong', N'Omar Obaid Al Abdouli (SZC)', N'AIR TRAFFIC CONTROL OFFICER', N'000630')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Jacob Ammari (SZC)', N'jammari@szc.gcaa.ae', N'+971504467482', N'gregkurten', N'ANS>CNS', N'jammari', N'Gregory John Kurten (SZC)', N'Head of Maintenance', N'000467')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Jamal Al Noumani', N'jalnoumani@gcaa.gov.ae', N'+971504486539', N'oghannam', N'SAFS>AWRD', N'jalnoumani', N'Omar Ahmad Bin Ghannam', N'Inspector - Airworthiness', N'000697')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'James Carrol (SZC)', N'jcarroll@szc.gcaa.ae', N'+971506898572', N'htenaiji', N'ANS>Training', N'jcarroll', N'Hesham Mohamed Al Tenaiji (SZC)', N'Air Traffic Service Instructor', N'000632')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'James E Buhl (SZC)', N'jbuhl@szc.gcaa.ae', N'+971504413092', NULL, N'ANS>ATC', N'jbuhl', NULL, N'ATCO', N'003146')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'James Graham', N'jgraham@gcaa.gov.ae', NULL, N'oghannam', N'SAFS>AWRD', N'jgraham', N'Omar Ahmad Bin Ghannam', N'INSPECTOR - AIRWORTHINESS', N'001022')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'James john Killeen (SZC)', N'jkilleen@szc.gcaa.ae', N'0562652504', N'oabdouli', N'ANS', N'jkilleen', N'Omar Obaid Al Abdouli (SZC)', N'ATC Officer', N'000712')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'James Michael Davin O''regan (SZC)', N'jdoregan@szc.gcaa.ae', NULL, N'oabdouli', N'ANS> ATM', N'jdoregan', N'Omar Obaid Al Abdouli (SZC)', N'ATC Officer', N'000917')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Jasem Mohamed Al Mansoori (SZC)', N'jmansoori@szc.gcaa.ae', N'+971505999319', N'oabdouli', N'ANS>ATM', N'jmansoori', N'Omar Obaid Al Abdouli (SZC)', N'ATC Officer', N'000260')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Jason Johnson (SZC)', N'jjohnson@szc.gcaa.ae', N'+971502650411', N'oabdouli', N'ANS>ATM', N'jjohnson', N'Omar Obaid Al Abdouli (SZC)', N'ATC Officer', N'000622')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Jawaher Al Shehhi', N'jalshehhi@gcaa.gov.ae', N'+9715 5062408', N'malhashemi', N'API', N'jalshehhi', N'Maryam Al Hashemi', N'Admin Officer', N'000780')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Jeremias Christiaan Malaihollo', N'jmalaihollo@gcaa.gov.ae', N'+971506130281', N'kalraisi', N'AAIS', N'jmalaihollo', N'Khalid Walid Al Raisi', N'Senior Air Accident Investigator', N'000495')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Jericho Raton', N'jraton@szc.gcaa.ae', NULL, N'vfernandes', N'ANS>AIS', N'jraton', N'Victor Mariano Fernandes (SZC)', N'NOTAM Assistant', N'001033')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Jessie Corpin Uy (SZC)', N'juy@szc.gcaa.ae', N'+917558013668', N'gregkurten', N'ANS>CNS', N'juy', N'Gregory John Kurten (SZC)', N'Senior Maintenance Technician', N'000634')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Jithesh Veleparambil Gopi (SZC)', N'Jitheshvg@szc.gcaa.ae', N'+971551863036', N'jammari', N'ANS>CNS', N'Jitheshvg', N'Jacob Ammari (SZC)', N'M&E Technician', N'000886')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Jo Michael (SZC)', N'jmichael@szc.gcaa.ae', N'+971566175885', N'vpabraham', N'ANS>ATC', N'jmichael', N'Abraham Vadakkekalam Pothen (SZC)', N'ATCA', N'000930')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'John Nicolau Fernandes (SZC)', N'jfernandes@szc.gcaa.ae', NULL, N'vpabraham', N'ANS>ATM', N'jfernandes', N'Abraham Vadakkekalam Pothen (SZC)', N'ATC Officer', N'000931')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'John Thomas Ogden (SZC)', N'jogden@szc.gcaa.ae', N'+971552993723', N'gregkurten', N'ANS>CNS', N'jogden', N'Gregory John Kurten (SZC)', N'CNS Engineer', N'000533')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Jose Manuel Vieira (SZC)', N'jvieira@szc.gcaa.ae', NULL, N'oabdouli', N'ANS', N'jvieira', N'Omar Obaid Al Abdouli (SZC)', N'ATC Officer', N'000713')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Joselito Flores Martinez', N'joselito.martinez@gcaa.gov.ae', N'+971508117845', N'schelakara', N'SUP>ASS', N'joselito.martinez', N'Subharaman Chelakara', N'ANS Revenue Accountant', N'000051')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Joseph D''Nazareth (SZC)', N'joednazareth@szc.gcaa.ae', N'+971505460424', N'gregkurten', N'ANS>CNS', N'joednazareth', N'Gregory John Kurten (SZC)', N'Senior Maintenance Technician', N'000357')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Joseph Makasi Wasike', N'jmwasike@gcaa.gov.ae', N'+971504458961', N'psayeed', N'SECS>OIND', N'jmwasike', N'Parvez Mohammad Sayeed', N'Aviation Security Inspector', N'000748')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Joseph Michael Bishop (SZC)', N'jbishop@szc.gcaa.ae', N'+971508830255', N'oabdouli', N'ANS>ATM', N'jbishop', N'Omar Obaid Al Abdouli (SZC)', N'ATC Officer', N'000526')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Jouhayna Al Mheiri (SZC)', N'JAlmheiri@szc.gcaa.ae', NULL, N'htenaiji', N'ANS>Training', N'jalmheiri', N'Hesham Mohamed Al Tenaiji (SZC)', N'ATC Trainee', N'000817')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Joumana Nazih Abu Said', N'jabusaid@gcaa.gov.ae', N'+971506674750', N'saeed.alsuwaidi', N'DGOO', N'Joumana.Abusaid', N'Saeed Mohd Al Suwaidi', N'Executive Assistant - DG office', N'000039')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Joy Mark Castillo (SZC)', N'jcastillo@szc.gcaa.ae', NULL, N'vfernandes', N'ANS>AIS', N'jcastillo', N'Victor Mariano Fernandes (SZC)', N'NOTAM Assistant', N'1027')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'jtac', NULL, NULL, NULL, NULL, N'jtac', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Juan Carlos Salazar', N'jsalazar@gcaa.gov.ae', N'+971508189247', N'khalid', N'SIAS>ATPD', N'jsalazar', N'Khalid Humaid Al Ali', N'Air Transport Advisor', N'000222')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Juan Van Der Merwe (SZC)', N'jvdmerwe@szc.gcaa.ae', NULL, N'gregkurten', N'ANS>CNS', N'jvdmerwe', N'Gregory John Kurten (SZC)', N'CNS Engineer', N'1019')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Karappath Usman', N'usman.karapath@gcaa.gov.ae', N'+971504145004', N'ismaeil.abdelwahed', N'AAIS', N'usman.karapath', N'Ismaeil Mohamed Al Hosani', N'Senior Officer - Administration and Planning', N'000004')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Karim Ullah Khan', N'karimkhan@gcaa.gov.ae', N'+97150 2044276', N'lhidalgo', N'SAFS>PRED', N'karimkhan', N'Luz Angelica Hidalgo', N'Admin Assistant (Aircraft Registry)', N'000602')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Karsten Primdahl Krogh (SZC)', N'kkrogh@szc.gcaa.ae', N'+971506729642', NULL, N'ANS>ATC', N'kkrogh', NULL, N'ATCO', N'003165')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Kawthar Alkindi', N'kalkindi@gcaa.gov.ae', NULL, N'walnaqbi', N'SUPS>HCD', N'kalkindi', N'Dr. Waleed Hassan Al Naqbi', N'OFFICER - EMPLOYEE ENGAGEMENT AND COMMUNICATION', N'982')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Kedar Prasad Pahadi', N'kppahadi@gcaa.gov.ae', N'0506217660', N'mohamed.butaweel', N'SAFS>FOPD', N'kppahadi', N'Mohamed Khamis Butaweel', N'Inspector – Flight Operations', N'000773')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Kedari Manthanwar (SZC)', N'kmanthanwar@szc.gcaa.ae', N'+971567698310', N'akaabi', N'ANS>AIS', N'kmanthanwar', N'Abdulla Salim Al Rashidi (SZC)', N'Head of AIS Design', N'000607')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Kettler Correya (SZC)', N'kcorreya@szc.gcaa.ae', N'+971507614080', N'jammari', N'ANS>CNS', N'kcorreya', N'Jacob Ammari (SZC)', N'Maintenance Technician', N'000053')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Khadeeja Al Hosani', N'kalhosani@gcaa.gov.ae', NULL, N'nissreen', N'HCD>TNDC', N'kalhosani', N'Nissreen Ibrahim', N'Admin Assistant', N'000846')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Khadija Al Naqbi', N'kalnaqbi@gcaa.gov.ae', NULL, N'mwoodward', N'DAS>ANA', N'kalnaqbi', N'Mark Edward Woodward', N'ADMIN ASSISTANT', N'960')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Khaled Ali Al Belooshi', N'kbelooshi@gcaa.gov.ae', N'+971506141882', N'larandjelovic', N'SECS>OIND', N'kbelooshi', N'Ljiljana Arandjelovic', N'Security Inspector', N'000486')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Khaled Sultan Al Romaithi', N'kromaithi@gcaa.gov.ae', N'+971507123452', N'omar', N'SUP>ASS', N'khalid.al-romaithi', N'Omar Ghaleb Bin Ghaleb', N'Manager - Procurement', N'000121')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Khalid Abdulrahim Al Mulla', N'kalmulla@gcaa.gov.ae', N'+971506423077', N'szeinal', N'SAFS>FOPD', N'kalmulla', N'Sayed zeinal', N'Flight Operation Technical Inspectpr', N'000819')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Khalid Ahmed Mousa', N'kmousa@gcaa.gov.ae', N'+971506147331', N'yazizi', N'SAFS>PRED', N'kmousa', N'Yousuf Hashim Al Azizi', N'Planning and Standards Specialist', N'000403')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Khalid Al Khalifa Al Husaini (SZC)', N'khusaini@szc.gcaa.ae', N'+971561294449', N'htenaiji', N'ANS>TRN', N'khusaini', N'Hesham Mohamed Al Tenaiji (SZC)', N'Pseudo Pilot', N'000241')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Khalid Al Mutawaa', N'kalmutawaa@gcaa.gov.ae', N'+971507473777', N'ialmazmi', N'API', N'kalmutawaa', N'Ismail Al Mazmi', N'Quality Assurance Manager – API Project', N'000591')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Khalid Ali Al Marri', N'kalmarri@gcaa.gov.ae', N'+971503660855', N'malsaadi', N'SAFS>FOPD', N'kalmarri', N'Mohammed Ahmed Al Saadi', N'Admin Assistant (Flight Ops)', N'000429')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Khalid Ebrahim Al Ali', N'kealali@gcaa.gov.ae', NULL, N'ialmazmi', N'API', N'kealali', N'Ismail Al Mazmi', N'Call Center Officer', N'000830')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Khalid Humaid Al Ali', N'khalid@gcaa.gov.ae', N'+971506420620', N'laila', N'SIAS>ATPD', N'khalid', N'Laila Ali Al Muhairi', N'Director Air Transport', N'000400')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Khalid Jaber (SZC)', N'kjaber@szc.gcaa.ae', N'+971506281765', N'htenaiji', N'ANS>TRN', N'kjaber', N'Hesham Mohamed Al Tenaiji (SZC)', N'Senior ATSI', N'000006')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Khalid Saud Al Humaidan', N'ksalhumaidan@gcaa.gov.ae', N'+971504460763', N'zmunawar', N'SAFS>AWRD', N'ksalhumaidan', N'Zahid Munawar', N'Inspector Engineering', N'000776')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Khalid Taher', N'ktaher@gcaa.gov.ae', N'00971557888864', N'malhashemi', N'API', N'ktaher', N'Maryam Al Hashemi', N'IT Specialist', N'000779')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Khalid Walid Al Raisi', N'kalraisi@gcaa.gov.ae', N'+971506153730', N'ismaeil.abdelwahed', N'AAIS', N'kalraisi', N'Ismaeil Mohamed Al Hosani', N'Director Air Accident Investigation', N'000097')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Khalid Yousuf', N'KYousuf@gcaa.gov.ae', N'+971506445568', N'ialmazmi', N'API', N'KYousuf', N'Ismail Al Mazmi', N'Carrier Relations Manager', N'000778')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Khalifa Mohammed Shehhi (SZC)', N'mshehhi@szc.gcaa.ae', N'+971503703313', N'vpabraham', N'ANS>ATC', N'mshehhi', N'Abraham Vadakkekalam Pothen (SZC)', N'ATCA', N'000196')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Khalifa Saif Al Sharqi', N'ksharqi@gcaa.gov.ae', N'0503999919', N'nibrahim', N'SUPS>LGLD', N'ksharqi', N'Nadia Ibrahim AlMaazmi', N'Junior Lawyer', N'000781')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Khawaja Asif Hanif (SZC)', N'akhawaja@szc.gcaa.ae', N'+971503195240', N'htenaiji', N'ANS>TRN', N'akhawaja', N'Hesham Mohamed Al Tenaiji (SZC)', N'Pseudo Pilot', N'000624')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Khawla Abdullateef Al Hammad (SZC)', N'khammadi@szc.gcaa.ae', N'+971501113374', N'hbelushi', N'ANS>ATM', N'khammadi', N'Hamad Bin Rashid Al Belushi (SZC)', N'Admin Officer', N'000497')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Khulood Bin Tamim', N'kbtamim@gcaa.gov.ae', N'0566929000', N'yazizi', N'SAFS>PRED', N'kbtamim', N'Yousuf Hashim Al Azizi', N'Admin Assistant', N'000965')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Khuluod Alhaddad', N'kalhaddad@gcaa.gov.ae', NULL, N'sshamsi', N'SIAS>EXAC', N'kalhaddad', N'Salem Jassim Al Shamsi', N'Chief nationalization officer', N'989')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Kim Christiansen (SZC)', N'kchristiansen@szc.gcaa.ae', N'0567826710', N'aalsabiri', N'ANS>ADM', N'kchristiansen', N'Ahmed Salem Al Sabiri (SZC)', N'Quality & Safety Manager', N'000593')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Kirubakaran Srinivasan', N'ksrinivasan@gcaa.gov.ae', N'+971564187589', N'mj', N'SUPS>ITD', N'ksrinivasan', N'Mohammed Jameeluddin', N'Software Engineer', N'001173')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Konstantinos Rodis', N'krodis@gcaa.gov.ae', N'+971504426563', N'aaljanahi', N'SAFS>FOPD', N'krodis', N'Ahmed Al Janahi', N'Inspector -Foreign Operators', N'000562')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Koshy Abraham (SZC)', N'koshy@szc.gcaa.ae', N'+971507520958', N'vpabraham', N'ANS>ATM', N'koshy', N'Abraham Vadakkekalam Pothen (SZC)', N'Assistant Supervisor', N'000615')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Kruger, Johannes', N'jkruger@szc.gcaa.ae', N'+971509081254', N'oabdouli', N'ANS>ATM', N'jkruger', N'Omar Obaid Al Abdouli (SZC)', N'ATC Officer', N'000272')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Labaran Ibrahim (SZC)', N'librahim@szc.gcaa.ae', NULL, N'vpabraham', N'ANS> ATM', N'librahim', N'Abraham Vadakkekalam Pothen (SZC)', N'Air Traffic Controller Assistant', N'001032')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Laila Ali Al Muhairi', N'laila.hareb@gcaa.gov.ae', N'+971506166179', N'dg', N'SIAS', N'laila', N'Director General', N'Asst Dir Genl Strategy&Inte af', N'000427')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Lamelicensing', N'Lamelicensing@gcaa.gov.ae', NULL, NULL, NULL, N'lamelicensing', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Lamya Mohamed Al Shebli', N'lshebli@gcaa.gov.ae', NULL, N'schelakara', N'SUP>ASS', N'lshebli', N'Subharaman Chelakara', N'Senior Accountants Assistant', N'000438')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Lara Long (SZC)', N'llong@szc.gcaa.ae', N'+971506414502', N'oabdouli', N'ANS> ATM', N'llong', N'Omar Obaid Al Abdouli (SZC)', N'AIR TRAFFIC CONTROL OFFICER', N'000978')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'leaves', N'leaves@gcaa.gov.ae', NULL, NULL, NULL, N'leaves', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Legal Affair', NULL, NULL, NULL, NULL, N'legalaffair', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Legal Affairs', N'legal@gcaa.gov.ae', NULL, NULL, NULL, N'legal', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Lendrum, Andrew', N'alendrum@szc.gcaa.ae', N'+971552430485', N'mdolbey', N'ANS>ATM', N'alendrum', N'Mike Dolbey', N'ATC Officer', N'000433')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Leo Aguiar D''souza', N'leo.dsouza@gcaa.gov.ae', N'+971504453960', N'khalid.al-romaithi', N'SUP>ASS', N'leo.dsouza', N'Khaled Sultan Al Romaithi', N'Procurement officer', N'000035')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Leon Herselman (SZC)', N'lherselman@szc.gcaa.ae', N'+971507434179', NULL, N'ANS>ATC', N'lherselman', NULL, N'ATCO', N'003155')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Leonard Clark Smalberger (SZC)', N'lsmalberger@szc.gcaa.ae', N'+971509064375', N'htenaiji', N'ANS>TRN', N'lsmalberger', N'Hesham Mohamed Al Tenaiji (SZC)', N'Senior ATSI', N'000548')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Leopoldo Paccial (SZC)', N'lpaccial@szc.gcaa.ae', N'0508163148', N'htenaiji', N'ANS/TRN', N'lpaccial', N'Hesham Mohamed Al Tenaiji (SZC)', N'Pseudo Pilot', N'000906')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Licensing Admin', N'licensingadmin@gcaa.gov.ae', NULL, NULL, NULL, N'licensingadmin', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Licensing Department', N'Licensing@gcaa.gov.ae', NULL, N'walid.ghanim', N'Licensing & Aeromedical', N'licensing', N'Walid Ghanim Mohammed', NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Licensing Examination', N'examination@gcaa.gov.ae', NULL, NULL, NULL, N'examination', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Lidisset Leonisa Viart (SZC)', N'lviart@szc.gcaa.ae', NULL, N'frobert', N'ANS>ATM', N'lviart', N'Francois Robert (SZC)', N'Air Traffic Control Officer', N'001143')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Lionel Engelstoft Nissen', N'lnissen@szc.gcaa.ae', N'+9713233610', N'gregkurten', N'ANS>CNS', N'lnissen', N'Gregory John Kurten (SZC)', N'CNS Engineer', N'000324')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Littu Abraham (SZC)', N'labraham@szc.gcaa.ae', N'0502811504', N'gregkurten', N'ANS>CNS', N'labraham', N'Gregory John Kurten (SZC)', N'Senior Maintenance Technician', N'000633')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Ljiljana Arandjelovic', N'larandjelovic@gcaa.gov.ae', N'+971506141186', N'tmusabbeh', N'SECS>PRPD', N'larandjelovic', N'Tariq Musabbeh', N'Chief Regulation Specialist', N'000464')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Lourdes Franciso D''costa (SZC)', N'ldcosta@szc.gcaa.ae', N'+971507720915', N'jammari', N'ANS>CNS', N'ldcosta', N'Jacob Ammari (SZC)', N'Maintenance Technician', N'000365')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Ludlow Delano Beckford', N'lbeckford@gcaa.gov.ae', N'+971506141129', N'malsaadi', N'SAFS>FOPD', N'lbeckford', N'Mohammed Ahmed Al Saadi', N'SENIOR FLIGHT OPERATION INSPECTOR', N'000483')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Luz Angelica Hidalgo', N'lhidalgo@gcaa.gov.ae', N'+971566160489', N'wrahmani', N'SAFS>PRED', N'lhidalgo', N'Walid Ibrahim Al Rahmani', N'Head - Aircraft Registry Unit', N'000454')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'lyncadmin', N'lyncadmin@gcaa.gov.ae', NULL, NULL, NULL, N'lyncadmin', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'lynctest', NULL, NULL, NULL, NULL, N'lynctest', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'lysinsta', N'lysinsta@gcaa.gov.ae', NULL, NULL, NULL, N'lysinsta', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'lystwitter', N'lystwitter@gcaa.gov.ae', NULL, NULL, NULL, N'lystwitter', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'M & E', N'm&e@gcaa.gov.ae', N'+971506662190', N'nasser.al-marzouqi', NULL, N'm&e', N'Nasser Ahmed Al Marzouqi', N'Maintenence', NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Magandeep singh', N'msingh@gcaa.gov.ae', N'+971506167064', N'khalid.al-romaithi', N'SUP>ASS', N'msingh', N'Khaled Sultan Al Romaithi', N'Procurement officer', N'000945')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Mahamad Bin Dan', N'mbdan@gcaa.gov.ae', N'+971506682572', N'szeinal', N'SAFS>FOPD', N'mbdan', N'Sayed zeinal', N'Inspector Flight Operations', N'000844')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Mahboob Bilal (SZC)', N'mbilal@szc.gcaa.ae', N'+971503099482', N'gregkurten', N'ANS>CNS', N'mbilal', N'Gregory John Kurten (SZC)', N'CNS Engineer', N'000873')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Mai Alawani', N'malawani@gcaa.gov.ae', N'+971503001101', N'emesafari', N'SAFS>LICD', N'malawani', N'Eman Mohamed Al Mesafri', N'ADMIN ASSISTANT – ADMIN & EXAM', N'992')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Mailmarshall', N'mailmarshall@gcaa.gov.ae', NULL, NULL, NULL, N'mailmarshall', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Maint & Facilities', N'M&F@gcaa.gov.ae', NULL, NULL, NULL, N'M&F', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Maissan Hassan Al Shunnar', N'mshannar@gcaa.gov.ae', NULL, N'malsaadi', N'SAFS>FOPD', N'mshannar', N'Mohammed Ahmed Al Saadi', N'Admin Assistant (Flight Ops)', N'000201')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Maja Kresojevic (SZC)', N'mkresojevic@szc.gcaa.ae', NULL, N'oabdouli', N'ANSS/ATD', N'mkresojevic', N'Omar Obaid Al Abdouli (SZC)', N'ATC Officer', N'000853')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Majo Aynikkal John (SZC)', N'mjohn@szc.gcaa.ae', N'+971506148280', N'gregkurten', N'ANS>CNS', N'mjohn', N'Gregory John Kurten (SZC)', N'Senior Maintenance Technician', N'000405')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Malm Maria Josefin (SZC)', N'mjosefin@szc.gcaa.ae', NULL, N'oabdouli', N'ANS> ATM', N'mjosefin', N'Omar Obaid Al Abdouli (SZC)', N'AIR TRAFFIC CONTROL OFFICER', N'979')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Mansoor Ul Karim', N'mulkarim@gcaa.gov.ae', NULL, N'mj', N'SUPS>ITD', N'mulkarim', N'Mohammed Jameeluddin', N'ERP Administrator', N'001169')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Marc Austen Boileau Boileau (SZC)', N'mboileau@szc.gcaa.ae', NULL, N'frobert', N'ANS> ATM', N'mboileau', N'Francois Robert (SZC)', N'Air Traffic Control Officer', N'001142')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Marc Brinkis (SZC)', N'mbrinkis@szc.gcaa.ae', N'+971568365883', N'frobert', N'ANS> ATM', N'mbrinkis', N'Francois Robert (SZC)', N'AIR TRAFFIC CONTROL OFFICER', N'1009')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Maria Al Mudharreb', N'malmudharreb@gcaa.gov.ae', NULL, N'schelakara', N'SUP>ASS', N'malmudharreb', N'Subharaman Chelakara', N'Senior ANS Revenues and Receivables Accountant', N'000772')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Maria.Egido', N'megido@gcaa.gov.ae', NULL, N'ahamili', N'DG OFFICE', N'megido', N'Aysha Mohammed Al Hamili', N'ADMIN  ASSISTANT', N'001045')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Mariam Al Hussaini', N'malhussaini@gcaa.gov.ae', NULL, N'kalraisi', N'AAIS', N'malhussaini', N'Khalid Walid Al Raisi', N'Admin Assistant', N'000755')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Mariam Mohamed Al Zaabi', N'mariamzaabi@gcaa.gov.ae', N'+971506154339', N'saeed.alsuwaidi', N'DGOO', N'mariamzaabi', N'Saeed Mohd Al Suwaidi', N'Executive Secretary', N'000344')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Mariam Shareef Al Hosani', N'malhosani@gcaa.gov.ae', NULL, N'nasser.al-marzouqi', N'SUP>ASS', N'malhosani', N'Nasser Ahmed Al Marzouqi', N'Admin Officer', N'000320')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Marina Forman', N'mforman@gcaa.gov.ae', N'00971506420162', N'mohamed.butaweel', N'SAFS>FOPD', N'mforman', N'Mohamed Khamis Butaweel', N'Inspector – Flight Operations', N'000782')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Marion  Meyer', N'mmeyer@gcaa.gov.ae', NULL, N'ahamili', N'UROO', N'mmeyer', N'Aysha Mohammed Al Hamili', N'Executive Assistant', N'000946')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Mark Edward Woodward', N'mwoodward@gcaa.gov.ae', N'+971506149771', N'aldossari', N'SAFS>ANAD', N'mwoodward', N'Mohammad Faisal Al Dossari', N'Manager - Aerodromes', N'000347')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Marlon Deleon (SZC)', N'mdeleon@szc.gcaa.ae', NULL, NULL, N'ANS>AIS', N'mdeleon', NULL, N'NOTAM Assistant', N'1026')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Martin Butterworth (SZC)', N'mbutterworth@szc.gcaa.ae', N'+971506417450', N'frobert', N'ANS> ATM', N'mbutterworth', N'Francois Robert (SZC)', N'AIR TRAFFIC CONTROL OFFICER', N'1008')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Martin Smit (SZC)', N'msmit@szc.gcaa.ae', NULL, N'oabdouli', N'ANS>ATM', N'msmit', N'Omar Obaid Al Abdouli (SZC)', N'ATC Officer', N'000692')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Marwa Salim Al Ali', N'marwa@gcaa.gov.ae', N'+971503648466', N'emesafari', N'SAFS>LICD', N'marwa', N'Eman Mohamed Al Mesafri', N'Admin Assistant (Admin & Exam)', N'000448')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Marwan Al Bloushi', N'malbloushi@gcaa.gov.ae', NULL, NULL, N'API', N'malbloushi', NULL, N'ARAS Administrator', N'000798')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Maryam Al Abdool', N'malabdool@gcaa.gov.ae', NULL, N'sshamsi', N'SIAS>EXAC', N'malabdool', N'Salem Jassim Al Shamsi', N'ASSISTANT EXTERNAL AFFAIRS', N'000696')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Maryam Al Hai', N'malhai@gcaa.gov.ae', N'+971507357404', N'iaahad', N'SIAS>CODD', N'malhai', N'Issa Abdel Ahad', N'Senior Officer Project Management', N'000702')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Maryam Al Hashemi', N'malhashemi@gcaa.gov.ae', N'+971508184526', N'ialmazmi', N'API', N'malhashemi', N'Ismail Al Mazmi', N'Support Service Manager – API', N'000735')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Maryam Ali AlBalooshi', N'mbalooshi@gcaa.gov.ae', NULL, N'khalid', N'SIAS>ATPD', N'mbalooshi', N'Khalid Humaid Al Ali', N'Manager - Environment Studies', N'000516')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Matar Al Nuaimi', N'malnuaimi@gcaa.gov.ae', N'0501967020', N'ialmazmi', N'API', N'malnuaimi', N'Ismail Al Mazmi', N'Call Centre Agent', N'000869')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Matar Rashed Al Suwaidi', N'matar.alsuwaidi@gcaa.gov.ae', N'+971506158995', NULL, NULL, N'malsuwaidi', NULL, NULL, N'000455')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Mathew Paul Kenyon (SZC)', N'mkenyon@szc.gcaa.ae', N'+971507632120', N'oabdouli', N'ANS>ATM', N'mkenyon', N'Omar Obaid Al Abdouli (SZC)', N'ATC Officer', N'000413')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Mattias Lundin (SZC)', N'mlundin@szc.gcaa.ae', NULL, N'oabdouli', N'ANS>ATM', N'mlundin', N'Omar Obaid Al Abdouli (SZC)', N'ATC Officer', N'000808')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Max William Evans', N'mwevans@gcaa.gov.ae', N'+971506155197', N'mwoodward', N'SAFS>ANAD', N'mwevans', N'Mark Edward Woodward', N'Aerodrome Inspector', N'000825')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Maxy Alphonso Saldanha (SZC)', N'msaldanha@szc.gcaa.ae', N'+971504912987', N'jammari', N'ANS>CNS', N'msaldanha', N'Jacob Ammari (SZC)', N'Maintenance Technician', N'000038')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'McCarthy, Kieran', N'kmccarthy@szc.gcaa.ae', N'+971561078099', N'oabdouli', N'ANS>ATM', N'kmccarthy', N'Omar Obaid Al Abdouli (SZC)', N'Senior ATC Watch Supervisor', N'000449')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'MDM01', NULL, NULL, NULL, NULL, N'mdm01', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'MDM02', NULL, NULL, NULL, NULL, N'mdm02', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Media', N'media@gcaa.gov.ae', NULL, NULL, NULL, N'media', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Meera Al Felasi', N'malfelasi@gcaa.gov.ae', N'+971508184627,+971505055558', N'KYousuf', N'API', N'malfelasi', N'Khalid Yousuf', N'ADMIN OFFICER', N'000706')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Melaku Denbel (SZC)', N'mdenbel@szc.gcaa.ae', N'+971 561791570', N'vfernandes', N'ANS>AIS', N'mdenbel', N'Victor Mariano Fernandes (SZC)', N'NOTAM Assistant', N'1028')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Michael David Manners (SZC)', N'MDavidManners@szc.gcaa.ae', NULL, N'oabdouli', N'ANS>ATM', N'MDavidManners', N'Omar Obaid Al Abdouli (SZC)', N'Air Navigation service provider', N'000954')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Michael Edward Hayes', N'michael.hayes@gcaa.gov.ae', N'+971508181295', N'aldossari', N'SAFS>ANAD', N'michael.hayes', N'Mohammad Faisal Al Dossari', N'Manager - ANS', N'000160')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Michael John Urquhart (SZC)', N'murquhart@szc.gcaa.ae', NULL, N'oabdouli', N'ANS>ATM', N'murquhart', N'Omar Obaid Al Abdouli (SZC)', N'ATC Officer', N'000918')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Michael Napolitano (SZC)', N'mnapolitano@szc.gcaa.ae', N'+971 50 475 3924', N'oabdouli', N'ANS>ATM', N'mnapolitano', N'Omar Obaid Al Abdouli (SZC)', N'ATC office', N'000654')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Michael Sidlow', N'msidlow@gcaa.gov.ae', N'+97156 4175025', N'mwoodward', N'SAFS>ANAD', N'msidlow', N'Mark Edward Woodward', N'Aerodrome Inspector', N'000862')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Michelle Helen Soliman', N'msoliman@gcaa.gov.ae', N'+971504861232', N'mwoodward', N'SAFS>ANAD', N'msoliman', N'Mark Edward Woodward', N'Aerodrome Ops Inspector', N'000514')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Microsoft Exchange', N'SystemMailbox{e0dc1c29-89c3-4034-b678-e6c29d823ed9}@gcaa.gov.ae', NULL, NULL, NULL, N'SM_b63c8882ea7f480c9', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Microsoft Exchange Approval Assistant', N'SystemMailbox{1f05a927-1377-4be8-88b4-028d366b440d}@gcaa.gov.ae', NULL, NULL, NULL, N'SM_ae4c4ab7d6b7401c8', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Microsoft Exchange Federation Mailbox', N'FederatedEmail.4c1f4d8b-8179-4148-93bf-00a95fa1e042@gcaa.gov.ae', NULL, NULL, NULL, N'SM_f4352909646b4a1da', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Mike Dolbey', N'mdolbey@szc.gcaa.ae', N'+971506152935', NULL, N'ANS>ATM', N'mdolbey', NULL, N'Manager Air Traffic Control', N'000120')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Milos Petrovic (SZC)', N'pmilos@szc.gcaa.ae', NULL, N'oabdouli', N'ANS> ATM', N'pmilos', N'Omar Obaid Al Abdouli (SZC)', N'AIR TRAFFIC CONTROL OFFICER', N'980')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Ministry of Finance User', NULL, NULL, NULL, NULL, N'mofuser', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Mirjana Neskovic (SZC)', N'mirjana.neskovic@szc.gcaa.ae', N'+971561906940', N'oabdouli', N'ANS> ATM', N'mneskovic', N'Omar Obaid Al Abdouli (SZC)', N'ATCO', N'000832')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Mladen Cala', N'mcala@gcaa.gov.ae', N'+971506417286', N'psayeed', N'SECS>OIND', N'mcala', N'Parvez Mohammad Sayeed', N'Chief Aviation Security Inspector', N'000754')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Mohamad Bin Denan', N'mdenan@gcaa.gov.ae', N'+971506138743', N'hamdoon', N'SAFS>LICD', N'mdenan', N'Obaid Mohamed Al Mehrezi', N'Engineering Inspector', N'000507')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Mohamed Abdo', N'mabdo@gcaa.gov.ae', N'+971506670394', N'hamdoon', N'SAFS>LICD', N'mabdo', N'Obaid Mohamed Al Mehrezi', N'Air Crew Inspector - simulator', N'000359')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Mohamed Abdulla Al Ameri (SZC)', N'msameri@szc.gcaa.ae', N'+971506699486', N'oabdouli', N'ANS>ATM', N'msameri', N'Omar Obaid Al Abdouli (SZC)', N'ATC Officer', N'000287')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Mohamed Ahmed Younis', N'mohdabbas@gcaa.gov.ae', N'+971505511060', N'malsaadi', N'SAFS>FOPD', N'mohdabbas', N'Mohammed Ahmed Al Saadi', N'Auditing Inspector – Flight Operations', N'000346')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Mohamed Alhashemi (SZC)', N'mhashemi@szc.gcaa.ae', NULL, N'htenaiji', N'ANS>TRN', N'mhashemi', N'Hesham Mohamed Al Tenaiji (SZC)', N'ATC TRAINEE', N'001046')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Mohamed Ali Al Belooshi (SZC)', N'mbelooshi@szc.gcaa.ae', N'+971508121201', N'oabdouli', N'ANS>ATM', N'mbelooshi', N'Omar Obaid Al Abdouli (SZC)', N'ATC Officer', N'000192')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Mohamed Hussain Al Zaabi (SZC)', N'mazaabi@szc.gcaa.ae', N'+971509090987', N'htenaiji', N'ANS>TRN', N'mazaabi', N'Hesham Mohamed Al Tenaiji (SZC)', N'ATC  Instructor', N'000129')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Mohamed Khamis Butaweel', N'mbutaweel@gcaa.gov.ae', N'+971506454404', N'malsaadi', N'SAFS>FOPD', N'mohamed.butaweel', N'Mohammed Ahmed Al Saadi', N'Manager Air Transport, Private and Special Operations', N'000117')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Mohamed Khurshid Alam (SZC)', N'malam@szc.gcaa.ae', N'+971507627550', NULL, N'ANS>ATC', N'malam', NULL, N'ATCA Supervisor', N'003017')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Mohamed Mohd Alkhayat', N'mkayat@gcaa.gov.ae', N'+971506215628', N'kalraisi', N'AAIS', N'malkayat', N'Khalid Walid Al Raisi', N'Air Accident Investigator', N'000290')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Mohamed Moosa Al Balooshi', N'malbalooshi@gcaa.gov.ae', N'+971506619136', N'mohamed.butaweel', N'SAFS>FOPD', N'malbalooshi', N'Mohamed Khamis Butaweel', N'Auditing Inspector – Flight Operations', N'000523')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Mohamed Salehuddin', N'msalehuddin@gcaa.gov.ae', N'+971565368694', N'oghannam', N'DAS\AWR', N'msalehuddin', N'Omar Ahmad Bin Ghannam', N'Airworthiness Inspector', N'962')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Mohamed Zafar Quraishi (SZC)', N'zquraishi@szc.gcaa.ae', N'+971554761696', N'oabdouli', N'ANS>ATM', N'zquraishi', N'Omar Obaid Al Abdouli (SZC)', N'ATC Officer', N'000398')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Mohammad Ahmed Al Majid', N'malmajid@gcaa.gov.ae', N'+971506680617', N'szeinal', N'SAFS>FOPD', N'malmajid', N'Sayed zeinal', N'Inspector – Flight Operations', N'000769')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Mohammad Al Dhaheri (SZC)', N'mdhaheri@szc.gcaa.ae', NULL, N'htenaiji', N'ANS>ATM', N'mdhaheri', N'Hesham Mohamed Al Tenaiji (SZC)', N'ATC Trainee', N'000731')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Mohammad Al Marzouqi', N'malmarzouqi@gcaa.gov.ae', N'+971506434750,+971504528811', N'hamdoon', N'SAFS>LICD', N'malmarzouqi', N'Obaid Mohamed Al Mehrezi', N'Engineering Inspector', N'000722')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Mohammad Al Saboosi', N'Msaboosi@gcaa.gov.ae', N'+971562195146', N'aalhamoudi', N'SECS>ITAD', N'Msaboosi', N'Abdulla Rashed Alhmoudi', N'Manager - ITA and Security Clearance', N'000738')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Mohammad Al Suwaidi (SZC)', N'mohammadalsuwaidi@szc.gcaa.ae', N'+971503971397', N'htenaiji', N'ANS>ATM', N'mohammadalsuwaidi', N'Hesham Mohamed Al Tenaiji (SZC)', N'ATC Assistant', N'000763')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Mohammad Athar Shams', N'mathar@gcaa.gov.ae', N'+971506213243', N'niqbal', N'ACRC', N'mathar', N'Nasir Iqbal', N'Senior Safety Risk Specialist', N'000648')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Mohammad Faisal Al Dossari', N'aldossari@gcaa.gov.ae', N'+971555594943', N'emaaa', N'SAFS>ANAD', N'aldossari', N'Ismaeil Mohammed Al Blooshi', N'Acting Director ANA', N'000589')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Mohammad Hussain Al-Sayed', N'mdhussain@gcaa.gov.ae', NULL, N'ssherazi', N'HCD>TNDC', N'msayed', N'Syed Sherazi', N'Translator', NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Mohammad Juma Bin Amhai (SZC)', N'mamhai@szc.gcaa.ae', NULL, N'oabdouli', N'ANS>ATM', N'mamhai', N'Omar Obaid Al Abdouli (SZC)', N'Air Navigation Services Provider', N'000683')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Mohammad Lootah (SZC)', N'mlootah@szc.gcaa.ae', N'+971508521222', N'htenaiji', N'ANS>ATM', N'mlootah', N'Hesham Mohamed Al Tenaiji (SZC)', N'AIR TRAFFIC CONTROL TRAINEE', N'000760')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Mohammad Moosa Al Shamali', N'mshamali@gcaa.gov.ae', N'+971506150569', N'oghannam', N'SAFS>AWRD', N'mshamali', N'Omar Ahmad Bin Ghannam', N'Inspector - Airworthiness', N'000460')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Mohammad Nasser Al Arai (SZC)', N'malarai@szc.gcaa.ae', NULL, N'oabdouli', N'ANS>ATM', N'malarai', N'Omar Obaid Al Abdouli (SZC)', N'Air Navigation Services Provider', N'000664')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Mohammad Obaid AlTayer', N'mtayer@gcaa.gov.ae', N'+971566885045', N'tmusabbeh', N'AVS>PRP', N'mtayer', N'Tariq Musabbeh', N'Chief Policy Specialist', N'000642')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Mohammad Salem', N'msalem@gcaa.gov.ae', N'+971562197823', N'hdibian', N'SAFS>AWRD', N'msalem', N'Hatem Mohamed Dibian', N'Inspector - Airworthiness', N'000670')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Mohammed Ahmed Al Saadi', N'malsaadi@gcaa.gov.ae', N'+971504511899', N'emaaa', N'SAFS>FOPD', N'malsaadi', N'Ismaeil Mohammed Al Blooshi', N'Director Flight Operations', N'000351')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Mohammed Al Madani (SZC)', N'mmadani@szc.gcaa.ae', NULL, N'htenaiji', N'ANS>ATM', N'mmadani', N'Hesham Mohamed Al Tenaiji (SZC)', N'ATC Trainee', N'000786')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Mohammed Alkamali', N'malkamali@gcaa.gov.ae', N'+971505357000', N'malsaadi', N'SAFS>FOPD', N'malkamali', N'Mohammed Ahmed Al Saadi', N'Inspector – Flight Operations', N'000677')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Mohammed Ebrahim Al Ali', N'mohammed.alali@gcaa.gov.ae', N'+971566885089', N'pking', N'SECS>OIND', N'mohammed.alali', N'Paul Ronald King', N'SECURITY INSPECTOR', N'000643')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Mohammed Hamdan Al Dahmani (SZC)', N'mdahmani@szc.gcaa.ae', N'+971506139369', N'gregkurten', N'ANS>CNS', N'mdahmani', N'Gregory John Kurten (SZC)', N'CNS Engineer', N'000018')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Mohammed Jameeluddin', N'jameel@gcaa.gov.ae', N'+971506621537', N'omar', N'SUPS>ITD', N'mj', N'Omar Ghaleb Bin Ghaleb', N'Manager Information Technology Department', N'000140')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Mohammed Khamis AlBlooshi (SZC)', N'mbaloushi@szc.gcaa.ae', N'+971505933327', N'oabdouli', N'ANS>ATM', N'mbaloushi', N'Omar Obaid Al Abdouli (SZC)', N'ATC Officer', N'000225')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Mohammed Saeed Al Shehhi', N'msaeed@gcaa.gov.ae', N'447975', NULL, NULL, N'msaeed', NULL, NULL, N'000202')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Mohammed Saif Al Ameri (SZC)', N'mameri@szc.gcaa.ae', N'+971508117272', N'mtenaiji', N'ANS>ATM', N'mameri', N'Muayyed Al Tenaiji (SZC)', N'Sr.Airspace Coordinator', N'000177')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Mohammed Yousif Mohamed', N'myousif@gcaa.gov.ae', N'+971566857501', N'mwoodward', N'SAFS>ANAD', N'myousif', N'Mark Edward Woodward', N'Aerodrome Ops Inspector', N'000655')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Mohammed Zia Ur Rahiman', N'mzrahiman@gcaa.gov.ae', NULL, N'emesafari', N'SAFS>LICD', N'mzrahiman', N'Eman Mohamed Al Mesafri', N'Filing Clerk', N'001135')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Mohd Zahidur Rahman (SZC)', N'mzrahman@szc.gcaa.ae', N'+971558893882', N'gregkurten', N'ANS>CNS', N'mzrahman', N'Gregory John Kurten (SZC)', N'Senior Technician CNS', N'000669')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'moi3', NULL, NULL, NULL, NULL, N'moi3', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'moi4', NULL, NULL, NULL, NULL, N'moi4', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'moi5', NULL, NULL, NULL, NULL, N'moi5', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'moi6', NULL, NULL, NULL, NULL, N'moi6', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'moi7', NULL, NULL, NULL, NULL, N'moi7', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'moi8', NULL, NULL, NULL, NULL, N'moi8', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Mona Fares Al Marzouqi', N'mfalmarzouqi@gcaa.gov.ae', NULL, NULL, N'SUP>ASS', N'mfalmarzouqi', NULL, N'Trainee', NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Mona Juma Al Jenabi', N'maljenaibi@gcaa.gov.ae', N'+971507374997', N'khalid', N'SIAS>ATPD', N'maljenaibi', N'Khalid Humaid Al Ali', N'Admin Assistant', N'000378')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Mona Salim Al Shaaer', N'mshaaer@gcaa.gov.ae', NULL, N'nasser.al-marzouqi', N'SUP>ASS', N'mshaaer', N'Nasser Ahmed Al Marzouqi', N'Front Desk Operations Assistant', N'000322')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Moosa Mohamed Khameeri (SZC)', N'mkhameeri@szc.gcaa.ae', N'+971 56 413 8213', N'oabdouli', N'ANS>ATM', N'mkhameeri', N'Omar Obaid Al Abdouli (SZC)', N'ATC watch Supervisor', N'000304')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Morne Blignaut (SZC)', N'mblignaut@szc.gcaa.ae', N'00971505632159', N'htenaiji', N'ANS>TRN', N'mblignaut', N'Hesham Mohamed Al Tenaiji (SZC)', N'Senior Air Traffic Service Instructor', N'000909')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'mosssa', NULL, NULL, NULL, NULL, N'mosssa', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Mourad Ben Asker', N'masker@gcaa.gov.ae', N'+971506178813', N'yazizi', N'SAFS>PRED', N'masker', N'Yousuf Hashim Al Azizi', N'Planning & Standard Specialist', N'000482')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Mouza Mohamed Al Sawafi', N'malsawafi@gcaa.gov.ae', N'+971566168228', N'aalhamoudi', N'SECS>ITAD', N'malsawafi', N'Abdulla Rashed Alhmoudi', N'ITA Senior Officer', N'000333')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'MoveDMZAdmin', NULL, NULL, NULL, NULL, N'movedmzadmin', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Moza Alsuwaidi', N'moalsuwaidi@gcaa.gov.ae', NULL, N'walid.ghanim', N'COP', N'moalsuwaidi', N'Walid Ghanim Mohammed', N'MANAGER - QUALITY ASSURANCE AND CORPORATE EXCELLENCE', N'999')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Moza Obaid Al Ali', N'moza.alali@gcaa.gov.ae', N'+971508686680', N'nasser.al-marzouqi', N'SUPS>FAPD', N'moza.alali', N'Nasser Ahmed Al Marzouqi', N'Admin Assistant Staff Logistcs', N'000142')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'mspsexclsvc', NULL, NULL, NULL, NULL, N'mspsexclsvc', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Mstest1', N'mstest1@gcaa.gov.ae', NULL, NULL, NULL, N'mstest1', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Muayyed Al Tenaiji (SZC)', N'mtenaiji@szc.gcaa.ae', N'+971566854505', N'hbelushi', N'ANS>ATM', N'mtenaiji', N'Hamad Bin Rashid Al Belushi (SZC)', N'Head of Airspace Coordination Section', N'000197')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Mubarak Al Mansoori', N'mmalmansoori@gcaa.gov.ae', NULL, N'aalhamoudi', N'SECS>ITAD', N'mmalmansoori', N'Abdulla Rashed Alhmoudi', N'Intelligence and Threat Assessment Investigator', N'000937')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Muhammad Adnan Khan', N'makhan@gcaa.gov.ae', N'+971506178983', N'mj', N'SUPS>ITD', N'makhan', N'Mohammed Jameeluddin', N'Software Engineer', N'001143')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Muhammad Ali Azeem (SZC)', N'maazeem@szc.gcaa.ae', N'+971 50 6298038', N'aljanaahi', N'ANS>CNS', N'maazeem', N'Ali Al Janaahi (SZC)', N'CNS Technician', N'000901')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Muhammad Faraz Chughtai', N'mchughtai@gcaa.gov.ae', N'+971 50 6174903', N'mj', N'SUPS>ITD', N'mchughtai', N'Mohammed Jameeluddin', N'Technical Consultant', N'001016')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Muhammad Imran Khan', N'mikhan@gcaa.gov.ae', NULL, N'mj', N'SUPS>ITD', N'mikhan', N'Mohammed Jameeluddin', N'Software Engineer', N'001150')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Muhammad Kamran Chaudhry', N'ksadiq@gcaa.gov.ae', NULL, N'niqbal', N'ACRC', N'ksadiq', N'Nasir Iqbal', N'Safety Risk Data Analyst', N'000552')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Muhammad Kamran Shakir', N'mkamran@gcaa.gov.ae', NULL, N'mj', N'SUPS>ITD', N'mkamran', N'Mohammed Jameeluddin', N'IT Technician', NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Muhammad Naveed Khan', N'mnkhan@gcaa.gov.ae', N'00971555440996', N'mj', N'SUPS>ITD', N'mnkhan', N'Mohammed Jameeluddin', N'Software Engineer', N'001160')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Muhammad Shafaat Afzal (SZC)', N'mafzal@szc.gcaa.ae', N'+971553622662', N'hbelushi', N'ANS> ATM', N'mafzal', N'Hamad Bin Rashid Al Belushi (SZC)', N'ADMIN ASSISTANT', N'001018')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Muhammad  Farook Bismi (SZC)', N'mfarook@szc.gcaa.ae', N'+971506133207', N'hbelushi', N'ANS>ATM', N'mfarook', N'Hamad Bin Rashid Al Belushi (SZC)', N'FDP Adaptation Officer', N'352')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Muna  Abdulwahab Al Dewani', N'mdewani@gcaa.gov.ae', N'+971555675074 ', N'ismaeil.abdelwahed', N'AAIS', N'mdewani', N'Ismaeil Mohamed Al Hosani', N'Executive Assistant', N'000473')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Muna Ahmed Ahmed', N'muna@gcaa.gov.ae', NULL, N'zmunawar', N'SAFS>AWRD', N'mahmed', N'Zahid Munawar', N'Admin Assistant Airworthness', N'000342')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Muna Alblooshi', N'malblooshi@gcaa.gov.ae', NULL, N'nibrahim', N'SUP>LGL', N'malblooshi', N'Nadia Ibrahim AlMaazmi', N'ADMIN ASSISTANT', N'968')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Muna Darwish Haikal', N'mhaikal@gcaa.gov.ae', N'+971506847477', N'emesafari', N'SAFS>LICD', N'mhaikal', N'Eman Mohamed Al Mesafri', N'Admin Assistant (Admin & Exam)', N'000371')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Muna Ibrahim Mohamed', N'mibrahim@gcaa.gov.ae', N'+971505536266', N'emesafari', N'SAFS>LICD', N'mibrahim', N'Eman Mohamed Al Mesafri', N'Admin Assistant (Admin & Exam)', N'000255')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Muneer Thai Valappil', N'mvalappil@gcaa.gov.ae', NULL, N'schelakara', N'SUP>ASS', N'mvalappil', N'Subharaman Chelakara', N'Payables and Payroll Accountant', N'000477')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Musliam Veettil Nasseem', N'mnaseem@szc.gcaa.ae', N'+971505728217', N'vpabraham', N'ANS>ATM', N'mnaseem', N'Abraham Vadakkekalam Pothen (SZC)', N'ATC Assistant', N'000188')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Mustafa Abu Younis', N'mayounis@gcaa.gov.ae', N'+971558490949', NULL, N'SUP>ASS', N'mayounis', NULL, N'Fees and Receivables Admin', N'000774')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Nabeel Yahya Shabiby', N'nshabiby@gcaa.gov.ae', NULL, N'nissreen', N'HCD>TNDC', N'nshabiby', N'Nissreen Ibrahim', N'Admin Assistant', N'001148')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Nader Al Amiri (SZC)', N'nalamiri@szc.gcaa.ae', N'+971508566455', N'htenaiji', N'ANS>ATM', N'nalamiri', N'Hesham Mohamed Al Tenaiji (SZC)', N'ATC Assistant', NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Nadia Ibrahim AlMaazmi', N'nibrahim@gcaa.gov.ae', N'+971505536553', N'omar', N'SUPS>LGLD', N'nibrahim', N'Omar Ghaleb Bin Ghaleb', N'Director - Legal Affairs', N'000640')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Nadia Konzali', N'nkonzali@gcaa.gov.ae', N'+971503281510', NULL, N'DGOO', N'nkonzali', NULL, N'COSCAP-Airworthiness Expert', NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Nadia Mubarak Al Dosari', N'ndosari@gcaa.gov.ae', NULL, N'khalid.al-romaithi', N'HCD>PERC', N'ndosari', N'Khaled Sultan Al Romaithi', N'Procurement and Planning Officer', N'000305')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Nadia Omar Al Braiki', N'nadia.al-braiki@gcaa.gov.ae', NULL, N'nissreen', N'SUP>ASS', N'nadia.al-braiki', N'Nissreen Ibrahim', N'Senior Training & Development Officer', N'000074')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Nadirsha Mukkattil', N'nmukkattil@gcaa.gov.ae', NULL, N'nasser.al-marzouqi', N'SUP', N'nmukkattil', N'Nasser Ahmed Al Marzouqi', N'Admin Assistant', N'997')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Najeeb Perumittathu Kutty (SZC)', N'pnajeeb@szc.gcaa.ae', N'+971502673994', N'gregkurten', N'ANS>CNS', N'nkutty', N'Gregory John Kurten (SZC)', N'CNS Senior technician', N'000838')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Narinder Pal Yadav', N'nyadav@gcaa.gov.ae', N'+971504431486', N'larandjelovic', N'SECS>PRPD', N'nyadav', N'Ljiljana Arandjelovic', N'Regulation Specialist', N'000625')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'NASAC', N'nasac@gcaa.gov.ae', NULL, NULL, NULL, N'NASAC', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Naser Abdulkarim Al Shehhi (SZC)', N'nshehhi@szc.gcaa.ae', N'+971507401048', N'htenaiji', N'ANS>TRN', N'nshehhi', N'Hesham Mohamed Al Tenaiji (SZC)', N'Pseudo Pilot', N'000349')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Naser al messabi', N'nalmessabi@gcaa.gov.ae', N'+971506212360', N'kalraisi', N'AAIS', N'nalmessabi', N'Khalid Walid Al Raisi', N'Technical  Assistant', N'000751')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Nasir Iqbal', N'niqbal@gcaa.gov.ae', N'+971562192357', N'walid.ghanim', N'ACRC', N'niqbal', N'Walid Ghanim Mohammed', N'Senior Safety Risk Specialist', N'000679')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Nasra Abdulla Masoud', N'nmasoud@gcaa.gov.ae', NULL, N'oghannam', N'SAFS>AWRD', N'nmasoud', N'Omar Ahmad Bin Ghannam', N'Admin Assistant Airworthness', N'000215')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Nasser Ahmed Al Marzouqi', N'nasser.al-marzouqi@gcaa.gov.ae', N'+971506621447', N'omar', N'SUP>ASS', N'nasser.al-marzouqi', N'Omar Ghaleb Bin Ghaleb', N'Manager - General Administration', N'000069')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Nasser Al Khater', N'nkhater@gcaa.gov.ae', N'+971553488889', N'khalid', N'SIAS>ATPD', N'nkhater', N'Khalid Humaid Al Ali', N'Air Transport Agreements Chief Officer', N'000765')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Nasser Jamea', N'Njamea@gcaa.gov.ae', N'+971506434751', N'zmunawar', N'SAFS>AWRD', N'Njamea', N'Zahid Munawar', N'Inspector Engineer', N'000724')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Nasser Sahleh Al Kharusi (SZC)', N'nkharusi@szc.gcaa.ae', N'+971502123637', N'fkhaja', N'ANS>ATM', N'nkharusi', N'Faisal Ibrahim Al Khaja (SZC)', N'Unit Investigator', N'000210')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Nathalie Aoun', N'naoun@gcaa.gov.ae', N'+971529087020', N'laila', N'SIAS', N'naoun', N'Laila Ali Al Muhairi', N'Executive Assistant', N'001138')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'National Runway Safety Team', N'NRST@gcaa.gov.ae', NULL, NULL, NULL, N'NRST', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Naveed khan', N'nkhan@gcaa.gov.ae', N'+971528010099', N'mj', N'SUPS>ITD', N'nkhan', N'Mohammed Jameeluddin', N'IT Compliance Officer', N'001139')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Nawal Kamal', N'nkamal@gcaa.gov.ae', NULL, N'hamad.almuhairi', N'SECS>ITAD', N'nkamal', N'Hamad Salem Al Muhairi', N'Executive Assistant', N'001036')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'networkbackup', NULL, NULL, NULL, NULL, N'networkbackup', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Neville Bakker (SZC)', N'nbakker@szc.gcaa.ae', N'+971509351517', NULL, N'ANS>ATC', N'nbakker', NULL, N'ATCO', N'003153')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'nextthink', N'nextthink@gcaa.gov.ae', NULL, NULL, NULL, N'nextthink', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Nicoletta Mazzoleni', N'nmazzoleni@gcaa.gov.ae', N'+971508128360', N'mtayer', N'SECS>PRPD', N'nmazzoleni', N'Mohammad Obaid AlTayer', N'Senior Policy Specialist', N'000753')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Niesan Chetty (SZC)', N'nchetty@szc.gcaa.ae', N'+971554851487', N'frobert', N'ANS> ATM', N'nchetty', N'Francois Robert (SZC)', N'AIR TRAFFIC CONTROL OFFICER', N'1005')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Nigel Prince Peres', N'nperes@gcaa.gov.ae', NULL, N'yazizi', N'SAFS>PRPD', N'nperes', N'Yousuf Hashim Al Azizi', N'Administrative Assistant', N'001179')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Niklas Lundqvist (SZC)', N'nlundqvist@szc.gcaa.ae', N'+971505118218', N'htenaiji', N'ANS>TRN', N'NLundqvist', N'Hesham Mohamed Al Tenaiji (SZC)', N'Air Trafic Service Instructor', N'000910')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Nisha Dsouza', N'nishad@gcaa.gov.ae', N'+971564067891', N'mj', N'SUPS>ITD', N'nishad', N'Mohammed Jameeluddin', N'Quality Assurance Officer', N'001183')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Nissreen Ibrahim', N'nissreen@gcaa.gov.ae', N'+971501097982', N'aahli', N'HCD>TNDC', N'nissreen', N'Amina Ahli', N'Senior Training Officer', N'000943')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Nojoud Al Bastaki', N'nbastaki@gcaa.gov.ae', N'+971503036006', NULL, N'SIAS>COCC', N'nbastaki', NULL, N'Communications Specialist', N'000678')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Noor Al Raisi (SZC)', N'nalraisi@szc.gcaa.ae', N'050 9908680', N'htenaiji', N'ANS>Training', N'nalraisi', N'Hesham Mohamed Al Tenaiji (SZC)', N'ATC Trainee', N'000858')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Noora Al Falahi', N'nalfalahi@gcaa.gov.ae', NULL, N'malhashemi', N'API', N'nalfalahi', N'Maryam Al Hashemi', N'HR Specialist', N'974')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Noora Al Zaabi', N'nalzaabi@gcaa.gov.ae', NULL, N'nasser.al-marzouqi', N'SUP>ASS', N'nalzaabi', N'Nasser Ahmed Al Marzouqi', N'Admin Assistant', N'000872')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Noora Ali (SZC)', N'nali@szc.gcaa.ae', NULL, N'htenaiji', N'ANS>Training', N'nali', N'Hesham Mohamed Al Tenaiji (SZC)', N'ATC TRAINEE', N'972')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Nora Mathias', NULL, NULL, NULL, NULL, N'nmathias', NULL, NULL, N'001170')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Nouf Al Ameri (SZC)', N'nalameri@szc.gcaa.ae', N'+971505160960', N'dfernandes', N'ANS>AIS', N'nalameri', N'Dean Fernandes (SZC)', N'Public Assistant', N'000689')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Nouf Al Mutawa', N'nalmutawa@gcaa.gov.ae', N'+91563511163', N'moalsuwaidi', N'COP\ASR', N'nalmutawa', N'Moza Alsuwaidi', N'Quality Admin Officer', N'000936')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Nouf Binhadyia', N'noufb@gcaa.gov.ae', NULL, N'saeed.alsuwaidi', N'DGOO', N'noufb', N'Saeed Mohd Al Suwaidi', N'Executive Secretary', N'964')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Noufa Naser Al Afeefi (SZC)', N'nalafeefi@szc.gcaa.ae', N'+971501114611', N'oabdouli', NULL, N'nalafeefi', N'Omar Obaid Al Abdouli (SZC)', N'AIR TRAFFIC CONTROL OFFICER', N'000288')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Noura Abdulla Ahmed', N'nouraa@gcaa.gov.ae', NULL, NULL, N'SAFS>PRED', N'nouraa', NULL, N'Admin Assistant Planning & Standard', N'000603')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Nourah Al Hefeiti', N'nalhefeiti@szc.gcaa.ae', N'0552020550', N'nasser.al-marzouqi', N'SUPS>FAPD', N'nalhefeiti', N'Nasser Ahmed Al Marzouqi', N'Staff Logistics Officer', N'970')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Obaid Ahmed Al Khajeh (SZC)', N'okhajeh@szc.gcaa.ae', NULL, N'htenaiji', N'ANS>TRN', N'okhajeh', N'Hesham Mohamed Al Tenaiji (SZC)', N'AIR TRAFFIC CONTROL TRAINEE', N'000783')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'obaid Ali Tamimi (SZC)', N'oaltamimi@szc.gcaa.ae', NULL, N'htenaiji', N'ANS>Training', N'oaltamimi', N'Hesham Mohamed Al Tenaiji (SZC)', N'ATC Trainee', N'000785')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Obaid Mohamed Al Mehrezi', N'hamdoon@gcaa.gov.ae', N'+971508180252', N'salzara', N'SAFS>LICD', N'hamdoon', N'Sultan Mohamed Al Zara', N'Manager - Engineering Licensing Section', N'000221')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Obaid Soomro', N'osoomro@gcaa.gov.ae', N'+971504437764', N'zmunawar', N'SAFS>AWRD', N'osoomro', N'Zahid Munawar', N'Sr Inspector -Engineering', N'000362')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Odd Erik Kjersem (SZC)', N'okjersem@szc.gcaa.ae', N'+971504100568', N'fkhaja', N'ANS>ATM', N'okjersem', N'Faisal Ibrahim Al Khaja (SZC)', N'Unit Investigator', N'000239')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Ola Mahmoud (SZC)', N'ola.mahmoud@szc.gcaa.ae', NULL, NULL, N'ANS', N'omahmoud', NULL, N'Project Coordinator', N'001128')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Omar Ahmad AL Teneiji', N'oalteneiji@gcaa.gov.ae', N'0508090993', N'ialmazmi', N'ACRC', N'oalteneiji', N'Ismail Al Mazmi', N'Call Center Agent', N'000829')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Omar Ahmad Bin Ghannam', N'oghannam@gcaa.gov.ae', N'+971508183530', N'azarouni', N'SAFS>AWRD', N'oghannam', N'Aqeel Ahmed Al Zarouni', N'Manager - MROs', N'000183')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Omar Al Nuaimi', N'omalnuaimi@gcaa.gov.ae', N'+971553678888', N'omar', N'DG Office', N'omalnuaimi', N'Omar Ghaleb Bin Ghaleb', N'Internal Auditor', N'000942')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Omar Bin Ghaleb dxb', N'omardxb@gcaa.gov.ae', NULL, NULL, NULL, N'omardxb', NULL, NULL, N'000353')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Omar Bin Musa', N'omusa@gcaa.gov.ae', N'+971508183957', N'oghannam', N'SAFS>AWRD', N'omusa', N'Omar Ahmad Bin Ghannam', N'Senior Inspector - Airworthiness', N'000265')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Omar Bumelha', N'OBumelha@gcaa.gov.ae', N'+971506164056', N'hdibian', N'SAFS>AWRD', N'OBumelha', N'Hatem Mohamed Dibian', N'Inspector - Airworthiness', N'000736')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Omar Fari Al Shawakfeh', N'oalshawakfeh@gcaa.gov.ae', N'+971566857494', N'schelakara', N'SUP>ASS', N'oalshawakfeh', N'Subharaman Chelakara', N'Receivable Accountant', N'000389')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Omar Ghaleb Bin Ghaleb', N'obinghaleb@gcaa.gov.ae', N'+971506167511', N'dg', N'SUPS', N'omar', N'Director General', N'Deputy Director General and Assistant DG Support Services', N'000353')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Omar Naqi (SZC)', N'onaqi@szc.gcaa.ae', N'050 3577898', N'htenaiji', N'ANS>Training', N'onaqi', N'Hesham Mohamed Al Tenaiji (SZC)', N'ATC Trainee', N'000860')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Omar Obaid Al Abdouli (SZC)', N'oabdouli@szc.gcaa.ae', N'+971566882438', N'frobert', N'ANS>ATM', N'oabdouli', N'Francois Robert (SZC)', N'SENIOR WATCH SUPERVISOR', N'000154')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Omer', NULL, NULL, NULL, NULL, N'Omer', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Operations Secretary', N'hameri@gcaa.gov.ae', NULL, NULL, NULL, N'opssec', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Opmanager Admin', N'opmgradmin@gcaa.gov.ae', NULL, NULL, NULL, N'opmgradmin', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'opmonitor', NULL, NULL, NULL, NULL, N'opmonitor', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Othman Bin Abas', N'oabas@gcaa.gov.ae', N'+971506138280', N'hamdoon', N'SAFS>LICD', N'oabas', N'Obaid Mohamed Al Mehrezi', N'Engineering Inspector', N'000367')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Palangat Othayoth Deepak (SZC)', N'deepak@szc.gcaa.ae', N'+971566988130', N'jammari', N'ANS>CNS', N'deepak', N'Jacob Ammari (SZC)', N'Maintenance Technician', N'000054')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Paolo Jeffrey Gan', N'pgan@gcaa.gov.ae', NULL, N'yazizi', N'SAFS>PRPD', N'pgan', N'Yousuf Hashim Al Azizi', N'Senior Officer - Flow Charts', NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Parimala Shekar', N'parimala@gcaa.gov.ae', N'+971506612459', N'laila', N'SIAS>COCC', N'parimala', N'Laila Ali Al Muhairi', N'Executive Assistant', N'000020')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Parvez Mohammad Sayeed', N'psayeed@gcaa.gov.ae', N'+971508133198', N'hamad.almuhairi', N'SECS>OIND', N'psayeed', N'Hamad Salem Al Muhairi', N'Chief Security Inspector', N'000301')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Password Notification System', N'PasswordNotification@gcaa.gov.ae', NULL, NULL, NULL, N'PasswordNotification', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Patrick Cuschieri', N'pcuschieri@gcaa.gov.ae', N'+9710563988360', N'larandjelovic', N'AVS>PRP', N'pcuschieri', N'Ljiljana Arandjelovic', N'Regulation Specialist', N'000949')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Paul Anthony Price', N'pprice@gcaa.gov.ae', N'+971508185499', N'hamdoon', N'SAFS>LICD', N'panthony', N'Obaid Mohamed Al Mehrezi', N'Engineering Inspector', N'000707')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Paul Ronald King', N'pking@gcaa.gov.ae', N'+971566859899', N'psayeed', N'SECS>OIND', N'pking', N'Parvez Mohammad Sayeed', N'Chief Security Inpector', N'000623')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Paul Simon Brown (SZC)', N'PBrown@szc.gcaa.ae', N'+971504130028', N'gregkurten', N'ANS>CNS', N'PBrown', N'Gregory John Kurten (SZC)', N'CNS Engineer', N'000517')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Paula Elizabeth Laws', N'plaws@gcaa.gov.ae', N'+971506213799', N'mwoodward', N'SAFS>ANAD', N'plaws', N'Mark Edward Woodward', N'Aerodrome Ops Senior Inspector', N'000484')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Pawan Nakrmi (SZC)', N'pnakrmi@szc.gcaa.ae', NULL, N'htenaiji', N'ANS/TRN', N'pnakrmi', N'Hesham Mohamed Al Tenaiji (SZC)', N'Pseudo Pilot', N'000907')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Perry Matanguihan Lat (SZC)', N'plat@szc.gcaa.ae', N'+971505805704', N'oabdouli', N'ANS>ATM', N'plat', N'Omar Obaid Al Abdouli (SZC)', N'Administrator', N'000282')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Peter McLoughlin (SZC)', N'pmcloughlin@szc.gcaa.ae', N'+971566151281', N'oabdouli', N'ANS>ATM', N'pmcloughlin', N'Omar Obaid Al Abdouli (SZC)', N'ATCO', N'000920')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'PHSC', N'PHSC@gcaa.gov.ae', NULL, NULL, NULL, N'PHSC', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'PMO', N'PMO@gcaa.gov.ae', NULL, NULL, NULL, N'PMO', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Prabhath Nandiyil Premlal', N'pprabhath@szc.gcaa.ae', N'+971508013901', N'gregkurten', N'ANS>CNS', N'pprabhath', N'Gregory John Kurten (SZC)', N'Senior Technician', N'000617')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'practice', NULL, NULL, NULL, NULL, N'practice', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Premjith Balakrishnan Nair (SZC)', N'pnair@szc.gcaa.ae', N'+971507517273', N'htenaiji', N'ANS>TRN', N'pnair', N'Hesham Mohamed Al Tenaiji (SZC)', N'PSEUDO Pilot', N'000528')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Priadarshni Dias', N'pdias@gcaa.gov.ae', NULL, N'emaaa', N'SAFS', N'pdias', N'Ismaeil Mohammed Al Blooshi', N'Executive Assistant', N'000481')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Printadmin', NULL, NULL, NULL, NULL, N'printadmin', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'printer test', N'printer@gcaa.gov.ae', NULL, NULL, NULL, N'printer', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'ProjectMgmt', N'ProjectMgmt@gcaa.gov.ae', NULL, NULL, NULL, N'ProjectMgmt', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Purchasing', N'Purchasing@gcaa.gov.ae', NULL, NULL, NULL, N'Purchasing', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Pushparajan Elampachikuzhiyil Meethal (SZC)', N'pushparajan@szc.gcaa.ae', N'+971509058502', N'gregkurten', N'ANS>CNS', N'pushparajan', N'Gregory John Kurten (SZC)', N'Senior Maintenance Technician', N'000541')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Qlik Administrator', NULL, NULL, NULL, NULL, N'Qlick', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'QPulse', N'qpulse@gcaa.ae', NULL, NULL, NULL, N'qpulse1', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'QPulse Project', NULL, NULL, NULL, NULL, N'qpulse', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'qrm', N'qrm@gcaa.gov.ae', NULL, NULL, NULL, N'qrm', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Quality&Excellence', N'Quality&Excellence@gcaa.gov.ae', NULL, NULL, NULL, N'Quality&Excellence', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Radarroom', N'RadarRoom@gcaa.gov.ae', NULL, NULL, NULL, N'radarroom', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Radhwa Alhaddadi', N'ralhaddadi@gcaa.gov.ae', NULL, N'lhidalgo', N'SAFS>PRED', N'ralhaddadi', N'Luz Angelica Hidalgo', N'ADMIN ASSISTANT', N'973')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Rahim Saheeda (SZC)', N'rsaheeda@szc.gcaa.ae', NULL, N'vpabraham', N'ANS>ATM', N'rsaheeda', N'Abraham Vadakkekalam Pothen (SZC)', N'Air Traffic Controller Assistant', N'001026')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Rahma Omar Al Ameri', N'ralameri@gcaa.gov.ae', NULL, NULL, N'SUP\ASS', N'ralameri', NULL, N'Receptionist', N'000864')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Ralf Hormes', N'rhormes@gcaa.gov.ae', NULL, N'aaljanahi', N'SAFS>FOPD', N'rhormes', N'Ahmed Al Janahi', N'SENIOR INSPECTOR FOREIGN OPERATORS', N'1015')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Ramachandran Madathil (SZC)', N'rmadathil@szc.gcaa.ae', N'+971504932589', N'vpabraham', N'ANS>ATC', N'rmadathil', N'Abraham Vadakkekalam Pothen (SZC)', N'ATCA', N'000932')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Ramez Shawky', N'rshawky@gcaa.gov.ae', NULL, NULL, N'SIAS>ATPD', N'rshawky', NULL, N'Project Portfolio Chief Officer', N'001141')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Rashed Ali Al Kaabi', N'rkaabi@gcaa.gov.ae', N'+971507766704', N'ahamili', N'UROO', N'rkaabi', N'Aysha Mohammed Al Hamili', N'UAE Alternative Representative to ICAO office', N'000132')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Rashed Humaid Al Alili', N'ralalili@gcaa.gov.ae', NULL, N'ialmazmi', N'ACRC', N'ralalili', N'Ismail Al Mazmi', N'Call Centre Agent', N'001001')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Rashed Mattar (SZC)', N'rmattar@szc.gcaa.ae', N'+971506717671', N'htenaiji', N'ANS>ATM', N'rmattar', N'Hesham Mohamed Al Tenaiji (SZC)', N'ATC Assistant', NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Rashid Adnan (SZC)', N'radnan@szc.gcaa.ae', N'+971502204274', N'nasser.al-marzouqi', N'SUPD\ASS', N'radnan', N'Nasser Ahmed Al Marzouqi', N'Public Relation Representative', N'000511')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Rashid Ismail Zada (SZC)', N'rzada@szc.gcaa.ae', NULL, N'htenaiji', N'ANS>ATM', N'rzada', N'Hesham Mohamed Al Tenaiji (SZC)', N'ATC Officer', N'000727')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Rashid Saeed Al Harmoul (SZC)', N'rharmoul@szc.gcaa.ae', N'+971504868866', N'oabdouli', N'ANS>ATM', N'rharmoul', N'Omar Obaid Al Abdouli (SZC)', N'ATC Officer', N'000063')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Rathnasiri Edirimannage (SZC)', N'redirimannage@szc.gcaa.ae', N'+971566132413', N'jammari', N'ANS>CNS', N'redirimannage', N'Jacob Ammari (SZC)', N'Senior Maintenance Technician', N'000423')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Raul Limbasan (SZC)', N'rlimbasan@szc.gcaa.ae', NULL, N'vpabraham', N'ANS> ATM', N'rlimbasan', N'Abraham Vadakkekalam Pothen (SZC)', N'ATCA', N'000933')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Raymond Bagshaw', N'rbagshaw@gcaa.gov.ae', N'+971508189344', N'michael.hayes', N'SAFS>ANAD', N'rbagshaw', N'Michael Edward Hayes', N'AIR TRAFFIC SERVICES INSPECTOR', N'000237')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Raymond Stanley Stanton (SZC)', N'rsstanton@szc.gcaa.ae', N'+971522952938', N'oabdouli', N'ANS>ATM', N'rsstanton', N'Omar Obaid Al Abdouli (SZC)', N'ATCO', N'000889')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'rdpservice', NULL, NULL, NULL, NULL, N'rdpservice', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Reach GCAA', N'reachgcaa@gcaa.ae', NULL, NULL, NULL, N'support', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Reem Chehade (SZC)', N'rchehade@gcaa.gov.ae', NULL, N'htenaiji', N'ANS>TRN', N'rchehade', N'Hesham Mohamed Al Tenaiji (SZC)', N'Training Admin Assistant', N'000895')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Reem Matar Al Haddad', N'rhaddad@gcaa.gov.ae', NULL, N'nasser.al-marzouqi', N'SUPS>FAPD', N'rhaddad', N'Nasser Ahmed Al Marzouqi', N'Receptionist', N'000468')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Regadmin', N'regadmin@gcaa.gov.ae', NULL, NULL, NULL, N'regadmin', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Regulated Agent', N'regulatedagent@gcaa.gov.ae', NULL, NULL, NULL, N'regulatedagent', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Regulations', N'regulations@gcaa.gov.ae', NULL, NULL, NULL, N'reg.inv', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Reham Hayatleh', N'rhayatleh@gcaa.gov.ae', N'+971567421993', N'omar', N'SUPS', N'rhayatleh', N'Omar Ghaleb Bin Ghaleb', N'ER Coordinator', N'001123')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Release Admin', NULL, NULL, NULL, NULL, N'releaseadmin', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Rensburg, Corne', N'crensburg@szc.gcaa.ae', N'+971501322763', N'oabdouli', N'ANS>ATM', N'crensburg', N'Omar Obaid Al Abdouli (SZC)', N'ATC Officer', N'000298')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Rep_test', NULL, NULL, NULL, NULL, N'rep_test', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'rfax', N'rfax@gcaa.gov.ae', NULL, NULL, NULL, N'rfax', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Rightfaxadmin', N'rfadmin@gcaa.gov.ae', NULL, NULL, NULL, N'rfadmin', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Rishil Vijay Nair (SZC)', N'rnair@szc.gcaa.ae', N'+971506545294', N'htenaiji', N'Training', N'rnair', N'Hesham Mohamed Al Tenaiji (SZC)', N'Pseudo Pilot', N'000529')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Riyana Abdul Hameed', N'rhameed@gcaa.gov.ae', NULL, N'psayeed', N'SECS>OIND', N'rhameed', N'Parvez Mohammad Sayeed', N'Dangerous Goods Officer', N'000821')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Riza Capuno Blanquera', N'rblanquera@gcaa.gov.ae', NULL, N'emesafari', N'DAS\LIC', N'rblanquera', N'Eman Mohamed Al Mesafri', N'FILING CLERK', N'1184')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'RODGO Investigation', N'RODGO.Investigation@gcaa.gov.ae', NULL, NULL, NULL, N'rodgoinvestigation', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Ronald Ortiz Rodigues (SZC)', N'rrodigues@szc.gcaa.ae', N'+971505329161', N'vpabraham', N'ANS>ATM', N'rrodigues', N'Abraham Vadakkekalam Pothen (SZC)', N'ATC Assistant', N'000555')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Ronmark Managuit (SZC)', N'rmanaguit@szc.gcaa.ae', NULL, N'vfernandes', N'ANS>AIS', N'rmanaguit', N'Victor Mariano Fernandes (SZC)', N'NOTAM Assistant', N'1025')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'ROSB Investigation', N'ROSB.Investigation@gcaa.gov.ae', NULL, NULL, NULL, N'rosbinvestigation', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'ROSI', N'rosi@gcaa.gov.ae', NULL, NULL, NULL, N'rosi', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Rovshan Sultanov (SZC)', N'rsultanov@szc.gcaa.ae', NULL, N'mtenaiji', N'ANS>ATM', N'rsultanov', N'Muayyed Al Tenaiji (SZC)', N'SENOIR AIR SPACE COORDINATOR', N'000810')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'RSA Admin', N'rsaadmin@gcaa.gov.ae', NULL, NULL, NULL, N'rsaadmin', NULL, N'RSA Admin', NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'RSA SSO', NULL, NULL, NULL, NULL, N'rsasso', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'RSABackup', NULL, NULL, NULL, NULL, N'rsabackup', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'RSADMIN', NULL, NULL, NULL, NULL, N'rsadmin', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Ryan Jon Nidoo (SZC)', N'rnaidoo@szc.gcaa.ae', N'+971503296906', N'oabdouli', N'ANS>ATM', N'rnaidoo', N'Omar Obaid Al Abdouli (SZC)', N'ATC Officer', N'000331')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Sabu Machathil (SZC)', N'sabu@szc.gcaa.ae', N'+971505620305', N'gregkurten', N'ANS>CNS', N'sabu', N'Gregory John Kurten (SZC)', N'CNS Engineer', N'000867')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Saeed Al Falasi (SZC)', N'sfalasi@szc.gcaa.ae', NULL, N'htenaiji', N'ANS>ATM', N'sfalasi', N'Hesham Mohamed Al Tenaiji (SZC)', N'ATC Trainee', N'000729')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Saeed Al Naqbi', N'salnaqbi@gcaa.gov.ae', NULL, N'ialmazmi', N'API', N'salnaqbi', N'Ismail Al Mazmi', N'Call Centre Agent', N'000868')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Saeed Al Suwaidi dxb', N'Saeeddxb@gcaa.gov.ae', N'+971505520011', NULL, NULL, N'Saeeddxb', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Saeed Almadhaani', N'salmadhaani@gcaa.gov.ae', N'+971565034255', N'salzara', N'SAFS>LICD', N'salmadhaani', N'Sultan Mohamed Al Zara', N'Aircrew Inspector - Commercial', N'001031')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Saeed Mohamed Al Rashdi', N'salrashdi@gcaa.gov.ae', NULL, N'ialmazmi', N'ACRC', N'salrashdi', N'Ismail Al Mazmi', N'Call Centre Agent', N'001011')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Saeed Mohd Al Suwaidi', N'saeed.alsuwaidi@gcaa.gov.ae', N'+971505520011', N'dg', N'DGOO', N'saeed.alsuwaidi', N'Director General', N'Office Manager - DG Office', N'000487')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Saeeda Mohamed Ahmed', N'saeeda@gcaa.ae', N'+971507358687', N'emesafari', N'SAFS>LICD', N'saeeda', N'Eman Mohamed Al Mesafri', N'Admin Assistant (Admin & Exam)', N'000488')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'SAFA UAE', N'safa@gcaa.gov.ae', NULL, NULL, NULL, N'safa', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Safety', N'Safety@gcaa.gov.ae', NULL, NULL, NULL, N'Safety', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Safety Planning and Standards', N'ps@gcaa.gov.ae', NULL, NULL, NULL, N'pstandards', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Safia BuMelha', N'sbumelha@gcaa.gov.ae', N'00971507494747', N'malhashemi', N'API', N'sbumelha', N'Maryam Al Hashemi', N'Chief Accountant', N'000813')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Safiya Kallingal (SZC)', N'skallingal@szc.gcaa.ae', NULL, N'vpabraham', N'ANS> ATM', N'skallingal', N'Abraham Vadakkekalam Pothen (SZC)', N'AIR TRAFFIC CONTROL ASSISTANT', N'001020')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Sahar Alzarooni', N'salzarooni@gcaa.gov.ae', NULL, N'walnaqbi', N'SUPS>HCD', N'salzarooni', N'Dr. Waleed Hassan Al Naqbi', N'Employee Relations - Officer', N'983')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Said Omar', N'somar@gcaa.gov.ae', N'0501293800', N'khalid.al-romaithi', N'SUPS>FAPD', N'somar', N'Khaled Sultan Al Romaithi', N'Procurement officer', N'001182')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Saidulkhadri Bin Hamzah', N'sbinhamzah@gcaa.gov.ae', N'+971506168837', N'hdibian', N'SAFS>AWRD', N'sbinhamzah', N'Hatem Mohamed Dibian', N'Senior Inspector - Airworthiness', N'000335')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Saif Abdulla Ali Moalla Al Hashmi', N'samoalla@gcaa.gov.ae', N'+971505896100', N'ialmazmi', N'Call Center', N'samoalla', N'Ismail Al Mazmi', N'Call Center Officer', N'000797')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Saif Al Hosani (SZC)', N'salhosani@szc.gcaa.ae', N'052 6766444', N'htenaiji', N'ANS>Training', N'salhosani', N'Hesham Mohamed Al Tenaiji (SZC)', N'ATC Trainee', N'000857')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Saif Al Mehairi', N'salmehairi@gcaa.gov.ae', N'+971562191551', N'psayeed', N'SECS>OIND', N'salmehairi', N'Parvez Mohammad Sayeed', N'Security Inspector - Oversight and Inspections', N'000705')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Sajan Samuel (SZC)', N'ssamuel@szc.gcaa.ae', N'+971558426105', N'vpabraham', N'ANS>ATM', N'ssamuel', N'Abraham Vadakkekalam Pothen (SZC)', N'ATCA', N'000839')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Sajan Samuel Seelas', N'ssamuel@szc.gcaa.ae', N'+971558426105', N'vpabraham', N'ANS>ATM', N'sseelas', N'Abraham Vadakkekalam Pothen (SZC)', N'ATCA', N'839')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Sajid Shaikh', N'sshaikh@gcaa.gov.ae', N'+971506425209', N'mj', N'SUPS>ITD', N'sshaikh', N'Mohammed Jameeluddin', N'IT Technician', N'001162')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Saleh Baomran', N'sbaomran@gcaa.gov.ae', NULL, N'yazizi', N'SAFS>PRED', N'sbaomran', N'Yousuf Hashim Al Azizi', N'Planning & Standards Specialist', N'000958')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Saleh Salim AlHarthy (SZC)', N'sharthy@szc.gcaa.ae', N'+971509726699', N'htenaiji', N'ANS>TRN', N'sharthy', N'Hesham Mohamed Al Tenaiji (SZC)', N'ATS Instructor', N'000294')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Salem Al Mutawwa', N'salmutawwa@gcaa.gov.ae', NULL, N'ialmazmi', N'API', N'salmutawwa', N'Ismail Al Mazmi', N'Call Centre Agent', N'000878')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Salem Jassim Al Shamsi', N'sshamsi@gcaa.gov.ae', N'+971506550466', N'laila', N'SIAS>EXAC', N'sshamsi', N'Laila Ali Al Muhairi', N'Manager - External Affairs', N'000480')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Salwa Almaazmi', N'salmaazmi@gcaa.gov.ae', NULL, N'aaljanahi', N'SAFS>FOPD', N'salmaazmi', N'Ahmed Al Janahi', N'Inspector - Foreign Operators', N'990')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Salwa Maki', N'smaki@gcaa.gov.ae', NULL, N'moalsuwaidi', N'AQRMD>QACC', N'smaki', N'Moza Alsuwaidi', N'Quality Assurance Officer', N'001024')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Saman Vajira Kumara (SZC)', N'svkumara@szc.gcaa.ae', NULL, NULL, N'ANS>CNS', N'svkumara', NULL, N'Technician (CNS)', N'1010')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Samar Mohamed Husain', N'szubaidi@gcaa.gov.ae', NULL, NULL, N'DGOO', N'szubaidi', NULL, N'Admin Officer', N'000319')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Sameer Boodu (SZC)', N'sboodu@szc.gcaa.ae', N'+971527567710', N'oabdouli', N'ANSS>ATMD', N'sboodu', N'Omar Obaid Al Abdouli (SZC)', N'ATC Officer', N'000855')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Sana Al Ali', N'sanaali@gcaa.gov.ae', N'+971562190303', N'aalhamoudi', N'SECS>ITAD', N'sanaali', N'Abdulla Rashed Alhmoudi', N'Security Clearance Officer', N'000687')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Sanaa Kiadi', N'skiadi@gcaa.gov.ae', N'0', NULL, N'SIAS>EXAC', N'skiadi', NULL, N'Senior Executive External Affairs', N'000532')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Sanderson Shane Geoffrey (SZC)', N'sgeoffrey@szc.gcaa.ae', NULL, N'oabdouli', N'ANS>ATM', N'sgeoffrey', N'Omar Obaid Al Abdouli (SZC)', N'AIR TRAFFIC CONTROL OFFICER', N'977')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Sanu Abdul Rahuman (SZC)', N'srahuman@szc.gcaa.ae', N'+971507126575', N'vpabraham', N'ANS>ATM', N'srahuman', N'Abraham Vadakkekalam Pothen (SZC)', N'Assistant Supervisor', N'000285')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Saqr Obaid Al Marashda (SZC)', N'smarashda@szc.gcaa.ae', N'+971507611717', N'htenaiji', N'ANS>TRN', N'smarashda', N'Hesham Mohamed Al Tenaiji (SZC)', N'Air Traffic Services Instructor', N'000204')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Sara Abualkhair', N'sabualkhair@gcaa.gov.ae', NULL, NULL, NULL, N'sabualkhair', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Sarah Kelly (SZC)', N'skelly@szc.gcaa.ae', NULL, N'oabdouli', N'ANS>ATM', N'skelly', N'Omar Obaid Al Abdouli (SZC)', N'ATC Officer', N'000802')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Sayed zeinal', N'szeinal@gcaa.gov.ae', N'+971504451457', N'malsaadi', N'SAFS>FOPD', N'szeinal', N'Mohammed Ahmed Al Saadi', N'Acting Manager Air Carrier', N'000750')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'ScanAdmin', N'ScanAdmin@gcaa.gov.ae', NULL, NULL, NULL, N'ScanAdmin', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'SCCMADMIN', NULL, NULL, NULL, NULL, N'SCCMADMIN', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'SCOMADMIN', NULL, NULL, NULL, NULL, N'SCOMADMIN', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Seema Siddique', N'ssiddique@gcaa.gov.ae', N'+971506848098', N'zmunawar', N'SAFS>AWRD', N'ssiddique', N'Zahid Munawar', N'Admin Assistant (Airworthiness)', N'000485')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Seymour Cauba (SZC)', N'scauba@szc.gcaa.ae', N'+971558426107', N'htenaiji', N'ANS>TRN', N'scauba', N'Hesham Mohamed Al Tenaiji (SZC)', N'Pseudo Pilot', N'000908')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Shabeeb Husain Abdul Ghafar (SZC)', N'sghafar@szc.gcaa.ae', NULL, N'htenaiji', N'ANS>TRN', N'sghafar', N'Hesham Mohamed Al Tenaiji (SZC)', N'ATC Trainee', N'000784')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Shafeek Thalhath Mohammed (SZC)', N'sthalhath@szc.gcaa.ae', N'+971502015529', N'dfernandes', N'ANS>AIS', N'sthalhath', N'Dean Fernandes (SZC)', N'Publication Assistant', N'000577')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Shahan Jamshid (SZC)', N'sjamshid@szc.gcaa.ae', NULL, N'vpabraham', N'ANS> ATM', N'sjamshid', N'Abraham Vadakkekalam Pothen (SZC)', N'AIR TRAFFIC CONTROL ASSISTANT', N'001021')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Shahid Qadeer', N'sqadeer@gcaa.gov.ae', N'+971506141604', N'laila', N'SIAS>CSPD', N'sqadeer', N'Laila Ali Al Muhairi', N'Senior Specialist- Strategy & Performance', N'000415')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Shahid Usman', N'susman@gcaa.gov.ae', NULL, N'emesafari', N'SAFS>LICD', N'susman', N'Eman Mohamed Al Mesafri', N'Filing Clerk', N'001171')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Shahzad (SZC)', N'shahzad@szc.gcaa.ae', N'+971508195635', N'gregkurten', N'ANS>CNS', N'shahzad', N'Gregory John Kurten (SZC)', N'CNS Engineer', N'000874')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Shahzad Haider', N'shaider@gcaa.gov.ae', N'+971506414043', N'mj', N'SUPS>ITD', N'shaider', N'Mohammed Jameeluddin', N'ERP Specialist', N'001019')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Shaijumon Mathew (SZC)', N'smathew@szc.gcaa.ae', N'+971504603134', N'jammari', N'ANS>CNS', N'smathew', N'Jacob Ammari (SZC)', N'Maintenance Technician', N'000356')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Shaikh Matibul Raheman', N'sraheman@gcaa.gov.ae', N'+971562127344', N'mj', N'SUPS>ITD', N'sraheman', N'Mohammed Jameeluddin', N'System Engineer', N'001154')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Shaikha Al Jneibi', N'saljneibi@gcaa.gov.ae', NULL, N'schelakara', N'SUP\ASS', N'saljneibi', N'Subharaman Chelakara', N'Payables and Payroll Accountant', N'001023')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Shaikha AL Zaabi', N'salzaabi@gcaa.gov.ae', N'00971509313391', N'michael.hayes', N'DAS>ANA', N'salzaabi', N'Michael Edward Hayes', N'Admin Assistant', N'000881')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Shaikha Ali Juama (SZC)', N'sjuama@szc.gcaa.ae', N'+971554452828', N'htenaiji', N'ANS', N'sjuama', N'Hesham Mohamed Al Tenaiji (SZC)', N'AIR TRAFFIC CONTROL TRAINEE', N'000696')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Shaikha Khalifa Al Shamsi', N'salshamsi@gcaa.gov.ae', NULL, N'laila', N'SIAS', N'salshamsi', N'Laila Ali Al Muhairi', N'Event Executive', N'000297')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Shaima Al Harmoodi', N'salharmoodi@gcaa.gov.ae', N'+971501333521', N'iaahad', N'SIAS>CODD', N'salharmoodi', N'Issa Abdel Ahad', N'SENIOR OFFICER PROJECT MANAGEMENT', N'975')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Shaima Alkamali', N'salkamali@gcaa.gov.ae', NULL, N'iaahad', N'SIAS>CODD', N'salkamali', N'Issa Abdel Ahad', N'SENIOR OFFICER PROJECT MANAGEMENT', N'1000')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Shair Ahmed Khan', N'sakhan@gcaa.gov.ae', NULL, N'pking', N'AVS\OIN', N'sakhan', N'Paul Ronald King', N'Dangerous Goods Inspector', N'000950')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Shamas Din', N'shamas@gcaa.gov.ae', N'+971506147520', N'mj', N'SUPS>ITD', N'shamas', N'Mohammed Jameeluddin', N'Software Engineer', N'001007')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Shamsa Al Muhairi', N'salmuhairi@gcaa.gov.ae', N'+971564120524', N'aahli', N'SUPS>HCD', N'salmuhairi', N'Amina Ahli', N'Manager - Manpower Planning and Recruitment', N'000882')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Shamseer Velumberi', N'svelumberi@gcaa.gov.ae', N'+97124054493', N'schelakara', N'SUP>ASS', N'svelumberi', N'Subharaman Chelakara', N'Junior FSS Accountant', N'000823')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'sharefileadmin', N'sharefileadmin@gcaa.gov.ae', NULL, NULL, NULL, N'sharefileadmin', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Sharjeel Vaseem Mirza', N'smirza@gcaa.gov.ae', N'+971502207612', N'mj', N'SUPS>ITD', N'vaseem', N'Mohammed Jameeluddin', N'Webmaster', N'000313')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Shatha Al Ali', N'shalali@gcaa.gov.ae', NULL, N'lhidalgo', N'SAFS>PRED', N'shalali', N'Luz Angelica Hidalgo', N'Aircraft Registry Assistant', N'000828')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Shawn Savio DCunha (SZC)', N'sdcunha@szc.gcaa.ae', N'+9715''+9715664124', N'vpabraham', N'ANS>ATM', N'sdcunha', N'Abraham Vadakkekalam Pothen (SZC)', N'Administrator', N'000558')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Shihan Fernando (SZC)', N'sfernando@szc.gcaa.ae', N'+971508148730', N'vpabraham', N'ANS>ATM', N'sfernando', N'Abraham Vadakkekalam Pothen (SZC)', N'Senior ATC Assistant', N'000574')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Shoeb Surya', N'ssurya@gcaa.gov.ae', N'+971 56 418 7740', N'mj', N'SUPS>ITD', N'ssurya', N'Mohammed Jameeluddin', N'Enterprise Architect', N'001178')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Siddharth Mandal', N'smandal@gcaa.gov.ae', N'+971504460754', N'hdibian', N'SAFS>AWRD', N'smandal', N'Hatem Mohamed Dibian', N'Inspector - Airworthiness', N'000777')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Sigurdur Hjaltason (SZC)', N'Sigurdurh@szc.gcaa.ae', N'+971502692070', N'frobert', NULL, N'Sigurdurh', N'Francois Robert (SZC)', N'AIR TRAFFIC CONTROL OFFICER', N'001006')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'SKGEP', NULL, NULL, NULL, NULL, N'SKGEP', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'SMARTGCAA', N'SMARTGCAA@gcaa.gov.ae', NULL, NULL, NULL, N'SMARTGCAA', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'smtpadmin', N'smtpadmin@gcaa.gov.ae', NULL, NULL, NULL, N'smtpadmin', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'snmpadmin', NULL, NULL, NULL, NULL, N'snmpadmin', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Social Media', N'sm@gcaa.gov.ae', NULL, NULL, NULL, N'sm', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Sohail Ahmad', N'sahmad@gcaa.gov.ae', NULL, N'mj', N'SUPS>ITD', N'sahmad', N'Mohammed Jameeluddin', N'Software Engineer', N'1187')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Sonal Dhople', N'sonal@gcaa.gov.ae', N'+971507956379', N'omar', N'DGOO', N'sonal', N'Omar Ghaleb Bin Ghaleb', N'Executive Assistant', N'000407')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'spaadmin2', NULL, NULL, NULL, NULL, N'spaadmin2', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'spadmin', NULL, NULL, NULL, NULL, N'spadmin', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Srdan Sladakovic (SZC)', N'ssladakovic@szc.gcaa.ae', N'+971508149880', N'oabdouli', N'ANS>ATM', N'ssladakovic', N'Omar Obaid Al Abdouli (SZC)', N'ATC Officer', N'000510')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Sripathi Babu Kilari (SZC)', N'sbabu@szc.gcaa.ae', N'+971555740978', N'vpabraham', N'ANS>ATC', N'sbabu', N'Abraham Vadakkekalam Pothen (SZC)', N'ATCA', N'000934')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'SRM', N'srm@gcaa.gov.ae', NULL, NULL, N'ACRC', N'srm', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'SSD', NULL, NULL, NULL, NULL, N'ssd1', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'SSD test', N'smoazzam@gcaa.ae', NULL, NULL, NULL, N'asis2', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'SSD/Admin', N'admin@gcaa.gov.ae', NULL, NULL, NULL, N'admin', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'SSD/Finance', N'fin@gcaa.gov.ae', NULL, NULL, NULL, N'fin', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'SSD/IT', N'it@gcaa.gov.ae', NULL, NULL, NULL, N'it', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'SSD/Procurement', N'procurement@gcaa.gov.ae', NULL, NULL, NULL, N'procurement', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'ssd2', NULL, NULL, NULL, NULL, N'ssd2', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'SSL VPN', NULL, NULL, NULL, NULL, N'sslvpn', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Staff Compliants', N'staffcompliants@gcaa.gov.ae', NULL, NULL, NULL, N'staffcompliants', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Staff Suggestions', N'staffsuggestions@gcaa.gov.ae', NULL, NULL, NULL, N'staffsuggestions', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Stanley Cecil Faulk', N'sfaulk@gcaa.gov.ae', N'+971506211905', N'michael.hayes', N'SAFS>ANAD', N'sfaulk', N'Michael Edward Hayes', N'ATS Senior Inspector-Air Navigation', N'000381')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Stanley James Facey', N'sfacey@gcaa.gov.ae', N'+971508189407', N'michael.hayes', N'SAFS>ANAD', N'sfacey', N'Michael Edward Hayes', N'CNS Inspector-Air Navigation', N'000247')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'State Audit Institution', NULL, NULL, NULL, NULL, N'SAI', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Steven David Murphy (SZC)', N'smurphy@szc.gcaa.ae', N'+971558070099', N'oabdouli', N'ANS>ATM', N'smurphy', N'Omar Obaid Al Abdouli (SZC)', N'ATC Officer', N'000614')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Steven Maxwell (SZC)', N'smaxwell@szc.gcaa.ae', NULL, N'oabdouli', N'ANS>ATM', N'smaxwell', N'Omar Obaid Al Abdouli (SZC)', N'ATCO', N'000921')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Steven Reeves (SZC)', N'sreeves@szc.gcaa.ae', NULL, N'oabdouli', N'ANS>ATM', N'sreeves', N'Omar Obaid Al Abdouli (SZC)', N'ATC Officer', N'000800')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Steven Reynolds (SZC)', N'sreynolds@szc.gcaa.ae', NULL, N'oabdouli', N'ANS>ATM', N'sreynolds', N'Omar Obaid Al Abdouli (SZC)', N'ATCO', N'000923')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Stuart Buck (SZC)', N'sbuck@szc.gcaa.ae', N'+971553734155', N'oabdouli', N'ANS>ATM', N'sbuck', N'Omar Obaid Al Abdouli (SZC)', N'ATC Officer', N'000653')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Stuart Colin Williams', N'swilliams@gcaa.gov.ae', N'+971504492841', N'mwoodward', N'SAFS>ANAD', N'swilliams', N'Mark Edward Woodward', N'AES & RFFS inspector Aero.', N'000708')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Subharaman Chelakara', N'schelakara@gcaa.gov.ae', N'+971506163072', N'omar', N'SUP>ASS', N'schelakara', N'Omar Ghaleb Bin Ghaleb', N'Manager - Finance & Budgeting', N'000795')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Sulaiman Ali AlAli (SZC)', N'salali@szc.gcaa.ae', N'+971505288994', N'oabdouli', N'ANS>ATM', N'salali', N'Omar Obaid Al Abdouli (SZC)', N'ATC watch Supervisor', N'000124')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Sultan Al Mehairi', N'smehairi@gcaa.gov.ae', NULL, N'salzara', N'SAFS>LICD', N'smehairi', N'Sultan Mohamed Al Zara', N'Air Crew Inspector - Commercial', N'000816')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Sultan Al Shamsi (SZC)', N'srshamsi@szc.gcaa.ae', NULL, N'htenaiji', N'ANS>ATM', N'srshamsi', N'Hesham Mohamed Al Tenaiji (SZC)', N'ATC Trainee', N'000726')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Sultan Mohamed Al Zara', N'salzara@gcaa.gov.ae', N'+971566886074', N'emaaa', N'SAFS>LICD', N'salzara', N'Ismaeil Mohammed Al Blooshi', N'Acting Director Licensing Dept.', N'000647')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Sunny Varghese (SZC)', N'svarghese@szc.gcaa.ae', N'+971506736031', N'vpabraham', N'ANS>ATC', N'svarghese', N'Abraham Vadakkekalam Pothen (SZC)', N'ATCA', N'000935')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Support Services', N'supportservices@gcaa.gov.ae', NULL, NULL, NULL, N'supportservices', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Support Services Sector', N'sss@gcaa.gov.ae', NULL, NULL, NULL, N'ssd', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'svc-blackberry-ldap', NULL, NULL, NULL, NULL, N'svc-blackberry-ldap', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Syed  Moazzam', N'smoazzam@gcaa.gov.ae', N'+971504436745', N'mj', N'SUPS>ITD', N'smoazzam', N'Mohammed Jameeluddin', N'IT WebMaster', N'001012')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Syed Aijaz Ahmed', N'sahmed@gcaa.gov.ae', N'+971502207597', N'mj', N'SUPS>ITD', N'sahmed', N'Mohammed Jameeluddin', N'Graphic Designer', N'000312')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Syed Hussain Pakartheen (SZC)', N'shussain@szc.gcaa.ae', N'+971504418533', N'gregkurten', N'ANS>CNS', N'shussain', N'Gregory John Kurten (SZC)', N'Maintenance Technician', N'000522')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Syed Shah (SZC)', N'sshah@szc.gcaa.ae', N'971567521890', N'kmanthanwar', N'ANS>AIS', N'sshah', N'Kedari Manthanwar (SZC)', N'AIS Design Officer', N'000876')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Syed Sherazi', N'ssherazi@gcaa.gov.ae', N'+971506425080', N'omar', N'SUPS>HCD', N'ssherazi', N'Omar Ghaleb Bin Ghaleb', N'HR Director', N'001153')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Syed Taqweem Ahmed (SZC)', N'sahmed@szc.gcaa.ae', NULL, NULL, N'ANS\ANS', N'syedahmed', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Systems', N'systems@gcaa.gov.ae', NULL, NULL, NULL, N'systems', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'szcsmart', NULL, NULL, NULL, NULL, N'szcsmart', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'szctest1', NULL, NULL, NULL, NULL, N'szctest1', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'TablAdmin', NULL, NULL, NULL, NULL, N'tabladmin', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Tahir Abdul Rashid', N'trashid@gcaa.gov.ae', NULL, N'salzara', N'SAFS>LICD', N'trashid', N'Sultan Mohamed Al Zara', N'Licensing Inspector', N'000805')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Tahir Hassan Al Hashemi', N'thashemi@gcaa.gov.ae', N'+971504545185', N'oghannam', N'SAFS>AWRD', N'thashemi', N'Omar Ahmad Bin Ghannam', N'Inspector - Airworthiness', N'000521')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Tahir Muhammad Ilyas', N'tilyas@gcaa.gov.ae', N'+971508183956', N'nasser.al-marzouqi', N'SUPS>FAPD', N'tilyas', N'Nasser Ahmed Al Marzouqi', N'Driver', N'000348')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Talal Abdulla Al Ansari', N'talansari@gcaa.gov.ae', N'+971506966969', N'mohamed.butaweel', N'SAFS>FOPD', N'talansari', N'Mohamed Khamis Butaweel', N'Flight Operations Inspector', N'000790')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Tamer Abdul Rahman Kataw', N'tkataw@gcaa.gov.ae', N'+971 56 6855868', N'hdibian', N'SAFS>AWRD', N'tabdulrahman', N'Hatem Mohamed Dibian', N'Inspector - Airworthiness', N'000657')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Tarek Beheiry (SZC)', N'tbeheiry@szc.gcaa.ae', NULL, N'frobert', N'ANS>ATM', N'tbeheiry', N'Francois Robert (SZC)', N'Air Traffic Control Officer', N'001040')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Tariq Mohammed AlMarzooqi', N'tareq@gcaa.gov.ae', N'00971566857478', N'mcala', N'SECS>OIND', N'tareq', N'Mladen Cala', N'Security Inspector', N'000649')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Tariq Musabbeh', N'tmusabbeh@gcaa.gov.ae', N'+971505520999', N'hamad.almuhairi', N'AVS>PRP', N'tmusabbeh', N'Hamad Salem Al Muhairi', N'Director Policy, Regulation and Planning', N'957')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Tariq Yousuf Fakhari', N'tfakhari@gcaa.gov.ae', N'+971506138748', N'psayeed', N'SECS>OIND', N'tfakhari', N'Parvez Mohammad Sayeed', N'Security Inpector', N'000508')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Technical Support', N'technicalsupport@gcaa.gov.ae', NULL, NULL, NULL, N'technicalsupport', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'terminal', NULL, NULL, NULL, NULL, N'terminal', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'test', NULL, NULL, N'test2', NULL, N'test', N'test2', NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Test User moi1', NULL, NULL, NULL, NULL, N'moi1', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Test User moi2', NULL, NULL, NULL, NULL, N'moi2', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'test-auh', N'test-auh@gcaa.gov.ae', NULL, NULL, NULL, N'test-auh', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'test-dxb', N'test-dxb@gcaa.gov.ae', NULL, NULL, NULL, N'test-dxb', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'test1', N'test1@gcaa.gov.ae', NULL, N'nkhan', N'COP>AAI', N'test1', N'Naveed khan', NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'test123', N'test123@gcaa.gov.ae', NULL, NULL, NULL, N'test123', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'test2', N'test2@gcaa.gov.ae', NULL, NULL, NULL, N'test2', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'testdeletion', N'testdeletion@gcaa.gov.ae', NULL, NULL, NULL, N'testdeletion', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'testgcaadchq02', NULL, NULL, NULL, NULL, N'testgcaadchq02', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Testing', N'testing@gcaa.gov.ae', NULL, NULL, NULL, N'testing', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'testShared1', N'testshared1@gcaa.gov.ae', NULL, NULL, NULL, N'testshared1', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'TFS Admin', NULL, NULL, NULL, NULL, N'tfsadmin', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Thani Al Suwaidi', N'thani.alSuwaidi@szc.gcaa.ae', NULL, N'hbelushi', N'Air TRafic Management', N'Thani.AlSuwaidi', N'Hamad Bin Rashid Al Belushi (SZC)', N'Military Coordinator', NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Thani Mohd AlKarimi (SZC)', N'tkarimi@szc.gcaa.ae', N'+971508222778', N'oabdouli', N'ANS>TRN', N'tkarimi', N'Omar Obaid Al Abdouli (SZC)', N'AIR TRAFFIC CONTROL OFFICER', N'000579')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Thaslin Nazly Deen', N'tndeen@gcaa.gov.ae', NULL, N'malsaadi', N'SAFS>FOPD', N'tndeen', N'Mohammed Ahmed Al Saadi', N'Inspector - Flight Operations', N'986')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Thomas Considine (SZC)', N'tconsidine@szc.gcaa.ae', NULL, N'oabdouli', N'ANS>ATM', N'tconsidine', N'Omar Obaid Al Abdouli (SZC)', N'ATCO', N'000922')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Thomas Curran', N'tcurran@gcaa.gov.ae', N'+971506239155', N'ismaeil.abdelwahed', N'AAIS', N'tcurran', N'Ismaeil Mohamed Al Hosani', N'Chief Air Accident Investigator', N'000709')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Thomas Mathew (SZC)', N'tmathew@szc.gcaa.ae', N'+971506713534', N'vpabraham', N'ANS>ATM', N'tmathew', N'Abraham Vadakkekalam Pothen (SZC)', N'ATC Assistant', N'000112')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Thomas Vamattathil Abraham (SZC)', N'vthomas@szc.gcaa.ae', N'+971505379048', N'vpabraham', N'ANS>ATM', N'vthomas', N'Abraham Vadakkekalam Pothen (SZC)', N'ATC Assistant', N'000608')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Thwaha Muhiyudheen Ullad (SZC)', N'tullad@szc.gcaa.ae', N'+971559969475', N'vpabraham', N'ANS>ATM', N'tullad', N'Abraham Vadakkekalam Pothen (SZC)', N'ATC Assistant', N'000545')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Time Attendance System', N'tbsadmin@gcaa.gov.ae', NULL, NULL, NULL, N'tbsadmin', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Timothy Foulsham (SZC)', N'tfoulsham@szc.gcaa.ae', N'+971555573399', N'htenaiji', N'ANS>TRN', N'tfoulsham', N'Hesham Mohamed Al Tenaiji (SZC)', N'Air Trafic Service Instructor', N'000911')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'tkataw1', N'tkataw2@gcaa.gov.ae', NULL, NULL, NULL, N'tkataw', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'TM_NTSERVER_105', NULL, NULL, NULL, NULL, N'TM_NTSERVER_105', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'tmsadmin', NULL, NULL, NULL, NULL, N'tmsadmin', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Todd Evan Erickson (SZC)', N'terickson@szc.gcaa.ae', N'+971506715301', N'oabdouli', N'ANS>ATM', N'terickson', N'Omar Obaid Al Abdouli (SZC)', N'ATCO', N'000898')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Tommy Stjernen (SZC)', N'tommy.stjernen@szc.gcaa.ae', N'+97156475332', N'oabdouli', N'ANS> ATM', N'tstjernen', N'Omar Obaid Al Abdouli (SZC)', N'ATCO', N'000836')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Trainee01', N'trainee01@gcaa.gov.ae', NULL, N'hmostafa', NULL, N'trainee01', N'Hemat Mostafa', NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Trainee02', N'trainee02@gcaa.gov.ae', NULL, N'hmostafa', NULL, N'trainee02', N'Hemat Mostafa', NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Trainee03', N'trainee03@gcaa.gov.ae', NULL, N'hmostafa', NULL, N'trainee03', N'Hemat Mostafa', NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Trainee04', N'trainee04@gcaa.gov.ae', NULL, N'hmostafa', NULL, N'trainee04', N'Hemat Mostafa', NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Trainee05', N'trainee05@gcaa.gov.ae', NULL, N'hmostafa', NULL, N'trainee05', N'Hemat Mostafa', NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Trainee06', N'trainee06@gcaa.gov.ae', NULL, N'hmostafa', NULL, N'trainee06', N'Hemat Mostafa', NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Trainee07', N'trainee07@gcaa.gov.ae', NULL, N'hmostafa', NULL, N'trainee07', N'Hemat Mostafa', NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Trainee08', N'trainee08@gcaa.gov.ae', NULL, N'hmostafa', NULL, N'trainee08', N'Hemat Mostafa', NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Trainee09', N'trainee09@gcaa.gov.ae', NULL, N'hmostafa', NULL, N'trainee09', N'Hemat Mostafa', NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Trainee10', N'trainee10@gcaa.gov.ae', NULL, N'hmostafa', NULL, N'trainee10', N'Hemat Mostafa', NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Training admin', N'trainingadmin@gcaa.gov.ae', NULL, NULL, NULL, N'trainingadmin', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Training Section', N'trainingsection@gcaa.gov.ae', NULL, NULL, NULL, N'trainingsection', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Trainingrequests', N'trainingrequests@gcaa.gov.ae', NULL, NULL, NULL, N'trainingrequests', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Troy saxby (SZC)', N'tsaxby@szc.gcaa.ae', NULL, N'oabdouli', N'ANS>ATM', N'tsaxby', N'Omar Obaid Al Abdouli (SZC)', N'ATC Officer', N'000743')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'TsInternetUser', NULL, NULL, NULL, NULL, N'TsInternetUser', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'UAE-ICAO', N'UAE-ICAO@gcaa.gov.ae', NULL, NULL, NULL, N'UAE-ICAO', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'uae.candidate', N'uae.candidate@gcaa.gov.ae', NULL, NULL, NULL, N'uae.candidate', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Ultadmin', N'test1@gcaa.ae', NULL, NULL, NULL, N'ultadmin', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Ultflow', N'ultflow@gcaa.gov.ae', NULL, NULL, NULL, N'ultflow', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'UnityInstall', NULL, NULL, NULL, NULL, N'UnityInstall', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Unni Krishnan (SZC)', N'ukrishnan@szc.gcaa.ae', N'+971504924619', N'vpabraham', N'ANS>ATM', N'ukrishnan', N'Abraham Vadakkekalam Pothen (SZC)', N'ATC Assistant', N'000113')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'ups6', N'ups6@gcaa.gov.ae', NULL, NULL, NULL, N'ups6', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Vadakkae Avarakkan Abdulla (SZC)', N'vaabdulla@szc.gcaa.ae', N'+971506465039', N'aljanaahi', N'ANS>CNS', N'vaabdulla', N'Ali Al Janaahi (SZC)', N'IT Technician', N'000775')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Valdemaras Batuchtinas (SZC)', N'vbatuchtinas@szc.gcaa.ae', NULL, N'frobert', N'ANS> ATM', N'vbatuchtinas', N'Francois Robert (SZC)', N'AIR TRAFFIC CONTROL OFFICER', N'1007')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Valentina Gargalic', N'vgargalic@gcaa.gov.ae', N'+971501785118', N'emesafari', N'SAFS>LICD', N'vgargalic', N'Eman Mohamed Al Mesafri', N'Admin Assistant Admin & Exam', N'000535')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Valerie Browne', N'vbrowne@gcaa.gov.ae', NULL, N'khalid', N'SIAS>ATPD', N'vbrowne', N'Khalid Humaid Al Ali', N'Air Transport Agreements Chief Specialist', N'000804')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Valerie Ray Eid (SZC)', N'veid@szc.gcaa.ae', N'+971503487828', N'oabdouli', N'ANS>ATM', N'veid', N'Omar Obaid Al Abdouli (SZC)', N'ATC Watch Supervisor', N'000243')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Varghese Koshy (SZC)', N'vkoshy@szc.gcaa.ae', N'+971508186488', N'vpabraham', N'ANS>ATM', N'vkoshy', N'Abraham Vadakkekalam Pothen (SZC)', N'Assistant Supervisor', N'000114')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Vasudevan Dileep Kumar (SZC)', N'dileep@szc.gcaa.ae', N'+971505216259', N'vpabraham', N'ANS>ATM', N'dileep', N'Abraham Vadakkekalam Pothen (SZC)', N'FLIGHT DATA SUPERVISOR', N'000534')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'VCadmin', NULL, NULL, NULL, NULL, N'vcadmin', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'VeeamAdmin', NULL, NULL, NULL, NULL, N'VeeamAdmin', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'veeampoc', NULL, NULL, NULL, NULL, N'veeampoc', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Vendor', NULL, NULL, NULL, NULL, N'vendor', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'vendorregistration', N'vendorregistration@gcaa.gov.ae', NULL, NULL, NULL, N'vendorregistration', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Verifications', N'Verifications@gcaa.gov.ae', NULL, NULL, NULL, N'Verifications', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Victor Mariano Fernandes (SZC)', N'vfernandes@szc.gcaa.ae', N'+971506149331', N'dfernandes', N'ANS>AIS', N'vfernandes', N'Dean Fernandes (SZC)', N'NOTAM Officer', N'000070')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Vijay Prasath', N'vprasath@gcaa.gov.ae', NULL, N'mj', N'SUP>ITD', N'vprasath', N'Mohammed Jameeluddin', N'Information Security Officer', NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Vincent Porter (SZC)', N'vincent.porter@szc.gcaa.ae', NULL, N'oabdouli', N'ANS> ATM', N'vporter', N'Omar Obaid Al Abdouli (SZC)', N'AIR TRAFFIC CONTROL OFFICER', N'000837')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Vinod Victor Pereira (SZC)', N'vpereira@szc.gcaa.ae', N'+971508357483', N'vpabraham', N'ANS>ATM', N'vpereira', N'Abraham Vadakkekalam Pothen (SZC)', N'Assistant Supervisor', N'000530')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Vivek Odakkayi Manden', N'vmanden@gcaa.gov.ae', NULL, N'schelakara', N'SUP>ASS', N'vmanden', N'Subharaman Chelakara', N'Payables and Payroll Accountant', N'000391')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'vorsy', N'vorsy@gcaa.gov.ae', NULL, NULL, NULL, N'vorsy', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'W Boosabaduga Niroshan Fernando', N'nfernando@gcaa.gov.ae', N'+971506662190', N'nasser.al-marzouqi', N'SUP>ASS', N'nfernando', N'Nasser Ahmed Al Marzouqi', N'Admin Assistant - Facilities Management', N'000095')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Wafa Abdulla Al Obaidli', N'walobaidli@gcaa.gov.ae', N'+971506141189', N'hamad.almuhairi', N'SECS>OIND', N'wafa.al-obaidli', N'Hamad Salem Al Muhairi', N'Director Oversight and Inspection', N'000163')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Wafa Meer', N'wmeer@gcaa.gov.ae', NULL, N'oghannam', N'DAS\AWR', N'wmeer', N'Omar Ahmad Bin Ghannam', N'Admin Assistant', N'000902')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Wafa Salim Al Hosani', N'wafa.salim@gcaa.gov.ae', N'+971507374535', N'emesafari', N'SAFS>LICD', N'wafa.salim', N'Eman Mohamed Al Mesafri', N'Admin Assistant (Admin & Exam)', N'000150')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Waleed Al Riyami', N'walriyami@gcaa.gov.ae', N'00971564186953', N'michael.hayes', N'DAS>ANA', N'walriyami', N'Michael Edward Hayes', N'Air Navigation Inspector', N'000866')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Walid Ghanim Mohammed', N'wgalghaith@gcaa.gov.ae', N'+971566877228', N'dg', N'ACRC', N'walid.ghanim', N'Director General', N'D.Q&R Management Dept.', N'000075')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Walid Ibrahim Al Rahmani', N'wrahmani@gcaa.gov.ae', N'+971506501116', N'emaaa', N'SAFS>PRED', N'wrahmani', N'Ismaeil Mohammed Al Blooshi', N'Director Policy, Regulation and Planning – Safety Affairs', N'000317')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Walid Mubarak', N'wmubarak@gcaa.gov.ae', NULL, N'malhashemi', N'API', N'wmubarak', N'Maryam Al Hashemi', N'System Administrator', N'000892')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Web Application Manager account', NULL, NULL, NULL, NULL, N'IWAM_NTSERVER_1', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'webadmin', NULL, NULL, NULL, NULL, N'webadmin', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'wireless', NULL, NULL, NULL, NULL, N'wireless', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Wolf Lennart Didszuhn', N'wldidszuhn@gcaa.gov.ae', N'+971562195108', N'wrahmani', N'SAFS>PRED', N'wlennart', N'Walid Ibrahim Al Rahmani', N'Specialist - Policy and Regulation', N'000811')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'wsadmin', NULL, NULL, NULL, NULL, N'wsadmin', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'xtendersvc', N'xtendersvc@gcaa.gov.ae', NULL, NULL, NULL, N'xtendersvc', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'xtreme', NULL, NULL, NULL, NULL, N'xtreme', NULL, NULL, NULL)
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Yahya Awadh Shabibi', N'yshabibi@gcaa.gov.ae', N'+971506627807', N'nasser.al-marzouqi', N'SUP>ASS', N'yshabibi', N'Nasser Ahmed Al Marzouqi', N'Public Relation officer', N'000050')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Yameen Saahebul', N'ysaahebul@gcaa.gov.ae', NULL, NULL, N'SAFS>AWRD', N'ysaahebul', NULL, N'Senior Inspector Engineering', N'000740')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Yasser Rahmataalah Yar Mohammed (SZC)', N'ymohammed@szc.gcaa.ae', NULL, N'oabdouli', N'ANS>ATM', N'ymohammed', N'Omar Obaid Al Abdouli (SZC)', N'Air Navigation Services Provider', N'000682')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Yomna Gaber Moustafa', N'ymoustafa@gcaa.gov.ae', NULL, N'schelakara', N'SUP>ASS', N'ymoustafa', N'Subharaman Chelakara', N'Receivable Accountant', N'000390')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Yousaf Ishaq Khan', N'yikhan@gcaa.gov.ae', NULL, N'nibrahim', N'SUPS>LGLD', N'yikhan', N'Nadia Ibrahim AlMaazmi', N'Lawyer', N'000893')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Yousef Obaid Al Zaabi', N'yalzaabi@gcaa.gov.ae', NULL, N'ialmazmi', N'ACRC', N'yalzaabi', N'Ismail Al Mazmi', N'Call Centre Agent', N'000993')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Yousif Abdul Rahim Al Awadi (SZC)', N'yawadi@szc.gcaa.ae', N'+971502226262', N'hbelushi', N'ANS>ATM', N'yalawadi', N'Hamad Bin Rashid Al Belushi (SZC)', N'Senior Resarch and Dataset Officer', N'000168')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Yousif Al Falasi', N'yalfalasi@gcaa.gov.ae', N'+971504492843', N'michael.hayes', N'SAFS>ANAD', N'yalfalasi', N'Michael Edward Hayes', N'Air Navigation Inspector SAR', N'000718')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Yousuf Abduula Zeyoudi (SZC)', N'yzeyoudi@szc.gcaa.ae', N'+971502044423', N'oabdouli', N'ANS>ATC', N'yzeyoudi', N'Omar Obaid Al Abdouli (SZC)', N'ATCO', N'000261')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Yousuf Al Rais', N'yalrais@gcaa.gov.ae', NULL, N'mohamed.butaweel', N'DAS\FOI', N'yalrais', N'Mohamed Khamis Butaweel', N'Senior Cabin Inspector', N'000938')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Yousuf Hashim Al Azizi', N'yazizi@gcaa.gov.ae', N'+971506158891', N'wrahmani', N'SAFS>PRED', N'yazizi', N'Walid Ibrahim Al Rahmani', N'Manager Plaining & Standards', N'000478')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Zafar Alam', N'zalam@gcaa.gov.ae', NULL, N'mj', N'SUPS>ITD', N'zalam', N'Mohammed Jameeluddin', N'Software Engineer', N'001161')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Zahid Munawar', N'zmunawar@gcaa.gov.ae', N'+971508110926', N'azarouni', N'SAFS>AWRD', N'zmunawar', N'Aqeel Ahmed Al Zarouni', N'Manager - Engineering Safety', N'000277')
GO
INSERT [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ([DisplayName], [EmailAddress], [MobilePhone], [ManagerLogin], [Department], [LoginName], [LineManagerName], [JobTitle], [EID]) VALUES (N'Zornitza Georgieva Valeva', N'zvaleva@gcaa.gov.ae', NULL, N'moalsuwaidi', N'ACRC', N'zvaleva', N'Moza Alsuwaidi', N'Quality Specilist', N'000496')
GO
SET IDENTITY_INSERT [dbo].[GCAA_ESS_Leave_Attachments_VehicleMaintenance] ON 

GO
INSERT [dbo].[GCAA_ESS_Leave_Attachments_VehicleMaintenance] ([DOC_ID], [FILENAME], [DOCUMENT], [REQUESTID]) VALUES (CAST(1 AS Numeric(18, 0)), N'Readme.docx', 0x504B0304140006000800000021004A980B5CD10100001B0A0000130008025B436F6E74656E745F54797065735D2E786D6C20A2040228A000020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000C4964D4FE3301086EF48FB1F225F57890B2BA1156ACA61812320D11567D79E34D6C61FB2A740FFFD4E9A3602547080465C2225F6BCEF33338E3CD3F327D3640F10A276B664C7C5846560A553DA2E4BF6777E95FF6659446195689C8592AD21B2F3D98FA3E97CED2166146D63C96A447FC679943518110BE7C1D24AE5821148AF61C9BD90FFC412F8C96472CAA5B30816736C35D86C7A01955835985D3ED1E78E24401359F6A7DBD87A954C78DF68299048F98355AF5CF2AD4341919B3DB1D63EFE240CC6F73AB42B6F1B6CE36EA834412BC86E45C06B6108833FBAA0B87272652887E27D993D9CAEAAB4843EBE55F3C14988916A6E9AA25F3142DB1DFF9B1C7665161028F2F020BD741222E2BA817878824E77A0FDBDC6FAB2AA40D2894B37C5C4BCAD7CD1593C8B4DBB0122D57B88C9CBFF204F753E6E9593088FB0B81B8DE2997812A4720EADC3317ADF4B2721C0AA911876CA49841A8482703CE0DC7DF04874C203FD4FBECDBF6DD628F977C2C9FCBB6D23E43FD0BF6BD3AF6FAEFF08FE03F3AFE89E9E8B450387AF402F9D3C0448C307F0CDF3EB7FE246E63D4BBAA66F83F3918699F089B477D34A1B9DD3FDEF21A0867E5ED977DFF78E34087DB9CED08E5A0AD41E6FBE19ED66FF010000FFFF0300504B0304140006000800000021001E911AB7F30000004E0200000B0008025F72656C732F2E72656C7320A2040228A0000200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008C92DB4A03410C86EF05DF61C87D37DB0A22D2D9DE48A17722EB038499EC01770ECCA4DABEBDA320BA50DB5EE6F4E7CB4FD69B839BD43BA73C06AF6159D5A0D89B6047DF6B786DB78B075059C85B9A82670D47CEB0696E6FD62F3C9194A13C8C31ABA2E2B38641243E226633B0A35C85C8BE54BA901C4909538F91CC1BF58CABBABEC7F457039A99A6DA590D6967EF40B5C758365FD60E5D371A7E0A66EFD8CB8915C807616FD92E622A6C49C6728D6A29F52C1A6C30CF259D9162AC0A36E069A2D5F544FF5F8B8E852C09A10989CFF37C759C035A5E0F74D9A279C7AF3B1F21592C167D7BFB4383B32F683E010000FFFF0300504B0304140006000800000021001E637703C50100000D0900001C000801776F72642F5F72656C732F646F63756D656E742E786D6C2E72656C7320A2040128A0000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000AC96C14EC3300C86EF48BC43953BCD321830B48E0B2071E0C28638A7ADBB96B5499518D8DE1EB3AA5DC7BA70C965925DC5FF97DF4EB2D9FDA62A832F30B6D02A62221CB10054A2D342AD22F6B67CBAB8658145A952596A0511DB8265F7F3F3B3D92B94126991CD8BDA065445D988E588F51DE736C9A19236D43528FA92695349A4D0AC782D93B55C011F8F46D7DCF46BB0F941CDE0398D98794E497FB9AD49F9FFDA3ACB8A041E74F25981C201099E532553166A4D45A5590136652D31D39E21AC6CAAC2AA488CB63AC330D1155FA4EB8596F587BD98C613114FA7B25DFB422B22F6B841304A968C0FF38B4BAF1B0099826909887E175F86E4F2298053FA87DB6CBCFBF5ECE6B02DDCE2B604FB5E60FE986590A0DDAB1F7D7271DCF8F40154AA34D22C767D6C332E0431F6C9906922E8F5A289C72E00AFFA8DFB7B079AD8252FAE7DEE1FE990C35E7E17F2DDAF7042F864509F550C862EAB3D479772417835E2B7F17FA6B14BB92084F069C5F0383A5B31F1A9FF0DF10210A917BD53D94B3A9DF04A9269854B1997BDE1EC524E0A7AFC3CBE358357B5F37AB8F2A96F8F9AD1665C1E4C7D2234AF13556CDFDA9D25CE91145E3D183E13DD73C90FFEC4CC7F000000FFFF0300504B030414000600080000002100C17F0ECF30170000B479000011000000776F72642F646F63756D656E742E786D6CEC5D4B73E33892BE6FC4FE0784CE2E5BF2B3AC186BC296EC6EEF7475792CD7F665233A6809B258A6082E4959569DE66FEC757FDAFC92F9120F0AA04099921FD5D5E3A8836D900412F9CE4422EB2F7F7D9C44EC81A75928E293466BBBD9603C1E886118DF9D34BEDC5C7CF8D860591EC4C32012313F69CC79D6F86BE73FFFE32FB3F6500CA6131EE70C53C4597B960C4E1AE33C4FDA3B3BD960CC2741B63D0907A9C8C428DF1E88C98E188DC201DF998974B8B3DB6C35E56F492A063CCBB05E37881F82ACA1A79B2CCF26121E63AD914827419E6D8BF46E6712A4F7D3E403664F823CBC0DA3309F63EEE6A199469C34A669DCD6007D2800A24FDA0A20FDC37C912EEDC2B3AEFAB2A7312057DC49790418449C8DC364B18D4D67C316C706A487559B789844E6BD59D2DA5F5AAFD8721D1AF4D26006522C265C9ACE838CA1FA6812293C107D17542DCFD86AAEDA8CA6084D51C0500704774D03C92408E3629ACD5063231712F11CFEFE2915D3A40027099F37DB657C5FCC4582B90664CD432979F6D6B2B5265812DDFE384878834D06EDCBBB58A4C16D048866AD7D461CD9E84059DC8AE19C7E266CD686B2195E9F349ACDA3B3E6E145B76186AE207ACDE6D9EEEEC141AB18ECF151308D727A72DC3BBA382E5EBFB26690335FA5F2473F9F471C533E04D149E3671E902A6B3576E8D9D781191F406FF1548DA6EAC3EC9B79B8DF540FB26FDDAC3C1605F19D198BE30FBF7EA65777B0279A043F1335598A77E4369D3D110C2FB7DAAC9D773E1905CB7AF33880A867AC7BFD8900C915587249038C853133F4BAF0912E6F674930003B2429CF78FAC01B1DD6EFFDCD0191F0266967A09280B6F6CF7A47051F38809AF72CE638EBB6BA07E7E675C51C6A0639B38F39AED230CE7BE14348C6EF26CC235E834D062212445DC95EC134178657CCD8DEAE1959708F197B79EE3133DBBC6AC656AE461C721EE7B097EC13CF83619007EC2C1533D0C8A10D38D6609BA872DE3DEA1DC2BAD6666F03CC260056B0CF2AF856A914AFF83D07BECE35D4CB843BF07879B97774D83B5CE8B4A778D97D5DF2F27173AFD5EB49556A548C62E99544360AC90BD4E1F1C1D9E95E414A4B965AA7871747AE2C59EB4B352BBDBE65D1BE1973E6A0A3C43E5A4A891295ECC7E03C3C84439EB11CB30D8224507E1DCB05E38F507231974F26866DE110B2208AE420F47A9887F8368CE5DFD93CCBF964DB81694D6CB87892D4D043959AC5363B8606C084DA767F3A81DB3A5F1B24C5352E34D716D58E5AADB35EC164B5E0BCE18FB9366086AB248C7EC123E28E441409721117540A5652DC4255DEB94D433E6202F1C643C8674C8C248D7221A27FFEE3FF32369AC603F2A00372E319820E164E92885390213DEBEF4446A9D097C878354D1391D5107ED7325D6BE177CC954D46F77549464B6A349912C7CBA92263A7C71F78048F3DCD80EB9CC72CE67C4872140C28E88290A8600A3867C1AD98E608FEB4FCE4E3206743C16291B3204978901A911A2A8F8C65229A12B5B6D9CD3874E7C29FC1431046E40812A3DCA501783E0F0710D339BDCF5985ED59B0150FB29043B015A480392FADF2D2DCA0559CF4141D37B524724FC9A1FB7A2D39D4FAA2CC68AE957524E9860FC6315C91BB3A7AE46CAFD9DDF7297A0FAF59AB685E2327A74F3E5CEFDCF838DA415E3CF9B5FC64F8759AE5D7E1DD38BF84186B77C9F8D5988C3408A2020EFE836F88ACC3AC1D80432902A0DF2328F993C62E3C71FDC7F594420AE36F9585B15A5F55B1197128F37BCF056383E320038E9E2E99B3EEDED1DE51575AE5BC33CD78567E798536AD3DB17F733FDF7CFA65698A15CBFDC66F193C70314D21F94B1F02CB455476BCB77BBCA75C8D0A2B0F612C6FD49EC0C68A1FF8619825513097DA5F6A9C3933D65C6907E98E824629CF61321EA0B4A69422921FF43F9F5E414F0D1301F71D062965CEDEB65DD8FCC6BE52220E9D2715C2BBE0FB3FAC4474A44E362A1AD803D1BFFE7DCA536D5733667266142C87F998FD24C41D7EEF8E5331E15BEC93F8164651C02EC21442FAB825CDF12545CD31CFD9F963823008EA59A70ED931031DC690779ED6D0CB9A430CD3584E8CFBE487C67FB58DF3690A830B0AB25A1F0F4ECFB45AF10B1094D70449DA5108C9302410A3B250AE5007AE9094D5DA71B3B77BA8D49A7F7DF2CC4BAB8DE7F033A0B7EF59DA0E87278DF47288DCF1AC0DAB9D8B748EE4B29C30B537DA550B99216559F52001AF9325A9E3EDFC6C16D29EAB7E29EFF487F7DB7D1124DB5F331685B7A9C7C92E8094B39B7509E7D6AA79A7060BEF41F5B70A6FDB76E0DC273F1E0B7B35A6BBA93FD376C165524E3AA70821BBFDBE5474FF05F7B53F48C30406268CA03B21B24376AB2C56395FC292E00EAF042967084EC349F80DEFCAE8251E44D321FE2005AB035269B7D50719F9B4F0304898C80AE2FB42618B389A4345C719A4879C77BC9472CEE4D733DB94BFB32AF484E3AEFFF959D5AF9329AA2A58F356A5F210C1813329860B152FC270C09EF314877CC8A210032E29F242432B75ACD1A964A41B85E0D49F22711B445D016FE03187B6DD0EB2E4B1640E8A5948B97E3C68ED778F5619140A2E71E8038F0240DDC1C320C0C0FFB40213B75FF9004302D9209DE729AD8618538CCE535A348779386964098FA27E1EA432BF51B26FB67DED6031B5AB2FD7BFD49AF53C1EAA0CAFB3457B4E3F7DC8C51D8B61690D6792A7F16482ED8CDDF24100ADA409AB9C6378CCA45A58301C421F0D874885513605881C52CE0CBA661080F0914AAD9520590F8736A89D8C472010CE89D3BCD6A47E14DA5356A010A1007CFED9381C8C9129907F654CAD4E1820A53B10C95C62837853A61AACFCA17AB5788F49F602D6906712298EB9736860C97AE027F05D7A17C4E137997B62600F8637316B1A0C7228F5111C65F92ED2614331639118A83715BBD650CC5D153E1A37E4A9C482FBFA9FC4B170B396B663E13E91DBD543A48BBC89B09579D7CB180C8A908664C2E152AFC3E3AE6EC3E5218305977226FCECAB21904C5358FA206373316533318DC86BC0718CF74CAF700DB6D9A54A6D3B7BB0349CF6A217A909AF17DDCF5381837EEBF49252F27D9EE7109EB5F218F07B822DDBC5790DC0BA4827097856CBD433FE9B1FE5EC8E4EDDB58A28872C85EE7D16CA741A741D9C6DB3BED4984F00B4DB6B1D9F9EA9B0499F2B3B91909F86975297958920ED77058E0A4D4699F85B647A498F6A55B9CA4190A6FD68EFF0BC382BD2D9ED8F6A90D65C83F98CF3A28F217FDFFBBD897FADDF27410CA336DCFE1626E55D19D56941B2DEA2151829AF23B1D7A15040A979A87F73C0144CE4A908B92E106599A42E2AA3F43BB00E712470C64AE970154F50DA8A50BB10769CDBD3C1388391C68FFF29436076BAC4AA79E70654CBCA1FD4B7E69E194B9428C1E29FDA6FD32D16AE1556BBC9735BEDBA4F2AAC9F7B2EB2D21C7C29128A5F725937E6ECD26B13DCE4A00D9CDEA6269204AED56AEE1E2AE1F5DAAAAA431B3F479E52721C3C274D9872F616D1E2966146670B964920F1B0E0594326FB55DACDF0E37A5323E58F0F65ED843C0C009A353015A966A5BFCBFB5AA1CCD6B044166FAE81918D2D5179131518CC3B6450CB2FAFD871A5112991A602C354D027555179490F7C6648A98C658EBA2DB913468FAC9A5A0B95A5B64BB3F805A2CEAED705B746FD8BB5E70A7C168E9AB4A2F29C9B143DA2E55178374D55884051DA8B1F5458B0ADA371A2002775384F4152607805B8CEC07EF7F21414A64545E125C875CC89CCC2F20132ED75E1DBC28FC86782DD4EF31CB92C8AE0A30087FC63C970F44465C274724225CAE43333458D28AA5A2BBB4F36D2CA6BDA01CF8A7A88F8DB4B958AB35F29F01D2340DED2ACE7C3B621C7186D7981FC0C554806D92044396B9FDF09CEBE5C3630343E45EAD21D1AA0C8B478A5A428E469954C5DE8A3413A9E4505398CDECE10753E218AD475C588C900C973C38D2A7D9C233EDB8A6F40BD2A2BDEF98DCED4A43728B745211E722F6D47133E9F804F315719BCB75B71D68EA71315B484D143049658587DF9ECB2280BD895E5B9004D7F4140EA704749810E96825895A7200B2F143B2C0E85CF6B9432FE989BFF6CECB30AC8107948CE9FD3C9F7C4387EA626C7C95885AABC4ABF9E4D13CA71A910E53BB16141E259FBB94CE1F70AAE782AD112A8CC5E86B225323682A22E72A0B576314824F5B1E0A1456D9B4619021D9C69523961BBEC6EF863203BE1AC5957DE84F91541A2837270B83763BD08A2E4E7FE4D6E6D0ACC2FE28E4AB0FE20D0F45411C81F049ACFF28CE10687075D24CB5F925888F46B4DB7CC3CC6FA5F960F0D5632CF8FA9E62E94804AC923B1C4592B25435D499C33189169A9CCEA87DE2FB9CB0B3563E92793202A697D8793DE6EE7B41299E4D75F71A53B7CFE07B3F22FEB081B24EB8CF6CB4E4ED97D8F97AD9C6B78DBB2FA37D0595F631FE7EB875F2A35E07AD22FE46317B9A2F465028F57C7F74BC500AF8AD3FA6EBAC9D8155FBC2C875AE47013375690F3B22B924CFC37859526A6B434B1D1BFDA00D18988F621AB54F6DAAAF99DAC54964E8EEECB93B5326AE2288A78DBD0E99DCCAF47E6EE18F771D575302DA8B2CA451EA85335874E14BC8BA637F3F61D352E2951A35A73D4F823432CD3C9DEB4DF365B58529906DC389BF6F6B2A8AF9EC3665A09AF3FA5255D56B981A16C6D85BBF8E279E9AA773ABF9ACEF5E7A4EA27DE0A12FB536FC5E3F593266FE8352E1CC5767FD30CDFDB81EB27D90669C4B703B9B379AEF2ED80FC11F1BA79D6F5FBE375934CEADB415D1CD6BE7CBAF6DD9CBD9A39EBE8C47361778AD473316212B41B679FDFC9F7EAE4AB4ACAC8FBC1F4B0C8A317647D3A28D465AC468558D754DD27AA18519515503AC35BE7618EE2D739037DBB38E175B2302AB986639C7B3ECF180EA971AD1F79345DFBAAE23F37C54C9DC2C43DB5F593C761403DDD25956D00621CA29E347EFF499C05837B7503C7BC8B63D3E24D5559B2DC4FAA94927E7B9994C42C973EBC1D850D173B1B7F45B2EBE8DEE98A5804F21C1797289257771F362A8C71F661366789A84BEF9710D17FE750DE2663ED68DEF9E83DA05F54C75595C27D9F845CFDD8DD26A809DFD5893C6E9546FC41A75CC9DED2354CBAB76C7FF2B4C57585F6FA5DC6DFC471B269640A2F9C3149E31F807AFF3626D69F79F8E73FFE5F7A5CDAF426297A5B461CBD090ABB8B0BAC4E02DD4DB291FA91FEAB31A77483A02492EF1616C87976C1B39F7E3A1425F5B928542CA868552A3AA258554B68D79319823A0AF5759C3F7455555CF70269105D9F6EA0B778CF7DA2BC3BD5CF5232B02A1F766F839900CC18592FB71F9CEE7F3C2D7A0C3FB37065452DD3AA4B1724C374C5AB8BAEE6117F64574519AA43772FFCEE45341B7EF7C94618D3854915175F7E1BE322116917827D9120DF52D79BD14C0A31B8EE42E0EC03B31A0293BEB9383CEC3577655940DEC9D08BAAFC3211B80204579D9526D6A45DF139B5C42284AFB1E2629FB2FF0B7F4C502942F73C55EB8189C872EA1D339AE20203952E520B81856C535F189C78CAAE49F2E01A852868C18B63EBBB3B0CA2DF195A35A2D3133AC3A8422D44CF846135B933446D3D641306757D264FA7837C8AEF748F4DD5506DA468819B3E34B369AEC65011817D384D1AE5E5256AB010A0598480464A171E9E9CCB7493401F8A6222F7522C5D63DB661708F6A96B2B10CB50904E359DD42821924D72D020929A5150E79C84DA43EB7E6E65FC1BF650DACBEA4F67EA466ADC8AD6796FE62937465D6335472D085C4E54385C5BA37745695798788D9625F6FC9DCF09F530C05DFD5A532E6ACA0D1E49CCEC09FDD6083791F5C13C137241F48CC3150CD05B713978519757489633958494DDE101AAEED5472ED6BC3A6BAF7B78B17740B786640F424BCBBB4F9EA5B33A5DDC649DE00E9A963E922E23EF0B1AD30EA95B0E3699E1B2042E9D3B28F6827F70B477B67FEA03DF7DB211F8DE15B58AF420CC7D2257B4F4A9372FB9C248A14533B59001A64C25FAD3D8A8EE9BE1C1861EAA6DB2571BA0CBD192E63628228E771A194D4CF3E810EDA19D5DAD5EC3D5DFE67E7FA923EED2C9AAA32A1C38E84E1355A4A91B92B2C14C4CE643CA967557125285663368804D2F93834870D7604EBD98C1832D5B4E033BC92A1664EBB38A725E89592E019ADB0DC3CBC5D5A069DDA48196A06DCA291D697F54D938D5702E749A25F4BA9CA8A2C0331BA37D83B2B8A8E2B98525844DB5BE2685078A502B26DA38D1F07FA7F815760EC8A045CDFCEA0CA2685F642E1729A36C95ABD5A0AB8B229D287125CC76FEDCD79F8551BFB128D08CBB1BE8156A2C07FD0E04D8C98422E56BA35B614E629A1210996A4363B06C0EDE9437817620B801487DC154EA698B6553981B34DF28C9F1D316561AFECEC6151C2BFC862DA60B18A4C3B1A410EA8266F4EE7AB1D4132A0CFCBA21A65EEB925421217095A576A3580D3D728ADB7BD354BAA0237549C8E2961AA2D2EB1EB6762F7CF6D97D22A5420F555A246D2DCD8D55AD269507D9F95B0C4DC12EB3ACD615A56A4BE99156CBE9F5AA6613DCAE71BAD83AD6DD9F743D3F2969E7DAAD0CE8D4F5C8E5C6BFADE696A4D4284C11E21045E82EAAB9B48D9006A313B478266F0AAE7D22A006543413C4536A491785837B263BB86DB39E98526B1C3926C31E18383430445329448D3226926BD110E620E74CB64FAAE59E1D79FF1F99BDC3E3FD5D1F4FB8AF4B9EB8D83DF878BE2723522FEE2B78C2D85C15B59CA91557A88C2E1AD7A5D431DD954EAFEDDC3F6862BE027EB54469D0B2F5EE13B9A9E659F35C6FAAF04E9C6956402AEF112D9A1CA1E9A0FA1F3B86AC11641FC2AC413DCAC86351CD2EC80250D44ACDF328CCA356AAD273A25858FF176AD4C2869AA512F5A9D31E7DA3C2CECBF85F02000000FFFFE456DD8E5A37107E95D1B9460458D8252820412055AA6E8A9655935C9A7306B0D6782CDB073879A3BC469FAC639FC35F96A5ABA8ED4D6FC01E8F87E1FBE69BB147ABD1C3679C83931EC1E2022DEA145D0DD6A2807425F412612BFD8A720F9ABC4CB10E5F2987390A0B7EC577A47B025A40EEA45E82F47578F766DBF383F069E3A719BCDBF60CF0D6C9ECA19F341AED4EE3E6F66DB2374DED05E318172257FEF9C934981AA3C6647293BCF9F74287C8F66286E1C4C36EAD7ACE8814FB89B1E8D06E3019CC688D803BB1360A1D646864EA318315A32A35088B602C6D64C6B60559904AE5CE5BE1256920AD0A103A8B6E0BBE28D99CBB3A7C2226462810CE512A2B670B29698DECC557A503A93DEA1097C33A664B654C115B99508BD9FF8494C1E38AA1C828CDD7A83D2F98042EDA3DE85070E1866266980B50B86450AD5CAEBC034FD11650548A51CDF988A932687DC128C6C37B995A72B488F1B23CE5520F4A8842215372973B64559C261178E6DF65B239B6D542D58E3203935B430E5DFDBFD04CA5BA2899294B934539F385627DF73642F59347DCF9A02816AE09E7E13B7AED55F05C8B0F3F2FDD10F98ABE067F7E8756A37986CBC98590CAA8D5EA749A4908E407ED973CCF328CBE97A50B477ADF13B352AAB20E437528924AE6D92BD8BA6BB647E3BB1F3ADC889B5EBB75309E74B873F7EB1DEEDCB762E067425F6060386A7FB8ED54901E00A9C190FBCC06612C2D6B836CB1B77CA9C1487E7B14EAA906935D8A5CDCBF70AFF23055426A9E221F63D1F38C99EC8C228BB606BFCE522B8DAF9D003E2EB458CB94FDEF679F6AF07BEE1511879CCA0DF947315758ADDFAF84E59B7F4817043A124EA687DDCCE799A41A7C963AA32DC7AA16F01BA77EDCCD42A7E63442A7DD7B703C2F62DFE5669CE15AD82717665A986F071460692937C19CD2DA082D7F94ED49799645579172ADE8CEAAF6A2E0FE31BA9FCFCA71B7359C740FF55829E5A63DFAD03C185F55A4172AE9E4BF2BE1FC43184E3C88A6628923AE90A7988D1F047511C3CC6F8923F2D59C2C9B6F4983B4DC359D09F38EEB90B61AED0B4DD3B1CFD49EB6AC57FCCD195F0A2DA533BCED76EE62FDAF902BC13EEC5F441CD01786873D6E5027607B32EB27F663F6B67C83BCE49D95AF98930BCD46796341C4F3E06FE3379BD7DD2FFC40EB7A4A0B699D3F4DA87A46BD94D033FF7619DF2C67DF18956D3F69B65AED46A89815AF3BDD729D52C66855D99BE53D3F171942326C6B971E71F4862D43C26773F29ED6C763850BE6A4D9BD2943473A78DFE8C67D99ED71BFCC3DC3C91C96C9A5A41CC7AC1E6877AD68667D95D51167DB9CB2222EF6EF85C15F000000FFFF0300504B03041400060008000000210008BE40C5A0010000CA04000010000000776F72642F666F6F746572332E786D6CA494D14E83301486EF4D7C07D2FB51D0653164E08544E39D71FA00B594D1ACED69DA02EEED2D6CB029CBA2EE8612E8F9CEFF9FD3D3E5FDA71441C38CE5A0521487110A98A25070B54ED1FBDBE3EC0E05D6115510018AA568CB2CBACFAEAF966D523A13F868659356D31455CEE904634B2B26890D25A7062C942EA420319425A70CB7600A7C13C551FFA60D5066AD4FF54054432CDAE3E494069A299FAB042389B321983596C46C6A3DF3744D1CFFE082BBAD67478B010329AA8D4AF68266A3A02E24D909DA2F438499B8389177179903AD2553AECF880D135E03285B717DB0F15F9AB7580D929A73261A29867DAD8EE7937CA3E5DFF42037A4F5AD380027B813C528764152ECEAD0F5F7D0D59FC4383A6766DF910E316AF88D84EF39072592703562FE579AE3E2FA61B8E47C3F19A8F52847F3CB68CF6A33B2BA99FC83B268D14FDEB135FB27C064745715D10C059226CF6B05867C08AFA88DE741772251E6EF091DB489BF5F8AD71445D16D3ECFEF1ED0F0296725A9853BFAD347BC987E59B9AD607E6B43448A1E011C3308674BEC99DD8E6EED9FFE26CABE000000FFFF0300504B030414000600080000002100656AA870AC010000E004000010000000776F72642F666F6F746572322E786D6CA494DF4EC32014C6EF4D7C8786FB0DAA736A63E7858BC63BE39F07404A57227008D0D6BDBDD0ADDDB4C638BD290DF0FDCE77CE01AEAEDF954C1A6E9D009DA3744A50C2358342E8558E5E9E6F271728719EEA824AD03C476BEED0F5E2F8E8AACD4A6F93A0D62E6B0DCB51E5BDC93076ACE28ABAA912CC8283D24F19280C652918C72DD8029F9094747FC602E3CE8550375437D4A12D4E8D6960B80EB14AB08A7A3705BBC28ADAB7DA4C02DD502F5E85147E1DD864DE632047B5D5D9D6D064301425D9C6D076E8157694C5377137CA25B05A71EDBB88D872193C80769530BB34FE4A0B2956BDA5E6A7241A25FB7DAD4967A37843CABFE9C1D2D236B462071CE1BE2946B11129B9A943ECEFAEAB5F8929F929996D472262F0F01B0B9F63F64E14157AC0FCAD34FBC50D97E13FE7FBCE426D063B46FC8F76AFDF0656BC93073823F3EEE6EDA7E60E028CAEEE53450D478962D9FD4A83A5AF32386AD359124F245A8477C2246D16DE97E23147845C9E9DDECCCF513FB5E425ADA5DF5BE9140FB61B9EFC5AF2B0B5A13247B7009E5B84E38AD04524885515A4A77312677188147571ECBEE17D5A7C000000FFFF0300504B03041400060008000000210008BE40C5A0010000CA04000010000000776F72642F666F6F746572312E786D6CA494D14E83301486EF4D7C07D2FB51D0653164E08544E39D71FA00B594D1ACED69DA02EEED2D6CB029CBA2EE8612E8F9CEFF9FD3D3E5FDA71441C38CE5A0521487110A98A25070B54ED1FBDBE3EC0E05D6115510018AA568CB2CBACFAEAF966D523A13F868659356D31455CEE904634B2B26890D25A7062C942EA420319425A70CB7600A7C13C551FFA60D5066AD4FF54054432CDAE3E494069A299FAB042389B321983596C46C6A3DF3744D1CFFE082BBAD67478B010329AA8D4AF68266A3A02E24D909DA2F438499B8389177179903AD2553AECF880D135E03285B717DB0F15F9AB7580D929A73261A29867DAD8EE7937CA3E5DFF42037A4F5AD380027B813C528764152ECEAD0F5F7D0D59FC4383A6766DF910E316AF88D84EF39072592703562FE579AE3E2FA61B8E47C3F19A8F52847F3CB68CF6A33B2BA99FC83B268D14FDEB135FB27C064745715D10C059226CF6B05867C08AFA88DE741772251E6EF091DB489BF5F8AD71445D16D3ECFEF1ED0F0296725A9853BFAD347BC987E59B9AD607E6B43448A1E011C3308674BEC99DD8E6EED9FFE26CABE000000FFFF0300504B0304140006000800000021007C296D82A1010000CA04000010000000776F72642F686561646572322E786D6CA494CB6EC3201045F795FA0F16FB04BB8DAACA8A9345AC3E76551F1F40308E51804180EDE6EF8B9F49EBAA6A9B8DB16CE6CCBD330CCBF5BB1441C58CE5A01214CD4314304521E36A97A0B7D7BBD92D0AAC232A2302144BD08159B45E5D5E2CEBB8C84CE0A3958D6B4D135438A7638C2D2D9824762E3935602177730A12439E73CA700D26C3576114B66FDA0065D6FA541BA22A62518F93531A68A67CAE1C8C24CECEC1ECB024665FEA99A76BE2F8960BEE0E9E1DDE0C1848506954DC0B9A8D829A90B813D42F438499B8F8266F1799022D2553AECD880D135E03285B707DB4F15F9AB7580C92AA9F4C54520CFB6A1D2D26F946CBBFE9416A48ED5B71044E70DF1423EB82A4E8EAD0F4F7D8D5AFC428FCC94CDF9106316AF88D84CF39072592703562FE579AD3E2FA6138E77CDF1B28F52847F3F3688F6A3FB29A99FC83B2F0A69DBC536BF64F80C9E8BE14443314481A3FEE1418B2155E511D2D82E644A295BF277450C7FE7EC99E131486D7E922BDDDA0E153CA72520A77F2A78D7832EDF2E20E82F9AD1511097A60246306E1D5127B66B3A359DBA7BF89561F000000FFFF0300504B0304140006000800000021007C296D82A1010000CA04000010000000776F72642F686561646572312E786D6CA494CB6EC3201045F795FA0F16FB04BB8DAACA8A9345AC3E76551F1F40308E51804180EDE6EF8B9F49EBAA6A9B8DB16CE6CCBD330CCBF5BB1441C58CE5A01214CD4314304521E36A97A0B7D7BBD92D0AAC232A2302144BD08159B45E5D5E2CEBB8C84CE0A3958D6B4D135438A7638C2D2D9824762E3935602177730A12439E73CA700D26C3576114B66FDA0065D6FA541BA22A62518F93531A68A67CAE1C8C24CECEC1ECB024665FEA99A76BE2F8960BEE0E9E1DDE0C1848506954DC0B9A8D829A90B813D42F438499B8F8266F1799022D2553AECD880D135E03285B707DB4F15F9AB7580C92AA9F4C54520CFB6A1D2D26F946CBBFE9416A48ED5B71044E70DF1423EB82A4E8EAD0F4F7D8D5AFC428FCC94CDF9106316AF88D84CF39072592703562FE579AD3E2FA6138E77CDF1B28F52847F3F3688F6A3FB29A99FC83B2F0A69DBC536BF64F80C9E8BE14443314481A3FEE1418B2155E511D2D82E644A295BF277450C7FE7EC99E131486D7E922BDDDA0E153CA72520A77F2A78D7832EDF2E20E82F9AD1511097A60246306E1D5127B66B3A359DBA7BF89561F000000FFFF0300504B030414000600080000002100A24414F0CE010000BA05000011000000776F72642F656E646E6F7465732E786D6CAC94DB6EE3201086EF57DA77B0B84FC0AB2AE95A717AD17457BDABDADD07A018C7A86606018E376F5F4C6CA7ADA3A887BDF10198EFFF8761585DFDD375B293D629849CA473461209020B05DB9CFCFDF36B764912E73914BC469039D94B47AED6DFBFADDA4C4201E8A54B02025CD61A9193CA7B9351EA4425357773AD844587A59F0BD414CB5209495BB405FDC15216BF8C45219D0B7AD71C76DC911EA7A73434128256895673EFE668B75473FBD49859A01BEED5A3AA95DF07365B0C18CC496321EB0DCD46435D487630D4BF86083BC9E284EE217283A2D1127C54A456D6C10382AB9439A6F1595A48B11A2CEDCE25B1D3F5B0AE35E9C5446F4CF93D35D858DE86521C8113DC89CD280E41BA3EEC4357DF6355DF1253762E99BE221D62F4F01E0BAF3507279A2B18319FDB9A979B1B3AE22BE7FBB7C5C68C768CFA1AED169E4656D7981F70C616B1F35EA6E63E0498B4EE43C58D248916D9ED16D0F2C73A386AD38BA43B91647DBC2C9236F37B13269D34DC728F96842155E46496C67526FC86CBA8B8CF09633737CB65FAB35B118736B2E44DEDA7337771E87AB9592C22C4768AA3025DAF6820C4A789CFFEE63AE54B2078054D6CE487B71ED97FB67852EC8CDD90C670E9AE9F010000FFFF0300504B03041400060008000000210085E487E6CE010000C005000012000000776F72642F666F6F746E6F7465732E786D6CAC94DB6EE3201086EF57EA3B58DC27E0AA4A76AD38BD68DA55EFAAEDEE03508C6354338300C79BB72F26B193D651D4D38D0FC07CFF3F0CC3E2FABFAE938DB44E21E4249D32924810582858E7E4DFDFBBC94F9238CFA1E03582CCC9563A72BDBCF8B168B312D1037AE992C00097B546E4A4F2DE64943A5149CDDD542B61D161E9A70235C5B25442D2166D412F59CAE297B128A47341F086C3863BB2C7E9310D8D84A055A2D5DCBB29DA35D5DC3E376612E8867BF5A46AE5B781CD663D0673D258C8F6862683A12E24DB19DABFFA083BCAE284EE2E7285A2D1127C54A456D6C10382AB9439A4F1595A48B1EA2D6DCE25B1D175BFAE35E9D5486F48F93D355859DE86521C8023DC89CD287641BADEED4357DF4355DF1253762E997D453AC4E0E13D165E6BF64E345730603EB735C79B1B5AE22BE7FBB7C5C60C768CFA1AED1E9E0756D7991F70C666B1F38E53731F028C5AF7B1E24692448BEC7E0D68F9531D1CB5E955D29D48B23CBA2D9236F35B13669D34DC728F96842155E46492C68526FC86EBA8F89313C66E6FE7F3F457B7220EAD64C99BDA8F671EE2D0CD7C359B4588ED240705BA5CD040884F139FFDDD75D29940F00A9AD8CB8F6F5DB26F367952EC9CE19049EFDE2D5F000000FFFF0300504B0304140006000800000021007C296D82A1010000CA04000010000000776F72642F686561646572332E786D6CA494CB6EC3201045F795FA0F16FB04BB8DAACA8A9345AC3E76551F1F40308E51804180EDE6EF8B9F49EBAA6A9B8DB16CE6CCBD330CCBF5BB1441C58CE5A01214CD4314304521E36A97A0B7D7BBD92D0AAC232A2302144BD08159B45E5D5E2CEBB8C84CE0A3958D6B4D135438A7638C2D2D9824762E3935602177730A12439E73CA700D26C3576114B66FDA0065D6FA541BA22A62518F93531A68A67CAE1C8C24CECEC1ECB024665FEA99A76BE2F8960BEE0E9E1DDE0C1848506954DC0B9A8D829A90B813D42F438499B8F8266F1799022D2553AECD880D135E03285B707DB4F15F9AB7580C92AA9F4C54520CFB6A1D2D26F946CBBFE9416A48ED5B71044E70DF1423EB82A4E8EAD0F4F7D8D5AFC428FCC94CDF9106316AF88D84CF39072592703562FE579AD3E2FA6138E77CDF1B28F52847F3F3688F6A3FB29A99FC83B2F0A69DBC536BF64F80C9E8BE14443314481A3FEE1418B2155E511D2D82E644A295BF277450C7FE7EC99E131486D7E922BDDDA0E153CA72520A77F2A78D7832EDF2E20E82F9AD1511097A60246306E1D5127B66B3A359DBA7BF89561F000000FFFF0300504B03041400060008000000210030DD4329A8060000A41B000015000000776F72642F7468656D652F7468656D65312E786D6CEC594F6FDB3614BF0FD87720746F6327761A07758AD8B19B2D4D1BC46E871E698996D850A240D2497D1BDAE38001C3BA618715D86D87615B8116D8A5FB34D93A6C1DD0AFB0475292C5585E9236D88AAD3E2412F9E3FBFF1E1FA9ABD7EEC70C1D1221294FDA5EFD72CD4324F1794093B0EDDD1EF62FAD79482A9C0498F184B4BD2991DEB58DF7DFBB8AD755446282607D22D771DB8B944AD79796A40FC3585EE62949606ECC458C15BC8A702910F808E8C66C69B9565B5D8A314D3C94E018C8DE1A8FA94FD05093F43672E23D06AF89927AC06762A049136785C10607758D9053D965021D62D6F6804FC08F86E4BEF210C352C144DBAB999FB7B4717509AF678B985AB0B6B4AE6F7ED9BA6C4170B06C788A705430ADF71BAD2B5B057D03606A1ED7EBF5BABD7A41CF00B0EF83A6569632CD467FADDEC9699640F6719E76B7D6AC355C7C89FECA9CCCAD4EA7D36C65B258A206641F1B73F8B5DA6A6373D9C11B90C537E7F08DCE66B7BBEAE00DC8E257E7F0FD2BADD5868B37A088D1E4600EAD1DDAEF67D40BC898B3ED4AF81AC0D76A197C86826828A24BB318F3442D8AB518DFE3A20F000D6458D104A9694AC6D88728EEE2782428D60CF03AC1A5193BE4CBB921CD0B495FD054B5BD0F530C1931A3F7EAF9F7AF9E3F45C70F9E1D3FF8E9F8E1C3E3073F5A42CEAA6D9C84E5552FBFFDECCFC71FA33F9E7EF3F2D117D57859C6FFFAC327BFFCFC793510D26726CE8B2F9FFCF6ECC98BAF3EFDFDBB4715F04D814765F890C644A29BE408EDF3181433567125272371BE15C308D3F28ACD249438C19A4B05FD9E8A1CF4CD296699771C393AC4B5E01D01E5A30A787D72CF1178108989A2159C77A2D801EE72CE3A5C545A6147F32A99793849C26AE66252C6ED637C58C5BB8B13C7BFBD490A75330F4B47F16E441C31F7184E140E494214D273FC80900AEDEE52EAD87597FA824B3E56E82E451D4C2B4D32A423279A668BB6690C7E9956E90CFE766CB37B077538ABD27A8B1CBA48C80ACC2A841F12E698F13A9E281C57911CE298950D7E03ABA84AC8C154F8655C4F2AF074481847BD804859B5E696007D4B4EDFC150B12ADDBECBA6B18B148A1E54D1BC81392F23B7F84137C2715A851DD0242A633F900710A218ED715505DFE56E86E877F0034E16BAFB0E258EBB4FAF06B769E888340B103D331115BEBC4EB813BF83291B63624A0D1475A756C734F9BBC2CD28546ECBE1E20A3794CA175F3FAE90FB6D2DD99BB07B55E5CCF68942BD0877B23C77B908E8DB5F9DB7F024D9239010F35BD4BBE2FCAE387BFFF9E2BC289F2FBE24CFAA301468DD8BD846DBB4DDF1C2AE7B4C191BA8292337A469BC25EC3D411F06F53A73E224C5292C8DE0516732307070A1C0660D125C7D44553488700A4D7BDDD3444299910E254AB984C3A219AEA4ADF1D0F82B7BD46CEA4388AD1C12AB5D1ED8E1153D9C9F350A3246AAD01C6873462B9AC05999AD5CC988826EAFC3ACAE853A33B7BA11CD1445875BA1B236B1399483C90BD560B0B0263435085A21B0F22A9CF9356B38EC6046026D77EBA3DC2DC60B17E92219E180643ED27ACFFBA86E9C94C7CA9C225A0F1B0CFAE0788AD54ADC5A9AEC1B703B8B93CAEC1A0BD8E5DE7B132FE5113CF312503B998E2C2927274BD051DB6B35979B1EF271DAF6C6704E86C73805AF4BDD476216C26593AF840DFB5393D964F9CC9BAD5C313709EA70F561ED3EA7B053075221D51696910D0D339585004B34272BFF7213CC7A510A5454A3B349B1B206C1F0AF490176745D4BC663E2ABB2B34B23DA76F6352BA57CA2881844C1111AB189D8C7E07E1DAAA04F40255C77988AA05FE06E4E5BDB4CB9C5394BBAF28D98C1D971CCD20867E556A7689EC9166E0A522183792B8907BA55CA6E943BBF2A26E52F48957218FFCF54D1FB09DC3EAC04DA033E5C0D0B8C74A6B43D2E54C4A10AA511F5FB021A07533B205AE07E17A621A8E082DAFC17E450FFB739676998B48643A4DAA7211214F623150942F6A02C99E83B85583DDBBB2C4996113211551257A656EC1139246CA86BE0AADEDB3D1441A89B6A929501833B197FEE7B9641A3503739E57C732A59B1F7DA1CF8A73B1F9BCCA0945B874D4393DBBF10B1680F66BBAA5D6F96E77B6F59113D316BB31A795600B3D256D0CAD2FE354538E7566B2BD69CC6CBCD5C38F0E2BCC63058344429DC2121FD07F63F2A7C66BF76E80D75C8F7A1B622F878A18941D840545FB28D07D205D20E8EA071B283369834296BDAAC75D256CB37EB0BEE740BBE278CAD253B8BBFCF69ECA23973D939B97891C6CE2CECD8DA8E2D343578F6648AC2D0383FC818C798CF64E52F597C740F1CBD05DF0C264C49134CF09D4A60E8A107260F20F92D47B374E32F000000FFFF0300504B030414000600080000002100ADDE39E2BD0900004A23000011000000776F72642F73657474696E67732E786D6CB45ADB8EDB46127D5F60FF61A0E71D4FDF9B14320E9A64F7C6419C1891FD011C8933C30D2F02498DE27C7D8AA46859F6911124D8A7A1BABAAAEB72AAFA52F3DDF7BFD7D5CD4BD1F565DBDCAFF82BB6BA299A6DBB2B9BA7FBD587F7E1365ADDF443DEECF2AA6D8AFBD5C7A25F7DFFFADFFFFAEEB8EE8B61A069FD0D8968FA75BDBD5F3D0FC37E7D77D76F9F8B3AEF5FB5FBA221E263DBD5F9403FBBA7BB3AEF7E3BEC6FB76DBDCF87F2A1ACCAE1E39D60CCAC4E62DAFBD5A16BD62711B775B9EDDABE7D1C469675FBF8586E8BD39F85A3FB2BEBCE9C59BB3DD445334C2BDE7545453AB44DFF5CEEFB455AFD77A59189CF8B90976F19F15257CBBC2367DF9A7932F7D876BB4F1C7F45BD9161DFB5DBA2EF294075359B5BE765F3490C575F09FAE4EA57E4EABB79EDBB5114B173367D9D35EFABAFF841B4E728FE543E747937879900306A516FD76F9E9AB6CB1F2A02D591ABD56B42D41F6D5BDF1CD7FBA2DB5290088E82ADEE464257D4ED4BF18E60DA3679F5A6991145A1FB8C9AE543E19ADDFBB22EA6517240FBB819689444F6FBA2AA264C6FAB2227058EEBA72EAF098DF7AB7964E2E9878F55F12E6F8A30413694D5507434F725277365606A64CCAB6A33CEEBEF57942DC7F5F6D00F6D7D3144B8220396213ECE9A44F76F9A0F3D193CF13D17F99866CBAC69AC39D40F45F7E5E830BAE962DEAEEC8AED306B3926E12FCDAF8786149A96FA9AF82EEF72B277FF7C7DCACFCBCA5785BC1FB558048C4EEBCEEB9F9886762F7FB8346BD2E8A5ECCB2F4DC847DF36E4A8C9B09FF37A76E814875DF1981FAA8156DC90C825007681C3F699ECD912FB669F6FC9FAB46D86AEAD9679BBF6E77648A9C274940033809E77DDE639DF17D92CB87FFD5DBBEEC781D34AFDCDCBBAF89D2057ECCA812ADEBEDCD5F9EFF72BC1543C4AB83BAEBF16715C3FB6EDD0B443F1AE1B51BAFC223DCADDFDEA96CF6B7F313C419AE42DC3336FD1ECCE824E3FBE907339BA88B9609CCBEAA8CBFCB5994B34096AC8BF04F5CFCBEEDB76578CC83C74E557B97CB5168C0C533650CA4EA1C20B51B6765DB92B26CC4C010E14A34DF9C798A23F52C29454C8A7E2FB0F34F896024533A2F517DA80DE7FDC17A1C88703A1E1FFB4D804B85095FBB765D7B5DD9B6647D9FF4F1723889CC349FBF38E404B95903E7E25D42D6160CC2546C561F6C5483D5318B3924948114AF8133CBFE031CAC79862791CA7509A1536769012312D3DA424CC7BAC5BA26416419E940B85D74979A6AFF0089F24589A16014BCB841198126C16C37538332CB2681DCE99305003A2D804AEC3851612F3482E388C02572675066AA09937CB4E7A81104ED1D1586BAD638629963BCEE13A917609D62D32CE418CF2D8C41EAF13DBEC0A8F9302239E3B19126CA933C14224F2449918FB3A489D6A6869B069722A8097F923049319B447081162A881103660F40A29520D632AA44A71148434DCC2CC128A7183A5291DA7D00742736FA10F442CB48431158EC908E25A38E914D6CD59190BE46B9108AB21AA44C66387B5F62224589A3789803C92718E75234AC6A034C9B449A147294D639D217B2457229D0E1573353FD76B29ADC43195DAB000FD268D920656246999492112A5351C6354469C732C2DD23A607B524379022DCD9875100732535904632A3D4B185EC74BA960DD518CB1146AAD98CD0C5C4771EB63B88E922A09781D492E80F6500C5C0A735B6946F045DE218A341007CACA4840BC11255110BD2AE6218648548EB9084B7392A00D75735A316CA997C2405469AE9C86966A829B87DED1464402E25A8F96420DB453918331D5CE447837D3299D4360B4B517069F84B457293EA1686F227CAED281A5167AD47016C530DA866BE3614C8DD0690CBD63941201EE73466BC7617C0CD510BCFF18A303DEB78DE506EF80C6EA80CF7CC65A1F200E4CAC1387ED49244B1542A249A4CA304F30C97209B9DC83C79D5E41BC59CE930CC6C77295E09A68E990E4A03D44892D8C9C1546A7781D29125C61AD511A9F296C443E80E8B5093301E6027980608A3C6ABD0E380AD6DB28C04A6183F2F444375DF82E7D3D6E18383E448971ED8DB88944C0D26C1A200E22A5383E5F475478F03E171969F0ED23B2D2E08A14A53CD2103B51A66203758B99E4383E311DB902F45B2C6C4ACF49C0A3311D6E71AD8A958AAFF06899E2AA1C1BA37096C4749FC3FB5C1CAB28C2BA252CC1BE8EC96F38B3E2CC067C6F8C03E50FCC2CC76877CC90779C541EE3C049CA61CCA359ACE15EE2B4100EF318E604CC2C671997585A24E300B1E368CFC27740E7B4779827E11EEF80D76FFC2E1DEF05D06F990E1AE6B6A3ACBFE29D20740C71E002BDC541BF5141225C210D12CE5C0A754BB88EF0F92D11426B584769C3C8F07934A1334504AB4B426519DF3513473080484C1216E1535A92F214578A24D32E867B70E235ED67C83B29B322863B3A5DF3AEE02015EACADB464A37090B7D9D2AEB1DF4684A077C8D75A31262AF5034C7199CC68C5E51A0A54E271E5B9A0A2F20AAD2544AFC2A95A674EAC4BA657444915003CF137C4E4C697D5C61533A0DE21B4B1A58C037BD8C9E7114D42DE33295304B32BA7027F02E43EE34F8452693DCE1DA9B497A7380599F51E096E7F4CB1D3DA38CC3AF4599359981D8C922E13CD69ADE5DF04E9BA586E353806732C6670A2F6D86DFC53C3D82E2D3BAB7B439C3DCF656280EF1E6237AF7877EF311290D23E763D20066BD777407837EF3A98EF109C5A72693D0A33EA53B2DCC2C9F09895F347D661DBEA37B2F7C8CBD438EF3D728576ABC0FF4720A111F08F116FA2D0811E10C0E829EAF61A5A08D4962841025C23820D56209EB41904CE0536750368B601482A6A7538FAA4B30E6CA6B51A0E71D7C1A0C91325902A5C52AF3D86F29F7F8552A64269A5F34A987302637750EEAF5D89F1E7B4DF3D7D88EB9A9E7564E9AD70F5D99DFBC1D3BD87422ADD70FDD6F49D92CF48782FAADC5E794CDE16121DEDECE84BEA6BE68A0B6DC42980257AF7765BFA7AEDB24B67A9B774F67B9A7191D1CA5C6DC8F9F648DEDE0A2FB6FD71EF6F36A476A66CE6D966539AED4495ED90C3F95F532DE1F1E360B57435DE8CF488766F7CB4B370ABC3BBBE7B81EE89F17A8014C52F2E669799D2B9ADB0F9BB17D54E4FDE0FA32BF5FFD2FBFFDF1DDC84D8D9AAADB8CFFF350BCCDF77B6A48D2BC87277EBFAACAA7E761EA800EF46B47FFFB30FD787812279A18450EF46BA44D3FF2ED682CCD3E7D8C13E64F9A75FA388FC9654C9EC7A8B33FCF9BBBD5933CBD8CE9F33CB38CD1FF5E507B93DA641DB5C87FA35EE0F2398E3FB655D51E8BDD0FCBE0FDEAABA1D9095317EC4DB3AD0EBB8200B26BB7D4EE1E1BF0FDE4A3A9DDFA77FBAFA76E6D957F6C0FC345AF76ECE48ECDDAFDC5E8CD2E1F284453D1BDBB609E7AB95FE8725CEF8A6D4900DE7CAC1FCE7DE457B35D55D90F9B624F2DE7A1EDC82353FBF33F136CCEFF04F3FA4F000000FFFF0300504B0304140006000800000021009016ECEB4D030000560E000012000000776F72642F666F6E745461626C652E786D6CDC97CD4EDB401485F795FA0E96F7E0B163F227020A21A958C0A284763D71C6F1A89E196BC621640BFBAEBB681FA1EAA295BAE16D22B1E5157AC73F49200EC46D23D412A1843BF665FCE99C7327FB87572C342E895454F09669EF22D320DC1343CA472DF3A2DFDBA99B868A311FE25070D232A744998707AF5FED4F9ABEE0B132E07EAE9ACC6B99411C474DCB525E401856BB22221C167D21198EE14F39B218961FC6D18E275884633AA0218DA7968350D5CCDAC84DBA08DFA71E3916DE98111E27F75B9284D0517015D048E5DD269B749B08398CA4F08852F0CC2C4CFB314CF9BC8DEDAE3462D49342093FDE8587B1D21D59BA15DC6EA3E4130B4D8379CD931117120F426037B15DF32003674C9A1C33289E4FD94084493DC25C2862C3D2250E5B26DA83978D74C31AAAC2FB1EAA99966EE005582A12CF2F74D2B28F190DA779550A8679BA10D1D80BF2FA259654EF275D5274040B633540F00FB31F33ADD8A087871567E59ACAC38A97F4A92FDD0515E833EF0CDBB752E5AC80E8534694714626C6DB64E7FA82C7441CA050451520E1C2AF039FDC6222E8EF10E9C2C69D6EAFB720D2814AADEE56B2CA824823AB1412499EDF4EFB6C4EA423C69212A99914EAC3015D54500338686D38C0A40C0D2686441609C4A75764B8AA8E8445FBA558BC0773EA50528524F672812DDE8B7551E8143C8E457AF93F619477440E31C785201C74040671338BB85A14C5200A0DA22654A95224DA3A21AACBA270A100723C7A6C101B264B12344F18A491186D73839C9E1B6F441C502F6181C3F80C2235CFB9FBDBAFF7B7DF8DD9F58FD9F5CFD9CDCDECFA5BF6688F623665D60033691BD5D732AB1732FB1D1B21679958B5DDA9F58E7BCBC49204B59D6788C1E42C4BAC8F0308D7ED4A878BB82FC7A43F8D4832ADCA992A4FD6E5A9910A6791B5CF4B09215BC3DB5C4A6D188AC55338B7944ED9F4B55D4BBD6CCE9E939120C6C5C95A89A483460F1B0DA3B2D574E94298AC8EDFAE5BCB07F24212DB18BF980D40156B48E803487A10D1079272395BFE68A645F1303574CE22779E230B12CF9BC32E9B1A90B3A7947B81782267EF3E7DBCFBFC655DC2EA635B23D18C4ED875C7B6FF21613B38A4209B35AAE9250735ED1C3DA3CBA9A6FC742E564DBB53A09A242EE16BC09F4CE7EC64AF0E7E010000FFFF0300504B03041400060008000000210011BB6EC2880F00000F6F00000F000000776F72642F7374796C65732E786D6CEC5DEB73DB3612FF7E33F73F70F4F59A5894E4E7D4E9D8727CF18CE3BA91D3FB4C5190C59A22752415C7F9EB6FB10041F0017121D26D2ED3641A9B0F60B1AFDF2E402CFAF32F5FD7A1F38525691047E703F7ED70E0B0C88F1741F4783EF8FC70FDE664E0A499172DBC308ED8F9E085A5835FDEFDF31F3F3F9FA5D94BC852073A88D2B3B57F3E5865D9E6ECE020F5576CEDA56FE30D8BE0E1324ED65E0697C9E3C1DA4B9EB69B377EBCDE7859300FC2207B39180D874703D94D42E9255E2E039F5DC5FE76CDA20CDB1F242C841EE3285D059B34EFED99D2DB739C2C3649ECB33405A6D7A1E86FED0591EAC69DD43A5A077E12A7F1327B0BCC1C88111DF0AEA0B93BC4DFD6E1C059FB67378F519C78F31084F7EC4E06EF40728BD8BF624B6F1B6629BF4CEE137929AFF0C7751C65A9F37CE6A57E109C0F1E823508FB8E3D3B9FE2B507637B3E635E9A5DA481D7F8707511A5CDCDFCB4DEE080930CBDE811BAFDE285E70316BDF93C2B1351B7E6C1027AF69237B38B01343C400EF29F1A271BC59778ABC236280CD4371356044261CBDBD87F628B59060FCE07608978F3F3CD7D12C409584A716FC6D6C18760B160DC66F3F7A255B060FF59B1E873CA16C5FDDFAED10065633FDE46D9F96074748C9A08D3C5FBAF3EDB70D3017291B706CA77BC01280F4C5CA383E3D95688E0CDFFE6145C2E0E906353A72BE671A77270B8AFD0EFE895C63BE6FD5A713879A5911C5A8F0460C572ECC7D62D001F2D699C925BF81E1A26F9FDDB20CD9CBBED7ACE12DE866065667BC5BEA8AA6CE90635D769340F411632224F547DCCB6F3EC35BAF5C22D2018000A71BC66E15D011076EEE4325EBC380FEC6BE65C0709D8C74D04B09975EE76962571F448EC86AA92F7EBCDCA4B0308E024EBA576FBC0C3AFF3EF2458103B36ABE43EF47CB68AC3054B50A8BCC36D5044A853F4EE7A9830F778173BB38DE7436C681E9CD639C68E7ADF5431DC068FABCC99AD3010B5123B32043C3327A27F0E1CED9D1B5869EBDCAC434D4C47180BEB723277FE912D82ED3A178D2946EB24302C76206108D73A0904DF3D4820721BD20CBD7F44E57DFB278C1FA3EF1EFD731D535480B17ADFFE09E3C7C8BE6FFF681FF590A7CBDF1A29AE60F6E490DCEBD8DA77A7711827CB6D98FB40AB071F5B7BB0224163C1DA8955FF249038B6F6E0127C3A17BE0F619462A7D6BA2870D4828AB53A041574363A2FD64AA922AB0547D60AAAD01A59D0EA86B51684AC41F713FB12F0C519EE90DD120D8C0BF75EE23D26DE66D5EAE063834CA8D9C66FDBD894BD6A283832A02095CA4D048B08297368D4C6065FA45293168692B431AF6EA1D0C2BCBAC5440B42DD82A30521837D9873391525E944BA874B0B5AD640ADE21A9A1D19AB8FADB15A11B20B0A3D4552424666F05EB32DD42329818AB582EA919440C55A3B95E8E6E62647A0D55B2425D032440DB38E744CB561CA3A92EA8414781338EA07BC0984FA016F02A17EC09B40A83B78B713E90FBC09B4ACB14161AA0EDE0442F88ACDE45311D2C19B40C81A1B04DAC955A41C84B097DDD3DD1EC09B40C55A4175F02650B1D68E09BC09B4F0151B4BA8D0525047A0D50F781308F503DE0442FD803781503FE04D20D40F7813087507EF7622FD813781963536284CD5C19B40C81A1E14211DBC0984F0151B6C68046FF4FA57076F02156B05D5C19B40C55A3B154055492A8196B5822AB414781368E12B36C62069A171DB30D50F781338EA07BC0984FA016F02A17EC09B40A83B78B713E90FBC09B4ACB14161AA0EDE0442D6F0A008E9E04D20648D0D8DE08DCEF8EAE04DA062ADA03A7813A8586BA702A80AE708B4AC1554A1A5C09B400BEDA533781308E12BFB12B2E1A81FF02670D40F781308F503DE0442DDC1BB9D487FE04DA0658D0D0A5375F02610B286074548076F02216B6C68046FF49157076F02156B05D5C19B40C55A3B154055E04DA065ADA00A2D0575045AFD803781101A6667F02610C257F620845E64A3A67EC09BC0513FE04D20D41DBCDB89F407DE045AD6D8A03055076F02216B78508474F02610B2C606BE55187690EEDE9EAAED6A700D4640DD6790EF6A20131C199444252819FCC4962C81FA1FD6BE3BA423C19C430B8A06F3A0B27819C74FCE8E7DE49AFAC6060321930AE66110E3369B97EABE9DF1F18E2291875FA7CE075128526B8726552EC480CA1BBD8886D79E6051168C337BD94025CB46DFED030536BCE44856C6E08B37502723AB5D78635EFE026DB10048DEC6EFB6922AFE0E95628BFC9DE1F0743876AFAE044750EE8323109B99E19D3983DA2F1885D849EC2D3306E55DE2220C7831D9A8B8F8B4E50552ECABE767B2A6487607C551BCD7A4520EF53B4B165EE47129C94AA7FC0E8C52AB4842365B04A3442145EF6269902E8CA2780765E085819742359614D5CAFDE9967D61A1E33A0FF126F0950AF1E5886FBD976FF26DF8425866915E5C1E4D4EAF4B227D626C73074DB1BFB4265FF704BFAD3508786C14F0F359BCCDB8166EBF84F9E886DD250F4AC741FA7C3BA9EA77C8FF088E9E58C20BADD0C44613712FFD96DF198FE41050EBA0C67DD43732AA0F7B878ABA8AFA46527DA326F5CD41D38B5FD5989589F4A5DBBA1AB08A0C782F3B4049A22743FEB70759897AC4265397BAA9CA6AF293A8228180219D42E8F0B5C55458BD808EF1086D9E5F54A0A3C9B2C7525465911676373AE941968746BB3B6C94918EB03A48E8F781BFA7DC39A4E91D4E575E223A2C27E86891665C6980EA12AEF08B5B10676A401928D3E5682B5146BA73DD7AD16E6AD6ABE03BAF597D801A6100FCB5F7479CBC9775ACBC7B3FCDB4279750692A652746A590A2C08EA9C26171AF1DFC7D1020C419512467888AB28C556D97E5E1A7A65FF992A3DE72F0351C6AB15737D79FAC0E2DA6FBE2BD524529DC32A35EC6CB98B8900C63C632A79DE1DCC157A4F1A884271F20D42E0929ABAAD7E6114276310F4558865FA09E0C3A80526B340F91772CBE7AA22B783E6561F8D14B780CCEE28DF9D5902D799C848EDC214ED62A5DCDE32C8BD7E6F6095637193B00B1EA8311979C09B3BC23ACA49485590699DFC57C9253B30C28EAC2FB42807B4BDA3CB65266E76F5310CD8C575257B33BCC38B8EC758C2FD2900ABCCBE444471DFE6E8138E5ECAF21552970FA2FCBFE00449AB30F90A64D5EB143AAB7DE9C8535A58BBBA8F28A5C430962E55CA250830EFFC55DB3B065523C075A964CA95CF73A86EDF9498D87A5B8DDC4C45230611E556D02C0A33364F93B42F51F3E38342683E8BE9C0230540ED32A76C89310F2441F5AD653FF8AF24FB4D4B308F7EE9124D493395C6EC390656CC15DBE3E79C89F222240C150936CE7A1BC5FC9A3F45CA055F080570295E1971B3549C38E41A8EA2984113C76027EE6C2E7D8CB03CB2686B321F8A441E841BC5953C8ABBBD71D02AF499EF9D35DF28C5E4F9EF91445CAF3CF970E141B47D95520CA82C4824615E0F115277F47AE7A34D9DD662121BFD5B8EAC05E9E76CA2BE1F213912BF28B5A76FE0A2E3F47D64A66D9ECF863A2E39732440599F7DE2313C65783CD0D3C72C022F8C90B8D728EC46DB39825A45B821D99732AE49538DF11012FA104BE2605BCD9C4FE9CC83D67071CAA0596A963BCC9200CFBB551CADB4DE394938D562D05BD8E53A5585537E60F9C22F9AA2415FAA36AC64694B7A5B5953C0C23AB9C06763F39C8B0D05352B572C40FB0B89970966BBA2D9EA07ACB8A9C5C8CC7431967A5BBD538BA962B6FDB3C34F243A160D6455278292957A3CD0FAAFAE86D6AE3CD9F39FC210E79470250993996993B715DF70AD73954FE94AE5412E0870C160D802764180E6FDA6631BF5C06211CF6C455A9969376275F0FDE0A8E9FE24DF303A6D40D3C574A5C7590D6A51786711C61165CF507F94C1CBCD19BB40CC84BE6145629D5B28480597EA75896A0426FC97A7640EF8CCFF36619DBA41749E085AEBBC1091AC789FCBF9A9D611B071B39FF72B09DE3BACE466008624CF14FAB21EA6843184D816065933D9C0E0FC757829AB4BA86DC14A2AA4A4D8F612A216C2B7FB19E96E8AB546E31F58079C8A4B264884E806614E01A06CF82CF079C06376F380C0D5C5FA5C34DCB8A796ABDDB6550DA9AC7886BA45B18CE08D3CAB2E1ECB59ED5CD70505555B7B3321E2D5E599A89308410CF8043E998ADC5E0B2AF2EE9928BA6DC0FF917343EEDBB575FDAAAD2E34F8B15C256DFAAAF1B42213E8AC3BCB4DBE048BBFD4239829557E0287C580885B464EB8533F1210AEED6E640D5BCA2A362D4D184E2E4C1157B73732B71A025556C56185F496F58FBE01F34F2FC7D4718D6CD5AF46402B8E9743C3E95098719E0F8392240163007A7DF9323118A61BDB298A08BD591FC95D3EA141D70A3F65550C7418ABE7325C24FB46C6EC7F80B50154BB1BEBE6EBE036734A1549D413CD230A222E7C66577B4BBBAD4855794414297B801246C968FAEE18FF872D93E2B6936B569BCE6879436A6335E14C5E2A43887BB542B34E822D0FA3559DFC964E29EC8DD06D2FAFAB3123949AB7F986F38A734CF142B27980AE0687160AACD55E551353CF95C1C8457486C2FF3D36835D96021F77E5C09B210F1CDAFCA13772678E81CF6E14F9C4A1337FA67C3768F6AFBBC5759B00568F9333EF835BB260FCC626DB6BE630083B678E8C8CCAC622AE695595D62D2EFE45A212EC2162BB318D7C146D4D35DB1D56C4B1026E4D9987942F2C0EFF03D71B579003E11272122AA5698C2C766CEC65793AB93A9B012FD13E0259C7B0C474873FB149FF870455FCE9C41C7E9B7F38128888128055F04301CE9335181F0E203E05E6DD5C7C1BD5AE79F0EF76A1CC039CB0BF601D8ECD0FCF7FD9A8351801E94F8C5E5EE8F9A066B99C6E1761DA5754F1016231F1B7CC1C26C8C8148EC546AD8C364B1496C2E6C7ACAB730802C245CE9968A531960E6124E349F05DFD46EB77C26577BF73E01CD88F467C98F4FFD143FA353C9BED18873DDF16C41AC1F5588E3B0325F7E32F795BEA0E77034E714D0742238619DA781DC5DD04578B836BA4B968CE66AEB964D536E25FA18B465A2340EC519A9C8975A1882318985A21287822161732857C9DF3C9457D04C482E840D1E15C1CD73A6E50AE2BC582FC9A7F8BAFABE6709A23CA5D381FDEC16051A1118A06E446DB2A87CD32C165EFF8FCCCC4A48DC5E2C65F4A38A620E40E5C294456C3169429D7C156B97043417DFF89938054F7371F1B5AE938BF3718E7A1EE708CB5DD438712AD6158A22C6F72395BCCF1C347E18D4499F7F70AEC1F8539EFDF214147F51B16777BE333664C8803E3C1D72E40795FDD3E4EF39DF81F0AC258F7085DBF31AB2585152534F468AEF46B04267CCDE29AD77E5EF94F63B32784A7391C31B92F0F60E7870D324292E8DD9D0DF79E4E07BCC23BB18FF5F9FC6739BC3098630BEFE9350E8F7874CC8FFCE3555A8EC3DD74C2BD3C9E990FFE553DCEF2ED774F5352939C3EA3ACE1F3ED7044C30645DA5657B7C877F2895FFCF98EA3AB6BC2DF2F0F21669F3F720F3D7D0E9F8787C2C57292564352D0C1583CF7F4BDFFD0F0000FFFF0300504B0304140006000800000021006AA5738710100000007200001A000000776F72642F7374796C657357697468456666656374732E786D6CEC5D5B73DBB6127E3F33E73F70F47A9A58375FE2A9DBB1E5BAF18CEBBA91D3F34C5190C59A227948CA4AF2EBBBBB0041F0021110E93627D3645A9B1760B1B76F172016F9FEC74F9BC0796149EA47E1C560F476387058E8454B3F7CBA187C7CBC79733670D2CC0D976E1085EC62F099A5831F7FF8F7BFBEDF9DA7D9E780A50E7410A6E7BBD8BB18ACB32C3E3F3A4ABD35DBB8E9DB8DEF25511AADB2B75EB4398A562BDF6347BB28591E8D87A321FD162791C7D214A8CDDCF0C54D07A2BB4DBDB7286621D05A45C9C6CDD2B751F274B47193E76DFC067A8FDDCC5FF8819F7D86BE87277937D1C5609B84E762406FE480B0C9391F90F891B7486A5C34D0E52DAF236FBB616146148F1216C018A2305DFB71C1C6A1BD018BEB7C482FFB9878D904F97BBB7834ADD1932C9BE8E03A7177A08AA2C35A770DC258F2469B80CB01F55B68B5DAE368B88F19A111EC428EC16408659AF94836AE1FCA6E0E138D2A5CF0872EF6FD73126D63399CD8EFD6DB6DF82CFB42B7B418D9F0843C4F652DB5EAA0E6BAF3B51BB381B3F1CE6F9FC2287117018C68379A3A6891831F002A969177CD56EE36C852BC4C1E127129AEE8C74D1466A9B33B7753CF07F13CFA1B40977BB6733E441B1734B93B676E9A5DA6BEDBF8707D19A6CDCD3CE0AFDADB11920CDCF009BA7D71838B010BDF7C9C9789C85B0B7F093DBBC99BF9E5001A1E1107F94F859358F2C5DFAAB00D00017031E7B0094261ABBBC87B66CB79060F2E0600BD74F3E3ED43E247096059716FCE36FE7B7FB96408D2F97BE1DA5FB2FFAE59F83165CBE2FE6F370491A2B1176DC3EC62303E39254D04E9F2A74F1E8B11AA805CE86E80F23D36001C014C57E8D078B6152274F37F3985118A03E4D8D4E99AB918451C1AEE2BF43B7EA5F14EB05F2B0EA7AF349263EB9140E0B31CFBA9750B48082C69BC336EE1B96498C6EFDFF969E6DC6F370B96601B032BD3DB2BF565AACA966E48739D46F3E8670160AA114FA6FA986F17D96B74EB065B40300014C3F1EA85770D40D8B993AB68F9D979649F32E7C64FC03E6E4380CDAC73B7F32C893037EA55253F6DE2B59BFA9030F6DAED23C660E7E7C4873CCAA863BD4A1E02D763EB2858B284848A1D6EFD2242BD23EFAE87097D8FF791338F5D8F12CDA6C1299D53ECA8F70D433002E83BFF699D39909E60206A968442EC4413F0F49CF0FE1138DA3BD7B0D2D6B95E87EAC82916D6E5A4EFFC17B6F4B79B5C34BA18AD92A0B0D88184265CAB24087C0F2041C8AD4933D4FE09950FEDDF60FC147D0FE81F756CA2028AD587F66F307E8AEC87F64FF6510F79AAFCAD91E21AE6F78E917B9D5AFBEE2C0AA264B50D721F68F5E0536B0F9624CC58B07662D9BF11489C5A7B70093E9D4BCF83306A62A7D6BA2870D4828AB53A38157236735EAC955245560B8EAC1554A135B6A0D50D6B2D085983EE07F6E2E36A64F74483E2C2839BB84F891BC3725A4BB231D1C8C434DBF86D1BE9B2570505C71A1434A5721BC22242CA1C336A138D2F9A5213164692B431AF6EA1D0C2BCBAC5440B42DD82A305218D7DE873391925CD89740F9716B4AC815AC635323B63AC3EB5C66A49C82E28F414490D32328DF7EA6DA11E490DA8582BA81E490DA8586BA712DD46B9C919D0EA2D921AD0D2440DBD8E544CB561CA3A92AA8424781B70D40F781B10EA07BC0D08F503DE0684BA83773B91FEC0DB80963536484C55C1DB8010BD6233F9948454F03620648D0D1CEDC42A520E42D4CBFEE96E0FE06D40C55A4175F036A062AD1D1D781BD0A2576C2CA1424B429D01AD7EC0DB80503FE06D40A81FF03620D40F781B10EA07BC0D087507EF7622FD81B7012D6B6C9098AA82B701216B78908454F0362044AFD86043237893D7BF3A781B50B156501DBC0DA8586BA702A8324935A065ADA00A2D09DE06B4E8151B6310B4C8B86D98EA07BC0D38EA07BC0D08F503DE0684FA016F0342DDC1BB9D487FE06D40CB1A1B24A6AAE06D40C81A1E242115BC0D0859634323789333BE3A781B50B156501DBC0DA8586BA702A812E70C68592BA8424B82B7012DB297CEE06D40885E3994900D47FD80B70147FD80B701A17EC0DB805077F06E27D21F781BD0B2C60689A92A781B10B286074948056F0342D6D8D008DEE423AF0EDE0654AC1554076F032AD6DAA900AA046F035AD60AAAD092506740AB1FF036204486D919BC0D08D12B0710222FB251533FE06DC0513FE06D40A83B78B713E90FBC0D68596383C45415BC0D0859C38324A482B701216B6CC0ADC2B08374FFF6546557C3486304A6FB0CF25D0DC604C71A259912140C7E602B9640C11B6BDF1DD29160CEA105458D7998B2781545CFCE9E7DE48AFA261A033126E52F023FA26D369FABFB7626A77B8A441E7F9D39EF79A148AD1D9954799F2F54DEA84534587B42558830CEEC730C952CB1BADB070A6CB0E44854C6D08BB7502723AA5DB03196BF405B2A0012B7E9BBADA04ABF4369E4327F67387C379C8CAEAF394750EE4323E09B99E19D0583EA441805DF49ECAE3206E584FC22F0B14C6B5C5C7CD8629514FBE47A99A82912DD417114F69A54CAA17E67C9D20D5D9492A874CAEFC028958A2462B34530521442F4232A0D52855114EF900CDCC07753A8C612A25A8FBEBB632F2C7046CE6314FB9E5421BD1CE2D67BF1266EC3E7C2D28BF4F2EA64FAEEA624D267C6E27B684AFDA535F98ECEE8DB5A8380275A01EFCEA36D865AB87B09F2D10DBB4B1E944E83F4703BA9EC77887F3847CF2CC1422B32B1F194DF4BBFE47726633104D23AA8F110F58DB5EAA3DEA1A2AEA2BEB150DFB8497D0BD0F4F257396669227DE9B6AE06AA2203DECB0E5092E8D910FFF6202B5E8FD864EA423755594DBFE3552410308453701DBEB6980AABE7D0311993CDE345053A9A2C7B22445516696177E3B31E6479ACB5BBE34619A908AB82847A1FF87BCE9D4398DEF16CED26BCC372824E16A9C79506A82EE10A5EDC8138530DCA402139A2AD4019E1CE75EB25BBA959AF84EFBC66F5116AE201F037EE1F51F293A863C5EEBD34539E5C41A5A9901D1F95448A023B661287F9BD76F0F74080106778919C262A8A3256B95D16C34F4DBFE22547BEE5D06B34D4A22828D79FA80E2DA6FBFCBD524529DCD2A35E86654C2824CD98A9CC696F3877E815613C32E1C90708B54B5CCAB2EAB57984905D2C021E96E117A827830E76A2BE96E71DCB4F2EEF0A9ECF5810FCE2261883B328D6BF1AB015C649E86834A4C95AA5AB459465D146DF3EA1EA266D0720567530FC1299D0CB3BA44A4A512BA591F97D84939C9A65405117DDE7023C58D2FAB195323B6F9B8268E658495DCDEE28E340D9AB185FA421157817C9898A3AF86E8138E5ECAF21552970FA6FCBFE00449AB30F90A64D5EB147AA77EE820535A5F3BBA4F28A5C030162E55CA250830AFFC55DBDB04552BC005A964CC95CF72682EDF9498D8715BFDDC4C48A33A11F556D0280D119B2FC3DA1FA0F0F1C9A9241725FA4000C95C3B48C1DE224843CD18796F5D4BFA2FC3325F52CC2FDE84410EAC91CAEB641C032B64497AF4F1EF2A784085030D424DB4520EE57F228351768153CE0154765F8E5564ED2A86310AA7C0A61848E9D809FB9F0117B31B0C4119C0D819306AE07FE664D21AFEE5EF704BC3A79E64FF7C9337C3D79E6531421CFBF5E3A506C1C66D73E2F0BE20B1A5580A7579CFC1DB1EAD16477F152407EAB71D581BD3CED1457DCE5A73C57C48B5A76FE0A2EBF20D64A66D9ECF81343C72F658812321FDC27C68DAF069B313C72C022F0E485463987FCB65ECC02D22DC1CE987353C82B71BE27025E41097C4D0A74B389FD8521F7C80E38540B2C9B8EF1368330ECD546296E378D534C365AB5E4F73A4E996255DD181F3845F255492AD447D58CCD50DE96D656F2308AAC621AD8FDE420CD424F49D5D211DFC3E266822CD7745B3C21F5961539BD9C4C8622CE0A77AB71742356DEB67968C4C3D860D665A4F052522E479B1F8CF68B1BD7C69B3F73F0210D794F0250993996993B1B8D46D7B4CE21F3A7742D93002F60B068003C11C37078D3368BF072E50770D813AA522E27ED4FBE1EDD351C3F854DF303A6E40D3A578A5F7590D6951B04511452165CF507F18C1FBCD19BB434C86BCC29AC52CA65090EB378A758963085DE92F5EC81DE39CEF3E6198BD3CBC47783D128A6091AE244FE5FCDCEA88D438D9CFF38D4CE198D9C986308614CF1BF564354D1C660340582954DF678363C9E5C736AC2EA1A725388AA32353D85A904B7ADFCC57A5AA2AE528D8AA907CC43A6952543720232239FD630300BBE18200D346F380C0D5C5FA6C34DCB8A796ABDDF6548DA8AC7F06BA25B18CE98D2CAB2E11CB49ED5CD70485555B7B3321E255E599A09378480CE8023E9E8AD45E3B2AF2EE9928BA6E887F8050DA77D0FF24B5B557AF8B458216CF5ADFABA2114E29338F44BBB0D8EB4DF2FA4235879058DC2838550484BB66E30E71FA2E06E6D0E54CD2B3A2A461E4DC84F1E5CB337B77702075A52C56685E14A7AC3DA077ED0C8F3F73D6158356BDE930EE066B3C9E49D4838F40087E7880059C01C9A7E4F4F782886F5CA6282CE5747F257DE55A7E8801BB5AF822A0E9AE83B5722FC24CB463BA65F802A5F8AF5D475F33D38A308A5EA0CFC9182111539372EBB93DDD5A5CEBDA20C12AAC4352061B37C74037FF897CBF65949B3A9CDA20D1E8ADB98CEB86118F193E21C74A956685045A0F4ABB3BEB3E9747426761B08EBEBCF4AC424ADFE61BE7AB22886D2E6A3483970B438B0A9CD55E551353CF19C1F845748EC20F3536835D96021F77E5C09B210FECDAFCA133A133C748EFBF027A4D2C48DFAD9B0DDA3DA3EEF55166CC138FE8A0F7ECDAE898199AFCDD6770C50D0E60F1D9199554C45BF32AB4A4CF89D582BA445D8626596E23AD8887CBA2FB6EA6D09C284381B334F481EF10EEE89ABCD03E8093F099150B5C2143DD67336B99E5E9FCDB895A89F00AFE0846A38331DED937FE2A3157D3173061DA75F2E06BC2006A2147C11A070A4CE4439C2F30F8007B5951F070F6A9D7F3A3CA8B10FE72C2FD97B60B343F3DF0F6B0E46017A90E2E797FB3F6A6AAC651605DB4D98D63D815B8C78ACF1050BB3D10622BE53A9610F93C526B105B7E9196E61005908B8522D95A632C0CC151CE13FF7BFC8DD6EF94CAEF6EE43029AE1E9CF0A8F4FFD10EDC8A944DF64C4B9EE305BE0EB4715E234ACCC139FCC3DA92FE839182F9002994E08FFA400A681E82EE42218AEB5EE9225E385DCBA65D314AD441D83B24C9446013F2395F8920B433026BE5054E29033C46D8EE42AF85B04E20A9A71C905B0C1A322B845CEB458415C14EB25F9145F55DFD72C4192A7703AB09FFDA220230203548DA84D16956F9AC5C2EBFF9199590909EDC55246DFAA281600542398B2F02D264DA893AF62ED9380E2E2B197F153F01417E75FEB3AB9388E73DCF338C754EE22C74953B1AE501432DC8F54F23E7DD0F8665027DD7DE35C83F1A798FD620A4ABFC8D8B33FDF99683264401F4C871CF141E5F034F96BCE77203C2BC9235CD1F6BC862C9697D4D49391E2BB11ACD069B37793D6FBF27793F67B327893E63C87D724E1ED1D60705324C92FB5D9D03F79E4E06BCC23BB18FFDF9FC6A3CDD104831B5FFF4928F4FB4D26E4FFE49A3254F69E6BA695E9E46C887F718AFBD5E59A23754D4ACCB0BA8EF39BCF35011334595769D99EDEC10FA5E2DF8CA9AE638BDB3C0F2F6F91D67F0FD27F0D9D4D4E27A76295524056D3C25031F8FCB7F4873F05000000FFFF0300504B030414000600080000002100AFDFBC95DB010000CD03000010000801646F6350726F70732F6170702E786D6C20A2040128A00001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000009C53CB6EDB3010BC17E83F08BAC7946C37680C9A4191A0C8A16D0C5849CE2CB5B2885224416E84B85FDFA554CB72DB53759A7D68389AA1F8ED5B67B21E42D4CE6EF37251E41958E56A6D0FDBFCA9FA7CF531CF224A5B4BE32C6CF323C4FC56BC7FC777C17908A821664461E3366F11FD86B1A85AE8645CD0D8D2A471A19348653830D7345AC1BD53AF1D5864CBA2B866F086606BA8AFFC44988F8C9B1EFF97B4762AE98BCFD5D19360C12BE8BC9108E25B926316B5C38EB3A9CB2B87D254BA0351507B2AF84E1E208A356723E02F2ED451DCAC569C8D90DFB5324885E4A0F8B02A6F389B35F827EF8D5612C95CF155ABE0A26B307B1C6CC8120167F3154ED6EC41BD068DC724645EF22FDA2629A46544A42DC84390BE8DA25C268553C9F74A1AB8230744234D04CECE0DFE0032A5BB939A24F31E373D2874218BFA27E5BBCCB3EF3242F26D9BF732686991FC4B6B633160E32306516934C44DB3B11EE07C6D8EF55A94C30281CBC544306AA0C1A5BAE184F8D8D0B7E13FC49673B1838651EA4CCE0C4E67FCC14A76FE884FBE72F7E982FC36ECB2394BF94563BBF7525116D7CB358574CE7B36E27BBA1650538027C273833F90B9C1A453E95D7B80FAB4F3F720DDA0E7F1EF14E57A51D0335C99538F629F7E1BF10B0000FFFF0300504B030414000600080000002100A212B5294B0100006D02000011000801646F6350726F70732F636F72652E786D6C20A2040128A00001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000007C92516B83301485DF07FB0F92774DA27494A016B6D1A71506736CEC2D24B76D98C69064B5FDF78BDA3A0B6590977BCFC9E7B9D7E4AB63534707B04EB5BA40342128022D5AA9F4AE40EFD53A5EA2C879AE25AF5B0D053A8143ABF2FE2E178689D6C2AB6D0D58AFC04581A41D13A6407BEF0DC3D8893D34DC25C1A183B86D6DC37D28ED0E1B2EBEF90E704AC8036EC073C93DC73D303613119D91524C48F363EB012005861A1AD0DE619A50FCE7F5601B77F3C2A0CC9C8DF22713663AC79DB3A518C5C97D746A32765D9774D91023E4A7F873F3F2368C1A2BDDEF4A002A732998B0C07D6BCB1CCF8BB0B89A3BBF093BDE2A908FA7A0DFE885968583EAFF4B4907C75406F630CAF801905108C7C6512ECA47F6F45CAD5199124A6392C6E9B2A24B463246C8571FE7EA7E1F766C34E750FF131731C9C2A9D2942D02744EBC00C699AE1F48F90B0000FFFF0300504B03041400060008000000210053F8F18E1C020000F512000014000000776F72642F77656253657474696E67732E786D6CEC584D6FDB300CBD0FD87F30746F2CF93336EA14088A0E03BAADD8BADD155B498449A221A9F1D25F3FC669BB74DDA10656C0079F4C51E433A9674A16CF2F7E6915EC8475124C45D88C9240981A1A693615F97E7B75362781F3DC345C811115D90B472E16EFDF9D77652756DF84F768E9024431AED47545B6DEB76518BA7A2B3477336885C1C93558CD3D0EED26D4DCFEBC6BCF6AD02DF7722595F4FB30A234230F30F63528B05ECB5A5C427DA785F1BD7F68854244306E2B5BF788D6BD06AD03DBB4166AE11CE6A3D5114F73699E6058F20248CBDA8283B59F6132E131A2F00085EE8CF6925624D075F97163C0F295C215EC584216B87C8DDCB98767D095B2A9484C9338A3099DF7F32B68F6977287733BAE901A121EAC71F1AEC5DA3F6AE993F6ABDC6CFFA1BE85F6A5ED12BC07FD971EE35936F6F00EFFC7C720E9040DDD7D45F0D340A1E53526D1CB352840AEF89D876318EA24B2619EAB67110DF3B5A7990F710D7B12FAA48FE2733A92228AF382B268A263C847F05674A4459A27791AA5131D63A023A34512A7713155C7A02DF2ADAA232BF224CB585C4CD53186EAC833860542B37CA2630C74605D64F33489733AF1310A3E521A27519A26537D8CE2F46029DE3D685EE4D3F1310A3E22C6521647318DA7FD6A0CFB55C4A2AC60453CDD0587DCAFBBF27FFEED1EAFE87DCB045A2FB5BC17576097163A276CDF1BC1F6CFFE8BF9F1E9BA1F71A5A0BBF9FC0107E87AD2AC5AFC060000FFFF0300504B030414000600080000002100E3014EB4320C000091B8000012000000776F72642F6E756D626572696E672E786D6CEC5DDB8EA3461ABE5F69DFA18534177B31DD14675AF144189B55AF26A36867A25CD336DD46E16061DC4EDFE665F208FB587985FDA10083AB2830B6DB64BA7211F7D8545187FFAFFAEAFB0FF5C38FBF87C1CD8B976CFC389A08E856146EBC68112FFDE87922FCF2CDF96808379BD48D966E1047DE4478F536C28F9FFEF98F1F76F7D1367CF41278F006EA8836F7BBF56222ACD2747D7F77B759ACBCD0DDDC86FE228937F1537ABB88C3BBF8E9C95F7877BB3859DE492212F3BFD649BCF0361BA8C776A317772314D585646DF1DA8BE05D4F7112BAE9E6364E9EEF4237F96DBBFE08B5AFDDD47FF4033F7D85BA45ADAC269E08DB24BA2F1AF4B16A5056E41E37A8F8284B24442F28EFC52567F1621B7A519ABFF12EF10268431C6D56FE7ADF8DA1B541175765935E589D780983F2B9DD1A29C4FBAA2EF7998359E2EE602AF61512D5510663890B85011E876C7EF7B37A582312599D296624ABA26A439F2634DF59B62474FDA8AA66D8D0D4071754E214F9FE77126FD75573D6FE69B53D44BF5575659A7944CB442DD7BC7AD736475540A8EED795BBF6849B7071FFF01CC589FB18408B7648B9C92452F804AB85FBB8491377917ED986378D7F3D2C2782983F126DFC25FCF6E20613C1C9FF3364E12E2B1C6E83D4FFECBD78C1B7D7B5573E93AD1981977F8D1F4BC37550FE6859D3F94CD635FC4BF092FDE0C347F93258D492B47C18E1A7604573C2EACBC76D107829FE65FD357D0DAA177FF637E934FF55AAAAFFE6FD5E95FCEB8FFF55DFFF6751BE24F09ECADA7E4EB25EA53026C567F90CB44080BFD731CC872E89592D77FB07FD281B9FAC1EFC2BFC63E546CF300C1341D6CAA7D7B8F6A4F870E228DDC093EE66E183C87D7D0D1F635830A0A80503DEF8C28FA0E2A5F7E4C27017AFCE6B8126C0C8E54DA94D63E7AC2262564555B415D1B2F0E8D06775F5FA98F8CB9FB2190FB219C7CFD6A7D69491614A4ADEDFBC65D099726AE1CF741DC0D621D9D6DC985952DE86EEC95E7A0B3F748B974167EBD3F901FD0B3702BE674CE749B3B33A1CFBDDFD239EFCC60C34BB8BB269C4DD1515D1144564E6DFC08E041BD10BA8209E82EEEE07F1CE4B3E7B69EA2555571B4320DD56DFF71C02A4C00C6562D622A1A55035BB24115D9A9ED2A5FFC6A11B552D6FF448A6F528F19F574D25ADCFAA8440C9EA5D424643E9E85D920FBB243A03BBC4145285D61F62CD6974C780E6D7BB73B086D0BBA31C76E77242A71EDD25E8C1802EA944972E25741AAD476CA15364D807EAB3D44BE800FF369786CB089D4EEB0F53E85458A91ADDE92574FA61772E2774C6F15DD20F96855E5D8283557386D0A584CEA4F5882D749A72B034B4081D2C11C72002BC1BD7719E685AA62ACE8BBD7C28229075C5501454E00AD8A661680944204A8A66EA0863CDEE2D91B9D87244F081230200CB1C11C0818A23027C66A59E227364CD80A11C11704450EC55EF1111C804478064CD50E4533902A4A8D24CD5D91C013E348B7D0FC97542E88022E8C9F8D44F5F19BD5387F507A071777F0102A779D626E80311CF463736628C445C9DB6CFC413B40E841D6F13DF4B6EBE78BB7C20319D75F0ED0288B483AF08AA05402C8364211809111F178F275918A3F6D71F7F1E3B6E04F4E82B40BF025F98D977C044519180CDEF0EB928F60091FC0616AC330F502F4AB5AE605207BDD12A58A750A44D0D239011685876EA3BEBD01CAD712028C3969E4345BA90C61174CC48348E6062AEA57124B9330E8DEB42726FA0710451340A8D533B18A2D68179238D2390E748348EA0A1DE4EE38E64B6B091B3CE6C21439DA9C89EE27D7D28B3A520D5504DC7A8D00195D9CA8D3F57C2B1483CA00AFBCED1F9B6D991005963DCDBEA6881AC3AF024D404AD188C34BFFB3E80AC9CD9BAAF7B541C299035D986976B6FABA305B2DAC025BBA95DA76BDC6881AC3270293FDF9E364E20ABA1816BF57B07B2C6C025FC748D3B12C8AA04210B4493A6DB53FB3420EB589661AB56514B9B89F69A40769C84ECF5E9A22E47AE6BEFB2A3C5B587DE627D0F46A7EB7C9385E4046D92FBAEC2A293F9ACD6D79E91E25A4ED04E840126114ED04E84939CEF5A97F2EF1DD7728216FC780668DCDF87A0D5485C3B3525C9B68B108EA104AD8E4C43130D8E6B192674929FBD8ECBC560247BBEE58F00AB17F3FAE5F10D5D0E007032EE03092FE76ACEE31BC08596006D2DAEE64DE04E3287CE40CF0AA69F378F6F8019EA0247743D226CCA175BE9C613DFA0132043962C154DC1098111C7DA23E2D134A4E9DCD9479BD2ACC0B66A4896329DE76DE8F6E163CA3D8F6FE0F10D599431E164D86B712609A78B2CCE3CE21166084845A67198BE381396C98B2DCE3CBEA1CB2B8E3E4384FDEF723094473C821E114C46CB4A07B3754CC4A34122021589108578A25F98AA21C5B265A58F5F98731644400B2265928D1DF634BAD873AAA082769C2A6084D531D12B07061C18EC43C0395590E581C9CF9FCD04479D495F3830B81C30304960309F29A2AC9F688F30B599658B90F7289FF0BAAD3B3F26E06C4196261BAA2EDB6701063C39124F85007AC2A9029E0AA1CA80D7BEDFF05408075900EB21AB9C2A78C7A9108ACC44F5183245D21D556367C1ECB61ECC3469AECAF29C09098A04827D0DF3CCF3D735AC0740271CE3817039368D83010E0670EE31C2B9F47242C73D0940E8B8270120506E3760B0865DC9B8C6E34980F046DC0003AA3CD3C5998AB771BABF223325B6632248123CA5520399637CB7CF403D834D3325F6344F87ED2DB3D4D805F807EEA19E70B7678AA48EA4D8FB188AF2C13A7ECE7E7DEB40D9230D4288CC81A998B68E664E61CBA14F6C37CAB3E1D20309E9237644BDC6EC34BDC648EBD218F2F10CCEA0F046419584216A24D941C0423B4CDDDF4D80D5D0CC0AE7F3772630F028F2F10CCEA8F0461A47B8E78C44E3E4A10917CEAD71A44D0F2FED674DACD613B1D401883234B3C2F9348E38008C42E3D4A11915DE48E3086FE59168DCE0840BA76BDCB1C0964CE5AA221388C7B9C93AB17403DBF91C19D65463BB3A4D4D753E9B3A38CAABFB20333AFA925FF75210D0D381611C5D477B1E0EC5C3A10AE31281AEB8F3F3FED633E6CAC8C3A18066E6E150C53D7EDD17C09159315515CD44C739F1BE1705214B142D76564C5D74E6B261BDBB78A87E546EA7F31FB763723B26B76376DE12DA853B79FC13776A7ACF4E4D643E41D556557DAE179BF750739734B5244591A9F7FB6639F3F24B60F9052F0723310A7357C7C5B0AD49A8DE880A1CABB98B70B0DEDBC2D9573E9F4E0536ADA86478F738C8F72E82A355B0CE47BE8FD4DCD51123DE3A306FA47104213312F29D7028BB96C68DD5DCD505ED5A05EB7C1A37527317BFF0E53BCF2788C88482AA63CEE0D6C113B92D70041341AF2CEEAD1F2C26426115324FB10A7DF6D2D44BAAF1AC3B25F22C3F3CCB4F713A27A01BF7D6DF5B8538CB05AEF5CC6C275D50889EEE84402F97133A1ECC0F7CFE85B2FC2032F19F369764A499053F3594E5525455D46489EAB25FB15C703D9CE5D8336C6CE3BE2F498F28640E0984C47F5EA5181415F451DD9191209B5AD2617531433CF1DF8B9B6D1DF1CE4B5842C703F878001FB6B67248F07D04F09199FF74349DEA0A3BCE8B19C06798686ECDE836AF7E5E1F0DEFAE6604DF976DF8E825AC08BE0FA8570EC032300F3E01A2E4CB1FE49DCA0EF0EB7893272CCD761DC0C3E583F57DA72346AC44D1C7FA2693D9967459D165C728621587E233C3D4146DAAB1F1194FADD04F383B3749EE92C45D92B84B1277496A06967FE05EC9B02C70AFE4BE5EC970836DB61FD5532BE88E82245D72F07178281898AB922519769F3C4BE2DF3A27F3E5484ABEC3F31D9EEFF07C87E73BFCCF49B649D58FC67C87EFBDC393C99374C798CA269B7BE9118A6C2363EE68BD76F8BE9914EB399586A54CAA0B49077FF2060E593CC7CE2EE3BA567E045BF9D27B72B7416E6601CA8A91A072AC4EC73CC74E87DD5FE23976609FA25810798E1DB0FB0DB85299E7D8E9D0389E63274386148DE339768669DCA872EC80A90CD003FCFF61995DDB924D75EDBEB1876569528304A1D88A068FE67456BD1CCE31492F97C7DD0118A195C3297CA8E524D6FBB0EB11B55CEE0DDDF23A1C1B482D96E70C6A29863DAFA9C580996A1F15ECA4452FC76A26B6E4D2CBE98CF761A323B51CAB5891079E5A0EE517C9B68C4B9133965E3077446B2BC892973CEF525B4186C030CB310426B7A5B6BD8F21312CF92C9CF5A923037470BBC8148E7DD48228CFC4DBD65286D030CB318486A5B905A94D6D284B6640ADDB9718D654804F626B4152D61E963FB90B2BB503CF8DB6EB6A0DAB8D04F81EF8D1F3A7FF030000FFFF0300504B01022D00140006000800000021004A980B5CD10100001B0A00001300000000000000000000000000000000005B436F6E74656E745F54797065735D2E786D6C504B01022D00140006000800000021001E911AB7F30000004E0200000B000000000000000000000000000A0400005F72656C732F2E72656C73504B01022D00140006000800000021001E637703C50100000D0900001C000000000000000000000000002E070000776F72642F5F72656C732F646F63756D656E742E786D6C2E72656C73504B01022D0014000600080000002100C17F0ECF30170000B47900001100000000000000000000000000350A0000776F72642F646F63756D656E742E786D6C504B01022D001400060008000000210008BE40C5A0010000CA040000100000000000000000000000000094210000776F72642F666F6F746572332E786D6C504B01022D0014000600080000002100656AA870AC010000E0040000100000000000000000000000000062230000776F72642F666F6F746572322E786D6C504B01022D001400060008000000210008BE40C5A0010000CA04000010000000000000000000000000003C250000776F72642F666F6F746572312E786D6C504B01022D00140006000800000021007C296D82A1010000CA04000010000000000000000000000000000A270000776F72642F686561646572322E786D6C504B01022D00140006000800000021007C296D82A1010000CA0400001000000000000000000000000000D9280000776F72642F686561646572312E786D6C504B01022D0014000600080000002100A24414F0CE010000BA0500001100000000000000000000000000A82A0000776F72642F656E646E6F7465732E786D6C504B01022D001400060008000000210085E487E6CE010000C00500001200000000000000000000000000A52C0000776F72642F666F6F746E6F7465732E786D6C504B01022D00140006000800000021007C296D82A1010000CA0400001000000000000000000000000000A32E0000776F72642F686561646572332E786D6C504B01022D001400060008000000210030DD4329A8060000A41B0000150000000000000000000000000072300000776F72642F7468656D652F7468656D65312E786D6C504B01022D0014000600080000002100ADDE39E2BD0900004A23000011000000000000000000000000004D370000776F72642F73657474696E67732E786D6C504B01022D00140006000800000021009016ECEB4D030000560E0000120000000000000000000000000039410000776F72642F666F6E745461626C652E786D6C504B01022D001400060008000000210011BB6EC2880F00000F6F00000F00000000000000000000000000B6440000776F72642F7374796C65732E786D6C504B01022D00140006000800000021006AA5738710100000007200001A000000000000000000000000006B540000776F72642F7374796C657357697468456666656374732E786D6C504B01022D0014000600080000002100AFDFBC95DB010000CD0300001000000000000000000000000000B3640000646F6350726F70732F6170702E786D6C504B01022D0014000600080000002100A212B5294B0100006D0200001100000000000000000000000000C4670000646F6350726F70732F636F72652E786D6C504B01022D001400060008000000210053F8F18E1C020000F51200001400000000000000000000000000466A0000776F72642F77656253657474696E67732E786D6C504B01022D0014000600080000002100E3014EB4320C000091B800001200000000000000000000000000946C0000776F72642F6E756D626572696E672E786D6C504B050600000000150015003C050000F67800000000, N'2')
GO
INSERT [dbo].[GCAA_ESS_Leave_Attachments_VehicleMaintenance] ([DOC_ID], [FILENAME], [DOCUMENT], [REQUESTID]) VALUES (CAST(2 AS Numeric(18, 0)), N'Microsoft_Meeting.docx', 0x504B030414000600080000002100DFA4D26C5A01000020050000130008025B436F6E74656E745F54797065735D2E786D6C20A2040228A000020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000B494CB6EC2301045F795FA0F91B75562E8A2AA2A028B3E962D52E907187B0256FD92C7BCFEBE1302515501910A6C222533F7DE3356C683D1DA9A6C0911B57725EB173D9681935E69372BD9D7E42D7F641926E19430DE41C936806C34BCBD194C36013023B5C392CD530A4F9CA39C831558F8008E2A958F56247A8D331E84FC1633E0F7BDDE0397DE2570294FB5071B0E5EA0120B93B2D7357D6E48221864D973D35867954C8460B41489EA7CE9D49F947C97509072DB83731DF08E1A183F9850578E07EC741F7434512BC8C622A67761A98BAF7C545C79B9B0A42C4EDB1CE0F455A525B4FADA2D442F0191CEDC9AA2AD58A1DD9EFF2807A68D01BC3C45E3DB1D0F2991E01A003BE74E84154C3FAF46F1CBBC13A4A2DC89981AB83C466BDD09916803A179F6CFE6D8DA9C8AA4CE71F40169A3E33FC6DEAF6CADCE69E00031E9D37F5D9B48D667CF07F56DA0401DC8E6DBFB6DF8030000FFFF0300504B0304140006000800000021001E911AB7EF0000004E0200000B0008025F72656C732F2E72656C7320A2040228A000020000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000AC92C16AC3300C40EF83FD83D1BD51DAC118A34E2F63D0DB18D907085B494C13DBD86AD7FEFD3CD8D8025DE96147CBD2D393D07A739C4675E0945DF01A96550D8ABD09D6F95EC35BFBBC78009585BCA53178D670E20C9BE6F666FDCA234929CA838B59158ACF1A0691F88898CDC013E52A44F6E5A70B692229CFD46324B3A39E7155D7F7987E33A09931D5D66A485B7B07AA3D45BE861DBACE197E0A663FB197332D908FC2DEB25DC454EA93B8328D6A29F52C1A6C302F259C9162AC0A1AF0BCD1EA7AA3BFA7C589852C09A109892FFB7C665C125AFEE78AE6193F36EF2159B45FE16F1B9C5D41F3010000FFFF0300504B030414000600080000002100D664B351F4000000310300001C000801776F72642F5F72656C732F646F63756D656E742E786D6C2E72656C7320A2040128A0000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000AC92CB6AC3301045F785FE83987D2D3B7D5042E46C4A21DBD6FD00451E3FA82C09CDF4E1BFAF4849EBD060BAF072AE9873CF8036DBCFC18A778CD47BA7A0C87210E88CAF7BD72A78A91EAFEE41106B576BEB1D2A1891605B5E5E6C9ED06A4E4BD4F58144A23852D03187B594643A1C34653EA04B2F8D8F83E634C656066D5E758B7295E777324E19509E30C5AE561077F535886A0CF81FB66F9ADEE083376F033A3E53213F70FF8CCCE9384A581D5B640593304B4490E745564B8AD01F8B6332A7502CAAC0A3C5A9C0619EABBF5DB29ED32EFEB61FC6EFB09873B859D2A1F18E2BBDB7138F9FE828214F3E7AF9050000FFFF0300504B030414000600080000002100A1A57D75DD0400007112000011000000776F72642F646F63756D656E742E786D6CB458DD72E23614BEEF4CDF41E38B4E7B91F04F1236B01312C86466D34997F6BA23CBC2D6449654498625577D87BE619FA447B20D26216096F406B0A4F39D9FEFFCC85C7FFE9672B4A0DA30298641EBBC19202A888C988887C11FBF4FCF2E03642C1611E652D061B0A226F83CFAF187EBE52092244BA9B0082084192C15190689B56AD0681892D0149BF394112D8D9CDB7322D3869CCF19A18DA5D451A3DD6C35FD2FA525A1C680BE5B2C16D804055CFA164D2A2A60732E758A2D3CEAB89162FD9CA9334057D8B29071665780DDEC97307218645A0C0A88B3B5414E64901B547C9512BA8EDE5CE4AE8880D7D8D094830D529884A98D1BDF8B069B4909B2D8E7C422E5E5B9A56A754FE3E04EE3257C6D00EB981FE54229CF2DDF8FD86AD660C441AC25EA98B0ADB3B424C54C6C147F57682AC16DF58E0368BF0650F169E4DC6B99A90D1A3B0DED413CAFB15C651F8155905C75CD9C66CC2CC10A2A3025838758488D430E16016508A28E5C5A0723E838A18C56EE5BA1E5003A56F47518802D9DDE55F3362897EEE81C67DCBA9D9B4EB7DDBBF492DA7DD8D1935C528DC60FE8ECA7D87E4286F2F999A17A01A6C1EA75C39D719FDA7FAA37BA0AC42374850C31835C240C0AB55C823604DDB45851D0315C1A7FACE65FB1CD34E68863116738A6E8AF8CEAD5960EF8A8A25F4E5B93661E63DFCE074661020C284D5D786830423F4714CA2E72FD5E0A24700AAC2122C502565CD34399A111026750842D46A98C28FFE563FDBA954250629195C8C84C43EA20995910A3C82614411FC082BDF81E7C5871E1F20EC5956094546621672601FF40B52A7935CCD253F4F42F2E2E5AE32D0735C59642004D124AAC23C48457B78FBAF14DF3EEE226A76EA45F9FDCC7686D17DEE7A837ED4C3AD3AA0B5F29249E652945998A9C3372EE13E2B096EE6DB735EEEDD252EC348E17A97288A12438E5E8EE63ACA9408FA9B590128A6A3F9204D94BD855A7D39B36F7D69AAF57A4A9E28C400C5D1EB89CA70A7C8090166D536AF3A17EEC36A670CE10CC717EBF42FBBC9B8CFB9322A9ED28535030C7A464FF69FCB1D4DCCA3464022218B2386F4CAEF91AAB33023D12D6EBE566C1D90E95C5CEDBDC3C2852B172F6842602A2AC3433F506D111E8EFD0BA42B3DFBE2018C5FDD77C427AC9F9443B5AED4A81945194F399C5DAE67E1656BB427AA1DBADF63DE98988AAB2EFD00F491E5297EC347689EEFB1FC4C6CF4B2CDC9E5A7762D85A4FF37A6DECFF2571B74B539887B5CB05E62A48A6900347D4CCC04568C96C525BCF6E9C7CACBDC208A57C76AF589E7CC0631180B970C0FC07E93FEFE51893E73C70E559A07A7D32A7FC5D87178C2E8F690F2E112A5DB67E649584A43A42D3277F91492534BC375AEA9687EB2C4796C7A9A5EED38D7099458375711CAE8B71AFD96DEFBC40173B15058FE5A51EDDBC40FF448F9824D05FD1178AB57037C27FFFFE07094A2383B03F60B2D010CD54BD4BD955B77BD56BED32A5426761CA0D8FA586BC4FB7A7E0AB342810F76555A6B8C4919B112B1873CCDD678D05FB1570B5C8971F67876D3F7893F5C961E002FBB46561E59EABE2D90B6CC11B6FABDDEE7ACE13F8DDBBEC96CD297EC43E7524BC98B7BAF911CDE2C46E1E4369AD4C37CF9CCE2BBB090557F530B868FBC7B994B6F218676ED8AF2B97486E60B508993BE3972349EE357355CE81FB27660958D9E9FBDD46E9A2FF99BFB03536FF158DFE030000FFFF0300504B030414000600080000002100AA5225DF230600008B1A000015000000776F72642F7468656D652F7468656D65312E786D6CEC594D8B1B3718BE17FA1FC4DC1D7FCDF8638937D8633B69B39B84EC26254779469E51AC191949DE5D13022539160AA569E9A181DE7A286D0309F492FE9A6D53DA14F217AAD1786CC99659DA6C602959C35A1FCFFBEAD1FB4A8F349ECB574E12028E10E398A61DA77AA9E200940634C469D471EE1C0E4B2D077001D310129AA28E3347DCB9B2FBE10797E18E88518280B44FF90EEC38B110D39D729907B219F24B748A52D937A62C81425659540E193C967E1352AE552A8D720271EA801426D2EDCDF11807081C662E9DDDC2F980C87FA9E0594340D841E61A19160A1B4EAAD9179F739F30700449C791E384F4F8109D080710C885ECE83815F5E794772F979746446CB1D5EC86EA6F61B73008273565C7A2D1D2D0753DB7D15DFA570022367183E6A031682CFD29000C0239D39C8B8EF57AED5EDF5B6035505EB4F8EE37FBF5AA81D7FCD737F05D2FFB187805CA8BEE067E38F45731D44079D1B3C4A459F35D03AF4079B1B1816F56BA7DB769E0152826389D6CA02B5EA3EE17B35D42C6945CB3C2DB9E3B6CD616F015AAACADAEDC3E15DBD65A02EF53369400955C28700AC47C8AC63090381F123C6218ECE128960B6F0A53CA6573A5561956EAF27FF67155494504EE20A859E74D01DF68CAF8001E303C151DE763E9D5D1206F5EFEF8E6E57370FAE8C5E9A35F4E1F3F3E7DF4B3C5EA1A4C23DDEAF5F75FFCFDF453F0D7F3EF5E3FF9CA8EE73AFEF79F3EFBEDD72FED40A1035F7DFDEC8F17CF5E7DF3F99F3F3CB1C0BB0C8E74F8214E100737D031B84D133931CB0068C4FE9DC5610CB16ED14D230E5398D958D003111BE81B7348A005D7436604EF32291336E0D5D97D83F041CC66025B80D7E3C400EE534A7A9459E7743D1B4B8FC22C8DEC83B3998EBB0DE1916D6C7F2DBF83D954AE776C73E9C7C8A0798BC894C308A54880AC8F4E10B298DDC3D888EB3E0E18E5742CC03D0C7A105B43728847C66A5A195DC389CCCBDC4650E6DB88CDFE5DD0A3C4E6BE8F8E4CA4DC1590D85C226284F12A9C09985819C384E8C83D28621BC983390B8C807321331D2142C120449CDB6C6EB2B941F7BA94177BDAF7C93C31914CE0890DB90729D5917D3AF163984CAD9C711AEBD88FF8442E51086E51612541CD1D92D5651E60BA35DD773132D27DF6DEBE2395D5BE40B29E19B36D0944CDFD3827638894F3F29A9E27383D53DCD764DD7BB7B22E85F4D5B74FEDBA7B2105BDCBB07547ADCBF836DCBA78FB9485F8E26B771FCED25B486E170BF4BD74BF97EEFFBD746FDBCFE72FD82B8D5697F8E2AAAEDC245BEFED634CC8819813B4C795BA7339BD70281B5545192D1F13A6B12C2E8633701183AA0C18159F60111FC4702A87A9AA1122BE701D7130A55C9E0FAAD9EA3BEB20B3649F86796BB55A3C994A032856EDF27C29DAE56924F2D64673F508B674AF6A917A542E0864B6FF8684369849A26E21D12C1ACF20A166762E2CDA1616ADCCFD5616EA6B9115B9FF00CC7ED4F0DC9C915C6F90A030CB536E5F64F7DC33BD2D98E6B46B96E9B533AEE793698384B6DC4C12DA328C6188D69BCF39D7ED554A0D7A59283669345BEF22D79988AC690349CD1A38967BAEEE4937019C769CB1BC19CA623295FE78A69B904469C709C422D0FF4559A68C8B3EE4710E535DF9FC132C1003042772ADEB6920E98A5BB5D6CCE67841C9B52B172F72EA4B4F321A8F5120B6B4ACAAB22F7762ED7D4B7056A13349FA200E8FC188CCD86D2803E535AB590043CCC5329A2166DAE25E45714DAE165BD1F8C56CB5452199C67071A2E8629EC3557949479B8762BA3E2BB3BE98CC28CA92F4D6A7EED9465987269A5B0E90ECD4B4EBC7BB3BE435562BDD3758E5D2BDAE75ED42EBB69D126F7F2068D4568319D432C6166AAB5693DA395E08B4E1964B73DB1971DEA7C1FAAACD0E88E25EA96A1BAF26E8E8BE5CF97D795D9D11C1155574229F11FCE247E55C09546BA12E2702CC18EE380F2A5ED7F56B9E5FAAB4BC41C9ADBB9552CBEBD64B5DCFAB57075EB5D2EFD51ECAA08838A97AF9D843F93C43E68B372FAA7DE3ED4B525CB32F05342953750F2E2B63F5F6A55ADBFEF605601999078DDAB05D6FF71AA576BD3B2CB9FD5EABD4F61BBD52BFE137FBC3BEEFB5DAC3870E385260B75BF7DDC6A0556A547DBFE4362A19FD56BBD4746BB5AEDBECB6066EF7E122D672E6C577115EC56BF71F000000FFFF0300504B03041400060008000000210034099E72EE030000970A000011000000776F72642F73657474696E67732E786D6CB4566D8FE23610FE5EA9FF01E57359921060898E3D11D8F4F6B4F4AACBDE0F701207ACF54B643BB05CD5FFDEB1136F608F9E684FF709679E79F3F89919DEBD7F6174B0C75211C1175E70E37B03CC0B5112BE5D785F9ED2E1AD37501AF11251C1F1C23B62E5BDBFFBF59777875861AD414D0DC00557312B16DE4EEB3A1E8D54B1C30CA91B51630E602524431A3EE576C4907C6EEA6121588D34C90925FA380A7D7FEA756EC4C26B248F3B1743460A2994A8B4318945559102773FCE425E13B735598BA261986B1B712431851C04573B522BE78DFD5F6F00EE9C93FDF72EB167D4E91D02FF8AEB1E842C5F2DAE49CF18D4521458297820465D8284F781A36F1CBDC6BE81D8DD15AD2B300F7C7B3ACD7CF2DF1C846F1C287ACD4D5AE891E412C99627DD3558113F6CB99028A7C04AB8CE0032F2EE80965F856083435C6359C0DB00A77DDF1B19002A22AA4C238D015635A6D492BCA01881C343BC9588013D9DC4DA94B8420DD54F28CFB4A841698F20EF59D8B92C7648A2426399D5A8006F2BC1B514D4E995E20FA1574075092FD15958E2F7A7AC6D22B0E088C14DCE1A63234A6C326B24B9BED8C6C046877A9C847C1B4840D34B52E22753C14C1F294E21F98C7CC54B5E7E6C9426E0D1B6C70F64F0BD043037913FC19B3F1D6B9C62A41B28D34F0A665F22A5A4DE1029857CE02570E3A705235585250420C0B50DD0874871B075FE805109B3F607E38E4E690493BB54EEF05908ED547D7F398EC2C96D9BA9417B245A4541D2D1E31C99A4E3FB717A09998E27737F751199CD66417209B94D837B3FBA84CCC7E349DA75D11B248AE693AEBEE7C8BFDF2799F8517831B764E9AF67CB4BC87D32BD6FB31EBD5691C5668AFF29DDC9B4C480B5162BC47249D06063E6FCC868E4F23921DCE13986C1854F91ACC91D381CB6806288D2146686036C09585C1255AF7165CF7483E4B6F7DB69C88B52984F1F5F7D997987E5EF5234758B1E24AA5BAA3B95208A3A4BC2F523614EAE9A3C73561C46ED09D4F0F2D35EDA3AF5E539C41A286B47C623B2D4B7BA980FBF645D6B5099195AE30DAAEBB63BF26DB0F028D9EE746008ADE1AB84BF03F623DF861D165A2C6C31FB810A7333D0EE0EBD2C74B213BDB1938D7B59E464512F9B38D9A4974D9D6C6A643B984B1296C43334AA3B1A79252815075C7EE8F16F446D11D40ED578DDEE10A0976805DD5251837D8C5F6043E19268F897559392A117B3B0C2A931EFB4293A8A469FE91ACC28D7E71E4AA4911B1167C696E26F7231BBAD2040C7ECC8F27E65DDB48953A260ACD5B0DDB4900EFBCD62C1C4AE3DFD042C7E8687FD8CAB04295C7658298A87D22CE3D6E6AFFBD53C4DA7F3E57099AC9361344FE014F8B7C3601D84C96A1DCD96F3F0EFAE0BDD3FCABB7F000000FFFF0300504B030414000600080000002100198FCB3FC4010000ED04000012000000776F72642F666F6E745461626C652E786D6CBC92DB8ADB301086EF0B7D07A1FB8D6527D9835967D9A61B28945E94ED03288A6C8BEA60344ADCBC7D47B2E3B684A50985CA20E47F663E8D7EE6F1E987D1E4203D28672B9ACF1825D20AB753B6A9E8B7D7CDCD3D2510B8DD71EDACACE851027D5ABD7FF7D897B5B30108D65B288DA8681B4257661988561A0E33D7498BC1DA79C303FEFA2633DC7FDF7737C2998E07B5555A85635630764B478CBF84E2EA5A09F9D189BD9136A4FACC4B8D4467A1551D9C68FD25B4DEF95DE79D9000F866A3079EE1CA4E987C7106324A7807AE0E337CCCD851426179CED2C9E85F80E57580620218517E6AACF37CABD17CEC84208CAE46F7495F5A6E30B0E65A6DBD4A818E5B0732C7D881EB8AB2826DD812F7F82DD83CEE348B89A2E51E64840C896C906B6E943E9E54E815C010E85410ED493F70AF625343085483813D6C59455F18AE62B3A18392577481C2F37A528A78575AF9A8CC2785454524CE90F190AA44E24C397867363870E6C4AB3212C817D993AFCE70FB862305BB452796E84774667E95233E71AF75A478F9DD91352A77F78BF999230F7F7764E05CEEC8381BE4B36ADAF0E684C4B9F85F13F21C5B4643FE9C9082DD7D38F323BDFE1F27643CC0EA27000000FFFF0300504B0304140006000800000021005B6DFD9309010000F101000014000000776F72642F77656253657474696E67732E786D6C94D1C14A03311006E0BBE03B2CB9B7D9161559BA2D8854BC88A03E409ACEB6C14C26CCA4AEF5E91D6BAD482FF59649321F33FC93D93BC6EA0D5802A5D68C86B5A920795A86B46ACDCBF37C706D2A292E2D5DA404ADD98298D9F4FC6CD2373D2C9EA014FD29952A491AF4AD5997921B6BC5AF019D0C2943D2C78E185DD19257161DBF6EF2C0136657C222C450B6765CD75766CFF0290A755DF0704B7E8390CAAEDF32441529C93A64F9D1FA53B49E7899993C88E83E18BF3D74211D98D1C51184C133097565A8CBEC27DA51DA3EAA77278CBFC0E5FF80F10140DFDCAF12B15B448D4027A9143353CD807209183E604E7CC3D40BB0FDBA763152FFF870A785FD13D4F4130000FFFF0300504B030414000600080000002100CD5AF0C5DB010000DD03000010000801646F6350726F70732F6170702E786D6C20A2040128A00001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000009C53C16EDB300CBD0FD83F18BA377282B5CD0246C59062E8615B0BC46DCF9A4C27C26C4990D8A0D9D78FB61B4FD9769A4FEF91D4D32329C3CD6BD716078CC97AB716F359290A74C6D7D6EDD6E2B1FA7CB1144522ED6ADD7A876B71C4246ED4FB77F0107DC0481653C1122EADC59E28ACA44C668F9D4E334E3BCE343E769A98C69DF44D630DDE7AF3D2A123B928CB2B89AF84AEC6FA224C8262545C1DE87F456B6F7A7FE9A93A06D6535061175A4DA8BEF527DB59EDA9033945A1F2A4DBCA76A896D71C9F183CE81D263507390278F6B1665E2E418E10367B1DB5211EA1BA5A2C40661C3E85D05AA38987ABBE5A137DF20D15F783E3A23F0F322F01EE628BE6255A3AAA12644EE18B756CE012E408D859D4BBA8C3FECDDEC4606B748B1BEE5F35BA4D08F27700EE50F7BB7DD0B6F777A0D5010DF95824FB93B7BB10C5779DB09FDA5A1C74B4DA9118CB4632E036248AAAB2D4B2F6C4079897E5D87EE84D8EE0BC70208307C6E7EE861BD27DC3BDD13FCCCE73B38387D16A66277776BAE30FD58DEF82763C5F39211EF08FF4182A7FDBBF8DB7199E07B3AD3F5BDA6F8336BC93EBC5C77CFF5906B61CC59A173AED640AC01D7710DB5E9FCFBA1DD6A79ABF13FD8B7A1AFF5635BF9C95FC0D4FE814E38730FD46EA17000000FFFF0300504B030414000600080000002100EC2CCBFF75010000F502000011000801646F6350726F70732F636F72652E786D6C20A2040128A00001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000008C924B4FC3300C80EF48FC872AF72EE9788DAAEBC4439C9884C410885B96785BA04DA2C4D0EDDF93B66B47C50EDCECF8F357D74936DB9645F40DCE2BA3A7241931128116462ABD9E9297C5433C219147AE252F8C8629D98127B3FCF424133615C6C19333161C2AF05130699F0A3B251B449B52EAC5064AEE4781D0A1B832AEE41852B7A6968B4FBE063A66EC9296805C72E4B416C6B63792BD528A5E69BF5CD108A4A05040091A3D4D46093DB008AEF4471B9ACA2FB254B8B37014ED8A3DBDF5AA07ABAA1A55670D1AE64FE8DBFCF1B9F9D558E97A5702489E4991A2C202F28C1EC210F9AFE507086C8FFB24C4C20147E3F29BE54639636CF4CC353ADE705DADDEFA27EC2AE3A40F86411630095E386531DC65EB1F1C04BAE01EE7E172570AE4EDEEEFA7FE227597836F55BF8FFCBA21FA34DB2FBB1D0F64149694B62BED2AAF6777F78B07928F597211B3EB988D17EC321D272963EFF58483FE83B0DC0FF04FE3557A3E191A3B41BBA4E143CD7F000000FFFF0300504B0304140006000800000021000B466A101B0B0000047000000F000000776F72642F7374796C65732E786D6CBC9D5D73DBBA1186EF3BD3FFC0D1557B91C8F267E239CE19DB896B4FE31C9FC869AE2112B2508384CA8FD8EEAF2F005212E425282EB8F5952D51FB00C4BB2F88E587F4DBEFCFA98C7EF1BC102A3B1B4DDEEF8D229EC52A11D9C3D9E8C7FDD5BB0FA3A828599630A9327E367AE1C5E8F74F7FFDCB6F4FA745F92279116940569CA6F1D9685196CBD3F1B888173C65C57BB5E499DE385779CA4AFD327F18A72C7FAC96EF62952E592966428AF265BCBFB7773C6A30791F8A9ACF45CC3FABB84A7956DAF871CEA526AAAC588865B1A23DF5A13DA93C59E62AE645A1773A95352F65225B63268700948A3857859A97EFF5CE343DB2281D3ED9B3FFA5720338C201F6D780343EBD79C854CE66528FBEEE49A461A34F7AF813157FE67356C9B2302FF3BBBC79D9BCB27FAE545616D1D3292B6221EE75CB1A920ACDBB3ECF0A31D25B382BCAF342B0D68D0BF34FEB96B8289DB72F44224663D362F15FBDF1179367A3FDFDD53B97A6075BEF49963DACDEE3D9BB1F53B727CE5B33CD3D1BB1FCDDF4DC048E9B1DABFF3ABBBB7CFDCA36BC64B1B0EDB079C975664D8EF70C540A93C8FB471F572FBE57666C5955AAA6110BA8FFAEB16330E23AE174FA4D6B17E8AD7CFE55C58F3C99967AC3D9C8B6A5DFFC7173970B95EB4C3F1B7DB46DEA37A73C15D7224978E67C305B8884FF5CF0EC47C193CDFB7F5ED96C6DDE885595E9FF0F4E26360B64917C798EF9D2E4BEDE9A31A3C9371320CDA72BB169DC86FF67059B344AB4C52F3833134034798DB0DD4721F64D44E1EC6D3BB37AB5EFF653A8860EDEAAA1C3B76AE8E8AD1A3A7EAB864EDEAAA10F6FD590C5FC3F1B1259C29F6B23C266007517C7E34634C7633634C7E32534C7631534C7E30434C793E8688E278FD11C4F9A2238A58A7D59E824FB8127DBBBB9BB8F1161DCDD878430EEEE23401877F7841FC6DD3DBF8771774FE761DCDDB3771877F7648DE7D64BADE846DB2C2B07BB6CAE5499A99247257F1E4E639966D9AA8886670E7A3C27D949024C3DB33507E2C1B498D9D7BB33C49A34FC785E9A422E52F3682E1EAA5C17D3433BCEB35F5CEAB2366249A27984C09C9755EE1991909CCEF99CE73C8B396562D3414D251865553A23C8CD257B2063F12C211EBE159164525827B4AE9F17C6248220A95316E76A78D714239B1FBE8A62F8581948745149C98958DF6852CCB286D7061633BC34B098E19581C50C2F0C1CCDA886A8A1118D5443231AB08646346E757E528D5B43231AB78646346E0D6DF8B8DD8B52DA29DE5D754CFA9FBBBB94CA9CC71EDC8FA978C8985E000C3FDC34E74CA33B96B3879C2D1791392BDD8E75F719DBCE854A5EA27B8A63DA9A44B5AEB72972A9F75A64D5F001DDA251996BCD23B2D79A4764B0356FB8C56EF532D92CD0AE69EA9969352B5B4D6B49BD4C3B65B2AA17B4C3DDC6CAE119B631C095C80B321BB4630932F89B59CE1A392966BE4D2F87776CC31A6EABD7B31269F71A24412FA58A1F69A6E1EB9725CF7559F6389874A5A4544F3CA1234ECB5CD5B9E65A7EDF4AD2CBF25FD2E58215C2D64A5B88FE87FAD515F0E8962D07EFD09D6422A3D1EDCBBB940919D1AD20AEEF6FBF46F76A69CA4C333034C00B55962A2563366702FFF693CFFE4ED3C1735D04672F447B7B4E747AC8C22E05C141A626A98488A49799221324C750CBFB277F9929962734B4BB9CD7379D949C883865E9B25E7410784BCF8B4F7AFE21580D59DEBF582ECC79212A53DD93C09CD3864535FB378F874F75DF54447266E88FAAB4E71FED52D746D3E1862F13B670C39708564D7D7830F94BB0B35BB8E13BBB85A3DAD94BC98A42782FA106F3A87677C5A3DEDFE1C55FC35352E5F34AD20DE00A4836822B20D9102A59A55941B9C79647B8C39647BDBF8429637904A7E42CEF1FB948C8C4B0302A252C8C4A060BA3D2C0C24805187E878E031B7E9B8E031B7EAF4E0D235A023830AA3C233DFC135DE57160547966615479666154796661547976F039E2F3B95E04D31D621C2455CE3948BA034D56F274A97296BF1021BF48FEC0084E90D6B4BB5CCDCDD3082AAB6FE226409A73D49270B15DE3A844FEC967645D332CCA7E119C1165522A45746E6D73C0B191DBF7AEED0AB34F720CEEC29D64315F2899F0DCB34FFE585D2F4FEBC7325E77DF76A3D769CFAFE2615146D3C5FA6CBF8B39DEDB19B92AD8B7C27637D836E6C7ABE759DAC26E7922AA74D551F830C5F141FF609BD15BC187BB83372B89ADC8A39E91B0CDE3DD919B55F256E449CF48D8E6879E91D6A75B915D7EF8CCF2C7D64438E9CA9F758DE749BE93AE2C5A07B736DB9548EBC8B6143CE9CAA22DAB44E7716CAE164075FA79C61FDFCF3CFE788C8BFC148C9DFC94DEBEF223BA0CF69DFF12E6C88E99346D7BEBBB27C0BC6F17D1BD66CE3F2B559FB7DFBAE0D4FFA1AE1BBD70CA0A1EB5720EFA5FB8DA9A65FCE3D87BBAF1237ACF3B7E44EF09C88FE8351379C35153929FD27B6EF2237A4F527E047AB6824704DC6C05E371B3158C0F99AD202564B61AB00AF0237A2F07FC08B45121026DD4012B053F026554101E645448411B1522D0468508B451E1020C6754188F332A8C0F312AA484181552D0468508B45121026D5488401B1522D0460D5CDB7BC3838C0A2968A34204DAA8108136AA5D2F0E302A8CC71915C687181552428C0A2968A34204DAA81081362A44A08D0A1168A34204CAA8203CC8A89082362A44A08D0A1168A3D68F1A861B15C6E38C0AE3438C0A2921468514B45121026D5488401B1522D0468508B45121026554101E645448411B1522D0468508B451EDC5C2014685F138A3C2F810A3424A885121056D5488401B1522D0468508B45121026D54884019158407191552D0468508B45121A22B3F9B4B94BEDBEC27F8B39EDE3BF6FB5FBA6A3AF5DD7D94DB451DF447AD7AE567F57F16E142A9C7A8F5C1C3035B6FF483889914CA9EA2F65C5677B9F69608D485CF3F2EBB9FF071E903BF74A97916C25E3305F0C3BE91E09CCA6157CABB91A0C83BECCA743712AC3A0FBB665F37121C060FBB265DEBCBD54D29FA700482BBA6192778E209EF9AAD9D7038C45D73B4130847B86B667602E10077CDC74EE0516426E7D7D1473DC7E9787D7F292074A5A34338F113BAD2126AB59A8EA131FA8AE627F455CF4FE82BA39F80D2D38BC10BEB47A115F6A3C2A48636C34A1D6E543F012B352404490D30E1524354B0D4101526359C18B152430256EAF0C9D94F08921A60C2A586A860A9212A4C6A7828C34A0D0958A921012BF5C003B217132E3544054B0D516152C3C51D566A48C04A0D0958A92121486A8009971AA282A586A830A941958C961A12B0524302566A4808921A60C2A586A860A921AA4B6A7B16654B6A94C24E386E11E604E20EC84E206E72760203AA25273AB05A720881D512D46AA539AE5A7245F313FAAAE727F495D14F40E9E9C5E085F5A3D00AFB516152E3AAA536A9C38DEA2760A5C6554B5EA971D552A7D4B86AA9536A5CB5E4971A572DB5498DAB96DAA40E9F9CFD8420A971D552A7D4B86AA9536A5CB5E4971A572DB5498DAB96DAA4C6554B6D520F3C207B31E152E3AAA54EA971D5925F6A5CB5D42635AE5A6A931A572DB5498DAB96BC52E3AAA54EA971D552A7D4B86AC92F35AE5A6A931A572DB5498DAB96DAA4C6554B5EA971D552A7D4B86AA9536A4FB5347EDAFA0126C3B63F48A63F5CBE2CB9F90E6EE78199A4FE0ED2E622A0FDE04DB2FEA124136C7A12353F49D5BC6D3BDC5C30AC5BB481B0A978A1DB8A9B6F4FF234D57C0BEAFA311EFB1DA8AF1BF67C55AAEDC86608569F6E86747329B4FEDCD665CFCE7E9766C83BFA6C25E91CA35A355F073F3669B8AB87BA3F3359FF6897FEE7264B34E0A9F9C1AABAA7C933AB517AFB2597F296D59F564BFF47259F97F5D6C99E7D68FED5F659FDFD6FDEF8DC4E145EC078BB33F5CBE687C33CE35D7F237C7305DB9B92C60D2DC36D6FA7183AD29BBEADFE2B3EFD0F0000FFFF0300504B01022D0014000600080000002100DFA4D26C5A010000200500001300000000000000000000000000000000005B436F6E74656E745F54797065735D2E786D6C504B01022D00140006000800000021001E911AB7EF0000004E0200000B00000000000000000000000000930300005F72656C732F2E72656C73504B01022D0014000600080000002100D664B351F4000000310300001C00000000000000000000000000B3060000776F72642F5F72656C732F646F63756D656E742E786D6C2E72656C73504B01022D0014000600080000002100A1A57D75DD040000711200001100000000000000000000000000E9080000776F72642F646F63756D656E742E786D6C504B01022D0014000600080000002100AA5225DF230600008B1A00001500000000000000000000000000F50D0000776F72642F7468656D652F7468656D65312E786D6C504B01022D001400060008000000210034099E72EE030000970A000011000000000000000000000000004B140000776F72642F73657474696E67732E786D6C504B01022D0014000600080000002100198FCB3FC4010000ED040000120000000000000000000000000068180000776F72642F666F6E745461626C652E786D6C504B01022D00140006000800000021005B6DFD9309010000F101000014000000000000000000000000005C1A0000776F72642F77656253657474696E67732E786D6C504B01022D0014000600080000002100CD5AF0C5DB010000DD0300001000000000000000000000000000971B0000646F6350726F70732F6170702E786D6C504B01022D0014000600080000002100EC2CCBFF75010000F50200001100000000000000000000000000A81E0000646F6350726F70732F636F72652E786D6C504B01022D00140006000800000021000B466A101B0B0000047000000F0000000000000000000000000054210000776F72642F7374796C65732E786D6C504B0506000000000B000B00C10200009C2C00000000, N'*1')
GO
INSERT [dbo].[GCAA_ESS_Leave_Attachments_VehicleMaintenance] ([DOC_ID], [FILENAME], [DOCUMENT], [REQUESTID]) VALUES (CAST(3 AS Numeric(18, 0)), N'logo.jpg', 0xFFD8FFE000104A46494600010101006000600000FFDB0043000201010201010202020202020202030503030303030604040305070607070706070708090B0908080A0807070A0D0A0A0B0C0C0C0C07090E0F0D0C0E0B0C0C0CFFDB004301020202030303060303060C0807080C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0C0CFFC00011080092011203012200021101031101FFC4001F0000010501010101010100000000000000000102030405060708090A0BFFC400B5100002010303020403050504040000017D01020300041105122131410613516107227114328191A1082342B1C11552D1F02433627282090A161718191A25262728292A3435363738393A434445464748494A535455565758595A636465666768696A737475767778797A838485868788898A92939495969798999AA2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE1E2E3E4E5E6E7E8E9EAF1F2F3F4F5F6F7F8F9FAFFC4001F0100030101010101010101010000000000000102030405060708090A0BFFC400B51100020102040403040705040400010277000102031104052131061241510761711322328108144291A1B1C109233352F0156272D10A162434E125F11718191A262728292A35363738393A434445464748494A535455565758595A636465666768696A737475767778797A82838485868788898A92939495969798999AA2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE2E3E4E5E6E7E8E9EAF2F3F4F5F6F7F8F9FAFFDA000C03010002110311003F00FDFCA28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28AF863FE0B37FF000530BAFD8FFC1D0780FC1ED245E3FF0016581B917D82068B64CCF179E87BCCCC922A63EEEC2C7A2838E22BC28D37527B23DAE1FC87179CE3E9E5D82579CFEE4BAB7E497F92D4F5CFDA8BFE0A8BF0A7F658F17C5E16BFD46F3C49E34B89A3B78F40D0E25B9BA49242022CACCCB144492BF2B3EFC302148AFA29492A33D7BE2BF9C9FF008275F875FE25FF00C1403E15C17AD25E3CDE29B5BFB869732B4E6193ED0C5F392D9F2CE73EA735FD1BD70E598C9E254A725657D0FB5F12F83705C35530D82C3C9CEA4A2E5393EBAD959745A3EADEBAB0A28A2BD43F300A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28AC0F8ABE26D43C17F0BFC49AC693A71D5F55D274BBABDB2B00706F668E2678E2CFFB6C02FE349BB2B974E9BA93508EEDD8F837FE0A87FF00058DB8FD9D3E32597C35F003DA1D46C2E2DDFC4DAC32ACC2C50B2B35AC2A415F37CBFBEE41D9B800378257C5FF00E0E54F09B59FC60F861AEE3E4D4747BCB0073D4C13A39FFD291F9D7E7278DFC67A97C46F196ABE20D66EA4BED5F5BBC96FAF6E24FBD3CD2B97763F5624D7E97FFC1563505FDA47FE0939F01BE27C07ED371A7BDADADEB83BBCB796D5A2B924FB5CDAAAFD48AF92963278AA5594BC9A5D9267F5BE1F84709C2D9A64D2C3C777529D497594E70F775ED74ECBA2F3B9F28FFC11F7FE5247F0B7FEBFAE7FF48EE2BFA13AFE797FE091DA8C7A5FFC146FE15C926EDADA9CB08DA3F89EDA645FD5857F4355E8F0FF00F025EBFA23F3DFA40A7FDB9877FF004E97FE9730A28A2BDD3F070A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800AFCF5FDAA3FE0AD52FC1CFF0082A4F83FE1EADEC567F0F7C3F2269FE29970313DCDE4436C8CFDA3B6F32162077F3B39C2E3F42ABF9E1FF82AD7C2DF157C31FDBCBE22BF8A6CE4B73E21D62E758D2E7E5A2BCB09656303A31EBB5004603EEBA32F6AF2738C4D4A34A32A7DCFD6BC20E1DCBF38CCEBE1F30B3FDD4B9575BCAD1E65E714DB5D9D9F42DFFC158FF6537FD93FF6CEF1269D6B69F67F0E788E43AEE88547EEC413312F10F4F2E51226339DAA87F8857D37FF0004E591BF6C6FF824C7C65F825C5D6BFE16DFAA6896E07CEC188BB8113BE4DD412A923B4C01EBCE5787B51FF87B6FFC137FFE11C61F6CF8E1F0260FB45802C5AE75ED376852173CB3B2222B75265862248F3715F3CFFC128BF6ABFF008643FDB43C3FA9EA137D9BC3DAFB7F606B8643B561826750256CF4114AB1B93D76AB8EF5E147929E254D7F0EA2FC1EEBE4CFDCF131C6E63C395305535C76025197F8A54BDE84D775561B3EEDAE879BFEC59E335F879FB5F7C2FD6E46D9069DE2AD3659CE33FBAFB4C624FF00C70B57F4B75F809FF057DFD9226FD913F6C8D527D32292DBC35E3191B5FD1658F81033BE678148C60C5293803A23C5DCD7EE47ECE9F14E3F8DFF0000BC19E2F8DD1FFE125D16D3517D9D1649225675E3BAB96047620D7A792274A75284F747E69E3655A599E132ECF70BAD3A9192F4D9A4FCD7BC9F9A3B3A28A2BE80FE7D0A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2803CDFF6C6F1E6A3F0B7F649F89FE25D21A54D5740F0A6A9A859C91FDE8A68AD25747EA3EEB00C7BE01C735F955FB29FED09E0CFF82B1FECE1A6FC08F8BDABC1A2FC5BF0DA795E07F15DC8DD26A5F2E16191CFDE90855574241980461991735FAD5FB476A5A168DFB3CF8F2F3C506E87866D7C3BA84DAB9B65DD30B35B690CFB0776F2C3607AE2BF9F4FDA6FFE09D1E21F81DE1683E257C38D762F89FF0009A6617167E2CD081F334C6520ECBC89497B6950E324FCA0E32558ED1C98A8F32E592BAEA8F8ECEB88B37C8336C367194C9DE926DA4FA5F7B76E97B35D1E8ECE4D367F89DFF04B9FDAEA09A7B67D13C5FE13B8DCD14996B4D56D9B823231E6DBCC9919183FEEBAFCBF407EDBDFB297877F6B9F85773FB4AFC0BB7F3B4DBE2D3F8DFC2D17CD77E1FBDC6E9E6541C94C92CF81D0F98A36336CE73E0A7FC147FC0BFB607C34D3BE167ED5505C5C1B0510787FE2359459D534738C0175804C8870A0BED6DD805D59879A3B3F0F7C05F8DFFF00049BF18C5F143E18DF5A7C53F84FAB42935D6A3A31FB4E9FAB58FDEFF49890B98B0376D9D772A64FCFF3321F9D9E0DD24E2FDEA6FEF8BEFF00E7DCFEC2E0AF1772BE31A74B31CB6AC68E654D72CA9CDF2C6AC7AC2FE6F583DE32DB99731E9BF0766B6FF82C5FFC133E6F015DDC4127C67F84289269535CB812DFC6ABB6262E792B346BE4C849C0952376EAB9FA5FFE086DAA78BA2FD87EDFC3DE2ED0759D127F0A6B179A7581D42D5A06B8B7DFE61C06018EC99E68CF1C6C033C60797FEC17F093E0AFC67F8F6BFB477C22F146A1F0FECF45B4B8FF0084D7C18625486D249626620B676A5B128D2FCA1918C436F9450AADAB2FF82A1EADE37FDB43C3D35BCF2E9DF0E92F4E962CBA7DAA294F962EA6FF0068315703F802E064962DEC65F86949AAEDEA95AEB692E8CF89E3EE20A54A15B22C3D36A9CA6AAF24D352A151DF9E0BA38BBF326BDDB4B4BDCFD0CA28A2BD53F240A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A28030FE26FC3FB0F8B1F0DFC41E16D543B697E25D36E74ABC0840630CF1344F824119DAE7B57F3C1AFF847F689FF008246FC5DD4AE2C4F8ABC236E2F64B14D516D19B45F10C71BB2A121C3412AB282C15C1601BA035FD1DD7E5CFED1FF00F059AF893FB097ED63E39F875F157C05A5F8D7C272DFCD79A0DCC47FB3EE64D2AE1DDE052763C370A884447E556DD13866639AC2BA5A36EC7C2F1AE0F0928D2C4D7AB2A528B694E29BB5FBDB5E9A58F8526FDA0BE01FED4776D27C50F00EA3F0C7C5374732F89BE1EAAB585CC8481BEE34B99B6A8FBCCCD6F22924FDCAFA03F647F85BA87C0CB84D43F66FFDB43E1BDD0B97125C7877C5D1CBE1F86F58E32A6CEE0CA1DF036EF55561D9D41CD7A4E9FF00B67FFC13BFF683912EFC59F0BE0F05DFCAE0CCAFE1D92D54B7396274D660C392492013D48CD761A75FFF00C132F4BBD8EE235F05B3C477289A1D62643F547054FD0835828ABDEEBF23E43079753F69EDFEB3424FF994E54E7FF92D95FD536FB9DFFED59E38D5BE167EC0F6106A7A3FC39F0FF8DBE276A446BB2782100D3B508A32C5A659701A466548158B13C48CB92073F337EC71FB39EADFB497C6BD334CB18E44D36C268EEF55BC1C2DA5BAB0279FEFB636A8EE4E7A0247D01FF0559D3F40B3F83FF053FE10DB4B6B1F071B2BC7D2E0B5B736D0476F24766F085888529F212705411920806BE8DFF82657C1287E117ECB9A45F3C4A354F17A8D62EA4C0DC6371FB84CF5DA22DAD8ECD23FAD7A10B461A1FB25394E518BAB2E6765AB77BE9DFA9F42D15E47E2EFDA8AE2FB5A9B49F875E13D47E22EA367234579716F70965A5593AE37235E483634833F7230E4608383C573B75F1F7E38787A06BAD43E07DBDEDA46332AE9BE29825B851DCAC7B32E719F947278A5666A7BF515C1FC03FDA2740FDA1FC3B7377A47DB2CEFB4C98DAEA7A5DFC3E45EE9938CE63950F4E870471C11D4103BCA401451450014514500145145001451450014514500145145001451450014514500145145001451450014514500145145001451450015F26FFC160BF65AD63E3CFECAFAB6BBE03F87DE05F881F153C230FDA342D3BC4B66F345A8425D4DCDAA347342EB23C6A4A7CE3E7551C6E2C3EB2A286AFA333AD469D587B3AB1524FA35747F23BA07FC147CF88BC51368107EC6BF0FF51F12D9CC6D6F74FB2BCF177DA22B85255E336E352678D832B0D8791823B57DB7FB36D9FED4FA9E871F8924F83FFB3CFEC3BF0F2C22DF75F117C65A016D634F52A4936EBABDCCB3BCB8E554A46A4800BF4AFD50FF0082AFFEC7DFB40FED4DF0EF4EFF00867BF8F37BF07BC47A7A4B15DD9C89B34FD6D1F1B4BDC471BDC5B4887761E30D90D82B9008FC6CF8F9FB0BD8FEC49F1C3C3BA1FC68B7F8D5FB71FED23AB888F87BC2F756BAA45E0BB6B890AB6F9AFEE499B51453862B0ED88ED749B672565422B6470D1C9F2FA52E7A542117DD4629FE47E8B6A5A9E9BFB517FC12BECF5EF0BF887E26FC41D37C07AE3CD67E35F1B5B082FBC6D6CEC45C5FDB4785905979D3958F7C69B52DB001550C7ED5F859A10F8CFF00B30F806C22BC9ECF40BDD02C4EA4D6D298E7B98C4080DAAB2F281882246041DA0AAFDF2C9E45FF0004E5FD83FC63F0DFC1DE28F1AFC7CD6ECFC59F167E2969B069BACE9D631AC5A17847498964F2343D3A25F9520884CFBD94FEF1F925B6EF6DEFD9DBC633FEC71E32FF008541E349E54D027B8925F066BF71816F770BB173672BF4599598E338CE70300A6ED3A1E89F48F877C3961E10D0EDB4CD2ACAD74ED3AC90456F6D6D108E285476551C014788B448FC4BA05EE9D349710C57D03C0D25BCA629A20CA46E471CAB8CE430E41008E9576B8AFDA0FE39691FB3B7C2AD53C51AC4A823B38C8B6B72D87BD9C83E5C29DF2C7DB800B1E01A919F3B6BBFF04DEF197843E23CDE2DF007C59D66C75C9E1DF7336AC0CD26A3382DFEB9D30A63DBB061A37C15279E00F7EFD9AFE27EB1F143E1D3C9E24B0874CF13E8B7D3E91AC5BC07302DCC2465A339394656461C9FBD8C9C578C7EC73FB3B78E7C59E1C6F1B7C46F1C78E62BFF00134C7508F43B5D5A6B4B7B78DCEE5F3154828483C22150ABB41E785FA57C3DE15B3F0C497ED68850EA3702E67258B1790451C5B893C925625C92492724D53EC06951451520145145001451450014514500145145001451450014514500145145001451450014514500145151DDDDC5616B24F3C91C30C28649249182AC6A064924F0001DE8024A28A2800A2AA6A1AED9693736F0DD5E5ADB4D765C4092CAA8D31452EDB41396C282C71D0027A53B49D62D35FD3E3BBB1BAB7BDB5973B268241246F8241C30241C1047D450059A2AA6A3AFD8E91756B05DDEDA5ACD7D27956D1CD32A35C3F5DA809CB1F6156E800A2AB6ADAC5A681A7C9777D756F656B1637CD3C8238D324019624019240FA9AB3400560FC49F863A07C60F08DC685E25D2ED757D2EEBEFC33AFDD6E70CAC3946193865208CF06ADDCF8D347B36944DAB69B11B7B94B3943DD22F973B805226C9E1D832E14F2723039AB57DAC5A697246B73756F6ED31DB189640864390B8193CF2CA3EAC3D6803E55F8DDE1CF8AFFB127C2DBFD73C11E324F14784347009D27C456A2E2EB4D84B2A8F2E7055A445C81B4E36AF4CE2B8CFD943E1B78E7F6E6F88761F12FE2B3B4BE13D0DF7E87A5187C9B4BB9BFBE91778D48C976C97202E4AA903ECEF1B780B47F891A27F66EBB610EA7A779A933DACF930CCC8772EF4CE1D41C1DAC0AE4038E055ABDD5F4DF0BC1690DC5CD8E9D1CF225A5AA4922C2B239F95224071963C00A39F4155CDA0AC5EA28A2A4614565BF8DF468B53164DABE98B7867FB2880DD2094CDB43F97B739DFB483B7AE083DEADDD6B169637714135D5BC33CFF00EAA37902BC9C81C0272792071EA2802CD14557D5B57B5D074D9EF2FAE6DECACED90C934F3C8238E251D5998E001EE6802C514D8A559E257465747019594E4303D0834EA0028A2B2F4CF1BE8DAD5DC1059EAFA65DCF75135C431C374923CD1AB6C67500E4A86F9491C03C5006A51451400514514005145140051451400514514010EA2B33E9F38B760B706361131E8AD8E0FE75F36A7C4CF885E3FF00057803C2B22F8DFC3DE345D5A2B6F166A10E9312858160984D3249E5BDBEC3298082A3A11C006BE977711A9248000C927B578E782BE2E7C30D73C7E3C49A5E8D7106A7AF24B0C1E2193C3F3DBC5AAEC51BA34B968C07252DC63270C2318CE298127C23F8E9AFC1F0D7478BC53E16F1B5E788A1B7116A13C3A198926954905C2E40F98007E51B7278E2A87ED0BF18351F11FC11F14699A47823C7136ABA969B3DADA24DA009E2691D0850E877295F5DCA47AD6E0FDADBC3F17C3C7F165CE93E2BB2F0E0B28B504BF9F4B6114D0CAD188CA6092C5BCC520019C66B4BC4FF00B4DF84BC33A6C779F6C9B50B59F4A4D66096C62F3D6E2DDE78E042841E49925418F73E9401E79A67ED13AC784FE39C5A3887C5BE2AD0AFED65867B58FC2B3DBBE817B0041B639CC51C73C32625C1DCC41418721803CE7ED19F1F3E21DDF886E27F08E85F1334BB2D234D592CE2B7F0C34E355D4BCE05A09F3148C2010E30E98059D86ECA62BD8F52FDA3EC347FB025D7877C6105D6AB766CACAD5F4CFDFDD48219266D8BBB90B1C4E49F6A92DFF696F0C4FF000DB56F1393AA436BA25EFF0066DE5A4B63225F4577BA355B7F208DC64632C6140CEEF3171D680380F1778F53E2B7ED21F0963B7F0F78AED23D3EEB51BBBA3A96893DBC4B04BA6DCC68CCCCBB572DF2EC721F2402BCD41F0ABC69A9FC2DFD99FC1DA59D3E7D2F51F11F896F3C3B0C8EBE4369426BDBDF2AE423C6EAC42A2B2A328572CA3201AF5DD37E31E83ACF89740D2ED2E5AE66F1369726B3A7C91A6629AD93CACBEEED9F39303BE4FA551FDA1353F07E9DF0D654F1BD9AEA5A25EDCC16A2CFEC8F7525D4EF22889238D01767DD82368C8C13DA803C66F6F35AF1FEB9E193733DCF88A6F0AFC5B3606F16D5775BDB45A74AAE5BCB50117CD3CF6C903D2BADF809FB49DF6BDF0CEDE6D4741F1A6B778B777713DF5B695BA1B80B732AA14605432840AB903AA9EE0D59B4F1D7C34D0BE197FC22F6BE1FBEB2D26E2EDF4B7D0868F35A5C34CD6F35DE0C4E11CF98904843F3B9B8CE735D3693F14FC17F0FBC1FE14B4D19638B48D5F4D92F348B7D3EDFF76B670C1E7BCB818DA814A8C9EAD228EAD401F3DFED71F1B3C45E35B4F18E9767E1AF1D1D12E743B2B7B1B29342970FA9C77E669725158A8302C786276F1EA79EBBE137ED37E297F8C7F61D5DB5FF001368BA8686D77FE89E0CBDB05B2D496504DAC2658D5993C9DEDBE56E4A0C10C761F5AF837AF7833E22DEEADE24F0D6976B05F3CC96F7D79F62582E27692DADAE46E6C65B31CB06727AAE3B56C7C58F8B3A37C16F073EB9AE4B3A5A2CD15BA25BC2D3CF3C92305548E35CB3B64E7007404F6A00F91FC59E2C3E3AD67C43059689E2D5B8D7FE24689ACDA473F87AF621F658A3B4495DDCC5E5A6C68DC1CB7F0E464609EFFF006F9D33C5DAD6B960341F0FEB37E34DD225BBD2AF34CD1A0D4245D505CC2D1C72B491BB451058C49F26DDCEAB93F260FB7C3F1CFC35243E2495AFC4507856D23D42FA57188FECB243E725C237478D94361877461D453350F8EDA0E8FA0EAFA85F1BDB28B42D2EDB55BC8E6B72258E39C398D02F532931B2EC1CEEC0EA68030BC4DFB455D5A7852F6E74EF03F8F66BFF00B33359C5268AF89262BFBB560096505CA8248C28249C0048F9D67F1778E75ED1F4C7F15D8F8EF55B3D07C41E18D6E6B9D53C312413D9DC2DCB9D42381618419614088CBB039C3756CD7D15AD7ED61E1DD1F47F0FEA2BA7F892FAC3C4E608B4FB8B5D38BA4B34BB82C079056505583291952083CD58BEFDA97C31A4D9DDB5EC7AE5ADDDA6A5069074FF00ECC966BD96EA6B64B9489218C3331F29C31C0E307D280397F8F7F1C3C4979F0C2FE0F09685E38D1B5E9B6ADBDCBF8765B9EF9641E5ACBB19802A2468D9509C91547F674F8E9E2CB4F085F5AF8C7C2FF116F351B7D42516CF71A28F3D2D4E3CB5965458E295C1DFF3C4BB7695CFCD9AEC75AFDAE3C11E1AF0F36A5A95FDEE9B0DBEA71693791DE584D6D3E9F34A8CE8668DD43A46514B6FC6DC739C038EC741F1FE9BE24F14EABA3DA4AD2DDE8D15B4D7042FEECACEACD1956E8D9087F4A00F97B4AB1BAF1EFC5287C4567A1EB696B75F162CEF6292EF4B9ADE58AD868AD1C8ECAE8195048A14B7DD240E4F15B5FB6747E309BE2DD85DE8DE1DD7AF1344B3B1BAD26F34AD161BEF36E0DFA9BA49A468DA48C2DBA064542B963924F007AFDB7ED43E10BDF0C78CB5786F2E25B3F02B4A3532B6ED92B1EF0D245FF3D10B472A865E0B44E074AD7F883F18B4DF877E20D2B49B8B5D56FF0053D6A1B8B8B3B5B0B6F3A49560308978C8E9E721FA06F4A7760677FC2F7FDD46C3C1DE3C3E62EEC7F6472BD782377078FD6BCEFF006B6F8C526ABF017C4B6169E12F170D56787669BF69F0EB5DC32DCAB0641B42C8BFC2482EBB78E4E715DB7857F6A6D07C59FD9CD1E9BE24B4B6D5B526D22D6E6EF4F314325D2BC91B479C9E55E1901FF74D69F8CFF686F0CF806EF5883529EF127D164B38658A0B392E259E5BBDDE447124619E476D8DC28E31E9480E7BC4BFB43087E1FDD4BA4784BC7C864B22BA7CABA1B8C3326213B58EE1C95E19723B8AE0FC51F1B7C5FAA7ECB3A15AC5E15F88F73E33BBD36CA3BBB9B6B096D88B80116E252F10DC1721DF0A1778C0046735DDF8BBF697F036AFA4269FA969BAC6A33DCEA96DA7368975A1CC977F687592E2DC982755254FD99D95C65729D720E347C05F1CFC2834DB7D1B48D2F54D29F4EB993488F466D2DAD66B4921B4FB508844400018002857E53B9706803CC3F652F8D9E34F0C68BAB59F8FFC3FF105ED6011DDDA5DDD6913DC49689E5E6E2267DBE64AA922964E1E42AE1792B597FB27783751D33C57F096F2E348D42D3C9F0B6BB0DCCB3D9BC4D117D46278924DCA0A920B32AB60F2C40EB5EC3A67ED41A66AB7FAC5BC7E1CF1A093C3F91A883A493F652201701480C49631B290AA093B8000938ADEF0BFC6DF0EF8E3C63FD8BA2DE7F6B4EBA6C5AACB3DA2F996D6F0CBFEA77C83E50F20CB2A7DE2A0B631CD0075B45145200A28A2800A28A2800A28A2800A28A28021D46C22D5B4F9ED675DD0DCC6D148B9C6558608CFD0D787E9BFB20EBBA76A1E16857C7B22687E10852CACEDA2B09E3B8BAB445648E0B87175E4C9B55BEF2C0A4ED5CF0315EED45007CF3E08FD8357C1BE0F93444D6BC3EB6D25A5ADA3DCD9784EDACEFA7104D0CAAD2CE8FBE424C3F36EEA5B71E4569F8F3F61CD2BC53ABF89E7D3F58B8D2ECFC4B602D4E9CF6CB73676529BB8AEA49238C9002C8F10DD1FDD2CEEDC648AF73A28B81E15A57EC41A64F6FA559EB73787AEF48D33546D4CE9FA5F8721D1E1B976B59ADFE710BF27F788C1BAFEE80E878B1A5FEC5763A6F83F41F0E2788753B5D0FC3FAA5CEAD0AE9E82D2F2E66638B769A7524BBC2ACCBBF00BFC84E0AF3EDB453BB03C374BFD90755F066B1A25DF873C777362DE1D8EFED2C4DF69897CE96B772C52B44CC645DDB5E3386C7DD6031F2E4F6BE3CF83FA878FFC17A05BDD6BEABE23F0DEA10EAD6BAA0B01E4B5CC61D72F6E1C028C923A950E0F390C0815DED1480F371F0635FF00116BFA2EA9E25F1641A95CE89AD47AB5BDBD9695F63B48C25A5CDB79688D2CAE0B7DA4BB3348DCA00028AA9E0FFD96B4FF0007EABE2BB88B53BA9D35EB49B4ED3A09231B341B599E49A5861C1E55A694BF3D0246A38415EA7451703C6BE1C7ECD3E26F8492CD0E83E3C8ADF4BBA9ADAE2E2D66D0926691A2B4B7B56C4865046E4B653D3824F5AE8BE31FECFD1FC6AF16F87EF6FF005ED634FB0F0E79D3DBDAE9B21B791AEDC0459CCA0E7E48CC8A140FF96AC73DABD0E8A00F11D3FF00628B0B283C336ADE20D465D3FC3BBACDE068973AA698972B736B633B67E658244501801B90BA118735B5F16BF65F87E2F78AA6BABBD7F51B0D32F65B19AF2CEC97CA96E1ACFCF68009B39502599643F2F5857915EA9453BB03C7F4AFD92A1D134EB1D3E1F11EA73E99A678B21F15DAC778BF689A3954169A2329605964959E4C9190CEDD73C5EF11FECDF35E78E752F14693AFFF00666BF71ACC7ACD9CB2D90B882DC8D3A3B078648F7A9951D13770C8436DC1F979F52A2901E4FA5FECC8D7BE28B8D7BC47AD5BEB7ACEA1A95BDE5EF95A68B7B296082DAE2DE3B6585A49085C5CC8496772C4E3A746FC36FD967FE15058F8D60F0F789752B75F13411DB69AD711FDA1BC3E91A48B1A44C581754329D81BEE855192057AD51401E13A6FEC17A0E81A54DA758F883C4834CD4340B8F0E5FDBDD5CFDA3CDB690128632702268E52CE3008F9DC11F31AEB3C1DF0475D83E24697E25F15F8AE0F12DD787EC6E2C34B48349161E509CC5E6CB29F364F32422141C045196F979E3D2A8A7703CA752FD94348F107C37D1FC2FAADC47A9E99A6788EE7C413457168AD1DE79D71753981949C6D06E719E73B01C73C663FEC59A2F87B56BEBEF08DCDB784A73A858EABA7C569A7A9B6B2B8B68A784978C32F9AB225C481972A79E0E706BDA68A40785F8C3F62D5F8BBE30B3D7FC71AF5B6B9A8DBDEDA4AD15A6986CECDAD6D92EC2DB2C66691C6E7BB77673231F9540005741F0BFF00659D3BE13DC69A9A6DEE2C748D6EEF57B688DB0F34ADC5BBC3E4C92EEDD26C0FF2BB7CDB1514E76E6BD528A2E0737E0EF8769E10F1978B7575BA69DBC577F05F3C463DA2D8C76905B6D073F364401B3C7DEC76CD53F83FF06F4EF83569AEC3A72C0175DD66EB5893CAB7587634CC0ECE3A8500007D07415D851400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451400514514005145140051451401FFD9, N'*1')
GO
SET IDENTITY_INSERT [dbo].[GCAA_ESS_Leave_Attachments_VehicleMaintenance] OFF
GO
SET IDENTITY_INSERT [dbo].[GCAAD0210100] ON 

GO
INSERT [dbo].[GCAAD0210100] ([SerialNo], [DocumentID], [ChasisNumber], [Color], [Make], [Name], [ODOMeter], [OilChangeDate], [RegistrationExpiryDate], [RegistrationNumber], [SalikAccountNumber], [TyreChangeDate], [InsuranceCompany], [InsurancePolicyNumber], [EngineNumber], [LastServiceDate], [Availability], [Model], [CreatedBy], [CreatedDate], [InsuranceExpiryDate], [Location]) VALUES (CAST(1 AS Numeric(18, 0)), N'VM-0000001', N'5678', N'#ff0000', N'Toyota', N'Camry 2011', CAST(100 AS Numeric(18, 0)), CAST(0x9D3A0B00 AS Date), CAST(0x70400B00 AS Date), N'ABCD', N'1234', CAST(0x9D3A0B00 AS Date), N'test', N'123456', N'1234', CAST(0xDE2B0B00 AS Date), N'No', N'Camry', N'asantra', CAST(0x983A0B00 AS Date), CAST(0x1F440B00 AS Date), N'Abu Dhabi')
GO
INSERT [dbo].[GCAAD0210100] ([SerialNo], [DocumentID], [ChasisNumber], [Color], [Make], [Name], [ODOMeter], [OilChangeDate], [RegistrationExpiryDate], [RegistrationNumber], [SalikAccountNumber], [TyreChangeDate], [InsuranceCompany], [InsurancePolicyNumber], [EngineNumber], [LastServiceDate], [Availability], [Model], [CreatedBy], [CreatedDate], [InsuranceExpiryDate], [Location]) VALUES (CAST(2 AS Numeric(18, 0)), N'VM-0000002', N'1147', N'#0000ff', N'Nissan', N'Altima 2013', CAST(5000 AS Numeric(18, 0)), CAST(0xE5380B00 AS Date), CAST(0xE7410B00 AS Date), N'4567', N'7784556', CAST(0x303A0B00 AS Date), N'Oman Insurance', N'1234', N'1142', CAST(0x3C370B00 AS Date), N'No', N'Altima', N'asantra', CAST(0x983A0B00 AS Date), CAST(0x7D3E0B00 AS Date), N'Dubai')
GO
INSERT [dbo].[GCAAD0210100] ([SerialNo], [DocumentID], [ChasisNumber], [Color], [Make], [Name], [ODOMeter], [OilChangeDate], [RegistrationExpiryDate], [RegistrationNumber], [SalikAccountNumber], [TyreChangeDate], [InsuranceCompany], [InsurancePolicyNumber], [EngineNumber], [LastServiceDate], [Availability], [Model], [CreatedBy], [CreatedDate], [InsuranceExpiryDate], [Location]) VALUES (CAST(3 AS Numeric(18, 0)), N'VM-0000003', N'56789', N'#ffff00', N'Toyota', N'Corolla', CAST(100 AS Numeric(18, 0)), CAST(0xA23A0B00 AS Date), CAST(0xFD410B00 AS Date), N'12345', N'12345', CAST(0xA23A0B00 AS Date), N'Oman Insurance', N'12345', N'12345', CAST(0x25390B00 AS Date), N'Yes', N'Corolla 2011', N'asantra', CAST(0xA83A0B00 AS Date), CAST(0x483C0B00 AS Date), N'SZC')
GO
SET IDENTITY_INSERT [dbo].[GCAAD0210100] OFF
GO
SET IDENTITY_INSERT [dbo].[GCAAD0210101] ON 

GO
INSERT [dbo].[GCAAD0210101] ([SerialNo], [DocumentID], [UserId], [Date], [EMPLOYID], [DisplayName], [EMail], [Division_Code], [Department_Code], [MobilePhone], [SLA_In_Days], [GoingFrom], [GoingTo], [Subject], [PickupLocation], [DepartureDate], [ReturnDate], [SelectedVehicleID], [TripType], [DriverRequired], [Comments], [CreatedBy], [CreatedDate], [LineManagerEmail], [ApprovalPass], [RejectPass], [LineManagerName], [FinalStatus], [Location], [ReturnHour], [ReturnMinutes], [DepartureHour], [DepartureMinutes]) VALUES (CAST(9 AS Numeric(18, 0)), N'VR-2015-0000001', N'asantra', CAST(0xA03A0B00 AS Date), N'1186', N'Abhiroop Santra', N'asantra@gcaa.gov.ae', N'SUPS', N'ITD', N'---', 0, N'test1', N'test2', N'.', N'.', CAST(0x0000A54500000000 AS DateTime), CAST(0x0000A54500000000 AS DateTime), N'VM-0000001', N'oneway', N'no', N'test', N'asantra', CAST(0x0000A54500000000 AS DateTime), N'jameel@gcaa.gov.ae', N'0.917288389949728', N'0.0746409818877657', N'Mohammed Jameeluddin', N'Final Approval', N'Abu Dhabi', N'9', N'0', N'8', N'0')
GO
INSERT [dbo].[GCAAD0210101] ([SerialNo], [DocumentID], [UserId], [Date], [EMPLOYID], [DisplayName], [EMail], [Division_Code], [Department_Code], [MobilePhone], [SLA_In_Days], [GoingFrom], [GoingTo], [Subject], [PickupLocation], [DepartureDate], [ReturnDate], [SelectedVehicleID], [TripType], [DriverRequired], [Comments], [CreatedBy], [CreatedDate], [LineManagerEmail], [ApprovalPass], [RejectPass], [LineManagerName], [FinalStatus], [Location], [ReturnHour], [ReturnMinutes], [DepartureHour], [DepartureMinutes]) VALUES (CAST(10 AS Numeric(18, 0)), N'VR-2015-0000002', N'asantra', CAST(0xAC3A0B00 AS Date), N'1186', N'Abhiroop Santra', N'asantra@gcaa.gov.ae', N'SUPS', N'ITD', N'---', 0, N'test 1', N'test 2', N'.', N'.', CAST(0x0000A55100000000 AS DateTime), CAST(0x0000A55100000000 AS DateTime), N'VM-0000001', N'roundtrip', N'no', N'test', N'asantra', CAST(0x0000A55100000000 AS DateTime), N'jameel@gcaa.gov.ae', N'0.840393365286474', N'0.650179535918953', N'Mohammed Jameeluddin', N'Reject', N'Abu Dhabi', N'14', N'0', N'8', N'0')
GO
INSERT [dbo].[GCAAD0210101] ([SerialNo], [DocumentID], [UserId], [Date], [EMPLOYID], [DisplayName], [EMail], [Division_Code], [Department_Code], [MobilePhone], [SLA_In_Days], [GoingFrom], [GoingTo], [Subject], [PickupLocation], [DepartureDate], [ReturnDate], [SelectedVehicleID], [TripType], [DriverRequired], [Comments], [CreatedBy], [CreatedDate], [LineManagerEmail], [ApprovalPass], [RejectPass], [LineManagerName], [FinalStatus], [Location], [ReturnHour], [ReturnMinutes], [DepartureHour], [DepartureMinutes]) VALUES (CAST(11 AS Numeric(18, 0)), N'VR-2015-0000003', N'asantra', CAST(0xAF3A0B00 AS Date), N'1186', N'Abhiroop Santra', N'asantra@gcaa.gov.ae', N'SUPS', N'ITD', N'---', 0, N'RAK', N'Dubai', N'.', N'.', CAST(0x0000A55400000000 AS DateTime), CAST(0x0000A55400000000 AS DateTime), N'VM-0000002', N'roundtrip', N'no', N'test', N'asantra', CAST(0x0000A55400000000 AS DateTime), N'jameel@gcaa.gov.ae', N'0.39632696211167', N'0.0451724780933803', N'Mohammed Jameeluddin', N'Submited', N'Dubai', N'16', N'30', N'8', N'0')
GO
SET IDENTITY_INSERT [dbo].[GCAAD0210101] OFF
GO
SET IDENTITY_INSERT [dbo].[GCAAD0700100] ON 

GO
INSERT [dbo].[GCAAD0700100] ([SerialNo], [ServiceType]) VALUES (CAST(1 AS Numeric(18, 0)), N'Regular Maintenance')
GO
INSERT [dbo].[GCAAD0700100] ([SerialNo], [ServiceType]) VALUES (CAST(2 AS Numeric(18, 0)), N'Major Maintenance')
GO
INSERT [dbo].[GCAAD0700100] ([SerialNo], [ServiceType]) VALUES (CAST(3 AS Numeric(18, 0)), N'Accident Fixing')
GO
INSERT [dbo].[GCAAD0700100] ([SerialNo], [ServiceType]) VALUES (CAST(4 AS Numeric(18, 0)), N'New Car Registration')
GO
INSERT [dbo].[GCAAD0700100] ([SerialNo], [ServiceType]) VALUES (CAST(5 AS Numeric(18, 0)), N'Renew Car Registration')
GO
INSERT [dbo].[GCAAD0700100] ([SerialNo], [ServiceType]) VALUES (CAST(6 AS Numeric(18, 0)), N'Request Petrol Card')
GO
INSERT [dbo].[GCAAD0700100] ([SerialNo], [ServiceType]) VALUES (CAST(7 AS Numeric(18, 0)), N'Request Salik Card')
GO
INSERT [dbo].[GCAAD0700100] ([SerialNo], [ServiceType]) VALUES (CAST(8 AS Numeric(18, 0)), N'Renew Petrol Card')
GO
INSERT [dbo].[GCAAD0700100] ([SerialNo], [ServiceType]) VALUES (CAST(9 AS Numeric(18, 0)), N'Renew Salik Card')
GO
INSERT [dbo].[GCAAD0700100] ([SerialNo], [ServiceType]) VALUES (CAST(11 AS Numeric(18, 0)), N'Others')
GO
SET IDENTITY_INSERT [dbo].[GCAAD0700100] OFF
GO
SET IDENTITY_INSERT [dbo].[GCAAD0710100] ON 

GO
INSERT [dbo].[GCAAD0710100] ([SerialNo], [DocumentID], [UserId], [Date], [EMPLOYID], [DisplayName], [EMail], [Division_Code], [Department_Code], [MobilePhone], [SLA_In_Days], [CreatedBy], [CreatedDate], [ServiceDate], [Location], [Remarks], [FinalStatus], [ApprovalPass], [RejectPass], [LineManagerName], [LineManagerEmail]) VALUES (CAST(1 AS Numeric(18, 0)), N'VT-2015-0000001', N'asantra', CAST(0x0000A55100000000 AS DateTime), N'1186', N'Abhiroop Santra', N'asantra@gcaa.gov.ae', N'SUPS', N'ITD', N'---', 0, N'asantra', CAST(0xAC3A0B00 AS Date), CAST(0xAB3A0B00 AS Date), N'Abu Dhabi', N'test 1', N'Submited', N'0.181281524329112', N'0.83935223745152', N'Mohammed Jameeluddin', N'jameel@gcaa.gov.ae')
GO
INSERT [dbo].[GCAAD0710100] ([SerialNo], [DocumentID], [UserId], [Date], [EMPLOYID], [DisplayName], [EMail], [Division_Code], [Department_Code], [MobilePhone], [SLA_In_Days], [CreatedBy], [CreatedDate], [ServiceDate], [Location], [Remarks], [FinalStatus], [ApprovalPass], [RejectPass], [LineManagerName], [LineManagerEmail]) VALUES (CAST(2 AS Numeric(18, 0)), N'VT-2015-0000002', N'asantra', CAST(0x0000A55100000000 AS DateTime), N'1186', N'Abhiroop Santra', N'asantra@gcaa.gov.ae', N'SUPS', N'ITD', N'---', 0, N'asantra', CAST(0xAC3A0B00 AS Date), CAST(0xAB3A0B00 AS Date), N'Abu Dhabi', N'test 1', N'Final Approval', N'0.231775550279662', N'0.0705209677436021', N'Mohammed Jameeluddin', N'jameel@gcaa.gov.ae')
GO
INSERT [dbo].[GCAAD0710100] ([SerialNo], [DocumentID], [UserId], [Date], [EMPLOYID], [DisplayName], [EMail], [Division_Code], [Department_Code], [MobilePhone], [SLA_In_Days], [CreatedBy], [CreatedDate], [ServiceDate], [Location], [Remarks], [FinalStatus], [ApprovalPass], [RejectPass], [LineManagerName], [LineManagerEmail]) VALUES (CAST(3 AS Numeric(18, 0)), N'VT-2015-0000003', N'asantra', CAST(0x0000A55100000000 AS DateTime), N'1186', N'Abhiroop Santra', N'asantra@gcaa.gov.ae', N'SUPS', N'ITD', N'---', 0, N'asantra', CAST(0xAC3A0B00 AS Date), CAST(0xAC3A0B00 AS Date), N'Abu Dhabi', N'test 1', N'Submited', N'0.124730346782473', N'0.786601460905094', N'Mohammed Jameeluddin', N'jameel@gcaa.gov.ae')
GO
INSERT [dbo].[GCAAD0710100] ([SerialNo], [DocumentID], [UserId], [Date], [EMPLOYID], [DisplayName], [EMail], [Division_Code], [Department_Code], [MobilePhone], [SLA_In_Days], [CreatedBy], [CreatedDate], [ServiceDate], [Location], [Remarks], [FinalStatus], [ApprovalPass], [RejectPass], [LineManagerName], [LineManagerEmail]) VALUES (CAST(4 AS Numeric(18, 0)), N'VT-2015-0000004', N'asantra', CAST(0x0000A55100000000 AS DateTime), N'1186', N'Abhiroop Santra', N'asantra@gcaa.gov.ae', N'SUPS', N'ITD', N'---', 0, N'asantra', CAST(0xAC3A0B00 AS Date), CAST(0xAC3A0B00 AS Date), N'Abu Dhabi', N'test 1', NULL, N'0.953695162643536', N'0.799468281119814', N'Mohammed Jameeluddin', N'jameel@gcaa.gov.ae')
GO
INSERT [dbo].[GCAAD0710100] ([SerialNo], [DocumentID], [UserId], [Date], [EMPLOYID], [DisplayName], [EMail], [Division_Code], [Department_Code], [MobilePhone], [SLA_In_Days], [CreatedBy], [CreatedDate], [ServiceDate], [Location], [Remarks], [FinalStatus], [ApprovalPass], [RejectPass], [LineManagerName], [LineManagerEmail]) VALUES (CAST(5 AS Numeric(18, 0)), N'VT-2015-0000005', N'asantra', CAST(0x0000A55100000000 AS DateTime), N'1186', N'Abhiroop Santra', N'asantra@gcaa.gov.ae', N'SUPS', N'ITD', N'---', 0, N'asantra', CAST(0xAC3A0B00 AS Date), CAST(0xAC3A0B00 AS Date), N'Abu Dhabi', N'test 1', N'Final Approval', N'0.795305827537228', N'0.833054282159104', N'Mohammed Jameeluddin', N'jameel@gcaa.gov.ae')
GO
INSERT [dbo].[GCAAD0710100] ([SerialNo], [DocumentID], [UserId], [Date], [EMPLOYID], [DisplayName], [EMail], [Division_Code], [Department_Code], [MobilePhone], [SLA_In_Days], [CreatedBy], [CreatedDate], [ServiceDate], [Location], [Remarks], [FinalStatus], [ApprovalPass], [RejectPass], [LineManagerName], [LineManagerEmail]) VALUES (CAST(6 AS Numeric(18, 0)), N'VT-2015-0000006', N'asantra', CAST(0x0000A55400000000 AS DateTime), N'1186', N'Abhiroop Santra', N'asantra@gcaa.gov.ae', N'SUPS', N'ITD', N'---', 0, N'asantra', CAST(0xAF3A0B00 AS Date), CAST(0xAF3A0B00 AS Date), N'Abu Dhabi', N'test 1', N'Reject', N'0.553250231106416', N'0.361009339038753', N'Mohammed Jameeluddin', N'jameel@gcaa.gov.ae')
GO
SET IDENTITY_INSERT [dbo].[GCAAD0710100] OFF
GO
SET IDENTITY_INSERT [dbo].[GCAAD0710110] ON 

GO
INSERT [dbo].[GCAAD0710110] ([DocumentID], [SerialNo], [UserId], [Division_Code], [Department_Code], [ServiceSerialNo], [ServiceType], [VehicleID], [RegistrationNumber], [Model], [Amount], [KM]) VALUES (N'VT-2015-0000001', CAST(1 AS Numeric(18, 0)), N'asantra', N'SU', N'IT', 1, N'Regular Maintenance', N'VM-0000001', N'ABCD', N'Camry', CAST(100.00 AS Numeric(18, 2)), CAST(100.00 AS Numeric(18, 2)))
GO
INSERT [dbo].[GCAAD0710110] ([DocumentID], [SerialNo], [UserId], [Division_Code], [Department_Code], [ServiceSerialNo], [ServiceType], [VehicleID], [RegistrationNumber], [Model], [Amount], [KM]) VALUES (N'VT-2015-0000001', CAST(6 AS Numeric(18, 0)), N'asantra', N'SU', N'IT', 1, N'Regular Maintenance', N'VM-0000001', N'ABCD', N'Camry', CAST(100.00 AS Numeric(18, 2)), CAST(100.00 AS Numeric(18, 2)))
GO
INSERT [dbo].[GCAAD0710110] ([DocumentID], [SerialNo], [UserId], [Division_Code], [Department_Code], [ServiceSerialNo], [ServiceType], [VehicleID], [RegistrationNumber], [Model], [Amount], [KM]) VALUES (N'VT-2015-0000002', CAST(2 AS Numeric(18, 0)), N'asantra', N'SU', N'IT', 1, N'Regular Maintenance', N'VM-0000001', N'ABCD', N'Camry', CAST(100.00 AS Numeric(18, 2)), CAST(100.00 AS Numeric(18, 2)))
GO
INSERT [dbo].[GCAAD0710110] ([DocumentID], [SerialNo], [UserId], [Division_Code], [Department_Code], [ServiceSerialNo], [ServiceType], [VehicleID], [RegistrationNumber], [Model], [Amount], [KM]) VALUES (N'VT-2015-0000003', CAST(3 AS Numeric(18, 0)), N'asantra', N'SU', N'IT', 5, N'Renew Car Registration', N'VM-0000001', N'ABCD', N'Camry', CAST(500.00 AS Numeric(18, 2)), CAST(50.00 AS Numeric(18, 2)))
GO
INSERT [dbo].[GCAAD0710110] ([DocumentID], [SerialNo], [UserId], [Division_Code], [Department_Code], [ServiceSerialNo], [ServiceType], [VehicleID], [RegistrationNumber], [Model], [Amount], [KM]) VALUES (N'VT-2015-0000004', CAST(4 AS Numeric(18, 0)), N'asantra', N'SU', N'IT', 2, N'Major Maintenance', N'VM-0000001', N'ABCD', N'Camry', CAST(40.00 AS Numeric(18, 2)), CAST(100.00 AS Numeric(18, 2)))
GO
INSERT [dbo].[GCAAD0710110] ([DocumentID], [SerialNo], [UserId], [Division_Code], [Department_Code], [ServiceSerialNo], [ServiceType], [VehicleID], [RegistrationNumber], [Model], [Amount], [KM]) VALUES (N'VT-2015-0000005', CAST(5 AS Numeric(18, 0)), N'asantra', N'SU', N'IT', 3, N'Accident Fixing', N'VM-0000001', N'ABCD', N'Camry', CAST(400.00 AS Numeric(18, 2)), CAST(500.00 AS Numeric(18, 2)))
GO
INSERT [dbo].[GCAAD0710110] ([DocumentID], [SerialNo], [UserId], [Division_Code], [Department_Code], [ServiceSerialNo], [ServiceType], [VehicleID], [RegistrationNumber], [Model], [Amount], [KM]) VALUES (N'VT-2015-0000006', CAST(7 AS Numeric(18, 0)), N'asantra', N'SU', N'IT', 6, N'Request Petrol Card', N'VM-0000002', N'4567', N'Altima', CAST(100.00 AS Numeric(18, 2)), CAST(5000.00 AS Numeric(18, 2)))
GO
SET IDENTITY_INSERT [dbo].[GCAAD0710110] OFF
GO
INSERT [dbo].[GCAWF0010110] ([RoleID], [UserID], [UserName], [EmployeeID], [EmailAddress], [Division], [Department], [Section], [RoleName], [JobTitle], [MobileNo], [RoleDescription], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate]) VALUES (N'VR02', N'asantra', N'Abhiroop Santra', N'1186', N'asantra@gcaa.gov.ae', N'11', N'05', N'.', N'Transport Approvals', N'Transport Officer', N'00971504453960', N'.', N'report1', CAST(0x0000A54400000000 AS DateTime), N'report1', CAST(0x0000A54400000000 AS DateTime))
GO
INSERT [dbo].[GCAWF0010110] ([RoleID], [UserID], [UserName], [EmployeeID], [EmailAddress], [Division], [Department], [Section], [RoleName], [JobTitle], [MobileNo], [RoleDescription], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate]) VALUES (N'VR02', N'smirza', N'Sharjeel Vaseem Mirza', N'1186', N'smirza@gcaa.gov.ae', N'11', N'05', N'.', N'Transport Approvals', N'Transport Officer', N'00971504453960', N'.', N'report1', CAST(0x0000A54400000000 AS DateTime), N'report1', CAST(0x0000A54400000000 AS DateTime))
GO
INSERT [dbo].[GCAWF0010110] ([RoleID], [UserID], [UserName], [EmployeeID], [EmailAddress], [Division], [Department], [Section], [RoleName], [JobTitle], [MobileNo], [RoleDescription], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate]) VALUES (N'VT01', N'asantra', N'Abhiroop Santra', N'1186', N'asantra@gcaa.gov.ae', N'11', N'05', N'.', N'Transport Approvals', N'Transport Officer', N'00971504453960', N'.', N'report1', CAST(0x0000A54400000000 AS DateTime), N'report1', CAST(0x0000A54400000000 AS DateTime))
GO
INSERT [dbo].[GCAWF0010110] ([RoleID], [UserID], [UserName], [EmployeeID], [EmailAddress], [Division], [Department], [Section], [RoleName], [JobTitle], [MobileNo], [RoleDescription], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate]) VALUES (N'VT01', N'smirza', N'Sharjeel Vaseem Mirza', N'1186', N'smirza@gcaa.gov.ae', N'11', N'05', N'.', N'Transport Approvals', N'Transport Officer', N'00971504453960', N'.', N'report1', CAST(0x0000A54400000000 AS DateTime), N'report1', CAST(0x0000A54400000000 AS DateTime))
GO
INSERT [dbo].[GCAWF0010111] ([WorkflowID], [eServiceID], [StepNumber], [UserID], [RoleID], [DefaultValue], [ActionType], [WorkflowName], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate]) VALUES (N'VR0201', N'AD02Transport', 1, NULL, NULL, N'Employee', N'Submit', N'Transport Request', N'report1', CAST(0x0000A54400000000 AS DateTime), N'report1', CAST(0x0000A54400000000 AS DateTime))
GO
INSERT [dbo].[GCAWF0010111] ([WorkflowID], [eServiceID], [StepNumber], [UserID], [RoleID], [DefaultValue], [ActionType], [WorkflowName], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate]) VALUES (N'VR0201', N'AD02Transport', 2, NULL, NULL, N'Line Manager', N'Approval', N'Transport Request', N'report1', CAST(0x0000A54400000000 AS DateTime), N'report1', CAST(0x0000A54400000000 AS DateTime))
GO
INSERT [dbo].[GCAWF0010111] ([WorkflowID], [eServiceID], [StepNumber], [UserID], [RoleID], [DefaultValue], [ActionType], [WorkflowName], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate]) VALUES (N'VR0201', N'AD02Transport', 3, NULL, N'VR02', NULL, N'Final Approval', N'Transport Request', N'report1', CAST(0x0000A54400000000 AS DateTime), N'report1', CAST(0x0000A54400000000 AS DateTime))
GO
INSERT [dbo].[GCAWF0010111] ([WorkflowID], [eServiceID], [StepNumber], [UserID], [RoleID], [DefaultValue], [ActionType], [WorkflowName], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate]) VALUES (N'VT0701', N'AD07VehicleMaintenance', 1, NULL, NULL, N'Employee', N'Submit', N'VehicleMaintenance', N'sa', CAST(0x0000A35500000000 AS DateTime), N'sa', CAST(0x0000A35500000000 AS DateTime))
GO
INSERT [dbo].[GCAWF0010111] ([WorkflowID], [eServiceID], [StepNumber], [UserID], [RoleID], [DefaultValue], [ActionType], [WorkflowName], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate]) VALUES (N'VT0701', N'AD07VehicleMaintenance', 2, NULL, NULL, N'Line Manager', N'Approval', N'VehicleMaintenance', N'sa', CAST(0x0000A35500000000 AS DateTime), N'sa', CAST(0x0000A35500000000 AS DateTime))
GO
INSERT [dbo].[GCAWF0010111] ([WorkflowID], [eServiceID], [StepNumber], [UserID], [RoleID], [DefaultValue], [ActionType], [WorkflowName], [CreatedBy], [CreatedDate], [LastModifiedBy], [LastModifiedDate]) VALUES (N'VT0701', N'AD07VehicleMaintenance', 3, NULL, N'VT01', NULL, N'Final Approval', N'VehicleMaintenance', N'sa', CAST(0x0000A35500000000 AS DateTime), N'sa', CAST(0x0000A35500000000 AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[GCAWF0010120] ON 

GO
INSERT [dbo].[GCAWF0010120] ([SerialNo], [eServiceID], [WorkflowID], [DocumentNumber], [TransactionDate], [StepNumber], [UserID], [RoleID], [OtherID], [ActionBy], [ActionDate], [ActionTime], [Comments], [Action], [AttachmentID], [CreatedDate], [ApprovalPassword], [RejectPassword]) VALUES (CAST(1 AS Numeric(18, 0)), N'AD02Transport', N'VR0201', N'VR-2015-0000001', CAST(0xA03A0B00 AS Date), 1, NULL, NULL, N'Employee', N'asantra', CAST(0x0000A54500C28545 AS DateTime), N'03/11/2015', N'test', N'Submit', N'.', CAST(0x0000A54500C28545 AS DateTime), N'0.9999999', N'0.8888888')
GO
INSERT [dbo].[GCAWF0010120] ([SerialNo], [eServiceID], [WorkflowID], [DocumentNumber], [TransactionDate], [StepNumber], [UserID], [RoleID], [OtherID], [ActionBy], [ActionDate], [ActionTime], [Comments], [Action], [AttachmentID], [CreatedDate], [ApprovalPassword], [RejectPassword]) VALUES (CAST(2 AS Numeric(18, 0)), N'AD02Transport', N'VR0201', N'VR-2015-0000001', CAST(0xA03A0B00 AS Date), 2, NULL, NULL, N'Line Manager', N'mj', CAST(0x0000A54500CEF8C1 AS DateTime), N'03/11/2015', N'test approve', N'Approval', N'.', CAST(0x0000A54500CEF8C1 AS DateTime), N'0.9999999', N'0.8888888')
GO
INSERT [dbo].[GCAWF0010120] ([SerialNo], [eServiceID], [WorkflowID], [DocumentNumber], [TransactionDate], [StepNumber], [UserID], [RoleID], [OtherID], [ActionBy], [ActionDate], [ActionTime], [Comments], [Action], [AttachmentID], [CreatedDate], [ApprovalPassword], [RejectPassword]) VALUES (CAST(3 AS Numeric(18, 0)), N'AD02Transport', N'VR0201', N'VR-2015-0000001', CAST(0xA03A0B00 AS Date), 3, NULL, N'VR02', NULL, N'asantra', CAST(0x0000A54500CFB49F AS DateTime), N'03/11/2015', N'test final approve', N'Final Approval', N'.', CAST(0x0000A54500CFB49F AS DateTime), N'0.9999999', N'0.8888888')
GO
INSERT [dbo].[GCAWF0010120] ([SerialNo], [eServiceID], [WorkflowID], [DocumentNumber], [TransactionDate], [StepNumber], [UserID], [RoleID], [OtherID], [ActionBy], [ActionDate], [ActionTime], [Comments], [Action], [AttachmentID], [CreatedDate], [ApprovalPassword], [RejectPassword]) VALUES (CAST(4 AS Numeric(18, 0)), N'AD07VehicleMaintenance', N'VT0701', N'VT-2015-0000002', CAST(0xAC3A0B00 AS Date), 1, NULL, NULL, N'Employee', N'asantra', CAST(0x0000A55100956EC9 AS DateTime), N'15/11/2015', N'test', N'Submit', N'.', CAST(0x0000A55100956EC9 AS DateTime), N'0.9999999', N'0.8888888')
GO
INSERT [dbo].[GCAWF0010120] ([SerialNo], [eServiceID], [WorkflowID], [DocumentNumber], [TransactionDate], [StepNumber], [UserID], [RoleID], [OtherID], [ActionBy], [ActionDate], [ActionTime], [Comments], [Action], [AttachmentID], [CreatedDate], [ApprovalPassword], [RejectPassword]) VALUES (CAST(5 AS Numeric(18, 0)), N'AD07VehicleMaintenance', N'VT0701', N'VT-2015-0000002', CAST(0xAC3A0B00 AS Date), 2, NULL, NULL, N'Line Manager', N'mj', CAST(0x0000A55100E069EA AS DateTime), N'15/11/2015', N'test', N'Approval', N'.', CAST(0x0000A55100E069EA AS DateTime), N'0.9999999', N'0.8888888')
GO
INSERT [dbo].[GCAWF0010120] ([SerialNo], [eServiceID], [WorkflowID], [DocumentNumber], [TransactionDate], [StepNumber], [UserID], [RoleID], [OtherID], [ActionBy], [ActionDate], [ActionTime], [Comments], [Action], [AttachmentID], [CreatedDate], [ApprovalPassword], [RejectPassword]) VALUES (CAST(6 AS Numeric(18, 0)), N'AD07VehicleMaintenance', N'VT0701', N'VT-2015-0000002', CAST(0xAC3A0B00 AS Date), 3, NULL, N'VT01', NULL, N'asantra', CAST(0x0000A55100E221C4 AS DateTime), N'15/11/2015', N'test', N'Final Approval', N'.', CAST(0x0000A55100E221C4 AS DateTime), N'0.9999999', N'0.8888888')
GO
INSERT [dbo].[GCAWF0010120] ([SerialNo], [eServiceID], [WorkflowID], [DocumentNumber], [TransactionDate], [StepNumber], [UserID], [RoleID], [OtherID], [ActionBy], [ActionDate], [ActionTime], [Comments], [Action], [AttachmentID], [CreatedDate], [ApprovalPassword], [RejectPassword]) VALUES (CAST(7 AS Numeric(18, 0)), N'AD02Transport', N'VR0201', N'VR-2015-0000002', CAST(0xAC3A0B00 AS Date), 1, NULL, NULL, N'Employee', N'asantra', CAST(0x0000A55100E4B33C AS DateTime), N'15/11/2015', N'submit', N'Submit', N'.', CAST(0x0000A55100E4B33C AS DateTime), N'0.9999999', N'0.8888888')
GO
INSERT [dbo].[GCAWF0010120] ([SerialNo], [eServiceID], [WorkflowID], [DocumentNumber], [TransactionDate], [StepNumber], [UserID], [RoleID], [OtherID], [ActionBy], [ActionDate], [ActionTime], [Comments], [Action], [AttachmentID], [CreatedDate], [ApprovalPassword], [RejectPassword]) VALUES (CAST(8 AS Numeric(18, 0)), N'AD02Transport', N'VR0201', N'VR-2015-0000002', CAST(0xAC3A0B00 AS Date), 2, NULL, NULL, N'Line Manager', N'mj', CAST(0x0000A55100E50DEC AS DateTime), N'15/11/2015', N'approve', N'Approval', N'.', CAST(0x0000A55100E50DEC AS DateTime), N'0.9999999', N'0.8888888')
GO
INSERT [dbo].[GCAWF0010120] ([SerialNo], [eServiceID], [WorkflowID], [DocumentNumber], [TransactionDate], [StepNumber], [UserID], [RoleID], [OtherID], [ActionBy], [ActionDate], [ActionTime], [Comments], [Action], [AttachmentID], [CreatedDate], [ApprovalPassword], [RejectPassword]) VALUES (CAST(9 AS Numeric(18, 0)), N'AD02Transport', N'VR0201', N'VR-2015-0000002', CAST(0xAC3A0B00 AS Date), 3, NULL, N'VR02', NULL, N'asantra', CAST(0x0000A55100E55F9F AS DateTime), N'15/11/2015', N'test', N'Reject', N'.', CAST(0x0000A55100E55F9F AS DateTime), N'0.9999999', N'0.8888888')
GO
INSERT [dbo].[GCAWF0010120] ([SerialNo], [eServiceID], [WorkflowID], [DocumentNumber], [TransactionDate], [StepNumber], [UserID], [RoleID], [OtherID], [ActionBy], [ActionDate], [ActionTime], [Comments], [Action], [AttachmentID], [CreatedDate], [ApprovalPassword], [RejectPassword]) VALUES (CAST(10 AS Numeric(18, 0)), N'AD07VehicleMaintenance', N'VT0701', N'VT-2015-0000005', CAST(0xAC3A0B00 AS Date), 1, NULL, NULL, N'Employee', N'asantra', CAST(0x0000A55100E6AC6B AS DateTime), N'15/11/2015', N'submit', N'Submit', N'.', CAST(0x0000A55100E6AC6B AS DateTime), N'0.9999999', N'0.8888888')
GO
INSERT [dbo].[GCAWF0010120] ([SerialNo], [eServiceID], [WorkflowID], [DocumentNumber], [TransactionDate], [StepNumber], [UserID], [RoleID], [OtherID], [ActionBy], [ActionDate], [ActionTime], [Comments], [Action], [AttachmentID], [CreatedDate], [ApprovalPassword], [RejectPassword]) VALUES (CAST(11 AS Numeric(18, 0)), N'AD07VehicleMaintenance', N'VT0701', N'VT-2015-0000005', CAST(0xAC3A0B00 AS Date), 2, NULL, NULL, N'Line Manager', N'mj', CAST(0x0000A55100E77968 AS DateTime), N'15/11/2015', N'approve', N'Approval', N'.', CAST(0x0000A55100E77968 AS DateTime), N'0.9999999', N'0.8888888')
GO
INSERT [dbo].[GCAWF0010120] ([SerialNo], [eServiceID], [WorkflowID], [DocumentNumber], [TransactionDate], [StepNumber], [UserID], [RoleID], [OtherID], [ActionBy], [ActionDate], [ActionTime], [Comments], [Action], [AttachmentID], [CreatedDate], [ApprovalPassword], [RejectPassword]) VALUES (CAST(12 AS Numeric(18, 0)), N'AD07VehicleMaintenance', N'VT0701', N'VT-2015-0000005', CAST(0xAC3A0B00 AS Date), 3, NULL, N'VT01', NULL, N'asantra', CAST(0x0000A55100E7B932 AS DateTime), N'15/11/2015', N'final approve', N'Final Approval', N'.', CAST(0x0000A55100E7B932 AS DateTime), N'0.9999999', N'0.8888888')
GO
INSERT [dbo].[GCAWF0010120] ([SerialNo], [eServiceID], [WorkflowID], [DocumentNumber], [TransactionDate], [StepNumber], [UserID], [RoleID], [OtherID], [ActionBy], [ActionDate], [ActionTime], [Comments], [Action], [AttachmentID], [CreatedDate], [ApprovalPassword], [RejectPassword]) VALUES (CAST(13 AS Numeric(18, 0)), N'AD07VehicleMaintenance', N'VT0701', N'VT-2015-0000006', CAST(0xAF3A0B00 AS Date), 1, NULL, NULL, N'Employee', N'asantra', CAST(0x0000A5540089C0AD AS DateTime), N'18/11/2015', N'test', N'Submit', N'.', CAST(0x0000A5540089C0AD AS DateTime), N'0.9999999', N'0.8888888')
GO
INSERT [dbo].[GCAWF0010120] ([SerialNo], [eServiceID], [WorkflowID], [DocumentNumber], [TransactionDate], [StepNumber], [UserID], [RoleID], [OtherID], [ActionBy], [ActionDate], [ActionTime], [Comments], [Action], [AttachmentID], [CreatedDate], [ApprovalPassword], [RejectPassword]) VALUES (CAST(14 AS Numeric(18, 0)), N'AD07VehicleMaintenance', N'VT0701', N'VT-2015-0000006', CAST(0xAF3A0B00 AS Date), 2, NULL, NULL, N'Line Manager', N'mj', CAST(0x0000A554008BAE6F AS DateTime), N'18/11/2015', N'approve', N'Approval', N'.', CAST(0x0000A554008BAE6F AS DateTime), N'0.9999999', N'0.8888888')
GO
INSERT [dbo].[GCAWF0010120] ([SerialNo], [eServiceID], [WorkflowID], [DocumentNumber], [TransactionDate], [StepNumber], [UserID], [RoleID], [OtherID], [ActionBy], [ActionDate], [ActionTime], [Comments], [Action], [AttachmentID], [CreatedDate], [ApprovalPassword], [RejectPassword]) VALUES (CAST(15 AS Numeric(18, 0)), N'AD07VehicleMaintenance', N'VT0701', N'VT-2015-0000006', CAST(0xAF3A0B00 AS Date), 3, NULL, N'VT01', NULL, N'asantra', CAST(0x0000A554008C3FC4 AS DateTime), N'18/11/2015', N'final reject', N'Reject', N'.', CAST(0x0000A554008C3FC4 AS DateTime), N'0.9999999', N'0.8888888')
GO
INSERT [dbo].[GCAWF0010120] ([SerialNo], [eServiceID], [WorkflowID], [DocumentNumber], [TransactionDate], [StepNumber], [UserID], [RoleID], [OtherID], [ActionBy], [ActionDate], [ActionTime], [Comments], [Action], [AttachmentID], [CreatedDate], [ApprovalPassword], [RejectPassword]) VALUES (CAST(16 AS Numeric(18, 0)), N'AD07VehicleMaintenance', N'VT0701', N'VT-2015-0000001', CAST(0xAF3A0B00 AS Date), 1, NULL, NULL, N'Employee', N'asantra', CAST(0x0000A5540094CAAF AS DateTime), N'18/11/2015', N'', N'Submit', N'.', CAST(0x0000A5540094CAAF AS DateTime), N'0.9999999', N'0.8888888')
GO
INSERT [dbo].[GCAWF0010120] ([SerialNo], [eServiceID], [WorkflowID], [DocumentNumber], [TransactionDate], [StepNumber], [UserID], [RoleID], [OtherID], [ActionBy], [ActionDate], [ActionTime], [Comments], [Action], [AttachmentID], [CreatedDate], [ApprovalPassword], [RejectPassword]) VALUES (CAST(17 AS Numeric(18, 0)), N'AD07VehicleMaintenance', N'VT0701', N'VT-2015-0000003', CAST(0xAF3A0B00 AS Date), 1, NULL, NULL, N'Employee', N'asantra', CAST(0x0000A55400983750 AS DateTime), N'18/11/2015', N'test email', N'Submit', N'.', CAST(0x0000A55400983750 AS DateTime), N'0.9999999', N'0.8888888')
GO
INSERT [dbo].[GCAWF0010120] ([SerialNo], [eServiceID], [WorkflowID], [DocumentNumber], [TransactionDate], [StepNumber], [UserID], [RoleID], [OtherID], [ActionBy], [ActionDate], [ActionTime], [Comments], [Action], [AttachmentID], [CreatedDate], [ApprovalPassword], [RejectPassword]) VALUES (CAST(18 AS Numeric(18, 0)), N'AD02Transport', N'VR0201', N'VR-2015-0000003', CAST(0xAF3A0B00 AS Date), 1, NULL, NULL, N'Employee', N'asantra', CAST(0x0000A55400BBB826 AS DateTime), N'18/11/2015', N'test uat', N'Submit', N'.', CAST(0x0000A55400BBB826 AS DateTime), N'0.9999999', N'0.8888888')
GO
SET IDENTITY_INSERT [dbo].[GCAWF0010120] OFF
GO
ALTER TABLE [dbo].[GCAA_ESS_ActiveDirectoryUsersList] ADD  CONSTRAINT [DF_GCAA_ESS_ActiveDirectoryUsersList_EID]  DEFAULT ((0)) FOR [EID]
GO
ALTER TABLE [dbo].[GCAAD0210101] ADD  CONSTRAINT [DF_GCAAD0210101_FinalStatus]  DEFAULT ('Submited') FOR [GoingTo]
GO
ALTER TABLE [dbo].[GCAAD0210101] ADD  CONSTRAINT [DF_GCAAD0210101_FinalStatus_1]  DEFAULT ('Saved') FOR [FinalStatus]
GO
USE [master]
GO
ALTER DATABASE [GCAAFMS] SET  READ_WRITE 
GO
