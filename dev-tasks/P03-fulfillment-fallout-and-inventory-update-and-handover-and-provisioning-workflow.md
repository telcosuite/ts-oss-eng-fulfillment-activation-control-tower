# Fulfillment And Activation Control Tower P03 - Fulfillment Fallout And Inventory Update And Handover And Provisioning Workflow Delivery Development Tasks

Suite: OSS Engineering, Inventory, And Fulfillment

App: Fulfillment And Activation Control Tower

App slug: `fulfillment-activation-control-tower`

Implementation repository: `ts-oss-eng-fulfillment-activation-control-tower`

Phase: P03 - Fulfillment Fallout And Inventory Update And Handover And Provisioning Workflow Delivery

Phase file: `P03-fulfillment-fallout-and-inventory-update-and-handover-and-provisioning-workflow.md`

Phase rationale: Build the Fulfillment Fallout, Inventory Update And Handover, Provisioning Workflow, Resource Order Execution capability cluster for Fulfillment And Activation Control Tower, carrying source workflows, APIs, events, tables, controls, and tests from the feature files into implementable work.

Phase exit gate: Fulfillment And Activation Control Tower can execute the Fulfillment Fallout, Inventory Update And Handover, Provisioning Workflow, Resource Order Execution workflows through UI, API, `fulfillment_activation` persistence, outbox events, audit evidence, and release tests.

Out of scope for this phase: Runtime bootstrap is in P01; unrelated feature clusters and post-launch operations remain in their own phases.

Source tracker: [development-task-tracker.md](development-task-tracker.md)

Repository strategy: [TelcoSuite Repository Strategy](../../../../repository-strategy.md)

## Phase Coverage

- [Fulfillment Fallout](../features/fulfillment-fallout.md)
- [Inventory Update And Handover](../features/inventory-update-and-handover.md)
- [Provisioning Workflow](../features/provisioning-workflow.md)
- [Resource Order Execution](../features/resource-order-execution.md)

## Phase Tasks

### DT-03-fulfillment-activation-control-tower-P03-T001: Build Fulfillment Fallout API, data model, workflow, and event spine

| Field | Value |
| --- | --- |
| Phase | P03 - Fulfillment Fallout And Inventory Update And Handover And Provisioning Workflow Delivery |
| Priority | P0 |
| Source evidence | [Fulfillment Fallout](../features/fulfillment-fallout.md), [Implementation usage](../implementation-file-usage.md), [App README](../README.md), [App overview](../../fulfillment-activation-control-tower.md), [Modules and features](../modules-and-features.md), [Personas and journeys](../personas-and-user-journeys.md), [Suite tech/UI guidance](../../tech-and-ui-guidance.md), [Suite data model](../../data-model.md), [Suite implementation guide](../../implementation-file-usage-guide.md), [Repository strategy](../../../../repository-strategy.md) |
| Feature or module | Fulfillment Fallout |
| Build area | API/Data/Event/Workflow/Security/Test |
| Target artifact | `backend/src/main/java/com/telcosuite/ossengineeringinventoryfulfillment/fulfillmentactivationcontroltower/FulfillmentFalloutController.java`, `fulfillment_activation.fulfillment_fallout`, `contracts/events/FulfillmentFalloutRaised.json`, and `/api/03-oss-engineering-inventory-fulfillment/fulfillment-activation-control-tower/v1/fulfillment-fallout` |
| Dependencies | DT-03-fulfillment-activation-control-tower-P01-T013 |
| Outputs | `FulfillmentFalloutController`, `FulfillmentFalloutService`, `fulfillment_activation.fulfillment_fallout` migration, `FulfillmentFalloutRaised` outbox schema, OpenAPI operations, unit/contract/migration/event replay tests |
| Missing evidence | No |

#### Implementation Notes

- Implement command and query APIs for `/api/03-oss-engineering-inventory-fulfillment/fulfillment-activation-control-tower/v1/fulfillment-fallout` using TMF621, TMF637, TMF638, TMF639, TMF640, TMF641, TMF646, TMF652, TMF664, TMF701, TMF702, with create, update, search, detail, lifecycle transition, timeline, evidence, and exception endpoints where the feature lifecycle requires them.
- Persist `Fulfillment Fallout` state in `fulfillment_activation.fulfillment_fallout` with tenant, brand/market, lifecycle state, source authority, idempotency key, correlation ID, actor, reason code, audit fields, and `tmf_payload` JSONB.
- Publish `FulfillmentFalloutRaised` through the transactional outbox with changed fields, replay metadata, consumer acknowledgement state, and reconciliation status for workflows: Trigger, Validation, Orchestration, Exception.
- Carry source details into code and tests for personas Fulfillment operations lead, Provisioning analyst, Activation engineer and objects Master entity, Referenced entities, Primary decisions, ODA boundary; keep cross-app references read-only unless they arrive through governed APIs/events/projections.

#### Acceptance Criteria

1. Given an authorized persona submits `POST /api/03-oss-engineering-inventory-fulfillment/fulfillment-activation-control-tower/v1/fulfillment-fallout`, when required fields and policy checks pass, then the API returns `201` with `$.state`, persists `fulfillment_activation.fulfillment_fallout.id`, and appends `FulfillmentFalloutRaised` to `fulfillment_activation.event_outbox`.
2. Given a stale, duplicate, or out-of-order request hits `PATCH /api/03-oss-engineering-inventory-fulfillment/fulfillment-activation-control-tower/v1/fulfillment-fallout/{id}`, when optimistic locking or idempotency validation fails, then the API returns `409` with `$.error.code='stale-or-duplicate-command'` and no second event is emitted.
3. Given another app needs `Fulfillment Fallout` state, when it requests data, then it receives TMF-aligned API/event/projection output and no direct database access to `fulfillment_activation.fulfillment_fallout` is required.

#### Definition Of Done

- `FulfillmentFalloutController`, service, repository, DTOs, validation, error model, and migration for `fulfillment_activation.fulfillment_fallout` are committed under `ts-oss-eng-fulfillment-activation-control-tower`.
- OpenAPI contract tests, unit tests, Flyway migration tests, event schema tests, and event replay tests cover `/api/03-oss-engineering-inventory-fulfillment/fulfillment-activation-control-tower/v1/fulfillment-fallout`, `fulfillment_activation.fulfillment_fallout`, and `FulfillmentFalloutRaised`.
- `development-task-tracker.md` records command output, source feature link, PR/evidence links, and any blocked downstream consumer.

