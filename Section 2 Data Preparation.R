fin <- read.csv("Future 500.csv")
head(fin)#return first 6 rows
tail(fin)#return last 6 rows
str(fin)
summary(fin)
#Change from non-factor to factor
fin$ID <- factor(fin$ID)
summary(fin)
str(fin)
fin$Inception <- factor(fin$Inception)
#The factor variable trap(FVT)
a <- c("12","13","14","12","12")
a
typeof(a)
b <- as.numeric(a)
b
typeof(b)
#convert into numeric for factor
z <- factor( c("12","13","14","12","12"))
z
y <- as.numeric(z)
y
#---------------------correct
x <- as.numeric(as.character(z))
x
typeof(x)
#FVT example:
#fin$Profit <- factor(fin$profit) #dangerous
#gsub and sub
fin$Expenses <- gsub(" Dollars","",fin$Employees)
fin$Expenses <- gsub(",","",fin$Expenses)
head(fin)
fin$Revenue <- gsub("\\$","",fin$Revenue)#remmeber \\befor"$",escape squence
fin$Revenue <- gsub(",","",fin$Revenue)
fin$Growth <- gsub("%","",fin$Growth)
str(fin)
fin$Revenue <- as.numeric(fin$Revenue)
fin$Expenses <- as.numeric(fin$Expenses)
fin$Growth <- as.numeric(fin$Growth)
str(fin)
#Deal with Missing Data:
# 1.Predict with 100% accuracy
# 2.Leave the record as it is
# 3. Remove recorded entirely
# 4.Replace with mean/median
# 5.Fill in by exploring correlation&similarity
# 6. Introduce dummy variables for "Missingness"
#The elegant way to locate missing data:
complete.cases(fin)
fin[!complete.cases(fin),]
#empty cell in " " which datatype is factor can't recognize it as NA,so..
fin <- read.csv("Future 500.csv",na.string= c(""))
fin
#data filter which() for non-mising data
#fin[fin$Revenue == 9746272,]
#which(fin$Revenue == 9746272)#look through vector and return row index
#fin[which(fin$Revenue == 9746272),]
fin[which(fin$Employees == 45),]
fin[fin$Employees == 45,]
#data filter is.na() for missing data:
fin[is.na(fin$Employees),]
#Remove record with missing data: clean dataset: make a backup
fin_backup <- fin
fin[!complete.cases(fin),]
fin[is.na(fin$Industry),]
fin <- fin[!is.na(fin$Industry),]
#check
fin[is.na(fin$Industry),]
#Resetting Dataset index:
rownames(fin) <- 1:nrow(fin)
#Quick Trip
rownames(fin) <- NULL
#Replacing Missing Data Factural Analysis Method:
fin[is.na(fin$State),]
fin[is.na(fin$State) & fin$City == "New York",] 
fin[is.na(fin$State) & fin$City == "New York","State"] <- "NY"
#Check
fin[c(11,377),]#377 because remove 2 rows when remove NA fin$industry
#Replacing Missing Data:Multi
fin[is.na(fin$State),]
fin[is.na(fin$State) & fin$City == "San Francisco","State"] <- "CA"
fin[c(82,265),]
#Replacing Missing Data: Median Imputation Method
fin[!complete.cases(fin),]
median(fin[,"Employees"],na.rm=T)
mean(fin[,"Employees"],na.rm=T)
med_employees = median(fin[fin$Industry == "Retail","Employees"],na.rm=T)
med_employees
mean(fin[fin$Industry == "Retail","Employees"],na.rm=T)

fin[is.na(fin$Employees),]
fin[is.na(fin$Employees) & fin$Industry == "Retail",]
fin[is.na(fin$Employees) & fin$Industry == "Retail","Employees"] <- med_employees
#Check
fin[3,]
fin[is.na(fin$Employees),]
fin[is.na(fin$Employees) & fin$Industry == "Services","Employees"] <- med_employees
#Check
fin[330,]
