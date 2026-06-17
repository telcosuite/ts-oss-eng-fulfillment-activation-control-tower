# Fulfillment And Activation Control Tower P02 - Activation And Configuration And Activation Rollback And Compensation And Customer Partner And Offnet Activation Delivery Development Tasks

Suite: OSS Engineering, Inventory, And Fulfillment

App: Fulfillment And Activation Control Tower

App slug: `fulfillment-activation-control-tower`

Implementation repository: `ts-oss-eng-fulfillment-activation-control-tower`

Phase: P02 - Activation And Configuration And Activation Rollback And Compensation And Customer Partner And Offnet Activation Delivery

Phase file: `P02-activation-and-configuration-and-activation-rollback-and-compensation.md`

Phase rationale: Build the Activation And Configuration, Activation Rollback And Compensation, Customer Partner And Offnet Activation, Feasibility Readiness And Fulfillment Simulation capability cluster for Fulfillment And Activation Control Tower, carrying source workflows, APIs, events, tables, controls, and tests from the feature files into implementable work.

Phase exit gate: Fulfillment And Activation Control Tower can execute the Activation And Configuration, Activation Rollback And Compensation, Customer Partner And Offnet Activation, Feasibility Readiness And Fulfillment Simulation workflows through UI, API, `fulfillment_activation` persistence, outbox events, audit evidence, and release tests.

Out of scope for this phase: Runtime bootstrap is in P01; unrelated feature clusters and post-launch operations remain in their own phases.

Source tracker: [development-task-tracker.md](development-task-tracker.md)

Repository strategy: [TelcoSuite Repository Strategy](../../../../repository-strategy.md)

## Phase Coverage

- [Activation And Configuration](../features/activation-and-configuration.md)
- [Activation Rollback And Compensation](../features/activation-rollback-and-compensation.md)
- [Customer Partner And Offnet Activation](../features/customer-partner-and-offnet-activation.md)
- [Feasibility Readiness And Fulfillment Simulation](../features/feasibility-readiness-and-fulfillment-simulation.md)

## Phase Tasks

### DT-03-fulfillment-activation-control-tower-P02-T001: Build Activation And Configuration API, data model, workflow, and event spine

| Field | Value |
| --- | --- |
| Phase | P02 - Activation And Configuration And Activation Rollback And Compensation And Customer Partner And Offnet Activation Delivery |
| Priority | P0 |
| Source evidence | [Activation And Configuration](../features/activation-and-configuration.md), [Implementation usage](../implementation-file-usage.md), [App README](../README.md), [App overview](../../fulfillment-activation-control-tower.md), [Modules and features](../modules-and-features.md), [Personas and journeys](../personas-and-user-journeys.md), [Suite tech/UI guidance](../../tech-and-ui-guidance.md), [Suite data model](../../data-model.md), [Suite implementation guide](../../implementation-file-usage-guide.md), [Repository strategy](../../../../repository-strategy.md) |
| Feature or module | Activation And Configuration |
| Build area | API/Data/Event/Workflow/Security/Test |
| Target artifact | `backend/src/main/java/com/telcosuite/ossengineeringinventoryfulfillment/fulfillmentactivationcontroltower/ActivationAndConfigurationController.java`, `fulfillment_activation.activation_and_configuration`, `contracts/events/ActivationCompleted.json`, and `/api/03-oss-engineering-inventory-fulfillment/fulfillment-activation-control-tower/v1/activation-and-configuration` |
| Dependencies | DT-03-fulfillment-activation-control-tower-P01-T013 |
| Outputs | `ActivationAndConfigurationController`, `ActivationAndConfigurationService`, `fulfillment_activation.activation_and_configuration` migration, `ActivationCompleted` outbox schema, OpenAPI operations, unit/contract/migration/event replay tests |
| Missing evidence | No |

#### Implementation Notes

- Implement command and query APIs for `/api/03-oss-engineering-inventory-fulfillment/fulfillment-activation-control-tower/v1/activation-and-configuration` using TMF621, TMF637, TMF638, TMF639, TMF640, TMF641, TMF652, TMF664, TMF701, TMF702, with create, update, search, detail, lifecycle transition, timeline, evidence, and exception endpoints where the feature lifecycle requires them.
- Persist `Activation And Configuration` state in `fulfillment_activation.activation_and_configuration` with tenant, brand/market, lifecycle state, source authority, idempotency key, correlation ID, actor, reason code, audit fields, and `tmf_payload` JSONB.
- Publish `ActivationCompleted` through the transactional outbox with changed fields, replay metadata, consumer acknowledgement state, and reconciliation status for workflows: Trigger, Validation, Orchestration, Exception.
- Carry source details into code and tests for personas Fulfillment operations lead, Provisioning analyst, Activation engineer and objects Master entity, Referenced entities, Primary decisions, ODA boundary; keep cross-app references read-only unless they arrive through governed APIs/events/projections.

#### Acceptance Criteria

1. Given an authorized persona submits `POST /api/03-oss-engineering-inventory-fulfillment/fulfillment-activation-control-tower/v1/activation-and-configuration`, when required fields and policy checks pass, then the API returns `201` with `$.state`, persists `fulfillment_activation.activation_and_configuration.id`, and appends `ActivationCompleted` to `fulfillment_activation.event_outbox`.
2. Given a stale, duplicate, or out-of-order request hits `PATCH /api/03-oss-engineering-inventory-fulfillment/fulfillment-activation-control-tower/v1/activation-and-configuration/{id}`, when optimistic locking or idempotency validation fails, then the API returns `409` with `$.error.code='stale-or-duplicate-command'` and no second event is emitted.
3. Given another app needs `Activation And Configuration` state, when it requests data, then it receives TMF-aligned API/event/projection output and no direct database access to `fulfillment_activation.activation_and_configuration` is required.

#### Definition Of Done

- `ActivationAndConfigurationController`, service, repository, DTOs, validation, error model, and migration for `fulfillment_activation.activation_and_configuration` are committed under `ts-oss-eng-fulfillment-activation-control-tower`.
- OpenAPI contract tests, unit tests, Flyway migration tests, event schema tests, and event replay tests cover `/api/03-oss-engineering-inventory-fulfillment/fulfillment-activation-control-tower/v1/activation-and-configuration`, `fulfillment_activation.activation_and_configuration`, and `ActivationCompleted`.
- `development-task-tracker.md` records command output, source feature link, PR/evidence links, and any blocked downstream consumer.

#### Negative Scenarios

