# ECE265 Lecture Key Knowledge Summary 2

**Coverage:** This summary continues immediately after [Lecture Key Knowledge Summary 1](tutorial1lecture_summary.md). It covers **§2.4 Properties of Functions**, **§2.5 Elementary Functions/Sequences**, **§2.6 Systems**, and **§2.7 Properties of Systems through Invertibility** in the *unified* lecture slides (printed pp. 51–114). It stops **before BIBO Stability**, which begins on printed p. 115.

This is a supplementary study guide based on the lecture slides and textbook. The instructor's slides, textbook, assignment sheet, and announcements remain authoritative. Section numbers in headings refer to the **slides**; textbook section numbers are identified separately.

A few results below are marked *(supplement)*. They clarify edge cases not stated explicitly on the slides; the official course materials remain authoritative.

**Assignment 2 map.** Part A also uses Summary 1 (notation, symmetry, periodic sums, and time transformations). From this summary, Part A uses §1 (causal signals), §4 (periods of sinusoidal sequences), §6 (unit-step representations and case collapsing), and §8 (delta properties). In Part B, the memoryless, causal, and invertible problems use §11; the BIBO-stability, time-invariance, linearity, and eigenfunction problems (and the MATLAB audio problems) are beyond this summary's scope.

The slides use a common symbol $\xi$ for CT time $t\in\mathbb R$ and DT index $n\in\mathbb Z$. When a statement applies to both, read $x(\xi)$ as either $x(t)$ or $x(n)$.

## 1. Where a signal can be nonzero (slides §2.4, pp. 52–54)

A signal's **support** describes where it can be nonzero. The following definitions apply to both functions and sequences.

| Property | Condition | Meaning |
| --- | --- | --- |
| Right sided | $x(\xi)=0$ for every $\xi<\xi_0$, for some finite $\xi_0$ | Potentially nonzero only from some point onward |
| Left sided | $x(\xi)=0$ for every $\xi>\xi_0$, for some finite $\xi_0$ | Potentially nonzero only up to some point |
| Finite duration | Both right sided and left sided | Nonzero values are confined to a finite interval |
| Two sided | Neither right sided nor left sided | Nonzero values extend arbitrarily far in both directions |

A **causal signal** satisfies $x(\xi)=0$ for all $\xi<0$, so it is right sided. An **anticausal signal** satisfies $x(\xi)=0$ for all $\xi>0$, so it is left sided. The value at $\xi=0$ is allowed to be nonzero in both definitions. For example, a signal that is zero for all $\xi<3$ is right sided and causal. A signal that equals $1$ for $\xi\ge-3$ and $0$ otherwise is right sided but **not** causal, because it is nonzero at $\xi=-1$.

The phrase *causal signal* describes where a signal is zero. The phrase *causal system*, introduced later, describes which input times can affect an output. Do not interchange these meanings.

**Textbook:** §§3.4.3 and 8.3.3.

## 2. Boundedness, 1-norm, energy, and differencing (slides §2.4, pp. 55–58)

### Boundedness

A signal $x$ is **bounded** if one finite constant $A>0$ works at **every** time or index:

$$
\lvert x(\xi)\rvert\le A\qquad\text{for all allowed }\xi.
$$

For example, $\sin t$ is bounded by $1$, while $x(n)=n^2$ is unbounded. It is not enough that each individual value is finite: every value of $x(n)=n^2$ is finite, yet no single $A$ bounds the whole sequence. So read the slide's parenthetical "(i.e., $x(\xi)$ is finite for all $\xi$)" as shorthand for the inequality above, not as an equivalent test.

### 1-norm and energy

| Quantity | CT function $x(t)$ | DT sequence $x(n)$ |
| --- | --- | --- |
| 1-norm | $\lVert x\rVert_1=\int_{-\infty}^{\infty}\lvert x(t)\rvert\,dt$ | $\lVert x\rVert_1=\sum_{n=-\infty}^{\infty}\lvert x(n)\rvert$ |
| Energy (square of the 2-norm) | $\lVert x\rVert_2^2=\int_{-\infty}^{\infty}\lvert x(t)\rvert^2\,dt$ | $\lVert x\rVert_2^2=\sum_{n=-\infty}^{\infty}\lvert x(n)\rvert^2$ |

A finite CT 1-norm means **absolute integrability**; a finite DT 1-norm means **absolute summability**. Finite energy means $\lVert x\rVert_2^2<\infty$. The vertical bars denote magnitude, so these definitions also work for complex-valued signals.