#### Negative Scenarios

- Unauthorized, cross-tenant, or wrong-purpose requests to `/api/03-oss-engineering-inventory-fulfillment/fulfillment-activation-control-tower/v1/fulfillment-fallout` return `403` and write a denial audit row instead of exposing `Fulfillment Fallout` data.
- Missing source authority, stale dependency state, invalid lifecycle transition, or failed policy decision keeps `fulfillment_activation.fulfillment_fallout` in blocked/exception state with owner and due date.
- Downstream outage or consumer rejection queues retry/replay for `FulfillmentFalloutRaised` and prevents silent completion.

#### Edge Cases

- Bulk or project-scale updates to `Fulfillment Fallout` use preview, partial-failure reporting, idempotency keys, rollback/repair notes, and async export where needed.
- Historical correction preserves previous `fulfillment_activation.fulfillment_fallout` values, audit reason, source timestamp, actor, and downstream recalculation/replay instructions.
- Multi-tenant, market, residency, localization, and high-volume queue cases include pagination, back-pressure, circuit breaker, and replay controls.

#### Test Expectations

- `mvn test` covers `FulfillmentFalloutService`, validation, authorization, idempotency, and lifecycle transition rules.
- OpenAPI contract tests call `POST/GET/PATCH /api/03-oss-engineering-inventory-fulfillment/fulfillment-activation-control-tower/v1/fulfillment-fallout` and verify `$.state`, `$.id`, error payloads, and pagination/filter behavior.
- Flyway migration tests verify `fulfillment_activation.fulfillment_fallout` columns and indexes; event replay tests validate `contracts/events/FulfillmentFalloutRaised.json` and `fulfillment_activation.event_outbox` ordering.

### DT-03-fulfillment-activation-control-tower-P03-T002: Build Fulfillment Fallout workbench, controls, observability, and release tests

| Field | Value |
| --- | --- |
| Phase | P03 - Fulfillment Fallout And Inventory Update And Handover And Provisioning Workflow Delivery |
| Priority | P1 |
| Source evidence | [Fulfillment Fallout](../features/fulfillment-fallout.md), [Implementation usage](../implementation-file-usage.md), [App README](../README.md), [App overview](../../fulfillment-activation-control-tower.md), [Modules and features](../modules-and-features.md), [Personas and journeys](../personas-and-user-journeys.md), [Suite tech/UI guidance](../../tech-and-ui-guidance.md), [Suite data model](../../data-model.md), [Suite implementation guide](../../implementation-file-usage-guide.md), [Repository strategy](../../../../repository-strategy.md) |
| Feature or module | Fulfillment Fallout |
| Build area | UI/Security/Ops/Test |
| Target artifact | `frontend/src/app/pages/fulfillment-fallout/`, `tests/e2e/fulfillment-fallout.spec.ts`, Grafana panel `fulfillment-fallout`, and `docs/operations-runbook.md#fulfillment-fallout` |
| Dependencies | DT-03-fulfillment-activation-control-tower-P03-T001 |
| Outputs | Angular workbench, queue/detail/timeline/evidence panels, role-aware guards, accessibility states, E2E tests, dashboard JSON, alert rules, runbook section |
| Missing evidence | No |

#### Implementation Notes

- Create `frontend/src/app/pages/fulfillment-fallout/` with search/intake, detail, lifecycle timeline, exception queue, evidence drawer, dependency freshness panel, and allowed-next-action controls for personas Fulfillment operations lead, Provisioning analyst, Activation engineer.
- Wire route guards, tenant/brand/market context, masking, no-permission states, keyboard navigation, PrimeNG table/form patterns, and saved filters using `ts-shared-ui-design-system`.
- Add dashboard metrics and runbook steps for workflows Trigger, Validation, Orchestration, Exception, event replay backlog, queue aging, policy denials, consumer lag, and completion quality.

#### Acceptance Criteria

1. Given an authorized persona opens `/app/fulfillment-activation-control-tower/fulfillment-fallout`, when records exist, then the workbench returns `$.uiState='ready'` and renders `Fulfillment Fallout` rows with lifecycle state, owner, freshness, SLA/OLA timer, and action menu.
2. Given the persona lacks permission, when the same route loads, then the UI shows a no-permission state and the backend returns `403` with `$.error.code='access-denied'`.
3. Given replay backlog or queue aging exceeds threshold, when Grafana dashboard `fulfillment-fallout` refreshes, then it shows the metric and links to `docs/operations-runbook.md#fulfillment-fallout`.

#### Definition Of Done

- `frontend/src/app/pages/fulfillment-fallout/` includes route, component, service, state, fixtures, empty/loading/error/no-permission states, and accessibility labels.
- `tests/e2e/fulfillment-fallout.spec.ts`, accessibility checks, security tests, dashboard checks, and runbook review pass and are linked from the tracker.
- `development-task-tracker.md` captures screenshots, command output, PR links, dashboard/runbook links, and unresolved blockers.

#### Negative Scenarios

- Do not render `Fulfillment Fallout` details across tenant/residency boundaries; masked values stay masked in table, detail, export, timeline, and dashboard paths.
- Do not close UI actions when backend validation, event publication, reconciliation, or required evidence is incomplete.
- Do not hide downstream outage, stale source data, policy denial, or manual override behind a generic success toast.

#### Edge Cases

- Mobile or constrained layouts for `Fulfillment Fallout` collapse tables into accessible cards without losing lifecycle, owner, SLA/OLA, or evidence fields.
- Bulk/replay actions require preview, explicit confirmation, partial-failure details, rollback/repair notes, and operator evidence.
- High-volume dashboard and queue views use pagination, saved filters, async export, trace IDs, and back-pressure indicators.

#### Test Expectations

- `npm run lint`, `npm test`, and `tests/e2e/fulfillment-fallout.spec.ts` validate route, forms, guards, workbench states, and API integration.
- Accessibility tests cover keyboard navigation, focus order, screen-reader labels, color contrast, density, and responsive layout.
- Operational-readiness tests validate Grafana dashboard JSON, alert rules, event replay panel, runbook links, and release evidence.

