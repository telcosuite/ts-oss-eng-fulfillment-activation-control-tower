# Fulfillment And Activation Control Tower Detail Pack

Reviewed: 2026-06-06

This folder expands the concise app overview into build-ready module, feature, persona, and user journey planning. The concise source overview remains at [fulfillment-activation-control-tower.md](../fulfillment-activation-control-tower.md).

Suite: OSS Engineering, Inventory, And Fulfillment

## Build Intent

Execute service orders, resource orders, activation, provisioning workflow, fallout handling, and inventory handover after commercial order decomposition.

## Detail Documents

- [Modules And Features](modules-and-features.md)
- [Feature Specifications](features/README.md)
- [Personas And User Journeys](personas-and-user-journeys.md)

## Primary Personas

- Fulfillment operations lead: monitors in-flight provisioning and SLA risk.
- Provisioning analyst: resolves assignment, activation, and workflow exceptions.
- Activation engineer: manages network/cloud/device activation failures and rollback.
- Order manager: consumes fulfillment milestones and customer-visible status.
- Inventory manager: validates final service/resource state.

## Core Operating Flow

1. Receive service and resource orders from order decomposition or operational workflows.
2. Select service design, reserve and assign resources, and create activation or field/logistics tasks.
3. Orchestrate provisioning across automated systems and manual work queues.
4. Trigger activation/configuration and capture responses, retries, rollback, and evidence.
5. Detect fulfillment fallout and route correction actions.
6. Update product, service, and resource inventory and notify order, billing, assurance, and customer channels.

## Module Map

| Module | Feature focus | Related APIs |
| --- | --- | --- |
| Service Order Execution | Execute service orders, service order items, dependencies, transitions, due dates, exceptions, design selection, resource reservation, activation, and inventory update. | [TMF641](../../../../references/tmforum-open-apis/openapi-specs/TMF641_ServiceOrder) |
| Resource Order Execution | Execute resource assignment, install, configure, modify, migrate, release, pool selection, reservation, inventory update, field work, shipping, and activation for network, cloud, CPE, SIM/eSIM, numbers, IP, and licenses. | [TMF652](../../../../references/tmforum-open-apis/openapi-specs/TMF652_ResourceOrderManagement) |
| Activation And Configuration | Trigger activation, configuration, suspension, resume, modification, disconnect, rollback, SIM/eSIM profile download, eSIM swap, number-port activation handoff, and evidence capture through controllers, EMS/NMS, SDN/NFV, cloud, SIM/eSIM, and device platforms. | [TMF640](../../../../references/tmforum-open-apis/openapi-specs/TMF640_ActivationConfiguration), [TMF702](../../../../references/tmforum-open-apis/openapi-specs/TMF702_ResourceActivationManagement), [TMF664](../../../../references/tmforum-open-apis/openapi-specs/TMF664_ResourceFunctionActivationConfiguration) |
| Provisioning Workflow | Orchestrate long-running workflows across service orders, resource orders, field tasks, shipments, reservations, activation, billing triggers, inventory updates, approvals, timers, dependencies, and parallel execution. | [TMF701](../../../../references/tmforum-open-apis/openapi-specs/TMF701_ProcessFlow), [TMF641](../../../../references/tmforum-open-apis/openapi-specs/TMF641_ServiceOrder), [TMF652](../../../../references/tmforum-open-apis/openapi-specs/TMF652_ResourceOrderManagement) |
| Fulfillment Fallout | Detect no capacity, reservation conflict, activation failure, field no-access, wrong equipment, design mismatch, inventory discrepancy, partner failure, and billing handoff errors | [TMF641](../../../../references/tmforum-open-apis/openapi-specs/TMF641_ServiceOrder), [TMF652](../../../../references/tmforum-open-apis/openapi-specs/TMF652_ResourceOrderManagement), [TMF621](../../../../references/tmforum-open-apis/openapi-specs/TMF621_TroubleTicket) |
| Inventory Update And Handover | Convert planned/reserved resources to active assignments, update product/service/resource inventory, capture activation and installation evidence, and notify order, billing, assurance, and customer channels. | [TMF637](../../../../references/tmforum-open-apis/openapi-specs/TMF637_ProductInventory), [TMF638](../../../../references/tmforum-open-apis/openapi-specs/TMF638_ServiceInventory), [TMF639](../../../../references/tmforum-open-apis/openapi-specs/TMF639_ResourceInventory) |

## Data Ownership

Owns service order execution state, resource order execution state, provisioning workflow state, activation requests/responses, fulfillment fallout, and fulfillment handover evidence. Inventory final state is mastered by Inventory And Topology.

## First Release Scope

Deliver service/resource order execution, basic provisioning workflow, activation adapter pattern, fallout queue, and inventory handover. Add advanced rollback, self-healing, and multi-domain intent orchestration later.

## Build Notes

- Treat this app as an API-first product surface. UI screens, automations, partner access, and internal integrations should use the same app-owned APIs.
- Keep the app database private to this app or its module owners. Other apps should consume APIs, events, governed read models, or data products.
- Create backlog items at feature level, but preserve module ownership so roadmap, permissions, observability, and data stewardship remain clear.

## Implementation Guidance

- [Implementation File Usage](implementation-file-usage.md)
