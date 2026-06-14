# Fulfillment And Activation Control Tower Modules And Features

Reviewed: 2026-06-06

This document expands each app module into feature-level planning guidance. It should be used to create epics, stories, API contracts, event contracts, screens, permissions, and test cases.

Source overview: [fulfillment-activation-control-tower.md](../fulfillment-activation-control-tower.md)

## App-Level Feature Principles

- Every feature must have an owning module and an owning app API.
- UI actions must call app APIs rather than writing directly to shared data stores.
- Cross-app reads should use APIs, subscribed events, governed projections, or data products.
- Each module should expose enough lifecycle state for operations, audit, automation, and customer/partner visibility.
- Feature design must include happy path, exception path, audit path, and reporting path.

## App Data Ownership Context

Owns service order execution state, resource order execution state, provisioning workflow state, activation requests/responses, fulfillment fallout, and fulfillment handover evidence. Inventory final state is mastered by Inventory And Topology.

## First Release Context

Deliver service/resource order execution, basic provisioning workflow, activation adapter pattern, fallout queue, and inventory handover. Add advanced rollback, self-healing, and multi-domain intent orchestration later.

## Module 1: Service Order Execution

Anchor: `service-order-execution`

### Capability Intent

Execute service orders, service order items, dependencies, transitions, due dates, exceptions, design selection, resource reservation, activation, and inventory update.

### Primary Personas Supported

- Fulfillment operations lead: monitors in-flight provisioning and SLA risk.
- Provisioning analyst: resolves assignment, activation, and workflow exceptions.
- Activation engineer: manages network/cloud/device activation failures and rollback.
- Order manager: consumes fulfillment milestones and customer-visible status.
- Inventory manager: validates final service/resource state.

### Feature Backlog Candidates

- Execute service orders.
- Service order items.
- Dependencies.
- Design selection.
- Resource reservation.
- And inventory update.

### Feature Groups

| Feature group | Feature detail |
| --- | --- |
| Record and lifecycle management | Create, search, view, update, retire, reinstate, and track lifecycle state for service order execution records. Maintain ownership, status reason, timestamps, and relationships to upstream and downstream entities. |
| Validation, policy, and eligibility | Validate service order execution changes against catalog rules, customer/account context, serviceability, inventory state, compliance policy, role permissions, and data-quality constraints relevant to this app. |
| Work queues and approvals | Provide queues for draft, pending approval, blocked, exception, fallout, rejected, completed, and archived work. Support assignment, SLA/OLA tracking, escalation, comments, and handoff. |
| Search, timeline, and operational views | Offer filtered search, saved views, dependency views, lifecycle timeline, related orders/tickets/events, and persona-specific dashboards for service order execution work. |
| API and event behavior | Expose command, query, and event contracts for service order execution so UIs, workflows, partner channels, analytics, and downstream apps do not bypass the owning app. |
| Audit, evidence, and reporting | Capture actor, reason, before/after state, source channel, approval evidence, policy decisions, and reporting measures needed for operations, compliance, and continuous improvement. |

### User Journey Coverage

| Journey | Trigger | App behavior | Successful outcome |
| --- | --- | --- | --- |
| Maintain Service Order Execution | User creates or updates domain information | Validate context, capture change, publish event, update projections | Accurate service order execution state available through APIs |
| Handle Service Order Execution exception | Conflict, validation failure, policy exception, fallout, or missing dependency | Route to owner, capture evidence, resolve or escalate, notify dependent work | Exception closed with auditable reason and downstream handoff |
| Review Service Order Execution performance | Supervisor, planner, compliance, or operations user needs visibility | Filter records, inspect trend, export/report, create follow-up task | Actionable operational insight and accountable next step |

### API And Integration Alignment

Related APIs and API areas: [TMF641](../../../../references/tmforum-open-apis/openapi-specs/TMF641_ServiceOrder)

Implementation guidance:

- Provide create, read, update, lifecycle transition, search, event notification, and audit retrieval behavior where the domain lifecycle requires it.
- Publish domain events for state changes that other apps need for projections, workflow triggers, analytics, or customer/partner communication.
- Keep integration retries, idempotency keys, correlation IDs, and external reference IDs visible to operators.

### Data, Control, And Reporting Needs

