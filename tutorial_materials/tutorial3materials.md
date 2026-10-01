# ECE265 Tutorial 3

## Assignment 2B: Properties of Systems

T02 · Ruilin Wang

This recap collects the definitions and methods needed for Assignment 2B practice.

For more detail, see [Lecture Summary 2](../lecture_summery/week2lecture_summary.md), §11, and [Lecture Summary 3](../lecture_summery/week3lecture_summary.md), §§1–4.

### Selected practice examples

These are unassigned textbook parts; they practise the methods used in Assignment 2B.

| Property | CT practice | DT practice |
| --- | --- | --- |
| Memoryless | 3.24(a) | 8.18(d) |
| Causality | 3.108(f) | 8.19(b) |
| Invertibility | 3.26(a) | 8.104(a) (in class) |
| BIBO stability | 3.27(c) | 8.21(b) (in class) |
| Time invariance | 3.28(e) (in class) | 8.22(e) |
| Linearity | 3.29(d) | 8.23(d) |
| Eigenfunctions / eigensequences | 3.33(d), all three inputs (in class) | 8.25(c), all three inputs |

## 1. Read the system rule before testing a property

A system acts on a **whole signal**:

$$
y=Hx.
$$

The expression $(Hx)(\xi)$ is one output value, where $\xi=t\in\mathbb{R}$ for CT and $\xi=n\in\mathbb{Z}$ for DT. Integration variables such as $\tau$ and summation indices such as $k$ are not the output time/index.

Test each property by its definition. One convenient input cannot prove a claim about **all** allowed inputs; one valid counterexample can disprove it.

**References:** slides §2.6, pp.104–107; textbook §§3.7 and 8.6.

## 2. Memoryless: which input values affect this output?

At a fixed $\xi_0$, a memoryless system can depend only on $x(\xi_0)$, if it depends on the input at all. Equivalently, for any two allowed inputs,

$$
x_1(\xi_0)=x_2(\xi_0)
\quad\Longrightarrow\quad
(Hx_1)(\xi_0)=(Hx_2)(\xi_0).
$$

This must hold at every $\xi_0$.

**Method:** fix the output time/index, simplify the rule, and identify every input value that can actually affect the output. For an integral or sum, inspect the effective integration or summation range.

**Trap:** an output independent of the input still satisfies the memoryless definition. Also, an explicit time-dependent coefficient is not itself memory: what matters is which **input times** are used.

**References:** slides §2.7, pp.109–110; textbook §§3.8.1 and 8.7.1.

## 3. Causality: does the output need future input?

A causal system allows past and present input values, but not future ones. An equivalent comparison test is

$$
x_1(\xi)=x_2(\xi)\quad\text{for all }\xi\le\xi_0
\quad\Longrightarrow\quad
(Hx_1)(\xi_0)=(Hx_2)(\xi_0).
$$

This must hold for every pair of allowed inputs and every $\xi_0$.

If the output at $\xi$ reads $x(q(\xi))$, compare that input index, $q(\xi)$, with $\xi$. Check **all** allowed times/indices, including negative ones.

For a step-weighted CT integral, first find where the step is nonzero. With a real constant $d$,

$$
u(t-\tau-d)\ne0
\quad\Longleftrightarrow\quad
\tau\le t-d.
$$

This inequality identifies the effective input-time range. Compare that range with $\tau\le t$ before deciding causality. The textbook uses $u(0)=1$.

**Trap:** a causal **signal** is not the same as a causal **system**. Do not justify system causality by checking only where one chosen input is nonzero.

**References:** slides §2.7, pp.111–112; step convention on p.87; textbook §§3.8.2, 8.7.2, and 3.5.4.

## 4. Invertibility: can every allowed input be recovered uniquely?

An inverse must recover every allowed input:

$$
H^{-1}(Hx)=x.
$$

Equivalently, the system must satisfy

$$
Hx_1=Hx_2\quad\Longrightarrow\quad x_1=x_2.
$$

- **To prove invertibility:** write $y=Hx$, recover the whole input $x$ from $y$, state the inverse rule, and verify the composition.
- **To disprove invertibility:** construct two distinct allowed input signals that produce the same entire output signal.

When a rule changes which input time/index is read, check whether **every input location is observed**. In CT, solve the input-argument equation to find when a desired value is read. In DT, use only integer indices.

*Supplement — DT samples:* For $y(n)=x(g(n))$, with no extra input restrictions, every integer $k$ must equal $g(n)$ for some integer $n$. Otherwise, $x(k)$ is never read and cannot be recovered. A one-to-one $g$ is **not enough**: it can still skip input samples.

For a rule that acts on each input value separately, $y(\xi)=f(x(\xi))$, check whether $f$ is one-to-one on the allowed input values. If so, recover $x(\xi)=f^{-1}(y(\xi))$; use the inverse only on the actual output range.

**Trap:** fractional indices are not DT samples. Algebra cannot recover unread values. Respect the stated input restrictions.

**References:** slides §2.7, pp.113–114; textbook §§3.8.3 and 8.7.3. CT/DT time-transformation background: slides pp.43–46 and 49–50.

## 5. BIBO stability: find a uniform bound, or a counterexample

Start with an arbitrary allowed input satisfying

$$
|x(\xi)|\le B_x<\infty\qquad\text{for all }\xi.
$$

To establish stability, obtain

$$
|(Hx)(\xi)|\le B_y<\infty\qquad\text{for all }\xi,
$$

where $B_y$ may depend on the input but **cannot depend on $\xi$**. Finiteness at each individual time/index is not a uniform bound; see Summary 3, §1, for the source-wording note.

For a fixed finite number of terms $M$ and fixed coefficients, use the triangle inequality:

$$
\left|\sum_{r=1}^{M}c_r x(k_r)\right|
\le\sum_{r=1}^{M}|c_r|\thinspace|x(k_r)|
\le B_x\sum_{r=1}^{M}|c_r|.
$$

Inclusive integer limits $a\le k\le b$ contain $b-a+1$ terms. The final bound must not depend on the output index.

