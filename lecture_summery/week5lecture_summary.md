# ECE265 Lecture Key Knowledge Summary 5

**Coverage:** This summary continues after [Lecture Key Knowledge Summary 4](tutorial4lecture_summary.md). It covers the unified lecture slides from **printed p. 139, "Invertibility," through printed p. 161, "DTFS Versus DFT."** The corresponding PDF-viewer pages are **158-180**. Printed p. 162, **"Fourier Series and Frequency Spectra," is the first excluded page.** Both slides and textbook are Edition **7.0.0-beta.3**.

This is a supplementary study guide. All references below use **printed** slide and textbook pages.

**Assignment connection:** Assignment 3B concerns impulse responses, LTI interconnections, system properties and exponential-input responses. Its MATLAB problems concern echoes and convolution reverb. The Fourier-series and DFT sections below follow the confirmed lecture range; they do not add Assignment 4 worked problems to this tutorial.

**Notation:** Following the slides, $\mathcal{H}$ is the system operator, $h$ its impulse response, and $H(s)$ or $H(z)$ its system function (also called the **transfer function**). The symbol $\ast$ between signals means convolution. A superscript $\ast$ means complex conjugation. Fourier-series coefficients are written $a_k$, as in the slides; the textbook often uses $c_k$ for the same coefficients. The textbook's trigonometric-form $a_k$ (p. 144) denotes a different coefficient; here $a_k$ always refers to the complex-exponential Fourier-series form.

## 1. Invertibility of an LTI system (slides §3.3, p. 139)

An inverse system undoes the original system. If an LTI system has an inverse, that inverse is also LTI. Their impulse responses must satisfy

$$
\boxed{h\ast h_{\mathrm{inv}}=\delta.}
$$

This follows from cascading the two systems:

$$
(x\ast h)\ast h_{\mathrm{inv}}
=x\ast(h\ast h_{\mathrm{inv}})
=x\ast\delta=x.
$$

Thus the LTI system is invertible if and only if such an impulse response $h_{\mathrm{inv}}$ exists. In CT, $\delta$ is the Dirac impulse; in DT, it is the unit-impulse sequence.

**Check:** this is a **convolution inverse**, not the pointwise reciprocal $1/h(t)$ or $1/h(n)$. An inverse need not have the same causality or stability properties as the original system.

**Textbook:** §4.9.3, pp. 104-106; §9.9.3, pp. 422-425.

## 2. BIBO stability of an LTI system (slides §3.3, p. 140)

Bounded-input bounded-output (**BIBO**) stability means that every bounded input produces a bounded output.

For an ordinary CT impulse-response function, the LTI stability test is **absolute integrability**:

$$
\boxed{\lVert h\rVert_1=\int_{-\infty}^{\infty}|h(t)|\thinspace dt\lt\infty.}
$$

For a DT impulse response, the test is **absolute summability**:

$$
\boxed{\lVert h\rVert_1=\sum_{n=-\infty}^{\infty}|h(n)|\lt\infty.}
$$

Why the absolute value matters: if $|x(\xi)|\le A$ for all input times/indices, convolution gives the uniform output bound

$$
|y(\xi)|\le A\lVert h\rVert_1.
$$

Here $\xi=t$ in CT and $\xi=n$ in DT. A finite $\lVert h\rVert_1$ gives one finite bound for the entire output, not just for a chosen time.

**Check:** bounded $h$ alone is insufficient. Check the integral/sum of $|h|$, not a signed integral/sum that may cancel. If parameters are present, examine all allowed parameter cases before stating stability.

### Supplement: CT impulse terms

The ordinary-function integral test above does not directly apply to a Dirac impulse; see the textbook footnote on p. 106. For a finite impulse sum, use its input-output rule instead. If

$$
h(t)=\sum_{r=1}^{R}c_r\delta(t-t_r),
$$

then

$$
y(t)=\sum_{r=1}^{R}c_rx(t-t_r),
\qquad
|y(t)|\le A\sum_{r=1}^{R}|c_r|\lt\infty
$$

