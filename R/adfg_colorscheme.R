library(tidyverse)

# http://paletton.com

adfg_colors <- c(
  "adfg_blue" = "#0068A5",
  "ak_gold" = "#FCDF2F",
  "ice_blue" = "#DFEAEF",
  "sea_green" = "#9FD3C2",
  "bou_tan" = "#EFE9CD",
  "bou_red" = "#7c1d25",
  "web_dblue1" = "#072F49",
  "web_dblue2" = "#194A6B",
  "web_lblue1" = "#427AA9",
  "web_lblue2" = "#B5D9F3",
  "web_midblue" = "#537fa5",
  "darkberry" = "#903E2D",
  "eveningblue" = "#346A8D",
  "mustard" = "#DD973F",
  "spruce" = "#6DB287",
  "darkpurple" =  "#312740", #testing sunset
  "sunsetpurp" = "#905e79", #testing sunset
  "sunsetyellow" =  "#ffdf42", #testing sunset
  "sunsetorange" = "#ff904b", #testing sunset
  "sunsetred" = "#d35e52", #testing sunset
  "auroragreen" = "#13eb66", 
  "aurorablue" = '#58a9a7',
  "aurorapurple" = "#7f60a4",
  "glacier1" = "#012d8e",
  "glacier2" = "#2c70bc",
  "glacier3" = "#5db4e4",
  "glacier4" = "#c7f4fa",
  "totemred" = "#A94A32",
  "totemforest" = "#6a9812",
  "totemcedar" = "#f0b358",
  "totemteal" = "#58c9c0",
  "totemblack" = "#2c2012",
  "rockfishred" = "#a03b2a", #rockfish
  "rockfishorange" = "#d37e3c", #rockfish
  "rockfishyellow" = "#e1d03b" # rockfish
)


colorlister <- function(...) {
  cols <- c(...)
  
  if (is.null(cols))
    return (adfg_colors)
  
  adfg_colors[cols]
}

adfg_palettes <- list(
  #Order within this list which colors are first shown on plot
  `logo` = colorlister("adfg_blue", "ak_gold", "ice_blue",
                       "sea_green", "bou_tan", "bou_red"),
  `blues` = colorlister("web_dblue1", "web_lblue1", "web_lblue2", "ice_blue"),
  `blues2` = colorlister("web_dblue1", "web_midblue", "web_lblue2"),
  `tetrad` = colorlister("pinot", "eveningblue", "mustard", "spruce"),
  `sitkasunset` = colorlister("darkpurple",  "sunsetpurp", "sunsetyellow", 
                              "sunsetorange", "sunsetred"),
  `aurora` = colorlister("auroragreen", "aurorablue", "aurorapurple"),
  `glacier` = colorlister("glacier1", "glacier2", "glacier3", "glacier4"),
  `totem` = colorlister("totemred", "totemforest", "totemteal", "totemcedar",
                        "totemblack"),
  `rockfish` = colorlister("rockfishred", "rockfishorange", "rockfishyellow")
)






adfg_paletter <- function(palette = "logo", reverse = FALSE, ...) {
  pal <- adfg_palettes[[palette]]
  
  if (reverse) pal <- rev(pal)

  colorRampPalette(pal, ...)
  
}


exactpal <- function(pal = "logo"){
  out <- adfg_palettes[[pal]]
  out <- unname(out)
  #structure(out, class = "adfgcolorpalette", name = pal)
  # This function just returns the same colors as listed, in the order listed
  # To be used only when "useexact" is called
}



display_palette <- function(name, n, ...) {
  pal <- adfg_paletter(name)(n)
  image(1:n, 1, as.matrix(1:n), col = pal, 
        xlab = paste(name), ylab = "", xaxt = "n", 
        yaxt = "n", bty = "n", ...)
  box()
}



scale_color_adfg <- function(palette = "logo", discrete = TRUE,  reverse = FALSE,
                             useexact = FALSE, ...) {
  pal <- adfg_paletter(palette = palette, reverse = reverse)
  
  if (discrete == TRUE) {
    if (useexact == TRUE) {
      scale_color_manual(values = exactpal(palette))
    }
    else{
    discrete_scale("color", paste0("adfg_", palette), palette = pal, ...)
  }} else {
    scale_color_gradientn(colors = pal(256), ...)
  }
}



scale_fill_adfg <- function(palette = "logo", discrete = TRUE, reverse = FALSE, 
                            useexact = FALSE, ...) {
  pal <- adfg_paletter(palette = palette, reverse = reverse)
  
  if (discrete == TRUE) {
    if (useexact == TRUE) {
      scale_fill_manual(values = exactpal(palette))
    }
    else{
    discrete_scale("fill", paste0("adfg_", palette), palette = pal, ...)
  }} else {
    scale_fill_gradientn(colors = pal(256), ...)
  }
}



mpgsub <- mpg %>%
  filter(manufacturer %in% c("audi", "jeep", "nissan", "toyota", "ford", 
                             "dodge", "subaru"))
mpgsub5 <- mpg %>%
  filter(manufacturer %in% c("audi", "jeep", "nissan", "toyota", "subaru"))



ggplot(mpgsub4, aes(manufacturer, fill = manufacturer)) +
  geom_bar(color = "black") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_fill_adfg(palette = "tetrad", discrete = TRUE) 


ggplot(mpgsub3, aes(manufacturer, fill = manufacturer)) +
  geom_bar(color = "black") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  scale_fill_adfg(palette = "rockfish", discrete = TRUE, useexact = TRUE) 



ggplot(mpg, aes(x = hwy, y = cty, color = displ)) +
  geom_point() +
  scale_color_adfg(palette = "rockfish", discrete = FALSE) 



ggplot(mpgsub4, aes(x = hwy, y = cty, color = manufacturer)) +
  geom_point(size = 3) +
  scale_color_adfg(palette = "tetrad", discrete = TRUE, useexact = TRUE) 








