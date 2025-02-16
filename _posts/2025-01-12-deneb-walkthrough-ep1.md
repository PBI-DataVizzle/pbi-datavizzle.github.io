---
layout: post
title: S1E1 - Marks and Encoding
date: 2025-01-12 15:51
category: [Season-1, Deneb, Vega-Lite, PowerBI, Walkthrough]
author: [A1, A2]
tags: [season1, walkthrough, marks]
summary: Walkthrough
description: Let’s learn to run before we fly 🕊️ — a walk-through of the fundamental building blocks in Vega-Lite data viz development
image: 
    path: "assets/headers/post-headers/ep1.png"
    width: 700
    height: 400
    alt: Power BI and Deneb
mermaid: true
published: true
hidden: false
---

> 💌 `PBIX` file available at the end of the article [^fn-pbix]  Enjoy!
{: .prompt-info }

[//]: # Comment first footnoote, can be please anywhere and will display on footer
[^fn-pbix]: PBIX: [Repo - Walkthrough Series](https://github.com/PBI-DataVizzle/pbi_content/tree/main/my_deneb_showcases/deneb_walkthrough_series){: width="700" height="400" }

---


## Acknowledgements
Before we begin, I’d like to tag and thank Deneb creator Daniel Marsh-Patrick — you can find comprehensive Deneb resources and examples at the offical website: deneb-viz.github.io. Daniel has inspired innumerable Power BI developers around the world, enabling us to go far beyond the boundaries of “traditional” Power BI report design. This article is a celebration of Daniel’s endeavours, for which I owe my sincere gratitude 🤓🙌

<br>

## Getting Started
When embarking on any new learning journey, it’s only natural that we want to create the most amazing, dazzling designs. However, despite our eagerness to unlock new skills and talents, it is absolutely necessary to begin by taking baby steps 🐣… and Vega-Lite is no exception.

It can at first be overwhelming, particularly when viewing the Vega-Lite examples gallery

![getting started vega-lite chart example](assets/img/deneb_walkthrough_images/1_getting_started.webp)

I know what you are thinking:

> *“But I just want to make a simple line chart 😭… what happened to my clicky-clicky-draggy-droppy experience?!”*


Well, Vega-Lite is incredibly powerful and versatile… but it does require some extra effort. In order to put our chart design ideas into practice, we must get to grips with JSON, and Vega-Lite’s grammar and syntax. It will enable you to build charts which overcome many of the limitations we find in native Power BI visuals. Are you ready to get stuck in? 🧙‍♂️

<br>

## Step 1: Marks and Encoding
Using the PBIX solution file as a guide, let’s go through the step-by-step process. First, we want to build the dataset for our Deneb visual.

Add the Deneb visual to the canvas
Add the `[Category]` field and `[AC]` measure to the Values bucket
Click on the elipses `[…]` and “Edit”
Select “Vega-Lite” specification, and the “empty (with Power BI theming)” template
Create! 📊

![](assets/img/deneb_walkthrough_images/1b_getting_started_create.webp "getting started")
{:.centered}  
*Create your first Deneb Vega-lite spec*
{: style="color:gray; font-size: 80%; text-align: center;margin-left:auto; margin-right:auto"}

## Step 2: Create a Mark
You will be presented with an empty template which will contain the following specification:

#### *starting spec*
```jsonc

{
  "data": {"name": "dataset"}, // PowerBI dataset
  "layer": []                  // Empty layer attribute (no marks)
}

```

> **`info`** From Deneb version ~> 1.7.0 onwards, comments can be written in the JSON spec.
{: .prompt-info }

<br>

What we need to do next is “assign” specific parts of our dataset to the chart canvas using a choice of geometric shapes which we refer to as marks.

For this exercise, we will apply a bar mark. I have annotated each line to describe the Vega-Lite structure and grammar:

#### *add bar mark*
```jsonc

{                               //-- specification start
  "data": {"name": "dataset"},    // powerbi dataset
  "layer": [                        // start layer
    {                                 // start mark (inside curly brackets)
      "mark": {                         // start mark attributes
        "type": "bar"                     // mark type (bar)
      }                                 // end mark attributes
    }                                 // end mark
  ]                                 // end layer
}                               //-- specification end

```

<br>


The resulting chart will look like this:

![](assets/img/deneb_walkthrough_images/1c_getting_started.webp "first bar chart")
{:.centered}  
*First Bar Chart*
{: style="color:gray; font-size: 80%; text-align: center;margin-left:auto; margin-right:auto"}

<br>

Wait, what? Where’s my bar chart? 🤔

![](assets/img/deneb_walkthrough_images/1c_getting_started.gif "where's my chart?")
{:.centered}  
*First Bar Chart*
{: style="color:gray; font-size: 80%; text-align: center;margin-left:auto; margin-right:auto"}

Althrough we’ve created a bar mark, it has not bound the graphical property to any axis. This is where encoding comes in. For now, we will look at the x-axis and y-axis.

Step 3: Encoding
Below, I’ve added the encoding channel to the specification.

#### *encode mark*
```jsonc

{
  "data": {"name": "dataset"},
  "encoding": {},                  // empty encoding channel
  "layer": [
    {
      "mark": {
        "type": "bar"
      }
    }
  ]
}

```

Now remember our dataset field values?

[comment]: # ADD DATA FIELD VALUES HERE 
[//]: # this is another comment on another line  

![](assets/img/deneb_walkthrough_images/1d_getting_started.webp "data fields")
{:.centered}  
*data fields*
{: style="color:gray; font-size: 80%; text-align: center;margin-left:auto; margin-right:auto"}


We want to bind and define these data fields against the x and y-axis. Let’s first bind our Category field to the y-axis:

#### *bind mark to y-axis*
```jsonc

{
  "data": {"name": "dataset"},
  "encoding": {                    
    "y": {"field": "Category"}     // bind the "Category" field to the y-axis
  },                               
  "layer": [
    {
      "mark": {
        "type": "bar"
      }
    }
  ]
}

```

<br>

Here is the result:

![](assets/img/deneb_walkthrough_images/1e_getting_started.webp "bar mark bound to the y-axis")
{:.centered}  
*bar mark bound to the y-axis*
{: style="color:gray; font-size: 80%; text-align: center;margin-left:auto; margin-right:auto"}


Looking better, but it’s not quite finished. Our x-axis is still undefined. Let’s fix that in a jiffy… returning to our specification:

#### bind x-axis
```jsonc

{
  "data": {"name": "dataset"},
  "encoding": {
    "y": {"field": "Category"},    // Category field on the y-axis
    "x": {"field": "AC"}           // AC measure on the x-axis
  },
  "layer": [
    {
      "mark": {
        "type": "bar"
      }
    }
  ]
}

```

![chart-image](assets/img/deneb_walkthrough_images/1f_getting_started.webp "bindin tothe x-axis")
{:.centered}
*bar mark bound to the y-axis*  
{: style="color:gray; font-size: 80%; text-align: center;margin-left:auto; margin-right:auto"}

<br>

Hmmn, this isn’t what we expected, is it? Vega-Lite just needs a little help understanding what type of data this is that we are binding to the axis. For example, is it nominal, ordinal or quantitative?

The `[AC]` measure is a quantitative value, i.e. we want to aggregate/summarise it. Let’s make a little addition to our code:

#### define data types

```jsonc

{
  "data": {"name": "dataset"},
  "encoding": {
    "y": {
      "field": "Category",    // y-axis field [Category]
      "type": "nominal"       // data type = "nominal"
    },
    "x": {
      "field": "AC",          // x-axis field [AC]
      "type": "quantitative"  // data type = "quantitative"
    }
  },
  "layer": [
    {
      "mark": {
        "type": "bar"
      }
    }
  ]
}

```

Now run the code again and take a look… much better!

![](assets/img/deneb_walkthrough_images/1g_getting_started.webp "a proper bar chart")
{:.centered}  
*a proper bar chart*
{: style="color:gray; font-size: 80%; text-align: center;margin-left:auto; margin-right:auto"}

Congratulations, you have successfully built a beautiful bar chart. We’re almost finished. Here are a few bonus tips and quality of life techniques you can use to jazz up your designs.

Step 4: Bonus techniques to perfect your chart
Firstly, our bar chart is sorted alphabetically by default. We can change the sort order of the y-axis in a very simple step:

```jsonc

{
  "data": {"name": "dataset"},
  "encoding": {
    "y": {
      "field": "Category",
      "type": "nominal",
      "sort": "-x"              // sort descending by the x-axis 
     // "sort": "x"             // sort ascending
    },
    "x": {
      "field": "AC",
      "type": "quantitative"
    }
  },
  "layer": [
    {
      "mark": {
        "type": "bar"
      }
    }
  ]
}

```
<br>

![](assets/img/deneb_walkthrough_images/1h_getting_started.webp "sort axis")
{:.centered}  
*sort axis*
{: style="color:gray; font-size: 80%; text-align: center;margin-left:auto; margin-right:auto"}

Finally, for that extra finesse 🪄, let’s add a splash of colour:

```jsonc
{
  "data": {"name": "dataset"},
  "encoding": {
    "y": {
      "field": "Category",
      "type": "nominal",
      "sort": "-x"
    },
    "x": {
      "field": "AC",
      "type": "quantitative"
    }
  },
  "layer": [
    {
      "mark": {
        "type": "bar",
        "color": "teal"      // update the mark's color attribute
     // "color": "#0000FF"   // use hex codes or CSS colour schemes
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
