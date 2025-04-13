---
layout: post
title: S2E5 - Filter Methods
date: 2025-04-12 13:53
category: [Season-2, Charts, DataViz, Deneb, Vega-Lite, Walkthrough]
author: [A1, A2]
tags: [season#, walkthrough]
summary: Walkthrough
description: Demystify Vega-Lite Examples in this step-by-step rebuild 🕊️🧙🏼‍♂️✨
image: 
    path: assets/headers/post-headers/s2e5/header.png
    width: 600
    height: 300
    alt: Filter Methods
mermaid: true
published: true
hidden: false
---



> 💌 `PBIX` file available at the end of the article [^fn-pbix]  Enjoy!
{: .prompt-info }

[//]: # Comment first footnoote, can be please anywhere and will display on footer
[^fn-pbix]: PBIX: [Repo - Walkthrough Series](https://github.com/PBI-DataVizzle/pbi_content/tree/main/my_deneb_showcases/deneb_walkthrough_series){: width="700" height="400" }

---

## <i class="fa-solid fa-hat-wizard fa-2x" style="color: blueviolet"></i>&ensp;Intro
Welcome to **Season 2** of the Vega-Lite walkthrough series. In this season, we will go step-by-step through many of the Vega-Lite Examples - learning loads of techniques and tips along the way. Enjoy and welcome! 🕊️

<br>

---

## <i class="fa-solid fa-database fa-2x" style="color: limegreen"></i>&ensp;Data
All data used in this series can be found in the Vega github repo: &emsp; <br> [<i class="fas fa-database"></i>&ensp; Official Vega & Vega-Lite Data Source Repo &ensp; <i class="fas fa-external-link-alt"></i>](https://github.com/vega/vega/tree/main/docs/data)

Today's dataset is provided by yours truly (see PowerQuery custom function *`fn_generate_randomised_data`*)

<p style="text-align: center;">. . .</p> 

## <i class="fa-solid fa-brain fa-2x" style="color: hotpink"></i>&ensp;Concept
In this episode we will focus on filtering methods.

> **Important Note: Viewing Vega/Vega-Lite Outputs** <br>
> When opening in the Vega Online Editor, remember to delete the raw path url before /data/. Examples: <br>
> 
> **Github pages:** <br> • "data": {"url": "https://raw.githubusercontent.com/vega/vega/refs/heads/main/docs/data/stocks.csv"} <br>
> 
> **For online editor:** <br> • "data": {"url": "data/stocks.csv} <br>
> 
> **For PowerBI:** <br> • "data": {"name": "dataset"} <br>
{: .prompt-warning }


***

<p style="text-align: center;">. . .</p> 

## <i class="fa-solid fa-person-digging fa-2x" style="color: darkorange"></i>&ensp;Build
What we are building here is the strong foundations of understanding the many ways in which we can filter marks and datasets directly in our Vega-Lite spec.

The concept is fairly simple, and we can reuse and reapply the following methods anywhere and everywhere within your Deneb/Vega/Vega-Lite visuals.

### Step 1: How do we filter?
Filters can be applied with a the [Filter Transform](https://vega.github.io/vega-lite/docs/filter.html) block. You'll be familiar with this from our previous tutorials. Here is our example below:

```jsonc

{
  "data": {"name": "dataset"},

  /* transform block */
  //-----------------
  "transform": [{
      "filter": {
        "field": "year_num", //-- field to filter on
        "equal": 2025 //-- numerical value
      }}],
  //-----------------
  
  "layer": [{"mark": {...}}],
  "encoding": {...}
}
```

For a wordy explanation, we could say:
> The `Filter Transform` must have a filter `property`. This property is described as the *predicate* and it determines the manner or method in which we perform the *filter operation*.  A predicate is a *logical condition* that returns a Boolean value (true or false).

In other words:
> A predicate is a test that says whether each row of data should be kept or removed.

So we can indeed think of it like this:  
• **Keep only** the rows **where this condition** is **true**  
• **Keep only** the rows of data where the values in the `[category]` field equal "Laptops"

```jsonc
{
  "data": {"name": "dataset"},
  /* transform block */
  //-----------------
  "transform": [{               // transform 
      "filter": {               //-- filter operation
        "field": "category",    //-- field to filter on
        "equal": "Laptops"      //-- predicate
      }}],
  //-----------------
  "layer": [{"mark": {...}}],
  "encoding": {...}
}
```
<br>


### Step 2: Filter Transformation Types

#### Predicate Types

There are four types of predicate:
1. [Field Predicate](https://vega.github.io/vega-lite/docs/predicate.html#field-predicate)
2. [Vega Expression](https://vega.github.io/vega/docs/expressions/)
3. [Selection Predicate](https://vega.github.io/vega-lite/docs/predicate.html#selection-predicate)
4. [A logical composition](https://vega.github.io/vega-lite/docs/predicate.html#composition) (a combination of the above with ( `and` , `or` , `not` ) )


#### Field Predicates:
Observe the table below. We have the field predicate and their descriptions:

| **predicate** | **description**                            |
| :-----------: | :----------------------------------------- |
|    `equal`    | equal to                                   |
|     `lt`      | less than                                  |
|     `lte`     | less than or equal to                      |
|     `gt`      | greater than                               |
|     `gte`     | greater than or equal to                   |
|    `range`    | an array between minimum and maximum value |
|    `oneOf`    | behaves like the `IN` operator             |


<br>

##### example with `and` & `gte` & `lte`: 

```jsonc
"transform": [{
   "filter": { 
    "and": [
	  { "field": "year_num", "gte": 2026 },
      { "field": "year_num", "lte": 2027 }
	 ]
  }}]
```

<br>

##### example with `oneOf`:

```jsonc
"transform": [{
   "filter": {
     "field": "subcategory",
     "oneOf": [
       "Smartphones",
       "Mini PCs",
       "Gaming PCs"
     ]
  }}]
```

<br>


#### Vega-Expressions
An alternative method, and one which I find preferabble for both ease and aesthetic reasons, is to use [Vega Expressions](https://vega.github.io/vega/docs/expressions/). They feel more like your DAX, M-code, SQL-type statements, albeit with a little JSON syntax sprinkles.

##### Field Predicate vs Vega-Expression
Let's make a comparison between the two filter methods...

###### Field Predicate:
```jsonc
// predicate method
"transform": [{
"filter": { 
  "and": [
    { "field": "year_num", "gte": 2026 },
    { "field": "year_num", "lte": 2027 }
  ]
}}]
```

--- VS ---

###### Vega-Expression:
```jsonc
// vega-expression method
"transform": [
    {
      "filter": "datum.year_num >= 2026 & datum.year_num <= 2027"
    }
  ]
```

What do you think? There is a slickness to the Vega-Expression method that is most satisying, isn't there? 🥲

<br>

### Step 3: Operators
You will notice that Vega Expressions allow us to use Operators. Operators are a kind of shorthand and make complex code easier to read and write.


#### 🔧 Logical Operators (for combining conditions)

| Operator                    | Meaning | Example           |
| --------------------------- | ------- | ----------------- |
| `&&`                        | AND     | `a > 5 && b < 10` |
| <code> &#124; &#124;</code> | OR      | `a < 5            |  | b == 20` |
| `!`                         | NOT     | `!(a == 'PCs')`   |

<br>

#### 🔍 Comparison Operators (for evaluating values)

| Operator | Meaning               | Example                    |
| -------- | --------------------- | -------------------------- |
| `==`     | Equals                | `datum.type == 'A'`        |
| `!=`     | Not equal             | `datum.status != 'closed'` |
| `>`      | Greater than          | `datum.value > 100`        |
| `>=`     | Greater than or equal | `datum.score >= 80`        |
| `<`      | Less than             | `datum.age < 18`           |
| `<=`     | Less than or equal    | `datum.size <= 50`         |

<br>

#### 🧮 Arithmetic Operators (for math in expressions)

| Operator | Meaning            | Example                       |
| -------- | ------------------ | ----------------------------- |
| `+`      | Addition           | `datum.x + datum.y`           |
| `-`      | Subtraction        | `datum.sales - datum.returns` |
| `*`      | Multiplication     | `datum.price * 1.1`           |
| `/`      | Division           | `datum.total / datum.count`   |
| `%`      | Modulo (remainder) | `datum.id % 2 == 0`           |

<br>

#### 🧠 Ternary Operator (if-else shorthand)

| Syntax                                   | Meaning                                       |
| ---------------------------------------- | --------------------------------------------- |
| `condition ? valueIfTrue : valueIfFalse` | Example: `datum.score > 50 ? 'Pass' : 'Fail'` |

<br>


Applying this to real-world examples, we can see how easily these can be applied:


```jsonc

  "transform": [

    // multiplication (*)
    {"calculate": "(datum.price * datum.quantity)", "as": "fx_multiply"},

    // division (/)
    {"calculate": "(datum.price / datum.quantity)", "as": "fx_divide"},

    // modulo (%)
    {"calculate": "(datum.price % datum.quantity)", "as": "fx_modulo"},

    // greater than (>)
    {"calculate": "(datum.fx_modulo >1)", "as": "fx_greater_than"},

    // equals (==)
    {"calculate": "(datum.category_name == 'PCs')", "as": "fx_equals"},

    // not equal (!=)
    {"calculate": "(datum.category_name != 'PCs')", "as": "fx_not_equals"},

    // OR (||)
    {"calculate": "(datum.category_name == 'PCs' || datum.category_name == 'Laptops')", "as": "fx_or"},

    // IF-ELSE - AND (&&)
    {"calculate": "(datum.price >= 1000 && datum.quantity > 2 ? 'pricey' : null)", "as": "fx_condition"}

  ]

```

![Operators](assets/img/deneb_walkthrough_images/s2e5/operators.png "Operators")



***


<p style="text-align: center;">. . .</p>

##### <center> <i class="fa-solid fa-heart-circle-check fa-2x"></i>&nbsp; En Fin, Serafin </center>
Thank you for staying to the end of the article… I hope you find it useful 😊. See you soon, and remember... #StayQueryous!🧙‍♂️🪄  

## <center><i class="fa-solid fa-download" aria-hidden="true"></i>&nbsp;  PBIX 💾 </center>
🔗 Repo: [Github Repo PBIX Treasure Trove](https://github.com/PBI-DataVizzle/pbi_content/tree/main/my_deneb_showcases)  

[!["Buy Me A Coffee"](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png)](https://buymeacoffee.com/pbidatavizzle) 

<p style="text-align: center;">. . .</p> 
<!-- <br> -->

---
## Footnotes