//How many users do we have?
SELECT COUNT( DISTINCT USER_ID) FROM USERS
130

//On average, how many orders do we receive per hour?
SELECT COUNT(ORDER_ID)/(SELECT COUNT(DISTINCT DATE(CREATED_AT))*24 FROM ORDERS) FROM ORDERS;
~7.5 orders/hour, on average

//On average, how long does an order take from being placed to being delivered?
SELECT AVG(datediff('day', CREATED_AT, DELIVERED_AT)) FROM ORDERS WHERE DELIVERED_AT IS NOT NULL;
~3.89 days, on average

//How many users have only made one purchase? Two purchases? Three+ purchases?
SELECT USER_ID, COUNT(ORDER_ID) FROM ORDERS GROUP BY USER_ID HAVING COUNT(ORDER_ID) = 1;
Using row counts:
3+ : 71
2: 28
1: 25

//On average, how many unique sessions do we have per hour?
SELECT COUNT(DISTINCT SESSION_ID)/(SELECT COUNT(DISTINCT DATE(CREATED_AT))*24 FROM EVENTS) FROM EVENTS;
~ 6 sessions/hr, on average