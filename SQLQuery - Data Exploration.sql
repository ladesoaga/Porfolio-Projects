SELECT *
FROM PortfolioProject..CovidDeaths

--DATA SELECTION
SELECT Location, date, total_cases, new_cases, total_deaths, population
FROM PortfolioProject..CovidDeaths



--Total cases versus total deaths(Percentage) depicts the likelihood of dying in a country if infected by Covid
SELECT Location, date, total_cases, total_deaths, (total_deaths/total_cases)*100 as DeathPercentage
FROM PortfolioProject..CovidDeaths
--For example
WHERE location like '%china%'


--Total Cases versus Population depicts what percentage of the population got Covid
SELECT Location, date, population, total_cases, (total_cases/population)*100 as PercentageInfected
FROM PortfolioProject..CovidDeaths
--For example
WHERE location like '%states%'


--Countries with highest infection rate compared to the population
SELECT Location, population, MAX(total_cases) as HighestInfectionCount, MAX((total_cases/population))*100 as PercentagePopulationInfected
FROM PortfolioProject..CovidDeaths
Group by location, population
ORDER BY PercentagePopulationInfected DESC


--Countries with the highest death count (Location)
SELECT Location, MAX(CAST(total_deaths AS INT)) as TotalDeathCount
FROM PortfolioProject..CovidDeaths
WHERE continent is not null
Group by location
ORDER BY TotalDeathCount DESC


--Countries with the highest death count (Continent)
SELECT continent, MAX(CAST(total_deaths AS INT)) as TotalDeathCount
FROM PortfolioProject..CovidDeaths
WHERE continent is not null
Group by continent
ORDER BY TotalDeathCount DESC


--Global Numbers

Select SUM(new_cases) as total_cases, SUM(cast(new_deaths as int)) as total_deaths, SUM(cast(new_deaths as int))/SUM(new_cases)*100 as DeathPercentage
FROM PortfolioProject..CovidDeaths
Where continent is not null
ORDER BY 1, 2



SELECT *
FROM PortfolioProject..CovidDeaths dea
Join PortfolioProject..CovidVaccinations vac
	On dea.location = vac.location
	and dea.date = vac.date