- Store app-owned operational records in the app's logical database defined in the database setup document.
- Store external IDs, source channel, owner, status reason, timestamps, and relationship references needed for traceability.
- Provide operational metrics for volume, aging, fallout, SLA/OLA status, exception rate, policy overrides, and automation success.
- Support role-based access, tenant/region boundaries, sensitive-data masking, and export controls where applicable.

### First Release Interpretation

For the first release, implement the minimum lifecycle, search, validation, API, event, audit, and operational queue behavior needed for this module to participate in the app's core workflow. Advanced automation, AI assistance, bulk optimization, simulation, and deep analytics can follow after the app proves the core operating loop.

## Module 2: Resource Order Execution

Anchor: `resource-order-execution`

### Capability Intent

Execute resource assignment, install, configure, modify, migrate, release, pool selection, reservation, inventory update, field work, shipping, and activation for network, cloud, CPE, SIM/eSIM, numbers, IP, and licenses.

### Primary Personas Supported

- Fulfillment operations lead: monitors in-flight provisioning and SLA risk.
- Provisioning analyst: resolves assignment, activation, and workflow exceptions.
- Activation engineer: manages network/cloud/device activation failures and rollback.
- Order manager: consumes fulfillment milestones and customer-visible status.
- Inventory manager: validates final service/resource state.

### Feature Backlog Candidates

- Execute resource assignment.
- Pool selection.
- Inventory update.
- And activation for network.
- And licenses.

### Feature Groups

| Feature group | Feature detail |
| --- | --- |
| Record and lifecycle management | Create, search, view, update, retire, reinstate, and track lifecycle state for resource order execution records. Maintain ownership, status reason, timestamps, and relationships to upstream and downstream entities. |
| Validation, policy, and eligibility | Validate resource order execution changes against catalog rules, customer/account context, serviceability, inventory state, compliance policy, role permissions, and data-quality constraints relevant to this app. |
| Work queues and approvals | Provide queues for draft, pending approval, blocked, exception, fallout, rejected, completed, and archived work. Support assignment, SLA/OLA tracking, escalation, comments, and handoff. |
| Search, timeline, and operational views | Offer filtered search, saved views, dependency views, lifecycle timeline, related orders/tickets/events, and persona-specific dashboards for resource order execution work. |
| API and event behavior | Expose command, query, and event contracts for resource order execution so UIs, workflows, partner channels, analytics, and downstream apps do not bypass the owning app. |
| Audit, evidence, and reporting | Capture actor, reason, before/after state, source channel, approval evidence, policy decisions, and reporting measures needed for operations, compliance, and continuous improvement. |

### User Journey Coverage

| Journey | Trigger | App behavior | Successful outcome |
| --- | --- | --- | --- |
| Maintain Resource Order Execution | User creates or updates domain information | Validate context, capture change, publish event, update projections | Accurate resource order execution state available through APIs |
| Handle Resource Order Execution exception | Conflict, validation failure, policy exception, fallout, or missing dependency | Route to owner, capture evidence, resolve or escalate, notify dependent work | Exception closed with auditable reason and downstream handoff |
| Review Resource Order Execution performance | Supervisor, planner, compliance, or operations user needs visibility | Filter records, inspect trend, export/report, create follow-up task | Actionable operational insight and accountable next step |

### API And Integration Alignment

Related APIs and API areas: [TMF652](../../../../references/tmforum-open-apis/openapi-specs/TMF652_ResourceOrderManagement)

Implementation guidance:

- Provide create, read, update, lifecycle transition, search, event notification, and audit retrieval behavior where the domain lifecycle requires it.
- Publish domain events for state changes that other apps need for projections, workflow triggers, analytics, or customer/partner communication.
- Keep integration retries, idempotency keys, correlation IDs, and external reference IDs visible to operators.

### Data, Control, And Reporting Needs

- Store app-owned operational records in the app's logical database defined in the database setup document.
- Store external IDs, source channel, owner, status reason, timestamps, and relationship references needed for traceability.
- Provide operational metrics for volume, aging, fallout, SLA/OLA status, exception rate, policy overrides, and automation success.
- Support role-based access, tenant/region boundaries, sensitive-data masking, and export controls where applicable.

### First Release Interpretation