- Unauthorized, cross-tenant, or wrong-purpose requests to `/api/03-oss-engineering-inventory-fulfillment/fulfillment-activation-control-tower/v1/activation-and-configuration` return `403` and write a denial audit row instead of exposing `Activation And Configuration` data.
- Missing source authority, stale dependency state, invalid lifecycle transition, or failed policy decision keeps `fulfillment_activation.activation_and_configuration` in blocked/exception state with owner and due date.
- Downstream outage or consumer rejection queues retry/replay for `ActivationCompleted` and prevents silent completion.

#### Edge Cases

- Bulk or project-scale updates to `Activation And Configuration` use preview, partial-failure reporting, idempotency keys, rollback/repair notes, and async export where needed.
- Historical correction preserves previous `fulfillment_activation.activation_and_configuration` values, audit reason, source timestamp, actor, and downstream recalculation/replay instructions.
- Multi-tenant, market, residency, localization, and high-volume queue cases include pagination, back-pressure, circuit breaker, and replay controls.

#### Test Expectations

- `mvn test` covers `ActivationAndConfigurationService`, validation, authorization, idempotency, and lifecycle transition rules.
- OpenAPI contract tests call `POST/GET/PATCH /api/03-oss-engineering-inventory-fulfillment/fulfillment-activation-control-tower/v1/activation-and-configuration` and verify `$.state`, `$.id`, error payloads, and pagination/filter behavior.
- Flyway migration tests verify `fulfillment_activation.activation_and_configuration` columns and indexes; event replay tests validate `contracts/events/ActivationCompleted.json` and `fulfillment_activation.event_outbox` ordering.

### DT-03-fulfillment-activation-control-tower-P02-T002: Build Activation And Configuration workbench, controls, observability, and release tests

| Field | Value |
| --- | --- |
| Phase | P02 - Activation And Configuration And Activation Rollback And Compensation And Customer Partner And Offnet Activation Delivery |
| Priority | P1 |
| Source evidence | [Activation And Configuration](../features/activation-and-configuration.md), [Implementation usage](../implementation-file-usage.md), [App README](../README.md), [App overview](../../fulfillment-activation-control-tower.md), [Modules and features](../modules-and-features.md), [Personas and journeys](../personas-and-user-journeys.md), [Suite tech/UI guidance](../../tech-and-ui-guidance.md), [Suite data model](../../data-model.md), [Suite implementation guide](../../implementation-file-usage-guide.md), [Repository strategy](../../../../repository-strategy.md) |
| Feature or module | Activation And Configuration |
| Build area | UI/Security/Ops/Test |
| Target artifact | `frontend/src/app/pages/activation-and-configuration/`, `tests/e2e/activation-and-configuration.spec.ts`, Grafana panel `activation-and-configuration`, and `docs/operations-runbook.md#activation-and-configuration` |
| Dependencies | DT-03-fulfillment-activation-control-tower-P02-T001 |
| Outputs | Angular workbench, queue/detail/timeline/evidence panels, role-aware guards, accessibility states, E2E tests, dashboard JSON, alert rules, runbook section |
| Missing evidence | No |

#### Implementation Notes

- Create `frontend/src/app/pages/activation-and-configuration/` with search/intake, detail, lifecycle timeline, exception queue, evidence drawer, dependency freshness panel, and allowed-next-action controls for personas Fulfillment operations lead, Provisioning analyst, Activation engineer.
- Wire route guards, tenant/brand/market context, masking, no-permission states, keyboard navigation, PrimeNG table/form patterns, and saved filters using `ts-shared-ui-design-system`.
- Add dashboard metrics and runbook steps for workflows Trigger, Validation, Orchestration, Exception, event replay backlog, queue aging, policy denials, consumer lag, and completion quality.

#### Acceptance Criteria

1. Given an authorized persona opens `/app/fulfillment-activation-control-tower/activation-and-configuration`, when records exist, then the workbench returns `$.uiState='ready'` and renders `Activation And Configuration` rows with lifecycle state, owner, freshness, SLA/OLA timer, and action menu.
2. Given the persona lacks permission, when the same route loads, then the UI shows a no-permission state and the backend returns `403` with `$.error.code='access-denied'`.
3. Given replay backlog or queue aging exceeds threshold, when Grafana dashboard `activation-and-configuration` refreshes, then it shows the metric and links to `docs/operations-runbook.md#activation-and-configuration`.

#### Definition Of Done

- `frontend/src/app/pages/activation-and-configuration/` includes route, component, service, state, fixtures, empty/loading/error/no-permission states, and accessibility labels.
- `tests/e2e/activation-and-configuration.spec.ts`, accessibility checks, security tests, dashboard checks, and runbook review pass and are linked from the tracker.
- `development-task-tracker.md` captures screenshots, command output, PR links, dashboard/runbook links, and unresolved blockers.

#### Negative Scenarios

- Do not render `Activation And Configuration` details across tenant/residency boundaries; masked values stay masked in table, detail, export, timeline, and dashboard paths.
- Do not close UI actions when backend validation, event publication, reconciliation, or required evidence is incomplete.
- Do not hide downstream outage, stale source data, policy denial, or manual override behind a generic success toast.

#### Edge Cases

- Mobile or constrained layouts for `Activation And Configuration` collapse tables into accessible cards without losing lifecycle, owner, SLA/OLA, or evidence fields.
- Bulk/replay actions require preview, explicit confirmation, partial-failure details, rollback/repair notes, and operator evidence.
- High-volume dashboard and queue views use pagination, saved filters, async export, trace IDs, and back-pressure indicators.

#### Test Expectations

- `npm run lint`, `npm test`, and `tests/e2e/activation-and-configuration.spec.ts` validate route, forms, guards, workbench states, and API integration.
- Accessibility tests cover keyboard navigation, focus order, screen-reader labels, color contrast, density, and responsive layout.
- Operational-readiness tests validate Grafana dashboard JSON, alert rules, event replay panel, runbook links, and release evidence.

### DT-03-fulfillment-activation-control-tower-P02-T003: Build Activation Rollback And Compensation API, data model, workflow, and event spine

