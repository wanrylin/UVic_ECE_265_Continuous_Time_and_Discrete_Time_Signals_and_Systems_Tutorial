# ECE265 Tutorial 7

## Assignment 5B: Fourier Transform

T02 · Ruilin Wang

This handout contains a short problem-solving recap, three worked regular examples, and the original MATLAB task with a method and pseudocode. Page references are **printed pages** in the course textbook and slides, Edition **7.0.0-beta.3**.

### Selected practice

| Assignment 5B problem | Tutorial example | Method |
| --- | --- | --- |
| 6.14(b) | **6.116(c)**, textbook p. 254 | Remove a running-integral term, then find the continuous-time frequency response. |
| 11.17(d) | **11.17(a)**, textbook p. 558 | Cross-multiply a discrete-time frequency response and translate exponentials into time shifts. |
| 6.24(a) | **6.20(a)**, textbook p. 246 | Track the spectra through two carrier multiplications and a lowpass filter. |
| 11.204(a,b) | **11.204(a,b)**, textbook pp. 561-562 | Relate a cascade of narrow notches to changes in the spectrum of noisy audio. |

The regular examples use different equations or carrier choices from the assigned parts. The MATLAB demonstration addresses the assigned task. This handout focuses on those methods; it is not a complete review of Assignment 5B.

## Problem-solving recap

Use this section for preparation and self-study. In class we start with the examples.

### 1. Continuous time: from a differential or integral equation to frequency response

Let $x$ and $y$ be the input and output of the LTI system, with CT Fourier transforms $X$ and $Y$. The frequency response $H$ satisfies $Y(\omega)=H(\omega)X(\omega)$. Differentiating $m$ times multiplies a transform by $(j\omega)^m$:

$$
\mathcal{F}\lbrace D^m x\rbrace(\omega)=(j\omega)^m X(\omega).
$$

**Method:** put output terms on one side and input terms on the other. For a differential equation, transform both sides and factor out $Y$ and $X$ to get $A(j\omega)Y(\omega)=B(j\omega)X(\omega)$. Then read $H(\omega)=B(j\omega)/A(j\omega)$ where the denominator is nonzero.

For a running integral $\mathcal{I}f(t)=\int_{-\infty}^{t}f(\tau)\thinspace d\tau$, differentiating **both sides** can remove it because $D(\mathcal{I}f)=f$. Keep the original equation with its lower limit $-\infty$: the differentiated equation alone cannot detect a constant added to one side.

**Trap:** the transform of a running integral can contain a DC impulse. Treating it as division by $j\omega$ at $\omega=0$ is not valid. When the resulting rational response has a valid continuous extension to DC, evaluate that extension after simplifying; otherwise check the original equation. The system response comes from the equation's coefficients, not from dividing numerical spectra at a zero of $X$.

**References:** slides pp. 209-210, 229, 238; textbook §§6.7.9, 6.7.11, 6.15 (pp. 185, 187, 214-215).

### 2. Discrete time: from frequency response to a difference equation

The textbook uses $\Omega$ for DT frequency here (rad/sample); slides 194 and 239 write $\omega$ for the same quantity. For a sequence $w$ with DT Fourier transform $W$, a delay of $m$ samples gives

$$
\mathcal{F}\lbrace w(n-m)\rbrace(\Omega)=e^{-jm\Omega}W(\Omega).
$$

Thus $e^{-jm\Omega}W$ corresponds to $w(n-m)$, and $e^{jm\Omega}W$ corresponds to $w(n+m)$.

**Method:** write $Y=HX$ and cross-multiply: the denominator multiplies $Y$, and the numerator multiplies $X$. Match each exponential on both sides to the appropriate shifted sample, then invert term by term. If you want a form with no positive exponents, multiply **every term on both sides** by the same $e^{-jM\Omega}$, using the largest positive exponent index $M$. This is equivalent to reindexing the entire time-domain equation.

**Trap:** a positive exponent means an advance, not a delay. Keep missing powers as zero coefficients; do not slide another coefficient into a missing position. The delay sign rule is the same when working in the reverse direction, from a difference equation to a frequency response.

**References:** slides pp. 194, 239; textbook §11.15 (pp. 537-539), particularly Example 11.38.

### 3. Amplitude modulation: track the complex spectrum through each block

For a CT signal $w$ with transform $W$, multiplication by a carrier produces shifted copies of $W$:

