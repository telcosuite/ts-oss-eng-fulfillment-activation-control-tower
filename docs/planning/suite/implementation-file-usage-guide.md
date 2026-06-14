# OSS Engineering, Inventory, And Fulfillment Implementation File Usage Guide

Reviewed: 2026-06-14

## Purpose

This guide explains how to use the planning, TMF, UI, data, and DDL files for the OSS Engineering, Inventory, And Fulfillment suite while building its apps.

Suite focus: service/resource design, inventory, topology, fulfillment, activation, field work, stock, and logistics.

## Suite-Level Files

| File | Use it for |
| --- | --- |
| [README.md](README.md) | Suite navigation and app list. |
| [tech-and-ui-guidance.md](tech-and-ui-guidance.md) | Suite-specific Angular, PrimeNG, layout, navigation, density, and UI consistency guidance. |
| [data-model.md](data-model.md) | Suite database ownership, app schemas, data mastery, cross-app sharing, and physical model guidance. |
| [journey-coverage.md](journey-coverage.md) | Cross-app suite journeys and end-to-end flow validation. |
| [../build-artifact-usage-guide.md](../build-artifact-usage-guide.md) | Global explanation of how all generated files fit together. |
| [../suite-app-coverage-control-matrix.md](../suite-app-coverage-control-matrix.md) | Build-readiness status across all suites and apps. |
| [../tmf-api-to-ddl-traceability-matrix.md](../tmf-api-to-ddl-traceability-matrix.md) | API-level TMF-to-schema/table coverage. |
| [../../../database/postgres/README.md](../../../database/postgres/README.md) | Database execution model and migration usage. |

## Database And Migration Use

Physical database: `ts_oss_engineering_fulfillment`

Run migrations in order inside this suite database. `V001` creates app schemas and starter tables. Each V002+ migration refines one app with promoted TMF fields, support tables, event contracts, and privacy/retention/audit policies.

| Migration | Path |
| --- | --- |
| `V001__create_app_schemas_and_starter_tables.sql` | `database/postgres/suites/ts_oss_engineering_fulfillment/V001__create_app_schemas_and_starter_tables.sql` |
| `V002__refine_inventory_topology_tmf_core.sql` | `database/postgres/suites/ts_oss_engineering_fulfillment/V002__refine_inventory_topology_tmf_core.sql` |
| `V003__refine_fulfillment_activation_tmf_core.sql` | `database/postgres/suites/ts_oss_engineering_fulfillment/V003__refine_fulfillment_activation_tmf_core.sql` |
| `V004__refine_service_resource_design_tmf_core.sql` | `database/postgres/suites/ts_oss_engineering_fulfillment/V004__refine_service_resource_design_tmf_core.sql` |
| `V005__refine_field_stock_logistics_tmf_core.sql` | `database/postgres/suites/ts_oss_engineering_fulfillment/V005__refine_field_stock_logistics_tmf_core.sql` |

## App File Map

| App | Schema | App usage guide | TMF review | App migration | Primary TMF/API areas |
| --- | --- | --- | --- | --- | --- |
| Field Work, Stock, And Logistics | `field_stock_logistics` | [field-work-stock-logistics/implementation-file-usage.md](field-work-stock-logistics/implementation-file-usage.md) | [field-stock-logistics.md](../tmf-api-ddl-reviews/field-stock-logistics.md) | `V005__refine_field_stock_logistics_tmf_core.sql` | TMF646, TMF697, TMF687, TMF700, TMF684, TMF639 |
| Fulfillment And Activation Control Tower | `fulfillment_activation` | [fulfillment-activation-control-tower/implementation-file-usage.md](fulfillment-activation-control-tower/implementation-file-usage.md) | [fulfillment-activation.md](../tmf-api-ddl-reviews/fulfillment-activation.md) | `V003__refine_fulfillment_activation_tmf_core.sql` | TMF641, TMF652, TMF640, TMF702, TMF664, TMF701, TMF621, TMF637, TMF638, TMF639 |
| Inventory And Topology | `inventory_topology` | [inventory-and-topology/implementation-file-usage.md](inventory-and-topology/implementation-file-usage.md) | [inventory-topology.md](../tmf-api-ddl-reviews/inventory-topology.md) | `V002__refine_inventory_topology_tmf_core.sql` | TMF637, TMF638, TMF639, TMF703, TMF674, TMF675, TMF685, TMF771, TMF716, TMF640, TMF697, TMF645, TMF655, TMF681 |
| Service And Resource Design Studio | `service_resource_design` | [service-and-resource-design-studio/implementation-file-usage.md](service-and-resource-design-studio/implementation-file-usage.md) | [service-resource-design.md](../tmf-api-ddl-reviews/service-resource-design.md) | `V004__refine_service_resource_design_tmf_core.sql` | TMF633, TMF620, TMF634, TMF730, TMF701, TMF645, TMF679, TMF662 |

## Suite Build Workflow

1. Start with this guide and the suite `data-model.md` to confirm database, schema, and ownership boundaries.
2. Use `tech-and-ui-guidance.md` before any Angular work so all apps share the TelcoSuite design language.
3. Build apps in the priority order from [../tmf-api-ddl-reviews/backlog.md](../tmf-api-ddl-reviews/backlog.md), unless delivery priorities explicitly change.
4. For each app, open its `implementation-file-usage.md` and follow its checklist.
5. Apply `V001`, then the app's V002+ migration, before implementing repositories/entities that depend on promoted columns or support tables.
6. Emit events through the app `event_outbox` and use the app `event_contract` table as the baseline register.
7. Enforce table handling with the app `privacy_retention_policy` table and add jurisdiction-specific rules before release.
8. Keep cross-app interactions out of database writes; use APIs, events, governed views, workflow tasks, or data products.

## Suite Delivery Gate

The suite is implementation-ready when each app keeps these artifacts aligned: app overview, modules/features, personas/journeys, TMF review, V002+ DDL, endpoint contract tests, event behavior, and privacy/audit controls.
