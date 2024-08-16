USE covid2;
-- Importando datos a la tabla covid_deaths
CREATE TABLE covid_deaths (
    iso_code VARCHAR(10),
    continent VARCHAR(50),
    location VARCHAR(100),
    date DATE,
    population BIGINT,
    total_cases BIGINT,
    new_cases BIGINT,
    new_cases_smoothed BIGINT,
    total_deaths BIGINT,
    new_deaths BIGINT,
    new_deaths_smoothed BIGINT,
    total_cases_per_million DECIMAL(10, 2),
    new_cases_per_million DECIMAL(10, 2),
    new_cases_smoothed_per_million DECIMAL(10, 2),
    total_deaths_per_million DECIMAL(10, 2),
    new_deaths_per_million DECIMAL(10, 2),
    new_deaths_smoothed_per_million DECIMAL(10, 2),
    reproduction_rate DECIMAL(4, 2),
    icu_patients BIGINT,
    icu_patients_per_million DECIMAL(10, 2),
    hosp_patients BIGINT,
    hosp_patients_per_million DECIMAL(10, 2),
    weekly_icu_admissions BIGINT,
    weekly_icu_admissions_per_million DECIMAL(10, 2),
    weekly_hosp_admissions BIGINT,
    weekly_hosp_admissions_per_million DECIMAL(10, 2)
);


LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\CovidDeaths.csv' 
INTO TABLE covid_deaths 
FIELDS TERMINATED BY ';' 
OPTIONALLY ENCLOSED BY '"' 
LINES TERMINATED BY '\r\n' 
IGNORE 1 LINES 
(@iso_code, @continent, @location, @date, @population, @total_cases, @new_cases, @new_cases_smoothed, 
@total_deaths, @new_deaths, @new_deaths_smoothed, @total_cases_per_million, @new_cases_per_million, 
@new_cases_smoothed_per_million, @total_deaths_per_million, @new_deaths_per_million, 
@new_deaths_smoothed_per_million, @reproduction_rate, @icu_patients, @icu_patients_per_million, 
@hosp_patients, @hosp_patients_per_million, @weekly_icu_admissions, @weekly_icu_admissions_per_million, 
@weekly_hosp_admissions, @weekly_hosp_admissions_per_million) 
SET 
    iso_code = @iso_code,
    continent = @continent,
    location = @location,
	date = STR_TO_DATE(@date, '%d/%m/%Y'),  -- Convirtiendo la fecha al formato adecuado    
    population = NULLIF(@population, ''),
    total_cases = NULLIF(@total_cases, ''),
    new_cases = NULLIF(@new_cases, ''),
    new_cases_smoothed = NULLIF(@new_cases_smoothed, ''),
    total_deaths = NULLIF(@total_deaths, ''),
    new_deaths = NULLIF(@new_deaths, ''),
    new_deaths_smoothed = NULLIF(@new_deaths_smoothed, ''),
    total_cases_per_million = NULLIF(@total_cases_per_million, ''),
    new_cases_per_million = NULLIF(@new_cases_per_million, ''),
    new_cases_smoothed_per_million = NULLIF(@new_cases_smoothed_per_million, ''),
    total_deaths_per_million = NULLIF(@total_deaths_per_million, ''),
    new_deaths_per_million = NULLIF(@new_deaths_per_million, ''),
    new_deaths_smoothed_per_million = NULLIF(@new_deaths_smoothed_per_million, ''),
    reproduction_rate = NULLIF(@reproduction_rate, ''),
    icu_patients = NULLIF(@icu_patients, ''),
    icu_patients_per_million = NULLIF(@icu_patients_per_million, ''),
    hosp_patients = NULLIF(@hosp_patients, ''),
    hosp_patients_per_million = NULLIF(@hosp_patients_per_million, ''),
    weekly_icu_admissions = NULLIF(@weekly_icu_admissions, ''),
    weekly_icu_admissions_per_million = NULLIF(@weekly_icu_admissions_per_million, ''),
    weekly_hosp_admissions = NULLIF(@weekly_hosp_admissions, ''),
    weekly_hosp_admissions_per_million = NULLIF(@weekly_hosp_admissions_per_million, '');


