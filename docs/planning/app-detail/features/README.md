# Fulfillment And Activation Control Tower Feature Specifications

Reviewed: 2026-06-07

This folder contains detailed feature specifications for the Fulfillment And Activation Control Tower app. The app owns service order execution state, resource order execution state, provisioning workflow state, activation requests/responses/evidence, readiness simulation results, fulfillment fallout, rollback/compensation transactions, service validation/turn-up evidence, customer/partner/off-net activation coordination, and fulfillment inventory handover evidence. The app does not own commercial product orders, active product/service/resource inventory, field work execution, stock/warehouse state, billing records, customer records, partner lifecycle, assurance incidents, or platform security records.

Parent app: [Fulfillment And Activation Control Tower](../README.md)

## Feature Specification Index

| Feature specification | Fulfillment and activation intent | Primary TMF anchors | Gap priority |
| --- | --- | --- | --- |
| [Service Order Execution](service-order-execution.md) | Execute service orders, service order items, dependencies, transitions, due dates, exceptions, design selection, resource reservation, activation, field dependency, service validation, and inventory handover after commercial order decomposition. | TMF641, TMF701, TMF622, TMF716 | Core |
| [Resource Order Execution](resource-order-execution.md) | Execute resource assignment, install, configure, modify, migrate, release, pool selection, reservation conversion, inventory update request, field work, shipment, and activation for network, cloud, CPE, SIM/eSIM, numbers, IP, licenses, and partner/off-net resources. | TMF652, TMF716, TMF685, TMF639, TMF697, TMF684 | Core |
| [Activation And Configuration](activation-and-configuration.md) | Trigger activation, configuration, suspension, resume, modification, disconnect, rollback, SIM/eSIM profile download, eSIM swap, number-port activation handoff, and evidence capture through controllers, EMS/NMS, SDN/NFV, cloud, SIM/eSIM, and device platforms. | TMF640, TMF702, TMF664, TMF641, TMF652 | Core |
| [Provisioning Workflow](provisioning-workflow.md) | Orchestrate long-running workflows across service orders, resource orders, field tasks, shipments, reservations, activation, billing triggers, inventory updates, approvals, timers, dependencies, parallel execution, retry, cancellation, and compensation. | TMF701, TMF641, TMF652, TMF646, TMF700, TMF684 | Core |
| [Fulfillment Fallout](fulfillment-fallout.md) | Detect and resolve no capacity, reservation conflict, activation failure, field no-access, wrong equipment, design mismatch, inventory discrepancy, partner failure, billing handoff error, timeout, and customer-impacting fulfillment exception. | TMF641, TMF652, TMF621, TMF701, TMF646 | Core |
| [Inventory Update And Handover](inventory-update-and-handover.md) | Convert planned or reserved resources to active assignment handover requests, capture activation and installation evidence, submit product/service/resource inventory updates for acceptance, and notify order, billing, assurance, customer, and partner channels. | TMF637, TMF638, TMF639, TMF641, TMF652 | Core |
| [Feasibility Readiness And Fulfillment Simulation](feasibility-readiness-and-fulfillment-simulation.md) | Validate order feasibility, resource readiness, activation readiness, appointment dependencies, stock/shipment needs, partner/off-net dependencies, rollback exposure, and dry-run execution before fulfillment starts. | TMF622, TMF641, TMF652, TMF645, TMF716, TMF646 | Critical |
| [Activation Rollback And Compensation](activation-rollback-and-compensation.md) | Provide safe rollback, compensation transactions, state repair, partial activation control, customer/order communication, and post-failure audit when activation or provisioning fails. | TMF640, TMF641, TMF652, TMF622, TMF681 | Critical |
| [Service Validation Test And Turn-Up](service-validation-test-and-turn-up.md) | Run test-and-turn-up, service validation, quality checks, assurance readiness, customer/enterprise acceptance, and completion gates before an order is marked fulfilled. | TMF653, TMF707, TMF657, TMF638, TMF641 | Critical |
| [Customer Partner And Offnet Activation](customer-partner-and-offnet-activation.md) | Coordinate customer self-activation, eSIM/device activation, partner tasks, off-net last-mile work, wholesale dependencies, external service readiness, communication, delivery evidence, and settlement evidence handoff. | TMF640, TMF641, TMF652, TMF622, TMF669, TMF681 | Critical |

