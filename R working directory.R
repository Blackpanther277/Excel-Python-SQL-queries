install.packages("tidyverse")

# printing working directory
getwd()
dir()
getwd()

# Extract the name of the 10th company
df[["company"]][10]

## Accessing columns and rows

head(df["city"])

df$company[1] # 1st company in this list


df$rank[5] # 5 index rank column


df$rank[5] # 5 index rank column

df$company[1] # 1st company in this list

df$city[-1]# return all elements

df$rank[1:5] # first 5 elements rank column

df$company[1:5]

df["state_l"][1:5,] # will also return first 5 rows




head(df$city, 20) # first 20 elements rank column

# Display the first 15 rows of the "company" and "state_l" columns
df[1:15, c("company", "state_l")]

head(df[["company"]],15,(df[["state_l"]]),15)

df$company[1:15]

df$state_l[1:15]

head(df$state_l,15) 

head(df$company, 15)

df[1:15, c("company", "state_l")]

# companies more than 1000 workers
df[df$workers > 1000, c("company")]

# companies more than 1000 workers df[rows, columns]
df[df$workers > 1000, c("company")]

head(df[df$workers > 1000, c("company")], 5) # first 5

subset(df, df$workers>1000)
subset(df$company, df$workers>1000)
?subset

df[1] #fist column
df["X_input"] #fist column
df$X_input #fist column

df[1:5, 1] # first 5 rows on first column

df[1, 1:5] # first row and first 5 column

df[1:5, which(colnames(df) == "rank")]
df[1:5, "rank"] # first 5 rows of rank column

tail(df[, c("rank", "company", "city", "state_s", "growth")]) # last 6 companies

# column calculations
mean(df$workers) # average number of workers in dataset
min(df$workers)
max(df$workers)

median(df$workers)


df[df$workers==0, "company"] # companies with 0 number of workers all of the columns


max(df$revenue)

min(df$revenue)

median(df$revenue)

mean(df$revenue)

# return company name with highest revenue

df[df$revenue==max(df$revenue) ,"company"]

# return companies are below the avg revenue

df[df$revenue <= mean(df$revenue) ,"company"] # 4126 companies

# Assuming 'df' contains the revenue data for Pinterest with columns 'company' and 'revenue'
pinterest_revenue_current <- df[df$company == "Pinterest", "revenue"][2]  # current year revenue
pinterest_revenue_previous <- df[df$company == "Pinterest", "revenue"][1]  # previous year revenue

# Calculate growth percentage
growth_percentage <- ((pinterest_revenue_current - pinterest_revenue_previous) / pinterest_revenue_previous) * 100

# Check if growth percentage is lower than 50%
growth_percentage < 50

# Select the 5th and 10th companies, displaying company, revenue, and rank columns
df[c(5, 10), c("company", "revenue", "rank")]

# Find the average years of companies in the list
mean(df$yrs_on_list, na.rm = TRUE)

# Count companies with growth percentage > 50 and < 100
count <- nrow(df[df$growth_percentage > 50 & df$growth_percentage < 100, ])
count

subset(df, df$revenue>500000000)
subset(df, df$revenue>500000000)$company

subset(df, df$revenue>500000000)

subset(df, df$revenue>500000000)$company

mean(df$yrs_on_list)

subset(df, df$yrs_on_list < mean(df$yrs_on_list))$company

# this code will return company names where company is on the list 

#less than average of all companies

# Extract company names with more than 10,000 workers using subset
large_companies <- subset(df, workers > 10000, select = company)
large_companies

# Extract and display details of companies with revenue greater than $1 billion
billion_dollar_companies <- subset(df, revenue > 1e9)
billion_dollar_companies

#Cleaning dataset

## Checking duplicates

duplicated(df) # will return true and false

sum(duplicated(df)) # return number of true values

sum(duplicated(df$id))

na.omit(df) 

# this is going to remove entire row even if there is only a single

# column with missing value

cleaned_df = na.omit(df)

# syntax with back ticks give the desired output
df_subset = subset(df, select = -`X_num`)
df_subset

# rounding up growth column

head(df$growth)

df$growth = round(df$growth,0)

head(df$growth)

ggplot(df, aes(x=revenue, y=growth)) + 
  geom_boxplot(outlier.colour = "purple", outlier.shape = 1)+ 
  scale_x_continuous(labels = scales::comma)+coord_cartesian(ylim = c(0, 1000))

# Outliers
median(df$growth)
quantile(df$growth, 0.25)

q1_growth = quantile(df$growth, 0.25)
q1_growth # 84

q3_growth = quantile(df$growth, 0.75)
q3_growth # 348

iqr_growth = q3_growth - q1_growth
iqr_growth
IQR(df$growth)

upper_boundary = q3_growth + 1.5 * iqr_growth
upper_boundary

lower_boundary = q1_growth - 1.5 * iqr_growth
lower_boundary



cleaned_df = subset(df, df$growth < upper_boundary & 
                      
                      df$growth > lower_boundary)

dim(df)

dim(cleaned_df)

mean(df$growth) 

mean(cleaned_df$growth)


median(df$growth)

median(cleaned_df$growth)
ggplot(cleaned_df, aes(x=rank, y=workers)) + 
  geom_point()+ scale_y_continuous(labels=scales::comma)+
  coord_cartesian(ylim = c(0, 300))

#exporting dataset
write.csv(cleaned_df, "cleaned_df.csv")