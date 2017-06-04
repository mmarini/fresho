# How to use

The scripts directory contains the executable file **fill-order**

This file will read the order specified in the **orders.txt** file and output the order

# Caveats

The examples in the documentation all fit the bundle sizes exactly. The code doesn't handle where 
the order doesn't fit a bundle amount exactly. In this case, it doesn't fulfill the order. This
is due to not knowing whether to:
 - fit best below the order amount
 - fit best exceeding the order amount
 
 The BundleLine copies the the amount and price to itself, rather than associating to the bundle.
 Reason for this is that the BundleLine is being thought of as an 'as-at' order, so if the 
 bundle prices change in the future, and orders are persisted, then the order is 'as-at' the time
 it was run.
 
 Michael Marini
 mmarini@gelatisoftware.com
