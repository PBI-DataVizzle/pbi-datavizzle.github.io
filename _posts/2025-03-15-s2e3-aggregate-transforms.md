---
layout: post
title: S2E3 - Aggregates and Facets
date: 2025-03-15 08:37
category: [Season-2, Charts, DataViz, Deneb, Vega-Lite, Walkthrough]
author: [A1, A2]
tags: [season#, walkthrough]
summary: Walkthrough
description: Demystify Vega-Lite Examples in this step-by-step rebuild 🕊️🧙🏼‍♂️✨
image: 
    path: assets/headers/post-headers/s2e3/header.png
    width: 600
    height: 300
    alt: Aggregates and Facets
mermaid: true
published: true
hidden: false
---

> 💌 `PBIX` file available at the end of the article [^fn-pbix]  Enjoy!
{: .prompt-info }

[//]: # Comment first footnoote, can be please anywhere and will display on footer
[^fn-pbix]: PBIX: [Repo - Walkthrough Series](https://github.com/PBI-DataVizzle/pbi_content/tree/main/my_deneb_showcases/deneb_walkthrough_series){: width="700" height="400" }

---

## <i class="fa-solid fa-hat-wizard fa-2x" style="color: blueviolet"></i>&ensp;Intro
Welcome to **Season 2** of the Vega-Lite walkthrough series. In this season, we will go step-by-step through many of the Vega-Lite Examples - learning loads of techniques and tips along the way. Enjoy and welcome! 🕊️

<br>

---

## <i class="fa-solid fa-database fa-2x" style="color: limegreen"></i>&ensp;Data
All data used in this series can be found in the Vega github repo: &emsp; <br> [<i class="fas fa-database"></i>&ensp; Official Vega & Vega-Lite Data Source Repo &ensp; <i class="fas fa-external-link-alt"></i>](https://github.com/vega/vega/tree/main/docs/data)

##### Dataset:
- [cars.json](https://raw.githubusercontent.com/vega/vega/refs/heads/main/docs/data/cars.json)

| **Name**                  | **Origin** | **Horsepower** | **Year**   |
| ------------------------- | ---------- | -------------- | ---------- |
| chevrolet chevelle malibu | USA        | 130            | 1970-01-01 |
| buick skylark 320         | USA        | 165            | 1970-01-01 |
| plymouth satellite        | USA        | 150            | 1970-01-01 |
| amc rebel sst             | USA        | 150            | 1970-01-01 |
| ford torino               | USA        | 140            | 1970-01-01 |
| ford galaxie 500          | USA        | 198            | 1970-01-01 |
| chevrolet impala          | USA        | 220            | 1970-01-01 |


<p style="text-align: center;">. . .</p> 

bold text

## <i class="fa-solid fa-brain fa-2x" style="color: hotpink"></i>&ensp;Concept
Here is the concept we will rebuild and better understand. The full script can be expanded below.
<html>
<div id="vis_concept"></div>
  <script type="text/javascript">
    var spec = {
"$schema": "https://vega.github.io/schema/vega-lite/v5.json",
  "description": "A showcase of the aggregate transform",
  "data": {
    "url": "https://raw.githubusercontent.com/vega/vega/refs/heads/main/docs/data/cars.json"
  },
  "transform": [
    {
      "aggregate": [
        {
          "op": "distinct",
          "field": "Name",
          "as": "distinct_count"
        },
        {
          "op": "count",
          "field": "__row_number__",
          "as": "normal_count"
        },
        {
          "op": "mean",
          "field": "Horsepower",
          "as": "mean_calc"
        },
        {
          "op": "median",
          "field": "Horsepower",
          "as": "median_calc"
        },
        {
          "op": "min",
          "field": "Horsepower",
          "as": "min_calc"
        },
        {
          "op": "max",
          "field": "Horsepower",
          "as": "max_calc"
        },
        {
          "op": "missing",
          "field": "Name",
          "as": "missing_calc"
        },
        {
          "op": "valid",
          "field": "Name",
          "as": "valid_calc"
        }
      ],
      "groupby": [
        "Origin"
      ]
    },
    {
      "calculate": "round(datum.mean_calc)", "as": "mean_calc"
    }
  ],
  "hconcat": [
    {
      "title": "NORMAL COUNT",
      "width": 200,
      "layer": [
        {
          "mark": {
            "type": "bar"
          }
        },
        {
          "mark": {
            "type": "text",
            "fontWeight": 900,
            "fontSize": 14,
            "dy": -10
          }
        }
      ],
      "encoding": {
        "y": {
          "field": "normal_count",
          "type": "quantitative"
        },
        "x": {
          "field": "Origin",
          "type": "nominal"
        },
        "text": {
          "field": "normal_count",
          "type": "quantitative"
        }
      }
    },
    {
      "title": "DISTINCT COUNT",
      "width": 200,
      "layer": [
        {
          "mark": {
            "type": "bar"
          }
        },
        {
          "mark": {
            "type": "text",
            "fontWeight": 900,
            "fontSize": 14,
            "dy": -10
          }
        }
      ],
      "encoding": {
        "y": {
          "field": "distinct_count",
          "type": "quantitative"
        },
        "x": {
          "field": "Origin",
          "type": "nominal"
        },
        "text": {
          "field": "distinct_count",
          "type": "quantitative"
        }
      }
    },   
    {
      "title": "MEAN",
      "width": 200,
      "layer": [
        {
          "mark": {
            "type": "bar"
          }
        },
        {
          "mark": {
            "type": "text",
            "fontWeight": 900,
            "fontSize": 14,
            "dy": -10
          }
        }
      ],
      "encoding": {
        "y": {
          "field": "mean_calc",
          "type": "quantitative"
        },
        "x": {
          "field": "Origin",
          "type": "nominal"
        },
        "text": {
          "field": "mean_calc",
          "type": "quantitative",
          "format": ".0~f"
        }
      }
    },
    {
      "title": "MEDIAN",
      "width": 200,
      "layer": [
        {
          "mark": {
            "type": "bar"
          }
        },
        {
          "mark": {
            "type": "text",
            "fontWeight": 900,
            "fontSize": 14,
            "dy": -10
          }
        }
      ],
      "encoding": {
        "y": {
          "field": "median_calc",
          "type": "quantitative"
        },
        "x": {
          "field": "Origin",
          "type": "nominal"
        },
        "text": {
          "field": "median_calc",
          "type": "quantitative",
          "format": ".0~f"
        }
      }
    },
  ]
};
    vegaEmbed('#vis_concept', spec);
  </script>
</html>

> **Important Note: Viewing Vega/Vega-Lite Outputs** <br>
> When opening in the Vega Online Editor, remember to delete the raw path url before /data/. Examples: <br>
> 
> **Github pages:** <br> • "data": {"url": "https://raw.githubusercontent.com/vega/vega/refs/heads/main/docs/data/cars.json"} <br>
> 
> **For online editor:** <br> • "data": {"url": "data/cars.json} <br>
> 
> **For PowerBI:** <br> • "data": {"name": "dataset"} <br>
{: .prompt-warning }




{::options parse_block_html="true" /}
<details><summary markdown="span"><b><i class="fa-solid fa-laptop-code" aria-hidden="true" style="color: orange"></i>&ensp;Reveal Vega-Lite Spec: </b></summary>

```jsonc
{
  "$schema": "https://vega.github.io/schema/vega-lite/v5.json",
  "description": "Multi-series line chart with labels and interactive highlight on hover.  We also set the selection's initial value to provide a better screenshot",
  "width": 600,
  "height": 300,
  /* when opening in the Vega Online Editor, remember to delete the raw path url before /data/ */
  /* • eg: for online editor | "data": {"url": "data/stocks.csv"} */
  /* • eg: for PowerBI | "data": {"name": "dataset"} */
  "data": {"url": "data/cars.csv"},
  // transforms
  "transform": [
    {
      "aggregate": [
        {
          "op": "distinct",
          "field": "Name",
          "as": "distinct_count"
        },
        {
          "op": "count",
          "field": "__row_number__",
          "as": "normal_count"
        },
        {
          "op": "mean",
          "field": "Horsepower",
          "as": "mean_calc"
        },
        {
          "op": "median",
          "field": "Horsepower",
          "as": "median_calc"
        },
        {
          "op": "min",
          "field": "Horsepower",
          "as": "min_calc"
        },
        {
          "op": "max",
          "field": "Horsepower",
          "as": "max_calc"
        },
        {
          "op": "missing",
          "field": "Name",
          "as": "missing_calc"
        },
        {
          "op": "valid",
          "field": "Name",
          "as": "valid_calc"
        }
      ],
      "groupby": [
        "Origin"
      ]
    },
    {
      "calculate": "round(datum.mean_calc)", "as": "mean_calc"
    }
  ],
  "hconcat": [
    {
      "title": "NORMAL COUNT",
      "width": 200,
      "layer": [
        {
          "mark": {
            "type": "bar"
          }
        },
        {
          "mark": {
            "type": "text",
            "fontWeight": 900,
            "fontSize": 14,
            "dy": -10
          }
        }
      ],
      "encoding": {
        "y": {
          "field": "normal_count",
          "type": "quantitative"
        },
        "x": {
          "field": "Origin",
          "type": "nominal"
        },
        "text": {
          "field": "normal_count",
          "type": "quantitative"
        }
      }
    },
    {
      "title": "DISTINCT COUNT",
      "width": 200,
      "layer": [
        {
          "mark": {
            "type": "bar"
          }
        },
        {
          "mark": {
            "type": "text",
            "fontWeight": 900,
            "fontSize": 14,
            "dy": -10
          }
        }
      ],
      "encoding": {
        "y": {
          "field": "distinct_count",
          "type": "quantitative"
        },
        "x": {
          "field": "Origin",
          "type": "nominal"
        },
        "text": {
          "field": "distinct_count",
          "type": "quantitative"
        }
      }
    },   
    {
      "title": "MEAN",
      "width": 200,
      "layer": [
        {
          "mark": {
            "type": "bar"
          }
        },
        {
          "mark": {
            "type": "text",
            "fontWeight": 900,
            "fontSize": 14,
            "dy": -10
          }
        }
      ],
      "encoding": {
        "y": {
          "field": "mean_calc",
          "type": "quantitative"
        },
        "x": {
          "field": "Origin",
          "type": "nominal"
        },
        "text": {
          "field": "mean_calc",
          "type": "quantitative",
          "format": ".0~f"
        }
      }
    },
    {
      "title": "MEDIAN",
      "width": 200,
      "layer": [
        {
          "mark": {
            "type": "bar"
          }
        },
        {
          "mark": {
            "type": "text",
            "fontWeight": 900,
            "fontSize": 14,
            "dy": -10
          }
        }
      ],
      "encoding": {
        "y": {
          "field": "median_calc",
          "type": "quantitative"
        },
        "x": {
          "field": "Origin",
          "type": "nominal"
        },
        "text": {
          "field": "median_calc",
          "type": "quantitative",
          "format": ".0~f"
        }
      }
    },
  ],
  "config": {"view": {"stroke": null}}
}
```

</details>
{::options parse_block_html="false" /}

***

<p style="text-align: center;">. . .</p> 

## <i class="fa-solid fa-person-digging fa-2x" style="color: darkorange"></i>&ensp;Build

### Step 1: What is the Aggregate transformation
In simple terms, the [aggregate transform](https://vega.github.io/vega-lite/docs/aggregate.html) alters your dataset and summarises your data table by the groups defined in the aggregate `groupby` property.

There are wide range of [aggregate operations](https://vega.github.io/vega-lite/docs/aggregate.html#ops) available. We won't look at all of them today, but we will focus on a few key operaitons... just enough to wet our whistles, such as:

- count
- distinct
- sum
- mean
- median


### Step 2: Observe Aggregate transform behaviours

The first thing that will help us understand how Transforms work in Vega-Lite is to observe their behaviours on our dataset.

Let's create a VL spec with no encoding, we will pay particular attention to the `DATA VIEWER` window in the **Editor**:

#### Single Aggregate Operation

```jsonc
{
  "data": {
    "url": "data/cars.json"
  },
  // transform array
  "transform": [
    {
      // aggregation propery
      "aggregate": [
        {
          "op": "count",            // the aggregate operation
          "field": "Name",          // the field we are aggregating
          "as": "standard_count"    // the name of our aggregate 'measure'
        }
      ],
      "groupby": []                 // the groupby property (currently empty)
    }
  ],
	"title": "Aggregates",
	"layer": [
	{
		"mark": {
		"type": "bar"
		}
	}
	]
}
```

In the Data Viewer, you will see the 

| standard_count |
| -------------- |
| 406            |


![Aggregates](assets/img/deneb_walkthrough_images/s2e3/img1.png "Aggregates")

As we've used the aggregate's `count` operation and we aren't grouping any fields, we return the result 406, as there are 406 rows in our dataset.

Taking it a step further, we can actually take this a step further an introduce multiple aggregations in a single dataset. 

<br>

#### Multiple Aggregate Operations

```jsonc

{
  "data": {
    "url": "data/cars.json"
  },
  // transform array
  "transform": [
    {
      // aggregation propery
      "aggregate": [
        {
          "op": "count",                // standard count Op
          "field": "Name",              // [Name] field
          "as": "standard_count"        // aggregate 1: count
        },
		{
          "op": "distinct",             // distinct count Op
          "field": "Name",              // [Name] field
          "as": "distinct_count"        // aggregate 2: distinct count
        }
      ],
      "groupby": []                     // no groupby (yet)
    }
  ],
	"title": "Aggregates",
	"layer": [
	{
		"mark": {
		"type": "bar"
		}
	}
	]
}

```

In our Data Viewer, we now see the following results:

| standard_count | distinct_count |
| -------------- | -------------- |
| 406            | 311            |


Let's go even further, and add both `mean` and `median` operations:

```jsonc
"transform": [
    {
        "op": "mean",
        "field": "Horsepower",
        "as": "mean_horsepower"
    },
    {
        "op": "median",
        "field": "Horsepower",
        "as": "median_horsepower"
    }
]
```


| standard_count | distinct_count | mean_horsepower | median_horsepower |
| -------------- | -------------- | --------------- | ----------------- |
| 406            | 311            | 105.08          | 95                |


<br>

#### Inputting GroupBy field

Now, we want to use the `groupby` property to summarise our result by the `Origin` field:


```jsonc

{
  "data": {
    "url": "data/cars.json"
  },
  // transform array
  "transform": [
    {
      // aggregation propery
      "aggregate": [
        {
          "op": "count",
          "field": "Name",
          "as": "standard_count"	// aggregate 1
        },
		{
          "op": "distinct",
          "field": "Name",
          "as": "distinct_count"	// aggregate 2
        },
		{
          "op": "mean",
          "field": "Horsepower",
          "as": "mean_horsepower"	// aggregate 3
        },
		{
          "op": "median",
          "field": "Horsepower",
          "as": "median_horsepower"	// aggregate 4
        }
      ],
      "groupby": ["Origin"]			//<-- group by property
    }
  ],
	"title": "Aggregates",
	"layer": [
	{
		"mark": {
		"type": "bar"
		}
	}
	]
}

```

And now we begin to see our data outputs taking shape:
*Note: each aggregate result summarises effortlessly against the `[Origin]` field*

| **Origin** | **standard_count** | **distinct_count** | **mean_horsepower** | **median_horsepower** |
| ---------- | ------------------ | ------------------ | ------------------- | --------------------- |
| USA        | 254                | 191                | 119.9               | 106                   |
| Europe     | 73                 | 61                 | 80.9                | 77                    |
| Japan      | 79                 | 59                 | 79.8                | 75                    |






<html>
<div id="vis_grouped"></div>
  <script type="text/javascript">
    var spec = {
  "data": {
    "url": "https://raw.githubusercontent.com/vega/vega/refs/heads/main/docs/data/cars.json"
  },
  "transform": [
    {
      "aggregate": [
        {
          "op": "count",
          "field": "Name",
          "as": "standard_count"	
        },
		{
          "op": "distinct",
          "field": "Name",
          "as": "distinct_count"	
        },
		{
          "op": "mean",
          "field": "Horsepower",
          "as": "mean_horsepower"	
        },
		{
          "op": "median",
          "field": "Horsepower",
          "as": "median_horsepower"	
        }
      ],
      "groupby": ["Origin"]			
    }
  ],
	"title": "Aggregates",
	"width": 150,
	"layer": [
	{
		"mark": {
		"type": "bar"
		},
		"encoding": {
			"x": {
				"field": "Origin",
				"type": "nominal"
			},
			"y": {
				"field": "standard_count",
				"type": "quantitative"

			}
		}
	}
	]
};
    vegaEmbed('#vis_grouped', spec);
  </script>
</html>


<br>

### Step 3: Small Multiples

So far so good, and not a DAX measure in sight 🤓

What would be pretty cool now, is if we could separate our four aggregations into four separate charts, in the style of small multiples. It's tantalisingly easy... follow me!

There are several ways to achieve the affect of small multiples using combinations of [view layering and concatenations](https://vega.github.io/vega-lite/docs/composition.html):
 - [hconcat](https://vega.github.io/vega-lite/docs/concat.html#hconcat)
 - [vconcat](https://vega.github.io/vega-lite/docs/concat.html#vconcat)
 - [repeat](https://vega.github.io/vega-lite/docs/repeat.html)

For ease and flexibility, I'll showcase `repeat` here. But the PBIX [^fn-pbix] attached contains all varieties 🧙🏼‍♂️

I'll write the before and after JSONs for comparison. The main difference is we wrap our mark and encoding block withing a `spec` block:

##### repeat and spec
```jsonc
{
  "repeat": [],
  "spec": { "mark":{}, "encoding":{} }
}
```

#### Pre-small multiples
```jsonc
{ 
  "data": {"url": "https://raw.githubusercontent.com/vega/vega/refs/heads/main/docs/data/cars.json"},
  "transform": [
    {
      "aggregate": [
        {"op": "count", "field": "Name", "as": "standard_count"},
        {"op": "distinct", "field": "Name", "as": "distinct_count"},
        {"op": "mean", "field": "Horsepower", "as": "mean_horsepower"},
        {"op": "median", "field": "Horsepower", "as": "median_horsepower"}
      ],
      "groupby": ["Origin"]
    }
  ],
   "title": {"text": "Aggregates and Facets", "anchor": "middle"},
  "width": 150,
  "mark": {"type": "bar"},
  "encoding": {
    "x": {
		"field": "Origin", 
		"type": "nominal"
	},
    "y": {
		"field": "mean_horsepower", 
		"type": "quantitative"
	}
  }
}
```

#### Post-small mulitples

```jsonc

{
  "data": {"url": "data/cars.json"},
  "transform": [
	// Our four aggregate transforms
    {
      "aggregate": [
        {"op": "count", "field": "Name", "as": "standard_count"},
        {"op": "distinct", "field": "Name", "as": "distinct_count"},
        {"op": "mean", "field": "Horsepower", "as": "mean_horsepower"},
        {"op": "median", "field": "Horsepower", "as": "median_horsepower"}
      ],
      "groupby": ["Origin"]
    }
  ],
  // start the repeat operation
  "repeat": [
    "standard_count",
    "distinct_count",
    "mean_horsepower",
    "median_horsepower"
  ],
  "spacing": 10,    // the spacing between charts
  "title": {"text": "Aggregates and Facets", "anchor": "middle"},
  "spec": {                             // wrap the mark properties in spec
    "width": 95,
    "height": 85,
    "mark": "bar",
    "encoding": {
      "x": {
        "field": "Origin",              // x-axis is unchange
        "sort": {"field": "Origin"},
        "axis": {"labels": true}
      },
      "y": {
        "field": {"repeat": "repeat"},  // y-axis uses the repeat fields instead of calculated fields
        "axis": {"labels": true},
        "type": "quantitative"
      },
    }
  },
  "resolve": {"scale": {"y": "shared"}} //
}

```

We now get this magical result:

<html>
<div id="vis_final"></div>
  <script type="text/javascript">
    var spec = {
  "$schema": "https://vega.github.io/schema/vega-lite/v5.json",
  "data": {"url": "https://raw.githubusercontent.com/vega/vega/refs/heads/main/docs/data/cars.json"},
  "transform": [
    {
      "aggregate": [
        {"op": "count", "field": "Name", "as": "standard_count"},
        {"op": "distinct", "field": "Name", "as": "distinct_count"},
        {"op": "mean", "field": "Horsepower", "as": "mean_horsepower"},
        {"op": "median", "field": "Horsepower", "as": "median_horsepower"}
      ],
      "groupby": ["Origin"]
    }
  ],
  "repeat": [
    "standard_count",
    "distinct_count",
    "mean_horsepower",
    "median_horsepower"
  ],
  "spacing": 10,   
  "title": {"text": "Aggregates and Facets", "anchor": "middle"},
  "spec": {                            
    "width": 120,
    "height": 100,
    "mark": "bar",
    "encoding": {
      "x": {
        "field": "Origin",              
        "sort": {"field": "Origin"},
        "axis": {"labels": true}
      },
      "y": {
        "field": {"repeat": "repeat"},  
        "axis": {"labels": true},
        "type": "quantitative"
      },
    }
  },
  "resolve": {"scale": {"y": "shared"}}
};
    vegaEmbed('#vis_final', spec);
  </script>
</html>


<br>

### Step 4: Finishing touches

We are close to perfection, we just want to add a splash of colour. We've been here before, just a simple `"color": {"field": "Origin"}` property in our `encoding` block.


<html>
<div id="vis_final2"></div>
  <script type="text/javascript">
    var spec = {
  "$schema": "https://vega.github.io/schema/vega-lite/v5.json",
  "data": {"url": "https://raw.githubusercontent.com/vega/vega/refs/heads/main/docs/data/cars.json"},
  "transform": [
    {
      "aggregate": [
        {"op": "count", "field": "Name", "as": "standard_count"},
        {"op": "distinct", "field": "Name", "as": "distinct_count"},
        {"op": "mean", "field": "Horsepower", "as": "mean_horsepower"},
        {"op": "median", "field": "Horsepower", "as": "median_horsepower"}
      ],
      "groupby": ["Origin"]
    }
  ],
  "repeat": [
    "standard_count",
    "distinct_count",
    "mean_horsepower",
    "median_horsepower"
  ],
  "spacing": 10,   
  "title": {"text": "Aggregates and Facets", "anchor": "middle"},
  "spec": {                            
    "width": 120,
    "height": 100,
    "mark": "bar",
    "encoding": {
      "x": {
        "field": "Origin",              
        "sort": {"field": "Origin"},
        "axis": {"labels": true}
      },
      "y": {
        "field": {"repeat": "repeat"},  
        "axis": {"labels": true},
        "type": "quantitative"
      },
      "color": {"field": "Origin"}
    }
  },
  "resolve": {"scale": {"y": "shared"}}
};
    vegaEmbed('#vis_final2', spec);
  </script>
</html>

<br>

*Chef's Kiss et voilà!* 🧑🏽‍🍳

***

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
