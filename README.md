# citation-network
RCitation - A quick way to create a citation network based on titles in R

A.R. Siders, siders@alumni.stanford.edu

## Intro
* This code identifies cross-citations within a set of texts. 
* It works by searching for full titles. The rationale is that if Article 1 contains the full title of Article 2, it is because Article 1 cites Article 2. 
* This approach will not work if a field does not use full titles in the citation format or if paper titles are very short or comprised of common phrases (e.g., a paper titled "Vulnerability" yields many false positives in a network of climate vulnerability studies). 
* Errors arise due to typos in the text citations, formatting problems when converting texts from pdf to txt, or short citations (e.g., when an author only cites the part of a title before a colon). This approach is a quick but inexact way to create a citation network and is useful for exploring patterns and clusters.  
* The code uses R packages `tm` and `plyr` to load and search texts.  

## Getting Started

### You will need: 

1. **Papers:** A set of texts in txt format. Batch converters from pdf and word are available online. The texts should be stored in a folder and should be the ONLY items in the folder. Texts must be in the same order as the titles in the csv file. One approach is to save all texts in Papers folder using author last name listed alphabetically, and then to organize titles in same order. Texts may include the full text of studies or, to reduce error rates, just the reference sections of studies. 

2. **Titles:** A csv file with a list of text titles in the first column with a header at the top. (Or you may edit the code to reference the appropriate column when reading in the title csv.) [Web of Science](webofknowledge.com) provides titles in this column format when bibliographic information is downloaded.  

3. **Network Visualizer:** Results are formatted to be uploaded as an edges table into [Gephi](https://gephi.org/) network visualization and anlaysis software, but any network visualization software or other R code could be used instead. 

## To Test 

In the "test files" folder are sample texts (reference lists from academic studies in txt format) and titles (a list of paper titles in a csv document with header) that can be used to test the citation network code. 

1. Download testtitles.csv to your working directory. 
2. Download all 20 test papers into a folder in your working directory. 
3. Use provided results to compare with your output.

Common errors include a) papers not being in alphabetical order, and b) reading in the wrong number of titles (should be 20). 
