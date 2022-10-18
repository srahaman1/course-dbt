{{
  config(
    materialized='table'
  )
}}

SELECT
  UA.USER_ID,
  UA.FIRST_NAME,
  UA.LAST_NAME,
  UA.EMAIL,
  UA.PHONE_NUMBER,
  UA.CREATED_AT,
  UA.UPDATED_AT,
  UA.ADDRESS_ID,
  UA.ADDRESS, 
  UA.ZIPCODE, 
  UA.STATE, 
  UA.COUNTRY,
  O.ORDER_ID,
  O.PROMO_ID,
  O.CREATED_AT as "ORDER_CREATION", 
  O.ORDER_COST, 
  O.SHIPPING_COST, 
  O.ORDER_TOTAL, 
  O.TRACKING_ID, 
  O.SHIPPING_SERVICE,
  O.ESTIMATED_DELIVERY_AT,
  O.DELIVERED_AT,
  O.STATUS
FROM {{ ref('int_user_addresses')}} as UA
LEFT JOIN {{source('postgres', 'Orders')}} as O 
  ON O.USER_ID = UA.USER_ID