$$
\begin{aligned}
\mathcal{F}\lbrace w(t)\cos(\omega_c t)\rbrace(\omega)
&=\frac{W(\omega-\omega_c)+W(\omega+\omega_c)}{2},\cr
\mathcal{F}\lbrace w(t)\sin(\omega_c t)\rbrace(\omega)
&=\frac{W(\omega-\omega_c)-W(\omega+\omega_c)}{2j}.
\end{aligned}
$$

**Method:** label the spectrum at the output of each block. Use the actual carrier at the first mixer; at the second mixer, apply the shift rule to the spectrum entering **that** mixer. Combine overlapping terms with their complex coefficients still attached. At the lowpass filter, multiply the intermediate spectrum by the given response $H(\omega)$. Use the bandwidth and cutoff to identify which copies pass, and include the passband gain.

**Trap:** taking magnitudes before adding can hide cancellation. A recovery formula derived for matching cosine carriers cannot be applied without checking the carriers in the new system. Also distinguish mixing in time from multiplying spectra at an LTI filter.

**References:** slides pp. 196, 255-259; textbook §6.19.2 (pp. 227-229).

### 4. MATLAB bridge: narrow notches and audio spectra

A notch attenuates a small band around a target frequency. A cascade places one section at each interference harmonic that is to be removed. Its overall response is the product of the individual responses; it is not their sum.

For a sampling rate $F_s$ in Hz, convert a target frequency $f$ in Hz to the Nyquist-normalized frequency used by the notch helper:

$$
\Omega=\frac{2\pi f}{F_s},\qquad f_{\mathrm{norm}}=\frac{\Omega}{\pi}=\frac{f}{F_s/2}.
$$

**Method:** find the harmonic locations in Hz, identify the valid targets, then normalize for filter design. Compare the noisy-input spectrum, cascade magnitude response and output spectrum on the same Hz axis. For an $N$-point FFT, the nonnegative-frequency bins have $f_k=kF_s/N$ Hz for $0\le k\le\lfloor N/2\rfloor$, with $k$ counted from zero. For magnitudes in dB use $20\log_{10}(\text{magnitude})$, using the same scaling for the input and output spectra.

**Trap:** $f/F_s$ and $f/(F_s/2)$ are different. A useful check is that a target at Nyquist has normalized frequency 1. The supplied notch-design helper accepts only frequencies strictly between 0 and 1. A very narrow notch may need a fine frequency grid to be visible in a plot.

**References:** slides pp. 229, 237, 248-249, 567, 569; textbook §§11.14, 11.16, D.15.2.1-D.15.2.2, and Exercise 11.204.

## 6.116(c): Problem

**Textbook p. 254; original common stem and selected subpart.**

> For each differential/integral equation below that characterizes a LTI system with input $x$ and output $y$, find the frequency response $H$ of the system. Note that $\mathcal{I}$ denotes the integration operator $\mathcal{I}x(t)=\int_{-\infty}^{t}x(\tau)\thinspace d\tau$ and $\mathcal{D}$ denotes the derivative operator.
>
> (c) $\mathcal{D}y(t)+3y(t)+2\mathcal{I}y(t)=\mathcal{D}x(t)+5x(t)$.

### Knowledge points

- A running integral from $-\infty$ can be removed by differentiating both sides. The lower limit is still part of the original equation.
- For CT signals, each derivative introduces a factor of $j\omega$; the LTI input-output relationship is $Y=HX$.
- **References:** slides pp. 209-210, 229, 238; textbook §§6.7.9, 6.7.11, 6.15 (pp. 185, 187, 214-215).

### Core bridge formula

Write $D$ and $I$ for the textbook's differentiation and running-integration operators. Then

$$
D(If)(t)=f(t),\qquad
\mathcal{F}\lbrace D^k f\rbrace(\omega)=(j\omega)^k F(\omega).
$$

An equation of the form $A(j\omega)Y(\omega)=B(j\omega)X(\omega)$ gives $H(\omega)=B(j\omega)/A(j\omega)$ wherever $A(j\omega)\ne 0$.

### Answer

**1. Differentiate the entire original equation.** This is a way to use $D(Iy)=y$ without dividing by $j\omega$:

$$
\begin{aligned}
D\bigl[Dy(t)+3y(t)+2Iy(t)\bigr]
&=D\bigl[Dx(t)+5x(t)\bigr],\cr
D^2y(t)+3Dy(t)+2y(t)
&=D^2x(t)+5Dx(t).
\end{aligned}
$$