For an integral, the corresponding bridge is

$$
\left|\int_a^b x(\tau)\thinspace d\tau\right|
\le\int_a^b|x(\tau)|\thinspace d\tau,
\qquad a\le b.
$$

The integrals must exist; check whether the interval length has a bound independent of the output time.

**Counterexample method:** choose one allowed input, establish its finite uniform input bound, compute its output, and show that no finite uniform output bound exists.

**Traps:**

- For a reciprocal-type rule, test **one** bounded input that is never zero but gets arbitrarily close to zero across time. Do not use an input with zero values if the system is undefined there.
- For an infinite sum, finite term counting no longer applies. Check that the sum converges for every allowed bounded input and that each resulting output has one uniform bound.

**References:** slides §2.7, p.115; textbook §§3.8.4 and 8.7.4.

## 6. Time invariance: keep the two shift routes separate

Define

$$
(S_{\xi_0}x)(\xi)=x(\xi-\xi_0).
$$

The time-invariance condition is

$$
H(S_{\xi_0}x)=S_{\xi_0}(Hx)
$$

for every allowed input and shift: any real $\xi_0$ in CT, any integer $\xi_0$ in DT.

1. **Shift the input first:** let $v=S_{\xi_0}x$. Compute $Hv$ using $v$ wherever the original rule uses $x$, while preserving the rule's own arguments and explicit time/index. Then substitute $v(s)=x(s-\xi_0)$.
2. **Shift the output instead:** compute $y=Hx$, then evaluate $y(\xi-\xi_0)$ throughout the complete output expression.
3. Compare the two whole signals. Equality must hold for arbitrary inputs and shifts.

For a moving DT sum, call the integer shift $m$ ($m=\xi_0$ in DT). Change the dummy summation index:

$$
\ell=k-m
\quad\Longrightarrow\quad
k=\ell+m.
$$

Update the summand **and both limits** consistently. The new summation index is still an integer.

**Trap:** replacing the time/index everywhere in the system rule belongs to the **output-shift** route, not the input-substitution route. Reflected input arguments and moving sum limits require particular care.

**References:** slides §2.7, pp.116–117; textbook §§3.8.5 and 8.7.5.

## 7. Linearity: substitute a weighted sum of inputs

For arbitrary allowed inputs and scalars,

$$
H(a_1x_1+a_2x_2)=a_1Hx_1+a_2Hx_2.
$$

Linearity requires both additivity and homogeneity. In the textbook's complex-valued signal spaces, test complex scalars as well as real ones.

**Method:** substitute $v=a_1x_1+a_2x_2$ into the rule and compare $Hv$ with $a_1Hx_1+a_2Hx_2$. Expand powers; for the even-part operator, use

$$
\mathrm{Even}\lbrace x\rbrace(\xi)=\frac{x(\xi)+x(-\xi)}{2}.
$$

*Supplement — quick necessary check:* A linear system must satisfy $H0=0$. Failure proves nonlinearity, but success alone does not prove linearity.

**Trap:** multiplying by a fixed function of time/index differs from applying a nonlinear function to the input. Linearity and time invariance are separate tests.

**References:** slides §2.7, pp.118–120; textbook §§3.8.6 and 8.7.6. Even-part definition: textbook §§3.4.1 and 8.3.1.

## 8. Eigenfunctions and eigensequences: one constant must work everywhere

A nonzero whole signal $x$ is an eigenfunction/eigensequence if

$$
Hx=\lambda x
$$

for a single constant $\lambda$ at every time/index. The system does not need to be linear for this definition to apply.

**Method:** compute the given system's output for the candidate input. Where $x(\xi)\ne0$, the ratio

$$
\frac{(Hx)(\xi)}{x(\xi)}
$$

must have the same value everywhere. Where $x(\xi)=0$, check separately that $(Hx)(\xi)=0$.

For real-valued inputs to a magnitude system, distinguish the sign regions using

$$
|r|=\begin{cases}
r,&r\ge0,\cr
-r,&r<0.
\end{cases}
$$

Check whether the same multiplier works across all regions, rather than testing only positive times/indices. For a complex value, use its magnitude definition instead of this real sign rule.

**Traps:**

- A signal with some zero samples is not the zero signal. The excluded zero signal is zero **everywhere**.
- The eigenvalue may be zero; the candidate input must still be a nonzero whole signal.

**References:** slides §2.7, p.121; textbook §§3.8.7 and 8.7.7.

## Coverage notes for Assignment 2B

Additional assigned steps:

- **3.26(b):** pointwise value map and its allowed input/output values → §4.
- **3.27(a):** integral bound → §5.
- **8.19(f):** compare an affine input index with $n$ across all integers → §3.
- **8.21(f):** infinite tail sum → §5.
- **3.33(a) and 8.25(b):** different system rules; recompute the output and repeat the constant-multiplier test → §8.

---

The question statements below reproduce the selected textbook parts; the knowledge points, bridge formulas and worked answers are tutorial notes.

## 3.24(a): Problem

Determine whether each system $H$ given below is memoryless.

(a)

$$
Hx(t)=\int_{-\infty}^{2t}x(\tau)\thinspace d\tau;
$$

**Source:** Michael D. Adams, *Signals and Systems*, Edition 7.0.0-beta.1, printed p.73, Exercise 3.24(a).

### 3.24(a): Knowledge points

- Memoryless systems: slides pp.109–110; textbook §3.8.1.
- An integration variable such as $\tau$ identifies input times, not the output time $t$.

### 3.24(a): Core bridge formula

For a memoryless system, two inputs with the same value at the current time must give the same output at that time:

$$
x_{1}(t_{0})=x_{2}(t_{0})
\quad\Longrightarrow\quad
(Hx_{1})(t_{0})=(Hx_{2})(t_{0}).
$$

To disprove this, find one time $t_{0}$ and two inputs for which the input values agree but the output values differ.

### 3.24(a): Answer

Set $t_{0}=0$. The upper integration limit becomes $2t_{0}=2(0)=0$, so