### DT-03-fulfillment-activation-control-tower-P03-T003: Build Inventory Update And Handover API, data model, workflow, and event spine

| Field | Value |
| --- | --- |
| Phase | P03 - Fulfillment Fallout And Inventory Update And Handover And Provisioning Workflow Delivery |
| Priority | P0 |
| Source evidence | [Inventory Update And Handover](../features/inventory-update-and-handover.md), [Implementation usage](../implementation-file-usage.md), [App README](../README.md), [App overview](../../fulfillment-activation-control-tower.md), [Modules and features](../modules-and-features.md), [Personas and journeys](../personas-and-user-journeys.md), [Suite tech/UI guidance](../../tech-and-ui-guidance.md), [Suite data model](../../data-model.md), [Suite implementation guide](../../implementation-file-usage-guide.md), [Repository strategy](../../../../repository-strategy.md) |
| Feature or module | Inventory Update And Handover |
| Build area | API/Data/Event/Workflow/Security/Test |
| Target artifact | `backend/src/main/java/com/telcosuite/ossengineeringinventoryfulfillment/fulfillmentactivationcontroltower/InventoryUpdateAndHandoverController.java`, `fulfillment_activation.inventory_update_and_handover`, `contracts/events/InventoryHandoverRejected.json`, and `/api/03-oss-engineering-inventory-fulfillment/fulfillment-activation-control-tower/v1/inventory-update-and-handover` |
| Dependencies | DT-03-fulfillment-activation-control-tower-P03-T001 |
| Outputs | `InventoryUpdateAndHandoverController`, `InventoryUpdateAndHandoverService`, `fulfillment_activation.inventory_update_and_handover` migration, `InventoryHandoverRejected` outbox schema, OpenAPI operations, unit/contract/migration/event replay tests |
| Missing evidence | No |

#### Implementation Notes

- Implement command and query APIs for `/api/03-oss-engineering-inventory-fulfillment/fulfillment-activation-control-tower/v1/inventory-update-and-handover` using TMF621, TMF637, TMF638, TMF639, TMF640, TMF641, TMF652, TMF664, TMF701, TMF702, with create, update, search, detail, lifecycle transition, timeline, evidence, and exception endpoints where the feature lifecycle requires them.
- Persist `Inventory Update And Handover` state in `fulfillment_activation.inventory_update_and_handover` with tenant, brand/market, lifecycle state, source authority, idempotency key, correlation ID, actor, reason code, audit fields, and `tmf_payload` JSONB.
- Publish `InventoryHandoverRejected` through the transactional outbox with changed fields, replay metadata, consumer acknowledgement state, and reconciliation status for workflows: Trigger, Validation, Orchestration, Exception.
- Carry source details into code and tests for personas Fulfillment operations lead, Provisioning analyst, Activation engineer and objects Master entity, Referenced entities, Primary decisions, ODA boundary; keep cross-app references read-only unless they arrive through governed APIs/events/projections.

#### Acceptance Criteria

1. Given an authorized persona submits `POST /api/03-oss-engineering-inventory-fulfillment/fulfillment-activation-control-tower/v1/inventory-update-and-handover`, when required fields and policy checks pass, then the API returns `201` with `$.state`, persists `fulfillment_activation.inventory_update_and_handover.id`, and appends `InventoryHandoverRejected` to `fulfillment_activation.event_outbox`.
2. Given a stale, duplicate, or out-of-order request hits `PATCH /api/03-oss-engineering-inventory-fulfillment/fulfillment-activation-control-tower/v1/inventory-update-and-handover/{id}`, when optimistic locking or idempotency validation fails, then the API returns `409` with `$.error.code='stale-or-duplicate-command'` and no second event is emitted.
3. Given another app needs `Inventory Update And Handover` state, when it requests data, then it receives TMF-aligned API/event/projection output and no direct database access to `fulfillment_activation.inventory_update_and_handover` is required.

#### Definition Of Done

- `InventoryUpdateAndHandoverController`, service, repository, DTOs, validation, error model, and migration for `fulfillment_activation.inventory_update_and_handover` are committed under `ts-oss-eng-fulfillment-activation-control-tower`.
- OpenAPI contract tests, unit tests, Flyway migration tests, event schema tests, and event replay tests cover `/api/03-oss-engineering-inventory-fulfillment/fulfillment-activation-control-tower/v1/inventory-update-and-handover`, `fulfillment_activation.inventory_update_and_handover`, and `InventoryHandoverRejected`.
- `development-task-tracker.md` records command output, source feature link, PR/evidence links, and any blocked downstream consumer.

#### Negative Scenarios

- Unauthorized, cross-tenant, or wrong-purpose requests to `/api/03-oss-engineering-inventory-fulfillment/fulfillment-activation-control-tower/v1/inventory-update-and-handover` return `403` and write a denial audit row instead of exposing `Inventory Update And Handover` data.
- Missing source authority, stale dependency state, invalid lifecycle transition, or failed policy decision keeps `fulfillment_activation.inventory_update_and_handover` in blocked/exception state with owner and due date.
- Downstream outage or consumer rejection queues retry/replay for `InventoryHandoverRejected` and prevents silent completion.

#### Edge Cases

- Bulk or project-scale updates to `Inventory Update And Handover` use preview, partial-failure reporting, idempotency keys, rollback/repair notes, and async export where needed.
- Historical correction preserves previous `fulfillment_activation.inventory_update_and_handover` values, audit reason, source timestamp, actor, and downstream recalculation/replay instructions.
- Multi-tenant, market, residency, localization, and high-volume queue cases include pagination, back-pressure, circuit breaker, and replay controls.

#### Test Expectations

- `mvn test` covers `InventoryUpdateAndHandoverService`, validation, authorization, idempotency, and lifecycle transition rules.
- OpenAPI contract tests call `POST/GET/PATCH /api/03-oss-engineering-inventory-fulfillment/fulfillment-activation-control-tower/v1/inventory-update-and-handover` and verify `$.state`, `$.id`, error payloads, and pagination/filter behavior.
- Flyway migration tests verify `fulfillment_activation.inventory_update_and_handover` columns and indexes; event replay tests validate `contracts/events/InventoryHandoverRejected.json` and `fulfillment_activation.event_outbox` ordering.

