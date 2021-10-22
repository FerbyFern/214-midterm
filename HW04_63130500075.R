# Part 1
# Library
library(readr) # read .csv file
library(dplyr) # use %>% function
library(ggplot2) # Plotting graph
library(stringr) # Changing of data format
library(DescTools) # For better use in exploring data and more function

# Dataset
Books <- read_csv("https://raw.githubusercontent.com/sit-2021-int214/027-Quickest-Electric-Cars/main/assignment/Homework04/HW04_63130500087/data.csv")
View(Books)

# Explore dataset
glimpse(Books)

------------------------------------------------------------

# Part 2
# Clean data column "Type" cleaned the word "Box set"
Books$Type <- Books$Type %>% str_remove("Boxed Set -") %>% str_trim()
View(Books)

# Package stringr
# str_remove
Books$Type %>% str_remove("Boxed Set -")
# str_count
str_count(Books$Description, "[aeiou]")

# Package readr
# read_csv
Books <- read_csv("https://raw.githubusercontent.com/sit-2021-int214/027-Quickest-Electric-Cars/main/assignment/Homework04/HW04_63130500087/data.csv")
# cols_condense()
cols_condense(Books)

# Package dplyr
# select()
Books %>% select(Rating,Book_title,Price)
# glimpse()
glimpse(Books)
# count()
Books %>% count()
Books %>% count(Type == "ebook")
# filter()
Books %>% filter(Number_Of_Pages <= 200)
# arrange()
Books %>% arrange(Price) #
Books %>% arrange(desc(Rating)) #
# group_by()
Books %>% group_by(Type)
# tally()
Books %>% group_by(Type) %>% tally(sort = TRUE)
# distinct()
Books %>% select(Type) %>% distinct()
# summarise()
Books %>% summarise(Books)
# factor()
as.factor(Books$Price)

------------------------------------------------------------

# Part 3
# What are the top 3 books with the highest ratings?
Books %>% select(Book_title,Rating) %>% arrange(desc(Rating)) %>% head(n = 3L)
# What are some books that price less than 200 ?
Books %>% select(Book_title,Number_Of_Pages) %>% filter(Number_Of_Pages < 200)
# What books are not reviewed at all and how many?
Books %>% select(Book_title,Reviews) %>% filter(Reviews == 0)
# How many books are reviewed in all 270 books?
SumReviews <- Books %>% count(Reviews)
sum(SumReviews)
# How many e-books are there?
Books %>% filter(Type == "ebook") %>% group_by(Type) %>% tally(sort = TRUE)
# Which book doesn't know the type of book and how much per book?
Books %>% select(Book_title,Type,Price) %>% filter(Type == "Unknown Binding")
# What types of books are there and How many books are there in each type of book?
Books %>% group_by(Type) %>% count()

------------------------------------------------------------

# Part 4
# 1: Bar Chart
# Graph show type of book
# Step1
ggplot(Books,aes(x = Type)) + geom_bar()

# Step2-1: Save to object
type_plot <- ggplot(Books,aes(x = Type)) + geom_bar()

# Step2-2: Adding component
type_plot + ggtitle("Type of Book") + xlab("Types") + ylab("Number of Books")
type_plot


# 2: Scatter Plot
# Graph show relation between price and rating
Books %>% filter(Price < 250)

Books %>% ggplot(aes(x = Rating,y = Price)) + geom_point()

Books %>% filter(Price < 250) %>% ggplot(aes(x = Rating,y = Price)) + geom_point()

ratingPrice_plot <- Books %>% filter(Price < 250) %>% ggplot(aes(x = Rating,y = Price)) + geom_point(aes(color=Type)) + ggtitle("Relation Between Price and Rating")
ratingPrice_plot

ratingPrice_plot + geom_smooth() # default value - loess
ratingPrice_plot + geom_smooth(method="lm") # linear model