For the first release, implement the minimum lifecycle, search, validation, API, event, audit, and operational queue behavior needed for this module to participate in the app's core workflow. Advanced automation, AI assistance, bulk optimization, simulation, and deep analytics can follow after the app proves the core operating loop.

## Module 3: Activation And Configuration

Anchor: `activation-and-configuration`

### Capability Intent

Trigger activation, configuration, suspension, resume, modification, disconnect, rollback, SIM/eSIM profile download, eSIM swap, number-port activation handoff, and evidence capture through controllers, EMS/NMS, SDN/NFV, cloud, SIM/eSIM, and device platforms.

### Primary Personas Supported

- Fulfillment operations lead: monitors in-flight provisioning and SLA risk.
- Provisioning analyst: resolves assignment, activation, and workflow exceptions.
- Activation engineer: manages network/cloud/device activation failures and rollback.
- Order manager: consumes fulfillment milestones and customer-visible status.
- Inventory manager: validates final service/resource state.

### Feature Backlog Candidates

- Trigger activation.
- Configuration.
- Modification.
- SIM/eSIM profile download.
- Number-port activation handoff.
- And evidence capture through controllers.
- And device platforms.

### Feature Groups

| Feature group | Feature detail |
| --- | --- |
| Record and lifecycle management | Create, search, view, update, retire, reinstate, and track lifecycle state for activation and configuration records. Maintain ownership, status reason, timestamps, and relationships to upstream and downstream entities. |
| Validation, policy, and eligibility | Validate activation and configuration changes against catalog rules, customer/account context, serviceability, inventory state, compliance policy, role permissions, and data-quality constraints relevant to this app. |
| Work queues and approvals | Provide queues for draft, pending approval, blocked, exception, fallout, rejected, completed, and archived work. Support assignment, SLA/OLA tracking, escalation, comments, and handoff. |
| Search, timeline, and operational views | Offer filtered search, saved views, dependency views, lifecycle timeline, related orders/tickets/events, and persona-specific dashboards for activation and configuration work. |
| API and event behavior | Expose command, query, and event contracts for activation and configuration so UIs, workflows, partner channels, analytics, and downstream apps do not bypass the owning app. |
| Audit, evidence, and reporting | Capture actor, reason, before/after state, source channel, approval evidence, policy decisions, and reporting measures needed for operations, compliance, and continuous improvement. |

### User Journey Coverage

| Journey | Trigger | App behavior | Successful outcome |
| --- | --- | --- | --- |
| Maintain Activation And Configuration | User creates or updates domain information | Validate context, capture change, publish event, update projections | Accurate activation and configuration state available through APIs |
| Handle Activation And Configuration exception | Conflict, validation failure, policy exception, fallout, or missing dependency | Route to owner, capture evidence, resolve or escalate, notify dependent work | Exception closed with auditable reason and downstream handoff |
| Review Activation And Configuration performance | Supervisor, planner, compliance, or operations user needs visibility | Filter records, inspect trend, export/report, create follow-up task | Actionable operational insight and accountable next step |

### API And Integration Alignment

Related APIs and API areas: [TMF640](../../../../references/tmforum-open-apis/openapi-specs/TMF640_ActivationConfiguration), [TMF702](../../../../references/tmforum-open-apis/openapi-specs/TMF702_ResourceActivationManagement), [TMF664](../../../../references/tmforum-open-apis/openapi-specs/TMF664_ResourceFunctionActivationConfiguration)

Implementation guidance:

- Provide create, read, update, lifecycle transition, search, event notification, and audit retrieval behavior where the domain lifecycle requires it.
- Publish domain events for state changes that other apps need for projections, workflow triggers, analytics, or customer/partner communication.
- Keep integration retries, idempotency keys, correlation IDs, and external reference IDs visible to operators.

### Data, Control, And Reporting Needs

- Store app-owned operational records in the app's logical database defined in the database setup document.
- Store external IDs, source channel, owner, status reason, timestamps, and relationship references needed for traceability.
- Provide operational metrics for volume, aging, fallout, SLA/OLA status, exception rate, policy overrides, and automation success.
- Support role-based access, tenant/region boundaries, sensitive-data masking, and export controls where applicable.

### First Release Interpretation

