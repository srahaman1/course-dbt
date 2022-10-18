{{
  config(
    materialized='table'
  )
}}

SELECT
  U.USER_ID,
  U.FIRST_NAME,
  U.LAST_NAME,
  U.EMAIL,
  U.PHONE_NUMBER,
  U.CREATED_AT,
  U.UPDATED_AT,
  U.ADDRESS_ID,
  A.ADDRESS, 
  A.ZIPCODE, 
  A.STATE, 
  A.COUNTRY
FROM {{ source('postgres', 'Users')}} as U
LEFT JOIN {{ source('postgres', 'Addresses')}} as A
  ON U.ADDRESS_ID = A.ADDRESS_ID