
# write function to create band combinations
create_combinations <- function(band_colors, band_number) {
  
  # combinations with 3 color bands, 1 usgs band
  if(band_number == 4) {
    
    # create every possible combination
    all_combos <- expand_grid(
      top_left = band_colors,
      bottom_left = c(band_colors, 'usgs'),
      top_right = band_colors,
      bottom_right = c(band_colors, 'usgs')
    )
    
    # only keep combinations where the metal band is on the bottom
    all_combos <- all_combos %>%
      filter(bottom_left %in% c('usgs') | bottom_right %in% c('usgs'))
    
    # pull out combinations where there are 2 usgs bands
    dup_usgs <- all_combos %>%
      filter(bottom_left == 'usgs' & bottom_right == 'usgs')
    
    # use anti_join to remove these
    band_combos <- all_combos %>%
      anti_join(., dup_usgs, by = c("top_left", "bottom_left", "top_right", "bottom_right"))
    
  }
  
  # combinations with 2 color bands, 1 usgs band
  if(band_number == 3) {
    
    # create every possible combination
    all_combos <- expand_grid(
      top_left = c(band_colors, 'none'),
      bottom_left = c(band_colors, 'usgs'),
      top_right = c(band_colors, 'none'),
      bottom_right = c(band_colors, 'usgs')
    )
    
    # only keep combinations where the metal band is on the bottom
    all_combos <- all_combos %>%
      filter(bottom_left %in% c('usgs') | bottom_right %in% c('usgs'))
    
    # pull out combinations where there are 2 usgs bands
    dup_usgs <- all_combos %>%
      filter(bottom_left == 'usgs' & bottom_right == 'usgs')
    
    # find combinations where there are 2 top colors (can't have that with 3 color bands)
    dup_top <- all_combos %>%
      filter(top_left %in% band_colors & top_right %in% band_colors)
    
    # use anti_join to remove these
    band_combos <- all_combos %>%
      anti_join(., dup_usgs, by = c("top_left", "bottom_left", "top_right", "bottom_right")) %>%
      anti_join(., dup_top, by = c("top_left", "bottom_left", "top_right", "bottom_right"))
    
    # finally, remove combos where there is more than one NA value (only 1 color)
    band_combos <- band_combos %>%
      na_if(., 'none') %>%
      mutate(count = rowSums(is.na(.))) %>%
      filter(count == 1) %>%
      select(-count)
    
  }
  
  # return the full dataframe of color band combinations
  return(band_combos)
  
}