For the first release, implement the minimum lifecycle, search, validation, API, event, audit, and operational queue behavior needed for this module to participate in the app's core workflow. Advanced automation, AI assistance, bulk optimization, simulation, and deep analytics can follow after the app proves the core operating loop.

## Module 4: Provisioning Workflow

Anchor: `provisioning-workflow`

### Capability Intent

Orchestrate long-running workflows across service orders, resource orders, field tasks, shipments, reservations, activation, billing triggers, inventory updates, approvals, timers, dependencies, and parallel execution.

### Primary Personas Supported

- Fulfillment operations lead: monitors in-flight provisioning and SLA risk.
- Provisioning analyst: resolves assignment, activation, and workflow exceptions.
- Activation engineer: manages network/cloud/device activation failures and rollback.
- Order manager: consumes fulfillment milestones and customer-visible status.
- Inventory manager: validates final service/resource state.

### Feature Backlog Candidates

- Orchestrate long-running workflows across service orders.
- Resource orders.
- Reservations.
- Billing triggers.
- Inventory updates.
- Dependencies.
- And parallel execution.

### Feature Groups

| Feature group | Feature detail |
| --- | --- |
| Record and lifecycle management | Create, search, view, update, retire, reinstate, and track lifecycle state for provisioning workflow records. Maintain ownership, status reason, timestamps, and relationships to upstream and downstream entities. |
| Validation, policy, and eligibility | Validate provisioning workflow changes against catalog rules, customer/account context, serviceability, inventory state, compliance policy, role permissions, and data-quality constraints relevant to this app. |
| Work queues and approvals | Provide queues for draft, pending approval, blocked, exception, fallout, rejected, completed, and archived work. Support assignment, SLA/OLA tracking, escalation, comments, and handoff. |
| Search, timeline, and operational views | Offer filtered search, saved views, dependency views, lifecycle timeline, related orders/tickets/events, and persona-specific dashboards for provisioning workflow work. |
| API and event behavior | Expose command, query, and event contracts for provisioning workflow so UIs, workflows, partner channels, analytics, and downstream apps do not bypass the owning app. |
| Audit, evidence, and reporting | Capture actor, reason, before/after state, source channel, approval evidence, policy decisions, and reporting measures needed for operations, compliance, and continuous improvement. |

### User Journey Coverage

| Journey | Trigger | App behavior | Successful outcome |
| --- | --- | --- | --- |
| Maintain Provisioning Workflow | User creates or updates domain information | Validate context, capture change, publish event, update projections | Accurate provisioning workflow state available through APIs |
| Handle Provisioning Workflow exception | Conflict, validation failure, policy exception, fallout, or missing dependency | Route to owner, capture evidence, resolve or escalate, notify dependent work | Exception closed with auditable reason and downstream handoff |
| Review Provisioning Workflow performance | Supervisor, planner, compliance, or operations user needs visibility | Filter records, inspect trend, export/report, create follow-up task | Actionable operational insight and accountable next step |

### API And Integration Alignment

Related APIs and API areas: [TMF701](../../../../references/tmforum-open-apis/openapi-specs/TMF701_ProcessFlow), [TMF641](../../../../references/tmforum-open-apis/openapi-specs/TMF641_ServiceOrder), [TMF652](../../../../references/tmforum-open-apis/openapi-specs/TMF652_ResourceOrderManagement)

Implementation guidance:

- Provide create, read, update, lifecycle transition, search, event notification, and audit retrieval behavior where the domain lifecycle requires it.
- Publish domain events for state changes that other apps need for projections, workflow triggers, analytics, or customer/partner communication.
- Keep integration retries, idempotency keys, correlation IDs, and external reference IDs visible to operators.

### Data, Control, And Reporting Needs

- Store app-owned operational records in the app's logical database defined in the database setup document.
- Store external IDs, source channel, owner, status reason, timestamps, and relationship references needed for traceability.
- Provide operational metrics for volume, aging, fallout, SLA/OLA status, exception rate, policy overrides, and automation success.
- Support role-based access, tenant/region boundaries, sensitive-data masking, and export controls where applicable.

### First Release Interpretation

