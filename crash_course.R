## A CRASH COURSE IN [R] PROGRAMMING
## Robin Edwards (geotheory.co.uk), May 2013
## In RStudio run through line-by-line using Ctrl + Enter

# basic R environmental functions
x=3.14159; y='hello world'; z=TRUE     # create some objects. In RStudio they'll appear in 'Workspace'
ls()                                   # list the objects in the Workspace
print(y)                               # print information to R 'Console'
rm(y)                                  # remove an object
rm(list=ls())                          # remove all
getwd()                                # find current working directory
setwd("C:/Users/Robin/Documents")      # set working directory as preferred
print    (  "R ignores the 'white-space' in command syntax"     )   

# use '?' for help on any R function (if its library is loaded in the session)
?max
??csv                  # search for a text string in R documentation library
library(help=utils)    # get help on a particular package (list its functions)

# 'str' is a powerful tool for investigating the underlying structure of any R object
str(max)

# CREATING AND MANIPULATING R OBJECTS

# assigning values to variables - these all do the same 
n = 5           # is possible but
n <- 5          # is typically used by Rogrammers (but see http://bit.ly/17r81AR)
5 -> n          # also valid
assign('n', 5)  # useful for variablising variable names
n <<- 5         # 'global' assignment (but at the risk of overwrite R's internal code)
rm(n)

# R objects can be of various data types, but probably most common are 'numeric' and 'character'
( num <- 3.14 ) # bracketing an instruction also prints it to the console
( char <- 'any text string' )

# create a VECTOR (array) using the 'c()' concatenate function
( vec <- c(2,5,8,3,7) )

# a vector series
( vec <- 10:15 )

# R vectors can be accessed in various ways using [ ] brackets
vec[3]
vec[2:4]
vec[ c(1,3,5) ]
vec[vec > 12]

# check a vector contains a value
5 %in% vec
12 %in% vec

# finding first index position of a matching value/sting
( x = c('one', 'five', 'two', 3, 'two') )
match('two', x)
match(c('two','five'), x)

# a MATRIX is a 2D vector (essentially a vector of vectors) of matching data type
( matrx = matrix(1:15, 3, 5) )
( matrx <- 1:12 )      # vector to a matrix
dim(matrx) <- c(3,4)
print(matrx)
t(matrx) # a matrix can be easily transposed

# an ARRAY is a generic vector but with more flexibiity. A 1D array is the same as a normal vector,
# and a 2D array is like a matrix. But arrays can store data with 'n' dimensions:
( arry <- array(1:24, dim=c(4,3,2)) )

# Using square brackets on arrays
arry[12]        # a single criterion (argument) selects the array's n'th record
arry[3,1,2]     # or use multiple arguments that reflect the array's dimensionality
arry[,,2]
arry[,1,]

# a DATA.FRAME is like a matrix, but accomodates fields (columns) with different data types
(df <- data.frame(name = c('Matt','Kate','Jacquie','Simon','Nita'), age = c(35,29,32,35,39),
                  stringsAsFactors=FALSE))

# They can be viewed easily
View(df)

# examine their internal stucture
str(df)

# data interrogation with square brackets
df[1,]       # single row
df[2:3,]     # row range
df[c(1,4),]  # row selection
df[,1]       # single column
df[[1]]      #  ""    column
df[2,1]      # cell selction

# data.frame and matrix objects can have field (column) and record (row) names
dimnames(df)
colnames(df)
names(df)     # not for matrix objects
row.names(df)

# interrogate data.frames by field name using the '$' operator. the result is a simple vector
df$name
df$name[2]

# names can be reassigned
names(df) <- c('person','years')
row.names(df) <- c('R1','R2','R3','R4','R5')
print(df)

# check dimensions of vector/matrix/array/data.frame objects
length(vec)
dim(df)
dim(arry)
nrow(df)
ncol(df)

# R has various inbuilt data.frame datasets used to illustrate how functions operate e.g.
data()
InsectSprays  # this guide makes use of these datasets
warpbreaks

# examine contents
head(InsectSprays)        # list the top records of a vector / matrix / d.f.
tail(InsectSprays, n=3)   # bottom the 3
summary(InsectSprays)     # summarise a data vector

# aggregate() is a powerful function for summarising categorical data
aggregate(InsectSprays$count, by=list(InsectSprays$spray), FUN=mean)
sumInsects <- aggregate(InsectSprays$count, by=list(InsectSprays$spray), FUN=sum)
names(sumInsects) <- c('group', 'sum')
print(sumInsects)

