/*

Cleaning Data in SQL Queries

*/


Select *
from [Personal Portfolio Project].dbo.NashvilleHousing



--Standardize Data Format
-- Changing the sale date

Select *
from [Personal Portfolio Project].dbo.NashvilleHousing

Select SaleDate, Convert(Date,SaleDate)
From [Personal Portfolio Project].dbo.[Nashville Housing]

Update [Nashville Housing]
Set SaleDate = Convert(date,saledate)

Alter Table NashvilleHousing
Add SaleDateConverted Date;

Update [Nashville Housing]
Set SaleDateConvertered= Convert(Date,SaleDate)




-- Populate Property Address Data

Select *
From [Personal Portfolio Project].dbo.[Nashville Housing]
--Where PropertyAddress is null
order by ParcelID

Select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress,b.PropertyAddress)
From [Personal Portfolio Project].dbo.[Nashville Housing] a
Join [Personal Portfolio Project].dbo.[Nashville Housing] b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
	where a.PropertyAddress is null

Update a
SET PropertyAddress = ISNULL(a.PropertyAddress,b.PropertyAddress)
From [Personal Portfolio Project].dbo.[Nashville Housing] a
Join [Personal Portfolio Project].dbo.[Nashville Housing] b
	on a.ParcelID = b.ParcelID
	AND a.[UniqueID ] <> b.[UniqueID ]
	where a.PropertyAddress is null





-- Breaking out Address into Individual Columns (Address, City, State)

Select *
From [Personal Portfolio Project].dbo.[Nashville Housing]
--Where PropertyAddress is null
order by ParcelID

SELECT
SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress) as Address
, SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress), LEN(PropertyAddress)) as Address

From [Personal Portfolio Project].dbo.[Nashville Housing]

SELECT
SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress)-1) as Address
, SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress)+1, LEN(PropertyAddress)) as Address

From [Personal Portfolio Project].dbo.[Nashville Housing]


Alter Table NashvilleHousing
Add PropertySplitAddress Nvarchar(255);

Update [Nashville Housing]
Set PropertySplitAddress = SUBSTRING(PropertyAddress, 1, CHARINDEX(',',PropertyAddress)-1)


Alter Table NashvilleHousing
Add PropertySplitCity Nvarchar(255);

Update [Nashville Housing]
Set PropertySplitCity = SUBSTRING(PropertyAddress, CHARINDEX(',',PropertyAddress)+1, LEN(PropertyAddress))

SELECT *
FROM [Personal Portfolio Project].DBO.NashvilleHousing

SELECT OwnerAddress
FROM [Personal Portfolio Project].DBO.NashvilleHousing

Select
Parsename(Replace(OwnerAddress,',','.') , 3),
Parsename(Replace(OwnerAddress,',','.') , 2),
Parsename(Replace(OwnerAddress,',','.') , 1)
From [Personal Portfolio Project].dbo.NashvilleHousing

ALTER TABLE NashvilleHousing
Add OwnerSplitAddress Nvarchar(255);

Update [Nashville Housing]
Set OwnerSplitAddress = Parsename(Replace(OwnerAddress,',','.') , 3),


ALTER TABLE NashvilleHousing
Add OwnerSplitCity Nvarchar(255);

Update [Nashville Housing]
Set OwnerSplitCity = Parsename(Replace(OwnerAddress,',','.') , 2),

ALTER TABLE NashvilleHousing
Add OwnerSplitState Nvarchar(255);

Update [Nashville Housing]
Set OwnerSplitState = Parsename(Replace(OwnerAddress,',','.') , 1),

Select *
From [Personal Portfolio Project].dbo.NashvilleHousing



-- Change Y and N to Yes and No in "sold as Vacant" field

Select Distinct(SoldAsVacant), count(soldasvacant)
From [Personal Portfolio Project].dbo.NashvilleHousing
Group by SoldAsVacant
order by 2

Select SoldAsVacant
, Case when SoldAsVacant = 'Y' THEN 'YES'
When SoldAsVacant = 'N' THEN 'No'
ELSE SoldAsVacant
END
From [Personal Portfolio Project].dbo.NashvilleHousing

Update NashvilleHousing
Set SoldAsVacant = Case when SoldAsVacant = 'Y' THEN 'YES'
When SoldAsVacant = 'N' THEN 'No'
ELSE SoldAsVacant
END
From [Personal Portfolio Project].dbo.NashvilleHousing



-- Remove Duplicates

With RowNumCTE AS(
Select *,
ROW_NUMBER() OVER (
PARTITION BY ParcelID,
			 PropertyAddress,
			 SalePrice,
			 SaleDate
			 LegalReference
			 Order BY
			 UNIQUEID
			 ) row_num

From [Personal Portfolio Project].dbo.NashvilleHousing
-- order by parcelid
)
Delete
Select *
From RowNumCTE
where row_num > 1
-- Order by PropertyAddress
n/a


-- Delete Unused Columns

Select *
From [Personal Portfolio Project].dbo.NashvilleHousing

ALTER TABLE [Personal Portfolio Project].dbo.NashvilleHousing
DROP COLUMN OwnerAddress, TaxDisrict, PropertyAddress

ALTER TABLE [Personal Portfolio Project].dbo.NashvilleHousing
DROP COLUMN SaleDate
