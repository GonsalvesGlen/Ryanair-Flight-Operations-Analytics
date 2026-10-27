# Ryanair Flight Operations Analytics

### End-to-End Data Analytics Project | Python • MySQL • Power BI

An end-to-end analysis of **740,787 Ryanair flight records** spanning **July 2025 to July 2026**, using Python, Pandas, MySQL, and Power BI to examine recorded flight activity, airport networks, directional routes, and aircraft model trends.

## Project Overview

This project demonstrates a complete data analytics workflow, from raw flight records to an interactive business intelligence dashboard.

The objective was to transform aviation data into meaningful insights about flight activity, airport connectivity, route patterns, and aircraft model distribution.

**Data source:** EUROCONTROL Open Performance Data Initiative (OPDI).

## Tools and Technologies

- **Python:** Data cleaning, transformation, validation, and exploratory data analysis
- **Pandas & NumPy:** Data manipulation and feature engineering
- **MySQL:** Business analysis using SQL queries, aggregations, CTEs, and window functions
- **Power BI:** Interactive dashboard development and data visualisation
- **Power Query & DAX:** Data modelling, measures, and reporting

## Project Workflow

**EUROCONTROL Flight Records → Python Data Cleaning → Feature Engineering → MySQL Analysis → Power BI Dashboard**

### 1. Data Cleaning and Preparation

- Filtered flight records for Ryanair.
- Removed duplicate records.
- Examined missing values and incomplete airport information.
- Standardised aircraft model descriptions.
- Converted date fields into appropriate formats.
- Developed reusable processing logic for multiple months.

### 2. Feature Engineering

Created analytical features including:

- Day of the week
- Day of the month
- Weekday versus weekend classification
- Directional flight routes
- Non-directional airport pairs
- Standardised aircraft model categories

### 3. SQL Business Analysis

Used MySQL to answer ten business-oriented questions covering monthly flight activity, airport rankings, route frequency, weekday patterns, aircraft distributions, and month-over-month changes.

### 4. Power BI Dashboard Development

Developed an interactive three-page report with KPI cards, monthly filters, airport rankings, route analysis, and fleet distribution visuals.

## Dashboard Preview

### Page 1 — Flight Operations Overview

![Flight Operations Overview](Flight%20Operations%20Dashboard.jpg)

Examines recorded flight activity across months, weekdays, weekends, and aircraft models.

### Page 2 — Airport & Route Analysis

![Airport and Route Analysis](Airport%20and%20Route%20Analysis%20Dashboard.jpg)

Highlights leading departure and destination airports and the most frequently recorded directional routes.

### Page 3 — Fleet Analysis

![Fleet Analysis](Fleet%20Analysis%20Dashboard.jpg)

Explores aircraft model distribution and changes in recorded aircraft activity across the analysis period.

## Key Findings

- **London Stansted (EGSS)** was the most frequently recorded departure and destination airport in the analysed data.
- **Dublin (EIDW)** was another major airport in the observed network.
- **London Stansted → Dublin** was the most frequently recorded directional route.
- The **Boeing 737-800** accounted for approximately **76.3%** of records with the analysed aircraft model categories.
- The **Boeing 737 MAX 8-200** accounted for approximately **23.2%**.

These findings reflect the available dataset and should not be interpreted as complete airline-wide operational statistics.

## Repository Files

| File | Description |
|---|---|
| `01_ryanair_data_cleaning.ipynb` | Data cleaning, feature engineering, and exploratory analysis |
| `02_multi_month_pipeline.ipynb` | Reusable multi-month data processing workflow |
| `ryanair_business_analysis.sql` | Ten SQL business analysis queries |
| `Ryanair_project.pbix` | Interactive Power BI report |
| `Flight Operations Dashboard.jpg` | Operations dashboard preview |
| `Airport and Route Analysis Dashboard.jpg` | Airport and route dashboard preview |
| `Fleet Analysis Dashboard.jpg` | Aircraft analysis dashboard preview |

## Data Limitations

- Some records contain missing departure or destination airport codes.
- Monthly data coverage varies.
- The dataset does not necessarily capture every Ryanair flight.
- Observation timestamps should not be interpreted as actual scheduled departure or arrival times.
- Aircraft model distributions describe the analysed records, not necessarily the airline's complete operational fleet.

## Author

**Glen Gonsalves**

MSc Business Analytics — Maynooth University

[GitHub Profile](https://github.com/GonsalvesGlen)

---

*This is an independent portfolio project and is not affiliated with or endorsed by Ryanair or EUROCONTROL.*
