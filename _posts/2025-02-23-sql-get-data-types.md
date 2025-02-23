---
layout: post
title: SQL Snippets - Copy-pasteable CREATE TABLE() snippet
date: 2025-02-16 15:06
category: [SQL, Snippets]
author: [A1, A2]
tags: [SQL, snippets]
summary: Snippets
description: SQL Snippets 🕊️🧙🏼‍♂️✨
image: 
    path: assets/headers/post-headers/sql_snippets/sql_snippets1.png
    width: 600
    height: 300
    alt: Bar Chart (VL)
mermaid: true
published: true
hidden: false
---

## <i class="fa-solid fa-hat-wizard fa-2x" style="color: blueviolet"></i>&ensp;Intro
I come from a PowerBI / PowerQuery background, so I'm not your traditional SQL DBA, I'm a completely self-taught n00b - so take any of my SQL-related content with a heavy pinch of salt 🧂 🕊️

As I meander through the many SQL challenges that I encounter, I hope to share some helpful tips, techniques and discoveries along the way that will make development that much more satisfying.

<br>

---

## <i class="fa-solid fa-database fa-2x" style="color: limegreen"></i>&ensp;Data
This example uses the AdventureWorks 2022 sample database: &emsp; <br> [<i class="fas fa-database"></i>&ensp; AdventureWorks Sample DB &ensp; <i class="fas fa-external-link-alt"></i>](https://learn.microsoft.com/en-us/sql/samples/adventureworks-install-configure?view=sql-server-ver16&tabs=ssms)

---

## <i class="fa-solid fa-person-digging fa-2x" style="color: darkorange"></i>&ensp;Build
When creating a data pipeline of sorts, we may wish create tables: Landing (LND), Staging (STG), or feature/enterprise (ENT). What I found quite tedious and time consuming was having to physically type the `CREATE TABLE ()` script, declaring each column and then declare the data types for each of those columns as well as the character limit for text columns, one-by-one. This is time-consuming and onerous, particularly for wider tables.

Originally, I would copy and pate the last of columns into Excel, then build a formula to add leading-commas and it just felt like a rather clunky process.

So I devised a SQL script that will obtain the column names and the current data types and produce a table output with leading commas which can then be copy-and-pasted directly into SQL and boom 🔥! One-click and go. This solution harnesses SQL's system `INFORMATION_SHEMA.COLUMNS` table

### Step 1: View Column Information
The script to view your existing Table/Column schema looks like this:

```sql
SELECT * FROM INFORMATION_SCHEMA.COLUMNS -- look at all tables in current server/db
WHERE -- filter for
TABLE_SCHEMA = 'Sales'  -- table schema = 'Sales' (normally 'dbo')
AND TABLE_NAME = 'Customer' -- table name = 'Customer'

```

This produces the following result:

![INFORMATION_SCHEMA.COLUMNS](assets/img/sql_snippet_imgs/sql_snippet1.png "INFORMATION_SCHEMA.COLUMNS")

<br>

As you can see, there is some useful information. We have some juicy columns such as: 
- COLUMN_NAME
- DATA_TYPE
- CHARACTER_MAXIMUM_LENGTH
- NUMERIC_PRECISION

These are all very useful, but we can't extract and utilise this info in any automated fashion, without manually piecing the puzzle together in some fashion. In the next step, we'll reshape this info


### Step 2: Reshape INFORMATION_SCHEMA output
Let's run a query that transforms and combines these columns:

```sql

WITH info_schema_columns_data AS (
    SELECT 
        COLUMN_NAME AS column_name, 
        DATA_TYPE AS old_data_type,
        CASE 
            WHEN DATA_TYPE IN ('varchar', 'text') THEN 'nvarchar'
            WHEN DATA_TYPE = 'char' THEN 'nchar'
            WHEN DATA_TYPE IN ('bit', 'int', 'bigint', 'smallint', 'tinyint') THEN 'int'
            WHEN DATA_TYPE IN ('decimal', 'numeric', 'float', 'real', 'money', 'smallmoney') THEN 'decimal'
            ELSE DATA_TYPE
        END AS simplified_data_type, 
        NUMERIC_PRECISION AS numeric_precision,
        NUMERIC_SCALE AS numeric_scale,
        CHARACTER_MAXIMUM_LENGTH AS text_character_length,
        CASE 
            WHEN DATA_TYPE IN ('bit', 'int', 'bigint', 'smallint', 'tinyint') THEN NULL  -- No precision/scale for whole numbers
            WHEN DATA_TYPE IN ('decimal', 'numeric', 'float', 'real', 'money', 'smallmoney') -- decimal precision maintained
            THEN CAST(CONCAT(NUMERIC_PRECISION, ',', NUMERIC_SCALE) AS NVARCHAR) 
            ELSE CAST(CHARACTER_MAXIMUM_LENGTH AS NVARCHAR) 
        END AS character_length,
        IS_NULLABLE AS is_nullable,
        ROW_NUMBER() OVER (ORDER BY ORDINAL_POSITION) AS rn
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_SCHEMA = 'Sales'  
    AND TABLE_NAME = 'vStoreWithDemographics'
),
cte_prepared_output AS (
    SELECT 
        column_name,
        old_data_type,
        simplified_data_type,
        text_character_length,
        character_length,
        -- Generate a final character length representation
        CASE
            WHEN character_length IS NULL THEN NULL
            WHEN text_character_length = -1 THEN '(MAX)'
            WHEN character_length IS NOT NULL THEN CONCAT('(', character_length, ')')
            ELSE CONCAT( '(', 
                    CASE 
                        WHEN text_character_length BETWEEN 9 AND 10 THEN 10				-- round to 10
                        WHEN text_character_length BETWEEN 11 AND 15 THEN 15			-- round 11-15
                        WHEN text_character_length BETWEEN 16 AND 20 THEN 20			-- round 16-20
                        WHEN text_character_length BETWEEN 90 AND 100 THEN 100			-- round 90-100
                        WHEN text_character_length BETWEEN 101 AND 200 THEN 200			-- round 101-200
                        WHEN text_character_length BETWEEN 201 AND 255 THEN 255			-- round 201-255
                        ELSE text_character_length
                    END
            , ')' )
        END AS final_character_length, 
        is_nullable,
        rn
    FROM info_schema_columns_data
)
SELECT 
    column_name,
    old_data_type,
    simplified_data_type,
    text_character_length,
    character_length,
    final_character_length,
    is_nullable,

    -- Generating column names for INSERT INTO statement
    CASE 
        WHEN rn = 1 THEN column_name
        ELSE ', ' + column_name
    END AS insert_table_script,

    -- Same as above, but wrapped in square brackets for SQL Server compatibility
    CASE 
        WHEN rn = 1 THEN CONCAT('[', column_name, ']')
        ELSE ', ' + CONCAT('[', column_name, ']')
    END AS insert_table_script_v2,

    -- Generating CREATE TABLE script
    CASE 
        WHEN rn = 1 THEN CONCAT_WS('  ', column_name , UPPER(simplified_data_type) , COALESCE(final_character_length, ''))
        ELSE ', ' + CONCAT_WS('  ', column_name , UPPER(simplified_data_type) , COALESCE(final_character_length, ''))
    END AS create_table_script,

    -- Same as above but with square brackets for SQL Server compatibility
    CASE 
        WHEN rn = 1 THEN CONCAT_WS('  ', CONCAT('[', column_name, ']') , UPPER(simplified_data_type) , COALESCE(final_character_length, ''))
        ELSE ', ' + CONCAT_WS('  ', CONCAT('[', column_name, ']') , UPPER(simplified_data_type) , COALESCE(final_character_length, ''))
    END AS create_table_script_v2
FROM cte_prepared_output;


```

![transformed column info](assets/img/sql_snippet_imgs/sql_snippet1b.png "transformed column info")


<br>

You can see in these highlight sections, we now have ready-made columns which allow us to copy-paste into a new script, saving valuable time.


![create table](assets/img/sql_snippet_imgs/sql_snippet1c.png "create table")&emsp;
![insert into](assets/img/sql_snippet_imgs/sql_snippet1d.png "insert into")


{::options parse_block_html="true" /}

<p float="left">

![full script](assets/img/sql_snippet_imgs/sql_snippet1e.png "full script")&emsp;

![success](assets/img/sql_snippet_imgs/sql_snippet1f.png "success")

</p>
{::options parse_block_html="false" /}

<br>

### Step 3: Run your script 🤓

```sql



-- paste
CREATE TABLE dbo.NewTable (
BusinessEntityID  INT  
, Name  NVARCHAR  (50)
, AnnualSales  DECIMAL  (19,4)
, AnnualRevenue  DECIMAL  (19,4)
, BankName  NVARCHAR  (50)
, BusinessType  NVARCHAR  (5)
, YearOpened  INT  
, Specialty  NVARCHAR  (50)
, SquareFeet  INT  
, Brands  NVARCHAR  (30)
, Internet  NVARCHAR  (30)
, NumberEmployees  INT  
)

INSERT INTO dbo.NewTable
(
[BusinessEntityID]
, [Name]
, [AnnualSales]
, [AnnualRevenue]
, [BankName]
, [BusinessType]
, [YearOpened]
, [Specialty]
, [SquareFeet]
, [Brands]
, [Internet]
, [NumberEmployees]
)
(
SELECT
[BusinessEntityID]
, [Name]
, [AnnualSales]
, [AnnualRevenue]
, [BankName]
, [BusinessType]
, [YearOpened]
, [Specialty]
, [SquareFeet]
, [Brands]
, [Internet]
, [NumberEmployees]
FROM [AW_2022].[Sales].[vStoreWithDemographics]
)



;

```

<p style="text-align: center;">. . .</p>

##### <center> <i class="fa-solid fa-heart-circle-check fa-2x"></i>&nbsp; En Fin, Serafin </center>
Thank you for staying to the end of the article… I hope you find it useful 😊. See you soon, and remember... #StayQueryous!🧙‍♂️🪄  

---