For the first release, implement the minimum lifecycle, search, validation, API, event, audit, and operational queue behavior needed for this module to participate in the app's core workflow. Advanced automation, AI assistance, bulk optimization, simulation, and deep analytics can follow after the app proves the core operating loop.

## Module 5: Fulfillment Fallout

Anchor: `fulfillment-fallout`

### Capability Intent

Detect no capacity, reservation conflict, activation failure, field no-access, wrong equipment, design mismatch, inventory discrepancy, partner failure, and billing handoff errors. Manage queues, remediation, retry, cancellation, and escalation.

### Primary Personas Supported

- Fulfillment operations lead: monitors in-flight provisioning and SLA risk.
- Provisioning analyst: resolves assignment, activation, and workflow exceptions.
- Activation engineer: manages network/cloud/device activation failures and rollback.
- Order manager: consumes fulfillment milestones and customer-visible status.
- Inventory manager: validates final service/resource state.

### Feature Backlog Candidates

- Detect no capacity.
- Reservation conflict.
- Activation failure.
- Field no-access.
- Wrong equipment.
- Design mismatch.
- Inventory discrepancy.
- Partner failure.
- And billing handoff errors.
- Manage queues.
- Cancellation.
- And escalation.

### Feature Groups

| Feature group | Feature detail |
| --- | --- |
| Record and lifecycle management | Create, search, view, update, retire, reinstate, and track lifecycle state for fulfillment fallout records. Maintain ownership, status reason, timestamps, and relationships to upstream and downstream entities. |
| Validation, policy, and eligibility | Validate fulfillment fallout changes against catalog rules, customer/account context, serviceability, inventory state, compliance policy, role permissions, and data-quality constraints relevant to this app. |
| Work queues and approvals | Provide queues for draft, pending approval, blocked, exception, fallout, rejected, completed, and archived work. Support assignment, SLA/OLA tracking, escalation, comments, and handoff. |
| Search, timeline, and operational views | Offer filtered search, saved views, dependency views, lifecycle timeline, related orders/tickets/events, and persona-specific dashboards for fulfillment fallout work. |
| API and event behavior | Expose command, query, and event contracts for fulfillment fallout so UIs, workflows, partner channels, analytics, and downstream apps do not bypass the owning app. |
| Audit, evidence, and reporting | Capture actor, reason, before/after state, source channel, approval evidence, policy decisions, and reporting measures needed for operations, compliance, and continuous improvement. |

### User Journey Coverage

| Journey | Trigger | App behavior | Successful outcome |
| --- | --- | --- | --- |
| Maintain Fulfillment Fallout | User creates or updates domain information | Validate context, capture change, publish event, update projections | Accurate fulfillment fallout state available through APIs |
| Handle Fulfillment Fallout exception | Conflict, validation failure, policy exception, fallout, or missing dependency | Route to owner, capture evidence, resolve or escalate, notify dependent work | Exception closed with auditable reason and downstream handoff |
| Review Fulfillment Fallout performance | Supervisor, planner, compliance, or operations user needs visibility | Filter records, inspect trend, export/report, create follow-up task | Actionable operational insight and accountable next step |

### API And Integration Alignment

Related APIs and API areas: [TMF641](../../../../references/tmforum-open-apis/openapi-specs/TMF641_ServiceOrder), [TMF652](../../../../references/tmforum-open-apis/openapi-specs/TMF652_ResourceOrderManagement), [TMF621](../../../../references/tmforum-open-apis/openapi-specs/TMF621_TroubleTicket)

Implementation guidance:

- Provide create, read, update, lifecycle transition, search, event notification, and audit retrieval behavior where the domain lifecycle requires it.
- Publish domain events for state changes that other apps need for projections, workflow triggers, analytics, or customer/partner communication.
- Keep integration retries, idempotency keys, correlation IDs, and external reference IDs visible to operators.

### Data, Control, And Reporting Needs

- Store app-owned operational records in the app's logical database defined in the database setup document.
- Store external IDs, source channel, owner, status reason, timestamps, and relationship references needed for traceability.
- Provide operational metrics for volume, aging, fallout, SLA/OLA status, exception rate, policy overrides, and automation success.
- Support role-based access, tenant/region boundaries, sensitive-data masking, and export controls where applicable.

### First Release Interpretation

