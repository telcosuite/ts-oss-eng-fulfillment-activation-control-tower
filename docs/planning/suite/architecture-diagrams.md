# OSS Engineering, Inventory, And Fulfillment Architecture Diagrams

Reviewed: 2026-06-14

## Purpose

Use these diagrams when building the OSS Engineering, Inventory, And Fulfillment suite and its apps. They make the ownership split between service/resource design, inventory/topology, fulfillment/activation, and field/stock/logistics explicit enough for implementation planning.

Primary sources:

- [Implementation File Usage Guide](implementation-file-usage-guide.md)
- [Tech And UI Guidance](tech-and-ui-guidance.md)
- [Data Model](data-model.md)
- [Journey Coverage](journey-coverage.md)
- App `implementation-file-usage.md`, `README.md`, `modules-and-features.md`, `personas-and-user-journeys.md`, and `features/` detail packs
- [TMF API To DDL Traceability Matrix](../tmf-api-to-ddl-traceability-matrix.md)
- `database/postgres/suites/ts_oss_engineering_fulfillment/`

## Suite Architecture

```mermaid
flowchart LR
  subgraph Upstream["Upstream Product And Planning Inputs"]
    Offer["Product And Offer Studio"]
    Order["Order Management Hub"]
    Capacity["Capacity Planning And Network Engineering"]
    Build["Infrastructure Build Program"]
    Geo["Geography, Site, Serviceability"]
  end

  subgraph Suite["OSS Engineering, Inventory, And Fulfillment Suite"]
    SRD["Service And Resource Design Studio"]
    Inventory["Inventory And Topology"]
    Fulfillment["Fulfillment And Activation Control Tower"]
    Field["Field Work, Stock, And Logistics"]
  end

  subgraph APIs["Suite API And Event Contracts"]
    TMF["TMF APIs: TMF633, TMF634, TMF637, TMF638, TMF639, TMF640, TMF641, TMF646, TMF652, TMF687, TMF697, TMF700, TMF703, TMF716"]
    Extensions["Extension APIs for realization rules, connectivity paths, operational inventory planning, activation evidence, field evidence, and inventory handover"]
    Events["Design, inventory, reservation, assignment, service order, resource order, activation, appointment, work order, stock, shipment, and handover events"]
  end

  subgraph Data["ts_oss_engineering_fulfillment"]
    SRDDB["service_resource_design schema"]
    InventoryDB["inventory_topology schema"]
    FulfillmentDB["fulfillment_activation schema"]
    FieldDB["field_stock_logistics schema"]
  end

  subgraph Downstream["Consumers And External Boundaries"]
    Network["Network controllers, EMS/NMS, SDN/NFV, cloud, activation platforms"]
    Assurance["NOC, performance, SLA, change, trouble-to-resolve"]
    Billing["Billing, usage, revenue assurance, settlement"]
    Digital["Self-care order tracking, partner operations, marketplace"]
    Platform["Workflow, API/eventing, data products, security, test"]
  end

  Offer --> SRD
  Capacity --> SRD
  Capacity --> Inventory
  Build --> Inventory
  Geo --> Inventory
  Order --> Fulfillment
  SRD --> Fulfillment
  Fulfillment --> Inventory
  Fulfillment --> Field
  Field --> Inventory

  Suite --> TMF
  Suite --> Extensions
  Suite --> Events

  SRD --> SRDDB
  Inventory --> InventoryDB
  Fulfillment --> FulfillmentDB
  Field --> FieldDB

  Fulfillment <--> Network
  Inventory --> Assurance
  Inventory --> Billing
  Events --> Digital
  Events --> Platform
```

## Suite Build Flow

```mermaid
sequenceDiagram
  autonumber
  participant Product as Product/offer and design input
  participant SRD as Service And Resource Design
  participant Order as BSS Order Management
  participant Fulfillment as Fulfillment And Activation
  participant Inventory as Inventory And Topology
  participant Field as Field/Stock/Logistics
  participant Network as Network/activation platforms
  participant Assurance as Assurance and billing consumers

  Product->>SRD: Define service/resource specs and realization rules
  Order->>Fulfillment: Send product-order decomposition context
  Fulfillment->>Inventory: Request reservation and assignment
  Inventory-->>Fulfillment: Return available resources, identifiers, paths, reservations
  Fulfillment->>Field: Create appointment, work order, stock, or shipment dependency
  Field-->>Fulfillment: Return field execution and evidence
  Fulfillment->>Network: Execute activation/configuration
  Network-->>Fulfillment: Return response, test, rollback, and evidence
  Fulfillment->>Inventory: Submit accepted product/service/resource inventory update
  Inventory-->>Assurance: Publish inventory, topology, and service/resource state
```

## App Architecture: Service And Resource Design Studio

