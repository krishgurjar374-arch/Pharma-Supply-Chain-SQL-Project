USE [PSC Database]

----1).Batches expiring in the next 90 days
Select batch_number,
       product_id,
       Expiry_date
From dbo.productionbatch
Where Expiry_date Between getdate() 
                      And dateadd(day,90,getdate())
Order by Expiry_date;
----------------------------------------------
select cast ( getdate () as datetime )



Select batch_number,

       product_id,
       Expiry_date
From dbo.productionbatch
Where Expiry_date >= CAST( getdate() AS DATE )
                      And Expiry_date <=  dateadd(day,90,CAST (getdate() AS DATE ))
Order by Expiry_date;

-------------------------------------------------
Select batch_number,
       product_id,
       Expiry_date
From dbo.productionbatch
Where Expiry_date Between CAST ( getdate() AS DATE ) 
                      And dateadd(day,90,CAST ( getdate() AS DATE ))
Order by Expiry_date;
-------------------------------------------------


----2).Total quantity produced per product
Select product_id,
       sum(quantity_produced) AS TotalQuantityProduced
From Productionbatch
Group by product_id
Order by  TotalQuantityProduced DESC;


----3).Average material cost by category, per supplier
Select supplier_name,
       material_category,
      CAST(AVG(unit_cost_inr) AS DECIMAL(18,2)) AS Avgcost
From Rawmaterial
Inner join Suppliers 
      on Rawmaterial.supplier_id=Suppliers.supplier_id
Group by supplier_name,
         material_category
Order by Avgcost DESC;


----4).How many distinct materials each supplier provides : Supplier diversification
Select
    supplier_name,
    COUNT(DISTINCT material_name) AS DistinctMaterials
From Suppliers AS S
Left join  Rawmaterial AS rm
     ON s.supplier_id = rm.supplier_id
Group by  s.supplier_name
Order by  DistinctMaterials DESC;


--------- OR 4) BY RIGHT JOIN;
Select
    supplier_name,
    COUNT(DISTINCT material_name) AS DistinctMaterials
From Rawmaterial AS rm
Right join  Suppliers AS S
     ON rm.supplier_id = s.supplier_id
Group by  s.supplier_name
Order by  DistinctMaterials DESC;


---------4) if i use Right join
Select
    supplier_name,
    COUNT(DISTINCT material_name) AS DistinctMaterials
From Suppliers AS s
Right join Rawmaterial   AS rm
     ON s.supplier_id = rm.supplier_id
Group by  s.supplier_name
Order by  DistinctMaterials DESC;


----5).Revenue by Customer
Select c.customer_id,
       customer_name,
       SUM(quantity_ordered * unit_price_inr) AS Revenue
From Customers AS c
Inner join Salesorder AS so 
      ON c.customer_id = so.customer_id
Inner join Orders
      ON so.order_id = Orders.order_id
Group by c.customer_id,
         customer_name
Order by Revenue DESC;


----6).batches that were never sold (dead stock candidates)
Select batch_number,
       pb.product_id ,
       product_name,
       quantity_produced,
       expiry_date   
From Productionbatch AS pb
Left join Orders AS o
     ON pb.batch_id = o.batch_id 
Inner join Products AS p
      ON p.product_id = pb.product_id 
Where o.order_id is NULL
Order by Expiry_date;



----7).Batches with no QC record logged (compliance check)
Select pb.batch_id,
       batch_number
From Productionbatch AS pb
Left join Qc 
          ON pb.batch_id = Qc.batch_id
Where qc_id IS NULL;
    

----8).Orders vs Shipments mismatch Audit
Select so.order_id,
       shipment_id
From Salesorder AS so
Full Outer Join Shipment AS S
           ON  so.order_id = s.order_id
Where so.order_id IS NULL 
                  OR S.shipment_id IS NULL ;


----9). suppliers whose average material cost exceeds ₹10,000 (flag for cost review)
Select S.supplier_name,
       R.supplier_id,
       CAST(AVG( unit_cost_inr) AS DECIMAL(18,2)) AS Avgcost
From Rawmaterial AS R
Inner join Suppliers AS S
      ON R.supplier_id = S.supplier_id
Group by R.supplier_id,
         S.supplier_name
HAVING AVG( unit_cost_inr) > 10000
Order by AVG( unit_cost_inr) DESC ;
-----------------------------------------------------
Select R.supplier_id,
        CAST(AVG( unit_cost_inr) AS DECIMAL(18,2)) AS Avgcost
