import Mathlib

/-!
# Erdős problem #126: proof

*Reference:* [erdosproblems.com/126](https://www.erdosproblems.com/126)

For a finite set `A ⊆ ℕ` let `S(A)` be the set of primes dividing some `a + b` with `a ≠ b ∈ A`,
and let `f(n)` be the minimum of `|S(A)|` over all `n`-element sets `A`. In their first joint
paper, Erdős and Turán [ErTu34] proved `log n ≪ f(n) ≪ n / log n`. Erdős asked on several
occasions whether `f(n) / log n → ∞`; erdosproblems.com lists a $250 prize.

The conjecture is **true**: `f(n) / log n → ∞`. Formally, the theorem proved is the Formal
Conjectures statement `Erdos126.erdos_126`: for every `f : ℕ → ℕ` satisfying
`IsMaximalAddFactorsCard f` (which pins `f` down as the function above), `f n / log n → ∞`. The
four resolutions in this repository prove polynomial lower bounds `f(n) ≫ n^c` with, according to
their own module documentation, `c = 1/8` (primary), `1/3`, `1/2` and `1/5`; only the limit
statement is advertised in `Challenge.lean`. Since `A = {1, …, n}` gives `|S(A)| ≪ n / log n`, the
truth lies between `n^{1/2}` and `n / log n`.

This file is the small statement surface a reader should audit: the theorem `Erdos126.erdos_126`
below is the compared declaration, and the conjecture is proved in `Solution.lean` and the module
it imports. Only the theorem's `sorry` is filled in there.

The definitions and the statement inside this file are copied verbatim from
`FormalConjectures/ErdosProblems/126.lean` in [Formal Conjectures](https://github.com/google-deepmind/formal-conjectures) (Google DeepMind,
Apache-2.0) at commit `488aade228ec37880b8fec178c173c07d279bb53`, which is the statement the AI system was
given in the FrontierMath Erdős benchmark (isolated statement file
`apn/data/erdos/Isolated/Erdos126.erdos_126.lean` in [LeanOpenProblems](https://github.com/epoch-research/LeanOpenProblems) at commit
`77882c437ca1dfefab3b27fa00f1d29788100311`).
-/
open Filter

namespace Erdos126

/--
`IsMaximalAddFactorsCard f` says that, for every `n`, `f n` is the greatest `m` such that every
`n`-element set `A` of natural numbers has at least `m` distinct primes dividing the product
$\prod_{a \neq b \in A} (a + b)$ (taken over ordered pairs; the prime divisors are the same as over
unordered pairs). Such an `f` exists and is unique, so the hypothesis of `erdos_126` pins down the
extremal function of the problem.
-/
def IsMaximalAddFactorsCard (f : ℕ → ℕ) : Prop := ∀ n,
    IsGreatest
      { m | ∀ (A : Finset ℕ), A.card = n →
        m ≤ (∏ ⟨a, b⟩ ∈ A.offDiag, (a + b)).primeFactors.card}
      (f n)

/--
**Erdős problem #126.** Let $f(n)$ be maximal such that if $A\subseteq\mathbb{N}$ has $|A| = n$ then
$\prod_{a\neq b\in A}(a + b)$ has at least $f(n)$ distinct prime factors. Then
$\frac{f(n)}{\log n} \to\infty$. This is the conjecture `erdos_126` exactly as formalized in
Formal Conjectures, now a theorem.
-/
theorem erdos_126 : ∀ (f : ℕ → ℕ), IsMaximalAddFactorsCard f →
    Tendsto (fun n => f n / Real.log n) atTop atTop := by
  sorry

end Erdos126