These tests answer different questions. For instance, a nonzero constant signal is bounded, but it has infinite 1-norm and infinite energy over the whole time axis.

### DT differencing

For a sequence, the first-order difference is

$$
(Dx)(n)=x(n)-x(n-1).
$$

It compares the present sample with the preceding sample. The same letter $D$ may denote differentiation for a CT function; decide which operation is intended from whether the input is a function or a sequence.

**Textbook:** §§2.11, 3.4.4–3.4.5, and 8.3.4–8.3.5. The unified slides introduce DT differencing here.

## 3. Floor and ceiling (slides §2.5, pp. 60–61)

The **floor** $\lfloor x\rfloor$ is the greatest integer at most $x$; the **ceiling** $\lceil x\rceil$ is the least integer at least $x$. For example,

$$
\lfloor -0.5\rfloor=-1,\qquad \lceil -0.5\rceil=0,\qquad
\lfloor 0.5\rfloor=0,\qquad \lceil 0.5\rceil=1.
$$

Useful identities are

$$
\lfloor x+k\rfloor=\lfloor x\rfloor+k,\qquad
\lceil x+k\rceil=\lceil x\rceil+k,\qquad
\lceil x\rceil=-\lfloor -x\rfloor,
$$

where $k\in\mathbb Z$. For integers $m$ and $q>0$, $\lceil m/q\rceil=\lfloor(m+q-1)/q\rfloor$. With negative numbers, floor means rounding **toward negative infinity**, not truncating toward zero.

**Textbook:** §3.5.11. The textbook puts these functions later in its CT chapter.

## 4. Sinusoids: CT versus DT (slides §2.5, pp. 62–74)

### Real and complex forms

| | Continuous time | Discrete time |
| --- | --- | --- |
| Real sinusoid | $x(t)=A\cos(\omega t+\theta)$ | $x(n)=A\cos(\omega n+\theta)$ |
| Complex sinusoid | $x(t)=A e^{j\omega t}$ | $x(n)=c e^{j\omega n}$ |

In the real forms, $A,\omega,\theta$ are real; in the complex forms, $\omega$ is real while $A$ and $c$ may be complex. If $A=\lvert A\rvert e^{j\theta}$, then

$$
A e^{j\omega t}=\lvert A\rvert\cos(\omega t+\theta)
+j\lvert A\rvert\sin(\omega t+\theta).
$$

The same identity holds with $n$ replacing $t$. The real and imaginary parts of a complex sinusoid are ordinary real sinusoids.

### Period and frequency

For a nonconstant CT sinusoid with $\omega\ne0$, the fundamental period is $T_0=2\pi/\lvert\omega\rvert$. Its **angular frequency** is $\lvert\omega\rvert$ radians per unit time, while its ordinary frequency is $1/T_0=\lvert\omega\rvert/(2\pi)$ cycles per unit time.

*(Supplement)* When $\omega=0$ (or the amplitude is zero), the signal is constant and has no smallest positive real period.

**Terminology.** The slides (pp. 62 and 67) call $\lvert\omega\rvert$ itself the **fundamental frequency**, and later chapters write the fundamental frequency as $\omega_0$. In this course, "frequency" often means angular frequency; the units (radians versus cycles per unit time) tell you which is meant.

A DT sinusoid (real or complex, with nonzero amplitude) is periodic **if and only if** its normalized angular frequency $\omega/(2\pi)$ is rational. In that case, write the ratio in **lowest terms**:

$$
\frac{\omega}{2\pi}=\frac{p}{q},\qquad p,q\in\mathbb Z,\quad q>0,
\quad p\text{ and }q\text{ are coprime}.
$$

For a nonzero complex sinusoid or a nondegenerate real sinusoid, the fundamental period is $N=q$. Two habits prevent most mistakes: **reduce the fraction first**, and let $p$ be **negative** when $\omega<0$. For example, $x(n)=\cos(\pi n/6)$ has $\omega/(2\pi)=1/12$, so $N=12$. For $x(n)=\sin(-6\pi n/16)$, $\omega/(2\pi)=-6/32=-3/16$ in lowest terms, so $N=16$, not $32$.

*(Supplement)* One degenerate real case breaks the rule $N=q$: when $q=2$ and $\cos\theta=0$, every sample is zero. For instance, $\sin(\pi n)=0$ for every integer $n$, so its fundamental period is $1$, not $2$. The zero sequence ($A=0$ or $c=0$) is likewise trivially periodic with fundamental period $1$.