For the first release, implement the minimum lifecycle, search, validation, API, event, audit, and operational queue behavior needed for this module to participate in the app's core workflow. Advanced automation, AI assistance, bulk optimization, simulation, and deep analytics can follow after the app proves the core operating loop.

## Module 6: Inventory Update And Handover

Anchor: `inventory-update-and-handover`

### Capability Intent

Convert planned/reserved resources to active assignments, update product/service/resource inventory, capture activation and installation evidence, and notify order, billing, assurance, and customer channels.

### Primary Personas Supported

- Fulfillment operations lead: monitors in-flight provisioning and SLA risk.
- Provisioning analyst: resolves assignment, activation, and workflow exceptions.
- Activation engineer: manages network/cloud/device activation failures and rollback.
- Order manager: consumes fulfillment milestones and customer-visible status.
- Inventory manager: validates final service/resource state.

### Feature Backlog Candidates

- Convert planned/reserved resources to active assignments.
- Update product/service/resource inventory.
- Capture activation and installation evidence.
- And notify order.
- And customer channels.

### Feature Groups

| Feature group | Feature detail |
| --- | --- |
| Record and lifecycle management | Create, search, view, update, retire, reinstate, and track lifecycle state for inventory update and handover records. Maintain ownership, status reason, timestamps, and relationships to upstream and downstream entities. |
| Validation, policy, and eligibility | Validate inventory update and handover changes against catalog rules, customer/account context, serviceability, inventory state, compliance policy, role permissions, and data-quality constraints relevant to this app. |
| Work queues and approvals | Provide queues for draft, pending approval, blocked, exception, fallout, rejected, completed, and archived work. Support assignment, SLA/OLA tracking, escalation, comments, and handoff. |
| Search, timeline, and operational views | Offer filtered search, saved views, dependency views, lifecycle timeline, related orders/tickets/events, and persona-specific dashboards for inventory update and handover work. |
| API and event behavior | Expose command, query, and event contracts for inventory update and handover so UIs, workflows, partner channels, analytics, and downstream apps do not bypass the owning app. |
| Audit, evidence, and reporting | Capture actor, reason, before/after state, source channel, approval evidence, policy decisions, and reporting measures needed for operations, compliance, and continuous improvement. |

### User Journey Coverage

| Journey | Trigger | App behavior | Successful outcome |
| --- | --- | --- | --- |
| Maintain Inventory Update And Handover | User creates or updates domain information | Validate context, capture change, publish event, update projections | Accurate inventory update and handover state available through APIs |
| Handle Inventory Update And Handover exception | Conflict, validation failure, policy exception, fallout, or missing dependency | Route to owner, capture evidence, resolve or escalate, notify dependent work | Exception closed with auditable reason and downstream handoff |
| Review Inventory Update And Handover performance | Supervisor, planner, compliance, or operations user needs visibility | Filter records, inspect trend, export/report, create follow-up task | Actionable operational insight and accountable next step |

### API And Integration Alignment

Related APIs and API areas: [TMF637](../../../../references/tmforum-open-apis/openapi-specs/TMF637_ProductInventory), [TMF638](../../../../references/tmforum-open-apis/openapi-specs/TMF638_ServiceInventory), [TMF639](../../../../references/tmforum-open-apis/openapi-specs/TMF639_ResourceInventory)

Implementation guidance:

- Provide create, read, update, lifecycle transition, search, event notification, and audit retrieval behavior where the domain lifecycle requires it.
- Publish domain events for state changes that other apps need for projections, workflow triggers, analytics, or customer/partner communication.
- Keep integration retries, idempotency keys, correlation IDs, and external reference IDs visible to operators.

### Data, Control, And Reporting Needs

- Store app-owned operational records in the app's logical database defined in the database setup document.
- Store external IDs, source channel, owner, status reason, timestamps, and relationship references needed for traceability.
- Provide operational metrics for volume, aging, fallout, SLA/OLA status, exception rate, policy overrides, and automation success.
- Support role-based access, tenant/region boundaries, sensitive-data masking, and export controls where applicable.

### First Release Interpretation

For the first release, implement the minimum lifecycle, search, validation, API, event, audit, and operational queue behavior needed for this module to participate in the app's core workflow. Advanced automation, AI assistance, bulk optimization, simulation, and deep analytics can follow after the app proves the core operating loop.