-- Importando datos a la tabla covid_vaccinations
CREATE TABLE covid_vaccinations (
    iso_code VARCHAR(10),
    continent VARCHAR(50),
    location VARCHAR(100),
    date DATE,
    new_tests INT,
    total_tests INT,
    total_tests_per_thousand FLOAT,
    new_tests_per_thousand FLOAT,
    new_tests_smoothed INT,
    new_tests_smoothed_per_thousand FLOAT,
    positive_rate FLOAT,
    tests_per_case FLOAT,
    tests_units VARCHAR(50),
    total_vaccinations INT,
    people_vaccinated INT,
    people_fully_vaccinated INT,
    new_vaccinations INT,
    new_vaccinations_smoothed INT,
    total_vaccinations_per_hundred FLOAT,
    people_vaccinated_per_hundred FLOAT,
    people_fully_vaccinated_per_hundred FLOAT,
    new_vaccinations_smoothed_per_million FLOAT,
    stringency_index FLOAT,
    population_density FLOAT,
    median_age FLOAT,
    aged_65_older FLOAT,
    aged_70_older FLOAT,
    gdp_per_capita FLOAT,
    extreme_poverty FLOAT,
    cardiovasc_death_rate FLOAT,
    diabetes_prevalence FLOAT,
    female_smokers FLOAT,
    male_smokers FLOAT,
    handwashing_facilities FLOAT,
    hospital_beds_per_thousand FLOAT,
    life_expectancy FLOAT,
    human_development_index FLOAT
);


LOAD DATA INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\CovidVaccinations.csv'
INTO TABLE covid_vaccinations
FIELDS TERMINATED BY ';'
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES
(@iso_code, @continent, @location, @date, @new_tests, @total_tests, @total_tests_per_thousand, @new_tests_per_thousand, 
 @new_tests_smoothed, @new_tests_smoothed_per_thousand, @positive_rate, @tests_per_case, @tests_units, 
 @total_vaccinations, @people_vaccinated, @people_fully_vaccinated, @new_vaccinations, @new_vaccinations_smoothed, 
 @total_vaccinations_per_hundred, @people_vaccinated_per_hundred, @people_fully_vaccinated_per_hundred, 
 @new_vaccinations_smoothed_per_million, @stringency_index, @population_density, @median_age, @aged_65_older, 
 @aged_70_older, @gdp_per_capita, @extreme_poverty, @cardiovasc_death_rate, @diabetes_prevalence, 
 @female_smokers, @male_smokers, @handwashing_facilities, @hospital_beds_per_thousand, @life_expectancy, 
 @human_development_index)
SET
    iso_code = @iso_code,
    continent = @continent,
    location = NULLIF(@location, ''),
    date = STR_TO_DATE(@date, '%d/%m/%Y'),
    new_tests = NULLIF(@new_tests, ''),
    total_tests = NULLIF(@total_tests, ''),
    total_tests_per_thousand = NULLIF(@total_tests_per_thousand, ''),
    new_tests_per_thousand = NULLIF(@new_tests_per_thousand, ''),
    new_tests_smoothed = NULLIF(@new_tests_smoothed, ''),
    new_tests_smoothed_per_thousand = NULLIF(@new_tests_smoothed_per_thousand, ''),
    positive_rate = NULLIF(@positive_rate, ''),
    tests_per_case = NULLIF(@tests_per_case, ''),
    tests_units = NULLIF(@tests_units, ''),
    total_vaccinations = NULLIF(@total_vaccinations, ''),
    people_vaccinated = NULLIF(@people_vaccinated, ''),
    people_fully_vaccinated = NULLIF(@people_fully_vaccinated, ''),
    new_vaccinations = NULLIF(@new_vaccinations, ''),
    new_vaccinations_smoothed = NULLIF(@new_vaccinations_smoothed, ''),
    total_vaccinations_per_hundred = NULLIF(@total_vaccinations_per_hundred, ''),
    people_vaccinated_per_hundred = NULLIF(@people_vaccinated_per_hundred, ''),
    people_fully_vaccinated_per_hundred = NULLIF(@people_fully_vaccinated_per_hundred, ''),
    new_vaccinations_smoothed_per_million = NULLIF(@new_vaccinations_smoothed_per_million, ''),
    stringency_index = NULLIF(@stringency_index, ''),
    population_density = NULLIF(@population_density, ''),
    median_age = NULLIF(@median_age, ''),
    aged_65_older = NULLIF(@aged_65_older, ''),
    aged_70_older = NULLIF(@aged_70_older, ''),
    gdp_per_capita = NULLIF(@gdp_per_capita, ''),
    extreme_poverty = NULLIF(@extreme_poverty, ''),
    cardiovasc_death_rate = NULLIF(@cardiovasc_death_rate, ''),
    diabetes_prevalence = NULLIF(@diabetes_prevalence, ''),
    female_smokers = NULLIF(@female_smokers, ''),
    male_smokers = NULLIF(@male_smokers, ''),
    handwashing_facilities = NULLIF(@handwashing_facilities, ''),
    hospital_beds_per_thousand = NULLIF(@hospital_beds_per_thousand, ''),
    life_expectancy = NULLIF(@life_expectancy, ''),
    human_development_index = NULLIF(@human_development_index, '');