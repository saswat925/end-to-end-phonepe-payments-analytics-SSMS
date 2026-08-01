CREATE OR ALTER PROCEDURE usp_Run_Payments_ETL
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

    -----------------------------------------------------
    -- STEP 1 : Load USERS_CLEAN
    -----------------------------------------------------

    TRUNCATE TABLE USERS_CLEAN;

    INSERT INTO USERS_CLEAN
    (
        USER_ID,
        USER_NAME,
        AGE,
        JOIN_DATE
    )
    SELECT
        User_ID,
        LTRIM(RTRIM(Name)),
        TRY_CAST(Age AS INT),
        TRY_CONVERT(DATE, REPLACE(Join_Date, CHAR(13), ''))
    FROM STG_USERS;

    PRINT 'USERS_CLEAN Loaded';

    -----------------------------------------------------
    -- STEP 2 : Load TRANSACTIONS_CLEAN
    -----------------------------------------------------

    TRUNCATE TABLE TRANSACTIONS_CLEAN;

    INSERT INTO TRANSACTIONS_CLEAN
    (
        TRANSACTION_ID,
        AMOUNT,
        USER_ID,
        SERVICE,
        SERVICE_TYPE,
        PAYMENT_STATUS,
        REASON,
        TRANSACTION_DATE
    )
    SELECT
        LTRIM(RTRIM(Transaction_ID)),
        TRY_CAST(Amount AS DECIMAL(18,2)),
        LTRIM(RTRIM(User_ID)),
        LTRIM(RTRIM(Service)),
        LTRIM(RTRIM(Service_Type)),
        LTRIM(RTRIM(Payment_Status)),
        LTRIM(RTRIM(Reason)),
        TRY_CONVERT(DATE, REPLACE(Transaction_Date, CHAR(13), ''),105)
    FROM STG_TRANSACTIONS;

    PRINT 'TRANSACTIONS_CLEAN Loaded';

    -----------------------------------------------------
    -- STEP 3 : Load DIM_USERS
    -----------------------------------------------------

    DELETE FROM FACT_TRANSACTIONS;
    DELETE FROM DIM_USERS;

    DBCC CHECKIDENT ('DIM_USERS', RESEED, 0);

    INSERT INTO DIM_USERS
    (
        USER_ID,
        USER_NAME,
        AGE,
        JOIN_DATE
    )
    SELECT
        USER_ID,
        USER_NAME,
        AGE,
        JOIN_DATE
    FROM USERS_CLEAN;

    PRINT 'DIM_USERS Loaded';

    -----------------------------------------------------
    -- STEP 4 : Load DIM_DATE
    -----------------------------------------------------

    DELETE FROM DIM_DATE;

    INSERT INTO DIM_DATE
    (
        DATE_KEY,
        FULL_DATE,
        YEAR,
        QUARTER,
        MONTH_NO,
        MONTH_NAME,
        DAY_NO
    )
    SELECT DISTINCT
        CAST(FORMAT(TRANSACTION_DATE,'yyyyMMdd') AS INT),
        TRANSACTION_DATE,
        YEAR(TRANSACTION_DATE),
        DATEPART(QUARTER,TRANSACTION_DATE),
        MONTH(TRANSACTION_DATE),
        DATENAME(MONTH,TRANSACTION_DATE),
        DAY(TRANSACTION_DATE)
    FROM TRANSACTIONS_CLEAN;

    PRINT 'DIM_DATE Loaded';

    -----------------------------------------------------
    -- STEP 5 : Load FACT_TRANSACTIONS
    -----------------------------------------------------

    INSERT INTO FACT_TRANSACTIONS
    (
        TRANSACTION_ID,
        USER_KEY,
        DATE_KEY,
        AMOUNT,
        SERVICE,
        SERVICE_TYPE,
        PAYMENT_STATUS,
        REASON
    )
    SELECT
        T.TRANSACTION_ID,
        D.USER_KEY,
        CAST(FORMAT(T.TRANSACTION_DATE,'yyyyMMdd') AS INT),
        T.AMOUNT,
        T.SERVICE,
        T.SERVICE_TYPE,
        T.PAYMENT_STATUS,
        T.REASON
    FROM TRANSACTIONS_CLEAN T
    INNER JOIN DIM_USERS D
        ON T.USER_ID = D.USER_ID;

    PRINT 'FACT_TRANSACTIONS Loaded';

    -----------------------------------------------------
    -- STEP 6 : Validation
    -----------------------------------------------------

    PRINT '----------------------------------------';
    PRINT 'ETL Completed Successfully';
    PRINT '----------------------------------------';

    SELECT
        (SELECT COUNT(*) FROM USERS_CLEAN) AS USERS_CLEAN,
        (SELECT COUNT(*) FROM TRANSACTIONS_CLEAN) AS TRANSACTIONS_CLEAN,
        (SELECT COUNT(*) FROM DIM_USERS) AS DIM_USERS,
        (SELECT COUNT(*) FROM DIM_DATE) AS DIM_DATE,
        (SELECT COUNT(*) FROM FACT_TRANSACTIONS) AS FACT_TRANSACTIONS;

        COMMIT TRANSACTION;

    END TRY

    BEGIN CATCH

        ROLLBACK TRANSACTION;

        PRINT 'ETL Failed';

        PRINT ERROR_MESSAGE();

    END CATCH
END;
GO
--Run
EXEC usp_Run_Payments_ETL;
