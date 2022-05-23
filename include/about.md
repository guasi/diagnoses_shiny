<DIV CLASS="row">
<DIV CLASS="col-sm-6">

## Purpose

I was looking for data on outpatient medical services in the U.S. and found that the CDC’s [National Center for Health Statistics (NCHS)](https://www.cdc.gov/nchs/ahcd/index.htm) holds a tight grip on this data. It’s pretty much inaccessible to someone like me, without access to SAS or STATA. I then looked for data at the DHHS’s [Health Care Cost and Utilization Project (HCUP)](https://www.hcup-us.ahrq.gov/overview.jsp), which provides actual data collected at hospitals and clinics and offers online access via [HCUP Net](https://hcupnet.ahrq.gov/). I thought I would familiarize myself with diagnoses in order to download pertinent data, but instead got sidetracked by the metadata of the metadata. One of the metadata files to understand the HCUP database is the metadata on diagnoses which amount to **73,371**, and the metadata to the metadata is a **66 page PDF file**!!. Easily navigating and searching the diagnoses became a project in itself. 

Thanks to the metadata of the metadata I was able to understand the system of classifying diagnoses. In this Shiny app you’ll find the Clinical Classifications Software Refined (CCSR)’s "21 body systems" labeled as **"Chapters,"** and their corresponding "530 clinical categories" labeled as **"Categories."** The International Classification of Diseases, Tenth Revision, Clinical Modification (ICD-10-CM) diagnoses are labeled as **"Diagnoses."** This grouping is the great achievement of the CCSR!! For simplicity, I have used the following abbreviations:

- CHA (chapters) refers to CCSR 3-character code abbreviations
- CAT (categories) refers to CCSR codes
- DIA (diagnoses) refers to ICD-10-CM codes

As I understand it, the [CCSR](https://www.hcup-us.ahrq.gov/toolssoftware/ccsr/ccs_refined.jsp) was developed as a tool for [HCUP](https://www.hcup-us.ahrq.gov/overview.jsp) given the size and complexity of the International Classification of Diseases. 

</DIV>
<DIV CLASS="col-sm-6">

## Lessons

The first big challenge was cleaning the list of of diagnoses that came in a hard-to-manipulate CSV file. I learned how to do a 18 to 3 long pivot.

Once I got it cleaned, it was smooth sailing until I got to creating the search for diagnoses. I first tried to search for diagnoses that contained all search terms by matching terms with the regular expression pattern `(?=*term)(?=*term2)` … `(?=*termN)`. No matter the function I used, `regex`, `str_detect`, `stri_detect`, the matching process was extraordinarily slow. True, I was searching 73,000 entries with a few sentences each. I turned to [StackOverflow](https://stackoverflow.com/questions/72334928/r-fast-way-to-find-all-vector-elements-that-contain-all-search-terms) for help and [@onyamby](https://stackoverflow.com/users/8380272/onyambu) provided an amazingly fast single line of code. It is surprisingly easy when you think about it, instead of looping through each string and matching all search terms with a regular expression, loop through each search term separately and then get the overlapping `TRUE` results. You can see the discussion [here](https://stackoverflow.com/questions/72334928/r-fast-way-to-find-all-vector-elements-that-contain-all-search-terms).

The next challenge was trying to update a dependent table upon a click on a row using the [DT package](https://rstudio.github.io/DT/). But DT doesn’t make available full table information as `inputs` ready to be used by Shiny. For instance, if a user clicks on cell (2,3), you can’t know through DT the value for another cell in the same row, say cell (2,4). To solve this problem I store a vector of IDs of the "active" table. I think this is a waste of resources, but I made the best of it, instead of storing the whole "active" data frame, I store only an "index" vector. 

Now I can go back and get the real data I want! Anyone knows how to hack the HCUP interface to get raw data? I don’t want summary tables, I want to make my own analysis!

</DIV>
</DIV>

