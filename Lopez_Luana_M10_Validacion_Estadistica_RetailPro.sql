USE Ventas_Tech_DB;
GO

---------------------------------------------------------
------------- Query 1: Media vs. Mediana ----------------
---------------------------------------------------------

WITH ventas_con_total AS (
    SELECT
        id_venta,
        cantidad,
        precio_unitario,
        cantidad * precio_unitario AS total_venta
    FROM ventas
)
SELECT DISTINCT
    AVG(total_venta) OVER () AS media,
    PERCENTILE_CONT(0.5)
        WITHIN GROUP (ORDER BY total_venta)
        OVER () AS mediana
FROM ventas_con_total;

---------------------------------------------------------
------------------- Query 2: IQR ------------------------
---------------------------------------------------------

WITH ventas_con_total AS (
    SELECT
        id_venta,
        cantidad * precio_unitario AS total_venta
    FROM ventas
),
cuartiles AS (
    SELECT
        PERCENTILE_CONT(0.25)
            WITHIN GROUP (ORDER BY total_venta)
            OVER () AS q1,
        PERCENTILE_CONT(0.75)
            WITHIN GROUP (ORDER BY total_venta)
            OVER () AS q3
    FROM ventas_con_total
)
SELECT DISTINCT
    q1,
    q3,
    q3 - q1 AS iqr,
    q1 - 1.5 * (q3 - q1) AS limite_inferior,
    q3 + 1.5 * (q3 - q1) AS limite_superior
FROM cuartiles;

---------------------------------------------------------
----------- Query 3: Identificar Outliers ---------------
---------------------------------------------------------
WITH ventas_con_total AS (
    SELECT
        id_venta,
        id_cliente,
        id_producto,
        fecha_venta,
        cantidad,
        precio_unitario,
        cantidad * precio_unitario AS total_venta
    FROM ventas
),
cuartiles AS (
    SELECT DISTINCT
        PERCENTILE_CONT(0.25)
            WITHIN GROUP (ORDER BY total_venta)
            OVER () AS q1,
        PERCENTILE_CONT(0.75)
            WITHIN GROUP (ORDER BY total_venta)
            OVER () AS q3
    FROM ventas_con_total
)
SELECT
    v.id_venta,
    v.id_cliente,
    v.id_producto,
    v.fecha_venta,
    v.cantidad,
    v.precio_unitario,
    v.total_venta
FROM ventas_con_total AS v
CROSS JOIN cuartiles AS q
WHERE
    v.total_venta < q.q1 - 1.5 * (q.q3 - q.q1)
    OR v.total_venta > q.q3 + 1.5 * (q.q3 - q.q1)
ORDER BY v.total_venta;