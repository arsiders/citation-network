# RCitation - Quick Citation Network 
# Fall 2018 
# A.R. Siders (siders@alumni.stanford.edu)

# Creates a network of the citations among a set of academic papers. 
# Rationale: If full title of Article 2 is present in text of Article 1, Article 1 cites Article 2. 
# NOTE: Will only work in fields where full, unabbreviated titles are used in reference/bibliography citation format. 
# NOTE: Will have high error rate if titles are very short or comprised of common words (e.g., paper "Vulnerability" produced many false positives). Some errors result from authors using a shortened version of a title (e.g., only text before a colon) or incorrect citations or typos. Citation networks produced are therefore approximate and to be used primarily for exploration of the data.
# NOTE: Error rate may be reduced by using only reference sections of the articles of interest, rather than full texts, but this will increase work required to prepare articles. 


# ==> FIVE STEPS TO CITATION NETWORK

# STEP 1. FORMAT INPUT
# a. Papers: Folder of papers in txt format (UTF-8) organized *in SAME ORDER* as Titles 
# b. Titles: Column of paper titles in csv spreadsheet (Column #1) *in SAME ORDER* as documents in Papers folder. Need a header cell or top title will be removed.
# Recommend naming all texts in Papers folder using author last name listed alphabetically. Organize Titles using same order.


# STEP 2.  PREP
# set working directory
setwd("C:\[name of working space]") # make sure \ not / in name
# load packages
install.packages(c("tm","plyr"))
library(tm)
library(plyr)


# STEP 3. LOAD INPUTS
# a. Papers 
papers<-Corpus(DirSource("[name of folder where papers located]"))
# b. Titles
titletable<-read.csv("[name of titles file].csv") #make sure column has a header
titles<-as.vector(titletable[,1])
# load functions at bottom of this script (below Step 5)


# STEP 4. RUN FUNCTION 

CitationNetwork<-CreateCitationNetwork(papers,titles)
# add date
currentDate <- Sys.Date()
csvFileName <- paste("CitationEdges",currentDate,".csv",sep="")
# save results
write.csv(CitationNetwork, file=csvFileName) 

  
# STEP 5. VISUALIZE NETWORK

# Install Gephi or other network visualization software and load CitationEdges.csv 
# Load list of titles or other spreadsheet as nodes to visualize network 
# Gephi available at https://gephi.org/


# ===> FUNCTIONS TO LOAD 

CreateCitationNetwork<-function(papers,titles){
  # prep papers corpus
  papers<-tm_map(papers, content_transformer(tolower))
  papers<-tm_map(papers, removePunctuation)
  papers<-tm_map(papers, removeNumbers)
  papers<-tm_map(papers, stripWhitespace)
  # prep titles 
  titles<-removePunctuation(titles)
  titles<-stripWhitespace(titles)
  titles<-tolower(titles)
  # create citation true/false matrix
  Cites.TF<-CiteMatrix(titles, papers)
  # format matrix into edges file 
  CitationEdges<-EdgesFormat(Cites.TF, titles)
  return(CitationEdges)
}  

# format true/false matrix into edges file 
EdgesFormat<-function(Cites.TF, titles){
  #create an empty object to put information in
  edges<-data.frame(matrix(NA), nrow=NA, ncol=NA)
  colnames(edges)<- c("Source","Target","Weight")
  for (i in 1:length(Cites.TF)){
  #for each document, run through all titles accross columns
    for (j in 1:ncol(Cites.TF)){
      # for each title, see if document [row] cited that title [column]
      if (Cites.TF[i,j]==TRUE){  #if document is cited
        temp<-data.frame(matrix(NA), nrow=NA, ncol=NA)
        colnames(temp)<- c("Source","Target","Weight")
        # first column <- document doing the citing 
        temp[1,1]<-titles[i]
        # second column <- document being cited
        temp[1,2]<-titles[j]
        # third column the yes/no [weight]
        temp[1,3]<-1  
        edges<-rbind(edges,temp)    
      } 
    }
  }  
  return(edges[-1,]) #-1 removes initial row of null values
}

# Citation true/false matrix 
CiteMatrix<-function(search.vector, Ref.corpus){
  # Creates a csv matrix with True/False for citation patterns 
  citations<-data.frame(matrix(NA, nrow = length(Ref.corpus), ncol=length(search.vector)))
  #Columns are the document being cited
  colnames(citations)<-search.vector
  #Rows are the document doing the citing 
  rownames(citations)<-search.vector
  for (i in 1:length(search.vector)){
    searchi<-search.vector[i]
    papercite<-grepl(searchi, Ref.corpus$content, fixed=TRUE)
    citations[,i]<-papercite
  }
  return(citations)
}
