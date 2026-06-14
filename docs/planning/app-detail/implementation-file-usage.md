# Fulfillment And Activation Control Tower Implementation File Usage

Reviewed: 2026-06-14

## Purpose

Use this guide when building `Fulfillment And Activation Control Tower`. It explains which generated files matter, when to read them, and how they drive Angular, Spring Boot, PostgreSQL, TMF API, event, and privacy work.

## App Identity

| Item | Value |
| --- | --- |
| Suite | 03 OSS Engineering, Inventory, And Fulfillment |
| Physical database | `ts_oss_engineering_fulfillment` |
| App schema | `fulfillment_activation` |
| Primary APIs | TMF641, TMF652, TMF640, TMF702, TMF664, TMF701, TMF621, TMF637, TMF638, TMF639 |
| Starter tables | 8 |
| TMF review status | Complete |
| DDL baseline status | Complete |

## File Checklist

| File | Link | Use it for |
| --- | --- | --- |
| App README | [README.md](README.md) | Navigation and current app detail pack entry point. |
| App overview | [../fulfillment-activation-control-tower.md](../fulfillment-activation-control-tower.md) | Concise product scope, app purpose, TMF API usage, ownership, integrations, and first-release direction. |
| Modules and features | [modules-and-features.md](modules-and-features.md) | Angular route/module planning, screens, user actions, backend capabilities, and acceptance scope. |
| Personas and journeys | [personas-and-user-journeys.md](personas-and-user-journeys.md) | UX behavior, workflow intent, dashboard needs, and role-specific journeys. |
| Suite tech/UI guidance | [../tech-and-ui-guidance.md](../tech-and-ui-guidance.md) | PrimeNG, Angular, density, navigation, theming, component reuse, and enterprise polish rules. |
| Suite data model | [../data-model.md](../data-model.md) | Suite database, app schema, data mastery, table ownership, and cross-app sharing rules. |
| App TMF review | [../../tmf-api-ddl-reviews/fulfillment-activation.md](../../tmf-api-ddl-reviews/fulfillment-activation.md) | TMF APIs, resource-to-table mapping, field handling, event baseline, privacy/retention/audit baseline. |
| Suite V001 migration | [../../../../database/postgres/suites/ts_oss_engineering_fulfillment/V001__create_app_schemas_and_starter_tables.sql](../../../../database/postgres/suites/ts_oss_engineering_fulfillment/V001__create_app_schemas_and_starter_tables.sql) | Creates suite schemas, starter app tables, base controls, and outbox tables. |
| App V002+ migration | [../../../../database/postgres/suites/ts_oss_engineering_fulfillment/V003__refine_fulfillment_activation_tmf_core.sql](../../../../database/postgres/suites/ts_oss_engineering_fulfillment/V003__refine_fulfillment_activation_tmf_core.sql) | Promotes common TMF columns and creates app support tables, event_contract, and privacy_retention_policy. |
| Coverage control matrix | [../../suite-app-coverage-control-matrix.md](../../suite-app-coverage-control-matrix.md) | Confirms this app is tracked and baseline implementation gate is clear. |

## How To Use These Files While Building

1. Read the app overview and this app folder README to confirm product scope and ownership.
2. Read `personas-and-user-journeys.md` before designing screens; it tells you who uses the app and why.
3. Read `modules-and-features.md` before creating Angular routes, pages, services, and PrimeNG components.
4. Apply suite UI guidance so the app keeps the TelcoSuite enterprise design language.
5. Read the suite `data-model.md` to confirm what this app owns and what it may only reference or consume.
6. Read the app TMF review before creating Spring Boot controllers, DTOs, entities, repositories, or database migrations.
7. Apply the suite `V001` migration and this app's V002+ migration in order before relying on promoted TMF fields or support tables.
8. Use `tmf_payload` for full TMF compatibility and promote only stable, searched, or operationally important fields to typed columns in later migrations.
9. Use `fulfillment_activation.event_contract` as the baseline event register and `fulfillment_activation.event_outbox` for publication.
10. Use `fulfillment_activation.privacy_retention_policy` as the baseline for masking, audit, retention, legal hold, and residency handling.

## Build Outputs To Produce

| Output | Must be based on |
| --- | --- |
| Angular routes/pages/components | `modules-and-features.md`, `personas-and-user-journeys.md`, suite tech/UI guidance |
| Spring Boot API contracts | App TMF review and selected local TMF specs |
| DTOs and validation | TMF resource fields, promoted columns, `tmf_payload`, and endpoint examples |
| Entities/repositories | Suite V001 migration, app V002+ migration, and suite data model |
| Events | `event_contract`, `event_outbox`, and integration design decisions |
| Tests | Persona journeys, module acceptance scope, endpoint contract tests, migration checks, privacy/audit checks |

## Guardrails

- Write only inside schema `fulfillment_activation` for this app's operational data.
- Do not write directly into another app schema. Use APIs, events, workflow tasks, governed views, or data products.
- Keep the primary stack open source: Angular, PrimeNG, Java Spring Boot, PostgreSQL.
- If another open-source technology is needed, list options with pros and cons and ask for a decision before implementation.
- If a TMF API does not fit the capability, document the mismatch and recommend a better TMF-aligned or open-source approach instead of forcing it.
- Endpoint contract tests remain required even though the baseline review and DDL are complete.

## Done Means

This app is ready for release only when product scope, UI flows, TMF API behavior, database schema, events, privacy controls, and tests all point back to the files above and any implementation deviations are documented.