DT frequencies are equivalent modulo $2\pi$, because $e^{j(\omega+2\pi k)n}=e^{j\omega n}$ for every integer $n$ and $k$. A real cosine obeys the same frequency equivalence. Unlike CT sinusoids, DT sinusoids cannot oscillate arbitrarily fast. Over $0\le\omega<2\pi$, the oscillation rate increases as $\omega$ goes from $0$ to $\pi$ (fastest at $\omega=\pi$) and decreases as $\omega$ goes from $\pi$ to $2\pi$.

**Textbook:** §§3.5.1–3.5.3 and 8.4.1–8.4.3. The textbook treats CT and DT in separate chapters.

## 5. Real and complex exponentials (slides §2.5, pp. 75–86)

### Continuous time

A real exponential has the form $x(t)=A e^{\lambda t}$ with real $A,\lambda$. For $A\ne0$, its magnitude grows as $t$ increases when $\lambda>0$, decays when $\lambda<0$, and stays constant when $\lambda=0$. It also satisfies the differential equation $x'(t)=\lambda x(t)$.

For a general complex exponential, let $A=\lvert A\rvert e^{j\theta}$ and $\lambda=\sigma+j\omega$. Then

$$
x(t)=A e^{\lambda t}=\lvert A\rvert e^{\sigma t}
\bigl[\cos(\omega t+\theta)+j\sin(\omega t+\theta)\bigr].
$$

The factor $e^{\sigma t}$ is the envelope: $\sigma>0$ gives growth, $\sigma<0$ decay, and $\sigma=0$ a complex sinusoid. A useful reason these signals recur in systems theory is that shifting them scales them: $x(t-b)=e^{-\lambda b}x(t)$.

### Discrete time

A real exponential sequence has the form $x(n)=c a^n$ with real $c,a$. *(Supplement: for $x(n)$ to be defined at negative $n$ as well, take $a\ne0$.)* For $c\ne0$, its magnitude grows as $n$ increases if $\lvert a\rvert>1$, decays if $0<\lvert a\rvert<1$, and stays constant if $\lvert a\rvert=1$. A negative $a$ makes successive nonzero terms alternate in sign. The sequence satisfies $x(n)=a\,x(n-1)$.

For complex $c$ and nonzero complex $a=\lvert a\rvert e^{j\omega}$, with $c=\lvert c\rvert e^{j\theta}$,

$$
x(n)=c a^n=\lvert c\rvert\lvert a\rvert^n
\bigl[\cos(\omega n+\theta)+j\sin(\omega n+\theta)\bigr].
$$

Thus $\lvert a\rvert$ controls the envelope and $\omega$ controls the oscillation. When $\lvert a\rvert=1$, this becomes a complex sinusoid. A one-sample shift again scales the sequence: $x(n-1)=a^{-1}x(n)$.

**Textbook:** §§3.5.2 and 8.4.2.

## 6. Steps, indicators, and rectangular pulses (slides §2.5, pp. 87–94)

The CT and DT **unit steps** use the same rule but different domains:

$$
u(\xi)=\begin{cases}1,&\xi\ge0,\\0,&\xi<0.\end{cases}
$$

In particular, $u(0)=1$. The CT **signum** function satisfies $\mathrm{sgn}(t)=1$ for $t>0$, $0$ for $t=0$, and $-1$ for $t<0$. The slides' **rectangular function** uses the half-open interval convention:

$$
\mathrm{rect}(t)=\begin{cases}1,&-\tfrac12\le t<\tfrac12,\\0,&\text{otherwise}.\end{cases}
$$

For a subset $S$ of the signal's domain, the **indicator** $\chi_S(\xi)$ equals $1$ when $\xi\in S$ and $0$ otherwise. It is a convenient on/off switch. A unit rectangular pulse from $a$ to $b$, with $a<b$, is

$$
\chi_{[a,b)}(t)=u(t-a)-u(t-b)\qquad\text{(CT)},
$$

or, for integers $a<b$,

$$
\chi_{[a..b)}(n)=u(n-a)-u(n-b)\qquad\text{(DT)}.
$$

The left endpoint is included and the right endpoint excluded. In DT, the nonzero sample indices are $a,a+1,\ldots,b-1$.

The step itself is the indicator of a half-infinite interval: $u=\chi_{[0,\infty)}$ in CT and $u=\chi_{[0..\infty)}$ in DT; likewise $\mathrm{rect}=\chi_{[-1/2,1/2)}$. More generally,

$$
\chi_{[a,\infty)}(t)=u(t-a),\qquad \chi_{(-\infty,b)}(t)=1-u(t-b)\qquad\text{(CT)},
$$

