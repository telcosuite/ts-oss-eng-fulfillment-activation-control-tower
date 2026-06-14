-- TelcoSuite starter DDL for OSS Engineering, Inventory, And Fulfillment
-- Target database: ts_oss_engineering_fulfillment
-- Source model: planning/suite-details/03-oss-engineering-inventory-fulfillment/data-model.md
-- Migration type: Flyway SQL migration, run while connected to ts_oss_engineering_fulfillment.
-- Purpose: create app schemas, starter tables, standard controls, and app event outboxes.

CREATE EXTENSION IF NOT EXISTS pgcrypto;

CREATE SCHEMA IF NOT EXISTS service_resource_design;
COMMENT ON SCHEMA service_resource_design IS 'App-owned schema for Service And Resource Design Studio in OSS Engineering, Inventory, And Fulfillment.';
CREATE SCHEMA IF NOT EXISTS inventory_topology;
COMMENT ON SCHEMA inventory_topology IS 'App-owned schema for Inventory And Topology in OSS Engineering, Inventory, And Fulfillment.';
CREATE SCHEMA IF NOT EXISTS fulfillment_activation;
COMMENT ON SCHEMA fulfillment_activation IS 'App-owned schema for Fulfillment And Activation Control Tower in OSS Engineering, Inventory, And Fulfillment.';
CREATE SCHEMA IF NOT EXISTS field_stock_logistics;
COMMENT ON SCHEMA field_stock_logistics IS 'App-owned schema for Field Work, Stock, And Logistics in OSS Engineering, Inventory, And Fulfillment.';