| Field | Value |
| --- | --- |
| Phase | P02 - Activation And Configuration And Activation Rollback And Compensation And Customer Partner And Offnet Activation Delivery |
| Priority | P0 |
| Source evidence | [Activation Rollback And Compensation](../features/activation-rollback-and-compensation.md), [Implementation usage](../implementation-file-usage.md), [App README](../README.md), [App overview](../../fulfillment-activation-control-tower.md), [Modules and features](../modules-and-features.md), [Personas and journeys](../personas-and-user-journeys.md), [Suite tech/UI guidance](../../tech-and-ui-guidance.md), [Suite data model](../../data-model.md), [Suite implementation guide](../../implementation-file-usage-guide.md), [Repository strategy](../../../../repository-strategy.md) |
| Feature or module | Activation Rollback And Compensation |
| Build area | API/Data/Event/Workflow/Security/Test |
| Target artifact | `backend/src/main/java/com/telcosuite/ossengineeringinventoryfulfillment/fulfillmentactivationcontroltower/ActivationRollbackAndCompensationController.java`, `fulfillment_activation.activation_rollback_and_compensation`, `contracts/events/ActivationStateRepairCompleted.json`, and `/api/03-oss-engineering-inventory-fulfillment/fulfillment-activation-control-tower/v1/activation-rollback-and-compensation` |
| Dependencies | DT-03-fulfillment-activation-control-tower-P02-T001 |
| Outputs | `ActivationRollbackAndCompensationController`, `ActivationRollbackAndCompensationService`, `fulfillment_activation.activation_rollback_and_compensation` migration, `ActivationStateRepairCompleted` outbox schema, OpenAPI operations, unit/contract/migration/event replay tests |
| Missing evidence | No |

#### Implementation Notes

- Implement command and query APIs for `/api/03-oss-engineering-inventory-fulfillment/fulfillment-activation-control-tower/v1/activation-rollback-and-compensation` using TMF621, TMF622, TMF637, TMF638, TMF639, TMF640, TMF641, TMF652, TMF664, TMF681, TMF701, TMF702, with create, update, search, detail, lifecycle transition, timeline, evidence, and exception endpoints where the feature lifecycle requires them.
- Persist `Activation Rollback And Compensation` state in `fulfillment_activation.activation_rollback_and_compensation` with tenant, brand/market, lifecycle state, source authority, idempotency key, correlation ID, actor, reason code, audit fields, and `tmf_payload` JSONB.
- Publish `ActivationStateRepairCompleted` through the transactional outbox with changed fields, replay metadata, consumer acknowledgement state, and reconciliation status for workflows: Trigger, Validation, Orchestration, Exception.
- Carry source details into code and tests for personas Fulfillment operations lead, Provisioning analyst, Activation engineer and objects Master entity, Referenced entities, Primary decisions, ODA boundary; keep cross-app references read-only unless they arrive through governed APIs/events/projections.

#### Acceptance Criteria

1. Given an authorized persona submits `POST /api/03-oss-engineering-inventory-fulfillment/fulfillment-activation-control-tower/v1/activation-rollback-and-compensation`, when required fields and policy checks pass, then the API returns `201` with `$.state`, persists `fulfillment_activation.activation_rollback_and_compensation.id`, and appends `ActivationStateRepairCompleted` to `fulfillment_activation.event_outbox`.
2. Given a stale, duplicate, or out-of-order request hits `PATCH /api/03-oss-engineering-inventory-fulfillment/fulfillment-activation-control-tower/v1/activation-rollback-and-compensation/{id}`, when optimistic locking or idempotency validation fails, then the API returns `409` with `$.error.code='stale-or-duplicate-command'` and no second event is emitted.
3. Given another app needs `Activation Rollback And Compensation` state, when it requests data, then it receives TMF-aligned API/event/projection output and no direct database access to `fulfillment_activation.activation_rollback_and_compensation` is required.

#### Definition Of Done

- `ActivationRollbackAndCompensationController`, service, repository, DTOs, validation, error model, and migration for `fulfillment_activation.activation_rollback_and_compensation` are committed under `ts-oss-eng-fulfillment-activation-control-tower`.
- OpenAPI contract tests, unit tests, Flyway migration tests, event schema tests, and event replay tests cover `/api/03-oss-engineering-inventory-fulfillment/fulfillment-activation-control-tower/v1/activation-rollback-and-compensation`, `fulfillment_activation.activation_rollback_and_compensation`, and `ActivationStateRepairCompleted`.
- `development-task-tracker.md` records command output, source feature link, PR/evidence links, and any blocked downstream consumer.

#### Negative Scenarios

- Unauthorized, cross-tenant, or wrong-purpose requests to `/api/03-oss-engineering-inventory-fulfillment/fulfillment-activation-control-tower/v1/activation-rollback-and-compensation` return `403` and write a denial audit row instead of exposing `Activation Rollback And Compensation` data.
- Missing source authority, stale dependency state, invalid lifecycle transition, or failed policy decision keeps `fulfillment_activation.activation_rollback_and_compensation` in blocked/exception state with owner and due date.
- Downstream outage or consumer rejection queues retry/replay for `ActivationStateRepairCompleted` and prevents silent completion.

#### Edge Cases

- Bulk or project-scale updates to `Activation Rollback And Compensation` use preview, partial-failure reporting, idempotency keys, rollback/repair notes, and async export where needed.
- Historical correction preserves previous `fulfillment_activation.activation_rollback_and_compensation` values, audit reason, source timestamp, actor, and downstream recalculation/replay instructions.
- Multi-tenant, market, residency, localization, and high-volume queue cases include pagination, back-pressure, circuit breaker, and replay controls.

#### Test Expectations

- `mvn test` covers `ActivationRollbackAndCompensationService`, validation, authorization, idempotency, and lifecycle transition rules.
- OpenAPI contract tests call `POST/GET/PATCH /api/03-oss-engineering-inventory-fulfillment/fulfillment-activation-control-tower/v1/activation-rollback-and-compensation` and verify `$.state`, `$.id`, error payloads, and pagination/filter behavior.
- Flyway migration tests verify `fulfillment_activation.activation_rollback_and_compensation` columns and indexes; event replay tests validate `contracts/events/ActivationStateRepairCompleted.json` and `fulfillment_activation.event_outbox` ordering.

### DT-03-fulfillment-activation-control-tower-P02-T004: Build Activation Rollback And Compensation workbench, controls, observability, and release tests

