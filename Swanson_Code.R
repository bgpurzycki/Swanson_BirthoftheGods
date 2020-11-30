## Swanson_BirthoftheGods
## Data from: Swanson, G. E. (1960). The birth of the gods: 
## The origin of primitive beliefs. University of Michigan Press.

## Code by: Benjamin Grant Purzycki
## Last Updated: 30-11-20

setwd("")
d <- read.csv("Swanson_Data.csv")

# Note: Data have headings
# After loading data into R, run the following to ensure that the 
# column numbers correspond to the variable numbers in Swanson's Appendix

str(d)
rownames(d) <- d$X
d$X <- NULL # now, column numbers correspond to Swanson's

colnames(d)[1:7] <- c("subsist", "amntfood", "outthreat", "size", "settle", "property", "debts")
colnames(d)[9] <- "class"
colnames(d)[12] <- "sovorg"
colnames(d)[23] <- "primog."
colnames(d)[25] <- "highgod"
colnames(d)[37:39] <- c("moral.health", "moral.afterlife", "moral.other")

d[d == "X"] <- NA # X means "Uncodable"
d[d == "Y"] <- NA # Y means "Uncertain"

labs <- c("size", "property", "debts", "class", "sovorg", "primog.", "highgod",
          "moral.health", "moral.afterlife", "moral.other")
dat <- d[labs]

#barplot(prop.table(table(d$moral.health, d$size), 2)) # , 1 for rows , 2 for columns
dat$amntfood <- as.integer(dat$amntfood)
dat$outthreat <- as.integer(dat$outthreat)
dat$size <- as.integer(dat$size)
dat$property <- as.integer(dat$property)
dat$debts <- as.integer(dat$debts)
dat$class <- as.integer(dat$class)
dat$primog. <- as.integer(dat$primog.)
dat$moral.afterlife <- as.integer(dat$moral.afterlife)
dat$moral.other <- as.integer(dat$moral.other)
dat$bin <- ifelse(dat$moral.health > 0 | dat$moral.afterlife > 0 | dat$moral.other > 0, 1, 0)
dat$propbin <- ifelse(dat$property > 1, 1, 0)
dat$debtbin <- ifelse(dat$debts > 1, 1, 0)
dat$wealth <- rowSums(dat[,c("propbin", "debtbin", "class", "primog.")], na.rm = TRUE)

# replicate Table XVII, p. 166
table(dat$debtbin, dat$bin)
table(dat$propbin, dat$bin)
table(dat$class, dat$bin)
table(dat$primog., dat$bin)

# replicate Table XVIII, p. 168
table(dat$bin, dat$wealth) # Note that there's a discrepancy of 5

# Society size: 0=1-49; 1=50-399; 2=400-9,999; 3=10,000 or more
par(mfrow = c(2, 2), mar = c(4.2, 5, 1, 0))
barplot(prop.table(table(dat$moral.health, dat$size), 2)[2,1:4], 
        xlab = NA, ylab = NA,
        ylim = c(0, 1), cex.axis = .8)
mtext(side = 2, line = 3, "Prop. with Health", cex = 1.1)
text(.5,.95, "(a)")
barplot(prop.table(table(dat$moral.afterlife, dat$size), 2)[2,1:4], 
        xlab = NA, ylab = NA, ylim = c(0, 1), cex.axis = .8)
mtext(side = 2, line = 3, "Prop. with Afterlife", cex = 1.1)
text(4.5,.95, "(b)")
barplot(prop.table(table(dat$moral.other, dat$size), 2)[2,1:4], 
        xlab = "Society Size", ylab = NA,
        ylim = c(0, 1), cex.axis = .8)
mtext(side = 2, line = 3, "Prop. with Other", cex = 1.1)
text(.5,.95, "(c)")
barplot(prop.table(table(dat$bin, dat$size), 2)[2,1:4], 
        xlab = "Society Size", ylab = NA,
        ylim = c(0, 1), cex.axis = .8)
text(4.5,.95, "(d)")
mtext(side = 2, line = 3, "Prop. with Any", cex = 1.1)

sum(table(dat$moral.health, dat$size))
sum(table(dat$moral.afterlife, dat$size))
sum(table(dat$moral.other, dat$size))
sum(table(dat$bin, dat$size))

par(mfrow = c(1, 2), mar = c(4.2, 4, 1, 0))
barplot(prop.table(table(dat$bin, dat$size), 2)[2,1:4], 
        xlab = "Society Size", ylab = NA,
        ylim = c(0, 1), cex.axis = .8)
text(.5,.95, "(a)")
mtext(side = 2, line = 3, "% w/ Moralistic Punish.", cex = 1.1)
barplot(prop.table(table(dat$bin, dat$wealth), 2)[2, 1:5],
        xlab = "No. Indicators of Wealth", ylab = NA,
        ylim = c(0, 1), cex.axis = .8)
text(.5,.95, "(b)")

