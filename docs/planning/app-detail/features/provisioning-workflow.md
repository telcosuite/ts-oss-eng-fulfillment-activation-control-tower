# Provisioning Workflow Feature Specification

Reviewed: 2026-06-07

Suite: OSS Engineering, Inventory, And Fulfillment

App: [Fulfillment And Activation Control Tower](../README.md)

Source module detail: [Modules And Features](../modules-and-features.md)

Source gap review: [E2E Feature Gap Assessment](../../../e2e-feature-gap-assessment.md)

Feature area slug: `provisioning-workflow`

E2E gap severity: Core

## Feature Intent

Orchestrate long-running workflows across service orders, resource orders, field tasks, shipments, reservations, activation, billing triggers, inventory updates, approvals, timers, dependencies, parallel execution, retry, cancellation, and compensation. The Provisioning Workflow feature produces a governed provisioning workflow instance outcome with dependency visibility, retry/rollback controls, customer-impact evidence, and downstream handoff for order-to-activate, MACD, partner/off-net, test-and-turn-up, and govern-to-comply journeys.

## Telecom Objects And Decision Rights

- Master entity: provisioning workflow instance. Fulfillment And Activation Control Tower owns workflow instance lifecycle, dependency graph, task state, timer/SLA state, retry policy, manual queue state, automation decision, compensation state, completion evidence, and publication events.
- Referenced entities: service orders, resource orders, product orders, reservations, assignments, activation tasks, field work, shipments, billing triggers, partner tasks, assurance tests, workflow definitions, and customer communication events. Fulfillment And Activation Control Tower consumes these through APIs, events, governed projections, workflow tasks, activation adapters, partner callbacks, or evidence packages and does not overwrite their operational masters.
- Primary decisions: start, sequence, parallelize, wait, hold, retry, escalate, cancel, compensate, resume, complete, correct, or publish provisioning workflow state. The decision records accountable persona, dependency state, automation/manual source, retry/rollback/compensation choice, customer/order impact, SLA/OLA state, and downstream handoff.
- ODA boundary: Fulfillment And Activation Control Tower keeps private service order execution, resource order execution, provisioning workflow, activation evidence, fallout, rollback/compensation, validation, and handover records; Order Management, Inventory And Topology, Field Work, Billing, Assurance, Customer, Partner, Platform, and Data apps remain masters for their own lifecycle records.

## Personas, Jobs To Be Done, And Outcomes

| Persona | Job to be done | Outcome |
| --- | --- | --- |
| Fulfillment operations lead | Monitor in-flight provisioning, SLA/OLA risk, automation rate, fallout, rollback exposure, and partner/off-net aging. | Sees accountable queues, milestone health, customer-impacting delays, and evidence needed for order-to-activate closure. |
| Provisioning analyst | Repair assignment, workflow, reservation, field, shipment, partner, and dependency exceptions. | Resolves execution issues without bypassing Inventory, Field, Order, Billing, or Partner owners. |
| Activation engineer | Execute, retry, validate, roll back, and compensate network, cloud, device, SIM/eSIM, number-port, and controller activation. | Controls privileged activation actions with command evidence, rollback plans, and post-action review. |
| Order manager | Consume fulfillment milestones, jeopardy reasons, partial activation state, and customer-visible status. | Receives reliable fulfillment status while Product Order remains mastered by Order Management Hub. |
| Inventory manager | Validate handover evidence, accepted assignment state, resource release, discrepancy, and final update outcome. | Accepts or rejects final state while Inventory And Topology remains the operational inventory master. |
| Partner/off-net coordinator | Track partner, wholesale, off-net, customer self-activation, and external dependency milestones. | Makes external delivery evidence and SLA exposure visible without mastering partner systems. |

## Core Workflows

