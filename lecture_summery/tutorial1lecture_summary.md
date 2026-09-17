# ECE265 Lecture Key Knowledge Summary 1

**Coverage:** After the Complex Analysis review, through the end of **§2.3 Independent-Variable Transformations** in the *unified* lecture slides. This includes the short Introduction (Part 1) and §§2.1–2.3; it **stops before §2.4 Properties of Functions**.

This is a supplementary study guide, not a replacement for the instructor's slides, textbook, or course announcements. Section numbers below refer to the **lecture slides** unless explicitly labelled "textbook." The textbook organizes some of these topics under different section numbers.

A few results below are marked *(supplement)*. They clarify edge cases not stated explicitly on the slides; the official course materials remain authoritative.

## 1. The big picture: signals and systems (slides Part 1)

A **signal** is a physical quantity or other information that varies with respect to **one or more** independent variables, such as time or space. A signal is **continuous-time (CT)** if its independent variables are continuous (e.g., real valued), and **discrete-time (DT)** if they are discrete (e.g., integer valued). Note "one or more": a digital image is a DT signal with two independent variables.

| Type | Typical notation | Independent variable | Example |
| --- | --- | --- | --- |
| Continuous-time (CT) signal | $x(t)$ | $t\in\mathbb{R}$ | Voltage in a circuit versus time |
| Discrete-time (DT) signal | $x(n)$ | $n\in\mathbb{Z}$ | A digital audio sample sequence |

A **system** is an entity that processes one or more input signals to produce one or more output signals. A system $H$ with $M$ inputs and $N$ outputs is **single input (SI)** if $M=1$ and **multi input (MI)** if $M\ge 2$; likewise **single output (SO)** if $N=1$ and **multi output (MO)** if $N\ge 2$. If its inputs and outputs are CT signals, $H$ is a **CT system**; if they are DT signals, a **DT system**.

For a single-input, single-output system, write $y=Hx$: $x$ is the **whole input signal**, $H$ is the system operator, and $y$ is the **whole output signal**.

We study signals and systems for four reasons: **representation** (describe physical quantities mathematically), **modeling** (describe how a device transforms inputs into outputs), **analysis** (predict the response before building anything), and **design** (modify a system so it meets specifications). The Tacoma Narrows and Millennium Bridge examples on the slides show what the analysis step is for.

**Textbook:** Chapter 1, especially §§1.2–1.4.

## 2. Sets, mappings, and notation (slides §2.1)

### Sets you will see often

| Symbol | Meaning |
| --- | --- |
| $\mathbb{Z}$ | Integers |
| $\mathbb{Q}$ | Rational numbers (ratios of integers with nonzero denominator) |
| $\mathbb{R}$ | Real numbers |
| $\mathbb{C}$ | Complex numbers |

Be careful about the notation for an **integer range** versus a **real interval**:

The course writes `[0 .. 4)` for the **integers** $\{0,1,2,3\}$, but $[0,4)$ denotes **every real number** $t$ with $0\le t<4$. In both notations, square brackets include an endpoint and parentheses exclude it. A useful integer-range shorthand is `[0 .. N)` $=$ `[0 .. N-1]` $=\{0,1,\ldots,N-1\}$.

A **mapping** $f:A\to B$ associates each element of the **domain** $A$ with an element of the **codomain** $B$. The codomain may contain values that are never reached by $f$.

### What is being mapped?

This table follows the "Mappings: Summary" slide.

| Mapping type | Domain elements | Codomain elements | Used to represent |
| --- | --- | --- | --- |
| Function | Numbers | Numbers | CT signals |
| Sequence | Numbers (an integer index $n$) | Numbers | DT signals |
| Operator | Functions or sequences | Functions, sequences, or numbers | Operations on signals |
| System operator | Functions or sequences | Functions or sequences | Systems |
| Transform | Functions or sequences | Functions or sequences | An alternate signal representation |

In the **unified slides**, a function is introduced broadly as a mapping between numerical sets (including tuples of numbers), so it may have a continuous domain ($f:\mathbb{R}\to\mathbb{R}$) or a discrete domain ($f:\mathbb{Z}\to\mathbb{R}$). A DT function is called a **sequence**. For the rest of the slides, **"function" alone means CT function** unless "DT" is stated explicitly. The textbook uses a narrower convention: §2.4 calls mappings with continuous domains functions, while §2.5 calls those with discrete domains sequences.

