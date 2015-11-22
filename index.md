---
title       : Wine Quality Predictor
subtitle    : Predicting Expert Ratings of Wine Based On Physiochemical Properties
author      : Jesus Dacuma
job         : Coursera - Data Product Developer
framework   : io2012_wine   # {io2012, html5slides, shower, dzslides, ...}
highlighter : highlight.js  # {highlight.js, prettify, highlight}
hitheme     : tomorrow      # 
widgets     : []            # {mathjax, quiz, bootstrap}
mode        : selfcontained # {standalone, draft}
knit        : slidify::knit2slides
--- 

## If Winemakers Could Predict the Future...

- Wine ratings are the standard in grading wine quality.

- Better ratings = Higher sales

- How can winemakers predict how their wines will be rated?

- The Wine Quality Predictor App can predict expert ratings based on a wine's physiochemical properties!

![wine_icon](www/wine_icon.jpg)

---

## An Example Wine (Rated 7/10)


```r
example
```

```
##    type volatile.acidity residual.sugar chlorides free.sulfur.dioxide
## 1 white             0.16            1.5     0.044                  48
##   sulphates alcohol quality
## 1      0.52    12.4       7
```

```r
appPrediction
```

```
##   appPrediction
## 1      6.913097
```

---

## Another Example Wine (Rated 5/10)


```r
example
```

```
##    type volatile.acidity residual.sugar chlorides free.sulfur.dioxide
## 1 white             0.27          18.75     0.052                  45
##   sulphates alcohol quality
## 1      0.52     8.9       5
```

```r
appPrediction
```

```
##   appPrediction
## 1       5.08689
```

---

## Why Winemakers Need This

* Fine wine sales will [grow 14-18%][link1]

* Fine wine is projected to sell for over $20 a bottle

* Attaching a wine’s score to its price tag results in [increased sales by 25%][link2]

* High-scoring wines display a higher increase in sales compared to low-scoring wines

* [Shortages in wine grapes][link3] makes creating the right wine more critical

[link1]: http://www.forbes.com/sites/cathyhuyghe/2015/01/21/happening-now-2015-wine-trends-and-predictions-from-silicon-valley-bank/
[link2]: http://www.academicwino.com/2012/07/how-expert-opinions-influence-consumer.html/
[link3]: http://www.businessinsider.com/us-wine-grape-shortage-developing-2013-8
