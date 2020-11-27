### Data from: Swanson, G. E. (1960). The birth of the gods: The origin of primitive beliefs. University of Michigan Press.

# Note: Data have headings

# After loading data into R, run the following to ensure that the column numbers correspond to the variable numbers in Swanson's Appendix

`d <- read.csv("Swanson_Data.csv")`\
`rownames(d) <- d$X`\
`d$X <- NULL # now, column numbers correspond to Swanson's`\
