---
layout: default
title: pMildRight
checksum: ce85c39753c7baae37037a7794138f68
parent: maths
---


 
# PMILDRIGHT Probability of 'mild right' outliers
 
# Syntax
```matlab
pMR = pMildRight(x)
```
 
# Examples
```matlab
pMildRight(exprnd(1, 10000, 1))
```
 
# Description

`pER = pMildRight(x)` non-parametrically calculates the frequency of 'mild right' outliers in the distribution given by the random samples in `x`. Here, an outlier is mild right if is between 1.5 and 3 times the IQR above the third quartile.

 
# TODO
-  docs 
 
# Authors

Mehul Gajwani, Monash University, 2024

 
# See Also

"Measuring heavy-tailedness of distributions", Pavlina K. Jordanova and Monika P. Petkova, AIP Conference Proceedings 1910, 060002 (2017), [https://doi.org/10.1063/1.5013996](https://doi.org/10.1063/1.5013996)