for finite coefficients $c_r$ and bounded input $x$. Do not treat $\delta$ as an ordinary function inside an absolute-value integral.

**Textbook:** §4.9.4, pp. 106-109; §9.9.4, pp. 425-427.

## 3. Exponential inputs and system functions (slides §3.3, pp. 141-142)

An eigenfunction/eigensequence keeps its shape after passing through the system; only a constant multiplier changes.

### CT: exponential rate $s$

For $x_s(t)=e^{st}$,

$$
\mathcal{H}x_s(t)=H(s)e^{st},
\qquad
H(s)=\int_{-\infty}^{\infty}h(\tau)e^{-s\tau}\thinspace d\tau.
$$

The complex number $H(s)$ is the eigenvalue corresponding to $e^{st}$.

### DT: exponential base $z$

For $x_z(n)=z^n$, with $z\ne0$,

$$
\mathcal{H}x_z(n)=H(z)z^n,
\qquad
H(z)=\sum_{k=-\infty}^{\infty}h(k)z^{-k}.
$$

The complex number $H(z)$ is the eigenvalue corresponding to $z^n$.

**Supplement (required textbook condition):** use these formulas only at values of $s$ or $z$ where the defining integral/sum converges. The textbook calls this set the **region of convergence (ROC)**. If a problem gives a domain for $H$, check that every required evaluation lies in it; a finite-looking algebraic expression alone does not remove this condition.

### Finding an output without computing convolution

For a finite sum of exponential inputs, linearity gives

$$
x(t)=\sum_{r=1}^{R}a_re^{s_rt}
\quad\Longrightarrow\quad
y(t)=\sum_{r=1}^{R}a_rH(s_r)e^{s_rt}
$$

in CT, and

$$
x(n)=\sum_{r=1}^{R}a_rz_r^n
\quad\Longrightarrow\quad
y(n)=\sum_{r=1}^{R}a_rH(z_r)z_r^n
$$

in DT. Each exponential receives its own multiplier; the exponent/base stays unchanged.

To use this method for sine and cosine, first apply Euler's identities:

$$
\cos(\omega\xi)=\frac{e^{j\omega\xi}+e^{-j\omega\xi}}{2},
\qquad
\sin(\omega\xi)=\frac{e^{j\omega\xi}-e^{-j\omega\xi}}{2j}.
$$

- CT evaluations use $s=j\omega$ and $s=-j\omega$.
- DT evaluations use $z=e^{j\omega}$ and $z=e^{-j\omega}$, since $e^{j\omega n}=(e^{j\omega})^n$.
- A constant input $C$ is $Ce^{0t}$ in CT and $C(1)^n$ in DT. Its output is therefore $CH(0)$ in CT, but $CH(1)$ in DT, whenever those evaluations are valid.

**Checks:** do not substitute the DT angular frequency itself into $H(z)$. Also, exponential eigenfunctions alone do not prove an arbitrary system is LTI; LTI is the starting assumption here.

**Supplement:** extending the finite-sum output rule to an infinite sum requires convergence and justification for passing the system operation through that sum. Linearity alone is not enough.

**Textbook:** §4.10, pp. 109-113, especially pp. 110-111; §9.10, pp. 428-431, especially pp. 428-429.

## 4. Why Fourier series use harmonically related sinusoids (slides Part 4 introduction and §4.1, pp. 143-146)

A Fourier series represents a periodic signal as a linear combination of complex sinusoids. These are useful building blocks because they are easy to manipulate and have the LTI eigenfunction/eigensequence property just discussed.

**Harmonically related** means that the sinusoidal frequencies lie at integer multiples of a common angular frequency $\omega_0$. The $k$th basis signal uses angular frequency $k\omega_0$.

For CT, choose $T>0$ and $\omega_0=2\pi/T$. The functions

$$
\phi_k(t)=e^{jk\omega_0t},\qquad k\in\mathbb{Z},
$$

are all distinct and share the period $T$.

For DT, choose a positive integer $N$ and $\omega_0=2\pi/N$. The sequences