| Stage | Telecom trigger or validation | Orchestration, exception, completion, and evidence |
| --- | --- | --- |
| Trigger | Provisioning Workflow starts from accepted service/resource order, bulk enterprise project, MACD request, field or shipment update, activation callback, partner milestone, fallout event, cancellation request, or workflow timer. | The provisioning workflow instance opens with owner, tenant, market, product/service/resource/order scope, lifecycle action, due date, source trigger, correlation ID, customer-impact flag, and required dependency references. |
| Validation | The app validates service/resource order readiness, dependency graph, reservation state, activation readiness, field/shipment state, partner/off-net dependency, billing trigger, SLA timer, retry limit, compensation path, and customer-impact flag. | Invalid provisioning workflow instance data creates readiness failures, workflow blocks, activation fallout, manual tasks, rollback tasks, partner escalations, or handover rejection before the order-to-activate journey advances. |
| Orchestration | Fulfillment And Activation Control Tower coordinates Order Management, Design Studio, Inventory, Field, Stock/Logistics, activation controllers, NMS/EMS/SDN/NFV/cloud, SIM/eSIM/device platforms, partner/off-net systems, Billing, Assurance, Customer communications, and Data consumers through APIs, events, workflow tasks, adapters, or evidence packages. | Consumers receive execution state and evidence while their own databases and lifecycle records remain private to their owning apps. |
| Exception | If any of these conditions occur - Parallel task completes after workflow cancellation, Retry exceeds limit while order promise date is at risk, Billing trigger fires before inventory handover acceptance - the workflow routes to the accountable fulfillment operations, provisioning, activation engineering, order, inventory, field, partner/off-net, data, or compliance owner. | The exception captures failed rule, affected customer/service/resource/order, SLA/OLA impact, retry/rollback/compensation option, blocked consumer, correlation ID, evidence gap, and escalation path. |
| Completion | Completion occurs when the provisioning workflow instance is completed, partially completed, failed, compensated, rolled back, handed over, accepted, rejected, cancelled, or closed with downstream acknowledgement. | Completion evidence includes execution version, command/response evidence, field/partner/test evidence where relevant, inventory handover status, customer/order/billing/assurance notification status, event IDs, and replay metadata. |

## Missing Use Cases And Scenarios

| Scenario | Required behavior |
| --- | --- |
| Greenfield activation | Provisioning Workflow must support new fiber install waits for field, shipment, activation, and test tasks with explicit provisioning workflow instance, lifecycle state, dependency state, evidence, decision owner, and downstream handoff. |
| Brownfield MACD | Provisioning Workflow must support brownfield MACD sequences disconnect and add actions with explicit provisioning workflow instance, lifecycle state, dependency state, evidence, decision owner, and downstream handoff. |
| Enterprise bulk or migration | Provisioning Workflow must support enterprise bulk project runs site waves in parallel with explicit provisioning workflow instance, lifecycle state, dependency state, evidence, decision owner, and downstream handoff. |
| Partner/off-net or customer activation | Provisioning Workflow must support partner/off-net task blocks activation until external milestone with explicit provisioning workflow instance, lifecycle state, dependency state, evidence, decision owner, and downstream handoff. |
| Partial activation, rollback, or decommissioning | Provisioning Workflow must support workflow rollback compensates completed resource task after activation failure with explicit provisioning workflow instance, lifecycle state, dependency state, evidence, decision owner, and downstream handoff. |

## Capability Slices

| Feature ID | Feature | Parent feature area | Priority guidance |
| --- | --- | --- | --- |
| F-provisioning-workflow-01 | Long-running provisioning orchestration | Provisioning Workflow | P1: required for order-to-activate execution, MACD, partner/off-net delivery, rollback, test-and-turn-up, inventory handover, or customer-visible milestone control. |
| F-provisioning-workflow-02 | Dependency graph and parallel execution | Provisioning Workflow | P1: required for order-to-activate execution, MACD, partner/off-net delivery, rollback, test-and-turn-up, inventory handover, or customer-visible milestone control. |
| F-provisioning-workflow-03 | Timer, SLA, and jeopardy tracking | Provisioning Workflow | P1: required for order-to-activate execution, MACD, partner/off-net delivery, rollback, test-and-turn-up, inventory handover, or customer-visible milestone control. |
| F-provisioning-workflow-04 | Manual queue and approval task | Provisioning Workflow | P1: required for order-to-activate execution, MACD, partner/off-net delivery, rollback, test-and-turn-up, inventory handover, or customer-visible milestone control. |
| F-provisioning-workflow-05 | Retry, cancellation, and compensation path | Provisioning Workflow | P2: required for order-to-activate execution, MACD, partner/off-net delivery, rollback, test-and-turn-up, inventory handover, or customer-visible milestone control. |
| F-provisioning-workflow-06 | Billing and inventory handoff trigger | Provisioning Workflow | P2: required for order-to-activate execution, MACD, partner/off-net delivery, rollback, test-and-turn-up, inventory handover, or customer-visible milestone control. |
| F-provisioning-workflow-07 | Workflow replay and audit | Provisioning Workflow | P2: required for order-to-activate execution, MACD, partner/off-net delivery, rollback, test-and-turn-up, inventory handover, or customer-visible milestone control. |

