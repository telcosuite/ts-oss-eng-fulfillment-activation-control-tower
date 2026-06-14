# Fulfillment And Activation Control Tower TMF API To DDL Review

Reviewed: 2026-06-14

Status: Complete for baseline app implementation. Endpoint-specific contract tests and final story-level field promotion still happen during build.

## Scope

This review covers `fulfillment_activation` in suite database `ts_oss_engineering_fulfillment`. It uses the local TMF Open API reference set, the suite data model, the API-to-DDL traceability matrix, and the V001 starter DDL.

The review confirms that the app can move into implementation with a V002 typed DDL baseline while preserving full TMF payload compatibility through validated `tmf_payload`, typed common TMF columns, and normalized support tables.

## TMF API Baseline Selection

| TMF API | Local baseline spec | Resources/path roots reviewed | V001 table groups |
| --- | --- | --- | --- |
| TMF641 | `references/tmforum-open-apis/openapi-specs/TMF641_ServiceOrder/TMF641_Service_Ordering_Management_API_v4.1.0_swagger.json` | `cancelServiceOrder`, `serviceOrder` | service_order_execution; product_order_decomposition_plan references |
| TMF652 | `references/tmforum-open-apis/openapi-specs/TMF652_ResourceOrderManagement/TMF652_Resource_Order_Management_API_v4.0.0_swagger.json` | `cancelResourceOrder`, `resourceOrder` | resource_order_execution; order_decomposition_plan references |
| TMF640 | `references/tmforum-open-apis/openapi-specs/TMF640_ActivationConfiguration/TMF640_Service_Activation_Management_API_v4.0.0_swagger.json` | `monitor`, `service` | activation_request; activation_response; restriction/reconnection execution references |
| TMF702 | `references/tmforum-open-apis/openapi-specs/TMF702_ResourceActivationManagement/TMF702_Resource_Activation_Management_API_v4.0.0_swagger.json` | `monitor`, `resource` | activation_request; activation_response |
| TMF664 | `references/tmforum-open-apis/openapi-specs/TMF664_ResourceFunctionActivationConfiguration/TMF664_Resource_Function_Activation_Management_API_v4.0.0_swagger.json` | `heal`, `migrate`, `monitor`, `resourceFunction`, `scale` | activation_request; activation_response |
| TMF701 | `references/tmforum-open-apis/openapi-specs/TMF701_ProcessFlow/TMF701-ProcessFlow-v4.0.0.swagger.json` | `processFlow` | process_definition; process_version; work_queue; task; provisioning_workflow_state |
| TMF621 | `references/tmforum-open-apis/openapi-specs/TMF621_TroubleTicket/TMF621-Trouble_Ticket-v5.0.1.oas.yaml` | `troubleTicket`, `troubleTicketSpecification` | trouble_ticket; service_problem; operational_incident; care_case references in BSS |
| TMF637 | `references/tmforum-open-apis/openapi-specs/TMF637_ProductInventory/TMF637-ProductInventory-v5.0.0.oas.yaml` | `product` | installed_product_inventory; migration_decommissioning_state |
| TMF638 | `references/tmforum-open-apis/openapi-specs/TMF638_ServiceInventory/TMF638-Service_Inventory_Management-v5.0.0.oas.yaml` | `service` | service_inventory; topology_edge; topology_node; discovered_resource_staging |
| TMF639 | `references/tmforum-open-apis/openapi-specs/TMF639_ResourceInventory/TMF639-Resource_Inventory_Management-v5.0.0.oas.yaml` | `resource` | resource_inventory; identifier_resource; inventory_location_binding; topology; assignment |

## Current DDL Coverage

Current starter DDL is in `database/postgres/suites/ts_oss_engineering_fulfillment/V001__create_app_schemas_and_starter_tables.sql` under schema `fulfillment_activation`.