$$
\phi_k(n)=e^{j(2\pi/N)kn}
$$

satisfy

$$
\phi_{k+N}(n)=\phi_k(n),
$$

so only **$N$ distinct basis sequences** are needed. Indices $k$ differing by $N$ identify the same DT basis sequence.

A linear combination of these basis signals has period $T$ in CT or $N$ in DT. The actual fundamental period can be smaller; a shared period is not automatically the smallest period.

**Textbook:** §§5.1-5.2, p. 125; §§10.1-10.2, pp. 439-440.

## 5. Continuous-time Fourier series: CTFS (slides §4.1, pp. 147-148)

For a periodic CT function, choose a period $T>0$ (normally its fundamental period) and set $\omega_0=2\pi/T$:

**Synthesis: coefficients to signal**

$$
\boxed{x(t)=\sum_{k=-\infty}^{\infty}a_ke^{jk\omega_0t}.}
$$

**Analysis: signal to coefficients**

$$
\boxed{a_k=\frac{1}{T}\int_{t_0}^{t_0+T}x(t)e^{-jk\omega_0t}\thinspace dt,
\qquad k\in\mathbb{Z}.}
$$

The analysis interval may start at any real $t_0$, but its length must be exactly $T$. Common choices are one period from $0$ to $T$, or from $-T/2$ to $T/2$. Split the integral if $x$ changes formula inside the chosen period.

The slides abbreviate this signal/coefficient pairing as $x(t)\overset{\mathrm{CTFS}}{\longleftrightarrow}a_k$.

The $k=0$ term is constant. For positive integer $K$, the terms with $k=K$ and $k=-K$ are the $K$th harmonic components, at angular frequencies $K\omega_0$ and $-K\omega_0$.

**Check:** analysis has a negative exponent and a factor $1/T$; synthesis has a positive exponent and no extra factor $1/T$. If a derived coefficient formula divides by $k$, compute $a_0$ separately from the analysis equation.

### Supplement: equality at CT discontinuities

The CT synthesis formula is read with its convergence conditions. Under the textbook's Dirichlet conditions, it reproduces $x(t)$ at continuous points; at a jump $t_a$, it converges to

$$
\frac{x(t_a^-)+x(t_a^+)}{2}.
$$

Changing $x$ at isolated points, for example assigning a different value at a jump, leaves every $a_k$ unchanged. The CT symmetry statements below describe the Fourier-series reconstruction, not those individually assigned values. Full convergence theory is outside this lecture-summary range.

**Textbook:** §§5.2-5.3, pp. 125-126; convergence clarification: §5.4, pp. 132-134, especially Theorem 5.4 on p. 133.

## 6. Discrete-time Fourier series: DTFS (slides §4.1, pp. 149-150)

For an $N$-periodic sequence, $N$ is a positive integer and $\omega_0=2\pi/N$.

**Synthesis: coefficients to signal**

$$
\boxed{x(n)=\sum_{k=\langle N\rangle}a_ke^{j(2\pi/N)kn},
\qquad n\in\mathbb{Z}.}
$$

**Analysis: signal to coefficients**

$$
\boxed{a_k=\frac{1}{N}\sum_{n=\langle N\rangle}x(n)e^{-j(2\pi/N)kn},
\qquad k\in\mathbb{Z}.}
$$

The notation $\sum_{n=\langle N\rangle}$ means a sum over **any $N$ consecutive integers**, such as $n=0,1,\ldots,N-1$. Another choice is the centered range $-\lfloor N/2\rfloor,\ldots,\lceil N/2\rceil-1$. The synthesis sum similarly uses any $N$ consecutive values of $k$.

The slides write this pairing as $x(n)\overset{\mathrm{DTFS}}{\longleftrightarrow}a_k$.

The coefficient sequence is periodic:

$$
\boxed{a_{k+N}=a_k.}
$$

Thus one block of $N$ coefficient values determines all the others. For example, the coefficient at index $-1$ is also the coefficient at index $N-1$.