| Field | Value |
| --- | --- |
| Phase | P02 - Activation And Configuration And Activation Rollback And Compensation And Customer Partner And Offnet Activation Delivery |
| Priority | P1 |
| Source evidence | [Activation Rollback And Compensation](../features/activation-rollback-and-compensation.md), [Implementation usage](../implementation-file-usage.md), [App README](../README.md), [App overview](../../fulfillment-activation-control-tower.md), [Modules and features](../modules-and-features.md), [Personas and journeys](../personas-and-user-journeys.md), [Suite tech/UI guidance](../../tech-and-ui-guidance.md), [Suite data model](../../data-model.md), [Suite implementation guide](../../implementation-file-usage-guide.md), [Repository strategy](../../../../repository-strategy.md) |
| Feature or module | Activation Rollback And Compensation |
| Build area | UI/Security/Ops/Test |
| Target artifact | `frontend/src/app/pages/activation-rollback-and-compensation/`, `tests/e2e/activation-rollback-and-compensation.spec.ts`, Grafana panel `activation-rollback-and-compensation`, and `docs/operations-runbook.md#activation-rollback-and-compensation` |
| Dependencies | DT-03-fulfillment-activation-control-tower-P02-T003 |
| Outputs | Angular workbench, queue/detail/timeline/evidence panels, role-aware guards, accessibility states, E2E tests, dashboard JSON, alert rules, runbook section |
| Missing evidence | No |

#### Implementation Notes

- Create `frontend/src/app/pages/activation-rollback-and-compensation/` with search/intake, detail, lifecycle timeline, exception queue, evidence drawer, dependency freshness panel, and allowed-next-action controls for personas Fulfillment operations lead, Provisioning analyst, Activation engineer.
- Wire route guards, tenant/brand/market context, masking, no-permission states, keyboard navigation, PrimeNG table/form patterns, and saved filters using `ts-shared-ui-design-system`.
- Add dashboard metrics and runbook steps for workflows Trigger, Validation, Orchestration, Exception, event replay backlog, queue aging, policy denials, consumer lag, and completion quality.

#### Acceptance Criteria

1. Given an authorized persona opens `/app/fulfillment-activation-control-tower/activation-rollback-and-compensation`, when records exist, then the workbench returns `$.uiState='ready'` and renders `Activation Rollback And Compensation` rows with lifecycle state, owner, freshness, SLA/OLA timer, and action menu.
2. Given the persona lacks permission, when the same route loads, then the UI shows a no-permission state and the backend returns `403` with `$.error.code='access-denied'`.
3. Given replay backlog or queue aging exceeds threshold, when Grafana dashboard `activation-rollback-and-compensation` refreshes, then it shows the metric and links to `docs/operations-runbook.md#activation-rollback-and-compensation`.

#### Definition Of Done

- `frontend/src/app/pages/activation-rollback-and-compensation/` includes route, component, service, state, fixtures, empty/loading/error/no-permission states, and accessibility labels.
- `tests/e2e/activation-rollback-and-compensation.spec.ts`, accessibility checks, security tests, dashboard checks, and runbook review pass and are linked from the tracker.
- `development-task-tracker.md` captures screenshots, command output, PR links, dashboard/runbook links, and unresolved blockers.

#### Negative Scenarios

- Do not render `Activation Rollback And Compensation` details across tenant/residency boundaries; masked values stay masked in table, detail, export, timeline, and dashboard paths.
- Do not close UI actions when backend validation, event publication, reconciliation, or required evidence is incomplete.
- Do not hide downstream outage, stale source data, policy denial, or manual override behind a generic success toast.

#### Edge Cases

- Mobile or constrained layouts for `Activation Rollback And Compensation` collapse tables into accessible cards without losing lifecycle, owner, SLA/OLA, or evidence fields.
- Bulk/replay actions require preview, explicit confirmation, partial-failure details, rollback/repair notes, and operator evidence.
- High-volume dashboard and queue views use pagination, saved filters, async export, trace IDs, and back-pressure indicators.

#### Test Expectations

- `npm run lint`, `npm test`, and `tests/e2e/activation-rollback-and-compensation.spec.ts` validate route, forms, guards, workbench states, and API integration.
- Accessibility tests cover keyboard navigation, focus order, screen-reader labels, color contrast, density, and responsive layout.
- Operational-readiness tests validate Grafana dashboard JSON, alert rules, event replay panel, runbook links, and release evidence.

### DT-03-fulfillment-activation-control-tower-P02-T005: Build Customer Partner And Offnet Activation API, data model, workflow, and event spine

| Field | Value |
| --- | --- |
| Phase | P02 - Activation And Configuration And Activation Rollback And Compensation And Customer Partner And Offnet Activation Delivery |
| Priority | P0 |
| Source evidence | [Customer Partner And Offnet Activation](../features/customer-partner-and-offnet-activation.md), [Implementation usage](../implementation-file-usage.md), [App README](../README.md), [App overview](../../fulfillment-activation-control-tower.md), [Modules and features](../modules-and-features.md), [Personas and journeys](../personas-and-user-journeys.md), [Suite tech/UI guidance](../../tech-and-ui-guidance.md), [Suite data model](../../data-model.md), [Suite implementation guide](../../implementation-file-usage-guide.md), [Repository strategy](../../../../repository-strategy.md) |
| Feature or module | Customer Partner And Offnet Activation |
| Build area | API/Data/Event/Workflow/Security/Test |
| Target artifact | `backend/src/main/java/com/telcosuite/ossengineeringinventoryfulfillment/fulfillmentactivationcontroltower/CustomerPartnerAndOffnetActivationController.java`, `fulfillment_activation.customer_partner_and_offnet_activation`, `contracts/events/OffnetActivationCompleted.json`, and `/api/03-oss-engineering-inventory-fulfillment/fulfillment-activation-control-tower/v1/customer-partner-and-offnet-activation` |
| Dependencies | DT-03-fulfillment-activation-control-tower-P02-T003 |
| Outputs | `CustomerPartnerAndOffnetActivationController`, `CustomerPartnerAndOffnetActivationService`, `fulfillment_activation.customer_partner_and_offnet_activation` migration, `OffnetActivationCompleted` outbox schema, OpenAPI operations, unit/contract/migration/event replay tests |
| Missing evidence | No |

#### Implementation Notes

