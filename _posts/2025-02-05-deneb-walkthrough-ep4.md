---
layout: post
title: S1E4 - Styling Mark Properties (pt2)
date: 2025-02-05 01:00
category: [PowerBI, DataViz, Deneb, Vega-Lite]
author: [A1, A2]
tags: [walkthrough]
summary: Walkthrough
description: Marks are the core building blocks for chart development. In this article we will take a little dip into the different mark types available🕊️🧙🏼‍♂️✨
image: 
    path: assets/headers/post-headers/ep4.png
    width: 700
    height: 400
    alt: Power BI and Deneb
mermaid: true
published: true
hidden: false

---

![Styling Marks](assets/img/deneb_walkthrough_images/4a_styles.webp "Styling Marks")

> 💌 `PBIX` file available at the end of the article [^fn-pbix]  Enjoy!
{: .prompt-info }

[//]: # Comment first footnoote, can be please anywhere and will display on footer
[^fn-pbix]: PBIX: [Github Repo](https://github.com/PBI-DataVizzle/Deneb/tree/main/Medium-VegaLite-Series){: width="700" height="400" }

---

## <i class="fa-solid fa-hat-wizard fa-2x" style="color: slateblue"></i>&ensp; Recap
In the previous episode, we looked at formatting the mark properties of our column chart. In this episode, we will reuse that column chart and modify it slightly to create an area chart with custom styling.


## Not Lazy, Just Efficient
We could start from scratch, but that’s unnecessary when we can make the most of the code we’ve already built.

> **The greatest invention of all time is copy and paste** — Alberto Ferrari (SQLBI)

There’s no shame in copy and paste, we are busy people and we are in a hurry to showcase our talents, remember…

> **I’m not lazy, just efficient** — Patrick LeBlank (Guys In A Cube)


## <i class="fa-solid fa-people-pulling fa-2x" style="color: orange"></i>&nbsp; Walkthrough: Customised Area Chart
### Step 1: Prepare the Area Chart
In the PBIX solution file, we can first copy and paste or duplicate the column chart viz. Then return to the Editor:  
  
<br>

![Styling Marks](assets/img/deneb_walkthrough_images/4b_styles.webp "Styling Marks")

<br>

### Step 2: Change the mark type
We want to start working on an area chart, so the next simple step is to replace mark type bar with area:

![Styling Marks](assets/img/deneb_walkthrough_images/4c_styles.webp "Styling Marks")

<details>
<summary>&ensp;<mark>Click here to reveal code</mark>&ensp; <i class="fa-solid fa-code"></i>&ensp;⬇️</summary>

{% highlight JSONC linenos %}

{
  "data": {"name": "dataset"},
  "mark": {
    "type": "area",           
    "color": "yellow",
    "fill": "#F0E199",
    "stroke": "#E044A7",
    "strokeWidth": 2
  },
  "encoding": {
    "x": {...},
    "y": {...}
  }
}

{% endhighlight %}
</details>

<br>

![Styling Marks](assets/img/deneb_walkthrough_images/4d_styles.webp "Styling Marks")

<br>

### Step 3: Replace X-Axis
Technically speaking, line and area charts are best suited for trend analyses, that is to say, viewing data in a continuous fashion horizontally over time. You’ll need to drop the DIM_Dates[EndOfMonth] field into the values field well, and remove [Category]

<br>

![Styling Marks](assets/img/deneb_walkthrough_images/4e_styles.webp "Styling Marks")

<br>

You might see some strange behaviours happening to your Deneb viz, fear not… this is temporary. You need to remove the [Category] field.


### Step 4: Fixing Sort, Data Types, and Axis Labels
You will have noticed immediately that our Area Chart needs some TLC. In a few simple steps, we can get the chart in working order. We need to do a couple of things first:

- Fix the sort order
- Fix the axis labels
- Fix axis data types
- This bit is a doddle, we’ll just delete a few pieces of code…


<details>
<summary>&ensp;<mark>Click here to reveal code</mark>&ensp; <i class="fa-solid fa-code"></i>&ensp;⬇️</summary>

{% highlight JSONC linenos %}
{
  "data": {"name": "dataset"},
  "mark": {
    "type": "area",
    "color": "yellow",
    "fill": "#F0E199",
    "stroke": "#E044A7",
    "strokeWidth": 2
  },
  "encoding": {
    "x": {
      "field": "EndOfMonth",
      "type": "nominal",
      "sort": "-y",          
      "axis": {}
      "axis": {
        "labelAngle": 325,  
        "labelPadding": 4   
     }
    },
    "y": {
      "field": "_AC",
      "type": "quantitative",
      "axis": {
        "format": "£0,,.#M",
        "formatType": "pbiFormat"
      }
    }
  }
}
{% endhighlight %}

</details>


<br>

![Styling Marks](assets/img/deneb_walkthrough_images/4f_styles.webp "Styling Marks")

<br>

Now for the Dates field. Vega-Lite requires us to be very specific about data types in general, but even more-so with date fields. They need extra attention when it comes to formatting. Let’s take a closer look:

We’ve mentioned in previous episodes that Vega-Lite needs a helping hand in defining the encoding data type to avoid ambiguity. We have:
- `nominal` (text or categorical)
- `ordinal` (ranked)
- `quantitative` (numerical)
- and `temporal` (datetime)



<br>

<details>
<summary>&ensp;<mark>Click here to reveal code</mark>&ensp; <i class="fa-solid fa-code"></i>&ensp;⬇️</summary>


{% highlight JSONC linenos %}
{
  "data": {"name": "dataset"},
  "mark": {
    "type": "area",
    "color": "yellow",
    "fill": "#F0E199",
    "stroke": "#E044A7",
    "strokeWidth": 2
  },
  "encoding": {
    "x": {
      "field": "EndOfMonth",      
      "type": "temporal",         
      "axis": {}
    },
    "y": {
      "field": "_AC",
      "type": "quantitative",
      "axis": {
        "format": "£0,,.#M",
        "formatType": "pbiFormat"
      }
    }
  }
}
{% endhighlight %}
</details>

<br> 

And the result is very tidy. Take note, when using a `temporal` data type, Vega-Lite automatically treat it as a *continuous* field:

<br>

![Styling Marks](assets/img/deneb_walkthrough_images/4g_styles.webp "Styling Marks")

<br>

Back to Deneb, our area chart is looking really good. But there is some fine tuning I’d like to apply to the axis labels. In this moment, we will be venturing into some uncharted territory. Vega-Lite provides us will near complete control of every element of the chart, whereas in Power BI we do not always have the same degree of flexibility. For example, in Power BI with a continuous axis, you do not have any options or settings to format how the axis labels appear. In fact, PBI’s continous axis changes dynamically depending on the size of the viz container, but still there is no real control:


This is where Vega-Lite shines, and this is where we will shine too 🪄✨… ready?

We want to change how the date appears on our axis, I want to keep it simple — I only want to see the month and year. We can achieve this really cleanly by adding a timeUnit attribute, and 1 single line of code:


<details>
<summary>&ensp;<mark>Click here to reveal code</mark>&ensp; <i class="fa-solid fa-code"></i>&ensp;⬇️</summary>


{% highlight JSONC linenos %}

{
  "data": {"name": "dataset"},
  "mark": {...},
  "encoding": {
    "x": {
      "field": "EndOfMonth",      
      "type": "temporal",         
      "timeUnit": "yearmonth",
      "axis": {}
    },
    "y": {...}
  }
}
{% endhighlight %}

</details>

<br>

The result is good, but I want further customisation. I’d like to apply a “mmm-yy” format, eg: Jan-23, Jul-23 etc.

```jsonc
{
  "data": {"name": "dataset"},
  "mark": {...},
  "encoding": {
    "x": {
      "field": "EndOfMonth",      
      "type": "temporal",         
      "timeUnit": "yearmonth", // assign a month & year format
      "axis": {}
    },
    "y": {...}
  }
}
```

To achieve this, we need to take a dive into a world of documentation pain 🤓… in the form of D3’s number/date formatting. I shall list a few important elements below:


We will add a format attribute to the axis properties:  



Fantastic. But don’t celebrate just yet 🥳 — there is still work to do, trust me, you going to love it… just some final flourishes to make our chart immaculate 🧙‍♂️

### Step 5: Adjust Axis Padding
We want to create some space between the axis labels and the chart canvas. This space is referred to as padding or labelPadding.

Returning to our code, we want to add padding to boy x and y-axis separately:

<details>
<summary>&ensp;<mark>Click here to reveal code</mark>&ensp; <i class="fa-solid fa-code"></i>&ensp;⬇️</summary>
<br>


{% highlight JSONC linenos %}
{
  "data": {"name": "dataset"},
  "mark": {
    "type": "area",
    "color": "yellow",
    "fill": "#F0E199",
    "stroke": "#E044A7",
    "strokeWidth": 2
  },
  "encoding": {
    "x": {
      "field": "EndOfMonth",
      "type": "temporal",
      "timeUnit": "yearmonth",
      "axis": {
        "format": "%b-%y",
        "labelPadding": 8   
      }
    },
    "y": {
      "field": "_AC",
      "type": "quantitative",
      "axis": {
        "format": "£0,,.#M",
        "formatType": "pbiFormat",
        "labelPadding": 18  
      }
    }
  }
}
{% endhighlight %}
</details>

<br> 

Champion. Chart look fab, axes are on fleek. You’ll be pleased to know that was the hardest part… we will cruise through the next section, which is formatting the area mark properties.

### Step 6: Format Area Mark Properties
There’s one mismatch between our PBI native chart and our Deneb area chart. Have you spotted it yet? Yup… correct… the bold pink outline (stroke) should be replaced. Let’s tackle that now:

<br>

```jsonc
{
  "data": {"name": "dataset"},
  "mark": {
    "type": "area",
    "color": "yellow",
    "fill": "#F0E199",
    "stroke": "#E044A7",   // delete the stroke attribute
    "strokeWidth": 2       // and delete the strokeWidth

  },
  "encoding": {
    "x": {...},
    "y": {...}
  }
}
```

<br>

And in one big go, we will make all the changes we need:

<b>

```jsonc
{
  "data": {"name": "dataset"},
  "mark": {
    "type": "area",
    "fill": "#F0E199",   // <-- change the fill colour
    "opacity": 0.3,      // <-- set the area colour opacity [0,1]
    "line": {            // <-- adjust line properties within area mark
      "stroke": "#E8D166",  // <-- line stroke colour
      "strokeWidth": 3      // <-- line stroke width
    },
    "point": {           // <-- add points (aka markers in PBI)
      "filled": true,    // <-- markers are filled
      "fill": "#E044A7", // <-- marker fill colour
      "stroke": "black", // <-- black outline around markers
      "strokeWidth": 0.2,  // <-- marker outline stroke width
      "size": 75         // <-- marker size
    }
  },
  "encoding": {
    "x": {
      "field": "EndOfMonth",
      "type": "temporal",
      "timeUnit": "yearmonth",
      "axis": {
        "format": "%b-%y",
        "labelPadding": 8
      }
    },
    "y": {
      "field": "_AC",
      "type": "quantitative",
      "axis": {
        "format": "£0,,.#M",
        "formatType": "pbiFormat",
        "labelPadding": 18
      }
    }
  }
}
```


___

<p style="text-align: center;">. . .</p>

##### <center> <i class="fa-solid fa-heart-circle-check fa-2x"></i>&nbsp; En Fin, Serafin </center>
Thank you for staying to the end of the article… I hope you find it useful 😊. See you soon, and remember... #StayQueryous!🧙‍♂️🪄  

## <center><i class="fa-solid fa-download"></i>&nbsp;  PBIX 💾 </center>
🔗 Repo: [Github Repo PBIX Treasure Trove - Deneb Walkthrough Series](https://github.com/PBI-DataVizzle/Deneb/tree/main/Medium-VegaLite-Series)  

[!["Buy Me A Coffee"](https://www.buymeacoffee.com/assets/img/custom_images/orange_img.png)](https://buymeacoffee.com/pbidatavizzle) 

<p style="text-align: center;">. . .</p> 
<!-- <br> -->

---
## Footnotes
_