A **transform** is an operator that converts one representation into another. For example, the CT Fourier series maps $T$-periodic functions to sequences of coefficients, the DT Fourier transform maps sequences to $2\pi$-periodic functions, and the Laplace and $Z$ transforms map to functions with domain $\mathbb{C}$. You do not need the transform formulas yet.

### A whole signal is not one signal value

If $x$ is a signal, $x(t)$ is just its value at time $t$. Likewise, $Hx$ is a whole output signal, whereas $(Hx)(t)$ is one value of that output. This matters whenever an operation acts on an entire signal rather than one number.

**Notation note.** The slides often omit parentheses around an operator's input: $S_bx(\xi)=x(\xi-b)$ denotes the value $(S_bx)(\xi)$, and $Dx$ means $D(x)$. Either form is fine when the grouping is clear; add parentheses whenever they prevent ambiguity. Textbook §2.6 discusses related function-versus-value notation.

For cascaded operators, operators group right to left, so the **rightmost acts first**:

$$
H_3H_2H_1x=H_3\bigl(H_2(H_1x)\bigr).
$$

Read the signal path as $x\longrightarrow H_1\longrightarrow H_2\longrightarrow H_3$.

**Textbook:** §§2.2–2.9.

## 3. Symmetry (slides §2.2)

The definitions below work for either CT or DT signals: use $\xi=t\in\mathbb{R}$ for CT and $\xi=n\in\mathbb{Z}$ for DT. Each equality must hold for **every** allowed value of $\xi$.

| Property | Test | Geometric meaning |
| --- | --- | --- |
| Even | $x(\xi)=x(-\xi)$ | Graph symmetric about the vertical axis |
| Odd | $x(\xi)=-x(-\xi)$ | Graph symmetric about the origin |
| Conjugate symmetric | $x(\xi)=x^*(-\xi)$ | Magnitude and real part even; argument and imaginary part odd |

An odd function/sequence satisfies $x(0)=0$. A complex sinusoid $x(t)=\cos(\omega t)+j\sin(\omega t)=e^{j\omega t}$, with $\omega$ a real constant, is conjugate symmetric.

*(Supplement)* A real-valued signal is conjugate symmetric exactly when it is even, and the $x(0)=0$ statement applies whenever $0$ lies in the domain.

### Combining even and odd signals

| Operation | Result |
| --- | --- |
| even + even | even |
| odd + odd | odd |
| even + odd | neither even nor odd, provided neither term is **identically** zero |
| even $\times$ even | even |
| odd $\times$ odd | even |
| even $\times$ odd | odd |

In words: the sum of two signals with the same symmetry keeps that symmetry; the product of two signals with the same symmetry is even, and the product of two with opposite symmetry is odd. In the "even + odd" row, "identically zero" means the signal is zero **everywhere**, not merely zero at some points.

Every signal has a **unique** decomposition into its **even** and **odd** parts:

$$
x(\xi)=x_{\mathrm e}(\xi)+x_{\mathrm o}(\xi),
\qquad
x_{\mathrm e}(\xi)=\tfrac{1}{2}\bigl[x(\xi)+x(-\xi)\bigr],
\qquad
x_{\mathrm o}(\xi)=\tfrac{1}{2}\bigl[x(\xi)-x(-\xi)\bigr].
$$

These are often written $\operatorname{Even}\{x\}$ and $\operatorname{Odd}\{x\}$.

Quick check: if $x(t)=t+2$, then $x_{\mathrm e}(t)=2$ and $x_{\mathrm o}(t)=t$. The same formulas work for sequences after replacing $t$ by $n$.

**Textbook:** §§2.10.1, 3.4.1, and 8.3.1.

## 4. Periodicity (slides §2.2)

A CT signal is periodic with period $T$ ($T$-periodic), for some strictly positive **real** $T$, when

$$
x(t)=x(t+T)\quad\text{for all }t\in\mathbb{R}.
$$

A DT signal is periodic with period $N$ ($N$-periodic), for some strictly positive **integer** $N$, when

$$
x(n)=x(n+N)\quad\text{for all }n\in\mathbb{Z}.
$$

A signal that is not periodic is **aperiodic**.

The period is not unique: if $T$ (or $N$) is a period, so is $kT$ (or $kN$) for every positive integer $k$. The smallest period is the **fundamental period**, and its frequency is the **fundamental frequency**.

