
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
  "rockfishyellow" = "#e1d03b", # rockfish
  "darkturq" =  "#2A6A79",
  "tangyorange" = "#F0803C",
  "offred" = "#bf4950",   #B6686D"
  "paleyellow" = "#F1F37C",
  "coolblue" = "#5B7A9A",
  "darklilac" = "#7C5066",
  "lightmint" = "#78CE95"
)






#' Combine colors from a list
#'
#' Given a list of color names & hex colors, returns hex colors as a list
#'
#' @param ... Color names
#'
#' @return named character
#' @export
#'
#' @examples
#' colorlister("auroragreen")
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
  `tetrad` = colorlister("darkberry", "eveningblue", "mustard", "spruce"),
  `sitkasunset` = colorlister("darkpurple",  "sunsetpurp", "sunsetyellow",
                              "sunsetorange", "sunsetred"),
  `aurora` = colorlister("auroragreen", "aurorablue", "aurorapurple"),
  `glacier` = colorlister("glacier1", "glacier2", "glacier3", "glacier4"),
  `totem` = colorlister("totemred", "totemforest", "totemteal", "totemcedar",
                        "totemblack"),
  `rockfish` = colorlister("rockfishred", "rockfishorange", "rockfishyellow"),
  `discrete7` = colorlister("darkturq", "tangyorange", "offred", "paleyellow", "coolblue" , "darklilac", "lightmint")
)






#' Interpolate the selected palette
#'
#' @param palette Palette name in "adfg_palettes"
#' @param reverse TRUE/FALSE of palette order
#' @param ... Additional arguments
#'
#' @return Characters, hex values of colors
#' @importFrom grDevices colorRampPalette
#' @export
#'
#' @examples
#' adfg_paletter("glacier")(7)
adfg_paletter <- function(palette = "glacier", reverse = FALSE, ...) {
  pal <- adfg_palettes[[palette]]

  if (reverse) pal <- rev(pal)

  colorRampPalette(pal, ...)
}


#' Returns exact palette select, no interpolatio
#'
#' This function just returns the same colors as listed, in the order listed
#' To be used only when "useexact" is called
#'
#' @param pal Palette name
#'
#' @return Character
#' @export
#'
#' @examples
exactpal <- function(pal = "totem"){
  out <- adfg_palettes[[pal]]
  out <- unname(out)
}



#' Create a display box output of the selected palette
#'
#' @param name Palette name
#' @param n Number of colors to display
#' @param ... Other arguments
#' @importFrom graphics box image
#' @return Graphic device
#' @export
#'
#' @examples
#' display_palette("glacier", 7)
display_palette <- function(name, n, ...) {
  pal <- adfg_paletter(name)(n)
  image(1:n, 1, as.matrix(1:n), col = pal,
        xlab = paste(name), ylab = "", xaxt = "n",
        yaxt = "n", bty = "n", ...)
  box()
}



#' Color scale helper to add directly to ggplot
#'
#' @param palette Palette name
#' @param discrete TRUE/FALSE of whether aesthetic is discrete
#' @param reverse TRUE/FALSE of palette order
#' @param useexact TRUE/FALSE of whether to use palettes exactly, no interpolation
#' @param ... Other arguments
#'
#' @importFrom ggplot2 ggplot geom_point discrete_scale scale_color_gradientn aes
#'
#' @return
#' @export
#'
#' @examples
#' \dontrun{
#'  ggplot(mpg, aes(x = hwy, y = cty, color = displ)) +
#'  geom_point() +
#'  scale_color_adfg(palette = "glacier", discrete = FALSE)
#' }
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



#' Fill scale helper to add directly to ggplot
#'
#' @param palette Palette name
#' @param discrete TRUE/FALSE of whether aesthetic is discrete
#' @param reverse TRUE/FALSE of palette order
#' @param useexact TRUE/FALSE of whether to use palettes exactly, no interpolation
#' @param ... Other arguments
#'
#' @importFrom ggplot2 ggplot geom_point discrete_scale scale_fill_gradientn aes
#'
#' @return
#' @export
#'
#' @examples
#' \dontrun{
#'  ggplot(mpg, aes(manufacturer, fill = manufacturer)) +
#'  geom_bar(color = "black") +
#'  scale_fill_adfg(palette = "glacier", discrete = TRUE)
#' }
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








