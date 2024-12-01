# Children's Depression in the USA
## Overview
This paper uses a Bayesian logical regression model to analyze whether a child has depression using the predictors: being bullied, difficulty making or keeping friends, living with someone with mental illness, whether the child is a victim of violence or witnessed violence in the neighbourhood, and family poverty. The results indicate that children facing daily bullying, having a lot of difficulty making and keeping friends, living with someone who is mentally ill, suicidal, or severely depressed, and being a victim of violence or witnessing violence in their neighbourhood are more likely to have depression. 

The dataset used is the 2023 National Survey of Children’s Health. The raw data was not uploaded because of the size of the dataset.
Data can be found here: https://www.census.gov/programs-surveys/nsch/data/datasets.html

## File Structure
The repo is structured as:
-   `paper` contains the files used to generate the paper, including the Quarto document and reference bibliography, as well as the PDF of the paper. 
-   `scripts` contains the R scripts used to simulate, download, clean, test the data, and the script used to create and test the model.
-   `model` contains the model generated.
-   `other` contains the sketches, llm usage, and a datasheet.
-   `data` contains the simulated and cleaned datasets used to analyze children depression.

## LLM Usage
ChatGPT was used to generate codes and improve writings. Chats could be found in `other/llm/llm_usage.txt`.
