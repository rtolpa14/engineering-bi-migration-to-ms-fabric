# Engineering BI Migration to Microsoft Fabric

A project to modernize the backend architecture of an engineering reporting suite by centralizing data and reporting in Microsoft Fabric for the Engineering division of a construction company.

---

## Project Summary

This project focused on modernizing the data foundation that supported an existing Power BI reporting suite used by engineering and finance leadership.

The work included building a data pipeline to replicate data from an Engineering ERP system into Microsoft Fabric, enabling full control over backend data used for reporting and allowing for the creation of custom cross-reference and snapshot tables. Once the Lakehouse was established, the Power BI semantic model was reworked to replace legacy data sources—including Excel files and Gen1 Dataflows—with Fabric Lakehouse tables acting as a SQL-based backend.

All data and visuals shown in this repository are anonymized to protect company confidentiality.

---

## Business Problem

The Finance team manager was responsible for manually updating the Engineering Power BI report suite multiple times per day. This process required:

- Downloading reports from the ERP system  
- Transforming data using Gen1 Dataflows  
- Refreshing reports manually to keep data current  

This workflow was time-consuming and became especially problematic during high-pressure periods such as month-end close, when frequent updates were required alongside many other responsibilities. Additionally, Engineering leadership requested a solution that was easier to scale and less dependent on manual intervention.

Given my background in SQL and data analytics, I was brought in to design and implement a more robust and scalable solution.

---

## Solution Overview

The solution introduced Microsoft Fabric as a centralized analytics platform and rebuilt the reporting architecture end to end:

- Replicated source tables from the ERP system into a Fabric Lakehouse using data pipelines  
- Built custom SQL queries to serve as the foundation for tables in the new Power BI semantic model, mirroring the structure of files used in the legacy model  
- Recreated semantic model relationships to ensure data rendered correctly in existing visuals  
- Replicated existing visuals to ensure a smooth transition for Engineering users  
- Added new Accounts Receivable (AR) reporting tabs to provide insight into AR aging and overdue invoices  

---

## Architecture

**High-level data flow:**

ODBC Source → Fabric Data Pipeline → Fabric Lakehouse → Power BI Semantic Model → Power BI Reports

---

## Pipeline Design

The Fabric data pipeline was designed to support reliability, scalability, and automation:

- Implemented incremental or full overwrite refresh logic depending on table size and data characteristics  
- Used `ForEach` loops to dynamically determine which tables required incremental versus overwrite refreshes  
- Scheduled automated refreshes to keep the Lakehouse up to date without manual intervention  
- Designed tables to support both current reporting and future analytics use cases  

This approach decoupled reporting from the source system and created a reusable foundation for additional BI solutions.

---

## Semantic Model Rebuild

The Power BI semantic model was rebuilt on top of the Fabric Lakehouse:

- Recreated core measures and dimensions  
- Optimized table relationships and cardinality  
- Refactored DAX measures for improved clarity and performance  
- Ensured backward compatibility with existing reporting requirements  

---

## Power BI Reporting

- Migrated existing reports to use the new Fabric-based semantic model  
- Replicated report layouts to minimize disruption for Engineering users  
- Added new AR reporting tabs to expand analytical capabilities across departments  
- Applied minor visual refinements for improved executive usability  

---

## Outcomes & Impact

- Improved report performance and reliability  
- Reduced dependency on direct access to the source ERP system  
- Eliminated repetitive manual data preparation tasks  
- Established a scalable, modern BI architecture for future projects  
- Received positive feedback from Engineering leadership regarding usability and performance  

---

## Tools & Technologies

- Microsoft Fabric  
- Fabric Data Pipelines  
- Fabric Lakehouse  
- Power BI  
- SQL  
- DAX  