The original equation implies this one. The reverse is not automatic: differentiation would also hide a constant added to one side, so the original equation still defines the system.

**2. Take the CT Fourier transform and collect like factors.**

$$
\begin{aligned}
(j\omega)^2Y(\omega)+3j\omega Y(\omega)+2Y(\omega)
&=(j\omega)^2X(\omega)+5j\omega X(\omega),\cr
\bigl[(j\omega)^2+3j\omega+2\bigr]Y(\omega)
&=\bigl[(j\omega)^2+5j\omega\bigr]X(\omega).
\end{aligned}
$$

**3. Read off the frequency response.** Factor the numerator and denominator:

$$
\begin{aligned}
(j\omega)^2+5j\omega&=(j\omega)(j\omega+5),\cr
(j\omega)^2+3j\omega+2&=(j\omega+1)(j\omega+2).
\end{aligned}
$$

Since $Y=HX$, the required response is

$$
\boxed{H(\omega)=\frac{(j\omega)(j\omega+5)}
{(j\omega+1)(j\omega+2)}
=\frac{\omega^2-5j\omega}{\omega^2-3j\omega-2}.}
$$

For the second form, expand using $(j\omega)^2=-\omega^2$ and multiply the numerator and denominator by $-1$. Neither denominator factor vanishes for real $\omega$, so this form also gives $H(0)=0$. We obtained the response from the equation, not by dividing the spectra of a particular input at its zeros.

## 11.17(a): Problem

**Textbook p. 558; original common stem and selected subpart.**

> For each frequency response $H$ given below for a LTI system with input $x$ and output $y$, find the difference equation that characterizes the system.
>
> (a) $H(\Omega)=\dfrac{e^{j\Omega}+8/25}{e^{j2\Omega}+e^{j\Omega}+4/25}$.

### Knowledge points

- Cross-multiply $Y=HX$ before interpreting individual terms.
- A negative power of $e^{j\Omega}$ represents a delay. Positive powers may be removed by shifting the **whole** equation.
- **References:** slides pp. 194, 239; textbook §11.15 (pp. 537-539), especially Example 11.38.

### Core bridge formula

For $H=B/A$, write $A(\Omega)Y(\Omega)=B(\Omega)X(\Omega)$. The DT Fourier transform maps

$$
w(n-m)\ \longleftrightarrow\ e^{-jm\Omega}W(\Omega).
$$

Multiplying every term by $e^{-jM\Omega}$ shifts every sample index by the same $-M$.

### Answer

**1. Cross-multiply.** The denominator goes with the output $Y$:

$$
\left(e^{j2\Omega}+e^{j\Omega}+\frac{4}{25}\right)Y(\Omega)
=\left(e^{j\Omega}+\frac{8}{25}\right)X(\Omega).
$$

**2. Multiply both sides by $e^{-j2\Omega}$.** The factors $e^{j2\Omega}$, $e^{j\Omega}$, and $1$ become $1$, $e^{-j\Omega}$, and $e^{-j2\Omega}$, respectively. Therefore

$$
\left(1+e^{-j\Omega}+\frac{4}{25}e^{-j2\Omega}\right)Y(\Omega)
=\left(e^{-j\Omega}+\frac{8}{25}e^{-j2\Omega}\right)X(\Omega).
$$

**3. Apply the inverse transform term by term.**

| Factor | Applied to $Y$ | Applied to $X$ |
| --- | --- | --- |
| $1$ | $y(n)$ | No term |
| $e^{-j\Omega}$ | $y(n-1)$ | $x(n-1)$ |
| $e^{-j2\Omega}$ | $\dfrac{4}{25}y(n-2)$ | $\dfrac{8}{25}x(n-2)$ |

The difference equation is

$$
\boxed{y(n)+y(n-1)+\frac{4}{25}y(n-2)
=x(n-1)+\frac{8}{25}x(n-2).}
$$

There is no $x(n)$ term: the right side has no constant power after the common shift. As a check, transforming this equation and multiplying both sides by $e^{j2\Omega}$ recovers the given ratio.

## 6.20(a): Problem

**Textbook p. 246; original common stem and selected subpart.**

