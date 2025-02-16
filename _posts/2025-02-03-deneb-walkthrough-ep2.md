---
layout: post
title: S1E2 - Mark Types
date: 2025-02-03 00:00
category: [Season-1, PowerBI, Deneb, Vega-Lite, Walkthrough]
author: [A1, A2]
tags: [season1, walkthrough, marks]
summary: Walkthrough
description: Marks are the core building blocks for chart development. In this article we will take a little dip into the different mark types available🕊️🧙🏼‍♂️✨
image: 
    path: assets/headers/post-headers/ep2.png #"C:/pbi_repos/github_page/pbi_datavizzle_blog/pbi-datavizzle.github.io/assets/headers/post-headers/ep1.png"
    width: 700
    # height: 400
    alt: Power BI and Deneb
mermaid: true
published: true
hidden: false

---

> 💌 `PBIX` file available at the end of the article [^fn-pbix]  Enjoy!
{: .prompt-info }

[//]: # Comment first footnoote, can be please anywhere and will display on footer
[^fn-pbix]: PBIX: [Github Repo](https://github.com/PBI-DataVizzle/Deneb/tree/main/Medium-VegaLite-Series){: width="700" height="400" }

---

[//]: # PLACE IMAGE HERE

![column chart](assets/img/deneb_walkthrough_images/2a_marks.webp "column chart")

<br> 

# Mark Types

## Introduction
There is a lot to learn in Vega-Lite, and it can be difficult to know where to start. In [Episode 1](https://pbi-datavizzle.github.io/posts/deneb-walkthrough-ep1/) on my Vega-Lite series we looked at encoding a bar mark, but there many other mark types we can use to start creating some magic! 💫


## Mark Types
There are two broad categories of marks, primitive marks and composite marks. Primitive marks represent the simplest forms of visual elements — i.e. **the geometric shape**. Composite marks are higher-level abstractions which incorporate multiple primitive marks. They are usually tailored for specific types of visualisation. For the most part, primitive marks will be more than enough for our needs.

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
Now we know how to change marks shapes, we can go one step further by translating these shapes into **charts** — the form of data which can be visually analysed and understood. Let’s take a look at 5 such examples:

### Column Chart
[//]: # PLACE IMAGE HERE

![column chart](assets/img/deneb_walkthrough_images/2b_marks.webp "column chart")

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

### Bar Chart
[//]: # PLACE IMAGE HERE

![bar chart](assets/img/deneb_walkthrough_images/2c_marks.webp "bar chart")

```jsonc

// note: the code is abbreviated and annotated for effect
{
  "data": {"name": "dataset"},
  "encoding": {
    "x": { "field": "AC" },          // now switched axis on the bottom
    "y": { "field": "EndOfMonth" }   // and axis on the left
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

<br>

### Line Chart
[//]: # PLACE IMAGE HERE

![bar chart](assets/img/deneb_walkthrough_images/2d_marks.webp "bar chart")

```jsonc

// note: the code is abbreviated and annotated for effect
{
  "data": {"name": "dataset"},
  "encoding": {
    "y": { "field": "AC" },          // now switched axis on the bottom
    "x": { "field": "EndOfMonth" }   // and axis on the left
  },
  "layer": [
    {
      "mark": {
        "type": "line",
        "point": "true",
        "color": "#0000FF"
      }
    }
  ]
}

```

<br>

### Area Chart
[//]: # PLACE IMAGE HERE

![bar chart](assets/img/deneb_walkthrough_images/2e_marks.webp "bar chart")

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
        "type": "area",
        "color": "#0000FF"
      }
    }
  ]
}

```

<br>

### Scatter Plot
[//]: # PLACE IMAGE HERE

![bar chart](assets/img/deneb_walkthrough_images/2f_marks.webp "bar chart")

```jsonc

// note: the code is abbreviated and annotated for effect
{
  "data": {"name": "dataset"},
  "encoding": {
    "x": { "field": "AC" },   // axis on the bottom
    "y": { "field": "QTY" }   // axis on the left
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
___

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