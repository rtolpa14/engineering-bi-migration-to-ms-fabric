# This document describes the design of the Fabric data pipeline used to replicate data from the source system into the Lakehouse.

![pipeline](lh-update-pipeline.png)

## Source Data

- The source data comes from the Ajera Cloud ODBC where read-only access was allowed to pull data via SQL queries

## Lookup Tables

- Tables were created via Excel and uploaded into the Lakehouse to use as guides for determining which tables needed full overwrite update and which tables needed incremental refreshes.
- there are two tables: ajera_queries and trans_queries. The ajera queries are the overwrite tables and the trans tables are the incremental refresh tables.
- The tables needing incremental refreshes were the transaction tables which housed in excess of 2m rows.
- Stored in the lookup tables are the table names needed and a SQL query which is used to copy the data from the ODBC.

## For Each Loops

- The for each loops loop through the lookup tables and run the queries associated with each table in the list. The overwrite table loop runs first followed by the incremental refresh loop.

## End Result

- This pipeline takes around 8-10 minutes to run and is on a schedule to run every two hours. During busy times like month end close it will be run every hour.
- This pipeline is relatively efficient pertaining to fabric capacity.