**Check:** $0$ through $N$ contains $N+1$ indices, so it repeats a periodic sample. Use exactly $N$ consecutive indices. Unlike CTFS, the DTFS synthesis sum is finite and reconstructs every sample of a finite-valued periodic sequence exactly.

**Textbook:** §§10.2-10.3, pp. 439-442; finite-sum convergence: §10.4, p. 449.

## 7. CTFS versus DTFS (slides §4.1, p. 151)

| Feature | CTFS | DTFS |
| --- | --- | --- |
| Signal | $T$-periodic function of real $t$ | $N$-periodic sequence of integer $n$ |
| Analysis | Integral over one period; factor $1/T$ | Sum over $N$ consecutive samples; factor $1/N$ |
| Synthesis | Generally an infinite sum | A finite sum of $N$ terms |
| Coefficient indices | All integers; generally not periodic | All integers; $a_{k+N}=a_k$ |
| Number of independent coefficients in the general case | Infinitely many | $N$ |

Both representations have discrete, integer-indexed coefficients even though one original signal is continuous-time. An individual CT signal can have only finitely many nonzero coefficients; the general CTFS representation still allows infinitely many.

**Textbook:** §§5.2-5.3 and §§10.2-10.4, cited above.

## 8. Fourier-series properties covered so far (slides §4.1, pp. 152-155)

These properties apply to CTFS and DTFS with the conventions above. For DT, negative coefficient indices are interpreted using the $N$-periodic extension.

### Linearity (p. 152)

Use the **same chosen period and harmonic basis** for both inputs. If $x_1$ has coefficients $a_{1,k}$ and $x_2$ has coefficients $a_{2,k}$, then for complex constants $c_1,c_2$,

$$
x=c_1x_1+c_2x_2
\quad\Longrightarrow\quad
a_k=c_1a_{1,k}+c_2a_{2,k}.
$$

Do not combine coefficients indexed on different harmonic grids without first expressing them on a common grid.

**Textbook:** §5.5.1, p. 134; §10.5.1, p. 450.

### Even/odd symmetry preservation (p. 153)

$$
x\text{ even}\quad\Longleftrightarrow\quad a_{-k}=a_k,
$$

$$
x\text{ odd}\quad\Longleftrightarrow\quad a_{-k}=-a_k.
$$

No real-valued assumption is required. In particular, odd symmetry gives $a_0=0$.

**Textbook:** §5.5.9, p. 142; §10.5.10, p. 456.

### Real/conjugate-symmetry duality (p. 154)

A real-valued signal has conjugate-symmetric coefficients, and conversely:

$$
\boxed{x\text{ real valued}\quad\Longleftrightarrow\quad a_{-k}=(a_k)^{\ast}.}
$$

A conjugate-symmetric signal has real-valued coefficients, and conversely:

$$
\boxed{x(-\xi)=(x(\xi))^{\ast}\quad\Longleftrightarrow\quad a_k\in\mathbb{R}\text{ for every }k.}
$$

Here $\xi=t$ in CT and $\xi=n$ in DT. Real-valued $x$ does **not** imply that every coefficient is real. Combining the properties: real-even signals have real-even coefficients; real-odd signals have purely imaginary odd coefficients.

**References:** slide p. 154 states both dualities. For real-valued signals, see textbook §5.5.10, pp. 142-145, and §10.5.11, pp. 457-459. For real-valued coefficients, see CT Example 5.7, p. 145; the DT result follows from reflection and conjugation in §§10.5.4-10.5.5, pp. 451-452.

### Average value (p. 155)

The zero-index coefficient is the average over one period:

$$
a_0=\frac{1}{T}\int_{t_0}^{t_0+T}x(t)\thinspace dt
\qquad\text{(CT)},
$$

$$
a_0=\frac{1}{N}\sum_{n=\langle N\rangle}x(n)
\qquad\text{(DT)}.
$$

This is the signal's direct-current (**DC**) component: the constant term in its synthesis equation. It is the average of $x$, not the average of $|x|$ or the signal's energy.

