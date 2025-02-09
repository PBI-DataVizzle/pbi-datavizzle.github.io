---
# the default layout is 'page'
layout: post
icon: fa-solid fa-toilet-paper
order: 5
toc: true
---

## icons
<h2><i class="fa-solid fa-chart-line" aria-hidden="true"></i>&ensp;Level2</h2>

<h3><i class="fa-solid fa-square-poll-vertical" aria-hidden="true"></i>&ensp;Level3</h3>

<h4><i class="fa-solid fa-code" aria-hidden="true"></i>&ensp;Level4</h4>

<h4><i class="fa-solid fa-brain" aria-hidden="true"></i>&ensp;Brain</h4>

<h4><i class="fa-solid fa-skull-crossbones" aria-hidden="true"></i>&ensp;SkullCrossbones</h4>

<h4><i class="fa-solid fa-person-digging" aria-hidden="true"></i>&ensp;digging</h4>

<h4><i class="fa-solid fa-magnifying-glass-chart" aria-hidden="true"></i>&ensp;chart-look</h4>

<h4><i class="fa-solid fa-hands-clapping" aria-hidden="true"></i>&ensp;hands</h4>

<h4><i class="fa-solid fa-toilet-paper" aria-hidden="true"></i>&ensp;bog-roll</h4>

<h4><i class="fa-solid fa-file-code" aria-hidden="true"></i>&ensp;chart-look</h4>

<i class="fa-solid fa-file-code"></i>

<h4><i class="fa-solid fa-pepper-hot" aria-hidden="true"></i>&ensp;Pepper</h4>
<h4><i class="fa-solid fa-smoking" aria-hidden="true"></i>&ensp;Smoking</h4>

<h5><i class="fa-solid fa-laptop-code" aria-hidden="true"></i>&ensp;Level5</h5>

<h6><i class="fa-solid fa-face-laugh-wink" aria-hidden="true"></i>&ensp;Level6</h6>


<div class="thi-columns" markdown="1">
## lists
### bullets
- item 1
- item 2
- item 3
- item 4
- item 5
- item 6
</div>

___


> **ℹ️ Note**: Here's a small note for reference.
{: .prompt-note }

> **💀 Note**: Here's a small note for reference.
{: .prompt-note }

> **⚠️ Note**: Here's a small note for reference.
{: .prompt-note }

> **⛔ Note**: Here's a small note for reference.
{: .prompt-note }

> This is an example of a Tip.
{: .prompt-tip }

> This is an example of an Info block.
{: .prompt-info }

> This is an example of a Warning block.
{: .prompt-warning }

> This is an example of a Danger block.
{: .prompt-danger }

[//]: # Collapsable Section


### dax highlighter 
```js
# Distinct Vertices Label Prop = 
CALCULATE( 
  COUNTROWS( DISTINCT( 'Vertices Label Prop'[id] ) )
  , 'Vertices Label Prop'[Type] in {"User", "Group"} 
)
```

{% highlight JS linenos %}
# Distinct Vertices Label Prop = 
CALCULATE( 
  COUNTROWS( DISTINCT( 'Vertices Label Prop'[id] ) )
  , 'Vertices Label Prop'[Type] in {"User", "Group"} 
)
{% endhighlight %}



### check boxes
- [ ] check1
- [x] check2

### terms
Define a Term
: definition

```jsonc
{
    $schema: "https://vega.github.io/schema/vega-lite/v5.json",
    description: "A simple bar chart with embedded data.",
    data: {
      values: [
        {a: "A", b: 28}, /* comments */
        {a: "B", b: 55}, // comments2
        {a: "C", b: 43},
        {a: "D", b: 91},
        {a: "E2", b: 81},
        {a: "F", b: 53},
        {a: "G", b: 19},
        {a: "H", b: 87},
        {a: "I", b: 52}
      ]
    },
    mark: "bar",
    encoding: {
      x: {field: "a", type: "ordinal"},
      y: {field: "b", type: "quantitative"}
    }
  }

````


<details>
<summary>Preview</summary>

{% highlight JSONC linenos mark_lines="1 2" %}
{
    $schema: "https://vega.github.io/schema/vega-lite/v5.json",
    description: "A simple bar chart with embedded data.",
    data: {
      values: [
        {a: "A", b: 28}, /* comments */
        {a: "B", b: 55}, // comments2
        {a: "C", b: 43},
        {a: "D", b: 91},
        {a: "E2", b: 81},
        {a: "F", b: 53},
        {a: "G", b: 19},
        {a: "H", b: 87},
        {a: "I", b: 52}
      ]
    },
    mark: "bar",
    encoding: {
      x: {field: "a", type: "ordinal"},
      y: {field: "b", type: "quantitative"}
    }
  }
{% endhighlight %}

</details>







<div id="vis"></div>
  <script type="text/javascript">
    var spec = {
      $schema: 'https://vega.github.io/schema/vega-lite/v5.json',
      description: 'A simple bar chart with embedded data.',
      width: 400,
      height: 200,
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
    vegaEmbed('#vis', spec);
  </script>
  
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

<h2><i class="fa-solid fa-table" aria-hidden="true"></i>&ensp;Dataset</h2>

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

