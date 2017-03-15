# Information and teaching materials for CyTOF workshop

This repository contains information and teaching materials for the R data analysis sessions in our CyTOF workshop, 13-15 March 2017, University of Zurich, Switzerland.



## Workshop information

The workshop is organized by the [Mass Cytometry Facility](http://www.cytometry.uzh.ch/en/mcf.html) at the University of Zurich, Switzerland. This is an intensive 3-day workshop aimed at introducing mass cytometry (CyTOF) experimental procedures and data analysis for users and collaborators of the Mass Cytometry Facility. Additional details are available on the [Mass Cytometry Facility website](http://www.cytometry.uzh.ch/en/mcf/training.html).

**Location:** On Monday morning, we will meet in building **Y22**, room **G-74** ("Dozentenfoyer", next to the "Seerose" cafeteria, UZH Irchel campus) for a brief introduction. The R data analysis sessions (Monday and Tuesday) will be held in building **Y01**, computer room **F-08**. A map of the UZH Irchel campus showing the locations of the buildings is available [here](Irchel_campus_map.png) (click on the "Download" button to zoom in).

**Schedule:** The overall schedule for the workshop is available on the [Mass Cytometry Facility website](http://www.cytometry.uzh.ch/en/mcf/training.html). The R data analysis sessions ("Data analysis in scripted environment") will be repeated on days 1 and 2 for each group of 4-5 participants.

**Instructors:** Instructors for the R data analysis sessions are [Mark Robinson](http://www.imls.uzh.ch/en/research/robinson.html) and [Lukas Weber](https://github.com/lmweber).



## Preparation

### System setup

If possible, please **bring your own laptop** and **install R and RStudio** before the workshop. This will ensure that you will leave the workshop with a complete data analysis system set up on your own laptop, ready to continue with your data analysis work.

Workstations will also be available in the computer room, if this is not possible.

- **To install R**, download and run the installer for your system from [CRAN](https://cran.r-project.org/). On Windows systems, if you have separate user and administrator accounts, it is better to run the installer as administrator (right-click on .exe file and select "Run as administrator" instead of double-clicking). Otherwise problems may occur later when installing R packages.

- **To install RStudio**, download and run the "RStudio Desktop" (free version) installer for your system from the [RStudio](https://www.rstudio.com/) website.

If you have previously installed R and RStudio but have not updated them in a while, please re-install the latest versions. (R installations cannot be updated easily, so it is simpler to un-install and re-install using the latest version.)


### DataCamp R courses

Prior to the workshop, you will receive an email with a link to an introductory R course from [DataCamp](https://www.datacamp.com/). Please enroll and work through this course in your own time, before the workshop. The course teaches the basics of manipulating data in R. Completing the course will greatly speed up your learning process during the workshop, since you will have already seen several of the main R data concepts. These concepts are generally not intuitive, so it is very helpful to see them more than once.

After the workshop, you will also receive a link to an intermediate R course from DataCamp, where you can continue to learn more advanced R concepts, which are useful for performing more advanced data analyses.


### Data Carpentry and Software Carpentry

If you would like to continue to develop your R data analysis skills, we highly recommend looking at some of the free lesson materials available from [Data Carpentry](http://www.datacarpentry.org/) or [Software Carpentry](https://software-carpentry.org/) (or signing up for a future Data Carpentry or Software Carpentry workshop, if one is available near you).

For example, the [Data Carpentry: R for data analysis and visualization of ecological data](http://www.datacarpentry.org/R-ecology-lesson/) lesson, or the [Software Carpentry: Programming with R](http://swcarpentry.github.io/r-novice-inflammation/) lesson, provide excellent introductions.



## Schedule

The schedule for the R data analysis sessions ("Data analysis in scripted environment") will be as follows:

Overall structure: 1 day, 4x 1.5 hour blocks


| Time          | Content                                       |
|---------------|-----------------------------------------------|
|  9:00 - 10:30 | Introduction                                  |
|               | *(short break)*                               |
| 11:00 - 12:30 | R programming                                 |
|               | *(lunch break)*                               |
| 13:30 - 15:00 | CyTOF workflows and plotting in R             |
|               | *(short break)*                               |
| 15:30 - 17:00 | CyTOF workflows and plotting in R (continued) |



## Etherpad

We will use an Etherpad for discussions and questions during the workshop. You can add questions or comments for the instructors or other learners at any time during the workshop.

The Etherpad is available here: [https://beta.etherpad.org/p/VaaeWno43s](https://beta.etherpad.org/p/VaaeWno43s)

Note that this Etherpad will expire after a few weeks, since we are using a free public instance.

Copies of the Etherpad notes from both days are saved in the following folder:

- [Etherpad](Etherpad/)



## R code scripts and slides

At the end of the workshop, we will provide the interactive R code scripts from the examples shown during each session, as well as the presentation slides. The R scripts contain all the main commands shown during the demonstrations, including additional comments to explain each step.

The CyTOF workflow script `CyTOF_workflow_master_script.R` also contains additional steps that were not shown during the demonstrations, e.g. FlowSOM clustering, t-SNE plots, differential analysis, and more advanced `ggplot2` plots.

- [scripts](scripts/)
- [slides](slides/)

An additional example demonstrating FlowSOM clustering and Rtsne for visualization is also available in the [FlowSOM-Rtsne-example](https://github.com/lmweber/FlowSOM-Rtsne-example) repository.



## Data files

We will use the following data files for the interactive exercises during the sessions. Please download them and save them in a local directory on your computer (click on them, then click the "Download" button on the next page).

The .fcs files are sourced from a data set consisting of peripheral blood mononuclear cells (PBMCs) stimulated with B-cell receptor / Fc receptor cross-linker (BCR-XL) and unstimulated reference cells (16 samples from 8 healthy donors; 8 stimulated vs. 8 unstimulated), from a larger CyTOF experiment comparing a number of stimulation conditions. The data set was initially created and published by [Bodenmiller et al. (2012), *Nature Biotechnology*](https://www.ncbi.nlm.nih.gov/pubmed/22902532), and re-analyzed by [Bruggner et al. (2014), *PNAS*](https://www.ncbi.nlm.nih.gov/pubmed/24979804).

- [example.fcs](data/example.fcs)

- [metadata.xlsx](data/metadata.xlsx)

- [BodenmillerEtAl2012_BCRXL.zip](data/BodenmillerEtAl2012_BCRXL.zip) (21.6 MB)



## Code of conduct

Participation in this workshop assumes acceptance of our code of conduct.

In short: please be professional and respectful towards others at all times. We want this to be a welcoming learning environment for all. If there are any problems, please let one of the instructors know.

For a longer version, we refer to [Laurent Gatto's lab code of conduct](https://lgatto.github.io/cpu-coc/) (Computational Proteomics Unit, University of Cambridge, UK).