# subset/apply filter to a data.frame
warpbreaks[warpbreaks$wool=='A',]                 # by 1 condition
warpbreaks[warpbreaks$tension %in% c('L','M'),]   # multiple conditions

# warpbreaks[warpbreaks$tension == 'L' | warpbreaks$tension == 'M',]
# warpbreaks[warpbreaks$tension == 'L' & warpbreaks$wool == 'A',]
# subset(), <, >, <=, >=, !=

# adding entries is possible (if a bit tricky)
(newrow <- data.frame(breaks=42, wool='B', tension='M'))
(warpbreaks <- rbind(warpbreaks, newrow))
warpbreaks[55,] <- c(42,"B", "M")
warpbreaks[,4] <- paste(warpbreaks[,2],warpbreaks[,3], sep='+') 

# but LISTS are better at this
lst = list()

# ways to assign/add items
lst[1] = "one"
lst[[2]] <- "two"
lst[length(lst)+1] <- "three"
print(lst)

# data retrieval
lst[[1]]      # double brackets means the object returned is of the data class of the list item
lst[2:3]      # selecting a more than 1 list item is possible with single brackets..
lst[c(1,3)]   # but the object returned (from single bracket interrogation) is a list

# delete list items
lst[[3]] <- NULL
lst[1:2] <- NULL
lst

# entries can be any object type (like python), including other lists (double bracketting)
lst[[1]] <- list('subitem1', 2, 3)
lst[[2]] <- 'item2'
lst
lst[[1]][[1]]

# lst[[1]] <- c('subitem1', 2, 3)
# lst[[1]][[1]]

# Data in lists can also be stored and recalled by key word/number (like Python's dictionary class)
dict <- list(mon=1, tues=2)
dict['wed'] <- 3
dict$thur <- 4
print(dict)
dict[['tues']]
dict$wed
dict[c('mon','wed')]

# dict[1]
# dict[[1]]
# dict[1]$mon

# reorder a vector with 'sort'
vec <- c(10,6,2,4,10,2,8,7,1,6)
sort(vec)

# or a dataframe with 'order'
df[order(df$years),]

# LOGICAL objects (booleans) are binary true/false objects that facilitate conditional data processing
(bool <- TRUE)
(bool <- c(TRUE, FALSE, TRUE))

# query an object's data/structure type with 'class()'
class(bool)
class(num)               # numeric is the default data type for number objects
class(as.integer(num))   # integer class exists but is not default
class(char)              # character class
class('237' )            # numbers aren't always numeric type
as.numeric('237')        # but can be converted
as.character(237)        # and vice verse

# Child-objects are often of different class to parents
class(df)
class(df[,2])
class(df[,1])

# FACTOR objects are vectors of items that have been categorised by unique values
factr <- as.factor(c(10,30,20,10,20,20,30))
str(factr) 
levels(factr)
table(factr)

# you may encounter problems converting a factor of numeric data to numeric type
as.numeric(factr)

# instead do this
as.numeric(as.character(factr))

# editing factors can be tricky
df$person = as.factor(df$person)
df$person[1] <- 'Matthew'

# instead convert to character or numeric etc
df$person <- as.character(df$person)
df$person[1] <- 'Matthew'
df$person <- as.factor(df$person)   # coerce back to factor if necessary
levels(df$person)

# LOGICAL OPERATIONS
2 + 2 == 4               # '==' denotes value equality
3 <= 2                   # less than or equal to
3 >= 2                   # greater than or equal to
'string' == "string"
'b' >= 'a'               # strings can be ranked
3 != 3                   # NOT operator
c(4,2,6) == c(4,2,8)     # vector comparisons return logical vectors
TRUE == T                # 'T' and 'F' default as boolean shortcuts (until overwritten)
TRUE & TRUE              # AND operator
TRUE | FALSE             # OR operator
F | FALSE
all(T,T,T,F)             # TRUE if ALL inputs are TRUE (or if FALSE if !all(...) )
any(T,T,T,F)             # TRUE if ANY inputs are TRUE (or if FALSE if !any(...) )

# IF/ELSE statement (used in most logical procedures)
x <- 4
if(x < 5){ 
  print('x is less than 5')
} else{
  print('x is not less than 5')
}

