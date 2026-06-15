| Field | Value |
| --- | --- |
| Feature ID | F-resource-order-execution-01 |
| App | Fulfillment Activation Control Tower |
| App slug | `fulfillment-activation-control-tower` |
| Module | Fulfillment And Activation Control Tower |
| Source slice | [modules-and-features.md](../modules-and-features.md) |
| Last refined | 2026-06-15 |
| Refiner verdict | Build-ready |

# Resource Order Execution Feature Specification


Reviewed: 2026-06-07

Suite: OSS Engineering, Inventory, And Fulfillment

App: [Fulfillment And Activation Control Tower](../README.md)

Source module detail: [Modules And Features](../modules-and-features.md)

Source gap review: [E2E Feature Gap Assessment](../../../e2e-feature-gap-assessment.md)

Feature area slug: `resource-order-execution`

E2E gap severity: Core

## Feature Intent

Execute resource assignment, install, configure, modify, migrate, release, pool selection, reservation conversion, inventory update request, field work, shipment, and activation for network, cloud, CPE, SIM/eSIM, numbers, IP, licenses, and partner/off-net resources. The Resource Order Execution feature produces a governed resource order execution record outcome with dependency visibility, retry/rollback controls, customer-impact evidence, and downstream handoff for order-to-activate, MACD, partner/off-net, test-and-turn-up, and govern-to-comply journeys.

## Telecom Objects And Decision Rights

- Master entity: resource order execution record. Fulfillment And Activation Control Tower owns resource order lifecycle, resource order item state, reservation/assignment request, pool selection, field/shipment dependency, activation dependency, release/migration state, fallout state, and handover evidence.
- Referenced entities: service order, resource catalog, resource inventory, resource pool, reservation, activation template, stock/shipment, field work, SIM/eSIM/number/IP platforms, partner resource evidence, and inventory handover state. Fulfillment And Activation Control Tower consumes these through APIs, events, governed projections, workflow tasks, activation adapters, partner callbacks, or evidence packages and does not overwrite their operational masters.
- Primary decisions: accept, validate, reserve, assign, install, configure, migrate, release, hold, retry, compensate, complete, correct, or publish resource order execution state. The decision records accountable persona, dependency state, automation/manual source, retry/rollback/compensation choice, customer/order impact, SLA/OLA state, and downstream handoff.
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
| Trigger | Resource Order Execution starts from service order decomposition, resource assignment request, CPE/device install, SIM/eSIM activation, number/IP allocation, migration/decommissioning wave, field completion, or activation rollback event. | The resource order execution record opens with owner, tenant, market, product/service/resource/order scope, lifecycle action, due date, source trigger, correlation ID, customer-impact flag, and required dependency references. |
| Validation | The app validates resource specification, service order dependency, pool availability, reservation/assignment state, identifier availability, stock/shipment requirement, field dependency, activation template, release/quarantine rule, and rollback path. | Invalid resource order execution record data creates readiness failures, workflow blocks, activation fallout, manual tasks, rollback tasks, partner escalations, or handover rejection before the order-to-activate journey advances. |
| Orchestration | Fulfillment And Activation Control Tower coordinates Order Management, Design Studio, Inventory, Field, Stock/Logistics, activation controllers, NMS/EMS/SDN/NFV/cloud, SIM/eSIM/device platforms, partner/off-net systems, Billing, Assurance, Customer communications, and Data consumers through APIs, events, workflow tasks, adapters, or evidence packages. | Consumers receive execution state and evidence while their own databases and lifecycle records remain private to their owning apps. |
| Exception | If any of these conditions occur - Resource pool has capacity but selected resource is quarantined, Wrong CPE or SIM/eSIM asset shipped for order, Partner resource delivery misses committed date - the workflow routes to the accountable fulfillment operations, provisioning, activation engineering, order, inventory, field, partner/off-net, data, or compliance owner. | The exception captures failed rule, affected customer/service/resource/order, SLA/OLA impact, retry/rollback/compensation option, blocked consumer, correlation ID, evidence gap, and escalation path. |
| Completion | Completion occurs when the resource order execution record is completed, partially completed, failed, compensated, rolled back, handed over, accepted, rejected, cancelled, or closed with downstream acknowledgement. | Completion evidence includes execution version, command/response evidence, field/partner/test evidence where relevant, inventory handover status, customer/order/billing/assurance notification status, event IDs, and replay metadata. |

## Missing Use Cases And Scenarios