$$
\chi_{[a..\infty)}(n)=u(n-a),\qquad \chi_{(-\infty..b)}(n)=1-u(n-b)\qquad\text{(DT)}.
$$

*(Supplement)* **Endpoint trap.** Because $u(0)=1$, the reflected step $u(b-\xi)$ equals $1$ at $\xi=b$, so it is the indicator of $(-\infty,b]$, not $(-\infty,b)$. In DT this is a whole extra sample: $u(b-n)$ is nonzero for $n\le b$, whereas $1-u(n-b)$ is nonzero only for $n\le b-1$.

To turn a piecewise signal into a single expression, multiply each case formula by the indicator for the interval where that case applies, and add the terms. For example,

$$
x(t)=\begin{cases}t,&0\le t<2,\\3,&2\le t<4,\\0,&\text{otherwise}\end{cases}
=t\,[u(t)-u(t-2)]+3\,[u(t-2)-u(t-4)].
$$

The same method works for DT sequences after using integer endpoints. If a case covers a half-infinite interval (for example, an "otherwise" region that extends to $-\infty$), use the half-infinite indicators above. Check boundaries explicitly when translating a graph or a piecewise definition into steps.

**Textbook:** §§3.5.4–3.5.7, 3.6, 8.4.4–8.4.5, and 8.5.

## 7. Sinc and aliased sinc (slides §2.5, pp. 95–96)

This course defines the **cardinal sine** as

$$
\mathrm{sinc}(t)=\begin{cases}\dfrac{\sin t}{t},&t\ne0,\\1,&t=0.\end{cases}
$$

The value at zero fills in the limit.

*(Supplement)* Be alert to notation: MATLAB's `sinc` uses $\sin(\pi t)/(\pi t)$, which has a different scaling from this course's definition.

For a positive integer $N$, the slides define the **aliased sinc** by

$$
\mathrm{asinc}_N(t)=
\begin{cases}
\dfrac{\sin(Nt/2)}{N\sin(t/2)},&t/(2\pi)\notin\mathbb Z,\\
(-1)^{(N-1)k},&t/(2\pi)=k\in\mathbb Z.
\end{cases}
$$

The second line supplies the continuous limit at points where the first line gives $0/0$. In particular, $\mathrm{asinc}_N(0)=1$. This function appears later in the DT Fourier transform of a length-$N$ rectangular pulse; for now, recognize its definition and removable singularities.

**Textbook:** §§3.5.9–3.5.10.

## 8. CT and DT impulses (slides §2.5, pp. 97–101)

The CT **Dirac delta** $\delta(t)$ is a *generalized function*, not an ordinary function with a finite value at $t=0$. It is zero away from $0$ and has unit area. It can be pictured as a rectangular pulse whose width shrinks while its area remains $1$. Its most useful rules are

$$
x(t)\delta(t-t_0)=x(t_0)\delta(t-t_0),\qquad
\int_{-\infty}^{\infty}x(t)\delta(t-t_0)\,dt=x(t_0),
$$

for a suitable continuous $x$. Also $\delta(a t)=\delta(t)/\lvert a\rvert$ for nonzero real $a$, and $\delta(-t)=\delta(t)$. The **label** on an impulse arrow gives its weight (area); the arrow does not show a finite value at $t=0$.

The DT **Kronecker delta sequence** is an ordinary sequence:

$$
\delta(n)=\begin{cases}1,&n=0,\\0,&n\ne0.\end{cases}
$$

Its equivalence and sifting rules are

$$
x(n)\delta(n-n_0)=x(n_0)\delta(n-n_0),\qquad
\sum_{n=-\infty}^{\infty}x(n)\delta(n-n_0)=x(n_0).
$$

The Kronecker delta is also even. Note that the slides state the scaling rule $\delta(at)=\delta(t)/\lvert a\rvert$ **only for the CT delta**; do not carry the factor $1/\lvert a\rvert$ over to sequences. For an integer-valued argument such as $2n-4$, evaluate the Kronecker delta directly: it equals $1$ exactly when the argument is $0$, and $0$ otherwise.

The DT step and impulse are connected by $\delta(n)=u(n)-u(n-1)$ and $u(n)=\sum_{k=-\infty}^{n}\delta(k)$. Both CT and DT use the symbol $\delta$, so check whether the independent variable is real time or an integer index before applying a rule.

**Textbook:** §§3.5.12 and 8.4.6.

## 9. Decibels (slides §2.5, pp. 102–103)

The decibel scale compresses a wide range of positive magnitudes. For a positive magnitude $m$, the slides use

$$
d=20\log_{10}m=10\log_{10}(m^2).
$$

