
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'Redsea@0987';

DROP DATABASE SCOPED CREDENTIAL MyBlobStorageCredential1;
DROP MASTER KEY;

CREATE DATABASE SCOPED CREDENTIAL MyBlobStorageCredential
WITH IDENTITY = 'SHARED ACCESS SIGNATURE',
SECRET = 'sp=rl&st=2024-10-19T15:53:12Z&se=2024-10-21T23:53:12Z&spr=https&sv=2022-11-02&sr=c&sig=OjwYNeXhycGKtAM8CcFA1u0%2BMYxc8ipHHBpmQwtSYWU%3D';

DROP EXTERNAL DATA SOURCE container1BlobStorage;

CREATE EXTERNAL DATA SOURCE container1BlobStorage
WITH (
    TYPE = HADOOP,
    LOCATION = 'wasbs://container1@storageonem.blob.core.windows.net/',
    CREDENTIAL = MyBlobStorageCredential
);
DROP EXTERNAL DATA SOURCE container2BlobStorage;

CREATE EXTERNAL DATA SOURCE container2BlobStorage
WITH (
    TYPE = HADOOP,
    LOCATION = 'wasbs://container1@storageonem.blob.core.windows.net/',
    CREDENTIAL = MyBlobStorageCredential
);

CREATE EXTERNAL FILE FORMAT FileFormat
WITH (
    FORMAT_TYPE = DELIMITEDTEXT,
    FORMAT_OPTIONS (
        FIELD_TERMINATOR = ',',
        STRING_DELIMITER = '"',
        FIRST_ROW = 2
    )
);

CREATE EXTERNAL TABLE business_report (
    Month VARCHAR(50),
    Year VARCHAR(4),
    TotalOrders VARCHAR(10),
    GrossSales VARCHAR(50),
    Discounts VARCHAR(50),
    Returns VARCHAR(50),
    NetSales VARCHAR(50),
    Shipping VARCHAR(50),
    TotalSales VARCHAR(50),
    CustomerID INT
)
WITH (
    LOCATION = 'business.retailsales2.csv.csv',
    DATA_SOURCE = container1BlobStorage,
    FILE_FORMAT = FileFormat
);

CREATE EXTERNAL TABLE customer_data_external (
    CustomerID INT,
    CustomerName VARCHAR(100),
    CustomerEmail VARCHAR(100),
    Location VARCHAR(100)
)
WITH (
    LOCATION = 'customer_data.csv',
    DATA_SOURCE = container2BlobStorage,
    FILE_FORMAT = FileFormat
);