### DT-03-fulfillment-activation-control-tower-P03-T004: Build Inventory Update And Handover workbench, controls, observability, and release tests

| Field | Value |
| --- | --- |
| Phase | P03 - Fulfillment Fallout And Inventory Update And Handover And Provisioning Workflow Delivery |
| Priority | P1 |
| Source evidence | [Inventory Update And Handover](../features/inventory-update-and-handover.md), [Implementation usage](../implementation-file-usage.md), [App README](../README.md), [App overview](../../fulfillment-activation-control-tower.md), [Modules and features](../modules-and-features.md), [Personas and journeys](../personas-and-user-journeys.md), [Suite tech/UI guidance](../../tech-and-ui-guidance.md), [Suite data model](../../data-model.md), [Suite implementation guide](../../implementation-file-usage-guide.md), [Repository strategy](../../../../repository-strategy.md) |
| Feature or module | Inventory Update And Handover |
| Build area | UI/Security/Ops/Test |
| Target artifact | `frontend/src/app/pages/inventory-update-and-handover/`, `tests/e2e/inventory-update-and-handover.spec.ts`, Grafana panel `inventory-update-and-handover`, and `docs/operations-runbook.md#inventory-update-and-handover` |
| Dependencies | DT-03-fulfillment-activation-control-tower-P03-T003 |
| Outputs | Angular workbench, queue/detail/timeline/evidence panels, role-aware guards, accessibility states, E2E tests, dashboard JSON, alert rules, runbook section |
| Missing evidence | No |

#### Implementation Notes

- Create `frontend/src/app/pages/inventory-update-and-handover/` with search/intake, detail, lifecycle timeline, exception queue, evidence drawer, dependency freshness panel, and allowed-next-action controls for personas Fulfillment operations lead, Provisioning analyst, Activation engineer.
- Wire route guards, tenant/brand/market context, masking, no-permission states, keyboard navigation, PrimeNG table/form patterns, and saved filters using `ts-shared-ui-design-system`.
- Add dashboard metrics and runbook steps for workflows Trigger, Validation, Orchestration, Exception, event replay backlog, queue aging, policy denials, consumer lag, and completion quality.

#### Acceptance Criteria

1. Given an authorized persona opens `/app/fulfillment-activation-control-tower/inventory-update-and-handover`, when records exist, then the workbench returns `$.uiState='ready'` and renders `Inventory Update And Handover` rows with lifecycle state, owner, freshness, SLA/OLA timer, and action menu.
2. Given the persona lacks permission, when the same route loads, then the UI shows a no-permission state and the backend returns `403` with `$.error.code='access-denied'`.
3. Given replay backlog or queue aging exceeds threshold, when Grafana dashboard `inventory-update-and-handover` refreshes, then it shows the metric and links to `docs/operations-runbook.md#inventory-update-and-handover`.

#### Definition Of Done

- `frontend/src/app/pages/inventory-update-and-handover/` includes route, component, service, state, fixtures, empty/loading/error/no-permission states, and accessibility labels.
- `tests/e2e/inventory-update-and-handover.spec.ts`, accessibility checks, security tests, dashboard checks, and runbook review pass and are linked from the tracker.
- `development-task-tracker.md` captures screenshots, command output, PR links, dashboard/runbook links, and unresolved blockers.

#### Negative Scenarios

- Do not render `Inventory Update And Handover` details across tenant/residency boundaries; masked values stay masked in table, detail, export, timeline, and dashboard paths.
- Do not close UI actions when backend validation, event publication, reconciliation, or required evidence is incomplete.
- Do not hide downstream outage, stale source data, policy denial, or manual override behind a generic success toast.

#### Edge Cases

- Mobile or constrained layouts for `Inventory Update And Handover` collapse tables into accessible cards without losing lifecycle, owner, SLA/OLA, or evidence fields.
- Bulk/replay actions require preview, explicit confirmation, partial-failure details, rollback/repair notes, and operator evidence.
- High-volume dashboard and queue views use pagination, saved filters, async export, trace IDs, and back-pressure indicators.

#### Test Expectations

- `npm run lint`, `npm test`, and `tests/e2e/inventory-update-and-handover.spec.ts` validate route, forms, guards, workbench states, and API integration.
- Accessibility tests cover keyboard navigation, focus order, screen-reader labels, color contrast, density, and responsive layout.
- Operational-readiness tests validate Grafana dashboard JSON, alert rules, event replay panel, runbook links, and release evidence.

### DT-03-fulfillment-activation-control-tower-P03-T005: Build Provisioning Workflow API, data model, workflow, and event spine

| Field | Value |
| --- | --- |
| Phase | P03 - Fulfillment Fallout And Inventory Update And Handover And Provisioning Workflow Delivery |
| Priority | P0 |
| Source evidence | [Provisioning Workflow](../features/provisioning-workflow.md), [Implementation usage](../implementation-file-usage.md), [App README](../README.md), [App overview](../../fulfillment-activation-control-tower.md), [Modules and features](../modules-and-features.md), [Personas and journeys](../personas-and-user-journeys.md), [Suite tech/UI guidance](../../tech-and-ui-guidance.md), [Suite data model](../../data-model.md), [Suite implementation guide](../../implementation-file-usage-guide.md), [Repository strategy](../../../../repository-strategy.md) |
| Feature or module | Provisioning Workflow |
| Build area | API/Data/Event/Workflow/Security/Test |
| Target artifact | `backend/src/main/java/com/telcosuite/ossengineeringinventoryfulfillment/fulfillmentactivationcontroltower/ProvisioningWorkflowController.java`, `fulfillment_activation.provisioning_workflow`, `contracts/events/ProvisioningTaskBlocked.json`, and `/api/03-oss-engineering-inventory-fulfillment/fulfillment-activation-control-tower/v1/provisioning-workflow` |
| Dependencies | DT-03-fulfillment-activation-control-tower-P03-T003 |
| Outputs | `ProvisioningWorkflowController`, `ProvisioningWorkflowService`, `fulfillment_activation.provisioning_workflow` migration, `ProvisioningTaskBlocked` outbox schema, OpenAPI operations, unit/contract/migration/event replay tests |
| Missing evidence | No |

