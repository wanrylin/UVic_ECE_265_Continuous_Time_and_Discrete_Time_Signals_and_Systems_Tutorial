# ECE265 Lecture Key Knowledge Summary 3

**Coverage:** This summary continues immediately after [Lecture Key Knowledge Summary 2](week2lecture_summary.md). It covers the *unified* lecture slides from **printed p. 115, “Bounded-Input Bounded-Output (BIBO) Stability,” through printed p. 127, “Practical CT Convolution Computation.”** Printed p. 128, **“Practical DT Convolution Computation,” is not included.** The corresponding PDF-viewer pages are 134–146.

This is a supplementary study guide, not a replacement for the instructor's slides, textbook, assignment sheet, or announcements. Slide page numbers below are the **printed** numbers. The slide deck and textbook used here are both Edition **7.0.0-beta.1**.

**Where Assignment 2B fits:** Memory, causality, and invertibility were covered in §11 of [Summary 2](week2lecture_summary.md). This summary covers its BIBO-stability, time-invariance, linearity, and eigenfunction/eigensequence concepts. The LTI and convolution slides at the end introduce the next topic; Assignment 2B does **not** ask for convolution computation.

The slides use a common variable $\xi$: read $\xi=t\in\mathbb{R}$ for CT functions and $\xi=n\in\mathbb{Z}$ for DT sequences. In this summary, $Hx$ means the **whole output signal**, while $(Hx)(\xi)$ is its value at one time or index.

## 1. BIBO stability (slides §2.7, p. 115)

A system $H$ is **bounded-input bounded-output (BIBO) stable** if **every** bounded input $x$ produces a bounded output $Hx$. “Bounded” means one finite bound works at every time or index:

$$
\bigl[\exists B_x<\infty:\ |x(\xi)|\le B_x\ \text{for all }\xi\bigr]
\quad\Longrightarrow\quad
\bigl[\exists B_y<\infty:\ |(Hx)(\xi)|\le B_y\ \text{for all }\xi\bigr].
$$

The output bound $B_y$ may depend on the chosen input, but it **cannot depend on $\xi$**. As in Summary 2, merely knowing that each individual value is finite does **not** establish boundedness.

*Source wording note:* Read the pointwise-finiteness notation on slide p. 115 and in textbook §§3.8.4 and 8.7.4 as shorthand for the uniform bounds above, not as an equivalent test of boundedness.

- **To prove stability:** start with an arbitrary bounded input, use $|x(\xi)|\le B_x$, and find a finite bound on the output that works for all $\xi$. The triangle inequality can help with sums and integrals.
- **To disprove stability:** find **one** bounded input whose output is unbounded. A calculation for one well-behaved input cannot prove stability.

This property asks about the system's behavior for all allowed bounded inputs. It is not the same as asking whether one particular signal is bounded.

**Textbook:** §§3.8.4 (CT) and 8.7.4 (DT).

## 2. Time invariance (slides §2.7, pp. 116–117)

Let $S_{\xi_0}$ shift a signal by $\xi_0$:

$$
(S_{\xi_0}x)(\xi)=x(\xi-\xi_0),
$$

where $\xi_0$ may be any real number in CT and any integer in DT. A positive $\xi_0$ is a delay. A system is **time invariant (TI)** if shifting the input before applying the system always gives the same result as shifting the system's output:

$$
H(S_{\xi_0}x)=S_{\xi_0}(Hx)
\qquad\text{for every allowed }x\text{ and every allowed }\xi_0.
$$

In other words, $H$ and the shift operator **commute**. To test a proposed system rule, keep the two routes separate:

1. Let $v=S_{\xi_0}x$, so $v(\xi)=x(\xi-\xi_0)$. Compute $Hv$ by using $v$ wherever the system rule uses $x$, keeping the rule's own arguments and explicit time/index unchanged. Then rewrite each $v(\cdot)$ in terms of $x$; this gives $\lbrack H(S_{\xi_0}x)\rbrack(\xi)$. Do **not** replace $\xi$ by $\xi-\xi_0$ throughout the system rule in this route.
2. Apply $H$ to the original $x$, then replace the output's argument $\xi$ by $\xi-\xi_0$; this gives $\lbrack S_{\xi_0}(Hx)\rbrack(\xi)$.
3. Compare for **all** inputs and shifts. One counterexample is enough to establish that the system is time varying.

Do not shift only one occurrence of the time variable inside a system formula: the entire output signal is shifted in the second route. An explicit $t$ or $n$ in a formula may be a clue, but the two-route test is the definition.

**Textbook:** §§3.8.5 (CT) and 8.7.5 (DT).

## 3. Additivity, homogeneity, and linearity (slides §2.7, pp. 118–120)

For all allowed inputs $x_1,x_2$ and scalars $a,a_1,a_2$:

| Property | Required identity |
| --- | --- |
| **Additivity** | $H(x_1+x_2)=Hx_1+Hx_2$ |
| **Homogeneity** | $H(ax)=aHx$ |
| **Linearity / superposition** | $H(a_1x_1+a_2x_2)=a_1Hx_1+a_2Hx_2$ |

A system is **linear** if and only if it is both additive and homogeneous. For the complex-valued signal spaces used in the textbook, homogeneity must also hold for **complex** scalars, not just real ones. To prove linearity, establish the identity for arbitrary allowed inputs and scalars. To disprove it, show one failure of additivity or homogeneity.

*Supplement — quick necessary check:* Every linear system sends the zero input to the zero output, because $H0=H(0x)=0Hx=0$. If $H0\ne0$, the system is nonlinear. The converse is **not** valid: $H0=0$ alone does not prove linearity.

Linearity and time invariance are separate questions. A system can satisfy one without satisfying the other; test each property by its own definition.

**Textbook:** §§3.8.6 (CT) and 8.7.6 (DT).

## 4. Eigenfunctions and eigensequences (slides §2.7, p. 121)

A **nonzero** CT function or DT sequence $x$ is an eigenfunction or eigensequence of $H$ if there is a **single scalar** $\lambda$ such that

$$
Hx=\lambda x
\qquad\text{at every time or index.}
$$

The scalar $\lambda$ is the corresponding **eigenvalue**. It may be zero; it **must not** depend on $t$ or $n$. The zero input is excluded by definition: for a system with $H0=0$, it would satisfy $H0=\lambda 0$ for every $\lambda$ and would not identify a particular eigenvalue.

To check a proposed $x$, compute $Hx$ and ask whether the **entire output signal** is a constant multiple of $x$. At a point where $x(\xi)=0$, the condition also requires $(Hx)(\xi)=0$; avoid dividing by $x(\xi)$ there. A ratio $(Hx)(\xi)/x(\xi)$ that changes with $\xi$ rules out the eigenfunction/eigensequence property.

The definition applies to a **general** system; it does not by itself say that every complex exponential is an eigenfunction of every system. Each candidate input must be checked for the specified $H$.

**Textbook:** §§3.8.7 (CT) and 8.7.7 (DT).

## 5. From general systems to LTI systems (slides Part 3 and §3.1 introduction, pp. 122–125)

An **LTI system** is both **linear** and **time invariant**. These two properties make a particularly useful class of systems, and the lectures next use **convolution** to characterize their input–output behavior. Being LTI does **not** by itself assert that a system is causal, memoryless, invertible, or BIBO stable; these remain separate properties.

How convolution characterizes LTI systems is developed later. At this point, the slides introduce the operation and its computation.

**Textbook:** §§4.1 (CT) and 9.1 (DT) for the LTI introduction; §§4.2 and 9.2 introduce convolution. The full LTI characterization is developed later in §§4.5 and 9.5.

## 6. The CT and DT convolution definitions (slides §3.1, p. 126)

For CT functions $x,h$, convolution produces another function:

$$
(x*h)(t)=\int_{-\infty}^{\infty}x(\tau)h(t-\tau)\thinspace d\tau.
$$

For DT sequences $x,h$, convolution produces another sequence:

$$
(x*h)(n)=\sum_{k=-\infty}^{\infty}x(k)h(n-k).
$$

The CT operation **integrates** and the DT operation **sums**. In each formula, $t$ or $n$ is the output time/index, while $\tau$ or $k$ is a dummy variable used to accumulate contributions. The slide's compact $x\ast h(t)$ means $(x\ast h)(t)$; the star is **convolution, not pointwise multiplication**.

In both CT and DT, convolution multiplies the first signal by a **time-reversed and time-shifted** version of the second signal, then accumulates the products by integration or summation.

*Supplement — domain note:* As with any improper integral or infinite sum, use the definition where the expression is well defined for the signals under consideration. Do not assume an arbitrary pair of signals has an ordinary finite convolution at every time/index.

**Textbook:** §§4.2 (CT) and 9.2 (DT). Practical **DT** convolution computation is on the excluded next slide, p. 128.

## 7. Practical CT convolution: reverse, shift, overlap, integrate (slides §3.1, p. 127)

For a **fixed** output time $t$, the integrand is a function of $\tau$:

$$
(x*h)(t)=\int_{-\infty}^{\infty}x(\tau)h(t-\tau)\thinspace d\tau.
$$

To understand $h(t-\tau)$, define the reversed function $g(\tau)=h(-\tau)$. Then

$$
h(t-\tau)=g(\tau-t).
$$

Thus, **reverse $h$ first**, then **shift the reversed function by $t$** along the $\tau$-axis (to the right when $t>0$). The integrand can be nonzero only where **both** $x(\tau)$ and $h(t-\tau)$ are nonzero.

*Source notation note:* On slide p. 127, $h'_t(\tau)$ labels $h(t-\tau)$, not a derivative. The extra prime in the subsequent expression $h'[-(\tau-t)]$ appears to be a typo; use $h[-(\tau-t)]=h(t-\tau)$.

1. Plot $x(\tau)$ and $h(t-\tau)$ against the **same** $\tau$-axis.
2. Begin with $t$ far to the left and move it toward the right. Identify the values of $t$ at which the overlap, integrand, or integration limits change form.
3. On each resulting interval of $t$, split the nonzero product $x(\tau)h(t-\tau)$ into any necessary $\tau$-intervals, write each integral with its correct limits, and add their values.
4. Combine the interval results into one piecewise expression valid for all $t$, checking the boundary points.

The lecture slide compresses this into six graphical steps; the textbook explicitly separates **writing the integrand**, **integrating on each interval**, and **combining the cases**. Both descriptions use the same computation. Do not replace the CT integral by a DT sum here; the practical DT procedure starts on p. 128.

**Textbook:** §4.2, especially the procedure immediately before Example 4.1.

## Quick self-check

1. Why is “$|x(\xi)|$ is finite at each individual $\xi$” insufficient to prove that $x$ is bounded? What type of output bound proves BIBO stability?
2. In a time-invariance test, what is the difference between $H(S_{\xi_0}x)$ and $S_{\xi_0}(Hx)$?
3. Why does $H0=0$ fail to prove linearity, even though $H0\ne0$ proves nonlinearity?
4. Can the eigenvalue $\lambda$ be zero? Must an eigenfunction/eigensequence be nonzero?
5. What is reversed and shifted in $(x*h)(t)$, and what determines where its integrand **can** be nonzero?

**Sources:** Michael D. Adams, *Lecture Slides for Signals and Systems: Unified Continuous-Time/Discrete-Time Coverage*, Edition 7.0.0-beta.1, printed pp. 115–127; and *Signals and Systems*, Edition 7.0.0-beta.1, textbook sections cited above. The next slide, printed p. 128, begins “Practical DT Convolution Computation” and is outside this summary.
