# Erdős problem #126: proof

[![CI](https://github.com/tadamcz/erdos126/actions/workflows/ci.yml/badge.svg)](https://github.com/tadamcz/erdos126/actions/workflows/ci.yml)

> **Note.** This README, the documentation in `Challenge.lean` and `formalization.yaml` were machine-written by Claude (Anthropic)
> at the direction of Tom Adamczewski, from the FrontierMath Erdős paper, the benchmark files and the module documentation inside
> the proof files, and reviewed by him. The Lean proofs themselves were written by GPT-6 Astra, as described below.

Machine-checked proof of [Erdős problem #126](https://www.erdosproblems.com/126) in Lean 4 with Mathlib, found autonomously by a
pre-release version of **GPT-6 Astra** (OpenAI) in the **FrontierMath Erdős** benchmark (Adamczewski and Bloom, 2026). The
repository packages the AI-written proofs for the [Palomar registry](https://palomar-registry.org/): `Challenge.lean` is the
small statement a reader audits, `Solution.lean` proves it, and [Comparator](https://github.com/leanprover/comparator) checks that the two
statements coincide and that only the standard axioms are used.

## The result

For a finite set `A ⊆ ℕ` let `S(A)` be the set of primes dividing some `a + b` with `a ≠ b ∈ A`, and let `f(n)` be the
minimum of `|S(A)|` over all `n`-element sets `A`. In their first joint paper, Erdős and Turán [ErTu34] proved `log n ≪
f(n) ≪ n / log n`. Erdős asked on several occasions whether `f(n) / log n → ∞`; erdosproblems.com lists a $250 prize.

The conjecture is **true**: `f(n) / log n → ∞`. Formally, the theorem proved is the Formal Conjectures statement
`Erdos126.erdos_126`: for every `f : ℕ → ℕ` satisfying `IsMaximalAddFactorsCard f` (which pins `f` down as the function
above), `f n / log n → ∞`. The four resolutions in this repository prove polynomial lower bounds `f(n) ≫ n^c` with,
according to their own module documentation, `c = 1/8` (primary), `1/3`, `1/2` and `1/5`; only the limit statement is
advertised in `Challenge.lean`. Since `A = {1, …, n}` gives `|S(A)| ≪ n / log n`, the truth lies between `n^{1/2}` and
`n / log n`.

The compared declaration, from `Challenge.lean`:

```lean
theorem erdos_126 : ∀ (f : ℕ → ℕ), IsMaximalAddFactorsCard f →
    Tendsto (fun n => f n / Real.log n) atTop atTop := by
  sorry
```



**Fidelity.** The compared theorem is exactly the Formal Conjectures statement. The definition `IsMaximalAddFactorsCard f` says that
for every `n`, `f n` is the greatest `m` such that every `n`-element `A : Finset ℕ` has at least `m` distinct prime
factors in `∏_{(a,b) ∈ A.offDiag} (a + b)` (product over ordered pairs `a ≠ b`; the same prime set as over unordered
pairs). Such an `f` exists and is unique (the primary resolution verifies existence, uniqueness and monotonicity in its
`Independent126` section), so the hypothesis is not vacuous; `A` may contain `0`, which changes `|S(A)|` by at most one
relative to positive sets. The conclusion `Tendsto (fun n => f n / Real.log n) atTop atTop` coerces `f n` to `ℝ`;
`Real.log n` is positive for `n ≥ 2`. The stronger polynomial bounds proved internally are not part of the compared
statement.

## Provenance

**Benchmark.** FrontierMath Erdős (Adamczewski and Bloom, 2026) evaluates AI systems on 68 open Erdős problems selected by Thomas F. Bloom, in the Lean proof
assistant, autonomously and under a fixed, disclosed budget ($300 and 72 hours of working time per attempt in the default configuration). The
agent works in a network-isolated Docker container with a Lean 4 toolchain (v4.27.0) and Mathlib, SageMath and Python; its final
`Spec.lean` is checked in a separate pristine container by Comparator against the trusted statement, permitting only `propext`,
`Quot.sound` and `Classical.choice`. The benchmark, harness and statements are public at
[epoch-research/LeanOpenProblems](https://github.com/epoch-research/LeanOpenProblems); the paper is in preparation. No human saw or steered the proof search.

**Statement.** The definitions and the statement come verbatim from [`FormalConjectures/ErdosProblems/126.lean`](https://github.com/google-deepmind/formal-conjectures/blob/488aade228ec37880b8fec178c173c07d279bb53/FormalConjectures/ErdosProblems/126.lean) in Google DeepMind's Formal Conjectures at commit `488aade228ec`, where the problem is stated with `sorry` as open. The benchmark isolated the selected statement into [`apn/data/erdos/Isolated/Erdos126.erdos_126.lean`](https://github.com/epoch-research/LeanOpenProblems/blob/77882c437ca1dfefab3b27fa00f1d29788100311/apn/data/erdos/Isolated/Erdos126.erdos_126.lean) (with the FC `answer(sorry) ↔` wrapper removed and a `.disproof` negation added), and that file is exactly what the model received.

**Resolutions.** Several independent attempts resolved this statement; all verified files are included.
"Default configuration" is the deepagent-based agent with subagents, memory and an offline arXiv snapshot under the benchmark's
budget of $300 and 72 hours of working time per attempt; "ReAct agent, larger budget" is a basic agent under a $1,000 budget.
**Cost** is computed from the attempt's exact token counts (from the harness's eval logs) at GPT-6 Astra's standard rates as provided
by OpenAI on 3 September 2026: $10 per million input tokens, $50 per million output tokens, $1 per million cache-read tokens and
$12.50 per million cache-write tokens. The harness itself metered spend at stand-in GPT-5.6 Sol prices, which is what the `usd` figure
in each file name reflects. **Working time** is the harness's `working_time` (time the agent was actually working, excluding waits on
API retries and rate limits), read from the harness's eval logs; the `h` figure in each file name is instead wall-clock time.

| Module | Role | Attempt | Cost | Working time | Tokens, millions (input / output / cache read / cache write) |
|---|---|---|---|---|---|
| `Erdos126/Resolutions/Erdos126_132usd_25h.lean` | **primary** (wired to `Solution.lean`) | default configuration, 28 Aug 2026 (benchmark run) | $247 | 15.8 h | 0.06 / 1.8 / 53 / 8.3 |
| `Erdos126/Resolutions/Erdos126_81usd_13h.lean` | alternate | default configuration, 31 Aug 2026 | $154 | 8.4 h | 0.02 / 0.9 / 38 / 5.5 |
| `Erdos126/Resolutions/Erdos126_104usd_15h.lean` | alternate | default configuration, 2 Sep 2026 | $194 | 9.5 h | 0.03 / 1.3 / 40 / 7.0 |
| `Erdos126/Resolutions/Erdos126_133usd_17h.lean` | alternate | ReAct agent, larger budget, 26 Aug 2026 | $249 | 17.0 h | 0.02 / 1.7 / 77 / 7.1 |

## Proof account

The accounts below paraphrase the module documentation the model wrote inside each file; they describe the Lean proofs actually
present. They are not a human verification of the mathematics beyond what Comparator establishes.

**`Erdos126_132usd_25h`** (default configuration, 28 Aug 2026 (benchmark run)). Prime-power cancellation gives weighted laminar opposition families whose signed Gram kernel has strictly negative off-diagonal entries while the opposition kernel is conditionally negative semidefinite; a finite energy estimate, laminar pruning and an almost-obtuse sign-vector bound give `|A| ≤ 1024 (s+1)^8` for positive sets with `s` supporting primes (so `f(n) ≫ n^{1/8}`); removing zero and taking the extremal minimum yields the limit.

**`Erdos126_81usd_13h`** (default configuration, 31 Aug 2026). For positive elements uses the reduced denominator of `2a/(a+b)`; a normalised Cauchy determinant bounds the number of vertices sharing a high prime power in this denominator, and a denominator quasi-triangle inequality covers the set by two families of balls, giving a bound on `|A|` cubic in the number of supporting primes (so `f(n) ≫ n^{1/3}`).

**`Erdos126_104usd_15h`** (default configuration, 2 Sep 2026). Signed laminar families and mixed negation-orbits of the residues; scalar quadratic forms, a two-copy Hall matching and two kernel budgets give a bound `n ≤ 3 r²` in the number `r` of supporting primes (so `f(n) ≫ n^{1/2}`), after a prime-colour exponential baseline.

**`Erdos126_133usd_17h`** (ReAct agent, larger budget, 26 Aug 2026). For each prime, differences of congruence and opposite-congruence kernels are positive semidefinite; unwinding their signs bounds the total logarithmic gcd-distance, a small-distance anchor set has small height after gcd normalisation, and an exceptional-prime pigeonhole propagates the height bound to the whole primitive set, giving `|A| ≤ 65 (r+1)^5` (so `f(n) ≫ n^{1/5}`).

**Informal summary from the FrontierMath Erdős paper** (Thomas F. Bloom, appendix; a fuller sketch is on the problem page of
erdosproblems.com): GPT-6 Astra provided several distinct proofs of `|S(A)| ≫ n^c` with different values of `c`. All use elementary methods
and are reasonably short, but appear to be distinct; after an initial examination the paper judges the four proofs to
consist of three distinct arguments.

## Repository layout

- `Challenge.lean` — the statement surface: definitions copied verbatim from the benchmark statement and the compared theorem with `sorry`.
- `Solution.lean` — imports the primary resolution module, in whose environment the compared theorem is proved.
- `Erdos126.lean`, `Erdos126/Resolutions/` — the AI-written proof module(s); `Erdos126.lean` imports the primary one.
- Alternate resolutions are built as the separate Lake library `Erdos126Alternates`; each is a self-contained copy of the statement preamble plus its own proof, so they are never imported together.
- `comparator.json` — Comparator configuration naming `Erdos126.erdos_126`.
- `formalization.yaml` — structured metadata (provenance, sources, classification, automation, review) in the mathlib-initiative v0.4 format.
- `provenance/` — SHA-256 sums of the benchmark output files and unified diffs from them to the modules here.
- `scripts/verify-comparator.sh` runs the pinned Comparator, lean4export, NanoDa and Landrun locally (Linux); `scripts/validate-formalization.rb` checks the metadata file.
- `.github/workflows/ci.yml` — builds the project and runs Comparator (layout from the Palomar template; the template's doc-gen4 job is omitted because the modules import all of Mathlib).

## Edits relative to the benchmark output

The proof modules are the model's final `Spec.lean` files, verified by the benchmark, with only the following mechanical changes; the
exact diffs are in `provenance/`. The toolchain was moved from Lean v4.27.0 / Mathlib (via Formal Conjectures at commit
`488aade2`) to Lean v4.28.0 / Mathlib v4.28.0, the oldest release Palomar accepts; the only change this required is the
`loopless` adjustment listed below for the files it affects.

- `Erdos126_132usd_25h.lean` (SHA-256 of the benchmark output: `3f05a9d2b4bf40ba0b64ff889b940578562bfa9083e98cda5607094186510dea`):
  - line 1: `import FormalConjecturesUtil` → `import Mathlib`
  - removed trailing unused stub `theorem Erdos126.erdos_126.disproof : ¬ (type_of% @Erdos126.erdos_126) := sorry`
- `Erdos126_81usd_13h.lean` (SHA-256 of the benchmark output: `f8268f33369e1c64c39c58955566a4022bb6a35c8e509e38fa6e0aba0b8d3331`):
  - line 1: `import FormalConjecturesUtil` → `import Mathlib`
  - removed trailing unused stub `theorem Erdos126.erdos_126.disproof : ¬ (type_of% @Erdos126.erdos_126) := sorry`
- `Erdos126_104usd_15h.lean` (SHA-256 of the benchmark output: `788304c7804e80815177b75011a85337531042cc60a727214ac4a83e8cdb15bf`):
  - line 1: `import FormalConjecturesUtil` → `import Mathlib`
  - removed trailing unused stub `theorem Erdos126.erdos_126.disproof : ¬ (type_of% @Erdos126.erdos_126) := sorry`
- `Erdos126_133usd_17h.lean` (SHA-256 of the benchmark output: `bef9db8617e9d2c56c10bb014c33921230afc0f6e4e33a133275dbe4c29c9fc3`):
  - line 1: `import FormalConjecturesUtil` → `import Mathlib`
  - no other changes (react-agent file: statement contained only the proved direction)

## Verification

```sh
lake exe cache get
lake build
ruby scripts/validate-formalization.rb
./scripts/verify-comparator.sh   # Linux: Comparator + NanoDa under Landrun
```

CI runs the same checks. The compared theorem depends on no `sorry` and on no axioms beyond `propext`, `Quot.sound` and
`Classical.choice`. This repository is prepared for submission to Palomar through the
[submission form](https://submit.palomar-registry.org/) with the full commit SHA; registration is a separate step by the maintainer.

## Licence and attribution

This repository snapshot is licensed under the Apache License 2.0 (see `LICENSE`). The benchmark statement it reproduces is
from Formal Conjectures, © The Formal Conjectures Authors, Apache-2.0 (see `NOTICE`). Cited papers,
erdosproblems.com and Mathlib retain their own licences.