#### Implementation Notes

- Implement command and query APIs for `/api/03-oss-engineering-inventory-fulfillment/fulfillment-activation-control-tower/v1/provisioning-workflow` using TMF621, TMF637, TMF638, TMF639, TMF640, TMF641, TMF646, TMF652, TMF664, TMF684, TMF700, TMF701, TMF702, with create, update, search, detail, lifecycle transition, timeline, evidence, and exception endpoints where the feature lifecycle requires them.
- Persist `Provisioning Workflow` state in `fulfillment_activation.provisioning_workflow` with tenant, brand/market, lifecycle state, source authority, idempotency key, correlation ID, actor, reason code, audit fields, and `tmf_payload` JSONB.
- Publish `ProvisioningTaskBlocked` through the transactional outbox with changed fields, replay metadata, consumer acknowledgement state, and reconciliation status for workflows: Trigger, Validation, Orchestration, Exception.
- Carry source details into code and tests for personas Fulfillment operations lead, Provisioning analyst, Activation engineer and objects Master entity, Referenced entities, Primary decisions, ODA boundary; keep cross-app references read-only unless they arrive through governed APIs/events/projections.

#### Acceptance Criteria

1. Given an authorized persona submits `POST /api/03-oss-engineering-inventory-fulfillment/fulfillment-activation-control-tower/v1/provisioning-workflow`, when required fields and policy checks pass, then the API returns `201` with `$.state`, persists `fulfillment_activation.provisioning_workflow.id`, and appends `ProvisioningTaskBlocked` to `fulfillment_activation.event_outbox`.
2. Given a stale, duplicate, or out-of-order request hits `PATCH /api/03-oss-engineering-inventory-fulfillment/fulfillment-activation-control-tower/v1/provisioning-workflow/{id}`, when optimistic locking or idempotency validation fails, then the API returns `409` with `$.error.code='stale-or-duplicate-command'` and no second event is emitted.
3. Given another app needs `Provisioning Workflow` state, when it requests data, then it receives TMF-aligned API/event/projection output and no direct database access to `fulfillment_activation.provisioning_workflow` is required.

#### Definition Of Done

- `ProvisioningWorkflowController`, service, repository, DTOs, validation, error model, and migration for `fulfillment_activation.provisioning_workflow` are committed under `ts-oss-eng-fulfillment-activation-control-tower`.
- OpenAPI contract tests, unit tests, Flyway migration tests, event schema tests, and event replay tests cover `/api/03-oss-engineering-inventory-fulfillment/fulfillment-activation-control-tower/v1/provisioning-workflow`, `fulfillment_activation.provisioning_workflow`, and `ProvisioningTaskBlocked`.
- `development-task-tracker.md` records command output, source feature link, PR/evidence links, and any blocked downstream consumer.

#### Negative Scenarios

- Unauthorized, cross-tenant, or wrong-purpose requests to `/api/03-oss-engineering-inventory-fulfillment/fulfillment-activation-control-tower/v1/provisioning-workflow` return `403` and write a denial audit row instead of exposing `Provisioning Workflow` data.
- Missing source authority, stale dependency state, invalid lifecycle transition, or failed policy decision keeps `fulfillment_activation.provisioning_workflow` in blocked/exception state with owner and due date.
- Downstream outage or consumer rejection queues retry/replay for `ProvisioningTaskBlocked` and prevents silent completion.

#### Edge Cases

- Bulk or project-scale updates to `Provisioning Workflow` use preview, partial-failure reporting, idempotency keys, rollback/repair notes, and async export where needed.
- Historical correction preserves previous `fulfillment_activation.provisioning_workflow` values, audit reason, source timestamp, actor, and downstream recalculation/replay instructions.
- Multi-tenant, market, residency, localization, and high-volume queue cases include pagination, back-pressure, circuit breaker, and replay controls.

#### Test Expectations

- `mvn test` covers `ProvisioningWorkflowService`, validation, authorization, idempotency, and lifecycle transition rules.
- OpenAPI contract tests call `POST/GET/PATCH /api/03-oss-engineering-inventory-fulfillment/fulfillment-activation-control-tower/v1/provisioning-workflow` and verify `$.state`, `$.id`, error payloads, and pagination/filter behavior.
- Flyway migration tests verify `fulfillment_activation.provisioning_workflow` columns and indexes; event replay tests validate `contracts/events/ProvisioningTaskBlocked.json` and `fulfillment_activation.event_outbox` ordering.

### DT-03-fulfillment-activation-control-tower-P03-T006: Build Provisioning Workflow workbench, controls, observability, and release tests

| Field | Value |
| --- | --- |
| Phase | P03 - Fulfillment Fallout And Inventory Update And Handover And Provisioning Workflow Delivery |
| Priority | P1 |
| Source evidence | [Provisioning Workflow](../features/provisioning-workflow.md), [Implementation usage](../implementation-file-usage.md), [App README](../README.md), [App overview](../../fulfillment-activation-control-tower.md), [Modules and features](../modules-and-features.md), [Personas and journeys](../personas-and-user-journeys.md), [Suite tech/UI guidance](../../tech-and-ui-guidance.md), [Suite data model](../../data-model.md), [Suite implementation guide](../../implementation-file-usage-guide.md), [Repository strategy](../../../../repository-strategy.md) |
| Feature or module | Provisioning Workflow |
| Build area | UI/Security/Ops/Test |
| Target artifact | `frontend/src/app/pages/provisioning-workflow/`, `tests/e2e/provisioning-workflow.spec.ts`, Grafana panel `provisioning-workflow`, and `docs/operations-runbook.md#provisioning-workflow` |
| Dependencies | DT-03-fulfillment-activation-control-tower-P03-T005 |
| Outputs | Angular workbench, queue/detail/timeline/evidence panels, role-aware guards, accessibility states, E2E tests, dashboard JSON, alert rules, runbook section |
| Missing evidence | No |

#### Implementation Notes