```mermaid
flowchart LR
  Inputs["Product specifications, resource catalogs, technology standards, capacity plans, network designs, compatibility and realization rules"]
  UI["Service/resource catalog workbench, realization rule editor, compatibility matrix, design template editor, entity catalog"]
  API["TMF633/TMF620/TMF634/TMF730/TMF701/TMF645/TMF679/TMF662 APIs plus realization-rule and design-template commands"]
  Domain["Service catalog, resource catalog, product-service-resource mapping, technical compatibility and design rule, entity catalog"]
  Data["service_resource_design schema: service specs, resource specs, realization rules, compatibility rules, templates, entity catalog metadata, event_outbox"]
  Consumers["Order decomposition, fulfillment, CPQ qualification, network engineering, inventory, activation"]
  Tests["TMF633/TMF634/TMF620 contract tests, rule resolution, compatibility, versioning, mapping, conformance tests"]

  Inputs --> UI --> API --> Domain --> Data
  Data --> Consumers
  Domain --> Tests
```

## App Architecture: Inventory And Topology

```mermaid
flowchart LR
  Inputs["Build acceptance, activation evidence, discovery sync, field handover, geography/site, product order, service/resource order, reservation requests"]
  UI["Inventory search, topology canvas, resource pool dashboard, reservation board, connectivity path view, reconciliation queue, decommission workbench"]
  API["TMF637/TMF638/TMF639/TMF703/TMF674/TMF675/TMF685/TMF771/TMF716/TMF640/TMF697/TMF645/TMF655/TMF681 APIs"]
  Domain["Product inventory, service inventory, resource inventory, location binding, topology, connectivity path, resource pool, operational inventory planning, identifiers, reservation/assignment, reconciliation, discovery, migration/decommission"]
  Data["inventory_topology schema: product/service/resource inventory, topology relationships, locations, paths, pools, identifiers, reservations, assignments, reconciliation, discovery snapshots, event_outbox"]
  Consumers["Fulfillment, assurance, billing, CPQ, capacity planning, field, self-care, partner, data products"]
  Tests["Inventory contract, reservation conflict, topology relationship, discovery reconciliation, assignment, decommission, masking, event replay tests"]

  Inputs --> UI --> API --> Domain --> Data
  Data --> Consumers
  Domain --> Tests
```

## App Architecture: Fulfillment And Activation Control Tower

```mermaid
flowchart LR
  Inputs["Product order decomposition, service/resource specs, inventory reservations, partner/offnet dependencies, appointments, stock, network controller responses"]
  UI["Service/resource order board, provisioning workflow, activation task console, fallout queue, readiness simulation, rollback/compensation timeline"]
  API["TMF641/TMF652/TMF640/TMF702/TMF664/TMF701/TMF621/TMF637/TMF638/TMF639 APIs plus activation evidence and compensation commands"]
  Domain["Service order execution, resource order execution, activation and configuration, provisioning workflow, fulfillment fallout, inventory update and handover, validation/test/turn-up"]
  Data["fulfillment_activation schema: service orders, resource orders, activation tasks, provisioning states, fallout, rollback/compensation, handover evidence, event_outbox"]
  Consumers["Inventory, order management, field, partner operations, billing activation, assurance, self-care"]
  Tests["Service/resource order contract, idempotency, readiness, activation rollback, fallout routing, inventory handover, partner/offnet activation tests"]

  Inputs --> UI --> API --> Domain --> Data
  Data --> Consumers
  Domain --> Tests
```

## App Architecture: Field Work, Stock, And Logistics

```mermaid
flowchart LR
  Inputs["Fulfillment work, assurance work, build work, appointment requests, stock reservations, shipping needs, contractor evidence, HSE constraints"]
  UI["Appointment scheduler, work order board, dispatch optimizer, mobile field evidence, stock/warehouse, shipment tracker, RMA/reverse logistics"]
  API["TMF646/TMF697/TMF687/TMF700/TMF684/TMF639 APIs plus field evidence, contractor, replenishment, and handover commands"]
  Domain["Appointment management, work order, dispatch and field execution, stock and warehouse, shipping and shipment tracking, field-to-inventory handover"]
  Data["field_stock_logistics schema: appointments, work orders, dispatch plans, execution evidence, stock items, stock balances, shipments, RMA, handover packages, event_outbox"]
  Consumers["Fulfillment, inventory, assurance, build program, customer order tracking, partner/contractor operations"]
  Tests["Appointment contract, dispatch rules, offline/mobile evidence, stock reservation, shipment tracking, RMA, handover mismatch, HSE/privacy tests"]

  Inputs --> UI --> API --> Domain --> Data
  Data --> Consumers
  Domain --> Tests
```

## Build Use

Use these diagrams to keep execution ownership clean: fulfillment owns service/resource order execution and activation evidence; inventory owns accepted product/service/resource state; field owns appointment, work order, stock, shipment, and field evidence; design studio owns service/resource definitions and realization rules.
