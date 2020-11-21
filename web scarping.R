# import a webpage into R
library(rvest)
library(tidyverse)
library(xml2)
url <- "https://en.wikipedia.org/wiki/Murder_in_the_United_States_by_state"
h <- read_html(url)
class(h)
h
tab <- h %>% html_nodes("table")
tab
tab <- tab[[2]]
tab
tab <- tab %>% html_table
class(tab)
tab <- tab %>% setNames(c("state", "population", "total", "murders", "gun_murders", "gun_ownership", "total_rate", "murder_rate", "gun_murder_rate"))
head(tab)
# guacamole-recipe
h <- read_html("http://www.foodnetwork.com/recipes/alton-brown/guacamole-recipe-1940609")
recipe <- h %>% html_node(".o-AssetTitle__a-HeadlineText") %>% html_text()
prep_time <- h %>% html_node(".m-RecipeInfo__a-Description--Total") %>% html_text()
ingredients <- h %>% html_nodes(".o-Ingredients__a-Ingredient") %>% html_text()
# careate list
guacamole <- list(recipe, prep_time, ingredients)
guacamole
#get recipe function to extract information
get_recipe <- function(url){
  h <- read_html(url)
  recipe <- h %>% html_node(".o-AssetTitle__a-HeadlineText") %>% html_text()
  prep_time <- h %>% html_node(".m-RecipeInfo__a-Description--Total") %>% html_text()
  ingredients <- h %>% html_nodes(".o-Ingredients__a-Ingredient") %>% html_text()
  return(list(recipe = recipe, prep_time = prep_time, ingredients = ingredients))
} 

get_recipe("http://www.foodnetwork.com/recipes/food-network-kitchen/pancakes-recipe-1913844")



#loading url
url <- "https://web.archive.org/web/20181024132313/http://www.stevetheump.com/Payrolls.htm"
h <- read_html(url)
h
#e the html_nodes() function and the table node type to extract the first table. 
nodes <- html_nodes(h, "table")
nodes
html_text(nodes[[8]])
html_table(nodes[[8]])
html_text(nodes[[6]])
html_table(nodes[[6]])
sapply(nodes[1:4], html_table)    # 2, 3, 4 give tables with payroll info
sapply(nodes[16:19], html_table)
# to look for last three nodes in website
html_table(nodes[[length(nodes)-2]])
html_table(nodes[[length(nodes)-1]])
html_table(nodes[[length(nodes)]])

tab1 <- html_table(nodes[[12]],header = TRUE)
tab1 <- tab1[-c(1)]
tab1
tab2 <- html_table(nodes[[21]],header = TRUE)
tab2
c<- full_join(tab1,tab2,by=c('Team'='Team'))

# full join 3
tab_1 <- html_table(nodes[[12]])
tab_2 <- html_table(nodes[[21]])
col_names <- c("Team", "Payroll", "Average")
tab_1 <- tab_1[-1, -1]
tab_2 <- tab_2[-1,]
names(tab_2) <- col_names
names(tab_1) <- col_names
full_join(tab_1,tab_2, by = "Team")

#opinion polling for the Brexit referendum 4&5

url <- "https://en.wikipedia.org/w/index.php?title=Opinion_polling_for_the_United_Kingdom_European_Union_membership_referendum&oldid=896735054"
tab <- read_html(url)%>%html_nodes("table") #count no. of table in website
length(tab)
tab %>% html_table(fill=TRUE)
html_table(tab[[5]],fill=TRUE,header=TRUE)
#answer
tab[[5]] %>% html_table(fill = TRUE) %>% names()    # inspect column names


