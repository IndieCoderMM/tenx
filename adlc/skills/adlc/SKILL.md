---
name: adlc
description: Orchestrate the Agent Development Lifecycle for product features from idea through architecture, specification, task planning, incremental implementation, review, and verified delivery using persistent repository artifacts.
---

# ADLC — Agent Development Lifecycle

Before coordinating feature work, read `references/lifecycle.md`. It defines the phase gates, artifact contract, resumption rules, and safety boundaries. Use the focused ADLC skills for discovery, architecture, planning, execution, review, and verification. `adlc-interview` is an optional cross-phase capability for meaningful unresolved decisions, not an additional phase or gate.

The coordinator owns user decisions and `.adlc/` records. Delegate bounded implementation, independent review, and acceptance checks to the ADLC role agents when that reduces risk or elapsed time. Keep dependent tasks sequential and parallelize only tasks with disjoint boundaries.