Thus a magnitude of $1$ is $0$ dB, a magnitude of $10$ is $20$ dB, and, by convention, magnitude $0$ corresponds to $-\infty$ dB. If the given quantity is already a **power** $P>0$, use $d_P=10\log_{10}P$ instead. Decide whether the question gives a magnitude or a power before choosing the factor $20$ or $10$.

**Textbook:** §2.12.

## 10. Systems and connections (slides §2.6, pp. 104–107)

A system operator $H$ maps an entire input signal $x$ to an entire output signal $y$:

$$
y=Hx,\qquad y(\xi)=(Hx)(\xi).
$$

Do not confuse $Hx$, an output **signal**, with $(Hx)(\xi)$, one **value** of that signal. The slides focus on single-input, single-output systems.

| Connection | Signal path | Output |
| --- | --- | --- |
| Cascade (series) | $x\to H_1\to H_2\to y$ | $y=H_2(H_1x)=H_2H_1x$ |
| Parallel | $x$ enters both $H_1$ and $H_2$; outputs are added | $y=H_1x+H_2x$ |

In a cascade, the **rightmost operator acts first**. In a parallel connection, addition is between the two resulting output signals.

**Textbook:** §§3.7 and 8.6.

## 11. Memory, causality, and invertibility (slides §2.7, pp. 108–114)

### Memory

A system is **memoryless** if, for every time or index $\xi_0$, its output $(Hx)(\xi_0)$ can depend on the input only at $\xi_0$. If it uses any input value at another time, it **has memory**.

For example, $(Hx)(n)=x^2(n)$ is memoryless, whereas $(Gx)(n)=x(n-1)$ has memory. A formula that depends explicitly on $n$ can still be memoryless: $(Fx)(n)=n x(n)$ uses only the current input sample.

### Causality

A system is **causal** if, for every $\xi_0$, its output at $\xi_0$ depends only on input values at $\xi\le\xi_0$. Past and present are allowed; future input values are not. Therefore every memoryless system is causal, but a causal system may have memory.

For example, $y(n)=x(n-1)$ has memory but is causal, while $y(n)=x(n+1)$ is noncausal. To disprove causality, find just one time where the output requires a later input. This is a property of the **system rule for all allowed inputs**, not a property of a particular input signal. If the index really represents time and output must be produced immediately, causality is necessary for real-time operation.

### Invertibility

A system $H$ is **invertible** if an inverse $H^{-1}$ recovers every allowed input from its output:

$$
H^{-1}(Hx)=x\qquad\text{for every allowed input }x.
$$

Equivalently, two distinct allowed inputs must never produce the same output. To prove invertibility, construct the inverse; to disprove it, exhibit two distinct inputs with identical outputs.

For bilateral sequences, $y(n)=x(n-1)$ is invertible because $x(n)=y(n+1)$. By contrast, the memoryless system $y(n)=x^2(n)$ is not invertible when the allowed inputs include both constant sequences $x_1(n)=1$ and $x_2(n)=-1$: these distinct inputs produce the same output $y(n)=1$. Always consider the stated set of allowed inputs: if only nonnegative inputs were allowed, $x(n)=\sqrt{y(n)}$ would recover the input.

**Textbook:** §§3.8.1–3.8.3 and 8.7.1–8.7.3. **BIBO Stability begins on the next slide and is not covered here.**

## Quick self-check

1. Can a signal be right sided without being causal? Give an example.
2. Why is $x(n)=n^2$ unbounded even though every $x(n)$ is finite?
3. What is the difference between the 1-norm and energy in CT and DT?
4. Is $\cos(\pi n/6)$ periodic? What is its fundamental period? What happens if $\omega/(2\pi)$ is irrational?
5. What do $\sigma$ in $e^{(\sigma+j\omega)t}$ and $\lvert a\rvert$ in $a^n$ tell you?
6. Which sample indices are nonzero in $u(n-2)-u(n-5)$?
7. When using $\delta(t-t_0)$ or $\delta(n-n_0)$, which single value of $x$ remains?
8. For $y(n)=x(-n)$, decide separately whether the system is memoryless, causal, and invertible.

**Sources:** Michael D. Adams, *Lecture Slides for Signals and Systems: Unified Continuous-Time/Discrete-Time Coverage*, Edition 7.0.0-beta.1, printed pp. 51–114 (§§2.4–2.7 through Invertibility); and *Signals and Systems*, Edition 7.0.0-beta.1, the textbook sections cited above. The next slide, printed p. 115, starts BIBO Stability and is outside this summary.