| Scenario | Required behavior |
| --- | --- |
| Greenfield activation | Resource Order Execution must support new fiber order assigns ONT, port, IP, and CPE resources with explicit resource order execution record, lifecycle state, dependency state, evidence, decision owner, and downstream handoff. |
| Brownfield MACD | Resource Order Execution must support brownfield router swap changes resource assignment and shipment with explicit resource order execution record, lifecycle state, dependency state, evidence, decision owner, and downstream handoff. |
| Enterprise bulk or migration | Resource Order Execution must support enterprise bulk order reserves resources by site wave with explicit resource order execution record, lifecycle state, dependency state, evidence, decision owner, and downstream handoff. |
| Partner/off-net or customer activation | Resource Order Execution must support partner/off-net resource order waits for wholesale circuit delivery with explicit resource order execution record, lifecycle state, dependency state, evidence, decision owner, and downstream handoff. |
| Partial activation, rollback, or decommissioning | Resource Order Execution must support rollback releases identifiers and quarantines failed resource assignment with explicit resource order execution record, lifecycle state, dependency state, evidence, decision owner, and downstream handoff. |

## Capability Slices

| Feature ID | Feature | Parent feature area | Priority guidance |
| --- | --- | --- | --- |
| F-resource-order-execution-01 | Resource order intake and validation | Resource Order Execution | P1: required for order-to-activate execution, MACD, partner/off-net delivery, rollback, test-and-turn-up, inventory handover, or customer-visible milestone control. |
| F-resource-order-execution-02 | Pool selection and reservation conversion | Resource Order Execution | P1: required for order-to-activate execution, MACD, partner/off-net delivery, rollback, test-and-turn-up, inventory handover, or customer-visible milestone control. |
| F-resource-order-execution-03 | Assignment and installation dependency | Resource Order Execution | P1: required for order-to-activate execution, MACD, partner/off-net delivery, rollback, test-and-turn-up, inventory handover, or customer-visible milestone control. |
| F-resource-order-execution-04 | Network/cloud/device/SIM/eSIM resource execution | Resource Order Execution | P1: required for order-to-activate execution, MACD, partner/off-net delivery, rollback, test-and-turn-up, inventory handover, or customer-visible milestone control. |
| F-resource-order-execution-05 | Field work and shipment dependency | Resource Order Execution | P2: required for order-to-activate execution, MACD, partner/off-net delivery, rollback, test-and-turn-up, inventory handover, or customer-visible milestone control. |
| F-resource-order-execution-06 | Release, quarantine, and migration control | Resource Order Execution | P2: required for order-to-activate execution, MACD, partner/off-net delivery, rollback, test-and-turn-up, inventory handover, or customer-visible milestone control. |
| F-resource-order-execution-07 | Resource handover evidence | Resource Order Execution | P2: required for order-to-activate execution, MACD, partner/off-net delivery, rollback, test-and-turn-up, inventory handover, or customer-visible milestone control. |

## Acceptance Criteria

1. **AC-resource-order-execution-01:** Given an authorized Fulfillment operations lead, Provisioning analyst, Activation engineer, Order manager, Inventory manager, or Partner/off-net coordinator creates or updates the resource order execution record, when the resource order execution lifecycle advances from accepted, waiting, executing, activated, failed, fallout, compensating, handover, completed, or cancelled state, then Fulfillment And Activation Control Tower validates resource specification, service order dependency, pool availability, reservation/assignment state, identifier availability, stock/shipment requirement, field dependency, activation template, release/quarantine rule, and rollback path before accepting the state change.
2. **AC-resource-order-execution-02:** Given the resource order execution record references product order, service order, resource order, reservation, inventory, field, activation, partner, billing, assurance, or customer communication data, when a persona opens the Resource Order Execution record, then the app shows source owner, source timestamp, freshness, dependency status, customer-impact flag, and whether the data is app-owned or read-only.
3. **AC-resource-order-execution-03:** Given Resource pool has capacity but selected resource is quarantined, when validation fails for Resource Order Execution, then the app keeps the execution record in waiting, blocked, fallout, retrying, compensating, or rejected state with severity, owner, due date, affected customer/service/resource/order, retry/rollback option, and correlation ID.
4. **AC-resource-order-execution-04:** Given the resource order execution record changes due to automation, manual action, controller response, field evidence, partner callback, test result, rollback, or compensation, when the transition is committed, then the app stores decision right, actor, role, reason, command/evidence links, old/new values, tenant/region boundary, and idempotency key.
5. **AC-resource-order-execution-05:** Given Order Management, Inventory, Billing, Care, Self-Care, Assurance, Field, Partner, Data, or Platform consumers subscribe to Resource Order Execution changes, when the resource order execution record reaches milestone, fallout, rollback, handover, or completion state, then the app emits a versioned event with changed fields, impact, SLA/OLA state, replay metadata, and correlation ID.
6. **AC-resource-order-execution-06:** Given a greenfield install, brownfield MACD, enterprise bulk order, partner/off-net delivery, automated provisioning, manual fallout, no-access, partial activation, rollback, migration, or decommissioning scenario references the resource order execution record, when the user requests closure, then the app validates downstream handoffs, open fallout, inventory acceptance, customer/order/billing/assurance notification, retention, and legal hold before closure.
7. **AC-resource-order-execution-07:** Given operations leaders review Resource Order Execution operations, when they open dashboards, then they see volume, automation rate, activation latency, queue aging, fallout cause, rollback/compensation count, partner/off-net aging, inventory handover status, and completion quality linked to the resource order execution record.