- Create `frontend/src/app/pages/provisioning-workflow/` with search/intake, detail, lifecycle timeline, exception queue, evidence drawer, dependency freshness panel, and allowed-next-action controls for personas Fulfillment operations lead, Provisioning analyst, Activation engineer.
- Wire route guards, tenant/brand/market context, masking, no-permission states, keyboard navigation, PrimeNG table/form patterns, and saved filters using `ts-shared-ui-design-system`.
- Add dashboard metrics and runbook steps for workflows Trigger, Validation, Orchestration, Exception, event replay backlog, queue aging, policy denials, consumer lag, and completion quality.

#### Acceptance Criteria

1. Given an authorized persona opens `/app/fulfillment-activation-control-tower/provisioning-workflow`, when records exist, then the workbench returns `$.uiState='ready'` and renders `Provisioning Workflow` rows with lifecycle state, owner, freshness, SLA/OLA timer, and action menu.
2. Given the persona lacks permission, when the same route loads, then the UI shows a no-permission state and the backend returns `403` with `$.error.code='access-denied'`.
3. Given replay backlog or queue aging exceeds threshold, when Grafana dashboard `provisioning-workflow` refreshes, then it shows the metric and links to `docs/operations-runbook.md#provisioning-workflow`.

#### Definition Of Done

- `frontend/src/app/pages/provisioning-workflow/` includes route, component, service, state, fixtures, empty/loading/error/no-permission states, and accessibility labels.
- `tests/e2e/provisioning-workflow.spec.ts`, accessibility checks, security tests, dashboard checks, and runbook review pass and are linked from the tracker.
- `development-task-tracker.md` captures screenshots, command output, PR links, dashboard/runbook links, and unresolved blockers.

#### Negative Scenarios

- Do not render `Provisioning Workflow` details across tenant/residency boundaries; masked values stay masked in table, detail, export, timeline, and dashboard paths.
- Do not close UI actions when backend validation, event publication, reconciliation, or required evidence is incomplete.
- Do not hide downstream outage, stale source data, policy denial, or manual override behind a generic success toast.

#### Edge Cases

- Mobile or constrained layouts for `Provisioning Workflow` collapse tables into accessible cards without losing lifecycle, owner, SLA/OLA, or evidence fields.
- Bulk/replay actions require preview, explicit confirmation, partial-failure details, rollback/repair notes, and operator evidence.
- High-volume dashboard and queue views use pagination, saved filters, async export, trace IDs, and back-pressure indicators.

#### Test Expectations

- `npm run lint`, `npm test`, and `tests/e2e/provisioning-workflow.spec.ts` validate route, forms, guards, workbench states, and API integration.
- Accessibility tests cover keyboard navigation, focus order, screen-reader labels, color contrast, density, and responsive layout.
- Operational-readiness tests validate Grafana dashboard JSON, alert rules, event replay panel, runbook links, and release evidence.

### DT-03-fulfillment-activation-control-tower-P03-T007: Build Resource Order Execution API, data model, workflow, and event spine

| Field | Value |
| --- | --- |
| Phase | P03 - Fulfillment Fallout And Inventory Update And Handover And Provisioning Workflow Delivery |
| Priority | P0 |
| Source evidence | [Resource Order Execution](../features/resource-order-execution.md), [Implementation usage](../implementation-file-usage.md), [App README](../README.md), [App overview](../../fulfillment-activation-control-tower.md), [Modules and features](../modules-and-features.md), [Personas and journeys](../personas-and-user-journeys.md), [Suite tech/UI guidance](../../tech-and-ui-guidance.md), [Suite data model](../../data-model.md), [Suite implementation guide](../../implementation-file-usage-guide.md), [Repository strategy](../../../../repository-strategy.md) |
| Feature or module | Resource Order Execution |
| Build area | API/Data/Event/Workflow/Security/Test |
| Target artifact | `backend/src/main/java/com/telcosuite/ossengineeringinventoryfulfillment/fulfillmentactivationcontroltower/ResourceOrderExecutionController.java`, `fulfillment_activation.resource_order_execution`, `contracts/events/ResourceAssignmentRequested.json`, and `/api/03-oss-engineering-inventory-fulfillment/fulfillment-activation-control-tower/v1/resource-order-execution` |
| Dependencies | DT-03-fulfillment-activation-control-tower-P03-T005 |
| Outputs | `ResourceOrderExecutionController`, `ResourceOrderExecutionService`, `fulfillment_activation.resource_order_execution` migration, `ResourceAssignmentRequested` outbox schema, OpenAPI operations, unit/contract/migration/event replay tests |
| Missing evidence | No |

#### Implementation Notes

- Implement command and query APIs for `/api/03-oss-engineering-inventory-fulfillment/fulfillment-activation-control-tower/v1/resource-order-execution` using TMF621, TMF637, TMF638, TMF639, TMF640, TMF641, TMF652, TMF664, TMF684, TMF685, TMF697, TMF701, TMF702, TMF716, with create, update, search, detail, lifecycle transition, timeline, evidence, and exception endpoints where the feature lifecycle requires them.
- Persist `Resource Order Execution` state in `fulfillment_activation.resource_order_execution` with tenant, brand/market, lifecycle state, source authority, idempotency key, correlation ID, actor, reason code, audit fields, and `tmf_payload` JSONB.
- Publish `ResourceAssignmentRequested` through the transactional outbox with changed fields, replay metadata, consumer acknowledgement state, and reconciliation status for workflows: Trigger, Validation, Orchestration, Exception.
- Carry source details into code and tests for personas Fulfillment operations lead, Provisioning analyst, Activation engineer and objects Master entity, Referenced entities, Primary decisions, ODA boundary; keep cross-app references read-only unless they arrive through governed APIs/events/projections.

#### Acceptance Criteria

1. Given an authorized persona submits `POST /api/03-oss-engineering-inventory-fulfillment/fulfillment-activation-control-tower/v1/resource-order-execution`, when required fields and policy checks pass, then the API returns `201` with `$.state`, persists `fulfillment_activation.resource_order_execution.id`, and appends `ResourceAssignmentRequested` to `fulfillment_activation.event_outbox`.
2. Given a stale, duplicate, or out-of-order request hits `PATCH /api/03-oss-engineering-inventory-fulfillment/fulfillment-activation-control-tower/v1/resource-order-execution/{id}`, when optimistic locking or idempotency validation fails, then the API returns `409` with `$.error.code='stale-or-duplicate-command'` and no second event is emitted.
3. Given another app needs `Resource Order Execution` state, when it requests data, then it receives TMF-aligned API/event/projection output and no direct database access to `fulfillment_activation.resource_order_execution` is required.

