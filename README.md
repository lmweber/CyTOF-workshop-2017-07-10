# Information and teaching materials for CyTOF workshop

This repository contains information and teaching materials for the R data analysis sessions in our CyTOF workshop, 10-12 July 2017, University of Zurich, Switzerland.



## Workshop information

The workshop is organized by the [Mass Cytometry Facility](http://www.cytometry.uzh.ch/en/mcf.html) at the University of Zurich, Switzerland. This is an intensive 3-day workshop aimed at introducing mass cytometry (CyTOF) experimental procedures and computational data analysis for users and collaborators of the Mass Cytometry Facility. Additional details are available on the [Mass Cytometry Facility website](http://www.cytometry.uzh.ch/en/mcf/training.html).

**Location:** On Monday morning, we will meet in building **Y11**, room **J-05** (UZH Irchel campus) for an introduction. The R data analysis sessions (Monday and Tuesday) will also be held in this room. A map of the UZH Irchel campus showing the locations of the buildings is available [here](Irchel_campus_map.png) (click on the "Download" button to zoom in).

**Schedule:** The overall schedule for the workshop is available on the [Mass Cytometry Facility website](http://www.cytometry.uzh.ch/en/mcf/training.html). The R data analysis sessions ("Data analysis in scripted environment") will be repeated on days 1 and 2 for each group of participants.

**Instructors:** Instructors for the R data analysis sessions are [Mark Robinson](http://www.imls.uzh.ch/en/research/robinson.html) and [Lukas Weber](https://github.com/lmweber).



## Preparation

### System setup

Please consider bringing your own laptop to the workshop. This will be beneficial since then you will leave the workshop with a complete data analysis environment set up on your own machine, ready to continue with your own data analysis work. Workstations will also be available for you in the computer room, if this is not possible.

If you bring your own laptop, **install the latest versions of R and RStudio** before the workshop. Also, check that you have **administrative rights**, which are required to install software and some R packages (if it is a work laptop, you can confirm this with your IT service, or test it by re-installing R/RStudio and some R packages).

- **To install R**, download and run the installer for your system from [CRAN](https://cran.r-project.org/). On Windows systems, if you have separate user and administrator accounts, it is better to run the installer as administrator (right-click on .exe file and select "Run as administrator" instead of double-clicking). Otherwise problems may occur later when installing R packages.

- **To install RStudio**, download and run the "RStudio Desktop" (free version) installer for your system from the [RStudio](https://www.rstudio.com/) website.

If you have previously installed R and RStudio but have not updated them in a while, re-install the latest versions to ensure you have all the latest updates. (Note that R installations cannot be updated directly, so it is best to simply un-install and re-install the latest version.)


### DataCamp R courses

Prior to the workshop, you will receive a link to an introductory R course from [DataCamp](https://www.datacamp.com/). Please enroll and work through this course before the start of the workshop. The course teaches the basics of manipulating data in R. Completing the course will greatly speed up your learning process during the workshop, since you will have already seen several of the main R data concepts. It is very helpful to see these concepts more than once.

You will also receive a link to an intermediate R course from DataCamp, which teaches more advanced R concepts. This course is optional, but highly recommended if you are interested in performing more advanced data analyses.


### Data Carpentry and Software Carpentry

If you would like to continue to develop your data analysis skills in R, we highly recommend looking at some of the free lesson materials available from [Data Carpentry](http://www.datacarpentry.org/) and [Software Carpentry](https://software-carpentry.org/), or signing up for a future Data Carpentry or Software Carpentry workshop near you (these are held regularly at locations throughout the world).

For example, the [Data Carpentry: R for data analysis and visualization of ecological data](http://www.datacarpentry.org/R-ecology-lesson/) lesson, or the [Software Carpentry: Programming with R](http://swcarpentry.github.io/r-novice-inflammation/) lesson, provide excellent introductions.



## Schedule

The schedule for the R data analysis sessions ("Data analysis in scripted environment") will be as follows:

Overall structure: 1 day, 4x 1.5 hour blocks


| Time          | Content                                       |
|---------------|-----------------------------------------------|
|  9:00 - 10:30 | Introduction; Overview of CyTOF workflow in R |
|               | *(short break)*                               |
| 11:00 - 12:30 | R programming and plotting                    |
|               | *(lunch break)*                               |
| 13:30 - 15:00 | R programming and plotting (continued)        |
|               | *(short break)*                               |
| 15:30 - 17:00 | CyTOF workflow: interactive exercises         |



## Etherpad

We will use an Etherpad for discussions and questions during the workshop. You can add comments for the instructors or other learners at any time during the workshop.

The Etherpad is available here: [https://beta.etherpad.org/p/gaNC03Xroh](https://beta.etherpad.org/p/gaNC03Xroh)

Note that this Etherpad will expire after a few weeks, since we are using a free public instance.

Copies of the Etherpad notes from both days will be saved on this website in the following folder:

- [Etherpad](Etherpad/)



## R code scripts and slides

At the end of the workshop, we will provide the full interactive R code scripts from the examples shown during each session, as well as the presentation slides. The R scripts contain all the main commands shown during the demonstrations and workflow, including additional comments to explain each step.

- [scripts](scripts/)
- [slides](slides/)



## Data files

We will use the following data files for the interactive exercises during the sessions. Please download them and save them in a local folder on your computer (click on them, then click the "Download" button on the next page).

The .fcs files are sourced from a data set consisting of peripheral blood mononuclear cells (PBMCs) stimulated with B-cell receptor / Fc receptor cross-linker (BCR-XL), and unstimulated reference cells (total of 16 samples from 8 healthy donors; 8 stimulated vs. 8 unstimulated), from a larger CyTOF experiment comparing a number of stimulation conditions. The data set was initially created and published by [Bodenmiller et al. (2012), *Nature Biotechnology*](https://www.ncbi.nlm.nih.gov/pubmed/22902532), and re-analyzed by [Bruggner et al. (2014), *PNAS*](https://www.ncbi.nlm.nih.gov/pubmed/24979804).

- [example.fcs](data/example.fcs)

- [metadata.xlsx](data/metadata.xlsx)

- [Bodenmiller2012_BCRXL.zip](data/Bodenmiller2012_BCRXL.zip) (21.6 MB)



## Code of conduct

Participation in this workshop assumes acceptance of our code of conduct.

In short: please be professional and respectful towards others at all times. We want this to be a welcoming learning environment for all. If there are any problems, please let one of the instructors know.

For a longer version, we refer to [Laurent Gatto's lab code of conduct](https://lgatto.github.io/cpu-coc/) (Computational Proteomics Unit, University of Cambridge, UK).