## Acceptance Criteria

1. **AC-provisioning-workflow-01:** Given an authorized Fulfillment operations lead, Provisioning analyst, Activation engineer, Order manager, Inventory manager, or Partner/off-net coordinator creates or updates the provisioning workflow instance, when the provisioning workflow lifecycle advances from accepted, waiting, executing, activated, failed, fallout, compensating, handover, completed, or cancelled state, then Fulfillment And Activation Control Tower validates service/resource order readiness, dependency graph, reservation state, activation readiness, field/shipment state, partner/off-net dependency, billing trigger, SLA timer, retry limit, compensation path, and customer-impact flag before accepting the state change.
2. **AC-provisioning-workflow-02:** Given the provisioning workflow instance references product order, service order, resource order, reservation, inventory, field, activation, partner, billing, assurance, or customer communication data, when a persona opens the Provisioning Workflow record, then the app shows source owner, source timestamp, freshness, dependency status, customer-impact flag, and whether the data is app-owned or read-only.
3. **AC-provisioning-workflow-03:** Given Parallel task completes after workflow cancellation, when validation fails for Provisioning Workflow, then the app keeps the execution record in waiting, blocked, fallout, retrying, compensating, or rejected state with severity, owner, due date, affected customer/service/resource/order, retry/rollback option, and correlation ID.
4. **AC-provisioning-workflow-04:** Given the provisioning workflow instance changes due to automation, manual action, controller response, field evidence, partner callback, test result, rollback, or compensation, when the transition is committed, then the app stores decision right, actor, role, reason, command/evidence links, old/new values, tenant/region boundary, and idempotency key.
5. **AC-provisioning-workflow-05:** Given Order Management, Inventory, Billing, Care, Self-Care, Assurance, Field, Partner, Data, or Platform consumers subscribe to Provisioning Workflow changes, when the provisioning workflow instance reaches milestone, fallout, rollback, handover, or completion state, then the app emits a versioned event with changed fields, impact, SLA/OLA state, replay metadata, and correlation ID.
6. **AC-provisioning-workflow-06:** Given a greenfield install, brownfield MACD, enterprise bulk order, partner/off-net delivery, automated provisioning, manual fallout, no-access, partial activation, rollback, migration, or decommissioning scenario references the provisioning workflow instance, when the user requests closure, then the app validates downstream handoffs, open fallout, inventory acceptance, customer/order/billing/assurance notification, retention, and legal hold before closure.
7. **AC-provisioning-workflow-07:** Given operations leaders review Provisioning Workflow operations, when they open dashboards, then they see volume, automation rate, activation latency, queue aging, fallout cause, rollback/compensation count, partner/off-net aging, inventory handover status, and completion quality linked to the provisioning workflow instance.

## Negative Scenarios

Negative scenarios for this feature include permission denial, missing source data, stale dependency state, policy failure, duplicate or replayed request, downstream timeout, reconciliation mismatch, and any feature-specific negative scenario additions listed in the suite gap-review closure addendum.

## Edge Cases

