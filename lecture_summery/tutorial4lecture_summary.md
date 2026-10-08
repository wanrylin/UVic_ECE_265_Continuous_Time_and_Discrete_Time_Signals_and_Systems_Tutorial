# ECE265 Lecture Key Knowledge Summary 4

**Coverage:** This summary continues after [Lecture Key Knowledge Summary 3](week3lecture_summary.md). It covers the unified lecture slides from **printed p. 128, "Practical DT Convolution Computation," through printed p. 138, "Causality."** Printed p. 139, **"Invertibility," is not included.** The corresponding PDF-viewer pages are 147-157. Both the slides and textbook used here are Edition **7.0.0-beta.3**.

This is a supplementary study guide. References below use **printed** slide and textbook pages, not PDF-viewer page numbers.

**Assignment connection:** Assignment 3A practises CT/DT convolution, rewriting convolution expressions, and using linearity and time invariance to relate inputs and outputs. Its MATLAB exercise uses finite-sequence convolution. The later impulse-response and system-property topics below follow the lecture range; they do not add Assignment 3B problems to this tutorial.

Throughout, $H$ denotes a system, $x$ its input, and $y$ its output. The slides use $\xi=t\in\mathbb{R}$ for CT and $\xi=n\in\mathbb{Z}$ for DT. The symbol $\ast$ means **convolution**, not pointwise multiplication.

## 1. Practical DT convolution (slides §3.1, p. 128)

For two sequences $x$ and $h$,

$$
y(n)=(x\ast h)(n)=\sum_{k=-\infty}^{\infty}x(k)h(n-k).
$$

The slides also write $x\ast h(n)$ for $(x\ast h)(n)$: convolve first, then evaluate at $n$.

Here, $n$ is the output index. For each **fixed** $n$, $k$ is the integer index over which we sum. To obtain $h(n-k)$ as a sequence of $k$, first reverse $h(k)$ to obtain $h(-k)$, then shift the reversed sequence by $n$. The slides label this shifted sequence $h_n'(k)=h(n-k)$; the prime is a label, not a derivative.

The practical procedure is:

1. Plot $x(k)$ and $h(n-k)$ against the same $k$-axis.
2. Move the shifted sequence from left to right, taking **integer** values of $n$. Identify the ranges where the overlap or the product formula changes.
3. For each range, write the product $x(k)h(n-k)$ and the integer limits where it can be nonzero. Split the sum if the product has different formulas within that overlap.
4. Evaluate the sum on each range and combine the results into a sequence valid for every integer $n$, including boundary indices.

No overlap means a zero output value. Overlap alone does not guarantee a nonzero output: positive and negative contributions can cancel. Unlike a CT integral, a single overlapping DT sample can contribute a nonzero value.

**Textbook:** §9.2, pp. 399-410; graphical procedure on p. 400.

### Supplement: tabular computation and finite-sequence index checks

For short finite sequences, a table can replace repeated sketches. Label its columns by the actual integer index $k$, place $x(k)$ and $h(-k)$ at their correct indices, and make a row for each shifted version $h(n-k)$. Multiply aligned entries by $x(k)$ and sum to obtain that row's output value $y(n)$. Do not discard either sequence's nonzero starting index when entering its values.

If the sequences are zero outside the inclusive integer intervals

$$
A_x\le k\le B_x,\qquad A_h\le k\le B_h,
$$

then the product can be nonzero only when

$$
\max(A_x,n-B_h)\le k\le\min(B_x,n-A_h).
$$

If the lower limit exceeds the upper limit, the sum is empty and equals zero. Consequently, the output is zero outside

$$
A_x+A_h\le n\le B_x+B_h.
$$

This is a **possible nonzero range**, not a claim that every sample inside it is nonzero. For stored input intervals of lengths $L_x=B_x-A_x+1$ and $L_h=B_h-A_h+1$, the full convolution output interval has $L_x+L_h-1$ positions. Keep these output indices separate from MATLAB array positions, which start at 1.

**Textbook:** §9.2, especially Examples 9.4-9.5 and Tables 9.1-9.2, pp. 406-408; finite-support check also relates to Exercise 9.9, p. 433.

## 2. Properties of convolution (slides §3.1, p. 129)

The following properties apply in both CT and DT:

| Property | Identity | Meaning |
| --- | --- | --- |
| Commutativity | $x\ast h=h\ast x$ | Swap the two operands. |
| Associativity | $(x\ast h_1)\ast h_2=x\ast(h_1\ast h_2)$ | Change the grouping of successive convolutions. |
| Distributivity | $x\ast(h_1+h_2)=x\ast h_1+x\ast h_2$ | Split a convolution across a sum. |