$$
(Hx)(0)=\int_{-\infty}^{0}x(\tau)\thinspace d\tau.
$$

Choose the two inputs

$$
x_{1}(t)=0\quad\text{for all }t,
\qquad
x_{2}(t)=\begin{cases}
1,&-2\le t\lt-1,\cr
0,&\text{otherwise}.
\end{cases}
$$

At the current time, both inputs are zero:

$$
x_{1}(0)=0=x_{2}(0).
$$

Their outputs at that time are

$$
(Hx_{1})(0)=\int_{-\infty}^{0}0\thinspace d\tau=0,
$$

$$
(Hx_{2})(0)=\int_{-2}^{-1}1\thinspace d\tau
=(-1)-(-2)=1.
$$

The integral sees the nonzero input on a past interval even though the current input value is zero. Equal current input values have produced unequal current output values.

**Final: the system has memory; it is not memoryless.**

---

## 8.18(d): Problem

> Determine whether each system $H$ given below is memoryless.
>
> (d) $Hx(n)=42$.

**Original question source:** Michael D. Adams, *Signals and Systems*, Edition 7.0.0-beta.1, p.394.

### 8.18(d): Knowledge points

- A memoryless system does not need input samples at other indices. A system that ignores the input also qualifies.
- **Slides:** §2.7, pp.109–110.
- **Textbook:** §8.7.1, p.378.

### 8.18(d): Core bridge formula

At any fixed index $n_{\ast}$, a memoryless system satisfies

$$
x_{1}(n_{\ast})=x_{2}(n_{\ast})
\quad\Longrightarrow\quad
(Hx_{1})(n_{\ast})=(Hx_{2})(n_{\ast}).
$$

This must hold for every pair of allowed inputs and every index.

### 8.18(d): Answer

Choose any two input sequences $x_{1}$ and $x_{2}$, and any integer $n_{\ast}$. The system rule gives

$$
(Hx_{1})(n_{\ast})=42,
\qquad
(Hx_{2})(n_{\ast})=42.
$$

The output is the same whether or not the two inputs agree at $n_{\ast}$. In particular, whenever their current samples agree, their current outputs agree. No input sample at another index is needed: the output is always the fixed number $42$.

**Final answer: the system is memoryless.**

---

## 3.108(f): Problem

Determine whether each system $H$ given below is causal.

(f)

$$
Hx(t)=\int_{-\infty}^{\infty}x(\tau)u(t-\tau-1)\thinspace d\tau;
$$

**Source:** Michael D. Adams, *Signals and Systems*, Edition 7.0.0-beta.1, printed p.78, Exercise 3.108(f).

### 3.108(f): Knowledge points

- Causal systems: slides pp.111–112; textbook §3.8.2.
- Unit-step function, including $u(0)=1$: slides p.87; textbook §3.5.4.

### 3.108(f): Core bridge formula

A causal system's output at $t$ can use input values only at times $\tau\le t$. For a step-weighted integral, first determine its effective input-time range:

$$
u(s)=\begin{cases}
1,&s\ge0,\cr
0,&s\lt0.
\end{cases}
$$

For a real constant $d$, $u(t-\tau-d)$ is nonzero only when $t-\tau-d\ge0$, or $\tau\le t-d$.

### 3.108(f): Answer

Here the step argument is $t-\tau-1$. Its nonzero region is

$$
t-\tau-1\ge0
\quad\Longleftrightarrow\quad
t-1\ge\tau
\quad\Longleftrightarrow\quad
\tau\le t-1.
$$

For $\tau\le t-1$, the step equals one; for $\tau>t-1$, it equals zero. The output therefore reduces to

$$
(Hx)(t)=\int_{-\infty}^{t-1}x(\tau)\thinspace d\tau.
$$

Every input time used satisfies

$$
\tau\le t-1\lt t.
$$

So at any output time $t$, the system uses only past input values, never future input values. This reasoning holds at every $t$, wherever the defining integral exists.

**Final: the system is causal.**

---

## 8.19(b): Problem

> Determine whether each system $H$ given below is causal.
>
> (b) $Hx(n)=x(n-1)+1$;

**Original question source:** Michael D. Adams, *Signals and Systems*, Edition 7.0.0-beta.1, p.394.

### 8.19(b): Knowledge points

- A causal system may use past and present input samples, but not future samples.
- Compare the input index used by the rule with the output index; a fixed added number is not an input sample.
- **Slides:** §2.7, pp.111–112.
- **Textbook:** §8.7.2, p.379.

### 8.19(b): Core bridge formula

For every integer $n_{\ast}$, causality requires

$$
x_{1}(k)=x_{2}(k)\quad\text{for every }k\le n_{\ast}
\quad\Longrightarrow\quad
(Hx_{1})(n_{\ast})=(Hx_{2})(n_{\ast}).
$$

### 8.19(b): Answer

At any output index $n_{\ast}$,

$$
y(n_{\ast})=x(n_{\ast}-1)+1.
$$

The only input index read is $n_{\ast}-1$. Since

$$
n_{\ast}-1\lt n_{\ast}
$$

for every integer $n_{\ast}$, this is always a past sample. The extra $1$ is a fixed constant and does not require any additional input value.

To check the definition directly, suppose $x_{1}(k)=x_{2}(k)$ for every $k\le n_{\ast}$. This includes $k=n_{\ast}-1$, so

$$
(Hx_{1})(n_{\ast})=x_{1}(n_{\ast}-1)+1
=x_{2}(n_{\ast}-1)+1=(Hx_{2})(n_{\ast}).
$$

**Final answer: the system is causal.**

---

## 3.26(a): Problem

For each system $H$ given below, determine if $H$ is invertible, and if it is, specify its inverse.

(a)

$$
Hx(t)=x(at-b)
$$

where $a$ and $b$ are real constants and $a\ne0$;

**Source:** Michael D. Adams, *Signals and Systems*, Edition 7.0.0-beta.1, printed p.74, Exercise 3.26(a).

### 3.26(a): Knowledge points

