-- TelcoSuite V003 TMF core refinement for Fulfillment And Activation Control Tower
-- Target database: ts_oss_engineering_fulfillment
-- App schema: fulfillment_activation
-- Generated from: planning/suite-details/tmf-api-ddl-reviews/fulfillment-activation.md
-- Reviewed: 2026-06-14

CREATE EXTENSION IF NOT EXISTS pgcrypto;

BEGIN;

COMMENT ON SCHEMA fulfillment_activation IS 'App-owned schema for Fulfillment And Activation Control Tower; V002 TMF baseline review complete on 2026-06-14.';

-- Promote common TMF resource fields on fulfillment_activation.service_order_execution.
ALTER TABLE fulfillment_activation.service_order_execution
    ADD COLUMN IF NOT EXISTS tmf_id text,
    ADD COLUMN IF NOT EXISTS tmf_href text,
    ADD COLUMN IF NOT EXISTS tmf_type text,
    ADD COLUMN IF NOT EXISTS tmf_base_type text,
    ADD COLUMN IF NOT EXISTS tmf_schema_location text,
    ADD COLUMN IF NOT EXISTS tmf_referred_type text,
    ADD COLUMN IF NOT EXISTS tmf_name text,
    ADD COLUMN IF NOT EXISTS tmf_description text,
    ADD COLUMN IF NOT EXISTS tmf_category text,
    ADD COLUMN IF NOT EXISTS tmf_lifecycle_status text,
    ADD COLUMN IF NOT EXISTS tmf_state text,
    ADD COLUMN IF NOT EXISTS tmf_status_reason text,
    ADD COLUMN IF NOT EXISTS tmf_priority text,
    ADD COLUMN IF NOT EXISTS tmf_last_update timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_start_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_end_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_requested_start_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_requested_completion_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_expected_completion_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_completion_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_external_id text;
CREATE INDEX IF NOT EXISTS ix_service_order_execution_tmf_id ON fulfillment_activation.service_order_execution (tmf_id) WHERE tmf_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_service_order_execution_tmf_href ON fulfillment_activation.service_order_execution (tmf_href) WHERE tmf_href IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_service_order_execution_tmf_state ON fulfillment_activation.service_order_execution (tenant_id, tmf_state) WHERE tmf_state IS NOT NULL;
COMMENT ON COLUMN fulfillment_activation.service_order_execution.tmf_payload IS 'Full validated TMF resource payload retained for fields not promoted to typed columns.';
COMMENT ON COLUMN fulfillment_activation.service_order_execution.tmf_id IS 'TMF resource id from the selected local TMF API baseline when different from canonical_id.';

-- Promote common TMF resource fields on fulfillment_activation.resource_order_execution.
ALTER TABLE fulfillment_activation.resource_order_execution
    ADD COLUMN IF NOT EXISTS tmf_id text,
    ADD COLUMN IF NOT EXISTS tmf_href text,
    ADD COLUMN IF NOT EXISTS tmf_type text,
    ADD COLUMN IF NOT EXISTS tmf_base_type text,
    ADD COLUMN IF NOT EXISTS tmf_schema_location text,
    ADD COLUMN IF NOT EXISTS tmf_referred_type text,
    ADD COLUMN IF NOT EXISTS tmf_name text,
    ADD COLUMN IF NOT EXISTS tmf_description text,
    ADD COLUMN IF NOT EXISTS tmf_category text,
    ADD COLUMN IF NOT EXISTS tmf_lifecycle_status text,
    ADD COLUMN IF NOT EXISTS tmf_state text,
    ADD COLUMN IF NOT EXISTS tmf_status_reason text,
    ADD COLUMN IF NOT EXISTS tmf_priority text,
    ADD COLUMN IF NOT EXISTS tmf_last_update timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_start_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_end_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_requested_start_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_requested_completion_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_expected_completion_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_completion_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_external_id text;
CREATE INDEX IF NOT EXISTS ix_resource_order_execution_tmf_id ON fulfillment_activation.resource_order_execution (tmf_id) WHERE tmf_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_resource_order_execution_tmf_href ON fulfillment_activation.resource_order_execution (tmf_href) WHERE tmf_href IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_resource_order_execution_tmf_state ON fulfillment_activation.resource_order_execution (tenant_id, tmf_state) WHERE tmf_state IS NOT NULL;
COMMENT ON COLUMN fulfillment_activation.resource_order_execution.tmf_payload IS 'Full validated TMF resource payload retained for fields not promoted to typed columns.';
COMMENT ON COLUMN fulfillment_activation.resource_order_execution.tmf_id IS 'TMF resource id from the selected local TMF API baseline when different from canonical_id.';

-- Promote common TMF resource fields on fulfillment_activation.activation_request.
ALTER TABLE fulfillment_activation.activation_request
    ADD COLUMN IF NOT EXISTS tmf_id text,
    ADD COLUMN IF NOT EXISTS tmf_href text,
    ADD COLUMN IF NOT EXISTS tmf_type text,
    ADD COLUMN IF NOT EXISTS tmf_base_type text,
    ADD COLUMN IF NOT EXISTS tmf_schema_location text,
    ADD COLUMN IF NOT EXISTS tmf_referred_type text,
    ADD COLUMN IF NOT EXISTS tmf_name text,
    ADD COLUMN IF NOT EXISTS tmf_description text,
    ADD COLUMN IF NOT EXISTS tmf_category text,
    ADD COLUMN IF NOT EXISTS tmf_lifecycle_status text,
    ADD COLUMN IF NOT EXISTS tmf_state text,
    ADD COLUMN IF NOT EXISTS tmf_status_reason text,
    ADD COLUMN IF NOT EXISTS tmf_priority text,
    ADD COLUMN IF NOT EXISTS tmf_last_update timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_start_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_end_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_requested_start_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_requested_completion_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_expected_completion_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_completion_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_external_id text;
CREATE INDEX IF NOT EXISTS ix_activation_request_tmf_id ON fulfillment_activation.activation_request (tmf_id) WHERE tmf_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_activation_request_tmf_href ON fulfillment_activation.activation_request (tmf_href) WHERE tmf_href IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_activation_request_tmf_state ON fulfillment_activation.activation_request (tenant_id, tmf_state) WHERE tmf_state IS NOT NULL;
COMMENT ON COLUMN fulfillment_activation.activation_request.tmf_payload IS 'Full validated TMF resource payload retained for fields not promoted to typed columns.';
COMMENT ON COLUMN fulfillment_activation.activation_request.tmf_id IS 'TMF resource id from the selected local TMF API baseline when different from canonical_id.';

-- Promote common TMF resource fields on fulfillment_activation.activation_response.
ALTER TABLE fulfillment_activation.activation_response
    ADD COLUMN IF NOT EXISTS tmf_id text,
    ADD COLUMN IF NOT EXISTS tmf_href text,
    ADD COLUMN IF NOT EXISTS tmf_type text,
    ADD COLUMN IF NOT EXISTS tmf_base_type text,
    ADD COLUMN IF NOT EXISTS tmf_schema_location text,
    ADD COLUMN IF NOT EXISTS tmf_referred_type text,
    ADD COLUMN IF NOT EXISTS tmf_name text,
    ADD COLUMN IF NOT EXISTS tmf_description text,
    ADD COLUMN IF NOT EXISTS tmf_category text,
    ADD COLUMN IF NOT EXISTS tmf_lifecycle_status text,
    ADD COLUMN IF NOT EXISTS tmf_state text,
    ADD COLUMN IF NOT EXISTS tmf_status_reason text,
    ADD COLUMN IF NOT EXISTS tmf_priority text,
    ADD COLUMN IF NOT EXISTS tmf_last_update timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_start_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_end_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_requested_start_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_requested_completion_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_expected_completion_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_completion_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_external_id text;
CREATE INDEX IF NOT EXISTS ix_activation_response_tmf_id ON fulfillment_activation.activation_response (tmf_id) WHERE tmf_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_activation_response_tmf_href ON fulfillment_activation.activation_response (tmf_href) WHERE tmf_href IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_activation_response_tmf_state ON fulfillment_activation.activation_response (tenant_id, tmf_state) WHERE tmf_state IS NOT NULL;
COMMENT ON COLUMN fulfillment_activation.activation_response.tmf_payload IS 'Full validated TMF resource payload retained for fields not promoted to typed columns.';
COMMENT ON COLUMN fulfillment_activation.activation_response.tmf_id IS 'TMF resource id from the selected local TMF API baseline when different from canonical_id.';

