{% macro simple_conversion(column1, table1, column2, condition1) %}

WITH
    CTE_PART AS (
        SELECT 
            {{column1}}
        FROM {{table1}}
        WHERE {{column2}} = {{condition1}}),
        
    CTE_TOTAL AS (
        SELECT DISTINCT {{column1}} FROM {{table1}}),
        
    CTE_CONVERSION AS (
        SELECT 
            (SELECT COUNT(DISTINCT {{column1}}) FROM CTE_PART)
            /
            COUNT(DISTINCT {{column1}}) as CONVERSION_RATE
        FROM CTE_TOTAL)

SELECT * FROM CTE_SESS_CONV

{% endmacro %}