> Let $x$ be a real function with Fourier transform $X$ satisfying $X(\omega)=0$ for $|\omega|\gt\omega_b$. We use amplitude modulation to produce the function $y(t)=x(t)\sin(\omega_ct)$. Note that $\omega_c\gg\omega_b$. In order to recover the original function $x$, it is proposed that the system shown in the figure below be used. This system contains a LTI subsystem that is labelled with its impulse response $h$. Let $Y$, $V$, $\widehat X$, and $H$ denote the Fourier transforms of $y$, $v$, $\widehat x$, and $h$, respectively. The system is such that
>
> $$
> H(\omega)=
> \begin{cases}
> 2,& |\omega|\lt\omega_b,\cr
> 0,& \text{otherwise}.
> \end{cases}
> $$
>
> $$
> y \xrightarrow{\times\cos(\omega_ct)} v \xrightarrow{\text{LTI system }h} \widehat x
> $$
>
> (a) Find an expression for $Y$ in terms of $X$. Find an expression for $\widehat X$ in terms of $V$. Find an expression for $\widehat X$ in terms of $X$.

The receiver figure is represented above as a signal chain with the same blocks and labels.

### Knowledge points

- In CT, multiplication by a complex exponential shifts the spectrum. Sine and cosine produce different complex weights for the two shifted copies.
- Only the LTI filter stage uses a product of the input spectrum and the frequency response.
- **References:** slides pp. 196, 229, 255-259; textbook §6.7.3 and §6.19.2 (pp. 177-178, 227-229).

### Core bridge formula

If $w$ has Fourier transform $W$, then

$$
\begin{aligned}
\mathcal{F}\lbrace w(t)\sin(\omega_ct)\rbrace(\omega)
&=\frac{W(\omega-\omega_c)-W(\omega+\omega_c)}{2j},\cr
\mathcal{F}\lbrace w(t)\cos(\omega_ct)\rbrace(\omega)
&=\frac{W(\omega-\omega_c)+W(\omega+\omega_c)}{2}.
\end{aligned}
$$

For the filter, an input spectrum $V$ produces output spectrum $HV$. Keep the signs and complex weights through both mixing stages before deciding which copies remain.

### Answer

**1. Transmitter: express $Y$ in terms of $X$.** Using
$\sin(\omega_ct)=(e^{j\omega_ct}-e^{-j\omega_ct})/(2j)$ and the CT frequency-shift rule gives

$$
\boxed{Y(\omega)=\frac{X(\omega-\omega_c)-X(\omega+\omega_c)}{2j}.}
$$

The copy centered at $+\omega_c$ has weight $1/(2j)$; the copy centered at $-\omega_c$ has weight $-1/(2j)$.

**2. Filter: express $\widehat X$ in terms of $V$.** The filter input is $v$, so

$$
\boxed{\widehat X(\omega)=H(\omega)V(\omega)=
\begin{cases}
2V(\omega),&|\omega|\lt\omega_b,\cr
0,&\text{otherwise}.
\end{cases}}
$$

**3. Receiver mixer: express $V$ in terms of $X$.** Here $v(t)=y(t)\cos(\omega_ct)$, hence

$$
V(\omega)=\frac12\bigl[Y(\omega-\omega_c)+Y(\omega+\omega_c)\bigr].
$$

Substitute the transmitter expression at both shifted arguments:

$$
\begin{aligned}
Y(\omega-\omega_c)&=\frac{X(\omega-2\omega_c)-X(\omega)}{2j},\cr
Y(\omega+\omega_c)&=\frac{X(\omega)-X(\omega+2\omega_c)}{2j}.
\end{aligned}
$$

The two baseband terms $-X(\omega)$ and $+X(\omega)$ cancel:

$$
\begin{aligned}
V(\omega)
&=\frac{X(\omega-2\omega_c)-X(\omega)+X(\omega)-X(\omega+2\omega_c)}{4j}\cr
&=\frac{X(\omega-2\omega_c)-X(\omega+2\omega_c)}{4j}.
\end{aligned}
$$

**4. Multiply by the lowpass response.** The unsimplified result in terms of $X$ is

$$
\widehat X(\omega)=\frac{H(\omega)}{4j}
\bigl[X(\omega-2\omega_c)-X(\omega+2\omega_c)\bigr].
$$

For $|\omega|\lt\omega_b$, both arguments satisfy
$|\omega\pm 2\omega_c|\ge 2\omega_c-|\omega|\gt 2\omega_c-\omega_b\gt\omega_b$.
The final inequality uses $\omega_c\gg\omega_b$. Both shifted copies are therefore zero in the passband. At and outside the cutoff, $H(\omega)=0$. Therefore

