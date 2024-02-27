# Causal Inference

## Causal Inference Introduction
The goal of this GitLab project and repository is to share methods and code implementation of causal methods. 
Code should be accompanied with sample data for researchers to understand the data format required for analysis.
Futhermore, code should be accompanied by peer reviewed journals.  

## Study Designs

### Target Trial Emulation (TTE)
Paper: Hernan et al., 2022. DOI: 10.1001/jama.2022.21383

To reduce confounding and other sources of bias impacting data collected outside of randomised controlled trials, Target Trial Emulation (Hernan et al., 2022) maps observational data to a hypothetical target experimental trial by creating the specification of an ideal (pragmatic) trial. Using this mapping as a basis, observational data is then shaped. Target Trial Emulation firstly consists of deining the specification of a hypothetical, ideal experiment of the causal question of interest (including the corresponding causal contrast), secondly emulating the specifications of the ideal target trial using observational data and thirdly, estimating the effects of the interest using the emulated trial data. The first component includes defining inclusion/exclusion criterion on entry, a treatment strategy (including time of assignment and entry), follow-up frequency and modality, outcome measures causal constrasts of interest and the analytical estimation methods for an ideal trial. Using the second component of TTE, observational data is wrangled to emulate the distribution of the data if it were to have been gathered prospectively in ideal trial. Finally, the third component of TTE requires using methods to adjus for known and suspected confounding. 

#### Staggered Cohorts
Paper: Nguyen at al., 2023: DOI: 10.1093/ije/dyad002 <br />
Link to code: https://github.com/END-VOC/WP5_Causal_Inference/tree/main/Target%20Trial%20Emulation%20-%20Staggered%20Cohorts <br />
Mechanism to estimate causal inference: Reduction of time-varying-confounding-by-indication through stratification and meta-analysis

Staggered cohorts should be used in conjunction with Target Trial Emulation where there are cohort effects. An example of this in COVID is vaccination date itself is a determinant of time-to-infection. E.g. Those vaccinated in December 2021 were at higher risk of SARs-CoV-2 (due to Omicron's immune escape) compared to those who were vaccinated in September 2021 (Delta dominance). 

## Theory behind Causal Inference
 
#### Potential Outcomes Framework 
Paper <br />
Link to code <br />

The potential outcomes framework, also known as the Rubin causal model, is an approach to understand causality. In short, the Potential Outcomes Framework postulates the following: Given an individual, and their characteristics, what is the outcome under treatment versus what is the outcome under non-treatment. **Therefore, under the potential outcomes framework, we estimate causal inference by removing the arrow from confounders to treatment as an individual's baseline characteristic does not  predict their treatment strategy. ** As it is impossible to view both outcomes and is known as the "fundamental problem of causal inference". Because of the "fundamental problem of causal inference", we must model the potential outcomes for each individual but this requires at least 3 assumptions: 

###### Positivty
    For each unit, there is a non-zero probability of recieving treatment. To test this, we evaluate the overlap of the propensity scores for treated and non treated. 

###### Exchnagability
    That the results would be the same if treatment regimes were swapped. i.e: If Treatment was 2X more effective, treatment would still be 2X more effect if the non-treated were treated and the treated were not treated. 

###### Non-interference
    That the treatment status of any individual does not impact the outcome of another. This can be difficult in vaccination based studies where herd immunity helps protect against immunlogically naieve individuals. 


#### Estimands
After we model the potential outcomes for each individual, we can create a few estimands to understand the impact of treatment. These estimands include (but not limited to):

###### Average Treatment Effect (ATE)
    For all individuals, the difference between the hypothetical outcome under treatment and the hypothetical outcome under the reference group. This can be expressed as a ratio or a potential means difference

###### Avergae Treatment Effect in the Treated (ATT)
    For all treated individuals, the difference between the hypothetical outcome under treatment and the hypothetical outcome under the reference group. This can be expressed as a ratio or a potential means difference. This represents the situation where those who were treated were to loose treatment. 

###### Average Treatment Effect in the Not Treated/Average Treatment Effect in the Controls (ATNT/ATC)
    For all  non treated individuals, the difference between the hypothetical outcome under treatment and the hypothetical outcome under the reference group. This can be expressed as a ratio or a potential means difference. This represents the situation where those who were not treated were to recieve treatment. 


## Epidemological Methods for Causal Inference

The following are epidemiological methods  used in causal inference work. These include propensity score based methods, and outcome based methods. 

#### Propensity Score Matching
Paper<br />
Link to code<br />
Mechanism to estimate causal inference: The probability of recieving treatment is distributed similarly amongst treated and non treated individuals


#### Inverse Probability Weighting 
Paper<br />
Link to code<br />
Mechanism to estimate causal inference: Two psuedo-populations are created, one under treatment, and the other under non-treatment. Each pseudo-population contains all individuals from the study population, therefore, this removes the link between baseline characteristics and treatment assignment. 

#### G-Formula and outcome based models
Paper<br />
Link to code <br />
Mechanism to estimate causal inference: Each individual is treated as being treated and non-treated; therefore, there is no link between baseline characteristics and treatment assignment. 

#### Doubly-robust methods
Paper<br />
Link to code<br />
Mechanism to estimate causal inference: Each individual is treated as being treated and non-treated; therefore, there is no link between baseline characteristics and treatment assignment. 


## Econometric Methods for Causal Inference

The following are economic metric methods used to estimate causal inference. 

#### Difference in Difference (DiD)
Paper<br />
Link to code<br />
Mechanism to estimate causal inference<br />

#### Two way fixed effects (TWFE)
Paper<br />
Link to code<br />
Mechanism to estimate causal inference<br />


## Machine Learning Methods

#### Inverse Probability Weighting - using machine learning propensity scores
Paper<br />
Link to Code<br />
Mechanism to estimate causal inference: Two psuedo-populations are created, one under treatment, and the other under non-treatment. Each pseudo-population contains all individuals from the study population, therefore, this removes the link between baseline characteristics and treatment assignment. 

#### Doubly Robust Methods - using Least Absolute Shrinkage and Selection Operator 
Paper<br />
Link to Code<br />
Mechanism to estimate causal inference: Each individual is treated as being treated and non-treated; therefore, there is no link between baseline characteristics and treatment assignment. 


#### Targetted Maximum Likelihood Estimation
Paper<br />
Link to code<br />

