

--Overview of the tables

select *
from portfolio_project.dbo.covidDeaths
order by 3,4
select *
from portfolio_project.covid_data.covidVaccinations
order by 3,4

--selecting data to be used for analysis

select location, date, total_cases, new_cases, total_deaths, population
from portfolio_project.dbo.covidDeaths
where continent is not null
order by 1,2

--Total cases vs Total Deaths
--shows the likelihood of dying if you contract covid

select location, date, total_cases, total_deaths, round(cast(total_deaths as bigint) / cast(total_cases as bigint)*100, 2) as DeathPercentage
from portfolio_project.dbo.covidDeaths
where location like 'africa'
order by 1,2,5 desc

--Total cases vs population

select location, date, total_cases, population, round(cast(total_cases as bigint) / cast(population as bigint)*100, 2) as CasesPercentage
from portfolio_project.dbo.covidDeaths
where location like 'africa'
order by 1,2,5 desc

--countries with highest infection rate compared to population

select location, population, max(total_cases) as HighestInfectionCount, round (max(cast(total_cases as bigint) / cast(population as bigint))*100, 2) as Percentagepopulationinfected
from portfolio_project.dbo.covidDeaths
--where location like 'africa'
where continent is not null
group by location, population
order by Percentagepopulationinfected desc

--countries with highest death counts and population

select location, max(cast(total_deaths as bigint)) as TotalDeathCount  
from portfolio_project..covidDeaths
--where location like 'africa'
where continent is not null
group by location
order by TotalDeathCount desc

--Continents with the highest death rates

select continent, max(cast(total_deaths as bigint)) as TotalDeathCount  
from portfolio_project..covidDeaths
--where location like 'africa'
where continent is not null
group by continent
order by TotalDeathCount desc

--Global 

SELECT date, 
       SUM(new_cases), 
       SUM(new_deaths), 
       SUM(ISNULL(new_deaths, 0)) / NULLIF(SUM(CAST(new_cases AS BIGINT)), 0) * 100 AS DeathPercentage
FROM portfolio_project..covidDeaths
WHERE continent IS NOT NULL
GROUP BY date
ORDER BY 1,2;

--Total population vs Vaccinations

select cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations,
sum(convert(bigint,cv.new_vaccinations)) over (partition by cd.location order by cd.location, cd.date) as PeopleVaccinated
from portfolio_project..covidDeaths cd
join portfolio_project.covid_data.covidVaccinations cv
on cd.location = cv.location
and cd.date = cv.date
where cd.continent is not null
order by 2,3

--USING CTE
WITH PopvsVac (continent, location, date, population, new_vaccinations, PeopleVaccinated)
as
(
select cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations,
sum(convert(bigint,cv.new_vaccinations)) over (partition by cd.location order by cd.location, cd.date) as PeopleVaccinated
from portfolio_project..covidDeaths cd
join portfolio_project.covid_data.covidVaccinations cv
on cd.location = cv.location
and cd.date = cv.date
where cd.continent is not null
--order by 2,3
)
select *, (PeopleVaccinated/population)*100
from PopvsVac

--Temp Table

-- Drop the temporary table if it already exists

IF OBJECT_ID('tempdb..#percentpopulationvaccinated') IS NOT NULL
    DROP TABLE #percentpopulationvaccinated;

-- Create the temporary table with the desired columns
CREATE TABLE #percentpopulationvaccinated (
    continent NVARCHAR(255),
    location NVARCHAR(255),
    date DATETIME,
    population NUMERIC,
    new_vaccinations NUMERIC,
    PeopleVaccinated NUMERIC
);

-- Insert data into the temporary table
INSERT INTO #percentpopulationvaccinated (continent, location, date, population, new_vaccinations, PeopleVaccinated)
SELECT cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations, 
SUM(CONVERT(BIGINT,cv.new_vaccinations)) over (partition by cd.location order by cd.location, cd.date) as PeopleVaccinated
FROM portfolio_project..covidDeaths cd
JOIN portfolio_project.covid_data.covidVaccinations cv
ON cd.location = cv.location
AND cd.date = cv.date
WHERE cd.continent is not null;

-- Select data from the temporary table with the calculated percentage of vaccinated population
SELECT *, (PeopleVaccinated/population)*100 as PercentPopulationVaccinated
FROM #percentpopulationvaccinated;

--create view to store data for visualization

CREATE VIEW PercentPopulationVaccinated as
select cd.continent, cd.location, cd.date, cd.population, cv.new_vaccinations,
sum(convert(bigint,cv.new_vaccinations)) over (partition by cd.location order by cd.location, cd.date) as PeopleVaccinated
from portfolio_project..covidDeaths cd
join portfolio_project.covid_data.covidVaccinations cv
on cd.location = cv.location
and cd.date = cv.date
where cd.continent is not null
--order by 2,3

SELECT *
FROM PercentPopulationVaccinated








