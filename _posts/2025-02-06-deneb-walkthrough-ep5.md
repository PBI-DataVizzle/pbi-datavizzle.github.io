---
layout: post
title: S1E5 - Layers
date: 2025-02-06 02:00
category: [PowerBI, DataViz, Deneb, Vega-Lite]
author: [A1, A2]
tags: [walkthrough]
summary: Walkthrough
description: Welcome to the layer cake 🕊️🧙🏼‍♂️✨
image: 
    path: assets/headers/post-headers/ep5.png
    width: 700
    height: 400
    alt: Power BI and Deneb
mermaid: true
published: true
hidden: false

---

![Layers](assets/img/deneb_walkthrough_images/5a_layers.webp "Layers")

> 💌 `PBIX` file available at the end of the article [^fn-pbix]  Enjoy!
{: .prompt-info }

[//]: # Comment first footnoote, can be please anywhere and will display on footer
[^fn-pbix]: PBIX: [Github Repo](https://github.com/PBI-DataVizzle/Deneb/tree/main/Medium-VegaLite-Series){: width="700" height="400" }

---

## <i class="fa-solid fa-hat-wizard fa-2x" style="color: slateblue"></i>&ensp; Recap
So far in the series, we have covered Marks, Encoding, Mark Types, Mark and Mark Styling. This series on [LAYERS](https://vega.github.io/vega-lite/docs/layer.html) is going to dive straight into the deep-end. If there are any unfamiliar concepts, please revisit previous episodes.

### Pre-Layer (Single View)
Before we can wrap our heads around the concept of layers in Vega-Lite (VL), we should take baby steps 🐣. Personally, I’m a visual-learner… I absorb code and code patterns by seeing them laid out in context, and being able to compare and desconstruct can be massively helpful 🤓

What do [single view](https://vega.github.io/vega-lite/docs/spec.html#single) and [multi-view](https://vega.github.io/vega-lite/docs/layer.html) charts look like? The VL syntax does contain important differences that we need to be aware of. [Let’s have a gander](https://dictionary.cambridge.org/dictionary/english/have-take-a-gander)…

#### Single View

```JSONC
{
  "data": {"name": "dataset"},
  "mark": {...},                    //   <--- single mark
  "encoding": {                     //   <--- encoding channel
    "x": {...},
    "y": {...}
  }
}
```

<br>

#### Multi / Composite View

```JSONC
{
  "data": {"name": "dataset"},
/* ------------------------------------------------|
*nb: note the square brackers [], this is to enable
an array or list of multiple view specifications
|--------------------------------------------------*/

  "layer": [          //   <--- start layer property
    {                 //       <--- start mark spec (1)
      "mark": {...}   //         <--- Mark1
    },                //       <--- end mark spec (1)

    {                 //       <--- start mark spec (2)
      "mark": {...}   //         <--- Mark2
    }                 //       <--- end mark spec (2)
  ],                  //   <--- end layer property

  "encoding": {
    "x": {...},
    "y": {...}
}
```

<br>

When we observe the code this way, it’s not as complicated as we might first have imagined. It’s a case of putting our `{ marks }` inside the layer [ `{mark1}`, `{mark2}` ]


### Multi-Layer Charts
So far so good? Ready for the good stuff? Me too 😏 — Without further a-do, let us build!!

#### Step 1: First Layer (Actual Bar)
We’ll start with just the basics and gradually increase the complexity. I’ve prepared some visuals in the PBIX so we can hit the ground running… 🏃🏽

<br>

![Layers](assets/img/deneb_walkthrough_images/5a_layers.webp "Layers")

<br>

##### Config:

Use this script for the config, by placing it here, we keep our specification code less cluttered, and easier to read 😊. I’m basically setting the fonts to “Segoe UI” and the font size for the labels to 16.


```JSONC
{
  "view": {"stroke": "transparent"},
  "params": [                      //    <--- declare some parameters
    {
      "name": "globalFont",        // <-- give parameter a name
      "value": "segoe ui"          // <-- parameter value
    },
    {
      "name": "globalFontAxis",    // <-- another parameter name
      "value": "segoe ui semibold" // <-- parameter value
    }
  ],                              //    <--- end parameters property
  "axis": {                      // applies config to all axis properties in the specification
    "labelFont": {
      "expr": "globalFontAxis"
    },
    "labelFontSize": 16,
    "titleFont": {"expr": "globalFont"}  // <-- expression to return paramter value
  },
  "legend": {
    "labelFont": {"expr": "globalFont"}, // <-- expression to return paramter value
    "titleFont": {"expr": "globalFont"}
  },
  "header": {
    "labelFont": {"expr": "globalFont"},
    "titleFont": {"expr": "globalFont"}
  },
  "mark": {
    "font": {"expr": "globalFont"}
  },
  "title": {
    "font": {"expr": "globalFont"},
    "subtitleFont": {
      "expr": "globalFont"
    }
  }
}
```

##### Specification:

This will give us a nicely formatted set of axes and a tidy bar chart. I’ve used [band](https://vega.github.io/vega-lite/docs/scale.html#band) scaling, to provide a narrow bar shape and even spacing to provide some room for our layers.


```JSONC
{
  "data": {"name": "dataset"},
  "layer": [                   // <<--- open layer
    {                            // <-- open mark1
      "mark": {                    
        "type": "bar",             // <-- mark type
        "width": {"band": 0.65},   // <-- width of bars 
        "fill": "#004385",         // <-- bar colour
        "stroke": "black",         // <-- bar border colour
        "xOffset": 0               // <-- bar offset (more on this later)
      }
    }                           // <-- close mark1
  ],                           // <<--- close layer

  "encoding": {
    "x": {                        
      "field": "Date",
      "type": "ordinal",
      "timeUnit": "yearmonth",
      "axis": {
        "title": null,
        "format": "%b-%y"
      },
      "scale": {"padding": 0.3}
    },
    "y": {
      "field": "AC",            // <-- actual sales field (AC)
      "type": "quantitative",
      "axis": {
        "title": null,
        "tickCount": 4,
        "format": "£0,,.#M",
        "formatType": "pbiFormat",
        "labelPadding": 18
      }
    }
  }
}
```

##### Step 2: Second Layer (Budget Bar)

For illustrative purposes, I want us to build a separate chart so we can better conceptualise the notion of layers.

[//]: # PLACE IMAGE HERE

We are super efficient, so we will simply copy and paste the entire visual and then tweek a couple of lines of code:


```JSONC
{
  "data": {"name": "dataset"},
  "layer": [                   
    {                            
      "mark": {                    
        "type": "bar",             
        "width": {"band": 0.65},   
        "fill": "#FDFFFC",         // <-- chnage the bar colour
        "stroke": "black",         
        "xOffset": 0               
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
      },
      "scale": {"padding": 0.3}
    },
    "y": {
      "field": "BU",            // <-- change to budget sales field (BU)
      "type": "quantitative",
      "axis": {
        "title": null,
        "tickCount": 4,
        "format": "£0,,.#M",
        "formatType": "pbiFormat",
        "labelPadding": 18
      }
    }
  }
}
```

Great progress! This is an ideal moment to take a step back, grab a coffee ☕, and enjoy the fruits of our labour:

[//]: # PLACE IMAGE HERE

#### Step 3: Combining these layers

At first glance, the idea of layering is quite straight forward. A fellow data viz wizard and Deneb (VL) artist [Thys](https://thysvdw.github.io/) said it best…

> It’s like printing charts on paper, and placing them on top of each other…

This is wonderful in it’s simplicity and when things start to get complicated or overwhelming with VL, I always give myself a shake and come back to this description.

[//]: # PLACE IMAGE HERE

We are powering up! Now we will combine our two layers into a single chart. All we need to is to duplicate (copy and paste) our mark properties into the existing layer, and amend a few properties so we end up with two marks, one for Actual and the other for Budget:

```JSONC
{
  "data": {"name": "dataset"},
  "layer": [                    //--- open layer
//------- COPY AND PASTE THIS SECTION
    {              
      "mark": {                  // <-- actual bar mark
        "type": "bar",
        "width": {"band": 0.65},
        "fill": "#004385",       // <-- actual bar colour 
        "stroke": "black",
        "xOffset": 0             // <-- actual bar offset is ZERO
      }
    }
//------- COPY AND PASTE THIS SECTION and paste below
//------- SEPARATED BY A COMMA
,
    {                                  
      "mark": {                  // <-- budget bar mark
        "type": "bar",
        "width": {"band": 0.65},
        "fill": "#FDFFFC",       // <-- budget bar colour
        "stroke": "black",
        "xOffset": 0             // <-- budget bar offset is ZERO (keep note)         
      }
    }
  ],                            //--- close layer
  "encoding": {
    "x": {
      "field": "Date",
      "type": "ordinal",
      "timeUnit": "yearmonth",
      "axis": {
        "title": null,
        "format": "%b-%y"
      },
      "scale": {"padding": 0.3}
    },
    "y": {
      "field": "AC",
      "type": "quantitative",
      "axis": {
        "title": null,
        "tickCount": 4,
        "format": "£0,,.#M",
        "formatType": "pbiFormat",
        "labelPadding": 18
      }
    }
  }
}
```

Hit play and take a bow you geni…… oh wait 😐

[//]: # PLACE IMAGE HERE
[//]: # PLACE GIF HERE

#### Step 4: Cry 😭
Erm. This is awkward. But we don’t have time to cry into our cornflakes just yet. We can fix this. First things first. We need to shift the bars along the X-Axis to create some separation…remember the “xOffset” attribute? Let’s head back to the code:

```JSONC
{
  "data": {"name": "dataset"},
  "layer": [                   

    {              
      "mark": {                  
        "type": "bar",
        "width": {"band": 0.65},
        "fill": "#004385",       
        "stroke": "black",
        "xOffset": 0        // <-- actual bar offset is ZERO
      }
    }

,
    {                                  
      "mark": {                  
        "type": "bar",
        "width": {"band": 0.65},
        "fill": "#FDFFFC",       
        "stroke": "black",
        "xOffset": -8       // <-- set the budget bar offset to -8 (8 pixels to the left)
      }
    }
  ],                            
  "encoding": {
    "x": {...},
    "y": {...}
  }
}
```

[//]: # PLACE IMAGE HERE

By setting the xOffset to -8, we have shifted the Budget mark 8 pixels to the left along the X-axis. Winning!

Now we can see both bars… but there’s still issues.

The Budget mark is returning the same values as the Actual mark
The Actual bar is behind the Budget mark, we want the flip the order around so the Actual bar is in front
So, we have our 2 marks, the Actual bar mark is encoding as intended, but the Budget mark isn’t playing ball. You’ll be pleased to know at this juncture we will be taking a trip into the 4th dimension… #SorryNotSorry

#### Step 5a: Understanding Encoding Behaviour
We want to make sure the Budget mark is encoded against the Budget field in our dataset. Let’s compare several variations of how we can write the code to better understand who encoding behaves across multiple marks.

I’ve included a few in-code descriptors to ease the congitive burden. Firstly, let’s look at how the position of the encoding channel can effect the viz:

##### *Example A: encoding channel below layer*

```JSONC
{
  "data": {"name": "dataset"},
  "layer": [
    {
      "name": "ACTUAL BAR",      // <-- define mark name (ACTUAL BAR)
      "mark": {
        "type": "bar",
        "width": {"band": 0.65},
        "fill": "#004385",
        "stroke": "black",
        "xOffset": 0
      }
    },
    {
      "name": "BUDGET BAR",    // <-- define mark name (BUDGET BAR)
      "mark": {
        "type": "bar",
        "width": {"band": 0.65},
        "fill": "#FDFFFC",
        "stroke": "black",
        "xOffset": -8
      }
    }
  ],
/*---------------------------------------|
ENCODING CHANNEL PLACED BELOW LAYER MARKS
|---------------------------------------*/
  "name": "GLOBAL ENCODING",  // <-- coding channel affects entire layer
  "description": "applies encoding to the entire layer above",
  "encoding": {
    "x": {
      "field": "Date",
      "type": "ordinal",
      "timeUnit": "yearmonth",
      "axis": {
        "title": null,
        "format": "%b-%y"
      },
      "scale": {"padding": 0.3}
    },
    "y": {
      "field": "AC",
      "type": "quantitative",
      "axis": {
        "title": null,
        "tickCount": 4,
        "format": "£0,,.#M",
        "formatType": "pbiFormat",
        "labelPadding": 18
      }
    }
  }
}
```


<br>

##### *Example B: encoding channel above layer*

```JSONC
{
  "data": {"name": "dataset"},
/*---------------------------------------|
ENCODING CHANNEL PLACED ABOVE LAYER MARKS
|---------------------------------------*/
  "name": "GLOBAL ENCODING",  // <-- coding channel affects entire layer
  "description": "applies encoding to the entire layer below",
  "encoding": {
    "x": {
      "field": "Date",          // <-- X-axis encodes the Date field
      "type": "ordinal",
      "timeUnit": "yearmonth",
      "axis": {
        "title": null,
        "format": "%b-%y"
      },
      "scale": {"padding": 0.3}
    },
    "y": {
      "field": "AC",            // <-- Y-axis encodes the AC field!!
      "type": "quantitative",
      "axis": {
        "title": null,
        "tickCount": 4,
        "format": "£0,,.#M",
        "formatType": "pbiFormat",
        "labelPadding": 18
      }
    }
  }
  "layer": [
    {
      "name": "ACTUAL BAR",      // <-- define mark name (ACTUAL BAR)
      "mark": {
        "type": "bar",
        "width": {"band": 0.65},
        "fill": "#004385",
        "stroke": "black",
        "xOffset": 0
      }
    },
    {
      "name": "BUDGET BAR",    // <-- define mark name (BUDGET BAR)
      "mark": {
        "type": "bar",
        "width": {"band": 0.65},
        "fill": "#FDFFFC",
        "stroke": "black",
        "xOffset": -8
      }
    }
  ]
}
```

<br>

**In Brief:** The position of the “global” encoding channel doesn’t effect the chart. But it’s clear now that the reason why the Budget bar isn’t encoding properly is because our “global” encoding is currently only bound to the AC field.

[//]: # PLACE IMAGE HERE

#### Step 5c: Add Budget Encoding
The quickest way to fix this is the trusty Copy and Paste. Copy the entire encoding section, and we are going to paste it inside the Budget Mark property. Change the Y-axis encoding to “BU”:

[//]: # PLACE IMAGE HERE

```JSONC
{
  "data": {"name": "dataset"},
  "name": "GLOBAL ENCODING",
  "description": "applies encoding to the entire layer above",
  "encoding": {                  // <-- global encoding
    "x": {
      "field": "Date",          // <-- Date field on X-axis (globally)
      "type": "ordinal",
      "timeUnit": "yearmonth",
      "axis": {...}
    },
    "y": {                      // <-- AC field on Y-axis (globally)
      "field": "AC",
      "type": "quantitative",
      "axis": {...}
    }
  },
  "layer": [
    {
      "name": "ACTUAL BAR",     // <-- actual bar mark
      "mark": {...}
    },                          // <-- no encoding on this mark  
                                // so it applies the global encoding
    {
      "name": "BUDGET BAR",     // <-- budget bar mark
      "mark": {...},
      "encoding": {             // <-- mark-specific encoding
        "x": {
           "field": "Date",     // <-- same Date field
           ...},             
        "y": {
          "field": "BU",        // <-- new budget encoding overwrites  
                                // the global encoding
          "type": "quantitative",
          "axis": {...}
        }
      }
    }
  ]
}
```

<br>

[//]: # PLACE IMAGE HERE

Magic! Before we move on, whilst we are still in the headspace of Encoding. We must MUST talk about efficent and succinct coding.. after all, coding is just a love letter to your future self 💌🤓

You’ll have noticed that in developing a lovely Deneb / Vega-Lite viz, the number of lines of code grows rather quickly. To ensure our code is as (obsessively) neat and tidy as possible, we want to reduce any unnecessary duplication or redundant code.

As we have seen, we have a global encoding channel, and any subsequent mark-specific encoding properties we add will in fact overwrite the global properties. This is perfect. We don’t actually have to copy every line of the encoding channel for this to work. We actually only need to add the parts we want to change. I’m probably not making much sense now, let me show you:

```JSONC
{
  "data": {"name": "dataset"},
  "encoding": {                  // <-- global encoding
    "x": {
      "field": "Date",
      "type": "ordinal",
      "timeUnit": "yearmonth",
      "axis": {
        "title": null,
        "format": "%b-%y"
      },
      "scale": {"padding": 0.3}
    },
    "y": {
      "field": "AC",            // <-- this is only part of the encoding
                                // we will be changing below...
      "type": "quantitative",
      "axis": {
        "title": null,
        "tickCount": 4,
        "format": "£0,,.#M",
        "formatType": "pbiFormat",
        "labelPadding": 18
      }
    }
  },
  "layer": [      // <<--- open layer
    {                          // <-- start mark1 object
      "mark": {
        "type": "bar",
        "width": {"band": 0.65},
        "fill": "#004385",
        "stroke": "black",
        "xOffset": 0
      }
    },                         // <-- end mark1 object
    {                          // <-- start mark2 object
      "mark": {
        "type": "bar",
        "width": {"band": 0.65},
        "fill": "#FDFFFC",
        "stroke": "black",
        "xOffset": -8
      },
      "encoding": {              // <-- mark-specific encoding
        "y": {"field": "BU"}     // <-- only changed the "field" property
                                 // all the other global encoding properties
                                 // will still apply
      }
    }                          // <-- end mark2 object
  ]              // <<--- close layer
}
```


<b>

And the result is the same, but our code is cleaner, and we feel better for it… don’t we? 😊

For the penultimate step, to reinforce the flexibility and variety of encoding options, I’ll share abbreviated version so you can compare the difference.

#### Example C: Partial Global / Defined at the Mark-level

```JSONC
{
  "data": {"name": "dataset"},
  "encoding": {
    "x": {                               // <-- global x-axis
      "field": "Date"
    },
    "y": {
                                         // <-- removed global y-axis field
      "type": "quantitative",            // <-- partial y-axis encoding
      "axis": {...}
    }
  },
  "layer": [
    {
      "name": "ACTUAL BAR",
      "mark": {...},
      "encoding": {"y": {"field": "AC"}}  // <-- mark-specific y-axis
    },
    {
      "name": "BUDGET BAR",
      "mark": {...},
      "encoding": {"y": {"field": "BU"}} // <-- mark specific y-axis
    }
  ]
}
```

<b>

#### Example D: Partial Global / Defined at the Mark-level

```JSONC
{
  "data": {"name": "dataset"},
 
  "layer": [
    {
     /* place the encoding position above the mark */
      "encoding": {"y": {"field": "AC"}}  // <-- mark-specific y-axis,
      "name": "ACTUAL BAR",
      "mark": {...}
      
    },
    {
     /* place the encoding position above the mark */
      "encoding": {"y": {"field": "BU"}} // <-- mark specific y-axis
      "name": "BUDGET BAR",
      "mark": {...}
      
    }
  ],
/* place the global encoding channel below the the layer property */
"encoding": {
    "x": {                               // <-- global x-axis
      "field": "Date"
    },
    "y": {
      "type": "quantitative",            // <-- partial y-axis encoding
      "axis": {...}
    }
  }
}
```

[//]: # PLACE IMAGE HERE

<br>

If you think that was intense. You’re are 100% correct! 🤪🤕🤭 — but there’s no more of that today… pinky swear 🤞🏽.

### Step 6: Change order of marks
This part is a breeze — trust me. In short, the order in which you code your marks, determines the position it appears on the canvas:

#### Example E: Actual behind the Budget

```JSONC
{
  "data": {"name": "dataset"},
  "description": "MAIN LAYER",
  "encoding": {
    "x": {...},
    "y": {...}
  },
  "layer": [
    {                              // <--- actual mark layered first (back)
      "name": "ACTUAL BAR",
      "mark": {...},
      "description": "ACTUAL BAR ENCODING",
      "encoding": {"y": {"field": "AC"}}
    },
    {
      "name": "BUDGET BAR",      // <--- budget mark layered second (front)
      "mark": {...},
      "description": "BUDGET BAR ENCODING",
      "encoding": {"y": {"field": "BU"}}
    }
  ]
}
```

<br>

So let’s do the switcheroo!

#### Example F: Actual in front of Budget

```JSONC
{
  "data": {"name": "dataset"},
  "description": "MAIN LAYER",
  "encoding": {
    "x": {...},
    "y": {...}
  },
  "layer": [
    {
      "name": "BUDGET BAR",      // <--- budget mark layered first (back)
      "mark": {...},
      "description": "BUDGET BAR ENCODING",
      "encoding": {"y": {"field": "BU"}}
    },
    {                              // <--- actual mark layered second (front)
      "name": "ACTUAL BAR",
      "mark": {...},
      "description": "ACTUAL BAR ENCODING",
      "encoding": {"y": {"field": "AC"}}
    }
  ]
}
```

[//]: # PLACE IMAGE AND GIF HERE

I hope you survived until the end… and I hope it gives you some inspiration to create your own magic! 🧙🏽‍♂️🪄

Until next time… #StayQueryous


---
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