- Invertible systems and recovery of the whole input: slides pp.113–114; textbook §3.8.3.
- CT time shifting: slides pp.38–39; CT time scaling: slides pp.43–44; textbook §§3.2.1–3.2.5.

### 3.26(a): Core bridge formula

An inverse must recover every allowed input:

$$
H^{-1}(Hx)=x.
$$

For a rule $y(t)=x(g(t))$, recover an input value $x(s)$ by finding an output time $t$ for which $g(t)=s$.

### 3.26(a): Answer

Write the output as

$$
y(t)=x(at-b).
$$

To recover $x(s)$, solve for the output time at which the input argument equals $s$:

$$
at-b=s
\quad\Longrightarrow\quad
at=s+b
\quad\Longrightarrow\quad
t=\frac{s+b}{a}.
$$

Division is valid because $a\ne0$. Since $s$, $a$ and $b$ are real, this is an allowed real CT time for every real $s$. Substitute this time into the output:

$$
y\left(\frac{s+b}{a}\right)
=x\left(a\frac{s+b}{a}-b\right)
=x(s+b-b)
=x(s).
$$

Therefore, after renaming the recovered input time $s$ as $t$, the inverse rule is

$$
(H^{-1}y)(t)=y\left(\frac{t+b}{a}\right).
$$

Check recovery directly:

$$
\bigl(H^{-1}(Hx)\bigr)(t)
=(Hx)\left(\frac{t+b}{a}\right)
=x\left(a\frac{t+b}{a}-b\right)
=x(t+b-b)
=x(t).
$$

**Final: the system is invertible, with**

$$
\boxed{(H^{-1}y)(t)=y\left(\frac{t+b}{a}\right).}
$$

---

## 8.104(a): Problem

> Determine whether each system $H$ given below is invertible.
>
> (a) $Hx(n)=x(3n)$.

**Original question source:** Michael D. Adams, *Signals and Systems*, Edition 7.0.0-beta.1, p.396.

### 8.104(a): Knowledge points

- An inverse must recover the entire input sequence, including every integer-indexed sample.
- To disprove invertibility, find two different inputs with the same entire output.
- **Slides:** §2.7, pp.113–114; DT downsampling, p.45.
- **Textbook:** §8.7.3, p.380; unit impulse, §8.4.6, p.373.

### 8.104(a): Core bridge formula

An invertible system must satisfy

$$
Hx_{1}=Hx_{2}\quad\Longrightarrow\quad x_{1}=x_{2}.
$$

The DT unit impulse is

$$
\delta(k)=\begin{cases}
1,&k=0,\cr
0,&k\ne0.
\end{cases}
$$

### 8.104(a): Answer

**1. Identify which input samples the output reads.**

The rule $y(n)=x(3n)$ reads input indices

$$
\ldots,-6,-3,0,3,6,\ldots.
$$

For example,

$$
y(-1)=x(-3),\qquad y(0)=x(0),\qquad y(1)=x(3).
$$

The sample $x(1)$ is never read: the equation $3n=1$ would require $n=1/3$, which is not an integer output index.

**2. Construct two distinct inputs that differ at an unread sample.**

Let

$$
x_{1}(n)=0,
\qquad
x_{2}(n)=\delta(n-1).
$$

At $n=1$,

$$
x_{1}(1)=0,
\qquad
x_{2}(1)=\delta(1-1)=\delta(0)=1.
$$

Thus $x_{1}\ne x_{2}$.

**3. Compute and compare their whole outputs.**

For the first input,

$$
(Hx_{1})(n)=x_{1}(3n)=0\qquad\text{for every }n\in\mathbb{Z}.
$$

For the second input,

$$
(Hx_{2})(n)=x_{2}(3n)=\delta(3n-1).
$$

This impulse would be nonzero only if $3n-1=0$, or $n=1/3$. Since no integer $n$ satisfies that equation,

$$
\delta(3n-1)=0\qquad\text{for every }n\in\mathbb{Z}.
$$

The two entire outputs are identical, even though the inputs are different. An inverse cannot tell which input produced the zero output.

**Final answer: the system is not invertible.** A one-to-one input-index map can still skip samples; recovery requires every input sample to be observed.

---

## 3.27(c): Problem

Determine whether each system $H$ given below is BIBO stable.

(c)

$$
Hx(t)=1/x(t);
$$

**Source:** Michael D. Adams, *Signals and Systems*, Edition 7.0.0-beta.1, printed p.74, Exercise 3.27(c).

### 3.27(c): Knowledge points

- Bounded-input bounded-output stability: slides p.115; textbook §3.8.4.
- A uniform bound must hold at all times. For a reciprocal, an input can remain bounded while approaching zero.

### 3.27(c): Core bridge formula

BIBO stability requires every allowed bounded input to produce a bounded output:

$$
|x(t)|\le B_{x}<\infty\quad\text{for all }t
\quad\Longrightarrow\quad
|(Hx)(t)|\le B_{y}<\infty\quad\text{for all }t.
$$

One bounded input with an unbounded output disproves stability. For a reciprocal system, the counterexample must not have zero input values, because division by zero is undefined.

### 3.27(c): Answer

Choose

$$
x(t)=\frac{1}{1+|t|}.
$$

For every real $t$, $1+|t|\ge1$, so

$$
0\lt x(t)=\frac{1}{1+|t|}\le1.
$$

Thus the input is bounded with $B_{x}=1$, and it is never zero. Substituting into the system gives

$$
(Hx)(t)=\frac{1}{x(t)}
=\frac{1}{1/(1+|t|)}
=1+|t|.
$$

There is no finite uniform output bound. To see this, take any proposed bound $B_{y}\ge0$ and evaluate the output at $t=B_{y}$:

$$
|(Hx)(B_{y})|=1+|B_{y}|=1+B_{y}>B_{y}.
$$

Every proposed bound fails at some time, despite the input staying between zero and one.

**Final: the system is not BIBO stable.**

---

## 8.21(b): Problem