| Scenario | Expected behavior |
| --- | --- |
| Parallel task completes after workflow cancellation | Provisioning Workflow blocks unsafe execution or routes controlled fallout with owner, due date, affected customer/service/resource/order, retry/rollback/compensation option, and replayable evidence. |
| Retry exceeds limit while order promise date is at risk | Provisioning Workflow blocks unsafe execution or routes controlled fallout with owner, due date, affected customer/service/resource/order, retry/rollback/compensation option, and replayable evidence. |
| Billing trigger fires before inventory handover acceptance | Provisioning Workflow blocks unsafe execution or routes controlled fallout with owner, due date, affected customer/service/resource/order, retry/rollback/compensation option, and replayable evidence. |
| Manual task owner is missing or on leave | Provisioning Workflow blocks unsafe execution or routes controlled fallout with owner, due date, affected customer/service/resource/order, retry/rollback/compensation option, and replayable evidence. |
| Bulk project partial completion loses site-level state | Provisioning Workflow blocks unsafe execution or routes controlled fallout with owner, due date, affected customer/service/resource/order, retry/rollback/compensation option, and replayable evidence. |
| Duplicate, stale, or out-of-order callback | Provisioning Workflow uses optimistic locking, callback timestamp, command ID, event version, and idempotency key so retries cannot duplicate activation, fallout, handover, rollback, or completion state. |
| Cross-tenant, cross-region, or privileged activation boundary breach | Provisioning Workflow blocks action, masks restricted customer/site/topology/identifier data, and records policy decision metadata for tenant isolation, privileged access, data residency, legal hold, and export control. |
| Downstream app, partner, controller, or external adapter unavailable | Provisioning Workflow either fails fast for synchronous safety gates or queues controlled retry, replay, escalation, fallback manual task, or compensation with owner, due date, and correlation ID. |
| Retention, privacy, regulatory, or legal hold conflict | Provisioning Workflow prevents destructive correction, evidence deletion, rollback closure, or order completion until retention, lawful/regulatory evidence, legal hold, and data residency controls allow it. |

## Suite Gap Review Closure Addendum

Source review: [03 Oss Engineering Inventory Fulfillment Gap Review](../../../../suite-gap-reviews/03-oss-engineering-inventory-fulfillment-gap-review.md)

This addendum applies the suite gap-review findings tied to this feature file. It supplements the baseline feature specification and should be carried into epic, story, API, event, data, and test refinement.

### Review Backlog Items Addressed

| Severity | Gap-review item | Closure expectation |
| --- | --- | --- |
| Critical | Fulfillment saga checkpoint, rollback, and compensation model. | Add concrete happy path, negative path, edge-case, API/event/data control, reporting, and test evidence for this feature area. |

### Acceptance Criteria Additions

1. Given a fulfillment workflow reaches an irreversible step, when a downstream failure occurs, then allowed resume, repair, rollback, compensation, billing hold, inventory correction, and customer communication actions are calculated from the checkpoint state.
2. Given activation reports success, when service test, controller readback, inventory, or order state disagrees, then fulfillment remains in validation exception and no closure event is emitted.
3. Given dry-run simulation is requested, when field, stock, reservation, activation, billing, assurance, partner, or communication readiness is missing, then fulfillment start is blocked or accepted with explicit risk approval.

### Negative Scenario Additions

1. Activation succeeds but inventory update fails; hold order completion and create inventory handover retry with customer impact.
2. Partner off-net task misses milestone; update promise-date risk and notify order/customer channels.
3. Rollback command fails after partial activation; freeze further automation and route to manual remediation with audit evidence.

### API, Event, Data, And Reporting Updates

- Add or refine command/query APIs so the owning app remains the system of record and consumers do not bypass app APIs.
- Add lifecycle events for the reviewed gap, including created, validated, blocked, approved, completed, failed, corrected, replayed, and reconciliation-failed variants where applicable.
- Capture idempotency keys, correlation IDs, source freshness, lineage, confidence, policy version, owner, SLA/OLA timers, and audit evidence.
- Add dashboards or operational reports for aging, failure reason, confidence/quality, consumer impact, exception backlog, and closure proof.
- Extend the test approach with happy-path, negative, edge-case, contract, event replay, data reconciliation, security, accessibility, and operational-readiness tests for the listed review items.

## API, Event, And Data Requirements