## Negative Scenarios

Negative scenarios for this feature include permission denial, missing source data, stale dependency state, policy failure, duplicate or replayed request, downstream timeout, reconciliation mismatch, and any feature-specific negative scenario additions listed in the suite gap-review closure addendum.

## Edge Cases

| Scenario | Expected behavior |
| --- | --- |
| Resource pool has capacity but selected resource is quarantined | Resource Order Execution blocks unsafe execution or routes controlled fallout with owner, due date, affected customer/service/resource/order, retry/rollback/compensation option, and replayable evidence. |
| Wrong CPE or SIM/eSIM asset shipped for order | Resource Order Execution blocks unsafe execution or routes controlled fallout with owner, due date, affected customer/service/resource/order, retry/rollback/compensation option, and replayable evidence. |
| Partner resource delivery misses committed date | Resource Order Execution blocks unsafe execution or routes controlled fallout with owner, due date, affected customer/service/resource/order, retry/rollback/compensation option, and replayable evidence. |
| Resource release conflicts with active service inventory | Resource Order Execution blocks unsafe execution or routes controlled fallout with owner, due date, affected customer/service/resource/order, retry/rollback/compensation option, and replayable evidence. |
| Resource order completes before activation evidence exists | Resource Order Execution blocks unsafe execution or routes controlled fallout with owner, due date, affected customer/service/resource/order, retry/rollback/compensation option, and replayable evidence. |
| Duplicate, stale, or out-of-order callback | Resource Order Execution uses optimistic locking, callback timestamp, command ID, event version, and idempotency key so retries cannot duplicate activation, fallout, handover, rollback, or completion state. |
| Cross-tenant, cross-region, or privileged activation boundary breach | Resource Order Execution blocks action, masks restricted customer/site/topology/identifier data, and records policy decision metadata for tenant isolation, privileged access, data residency, legal hold, and export control. |
| Downstream app, partner, controller, or external adapter unavailable | Resource Order Execution either fails fast for synchronous safety gates or queues controlled retry, replay, escalation, fallback manual task, or compensation with owner, due date, and correlation ID. |
| Retention, privacy, regulatory, or legal hold conflict | Resource Order Execution prevents destructive correction, evidence deletion, rollback closure, or order completion until retention, lawful/regulatory evidence, legal hold, and data residency controls allow it. |

## API, Event, And Data Requirements

Related APIs and API areas: [TMF652](../../../../../references/tmforum-open-apis/openapi-specs/TMF652_ResourceOrderManagement), [TMF716](../../../../../references/tmforum-open-apis/openapi-specs/TMF716_ResourceReservation), [TMF685](../../../../../references/tmforum-open-apis/openapi-specs/TMF685_ResourcePool), [TMF639](../../../../../references/tmforum-open-apis/openapi-specs/TMF639_ResourceInventory), [TMF697](../../../../../references/tmforum-open-apis/openapi-specs/TMF697_Work_Order), [TMF684](../../../../../references/tmforum-open-apis/openapi-specs/TMF684_ShipmentTracking)

TMF API fit and extension notes:

- Use TMF652 for resource order execution, TMF716/TMF685/TMF639 for reservation, pool, and resource references, and TMF697/TMF684 for field and shipment dependencies; Inventory And Topology remains final resource inventory master.
- Non-TMF Resource Execution Control API for pool selection rationale, assignment conflict repair, partner resource evidence, shipment dependency, and rollback-aware release. Each extension contract must be explicitly labelled non-TMF, documented with OpenAPI, and aligned to TMF-style id, href, lifecycle state, relatedParty, relatedEntity, error, pagination, and event-envelope patterns where practical.
- Command APIs for Resource Order Execution must cover accept/initiate, validate, start, update, hold, release, retry, escalate, cancel, roll back, compensate, test, handover, correct, replay, and close where the resource order execution lifecycle uses those states.
- Query APIs for Resource Order Execution must cover search, detail, timeline, related resource order execution record references, dependency graph, fallout queue, activation evidence, partner/off-net milestones, metrics, and audit/evidence retrieval with role-aware masking.
- Domain events for Resource Order Execution must include ResourceOrderExecutionAccepted, ResourceAssignmentRequested, ResourceOrderExecutionCompleted, ResourceOrderExecutionFalloutRaised, plus blocked, jeopardy raised, fallout raised, fallout resolved, rollback requested, compensation completed, handover requested, completion rejected, replay requested, and reconciliation failed where the lifecycle uses those states.

Data and ownership requirements:

- Fulfillment And Activation Control Tower owns resource order lifecycle, resource order item state, reservation/assignment request, pool selection, field/shipment dependency, activation dependency, release/migration state, fallout state, and handover evidence; other apps consume Resource Order Execution state through APIs, events, governed projections, workflow tasks, adapters, evidence packages, or certified data products.
- Store source channel, actor, tenant/brand/market, customer/order/service/resource references, lifecycle action, status reason, due date, SLA/OLA state, command ID, external references, old/new values, policy decision, evidence links, retention class, legal hold flag, and impacted consumer list.
- Keep read projections, analytics extracts, and DWH/lakehouse outputs separate from operational writes so Resource Order Execution does not create shadow mastership of product orders, installed inventory, field work, stock, billing, assurance tickets, customer records, partner lifecycle, or platform security records.
- Provide reconciliation outputs that prove Order Management, Inventory, Field, Billing, Care, Self-Care, Assurance, Partner, Platform, and Data consumers have accepted, rejected, or remain explicitly blocked by the resource order execution record.

## Integrations And Handoffs

- Inventory And Topology for resource pools, reservations, assignments, release, quarantine, and handover acceptance.
- Field Work and Stock/Logistics for work order, stock, shipment, and device movement.
- Activation systems for configure/activate/release commands.
- Partner/off-net systems for external resource delivery evidence.
- Order Management Hub and Service Order Execution for dependency and status updates.

## Non-Functional Requirements

- Scale and latency: Resource Order Execution must support high-volume order-to-activate workloads with thousands of concurrent service/resource orders, activation commands, partner milestones, workflow timers, fallout cases, and handover packages; command acceptance should be low-latency while long-running orchestration, simulation, activation, test, and handover tasks expose progress, ETA, and partial-failure reports.
- Availability and resilience: execution query APIs and active queues for Resource Order Execution must remain available during downstream order, inventory, field, billing, assurance, partner, controller, or data outages by serving last-known execution state with dependency freshness and retry status.
- Auditability and retention: Resource Order Execution history must retain actor, channel, reason, old/new value, command/request/response, policy version, approval/waiver, event ID, external reference, customer-impact flag, legal hold flag, and retention class for activation, field, partner, regulatory, and customer evidence periods.
- Localization and accessibility: Resource Order Execution UI tasks, fallout messages, customer/partner communication triggers, engineering units, time zones, language, keyboard navigation, and screen-reader labels must respect tenant, market, geography, and accessibility policy.
- Data protection: API, event, export, adapter, and dashboard paths for Resource Order Execution must enforce tenant isolation, data residency, purpose limitation, least privilege, privileged activation controls, sensitive topology masking, critical-infrastructure masking, and secure evidence storage.

## Compliance, Security, And Privacy

- Resource Order Execution must enforce tenant isolation, region boundaries, role-based execution, privileged activation approval, break-glass review where used, critical infrastructure masking, lawful/regulatory activation evidence, partner/off-net evidence controls, export controls, and data residency for the resource order execution record.
- Resource Order Execution must preserve activation command evidence, rollback evidence, field evidence, service validation evidence, partner/off-net delivery evidence, customer communication evidence, legal hold, and regulatory inventory handover evidence where execution decisions affect telecom obligations.
- Sensitive customer, enterprise, site, topology, identifier, firmware, controller, partner/off-net, and activation command references in Resource Order Execution must be masked in search, timelines, exports, analytics, and dashboards unless the persona has a permitted operational purpose.

## Observability And Operations