CREATE TABLE IF NOT EXISTS service_resource_design.service_specification (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_service_r_service_specification_canonica_3aa394b5 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_service_r_service_specification_version_f9ff84e8 CHECK (version > 0),
    CONSTRAINT ck_service_r_service_specification_validity_e2b84d2e CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_service_r_service_specification_canonica_7e623ac4 ON service_resource_design.service_specification (canonical_id);
CREATE INDEX IF NOT EXISTS ix_service_r_service_specification_status_fdabd0ff ON service_resource_design.service_specification (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_service_r_service_specification_updated_750bf2fc ON service_resource_design.service_specification (updated_at);
CREATE INDEX IF NOT EXISTS ix_service_r_service_specification_source_0489c5c8 ON service_resource_design.service_specification (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_service_r_service_specification_attrgin_e811eac6 ON service_resource_design.service_specification USING gin (attributes);
COMMENT ON TABLE service_resource_design.service_specification IS 'Starter table for Service And Resource Design Studio. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN service_resource_design.service_specification.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN service_resource_design.service_specification.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN service_resource_design.service_specification.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS service_resource_design.resource_specification (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_service_r_resource_specification_canonica_af6f69d9 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_service_r_resource_specification_version_ad459652 CHECK (version > 0),
    CONSTRAINT ck_service_r_resource_specification_validity_c66e673d CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_service_r_resource_specification_canonica_b0905e38 ON service_resource_design.resource_specification (canonical_id);
CREATE INDEX IF NOT EXISTS ix_service_r_resource_specification_status_b24bcdf2 ON service_resource_design.resource_specification (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_service_r_resource_specification_updated_d0da3cb4 ON service_resource_design.resource_specification (updated_at);
CREATE INDEX IF NOT EXISTS ix_service_r_resource_specification_source_110b9429 ON service_resource_design.resource_specification (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_service_r_resource_specification_attrgin_69054c96 ON service_resource_design.resource_specification USING gin (attributes);
COMMENT ON TABLE service_resource_design.resource_specification IS 'Starter table for Service And Resource Design Studio. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN service_resource_design.resource_specification.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN service_resource_design.resource_specification.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN service_resource_design.resource_specification.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS service_resource_design.specification_version (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_service_r_specification_version_canonica_37556731 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_service_r_specification_version_version_affda69e CHECK (version > 0),
    CONSTRAINT ck_service_r_specification_version_validity_6c6115c7 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_service_r_specification_version_canonica_6a2c2418 ON service_resource_design.specification_version (canonical_id);
CREATE INDEX IF NOT EXISTS ix_service_r_specification_version_status_ed067c3c ON service_resource_design.specification_version (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_service_r_specification_version_updated_7eaac0b7 ON service_resource_design.specification_version (updated_at);
CREATE INDEX IF NOT EXISTS ix_service_r_specification_version_source_0b321be0 ON service_resource_design.specification_version (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_service_r_specification_version_attrgin_6290dd4f ON service_resource_design.specification_version USING gin (attributes);
COMMENT ON TABLE service_resource_design.specification_version IS 'Starter table for Service And Resource Design Studio. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN service_resource_design.specification_version.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN service_resource_design.specification_version.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN service_resource_design.specification_version.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS service_resource_design.realization_rule (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_service_r_realization_rule_canonica_1c66f180 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_service_r_realization_rule_version_9dc1bdee CHECK (version > 0),
    CONSTRAINT ck_service_r_realization_rule_validity_fdde59ae CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_service_r_realization_rule_canonica_c3c9ef1b ON service_resource_design.realization_rule (canonical_id);
CREATE INDEX IF NOT EXISTS ix_service_r_realization_rule_status_b48b098f ON service_resource_design.realization_rule (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_service_r_realization_rule_updated_e1315d92 ON service_resource_design.realization_rule (updated_at);
CREATE INDEX IF NOT EXISTS ix_service_r_realization_rule_source_6580741c ON service_resource_design.realization_rule (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_service_r_realization_rule_attrgin_703b087e ON service_resource_design.realization_rule USING gin (attributes);
COMMENT ON TABLE service_resource_design.realization_rule IS 'Starter table for Service And Resource Design Studio. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN service_resource_design.realization_rule.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN service_resource_design.realization_rule.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN service_resource_design.realization_rule.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS service_resource_design.technical_compatibility_rule (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_service_r_technical_compatibility_ru_canonica_bf041919 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_service_r_technical_compatibility_ru_version_5cccd70e CHECK (version > 0),
    CONSTRAINT ck_service_r_technical_compatibility_ru_validity_7ac3b125 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_service_r_technical_compatibility_ru_canonica_8a9cde2b ON service_resource_design.technical_compatibility_rule (canonical_id);
CREATE INDEX IF NOT EXISTS ix_service_r_technical_compatibility_ru_status_121c091b ON service_resource_design.technical_compatibility_rule (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_service_r_technical_compatibility_ru_updated_3dc31a92 ON service_resource_design.technical_compatibility_rule (updated_at);
CREATE INDEX IF NOT EXISTS ix_service_r_technical_compatibility_ru_source_f9aecd33 ON service_resource_design.technical_compatibility_rule (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_service_r_technical_compatibility_ru_attrgin_53d24a19 ON service_resource_design.technical_compatibility_rule USING gin (attributes);
COMMENT ON TABLE service_resource_design.technical_compatibility_rule IS 'Starter table for Service And Resource Design Studio. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN service_resource_design.technical_compatibility_rule.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN service_resource_design.technical_compatibility_rule.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN service_resource_design.technical_compatibility_rule.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS service_resource_design.entity_template (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_service_r_entity_template_canonica_6bd1bd83 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_service_r_entity_template_version_6ad1586c CHECK (version > 0),
    CONSTRAINT ck_service_r_entity_template_validity_cbb7faaf CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_service_r_entity_template_canonica_43e6a35d ON service_resource_design.entity_template (canonical_id);
CREATE INDEX IF NOT EXISTS ix_service_r_entity_template_status_8bba9093 ON service_resource_design.entity_template (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_service_r_entity_template_updated_3990b5dd ON service_resource_design.entity_template (updated_at);
CREATE INDEX IF NOT EXISTS ix_service_r_entity_template_source_f92c5fdb ON service_resource_design.entity_template (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_service_r_entity_template_attrgin_30c0f79f ON service_resource_design.entity_template USING gin (attributes);
COMMENT ON TABLE service_resource_design.entity_template IS 'Starter table for Service And Resource Design Studio. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN service_resource_design.entity_template.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN service_resource_design.entity_template.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN service_resource_design.entity_template.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS service_resource_design.event_outbox (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    event_name text NOT NULL,
    event_version integer NOT NULL DEFAULT 1,
    event_key text NOT NULL,
    aggregate_type text NOT NULL,
    aggregate_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    payload jsonb NOT NULL,
    headers jsonb NOT NULL DEFAULT '{}'::jsonb,
    data_classification text NOT NULL DEFAULT 'internal',
    occurred_at timestamptz NOT NULL DEFAULT now(),
    published_at timestamptz,
    publish_status text NOT NULL DEFAULT 'pending',
    publish_attempt_count integer NOT NULL DEFAULT 0,
    last_error text,
    correlation_id text,
    causation_id text,
    created_at timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT ck_service_r_event_outbox_status_4e7d1b25 CHECK (publish_status IN ('pending', 'published', 'failed', 'dead_letter'))
);

CREATE INDEX IF NOT EXISTS ix_service_r_event_outbox_publish_8b090768 ON service_resource_design.event_outbox (publish_status, occurred_at);
CREATE INDEX IF NOT EXISTS ix_service_r_event_outbox_eventkey_0ed087a3 ON service_resource_design.event_outbox (event_key, occurred_at);
CREATE INDEX IF NOT EXISTS ix_service_r_event_outbox_agg_4008e2b3 ON service_resource_design.event_outbox (aggregate_type, aggregate_id);
COMMENT ON TABLE service_resource_design.event_outbox IS 'Transactional event outbox for the owning app schema. Event contracts must be registered before publishing beyond the suite boundary.';

CREATE TABLE IF NOT EXISTS inventory_topology.installed_product_inventory (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_inventory_installed_product_inventor_canonica_b6bd9ca9 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_inventory_installed_product_inventor_version_d4af7f91 CHECK (version > 0),
    CONSTRAINT ck_inventory_installed_product_inventor_validity_4b4d20c1 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_inventory_installed_product_inventor_canonica_7329b732 ON inventory_topology.installed_product_inventory (canonical_id);
CREATE INDEX IF NOT EXISTS ix_inventory_installed_product_inventor_status_2a7d2a6d ON inventory_topology.installed_product_inventory (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_inventory_installed_product_inventor_updated_2113f462 ON inventory_topology.installed_product_inventory (updated_at);
CREATE INDEX IF NOT EXISTS ix_inventory_installed_product_inventor_source_7f7864fa ON inventory_topology.installed_product_inventory (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_inventory_installed_product_inventor_attrgin_4333f639 ON inventory_topology.installed_product_inventory USING gin (attributes);
COMMENT ON TABLE inventory_topology.installed_product_inventory IS 'Starter table for Inventory And Topology. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN inventory_topology.installed_product_inventory.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN inventory_topology.installed_product_inventory.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN inventory_topology.installed_product_inventory.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS inventory_topology.service_inventory (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_inventory_service_inventory_canonica_104ad20a UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_inventory_service_inventory_version_90e3f599 CHECK (version > 0),
    CONSTRAINT ck_inventory_service_inventory_validity_a747f7df CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_inventory_service_inventory_canonica_fa03206d ON inventory_topology.service_inventory (canonical_id);
CREATE INDEX IF NOT EXISTS ix_inventory_service_inventory_status_ef5f6292 ON inventory_topology.service_inventory (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_inventory_service_inventory_updated_cef4ea41 ON inventory_topology.service_inventory (updated_at);
CREATE INDEX IF NOT EXISTS ix_inventory_service_inventory_source_668fa8cd ON inventory_topology.service_inventory (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_inventory_service_inventory_attrgin_e5e869ab ON inventory_topology.service_inventory USING gin (attributes);
COMMENT ON TABLE inventory_topology.service_inventory IS 'Starter table for Inventory And Topology. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN inventory_topology.service_inventory.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN inventory_topology.service_inventory.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN inventory_topology.service_inventory.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS inventory_topology.resource_inventory (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_inventory_resource_inventory_canonica_5bc989c0 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_inventory_resource_inventory_version_c4c0914f CHECK (version > 0),
    CONSTRAINT ck_inventory_resource_inventory_validity_3885c8d0 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_inventory_resource_inventory_canonica_5524caed ON inventory_topology.resource_inventory (canonical_id);
CREATE INDEX IF NOT EXISTS ix_inventory_resource_inventory_status_d0d58030 ON inventory_topology.resource_inventory (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_inventory_resource_inventory_updated_bb5f0db9 ON inventory_topology.resource_inventory (updated_at);
CREATE INDEX IF NOT EXISTS ix_inventory_resource_inventory_source_ebe10c62 ON inventory_topology.resource_inventory (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_inventory_resource_inventory_attrgin_38f489c7 ON inventory_topology.resource_inventory USING gin (attributes);
COMMENT ON TABLE inventory_topology.resource_inventory IS 'Starter table for Inventory And Topology. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN inventory_topology.resource_inventory.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN inventory_topology.resource_inventory.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN inventory_topology.resource_inventory.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS inventory_topology.inventory_location_binding (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_inventory_inventory_location_binding_canonica_d2eeff2f UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_inventory_inventory_location_binding_version_9c0a47ae CHECK (version > 0),
    CONSTRAINT ck_inventory_inventory_location_binding_validity_d08af026 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_inventory_inventory_location_binding_canonica_02b5d24f ON inventory_topology.inventory_location_binding (canonical_id);
CREATE INDEX IF NOT EXISTS ix_inventory_inventory_location_binding_status_dc23b23e ON inventory_topology.inventory_location_binding (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_inventory_inventory_location_binding_updated_09b7d3ac ON inventory_topology.inventory_location_binding (updated_at);
CREATE INDEX IF NOT EXISTS ix_inventory_inventory_location_binding_source_89b3577b ON inventory_topology.inventory_location_binding (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_inventory_inventory_location_binding_attrgin_49b0b52c ON inventory_topology.inventory_location_binding USING gin (attributes);
COMMENT ON TABLE inventory_topology.inventory_location_binding IS 'Starter table for Inventory And Topology. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN inventory_topology.inventory_location_binding.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN inventory_topology.inventory_location_binding.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN inventory_topology.inventory_location_binding.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS inventory_topology.topology_node (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_inventory_topology_node_canonica_340c1f8a UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_inventory_topology_node_version_e799dbbb CHECK (version > 0),
    CONSTRAINT ck_inventory_topology_node_validity_a4db43d4 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_inventory_topology_node_canonica_e6065248 ON inventory_topology.topology_node (canonical_id);
CREATE INDEX IF NOT EXISTS ix_inventory_topology_node_status_b34ab564 ON inventory_topology.topology_node (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_inventory_topology_node_updated_78ec43bc ON inventory_topology.topology_node (updated_at);
CREATE INDEX IF NOT EXISTS ix_inventory_topology_node_source_51e2b469 ON inventory_topology.topology_node (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_inventory_topology_node_attrgin_d996a91c ON inventory_topology.topology_node USING gin (attributes);
COMMENT ON TABLE inventory_topology.topology_node IS 'Starter table for Inventory And Topology. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN inventory_topology.topology_node.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN inventory_topology.topology_node.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN inventory_topology.topology_node.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS inventory_topology.topology_edge (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_inventory_topology_edge_canonica_5a9f73ae UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_inventory_topology_edge_version_78de9a9b CHECK (version > 0),
    CONSTRAINT ck_inventory_topology_edge_validity_ddf9bef4 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_inventory_topology_edge_canonica_078ef2b9 ON inventory_topology.topology_edge (canonical_id);
CREATE INDEX IF NOT EXISTS ix_inventory_topology_edge_status_95dc5c79 ON inventory_topology.topology_edge (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_inventory_topology_edge_updated_5acb27fc ON inventory_topology.topology_edge (updated_at);
CREATE INDEX IF NOT EXISTS ix_inventory_topology_edge_source_50eb0a1a ON inventory_topology.topology_edge (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_inventory_topology_edge_attrgin_e7e511fd ON inventory_topology.topology_edge USING gin (attributes);
COMMENT ON TABLE inventory_topology.topology_edge IS 'Starter table for Inventory And Topology. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN inventory_topology.topology_edge.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN inventory_topology.topology_edge.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN inventory_topology.topology_edge.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS inventory_topology.connectivity_path (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_inventory_connectivity_path_canonica_a5580276 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_inventory_connectivity_path_version_de208a19 CHECK (version > 0),
    CONSTRAINT ck_inventory_connectivity_path_validity_633b7764 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_inventory_connectivity_path_canonica_ab504742 ON inventory_topology.connectivity_path (canonical_id);
CREATE INDEX IF NOT EXISTS ix_inventory_connectivity_path_status_58d8279e ON inventory_topology.connectivity_path (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_inventory_connectivity_path_updated_916527ab ON inventory_topology.connectivity_path (updated_at);
CREATE INDEX IF NOT EXISTS ix_inventory_connectivity_path_source_a1e22aa6 ON inventory_topology.connectivity_path (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_inventory_connectivity_path_attrgin_fdfe823c ON inventory_topology.connectivity_path USING gin (attributes);
COMMENT ON TABLE inventory_topology.connectivity_path IS 'Starter table for Inventory And Topology. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN inventory_topology.connectivity_path.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN inventory_topology.connectivity_path.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN inventory_topology.connectivity_path.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS inventory_topology.resource_pool (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_inventory_resource_pool_canonica_80418fb3 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_inventory_resource_pool_version_166168c4 CHECK (version > 0),
    CONSTRAINT ck_inventory_resource_pool_validity_4e26c303 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_inventory_resource_pool_canonica_2d75e4e1 ON inventory_topology.resource_pool (canonical_id);
CREATE INDEX IF NOT EXISTS ix_inventory_resource_pool_status_a58e5e28 ON inventory_topology.resource_pool (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_inventory_resource_pool_updated_eb28b51d ON inventory_topology.resource_pool (updated_at);
CREATE INDEX IF NOT EXISTS ix_inventory_resource_pool_source_04500b98 ON inventory_topology.resource_pool (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_inventory_resource_pool_attrgin_0808d1f3 ON inventory_topology.resource_pool USING gin (attributes);
COMMENT ON TABLE inventory_topology.resource_pool IS 'Starter table for Inventory And Topology. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN inventory_topology.resource_pool.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN inventory_topology.resource_pool.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN inventory_topology.resource_pool.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS inventory_topology.identifier_resource (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_inventory_identifier_resource_canonica_425b0d5f UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_inventory_identifier_resource_version_a7ff6c31 CHECK (version > 0),
    CONSTRAINT ck_inventory_identifier_resource_validity_83a43f62 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_inventory_identifier_resource_canonica_97c93976 ON inventory_topology.identifier_resource (canonical_id);
CREATE INDEX IF NOT EXISTS ix_inventory_identifier_resource_status_41a13f9c ON inventory_topology.identifier_resource (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_inventory_identifier_resource_updated_85cfe011 ON inventory_topology.identifier_resource (updated_at);
CREATE INDEX IF NOT EXISTS ix_inventory_identifier_resource_source_47fa9468 ON inventory_topology.identifier_resource (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_inventory_identifier_resource_attrgin_428bcbeb ON inventory_topology.identifier_resource USING gin (attributes);
COMMENT ON TABLE inventory_topology.identifier_resource IS 'Starter table for Inventory And Topology. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN inventory_topology.identifier_resource.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN inventory_topology.identifier_resource.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN inventory_topology.identifier_resource.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS inventory_topology.number_portability_state (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_inventory_number_portability_state_canonica_07dde516 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_inventory_number_portability_state_version_58d40cd2 CHECK (version > 0),
    CONSTRAINT ck_inventory_number_portability_state_validity_3f75cf9b CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_inventory_number_portability_state_canonica_640d6c5c ON inventory_topology.number_portability_state (canonical_id);
CREATE INDEX IF NOT EXISTS ix_inventory_number_portability_state_status_cca2ef39 ON inventory_topology.number_portability_state (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_inventory_number_portability_state_updated_162cf514 ON inventory_topology.number_portability_state (updated_at);
CREATE INDEX IF NOT EXISTS ix_inventory_number_portability_state_source_1e50722d ON inventory_topology.number_portability_state (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_inventory_number_portability_state_attrgin_40d87238 ON inventory_topology.number_portability_state USING gin (attributes);
COMMENT ON TABLE inventory_topology.number_portability_state IS 'Starter table for Inventory And Topology. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN inventory_topology.number_portability_state.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN inventory_topology.number_portability_state.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN inventory_topology.number_portability_state.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS inventory_topology.esim_profile_lifecycle (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_inventory_esim_profile_lifecycle_canonica_c8f52bee UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_inventory_esim_profile_lifecycle_version_741221dd CHECK (version > 0),
    CONSTRAINT ck_inventory_esim_profile_lifecycle_validity_e92e3806 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_inventory_esim_profile_lifecycle_canonica_b8c2a04c ON inventory_topology.esim_profile_lifecycle (canonical_id);
CREATE INDEX IF NOT EXISTS ix_inventory_esim_profile_lifecycle_status_1bb87d4c ON inventory_topology.esim_profile_lifecycle (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_inventory_esim_profile_lifecycle_updated_b5e81ef8 ON inventory_topology.esim_profile_lifecycle (updated_at);
CREATE INDEX IF NOT EXISTS ix_inventory_esim_profile_lifecycle_source_967b91e2 ON inventory_topology.esim_profile_lifecycle (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_inventory_esim_profile_lifecycle_attrgin_3158fcfd ON inventory_topology.esim_profile_lifecycle USING gin (attributes);
COMMENT ON TABLE inventory_topology.esim_profile_lifecycle IS 'Starter table for Inventory And Topology. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN inventory_topology.esim_profile_lifecycle.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN inventory_topology.esim_profile_lifecycle.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN inventory_topology.esim_profile_lifecycle.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS inventory_topology.resource_reservation (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_inventory_resource_reservation_canonica_2be262ef UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_inventory_resource_reservation_version_b851b496 CHECK (version > 0),
    CONSTRAINT ck_inventory_resource_reservation_validity_ca0e8718 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_inventory_resource_reservation_canonica_350d41ae ON inventory_topology.resource_reservation (canonical_id);
CREATE INDEX IF NOT EXISTS ix_inventory_resource_reservation_status_28c64d8c ON inventory_topology.resource_reservation (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_inventory_resource_reservation_updated_f50efd4f ON inventory_topology.resource_reservation (updated_at);
CREATE INDEX IF NOT EXISTS ix_inventory_resource_reservation_source_ad836173 ON inventory_topology.resource_reservation (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_inventory_resource_reservation_attrgin_88169a92 ON inventory_topology.resource_reservation USING gin (attributes);
COMMENT ON TABLE inventory_topology.resource_reservation IS 'Starter table for Inventory And Topology. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN inventory_topology.resource_reservation.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN inventory_topology.resource_reservation.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN inventory_topology.resource_reservation.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS inventory_topology.resource_assignment (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_inventory_resource_assignment_canonica_8fae7671 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_inventory_resource_assignment_version_02a75d58 CHECK (version > 0),
    CONSTRAINT ck_inventory_resource_assignment_validity_8e962df1 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_inventory_resource_assignment_canonica_19cb6bab ON inventory_topology.resource_assignment (canonical_id);
CREATE INDEX IF NOT EXISTS ix_inventory_resource_assignment_status_97ad376f ON inventory_topology.resource_assignment (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_inventory_resource_assignment_updated_e3dceb8f ON inventory_topology.resource_assignment (updated_at);
CREATE INDEX IF NOT EXISTS ix_inventory_resource_assignment_source_02c4e3a3 ON inventory_topology.resource_assignment (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_inventory_resource_assignment_attrgin_46819e9d ON inventory_topology.resource_assignment USING gin (attributes);
COMMENT ON TABLE inventory_topology.resource_assignment IS 'Starter table for Inventory And Topology. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN inventory_topology.resource_assignment.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN inventory_topology.resource_assignment.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN inventory_topology.resource_assignment.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS inventory_topology.discovered_resource_staging (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_inventory_discovered_resource_stagin_canonica_610c5c76 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_inventory_discovered_resource_stagin_version_9c0d6c34 CHECK (version > 0),
    CONSTRAINT ck_inventory_discovered_resource_stagin_validity_1f3c181a CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_inventory_discovered_resource_stagin_canonica_c5f351b2 ON inventory_topology.discovered_resource_staging (canonical_id);
CREATE INDEX IF NOT EXISTS ix_inventory_discovered_resource_stagin_status_9971da58 ON inventory_topology.discovered_resource_staging (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_inventory_discovered_resource_stagin_updated_5d61649d ON inventory_topology.discovered_resource_staging (updated_at);
CREATE INDEX IF NOT EXISTS ix_inventory_discovered_resource_stagin_source_0f2b5be0 ON inventory_topology.discovered_resource_staging (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_inventory_discovered_resource_stagin_attrgin_aac3dd80 ON inventory_topology.discovered_resource_staging USING gin (attributes);
COMMENT ON TABLE inventory_topology.discovered_resource_staging IS 'Starter table for Inventory And Topology. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN inventory_topology.discovered_resource_staging.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN inventory_topology.discovered_resource_staging.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN inventory_topology.discovered_resource_staging.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS inventory_topology.inventory_reconciliation_record (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_inventory_inventory_reconciliation_r_canonica_cf7dac2e UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_inventory_inventory_reconciliation_r_version_b54dda6c CHECK (version > 0),
    CONSTRAINT ck_inventory_inventory_reconciliation_r_validity_8b18e6f3 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_inventory_inventory_reconciliation_r_canonica_e179914d ON inventory_topology.inventory_reconciliation_record (canonical_id);
CREATE INDEX IF NOT EXISTS ix_inventory_inventory_reconciliation_r_status_a9abd22e ON inventory_topology.inventory_reconciliation_record (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_inventory_inventory_reconciliation_r_updated_7dce0689 ON inventory_topology.inventory_reconciliation_record (updated_at);
CREATE INDEX IF NOT EXISTS ix_inventory_inventory_reconciliation_r_source_ba48ad5e ON inventory_topology.inventory_reconciliation_record (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_inventory_inventory_reconciliation_r_attrgin_b2b3a52d ON inventory_topology.inventory_reconciliation_record USING gin (attributes);
COMMENT ON TABLE inventory_topology.inventory_reconciliation_record IS 'Starter table for Inventory And Topology. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN inventory_topology.inventory_reconciliation_record.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN inventory_topology.inventory_reconciliation_record.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN inventory_topology.inventory_reconciliation_record.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS inventory_topology.migration_decommissioning_state (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_inventory_migration_decommissioning__canonica_6dfcc0f1 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_inventory_migration_decommissioning__version_72c3a524 CHECK (version > 0),
    CONSTRAINT ck_inventory_migration_decommissioning__validity_418b8dfe CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_inventory_migration_decommissioning__canonica_4a8067ee ON inventory_topology.migration_decommissioning_state (canonical_id);
CREATE INDEX IF NOT EXISTS ix_inventory_migration_decommissioning__status_3e4b6f72 ON inventory_topology.migration_decommissioning_state (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_inventory_migration_decommissioning__updated_91fe9131 ON inventory_topology.migration_decommissioning_state (updated_at);
CREATE INDEX IF NOT EXISTS ix_inventory_migration_decommissioning__source_614702df ON inventory_topology.migration_decommissioning_state (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_inventory_migration_decommissioning__attrgin_a737be6f ON inventory_topology.migration_decommissioning_state USING gin (attributes);
COMMENT ON TABLE inventory_topology.migration_decommissioning_state IS 'Starter table for Inventory And Topology. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN inventory_topology.migration_decommissioning_state.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN inventory_topology.migration_decommissioning_state.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN inventory_topology.migration_decommissioning_state.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS inventory_topology.event_outbox (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    event_name text NOT NULL,
    event_version integer NOT NULL DEFAULT 1,
    event_key text NOT NULL,
    aggregate_type text NOT NULL,
    aggregate_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    payload jsonb NOT NULL,
    headers jsonb NOT NULL DEFAULT '{}'::jsonb,
    data_classification text NOT NULL DEFAULT 'internal',
    occurred_at timestamptz NOT NULL DEFAULT now(),
    published_at timestamptz,
    publish_status text NOT NULL DEFAULT 'pending',
    publish_attempt_count integer NOT NULL DEFAULT 0,
    last_error text,
    correlation_id text,
    causation_id text,
    created_at timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT ck_inventory_event_outbox_status_9164fe4a CHECK (publish_status IN ('pending', 'published', 'failed', 'dead_letter'))
);

CREATE INDEX IF NOT EXISTS ix_inventory_event_outbox_publish_df2c4dc5 ON inventory_topology.event_outbox (publish_status, occurred_at);
CREATE INDEX IF NOT EXISTS ix_inventory_event_outbox_eventkey_f61dc55b ON inventory_topology.event_outbox (event_key, occurred_at);
CREATE INDEX IF NOT EXISTS ix_inventory_event_outbox_agg_df917f5f ON inventory_topology.event_outbox (aggregate_type, aggregate_id);
COMMENT ON TABLE inventory_topology.event_outbox IS 'Transactional event outbox for the owning app schema. Event contracts must be registered before publishing beyond the suite boundary.';

CREATE TABLE IF NOT EXISTS fulfillment_activation.service_order_execution (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_fulfillme_service_order_execution_canonica_e9582e44 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_fulfillme_service_order_execution_version_86928e5b CHECK (version > 0),
    CONSTRAINT ck_fulfillme_service_order_execution_validity_e4170420 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_fulfillme_service_order_execution_canonica_f565f3f5 ON fulfillment_activation.service_order_execution (canonical_id);
CREATE INDEX IF NOT EXISTS ix_fulfillme_service_order_execution_status_443ee775 ON fulfillment_activation.service_order_execution (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_fulfillme_service_order_execution_updated_0473a3bc ON fulfillment_activation.service_order_execution (updated_at);
CREATE INDEX IF NOT EXISTS ix_fulfillme_service_order_execution_source_066f0ac3 ON fulfillment_activation.service_order_execution (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_fulfillme_service_order_execution_attrgin_6018d5b8 ON fulfillment_activation.service_order_execution USING gin (attributes);
COMMENT ON TABLE fulfillment_activation.service_order_execution IS 'Starter table for Fulfillment And Activation Control Tower. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN fulfillment_activation.service_order_execution.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN fulfillment_activation.service_order_execution.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN fulfillment_activation.service_order_execution.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS fulfillment_activation.resource_order_execution (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_fulfillme_resource_order_execution_canonica_24471a90 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_fulfillme_resource_order_execution_version_21e91ccc CHECK (version > 0),
    CONSTRAINT ck_fulfillme_resource_order_execution_validity_dbdd9991 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_fulfillme_resource_order_execution_canonica_f0c5ca71 ON fulfillment_activation.resource_order_execution (canonical_id);
CREATE INDEX IF NOT EXISTS ix_fulfillme_resource_order_execution_status_056b8aff ON fulfillment_activation.resource_order_execution (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_fulfillme_resource_order_execution_updated_59a963b5 ON fulfillment_activation.resource_order_execution (updated_at);
CREATE INDEX IF NOT EXISTS ix_fulfillme_resource_order_execution_source_1a637cec ON fulfillment_activation.resource_order_execution (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_fulfillme_resource_order_execution_attrgin_bfaa41b1 ON fulfillment_activation.resource_order_execution USING gin (attributes);
COMMENT ON TABLE fulfillment_activation.resource_order_execution IS 'Starter table for Fulfillment And Activation Control Tower. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN fulfillment_activation.resource_order_execution.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN fulfillment_activation.resource_order_execution.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN fulfillment_activation.resource_order_execution.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS fulfillment_activation.activation_request (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_fulfillme_activation_request_canonica_4178464b UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_fulfillme_activation_request_version_359e2295 CHECK (version > 0),
    CONSTRAINT ck_fulfillme_activation_request_validity_ae1063d9 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_fulfillme_activation_request_canonica_6b313d2b ON fulfillment_activation.activation_request (canonical_id);
CREATE INDEX IF NOT EXISTS ix_fulfillme_activation_request_status_fc05fb00 ON fulfillment_activation.activation_request (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_fulfillme_activation_request_updated_38517555 ON fulfillment_activation.activation_request (updated_at);
CREATE INDEX IF NOT EXISTS ix_fulfillme_activation_request_source_f7747df2 ON fulfillment_activation.activation_request (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_fulfillme_activation_request_attrgin_353694de ON fulfillment_activation.activation_request USING gin (attributes);
COMMENT ON TABLE fulfillment_activation.activation_request IS 'Starter table for Fulfillment And Activation Control Tower. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN fulfillment_activation.activation_request.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN fulfillment_activation.activation_request.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN fulfillment_activation.activation_request.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS fulfillment_activation.activation_response (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_fulfillme_activation_response_canonica_1c6da1ab UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_fulfillme_activation_response_version_1fe1ca5b CHECK (version > 0),
    CONSTRAINT ck_fulfillme_activation_response_validity_c4bf13c4 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_fulfillme_activation_response_canonica_f958f784 ON fulfillment_activation.activation_response (canonical_id);
CREATE INDEX IF NOT EXISTS ix_fulfillme_activation_response_status_7e310be8 ON fulfillment_activation.activation_response (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_fulfillme_activation_response_updated_8e252904 ON fulfillment_activation.activation_response (updated_at);
CREATE INDEX IF NOT EXISTS ix_fulfillme_activation_response_source_6eed5e9a ON fulfillment_activation.activation_response (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_fulfillme_activation_response_attrgin_34db4851 ON fulfillment_activation.activation_response USING gin (attributes);
COMMENT ON TABLE fulfillment_activation.activation_response IS 'Starter table for Fulfillment And Activation Control Tower. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN fulfillment_activation.activation_response.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN fulfillment_activation.activation_response.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN fulfillment_activation.activation_response.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS fulfillment_activation.provisioning_workflow_state (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_fulfillme_provisioning_workflow_stat_canonica_451f2dc9 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_fulfillme_provisioning_workflow_stat_version_485199ee CHECK (version > 0),
    CONSTRAINT ck_fulfillme_provisioning_workflow_stat_validity_fca9eedb CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_fulfillme_provisioning_workflow_stat_canonica_8aca8da7 ON fulfillment_activation.provisioning_workflow_state (canonical_id);
CREATE INDEX IF NOT EXISTS ix_fulfillme_provisioning_workflow_stat_status_f0b87fbc ON fulfillment_activation.provisioning_workflow_state (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_fulfillme_provisioning_workflow_stat_updated_a6309314 ON fulfillment_activation.provisioning_workflow_state (updated_at);
CREATE INDEX IF NOT EXISTS ix_fulfillme_provisioning_workflow_stat_source_f1a7a345 ON fulfillment_activation.provisioning_workflow_state (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_fulfillme_provisioning_workflow_stat_attrgin_012b3b45 ON fulfillment_activation.provisioning_workflow_state USING gin (attributes);
COMMENT ON TABLE fulfillment_activation.provisioning_workflow_state IS 'Starter table for Fulfillment And Activation Control Tower. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN fulfillment_activation.provisioning_workflow_state.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN fulfillment_activation.provisioning_workflow_state.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN fulfillment_activation.provisioning_workflow_state.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS fulfillment_activation.fulfillment_fallout (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_fulfillme_fulfillment_fallout_canonica_d603769a UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_fulfillme_fulfillment_fallout_version_20ecd1b7 CHECK (version > 0),
    CONSTRAINT ck_fulfillme_fulfillment_fallout_validity_ce306544 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_fulfillme_fulfillment_fallout_canonica_899c0931 ON fulfillment_activation.fulfillment_fallout (canonical_id);
CREATE INDEX IF NOT EXISTS ix_fulfillme_fulfillment_fallout_status_2ffe51c0 ON fulfillment_activation.fulfillment_fallout (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_fulfillme_fulfillment_fallout_updated_637dd907 ON fulfillment_activation.fulfillment_fallout (updated_at);
CREATE INDEX IF NOT EXISTS ix_fulfillme_fulfillment_fallout_source_a0ab2c2d ON fulfillment_activation.fulfillment_fallout (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_fulfillme_fulfillment_fallout_attrgin_597a0328 ON fulfillment_activation.fulfillment_fallout USING gin (attributes);
COMMENT ON TABLE fulfillment_activation.fulfillment_fallout IS 'Starter table for Fulfillment And Activation Control Tower. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN fulfillment_activation.fulfillment_fallout.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN fulfillment_activation.fulfillment_fallout.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN fulfillment_activation.fulfillment_fallout.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS fulfillment_activation.fulfillment_handover_evidence (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_fulfillme_fulfillment_handover_evide_canonica_794c03a8 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_fulfillme_fulfillment_handover_evide_version_f29f90f7 CHECK (version > 0),
    CONSTRAINT ck_fulfillme_fulfillment_handover_evide_validity_9ff5f6ee CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_fulfillme_fulfillment_handover_evide_canonica_0c7d6132 ON fulfillment_activation.fulfillment_handover_evidence (canonical_id);
CREATE INDEX IF NOT EXISTS ix_fulfillme_fulfillment_handover_evide_status_4f73442c ON fulfillment_activation.fulfillment_handover_evidence (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_fulfillme_fulfillment_handover_evide_updated_1bd6c71f ON fulfillment_activation.fulfillment_handover_evidence (updated_at);
CREATE INDEX IF NOT EXISTS ix_fulfillme_fulfillment_handover_evide_source_2b132b85 ON fulfillment_activation.fulfillment_handover_evidence (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_fulfillme_fulfillment_handover_evide_attrgin_7dd54c45 ON fulfillment_activation.fulfillment_handover_evidence USING gin (attributes);
COMMENT ON TABLE fulfillment_activation.fulfillment_handover_evidence IS 'Starter table for Fulfillment And Activation Control Tower. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN fulfillment_activation.fulfillment_handover_evidence.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN fulfillment_activation.fulfillment_handover_evidence.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN fulfillment_activation.fulfillment_handover_evidence.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS fulfillment_activation.event_outbox (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    event_name text NOT NULL,
    event_version integer NOT NULL DEFAULT 1,
    event_key text NOT NULL,
    aggregate_type text NOT NULL,
    aggregate_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    payload jsonb NOT NULL,
    headers jsonb NOT NULL DEFAULT '{}'::jsonb,
    data_classification text NOT NULL DEFAULT 'internal',
    occurred_at timestamptz NOT NULL DEFAULT now(),
    published_at timestamptz,
    publish_status text NOT NULL DEFAULT 'pending',
    publish_attempt_count integer NOT NULL DEFAULT 0,
    last_error text,
    correlation_id text,
    causation_id text,
    created_at timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT ck_fulfillme_event_outbox_status_9dedfad4 CHECK (publish_status IN ('pending', 'published', 'failed', 'dead_letter'))
);

CREATE INDEX IF NOT EXISTS ix_fulfillme_event_outbox_publish_9d36780e ON fulfillment_activation.event_outbox (publish_status, occurred_at);
CREATE INDEX IF NOT EXISTS ix_fulfillme_event_outbox_eventkey_deb5ca26 ON fulfillment_activation.event_outbox (event_key, occurred_at);
CREATE INDEX IF NOT EXISTS ix_fulfillme_event_outbox_agg_97787131 ON fulfillment_activation.event_outbox (aggregate_type, aggregate_id);
COMMENT ON TABLE fulfillment_activation.event_outbox IS 'Transactional event outbox for the owning app schema. Event contracts must be registered before publishing beyond the suite boundary.';

CREATE TABLE IF NOT EXISTS field_stock_logistics.appointment (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_field_sto_appointment_canonica_d6a85652 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_field_sto_appointment_version_8e74fa5d CHECK (version > 0),
    CONSTRAINT ck_field_sto_appointment_validity_fe093493 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_field_sto_appointment_canonica_1cf3c2d1 ON field_stock_logistics.appointment (canonical_id);
CREATE INDEX IF NOT EXISTS ix_field_sto_appointment_status_6cf121c0 ON field_stock_logistics.appointment (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_field_sto_appointment_updated_59829175 ON field_stock_logistics.appointment (updated_at);
CREATE INDEX IF NOT EXISTS ix_field_sto_appointment_source_bde9d731 ON field_stock_logistics.appointment (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_field_sto_appointment_attrgin_aae7d959 ON field_stock_logistics.appointment USING gin (attributes);
COMMENT ON TABLE field_stock_logistics.appointment IS 'Starter table for Field Work, Stock, And Logistics. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN field_stock_logistics.appointment.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN field_stock_logistics.appointment.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN field_stock_logistics.appointment.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS field_stock_logistics.work_order (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_field_sto_work_order_canonica_7e61e499 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_field_sto_work_order_version_b9de3bb1 CHECK (version > 0),
    CONSTRAINT ck_field_sto_work_order_validity_3375e30a CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_field_sto_work_order_canonica_671fab76 ON field_stock_logistics.work_order (canonical_id);
CREATE INDEX IF NOT EXISTS ix_field_sto_work_order_status_e2a2c8a7 ON field_stock_logistics.work_order (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_field_sto_work_order_updated_023e6bc4 ON field_stock_logistics.work_order (updated_at);
CREATE INDEX IF NOT EXISTS ix_field_sto_work_order_source_11c20f02 ON field_stock_logistics.work_order (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_field_sto_work_order_attrgin_f16a123a ON field_stock_logistics.work_order USING gin (attributes);
COMMENT ON TABLE field_stock_logistics.work_order IS 'Starter table for Field Work, Stock, And Logistics. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN field_stock_logistics.work_order.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN field_stock_logistics.work_order.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN field_stock_logistics.work_order.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS field_stock_logistics.dispatch_plan (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_field_sto_dispatch_plan_canonica_b8032d58 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_field_sto_dispatch_plan_version_c567eb23 CHECK (version > 0),
    CONSTRAINT ck_field_sto_dispatch_plan_validity_162e9e3e CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_field_sto_dispatch_plan_canonica_048bc9d2 ON field_stock_logistics.dispatch_plan (canonical_id);
CREATE INDEX IF NOT EXISTS ix_field_sto_dispatch_plan_status_2f9ec0ec ON field_stock_logistics.dispatch_plan (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_field_sto_dispatch_plan_updated_3c38841e ON field_stock_logistics.dispatch_plan (updated_at);
CREATE INDEX IF NOT EXISTS ix_field_sto_dispatch_plan_source_9de9fe49 ON field_stock_logistics.dispatch_plan (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_field_sto_dispatch_plan_attrgin_cee4e023 ON field_stock_logistics.dispatch_plan USING gin (attributes);
COMMENT ON TABLE field_stock_logistics.dispatch_plan IS 'Starter table for Field Work, Stock, And Logistics. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN field_stock_logistics.dispatch_plan.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN field_stock_logistics.dispatch_plan.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN field_stock_logistics.dispatch_plan.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS field_stock_logistics.field_evidence (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_field_sto_field_evidence_canonica_75b0463b UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_field_sto_field_evidence_version_13954f35 CHECK (version > 0),
    CONSTRAINT ck_field_sto_field_evidence_validity_38dc48e7 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_field_sto_field_evidence_canonica_36313c20 ON field_stock_logistics.field_evidence (canonical_id);
CREATE INDEX IF NOT EXISTS ix_field_sto_field_evidence_status_7f348ff4 ON field_stock_logistics.field_evidence (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_field_sto_field_evidence_updated_90a15096 ON field_stock_logistics.field_evidence (updated_at);
CREATE INDEX IF NOT EXISTS ix_field_sto_field_evidence_source_520b5c74 ON field_stock_logistics.field_evidence (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_field_sto_field_evidence_attrgin_8301f242 ON field_stock_logistics.field_evidence USING gin (attributes);
COMMENT ON TABLE field_stock_logistics.field_evidence IS 'Starter table for Field Work, Stock, And Logistics. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN field_stock_logistics.field_evidence.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN field_stock_logistics.field_evidence.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN field_stock_logistics.field_evidence.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS field_stock_logistics.stock_item (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_field_sto_stock_item_canonica_9ec5792a UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_field_sto_stock_item_version_75a540d8 CHECK (version > 0),
    CONSTRAINT ck_field_sto_stock_item_validity_513af410 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_field_sto_stock_item_canonica_2f099690 ON field_stock_logistics.stock_item (canonical_id);
CREATE INDEX IF NOT EXISTS ix_field_sto_stock_item_status_10f690d8 ON field_stock_logistics.stock_item (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_field_sto_stock_item_updated_f2312b6f ON field_stock_logistics.stock_item (updated_at);
CREATE INDEX IF NOT EXISTS ix_field_sto_stock_item_source_2b24dd6f ON field_stock_logistics.stock_item (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_field_sto_stock_item_attrgin_c311d238 ON field_stock_logistics.stock_item USING gin (attributes);
COMMENT ON TABLE field_stock_logistics.stock_item IS 'Starter table for Field Work, Stock, And Logistics. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN field_stock_logistics.stock_item.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN field_stock_logistics.stock_item.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN field_stock_logistics.stock_item.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS field_stock_logistics.stock_balance (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_field_sto_stock_balance_canonica_f13dd6ac UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_field_sto_stock_balance_version_ca516df3 CHECK (version > 0),
    CONSTRAINT ck_field_sto_stock_balance_validity_472be599 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_field_sto_stock_balance_canonica_893604e0 ON field_stock_logistics.stock_balance (canonical_id);
CREATE INDEX IF NOT EXISTS ix_field_sto_stock_balance_status_42510b32 ON field_stock_logistics.stock_balance (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_field_sto_stock_balance_updated_e741de8f ON field_stock_logistics.stock_balance (updated_at);
CREATE INDEX IF NOT EXISTS ix_field_sto_stock_balance_source_3857ae44 ON field_stock_logistics.stock_balance (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_field_sto_stock_balance_attrgin_eb579679 ON field_stock_logistics.stock_balance USING gin (attributes);
COMMENT ON TABLE field_stock_logistics.stock_balance IS 'Starter table for Field Work, Stock, And Logistics. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN field_stock_logistics.stock_balance.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN field_stock_logistics.stock_balance.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN field_stock_logistics.stock_balance.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS field_stock_logistics.shipping_order (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_field_sto_shipping_order_canonica_1e5b7bed UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_field_sto_shipping_order_version_b2607607 CHECK (version > 0),
    CONSTRAINT ck_field_sto_shipping_order_validity_a2cc8d83 CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_field_sto_shipping_order_canonica_b4c9b910 ON field_stock_logistics.shipping_order (canonical_id);
CREATE INDEX IF NOT EXISTS ix_field_sto_shipping_order_status_5a610de8 ON field_stock_logistics.shipping_order (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_field_sto_shipping_order_updated_8c381ed0 ON field_stock_logistics.shipping_order (updated_at);
CREATE INDEX IF NOT EXISTS ix_field_sto_shipping_order_source_139e61d0 ON field_stock_logistics.shipping_order (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_field_sto_shipping_order_attrgin_49b2a574 ON field_stock_logistics.shipping_order USING gin (attributes);
COMMENT ON TABLE field_stock_logistics.shipping_order IS 'Starter table for Field Work, Stock, And Logistics. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN field_stock_logistics.shipping_order.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN field_stock_logistics.shipping_order.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN field_stock_logistics.shipping_order.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS field_stock_logistics.tracking_event (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_field_sto_tracking_event_canonica_bf117a52 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_field_sto_tracking_event_version_aa0fe31c CHECK (version > 0),
    CONSTRAINT ck_field_sto_tracking_event_validity_24489f9d CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_field_sto_tracking_event_canonica_2c244132 ON field_stock_logistics.tracking_event (canonical_id);
CREATE INDEX IF NOT EXISTS ix_field_sto_tracking_event_status_e9c127dd ON field_stock_logistics.tracking_event (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_field_sto_tracking_event_updated_1f4939f4 ON field_stock_logistics.tracking_event (updated_at);
CREATE INDEX IF NOT EXISTS ix_field_sto_tracking_event_source_c762c254 ON field_stock_logistics.tracking_event (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_field_sto_tracking_event_attrgin_56070054 ON field_stock_logistics.tracking_event USING gin (attributes);
COMMENT ON TABLE field_stock_logistics.tracking_event IS 'Starter table for Field Work, Stock, And Logistics. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN field_stock_logistics.tracking_event.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN field_stock_logistics.tracking_event.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN field_stock_logistics.tracking_event.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS field_stock_logistics.field_inventory_handover (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    canonical_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    lifecycle_state text NOT NULL DEFAULT 'draft',
    status text NOT NULL DEFAULT 'active',
    version integer NOT NULL DEFAULT 1,
    valid_from timestamptz,
    valid_to timestamptz,
    source_suite text,
    source_app text,
    source_entity text,
    source_id text,
    source_version text,
    tmf_api text,
    tmf_resource text,
    tmf_version text,
    tmf_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    extension_attributes jsonb NOT NULL DEFAULT '{}'::jsonb,
    retention_class text,
    data_classification text NOT NULL DEFAULT 'internal',
    legal_hold boolean NOT NULL DEFAULT false,
    residency_region text,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    updated_at timestamptz NOT NULL DEFAULT now(),
    updated_by text,
    deleted_at timestamptz,
    CONSTRAINT uk_field_sto_field_inventory_handover_canonica_c3fe7d52 UNIQUE (tenant_id, canonical_id),
    CONSTRAINT ck_field_sto_field_inventory_handover_version_2874134c CHECK (version > 0),
    CONSTRAINT ck_field_sto_field_inventory_handover_validity_43e9550c CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE INDEX IF NOT EXISTS ix_field_sto_field_inventory_handover_canonica_ff5eb0af ON field_stock_logistics.field_inventory_handover (canonical_id);
CREATE INDEX IF NOT EXISTS ix_field_sto_field_inventory_handover_status_b11aa3e3 ON field_stock_logistics.field_inventory_handover (tenant_id, lifecycle_state, status);
CREATE INDEX IF NOT EXISTS ix_field_sto_field_inventory_handover_updated_ad879003 ON field_stock_logistics.field_inventory_handover (updated_at);
CREATE INDEX IF NOT EXISTS ix_field_sto_field_inventory_handover_source_0fa9bc16 ON field_stock_logistics.field_inventory_handover (source_suite, source_app, source_entity, source_id) WHERE source_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_field_sto_field_inventory_handover_attrgin_8c527345 ON field_stock_logistics.field_inventory_handover USING gin (attributes);
COMMENT ON TABLE field_stock_logistics.field_inventory_handover IS 'Starter table for Field Work, Stock, And Logistics. Refine typed domain columns and TMF field mappings before production implementation.';
COMMENT ON COLUMN field_stock_logistics.field_inventory_handover.tmf_payload IS 'TMF-aligned payload fragment or snapshot validated against the local TMF reference set before API exposure.';
COMMENT ON COLUMN field_stock_logistics.field_inventory_handover.attributes IS 'Typed domain attributes should graduate to first-class columns when stable or frequently queried.';
COMMENT ON COLUMN field_stock_logistics.field_inventory_handover.extension_attributes IS 'TMF characteristics, non-TMF extensions, or implementation metadata with documented compatibility status.';

CREATE TABLE IF NOT EXISTS field_stock_logistics.event_outbox (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    event_name text NOT NULL,
    event_version integer NOT NULL DEFAULT 1,
    event_key text NOT NULL,
    aggregate_type text NOT NULL,
    aggregate_id text NOT NULL,
    tenant_id text NOT NULL DEFAULT 'default',
    brand text,
    market text,
    payload jsonb NOT NULL,
    headers jsonb NOT NULL DEFAULT '{}'::jsonb,
    data_classification text NOT NULL DEFAULT 'internal',
    occurred_at timestamptz NOT NULL DEFAULT now(),
    published_at timestamptz,
    publish_status text NOT NULL DEFAULT 'pending',
    publish_attempt_count integer NOT NULL DEFAULT 0,
    last_error text,
    correlation_id text,
    causation_id text,
    created_at timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT ck_field_sto_event_outbox_status_dd318671 CHECK (publish_status IN ('pending', 'published', 'failed', 'dead_letter'))
);

CREATE INDEX IF NOT EXISTS ix_field_sto_event_outbox_publish_9b50ddcc ON field_stock_logistics.event_outbox (publish_status, occurred_at);
CREATE INDEX IF NOT EXISTS ix_field_sto_event_outbox_eventkey_eff589c6 ON field_stock_logistics.event_outbox (event_key, occurred_at);
CREATE INDEX IF NOT EXISTS ix_field_sto_event_outbox_agg_edcc8433 ON field_stock_logistics.event_outbox (aggregate_type, aggregate_id);
COMMENT ON TABLE field_stock_logistics.event_outbox IS 'Transactional event outbox for the owning app schema. Event contracts must be registered before publishing beyond the suite boundary.';


GRANT USAGE ON SCHEMA service_resource_design TO telcosuite_app, telcosuite_readonly;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA service_resource_design TO telcosuite_app;
GRANT SELECT ON ALL TABLES IN SCHEMA service_resource_design TO telcosuite_readonly;
ALTER DEFAULT PRIVILEGES IN SCHEMA service_resource_design GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO telcosuite_app;
ALTER DEFAULT PRIVILEGES IN SCHEMA service_resource_design GRANT SELECT ON TABLES TO telcosuite_readonly;
GRANT USAGE ON SCHEMA inventory_topology TO telcosuite_app, telcosuite_readonly;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA inventory_topology TO telcosuite_app;
GRANT SELECT ON ALL TABLES IN SCHEMA inventory_topology TO telcosuite_readonly;
ALTER DEFAULT PRIVILEGES IN SCHEMA inventory_topology GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO telcosuite_app;
ALTER DEFAULT PRIVILEGES IN SCHEMA inventory_topology GRANT SELECT ON TABLES TO telcosuite_readonly;
GRANT USAGE ON SCHEMA fulfillment_activation TO telcosuite_app, telcosuite_readonly;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA fulfillment_activation TO telcosuite_app;
GRANT SELECT ON ALL TABLES IN SCHEMA fulfillment_activation TO telcosuite_readonly;
ALTER DEFAULT PRIVILEGES IN SCHEMA fulfillment_activation GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO telcosuite_app;
ALTER DEFAULT PRIVILEGES IN SCHEMA fulfillment_activation GRANT SELECT ON TABLES TO telcosuite_readonly;
GRANT USAGE ON SCHEMA field_stock_logistics TO telcosuite_app, telcosuite_readonly;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA field_stock_logistics TO telcosuite_app;
GRANT SELECT ON ALL TABLES IN SCHEMA field_stock_logistics TO telcosuite_readonly;
ALTER DEFAULT PRIVILEGES IN SCHEMA field_stock_logistics GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO telcosuite_app;
ALTER DEFAULT PRIVILEGES IN SCHEMA field_stock_logistics GRANT SELECT ON TABLES TO telcosuite_readonly;
