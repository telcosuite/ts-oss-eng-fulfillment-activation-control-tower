# OSS Engineering, Inventory, And Fulfillment Data Model

This document defines the suite-level data model for OSS Engineering, Inventory, And Fulfillment. It translates the product-suite data mastery decisions into one PostgreSQL suite database with app-owned schemas and TMF-aligned entity ownership.

## Suite Database Layout

Physical database: `ts_oss_engineering_fulfillment`

| App | Owning schema | Primary data role |
| --- | --- | --- |
| Service And Resource Design Studio | `service_resource_design` | Service/resource specifications, realization rules, compatibility, templates |
| Inventory And Topology | `inventory_topology` | Product, service, resource inventory, topology, pools, reservations, assignments |
| Fulfillment And Activation Control Tower | `fulfillment_activation` | Service/resource order execution, provisioning, activation, fallout, handover |
| Field Work, Stock, And Logistics | `field_stock_logistics` | Work orders, appointments, dispatch, stock, shipment, field evidence |

## Data Modeling Rules

- Separate definition data, operational inventory instance data, execution transaction data, and field/logistics evidence.
- Inventory And Topology owns accepted operational product/service/resource inventory and actual topology.
- Fulfillment may request inventory changes but does not master final inventory state.
- Network controllers, discovery tools, activation platforms, and field systems provide input or evidence; they do not write directly to app schemas.
- Identifier resources, reservations, assignments, and reconciliations require strong audit and lifecycle state.

## Entity Mastery Matrix