> Determine whether each system $H$ given below is BIBO stable.
>
> (b) $Hx(n)=\sum_{k=n}^{n+4}x(k)$;

**Original question source:** Michael D. Adams, *Signals and Systems*, Edition 7.0.0-beta.1, p.395.

### 8.21(b): Knowledge points

- BIBO stability requires a finite output bound independent of the output index, for every bounded input.
- Apply the triangle inequality and count the number of terms, including both endpoints.
- **Slides:** §2.7, p.115.
- **Textbook:** §8.7.4, p.382.

### 8.21(b): Core bridge formula

Start with an arbitrary bounded input:

$$
|x(k)|\le B_{x}<\infty\qquad\text{for every }k\in\mathbb{Z}.
$$

For a finite sum, the triangle inequality gives

$$
\left|\sum_{k=a}^{b}x(k)\right|
\le\sum_{k=a}^{b}|x(k)|
\le(b-a+1)B_{x},\qquad a\le b.
$$

The output bound must hold for every output index, not just for one chosen index or input.

### 8.21(b): Answer

**1. Expand the sum and count its terms.**

$$
y(n)=x(n)+x(n+1)+x(n+2)+x(n+3)+x(n+4).
$$

The inclusive count is

$$
(n+4)-n+1=5.
$$

There are always five terms, regardless of $n$.

**2. Apply the input bound to every term.**

For any input satisfying $|x(k)|\le B_{x}$ at every integer $k$,

$$
|y(n)|
\le|x(n)|+|x(n+1)|+|x(n+2)|+|x(n+3)|+|x(n+4)|
\le B_{x}+B_{x}+B_{x}+B_{x}+B_{x}=5B_{x}.
$$

**3. Check that the output bound is uniform.**

Choose $B_{y}=5B_{x}$. Since $B_{x}$ is finite, $B_{y}$ is finite. It does not depend on $n$, and the argument applies to every bounded input.

**Final answer: the system is BIBO stable, with $|y(n)|\le5B_{x}$ for all $n$.**

---

## 3.28(e): Problem

Determine whether each system $H$ given below is time invariant.

(e)

$$
Hx(t)=x(-t);
$$

**Source:** Michael D. Adams, *Signals and Systems*, Edition 7.0.0-beta.1, printed p.74, Exercise 3.28(e).

### 3.28(e): Knowledge points

- Time invariance and the two shift routes: slides pp.116–117; textbook §3.8.5.
- CT time shifting: slides pp.38–39; CT time reversal: slides pp.41–42; textbook §§3.2.1–3.2.2.

### 3.28(e): Core bridge formula

Let $y=Hx$ and shift the input by $t_{0}$:

$$
v(t)=x(t-t_{0}).
$$

Time invariance requires

$$
(Hv)(t)=y(t-t_{0})
$$

for every input $x$, every real shift $t_{0}$ and every time $t$. Compute the two sides separately; one unequal result is enough to disprove time invariance.

### 3.28(e): Answer

**Route 1: shift the input, then apply the system.**

The system replaces the argument of its input by $-t$. Its input is now $v$, so

$$
(Hv)(t)=v(-t).
$$

Using $v(s)=x(s-t_{0})$ with $s=-t$ gives

$$
(Hv)(t)=x(-t-t_{0}).
$$

**Route 2: apply the system, then shift the output.**

The original output is $y(t)=x(-t)$. Evaluating it at $t-t_{0}$ gives

$$
y(t-t_{0})=x\bigl(-(t-t_{0})\bigr)=x(-t+t_{0}).
$$

The shifts inside the two input arguments have opposite signs. Confirm that they can give different values by choosing

$$
x(s)=s,\qquad t_{0}=1,\qquad t=0.
$$

For Route 1,

$$
(Hv)(0)=x(-0-1)=x(-1)=-1.
$$

For Route 2,

$$
y(0-1)=x(-0+1)=x(1)=1.
$$

Since $-1\ne1$, the required equality fails.

**Final: the system is not time invariant.**

---

## 8.22(e): Problem

> Determine whether each system $H$ given below is time invariant.
>
> (e) $Hx(n)=\sum_{k=n-n_{0}}^{n}x(k)$, where $n_{0}$ is a strictly positive integer constant.

**Original question source:** Michael D. Adams, *Signals and Systems*, Edition 7.0.0-beta.1, p.395.

### 8.22(e): Knowledge points

- Compare shifting the input before applying the system with shifting the original output.
- When changing a summation index, change both limits as well as the summand.
- The window parameter $n_{0}$ is fixed; it is not the shift used in the test.
- **Slides:** §2.7, pp.116–117.
- **Textbook:** §8.7.5, p.384.

### 8.22(e): Core bridge formula

For an arbitrary integer shift $m$, define

$$
v(n)=x(n-m),\qquad y(n)=(Hx)(n).
$$

Time invariance requires

$$
(Hv)(n)=y(n-m)
$$

for every input $x$, every integer shift $m$, and every integer $n$.

### 8.22(e): Answer

**1. Shift the input, then apply the original system rule.**

Since $v(k)=x(k-m)$,

$$
(Hv)(n)=\sum_{k=n-n_{0}}^{n}v(k)
=\sum_{k=n-n_{0}}^{n}x(k-m).
$$

The system's original limits stay $n-n_{0}$ and $n$ at this stage: we replaced the input sequence, not the output index.

**2. Change the dummy summation index.**

Set

$$
\ell=k-m,\qquad k=\ell+m.
$$

Substitute both limits:

$$
k=n-n_{0}\quad\Longrightarrow\quad\ell=n-n_{0}-m,
$$

$$
k=n\quad\Longrightarrow\quad\ell=n-m.
$$

Therefore,

$$
(Hv)(n)=\sum_{\ell=n-n_{0}-m}^{n-m}x(\ell).
$$

**3. Apply the system first, then shift its output.**

The original output is

$$
y(n)=\sum_{k=n-n_{0}}^{n}x(k).
$$

Replace its output index $n$ by $n-m$ throughout the limits:

$$
y(n-m)=\sum_{k=(n-m)-n_{0}}^{n-m}x(k)
=\sum_{k=n-n_{0}-m}^{n-m}x(k).
$$

Both routes sum the same input samples over the same limits. The dummy letters $k$ and $\ell$ do not change the value of a sum. Thus $(Hv)(n)=y(n-m)$ for arbitrary $x$, $m$, and $n$.

**Final answer: the system is time invariant.**

---

## 3.29(d): Problem

Determine whether each system $H$ given below is linear.

(d)

$$
Hx(t)=x^{2}(t);
$$

**Source:** Michael D. Adams, *Signals and Systems*, Edition 7.0.0-beta.1, printed p.74, Exercise 3.29(d).

### 3.29(d): Knowledge points

- Superposition, additivity and homogeneity: slides pp.118–120; textbook §3.8.6.
- To disprove linearity, one valid failure of either additivity or homogeneity is enough.

### 3.29(d): Core bridge formula

A linear system must satisfy

$$
H(a_{1}x_{1}+a_{2}x_{2})=a_{1}Hx_{1}+a_{2}Hx_{2}.
$$

In particular, it must be homogeneous:

$$
H(cx)=cHx
$$

for every allowed input $x$ and scalar $c$.

### 3.29(d): Answer

Choose the constant input $x(t)=1$ and scalar $c=2$.

If we scale the input first, then apply the system,

$$
\bigl(H(2x)\bigr)(t)
=[2x(t)]^{2}
=[2(1)]^{2}
=2^{2}
=4.
$$

If we apply the system first, then scale the output,

$$
2(Hx)(t)
=2[x(t)]^{2}
=2(1)^{2}
=2.
$$

The two outputs disagree: $4\ne2$. Therefore homogeneity fails, and linearity fails with it.

**Final: the system is nonlinear.**

---

## 8.23(d): Problem

> Determine whether each system $H$ given below is linear.
>
> (d) $Hx(n)=\mathrm{Even}\lbrace x\rbrace(n)$;

**Original question source:** Michael D. Adams, *Signals and Systems*, Edition 7.0.0-beta.1, p.395.

### 8.23(d): Knowledge points

- A linear system preserves arbitrary weighted sums of input sequences.
- Expand the even part as the average of the original and reflected sequence before testing linearity.
- **Slides:** §2.7, pp.118–120.
- **Textbook:** §8.7.6, pp.386–387; even-part definition, §8.3.1, p.357.

### 8.23(d): Core bridge formula

For arbitrary input sequences and scalars, linearity requires

$$
H(a_{1}x_{1}+a_{2}x_{2})=a_{1}Hx_{1}+a_{2}Hx_{2}.
$$

The even-part definition is

$$
\mathrm{Even}\lbrace x\rbrace(n)=\frac{x(n)+x(-n)}{2}.
$$

### 8.23(d): Answer

**1. Form an arbitrary weighted input.**

Let $a_{1},a_{2}$ be arbitrary complex scalars and $x_{1},x_{2}$ be arbitrary input sequences. Define

$$
v(n)=a_{1}x_{1}(n)+a_{2}x_{2}(n).
$$

At the reflected index,

$$
v(-n)=a_{1}x_{1}(-n)+a_{2}x_{2}(-n).
$$

**2. Apply the even-part rule and substitute both values.**

$$
(Hv)(n)=\frac{v(n)+v(-n)}{2}
=\frac{a_{1}x_{1}(n)+a_{2}x_{2}(n)+a_{1}x_{1}(-n)+a_{2}x_{2}(-n)}{2}.
$$

**3. Group the terms belonging to each input.**

$$
(Hv)(n)
=a_{1}\frac{x_{1}(n)+x_{1}(-n)}{2}
+a_{2}\frac{x_{2}(n)+x_{2}(-n)}{2}
=a_{1}(Hx_{1})(n)+a_{2}(Hx_{2})(n).
$$

The equality holds at every integer $n$ for arbitrary inputs and complex scalars, so it establishes the full linearity condition.

**Final answer: the system is linear.**

---

## 3.33(d): Problem

For each system $H$ and the functions $\lbrace x_{k}\rbrace$ given below, determine if each of the $x_{k}$ is an eigenfunction of $H$, and if it is, also state the corresponding eigenvalue.

(d)

$$
Hx(t)=|x(t)|,\qquad
x_{1}(t)=a,\qquad
x_{2}(t)=t,\qquad
x_{3}(t)=t^{2},
$$

where $a$ is a strictly positive real constant.

**Source:** Michael D. Adams, *Signals and Systems*, Edition 7.0.0-beta.1, printed p.75, Exercise 3.33(d).

### 3.33(d): Knowledge points

- Eigenfunctions and eigenvalues: slides p.121; textbook §3.8.7.
- A single constant multiplier must work at every time, including negative times and points where the input is zero.

### 3.33(d): Core bridge formula

A nonzero whole function $x$ is an eigenfunction of $H$ if there is a constant $\lambda$ such that

$$
(Hx)(t)=\lambda x(t)\qquad\text{for every }t.
$$

For a real number $r$,

$$
|r|=\begin{cases}
r,&r\ge0,\cr
-r,&r\lt0.
\end{cases}
$$

For each candidate, compute the magnitude and test whether one constant $\lambda$ reproduces it for the entire function. A nonzero whole function may still have zero values at individual times.

### 3.33(d): Answer

**Candidate 1: $x_{1}(t)=a$, where $a>0$.**

Because $a$ is strictly positive,

$$
(Hx_{1})(t)=|x_{1}(t)|=|a|=a=1\cdot x_{1}(t)
$$

at every time. The function is not the zero function because $a>0$.

**Result: $x_{1}$ is an eigenfunction with eigenvalue $\lambda=1$.**

**Candidate 2: $x_{2}(t)=t$.**

The output is

$$
(Hx_{2})(t)=|t|.
$$

At $t=1$, the eigenfunction equation would require

$$
|1|=\lambda(1)
\quad\Longrightarrow\quad
1=\lambda.
$$

At $t=-1$, the same equation would require