-- Promote common TMF resource fields on fulfillment_activation.provisioning_workflow_state.
ALTER TABLE fulfillment_activation.provisioning_workflow_state
    ADD COLUMN IF NOT EXISTS tmf_id text,
    ADD COLUMN IF NOT EXISTS tmf_href text,
    ADD COLUMN IF NOT EXISTS tmf_type text,
    ADD COLUMN IF NOT EXISTS tmf_base_type text,
    ADD COLUMN IF NOT EXISTS tmf_schema_location text,
    ADD COLUMN IF NOT EXISTS tmf_referred_type text,
    ADD COLUMN IF NOT EXISTS tmf_name text,
    ADD COLUMN IF NOT EXISTS tmf_description text,
    ADD COLUMN IF NOT EXISTS tmf_category text,
    ADD COLUMN IF NOT EXISTS tmf_lifecycle_status text,
    ADD COLUMN IF NOT EXISTS tmf_state text,
    ADD COLUMN IF NOT EXISTS tmf_status_reason text,
    ADD COLUMN IF NOT EXISTS tmf_priority text,
    ADD COLUMN IF NOT EXISTS tmf_last_update timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_start_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_end_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_requested_start_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_requested_completion_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_expected_completion_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_completion_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_external_id text;
CREATE INDEX IF NOT EXISTS ix_provisioning_workflow_state_tmf_id ON fulfillment_activation.provisioning_workflow_state (tmf_id) WHERE tmf_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_provisioning_workflow_state_tmf_href ON fulfillment_activation.provisioning_workflow_state (tmf_href) WHERE tmf_href IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_provisioning_workflow_state_tmf_state ON fulfillment_activation.provisioning_workflow_state (tenant_id, tmf_state) WHERE tmf_state IS NOT NULL;
COMMENT ON COLUMN fulfillment_activation.provisioning_workflow_state.tmf_payload IS 'Full validated TMF resource payload retained for fields not promoted to typed columns.';
COMMENT ON COLUMN fulfillment_activation.provisioning_workflow_state.tmf_id IS 'TMF resource id from the selected local TMF API baseline when different from canonical_id.';

-- Promote common TMF resource fields on fulfillment_activation.fulfillment_fallout.
ALTER TABLE fulfillment_activation.fulfillment_fallout
    ADD COLUMN IF NOT EXISTS tmf_id text,
    ADD COLUMN IF NOT EXISTS tmf_href text,
    ADD COLUMN IF NOT EXISTS tmf_type text,
    ADD COLUMN IF NOT EXISTS tmf_base_type text,
    ADD COLUMN IF NOT EXISTS tmf_schema_location text,
    ADD COLUMN IF NOT EXISTS tmf_referred_type text,
    ADD COLUMN IF NOT EXISTS tmf_name text,
    ADD COLUMN IF NOT EXISTS tmf_description text,
    ADD COLUMN IF NOT EXISTS tmf_category text,
    ADD COLUMN IF NOT EXISTS tmf_lifecycle_status text,
    ADD COLUMN IF NOT EXISTS tmf_state text,
    ADD COLUMN IF NOT EXISTS tmf_status_reason text,
    ADD COLUMN IF NOT EXISTS tmf_priority text,
    ADD COLUMN IF NOT EXISTS tmf_last_update timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_start_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_end_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_requested_start_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_requested_completion_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_expected_completion_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_completion_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_external_id text;
CREATE INDEX IF NOT EXISTS ix_fulfillment_fallout_tmf_id ON fulfillment_activation.fulfillment_fallout (tmf_id) WHERE tmf_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_fulfillment_fallout_tmf_href ON fulfillment_activation.fulfillment_fallout (tmf_href) WHERE tmf_href IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_fulfillment_fallout_tmf_state ON fulfillment_activation.fulfillment_fallout (tenant_id, tmf_state) WHERE tmf_state IS NOT NULL;
COMMENT ON COLUMN fulfillment_activation.fulfillment_fallout.tmf_payload IS 'Full validated TMF resource payload retained for fields not promoted to typed columns.';
COMMENT ON COLUMN fulfillment_activation.fulfillment_fallout.tmf_id IS 'TMF resource id from the selected local TMF API baseline when different from canonical_id.';

-- Promote common TMF resource fields on fulfillment_activation.fulfillment_handover_evidence.
ALTER TABLE fulfillment_activation.fulfillment_handover_evidence
    ADD COLUMN IF NOT EXISTS tmf_id text,
    ADD COLUMN IF NOT EXISTS tmf_href text,
    ADD COLUMN IF NOT EXISTS tmf_type text,
    ADD COLUMN IF NOT EXISTS tmf_base_type text,
    ADD COLUMN IF NOT EXISTS tmf_schema_location text,
    ADD COLUMN IF NOT EXISTS tmf_referred_type text,
    ADD COLUMN IF NOT EXISTS tmf_name text,
    ADD COLUMN IF NOT EXISTS tmf_description text,
    ADD COLUMN IF NOT EXISTS tmf_category text,
    ADD COLUMN IF NOT EXISTS tmf_lifecycle_status text,
    ADD COLUMN IF NOT EXISTS tmf_state text,
    ADD COLUMN IF NOT EXISTS tmf_status_reason text,
    ADD COLUMN IF NOT EXISTS tmf_priority text,
    ADD COLUMN IF NOT EXISTS tmf_last_update timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_start_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_end_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_requested_start_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_requested_completion_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_expected_completion_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_completion_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_external_id text;
CREATE INDEX IF NOT EXISTS ix_fulfillment_handover_evidence_tmf_id ON fulfillment_activation.fulfillment_handover_evidence (tmf_id) WHERE tmf_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_fulfillment_handover_evidence_tmf_href ON fulfillment_activation.fulfillment_handover_evidence (tmf_href) WHERE tmf_href IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_fulfillment_handover_evidence_tmf_state ON fulfillment_activation.fulfillment_handover_evidence (tenant_id, tmf_state) WHERE tmf_state IS NOT NULL;
COMMENT ON COLUMN fulfillment_activation.fulfillment_handover_evidence.tmf_payload IS 'Full validated TMF resource payload retained for fields not promoted to typed columns.';
COMMENT ON COLUMN fulfillment_activation.fulfillment_handover_evidence.tmf_id IS 'TMF resource id from the selected local TMF API baseline when different from canonical_id.';

-- Promote common TMF resource fields on fulfillment_activation.event_outbox.
ALTER TABLE fulfillment_activation.event_outbox
    ADD COLUMN IF NOT EXISTS tmf_id text,
    ADD COLUMN IF NOT EXISTS tmf_href text,
    ADD COLUMN IF NOT EXISTS tmf_type text,
    ADD COLUMN IF NOT EXISTS tmf_base_type text,
    ADD COLUMN IF NOT EXISTS tmf_schema_location text,
    ADD COLUMN IF NOT EXISTS tmf_referred_type text,
    ADD COLUMN IF NOT EXISTS tmf_name text,
    ADD COLUMN IF NOT EXISTS tmf_description text,
    ADD COLUMN IF NOT EXISTS tmf_category text,
    ADD COLUMN IF NOT EXISTS tmf_lifecycle_status text,
    ADD COLUMN IF NOT EXISTS tmf_state text,
    ADD COLUMN IF NOT EXISTS tmf_status_reason text,
    ADD COLUMN IF NOT EXISTS tmf_priority text,
    ADD COLUMN IF NOT EXISTS tmf_last_update timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_start_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_end_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_requested_start_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_requested_completion_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_expected_completion_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_completion_date timestamptz,
    ADD COLUMN IF NOT EXISTS tmf_external_id text;
