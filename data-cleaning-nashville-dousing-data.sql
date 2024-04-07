/*

Cleaning Data in SQL Queries

*/


SELECT *
FROM NashvilleHousing


-- Standarize Date Format

SELECT SaleDate, CONVERT(Date, SaleDate)
FROM NashvilleHousing


ALTER TABLE NashvilleHousing
Add SaleDateConverted Date;


UPDATE NashvilleHousing
SET SaleDateConverted = CONVERT(Date, SaleDate)


-- Populate Property Address data

SELECT *
FROM NashvilleHousing
-- WHERE PropertyAddress IS NULL
ORDER BY ParcelID



SELECT Table1.ParcelID, Table1.PropertyAddress, Table2.ParcelID, Table2.PropertyAddress, ISNULL(Table1.PropertyAddress, Table2.PropertyAddress)
FROM NashvilleHousing AS Table1 
INNER JOIN NashvilleHousing AS Table2
	ON Table1.ParcelID = Table2.ParcelID AND Table1.[UniqueID ] <> Table2.[UniqueID ]
	WHERE Table1.PropertyAddress IS NULL


UPDATE Table1
SET PropertyAddress = ISNULL(Table1.PropertyAddress, Table2.PropertyAddress)
FROM NashvilleHousing AS Table1 
INNER JOIN NashvilleHousing AS Table2
	ON Table1.ParcelID = Table2.ParcelID AND Table1.[UniqueID ] <> Table2.[UniqueID ]
	WHERE Table1.PropertyAddress IS NULL


-- Breaking out Address into Individual Columns (Address, City, State)
Select PropertyAddress
FROM NashvilleHousing

SELECT 
SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1) AS Address,
SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress)+1, LEN(PropertyAddress)) AS City
FROM NashvilleHousing

-- Create two new columns and add a value inside each one
ALTER TABLE NashvilleHousing DROP COLUMN IF EXISTS PropertySplitAddress;
ALTER TABLE NashvilleHousing
Add PropertySplitAddress NVARCHAR(255);

UPDATE NashvilleHousing
SET PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',', PropertyAddress)-1)


ALTER TABLE NashvilleHousing DROP COLUMN IF EXISTS PropertySplitAddress;
ALTER TABLE NashvilleHousing
Add PropertySplitCity NVARCHAR(255);

UPDATE NashvilleHousing
SET PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',', PropertyAddress)+1, LEN(PropertyAddress))


-- Let's take a look at OwnerAddress
-- Using PARSENAME

SELECT PARSENAME(REPLACE(OwnerAddress, ',','.'), 3) -- PARSENAME only looks for periods
,PARSENAME(REPLACE(OwnerAddress, ',','.'), 2)
,PARSENAME(REPLACE(OwnerAddress, ',','.'), 1)
FROM NashvilleHousing

-- Adding columns
ALTER TABLE NashvilleHousing
Add OwnerSplitAddress NVARCHAR(255);

ALTER TABLE NashvilleHousing
Add OwnerSplitCity NVARCHAR(255);

ALTER TABLE NashvilleHousing
Add OwnerSplitState NVARCHAR(255);


-- Updating columns
UPDATE NashvilleHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',','.'), 3) -- Address

UPDATE NashvilleHousing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',','.'), 2) -- City

UPDATE NashvilleHousing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',','.'), 1) -- State


-- Change Y and N to Yes and No in "SoldAsVacant" column

SELECT SoldAsVacant, COUNT(SoldAsVacant) AS CountSoldAsVacant
FROM NashvilleHousing
GROUP BY SoldAsVacant
ORDER BY 2


SELECT SoldAsVacant,
CASE
	WHEN SoldAsVacant = 'Y' THEN 'Yes'
	WHEN SoldAsVacant = 'N' THEN 'No'
	ELSE SoldAsVacant
END
FROM NashvilleHousing


UPDATE NashvilleHousing
SET SoldAsVacant = CASE
	WHEN SoldAsVacant = 'Y' THEN 'Yes'
	WHEN SoldAsVacant = 'N' THEN 'No'
	ELSE SoldAsVacant
END


