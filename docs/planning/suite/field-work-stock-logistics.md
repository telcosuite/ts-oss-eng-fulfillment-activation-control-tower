# Field Work, Stock, And Logistics App

## Purpose

Coordinate appointments, field work, dispatch, mobile execution, warehouse stock, shipments, returns, and field-to-inventory handover.

## Primary Personas

- Dispatcher: schedules technicians and balances work queues.
- Field technician: executes install, repair, survey, migration, pickup, maintenance, and decommission tasks.
- Warehouse user: manages serialized equipment, CPE, devices, spares, and van stock.
- Logistics coordinator: tracks shipping, delivery, returns, and exceptions.
- Customer/care user: sees appointment and shipment status.

## Core Workflow

1. Schedule appointment and reserve time slot.
2. Create work order with skills, tasks, materials, access notes, safety constraints, and customer/site context.
3. Dispatch technician or vendor based on location, skills, SLA, materials, and availability.
4. Reserve, ship, transfer, consume, return, or reconcile stock.
5. Capture field evidence, serials, photos, signatures, tests, and acceptance.
6. Handover actual installed state to inventory and fulfillment.

## Module Capability Matrix

| Module | Detailed Capabilities | Related APIs |
| --- | --- | --- |
| Appointment Management | Schedule installation, repair, survey, migration, pickup, maintenance, and decommission appointments. Manage slots, customer availability, technician availability, location constraints, status, and rescheduling. | [TMF646](../../../references/tmforum-open-apis/openapi-specs/TMF646_AppointmentManagement) |
| Work Order | Create and manage field and engineering work orders, technician/vendor assignment, task steps, required skills, materials, access notes, safety constraints, photos, signatures, and completion evidence. | [TMF697](../../../references/tmforum-open-apis/openapi-specs/TMF697_Work_Order) |
| Dispatch And Field Execution | Optimize technician assignment by skill, location, availability, SLA, materials, and appointment windows. Support mobile workflows, offline capture, evidence upload, no-access, incomplete work, rework, and escalation. | [TMF697](../../../references/tmforum-open-apis/openapi-specs/TMF697_Work_Order), [TMF646](../../../references/tmforum-open-apis/openapi-specs/TMF646_AppointmentManagement) |
| Stock And Warehouse | Manage stock items, serialized equipment, CPE, SIM/eSIM, spare parts, devices, warehouse stock, van stock, reservations, transfers, returns, damaged items, consumed materials, and reconciliation. | [TMF687](../../../references/tmforum-open-apis/openapi-specs/TMF687_StockManagement) |
| Shipping And Shipment Tracking | Create shipping orders for CPE, devices, cards, equipment, and install material. Track carrier references, delivery evidence, exceptions, returns, and links to orders/work/stock/customer notifications. | [TMF700](../../../references/tmforum-open-apis/openapi-specs/TMF700_ShippingOrder), [TMF684](../../../references/tmforum-open-apis/openapi-specs/TMF684_ShipmentTracking) |
| Field-To-Inventory Handover | Convert field evidence into inventory updates, installed equipment, serial numbers, port assignments, locations, photos, test results, customer acceptance, and mismatch tasks. | [TMF639](../../../references/tmforum-open-apis/openapi-specs/TMF639_ResourceInventory), [TMF697](../../../references/tmforum-open-apis/openapi-specs/TMF697_Work_Order), [TMF687](../../../references/tmforum-open-apis/openapi-specs/TMF687_StockManagement) |

## Data Ownership

Owns appointment state, dispatch plans, work order execution state, field evidence, stock operational records, shipment tracking, and handover packages. Inventory owns final resource state after acceptance.

## First Release Scope

Deliver appointment, work order, dispatch board, stock reservation, shipment tracking, and field evidence handover. Add route optimization, offline mobile depth, contractor portals, and advanced stock forecasting later.

