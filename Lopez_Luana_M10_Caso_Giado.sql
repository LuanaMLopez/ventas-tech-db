-- =====================================================
-- M10 - VALIDACIÓN ESTADÍSTICA
-- Proyecto: RetailPro
-- Motor: SQL Server
-- =====================================================


-- =====================================================
-- PARTE 1 - CASO GUIADO
-- Consistencia de ventas por sucursal
-- =====================================================

CREATE TABLE ventas_semana (
    sucursal VARCHAR(20),
    venta DECIMAL(10,2)
);

INSERT INTO ventas_semana (sucursal, venta)
VALUES
    ('Norte', 500),
    ('Norte', 510),
    ('Norte', 490),
    ('Norte', 505),
    ('Norte', 495),
    ('Sur', 100),
    ('Sur', 900),
    ('Sur', 50),
    ('Sur', 1200),
    ('Sur', 250);

    SELECT
    sucursal,
    AVG(venta) AS media,
    MAX(venta) - MIN(venta) AS rango
FROM ventas_semana
GROUP BY sucursal;


SELECT
    sucursal,
    STDEV(venta) AS desvio_muestral
FROM ventas_semana
GROUP BY sucursal;


SELECT DISTINCT
    AVG(venta) OVER () AS media,
    PERCENTILE_CONT(0.5)
        WITHIN GROUP (ORDER BY venta)
        OVER () AS mediana
FROM ventas_semana;


;WITH q AS (
    SELECT DISTINCT
        PERCENTILE_CONT(0.25)
            WITHIN GROUP (ORDER BY venta)
            OVER () AS q1,
        PERCENTILE_CONT(0.75)
            WITHIN GROUP (ORDER BY venta)
            OVER () AS q3
    FROM ventas_semana
)
SELECT
    q1,
    q3,
    q3 - q1 AS iqr,
    q1 - 1.5 * (q3 - q1) AS limite_inferior,
    q3 + 1.5 * (q3 - q1) AS limite_superior
FROM q;




;WITH q AS (
  SELECT
    PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY venta) OVER () AS q1,
    PERCENTILE_CONT(0.75) WITHIN GROUP (ORDER BY venta) OVER () AS q3
  FROM ventas_semana
)
SELECT v.*
FROM ventas_semana v, q
WHERE v.venta < q.q1 - 1.5*(q.q3 - q.q1)
   OR v.venta > q.q3 + 1.5*(q.q3 - q.q1);