| Entity family | Master app | Owning schema | TMF API anchors | Main consumers | Data role |
| --- | --- | --- | --- | --- | --- |
| Service specification | Service And Resource Design Studio | `service_resource_design` | TMF633 | Product mapping, fulfillment, inventory | Master definition |
| Resource specification | Service And Resource Design Studio | `service_resource_design` | TMF634, TMF730 | Inventory, activation, field, planning | Master definition for physical, logical, network, compute, software, CPE, SIM/eSIM, number, IP, and license templates |
| Product-service-resource realization rule | Service And Resource Design Studio | `service_resource_design` | TMF620, TMF633, TMF634, TMF701 | Order decomposition, CPQ, fulfillment | Master rule |
| Technical compatibility rule | Service And Resource Design Studio | `service_resource_design` | TMF645, TMF679 | CPQ, design, fulfillment | Master rule |
| Entity template/catalog extension | Service And Resource Design Studio | `service_resource_design` | TMF662 | Inventory, design, platform | Master metadata |
| Installed product inventory | Inventory And Topology | `inventory_topology` | TMF637 | Billing, care, assurance, self-care | Master instance |
| Service inventory | Inventory And Topology | `inventory_topology` | TMF638 | Fulfillment, assurance, self-care | Master instance |
| Resource inventory | Inventory And Topology | `inventory_topology` | TMF639, TMF703 | Fulfillment, assurance, planning | Master instance |
| Inventory location binding | Inventory And Topology | `inventory_topology` | TMF639, TMF674, TMF675 | Field, assurance, planning | Master binding/reference |
| Topology relationship | Inventory And Topology | `inventory_topology` | TMF638, TMF639, TMF703 | Assurance, design, fulfillment | Master actual topology |
| Connectivity path and circuit | Inventory And Topology | `inventory_topology` | TMF638, TMF639, TMF703 | Assurance, fulfillment, partner | Master actual path |
| Resource pool | Inventory And Topology | `inventory_topology` | TMF685 | Capacity, fulfillment, CPQ | Master pool |
| Operational inventory plan/readiness | Inventory And Topology | `inventory_topology` | TMF685, TMF716, TMF639, TMF771 | Fulfillment, capacity, order | Master operational readiness |
| Identifier resource | Inventory And Topology | `inventory_topology` | TMF639, TMF685, TMF716, TMF640 | Fulfillment, activation, billing | Master number, IP, SIM/eSIM, and license identifier resource |
| Resource reservation | Inventory And Topology | `inventory_topology` | TMF716, TMF685 | Fulfillment, CPQ, order | Master reservation |
| Resource assignment | Inventory And Topology | `inventory_topology` | TMF639, TMF716 | Fulfillment, activation, assurance | Master assignment |
| Number portability support state | Inventory And Topology | `inventory_topology` | TMF639, TMF685, TMF716, TMF640 | Order, fulfillment, billing, assurance | Master identifier lifecycle support state |
| eSIM profile lifecycle state | Inventory And Topology | `inventory_topology` | TMF639, TMF685, TMF716, TMF640 | Fulfillment, activation, billing, care | Master SIM/eSIM lifecycle state |
| Inventory reconciliation record | Inventory And Topology | `inventory_topology` | TMF639, TMF703, TMF697 | Assurance, field, build | Master evidence |
| Discovered resource/service state | Inventory And Topology | `inventory_topology` | TMF638, TMF639, TMF703 | Assurance, fulfillment, planning | Staged discovery evidence before acceptance |
| Migration and decommissioning state | Inventory And Topology | `inventory_topology` | TMF637, TMF638, TMF639, TMF655, TMF681 | Change, billing, field, care | Master lifecycle state |
| Service order execution state | Fulfillment And Activation Control Tower | `fulfillment_activation` | TMF641 | Order, inventory, assurance | Master execution |
| Resource order execution state | Fulfillment And Activation Control Tower | `fulfillment_activation` | TMF652 | Inventory, activation, field | Master execution |
| Activation request/response/evidence | Fulfillment And Activation Control Tower | `fulfillment_activation` | TMF640, TMF702, TMF664 | Inventory, assurance, order | Master evidence |
| Provisioning workflow state | Fulfillment And Activation Control Tower | `fulfillment_activation` | TMF701, TMF641, TMF652 | Workflow, inventory, order | Master execution state |
| Fulfillment fallout | Fulfillment And Activation Control Tower | `fulfillment_activation` | TMF641, TMF652, TMF621 | Order, care, assurance | Master technical exception |
| Fulfillment handover evidence | Fulfillment And Activation Control Tower | `fulfillment_activation` | TMF637, TMF638, TMF639 | Inventory | Evidence and handoff |
| Appointment | Field Work, Stock, And Logistics | `field_stock_logistics` | TMF646 | Order, care, self-care, field | Master schedule |
| Work order | Field Work, Stock, And Logistics | `field_stock_logistics` | TMF697 | Build, fulfillment, assurance, change | Master execution |
| Dispatch plan and field evidence | Field Work, Stock, And Logistics | `field_stock_logistics` | TMF697, TMF646 | Inventory, fulfillment, assurance | Master evidence |
| Stock item and stock balance | Field Work, Stock, And Logistics | `field_stock_logistics` | TMF687 | Field, fulfillment, finance boundary | Master operational stock |
| Shipping order and tracking | Field Work, Stock, And Logistics | `field_stock_logistics` | TMF700, TMF684 | Order, field, customer | Master shipment context |
| Field-to-inventory handover package | Field Work, Stock, And Logistics | `field_stock_logistics` | TMF639, TMF697, TMF687 | Inventory | Evidence and handoff |

## Schema-Ready App Physical Design

Candidate table names are starter names for app migrations. Each app must validate exact TMF API version, resource, operation, and field paths against `references/tmforum-open-apis/openapi-specs/` before creating DDL.