#### Definition Of Done

- `ResourceOrderExecutionController`, service, repository, DTOs, validation, error model, and migration for `fulfillment_activation.resource_order_execution` are committed under `ts-oss-eng-fulfillment-activation-control-tower`.
- OpenAPI contract tests, unit tests, Flyway migration tests, event schema tests, and event replay tests cover `/api/03-oss-engineering-inventory-fulfillment/fulfillment-activation-control-tower/v1/resource-order-execution`, `fulfillment_activation.resource_order_execution`, and `ResourceAssignmentRequested`.
- `development-task-tracker.md` records command output, source feature link, PR/evidence links, and any blocked downstream consumer.

#### Negative Scenarios

- Unauthorized, cross-tenant, or wrong-purpose requests to `/api/03-oss-engineering-inventory-fulfillment/fulfillment-activation-control-tower/v1/resource-order-execution` return `403` and write a denial audit row instead of exposing `Resource Order Execution` data.
- Missing source authority, stale dependency state, invalid lifecycle transition, or failed policy decision keeps `fulfillment_activation.resource_order_execution` in blocked/exception state with owner and due date.
- Downstream outage or consumer rejection queues retry/replay for `ResourceAssignmentRequested` and prevents silent completion.

#### Edge Cases

- Bulk or project-scale updates to `Resource Order Execution` use preview, partial-failure reporting, idempotency keys, rollback/repair notes, and async export where needed.
- Historical correction preserves previous `fulfillment_activation.resource_order_execution` values, audit reason, source timestamp, actor, and downstream recalculation/replay instructions.
- Multi-tenant, market, residency, localization, and high-volume queue cases include pagination, back-pressure, circuit breaker, and replay controls.

#### Test Expectations

- `mvn test` covers `ResourceOrderExecutionService`, validation, authorization, idempotency, and lifecycle transition rules.
- OpenAPI contract tests call `POST/GET/PATCH /api/03-oss-engineering-inventory-fulfillment/fulfillment-activation-control-tower/v1/resource-order-execution` and verify `$.state`, `$.id`, error payloads, and pagination/filter behavior.
- Flyway migration tests verify `fulfillment_activation.resource_order_execution` columns and indexes; event replay tests validate `contracts/events/ResourceAssignmentRequested.json` and `fulfillment_activation.event_outbox` ordering.

### DT-03-fulfillment-activation-control-tower-P03-T008: Build Resource Order Execution workbench, controls, observability, and release tests

| Field | Value |
| --- | --- |
| Phase | P03 - Fulfillment Fallout And Inventory Update And Handover And Provisioning Workflow Delivery |
| Priority | P1 |
| Source evidence | [Resource Order Execution](../features/resource-order-execution.md), [Implementation usage](../implementation-file-usage.md), [App README](../README.md), [App overview](../../fulfillment-activation-control-tower.md), [Modules and features](../modules-and-features.md), [Personas and journeys](../personas-and-user-journeys.md), [Suite tech/UI guidance](../../tech-and-ui-guidance.md), [Suite data model](../../data-model.md), [Suite implementation guide](../../implementation-file-usage-guide.md), [Repository strategy](../../../../repository-strategy.md) |
| Feature or module | Resource Order Execution |
| Build area | UI/Security/Ops/Test |
| Target artifact | `frontend/src/app/pages/resource-order-execution/`, `tests/e2e/resource-order-execution.spec.ts`, Grafana panel `resource-order-execution`, and `docs/operations-runbook.md#resource-order-execution` |
| Dependencies | DT-03-fulfillment-activation-control-tower-P03-T007 |
| Outputs | Angular workbench, queue/detail/timeline/evidence panels, role-aware guards, accessibility states, E2E tests, dashboard JSON, alert rules, runbook section |
| Missing evidence | No |

#### Implementation Notes

- Create `frontend/src/app/pages/resource-order-execution/` with search/intake, detail, lifecycle timeline, exception queue, evidence drawer, dependency freshness panel, and allowed-next-action controls for personas Fulfillment operations lead, Provisioning analyst, Activation engineer.
- Wire route guards, tenant/brand/market context, masking, no-permission states, keyboard navigation, PrimeNG table/form patterns, and saved filters using `ts-shared-ui-design-system`.
- Add dashboard metrics and runbook steps for workflows Trigger, Validation, Orchestration, Exception, event replay backlog, queue aging, policy denials, consumer lag, and completion quality.

#### Acceptance Criteria

1. Given an authorized persona opens `/app/fulfillment-activation-control-tower/resource-order-execution`, when records exist, then the workbench returns `$.uiState='ready'` and renders `Resource Order Execution` rows with lifecycle state, owner, freshness, SLA/OLA timer, and action menu.
2. Given the persona lacks permission, when the same route loads, then the UI shows a no-permission state and the backend returns `403` with `$.error.code='access-denied'`.
3. Given replay backlog or queue aging exceeds threshold, when Grafana dashboard `resource-order-execution` refreshes, then it shows the metric and links to `docs/operations-runbook.md#resource-order-execution`.

#### Definition Of Done

- `frontend/src/app/pages/resource-order-execution/` includes route, component, service, state, fixtures, empty/loading/error/no-permission states, and accessibility labels.
- `tests/e2e/resource-order-execution.spec.ts`, accessibility checks, security tests, dashboard checks, and runbook review pass and are linked from the tracker.
- `development-task-tracker.md` captures screenshots, command output, PR links, dashboard/runbook links, and unresolved blockers.

#### Negative Scenarios

- Do not render `Resource Order Execution` details across tenant/residency boundaries; masked values stay masked in table, detail, export, timeline, and dashboard paths.
- Do not close UI actions when backend validation, event publication, reconciliation, or required evidence is incomplete.
- Do not hide downstream outage, stale source data, policy denial, or manual override behind a generic success toast.

