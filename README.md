# RetailPro — Análisis de Ventas

## Descripción

RetailPro es un proyecto de análisis de datos orientado al análisis de ventas de una empresa de retail tecnológico.
El proyecto tiene como objetivo construir un flujo de análisis
que permita trabajar con información de ventas, clientes,
productos y categorías, desde la creación de la base de datos
hasta su análisis y visualización.

## Herramientas utilizadas

- SQL Server
- SQL Server Management Studio (SSMS)
- Power Query
- Power BI
- DAX
- GitHub

## Estructura del proyecto

- `M3-VentasTechDB.sql`: creación y configuración de la base
  de datos y sus tablas.
- `m4_consultas_negocio.sql`: consultas orientadas al análisis
  de negocio.
- `M5_consultas_JOINs.sql`: consultas utilizando JOINs entre
  las diferentes tablas.
- `Pipeline_ETL_Lopez_Luana.pbix`: archivo de Power BI utilizado
  para el proceso ETL y preparación de datos.
- `Lopez_Luana_Checkpoint2.pbix`: archivo de Power BI con el
  modelo analítico y medidas desarrolladas.

## Modelo de datos

La base de datos `Ventas_Tech_DB` trabaja principalmente
con las siguientes tablas:

- `clientes`
- `productos`
- `categorias`
- `ventas`

Las relaciones entre estas entidades permiten analizar
las ventas según cliente, producto y categoría.

## Ejecución de los scripts SQL

Los scripts pueden ejecutarse utilizando SQL Server Management
Studio.

1. Abrir SQL Server Management Studio.
2. Conectarse a una instancia de SQL Server.
3. Ejecutar `M3-VentasTechDB.sql` para crear y cargar
   la base de datos `Ventas_Tech_DB`.
4. Ejecutar `m4_consultas_negocio.sql` para obtener
   indicadores y resultados orientados al negocio.
5. Ejecutar `M5_consultas_JOINs.sql` para realizar
   consultas que integran información de ventas,
   clientes, productos y categorías.
6. Abrir los archivos `.pbix` para continuar con
   el proceso de ETL, modelado y análisis en Power BI.

## Power BI

Power BI se utiliza para realizar el proceso de ETL mediante
Power Query, construir el modelo de datos y desarrollar las
medidas necesarias para el análisis.

El modelo incluye tablas de dimensiones y una tabla de hechos,
además de una tabla calendario para el análisis temporal.

Entre las medidas DAX desarrolladas se encuentran:

- Total Ventas
- Ventas Online
- Ventas YTD
- Ventas LY
- % Crecimiento Anual

## Flujo del proyecto

Datos → SQL Server → Consultas SQL → ETL/Power Query →
Modelo de datos → DAX → Power BI → Dashboard

## Repositorio

El proyecto se encuentra disponible en GitHub.


