---
# the default layout is 'page'
icon: fa solid fa-poo
order: 5
---

# chart blocks

<html>
  <head>
    <title>Embedding Vega-Lite</title>
    <script src="https://cdn.jsdelivr.net/npm/vega@5.30.0"></script>
    <script src="https://cdn.jsdelivr.net/npm/vega-lite@5.21.0"></script>
    <script src="https://cdn.jsdelivr.net/npm/vega-embed@6.26.0"></script>
  </head>
<body>
<div id="vis"></div>
<script type="text/javascript">
  var spec = "https://gist.githubusercontent.com/PBI-DataVizzle/6edc92e911fe8c455bb306a1fba6d5a4/raw/e336062e52712a6f83c1c2acd0f9a7d666f87fae/vega_lite_dot_nov24_spec.json";
  vegaEmbed('#vis', spec).then(function(result) {
    // Access the Vega view instance (https://vega.github.io/vega/docs/api/view/) as result.view
  }).catch(console.error);
</script>
</body>
</html>
  
<br>
<br>

<html>

  <body>
    <div id="vis3"></div>

    <script type="text/javascript">
      var yourVlSpec = {
        $schema: 'https://vega.github.io/schema/vega-lite/v5.json',
        description: 'A simple bar chart with embedded data.',
        data: {
          values: [
            {a: 'A', b: 28},
            {a: 'B', b: 55},
            {a: 'C', b: 43},
            {a: 'D', b: 91},
            {a: 'E', b: 81},
            {a: 'F', b: 53},
            {a: 'G', b: 19},
            {a: 'H', b: 87},
            {a: 'I', b: 52}
          ]
        },
        mark: 'bar',
        encoding: {
          x: {field: 'a', type: 'ordinal'},
          y: {field: 'b', type: 'quantitative'}
        }
      };
      vegaEmbed('#vis3', yourVlSpec);
    </script>
  </body>
</html>


<br>

<html>

  <body>
    <div id="vis2"></div>

    <script type="text/javascript">
      var yourVlSpec = {
        $schema: 'https://vega.github.io/schema/vega-lite/v5.json',
        description: 'A simple bar chart with embedded data.',
        data: {
          values: [
            {a: 'A', b: 15},
            {a: 'B', b: 12},
            {a: 'C', b: 10},
            {a: 'D', b: 10},
            {a: 'E', b: 6},
            {a: 'F', b: 13},
            {a: 'G', b: 19},
            {a: 'H', b: 21},
            {a: 'I', b: 10}
          ]
        },
        width: 350,
        height: 200,
        mark: 'bar',
        encoding: {
          x: {field: 'a', type: 'ordinal'},
          y: {field: 'b', type: 'quantitative'}
        }
      };
      vegaEmbed('#vis2', yourVlSpec);
    </script>
  </body>
</html>


# Prompt Blocks
text new text here

## subsection
text2

### subsection3
text3

> Add Markdown syntax content to file `_tabs/about.md`{: .filepath } and it will show up on this page.
{: .prompt-tip }

> Add another markdown bit here
{: .prompt-info }

```sql
SELECT 
t.column1
, t.column2
, t.column3
FROM table1 as t
```


