# OSS Engineering, Inventory, And Fulfillment Tech And UI Guidance

This document guides implementation of the OSS Engineering, Inventory, And Fulfillment suite. It applies the shared [Technology Stack Guidance](../../technology-stack-guidance.md) and [TelcoSuite UI Design System](../../telcosuite-ui-design-system.md) to service/resource design, inventory, topology, fulfillment, activation, field work, stock, and logistics apps.

## Apps Covered

| App | Implementation focus |
| --- | --- |
| Service And Resource Design Studio | Service/resource specifications, realization rules, compatibility, activation templates, and certification readiness |
| Inventory And Topology | Product/service/resource inventory, topology, location bindings, reconciliation, reservation, assignment, and lifecycle state |
| Fulfillment And Activation Control Tower | Service order, resource order, provisioning, activation, technical fallout, rollback, and handover evidence |
| Field Work, Stock, And Logistics | Work orders, appointments, dispatch, field execution, stock, shipment, RMA, and logistics handoff |

## Recommended Build Order

1. Service And Resource Design Studio.
2. Inventory And Topology.
3. Fulfillment And Activation Control Tower.
4. Field Work, Stock, And Logistics.

This order establishes technical design and inventory truth before execution, activation, and field logistics flows.

## Suite Technology Posture

Use Angular, Spring Boot, and PostgreSQL as the default implementation stack. PostgreSQL should own design definitions, inventory state, service/resource relationships, order execution records, activation evidence, work orders, appointments, stock, and logistics state unless a documented decision approves another open source store.

OSS apps may need specialized topology, geospatial, workflow, adapter, offline, or high-volume event capabilities. Do not add those technologies automatically. If the default stack becomes a poor fit, present open source options with pros and cons and ask for a decision.

## Suite UI Posture

The suite should feel like an engineering and operations workbench: compact records for high-volume execution, rich topology and hierarchy views for investigation, and clear lifecycle state for design, inventory, fulfillment, activation, and field work.

Use full-screen adapted shell patterns for topology maps, design canvases, field dispatch boards, and activation control views while preserving product identity, navigation escape, theme, user controls, and accessibility.

## Shared Suite Components

| Shared pattern | Use across apps |
| --- | --- |
| Service/resource hierarchy viewer | Design, inventory, topology, impact analysis, fulfillment, and assurance handoff |
| Inventory entity header | Product, service, resource, location, assignment, reservation, lifecycle, and reconciliation status |
| Topology canvas shell | Network, cloud, device, path, dependency, and service topology views |
| Fulfillment lifecycle tracker | Product order reference, service order, resource order, provisioning, activation, rollback, and handover state |
| Fallout and exception panel | Technical fallout, retry, compensation, dependency, impact, and owner queue |
| Field work card | Appointment, work order, technician, skill, route, stock, evidence, and closure state |
| Stock and logistics summary | Warehouse, item, shipment, RMA, reservation, transfer, and reconciliation state |

## Standard Page Templates

Use TelcoSuite page templates consistently:

- List and workbench for designs, inventory entities, reservations, assignments, orders, fallout, work orders, appointments, stock, and shipments.
- Record detail for service/resource specs, inventory entities, orders, activation tasks, appointments, and logistics records.
- Wizard or guided flow for design publication, reservation, assignment, fulfillment decomposition, activation rollback, and field closure.
- Dashboard for inventory health, order execution, activation success, fallout, field capacity, and stock/logistics performance.
- Full-screen operational view for topology, maps, path design, dispatch boards, and activation control.

## Data, API, And Integration Guidance

- Keep service/resource design, inventory, fulfillment, activation, field, stock, and logistics write models private to their owning apps.
- Use APIs and events for cross-app handoffs from commercial orders, planning, assurance, and field execution.
- Publish lifecycle events for service/resource specs, inventory changes, reservations, assignments, orders, activation, work orders, stock movements, and reconciliation outcomes.
- Maintain traceability from commercial product order to service/resource execution, inventory update, activation evidence, field evidence, and handover.
- Do not allow direct writes from external network controllers, discovery tools, or field systems into app-owned databases.

## Candidate Extra Technology Decision Areas

These categories may require a decision when implementation starts:

| Need | Why it may arise | Decision rule |
| --- | --- | --- |
| Topology or graph analysis | Service/resource dependency, impact, path, and connectivity analysis | Start with PostgreSQL relationships; ask before adding graph technology. |
| Geospatial and map workflows | Location, plant, route, field, coverage, and site workflows | Evaluate open source geospatial options before adoption. |
| Workflow or orchestration | Fulfillment, activation, rollback, compensation, and field processes | Prefer Spring workflow tables first; ask before adding a workflow engine. |
| Adapter/runtime integration | Network, cloud, device, warehouse, and field systems | Keep adapters behind Spring services; ask before adding integration runtimes. |
| Offline field capability | Mobile field work in low-connectivity environments | Ask before adding offline sync, local storage, or mobile-specific frameworks. |

## App Readiness Checklist

- Uses shared hierarchy, topology, lifecycle, fallout, field, and stock/logistics patterns.
- Defines app-owned write models and consumed commercial, planning, assurance, and platform projections.
- Provides compact operational workbenches for fulfillment, inventory, fallout, field, and logistics teams.
- Supports full-screen canvases only where maps, topology, dispatch, or activation control require them.
- Records traceability, evidence, before/after inventory state, retries, rollback, and reconciliation outcomes.
- Supports desktop, tablet, and mobile field execution patterns where relevant.
- Documents any non-primary technology need with open source options, pros and cons, and a decision request.