From Rawmaterial AS R
Group by R.supplier_id
HAVING AVG( unit_cost_inr) > 10000;
-----------------------------------------------------





----10) CTE + CASE: QC pass-rate bucket per product
WITH QCSummary AS (
     Select product_id,
            COUNT(*) AS Totalbatch,
            SUM (Case 
                     When final_result = 'Pass'Then 1 Else 0 End ) AS Passed
From Productionbatch  AS pb
Inner join Qc
      ON pb.batch_id = QC.batch_id 
Group by product_id
)
Select product_id,
       Totalbatch,
       Passed,
Round( 100 * Passed / Totalbatch,1) AS Pass_Rate_pct,
Case 
    When 100 * Passed / Totalbatch  >= 95 Then 'Excellent'
    When 100 * Passed / Totalbatch  >= 85 Then 'Acceptable'
    Else 'Need Review'
    End AS Quality_flag
From QCSummary
Order by Pass_Rate_pct DESC;


----11).Window function: Rank customers by revenue within their state
Select C.customer_id,
       customer_name,
       state,
       SUM( quantity_ordered * unit_price_inr) AS Revenue,
       Rank()Over ( partition by C.State 
                    Order by SUM (quantity_ordered * unit_price_inr)DESC) AS State_rank
From Customers AS C
Inner join Salesorder AS so
                      ON C.customer_id = so.customer_id
Inner join Orders AS O
                      ON O.order_id = so.order_id
Group by customer_name,
         C.customer_id,
         state;                     
        

----12). Window function: Running total of batch output per plant per month
Select plant_id,
       FORMAT ( Manufacturing_date, 'yyyy-MM') AS Month,
       SUM ( quantity_produced ) AS Monthly_output,
       SUM ( SUM ( quantity_produced )) OVER (PARTITION BY plant_id
                                              ORDER BY  FORMAT ( Manufacturing_date , 'yyyy-MM')
                                              ) AS RunningTotal
From Productionbatch                         
Group by plant_id,
         FORMAT ( Manufacturing_date, 'yyyy-MM') ;


----------------------------------------------------

Select plant_id,
       FORMAT ( Manufacturing_date, 'yyyy-MM') AS Month,
       SUM ( quantity_produced ) AS Monthly_output,
       SUM ( SUM ( quantity_produced )) OVER (PARTITION BY plant_id
                                              ORDER BY  FORMAT ( Manufacturing_date , 'yyyy-MM')
                                              ROWS UNBOUNDED PRECEDING) AS RunningTotal
From Productionbatch                         
Group by plant_id,
         FORMAT ( Manufacturing_date, 'yyyy-MM') ;

-----------------------------------------------------

Select plant_id,
       FORMAT ( Manufacturing_date, 'yyyy-MM') AS Month,
       SUM ( quantity_produced ) AS Monthly_output,
       SUM ( SUM ( quantity_produced )) OVER (PARTITION BY plant_id
                                              ORDER BY  DATEFROMPARTS(YEAR ( Manufacturing_date),
                                                                     MONTH( Manufacturing_date),1))
                                                                     AS RUNNINGTOATAL
From Productionbatch AS pb                     
Group by plant_id,
          FORMAT ( Manufacturing_date, 'yyyy-MM') ,
         DATEFROMPARTS(YEAR (manufacturing_date),
         MONTH( manufacturing_date),1);

---------------------------------------------------

Select plant_id,
       DATEFROMPARTS(YEAR (manufacturing_date),
       MONTH( manufacturing_date),1)AS Month,

       SUM ( quantity_produced ) AS Monthly_output,
       SUM ( SUM ( quantity_produced )) OVER (PARTITION BY plant_id
                                              ORDER BY  DATEFROMPARTS(YEAR ( Manufacturing_date),
                                                                     MONTH( Manufacturing_date),1))
                                                                     AS RUNNINGTOATAL
From Productionbatch AS pb                     
Group by plant_id,
         DATEFROMPARTS(YEAR (manufacturing_date),
         MONTH( manufacturing_date),1);


----13).Batches past 70% of their shelf life, still in inventory
Select batch_number,
       expiry_date,
       warehouse_id,
       quantity_on_hand
From Productionbatch AS pb
Inner join Inventory AS i
      ON pb.batch_id = i.batch_id
Where DATEDIFF( DAY,manufacturing_date,GETDATE()) >
              0.7 * DATEDIFF (DAY,manufacturing_date, expiry_date)
              AND i.quantity_on_hand>0;

----