$$
|-1|=\lambda(-1)
\quad\Longrightarrow\quad
1=-\lambda
\quad\Longrightarrow\quad
\lambda=-1.
$$

No single constant can equal both $1$ and $-1$. The equation works at $t=0$ for any $\lambda$, since both sides are zero, but that cannot repair its failure at the other times.

**Result: $x_{2}$ is not an eigenfunction.**

**Candidate 3: $x_{3}(t)=t^{2}$.**

Since $t^{2}\ge0$ for every real $t$,

$$
(Hx_{3})(t)=|t^{2}|=t^{2}=1\cdot x_{3}(t).
$$

At $t=0$, both sides equal $0$; at $t=1$, $x_{3}(1)=1$, so this is not the zero function. The same multiplier $1$ works everywhere.

**Result: $x_{3}$ is an eigenfunction with eigenvalue $\lambda=1$.**

| Candidate | Eigenfunction? | Eigenvalue |
| --- | --- | --- |
| $x_{1}(t)=a$, $a>0$ | Yes | $1$ |
| $x_{2}(t)=t$ | No | — |
| $x_{3}(t)=t^{2}$ | Yes | $1$ |

---

## 8.25(c): Problem

> For each system $H$ and the sequences $\lbrace x_{k}\rbrace$ given below, determine if each of the $x_{k}$ is an eigensequence of $H$, and if it is, also state the corresponding eigenvalue.
>
> (c) $Hx(n)=|x(n)|$, $x_{1}(n)=a$, $x_{2}(n)=n$, $x_{3}(n)=n^{2}$, where $a$ is a strictly positive real constant.

**Original question source:** Michael D. Adams, *Signals and Systems*, Edition 7.0.0-beta.1, p.395.

### 8.25(c): Knowledge points

- An eigensequence produces its own shape multiplied by one constant at every index.
- For the magnitude of a real sequence, check both positive and negative values.
- A nonzero whole sequence may have some zero samples.
- **Slides:** §2.7, p.121.
- **Textbook:** §8.7.7, p.390.

### 8.25(c): Core bridge formula

A nonzero sequence $x$ is an eigensequence if one constant $\lambda$ satisfies

$$
(Hx)(n)=\lambda x(n)\qquad\text{for every }n\in\mathbb{Z}.
$$

For a real number $r$,

$$
|r|=\begin{cases}
r,&r\ge0,\cr
-r,&r<0.
\end{cases}
$$

### 8.25(c): Answer

**1. Test $x_{1}(n)=a$, where $a>0$.**

Because $a$ is strictly positive and real,

$$
(Hx_{1})(n)=|x_{1}(n)|=|a|=a=1\cdot x_{1}(n)
$$

for every $n$. The input is not the zero sequence since $a>0$.

Thus **$x_{1}$ is an eigensequence with $\lambda=1$.**

**2. Test $x_{2}(n)=n$.**

The output is $(Hx_{2})(n)=|n|$. At $n=1$, the required equality would give

$$
|1|=\lambda\cdot1
\quad\Longrightarrow\quad
1=\lambda.
$$

At $n=-1$, the same equality would give

$$
|-1|=\lambda\cdot(-1)
\quad\Longrightarrow\quad
1=-\lambda
\quad\Longrightarrow\quad
\lambda=-1.
$$

One constant cannot be both $1$ and $-1$. The equality at $n=0$ is $0=\lambda\cdot0$ and cannot fix this contradiction.

Thus **$x_{2}$ is not an eigensequence.**

**3. Test $x_{3}(n)=n^{2}$.**

Since $n^{2}\ge0$ at every integer $n$,

$$
(Hx_{3})(n)=|n^{2}|=n^{2}=1\cdot x_{3}(n).
$$

At $n=0$, both sides are $0$. The whole input is nevertheless nonzero: $x_{3}(1)=1^{2}=1$.

Thus **$x_{3}$ is an eigensequence with $\lambda=1$.**

**Final answers:**

| Input | Eigensequence? | Eigenvalue |
| --- | --- | --- |
| $x_{1}(n)=a$, $a>0$ | Yes | $1$ |
| $x_{2}(n)=n$ | No | None |
| $x_{3}(n)=n^{2}$ | Yes | $1$ |

---

## MATLAB practice

The original questions below are from Michael D. Adams, *Signals and Systems*, Edition 7.0.0-beta.1, §8.8.3. The guidance and pseudocode following each question are tutorial notes, not the original question text.

**Assignment handout note (Version 2026-09-21, p.3):** The handout's bracketed topic labels for 8.202 and 8.203(b) are swapped relative to the textbook: textbook 8.202 records audio, while 8.203(b) loads and plays audio backwards. The question statements below use the textbook numbering.

The handout also requires: "Submit a wav file of you speaking your first name." A recording made with `record_audio` from 8.202 and a nonempty `output_file` can produce this file. Follow the handout and any instructor clarification for submission instructions.

## 8.202: Problem

**Original question — printed textbook pp. 397–398.**

Write a MATLAB function `record_audio` that records audio from the system microphone and optionally writes the result to a file. The function has the signature:

```matlab
function [x, samp_rate] = record_audio(samp_rate, num_channels, ...
    output_file)
```

The function parameters are defined as follows:

- `samp_rate`: the sampling rate (in Hz);
- `num_channels`: the number of channels (i.e., 1 for mono and 2 for stereo);
- `output_file`: the path of the output file, which may be an empty string (e.g., `/tmp/my_audio.wav`).

The function does the following:

(a) prints a message asking the user to press enter to start recording and then waits for the user to press enter;

(b) starts recording;

(c) prints a message asking the user to press enter to stop recording and then waits for the user to press enter;

(d) stops recording.

The audio is recorded for `num_channels` channels with the sampling rate `samp_rate` and 16 bits/sample precision. If `output_file` is not an empty string, the audio data is saved to a file whose path is specified by this variable. The meaning of the function return value is as follows:

- `x`: the audio data;
- `samp_rate`: the sampling rate (in Hz).

