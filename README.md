# citation-network
RCitation - A quick way to create a citation network based on titles in R

A.R. Siders, siders@alumni.stanford.edu

Premise. This code identifies cross-citations within a set of texts. It does this by searching for full titles.
The rationale is that if Article 1 contains the full title of Article 2, it is because Article 1 cites Article 2. 

This is not a valid assumption if your researh field does not use full titles in the citation format, or if the titles
of the papers are short or comprised of very common words (e.g., a paper titled "Vulnerability" yields many false positives). 
Errors will be introduced by typos in the citation field, formatting problems when converting pdf to txt, and short citations
(e.g., when an author only cites the part of a title before the colon). This code is therefore a way to create a quick citation network but is not error-free. 

Getting Started. You will need: 

1. Papers: A set of texts in txt format. Batch converters from pdf and word are available online. 
The texts should be stored in a folder and should be the ONLY items in the folder. 
Texts should be in the same order as the titles in the csv file. 
Recommend naming all texts in Papers folder using author lasst name listed alphabetically. Organize titles in same order.

2. Titles: A csv file with a list of text titles in the first column with a header at the top. Other data may be in the csv. 

3. R 

4. Install the tm and plyr packages

   install.packages(c("tm","plyr"))

   library(tm)
   
   library(plyr)
 
 
  