- Metrics: track resource-order-execution records accepted, started, waiting, automated, manually handled, activated, failed, retried, rolled back, compensated, handed over, rejected, completed, and replayed, plus activation latency, queue aging, fallout rate, rollback rate, partner/off-net aging, inventory handover acceptance, and completion quality.
- Queues: provide queues for accepted, readiness failed, waiting dependency, in progress, activation pending, field pending, partner pending, fallout, retrying, rollback pending, compensation pending, handover pending, rejected, completed, and archived Resource Order Execution records.
- Alerts: notify Fulfillment And Activation Control Tower owners when activation failure rate, queue aging, controller outage, partner/off-net delay, event publication failure, retry backlog, rollback failure, inventory handover rejection, or SLA/OLA breach risk exceeds threshold.
- Runbooks: document triage, retry, replay, controller adapter recovery, manual activation, rollback, compensation, fallout escalation, partner/off-net escalation, handover repair, evidence export, legal hold response, and downstream event replay procedures for Resource Order Execution.
- Ownership: Fulfillment And Activation Control Tower owns first-line health for Resource Order Execution lifecycle, queues, event replay, activation evidence, fallout, rollback/compensation, and handover evidence; Order, Inventory, Field, Billing, Assurance, Partner, Platform, Data, and external controller owners correct their own source records.

## Test Approach

| Test layer | Required coverage |
| --- | --- |
| Unit tests | Field rules, lifecycle transitions, dependency state, retry policy, rollback/compensation state, duplicate detection, masking, and resource order execution record calculations for Resource Order Execution. |
| API contract tests | Commands, queries, errors, idempotency, pagination, filtering, version compatibility, TMF-aligned payloads for TMF652, TMF716, TMF685, TMF639, TMF697, TMF684, and documented non-TMF extension APIs. |
| Event contract tests | Resource Order Execution event names, payload shape, changed fields, correlation ID, idempotency key, ordering metadata, replay behavior, and subscriber compatibility. |
| Workflow tests | Happy path, assisted correction, automated API path, readiness simulation, field path, partner/off-net path, activation, validation/test, fallout, timeout, retry, cancellation, rollback, compensation, handover, correction, and closure for resource order execution lifecycle. |
| Integration tests | Handoffs with order, design, inventory, field, stock, activation/controller, billing, care/self-care, assurance, partner/off-net, data, and platform owners, including unavailability and no direct database access. |
| Security and privacy tests | Tenant isolation, privileged activation approval, command masking, sensitive topology masking, malicious payloads, audit logging, legal hold, retention, export controls, and data residency for Resource Order Execution. |
| Data tests | Source authority, referential integrity, historical correction, projection refresh, completion evidence, fallout analytics, reporting metrics, and lineage for resource order execution record. |
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

This refinement converts the feature review material for Resource Order Execution into delivery slices that can become epics, stories, API contracts, migrations, and test cases. Treat Fulfillment And Activation Control Tower as the owning application for this feature within Suite OSS Engineering, Inventory, And Fulfillment and schema `fulfillment_activation`.