The following MATLAB functions may be helpful: `audiorecorder`, `record`, `stop`, `getaudiodata`, and `audiowrite`.

### 8.202: Knowledge points

- Textbook §8.8.3, pp. 397–398: recording, extracting samples and optional file output.
- An audio array stores successive samples in **rows** and channels in **columns**. Mono has one column; stereo has two.
- The sampling rate specifies how many samples per second are recorded **per channel**. Keep this rate with the audio data.

### 8.202: Core bridge formula

For $M$ samples per channel and sampling rate $F_{s}$, adjacent samples are separated by

$$
\Delta t=\frac{1}{F_{s}}\text{ seconds}.
$$

The data array has size $M\times C$, where $C$ is the number of channels. A stereo recording has twice as many stored values as a mono recording of the same duration and sampling rate, not twice the sampling rate.

### 8.202: Approach

1. Configure one recorder with the requested sampling rate, **16 bits/sample**, and requested channel count.
2. Wait for the first Enter press, then start recording. Recording must continue while the program waits for the second Enter press.
3. After the second Enter press, stop the recorder and extract the recorded samples into `x`.
4. If `output_file` is nonempty, write `x` and its sampling rate to that file. If it is empty, **skip the file write but still return the recorded data**.

The 16-bit requirement is a recording setting; it does not require converting the returned MATLAB array to an integer type. The recording step needs a working microphone and permission to access it.

### 8.202: Pseudocode

```text
FUNCTION record_audio(samp_rate, num_channels, output_file)
    CREATE a recorder using:
        sampling rate = samp_rate
        recording precision = 16 bits/sample
        channel count = num_channels

    DISPLAY "Press Enter to start recording."
    WAIT for Enter
    START recording without blocking the next steps

    DISPLAY "Press Enter to stop recording."
    WAIT for Enter while the recorder continues recording
    STOP recording

    EXTRACT the recorded sample array into x
    KEEP samp_rate equal to the recorder's configured sampling rate

    IF output_file is not empty
        WRITE x to output_file using samp_rate
    END IF

    RETURN x and samp_rate
END FUNCTION
```

---

## 8.203(b): Problem

**Original question — printed textbook p. 398.** Part (a) is included as the shared context required by part (b); it is not an additional selected assignment subpart.

**Part (a), required context:**

Write a MATLAB function to load an audio signal from a file and then play the signal. Prior to playback, the audio signal should be scaled such that its maximum magnitude is one. This normalization prevents nonlinear distortion due to clipping and may also help to make lower volume audio tracks audible. The function has the following signature:

```matlab
function play_audio_file(file)
```

The meaning of the function parameters are as follows:

- `file`: the path of the audio file to play (e.g., `audio_data/my_song.wav`).

The MATLAB functions `audioread` and `sound` are likely to be useful.

**Part (b):**

Write a function called `play_audio_file_backwards` that behaves identically to `play_audio_file` in part (a), except that the audio signal is played backwards (i.e., as if reversed in time). Use this function to play the audio in the file `reversed_speech.wav` backwards. This file contains a speech signal that has been reversed. So, by reversing it again, the original unreversed speech signal will be obtained. Identify the specific phrase spoken in the original (i.e., unreversed) audio signal.

### 8.203(b): Knowledge points

- Textbook §8.8.3, p. 398: audio loading, amplitude normalization and playback.
- Textbook §8.2.2, p. 353, and printed slides pp. 41–42: time reversal.
- A finite audio array uses MATLAB row positions $1,2,\ldots,M$. Reverse the **sample rows**, preserving the channel columns and the sampling rate read from the file.

### 8.203(b): Core bridge formulas

For an infinite DT sequence, time reversal is

$$
y(n)=x(-n).
$$

For a stored audio array with $M$ rows, reversed row $i$ comes from original row $M+1-i$:

$$
x_{\mathrm{rev}}(i,c)=x(M+1-i,c),\qquad i=1,\ldots,M.
$$

Here $c$ is the channel column. For example, with $M=4$, the source row positions are $4,3,2,1$. This reverses the stored interval; it does not require a MATLAB row numbered zero or a negative row index.

Let $P$ be the largest magnitude over **all rows and all channels**:

$$
P=\max_{i,c}|x(i,c)|.
$$

When $P>0$, normalize by

$$
x_{\mathrm{norm}}(i,c)=\frac{x(i,c)}{P}.
$$

Every channel uses the same scale factor, preserving their relative levels. If $P=0$, the file is all silence: leave the zeros unchanged rather than divide by zero. A zero signal cannot be scaled to have maximum magnitude one.

### 8.203(b): Approach

1. Read the audio data **and its sampling rate** from the file.
2. Reverse the order of the sample rows. Do not reverse the left/right channel columns.
3. Find one largest absolute value over the entire audio array. If it is nonzero, divide every sample by it; otherwise keep the silent array unchanged.
4. Play the result using the sampling rate returned by the file reader. Changing this rate would also change playback speed and pitch.
5. Test with `reversed_speech.wav` and listen to identify the phrase yourself. The phrase is not supplied in these tutorial notes.

### 8.203(b): Pseudocode

```text
FUNCTION play_audio_file_backwards(file)
    READ the audio sample array x and its sampling rate samp_rate from file
    IF the array contains no samples
        REPORT that there is no audio to play
        STOP this function
    END IF

    REVERSE the order of the rows of x
    KEEP the channel columns in their original order

    FIND P = the largest absolute sample value over all rows and columns
    IF P is greater than zero
        DIVIDE every sample by P
    ELSE
        KEEP the all-zero audio unchanged
    END IF

    PLAY the resulting sample array using samp_rate
END FUNCTION

TEST using the file reversed_speech.wav
LISTEN and identify the phrase spoken in the restored recording
```

---

**Sources:** Michael D. Adams, unified lecture slides and textbook *Signals and Systems*, Edition 7.0.0-beta.1; Assignment handout Version 2026-09-21. All slide page numbers above are printed page numbers. Convolution computation is not part of Assignment 2B and is not included in this recap.
