---
layout: post
title: PBI/D/VL | EP02 - Mark Types
date: 2025-02-04 00:00
category: [PowerBI, DataViz, Deneb, Vega-Lite]
author: [A1, A2]
tags: [powerbi, dataviz, deneb, vega-lite, data visualisation, power bi walkthrough]
summary: Walkthrough
description: Marks are the core building blocks for chart development. In this article we will take a little dip into the different mark types available🕊️🧙🏼‍♂️✨
image: 
    path: assets/headers/deneb-ep02.svg
    width: 700
    height: 400
    alt: Power BI and Deneb
mermaid: true
published: false
hidden: false

---

> 💌 `PBIX` file available at the end of the article [^fn-pbix]  Enjoy!
{: .prompt-info }

[//]: # Comment first footnoote, can be please anywhere and will display on footer
[^fn-pbix]: PBIX: [Github Repo](https://github.com/PBI-DataVizzle/Deneb/tree/main/Medium-VegaLite-Series)

---

# Mark Types

## Introduction
There is a lot to learn in Vega-Lite, and it can be difficult to know where to start. In Episode 1 on my Vega-Lite series we looked at encoding a bar mark, but there many other mark types we can use to start creating some magic! 💫


## Mark Types
There are two broad categories of marks, primitive marks and composite marks. Primitive marks represent the simplest forms of visual elements — i.e. the geometric shape. Composite marks are higher-level abstractions which incorporate multiple primitive marks. They are usually tailored for specific types of visualisation. For the most part, primitive marks will be more than enough for our needs.

Coding our marks is super easy — take a look at the general format below. You have two parts: the mark object, and the mark type attribute:

```jsonc

{
  "data": {"name": "dataset"},
  "encoding": {
    "y": {...},
    "x": {...}
  },
  "layer": [
    {
      "mark": {          // open mark object
        "type": "bar"      // assign mark type
      }                  // close mark object
    }
  ]
}

```

And for illustrative purposes, a more comprehensive list:

```jsonc

{
  "data": {"name": "dataset"},
  "encoding": {
    "y": {...},
    "x": {...}
  },
  "layer": [
    {
      "mark": {
        // here are a list of primitive mark types
        "type": "bar",    
        "type": "area",
        "type": "line",
        "type": "rect",
        "type": "trail",
        "type": "arc",
        "type": "rule",
        "type": "circle",
        "type": "square",
        "type": "point",
        "type": "tick",
        "type": "geoshape",
        
        // a list of composite marks (complex, multi-layered marks)
        "type": "errorband",
        "type": "errorbar",
        "type": "boxplot"
      }
    }
  ]
}

```

---
<br>

<p style="text-align: center;">. . .</p>

<br>

## From Marks to Charts
Now we know how to change marks shapes, we can go one step further by translating these shapes into charts — the form of data which can be visually analysed and understood. Let’s take a look at 5 such examples:

### Column Chart
[//]: # PLACE IMAGE HERE

![images](assets/img/deneb_walkthrough_images/2a_marks.webp)
```jsonc
// note: the code is abbreviated and annotated for effect
{
  "data": {"name": "dataset"},
  "encoding": {
    "y": { "field": "AC" },          // axis on the left
    "x": { "field": "EndOfMonth" }   // axis on the bottom
  },
  "layer": [
    {
      "mark": {
        "type": "bar",
        "color": "#0000FF"
      }
    }
  ]
}

```

## Subtitle2
text

It can at first be overwhelming, particularly when viewing the Vega-Lite examples gallery

![images](assets/img/deneb_walkthrough_images/1_getting_started.webp)


<br>

<br>

<p style="text-align: center;">. . .</p>

<br>

## En Fin, Serafin
This is the end of the article — but only the beginning of the series! 😋 Thank you for sticking with me and stay tuned for the next Deneb/Vega-Lite episode soon! 🧙‍♂️

<br>

## ⏬ PBIX  ⏏️
🔗 Repo: [Github Repo PBIX Treasure Trove - Deneb Walkthrough Series](https://github.com/PBI-DataVizzle/Deneb/tree/main/Medium-VegaLite-Series)

***

<br>



<p style="text-align: center;">. . .</p>
<h6 style="text-align: center;"> ☕ un cafelito porfa ☕ </h6>
<h6 style="text-align: center;"> Oh, I almost affogato tell you 😏 My body is 90% coffee ☕ <br> the rest is classified 🤓 🤖 </h6>

[!["Buy Me A Coffee"](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png)](https://buymeacoffee.com/pbidatavizzle)  

[//]: # <div style="text-align: center;"> <a href="https://buymeacoffee.com/pbidatavizzle"> <img src="https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png" alt="Buy Me A Coffee"> </a></div>

<p style="text-align: center;">. . .</p>

***

---
## Footnotes