| Current table | TMF purpose | V002 decision |
| --- | --- | --- |
| `fulfillment_activation.service_order_execution` | Starter table for Fulfillment And Activation Control Tower; V002 promotes common TMF fields and keeps full validated payload support. | Keep and refine through `database/postgres/suites/ts_oss_engineering_fulfillment/V003__refine_fulfillment_activation_tmf_core.sql` |
| `fulfillment_activation.resource_order_execution` | Starter table for Fulfillment And Activation Control Tower; V002 promotes common TMF fields and keeps full validated payload support. | Keep and refine through `database/postgres/suites/ts_oss_engineering_fulfillment/V003__refine_fulfillment_activation_tmf_core.sql` |
| `fulfillment_activation.activation_request` | Starter table for Fulfillment And Activation Control Tower; V002 promotes common TMF fields and keeps full validated payload support. | Keep and refine through `database/postgres/suites/ts_oss_engineering_fulfillment/V003__refine_fulfillment_activation_tmf_core.sql` |
| `fulfillment_activation.activation_response` | Starter table for Fulfillment And Activation Control Tower; V002 promotes common TMF fields and keeps full validated payload support. | Keep and refine through `database/postgres/suites/ts_oss_engineering_fulfillment/V003__refine_fulfillment_activation_tmf_core.sql` |
| `fulfillment_activation.provisioning_workflow_state` | Starter table for Fulfillment And Activation Control Tower; V002 promotes common TMF fields and keeps full validated payload support. | Keep and refine through `database/postgres/suites/ts_oss_engineering_fulfillment/V003__refine_fulfillment_activation_tmf_core.sql` |
| `fulfillment_activation.fulfillment_fallout` | Starter table for Fulfillment And Activation Control Tower; V002 promotes common TMF fields and keeps full validated payload support. | Keep and refine through `database/postgres/suites/ts_oss_engineering_fulfillment/V003__refine_fulfillment_activation_tmf_core.sql` |
| `fulfillment_activation.fulfillment_handover_evidence` | Starter table for Fulfillment And Activation Control Tower; V002 promotes common TMF fields and keeps full validated payload support. | Keep and refine through `database/postgres/suites/ts_oss_engineering_fulfillment/V003__refine_fulfillment_activation_tmf_core.sql` |
| `fulfillment_activation.event_outbox` | App outbox for domain and TMF notification events. | Keep and refine through `database/postgres/suites/ts_oss_engineering_fulfillment/V003__refine_fulfillment_activation_tmf_core.sql` |

## Resource To Table Decisions