| Signal | Ordinary frequency | Angular frequency |
| --- | --- | --- |
| CT, fundamental period $T_0$ | $f_0=1/T_0$ (Hz if $t$ is in seconds) | $\omega_0=2\pi/T_0$ (rad/s) |
| DT, fundamental period $N_0$ | $f_0=1/N_0$ (cycles/sample) | $\Omega_0=2\pi/N_0$ (rad/sample) |

*(Supplement)* A constant CT signal is an exceptional case: **every** $T>0$ is a period, so there is no smallest one and the fundamental period does not exist. A constant DT signal has fundamental period $N_0=1$.

### Least common multiple (LCM)

The **LCM** of two nonzero reals $a$ and $b$, written $\operatorname{lcm}(a,b)$, is the smallest positive real that is an integer multiple of both $|a|$ and $|b|$. It exists **if and only if** $a/b$ is rational, and it is then unique. Think of two clocks started at $t=0$ that chime every $a$ and every $b$: the LCM is the first moment they chime together.

To compute it, write $|a|/|b|=p/q$ with $p,q$ coprime positive integers; then

$$
\operatorname{lcm}(a,b)=q\,|a|=p\,|b|.
$$

For two nonzero integers the ratio is automatically rational, so the LCM always exists and is a positive integer.

### Adding periodic signals

**Theorem.** For periodic $x_1,x_2$ with fundamental periods $\Xi_1,\Xi_2$, the sum $y=x_1+x_2$ is periodic **if and only if** $\Xi=\operatorname{lcm}(\Xi_1,\Xi_2)$ exists, in which case $\Xi$ is a period of $y$.

- **CT:** two positive reals need not have an LCM, so the sum of two periodic functions is not necessarily periodic. If $T_1/T_2$ is irrational, the sum is aperiodic.
- **DT:** two positive integers always have an LCM, so the sum of two periodic sequences is always periodic.
- $\Xi$ is a **period** of $y$, and it is also the **fundamental** period in the absence of degeneracies — cancellation between the two signals can make the fundamental period smaller.
- For a sum of $N>2$ signals, apply the theorem $N-1$ times.

For example, components with CT periods $2$ and $3$ repeat together after $6$; sequences with DT periods $4$ and $6$ repeat together after $12$.

**Textbook:** §§2.10.2, 3.4.2, and 8.3.2.

## 5. Independent-variable transformations (slides §2.3)

These operations act on the **time variable**, not on amplitude. Shifting, reversal, and CT scaling relocate existing values; DT downsampling discards samples, and DT upsampling inserts zeros.

### Transformations available in both CT and DT

For $\xi=t$ (CT) or $\xi=n$ (DT):

| Operation | Definition | Effect on the signal |
| --- | --- | --- |
| Shift (translation) $S_b$ | $S_bx(\xi)=x(\xi-b)$ | $b>0$: shift right by $\lvert b\rvert$ (delay); $b<0$: shift left by $\lvert b\rvert$ (advance) |
| Reversal (reflection) $R$ | $Rx(\xi)=x(-\xi)$ | Reflect about the vertical line through the origin |

The shift $b$ may be any real number in CT, but it must be an **integer** in DT. For example, $x(t-2)$ shifts right by $2$, while $x(n+2)$ shifts left by $2$ samples.

### CT only: time scaling (dilation)

$$
K_ax(t)=x(at),\qquad a\in\mathbb{R}\setminus\{0\}.
$$

- $|a|>1$: compress along the time axis by a factor of $|a|$.
- $|a|<1$: expand (stretch) along the time axis by a factor of $1/|a|$.
- $a<0$: also time reversed.

A feature originally at $t_0$ appears at $t=t_0/a$ in $x(at)$. Thus $x(2t)$ is **twice as narrow**, not twice as tall.

### DT only: downsampling and upsampling

For a strictly positive integer $m$:

$$
(\downarrow m)x(n)=x(mn),
\qquad
(\uparrow m)x(n)=
\begin{cases}
x(n/m),&n/m\in\mathbb{Z},\\
0,&\text{otherwise}.
\end{cases}
$$

Downsampling keeps only every $m$-th sample of $x$; the others are discarded. The downsampling definition still makes sense for $m<0$, but then it is downsampling **composed with time reversal**.

Upsampling inserts $m-1$ zeros between adjacent samples of $x$, so the original samples end up $m$ indices apart. **Upsampling does not invent interpolated values.**

For instance, if $x(0)=1$, $x(1)=2$, $x(2)=3$, and all other samples are zero, then $(\downarrow 2)x$ has values $1,3$ at indices $0,1$, while $(\uparrow 2)x$ has values $1,2,3$ at indices $0,2,4$.

