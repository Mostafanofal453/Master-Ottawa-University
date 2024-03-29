USE HSD_DW
GO

-- Part B 2a
select C.CustomerName,C.CustomerID,COUNT(DISTINCT ProductNumber) as Quantity_ProductNumber
from PRODUCT_SALES S join CUSTOMER C
on s.CustomerID=c.CustomerID
group by C.CustomerID,C.CustomerName
having COUNT(DISTINCT productnumber )>=5

-- Part B 2b
with LargestBill as(
select CustomerID,TimeID,sum(Total)as Total_bill
FROM PRODUCT_SALES
group by TimeID,CustomerID)

select c.* from LargestBill,CUSTOMER as c where LargestBill.CustomerID=c.CustomerID and LargestBill.Total_bill= 
(select max(Total_bill) from LargestBill)


-- Part B 2c
Select TL.TYear ,sum(Total) 
from PRODUCT_SALES as S,TIMELINE as TL
where S.TimeID=TL.TimeID
group by Rollup(TL.TYear)

--3.
--First method
-- From april to june 2018
Select  P.ProductType, T.TMonth,sum(PS.Total) as Total  
from TIMELINE as T ,PRODUCT_SALES as PS,PRODUCT as P 
where T.TimeID=PS.TimeID  and T.TYear =2018 and T.TMonth in (4,5,6)and p.ProductNumber=PS.ProductNumber
Group by P.ProductType, T.TMonth order by P.ProductType

-- Second method
-- Compare the second quarter with the other quartiles to see whether its decreasing or not
Select  P.ProductType,T.TYear, T.TMonth,sum(PS.Total) as Total  
from TIMELINE as T ,PRODUCT_SALES as PS,PRODUCT as P 
where T.TimeID=PS.TimeID  and p.ProductNumber=PS.ProductNumber
Group by T.TYear, P.ProductType, T.TMonth order by P.ProductType