| TMF API/resource | Master or anchor table | Path coverage | Promoted field candidates | Field handling strategy |
| --- | --- | --- | --- | --- |
| TMF641 `cancelServiceOrder` | `fulfillment_activation.service_order_execution` | `/cancelServiceOrder`, `/cancelServiceOrder/{id}` | `id`, `href`, `cancellationDate`, `cancellationReason`, `category`, `completionDate`, `description`, `expectedCompletionDate` | Promote common TMF lifecycle/reference fields; store remaining validated resource fields in tmf_payload and characteristics tables. |
| TMF641 `serviceOrder` | `fulfillment_activation.service_order_execution` | `/serviceOrder`, `/serviceOrder/{id}` | `id`, `href`, `cancellationDate`, `cancellationReason`, `category`, `completionDate`, `description`, `expectedCompletionDate` | Promote common TMF lifecycle/reference fields; store remaining validated resource fields in tmf_payload and characteristics tables. |
| TMF652 `cancelResourceOrder` | `fulfillment_activation.resource_order_execution` | `/cancelResourceOrder`, `/cancelResourceOrder/{id}` | `id`, `href`, `category`, `completionDate`, `description`, `expectedCompletionDate`, `externalId`, `name` | Promote common TMF lifecycle/reference fields; store remaining validated resource fields in tmf_payload and characteristics tables. |
| TMF652 `resourceOrder` | `fulfillment_activation.resource_order_execution` | `/resourceOrder`, `/resourceOrder/{id}` | `id`, `href`, `category`, `completionDate`, `description`, `expectedCompletionDate`, `externalId`, `name` | Promote common TMF lifecycle/reference fields; store remaining validated resource fields in tmf_payload and characteristics tables. |
| TMF640 `monitor` | `fulfillment_activation.activation_request` | `/monitor`, `/monitor/{id}` | `id`, `href`, `sourceHref`, `state`, `request`, `response`, `@baseType`, `@schemaLocation` | Promote common TMF lifecycle/reference fields; store remaining validated resource fields in tmf_payload and characteristics tables. |
| TMF640 `service` | `fulfillment_activation.service_order_execution` | `/service`, `/service/{id}` | `id`, `href`, `category`, `description`, `endDate`, `hasStarted`, `isBundle`, `isServiceEnabled` | Promote common TMF lifecycle/reference fields; store remaining validated resource fields in tmf_payload and characteristics tables. |
| TMF702 `monitor` | `fulfillment_activation.activation_request` | `/monitor`, `/monitor/{id}` | `id`, `href`, `sourceHref`, `state`, `request`, `response`, `@baseType`, `@schemaLocation` | Promote common TMF lifecycle/reference fields; store remaining validated resource fields in tmf_payload and characteristics tables. |
| TMF702 `resource` | `fulfillment_activation.resource_order_execution` | `/resource`, `/resource/{id}` | `id`, `href`, `category`, `description`, `endOperatingDate`, `name`, `resourceVersion`, `startOperatingDate` | Promote common TMF lifecycle/reference fields; store remaining validated resource fields in tmf_payload and characteristics tables. |
| TMF664 `heal` | `fulfillment_activation.activation_request` | `/heal`, `/heal/{id}` | `id`, `href`, `cause`, `degreeOfHealing`, `healAction`, `name`, `startTime`, `additionalParms` | Promote common TMF lifecycle/reference fields; store remaining validated resource fields in tmf_payload and characteristics tables. |
| TMF664 `migrate` | `fulfillment_activation.activation_request` | `/migrate`, `/migrate/{id}` | `id`, `href`, `adminStateModification`, `cause`, `completionMode`, `name`, `priority`, `startTime` | Promote common TMF lifecycle/reference fields; store remaining validated resource fields in tmf_payload and characteristics tables. |
| TMF664 `monitor` | `fulfillment_activation.activation_request` | `/monitor`, `/monitor/{id}` | `id`, `href`, `sourceHref`, `state`, `request`, `response`, `@baseType`, `@schemaLocation` | Promote common TMF lifecycle/reference fields; store remaining validated resource fields in tmf_payload and characteristics tables. |
| TMF664 `resourceFunction` | `fulfillment_activation.resource_order_execution` | `/resourceFunction`, `/resourceFunction/{id}` | `id`, `href`, `category`, `description`, `endOperatingDate`, `functionType`, `name`, `priority` | Promote common TMF lifecycle/reference fields; store remaining validated resource fields in tmf_payload and characteristics tables. |
| TMF664 `scale` | `fulfillment_activation.activation_request` | `/scale`, `/scale/{id}` | `id`, `href`, `aspectId`, `name`, `numberOfSteps`, `scaleType`, `resourceFunction`, `schedule` | Promote common TMF lifecycle/reference fields; store remaining validated resource fields in tmf_payload and characteristics tables. |
| TMF701 `processFlow` | `fulfillment_activation.provisioning_workflow_state` | `/processFlow`, `/processFlow/{id}`, `/processFlow/{processFlowId}/taskFlow` | `id`, `href`, `processFlowDate`, `processFlowSpecification`, `channel`, `characteristic`, `relatedEntity`, `relatedParty` | Promote common TMF lifecycle/reference fields; store remaining validated resource fields in tmf_payload and characteristics tables. |
| TMF621 `troubleTicket` | `fulfillment_activation.service_order_execution` | `/troubleTicket`, `/troubleTicket/{id}` | Common TMF metadata plus payload validation | Promote common TMF metadata; store resource-specific fields in tmf_payload until query patterns justify additional typed columns. |
| TMF621 `troubleTicketSpecification` | `fulfillment_activation.service_order_execution` | `/troubleTicketSpecification`, `/troubleTicketSpecification/{id}` | Common TMF metadata plus payload validation | Promote common TMF metadata; store resource-specific fields in tmf_payload until query patterns justify additional typed columns. |
| TMF637 `product` | `fulfillment_activation.service_order_execution` | `/product`, `/product/{id}` | Common TMF metadata plus payload validation | Promote common TMF metadata; store resource-specific fields in tmf_payload until query patterns justify additional typed columns. |
| TMF638 `service` | `fulfillment_activation.service_order_execution` | `/service`, `/service/{id}` | Common TMF metadata plus payload validation | Promote common TMF metadata; store resource-specific fields in tmf_payload until query patterns justify additional typed columns. |
| TMF639 `resource` | `fulfillment_activation.resource_order_execution` | `/resource`, `/resource/{id}` | Common TMF metadata plus payload validation | Promote common TMF metadata; store resource-specific fields in tmf_payload until query patterns justify additional typed columns. |