## Critical Feature Review Enhancements (2026-06-14)

### Critical Assessment

The baseline has the right execution modules, but fulfillment needs more operational control detail. This app must coordinate service/resource order execution, workflow state, reservation and assignment checks, activation requests/responses, retries, rollback, technical fallout, and handover evidence without becoming the final inventory master.

### Enhancements To Add

| Enhancement | Modules | Implementation need |
| --- | --- | --- |
| Fulfillment execution control tower | Service Order Execution; Resource Order Execution | Track service/resource order state, customer promise, SLA risk, dependency owner, reservation/assignment status, field dependency, and downstream milestones. |
| Provisioning plan and dependency board | Provisioning Workflow | Show workflow steps, automated/manual tasks, prerequisites, adapter target, timeout, retry policy, compensation path, and blocked dependency. |
| Activation command cockpit | Activation And Configuration | Manage activation request, controller target, payload version, response, monitor state, retry, rollback, correlation ID, and evidence. |
| Rollback and compensation workflow | Activation And Configuration; Provisioning Workflow | Define safe rollback, partial activation, cleanup, inventory reversal request, customer status, and billing/order notification. |
| Technical fallout case board | Fulfillment Fallout | Classify assignment, activation, controller, inventory, design, field, partner, serviceability, or order fallout with owner, severity, retry/waiver, and customer impact. |
| Inventory handover package | Inventory Update And Handover | Package final service/resource state, activation evidence, field dependencies, controller evidence, before/after state, confidence, and acceptance decision for Inventory And Topology. |
| Customer/order milestone publisher | Service Order Execution; Inventory Update And Handover | Publish safe fulfillment milestones to Order Management, care, self-care, billing, assurance, and partner apps. |

### Required Screens

| Screen | Required behavior |
| --- | --- |
| Activation control tower | In-flight orders, SLA risk, dependency status, activation state, fallout, retry queues, and handover readiness. |
| Workflow instance detail | Steps, owners, timers, adapter calls, prerequisites, compensation path, evidence, and event timeline. |
| Activation request detail | Payload, controller, request/response, monitor state, retry history, rollback status, and evidence links. |
| Technical fallout workspace | Cause, impacted service/resource/order/customer, owner, retry action, rollback option, inventory impact, and closure evidence. |
| Inventory handover review | Proposed inventory changes, activation evidence, field evidence, confidence, acceptance/rejection, and rework route. |

### Open-Source Decision Points

| Need | Candidate options | Decision prompt |
| --- | --- | --- |
| Fulfillment workflow orchestration | Spring state tables; Flowable/Camunda Community; Temporal-like open-source workflow engine | Ask before adding a workflow engine; use one only if orchestration, timers, and compensation are too complex for Spring/PostgreSQL. |
| Adapter/runtime integration | Spring adapters; Apache Camel; event-driven adapters | Keep controller adapters behind Spring services; ask before adding integration runtime. |
| Event streaming | PostgreSQL outbox; Kafka-compatible broker; RabbitMQ | Start with outbox; add broker only if activation/order event volume requires it. |
| Evidence storage | PostgreSQL metadata plus object adapter; MinIO | Ask before storing large controller logs, test artifacts, or handover packs outside PostgreSQL. |

### API/Event/Data Additions

| Area | Additions |
| --- | --- |
| APIs | Service/resource order accept, workflow start/pause/resume/cancel, activation request/monitor/retry/rollback, fallout open/resolve, handover submit, milestone publish. |
| Events | `ServiceOrderExecutionChanged`, `ResourceOrderExecutionChanged`, `ProvisioningWorkflowBlocked`, `ActivationRequested`, `ActivationCompleted`, `ActivationRollbackStarted`, `FulfillmentFalloutRaised`, `InventoryHandoverReady`, `FulfillmentMilestonePublished`. |
| Data | Fulfillment owns execution state and evidence; Inventory And Topology owns accepted final inventory after handover acceptance. |

### First Release Scope

Include execution control tower, workflow instance detail, activation request/response capture, retry/rollback baseline, technical fallout board, and inventory handover package. Defer broad adapter marketplace, advanced workflow engine adoption, and autonomous remediation.
