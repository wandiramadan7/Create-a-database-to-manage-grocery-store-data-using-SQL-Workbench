SELECT *
from customer;

SELECT *
from products;

SELECT *
from purchase;

SELECT *
from sales;

SELECT *
from salesdetails;

SELECT *
from stock;

-- Total purchase cost by product item
SELECT itemNum, p.description , sum(cost*quantity) AS totalCost
FROM purchase
INNER JOIN products AS p ON purchase.itemNumP = p.itemNum
GROUP BY itemNum
ORDER BY totalCost;

-- Total revenue by product ptem
SELECT itemNum, p.description, sum(price * quantity) AS totalRevenue
FROM products AS p
INNER JOIN salesdetails AS sd ON p.itemNum = sd.itemNumSales
GROUP BY itemNum
ORDER BY totalRevenue;

-- Total orders and customer payments
SELECT customerName, sum(price*quantity) AS totalPayment, count(sd.salesNum) AS totalOrder
FROM salesdetails AS sd
JOIN sales AS s ON sd.salesNum = s.salesNum
LEFT JOIN customer ON customer.idCustomer = s.idCustomer
GROUP BY customerName
ORDER BY totalPayment;