Use these identities where the required convolutions and rearrangements of sums/integrals are valid. Finite-sequence convolution has no infinite-sum convergence issue.

Commutativity gives the same final signal, but the intermediate reversed-and-shifted signal changes when the operands are swapped. If a question requires computing $x\ast h$ directly without swapping the operands, follow that instruction.

**Textbook:** §4.3, Theorems 4.1-4.3, pp. 91-94; §9.3, Theorems 9.1-9.3, pp. 411-412.

## 3. The convolutional identity (slides §3.1, p. 130)

The unit impulse is the identity for convolution:

$$
x\ast\delta=\delta\ast x=x.
$$

Here, $\delta$ is the **Dirac delta function** in CT and the **Kronecker delta sequence** in DT. This is a convolution identity, not the pointwise multiplication rule $x(\xi)\delta(\xi)=x(\xi)$, which is generally false.

**Textbook:** §4.3, Theorem 4.4, p. 94; §9.3, Theorem 9.4 and its proof, pp. 412-413.

### Supplement: a shifted impulse shifts the signal

If $v(t)=\delta(t-t_0)$ in CT or $v(n)=\delta(n-n_0)$ in DT, then

$$
(x\ast v)(t)=x(t-t_0),\qquad
(x\ast v)(n)=x(n-n_0).
$$

The first formula uses a real shift $t_0$; the second uses an integer shift $n_0$. Thus a positive shift of the impulse produces the same delay of the signal.

**Textbook:** Exercises 4.4 (p. 116) and 9.5 (p. 432), together with the CT/DT delta sifting properties.

## 4. Impulse response and the LTI input-output relation (slides §3.2, pp. 131-132)

The **impulse response** is the output produced by a unit-impulse input:

$$
h=H\delta.
$$

If the system is **linear and time invariant**, its output is

$$
y=Hx=x\ast h.
$$

Therefore, knowing the impulse response characterizes an LTI system: for an allowed input, compute its convolution with $h$ to find the output. A system's response to one impulse does **not** generally characterize a nonlinear or time-varying system.

The two LTI properties have different roles: time invariance makes the response to a shifted impulse the same shift of $h$; linearity combines scaled impulse responses by addition (or integration).

### Supplement: transfer an input decomposition to the output

Suppose an LTI system maps $x_1$ to $y_1$. If a new input is a finite combination of shifted copies of $x_1$,

$$
x_2(\xi)=\sum_{r=1}^{R}a_r x_1(\xi-\xi_r),
$$

then its output is

$$
y_2(\xi)=\sum_{r=1}^{R}a_r y_1(\xi-\xi_r).
$$

Use real shifts in CT and integer shifts in DT; the coefficients $a_r$ are constants. Match the input decomposition first, then use exactly the same coefficients and shifts in the output. Do not assume that stretching the input also stretches the output: time invariance guarantees **shifts**, not time scaling.

**Textbook:** §4.5, Theorem 4.5, pp. 95-97; §9.5, Theorem 9.5, pp. 414-416. The finite-combination rule follows from the linearity and time-invariance definitions in §§3.8.5-3.8.6 and §§8.7.5-8.7.6.

## 5. Step response: derivative in CT, first difference in DT (slides §3.2, p. 133)

The **step response** is the output produced by a unit-step input:

$$
s=Hu.
$$

For an LTI system, $s=u\ast h$. The step response accumulates the impulse response, and the reverse operation recovers $h$:

| | Step response from impulse response | Impulse response from step response |
| --- | --- | --- |
| CT | $s(t)=\int_{-\infty}^{t}h(\tau)\thinspace d\tau$ | $h(t)=\dfrac{ds(t)}{dt}$ |
| DT | $s(n)=\sum_{k=-\infty}^{n}h(k)$ | $h(n)=s(n)-s(n-1)$ |

Use these formulas when the responses and integrals/sums are defined. The slides write both cases as $h=Ds$: $D$ means **differentiation** in CT and **first-order differencing** in DT. DT differencing subtracts the previous sample; it is not differentiation with respect to a continuous variable.

For CT measurements, the step response is often more practical to obtain than the impulse response because an ideal Dirac impulse cannot be generated physically.

### Supplement: jumps in a CT step response

For CT ideal signals, retain impulse terms when differentiating a step response with jumps; differentiating only its smooth pieces can miss part of $h$. With the slides' $D$, $Du=\delta$ in both CT and DT: a generalized derivative in CT, and $u(n)-u(n-1)=\delta(n)$ in DT.

**Textbook:** §4.6, Theorem 4.6, pp. 97-99; §9.6, Theorem 9.6, pp. 416-417. Unit-step/impulse relations: §3.5.12, p. 46 (CT), and §8.4.6, p. 373 (DT).

