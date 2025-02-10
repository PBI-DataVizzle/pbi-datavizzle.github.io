---
layout: post
title: S1E8 - Number Formatting
date: 2025-02-9 08:00
category: [PowerBI, DataViz, Deneb, Vega-Lite]
author: [A1, A2]
tags: [walkthrough]
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

![Styling Marks](assets/img/deneb_walkthrough_images/3a_styles.webp "Styling Marks")

> 💌 `PBIX` file available at the end of the article [^fn-pbix]  Enjoy!
{: .prompt-info }

[//]: # Comment first footnoote, can be please anywhere and will display on footer
[^fn-pbix]: PBIX: [Github Repo](https://github.com/PBI-DataVizzle/Deneb/tree/main/Medium-VegaLite-Series){: width="700" height="400" }

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