- Implement command and query APIs for `/api/03-oss-engineering-inventory-fulfillment/fulfillment-activation-control-tower/v1/customer-partner-and-offnet-activation` using TMF621, TMF622, TMF637, TMF638, TMF639, TMF640, TMF641, TMF652, TMF664, TMF669, TMF681, TMF701, TMF702, with create, update, search, detail, lifecycle transition, timeline, evidence, and exception endpoints where the feature lifecycle requires them.
- Persist `Customer Partner And Offnet Activation` state in `fulfillment_activation.customer_partner_and_offnet_activation` with tenant, brand/market, lifecycle state, source authority, idempotency key, correlation ID, actor, reason code, audit fields, and `tmf_payload` JSONB.
- Publish `OffnetActivationCompleted` through the transactional outbox with changed fields, replay metadata, consumer acknowledgement state, and reconciliation status for workflows: Trigger, Validation, Orchestration, Exception.
- Carry source details into code and tests for personas Fulfillment operations lead, Provisioning analyst, Activation engineer and objects Master entity, Referenced entities, Primary decisions, ODA boundary; keep cross-app references read-only unless they arrive through governed APIs/events/projections.

#### Acceptance Criteria

1. Given an authorized persona submits `POST /api/03-oss-engineering-inventory-fulfillment/fulfillment-activation-control-tower/v1/customer-partner-and-offnet-activation`, when required fields and policy checks pass, then the API returns `201` with `$.state`, persists `fulfillment_activation.customer_partner_and_offnet_activation.id`, and appends `OffnetActivationCompleted` to `fulfillment_activation.event_outbox`.
2. Given a stale, duplicate, or out-of-order request hits `PATCH /api/03-oss-engineering-inventory-fulfillment/fulfillment-activation-control-tower/v1/customer-partner-and-offnet-activation/{id}`, when optimistic locking or idempotency validation fails, then the API returns `409` with `$.error.code='stale-or-duplicate-command'` and no second event is emitted.
3. Given another app needs `Customer Partner And Offnet Activation` state, when it requests data, then it receives TMF-aligned API/event/projection output and no direct database access to `fulfillment_activation.customer_partner_and_offnet_activation` is required.

#### Definition Of Done

- `CustomerPartnerAndOffnetActivationController`, service, repository, DTOs, validation, error model, and migration for `fulfillment_activation.customer_partner_and_offnet_activation` are committed under `ts-oss-eng-fulfillment-activation-control-tower`.
- OpenAPI contract tests, unit tests, Flyway migration tests, event schema tests, and event replay tests cover `/api/03-oss-engineering-inventory-fulfillment/fulfillment-activation-control-tower/v1/customer-partner-and-offnet-activation`, `fulfillment_activation.customer_partner_and_offnet_activation`, and `OffnetActivationCompleted`.
- `development-task-tracker.md` records command output, source feature link, PR/evidence links, and any blocked downstream consumer.

#### Negative Scenarios

- Unauthorized, cross-tenant, or wrong-purpose requests to `/api/03-oss-engineering-inventory-fulfillment/fulfillment-activation-control-tower/v1/customer-partner-and-offnet-activation` return `403` and write a denial audit row instead of exposing `Customer Partner And Offnet Activation` data.
- Missing source authority, stale dependency state, invalid lifecycle transition, or failed policy decision keeps `fulfillment_activation.customer_partner_and_offnet_activation` in blocked/exception state with owner and due date.
- Downstream outage or consumer rejection queues retry/replay for `OffnetActivationCompleted` and prevents silent completion.

#### Edge Cases

- Bulk or project-scale updates to `Customer Partner And Offnet Activation` use preview, partial-failure reporting, idempotency keys, rollback/repair notes, and async export where needed.
- Historical correction preserves previous `fulfillment_activation.customer_partner_and_offnet_activation` values, audit reason, source timestamp, actor, and downstream recalculation/replay instructions.
- Multi-tenant, market, residency, localization, and high-volume queue cases include pagination, back-pressure, circuit breaker, and replay controls.

#### Test Expectations

- `mvn test` covers `CustomerPartnerAndOffnetActivationService`, validation, authorization, idempotency, and lifecycle transition rules.
- OpenAPI contract tests call `POST/GET/PATCH /api/03-oss-engineering-inventory-fulfillment/fulfillment-activation-control-tower/v1/customer-partner-and-offnet-activation` and verify `$.state`, `$.id`, error payloads, and pagination/filter behavior.
- Flyway migration tests verify `fulfillment_activation.customer_partner_and_offnet_activation` columns and indexes; event replay tests validate `contracts/events/OffnetActivationCompleted.json` and `fulfillment_activation.event_outbox` ordering.

### DT-03-fulfillment-activation-control-tower-P02-T006: Build Customer Partner And Offnet Activation workbench, controls, observability, and release tests

| Field | Value |
| --- | --- |
| Phase | P02 - Activation And Configuration And Activation Rollback And Compensation And Customer Partner And Offnet Activation Delivery |
| Priority | P1 |
| Source evidence | [Customer Partner And Offnet Activation](../features/customer-partner-and-offnet-activation.md), [Implementation usage](../implementation-file-usage.md), [App README](../README.md), [App overview](../../fulfillment-activation-control-tower.md), [Modules and features](../modules-and-features.md), [Personas and journeys](../personas-and-user-journeys.md), [Suite tech/UI guidance](../../tech-and-ui-guidance.md), [Suite data model](../../data-model.md), [Suite implementation guide](../../implementation-file-usage-guide.md), [Repository strategy](../../../../repository-strategy.md) |
| Feature or module | Customer Partner And Offnet Activation |
| Build area | UI/Security/Ops/Test |
| Target artifact | `frontend/src/app/pages/customer-partner-and-offnet-activation/`, `tests/e2e/customer-partner-and-offnet-activation.spec.ts`, Grafana panel `customer-partner-and-offnet-activation`, and `docs/operations-runbook.md#customer-partner-and-offnet-activation` |
| Dependencies | DT-03-fulfillment-activation-control-tower-P02-T005 |
| Outputs | Angular workbench, queue/detail/timeline/evidence panels, role-aware guards, accessibility states, E2E tests, dashboard JSON, alert rules, runbook section |
| Missing evidence | No |

#### Implementation Notes

- Create `frontend/src/app/pages/customer-partner-and-offnet-activation/` with search/intake, detail, lifecycle timeline, exception queue, evidence drawer, dependency freshness panel, and allowed-next-action controls for personas Fulfillment operations lead, Provisioning analyst, Activation engineer.
- Wire route guards, tenant/brand/market context, masking, no-permission states, keyboard navigation, PrimeNG table/form patterns, and saved filters using `ts-shared-ui-design-system`.
- Add dashboard metrics and runbook steps for workflows Trigger, Validation, Orchestration, Exception, event replay backlog, queue aging, policy denials, consumer lag, and completion quality.

#### Acceptance Criteria

