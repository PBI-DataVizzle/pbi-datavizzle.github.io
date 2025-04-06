---
layout: post
title: S2E4 - Join Aggregate Transform
date: 2025-04-06 09:24
category: [Season-2, Charts, DataViz, Deneb, Vega-Lite, Walkthrough]
author: [A1, A2]
tags: [season2, walkthrough]
summary: Walkthrough
description: Demystify Vega-Lite Examples in this step-by-step rebuild 🕊️🧙🏼‍♂️✨
image: 
    path: assets/headers/post-headers/s2e4/s2e4_header.png
    width: 600
    height: 300
    alt: Join Aggregate
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

<br>

##### (Summarised & Aggregated)

| **Origin** | **Count** | **Distinct Count** |
| ---------- | --------- | ------------------ |
| USA        | 253       | 191                |
| Europe     | 73        | 61                 |
| Japan      | 79        | 59                 |



<p style="text-align: center;">. . .</p> 

## <i class="fa-solid fa-brain fa-2x" style="color: hotpink"></i>&ensp;Concept
Here is the concept we will rebuild and better understand. The full script can be expanded below.

<html>
<div id="vis_grouped"></div>
  <script type="text/javascript">
    var spec = {
  "data": {"url": "https://raw.githubusercontent.com/vega/vega/refs/heads/main/docs/data/cars.json"},
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
        }
      ],
      "groupby": [
        "Origin"
      ]
    },
    {
      "joinaggregate": [
        {
          "op": "sum",
          "field": "distinct_count",
          "as": "distinct_count_ja"
        },
        {
          "op": "sum",
          "field": "normal_count",
          "as": "normal_count_ja"
        }
      ],
      "groupby": []
    },
    {
      "calculate": "(datum.normal_count / datum.normal_count_ja)",
      "as": "normal_count_pct"
    },
    {
      "calculate": "(datum.distinct_count / datum.distinct_count_ja)",
      "as": "distinct_count_pct"
    }
  ],
  "hconcat": [
    {
      "title": "NORMAL COUNT",
      "width": 150,
      "layer": [
        {
          "mark": {
            "type": "bar",
            "strokeWidth": 0.8,
            "stroke": "black"
          }
        },
        {
          "mark": {
            "type": "text",
            "baseline": "middle",
            "fill": "black",
            "fontWeight": 900,
            "fontSize": 14
          },
          "encoding": {
            "y": {
              "field": "normal_count_pct",
              "bandPosition": 0.5,
              "type": "quantitative"
            }
          }
        }
      ],
      "encoding": {
        "y": {
          "field": "normal_count_pct",
          "type": "quantitative",
          "aggregate": "sum",
          "stack": "normalize"
        },
        "order": {
          "field": "normal_count_pct",
          "sort": "descending"          
        },
        "color": {
          "field": "Origin",
          "type": "nominal",
          "scale": {
            "scheme":"pastel1"
          }
        },
        "text": {
          "field": "normal_count_pct",
          "type": "quantitative",
          "format": "0.1%"
        },
        "detail": {
          "field": "Origin"
        }
      }
    },
    {
      "title": "DISTINCT COUNT",
      "width": 150,
      "layer": [
        {
          "mark": {
            "type": "bar",
            "strokeWidth": 0.8,
            "stroke": "black"
          }
        },
        {
          "mark": {
            "type": "text",
            "baseline": "middle",
            "fill": "black",
            "fontWeight": 900,
            "fontSize": 14
          },
          "encoding": {
            "y": {
              "field": "distinct_count_pct",
              "bandPosition": 0.5,
              "type": "quantitative"
            }
          }
        }
      ],
      "encoding": {
        "y": {
          "field": "distinct_count_pct",
          "type": "quantitative",
          "aggregate": "sum",
          "stack": "normalize"
        },
        "order": {
          "field": "distinct_count_pct",
          "sort": "descending"          
        },
        "color": {
          "field": "Origin",
          "type": "nominal",
          "scale": {
            "scheme":"pastel1"
          }
        },
        "text": {
          "field": "distinct_count_pct",
          "type": "quantitative",
          "format": "0.1%"
        },
        "detail": {
          "field": "Origin"
        }
      }
    }
  ]
};
    vegaEmbed('#vis_grouped', spec);
  </script>