Related APIs and API areas: [TMF701](../../../../../references/tmforum-open-apis/openapi-specs/TMF701_ProcessFlow), [TMF641](../../../../../references/tmforum-open-apis/openapi-specs/TMF641_ServiceOrder), [TMF652](../../../../../references/tmforum-open-apis/openapi-specs/TMF652_ResourceOrderManagement), [TMF646](../../../../../references/tmforum-open-apis/openapi-specs/TMF646_AppointmentManagement), [TMF700](../../../../../references/tmforum-open-apis/openapi-specs/TMF700_ShippingOrder), [TMF684](../../../../../references/tmforum-open-apis/openapi-specs/TMF684_ShipmentTracking)

TMF API fit and extension notes:

- Use TMF701 for process flow patterns and TMF641/TMF652 for service/resource order context. Use TMF646/TMF700/TMF684 as field/shipment dependency references; domain workflow state remains owned by this app even if a platform workflow engine executes tasks.
- Non-TMF Provisioning Saga API for dependency graph, timer policy, compensation state, replay, bulk project grouping, and customer-impacting jeopardy. Each extension contract must be explicitly labelled non-TMF, documented with OpenAPI, and aligned to TMF-style id, href, lifecycle state, relatedParty, relatedEntity, error, pagination, and event-envelope patterns where practical.
- Command APIs for Provisioning Workflow must cover accept/initiate, validate, start, update, hold, release, retry, escalate, cancel, roll back, compensate, test, handover, correct, replay, and close where the provisioning workflow lifecycle uses those states.
- Query APIs for Provisioning Workflow must cover search, detail, timeline, related provisioning workflow instance references, dependency graph, fallout queue, activation evidence, partner/off-net milestones, metrics, and audit/evidence retrieval with role-aware masking.
- Domain events for Provisioning Workflow must include ProvisioningWorkflowStarted, ProvisioningTaskBlocked, ProvisioningWorkflowCompensated, ProvisioningWorkflowCompleted, plus blocked, jeopardy raised, fallout raised, fallout resolved, rollback requested, compensation completed, handover requested, completion rejected, replay requested, and reconciliation failed where the lifecycle uses those states.

Data and ownership requirements:

- Fulfillment And Activation Control Tower owns workflow instance lifecycle, dependency graph, task state, timer/SLA state, retry policy, manual queue state, automation decision, compensation state, completion evidence, and publication events; other apps consume Provisioning Workflow state through APIs, events, governed projections, workflow tasks, adapters, evidence packages, or certified data products.
- Store source channel, actor, tenant/brand/market, customer/order/service/resource references, lifecycle action, status reason, due date, SLA/OLA state, command ID, external references, old/new values, policy decision, evidence links, retention class, legal hold flag, and impacted consumer list.
- Keep read projections, analytics extracts, and DWH/lakehouse outputs separate from operational writes so Provisioning Workflow does not create shadow mastership of product orders, installed inventory, field work, stock, billing, assurance tickets, customer records, partner lifecycle, or platform security records.
- Provide reconciliation outputs that prove Order Management, Inventory, Field, Billing, Care, Self-Care, Assurance, Partner, Platform, and Data consumers have accepted, rejected, or remain explicitly blocked by the provisioning workflow instance.

## Integrations And Handoffs

- Workflow And Automation Studio for reusable process infrastructure where used.
- Order Management Hub for promise-date and customer-visible milestone updates.
- Field Work/Stock/Logistics for appointment, work order, shipment, and stock tasks.
- Billing and Customer communications for triggers and status.
- Partner/off-net systems for external milestone callbacks.

## Non-Functional Requirements

- Scale and latency: Provisioning Workflow must support high-volume order-to-activate workloads with thousands of concurrent service/resource orders, activation commands, partner milestones, workflow timers, fallout cases, and handover packages; command acceptance should be low-latency while long-running orchestration, simulation, activation, test, and handover tasks expose progress, ETA, and partial-failure reports.
- Availability and resilience: execution query APIs and active queues for Provisioning Workflow must remain available during downstream order, inventory, field, billing, assurance, partner, controller, or data outages by serving last-known execution state with dependency freshness and retry status.
- Auditability and retention: Provisioning Workflow history must retain actor, channel, reason, old/new value, command/request/response, policy version, approval/waiver, event ID, external reference, customer-impact flag, legal hold flag, and retention class for activation, field, partner, regulatory, and customer evidence periods.
- Localization and accessibility: Provisioning Workflow UI tasks, fallout messages, customer/partner communication triggers, engineering units, time zones, language, keyboard navigation, and screen-reader labels must respect tenant, market, geography, and accessibility policy.
- Data protection: API, event, export, adapter, and dashboard paths for Provisioning Workflow must enforce tenant isolation, data residency, purpose limitation, least privilege, privileged activation controls, sensitive topology masking, critical-infrastructure masking, and secure evidence storage.

