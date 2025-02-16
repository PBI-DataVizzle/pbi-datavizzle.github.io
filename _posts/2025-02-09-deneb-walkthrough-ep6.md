---
layout: post
title: S1E6 - Expressions & Conditional Formatting (pt1)
date: 2025-02-09 01:00
category: [Season-1, Vega-Lite, Deneb,  PowerBI, Walkthrough]
author: [A1, A2]
tags: [season1, walkthrough, conditional-formatting, expressions]
summary: Walkthrough
description: Marks are the core building blocks for chart development. In this article we will take a little dip into the different mark types available🕊️🧙🏼‍♂️✨
image: 
    path: assets/headers/post-headers/ep6.png
    width: 700
    height: 400
    alt: Power BI and Deneb
mermaid: true
published: true
hidden: false

---

![conditional formatting](assets/img/deneb_walkthrough_images/6a_cf.webp "conditional formatting")

> 💌 `PBIX` file available at the end of the article [^fn-pbix]  Enjoy!
{: .prompt-info }

[//]: # Comment first footnoote, can be please anywhere and will display on footer
[^fn-pbix]: PBIX: [Github Repo](https://github.com/PBI-DataVizzle/pbi_content/tree/main/my_deneb_showcases/deneb_walkthrough_series){: width="700" height="400" }

---

> # <center>  <i class="fa-solid fa-triangle-exclamation"></i>&nbsp; CAUTION! &nbsp; <i class="fa-solid fa-triangle-exclamation"></i>&nbsp; <br> <i class="fa-solid fa-triangle-exclamation"></i>&nbsp; ADDICTIVE CONTENT &nbsp;<i class="fa-solid fa-triangle-exclamation"></i> </center>
{: .prompt-note }

<div  markdown="span" style="margin-bottom: 10px; margin-top: 10px; overflow: hidden; color:rgb(143, 49, 49); background-color:rgb(247, 217, 217); border-color:rgb(241, 229, 188); padding: 15px; border: 1px solid transparent; border-radius: 4px;"><center>   <b> ⚠️ CAUTION! ADDICTIVE CONTENT ⚠️</b> </center> </div>

---

## Intro
I am excited to write this article and I am excited for you because you will hopefully unlock your abilities to unleash next-level wizardry in your Deneb data visualisations. It might get a little intense, a little wild and confusing at times 🤪… but if we break it down into little pieces, the penny will drop for you like it did for me🥲. This episode will be the icing on the cake 🎂with the cherry 🍒 on top! 🙌🏽

There’s a lot to get through, so make sure you are hydrated and well-nourished — we need all the help we can get 😅


## Expressions
What are expressions? 🤔Think of them as data manipulations or transformations. They have the same effect as creating a DAX measure with conditional logic for conditional formatting.

If we start by referring to the trusted [Vega documentation](https://vega.github.io/vega/docs/expressions/), you will soon realise you have entered a world of pain. Nested deep in the [Expressions](https://vega.github.io/vega/docs/expressions/) section, there is a small paragraph on something called *Control Flow Functions* 🤨

![expressions](assets/img/deneb_walkthrough_images/6a_expressions.webp "expressions")

and [elsewhere](https://vega.github.io/vega-lite/docs/types.html#expression) we see:

![expressions](assets/img/deneb_walkthrough_images/6b_expressions.webp "expressions")
![expressions](assets/img/deneb_walkthrough_images/6c_expressions.webp "expressions")
![expressions](assets/img/deneb_walkthrough_images/6c_expressions.gif "expressions")

> “Control whatty what-now… Ternary Opera-whatchimacallit??🤯

To mere mortals, we are talking about IF statements! Nice, safe, easy(-ish), comfortable, familiar IF statements 🙌🏽

We’ll take a look at the DAX examples first.

## Conditional Formatting

### **DAX Examples**
Below are 2 examples of typical conditional formatting measures using the `SWITCH()` function.

![expressions](assets/img/deneb_walkthrough_images/6e_expressions.png "expressions")

That is indeed… tremendous.

### **Vega-Lite Examples**
Next, we’ll do the exact same with Vega-Lite in Deneb. This is a quick glance, we’ll dig into the detail shortly.


```jsonc
"layer": [
    {
      "mark": {
        "type": "bar",
        "width": {"band": 0.65},
        "xOffset": 0,
///* -----------------------------------------------------------------------
// conditionally format the mark's colour property, if the column data value
// equals 1 then return the blue colour otherwise return the grey colour
//------------------------------------------------------------------------*///
        "color": {
          "expr": "datum.isYTD_INT == 1 ? '#004385' : '#EDEDED'"
        },
//----------------------------------------------------------------------\\
        "stroke": "black",
        "strokeWidth": 1
      }
    }
  ]
  ```

<br>

Can you see the similarities between the DAX and VL methods? We achieve the same result, with similar techniques, just with a different coding langauge.

This is the starting point. We eventually want to end up with this result 👇🏽


** IMAGE **

Now let’s break it down, step by step. I will show you two examples:

One with Power Query “helper” columns
One using in-line VL transformations and expression, and no helper columns
## 1. Conditional Formatting with Power Query columns (dimension table)
### Step 1: House Keeping
Preparing variables/parameters for tidier coding
As you will have experienced, in any conditional formatting situation, the lines of code can explode rather rapidly, which can be overwhelming to manage and maintain, and makes reading the code somewhat more difficult. We’ll organise our code in such a way as to reduce duplication and redundancy, and make it more pleasant to peruse.

To provide the foundations, we first want to copy and paste this code into the Config tab. The intention is to create a consistent theme for all chart elements in terms of fonts, axis & label fonts, and X & Y-axis chart design. In terms of fonts, I don’t think there is a way to set a “global” font, we have to declare the font for the various chart properties. I’ve used parameters (params), which are similar to declaring [variables](https://learn.microsoft.com/en-us/dax/best-practices/dax-variables) ([var](https://www.sqlbi.com/articles/variables-in-dax/)) in DAX.

Curveball… the term variable is a misnomer, a variable is better understood as a constant or a parameter 🫠

> *You can think about a variable as a name for an expression. The term “variable” itself is somewhat misleading — a DAX variable cannot change its value, as the name would suggest. ***A DAX variable is indeed a constant***, meaning that it is a name for the value computed by the definition of the variable.*
>
> ***— SQLBI (Marco Russo & Alberto Ferrari)***

Back to the lesson…paste the code sample below into the Config tab. I’ve added annotation for illustrative purposes.

##### config
In th `Config` tab:
```jsonc
{
  "view": {"stroke": "transparent"},
//*------------------------------------------------------------------
// Declare parameters/variables
//------------------------------------------------------------------*/
  "params": [
    {
      "name": "globalFont",  //<-- I create a parameter called "globalFont"
      "value": "segoe ui"    //<-- define the value for the globalFont parameter (segoe ui font name)
    },
    {
      "name": "globalFontAxis", //<-- define another parameter called "globalFontAxis"
      "value": "segoe ui semibold"  //<-- define the value (segeo ui semibold font name)
    }
  ],
//*------------------------------------------------------------------
// define or format individual axis objects
//------------------------------------------------------------------*/
  "axis": {                      //<<--- open global axis properties
    "labelFont": {
      "expr": "globalFontAxis"
    }
//    "labelFont": "segoe ui"  //<-- standard method for formatting options
    ,
    "labelFontSize": 16,
    "titleFont": {"expr": "globalFont"},
    "title": null,
    "tickCount": 4,
    "ticks": false,
    "domain": false,
    "gridDash": [2, 4],
    "gridOpacity": 0.4
  },                            //<<--- close global axis properties

  "axisX": {                    //<<--- open X-axis properties
    "ticks": true,
    "domain": true
  },                            //<<--- close X-axis properties

  "axisY": {                    //<<--- open Y-axis properties
    "labelPadding": 18,
    "ticks": false,
    "domain": false
  },                            //<<--- close Y-axis properties

  "mark": {
    "font": {"expr": "globalFont"}
  }
}
```
##### spec
And in the `Specification` tab, we’ll copy and paste the base chart spec:

```jsonc
{
  "data": {"name": "dataset"},
  "params": [],                  //<-- blank params array (we'll return to ths later)
  "transform": [],               //<-- blank transforms array (more on this later also)
  "layer": [
    {
      "mark": {
        "type": "bar",
        "width": {"band": 0.65},
        "xOffset": 0,
        "color": "#004385",      //<-- colour value
        "stroke": "black",       //<-- stroke value
        "strokeWidth": 1         //<-- stroke width
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
    }
  }
}
```

### Step 2: Utilise parameter values
Now we have a few options where we can place the parameter, either within the Spec or the Config, there’s no right or wrong… just a matter of preference. I’ll show both, the effect is exactly the same.

#### Option 1: Spec
First, I’ll make an intentional mistake to emphasise how things can go wrong and to highlight where we need to take extra care in coding in parameters.

```jsonc
{
  "data": {"name": "dataset"},
  "params": [
    {                          // <-- add parameter between curly braces
      "name": "_barColour",        //<-- parameter name
      "value": "#004385"           //<-- parameter value
    }                          // <-- close braces
  ],
  "transform": [],
  "layer": [
    {
      "mark": {
        "type": "bar",
        "width": {"band": 0.65},
        "xOffset": 0,
   //   "color": "#004385"      <-- original code
        "color": "_barColour",  //<-- reference your parameter name (p.s this isn't going to work)
        "stroke": "black",
        "strokeWidth": 1
      }
    }
  ],
  "encoding": {
    "x": {...},
    "y": {...}
  }
}
```
and the result…

![expressions](assets/img/deneb_walkthrough_images/6i_expressions.webp "expressions")

But why doesn’t this work? Let’s consider what the VL code is saying:

```jsonc
{
  "data": {"name": "dataset"},
  "params": [
    {                          // <-- add parameter between curly braces
      "name": "_barColour",        //<-- parameter name
      "value": "#004385"           //<-- parameter value
    }                          // <-- close braces
  ],
  "transform": [],
  "layer": [
    {
      "mark": {

//* -----------------------------------------------------------------------
//• here, the color object is looking for a colour value value "#004385"
//• this is a proper colour HexCode (polynesian blue) and works fine
//----------------------------------------------------------------------- */

    "color": "#004385"      // <-- colour is looking for a value "#004385"

//* -----------------------------------------------------------------------
//• here, the color object is looking for a colour value called "_barColour"
//• no such colour exists in the rainbow or the list of CSS colour names
//----------------------------------------------------------------------- */
    "color": "_barColour",  // <-- colour is looking for a value "_barColour"

//* -----------------------------------------------------------------------
//• here, the color object contains an expression ("expr":) 
//• this enables Vega-Lite to look for a parameter called "_barColour"
//• the parameter contains the colour value "#004385"
//----------------------------------------------------------------------- */
    "color":{"expr": "_barColour" },  // <-- colour is looking for a parameter "_barColour"
        
    }
    }
  ],
  "encoding": {
    "x": {...},
    "y": {...}
  }
}
```

<br>

So when we run the amended code, we get success!

```jsonc
{
  "data": {"name": "dataset"},
  "params": [
    {
      "name": "_barColour",              //<-- magic recipe
      "value": "#004385"
    }
  ],
  "transform": [],
  "layer": [
    {
      "mark": {
        "type": "bar",
        "width": {"band": 0.65},
        "xOffset": 0,
        "color":{"expr": "_barColour" },  //<<-- magic recipe
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
    }
  }
}
```

![expressions](assets/img/deneb_walkthrough_images/6j_expressions.webp "expressions")

<br>


Let’s try it again, puting the parameters in the Config tab.

#### Option 2: Config
Copy and paste the parameter including the curly braces and place it in the Config section, at the end of our parameters array (between the square brackets).

```jsonc
// copy this bit
{
  "name": "_barColour",
  "value": "#004385"
}
```

and paste it here in your `Config`: ⬇️

##### config
```jsonc
{
  "view": {"stroke": "transparent"},
  "params": [ //<<--- open parameters array
    {
      "name": "globalFont",
      "value": "segoe ui"
    },
    {
      "name": "globalFontAxis",
      "value": "segoe ui semibold"
    },
//------------------------------------------ copy and paste
    {
      "name": "_barColour",  //<-- paste 
      "value": "#004385"     //<-- paste
    }
//------------------------------------------ copy and paste
  ],          //<<--- close parameters array
  "axis": {
    "labelFont": {
      "expr": "globalFontAxis"
    },
    "labelFontSize": 16,
    "titleFont": {"expr": "globalFont"},
    "title": null,
    "tickCount": 4,
    "ticks": false,
    "domain": false,
    "gridDash": [2, 4],
    "gridOpacity": 0.4
  },
  "axisX": {
    "ticks": true,
    "domain": true
  },
  "axisY": {
    "labelPadding": 18,
    "ticks": false,
    "domain": false
  },
  "mark": {
    "font": {"expr": "globalFont"}
  }
}
```

And run your new spec:

```jsonc
{
  "data": {"name": "dataset"},
  "params": [  
  //--- empty / no parameters, it's living in the Config tab now ---\\
  ],
  "transform": [],
  "layer": [
    {
      "mark": {
        "type": "bar",
        "width": {"band": 0.65},
        "xOffset": 0,
        "color":{"expr": "_barColour" },    //<-- magic recipe
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
    }
  }
}
```

<br>

So our Spec is less cluttered, and you’ll see this works perfectly the same.

![expressions](assets/img/deneb_walkthrough_images/6j_expressions.webp "expressions")
![expressions](assets/img/deneb_walkthrough_images/6k_expressions.gif "expressions")

> Time for a break? 🥹☕
> {: .prompt-info}

<p style="text-align: center;">. . .</p>

### Step 3: Conditional Formatting
Welcome back 🥰… at this stage, I’d say we are pretty comfortable with how parameters? For our next challenge, we’ll tackle the juicy bit — Conditional Formatting!

Some reminders… we are using the following fields in our dataset


![expressions](assets/img/deneb_walkthrough_images/6f1_expressions.webp "expressions")

The field [isYTD_INT] (is the [Date] within the Year to Date, as Int64.Type integer) is a column added to our DIM_Calendar table, with 1s and 0s

![expressions](assets/img/deneb_walkthrough_images/6f2_expressions.webp "expressions")

This is nice and we’ll use this to our advantage.

First we want to create two parameters, one colour for the Actual (ACT), and another colour for the Forecast (FRC). So we’ll amend our parameters to make this distinction clear.

Head back to the Config tab and add two more parameters:

- _barColourACT
- _barColourFRC

##### config
```jsonc
  "params": [
    {
      "name": "globalFont",
      "value": "segoe ui"
    },
    {
      "name": "globalFontAxis",
      "value": "segoe ui semibold"
    },
    {
      "name": "_barColour",
      "value": "#004385"
    },
    {
      "name": "_barColourACT",    //<-- new parameters (Actual colour)
      "value": "#004385"
    },
    {
      "name": "_barColourFRC",    //<-- new parameters (Forecast colour)
      "value": "whitesmoke"       //<-- Hex code #F5F5F5
    }
  ]
```

<br>

Excellent. Now stay with me, we’ll be doing a bit of back and forth comparisons, you might feel dizzy, but I want to make sure that we understand the concepts we are familiar with and how they compare in the VL context.

We are going to look at the DAX conditional formatting measure and recreate the same effect using a VL expression.

![expressions](assets/img/deneb_walkthrough_images/6k_expressions.webp "expressions")


In Vega-Lite, we have several options. Let’s look at them individually, them put them into context:

#### Traditional IF Statement
Datum
: single data point / data value


```jsonc
// traditional IF statement
"color": {
    "expr": "if(datum.isYTD_INT == 1 , _barColourACT , _barColourFRC)"
}
//-- plain english: if the value in the [isYTD_INT] field equals 1
//-- then return _barColourACT otherwise return _barColourFRC */

```

#### Ternary Operators (kinda like shortcuts)
```jsonc
// ternary operators
"color": {
          "expr": "datum.isYTD_INT == 1 ? _barColourACT : _barColourFRC"
        }
//* 
//• "?" = if the logical test true then return subsequent value...
//• ":" = otherwise return subsequent value
//• eg: "logical test ? return value : return another Value"

//-- plain english: if the value in the [isYTD_INT] field equals 1
//-- then return _barColourACT otherwise return _barColourFRC */
```

We can see what dataset looks like in the Deneb Editor:
![expressions](assets/img/deneb_walkthrough_images/6l_expressions.webp "expressions")
![expressions](assets/img/deneb_walkthrough_images/6m_expressions.webp "expressions")

This is amazing, and when you are able to break it down into digestible chunks 🍪, it’s much easer to …. digest 😅

But what if I don’t want to use a Power Query helper column? What if I want all my “calculated” columns to be derived from the Vega-Lite code itself? Don’t worry… I gotchu!

<p style="text-align: center;">. . .</p>

## 2. Conditional Formatting with in-line Vega-Lite expressions
The next section might seem a bit daunting, but if you can create DAX measures or add Power Query columns, you can definitely create Vega-Lite expressions using [calculate transforms](https://vega.github.io/vega-lite/docs/calculate.html) ([transformations](https://vega.github.io/vega-lite/docs/transform.html)).

The idea of a calculate transform, is very similar to that of a calculated column, a power query column or a measure. We are deriving new data inside of the Vega-Lite dataset which we can then reference for our conditional formatting expressions.

The documentation gives us a framework to build calculate tranfroms:

![expressions](assets/img/deneb_walkthrough_images/6n_expressions.webp "expressions")

Let’s put this into practice. We want to recreate and replace the [isYTD_INT] field with a Vega-Lite [_isYTD] calculated field.

##### Create the calculate transforms
First things first, we want to find out what TODAY() is, and flag a “1” for anything that is on or earlier than TODAY().

This is what TODAY() looks like in Power Query:

```ruby
// Power Query
Date.From( DateTime.FixedLocalNow() )
```

Then to create the flag column, we complete the code:

```ruby
Table.AddColumn(
  #"Inserted Multiplication", 
  "isYTD_INT", 
  each 
    let
      _today  = Date.From(DateTime.FixedLocalNow()), // today variable
      _result = if [Date] <= _today then 1 else 0    // calculation
    in
      _result, 
  Int64.Type
)
```

In Vega-Lite we can do something very similar, first we want to add a transform array object to hold our array of calculate transforms:

```jsonc
"transform": [
  {
    "calculate": "datetime( now()) ",  // transform NOW() into Date format
    "as": "_Today"                     // name this field "_Today"
  },
  {
// if the [Date] field is <= the field value _Today then 1 else 0
    "calculate": "datum['Date'] <= datum._Today ? 1 : 0 ",
    "as": "_isYTD"
  }
]
```

And putting it into context, here is our Spec:

```jsonc
{
  "data": {"name": "dataset"},
  "params": [],
  "transform": [
// date today() transform
    {
      "calculate": "datetime( now()) ",        
      "as": "_Today"
    },
// isYTD transform
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

//* ---------------------------------------------------------------
// if the datum in our calculated tranform field "_isYTD" is 1
// then return our _barColourACT parameter, otherwise _barColourFRC 
// ----------------------------------------------------------------*/

        "color": {
          "expr": "datum._isYTD == 1 ? _barColourACT : _barColourFRC"
        },
//----------------------------------------------------------------
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
    }
  }
}
```

![expressions](assets/img/deneb_walkthrough_images/6o_expressions.webp "expressions")

We can also check how these calculate transform behave within the VL dataset in the Editor’s data viewer:



**Officially MINDBLOWN 🤯🤪!**
I’ve broken down all these steps AND MORE in the PBIX file. I had intended to write more, but I think this is a sensible place to pause for today 😅🙏🏽. So I’ll call this article Part 1. In Part 2 next time, I’ll look at more conditional formatting techniques using the [Condition](https://vega.github.io/vega-lite/docs/condition.html) expression in the Encoding channel.

I hope you find the article useful, thank you for following me on this journey — until next time… **#StayQueryous**


___
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