| Workstream | Build-ready delivery guidance |
| --- | --- |
| UX and workflow | Build the Resource Order Execution workbench for Fulfillment operations lead, Provisioning analyst, Activation engineer, Order manager, Inventory manager, Partner/off-net coordinator. Include search or intake, guided validation, detail view, lifecycle timeline, decision panel, evidence drawer, exception queue, bulk or replay controls where relevant, saved filters, SLA/OLA aging, empty/error states, and role-aware masking. The UI must expose accept, validate, reserve, assign, install, configure, migrate, release, hold, retry, compensate, complete, correct, or publish resource order execution state. The decision records accountable persona, dependency state... and block closure when required evidence, approval, reconciliation, or downstream acknowledgement is missing. |
| API and events | Implement command and query APIs around resource-order-execution using TMF652, TMF716, TMF685, TMF639, TMF697, TMF684. Command APIs for Resource Order Execution must cover accept/initiate, validate, start, update, hold, release, retry, escalate, cancel, roll back, compensate, test, handover, correct, replay, and close where the resource... Query APIs for Resource Order Execution must cover search, detail, timeline, related resource order execution record references, dependency graph, fallout queue, activation evidence, partner/off-net milestones, metrics... Domain events for Resource Order Execution must include ResourceOrderExecutionAccepted, ResourceAssignmentRequested, ResourceOrderExecutionCompleted, ResourceOrderExecutionFalloutRaised, plus blocked, jeopardy raised... Non-TMF Resource Execution Control API for pool selection rationale, assignment conflict repair, partner resource evidence, shipment dependency, and rollback-aware release. Each extension contract must be explicitly... Every command, query, and event must carry tenant/brand/market where applicable, actor, source channel, reason code, idempotency key, correlation ID, external reference, lifecycle state, and version metadata. |
| Data and controls | Persist resource order execution record. inside `fulfillment_activation` with typed lifecycle, owner, status reason, timestamps, policy decision, source freshness, confidence, old/new value, evidence, and reconciliation fields. Fulfillment And Activation Control Tower owns resource order lifecycle, resource order item state, reservation/assignment request, pool selection, field/shipment dependency, activation dependency, release/migration state, fallout state... Keep TMF payloads, extension characteristics, imported evidence, and low-stability metadata in JSONB while promoting operationally searched lifecycle fields to typed columns. |
| Integration and handoff | Exchange service order, resource catalog, resource inventory, resource pool, reservation, activation template, stock/shipment, field work, SIM/eSIM/number/IP platforms, partner resource evidence... with Inventory And Topology for resource pools, reservations, assignments, release, quarantine, and handover acceptance., Field Work and Stock/Logistics for work order, stock, shipment, and device movement., Activation systems for... only through APIs, events, workflow tasks, governed projections, adapters, evidence packages, or certified data products. Show source owner, freshness, confidence, dependency state, retry status, blocked consumer, and completion evidence so the app does not create shadow mastership or direct cross-schema coupling. |
| Security, privacy, and compliance | Enforce RBAC/ABAC, tenant and residency boundaries, least privilege, separation of duties, masking, purpose limitation, retention, legal hold, export control, manual override expiry, immutable audit, and evidence chain of custody for Resource Order Execution. Sensitive customer, revenue, partner, security, network, credential, or regulatory evidence must be masked unless the persona has explicit operational purpose. |
| Tests and operations | Create unit, API contract, event replay/idempotency, workflow, integration, migration, data reconciliation, security/privacy, accessibility/localization, performance, dashboard, alert, and runbook tests for Resource Order Execution. Cover happy path, assisted path, automated path, exception path, bulk/project path, stale or duplicate input, downstream outage, policy denial, manual override, and reconciliation mismatch. Use the existing review scope - service and resource order execution, workflow orchestration, activation evidence, rollback and compensation, fallout, and inventory handover. - as mandatory backlog and test evidence. |

Implementation notes:

- Treat Fulfillment And Activation Control Tower as the lifecycle owner for resource order execution record.; referenced data such as service order, resource catalog, resource inventory, resource pool, reservation, activation template, stock/shipment, field work, SIM/eSIM/number/IP platforms, partner resource evidence, and inventory handover state. must remain references, snapshots, projections, evidence packages, or consumer acknowledgements unless the source file explicitly gives this app mastership.
- Make TMF alignment visible in every story: use named TMF resources where they fit, document non-TMF extension APIs with OpenAPI, and keep extension payloads compatible with TMF-style identifiers, lifecycle state, related entities, pagination, errors, and event envelopes.
- Build UI and API behavior around decision evidence, not only CRUD: surface the permitted next actions, policy decision, state reason, owner, SLA/OLA timer, blocked dependency, retry or compensation path, and closure proof.
- Add development tasks for route/page/component work, command/query handlers, DTO validation, entity/repository/migration changes, outbox/event contracts, projection refresh, privacy/security checks, and operational dashboards.
- Definition-of-done evidence must show downstream consumers can use published state through APIs, events, projections, workflow tasks, or certified data products without direct database reads or manual spreadsheet reconciliation.

## Definition Of Done

1. The resource order execution record lifecycle supports accepted, validating, waiting, in progress, activated, field pending, partner pending, fallout, retrying, rollback pending, compensating, handover pending, completed, rejected, cancelled, corrected, and archived states where applicable.
2. Persona workflows for Fulfillment operations lead, Provisioning analyst, Activation engineer, Order manager, Inventory manager, and Partner/off-net coordinator include decision rights, validation messages, exception routing, retry/rollback/compensation controls, and evidence capture for Resource Order Execution.
3. TMF-aligned references, non-TMF extension APIs, events, idempotency, correlation IDs, error models, replay behavior, adapter behavior, and consumer revalidation contracts are documented and contract-tested.
4. Data ownership, private app database boundaries, governed projections, retention, legal hold, tenant isolation, critical-topology masking, privileged activation controls, partner/off-net evidence, and export controls match data mastery and ODA guidance.
5. Operational dashboards explain Resource Order Execution state, dependency graph, automation status, activation evidence, fallout, rollback/compensation, partner/off-net milestones, handover status, consumer lag, and completion quality without direct database access.
6. Negative scenarios, telecom edge cases, workflow tests, security tests, event replay tests, activation adapter tests, rollback tests, partner/off-net tests, test-and-turn-up tests, and handover tests are automated or explicitly covered in delivery evidence.