$$
\boxed{\widehat X(\omega)=0\quad\text{for all }\omega.}
$$

This cancellation comes from the signs of the two baseband copies, not from comparing their magnitudes.

## MATLAB 11.204(a,b): Problem

**Textbook pp. 561-562; original task (a), (b)(i), and (b)(ii).**

> In this exercise, we explore the problem posed by interference introduced through the alternating current (AC) used to distribute electricity in power grids. The frequency of alternation used by AC varies in different regions in the world, but is typically either 50 or 60 Hz. For simplicity, we will assume 60 Hz in what follows. As a consequence of the AC power distribution, noise at a frequency of 60 Hz and its harmonics (i.e., integer multiples of 60 Hz) often arise in many practical applications.
>
> In this exercise, power-line interference is to be removed from an audio signal by employing a cascade of recursive notch filters, with each notch filter rejecting a single harmonic frequency. (A notch filter is essentially a bandstop filter with a very narrow stopband centered at a specific frequency, intended to reject only that frequency.) The following helper functions are provided:
>
> - `sos_notch_filter`: This function designs a series of second-order recursive notch filters.
> - `sos_filter`: This function applies a cascade of second-order filters to a signal.
> - `sos_freqz`: This function computes the overall frequency response of a cascade of second-order filters.
>
> The source code for these functions can be found in the files `sos_notch_filter.m`, `sos_filter.m`, and `sos_freqz.m`. Moreover, the documentation for each function can be found in its corresponding source file.
>
> The `compute_dtft` and `plot_dt_spectrum` functions (from the files `compute_dtft.m` and `plot_dt_spectrum.m`) may also be helpful.
>
> **a)** Write the `audio_file_remove_harmonic_noise` function. This function reads a noisy audio file, removes power-line harmonic interference using a cascade of second-order recursive notch filters, saves the denoised signal to an output file, and generates some related plots. The `audio_file_remove_harmonic_noise` function has the signature:
>
> ```matlab
> function audio_file_remove_harmonic_noise(input_file, output_file, ...
>     base_freq, num_harmonics)
> ```
>
> The function parameters are defined as follows:
>
> - `input_file`: path to the input .wav file containing the noisy audio signal;
> - `output_file`: path to the output .wav file to which the denoised signal will be written;
> - `base_freq`: the fundamental frequency of the power-line interference in Hz (e.g., 60);
> - `num_harmonics`: the number of harmonics to remove, including the fundamental frequency (e.g., 20 corresponds to the fundamental frequency and the next 19 higher harmonics).
>
> Any harmonic with a frequency exceeding the Nyquist frequency should be ignored. The function should perform the following steps:
>
> **i.** Read the audio signal from the file specified by `input_file`. If the file is stereo, retain only the left channel.
>
> **ii.** Compute the normalized notch frequencies for the first `num_harmonics` harmonics of `base_freq`, including the fundamental frequency. (Normalized frequency is as defined by (D.3).)
>
> **iii.** Design the cascade of notch filters by calling `sos_notch_filter` with the computed normalized frequencies and a pole radius of 0.999 (which controls stopband width).
>
> **iv.** Apply the cascade of filters to the noisy signal by calling `sos_filter`.
>
> **v.** Write the denoised signal to the file specified by `output_file`.
>
> **vi.** Produce a single figure with the following three plots:
>
> - the magnitude spectrum (in dB) of the noisy input signal;
> - the magnitude response (in dB) of the overall filter (formed from a cascade of notch filters);
> - the magnitude spectrum (in dB) of the denoised output signal.
>
> All three plots should use the same scale for the frequency axis, with the range $[0,F]$ where $F=\frac{3}{2}Kf_0$ (to provide a margin beyond the highest harmonic frequency).
>
> [Notation: $K$ is `num_harmonics` and $f_0$ is `base_freq`.]
>
> The following MATLAB functions may be helpful: `audioread`, `audiowrite`, `log10`, and `fft`. The `compute_dtft` and `plot_dt_spectrum` functions mentioned above may also be helpful.
>
> **b)** Using the `audio_file_remove_harmonic_noise` function developed in part (a), remove the power-line noise in the audio in the file `speech_with_powerline_noise.wav`. The power-line noise is present at 60 Hz and its harmonics up to and including $20\cdot60=1200$ Hz.
>
> **i.** Listen to both the noisy and denoised audio signals and comment on any audible differences.
>
> **ii.** Examine the three plots in the figure generated by the code. Relate what was heard to what is shown by these plots.