</html>

> **Important Note: Viewing Vega/Vega-Lite Outputs** <br>
> When opening in the Vega Online Editor, remember to delete the raw path url before /data/. Examples: <br>
> 
> **Github pages:** <br> • "data": {"url": "https://raw.githubusercontent.com/vega/vega/refs/heads/main/docs/data/stocks.csv"} <br>
> 
> **For online editor:** <br> • "data": {"url": "data/stocks.csv} <br>
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
  "data": {
    "name": "dataset"
  },
  // transforms
  "transform": [
    {
      /* we can add multiple aggregate operations */
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
        }
      ],
      "groupby": [
        "Origin"
      ]
    },
    {
      /* we can add multiple aggregate operations */
      "joinaggregate": [
        {
          "op": "sum",
          "field": "distinct_count",
          "as": "distinct_count_ja"
        },
        {
          "op": "sum",
          "field": "normal_count",
          "as": "normal_count_ja"
        }
      ],
      "groupby": []
    },
    {
      "calculate": "(datum.normal_count / datum.normal_count_ja)",
      "as": "normal_count_pct"
    },
    {
      "calculate": "(datum.distinct_count / datum.distinct_count_ja)",
      "as": "distinct_count_pct"
    }
  ],
  
  "hconcat": [
    {
      "title": "NORMAL COUNT",
      "width": 150,
      "layer": [
        {
          "mark": {
            "type": "bar",
            "strokeWidth": 0.8,
            "stroke": "black"
          }
        },
        {
          "mark": {
            "type": "text",
            "baseline": "middle",
            "fill": "black",
            "fontWeight": 900,
            "fontSize": 14
            //"dy": 20
          },
          "encoding": {
            "y": {
              "field": "normal_count_pct",
              "bandPosition": 0.5,
              "type": "quantitative"
            }
          }
        }
      ],
      "encoding": {
        "y": {
          "field": "normal_count_pct",
          "type": "quantitative",
          "aggregate": "sum",
          "stack": "normalize"
        },
        "order": {
          "field": "normal_count_pct",
          "sort": "descending"          
        },
        "color": {
          "field": "Origin",
          "type": "nominal",
          "scale": {
            "scheme":"pastel1"
          }
        },
        "text": {
          "field": "normal_count_pct",
          "type": "quantitative",
          "format": "0.1%"
        },
        "detail": {
          "field": "Origin"
        }
      }
    },
    {
      "title": "DISTINCT COUNT",
      "width": 150,
      "layer": [
        {
          "mark": {
            "type": "bar",
            "strokeWidth": 0.8,
            "stroke": "black"
          }
        },
        {
          "mark": {
            "type": "text",
            "baseline": "middle",
            "fill": "black",
            "fontWeight": 900,
            "fontSize": 14
            //"dy": 20
          },
          "encoding": {
            "y": {
              "field": "distinct_count_pct",
              "bandPosition": 0.5,
              "type": "quantitative"
            }
          }
        }
      ],
      "encoding": {
        "y": {
          "field": "distinct_count_pct",
          "type": "quantitative",
          "aggregate": "sum",
          "stack": "normalize"
        },
        "order": {
          "field": "distinct_count_pct",
          "sort": "descending"          
        },
        "color": {
          "field": "Origin",
          "type": "nominal",
          "scale": {
            "scheme":"pastel1"
          }
        },
        "text": {
          "field": "distinct_count_pct",
          "type": "quantitative",
          "format": "0.1%"
        },
        "detail": {
          "field": "Origin"
        }
      }
    }
  ]
}
```

</details>
{::options parse_block_html="false" /}

***

<p style="text-align: center;">. . .</p> 

## <i class="fa-solid fa-person-digging fa-2x" style="color: darkorange"></i>&ensp;Build

### Step 1: What is the Join Aggregate Transformation?
It's actually harder to explain than it is to show 🤓 - but I will try to do both and hope it makes sense.  The easiest way to look at it is that [Join Aggregate](https://vega.github.io/vega-lite/docs/joinaggregate.html) is similar to the [Aggregate](https://vega.github.io/vega-lite/docs/aggregate.html) function. The BIG difference is that instead of transforming your dataset entirely, it takes the RESULT of your AGGREGATED dataset and JOINS it back onto your existing dataset. 

For example:
We take the original dataset...

| **Name**                  | **Origin** | **Horsepower** | **Year**   |
| ------------------------- | ---------- | -------------- | ---------- |
| chevrolet chevelle malibu | USA        | 130            | 1970-01-01 |
| buick skylark 320         | USA        | 165            | 1970-01-01 |
| plymouth satellite        | USA        | 150            | 1970-01-01 |
| amc rebel sst             | USA        | 150            | 1970-01-01 |

<br>

Then with `Aggregate Transform,` our dataset is transformed returning `count` and `distinct count` columns. The original dataset is transformed and summarised.

So `Aggregate` takes us from this...

```jsonc
{
      /* we can add multiple aggregate operations */
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
        }
      ],
      /* Note: Groupby field is necessary here*/
      "groupby": [
        "Origin"
      ]
    }