## Build-Ready Refinement (2026-06-15)

Header added at the top of this file. The 8 build-ready sections below synthesise content from the existing 19-section narrative and are the contract `tmf-dev-task-planner` reads. Source citations are inline.

## Persona & decision

- Fulfillment operations lead can monitor in-flight provisioning, sla/ola risk, automation rate, fallout, rollback exposure, for the persona-specific outcome `Sees accountable queues, milestone health, customer-impacting delays, and eviden…`, evidenced by the `## Persona & decision` audit trail in this file.
- Provisioning analyst can repair assignment, workflow, reservation, field, shipment, partner, for the persona-specific outcome `Resolves execution issues without bypassing Inventory, Field, Order, Billing, or…`, evidenced by the `## Persona & decision` audit trail in this file.
- Activation engineer can execute, retry, validate, roll back, for the persona-specific outcome `Controls privileged activation actions with command evidence, rollback plans, an…`, evidenced by the `## Persona & decision` audit trail in this file.
- Order manager can consume fulfillment milestones, jeopardy reasons, partial activation state, for the persona-specific outcome `Receives reliable fulfillment status while Product Order remains mastered by Ord…`, evidenced by the `## Persona & decision` audit trail in this file.
- Inventory manager can validate handover evidence, accepted assignment state, resource release, discrepancy, for the persona-specific outcome `Accepts or rejects final state while Inventory And Topology remains the operatio…`, evidenced by the `## Persona & decision` audit trail in this file.
- Partner/off-net coordinator can track partner, wholesale, off-net, customer self-activation, for the persona-specific outcome `Makes external delivery evidence and SLA exposure visible without mastering part…`, evidenced by the `## Persona & decision` audit trail in this file.

## Lifecycle ownership

- This app owns the lifecycle state of the planning record listed in the source `## Telecom Objects And Decision Rights`. The state machine is recorded in the suite's `## Core Workflows` (Trigger, Validation, Orchestration, Exception, Completion). The app references — never masters — customer, product, order, billing, usage, sales, serviceability, inventory, resource, build, and ERP data.
- Source: [features/<this>.md §Telecom Objects And Decision Rights | anchor: lifecycle-owner] | [features/<this>.md §Core Workflows | anchor: lifecycle-states]

## TMF fit

- TMF API baseline for this app: TMF641, TMF652, TMF640, TMF702, TMF664, TMF701, TMF621, TMF637, TMF638, TMF639.
- Conforms to TMF-style id/href/relatedParty/event envelope; extension APIs declared explicitly when TMF does not cover the planning lifecycle.
- Source: [planning/suite-details/tmf-api-ddl-reviews/fulfillment-activation.md | anchor: tmf-fit]

## Data fit

- Owns schema `fulfillment_activation_control_tower`; the V001 migration lists the owned tables: (none captured).
- Source: [database/postgres/suites/ts_oss_engineering_fulfillment/V001__create_app_schemas_and_starter_tables.sql §schema | anchor: schema-list]

## Path coverage

- Happy path: Not applicable — no evidence of this path in `## Edge Cases` or `## Missing Use Cases And Scenarios`.
- Assisted path: Not applicable — feature is persona-driven happy path; assisted path is owned by exception / approval features.
- Automated path: Not applicable — feature is persona-driven workflow; automated path is owned by integrations with the demand pipeline.
- Exception path: Not applicable — no evidence of this path in `## Edge Cases` or `## Missing Use Cases And Scenarios`.
- Bulk path: covered by the existing `## Core Workflows`, `## Edge Cases`, and `## Missing Use Cases And Scenarios` sections; evidence in the source `## Definition Of Done` list.
- Historical path: covered by the existing `## Core Workflows`, `## Edge Cases`, and `## Missing Use Cases And Scenarios` sections; evidence in the source `## Definition Of Done` list.
- Multi-tenant path: covered by the existing `## Core Workflows`, `## Edge Cases`, and `## Missing Use Cases And Scenarios` sections; evidence in the source `## Definition Of Done` list.
- Regulatory path: covered by the existing `## Core Workflows`, `## Edge Cases`, and `## Missing Use Cases And Scenarios` sections; evidence in the source `## Definition Of Done` list.
- Source: [features/<this>.md §Edge Cases | anchor: paths] | [features/<this>.md §Missing Use Cases And Scenarios | anchor: paths]