**Assignment handout, p. 6:** Submit the WAV file for the denoised signal.

### Idea

1. **Find the frequencies to reject.** The input file supplies the sampling rate $F_s$. If $f_0$ is the fundamental and $K$ the requested count, the target list is $f_0,2f_0,\ldots,Kf_0$. Discard targets above $F_s/2$. For the helper, normalize each interior target as $f/(F_s/2)$, not $f/F_s$.
2. **Build and apply the cascade.** One second-order section (SOS) rejects one harmonic. The supplied helpers design the sections, apply them in sequence and compute their combined response. A pole radius close to 1 gives a narrow notch, so a coarse display grid may miss its deepest point. The output WAV uses the input sampling rate.
3. **Compare all three plots in Hz.** Use the same FFT length, magnitude scaling and dB reference for input and output. Convert magnitude to dB with $20\log_{10}$; a common positive floor can be used only for display to avoid $\log_{10}(0)$. Do not normalize each audio spectrum by its own peak. The filter response is a gain, while the other panels are signal magnitudes. The saved finite-length output omits the IIR tail beyond the record, so its FFT need not equal the pointwise product of the displayed input FFT and filter response.
4. **Interpret part (b) using your results.** The target locations are 60, 120, ..., 1200 Hz and the shared plot limit is $F=1.5(20)(60)=1800$ Hz. Follow one or two target frequencies from an input peak to the corresponding notch and output spectrum. Listen to comparable portions at a common playback gain; report the differences you actually hear and use the plots to explain them.

**Nyquist boundary (extension beyond textbook steps i-vi):** The original wording excludes harmonics *above* Nyquist but does not specify how to design a section exactly at Nyquist with the supplied helper. That helper accepts only normalized frequencies strictly between 0 and 1. One way to handle equality without passing 1 to the helper is to set the notch center to $\Omega_0=\pi$ in the same second-order section design, giving

$$
H_{\mathrm{N}}(\Omega)=
\frac{(1+e^{-j\Omega})^2}{(1+r e^{-j\Omega})^2},
\qquad r=0.999.
$$

It can be appended as a separate section without changing the supplied helper. If there are no valid targets, use the unchanged signal and a unity response. If the requested plot limit $F$ exceeds Nyquist, this handout keeps the original axis limits and displays only baseband data through Nyquist. None of these boundary cases arises for the supplied WAV.

### Pseudocode

```text
Part (a): denoise and plot

Read the input WAV and its sampling rate.
If stereo, select the left channel.
Form the requested harmonics, starting at the fundamental.
Ignore targets above Nyquist.
Normalize the strictly interior targets by the Nyquist frequency.
If there are interior targets, design their sections with the supplied
    notch helper and radius 0.999; otherwise start with no sections.
If a target is exactly Nyquist, append its separately formed section (extension).
If no sections remain, use the input as the output.
Otherwise, apply the supplied cascade filter.
Save the denoised signal to the output WAV at the original sampling rate.

Compute input and output magnitudes with matching FFT settings and scaling.
If the cascade is nonempty, evaluate its response on a grid fine enough
    to resolve the notches; otherwise use unity gain for the middle panel.
Convert the three magnitudes to dB; use a display floor only if needed.
Create one figure with input spectrum, filter gain and output spectrum.
Use the requested common 0-to-F Hz axis for all three panels.
If F exceeds Nyquist, show baseband data only through Nyquist (handout's plotting choice).

Part (b): run the supplied case and report evidence

Use the supplied speech WAV, fundamental 60 Hz and harmonic count 20.
Listen to the noisy and denoised versions at comparable playback levels.
Compare the same harmonic locations across the three panels.
Describe what changed, using both the listening comparison and the plots.
Submit the denoised WAV as required by the assignment handout.
```

**References:** slides pp. 229, 237, 248-249, 567, 569; textbook §§11.14, 11.16, D.15.2.1-D.15.2.2 (pp. 720-721 for the MATLAB frequency convention and response functions). See the source comments of the companion helpers for their argument conventions.

---

Exercise text from Michael D. Adams, *Signals and Systems*, Edition 7.0.0-beta.3, University of Victoria, 2026, © 2012-2026 Michael D. Adams, [CC BY-NC-ND 3.0 Unported](https://creativecommons.org/licenses/by-nc-nd/3.0/). The derivations and pseudocode are tutorial explanations.
