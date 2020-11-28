library(tidyverse)

nmfs_colors <- c(
  "process_blue" = "#0093D0",
  "reflex_blue" = "#0055A4",
  "PMS_541" = "#00467F",
  "PMS_319" = "#1ECAD3",
  "PMS_321" = "#008998",
  "PMS_322" = "#007078",
  "PMS_375" = "#93D500",
  "PMS_362" = "#4C9C2E",
  "PMS_356" = "#007934",
  "custom" = "#7F7FFF",
  "PMS_2725" = "#625BC4",
  "PMS_7670" = "#575195",
  "PMS_151" = "#FF8300",
  "PMS_717" = "#D65F00",
  "PMS_1525" = "#BC4700",
  "warm_red" = "#FF4438",
  "PMS_711" = "#D02C2F",
  "PMS_1805" = "#B2292E",
  "white" = "#FFFFFF",
  "lt_gray_1" = "#E8E8E8",
  "lt_gray_2" = "#D0D0D0",
  "med_gray" = "#9A9A9A",
  "dk_gray_1" = "#7B7B7B",
  "dk_gray_2" = "#646464"
)

adfg_colors <- c(
  "adfg_blue" = "#0068A5",
  "ak_gold" = "#FCDF2F",
  "ice_blue" = "#DFEAEF",
  "sea_green" = "#9FD3C2",
  "bou_tan" = "#EFE9CD",
  "web_dblue1" = "#072F49",
  "web_dblue2" = "#194A6B",
  "web_lblue1" = "#427AA9",
  "web_lblue2" = "#B5D9F3"
)


nmfs_cols <- function(...) {
  cols <- c(...)
  
  if (is.null(cols))
    return (adfg_colors)
  
  adfg_colors[cols]
}

nmfs_palettes <- list(
  `logo` = nmfs_cols("adfg_blue",
                     "ak_gold",
                     "ice_blue",
                     "sea_green",
                     "bou_tan",
                     "bou_red"),
  `blues` = nmfs_cols("web_dblue1", 
                      "web_lblue1", 
                      "web_lblue1", "ice_blue")
  #`oceans`  = nmfs_cols("process_blue", "reflex_blue", "PMS_541", "white"),
  #`waves`  = nmfs_cols("PMS_319", "PMS_321", "PMS_322", "lt_gray_1"),
  #`seagrass`   = nmfs_cols("PMS_375", "PMS_362", "PMS_356", "lt_gray_2"),
  #`urchin` = nmfs_cols("custom", "PMS_2725", "PMS_7670", "med_gray"),
  #`crustacean`  = nmfs_cols("PMS_151", "PMS_717", "PMS_1525", "dk_gray_1"),
  #`coral` = nmfs_cols("warm_red", "PMS_711", "PMS_1805", "dk_gray_2"),
  #`regional web` = nmfs_cols("PMS_541", "PMS_321","PMS_356","PMS_2725","PMS_717","PMS_1805"),
  #"secondary" = nmfs_cols("PMS_322", "PMS_362", "PMS_7670", "dk_gray_2")
)






nmfs_palette <- function(palette = "oceans", reverse = FALSE, ...) {
  pal <- nmfs_palettes[[palette]]
  
  if (reverse) pal <- rev(pal)
  
  colorRampPalette(pal, ...)
}


display_nmfs_palette <- function(name, n, ...) {
  pal <- nmfs_palette(name)(n)
  image(1:n, 1, as.matrix(1:n), col = pal, 
        xlab = paste(name), ylab = "", xaxt = "n", 
        yaxt = "n", bty = "n", ...)
  box()
}



scale_color_nmfs <- function(palette = "oceans", discrete = TRUE, reverse = FALSE, ...) {
  pal <- nmfs_palette(palette = palette, reverse = reverse)
  
  if (discrete) {
    discrete_scale("colour", paste0("nmfs_", palette), palette = pal, ...)
  } else {
    scale_color_gradientn(colours = pal(256), ...)
  }
}


scale_fill_nmfs <- function(palette = "oceans", discrete = TRUE, reverse = FALSE, ...) {
  pal <- nmfs_palette(palette = palette, reverse = reverse)
  
  if (discrete) {
    discrete_scale("fill", paste0("nmfs_", palette), palette = pal, ...)
  } else {
    scale_fill_gradientn(colours = pal(256), ...)
  }
}

mpgsub <- mpg %>%
  filter(manufacturer %in% c("audi", "jeep", "nissan", "toyota", "ford", "dodge"))


ggplot(mpgsub, aes(manufacturer, fill = manufacturer)) +
  geom_bar(color = "black") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_fill_nmfs(palette = "logo", discrete = TRUE) 

ggplot(mpg, aes(manufacturer, fill = manufacturer)) +
  geom_bar(color = "black") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_fill_nmfs(palette = "blues", discrete = TRUE) 