1. Given an authorized persona opens `/app/fulfillment-activation-control-tower/customer-partner-and-offnet-activation`, when records exist, then the workbench returns `$.uiState='ready'` and renders `Customer Partner And Offnet Activation` rows with lifecycle state, owner, freshness, SLA/OLA timer, and action menu.
2. Given the persona lacks permission, when the same route loads, then the UI shows a no-permission state and the backend returns `403` with `$.error.code='access-denied'`.
3. Given replay backlog or queue aging exceeds threshold, when Grafana dashboard `customer-partner-and-offnet-activation` refreshes, then it shows the metric and links to `docs/operations-runbook.md#customer-partner-and-offnet-activation`.

#### Definition Of Done

- `frontend/src/app/pages/customer-partner-and-offnet-activation/` includes route, component, service, state, fixtures, empty/loading/error/no-permission states, and accessibility labels.
- `tests/e2e/customer-partner-and-offnet-activation.spec.ts`, accessibility checks, security tests, dashboard checks, and runbook review pass and are linked from the tracker.
- `development-task-tracker.md` captures screenshots, command output, PR links, dashboard/runbook links, and unresolved blockers.

#### Negative Scenarios

- Do not render `Customer Partner And Offnet Activation` details across tenant/residency boundaries; masked values stay masked in table, detail, export, timeline, and dashboard paths.
- Do not close UI actions when backend validation, event publication, reconciliation, or required evidence is incomplete.
- Do not hide downstream outage, stale source data, policy denial, or manual override behind a generic success toast.

#### Edge Cases

- Mobile or constrained layouts for `Customer Partner And Offnet Activation` collapse tables into accessible cards without losing lifecycle, owner, SLA/OLA, or evidence fields.
- Bulk/replay actions require preview, explicit confirmation, partial-failure details, rollback/repair notes, and operator evidence.
- High-volume dashboard and queue views use pagination, saved filters, async export, trace IDs, and back-pressure indicators.

#### Test Expectations

- `npm run lint`, `npm test`, and `tests/e2e/customer-partner-and-offnet-activation.spec.ts` validate route, forms, guards, workbench states, and API integration.
- Accessibility tests cover keyboard navigation, focus order, screen-reader labels, color contrast, density, and responsive layout.
- Operational-readiness tests validate Grafana dashboard JSON, alert rules, event replay panel, runbook links, and release evidence.

### DT-03-fulfillment-activation-control-tower-P02-T007: Build Feasibility Readiness And Fulfillment Simulation API, data model, workflow, and event spine

| Field | Value |
| --- | --- |
| Phase | P02 - Activation And Configuration And Activation Rollback And Compensation And Customer Partner And Offnet Activation Delivery |
| Priority | P0 |
| Source evidence | [Feasibility Readiness And Fulfillment Simulation](../features/feasibility-readiness-and-fulfillment-simulation.md), [Implementation usage](../implementation-file-usage.md), [App README](../README.md), [App overview](../../fulfillment-activation-control-tower.md), [Modules and features](../modules-and-features.md), [Personas and journeys](../personas-and-user-journeys.md), [Suite tech/UI guidance](../../tech-and-ui-guidance.md), [Suite data model](../../data-model.md), [Suite implementation guide](../../implementation-file-usage-guide.md), [Repository strategy](../../../../repository-strategy.md) |
| Feature or module | Feasibility Readiness And Fulfillment Simulation |
| Build area | API/Data/Event/Workflow/Security/Test |
| Target artifact | `backend/src/main/java/com/telcosuite/ossengineeringinventoryfulfillment/fulfillmentactivationcontroltower/FeasibilityReadinessAndFulfillmentSimulationController.java`, `fulfillment_activation.feasibility_readiness_and_fulfillment_simulation`, `contracts/events/FulfillmentReadinessFailed.json`, and `/api/03-oss-engineering-inventory-fulfillment/fulfillment-activation-control-tower/v1/feasibility-readiness-and-fulfillment-simulation` |
| Dependencies | DT-03-fulfillment-activation-control-tower-P02-T005 |
| Outputs | `FeasibilityReadinessAndFulfillmentSimulationController`, `FeasibilityReadinessAndFulfillmentSimulationService`, `fulfillment_activation.feasibility_readiness_and_fulfillment_simulation` migration, `FulfillmentReadinessFailed` outbox schema, OpenAPI operations, unit/contract/migration/event replay tests |
| Missing evidence | No |

#### Implementation Notes

- Implement command and query APIs for `/api/03-oss-engineering-inventory-fulfillment/fulfillment-activation-control-tower/v1/feasibility-readiness-and-fulfillment-simulation` using TMF621, TMF622, TMF637, TMF638, TMF639, TMF640, TMF641, TMF645, TMF646, TMF652, TMF664, TMF701, TMF702, TMF716, with create, update, search, detail, lifecycle transition, timeline, evidence, and exception endpoints where the feature lifecycle requires them.
- Persist `Feasibility Readiness And Fulfillment Simulation` state in `fulfillment_activation.feasibility_readiness_and_fulfillment_simulation` with tenant, brand/market, lifecycle state, source authority, idempotency key, correlation ID, actor, reason code, audit fields, and `tmf_payload` JSONB.
- Publish `FulfillmentReadinessFailed` through the transactional outbox with changed fields, replay metadata, consumer acknowledgement state, and reconciliation status for workflows: Trigger, Validation, Orchestration, Exception.
- Carry source details into code and tests for personas Fulfillment operations lead, Provisioning analyst, Activation engineer and objects Master entity, Referenced entities, Primary decisions, ODA boundary; keep cross-app references read-only unless they arrive through governed APIs/events/projections.

#### Acceptance Criteria

1. Given an authorized persona submits `POST /api/03-oss-engineering-inventory-fulfillment/fulfillment-activation-control-tower/v1/feasibility-readiness-and-fulfillment-simulation`, when required fields and policy checks pass, then the API returns `201` with `$.state`, persists `fulfillment_activation.feasibility_readiness_and_fulfillment_simulation.id`, and appends `FulfillmentReadinessFailed` to `fulfillment_activation.event_outbox`.
2. Given a stale, duplicate, or out-of-order request hits `PATCH /api/03-oss-engineering-inventory-fulfillment/fulfillment-activation-control-tower/v1/feasibility-readiness-and-fulfillment-simulation/{id}`, when optimistic locking or idempotency validation fails, then the API returns `409` with `$.error.code='stale-or-duplicate-command'` and no second event is emitted.
3. Given another app needs `Feasibility Readiness And Fulfillment Simulation` state, when it requests data, then it receives TMF-aligned API/event/projection output and no direct database access to `fulfillment_activation.feasibility_readiness_and_fulfillment_simulation` is required.