| Owning schema | Starter table groups and candidate tables | Key and relationship rules | Controls and storage notes |
| --- | --- | --- | --- |
| `service_resource_design` | Technical catalog: `service_specification`, `resource_specification`, `specification_version`, `realization_rule`, `technical_compatibility_rule`, `entity_template`, `event_outbox` | Service/resource specifications are versioned definitions. Realization rules reference product specification/offering versions and downstream fulfillment patterns. | Version every definition and rule. Use characteristics for flexible technical attributes, but keep core compatibility keys typed. |
| `inventory_topology` | Operational inventory: `installed_product_inventory`, `service_inventory`, `resource_inventory`, `inventory_location_binding`, `topology_node`, `topology_edge`, `connectivity_path`, `resource_pool`, `identifier_resource`, `number_portability_state`, `esim_profile_lifecycle`, `resource_reservation`, `resource_assignment`, `discovered_resource_staging`, `inventory_reconciliation_record`, `migration_decommissioning_state`, `event_outbox` | Inventory owns accepted operational truth. Discovery, controller, fulfillment, and field inputs stage first, then reconcile into accepted inventory. Cross-app references store product order, service order, site/location, and customer/product IDs. | Strong audit, assignment history, and correction workflow required. Partition discovery/reconciliation evidence by source and period if high volume. |
| `fulfillment_activation` | Execution control: `service_order_execution`, `resource_order_execution`, `activation_request`, `activation_response`, `provisioning_workflow_state`, `fulfillment_fallout`, `fulfillment_handover_evidence`, `event_outbox` | Fulfillment owns execution state and references product orders, inventory reservations, assignments, and activation controller IDs. Inventory APIs accept final state changes. | Store correlation/causation IDs, retry/idempotency keys, controller evidence, fallout cause, and handover decision. |
| `field_stock_logistics` | Field and logistics: `appointment`, `work_order`, `dispatch_plan`, `field_evidence`, `stock_item`, `stock_balance`, `shipping_order`, `tracking_event`, `field_inventory_handover`, `event_outbox` | Field work references service/resource order, site/location, stock, shipment, and accepted inventory IDs. Stock and shipment have their own operational IDs and external carrier/vendor references. | Preserve chain of custody for stock, shipment, technician actions, photos/documents, and inventory handoff evidence. |

## Consumed Cross-Suite Data

| Source suite/app | Consumed data | Storage rule |
| --- | --- | --- |
| BSS Commercial | Product catalog, product order, customer/account references | Store order context and references; do not master commercial state |
| Strategy, Investment, And Capacity | Geography, serviceability, planned topology, build packages | Store accepted handoffs and references |
| OSS Operations And Assurance | Incident, change, diagnostics, remediation requests | Store execution references and evidence only |
| Enterprise Platform, Data, And Governance | Workflow, API, event, test, identity, policy | Store references and app-local execution state |

## TMF Compliance Rules

- Use TMF633, TMF634, TMF662, and TMF730 for service/resource design definitions before adding local design entities.
- Use TMF637, TMF638, TMF639, TMF703, TMF685, TMF716, and TMF640 for inventory, topology, identifiers, portability/eSIM support state, pool, reservation, and assignment data.
- Use TMF641, TMF652, TMF640, TMF702, TMF664, and TMF701 for fulfillment, resource order, activation, and provisioning state.
- Use TMF646, TMF697, TMF687, TMF700, and TMF684 for appointments, work orders, stock, and shipping.
- Technical fields not covered by TMF must be classified as characteristics, internal operational fields, controller evidence, snapshots, or reviewed extensions.

## Events And Projections

- Publish events for spec changed, inventory changed, topology changed, reservation changed, assignment changed, reconciliation completed, service order changed, resource order changed, activation completed, fallout changed, appointment changed, work order changed, stock changed, and shipment changed.
- Each event must be registered with event name/version, event key, payload basis, outbox table, known consumers, replay retention, and masking controls before implementation.
- Consumers must use APIs/events/projections for inventory and fulfillment state; no direct writes to inventory schemas.
- Reconciliation and handover events must include before/after state, source system, evidence reference, and acceptance decision.

## App-Level Data Model Checklist

- Definitions, instances, transactions, and evidence are separate table groups.
- Candidate tables, primary keys, alternate identifiers, cross-app reference fields, and migration owner must be recorded before creating migrations.
- Each app must maintain TMF conformance, event contract, and privacy/retention/audit registers for every table group.
- Actual topology is separate from planned topology.
- Inventory corrections occur only through Inventory And Topology APIs/workflows.
- External controller and discovery data is staged, reconciled, and accepted before becoming operational truth.
- Every TMF extension is documented with resource, characteristic, owner, and compatibility note.