```jsonc
{
/*comments*/
  "data": {
    "name": "dataset"
  },
  "title": {
    "text": "BULLET CHART",
    "anchor": "start"
  },
  "params": [
    {
      "name": "actual",
      "value": 43000,
      "bind": {
        "input": "range",
        "min": 10000,
        "max": 60000,
        "step": 1
      }
    },
    {
      "name": "budget",
      "value": 100000,
      "bind": {
        "input": "range",
        "min": 10000,
        "max": 100000,
        "step": 1
      }
    },
    {
      "name": "target",
      "value": 40000,
      "bind": {
        "input": "range",
        "min": 20000,
        "max": 75000,
        "step": 1
      }
    }
  ],
  "transform": [
    {
      "calculate": "max(actual,target,budget)",
      "as": "max_label"
    },
    {
      "calculate": "min(actual,target,budget)",
      "as": "min_actual_label"
    },
    {
      "calculate": "((actual - target) / target)",
      "as": "label_var"
    }
  ],
  "width": 450,
  "height": 35,
  "layer": [
    {
      "mark": {
        "type": "bar",
        "fill": "transparent",
        "stroke": "transparent"
      },
      "encoding": {
        "x": {
          "datum": 100000,
          "type": "quantitative"
        },
        "y": {
          "datum": "",
          "axis": {
            "title": "",
            "titlePadding": 10,
            "titleBaseline": "middle",
            "titleAngle": 0,
            "titleAlign": "right"
          }
        }
      }
    },
    {
      "mark": {
        "type": "bar",
        "fill": "whitesmoke"
      },
      "encoding": {
        "x": {
          "datum": {
            "expr": "budget"
          },
          "type": "quantitative"
        }
      }
    },
    {
      "mark": {
        "type": "bar",
        "height": 20,
        "fill": "lightblue",
        "fillOpacity": 0.5
      },
      "encoding": {
        "x": {
          "datum": {
            "expr": "actual"
          },
          "type": "quantitative"
        }
      }
    },
    {
      "mark": {
        "type": "bar",
        "height": 10,
        "yOffset": 5,
        "fill": {
          "expr": "actual > target ? 'limegreen' : 'crimson'"
        }
      },
      "encoding": {
        "x": {
          "datum": {
            "expr": "target"
          },
          "type": "quantitative"
        },
        "x2": {
          "datum": {
            "expr": "actual"
          },
          "type": "quantitative"
        }
      }
    },
    {
      "mark": {
        "type": "tick",
        "size": 35,
        "thickness": 5,
        "fill": "black"
      },
      "encoding": {
        "x": {
          "datum": {
            "expr": "target"
          },
          "type": "quantitative"
        }
      }
    },
    {
      "mark": {
        "type": "text",
        "size": 16,
        "thickness": 5,
        "strokeWidth": 0.1,
        "stroke": "black",
        "fill": {
          "expr": "actual > target ? 'darkgreen' : 'crimson'"
        },
        "align": "left",
        "dx": 10,
        "dy": 0.5
      },
      "encoding": {
        "x": {
          "datum": {
            "expr": "max(actual,target)"
          },
          "type": "quantitative"
        },
        "text": {
          "value": {
            "expr": "format(((actual - target) / target), '+0.0%')"
          },
          "type": "quantitative",
          "format": "+0.0%"
        }
      }
    },
    {
      "mark": {
        "type": "text",
        "fontWeight": "bold",
        "size": 15,
        "thickness": 5,
        "fill": "black",
        "align": "right",
        "baseline": "middle",
        "dx": -10,
        "dy": 0.5
      },
      "encoding": {
        "x": {
          "datum": {
            "expr": "min(actual,target)"
          },
          "format": ",.3~s",
          "type": "quantitative"
        },
        "text": {
          "value": {
            "expr": "format(actual, ',.3~s')"
          },
          "type": "quantitative",
          "format": ",.3~s"
        }
      }
    }
  ],
  "encoding": {
    "x": {
      "datum": 80000,
      "type": "quantitative"
    },
    "y": {
      "datum": "",
      "axis": {
        "title": "",
        "titlePadding": 10,
        "titleBaseline": "middle",
        "titleAngle": 0,
        "titleAlign": "right"
      }
    }
  }
}
```

<details>
<summary>”What's the secret?”</summary>
It's a dirty mess!
</details>

<br>

---

<br>

<details>
  <summary>Click to expand</summary>
  **This text is bold!**

  You can use other Markdown features here too, like:

  - **Bold list item**
  - *Italic list item*
  - [Links](https://example.com)

</details>

<br>


> This is a helpful tip!
{: .prompt-tip }

<br>

> **Tip**: This is a helpful tip!
{: .prompt-tip }

<br>

> **Warning**: Be careful with this!
{: .prompt-warning }

<br>

> **Important**: This is critical information.
{: .prompt-important }

<br>

> **Danger**: This might break your code!
{: .prompt-danger }

<br>

> **Note**: Here's a small note for reference.
{: .prompt-note }

<br>

> **Custom Block**: You can style this however you like.
{: .prompt-custom }

*(You will need to define the `.prompt-custom` class in your CSS for this to work.)*


> [!NOTE]  
Highlights information that users should take into account, even when skimming.

> [!IMPORTANT]  
> Crucial information necessary for users to succeed.

> [!WARNING]  
> Critical content demanding immediate user attention due to potential risks.


> **Note**
> This is a note

> **Warning**
> This is a warning

---

## Simple alerts
> [!NOTE]
> This is a note.

> [!TIP]
> This is a tip. (Supported since 14 Nov 2023)

> [!IMPORTANT]
> Crutial information comes here.

> [!CAUTION]
> Negative potential consequences of an action. (Supported since 14 Nov 2023)

> [!WARNING]
> Critical content comes here.

---

> **⚠️ Warning**
>
> You shouldn't. This is irreversible!

> **❌ Error**
>
> Don't do that. This is irreversible!

> **ℹ️ Information**
>
> You can do that without problem.

> **✅ Success**
>
> Don't hesitate to do that.

> **🦄 New line support**
> 
> It supports new lines:
>
> .. simply use an empty `>` line

---
> This is an example of a Tip.
{: .prompt-tip }

> This is an example of an Info block.
{: .prompt-info }

> This is an example of a Warning block.
{: .prompt-warning }

> This is an example of a Danger block.
{: .prompt-danger }