#### Definition Of Done

- `FeasibilityReadinessAndFulfillmentSimulationController`, service, repository, DTOs, validation, error model, and migration for `fulfillment_activation.feasibility_readiness_and_fulfillment_simulation` are committed under `ts-oss-eng-fulfillment-activation-control-tower`.
- OpenAPI contract tests, unit tests, Flyway migration tests, event schema tests, and event replay tests cover `/api/03-oss-engineering-inventory-fulfillment/fulfillment-activation-control-tower/v1/feasibility-readiness-and-fulfillment-simulation`, `fulfillment_activation.feasibility_readiness_and_fulfillment_simulation`, and `FulfillmentReadinessFailed`.
- `development-task-tracker.md` records command output, source feature link, PR/evidence links, and any blocked downstream consumer.

#### Negative Scenarios

- Unauthorized, cross-tenant, or wrong-purpose requests to `/api/03-oss-engineering-inventory-fulfillment/fulfillment-activation-control-tower/v1/feasibility-readiness-and-fulfillment-simulation` return `403` and write a denial audit row instead of exposing `Feasibility Readiness And Fulfillment Simulation` data.
- Missing source authority, stale dependency state, invalid lifecycle transition, or failed policy decision keeps `fulfillment_activation.feasibility_readiness_and_fulfillment_simulation` in blocked/exception state with owner and due date.
- Downstream outage or consumer rejection queues retry/replay for `FulfillmentReadinessFailed` and prevents silent completion.

#### Edge Cases

- Bulk or project-scale updates to `Feasibility Readiness And Fulfillment Simulation` use preview, partial-failure reporting, idempotency keys, rollback/repair notes, and async export where needed.
- Historical correction preserves previous `fulfillment_activation.feasibility_readiness_and_fulfillment_simulation` values, audit reason, source timestamp, actor, and downstream recalculation/replay instructions.
- Multi-tenant, market, residency, localization, and high-volume queue cases include pagination, back-pressure, circuit breaker, and replay controls.

#### Test Expectations

- `mvn test` covers `FeasibilityReadinessAndFulfillmentSimulationService`, validation, authorization, idempotency, and lifecycle transition rules.
- OpenAPI contract tests call `POST/GET/PATCH /api/03-oss-engineering-inventory-fulfillment/fulfillment-activation-control-tower/v1/feasibility-readiness-and-fulfillment-simulation` and verify `$.state`, `$.id`, error payloads, and pagination/filter behavior.
- Flyway migration tests verify `fulfillment_activation.feasibility_readiness_and_fulfillment_simulation` columns and indexes; event replay tests validate `contracts/events/FulfillmentReadinessFailed.json` and `fulfillment_activation.event_outbox` ordering.

### DT-03-fulfillment-activation-control-tower-P02-T008: Build Feasibility Readiness And Fulfillment Simulation workbench, controls, observability, and release tests

| Field | Value |
| --- | --- |
| Phase | P02 - Activation And Configuration And Activation Rollback And Compensation And Customer Partner And Offnet Activation Delivery |
| Priority | P1 |
| Source evidence | [Feasibility Readiness And Fulfillment Simulation](../features/feasibility-readiness-and-fulfillment-simulation.md), [Implementation usage](../implementation-file-usage.md), [App README](../README.md), [App overview](../../fulfillment-activation-control-tower.md), [Modules and features](../modules-and-features.md), [Personas and journeys](../personas-and-user-journeys.md), [Suite tech/UI guidance](../../tech-and-ui-guidance.md), [Suite data model](../../data-model.md), [Suite implementation guide](../../implementation-file-usage-guide.md), [Repository strategy](../../../../repository-strategy.md) |
| Feature or module | Feasibility Readiness And Fulfillment Simulation |
| Build area | UI/Security/Ops/Test |
| Target artifact | `frontend/src/app/pages/feasibility-readiness-and-fulfillment-simulation/`, `tests/e2e/feasibility-readiness-and-fulfillment-simulation.spec.ts`, Grafana panel `feasibility-readiness-and-fulfillment-simulation`, and `docs/operations-runbook.md#feasibility-readiness-and-fulfillment-simulation` |
| Dependencies | DT-03-fulfillment-activation-control-tower-P02-T007 |
| Outputs | Angular workbench, queue/detail/timeline/evidence panels, role-aware guards, accessibility states, E2E tests, dashboard JSON, alert rules, runbook section |
| Missing evidence | No |

#### Implementation Notes

- Create `frontend/src/app/pages/feasibility-readiness-and-fulfillment-simulation/` with search/intake, detail, lifecycle timeline, exception queue, evidence drawer, dependency freshness panel, and allowed-next-action controls for personas Fulfillment operations lead, Provisioning analyst, Activation engineer.
- Wire route guards, tenant/brand/market context, masking, no-permission states, keyboard navigation, PrimeNG table/form patterns, and saved filters using `ts-shared-ui-design-system`.
- Add dashboard metrics and runbook steps for workflows Trigger, Validation, Orchestration, Exception, event replay backlog, queue aging, policy denials, consumer lag, and completion quality.

#### Acceptance Criteria

1. Given an authorized persona opens `/app/fulfillment-activation-control-tower/feasibility-readiness-and-fulfillment-simulation`, when records exist, then the workbench returns `$.uiState='ready'` and renders `Feasibility Readiness And Fulfillment Simulation` rows with lifecycle state, owner, freshness, SLA/OLA timer, and action menu.
2. Given the persona lacks permission, when the same route loads, then the UI shows a no-permission state and the backend returns `403` with `$.error.code='access-denied'`.
3. Given replay backlog or queue aging exceeds threshold, when Grafana dashboard `feasibility-readiness-and-fulfillment-simulation` refreshes, then it shows the metric and links to `docs/operations-runbook.md#feasibility-readiness-and-fulfillment-simulation`.

#### Definition Of Done

- `frontend/src/app/pages/feasibility-readiness-and-fulfillment-simulation/` includes route, component, service, state, fixtures, empty/loading/error/no-permission states, and accessibility labels.
- `tests/e2e/feasibility-readiness-and-fulfillment-simulation.spec.ts`, accessibility checks, security tests, dashboard checks, and runbook review pass and are linked from the tracker.
- `development-task-tracker.md` captures screenshots, command output, PR links, dashboard/runbook links, and unresolved blockers.

