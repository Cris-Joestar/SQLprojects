-- MUERTES

-- Datos de las muertes por covid
SELECT location, date, total_cases, new_cases, total_deaths, population
FROM covid2.covid_deaths
ORDER BY location, date;

-- Casos totales vs muertes totales en Perú
-- El porcentaje de muerte muestra la probabilidad de morir si contraes covid en el Perú
SELECT location, date, total_cases, total_deaths, ROUND((total_deaths / total_cases) * 100, 2) AS death_percentage
FROM covid2.covid_deaths
WHERE location = 'Peru'
ORDER BY 1, 2;

-- Casos totales vs población
-- Muestra el porcentaje de la población con covid
SELECT location, date, total_cases, population, ROUND((total_cases / population) * 100, 2) AS people_with_covid_percentage
FROM covid2.covid_deaths
WHERE location = 'Peru'
ORDER BY 1, 2;

-- Países con mayor tasa de infección comparada con su población
SELECT location, population, MAX(total_cases)AS highest_infection , MAX(ROUND((total_cases / population) * 100, 2)) AS people_with_covid_percentage
FROM covid2.covid_deaths
GROUP BY 1, 2
ORDER BY 4 DESC;


-- Países con mayor tasa de muertes comparada con su población
SELECT location, population, MAX(total_deaths)AS highest_death , MAX(ROUND((total_deaths / population) * 100, 2)) AS people_death_with_covid_percentage
FROM covid2.covid_deaths
GROUP BY 1, 2
ORDER BY 4 DESC;

-- Paises con la mayor contador de muertes por poblacion 
SELECT location, MAX(total_deaths) AS total_death_count
FROM covid2.covid_deaths
WHERE continent != ""
GROUP BY location
ORDER BY total_death_count DESC;

-- máximo número de muertes por continente
SELECT continent, MAX(total_deaths) AS total_death_count
FROM covid2.covid_deaths
WHERE continent != ""
GROUP BY continent
ORDER BY total_death_count DESC;

-- Números globales
SELECT SUM(new_cases) AS total_cases, SUM(new_deaths)AS total_deaths, (SUM(new_deaths) / SUM(new_cases)) * 100 AS death_percentaje
FROM covid2.covid_deaths
WHERE continent != ""
ORDER BY 1, 2;


-- VACUNACIONES

-- Total poblacion vs total vacunados
-- Usando CTE
WITH PopulationVSVaccination (Continent, Location, Date, Population, New_Vaccinations, cumulative_number_vaccinated_people)
AS (
	SELECT d.continent, d.location, d.date, d.population, v.new_vaccinations,
		SUM(v.new_vaccinations) OVER ( PARTITION BY d.location ORDER BY d.location, d.date) AS cumulative_number_vaccinated_people
	FROM covid2.covid_deaths AS d
	JOIN covid2.covid_vaccinations AS v
		ON d.location = v.location
		AND d.date = v.date
	WHERE d.continent != ""
	ORDER BY d.location, d.date
)

SELECT *, (cumulative_number_vaccinated_people / Population) * 100 
FROM PopulationVSVaccination;

USE covid2;
-- Usando una tabla temporal
DROP TABLE IF EXISTS PercentPopulationVaccinated;
CREATE TEMPORARY TABLE PercentPopulationVaccinated (
Continent NVARCHAR(255),
Location NVARCHAR(255),
Date DATE,
Population NUMERIC,
New_Vaccinations NUMERIC,
Cumulative_number_vaccinated_people NUMERIC
);

INSERT INTO PercentPopulationVaccinated
SELECT d.continent, d.location, d.date, d.population, v.new_vaccinations,
		SUM(v.new_vaccinations) OVER ( PARTITION BY d.location ORDER BY d.location, d.date) AS cumulative_number_vaccinated_people
FROM covid2.covid_deaths AS d
JOIN covid2.covid_vaccinations AS v
	ON d.location = v.location
	AND d.date = v.date
WHERE d.continent <> ""
ORDER BY d.location, d.date;

SELECT *, (Cumulative_number_vaccinated_people / Population) * 100  FROM PercentPopulationVaccinated;
 
 
 -- Creando una vista
 
 CREATE VIEW PercentPopulationVaccinated AS
 SELECT d.continent, d.location, d.date, d.population, v.new_vaccinations,
		SUM(v.new_vaccinations) OVER ( PARTITION BY d.location ORDER BY d.location, d.date) AS cumulative_number_vaccinated_people
FROM covid2.covid_deaths AS d
JOIN covid2.covid_vaccinations AS v
	ON d.location = v.location
	AND d.date = v.date
WHERE d.continent <> ""
ORDER BY d.location, d.date;
 
 
 
