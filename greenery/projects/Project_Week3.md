**Note:** Learning more markdown technique to help organize my writing. Apologies if hard to read.

#Models
What is our overall conversion rate?

62.5%

What is our conversion rate by product?

NAME	PROD_CONVERSION_RATE
String of pearls	5.640625
Arrow Head	5.730159
Pilea Peperomioides	6.118644
Philodendron	5.822581
Rubber Plant	6.685185
Jade Plant	7.847826
Orchid	4.813333
Cactus	6.563636
Aloe Vera	5.553846
Calathea Makoyana	6.811321
Pothos	5.918033
Majesty Palm	5.38806
Monstera	7.367347
Boston Fern	5.730159
Snake Plant	4.945205
Birds Nest Fern	4.628205
Bird of Paradise	6.016667
Ponytail Palm	5.157143
Ficus	5.308824
Angel Wings Begonia	5.918033
Spider Plant	6.118644
Money Tree	6.446429
Bamboo	5.38806
Pink Anthurium	4.878378
Peace Lily	5.469697
ZZ Plant	5.730159
Devil's Ivy	8.022222
Fiddle Leaf Fig	6.446429
Alocasia Polly	7.078431
Dragon Tree	5.822581

This is not entirely accurate. I found the # of unique session with purchases and then divided by the 
number of unique sessions of pageviews for each product to get the conversion rate.
CODE:
`WITH
    CTE_PURCHASE_SESS AS (
        SELECT 
            session_id,
            event_type,
            order_id
        FROM STG_EVENTS
        WHERE event_type = 'checkout'),
        
    CTE_TOTAL_SESS AS (
        SELECT DISTINCT session_id FROM STG_EVENTS),
        
    CTE_SESS_CONV AS (
        SELECT 
            (SELECT COUNT(DISTINCT session_id) FROM CTE_PURCHASE_SESS)
            /
            COUNT(DISTINCT session_id) as CONVERSION_RATE
        FROM CTE_TOTAL_SESS),
        
// SELECT * FROM CTE_SESS_CONV;

    CTE_PURCHASE_SESS_ORDERS AS (
        SELECT 
            ps.*,
            oi.product_id,
            p.name
        FROM CTE_PURCHASE_SESS ps
        LEFT JOIN ORDER_ITEMS oi ON oi.order_id = ps.order_id
        LEFT JOIN PRODUCTS p on p.product_id = oi.product_id),
        
    CTE_PROD_VIEWS AS (
        SELECT
            e.session_id,
            e.event_type,
            e.order_id,
            e.product_id,
            p.name
        FROM STG_EVENTS e
        LEFT JOIN PRODUCTS p ON p.product_id = e.product_id
        WHERE event_type = 'page_view'),
        
    CTE_PROD_CONV AS (
        SELECT
            name,
            (SELECT COUNT(DISTINCT session_id) FROM CTE_PURCHASE_SESS_ORDERS)
            /
            COUNT(DISTINCT session_id) as PROD_CONVERSION_RATE
        FROM CTE_PROD_VIEWS
        GROUP BY 1)
            
SELECT * FROM CTE_PROD_CONV;`

#Macros
I tried creating a macro to get a simple conversion rate given that we track this metric so often in this course
but, I think it's limited and uneffective at the moment because I'm trying to reference a table and I don't think
the macro run itself outside of a query in the first place.

#Hooks
Add Grant post hook to dbt_project.yml

#Packages
Download a few packages. I find the codegen the most useful to produce yml files, it's the most common way since Jake had shown it to us.
Will need to look into other applications if possible.

#DAG
No changes were made to DAG bc I did not use any packages to simplify my process.

#Snapshot
5 orders were shipped in the last week.
`SELECT * FROM SNAPSHOTS.ORDERS_SNAPSHOT WHERE ORDER_ID IN (
'8385cfcd-2b3f-443a-a676-9756f7eb5404',
'e24985f3-2fb3-456e-a1aa-aaf88f490d70',
'5741e351-3124-4de7-9dff-01a448e7dfd4',
'914b8929-e04a-40f8-86ee-357f2be3a2a2',
'05202733-0e17-4726-97c2-0520c024ab85',
'939767ac-357a-4bec-91f8-a7b25edd46c9')`