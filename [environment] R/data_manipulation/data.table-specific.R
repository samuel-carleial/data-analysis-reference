###########################################################################
# Package data.table
###########################################################################

## Author: Samuel Carleial
## Date: 

library("data.table")

### order data.table by row using a specific vector as reference anchor
setroworder <- function(x, neworder) {
  .Call(data.table:::Creorder, x, as.integer(neworder), PACKAGE = "data.table")
  invisible(x)
}
new_order <- vector
setroworder(x = datatable, neworder = new_order)