if(T|F) print('single liners can dispense with curly brackets')
if(T&F) print('') else print("but then 'else' only works on the same line")

# LOOPING FUNCTIONS - very useful for handling repetitive operations

# 'FOR' loop 
for(i in 1:5){
  print(paste('number ',i))
}

# WHILE loop (be careful to include safeguards to prevent infinite loops)
i = 20
while(i > 0){
  print(paste('number ',i))
  i = i - 3
}

# creating a function
multiply <- function(input1, input2){
  tot <- input1 * input2
  return(tot)
}

multiply(3,5)
# note 'tot' wasn't remembered outside the function - functions are contained environments
# if required use '<<-' for global assignment but be careful not to overwrite R's internal objects
# its generally better to do this:
newVar <- multiply(3,5)

# handling 'NA' values
(x = 1:5)
x[8] = 8
x[3] = NA
print(x)       # sometimes functions will fail because of NA values
na.omit(x)     # iterates full list but ignores NAs
x[na.omit(x)]
is.na(x)       # alternatively
x[!is.na(x)]

# useful basic math functions
seq(-2, 2, by=.2)                 # sequence of equal difference
seq(length=10, from=-5, by=.2)    # with range defined by vector length
rnorm(20, mean = 0, sd = 1)       # random normal distribution
runif(20, min=0, max=100)         # array of random numbers
sample(0:100, 20, replace=TRUE)   # array of random integers
table(warpbreaks[,2:3])           # array summary stats (powerful summary tool)
min(vec)
max(vec)
range(vec)
mean(vec)
median(vec)
sum(vec)
prod(vec)                         # dot product
abs(-5)                           # magnitude
sd(rnorm(10))                     # standard deviation
4^2                               # square
sqrt(16)                          # square root
5%%3                              # modulo (remainder after subtraction of a multiple)
6%%2                                   
for(i in 1:100) if(i%%20==0) print(i)  # useful for running an operation every n'th cycle

# Importing and exporting data using comma-separated file
write.csv(df, 'example.csv')       # save to csv file
rm(df)
(df <- read.csv('example.csv'))

# PLOTTING IN R

# some basic functionality
plot(1:10)
plot(sort(rnorm(100)), pch=16, cex=0.5)                 # specifying point and size respectively
plot(x=1:25, y=25:1, pch=1:25)                          # x & y inputs, and showing the available point symbols
plot(sin, -pi, 2*pi)
hist(rnorm(1000), breaks=50)
barplot(sumInsects$sum, names.arg = sumInsects$group)
pie(sumInsects$sum, labels = sumInsects$group)

# plots with more visual components are built up incrementally
x <- sample(0:100, 25, replace=TRUE)
plot(x, pch=17)
lines(x, col='#00FF00')
points(x+5, pch=16, col='red')

# stacking charts
warpbreaks
sumWB <- aggregate(warpbreaks$breaks, by=list(warpbreaks$wool, warpbreaks$tension), FUN=mean)
names(sumWB) <- c('wool','tension','mean_breaks')
sumWB
(data <- cbind(sumWB$mean_breaks[c(1,3,5)], sumWB$mean_breaks[c(2,4,6)]))
barplot(data, names.arg=c('Group A','Group B'), 
        legend.text=c('L','M','H'), args.legend = list(x = "right"))

barplot(data, names.arg=c('Group A','Group B'), beside=T,
        legend.text=c('L','M','H'), args.legend = list(x = "topright"))

# 'symbols()' is a good way to represent a 3rd data dimension (use square root for area proportionality)
(cities <- data.frame(city=c('London','Bristol','Manchester','Leeds'), 
                      lon=c(-0.1,-2.6,-2.2,-1.5), lat=c(51.5,51.4,53.5,53.8), pop=c(8,1,2.7,0.8)))
symbols(x=cities$lon, y=cities$lat, circles=sqrt(cities$pop), inches=0.3, 
        bg='red', fg=NULL, asp=T, xlab='Longitude', ylab='Latitude')
abline(h=(seq(51,53,1)), col="lightgray", lty=1)
abline(v=(seq(-4,1,1)), col="lightgray", lty=1)
text(x=cities$lon, y=cities$lat+0.2, labels=cities$city)

# But for much easier and more elegant data visualisation use GGPLOT2
# see http://docs.ggplot2.org/current/ for examples

# END OF SCRIPT