```

| **Origin** | **Count** | **Distinct Count** |
| ---------- | --------- | ------------------ |
| USA        | 253       | 191                |
| Europe     | 73        | 61                 |
| Japan      | 79        | 59                 |

...becomes this:

```jsonc
/* we can add multiple aggregate operations */
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
        }
      ],
      /* Note: Groupby field is not needed as we need the grand total*/
      "groupby": []
    }
```

| **Total Count** | **Distinct Count** |
| --------------- | ------------------ |
| 311             | 405                |

Due to the summarisation, we have lost the Origin field detail.

<br>



Note how this differs to `Join Aggregate`. Now we can summarise the grand totals and join the result back onto the original dataset, which gives us the following:

```jsonc
{
      /* we can add multiple aggregate operations */
      "joinaggregate": [
        {
          "op": "sum",
          "field": "distinct_count",
          "as": "distinct_count_ja"
        },
        {
          "op": "sum",
          "field": "normal_count",
          "as": "normal_count_ja"
        }
      ],
      "groupby": []
    }
```

| **Origin** | **Count** | **Total Count** | **Distinct Count** | **Total Distinct Count** |
| ---------- | --------- | --------------- | ------------------ | ------------------------ |
| USA        | 253       | 311             | 191                | 405                      |
| Europe     | 73        | 311             | 61                 | 405                      |
| Japan      | 79        | 311             | 59                 | 405                      |

<br>


### Step 2: How is this useful?
This is the key question. When and why would we use this? There are several use cases, but the most useful one I have found is calculation the **percentage of the total**. 

Returning to our `Join Aggregate` dataset, we have our numerator (counts) and with join aggregate transforms we now have our denominator (total counts). With these two fields, we can now determine each rows value and what the percentage is of the grand total.

### Step 3: Derive the Percentage (of Total)

We've been here before, this is our bread 🍞 and butter 🧈 calculate transform:

```jsonc
"transform": [{
  "calculate": " ( datum.numerator / datum.denominator )", "as": "percentage_field"
}] 
```

In context, we will reuse the results of our previous `Aggregate` and `Join Aggregate` transforms:

```jsonc
"transforms": [
    {
      "calculate": "(datum.normal_count / datum.normal_count_ja)",
      "as": "normal_count_pct"
    },
    {
      "calculate": "(datum.distinct_count / datum.distinct_count_ja)",
      "as": "distinct_count_pct"
    }
]