CREATE INDEX IF NOT EXISTS ix_event_outbox_tmf_id ON fulfillment_activation.event_outbox (tmf_id) WHERE tmf_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_event_outbox_tmf_href ON fulfillment_activation.event_outbox (tmf_href) WHERE tmf_href IS NOT NULL;
CREATE INDEX IF NOT EXISTS ix_event_outbox_tmf_state ON fulfillment_activation.event_outbox (tenant_id, tmf_state) WHERE tmf_state IS NOT NULL;
COMMENT ON COLUMN fulfillment_activation.event_outbox.tmf_payload IS 'Full validated TMF resource payload retained for fields not promoted to typed columns.';
COMMENT ON COLUMN fulfillment_activation.event_outbox.tmf_id IS 'TMF resource id from the selected local TMF API baseline when different from canonical_id.';

CREATE TABLE IF NOT EXISTS fulfillment_activation.tmf_api_resource_map (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    tmf_api text NOT NULL,
    tmf_resource text NOT NULL,
    resource_path text,
    anchor_table text NOT NULL,
    ownership_role text NOT NULL DEFAULT 'master_or_projection',
    field_strategy text NOT NULL,
    local_spec_path text,
    promoted_fields jsonb NOT NULL DEFAULT '[]'::jsonb,
    payload_required boolean NOT NULL DEFAULT true,
    contract_test_required boolean NOT NULL DEFAULT true,
    created_at timestamptz NOT NULL DEFAULT now(),
    updated_at timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT uk_tmf_api_resource_map UNIQUE (tmf_api, tmf_resource, anchor_table)
);