## V002 DDL Refinement

Migration: `database/postgres/suites/ts_oss_engineering_fulfillment/V003__refine_fulfillment_activation_tmf_core.sql`

The migration adds this implementation baseline for the app:

| Area | Decision |
| --- | --- |
| Common TMF fields | Add reusable typed columns such as `tmf_id`, `tmf_href`, `tmf_type`, `tmf_base_type`, `tmf_schema_location`, `tmf_referred_type`, `tmf_name`, `tmf_description`, `tmf_lifecycle_status`, `tmf_state`, dates, priority, and external ID to every V001 app table. |
| Full TMF compatibility | Keep the V001 `tmf_payload` column as the complete validated TMF resource snapshot for fields that are not yet promoted to typed columns. |
| Characteristics and references | Add normalized `tmf_characteristic`, `tmf_resource_reference`, `tmf_external_identifier`, `tmf_related_party`, `tmf_note`, `tmf_attachment`, and `tmf_relationship` support tables. |
| API/resource map | Add `tmf_api_resource_map` rows for the selected local TMF APIs and resource roots. |
| Event contracts | Add baseline event contract rows for create, update, state-change, and delete events per reviewed API resource. |
| Privacy and audit | Add table-level privacy, retention, legal-hold, residency, masking, and audit policy rows. |
| High-volume candidates | `fulfillment_activation.event_outbox` |

## Event Contract Baseline

Events are registered in `fulfillment_activation.event_contract` using `fulfillment_activation.event_outbox` as the publication basis. Consumers must be added when integrations are designed; no app should directly write another app schema.

## Privacy, Retention, And Audit Baseline

| Table | Data classification | Retention class | Audit level |
| --- | --- | --- | --- |
| `fulfillment_activation.service_order_execution` | confidential | business_lifecycle | standard-high |
| `fulfillment_activation.resource_order_execution` | confidential | business_lifecycle | standard-high |
| `fulfillment_activation.activation_request` | internal | domain_lifecycle | standard |
| `fulfillment_activation.activation_response` | internal | domain_lifecycle | standard |
| `fulfillment_activation.provisioning_workflow_state` | internal | domain_lifecycle | standard |
| `fulfillment_activation.fulfillment_fallout` | internal | domain_lifecycle | standard |
| `fulfillment_activation.fulfillment_handover_evidence` | internal | domain_lifecycle | standard |
| `fulfillment_activation.event_outbox` | internal | operational_telemetry | standard |

## Build Gate Result

| Gate item | Result |
| --- | --- |
| API/resource review | Complete for baseline implementation |
| V002 typed DDL | Complete: `database/postgres/suites/ts_oss_engineering_fulfillment/V003__refine_fulfillment_activation_tmf_core.sql` |
| Event contract register | Baseline complete |
| Privacy/retention/audit classification | Baseline complete |
| Remaining implementation control | Validate exact endpoint operations and contract tests as Angular/Spring Boot features are built |