```

##### *(separated for emphasis)*

| **Origin** | **Count** | **Total Count** | **Normal Count PCT** |
| ---------- | --------- | --------------- | -------------------- |
| USA        | 253       | 311             | 0.624                |
| Europe     | 73        | 311             | 0.180                |
| Japan      | 79        | 311             | 0.195                |

| **Origin** | **Distinct** | **Total Distinct Count** | **Distinct Count PCT** |
| ---------- | ------------ | ------------------------ | ---------------------- |
| USA        | 191          | 405                      | 0.614                  |
| Europe     | 61           | 405                      | 0.196                  |
| Japan      | 59           | 405                      | 0.189                  |

<br>


### Step 4: Create our DataViz

This is our moment to piece everything together. Noone can stop this freight train 🚄

![Join Aggregate](assets/headers/post-headers/s2e4/title.png "Join Aggregate")


<html>
<div id="vis_final2"></div>
  <script type="text/javascript">
    var spec = {
  "$schema": "https://vega.github.io/schema/vega-lite/v5.json",
  "description": "A showcase of the aggregate transform",
   "data": {"url": "https://raw.githubusercontent.com/vega/vega/refs/heads/main/docs/data/cars.json"},
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
        }
      ],
      "groupby": [
        "Origin"
      ]
    },
    {
      "joinaggregate": [
        {
          "op": "sum",
          "field": "distinct_count",
          "as": "distinct_count_ja"
        },
        {
          "op": "sum",
          "field": "normal_count",
          "as": "normal_count_ja"
        }
      ],
      "groupby": []
    },
    {
      "calculate": "(datum.normal_count / datum.normal_count_ja)",
      "as": "normal_count_pct"
    },
    {
      "calculate": "(datum.distinct_count / datum.distinct_count_ja)",
      "as": "distinct_count_pct"
    }
  ],
  "hconcat": [
    {
      "title": "NORMAL COUNT",
      "width": 150,
      "layer": [
        {
          "mark": {
            "type": "bar",
            "strokeWidth": 0.8,
            "stroke": "black"
          }
        },
        {
          "mark": {
            "type": "text",
            "baseline": "middle",
            "fill": "black",
            "fontWeight": 900,
            "fontSize": 14
          },
          "encoding": {
            "y": {
              "field": "normal_count_pct",
              "bandPosition": 0.5,
              "type": "quantitative"
            }
          }
        }
      ],
      "encoding": {
        "y": {
          "field": "normal_count_pct",
          "type": "quantitative",
          "aggregate": "sum",
          "stack": "normalize"
        },
        "order": {
          "field": "normal_count_pct",
          "sort": "descending"          
        },
        "color": {
          "field": "Origin",
          "type": "nominal",
          "scale": {
            "scheme":"pastel1"
          }
        },
        "text": {
          "field": "normal_count_pct",
          "type": "quantitative",
          "format": "0.1%"
        },
        "detail": {
          "field": "Origin"
        }
      }
    },
    {
      "title": "DISTINCT COUNT",
      "width": 150,
      "layer": [
        {
          "mark": {
            "type": "bar",
            "strokeWidth": 0.8,
            "stroke": "black"
          }
        },
        {
          "mark": {
            "type": "text",
            "baseline": "middle",
            "fill": "black",
            "fontWeight": 900,
            "fontSize": 14
          },
          "encoding": {
            "y": {
              "field": "distinct_count_pct",
              "bandPosition": 0.5,
              "type": "quantitative"
            }
          }
        }
      ],
      "encoding": {
        "y": {
          "field": "distinct_count_pct",
          "type": "quantitative",
          "aggregate": "sum",
          "stack": "normalize"
        },
        "order": {
          "field": "distinct_count_pct",
          "sort": "descending"          
        },
        "color": {
          "field": "Origin",
          "type": "nominal",
          "scale": {
            "scheme":"pastel1"
          }
        },
        "text": {
          "field": "distinct_count_pct",
          "type": "quantitative",
          "format": "0.1%"
        },
        "detail": {
          "field": "Origin"
        }
      }
    }
  ]
};
    vegaEmbed('#vis_final2', spec);
  </script>
</html>

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
