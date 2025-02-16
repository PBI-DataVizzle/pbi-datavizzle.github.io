---
layout: post
title: S1E7 - Expressions & Conditional Formatting (pt2)
date: 2025-02-09 05:00
category: [Season-1, PowerBI, DataViz, Deneb, Vega-Lite, Walkthrough]
author: [A1, A2]
tags: [season1, walkthrough, conditional-formatting, expressions]
summary: Walkthrough
description: Marks are the core building blocks for chart development. In this article we will take a little dip into the different mark types available🕊️🧙🏼‍♂️✨
image: 
    path: assets/headers/post-headers/ep7.png
    width: 700
    height: 400
    alt: Power BI and Deneb
mermaid: true
published: true
hidden: false

---

![Styling Marks](assets/img/deneb_walkthrough_images/3a_styles.webp "Styling Marks")

> 💌 `PBIX` file available at the end of the article [^fn-pbix]  Enjoy!
{: .prompt-info }

[//]: # Comment first footnoote, can be please anywhere and will display on footer
[^fn-pbix]: PBIX: [Repo - Walkthrough Series](https://github.com/PBI-DataVizzle/pbi_content/tree/main/my_deneb_showcases/deneb_walkthrough_series){: width="700" height="400" }

---
## <i class="fa-solid fa-hat-wizard fa-2x" style="color: slateblue"></i>&ensp;Picking Up Where We Left Off
If you haven’t been scared off by [Part 1](https://pbi-datavizzle.github.io/posts/deneb-walkthrough-ep6/) 😅then I promise in Part 2, you will be cruising…easy, breezy. Power Up! 🌈

![formatting](assets/img/deneb_walkthrough_images/7a_expressions.gif "formatting")

<br>


## 1. Conditional Formatting via the Encoding channel
Previously, we achieved conditional formatting using a combination of Calculate Transforms and Expressions. In this section, we will apply the same logic, using the [Condition](https://vega.github.io/vega-lite/docs/condition.html) property in the mark’s Encoding channel.

As with all learning journeys, there is always an element of pain, and that pain my friends is ***`documentation`***. It hurts, but it most importantly it can definitely help. How to explain the Condition property? What does Vega-Lite say?

![formatting](assets/img/deneb_walkthrough_images/7b_expression.webp "formatting")
![formatting](assets/img/deneb_walkthrough_images/7c_expression.webp "formatting")

In other words, the Conditional property is also flexible, and there are several ways in which you can achieve conditional formatting using this method. Let’s take a look at those using the PBIX file at the end of the article.

Let’s try some malpractice first, so we can better understand the VL behaviours. Then we’ll end with a refined example to finish. Below is the skeleton structure

### Mark Expression Method
```jsonc
// Expression Method
{                                    //<-- open mark property
      "mark": {
        "type": "bar",
        "width": {"band": 0.65},
        "xOffset": 0,

///*----------------------------------------------------------------
//Format the mark's colour property with an expression
//----------------------------------------------------------------*/
        "color": {
          "expr": "datum._isYTD == 1 ? _barColourACT : _barColourFRC"
        },
//----------------------------------------------------------------
        "stroke": "black",
        "strokeWidth": 1
      }
    }                              //<-- close mark property
//* 
//• "?" = if the logical test true then return subsequent value...
//• ":" = otherwise return subsequent value
//• eg: "logical test ? return value : return another Value"

// plain english: if the value in the [isYTD] field equals 1
// then return _barColourACT otherwise return _barColourFRC */
```

<br>

#### Encoding Condition Method 1
```jsonc
// Encoding Condition Method
  "encoding": {    //<-- open encoding properties
    "x": {...},
    "y": {...},
    "color": {        //<<-- open colour properties
      "condition": [          //<-- open conditions
        {
          "test": {
            "field": "_isYTD",
            "equal": 1
          },
          "value": {
            "expr": "_barColourACT"
          }
        }
      ],                     //<-- close condition
      "value": {"expr": "_barColourFRC"}  //<-- value to return if condition not met
    }                //<<-- close colour properties
  }              //<-- close encoding properties
//* 
//• "condition" = the property which will contain our logical test...
//• "test" = the elements that comprise our test
//• "field" = the field we are testing against
//• "equal": this is the predicate (equal, lessthan, morethan etc)
//• "value": the result to return if the test is met/not met

//plain english: if the value in the [isYTD] field equals 1
//then return _barColourACT otherwise return _barColourFRC */
```

<br>

#### Encoding Condition Method 2
```jsonc
// Encoding Condition Method
  "encoding": {    //<-- open encoding properties
    "x": {...},
    "y": {...},
    "color": {        //<<-- open colour properties
      "condition": [      //<-- open conditions
        {
          "test": "datum._isYTD == 1",
          "value": {
            "expr": "_barColourACT"
          }
        }
      ],                  //<-- close condition
      "value": {"expr": "_barColourFRC"}  //<-- value to return if condition not met
    }                 //<<-- close colour properties
  }               //<-- close encoding properties
/* 
//• "condition" = the property which will contain our logical test...
//• "test" = the logical test (similar to the mark expression method)
//• "value": the result to return if the test is met/not met

// plain english: if the value in the [isYTD] field equals 1
// then return _barColourACT otherwise return _barColourFRC */
```

<br>


Now to test it in practice. Let’s simply add the color condition at the end of our encoding channel in the `Spec` :

```jsonc
{
  "data": {"name": "dataset"},
  "params": [],
  "transform": [
    {
      "calculate": "datetime( now()) ",
      "as": "_Today"
    },
    {
      "calculate": "datum['Date'] <= datum._Today ? 1 : 0 ",
      "as": "_isYTD"
    }
  ],
  "layer": [
    {
      "mark": {
        "type": "bar",
        "width": {"band": 0.65},
        "xOffset": 0,
//*----------------------------------------------------------------
//Format the mark's colour property with an expression
//NOTE: This is superfluous to requirements now, but we'll test
//which propery has a higher precedence
//----------------------------------------------------------------*/
        "color": {
          "expr": "datum._isYTD == 1 ? _barColourACT : _barColourFRC"
        },
        "stroke": "black",
        "strokeWidth": 1
      }
    }
  ],
  "encoding": {
    "x": {
      "field": "Date",
      "type": "ordinal",
      "timeUnit": "yearmonth",
      "axis": {
        "title": null,
        "format": "%b-%y"
      }
    },
    "y": {
      "field": "AC",
      "type": "quantitative",
      "axis": {
        "format": "£0,,.#M",
        "formatType": "pbiFormat"
      }
    },
///*----------------------------------------------------------------
//Format the encoding colour property with a condition (method 2)
//----------------------------------------------------------------*/
    "color": {
      "condition": [
        {
          "test": "datum._isYTD == 1",
          "value": {
            "expr": "_barColourACT"
          }
        }
      ],
      "value": {"expr": "_barColourFRC"}
    }
//---------------------------------------------------------------
  }
}

```

![formatting](assets/img/deneb_walkthrough_images/7d_expressions.webp "formatting")

<br>

Fantastic! Next, out of curiosity, I want to see which method (Mark Expression or Encoding Condition) has a higher precedence: i.e. which one has a higher priority?

To test this, let’s just change the colour of the Actual bar in the encoding condition.


```jsonc
{
  "data": {"name": "dataset"},
  "params": [],
  "transform": [...],
  "layer": [
    {
      "mark": {
        "type": "bar",
        "width": {"band": 0.65},
        "xOffset": 0,
//*----------------------------------------------------------------
//Format the mark's colour property with an expression
//NOTE: This is superfluous to requirements now, but we'll test
//which propery has a higher precedence
//----------------------------------------------------------------*/
        "color": {
          "expr": "datum._isYTD == 1 ? _barColourACT : _barColourFRC"
        },
        "stroke": "black",
        "strokeWidth": 1
      }
    }
  ],
  "encoding": {,
    "x": {...},
    "y": {...},
//*----------------------------------------------------------------
//Format the encoding colour property with a condition (method 2)
//----------------------------------------------------------------*/
    "color": {
      "condition": [
        {
          "test": "datum._isYTD == 1",
          "value": {
            "expr": "'yellow'" //<--- make sure to use single quotes 'yellow'
          }
        }
      ],
      "value": {"expr": "_barColourFRC"}
    }
//---------------------------------------------------------------
  }
}
```

<br>

And what do we find…

![formatting](assets/img/deneb_walkthrough_images/7e_expressions.webp "formatting")


Exactly… the `encoding color` properties have a higher precedence than the mark color properties, it effectively overwrites any formatting we’ve applied to the `mark color` property. So, we can remove the mark color properties from our Vega-Lite code. See below:

```jsonc
{
  "data": {"name": "dataset"},
  "params": [],
  "transform": [...],
  "layer": [
    {
      "mark": {
        "type": "bar",
        "width": {"band": 0.65},
        "xOffset": 0,
//        "color": {...}     //<-- we've deleted this section
    }
  ],
  "encoding": {...},
    "y": {...},
///*----------------------------------------------------------------
// Format the encoding colour property with a condition (method 2)
//----------------------------------------------------------------*/
    "color": {
      "condition": [
        {
          "test": "datum._isYTD == 1",
          "value": {
            "expr": "'yellow'" //<--- make sure to use single quotes 'yellow'
          }
        }
      ],
      "value": {"expr": "_barColourFRC"}
    }
//---------------------------------------------------------------
  }
}
```

<br>

Now run that neater code and….behold!

Congratulations, you now have COMPLETE control over your Deneb chart formatting!

![formatting](assets/img/deneb_walkthrough_images/7e_expressions.gif "formatting")

---


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