## UI implications

- Pages / workbenches (per the app's `Required app screens / workbenches` block in `dev-tasks/development-task-tracker.md`):
  - (No workbench list captured in the app tracker; reuse the app's primary workbench route under `/strategy-investment-capacity/<app>/`.)
- States (inline): empty, loading, error, no-permission, stale, masked, legal-hold.
- Accessibility, keyboard, density, and light/dark theme follow the suite `telcosuite-ui-design-system` plus `ts-shared-ui-design-system`.
- Source: [development-task-tracker.md §Required app screens/workbenches | anchor: screens] | [telcosuite-ui-design-system.md | anchor: ux-baseline]

## Acceptance & tests

- AC1 (AC-resource-order-execution-01): Given an authorized Fulfillment operations lead, Provisioning analyst, Activation engineer, Order manager, Inventory manager, or Partner/off-net coordinator creates or updates the resource order execution record, when the resource order execution lifecycle advances from accepted, waiting, executing, activated, failed, fallout, compensating, handover, completed, or cancelled state, then Fulfillment And Activation Control Tower validates resource specification, service order dependency, pool availability, reservation/assignment state, identifier availability, stock/shipment requirement, field dependency, activation template, release/quarantine rule, and rollback path before accepting the state change.
- AC2 (AC-resource-order-execution-02): Given the resource order execution record references product order, service order, resource order, reservation, inventory, field, activation, partner, billing, assurance, or customer communication data, when a persona opens the Resource Order Execution record, then the app shows source owner, source timestamp, freshness, dependency status, customer-impact flag, and whether the data is app-owned or read-only.
- AC3 (AC-resource-order-execution-03): Given Resource pool has capacity but selected resource is quarantined, when validation fails for Resource Order Execution, then the app keeps the execution record in waiting, blocked, fallout, retrying, compensating, or rejected state with severity, owner, due date, affected customer/service/resource/order, retry/rollback option, and correlation ID.
- AC4 (AC-resource-order-execution-04): Given the resource order execution record changes due to automation, manual action, controller response, field evidence, partner callback, test result, rollback, or compensation, when the transition is committed, then the app stores decision right, actor, role, reason, command/evidence links, old/new values, tenant/region boundary, and idempotency key.
- AC5 (AC-resource-order-execution-05): Given Order Management, Inventory, Billing, Care, Self-Care, Assurance, Field, Partner, Data, or Platform consumers subscribe to Resource Order Execution changes, when the resource order execution record reaches milestone, fallout, rollback, handover, or completion state, then the app emits a versioned event with changed fields, impact, SLA/OLA state, replay metadata, and correlation ID.
- AC6 (AC-resource-order-execution-06): Given a greenfield install, brownfield MACD, enterprise bulk order, partner/off-net delivery, automated provisioning, manual fallout, no-access, partial activation, rollback, migration, or decommissioning scenario references the resource order execution record, when the user requests closure, then the app validates downstream handoffs, open fallout, inventory acceptance, customer/order/billing/assurance notification, retention, and legal hold before closure.
- AC7 (AC-resource-order-execution-07): Given operations leaders review Resource Order Execution operations, when they open dashboards, then they see volume, automation rate, activation latency, queue aging, fallout cause, rollback/compensation count, partner/off-net aging, inventory handover status, and completion quality linked to the resource order execution record.
- Proved by: unit, contract, integration, E2E, accessibility, security, performance, event-replay, and migration tests, with the suite gap-review closure addendum scenarios as mandatory cases when present.
- Source: [features/<this>.md §Acceptance Criteria | anchor: ac-list]

## Dependencies & release gate

- Depends on: dev-tasks tracker `Required app screens/workbenches` block; the suite's P01 foundation tasks; cross-app TMF and event contracts listed under `## API, Event, And Data Requirements`.
- Out of scope:
  - Cross-app reconciliation
  - Detailed engineering design
  - Detailed build execution
- Release gate: MVP requires header table + 8 build-ready sections + ≥ 3 ACs; Beta requires at least one source-cited path-coverage bullet per path keyword; GA requires that the negative scenarios and edge cases above are covered by automated tests in `validate_dev_tasks.py`.
- Source: [development-task-tracker.md | anchor: release-gate]
