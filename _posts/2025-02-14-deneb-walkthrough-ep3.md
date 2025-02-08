---
layout: post
title: S1E3 - Styling Mark Properties (pt1) ( PBI | D | VL )
date: 2025-02-08 00:00
category: [PowerBI, DataViz, Deneb, Vega-Lite]
author: [A1, A2]
tags: [powerbi, dataviz, deneb, vega-lite, data visualisation, walkthrough]
summary: Walkthrough
description: Take chart customisation one gigantic step forward. Today’s walk-through looks at styling your chart elements to create truly compelling visualisations 🕊️🧙🏼‍♂️✨
image: 
    path: assets/headers/post-headers/ep3.png
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

---

## Recap
So far in Episodes [1](https://pbi-datavizzle.github.io/posts/deneb-walkthrough-ep1/) and [2](https://pbi-datavizzle.github.io/posts/deneb-walkthrough-ep2/), we have looked at the fundamentals of Deneb / Vega-Lite visualisation: how to create a chart using a variety marks, and how to bind our data fields to the a chart’s encoding channel. In this episode, we are going to get jazzy 🎸… I hope you like curly brackets {} 😋

<p style="text-align: center;">. . .</p>


## Understanding Mark Properties
Mark properties are essential for defining how your data viz will appear on your report canvas. As we have demonstrated in earlier episodes, Vega-Lite charts are a combination of one or more marks. This is already an extremely powerful tool in story-telling. The choice of mark type and its properties can be utilised to directly influence the readability, accessability, dynamics and aesthetics of your visualisation.

The joy of Power BI is that we can see what stylistic options are available in the **formatting pane**, and it is effortless (*cough*🤫) to find and adjust these options to the desired effect.


[//]: # PLACE IMAGE HERE

![Formatting Pane](assets/img/deneb_walkthrough_images/3b_styles.webp "Formatting Pane")

<br>

Vega-Lite has a plethora of mark properties we can use to [manipulate the style of our data viz](https://deneb-viz.github.io/docs/formatting). However, it is not immediately apparent how or where we can do this. You will be pleased to know that there is no clicky-clacky-draggy-droppy functionality here, instead you have the joy of reading through [**documentation**](https://vega.github.io/vega-lite/docs/) — reems and reems of lovely, coherent, documentation 🤮🥹.  

![](assets/img/deneb_walkthrough_images/3c_styles.gif "")

![](assets/img/deneb_walkthrough_images/3d_styles.webp "")


<br>

At this juncture you may be regretting your life choices. It happens to all of us. The pain is temporary. Take a break, wipe away the tears… and when you return with renewed vigour, we will build our formatted viz together. Let’s go!

<p style="text-align: center;">. . .</p>

## Walkthrough: Formatting Mark Properties
### Step 1: Prepare the canvas
For this exercise, we are going to try and recreate native Power BI visuals in Deneb, let’s start with the column chart:

![](assets/img/deneb_walkthrough_images/3e_styles.webp "")

Add a blank Deneb viz to your page, and the `DIM_Category[Category]` field and `___Measures[**_AC**]` measure to the Values field well.

![](assets/img/deneb_walkthrough_images/3f_styles.webp "")

Click on “Edit” and create with “Vega-Lite” and the “Simple bar chart” [template](https://deneb-viz.github.io/templates).





<p style="text-align: center;">. . .</p>

## En Fin, Serafin
Thank you for staying to the end of the article… I hope you find it useful 😊. Join me on the next episode where things are going to get a lot more technical! 😏🧙‍♂️🪄

<br>

## ⏬ PBIX  ⏏️
🔗 Repo: [Github Repo PBIX Treasure Trove - Deneb Walkthrough Series](https://github.com/PBI-DataVizzle/Deneb/tree/main/Medium-VegaLite-Series)

***

<br>



<p style="text-align: center;">. . .</p>
<h6 style="text-align: center;"> ☕ un cafelito porfa ☕ </h6>
<h6 style="text-align: center;"> Oh, I almost affogato tell you 😏 My body is 90% coffee ☕ <br> the rest is classified 🤓 🤖 </h6>

[!["Buy Me A Coffee"](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png)](https://buymeacoffee.com/pbidatavizzle){: w="1200" h="630" }  



<p style="text-align: center;">. . .</p>

***


---
## Footnotes