Here's a rephrased version in a more structured data language:


---

Guidelines for Creating Views/Tables from Existing DDL:

1. New Data Model MDM Tables:

When creating new tables based on the MDM data model, ensure that grants are applied from the corresponding MDM schema.

Example: For a view being created in the ETL_DEV_GXP schema, any MDM tables used (from the new data model) should be sourced from DEV_GXP.



2. Data Sourced from Existing Data Model:

When views or tables use data from existing models, apply grants from the "production GXP" (MDM) schema.



3. Non-MDM Table Usage:

If a non-MDM table is being utilized in any mapping or view creation, it should be set up in the ETL schema. For example, in a dev_etl environment, the source of non-MDM tables should reference dev_etl only.



4. ETL Data Handling:

Data intended for ETL processes (e.g., landing mapping data) should be stored in the ETL schema.



5. Stage Mapping Data:

Data used for stage mapping should be loaded into MDM stage schemas, as available within the MDM schema.





---

This version clarifies the processes and uses consistent terminology to describe the handling of data models, schemas, and environments.