## Compliance, Security, And Privacy

- Provisioning Workflow must enforce tenant isolation, region boundaries, role-based execution, privileged activation approval, break-glass review where used, critical infrastructure masking, lawful/regulatory activation evidence, partner/off-net evidence controls, export controls, and data residency for the provisioning workflow instance.
- Provisioning Workflow must preserve activation command evidence, rollback evidence, field evidence, service validation evidence, partner/off-net delivery evidence, customer communication evidence, legal hold, and regulatory inventory handover evidence where execution decisions affect telecom obligations.
- Sensitive customer, enterprise, site, topology, identifier, firmware, controller, partner/off-net, and activation command references in Provisioning Workflow must be masked in search, timelines, exports, analytics, and dashboards unless the persona has a permitted operational purpose.

## Observability And Operations

- Metrics: track provisioning-workflow records accepted, started, waiting, automated, manually handled, activated, failed, retried, rolled back, compensated, handed over, rejected, completed, and replayed, plus activation latency, queue aging, fallout rate, rollback rate, partner/off-net aging, inventory handover acceptance, and completion quality.
- Queues: provide queues for accepted, readiness failed, waiting dependency, in progress, activation pending, field pending, partner pending, fallout, retrying, rollback pending, compensation pending, handover pending, rejected, completed, and archived Provisioning Workflow records.
- Alerts: notify Fulfillment And Activation Control Tower owners when activation failure rate, queue aging, controller outage, partner/off-net delay, event publication failure, retry backlog, rollback failure, inventory handover rejection, or SLA/OLA breach risk exceeds threshold.
- Runbooks: document triage, retry, replay, controller adapter recovery, manual activation, rollback, compensation, fallout escalation, partner/off-net escalation, handover repair, evidence export, legal hold response, and downstream event replay procedures for Provisioning Workflow.
- Ownership: Fulfillment And Activation Control Tower owns first-line health for Provisioning Workflow lifecycle, queues, event replay, activation evidence, fallout, rollback/compensation, and handover evidence; Order, Inventory, Field, Billing, Assurance, Partner, Platform, Data, and external controller owners correct their own source records.

## Test Approach

| Test layer | Required coverage |
| --- | --- |
| Unit tests | Field rules, lifecycle transitions, dependency state, retry policy, rollback/compensation state, duplicate detection, masking, and provisioning workflow instance calculations for Provisioning Workflow. |
| API contract tests | Commands, queries, errors, idempotency, pagination, filtering, version compatibility, TMF-aligned payloads for TMF701, TMF641, TMF652, TMF646, TMF700, TMF684, and documented non-TMF extension APIs. |
| Event contract tests | Provisioning Workflow event names, payload shape, changed fields, correlation ID, idempotency key, ordering metadata, replay behavior, and subscriber compatibility. |
| Workflow tests | Happy path, assisted correction, automated API path, readiness simulation, field path, partner/off-net path, activation, validation/test, fallout, timeout, retry, cancellation, rollback, compensation, handover, correction, and closure for provisioning workflow lifecycle. |
| Integration tests | Handoffs with order, design, inventory, field, stock, activation/controller, billing, care/self-care, assurance, partner/off-net, data, and platform owners, including unavailability and no direct database access. |
| Security and privacy tests | Tenant isolation, privileged activation approval, command masking, sensitive topology masking, malicious payloads, audit logging, legal hold, retention, export controls, and data residency for Provisioning Workflow. |
| Data tests | Source authority, referential integrity, historical correction, projection refresh, completion evidence, fallout analytics, reporting metrics, and lineage for provisioning workflow instance. |
| Performance tests | Search, orchestration, activation command throughput, queue processing, partner callback ingest, event publication, replay, and API throughput under realistic telecom fulfillment volumes. |

