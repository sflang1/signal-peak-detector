# Implementation

This application intends to identify peaks on a signal by comparing them to a threshold. If the value is beyond the given threshold, it will return a 1. In the opposite case, it will return a 0. I added some validation for numericality and presence for the input params. I also added some automated testing to it, as you can see if you run the `rspec` command.

The formulas used are:

$z = \frac{x -\mu}{\sigma}  $

where $\mu$ is the average and $\sigma$ is the standard deviation. As the z-score is mentioned as "moving", I considered that the input was a time series, so suppose that the series is something like

$data = [x_{1}, x_{2}, ..., x_{n}]$

then the z-score is calculated like:

1. For the position $m$, consider only the data until $m$, this is: $[x_{1}, x_{2}, ..., x_{m}]$

2. Find the average and standard deviation for this subset of the data
3. Calculate the z-score for the $m$ position based on the aforementioned average and standard deviation.

Regarding the time doing consumed during this test, it was approximately 3 hours