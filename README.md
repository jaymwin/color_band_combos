# color_band_combos
Create color band combinations for bird banding projects

For this function, I'm assuming that the metal USGS band is always placed on the bottom of the leg (right or left) and the number of color bands used is either 2 or 3. The user just needs to specify the number that they would like to use, and a list of color options. The output is a data frame with the complete list of color band combinations.

``` r
# load the tidyverse and the create_combinations function

library(tidyverse)
source(here::here('create_combinations.R'))

```

Supply the number of bands to be used (including the USGS band) and the available band colors:

``` r

band_colors <- c("white", "red", "purple", "orange")
band_number <- 4

```

Finally, generate all of the possible color band combinations based on the arguments set above:

``` r

create_combinations(band_colors = band_colors, band_number = band_number)

```
