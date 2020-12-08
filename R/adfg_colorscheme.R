
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
  "darkturq" =  "#2A6A79",   # new discrete pal
  "lightmint" = "#78CE95",
  "offred" = "#bf4950",      # new discrete pal  #B6686D is alt
  "paleyellow" = "#F1F37C",  # new discrete pal
  "coolblue" = "#5B7A9A",    # new discrete pal
  "darklilac" = "#7C5066",   # new discrete pal
  "tangyorange" = "#F0803C", # new discrete pal
  "gray1" = "#cccccc",
  "gray2" = "#a3a3a3",
  "gray3" = "#7a7a7a",
  "gray4" = "#474747",
  "black" = "#000000",
  "white" = "#ffffff"
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
  `discrete7` = colorlister("darkturq", "tangyorange", "offred", "paleyellow", "coolblue" , "darklilac", "lightmint"),
  `grays` = colorlister("gray4", "gray3", "gray2", "gray1"),
  `grays_bw` = colorlister("black", "gray4", "gray3", "gray2", "gray1", "white")
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

  old <- par(mar = c(0.25, 0.25, 0.25, 0.25))
  on.exit(par(old))

  image(1:n, 1, as.matrix(1:n), col = pal,
        xlab = "",
        ylab = "", xaxt = "n",
        yaxt = "n", bty = "n", ...)

  rect(0, 0.8, n + 1, 1, col = rgb(1, 1, 1, 0.8), border = NA) # opaque rect
  text((n + 1) / 2, 0.9, labels = paste(name), cex = 1.5, family = "sans", col = "#32373D") # palette name
  rect(0, 0.6, 7 + 1, 0.8, col = rgb(1, 1, 1, 1), border = NA) # white bottom fill
  rect(0.5, 0.8, n +0.5, 1.4, col = rgb(1, 1, 1, 0), border = "#000000") # black border
  text((1:n), 0.7, labels = paste(pal), srt = 45, cex = 0.78, family = "sans", col = "#32373D") # hex labels
}

# OLD
# display_palette <- function(name, n, ...) {
#   pal <- adfg_paletter(name)(n)
#   image(1:n, 1, as.matrix(1:n), col = pal,
#         xlab = paste(name), ylab = "", xaxt = "n",
#         yaxt = "n", bty = "n", ...)
#   box()
# }




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








