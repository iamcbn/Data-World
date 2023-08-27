# The World of Data
This is a SQL project to explore the earning potentials of data professionals.

![Image](Image.png)

# Introduction
Join me as I explore the world of data concentrating on data professionals in different fields of data. I divided the project into two sections which are the data modification section and EDA.

# Data Source
This projects has two different tables. The first table, Salaries was gotten from Kaggle while the second table was from Wikipedia.

# DS_Salaries by Kaggle
ds_salaries.csv is a dataset uploaded to Kaggle by Ruchi Bhatia containing the salaries of workers in the data science jobs or related to it, including a certain amount of features for each individual such as:

work_year : The year the salary was paid.

experience_level: The experience level in the job during the year with the following possible values:
- EN: Entry-level / Junior
- MI: Mid-level / Intermediate
- SE: Senior-level / Expert
- EX: Executive-level / Director.

employment_type: The type of employement for the role: 
- PT: Part-time
- FT: Full-time
- CT: Contract
- FL: Freelance.

job_title: The role worked in during the year.

employee_residence: Employee's primary country of residence in during the work year as an ISO 3166 country code.

remote_ratio: The overall amount of work done remotely, possible values are as follows:
- 0: On-site
- 50: Hybrid
- 100: Remote

company_location: The country of the employer's main office or contracting branch as an ISO 3166 country code.

company_size: The average number of people that worked for the company during the year:
- S: less than 50 employees (small)
- M: 50 to 250 employees (medium)
- L: more than 250 employees (large).

salary: The total gross salary amount paid.

salary_currency: The currency of the salary paid as an ISO 4217 currency code.

salary_in_usd: The salary in USD (FX rate divided by avg. USD rate for the respective year via fxdata.foorilla.com).

# EDA (Exploratory Data Analysis)
For the full SQL documentaion, I reckon you to check this [file](https://github.com/iamcbn/Data-World/blob/main/DSSalary%20Project.ipynb).

Also, to download the database, click [here!](https://github.com/iamcbn/Data-World/blob/main/DSSalary.bak)

To get the .csv file, click [here!](https://github.com/iamcbn/Data-World/blob/main/ds_salaries.csv)
