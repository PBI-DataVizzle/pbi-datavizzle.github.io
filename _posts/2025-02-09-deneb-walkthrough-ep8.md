---
layout: post
title: S1E8 - Number Formatting
date: 2025-02-09 08:00
category: [Season-1, PowerBI, DataViz, Deneb, Vega-Lite, Walkthrough]
author: [A1, A2]
tags: [season1, walkthrough, number-formatting]
summary: Walkthrough
description: Numbers need some attention, and just like DAX dynamic number formatting, in Vega-Lite we have plenty of options🕊️🧙🏼‍♂️✨
image: 
    path: assets/headers/post-headers/ep8.png
    width: 700
    height: 400
    alt: Power BI and Deneb
mermaid: true
published: true
hidden: false

---

![Numbers](assets/img/deneb_walkthrough_images/8a_numbers.webp "Numbers")

> 💌 `PBIX` file available at the end of the article [^fn-pbix]  Enjoy!
{: .prompt-info }

[//]: # Comment first footnoote, can be please anywhere and will display on footer
[^fn-pbix]: PBIX: [Github Repo](https://github.com/PBI-DataVizzle/pbi_content/tree/main/deneb_walkthrough_series){: width="700" height="400" }

---

## Default Number Formatting
In Vega-Lite, numerical fields are not formatted — which means they are a blank canvas for us to paint and shape as our heart desires 🥰

In Vega-Lite, you can apply formatting options in various properties such as **axis labels**, **tooltip content**, and **text marks**. By specifying the format property, you can control how numeric data is displayed, enhancing the readability and effectiveness of your visualizations For this episode we will focus on the latter, but the principles and techniques for formatting axis labels and tooltip content are rather similar.

## D3 Number Formatting Basics:
### Fixed-point notation (f):
Displays numbers as fixed-point notation. The precision specifier indicates the number of digits after the decimal point.

Example: `".2f"` for `123.456` → `"123.46"`

### SI-prefix (s):
Uses SI prefix for the given number and precision, useful for large or small numbers.

Example: `",.3s"` for `123456789` → `"123M"`

### Percentage (%):
Multiplies the number by 100 and displays it in fixed-point notation, followed by a percent sign. The precision specifier indicates the number of digits after the decimal point.

Example: `".1%"` for `0.123` → `"12.3%"`

### Comma-separated (,f):
Formats the number with commas as thousands separators in fixed-point notation.

Example: `",.0f"` for `1234567` → `"1,234,567"`

### Rounded notation (r):
Rounds numbers to significant digits. The precision specifier indicates the number of significant digits.

Example: `",.3r"` for `12345` → `"12,300"`

### Exponential notation (e):
Displays numbers in exponential notation. The precision specifier indicates the number of digits after the decimal point.

Example: `".2e"` for `123.456` → `"1.23e+2"`

### General notation (g):
Uses either fixed-point or exponential notation, whichever is more compact, for the given number and precision.

Example: `"0.2g"` for `123.456` → `"1e+2"`

Please… you don’t need to say it… this isn’t an April Fool’s Trick, this is actually how some people choose to live in the D3 world. 😅 Alas, it’s our world now! 😋

Joking aside, this isn’t about hating, it’s about contemplating 🤓 — D3 number formatting allows for much needed dynamism and precision, but the question is how can we do this ✨better✨?… Come with me!

Now we can do a lot with very little. So let’s start with the basics:

## Thousands Separated 1.0

![Numbers](assets/img/deneb_walkthrough_images/8a_numbers.webp "Numbers")

```jsonc
{
  "title": "Thousands Separator",
  "mark": { "type": "text" },  // text mark
  "encoding": {
    "text": {                  //<-- text encoding channel
      "field": "Value",        // dataset field
      "type": "quantitative",  // quantitative type 
      "format": ","            // standard thousand separator formatting
    },
    "y": {...}
  }
}
```

<br>

## Thousand Separated 2.0

![Numbers](assets/img/deneb_walkthrough_images/8b_numbers.webp "Numbers")

```jsonc
{
  "title": "Zero Decimal (with Thousands Separator)",
  "mark": { "type": "text" },  // text mark
  "encoding": {
    "text": {                  //<-- text encoding channel
      "field": "Value",        // dataset field
      "type": "quantitative",  
      "format": ",.0f"        // zero decimal, comma separated
    },
    "y": {...}
  }
}
```

## SI Prefix (Significant Digits) 1.0

![Numbers](assets/img/deneb_walkthrough_images/8c_numbers.webp "Numbers")

```jsonc
{
  "title": "SI Prefix (3 Significant Digits)",
  "mark": { "type": "text" },  // text mark
  "encoding": {
    "text": {                  //<-- text encoding channel
      "field": "Value",        // dataset field
      "type": "quantitative",  
      "format": ",.3s"        // 3 significant numbers
    },
    "y": {...}
  }
}
```

<br>

## SI Prefix (Significant Digits) 2.0

![Numbers](assets/img/deneb_walkthrough_images/8d_numbers.webp "Numbers")

```jsonc
{
  "title": "SI Prefix (3 Significant Digits)",
  "mark": { "type": "text" },  // text mark
  "encoding": {
    "text": {                  //<-- text encoding channel
      "field": "Value",        // dataset field
      "type": "quantitative",  
      "format": ",.3~s"        // 3 significant numbers, removing trailing zeros
    },
    "y": {...}
  }
}
```

<br>

## Rounded (3 Significant Digits)

![Numbers](assets/img/deneb_walkthrough_images/8e_numbers.webp "Numbers")

```jsonc
{
  "title": "Rounded (3 Significant Digits)",
  "mark": { "type": "text" },  // text mark
  "encoding": {
    "text": {                  //<-- text encoding channel
      "field": "Value",        // dataset field
      "type": "quantitative",  
      "format": ",.3r"        // 3 significant numbers
    },
    "y": {...}
  }
}
```

<br>

This is great. Generally, I tend to use the “,.3~s” or “,.4~s” formatting style. But my preference is to keep the text data labels as compact as possible. Using the above technique only gets you so far, soon you stumble across the oddity of the “billions” number denomination, which looks like this:

![Numbers](assets/img/deneb_walkthrough_images/8e2_numbers.webp "Numbers")


Yep. We’ve entered the weird world of D3 formatting. I don’t know anyone who understands that “G” means “billions”. So we have to get advanced, we need more flexibility.

### Custom Number Formatting
Again, we have several techniques we can employ. I’ll use a DAX-inspired method and a Vega-Lite one.

### DAX-Inspired Number Format
This method was revealed thanks to Kurt Buhler 🧙🏽‍♂️🪄. In his recent [sqlbi article](https://www.sqlbi.com/articles/improving-data-labels-with-format-strings/) he demonstrated a really tidy technique using scientific / exponential notation.

![Numbers](assets/img/deneb_walkthrough_images/8e1_numbers.webp "Numbers")


To replicate this in Vega-Lite, we create a combination calculate transformations alongside some params:

```jsonc
"params": [
    {
      "name": "_quintillions",
      "value": "#,0,,,,,,.#"
    },
    {
      "name": "_quadrillions",
      "value": "#,0,,,,,.#"
    },
    {
      "name": "_trillions",
      "value": "#,0,,,,.#"
    },
    {
      "name": "_billions",
      "value": "#,0,,,.#"
    },
    {
      "name": "_millions",
      "value": "#,0,,.#"
    },
    {
      "name": "_thousands",
      "value": "#,0,.#"
    }
  ],
"transform": [
  {
    "calculate": "datum.Value >= 5e17 ? pbiFormat(datum.Value,_quintillions) + 'Q'  
    : datum.Value >= 5e14 ? pbiFormat(datum.Value,_quadrillions) + 'q'  
    : datum.Value >= 5e11 ? pbiFormat(datum.Value,_trillions) + 'T' 
    : datum.Value >= 5e8 ? pbiFormat(datum.Value,_billions) + 'B' 
    : datum.Value >= 5e5 ? pbiFormat(datum.Value,_millions) + 'M' 
    : datum.Value >= 1e3 ? pbiFormat(datum.Value,_thousands) + 'K' 
    : pbiFormat(datum.Value,'#,#')",
      "as": "pbiformat_v0"
  }
]
```

<br>

```jsonc
"encoding": {
  "text": {
    "field": "pbiformat_v0",
    "type": "nominal"  //<-- nominal because formatted numbers are text strings
  },
  "y": {...}
}
```

<br>

Not as tidy as DAX’s `SWITCH()` statement, but it’s pretty good!

How does it look? Champion!

![Numbers](assets/img/deneb_walkthrough_images/8g_numbers.webp "Numbers")
![Numbers](assets/img/deneb_walkthrough_images/8g_numbers.gif "Numbers")

<br>


Crisp, Clean, Concise. Let’s try another way

## DAX-Inspired Vega-Lite Adaptation Method:

```jsonc
"transform": [
  {
    "calculate": "datum.Value >= 1e18 ? 
      format((datum.Value / 1e18),',.1f') + 'Q'  
    : datum.Value >= 1e16 ? format((datum.Value / 1e15), ',.1~f') + 'q'  
    : datum.Value >= 1e12 ? format((datum.Value / 1e12), ',.1~f') + 'T' 
    : datum.Value >= 1e9 ? format((datum.Value / 1e9), ',.1~f') + 'B' 
    : datum.Value >= 1e6 ? format((datum.Value / 1e6), ',.1~f') + 'M' 
    : datum.Value >= 1e3 ? format((datum.Value / 1e3), ',.1~f') + 'K' 
    : format(datum.Value, ',.1~f')",
    "as": "format_v0"
  }
]
```

<br>

```jsonc
"encoding": {
  "text": {
    "field": "format_v0",
    "type": "nominal"  //<-- nominal because formatted numbers are text strings
  },
  "y": {...}
}
```
![Numbers](assets/img/deneb_walkthrough_images/8h_numbers.webp "Numbers")

## Hidden Option in Deneb’s pbiFormat expression
There is also a bonus 3rd parameter for dynamic pbiFormat expression (thanks Daniel Marsh-Patrick!) — read more information on this gem at the [Deneb Website](https://deneb-viz.github.io/formatting#pbiformat-expression-function-full-implementation-details). The 3rd parameter allows you to set a list of options, mainly the Value to format, the Precison (number of decimals) and the Culture (en-US; en-GB).

```jsonc
//** layout is not JSON compliant - displayed for effect **//

{
      "calculate": "pbiFormat( datum.Value, '#,0', 
                   {
                     value: datum.Value, 
                     precision: 1, 
                     cultureSelector: 'en-GB'
                    })", 
      "as": "pbiFormat_Options"
 }
 ```

 <br>

 ```jsonc
 //** JSON proper **//

{
      "calculate": "pbiFormat( datum.Value, '#,0', { value: datum.Value, precision: 1, cultureSelector: 'en-GB'})", 
      "as": "pbiFormat_Options"
 }
 ```

And the final result, putting it into practice?


![Numbers](assets/img/deneb_walkthrough_images/8i_numbers.webp "Numbers")



---


<p style="text-align: center;">. . .</p>

##### <center> <i class="fa-solid fa-heart-circle-check fa-2x"></i>&nbsp; En Fin, Serafin </center>
Thank you for staying to the end of the article… I hope you find it useful 😊. See you soon, and remember... #StayQueryous!🧙‍♂️🪄  

## <center><i class="fa-solid fa-download" aria-hidden="true"></i>&nbsp;  PBIX 💾 </center>
🔗 Repo: [Github Repo PBIX Treasure Trove - Deneb Walkthrough Series](https://github.com/PBI-DataVizzle/Deneb/tree/main/Medium-VegaLite-Series)  

[!["Buy Me A Coffee"](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png)](https://buymeacoffee.com/pbidatavizzle) 

<p style="text-align: center;">. . .</p> 
<!-- <br> -->

---
## Footnotes