**Textbook:** §§3.2 and 8.2.

## 6. Composing transformations (slides §2.3)

Composed transformations often **do not** commute, so the order matters. It helps to separate the two cases. Throughout, $a\ne0$, and a DT shift is valid only when its shift amount is an integer.

### Transformations that **do** commute

$$
S_{b_2}S_{b_1}=S_{b_1+b_2}=S_{b_1}S_{b_2},
\qquad
K_{a_2}K_{a_1}=K_{a_1a_2}=K_{a_1}K_{a_2},
\qquad
RK_a=K_aR.
$$

Shifts add and scalings multiply under composition, and addition and multiplication commute. Reversal commutes with scaling because reversal **is** a scaling: $R=K_{-1}$.

### Transformations that do **not** commute

$$
RS_b=S_{-b}R,
\qquad
K_aS_b=S_{b/a}K_a,
$$

$$
(\downarrow m)S_b=S_{b/m}(\downarrow m)\quad\text{if }b/m\in\mathbb{Z},
\qquad
DK_a=aK_aD,
$$

Here $D$ is the CT differentiation operator (the factor $a$ comes from the chain rule). The displayed identities remain valid even in their special cases. The exceptions concern **commutation**: $R$ and $S_b$ commute when $b=0$; $K_a$ and $S_b$ when $a=1$ or $b=0$; $(\downarrow m)$ and $S_b$ when $m=1$ or $b=0$; and $D$ and $K_a$ when $a=1$. In addition, **time shifting and upsampling** normally do not commute, and **downsampling and upsampling** normally do not commute.

### Two readings of $x(at-b)$ in CT

$$
y(t)=x(at-b)=x\bigl[a(t-b/a)\bigr]
\quad\Longrightarrow\quad
y=K_aS_bx=S_{b/a}K_ax.
$$

1. $K_aS_b$: shift $x$ by $b$, **then** scale by $a$ — this is $x(at-b)$.
2. $S_{b/a}K_a$: scale $x$ by $a$, **then** shift by $b/a$ — this is $x[a(t-b/a)]$.

Two things to notice: the shift amount differs between the two routes ($b$ versus $b/a$), and the order of the operations is **reversed** relative to the order of the arithmetic inside $at-b$.

For drawing a graph, the most dependable method is to map each important original time $t_0$ to its new location:

$$
at-b=t_0\quad\Longrightarrow\quad t=\frac{t_0+b}{a}.
$$

Example: if $x$ has endpoints at $t_0=0$ and $t_0=2$, then $x(2t-2)$ has endpoints at $t=1$ and $t=2$. If $a<0$, their left-to-right order reverses.

### The DT counterpart

For integers $a\ne0$ and $b$, $y(n)=x(an-b)$ composes a shift with downsampling (negative downsampling factors allowed, which include a reversal):

1. In general: $(\downarrow a)S_b$ — shift by $b$, **then** downsample by $a$.
2. Only if $b/a\in\mathbb{Z}$: $S_{b/a}(\downarrow a)$ — downsample by $a$, **then** shift by $b/a$.

The integer condition is the whole point of the restriction in $(\downarrow m)S_b=S_{b/m}(\downarrow m)$: otherwise route 2 would require a fractional-sample shift, which is not a valid DT operation.

**Textbook:** §§3.2.5–3.2.6 and 8.2.5–8.2.6.

## Quick self-check

Before moving to slides §2.4, make sure you can answer these without looking at a formula sheet:

1. What is the difference between $x$ and $x(t)$, or between $Hx$ and $(Hx)(t)$?
2. How do you test whether a CT or DT signal is even, odd, or periodic?
3. How do you split a signal into its even and odd parts?
4. Which pairs of time transformations commute, and which do not?
5. Why does $x(2t-2)$ end up shifted right by $1$, not $2$, when you scale first?
6. Why is $x(2n)$ downsampling rather than ordinary DT time compression, and what happens to the discarded samples?
7. When is the sum of two periodic signals periodic, and why is the DT answer always "yes"?

**Sources:** Michael D. Adams, *Lecture Slides for Signals and Systems [Unified Continuous-Time/Discrete-Time Coverage]*, Edition 7.0.0-beta.1, Part 1 (printed pp. 1–11) and Part 2 §§2.1–2.3 (printed pp. 13–50); and *Signals and Systems*, Edition 7.0.0-beta.1, the textbook sections cited above. The lecture slides' §2.4 is outside this summary's scope.