CREATE TABLE IF NOT EXISTS fulfillment_activation.tmf_resource_reference (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id text NOT NULL DEFAULT 'default',
    source_table text NOT NULL,
    source_record_id uuid,
    source_canonical_id text,
    reference_role text NOT NULL,
    referenced_api text,
    referenced_resource text,
    referenced_id text,
    referenced_href text,
    referenced_name text,
    referred_type text,
    reference_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    valid_from timestamptz,
    valid_to timestamptz,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    CONSTRAINT ck_tmf_resource_reference_validity CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE TABLE IF NOT EXISTS fulfillment_activation.tmf_characteristic (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id text NOT NULL DEFAULT 'default',
    source_table text NOT NULL,
    source_record_id uuid,
    source_canonical_id text,
    characteristic_name text NOT NULL,
    value_type text,
    characteristic_value jsonb NOT NULL DEFAULT '{}'::jsonb,
    value_from timestamptz,
    value_to timestamptz,
    created_at timestamptz NOT NULL DEFAULT now(),
    created_by text,
    CONSTRAINT ck_tmf_characteristic_validity CHECK (value_to IS NULL OR value_from IS NULL OR value_to >= value_from)
);

CREATE TABLE IF NOT EXISTS fulfillment_activation.tmf_external_identifier (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id text NOT NULL DEFAULT 'default',
    source_table text NOT NULL,
    source_record_id uuid,
    source_canonical_id text,
    owner text,
    external_identifier_type text,
    external_identifier_id text NOT NULL,
    external_href text,
    created_at timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT uk_tmf_external_identifier UNIQUE (tenant_id, source_table, external_identifier_id)
);

CREATE TABLE IF NOT EXISTS fulfillment_activation.tmf_related_party (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id text NOT NULL DEFAULT 'default',
    source_table text NOT NULL,
    source_record_id uuid,
    source_canonical_id text,
    party_id text,
    party_href text,
    party_name text,
    party_role text,
    party_referred_type text,
    related_party_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    created_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS fulfillment_activation.tmf_note (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id text NOT NULL DEFAULT 'default',
    source_table text NOT NULL,
    source_record_id uuid,
    source_canonical_id text,
    note_author text,
    note_date timestamptz,
    note_text text NOT NULL,
    note_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    created_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS fulfillment_activation.tmf_attachment (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id text NOT NULL DEFAULT 'default',
    source_table text NOT NULL,
    source_record_id uuid,
    source_canonical_id text,
    attachment_id text,
    attachment_href text,
    attachment_name text,
    attachment_type text,
    mime_type text,
    content_url text,
    size_amount numeric,
    size_units text,
    attachment_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    created_at timestamptz NOT NULL DEFAULT now()
);

CREATE TABLE IF NOT EXISTS fulfillment_activation.tmf_relationship (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id text NOT NULL DEFAULT 'default',
    source_table text NOT NULL,
    source_record_id uuid,
    source_canonical_id text,
    relationship_type text NOT NULL,
    target_table text,
    target_record_id uuid,
    target_canonical_id text,
    target_api text,
    target_resource text,
    target_href text,
    relationship_payload jsonb NOT NULL DEFAULT '{}'::jsonb,
    valid_from timestamptz,
    valid_to timestamptz,
    created_at timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT ck_tmf_relationship_validity CHECK (valid_to IS NULL OR valid_from IS NULL OR valid_to >= valid_from)
);

CREATE TABLE IF NOT EXISTS fulfillment_activation.event_contract (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    event_name text NOT NULL,
    event_version text NOT NULL DEFAULT 'v1',
    tmf_api text,
    tmf_resource text,
    source_table text NOT NULL,
    event_type text NOT NULL,
    event_key_strategy text NOT NULL,
    payload_basis text NOT NULL,
    outbox_table text NOT NULL DEFAULT 'fulfillment_activation.event_outbox',
    retention_class text NOT NULL DEFAULT 'event_replay_90d',
    masking_policy text NOT NULL DEFAULT 'Apply source table masking policy before external publication',
    consumer_notes text,
    is_active boolean NOT NULL DEFAULT true,
    created_at timestamptz NOT NULL DEFAULT now(),
    updated_at timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT uk_event_contract UNIQUE (event_name, event_version)
);

CREATE TABLE IF NOT EXISTS fulfillment_activation.privacy_retention_policy (
    id uuid PRIMARY KEY DEFAULT gen_random_uuid(),
    table_name text NOT NULL,
    data_domain text NOT NULL,
    data_classification text NOT NULL,
    retention_class text NOT NULL,
    retention_basis text NOT NULL,
    default_retention_days integer,
    legal_hold_supported boolean NOT NULL DEFAULT true,
    residency_rule text,
    masking_policy text NOT NULL,
    audit_level text NOT NULL DEFAULT 'standard',
    created_at timestamptz NOT NULL DEFAULT now(),
    updated_at timestamptz NOT NULL DEFAULT now(),
    CONSTRAINT uk_privacy_retention_policy UNIQUE (table_name)
);

CREATE INDEX IF NOT EXISTS ix_tmf_api_resource_map_lookup ON fulfillment_activation.tmf_api_resource_map (tmf_api, tmf_resource);
CREATE INDEX IF NOT EXISTS ix_tmf_resource_reference_lookup ON fulfillment_activation.tmf_resource_reference (tenant_id, source_table, source_canonical_id);
CREATE INDEX IF NOT EXISTS ix_tmf_characteristic_lookup ON fulfillment_activation.tmf_characteristic (tenant_id, source_table, characteristic_name);
CREATE INDEX IF NOT EXISTS ix_tmf_external_identifier_lookup ON fulfillment_activation.tmf_external_identifier (tenant_id, external_identifier_id);
CREATE INDEX IF NOT EXISTS ix_tmf_related_party_lookup ON fulfillment_activation.tmf_related_party (tenant_id, party_id);
CREATE INDEX IF NOT EXISTS ix_tmf_note_lookup ON fulfillment_activation.tmf_note (tenant_id, source_table, source_canonical_id);
CREATE INDEX IF NOT EXISTS ix_tmf_attachment_lookup ON fulfillment_activation.tmf_attachment (tenant_id, source_table, source_canonical_id);
CREATE INDEX IF NOT EXISTS ix_tmf_relationship_lookup ON fulfillment_activation.tmf_relationship (tenant_id, source_table, relationship_type);
CREATE INDEX IF NOT EXISTS ix_event_contract_lookup ON fulfillment_activation.event_contract (event_name, event_version);
CREATE INDEX IF NOT EXISTS ix_privacy_retention_policy_lookup ON fulfillment_activation.privacy_retention_policy (table_name);

COMMENT ON TABLE fulfillment_activation.tmf_api_resource_map IS 'V002 TMF support/control table for Fulfillment And Activation Control Tower.';
COMMENT ON TABLE fulfillment_activation.tmf_resource_reference IS 'V002 TMF support/control table for Fulfillment And Activation Control Tower.';
COMMENT ON TABLE fulfillment_activation.tmf_characteristic IS 'V002 TMF support/control table for Fulfillment And Activation Control Tower.';
COMMENT ON TABLE fulfillment_activation.tmf_external_identifier IS 'V002 TMF support/control table for Fulfillment And Activation Control Tower.';
COMMENT ON TABLE fulfillment_activation.tmf_related_party IS 'V002 TMF support/control table for Fulfillment And Activation Control Tower.';
COMMENT ON TABLE fulfillment_activation.tmf_note IS 'V002 TMF support/control table for Fulfillment And Activation Control Tower.';
COMMENT ON TABLE fulfillment_activation.tmf_attachment IS 'V002 TMF support/control table for Fulfillment And Activation Control Tower.';
COMMENT ON TABLE fulfillment_activation.tmf_relationship IS 'V002 TMF support/control table for Fulfillment And Activation Control Tower.';
COMMENT ON TABLE fulfillment_activation.event_contract IS 'V002 TMF support/control table for Fulfillment And Activation Control Tower.';
COMMENT ON TABLE fulfillment_activation.privacy_retention_policy IS 'V002 TMF support/control table for Fulfillment And Activation Control Tower.';


INSERT INTO fulfillment_activation.tmf_api_resource_map (tmf_api, tmf_resource, resource_path, anchor_table, field_strategy, local_spec_path, promoted_fields) VALUES ('TMF641', 'cancelServiceOrder', '/cancelServiceOrder', 'service_order_execution', 'Promote common TMF lifecycle/reference fields; store remaining validated resource fields in tmf_payload and characteristics tables.', 'references/tmforum-open-apis/openapi-specs/TMF641_ServiceOrder/TMF641_Service_Ordering_Management_API_v4.1.0_swagger.json', '["id", "href", "cancellationDate", "cancellationReason", "category", "completionDate", "description", "expectedCompletionDate", "externalId", "notificationContact", "orderDate", "priority", "requestedCompletionDate", "requestedStartDate", "startDate", "errorMessage"]'::jsonb) ON CONFLICT (tmf_api, tmf_resource, anchor_table) DO UPDATE SET field_strategy = EXCLUDED.field_strategy, local_spec_path = EXCLUDED.local_spec_path, promoted_fields = EXCLUDED.promoted_fields, updated_at = now();
INSERT INTO fulfillment_activation.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('fulfillment_activation.cancel_service_order.created', 'v1', 'TMF641', 'cancelServiceOrder', 'fulfillment_activation.service_order_execution', 'created', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO fulfillment_activation.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('fulfillment_activation.cancel_service_order.updated', 'v1', 'TMF641', 'cancelServiceOrder', 'fulfillment_activation.service_order_execution', 'updated', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO fulfillment_activation.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('fulfillment_activation.cancel_service_order.stateChanged', 'v1', 'TMF641', 'cancelServiceOrder', 'fulfillment_activation.service_order_execution', 'stateChanged', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO fulfillment_activation.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('fulfillment_activation.cancel_service_order.deleted', 'v1', 'TMF641', 'cancelServiceOrder', 'fulfillment_activation.service_order_execution', 'deleted', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO fulfillment_activation.tmf_api_resource_map (tmf_api, tmf_resource, resource_path, anchor_table, field_strategy, local_spec_path, promoted_fields) VALUES ('TMF641', 'serviceOrder', '/serviceOrder', 'service_order_execution', 'Promote common TMF lifecycle/reference fields; store remaining validated resource fields in tmf_payload and characteristics tables.', 'references/tmforum-open-apis/openapi-specs/TMF641_ServiceOrder/TMF641_Service_Ordering_Management_API_v4.1.0_swagger.json', '["id", "href", "cancellationDate", "cancellationReason", "category", "completionDate", "description", "expectedCompletionDate", "externalId", "notificationContact", "orderDate", "priority", "requestedCompletionDate", "requestedStartDate", "startDate", "errorMessage"]'::jsonb) ON CONFLICT (tmf_api, tmf_resource, anchor_table) DO UPDATE SET field_strategy = EXCLUDED.field_strategy, local_spec_path = EXCLUDED.local_spec_path, promoted_fields = EXCLUDED.promoted_fields, updated_at = now();
INSERT INTO fulfillment_activation.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('fulfillment_activation.service_order.created', 'v1', 'TMF641', 'serviceOrder', 'fulfillment_activation.service_order_execution', 'created', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO fulfillment_activation.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('fulfillment_activation.service_order.updated', 'v1', 'TMF641', 'serviceOrder', 'fulfillment_activation.service_order_execution', 'updated', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO fulfillment_activation.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('fulfillment_activation.service_order.stateChanged', 'v1', 'TMF641', 'serviceOrder', 'fulfillment_activation.service_order_execution', 'stateChanged', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO fulfillment_activation.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('fulfillment_activation.service_order.deleted', 'v1', 'TMF641', 'serviceOrder', 'fulfillment_activation.service_order_execution', 'deleted', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO fulfillment_activation.tmf_api_resource_map (tmf_api, tmf_resource, resource_path, anchor_table, field_strategy, local_spec_path, promoted_fields) VALUES ('TMF652', 'cancelResourceOrder', '/cancelResourceOrder', 'resource_order_execution', 'Promote common TMF lifecycle/reference fields; store remaining validated resource fields in tmf_payload and characteristics tables.', 'references/tmforum-open-apis/openapi-specs/TMF652_ResourceOrderManagement/TMF652_Resource_Order_Management_API_v4.0.0_swagger.json', '["id", "href", "category", "completionDate", "description", "expectedCompletionDate", "externalId", "name", "orderDate", "orderType", "priority", "requestedCompletionDate", "requestedStartDate", "startDate", "state", "externalReference"]'::jsonb) ON CONFLICT (tmf_api, tmf_resource, anchor_table) DO UPDATE SET field_strategy = EXCLUDED.field_strategy, local_spec_path = EXCLUDED.local_spec_path, promoted_fields = EXCLUDED.promoted_fields, updated_at = now();
INSERT INTO fulfillment_activation.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('fulfillment_activation.cancel_resource_order.created', 'v1', 'TMF652', 'cancelResourceOrder', 'fulfillment_activation.resource_order_execution', 'created', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO fulfillment_activation.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('fulfillment_activation.cancel_resource_order.updated', 'v1', 'TMF652', 'cancelResourceOrder', 'fulfillment_activation.resource_order_execution', 'updated', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO fulfillment_activation.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('fulfillment_activation.cancel_resource_order.stateChanged', 'v1', 'TMF652', 'cancelResourceOrder', 'fulfillment_activation.resource_order_execution', 'stateChanged', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO fulfillment_activation.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('fulfillment_activation.cancel_resource_order.deleted', 'v1', 'TMF652', 'cancelResourceOrder', 'fulfillment_activation.resource_order_execution', 'deleted', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO fulfillment_activation.tmf_api_resource_map (tmf_api, tmf_resource, resource_path, anchor_table, field_strategy, local_spec_path, promoted_fields) VALUES ('TMF652', 'resourceOrder', '/resourceOrder', 'resource_order_execution', 'Promote common TMF lifecycle/reference fields; store remaining validated resource fields in tmf_payload and characteristics tables.', 'references/tmforum-open-apis/openapi-specs/TMF652_ResourceOrderManagement/TMF652_Resource_Order_Management_API_v4.0.0_swagger.json', '["id", "href", "category", "completionDate", "description", "expectedCompletionDate", "externalId", "name", "orderDate", "orderType", "priority", "requestedCompletionDate", "requestedStartDate", "startDate", "state", "externalReference"]'::jsonb) ON CONFLICT (tmf_api, tmf_resource, anchor_table) DO UPDATE SET field_strategy = EXCLUDED.field_strategy, local_spec_path = EXCLUDED.local_spec_path, promoted_fields = EXCLUDED.promoted_fields, updated_at = now();
INSERT INTO fulfillment_activation.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('fulfillment_activation.resource_order.created', 'v1', 'TMF652', 'resourceOrder', 'fulfillment_activation.resource_order_execution', 'created', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO fulfillment_activation.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('fulfillment_activation.resource_order.updated', 'v1', 'TMF652', 'resourceOrder', 'fulfillment_activation.resource_order_execution', 'updated', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO fulfillment_activation.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('fulfillment_activation.resource_order.stateChanged', 'v1', 'TMF652', 'resourceOrder', 'fulfillment_activation.resource_order_execution', 'stateChanged', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO fulfillment_activation.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('fulfillment_activation.resource_order.deleted', 'v1', 'TMF652', 'resourceOrder', 'fulfillment_activation.resource_order_execution', 'deleted', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO fulfillment_activation.tmf_api_resource_map (tmf_api, tmf_resource, resource_path, anchor_table, field_strategy, local_spec_path, promoted_fields) VALUES ('TMF640', 'monitor', '/monitor', 'activation_request', 'Promote common TMF lifecycle/reference fields; store remaining validated resource fields in tmf_payload and characteristics tables.', 'references/tmforum-open-apis/openapi-specs/TMF640_ActivationConfiguration/TMF640_Service_Activation_Management_API_v4.0.0_swagger.json', '["id", "href", "sourceHref", "state", "request", "response", "@baseType", "@schemaLocation", "@type"]'::jsonb) ON CONFLICT (tmf_api, tmf_resource, anchor_table) DO UPDATE SET field_strategy = EXCLUDED.field_strategy, local_spec_path = EXCLUDED.local_spec_path, promoted_fields = EXCLUDED.promoted_fields, updated_at = now();
INSERT INTO fulfillment_activation.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('fulfillment_activation.monitor.created', 'v1', 'TMF640', 'monitor', 'fulfillment_activation.activation_request', 'created', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO fulfillment_activation.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('fulfillment_activation.monitor.updated', 'v1', 'TMF640', 'monitor', 'fulfillment_activation.activation_request', 'updated', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO fulfillment_activation.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('fulfillment_activation.monitor.stateChanged', 'v1', 'TMF640', 'monitor', 'fulfillment_activation.activation_request', 'stateChanged', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO fulfillment_activation.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('fulfillment_activation.monitor.deleted', 'v1', 'TMF640', 'monitor', 'fulfillment_activation.activation_request', 'deleted', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO fulfillment_activation.tmf_api_resource_map (tmf_api, tmf_resource, resource_path, anchor_table, field_strategy, local_spec_path, promoted_fields) VALUES ('TMF640', 'service', '/service', 'service_order_execution', 'Promote common TMF lifecycle/reference fields; store remaining validated resource fields in tmf_payload and characteristics tables.', 'references/tmforum-open-apis/openapi-specs/TMF640_ActivationConfiguration/TMF640_Service_Activation_Management_API_v4.0.0_swagger.json', '["id", "href", "category", "description", "endDate", "hasStarted", "isBundle", "isServiceEnabled", "isStateful", "name", "serviceDate", "serviceType", "startDate", "startMode", "feature", "note"]'::jsonb) ON CONFLICT (tmf_api, tmf_resource, anchor_table) DO UPDATE SET field_strategy = EXCLUDED.field_strategy, local_spec_path = EXCLUDED.local_spec_path, promoted_fields = EXCLUDED.promoted_fields, updated_at = now();
INSERT INTO fulfillment_activation.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('fulfillment_activation.service.created', 'v1', 'TMF640', 'service', 'fulfillment_activation.service_order_execution', 'created', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO fulfillment_activation.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('fulfillment_activation.service.updated', 'v1', 'TMF640', 'service', 'fulfillment_activation.service_order_execution', 'updated', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO fulfillment_activation.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('fulfillment_activation.service.stateChanged', 'v1', 'TMF640', 'service', 'fulfillment_activation.service_order_execution', 'stateChanged', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO fulfillment_activation.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('fulfillment_activation.service.deleted', 'v1', 'TMF640', 'service', 'fulfillment_activation.service_order_execution', 'deleted', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO fulfillment_activation.tmf_api_resource_map (tmf_api, tmf_resource, resource_path, anchor_table, field_strategy, local_spec_path, promoted_fields) VALUES ('TMF702', 'monitor', '/monitor', 'activation_request', 'Promote common TMF lifecycle/reference fields; store remaining validated resource fields in tmf_payload and characteristics tables.', 'references/tmforum-open-apis/openapi-specs/TMF702_ResourceActivationManagement/TMF702_Resource_Activation_Management_API_v4.0.0_swagger.json', '["id", "href", "sourceHref", "state", "request", "response", "@baseType", "@schemaLocation", "@type"]'::jsonb) ON CONFLICT (tmf_api, tmf_resource, anchor_table) DO UPDATE SET field_strategy = EXCLUDED.field_strategy, local_spec_path = EXCLUDED.local_spec_path, promoted_fields = EXCLUDED.promoted_fields, updated_at = now();
INSERT INTO fulfillment_activation.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('fulfillment_activation.monitor.created', 'v1', 'TMF702', 'monitor', 'fulfillment_activation.activation_request', 'created', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO fulfillment_activation.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('fulfillment_activation.monitor.updated', 'v1', 'TMF702', 'monitor', 'fulfillment_activation.activation_request', 'updated', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO fulfillment_activation.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('fulfillment_activation.monitor.stateChanged', 'v1', 'TMF702', 'monitor', 'fulfillment_activation.activation_request', 'stateChanged', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO fulfillment_activation.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('fulfillment_activation.monitor.deleted', 'v1', 'TMF702', 'monitor', 'fulfillment_activation.activation_request', 'deleted', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO fulfillment_activation.tmf_api_resource_map (tmf_api, tmf_resource, resource_path, anchor_table, field_strategy, local_spec_path, promoted_fields) VALUES ('TMF702', 'resource', '/resource', 'resource_order_execution', 'Promote common TMF lifecycle/reference fields; store remaining validated resource fields in tmf_payload and characteristics tables.', 'references/tmforum-open-apis/openapi-specs/TMF702_ResourceActivationManagement/TMF702_Resource_Activation_Management_API_v4.0.0_swagger.json', '["id", "href", "category", "description", "endOperatingDate", "name", "resourceVersion", "startOperatingDate", "activationFeature", "administrativeState", "attachment", "note", "operationalState", "place", "relatedParty", "resourceCharacteristic"]'::jsonb) ON CONFLICT (tmf_api, tmf_resource, anchor_table) DO UPDATE SET field_strategy = EXCLUDED.field_strategy, local_spec_path = EXCLUDED.local_spec_path, promoted_fields = EXCLUDED.promoted_fields, updated_at = now();
INSERT INTO fulfillment_activation.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('fulfillment_activation.resource.created', 'v1', 'TMF702', 'resource', 'fulfillment_activation.resource_order_execution', 'created', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO fulfillment_activation.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('fulfillment_activation.resource.updated', 'v1', 'TMF702', 'resource', 'fulfillment_activation.resource_order_execution', 'updated', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO fulfillment_activation.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('fulfillment_activation.resource.stateChanged', 'v1', 'TMF702', 'resource', 'fulfillment_activation.resource_order_execution', 'stateChanged', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO fulfillment_activation.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('fulfillment_activation.resource.deleted', 'v1', 'TMF702', 'resource', 'fulfillment_activation.resource_order_execution', 'deleted', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO fulfillment_activation.tmf_api_resource_map (tmf_api, tmf_resource, resource_path, anchor_table, field_strategy, local_spec_path, promoted_fields) VALUES ('TMF664', 'heal', '/heal', 'activation_request', 'Promote common TMF lifecycle/reference fields; store remaining validated resource fields in tmf_payload and characteristics tables.', 'references/tmforum-open-apis/openapi-specs/TMF664_ResourceFunctionActivationConfiguration/TMF664_Resource_Function_Activation_Management_API_v4.0.0_swagger.json', '["id", "href", "cause", "degreeOfHealing", "healAction", "name", "startTime", "additionalParms", "healPolicy", "resourceFunction", "state", "@baseType", "@schemaLocation", "@type"]'::jsonb) ON CONFLICT (tmf_api, tmf_resource, anchor_table) DO UPDATE SET field_strategy = EXCLUDED.field_strategy, local_spec_path = EXCLUDED.local_spec_path, promoted_fields = EXCLUDED.promoted_fields, updated_at = now();
INSERT INTO fulfillment_activation.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('fulfillment_activation.heal.created', 'v1', 'TMF664', 'heal', 'fulfillment_activation.activation_request', 'created', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO fulfillment_activation.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('fulfillment_activation.heal.updated', 'v1', 'TMF664', 'heal', 'fulfillment_activation.activation_request', 'updated', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO fulfillment_activation.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('fulfillment_activation.heal.stateChanged', 'v1', 'TMF664', 'heal', 'fulfillment_activation.activation_request', 'stateChanged', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO fulfillment_activation.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('fulfillment_activation.heal.deleted', 'v1', 'TMF664', 'heal', 'fulfillment_activation.activation_request', 'deleted', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO fulfillment_activation.tmf_api_resource_map (tmf_api, tmf_resource, resource_path, anchor_table, field_strategy, local_spec_path, promoted_fields) VALUES ('TMF664', 'migrate', '/migrate', 'activation_request', 'Promote common TMF lifecycle/reference fields; store remaining validated resource fields in tmf_payload and characteristics tables.', 'references/tmforum-open-apis/openapi-specs/TMF664_ResourceFunctionActivationConfiguration/TMF664_Resource_Function_Activation_Management_API_v4.0.0_swagger.json', '["id", "href", "adminStateModification", "cause", "completionMode", "name", "priority", "startTime", "addConnectionPoint", "characteristics", "place", "removeConnectionPoint", "resourceFunction", "state", "@baseType", "@schemaLocation"]'::jsonb) ON CONFLICT (tmf_api, tmf_resource, anchor_table) DO UPDATE SET field_strategy = EXCLUDED.field_strategy, local_spec_path = EXCLUDED.local_spec_path, promoted_fields = EXCLUDED.promoted_fields, updated_at = now();
INSERT INTO fulfillment_activation.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('fulfillment_activation.migrate.created', 'v1', 'TMF664', 'migrate', 'fulfillment_activation.activation_request', 'created', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO fulfillment_activation.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('fulfillment_activation.migrate.updated', 'v1', 'TMF664', 'migrate', 'fulfillment_activation.activation_request', 'updated', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO fulfillment_activation.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('fulfillment_activation.migrate.stateChanged', 'v1', 'TMF664', 'migrate', 'fulfillment_activation.activation_request', 'stateChanged', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO fulfillment_activation.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('fulfillment_activation.migrate.deleted', 'v1', 'TMF664', 'migrate', 'fulfillment_activation.activation_request', 'deleted', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO fulfillment_activation.tmf_api_resource_map (tmf_api, tmf_resource, resource_path, anchor_table, field_strategy, local_spec_path, promoted_fields) VALUES ('TMF664', 'monitor', '/monitor', 'activation_request', 'Promote common TMF lifecycle/reference fields; store remaining validated resource fields in tmf_payload and characteristics tables.', 'references/tmforum-open-apis/openapi-specs/TMF664_ResourceFunctionActivationConfiguration/TMF664_Resource_Function_Activation_Management_API_v4.0.0_swagger.json', '["id", "href", "sourceHref", "state", "request", "response", "@baseType", "@schemaLocation", "@type"]'::jsonb) ON CONFLICT (tmf_api, tmf_resource, anchor_table) DO UPDATE SET field_strategy = EXCLUDED.field_strategy, local_spec_path = EXCLUDED.local_spec_path, promoted_fields = EXCLUDED.promoted_fields, updated_at = now();
INSERT INTO fulfillment_activation.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('fulfillment_activation.monitor.created', 'v1', 'TMF664', 'monitor', 'fulfillment_activation.activation_request', 'created', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO fulfillment_activation.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('fulfillment_activation.monitor.updated', 'v1', 'TMF664', 'monitor', 'fulfillment_activation.activation_request', 'updated', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO fulfillment_activation.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('fulfillment_activation.monitor.stateChanged', 'v1', 'TMF664', 'monitor', 'fulfillment_activation.activation_request', 'stateChanged', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO fulfillment_activation.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('fulfillment_activation.monitor.deleted', 'v1', 'TMF664', 'monitor', 'fulfillment_activation.activation_request', 'deleted', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO fulfillment_activation.tmf_api_resource_map (tmf_api, tmf_resource, resource_path, anchor_table, field_strategy, local_spec_path, promoted_fields) VALUES ('TMF664', 'resourceFunction', '/resourceFunction', 'resource_order_execution', 'Promote common TMF lifecycle/reference fields; store remaining validated resource fields in tmf_payload and characteristics tables.', 'references/tmforum-open-apis/openapi-specs/TMF664_ResourceFunctionActivationConfiguration/TMF664_Resource_Function_Activation_Management_API_v4.0.0_swagger.json', '["id", "href", "category", "description", "endOperatingDate", "functionType", "name", "priority", "resourceVersion", "role", "startOperatingDate", "value", "activationFeature", "administrativeState", "attachment", "autoModification"]'::jsonb) ON CONFLICT (tmf_api, tmf_resource, anchor_table) DO UPDATE SET field_strategy = EXCLUDED.field_strategy, local_spec_path = EXCLUDED.local_spec_path, promoted_fields = EXCLUDED.promoted_fields, updated_at = now();
INSERT INTO fulfillment_activation.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('fulfillment_activation.resource_function.created', 'v1', 'TMF664', 'resourceFunction', 'fulfillment_activation.resource_order_execution', 'created', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO fulfillment_activation.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('fulfillment_activation.resource_function.updated', 'v1', 'TMF664', 'resourceFunction', 'fulfillment_activation.resource_order_execution', 'updated', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO fulfillment_activation.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('fulfillment_activation.resource_function.stateChanged', 'v1', 'TMF664', 'resourceFunction', 'fulfillment_activation.resource_order_execution', 'stateChanged', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO fulfillment_activation.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('fulfillment_activation.resource_function.deleted', 'v1', 'TMF664', 'resourceFunction', 'fulfillment_activation.resource_order_execution', 'deleted', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO fulfillment_activation.tmf_api_resource_map (tmf_api, tmf_resource, resource_path, anchor_table, field_strategy, local_spec_path, promoted_fields) VALUES ('TMF664', 'scale', '/scale', 'activation_request', 'Promote common TMF lifecycle/reference fields; store remaining validated resource fields in tmf_payload and characteristics tables.', 'references/tmforum-open-apis/openapi-specs/TMF664_ResourceFunctionActivationConfiguration/TMF664_Resource_Function_Activation_Management_API_v4.0.0_swagger.json', '["id", "href", "aspectId", "name", "numberOfSteps", "scaleType", "resourceFunction", "schedule", "state", "@baseType", "@schemaLocation", "@type"]'::jsonb) ON CONFLICT (tmf_api, tmf_resource, anchor_table) DO UPDATE SET field_strategy = EXCLUDED.field_strategy, local_spec_path = EXCLUDED.local_spec_path, promoted_fields = EXCLUDED.promoted_fields, updated_at = now();
INSERT INTO fulfillment_activation.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('fulfillment_activation.scale.created', 'v1', 'TMF664', 'scale', 'fulfillment_activation.activation_request', 'created', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO fulfillment_activation.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('fulfillment_activation.scale.updated', 'v1', 'TMF664', 'scale', 'fulfillment_activation.activation_request', 'updated', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO fulfillment_activation.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('fulfillment_activation.scale.stateChanged', 'v1', 'TMF664', 'scale', 'fulfillment_activation.activation_request', 'stateChanged', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO fulfillment_activation.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('fulfillment_activation.scale.deleted', 'v1', 'TMF664', 'scale', 'fulfillment_activation.activation_request', 'deleted', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO fulfillment_activation.tmf_api_resource_map (tmf_api, tmf_resource, resource_path, anchor_table, field_strategy, local_spec_path, promoted_fields) VALUES ('TMF701', 'processFlow', '/processFlow', 'provisioning_workflow_state', 'Promote common TMF lifecycle/reference fields; store remaining validated resource fields in tmf_payload and characteristics tables.', 'references/tmforum-open-apis/openapi-specs/TMF701_ProcessFlow/TMF701-ProcessFlow-v4.0.0.swagger.json', '["id", "href", "processFlowDate", "processFlowSpecification", "channel", "characteristic", "relatedEntity", "relatedParty", "state", "taskFlow", "@baseType", "@schemaLocation", "@type"]'::jsonb) ON CONFLICT (tmf_api, tmf_resource, anchor_table) DO UPDATE SET field_strategy = EXCLUDED.field_strategy, local_spec_path = EXCLUDED.local_spec_path, promoted_fields = EXCLUDED.promoted_fields, updated_at = now();
INSERT INTO fulfillment_activation.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('fulfillment_activation.process_flow.created', 'v1', 'TMF701', 'processFlow', 'fulfillment_activation.provisioning_workflow_state', 'created', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO fulfillment_activation.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('fulfillment_activation.process_flow.updated', 'v1', 'TMF701', 'processFlow', 'fulfillment_activation.provisioning_workflow_state', 'updated', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO fulfillment_activation.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('fulfillment_activation.process_flow.stateChanged', 'v1', 'TMF701', 'processFlow', 'fulfillment_activation.provisioning_workflow_state', 'stateChanged', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO fulfillment_activation.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('fulfillment_activation.process_flow.deleted', 'v1', 'TMF701', 'processFlow', 'fulfillment_activation.provisioning_workflow_state', 'deleted', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO fulfillment_activation.tmf_api_resource_map (tmf_api, tmf_resource, resource_path, anchor_table, field_strategy, local_spec_path, promoted_fields) VALUES ('TMF621', 'troubleTicket', '/troubleTicket', 'service_order_execution', 'Promote common TMF metadata; store resource-specific fields in tmf_payload until query patterns justify additional typed columns.', 'references/tmforum-open-apis/openapi-specs/TMF621_TroubleTicket/TMF621-Trouble_Ticket-v5.0.1.oas.yaml', '[]'::jsonb) ON CONFLICT (tmf_api, tmf_resource, anchor_table) DO UPDATE SET field_strategy = EXCLUDED.field_strategy, local_spec_path = EXCLUDED.local_spec_path, promoted_fields = EXCLUDED.promoted_fields, updated_at = now();
INSERT INTO fulfillment_activation.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('fulfillment_activation.trouble_ticket.created', 'v1', 'TMF621', 'troubleTicket', 'fulfillment_activation.service_order_execution', 'created', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO fulfillment_activation.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('fulfillment_activation.trouble_ticket.updated', 'v1', 'TMF621', 'troubleTicket', 'fulfillment_activation.service_order_execution', 'updated', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO fulfillment_activation.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('fulfillment_activation.trouble_ticket.stateChanged', 'v1', 'TMF621', 'troubleTicket', 'fulfillment_activation.service_order_execution', 'stateChanged', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO fulfillment_activation.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('fulfillment_activation.trouble_ticket.deleted', 'v1', 'TMF621', 'troubleTicket', 'fulfillment_activation.service_order_execution', 'deleted', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO fulfillment_activation.tmf_api_resource_map (tmf_api, tmf_resource, resource_path, anchor_table, field_strategy, local_spec_path, promoted_fields) VALUES ('TMF621', 'troubleTicketSpecification', '/troubleTicketSpecification', 'service_order_execution', 'Promote common TMF metadata; store resource-specific fields in tmf_payload until query patterns justify additional typed columns.', 'references/tmforum-open-apis/openapi-specs/TMF621_TroubleTicket/TMF621-Trouble_Ticket-v5.0.1.oas.yaml', '[]'::jsonb) ON CONFLICT (tmf_api, tmf_resource, anchor_table) DO UPDATE SET field_strategy = EXCLUDED.field_strategy, local_spec_path = EXCLUDED.local_spec_path, promoted_fields = EXCLUDED.promoted_fields, updated_at = now();
INSERT INTO fulfillment_activation.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('fulfillment_activation.trouble_ticket_specification.created', 'v1', 'TMF621', 'troubleTicketSpecification', 'fulfillment_activation.service_order_execution', 'created', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO fulfillment_activation.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('fulfillment_activation.trouble_ticket_specification.updated', 'v1', 'TMF621', 'troubleTicketSpecification', 'fulfillment_activation.service_order_execution', 'updated', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO fulfillment_activation.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('fulfillment_activation.trouble_ticket_specification.stateChanged', 'v1', 'TMF621', 'troubleTicketSpecification', 'fulfillment_activation.service_order_execution', 'stateChanged', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO fulfillment_activation.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('fulfillment_activation.trouble_ticket_specification.deleted', 'v1', 'TMF621', 'troubleTicketSpecification', 'fulfillment_activation.service_order_execution', 'deleted', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO fulfillment_activation.tmf_api_resource_map (tmf_api, tmf_resource, resource_path, anchor_table, field_strategy, local_spec_path, promoted_fields) VALUES ('TMF637', 'product', '/product', 'service_order_execution', 'Promote common TMF metadata; store resource-specific fields in tmf_payload until query patterns justify additional typed columns.', 'references/tmforum-open-apis/openapi-specs/TMF637_ProductInventory/TMF637-ProductInventory-v5.0.0.oas.yaml', '[]'::jsonb) ON CONFLICT (tmf_api, tmf_resource, anchor_table) DO UPDATE SET field_strategy = EXCLUDED.field_strategy, local_spec_path = EXCLUDED.local_spec_path, promoted_fields = EXCLUDED.promoted_fields, updated_at = now();
INSERT INTO fulfillment_activation.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('fulfillment_activation.product.created', 'v1', 'TMF637', 'product', 'fulfillment_activation.service_order_execution', 'created', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO fulfillment_activation.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('fulfillment_activation.product.updated', 'v1', 'TMF637', 'product', 'fulfillment_activation.service_order_execution', 'updated', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO fulfillment_activation.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('fulfillment_activation.product.stateChanged', 'v1', 'TMF637', 'product', 'fulfillment_activation.service_order_execution', 'stateChanged', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO fulfillment_activation.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('fulfillment_activation.product.deleted', 'v1', 'TMF637', 'product', 'fulfillment_activation.service_order_execution', 'deleted', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO fulfillment_activation.tmf_api_resource_map (tmf_api, tmf_resource, resource_path, anchor_table, field_strategy, local_spec_path, promoted_fields) VALUES ('TMF638', 'service', '/service', 'service_order_execution', 'Promote common TMF metadata; store resource-specific fields in tmf_payload until query patterns justify additional typed columns.', 'references/tmforum-open-apis/openapi-specs/TMF638_ServiceInventory/TMF638-Service_Inventory_Management-v5.0.0.oas.yaml', '[]'::jsonb) ON CONFLICT (tmf_api, tmf_resource, anchor_table) DO UPDATE SET field_strategy = EXCLUDED.field_strategy, local_spec_path = EXCLUDED.local_spec_path, promoted_fields = EXCLUDED.promoted_fields, updated_at = now();
INSERT INTO fulfillment_activation.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('fulfillment_activation.service.created', 'v1', 'TMF638', 'service', 'fulfillment_activation.service_order_execution', 'created', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO fulfillment_activation.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('fulfillment_activation.service.updated', 'v1', 'TMF638', 'service', 'fulfillment_activation.service_order_execution', 'updated', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO fulfillment_activation.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('fulfillment_activation.service.stateChanged', 'v1', 'TMF638', 'service', 'fulfillment_activation.service_order_execution', 'stateChanged', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO fulfillment_activation.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('fulfillment_activation.service.deleted', 'v1', 'TMF638', 'service', 'fulfillment_activation.service_order_execution', 'deleted', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO fulfillment_activation.tmf_api_resource_map (tmf_api, tmf_resource, resource_path, anchor_table, field_strategy, local_spec_path, promoted_fields) VALUES ('TMF639', 'resource', '/resource', 'resource_order_execution', 'Promote common TMF metadata; store resource-specific fields in tmf_payload until query patterns justify additional typed columns.', 'references/tmforum-open-apis/openapi-specs/TMF639_ResourceInventory/TMF639-Resource_Inventory_Management-v5.0.0.oas.yaml', '[]'::jsonb) ON CONFLICT (tmf_api, tmf_resource, anchor_table) DO UPDATE SET field_strategy = EXCLUDED.field_strategy, local_spec_path = EXCLUDED.local_spec_path, promoted_fields = EXCLUDED.promoted_fields, updated_at = now();
INSERT INTO fulfillment_activation.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('fulfillment_activation.resource.created', 'v1', 'TMF639', 'resource', 'fulfillment_activation.resource_order_execution', 'created', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO fulfillment_activation.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('fulfillment_activation.resource.updated', 'v1', 'TMF639', 'resource', 'fulfillment_activation.resource_order_execution', 'updated', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO fulfillment_activation.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('fulfillment_activation.resource.stateChanged', 'v1', 'TMF639', 'resource', 'fulfillment_activation.resource_order_execution', 'stateChanged', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();
INSERT INTO fulfillment_activation.event_contract (event_name, event_version, tmf_api, tmf_resource, source_table, event_type, event_key_strategy, payload_basis, consumer_notes) VALUES ('fulfillment_activation.resource.deleted', 'v1', 'TMF639', 'resource', 'fulfillment_activation.resource_order_execution', 'deleted', 'tenant_id + canonical_id + version', 'typed columns + tmf_payload snapshot', 'Register concrete consumers during integration design') ON CONFLICT (event_name, event_version) DO UPDATE SET source_table = EXCLUDED.source_table, payload_basis = EXCLUDED.payload_basis, updated_at = now();

INSERT INTO fulfillment_activation.privacy_retention_policy (table_name, data_domain, data_classification, retention_class, retention_basis, default_retention_days, legal_hold_supported, residency_rule, masking_policy, audit_level) VALUES ('fulfillment_activation.service_order_execution', 'fulfillment_activation', 'confidential', 'business_lifecycle', 'Suite data model and TMF API baseline review', 2190, true, 'Keep operational data in the suite deployment region unless a release-specific residency rule overrides it.', 'Mask customer, partner, account, order, and operationally sensitive details in non-production and exports.', 'standard-high') ON CONFLICT (table_name) DO UPDATE SET data_classification = EXCLUDED.data_classification, retention_class = EXCLUDED.retention_class, masking_policy = EXCLUDED.masking_policy, audit_level = EXCLUDED.audit_level, updated_at = now();
INSERT INTO fulfillment_activation.privacy_retention_policy (table_name, data_domain, data_classification, retention_class, retention_basis, default_retention_days, legal_hold_supported, residency_rule, masking_policy, audit_level) VALUES ('fulfillment_activation.resource_order_execution', 'fulfillment_activation', 'confidential', 'business_lifecycle', 'Suite data model and TMF API baseline review', 2190, true, 'Keep operational data in the suite deployment region unless a release-specific residency rule overrides it.', 'Mask customer, partner, account, order, and operationally sensitive details in non-production and exports.', 'standard-high') ON CONFLICT (table_name) DO UPDATE SET data_classification = EXCLUDED.data_classification, retention_class = EXCLUDED.retention_class, masking_policy = EXCLUDED.masking_policy, audit_level = EXCLUDED.audit_level, updated_at = now();
INSERT INTO fulfillment_activation.privacy_retention_policy (table_name, data_domain, data_classification, retention_class, retention_basis, default_retention_days, legal_hold_supported, residency_rule, masking_policy, audit_level) VALUES ('fulfillment_activation.activation_request', 'fulfillment_activation', 'internal', 'domain_lifecycle', 'Suite data model and TMF API baseline review', 1095, true, 'Keep operational data in the suite deployment region unless a release-specific residency rule overrides it.', 'Apply tenant isolation and redact source identifiers in shared read models.', 'standard') ON CONFLICT (table_name) DO UPDATE SET data_classification = EXCLUDED.data_classification, retention_class = EXCLUDED.retention_class, masking_policy = EXCLUDED.masking_policy, audit_level = EXCLUDED.audit_level, updated_at = now();
INSERT INTO fulfillment_activation.privacy_retention_policy (table_name, data_domain, data_classification, retention_class, retention_basis, default_retention_days, legal_hold_supported, residency_rule, masking_policy, audit_level) VALUES ('fulfillment_activation.activation_response', 'fulfillment_activation', 'internal', 'domain_lifecycle', 'Suite data model and TMF API baseline review', 1095, true, 'Keep operational data in the suite deployment region unless a release-specific residency rule overrides it.', 'Apply tenant isolation and redact source identifiers in shared read models.', 'standard') ON CONFLICT (table_name) DO UPDATE SET data_classification = EXCLUDED.data_classification, retention_class = EXCLUDED.retention_class, masking_policy = EXCLUDED.masking_policy, audit_level = EXCLUDED.audit_level, updated_at = now();
INSERT INTO fulfillment_activation.privacy_retention_policy (table_name, data_domain, data_classification, retention_class, retention_basis, default_retention_days, legal_hold_supported, residency_rule, masking_policy, audit_level) VALUES ('fulfillment_activation.provisioning_workflow_state', 'fulfillment_activation', 'internal', 'domain_lifecycle', 'Suite data model and TMF API baseline review', 1095, true, 'Keep operational data in the suite deployment region unless a release-specific residency rule overrides it.', 'Apply tenant isolation and redact source identifiers in shared read models.', 'standard') ON CONFLICT (table_name) DO UPDATE SET data_classification = EXCLUDED.data_classification, retention_class = EXCLUDED.retention_class, masking_policy = EXCLUDED.masking_policy, audit_level = EXCLUDED.audit_level, updated_at = now();
INSERT INTO fulfillment_activation.privacy_retention_policy (table_name, data_domain, data_classification, retention_class, retention_basis, default_retention_days, legal_hold_supported, residency_rule, masking_policy, audit_level) VALUES ('fulfillment_activation.fulfillment_fallout', 'fulfillment_activation', 'internal', 'domain_lifecycle', 'Suite data model and TMF API baseline review', 1095, true, 'Keep operational data in the suite deployment region unless a release-specific residency rule overrides it.', 'Apply tenant isolation and redact source identifiers in shared read models.', 'standard') ON CONFLICT (table_name) DO UPDATE SET data_classification = EXCLUDED.data_classification, retention_class = EXCLUDED.retention_class, masking_policy = EXCLUDED.masking_policy, audit_level = EXCLUDED.audit_level, updated_at = now();
INSERT INTO fulfillment_activation.privacy_retention_policy (table_name, data_domain, data_classification, retention_class, retention_basis, default_retention_days, legal_hold_supported, residency_rule, masking_policy, audit_level) VALUES ('fulfillment_activation.fulfillment_handover_evidence', 'fulfillment_activation', 'internal', 'domain_lifecycle', 'Suite data model and TMF API baseline review', 1095, true, 'Keep operational data in the suite deployment region unless a release-specific residency rule overrides it.', 'Apply tenant isolation and redact source identifiers in shared read models.', 'standard') ON CONFLICT (table_name) DO UPDATE SET data_classification = EXCLUDED.data_classification, retention_class = EXCLUDED.retention_class, masking_policy = EXCLUDED.masking_policy, audit_level = EXCLUDED.audit_level, updated_at = now();
INSERT INTO fulfillment_activation.privacy_retention_policy (table_name, data_domain, data_classification, retention_class, retention_basis, default_retention_days, legal_hold_supported, residency_rule, masking_policy, audit_level) VALUES ('fulfillment_activation.event_outbox', 'fulfillment_activation', 'internal', 'operational_telemetry', 'Suite data model and TMF API baseline review', 730, true, 'Keep operational data in the suite deployment region unless a release-specific residency rule overrides it.', 'Aggregate or pseudonymize identifiers before analytics distribution.', 'standard') ON CONFLICT (table_name) DO UPDATE SET data_classification = EXCLUDED.data_classification, retention_class = EXCLUDED.retention_class, masking_policy = EXCLUDED.masking_policy, audit_level = EXCLUDED.audit_level, updated_at = now();

COMMIT;