#### Negative Scenarios

- Do not render `Feasibility Readiness And Fulfillment Simulation` details across tenant/residency boundaries; masked values stay masked in table, detail, export, timeline, and dashboard paths.
- Do not close UI actions when backend validation, event publication, reconciliation, or required evidence is incomplete.
- Do not hide downstream outage, stale source data, policy denial, or manual override behind a generic success toast.

#### Edge Cases

- Mobile or constrained layouts for `Feasibility Readiness And Fulfillment Simulation` collapse tables into accessible cards without losing lifecycle, owner, SLA/OLA, or evidence fields.
- Bulk/replay actions require preview, explicit confirmation, partial-failure details, rollback/repair notes, and operator evidence.
- High-volume dashboard and queue views use pagination, saved filters, async export, trace IDs, and back-pressure indicators.

#### Test Expectations

- `npm run lint`, `npm test`, and `tests/e2e/feasibility-readiness-and-fulfillment-simulation.spec.ts` validate route, forms, guards, workbench states, and API integration.
- Accessibility tests cover keyboard navigation, focus order, screen-reader labels, color contrast, density, and responsive layout.
- Operational-readiness tests validate Grafana dashboard JSON, alert rules, event replay panel, runbook links, and release evidence.

### DT-03-fulfillment-activation-control-tower-P02-T009: Prove Activation And Configuration And Activation Rollback And Compensation And Customer Partner And Offnet Activation Delivery release gate, replay, and handoff evidence

| Field | Value |
| --- | --- |
| Phase | P02 - Activation And Configuration And Activation Rollback And Compensation And Customer Partner And Offnet Activation Delivery |
| Priority | P1 |
| Source evidence | [Activation And Configuration](../features/activation-and-configuration.md), [Activation Rollback And Compensation](../features/activation-rollback-and-compensation.md), [Customer Partner And Offnet Activation](../features/customer-partner-and-offnet-activation.md), [Feasibility Readiness And Fulfillment Simulation](../features/feasibility-readiness-and-fulfillment-simulation.md), [Implementation usage](../implementation-file-usage.md), [App README](../README.md), [App overview](../../fulfillment-activation-control-tower.md), [Modules and features](../modules-and-features.md), [Personas and journeys](../personas-and-user-journeys.md), [Suite tech/UI guidance](../../tech-and-ui-guidance.md), [Suite data model](../../data-model.md), [Suite implementation guide](../../implementation-file-usage-guide.md), [Repository strategy](../../../../repository-strategy.md) |
| Feature or module | Activation And Configuration And Activation Rollback And Compensation And Customer Partner And Offnet Activation Delivery |
| Build area | Test/Ops/Release/Event |
| Target artifact | `tests/release/activation-and-configuration-and-activation-rollback-and-compensation.spec.ts`, `docs/release-notes/activation-and-configuration-and-activation-rollback-and-compensation.md`, Grafana dashboard `activation-and-configuration-and-activation-rollback-and-compensation`, and replay fixtures |
| Dependencies | DT-03-fulfillment-activation-control-tower-P02-T002, DT-03-fulfillment-activation-control-tower-P02-T004, DT-03-fulfillment-activation-control-tower-P02-T006, DT-03-fulfillment-activation-control-tower-P02-T008 |
| Outputs | Release-gate test, replay/reconciliation evidence, accessibility/security/performance reports, dashboard/runbook links, support handoff notes |
| Missing evidence | No |

#### Implementation Notes

- Create a release-gate checklist for `activation-and-configuration-and-activation-rollback-and-compensation` covering Activation And Configuration, Activation Rollback And Compensation, Customer Partner And Offnet Activation, Feasibility Readiness And Fulfillment Simulation, with happy path, assisted path, negative path, edge cases, event replay, data reconciliation, security, accessibility, performance, and support evidence.
- Record producer and consumer acknowledgements for phase events, reconcile `fulfillment_activation.event_outbox`, and link replay fixtures and correlation IDs.
- Update `docs/operations-runbook.md`, `docs/release-notes/activation-and-configuration-and-activation-rollback-and-compensation.md`, and `development-task-tracker.md` with release evidence and unresolved blockers.

#### Acceptance Criteria

1. Given all tasks in `P02-activation-and-configuration-and-activation-rollback-and-compensation.md` are complete, when `tests/release/activation-and-configuration-and-activation-rollback-and-compensation.spec.ts` runs, then it returns exit code `0` and links evidence for UI, API, data, event, security, ops, and test gates.
2. Given a consumer rejects an event from `activation-and-configuration-and-activation-rollback-and-compensation`, when replay is triggered, then the replay fixture preserves `$.correlationId`, `$.eventId`, and consumer acknowledgement state.
3. Given release notes are generated, when support reviews `docs/release-notes/activation-and-configuration-and-activation-rollback-and-compensation.md`, then open blockers, rollback steps, runbook links, and ownership contacts are present.

#### Definition Of Done

- `tests/release/activation-and-configuration-and-activation-rollback-and-compensation.spec.ts`, replay fixtures, dashboard/runbook links, and release notes are committed.
- Accessibility, security, contract, migration, event replay, performance, and operational-readiness evidence is linked from the tracker.
- Open blockers have owner, due date, target increment, and rollback or removal criteria.

#### Negative Scenarios

- Do not mark the phase Done if event replay, reconciliation, accessibility, security, or downstream acknowledgement evidence is missing.
- Do not release `activation-and-configuration-and-activation-rollback-and-compensation` with unresolved cross-app writes, direct schema coupling, or stale source authority assumptions.
- Do not suppress failed release gates; record failures with owner, due date, and target increment.

#### Edge Cases

- Coordinated release gates may require downstream app windows; record scheduling, owner, and fallback route in release notes.
- Historical backfill, replay, bulk update, or migration repair runs must include preview, partial failure report, and rollback evidence.
- High-volume launch periods require dashboard thresholds, alert owners, queue back-pressure, and support escalation paths.

#### Test Expectations

- `tests/release/activation-and-configuration-and-activation-rollback-and-compensation.spec.ts`, `mvn test`, OpenAPI/event replay tests, Flyway checks, Playwright/Cypress E2E, accessibility, security, and k6/performance gates pass.
- `docker compose config`, clean-checkout smoke, `helm lint`, Kubernetes dry-run, dashboard JSON validation, and runbook link checks pass.
- Tracker evidence links command output, PRs, screenshots, replay payloads, dashboards, release notes, and support handoff notes.
