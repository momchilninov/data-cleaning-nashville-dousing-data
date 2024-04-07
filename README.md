# Nashville Housing Data SQL Project

This project involves cleaning and preparing Nashville housing data using SQL queries. The purpose of this README file is to provide an overview of the project and the rationale behind the data cleaning process.

## Overview

The Nashville housing data contains information about property sales, addresses, owners, and other relevant details. However, the data requires cleaning and standardization to ensure consistency and usability for analysis.

## Cleaning Process

The cleaning process for the Nashville housing data involved several steps, each aimed at addressing specific data quality issues:

1. **Standarize Date Format:** Standardized the date format in the `SaleDate` column.
2. **Populate Property Address Data:** Populated missing property addresses by matching parcel IDs.
3. **Breaking out Address into Individual Columns:** Split the property address into separate columns for address, city, and state.
4. **Parse Owner Address:** Split the owner address into separate columns for address, city, and state.
5. **Change Yes/No to Y/N in "SoldAsVacant" Column:** Standardized values in the "SoldAsVacant" column to Y/N.

## Conclusion

These cleaning steps were crucial in preparing the Nashville housing data for further analysis. By standardizing formats, filling missing values, and parsing address information, the dataset became more organized and suitable for analysis. The cleaned dataset provides a solid foundation for extracting insights and making informed decisions related to Nashville housing trends.
