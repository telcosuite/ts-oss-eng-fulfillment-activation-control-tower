# Fulfillment And Activation Control Tower P04 - Phase 4 Cross Area Development Tasks

Suite: OSS Engineering, Inventory, And Fulfillment

App: Fulfillment And Activation Control Tower

App slug: `fulfillment-activation-control-tower`

Implementation repository: `ts-oss-eng-fulfillment-activation-control-tower`

Phase: P04 - Phase 4 Cross Area

Phase file: `p04-phase-4-cross-area.md`

Phase rationale: Wire cross-area handoffs, lifecycle transitions, and downstream events for Fulfillment And Activation Control Tower.

Phase exit gate: Cross-area handoffs and event publication are tested end to end.

Source tracker: [development-task-tracker.md](development-task-tracker.md)

Repository strategy: [TelcoSuite Repository Strategy](../../../../repository-strategy.md)

## Phase Coverage

- [customer-partner-and-offnet-activation](../planning/app-detail/features/customer-partner-and-offnet-activation.md)
- [provisioning-workflow](../planning/app-detail/features/provisioning-workflow.md)

## Phase Tasks

### DT-01-fulfillment-activation-control-tower-P04-T001: Implement P04 - Phase 4 Cross Area enablement and cross-feature controls

| Field | Value |
| --- | --- |
| Phase | P04 - Phase 4 Cross Area |
| Priority | P0 |
| Source evidence | [App README](../README.md), [Modules and features](../planning/app-detail/modules-and-features.md), [Personas and journeys](../planning/app-detail/personas-and-user-journeys.md), [Suite data model](../../data-model.md), [TMF review](../../tmf-api-ddl-reviews/fulfillment-activation.md) |
| Feature or module | Phase enablement and cross-feature controls |
| Build area | API/Data/Event |
| Dependencies | DT-01-fulfillment-activation-control-tower-P03-T012 (or earlier phase exit gate) |
| Outputs | Phase readiness evidence, implementation notes, task dependencies, and tracker updates. |

#### Implementation Notes

- Use this phase to establish or refine the app-specific delivery controls for P04 - Phase 4 Cross Area.
- Confirm phase scope, exit gate, source evidence, app-owned schema `fulfillment_activation`, TMF/API posture (TMF641, TMF652, TMF640, TMF702, TMF664, TMF701, TMF621, TMF637), migration order, and no-direct-cross-app-write rules.
- Update the tracker and feature-slice coverage matrix when scope, dependencies, or implementation evidence changes.

#### Phase-Specific Build Details

- Feature specs in this phase: customer-partner-and-offnet-activation, provisioning-workflow.
- Required screens/workbenches to implement or refine in this phase: derived from the per-feature feature specs in `docs/planning/app-detail/features/`.
- Required events to implement or disposition: derived from the per-feature event contracts.
- Required data/table groups: derived from the per-feature data ownership statements and the V001/V00X migration baseline.

#### Acceptance Criteria

1. Given the P04 - Phase 4 Cross Area exit gate, when the tasks in this phase complete, then the documented evidence is produced and the tracker is updated.
2. Given the P04 - Phase 4 Cross Area feature coverage list, when the tasks in this phase complete, then every source feature has at least one implementation task in the tracker.
3. Given cross-app boundaries, when the tasks in this phase complete, then the app does not write to any other app's schema or rely on cross-app joins.

#### Definition of Done

- Phase exit gate evidence is recorded.
- Tracker is updated with implementation evidence.
- Cross-app boundary rules are preserved.

#### Negative Scenarios

- Do not bypass audit, masking, or tenant controls.
- Do not publish events from controllers without going through the outbox.

#### Edge Cases

- Out-of-order phase work must still preserve the no-direct-cross-app-write rule.
- TMF coverage gaps must be documented as non-TMF extensions.

#### Test Expectations

- Run unit, contract, integration, and E2E tests appropriate to the phase output.
- Update the tracker with command output, PR links, screenshots, or blocker notes.

### DT-01-fulfillment-activation-control-tower-P04-T002: Implement feature-slice coverage and tracker linkage for P04 - Phase 4 Cross Area

| Field | Value |
| --- | --- |
| Phase | P04 - Phase 4 Cross Area |
| Priority | P0 |
| Source evidence | [Modules and features](../planning/app-detail/modules-and-features.md), [Personas and journeys](../planning/app-detail/personas-and-user-journeys.md) |
| Feature or module | Feature-slice coverage and tracker linkage |
| Build area | Docs/Test |
| Dependencies | DT-01-fulfillment-activation-control-tower-P04-T001 |
| Outputs | Tracker linkage for every source feature in this phase, including task IDs, feature names, and slice intent. |

#### Implementation Notes

- For each source feature in this phase, record the feature ID, feature name, source slice file, phase, and tracker task ID.
- Mark coverage as Not Started, In Progress, Blocked, or Complete.
- Surface missing evidence as explicit blockers with owners and target increments.

#### Phase-Specific Build Details

- Source features covered in this phase: customer-partner-and-offnet-activation, provisioning-workflow.

#### Acceptance Criteria

1. Given the source feature pack, when the tracker linkage is updated, then every source feature is mapped to a DT task.
2. Given an unmapped source feature, when the tracker is reviewed, then it is listed as a blocker with an owner.

#### Definition of Done

- Tracker linkage is complete and current.
- Blockers are visible to the app team.

#### Negative Scenarios

- Do not silently skip features.
- Do not close coverage without evidence.

#### Edge Cases

- Source features may be merged or split; preserve traceability.

#### Test Expectations

- Review the tracker for completeness.
- Update the tracker with command output, screenshots, or blocker notes.

### DT-01-fulfillment-activation-control-tower-P04-T003: Prove phase readiness with end-to-end, contract, accessibility, event replay, and reconciliation evidence

| Field | Value |
| --- | --- |
| Phase | P04 - Phase 4 Cross Area |
| Priority | P0 |
| Source evidence | [Repository strategy](../../../../repository-strategy.md), [App summary](../../../../../fulfillment-activation-control-tower.md) |
| Feature or module | Phase readiness evidence |
| Build area | Test/Ops/Release |
| Dependencies | DT-01-fulfillment-activation-control-tower-P04-T002 |
| Outputs | Phase readiness evidence covering E2E, contract, accessibility, event replay, and reconciliation. |

#### Implementation Notes

- Capture test reports, screenshots, and event payloads in the tracker.
- Reconcile cross-app handoffs with consumer acknowledgement evidence.

#### Phase-Specific Build Details

- E2E journeys covered: derived from the persona/user-journey planning.
- Contract tests: derived from the per-feature event/data contracts.
- Accessibility checks: at least the primary screens for this phase.
- Event replay: at least the outbox-to-event-to-consumer path.
- Reconciliation: at least one cross-app handoff.

#### Acceptance Criteria

1. Given the phase readiness checklist, when the evidence is captured, then every item is linked from the tracker.
2. Given a failure, when the evidence is reviewed, then the failure has an owner and a target increment.

#### Definition of Done

- Phase readiness evidence is complete and current.

#### Negative Scenarios

- Do not "make it pass" by skipping reconciliation or event replay.
- Do not close the phase without accessibility evidence.

#### Edge Cases

- Reconciliation may require coordinated work with another app; record the coordination evidence.

#### Test Expectations

- Run the documented test suite.
- Update the tracker with command output, screenshots, and event payloads.