## App-Level Control Scope

- Fulfillment And Activation Control Tower masters execution evidence: service/resource order execution, provisioning workflow, activation/configuration, readiness simulation, fallout, rollback/compensation, service validation, partner/off-net activation coordination, and inventory handover packages.
- Fulfillment And Activation Control Tower references BSS product order, service/resource design, resource reservations, active inventory, field work, stock, shipment, activation controllers, partner systems, billing, customer communication, assurance, platform policy, and data products through APIs, events, workflow tasks, adapters, or evidence packages.
- Fulfillment And Activation Control Tower must never become the product order, final inventory, work order, warehouse/stock, billing, customer, partner, assurance incident, or platform policy master.

## Cross-App Handoffs To Prove

| Handoff | Required evidence |
| --- | --- |
| Order to fulfillment | Product order reference, service/resource order IDs, decomposition source, customer-impact flag, SLA/OLA target, dependency graph, and idempotency key. |
| Fulfillment to inventory | Reservation/assignment evidence, activation response, field/partner/test evidence, handover package, acceptance/rejection state, and replay metadata. |
| Fulfillment to field/stock/logistics | Work order, appointment, stock, shipment, no-access, wrong-equipment, and installation evidence with owning queue and due date. |
| Fulfillment to activation/controller | Activation template version, command payload, privileged approval, controller response, retry/rollback evidence, and adapter trace. |
| Fulfillment to order/billing/customer/partner | Milestone state, promise-date risk, partial activation, rollback/compensation, billing trigger, customer/partner communication evidence, and completion status. |
| Fulfillment to assurance/data/compliance | Service validation result, monitoring readiness, activation evidence, fallout metrics, retention/legal hold, privileged action evidence, and data lineage. |

## How To Use These Feature Specs

- Use each feature specification as the starting point for epics, user stories, API contracts, event contracts, activation adapters, partner callbacks, operational dashboards, runbooks, and QA evidence.
- Confirm the master entity, referenced entities, TMF API fit, non-TMF extension APIs, events, private database boundary, idempotency, rollback/compensation behavior, and consumer revalidation before implementation starts.
- Keep app-owned writes inside the Fulfillment And Activation Control Tower boundary; cross-app work must use APIs, events, governed projections, workflow tasks, activation adapters, evidence packages, or certified data products.
- Validate every feature against order-to-activate, plan-to-build handoff, lead-to-order feasibility, partner/off-net delivery evidence, trouble-to-resolve support, rollback/compensation, and govern-to-comply activation/inventory evidence journeys.

## Feature Detail Review Alignment (2026-06-14)

Source: [Suite Feature Detail Review](../../feature-detail-review.md) and [Critical Feature Review Enhancements](../modules-and-features.md#critical-feature-review-enhancements-2026-06-14).

The 2026-06-14 review upgrades this app feature set with required scope: service and resource order execution, workflow orchestration, activation evidence, rollback and compensation, fallout, and inventory handover.

Apply this scope when refining the feature specifications in this folder:

- Add or update epics, stories, UI workbenches, APIs, events, app-owned data fields, DDL gaps, test cases, observability, runbooks, and definition-of-done evidence for the review scope.
- Preserve the app data ownership boundary. Cross-app access must use APIs, events, workflow tasks, governed projections, or certified data products rather than direct database sharing.
- If this scope needs technology beyond Angular, Spring Boot, PostgreSQL, and PrimeNG, offer open-source options with pros, cons, and a recommendation before implementation.