#### Edge Cases

- Mobile or constrained layouts for `Resource Order Execution` collapse tables into accessible cards without losing lifecycle, owner, SLA/OLA, or evidence fields.
- Bulk/replay actions require preview, explicit confirmation, partial-failure details, rollback/repair notes, and operator evidence.
- High-volume dashboard and queue views use pagination, saved filters, async export, trace IDs, and back-pressure indicators.

#### Test Expectations

- `npm run lint`, `npm test`, and `tests/e2e/resource-order-execution.spec.ts` validate route, forms, guards, workbench states, and API integration.
- Accessibility tests cover keyboard navigation, focus order, screen-reader labels, color contrast, density, and responsive layout.
- Operational-readiness tests validate Grafana dashboard JSON, alert rules, event replay panel, runbook links, and release evidence.

### DT-03-fulfillment-activation-control-tower-P03-T009: Prove Fulfillment Fallout And Inventory Update And Handover And Provisioning Workflow Delivery release gate, replay, and handoff evidence

| Field | Value |
| --- | --- |
| Phase | P03 - Fulfillment Fallout And Inventory Update And Handover And Provisioning Workflow Delivery |
| Priority | P1 |
| Source evidence | [Fulfillment Fallout](../features/fulfillment-fallout.md), [Inventory Update And Handover](../features/inventory-update-and-handover.md), [Provisioning Workflow](../features/provisioning-workflow.md), [Resource Order Execution](../features/resource-order-execution.md), [Implementation usage](../implementation-file-usage.md), [App README](../README.md), [App overview](../../fulfillment-activation-control-tower.md), [Modules and features](../modules-and-features.md), [Personas and journeys](../personas-and-user-journeys.md), [Suite tech/UI guidance](../../tech-and-ui-guidance.md), [Suite data model](../../data-model.md), [Suite implementation guide](../../implementation-file-usage-guide.md), [Repository strategy](../../../../repository-strategy.md) |
| Feature or module | Fulfillment Fallout And Inventory Update And Handover And Provisioning Workflow Delivery |
| Build area | Test/Ops/Release/Event |
| Target artifact | `tests/release/fulfillment-fallout-and-inventory-update-and-handover-and-provisioning-workflow.spec.ts`, `docs/release-notes/fulfillment-fallout-and-inventory-update-and-handover-and-provisioning-workflow.md`, Grafana dashboard `fulfillment-fallout-and-inventory-update-and-handover-and-provisioning-workflow`, and replay fixtures |
| Dependencies | DT-03-fulfillment-activation-control-tower-P03-T002, DT-03-fulfillment-activation-control-tower-P03-T004, DT-03-fulfillment-activation-control-tower-P03-T006, DT-03-fulfillment-activation-control-tower-P03-T008 |
| Outputs | Release-gate test, replay/reconciliation evidence, accessibility/security/performance reports, dashboard/runbook links, support handoff notes |
| Missing evidence | No |

#### Implementation Notes

- Create a release-gate checklist for `fulfillment-fallout-and-inventory-update-and-handover-and-provisioning-workflow` covering Fulfillment Fallout, Inventory Update And Handover, Provisioning Workflow, Resource Order Execution, with happy path, assisted path, negative path, edge cases, event replay, data reconciliation, security, accessibility, performance, and support evidence.
- Record producer and consumer acknowledgements for phase events, reconcile `fulfillment_activation.event_outbox`, and link replay fixtures and correlation IDs.
- Update `docs/operations-runbook.md`, `docs/release-notes/fulfillment-fallout-and-inventory-update-and-handover-and-provisioning-workflow.md`, and `development-task-tracker.md` with release evidence and unresolved blockers.

#### Acceptance Criteria

1. Given all tasks in `P03-fulfillment-fallout-and-inventory-update-and-handover-and-provisioning-workflow.md` are complete, when `tests/release/fulfillment-fallout-and-inventory-update-and-handover-and-provisioning-workflow.spec.ts` runs, then it returns exit code `0` and links evidence for UI, API, data, event, security, ops, and test gates.
2. Given a consumer rejects an event from `fulfillment-fallout-and-inventory-update-and-handover-and-provisioning-workflow`, when replay is triggered, then the replay fixture preserves `$.correlationId`, `$.eventId`, and consumer acknowledgement state.
3. Given release notes are generated, when support reviews `docs/release-notes/fulfillment-fallout-and-inventory-update-and-handover-and-provisioning-workflow.md`, then open blockers, rollback steps, runbook links, and ownership contacts are present.

#### Definition Of Done

- `tests/release/fulfillment-fallout-and-inventory-update-and-handover-and-provisioning-workflow.spec.ts`, replay fixtures, dashboard/runbook links, and release notes are committed.
- Accessibility, security, contract, migration, event replay, performance, and operational-readiness evidence is linked from the tracker.
- Open blockers have owner, due date, target increment, and rollback or removal criteria.

#### Negative Scenarios

- Do not mark the phase Done if event replay, reconciliation, accessibility, security, or downstream acknowledgement evidence is missing.
- Do not release `fulfillment-fallout-and-inventory-update-and-handover-and-provisioning-workflow` with unresolved cross-app writes, direct schema coupling, or stale source authority assumptions.
- Do not suppress failed release gates; record failures with owner, due date, and target increment.

#### Edge Cases

- Coordinated release gates may require downstream app windows; record scheduling, owner, and fallback route in release notes.
- Historical backfill, replay, bulk update, or migration repair runs must include preview, partial failure report, and rollback evidence.
- High-volume launch periods require dashboard thresholds, alert owners, queue back-pressure, and support escalation paths.

#### Test Expectations

- `tests/release/fulfillment-fallout-and-inventory-update-and-handover-and-provisioning-workflow.spec.ts`, `mvn test`, OpenAPI/event replay tests, Flyway checks, Playwright/Cypress E2E, accessibility, security, and k6/performance gates pass.
- `docker compose config`, clean-checkout smoke, `helm lint`, Kubernetes dry-run, dashboard JSON validation, and runbook link checks pass.
- Tracker evidence links command output, PRs, screenshots, replay payloads, dashboards, release notes, and support handoff notes.