## Feature Detail Review Implementation Alignment (2026-06-14)

Source: [App Feature Detail Review Alignment](README.md#feature-detail-review-alignment-2026-06-14) and [Suite Feature Detail Review](../../feature-detail-review.md).

Apply this app review scope to this feature: service and resource order execution, workflow orchestration, activation evidence, rollback and compensation, fallout, and inventory handover.

Implementation updates required for this feature:

- Re-check the core workflows and add or adjust happy paths, approval paths, exception queues, rollback or compensation behavior, and handoffs so the review scope is directly represented in build stories.
- Add or refine UI workbench expectations, including operator queues, evidence panels, policy decision traces, preview/simulation views, and status dashboards where this feature owns the behavior.
- Add or refine command APIs, query APIs, events, app-owned data fields, DDL gap notes, and integration handoffs needed to support the review scope without crossing app data ownership boundaries.
- Add acceptance criteria for source authority, tenant and residency controls, lifecycle state, approval evidence, idempotency, correlation IDs, SLA/OLA timers, and downstream acknowledgement where applicable.
- Add negative scenarios for stale data, duplicate events, policy denial, missing evidence, downstream outage, unauthorized access, bulk/replay risk, and manual override misuse.
- Extend tests to include happy path, negative path, edge case, API contract, event replay, data reconciliation, security, accessibility, observability, runbook, and release-gate evidence for the review scope.

## Build-Ready Refinement (2026-06-14)

This refinement converts the feature review material for Provisioning Workflow into delivery slices that can become epics, stories, API contracts, migrations, and test cases. Treat Fulfillment And Activation Control Tower as the owning application for this feature within Suite OSS Engineering, Inventory, And Fulfillment and schema `fulfillment_activation`.

| Workstream | Build-ready delivery guidance |
| --- | --- |
| UX and workflow | Build the Provisioning Workflow workbench for Fulfillment operations lead, Provisioning analyst, Activation engineer, Order manager, Inventory manager, Partner/off-net coordinator. Include search or intake, guided validation, detail view, lifecycle timeline, decision panel, evidence drawer, exception queue, bulk or replay controls where relevant, saved filters, SLA/OLA aging, empty/error states, and role-aware masking. The UI must expose start, sequence, parallelize, wait, hold, retry, escalate, cancel, compensate, resume, complete, correct, or publish provisioning workflow state. The decision records accountable persona, dependency state... and block closure when required evidence, approval, reconciliation, or downstream acknowledgement is missing. |
| API and events | Implement command and query APIs around provisioning-workflow using TMF701, TMF641, TMF652, TMF646, TMF700, TMF684. Command APIs for Provisioning Workflow must cover accept/initiate, validate, start, update, hold, release, retry, escalate, cancel, roll back, compensate, test, handover, correct, replay, and close where the... Query APIs for Provisioning Workflow must cover search, detail, timeline, related provisioning workflow instance references, dependency graph, fallout queue, activation evidence, partner/off-net milestones, metrics, and... Domain events for Provisioning Workflow must include ProvisioningWorkflowStarted, ProvisioningTaskBlocked, ProvisioningWorkflowCompensated, ProvisioningWorkflowCompleted, plus blocked, jeopardy raised, fallout raised... Non-TMF Provisioning Saga API for dependency graph, timer policy, compensation state, replay, bulk project grouping, and customer-impacting jeopardy. Each extension contract must be explicitly labelled non-TMF... Every command, query, and event must carry tenant/brand/market where applicable, actor, source channel, reason code, idempotency key, correlation ID, external reference, lifecycle state, and version metadata. |
| Data and controls | Persist provisioning workflow instance. inside `fulfillment_activation` with typed lifecycle, owner, status reason, timestamps, policy decision, source freshness, confidence, old/new value, evidence, and reconciliation fields. Fulfillment And Activation Control Tower owns workflow instance lifecycle, dependency graph, task state, timer/SLA state, retry policy, manual queue state, automation decision, compensation state, completion evidence, and publication... Keep TMF payloads, extension characteristics, imported evidence, and low-stability metadata in JSONB while promoting operationally searched lifecycle fields to typed columns. |
| Integration and handoff | Exchange service orders, resource orders, product orders, reservations, assignments, activation tasks, field work, shipments, billing triggers, partner tasks, assurance tests, workflow definitions... with Workflow And Automation Studio for reusable process infrastructure where used., Order Management Hub for promise-date and customer-visible milestone updates., Field Work/Stock/Logistics for appointment, work order, shipment, and... only through APIs, events, workflow tasks, governed projections, adapters, evidence packages, or certified data products. Show source owner, freshness, confidence, dependency state, retry status, blocked consumer, and completion evidence so the app does not create shadow mastership or direct cross-schema coupling. |
| Security, privacy, and compliance | Enforce RBAC/ABAC, tenant and residency boundaries, least privilege, separation of duties, masking, purpose limitation, retention, legal hold, export control, manual override expiry, immutable audit, and evidence chain of custody for Provisioning Workflow. Sensitive customer, revenue, partner, security, network, credential, or regulatory evidence must be masked unless the persona has explicit operational purpose. |
| Tests and operations | Create unit, API contract, event replay/idempotency, workflow, integration, migration, data reconciliation, security/privacy, accessibility/localization, performance, dashboard, alert, and runbook tests for Provisioning Workflow. Cover happy path, assisted path, automated path, exception path, bulk/project path, stale or duplicate input, downstream outage, policy denial, manual override, and reconciliation mismatch. Use the existing review scope - service and resource order execution, workflow orchestration, activation evidence, rollback and compensation, fallout, and inventory handover. - as mandatory backlog and test evidence. |

Implementation notes:

- Treat Fulfillment And Activation Control Tower as the lifecycle owner for provisioning workflow instance.; referenced data such as service orders, resource orders, product orders, reservations, assignments, activation tasks, field work, shipments, billing triggers, partner tasks, assurance tests, workflow definitions, and customer communication... must remain references, snapshots, projections, evidence packages, or consumer acknowledgements unless the source file explicitly gives this app mastership.
- Make TMF alignment visible in every story: use named TMF resources where they fit, document non-TMF extension APIs with OpenAPI, and keep extension payloads compatible with TMF-style identifiers, lifecycle state, related entities, pagination, errors, and event envelopes.
- Build UI and API behavior around decision evidence, not only CRUD: surface the permitted next actions, policy decision, state reason, owner, SLA/OLA timer, blocked dependency, retry or compensation path, and closure proof.
- Add development tasks for route/page/component work, command/query handlers, DTO validation, entity/repository/migration changes, outbox/event contracts, projection refresh, privacy/security checks, and operational dashboards.
- Definition-of-done evidence must show downstream consumers can use published state through APIs, events, projections, workflow tasks, or certified data products without direct database reads or manual spreadsheet reconciliation.

## Definition Of Done

1. The provisioning workflow instance lifecycle supports accepted, validating, waiting, in progress, activated, field pending, partner pending, fallout, retrying, rollback pending, compensating, handover pending, completed, rejected, cancelled, corrected, and archived states where applicable.
2. Persona workflows for Fulfillment operations lead, Provisioning analyst, Activation engineer, Order manager, Inventory manager, and Partner/off-net coordinator include decision rights, validation messages, exception routing, retry/rollback/compensation controls, and evidence capture for Provisioning Workflow.
3. TMF-aligned references, non-TMF extension APIs, events, idempotency, correlation IDs, error models, replay behavior, adapter behavior, and consumer revalidation contracts are documented and contract-tested.
4. Data ownership, private app database boundaries, governed projections, retention, legal hold, tenant isolation, critical-topology masking, privileged activation controls, partner/off-net evidence, and export controls match data mastery and ODA guidance.
5. Operational dashboards explain Provisioning Workflow state, dependency graph, automation status, activation evidence, fallout, rollback/compensation, partner/off-net milestones, handover status, consumer lag, and completion quality without direct database access.
6. Negative scenarios, telecom edge cases, workflow tests, security tests, event replay tests, activation adapter tests, rollback tests, partner/off-net tests, test-and-turn-up tests, and handover tests are automated or explicitly covered in delivery evidence.