## 6. Block diagrams and interconnected LTI systems (slides §3.2, pp. 134-135)

A block labelled $h$ denotes an LTI system with **impulse response** $h$. It maps $x$ to $x\ast h$; the label does not mean pointwise multiplication by $h$.

For two compatible LTI systems, use the connection type to find the overall impulse response:

| Connection | Output | Overall impulse response |
| --- | --- | --- |
| Series / cascade | $y=(x\ast h_1)\ast h_2$ | $h=h_1\ast h_2$ |
| Parallel, outputs added | $y=x\ast h_1+x\ast h_2$ | $h=h_1+h_2$ |

Associativity gives the series rule; distributivity gives the parallel rule. Commutativity also means that swapping two such series-connected LTI blocks leaves the overall input-output relation unchanged. Do not extend this swapping rule to arbitrary nonlinear or time-varying blocks.

**Supplement - direct path:** An unchanged signal path is the identity system, whose impulse response is $\delta$. Represent it by $\delta$, not by the constant signal $1$, when combining impulse responses.

**Textbook:** §§4.7-4.8, pp. 99-101; §§9.7-9.8, pp. 417-419. Direct-path examples: Example 4.7, pp. 100-101, and Example 9.11, p. 419.

## 7. Memorylessness of an LTI system (slides §3.3, pp. 136-137)

An LTI system is **memoryless** if and only if its impulse response has the form

$$
h=K\delta,
$$

where $K$ is a constant, possibly complex or zero. Its input-output relation is then

$$
y=x\ast(K\delta)=Kx.
$$

Thus every memoryless LTI system is a constant-gain system (the slides' **ideal amplifier**): its output at a time/index uses only the input at that same time/index.

The slides also state $h(\xi)=0$ for all $\xi\ne0$; read this together with the memoryless form $h=K\delta$ above. In DT, $K=h(0)$. In CT, use $h(t)=K\delta(t)$, not an ordinary finite-height value at $t=0$.

Nonzero impulse-response values away from the origin indicate dependence on other input times/indices. A nonzero pure delay therefore has memory, even though it does not change the signal's shape. A memoryless **general** system need not be linear or time invariant; the constant-gain characterization here requires LTI.

**Textbook:** §4.9.1, Theorem 4.7, pp. 102-103; §9.9.1, Theorem 9.7, p. 420.

## 8. Causality of an LTI system (slides §3.3, p. 138)

An LTI system is **causal** if and only if its impulse response is zero at negative times/indices:

$$
h(\xi)=0\qquad\text{for all }\xi\lt0.
$$

For CT, read $\xi=t$; for DT, read $\xi=n$. The value or impulse at zero is not excluded: a causal system may use the present input.

A function/sequence $x$ satisfying $x(\xi)=0$ for all $\xi\lt0$ is called a **causal function/sequence**. Thus an LTI system is causal if and only if its impulse response $h$ is causal.

To see the connection, write DT convolution with $h$ as the first operand:

$$
y(n)=\sum_{k=-\infty}^{\infty}h(k)x(n-k).
$$

If $h(k)=0$ for $k\lt0$, only $k\ge0$ can contribute, and $n-k\le n$: the output uses only present or past input. The CT argument uses the same reasoning with an integral. A nonzero contribution at a negative impulse-response time/index would instead read future input.

The impulse-response test is a **system** test only after LTI has been established. A causal input signal alone does not establish that the system is causal. Memorylessness is stricter: a causal LTI system can have memory through its dependence on past input.

**Textbook:** §4.9.2, Theorem 4.8, p. 103; §9.9.2, Theorem 9.8, p. 421.

## Quick self-check

1. In the DT convolution formula, which index is fixed while summing? Why can one overlapping sample matter?
2. How do the starting and ending indices of two finite sequences determine the possible output range? Can a sample inside that range still be zero?
3. Which signal is the identity under convolution, and which impulse response represents an unchanged path?
4. Why is the impulse-response formula $y=x\ast h$ not a general rule for every system? Which LTI property lets you shift a known response?
5. How do you recover $h$ from $s$ in CT and DT? What must you retain at a CT jump?
6. How do series and parallel connections change the overall impulse response? How do the memoryless and causal impulse-response conditions differ?

**Sources:** Michael D. Adams, unified lecture slides, Edition 7.0.0-beta.3, printed pp. 128-138; *Signals and Systems*, Edition 7.0.0-beta.3, sections cited above. Assignment context: Assignment handout Version 2026-09-21, Assignment 3, Part A. The next slide, printed p. 139, begins "Invertibility" and is outside this summary.
