---
# the default layout is 'page'
icon: fas fa-info-circle
order: 4
---

# Prompt Blocks
text

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
