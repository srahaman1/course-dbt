WITH orders AS (
    SELECT * FROM {{ ref('stg_orders') }}
),
order_items AS (
    SELECT * FROM {{ ref('stg_order_items') }}
),
products AS (
    SELECT * FROM {{ ref('stg_products') }}
),
events AS (
    SELECT * FROM {{ ref('stg_events') }}
)

SELECT  orders.ORDER_GUID
        ,orders.ORDER_CREATED_AT_UTC
        ,events.SESSION_GUID
        ,orders.USER_GUID
        ,order_items.PRODUCT_GUID
        ,order_items.QUANTITY_ORDERED
        ,products.PRODUCT_NAME
        ,products.PRODUCT_PRICE
        ,order_items.QUANTITY_ORDERED * products.PRODUCT_PRICE AS PRODUCT_SUBTOTAL
FROM orders
LEFT JOIN order_items ON orders.ORDER_GUID = order_items.ORDER_GUID
LEFT JOIN products ON order_items.PRODUCT_GUID = products.PRODUCT_GUID
LEFT JOIN events ON orders.ORDER_GUID = events.ORDER_GUID
GROUP BY    orders.ORDER_GUID
            ,orders.ORDER_CREATED_AT_UTC
            ,events.SESSION_GUID
            ,orders.USER_GUID
            ,order_items.PRODUCT_GUID
            ,order_items.QUANTITY_ORDERED
            ,products.PRODUCT_NAME
            ,products.PRODUCT_PRICE
            ,PRODUCT_SUBTOTAL