**Textbook:** §5.3, p. 126; §10.3, pp. 441-442.

## 9. Discrete Fourier transform: DFT (slides §4.2, pp. 156-161)

The DFT gives a compact vector representation closely related to DTFS. It changes both the way one period is stored and the normalization of its coefficients.

### Normalization (p. 158)

If $a_k'=\beta a_k$, where $\beta$ is a nonzero real constant, the DTFS pair becomes

$$
a_k'=\frac{\beta}{N}\sum_{n=\langle N\rangle}x(n)e^{-j(2\pi/N)kn},
$$

$$
x(n)=\frac{1}{\beta}\sum_{k=\langle N\rangle}a_k'e^{j(2\pi/N)kn}.
$$

The course's DTFS convention uses $\beta=1$; the DFT uses $\beta=N$. Moving the scale factor from analysis to synthesis changes the coefficient values, not the reconstructed signal.

### From periodic sequences to finite vectors (pp. 159-160)

DTFS describes $x(n)$ and $a_k$ for all integer indices; both sequences are $N$-periodic. The DFT stores only the $N$ entries with indices $0,1,\ldots,N-1$.

For this $N$-element input vector, the **DFT analysis equation** is

$$
\boxed{X(k)=\sum_{n=0}^{N-1}x(n)e^{-j(2\pi/N)kn},
\qquad k=0,1,\ldots,N-1.}
$$

The **inverse DFT / synthesis equation** is

$$
\boxed{x(n)=\frac{1}{N}\sum_{k=0}^{N-1}X(k)e^{j(2\pi/N)kn},
\qquad n=0,1,\ldots,N-1.}
$$

### DTFS versus DFT (p. 161)

For the same period and the same index origin,

$$
\boxed{X(k)=Na_k,\qquad a_k=\frac{X(k)}{N},
\qquad k=0,1,\ldots,N-1.}
$$

| Feature | DTFS | DFT |
| --- | --- | --- |
| Representation | Periodic sequences for every integer index | Two stored vectors of $N$ elements |
| Analysis scale factor | $1/N$ | None |
| Synthesis scale factor | None | $1/N$ |

To relate other integer indices to stored DFT entries, first use the periodic-extension viewpoint. Also, do not relabel a block starting at another sequence index as $0,\ldots,N-1$ without accounting for the changed index origin.

**Checks:** the **fast Fourier transform (FFT)** is a family of efficient algorithms for computing the DFT, not a different transform. The DFT is not the **discrete-time Fourier transform (DTFT)**; DTFT is introduced later.

**Textbook:** §10.6, pp. 461-462. The additional DFT properties listed in Table 10.2 are not included in this summary because they are not covered in slides pp. 156-161.

## Quick self-check

1. What must the convolution of a system's impulse response and its inverse's impulse response equal? Why is pointwise reciprocation the wrong test?
2. Why does boundedness of an ordinary impulse-response function not establish BIBO stability? What must you integrate or sum?
3. For an exponential input, what stays unchanged and what is multiplied? Which CT and DT system-function arguments correspond to a constant input?
4. Why are there infinitely many distinct CT basis functions but only $N$ distinct DT basis sequences? Must the shared period be fundamental?
5. Which sign and scale factor belong to analysis? Why does a DTFS sum over $0,\ldots,N$ repeat a sample?
6. If a signal is real and odd, what symmetry and real/imaginary restrictions must its coefficients satisfy? How should DT negative indices be read?
7. For a constant sequence $x(n)=C$, choose any positive-integer period $N$, not necessarily the fundamental period. What are $a_0$ and $X(0)$? What is $a_N$, and why?

**Sources:** Michael D. Adams, unified lecture slides, Edition 7.0.0-beta.3, printed pp. 139-161; *Signals and Systems*, Edition 7.0.0-beta.3, sections cited above. Assignment context: Assignment handout Version 2026-09-21, Assignment 3, Part B. Printed slide p. 162 begins "Fourier Series and Frequency Spectra" and is outside this summary.
