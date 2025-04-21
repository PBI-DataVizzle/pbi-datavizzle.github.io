---
layout: post
title: Power Query - Optimised Calendar/Dates Table
date: 2025-04-21 06:14
category: [PowerQuery]
author: [A1, A2]
tags: [powerquery, walkthrough]
summary: Walkthrough
description: Enjoy a newly refurbished calendar table dimension with business calendar and fiscal calendar date fields 🕊️🧙🏼‍♂️✨
image: 
    path: assets/headers/post-headers/pq_snippets/pq_calendar_table.png
    width: 600
    height: 300
    alt: IMAGE_DESCRIPTION
mermaid: true
published: true
hidden: false
---


> 💌 `PBIX` file available at the end of the article [^fn-pbix]  Enjoy!
{: .prompt-info }

[//]: # Comment first footnoote, can be please anywhere and will display on footer
[^fn-pbix]: PBIX: [Calendar Dates Table Template](https://github.com/PBI-DataVizzle/pbi_content/tree/main/power_query_showcases/Calendar%20Table){: width="700" height="400" }

---

## <i class="fa-solid fa-hat-wizard fa-2x" style="color: blueviolet"></i>&ensp;Intro
The calendar / dates table is easily **THE** most important dimension table in any semantic model. Most of you will have came across Melissa de Korte's famous Extended Date Table no doubt. My date table builds upon Melissa's great work even further additional fields and a dynamic 3-in-1 dates table: 
- Calendar Year
- Business Year
- Financial Year

Column selection is dynamic, so Business & Financial Year fields are only selected if Business / Fiscal Start Month is input in the function parameters.

<br>

---


<p style="text-align: center;">. . .</p> 

## <i class="fa-solid fa-person-digging fa-2x" style="color: darkorange"></i>&ensp;Build
You can begin debugging the code directly the PBIX[^fn-pbix] linked in the footnotes. In the next section, we'll take a look at some important code snippets.


<p style="text-align: center;">. . .</p> 

## <i class="fa-solid fa-file-code fa-2x" style="color: deepskyblue" ></i>&ensp;Code
In this Code segment, we will look some (but not all) of the most important transformations and useful patterns used to calculate the requisite calendar and fiscal year fields. We will use a combination of M-code and pseudo-code so we can better understand some of the underlying mechanics behind the calendar table values:

### Calendar Table Transformation Steps

#### Parameters
```swift
p_start_date = #date(p_year_start,01,01) // #date( 2024 , 01 , 01 )
p_end_date = #date(p_year_end,12,31) // #date( 2027 , 12, 31 )
v_day_count = Duration.Days(Duration.From(p_end_date -  p_start_date)) + 1
// Duration.Days ( Duration.From (#date( 2027 , 12, 31 ) - #date( 2024 , 01 , 01 )  )) + 1
```

#### Contiguous List of Dates
```swift
v_source = List.Dates(p_start_date, v_day_count, Duration.From(1))
```

| List       |
| ---------- |
| 01/01/2024 |
| 02/01/2024 |
| 03/01/2024 |
| 04/01/2024 |
| ...etc     |
| 30/12/2027 |
| 31/12/2027 |

<br>

#### Generate Date Serial Number
We can derive a date serial number which can act as an alternative key.

```swift
v_date_serial = Table.AddColumn(
    v_to_table, 
    "date_serial_number", 
    each Duration.Days([date_id] - #date(1900, 1, 1))
    , Int64.Type
)

```

| date_id    | date_serial_number |
| ---------- | ------------------ |
| 01/01/2024 | 45290              |
| 02/01/2024 | 45291              |
| 03/01/2024 | 45292              |
| 04/01/2024 | 45293              |
| ...etc     | ...etc             |
| 30/12/2027 | 46019              |
| 31/12/2027 | 46020              |

<br>

#### Generate Year-specific Columns
The following examples are a brilliant use case for `record` fields. This is one of the first optimisations where instead of creating 8 separate steps for 8 separate columns, we can create 8 columns in 1 step. Here's how we do it, note the square brackets on `each [...]`. Every variable inside the square brackets is a new column:


##### psuedo-code
```swift

current_step = Table.AddColumn(
    previous_step,
    "column_name",
each [
    column1 = formula1,
    column2 = formula2,
    column3 = formula3
],
type [
    column1 = Text.Type, // column data type
    column2 = Date.Type, // column data type
    column3 = Int64.Type // column data type
]

)
```


##### real-code
```swift

v_rec_years = Table.AddColumn(
  v_date_serial, 
  "rec_year", 
  each [
    // get calendar year
    calendar_year        = Date.Year([date_id]), 

    // get current year: Date.Year( #date( 2025, 04 , 21 ) )
    current_year         = Date.Year(v_current_date), 

    // get current year offset: 2024 - 2025
    calendar_year_offset = calendar_year - current_year, 

    // check if the calendar year is complete
    is_year_complete     = if Date.EndOfYear([date_id]) < Date.EndOfYear(v_current_date) then 1 else 0, 

    // check if date is completed month to date (cmtd)
    is_cmtd              = if ([date_id] <= Date.AddDays(Date.StartOfMonth(Date.From(v_current_date)), - 1)) then 1 else 0, 

    //check if date is year-to-date (ytd)
    is_ytd               = if ([date_id] <= Date.From(v_current_date)) then 1 else 0, 

    // check if date is forecast/future (frc)
    is_frc               = if ([date_id] > Date.From(v_current_date)) then 1 else 0, 

    // check if date is in the previous year (py)
    is_py                = if calendar_year_offset = - 1 then 1 else 0
  ], 
  type [
    calendar_year = Int64.Type, 
    calendar_year_offset = Int64.Type, 
    is_year_complete = Int64.Type, 
    is_cmtd = Int64.Type, 
    is_ytd = Int64.Type, 
    is_frc = Int64.Type, 
    is_py = Int64.Type
  ]
)

```

| date_id    | date_serial_number | calendar_year_offset | is_year_complete | is_cmtd | is_ytd |
| ---------- | ------------------ | -------------------- | ---------------- | ------- | ------ |
| 29/03/2025 | 45743              | 0                    | 0                | 1       | 1      |
| 30/03/2025 | 45744              | 0                    | 0                | 1       | 1      |
| 31/03/2025 | 45745              | 0                    | 0                | 1       | 1      |
| 01/04/2025 | 45746              | 0                    | 0                | 0       | 1      |
| 02/04/2025 | 45747              | 0                    | 0                | 0       | 1      |
| 03/04/2025 | 45748              | 0                    | 0                | 0       | 1      |


<br>

#### Generate Fiscal Calendar Fields
Next we will demonstrate how we can derive the fiscal year columns. This method can be reused and reapplied to the business column fields. The variable names will become the columns 

```swift

v_rec_fiscal_fields = = Table.AddColumn(
    v_exp_rec_business_fields, 
    "BusinessRecords", 
    each [
    fiscal_year_num = (                     // fiscal year number
        if [month_num] >= v_fy_start_month 
        and v_fy_start_month > 1 
        then [calendar_year] + 1 
        else [calendar_year]
    ), 
    fiscal_year_offset = (                  // calendar year minus
        if [month_num] >= v_fy_start_month 
        then ([calendar_year] + 1) 
        else [calendar_year]
        )   
        - // minus
        (                                   // current year
        if v_current_month_num >= v_fy_start_month 
        then (Date.Year(v_current_date) + 1) 
        else Date.Year(v_current_date)
    ),
    fiscal_year = // eg: 24/25
        Text.End(Text.From(fiscal_year_num -1), 2) // Text.End(2024, 2)
        & "/" & 
        Text.End(Text.From(fiscal_year_num ), 2), // Text.End(2025, 2)

    // "FY" & Text.End(2025,2) = "FY25"
    fiscal_year_short = "FY" & Text.End(Text.From(fiscal_year_num), 2), 

    // field to enable default "Current Fiscal Year" slicer selection
    fiscal_year_selection = if fiscal_year_offset = 0 then "Current Fiscal Year" else fiscal_year,

    // flag current fiscal year
    is_current_fy = if fiscal_year_offset = 0 then 1 else 0,

    // flag previous fiscal year
    is_previous_fy = if fiscal_year_offset = -1 then 1 else 0,

    // fiscal quarter number = Number.RoundUp( Date.Month ( Date.AddMonths( 8 - (4-1) )) / 3 )
    fiscal_quarter_num = Number.RoundUp( Date.Month( Date.AddMonths( [date_id], - (v_fy_start_month -1) )) / 3 ) ,

    // fiscal quarter label - eg: "FQ4"
    fiscal_quarter = "FQ" & Text.From( fiscal_quarter_num ) ,

    // fiscal quarter - eg: "FQ4 FY25"
    fiscal_year_quarter = fiscal_quarter & " " & fiscal_year, 

    // fiscal quarter numbumer - eg: (2024 * 100) + 04 = 202404
    fiscal_year_quarter_num = (fiscal_year_num * 100) + fiscal_quarter_num, 

    // fiscal period number - eg: FY Start April, Fiscal Number = April = 1, May = 2 etc
    fiscal_period_num = 
        if [month_num] >= v_fy_start_month and v_fy_start_month > 1 
        then  [month_num] - (v_fy_start_month - 1)
        else if [month_num] >= v_fy_start_month and v_fy_start_month = 1 
        then  [month_num]
        else  [month_num] + (12 - v_fy_start_month + 1), 

    // fiscal period - eg: FP01 24/25
    fiscal_period = "FP" & Text.PadStart(Text.From(fiscal_period_num), 2, "0") & " " & fiscal_year  , 

    // fiscal year month num = (2024 * 100 ) + 04
    fiscal_year_month_num = ((fiscal_year_num * 100) + fiscal_period_num), 

    // fiscal month name short = "Apr"
    fiscal_month_name_short = [month_name_short],

    // fiscal month year = "Apr-24"
    fiscal_month_year = [month_year],


    fiscal_year_first_day = #date(Date.Year(p_start_date) - 1, v_fy_start_month, 1), 
    
    // fiscal year start
    fiscal_year_start = 
        if [month_num] >= v_fy_start_month 
        then #date([calendar_year], v_fy_start_month, 1) 
        else #date([calendar_year] - 1, v_fy_start_month, 1),

    // fiscal year end
    fiscal_year_end = 
        if [month_num] >= v_fy_start_month 
        then Date.AddDays(#date([calendar_year] +1, v_fy_start_month, 1), -1) 
        else Date.AddDays(#date([calendar_year] + 0, v_fy_start_month, 1),-1),

    // fiscal week start
    fiscal_week_start = Date.StartOfWeek(fiscal_year_first_day, v_week_start),

    // fiscal week end
    current_week_start = Date.StartOfWeek([date_id], v_week_start),

    // fiscal week difference
    week_diff = (Duration.Days(current_week_start - fiscal_week_start) / 7),

    // fiscal week number
    fiscal_week_num = Number.RoundDown(week_diff) + 1,

    // fiscal week
    fiscal_week = "FW" & Text.PadStart( Text.From(fiscal_week_num), 2, "0") & " " & fiscal_year,

    // fiscal week logic
    fiscal_week_logic = v_fiscal_week_logic,

    // fiscal week logic update
    fiscal_week_logic_updated = if fiscal_week_logic then Table.ReplaceValue(fiscal_year_first_day, each fiscal_week_num, each if v_fy_start_month =1 then [week_num] else fiscal_week_num, Replacer.ReplaceValue, {"fiscal_week_num"}) else fiscal_year_first_day,

    // fiscal year week number = if v_fiscal_week_logic = true then [week_year_num] else (2024 * 100) + 12
    fiscal_year_week_num = if v_fiscal_week_logic then [week_year_num] else (fiscal_year_num * 100) + fiscal_week_num

    ], 

    // declare column data types inside the record
    type [
    fiscal_year_num = number, 
    fiscal_year_offset = Int64.Type, 
    fiscal_year = text, 
    fiscal_year_short = text,
    fiscal_year_selection = text,

    is_current_fy = Int64.Type,
    is_previous_fy = Int64.Type,

    fiscal_quarter_num = number,
    fiscal_quarter = text,
    fiscal_year_quarter_num = number, 
    fiscal_year_quarter = text, 

    fiscal_period_num = number, 
    fiscal_period = text, 
    fiscal_month_name_short = text,
    fiscal_year_month_num = number, 
    fiscal_month_year = text,

    fiscal_year_first_day = date,
    fiscal_year_start = date,
    fiscal_year_end = date ,
    fiscal_week_num = number,
    fiscal_week = text,
    fiscal_week_logic = logical,
    fiscal_week_logic_updated = date,
    fiscal_year_week_num = number
    ]
)

```

##### example of fiscal column/record values 

| field name                | field value |
| ------------------------- | ----------- |
| fiscal_year_num           | 2025        |
| fiscal_year_offset        | -1          |
| fiscal_year               | 24/25       |
| fiscal_year_short         | FY25        |
| fiscal_year_selection     | 24/25       |
| is_current_fy             | 0           |
| is_previous_fy            | 1           |
| fiscal_quarter_num        | 4           |
| fiscal_quarter            | FQ4         |
| fiscal_year_quarter       | FQ4 24/25   |
| fiscal_year_quarter_num   | 202504      |
| fiscal_period_num         | 12          |
| fiscal_period             | FP12 24/25  |
| fiscal_year_month_num     | 202512      |
| fiscal_month_name_short   | Mar         |
| fiscal_month_year         | Mar-25      |
| fiscal_year_first_day     | 01/04/2023  |
| fiscal_year_start         | 01/04/2024  |
| fiscal_year_end           | 31/03/2025  |
| fiscal_week_start         | 27/03/2023  |
| current_week_start        | 24/03/2025  |
| week_diff                 | 104         |
| fsical_week_num           | 105         |
| fiscal_week               | FW105 24/25 |
| fiscal_week_logic         | FALSE       |
| fiscal_week_logic_updated | 01/04/2023  |
| fiscal_year_week_num      | 202605      |



<br>

<p style="text-align: center;">. . .</p> 

I hope you can see how much more efficient and versatile it is to use records to derivce multiple columns in one step. There are many other little treats and techniques inside the PBIX[^fn-pbix].

![Function Meta](assets/headers/post-headers/pq_snippets/function_metadata.png)

***


<p style="text-align: center;">. . .</p>

##### <center> <i class="fa-solid fa-heart-circle-check fa-2x"></i>&nbsp; En Fin, Serafin </center>
Thank you for staying to the end of the article… I hope you find it useful 😊. See you soon, and remember... #StayQueryous!🧙‍♂️🪄  

## <center><i class="fa-solid fa-download" aria-hidden="true"></i>&nbsp;  PBIX 💾 </center>
🔗 Repo: [Power Query Showcases](https://github.com/PBI-DataVizzle/pbi_content/tree/main/power_query_showcases) <br>
🔗 Repo: [Github Repo PBIX Treasure Trove](https://github.com/PBI-DataVizzle/pbi_content/tree/main/my_deneb_showcases)  

[!["Buy Me A Coffee"](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png)](https://buymeacoffee.com/pbidatavizzle) 

<p style="text-align: center;">. . .</p> 
<!-- <br> -->

---
## Footnotes
