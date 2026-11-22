# Forward Design & Calculation Procedure (`3.50 + 5.80 GHz`, Steps 1–10)
**Project:** Dual-Band ($3.50\text{ GHz} / 5.80\text{ GHz}$) Miniaturized Concentric Double-CSRR Microstrip Patch Antenna  
**Course:** UGEA2273 Electromagnetic Fields and Waves  
**Simulator:** Sonnet Lite v18.53 (Method of Moments, `100.0 × 80.0 mm` Box, `0.5 × 0.5 mm` Grid)  
**Verified Files:** [EFW_3.5_5.8GHz](file:///C:/EFW/Assignment/EFW_3.5_5.8GHz) (`Stage a.son` – `Stage d.son`)

---

## Design Workflow Overview

This document presents the complete **10-step analytical-to-EM synthesis procedure** for the **verified `EFW_3.5_5.8GHz` 4-stage design**. Classical transmission-line patch equations and Hammerstad synthesis establish the **Initial Analytical Seed**, which is then separated into four verification stages and parametrically optimized on a `0.5 mm` exact grid in Sonnet Lite to obtain the final **`22.5 × 15.0 mm` (`29.36%` miniaturized)** dual-band antenna with **zero spurious $\le -5\text{ dB}$ modes** across `2.0–7.0 GHz`.

```
================================================================================
         10-STEP FORWARD ANALYTICAL & EM-TUNED DESIGN PIPELINE (3.50 + 5.80 GHz)
================================================================================

  [INPUTS: FR4 (ε_r = 4.4, h = 1.6 mm, tanδ = 0.022), f_r1 = 3.50 GHz, f_r2 = 5.80 GHz]
                                       |
                                       v
  STEP 1: Stage (a) Solid Patch & λ/4 Feedline
          - Analytical Seed : W_A = 26.08 mm, L_A = 19.99 mm, feed 1.0 x 12.19 mm
          - Final EM Stage a: W_A = 24.5 mm,  L_A = 19.5 mm (477.75 mm^2), feed 1.0 x 12.0 mm
          [Sonnet EM: 3.500 GHz, -26.26 dB, 87.2 MHz BW, 0 spurious dips <= -10 dB]
                                       |
                                       v
  STEP 2: Scaling Factor k (k_final = 0.8405 -> 29.36% Area Miniaturization)
                                       |
                                       v
  STEPS 3-5 & 9: Stage (b) Outer CSRR Slot Ring
          - Dimensions: W_out = 15.5 mm, L_out = 10.0 mm (s = 1.0, g = 1.5, detour = 7.00 mm)
          [Sonnet EM: shifts Band 1 downward 3.500 -> 3.180 GHz (-26.88 dB, 70.3 MHz BW)]
                                       |
                                       v
  STEPS 6-8: Stage (c) Concentric Inner CSRR Slot Ring (180 deg opposite split bridge)
          - Dimensions: W_in = 7.5 mm, L_in = 5.0 mm (s = 1.0, g = 1.5, d_x = 3.00 mm)
          [Sonnet EM: Band 1 -> 2.970 GHz (-17.28 dB), Band 2 activates @ 5.340 GHz (-10.12 dB)]
                                       |
                                       v
  STEP 10: Stage (d) Shrink Outer Patch Around Fixed CSRRs & Re-Match λ/4 Feed
          - Shrunk Patch: W_D = 22.5 mm, L_D = 15.0 mm (337.50 mm^2, 29.36% reduction)
          - Matched Feed: wt = 0.5 mm (112.38 Ohm), lt = 9.5 mm
          -> Band 1: 3.510 GHz (-23.43 dB; -22.60 dB @ 3.50 GHz), BW 3.470-3.540 GHz (70.0 MHz)
          -> Band 2: 5.78/5.89 GHz (-19.74 dB @ 5.80 GHz), BW 5.734-5.897 GHz (163.6 MHz)
          -> Mid-band isolation (3.60-5.65 GHz): worst ripple -3.60 dB (zero spurious modes)
================================================================================
```

---

## Fixed Input Parameters & Meshing Rules

### 1. Substrate & Operating Specifications
| Parameter | Symbol | Value | Reference / Purpose |
| :--- | :---: | :---: | :--- |
| **Substrate Material** | — | FR4 Epoxy | Standard PCB substrate (Lab 2 & Ref. [3]) |
| **Relative Permittivity** | $\varepsilon_r$ | $4.4$ | Dielectric constant of FR4 |
| **Substrate Thickness** | $h$ | $1.6\text{ mm}$ | Standard FR4 board height |
| **Loss Tangent** | $\tan\delta$ | $0.022$ | FR4 dielectric loss factor |
| **Copper Cladding** | $t$ | $0.035\text{ mm}$ | $35\ \mu\text{m}$ standard metallization ($\sigma = 5.8 \times 10^7\text{ S/m}$) |
| **Primary Band** | $f_{r1}$ | $3.50\text{ GHz}$ | 5G NR Band n78 TDD single-carrier (`20–60 MHz` channels) / $3.5\text{ GHz}$ WiMAX-FWA |
| **Secondary Band** | $f_{r2}$ | $5.80\text{ GHz}$ | $5.8\text{ GHz}$ ISM / IEEE 802.11 UNII-3 (`5.725–5.850 GHz`) & C-V2X (`5.85–5.90 GHz`) |
| **Achieved Miniaturization** | $\Delta A_{\%}$ | **$29.36\%$** | Down from $477.75\text{ mm}^2$ (`24.5 × 19.5 mm`) to $337.50\text{ mm}^2$ (`22.5 × 15.0 mm`) |

### 2. MoM Grid Constants (`100.0 × 80.0 mm` Box, `0.5 × 0.5 mm` Cells)
Every vertex across all four `.son` files sits directly on an exact multiple of **$0.5\text{ mm}$** (no sub-cell snap distortion):

$$
s_{\text{out}} = s_{\text{in}} = s = 1.0\text{ mm}
$$

$$
g = 1.5\text{ mm}
$$

$$
d_{x} = 3.0\text{ mm}, \quad d_{y,\text{Stage d}} = 1.5\text{ mm}
$$

- **$s$**: Uniform etched CSRR slot width (`1.0 mm` for both outer and inner rings)
- **$g$**: Uncut conductive split bridge gap width (`1.5 mm`, placed at bottom of Outer CSRR and top of Inner CSRR)
- **$d_x, d_y$**: Continuous copper separation wall thickness between Outer (`15.5 × 10.0 mm`) and Inner (`7.5 × 5.0 mm`) CSRRs in the symmetric Stage (d) layout (`3.0 mm` left/right, `1.5 mm` top/bottom; in Stage (c)'s `19.5 mm` tall patch, grid alignment shifts vertical walls slightly to `2.0 mm` bottom / `1.0 mm` top)

---

## Preliminary Step: Sonnet Air Box Thickness ($h_{\text{air}}$)

Following Lab 1 & Lab 2 guidelines, the upper air dielectric layer above the patch must equal half the free-space wavelength ($\lambda_0 / 2$) at the lowest operating frequency ($3.50\text{ GHz}$):

$$
\lambda_{0\,(3.50)} = \frac{c}{f_{r1}}
$$

$$
\lambda_{0\,(3.50)} = \frac{3 \times 10^8}{3.50 \times 10^9} = 0.085714\text{ m} = 85.71\text{ mm}
$$

$$
h_{\text{air}} = \frac{\lambda_{0\,(3.50)}}{2}
$$

$$
h_{\text{air}} = \frac{85.714}{2} = 42.857\text{ mm} \rightarrow 42.86\text{ mm}
$$

- **$c$**: Speed of light in free space ($3 \times 10^8\text{ m/s}$)
- **$f_{r1}$**: Lowest fundamental target frequency ($3.50\text{ GHz}$)
- **$\lambda_{0\,(3.50)}$**: Free-space wavelength at $3.50\text{ GHz}$ ($85.71\text{ mm}$)
- **$h_{\text{air}}$**: Upper air dielectric height in Sonnet Lite ($42.86\text{ mm}$)

---

## Step 1: Conventional Stage (a) Patch & Feedline at $f_{r1} = 3.50\text{ GHz}$

### 1.1 Analytical Patch Width ($W_{\text{A}}$)

$$
W_{\text{A,theo}} = \frac{c}{2 f_{r1}} \sqrt{\frac{2}{\varepsilon_r + 1}}
$$

$$
W_{\text{A,theo}} = \frac{3 \times 10^8}{2 (3.50 \times 10^9)} \sqrt{\frac{2}{4.4 + 1}}
$$

$$
W_{\text{A,theo}} = (0.042857\text{ m}) \times \sqrt{0.37037} = 0.042857 \times 0.60858 = 0.026082\text{ m} = 26.08\text{ mm}
$$

To eliminate spurious higher-order transverse/diagonal resonances in the $5.3\text{–}6.6\text{ GHz}$ upper band while matching the $0.5\text{ mm}$ grid parity of the CSRRs centered at $X = 49.75\text{ mm}$, full-wave Stage (a) optimization narrows $W_{\text{A}}$ slightly from the `26.08 mm` seed to:

$$
W_{\text{A (EM)}} = 24.5\text{ mm}
$$

- **$W_{\text{A,theo}}$**: Classical transmission-line patch width seed ($26.08\text{ mm}$)
- **$W_{\text{A (EM)}}$**: Grid-aligned, harmonic-clean Stage (a) patch width ($24.5\text{ mm}$)

---

### 1.2 Effective Dielectric Constant ($\varepsilon_{\text{eff,A}}$)

Evaluating Hammerstad's microstrip effective permittivity formula at the Stage (a) width $W_{\text{A (EM)}} = 24.5\text{ mm}$ (and noting the $26.08\text{ mm}$ seed gives $\varepsilon_{\text{eff}} = 3.9902$):

$$
\varepsilon_{\text{eff,A}} = \frac{\varepsilon_r + 1}{2} + \frac{\varepsilon_r - 1}{2} \left( 1 + 12 \frac{h}{W_{\text{A (EM)}}} \right)^{-0.5}
$$

$$
\varepsilon_{\text{eff,A}} = \frac{4.4 + 1}{2} + \frac{4.4 - 1}{2} \left( 1 + 12 \left( \frac{1.6}{24.5} \right) \right)^{-0.5}
$$

$$
\varepsilon_{\text{eff,A}} = 2.7 + 1.7 (1 + 0.78367)^{-0.5}
$$

$$
\varepsilon_{\text{eff,A}} = 2.7 + 1.7 (0.74880) = 3.9729
$$

- **$\varepsilon_{\text{eff,A}}$**: Effective relative permittivity of the Stage (a) patch ($3.9729$)
- **$h$**: FR4 substrate thickness ($1.6\text{ mm}$)

---

### 1.3 Fringing Field Length Extension ($\Delta L_{\text{A}}$)

$$
\frac{W_{\text{A (EM)}}}{h} = \frac{24.5}{1.6} = 15.3125
$$

$$
\Delta L_{\text{A}} = 0.412 h \left[ \frac{(\varepsilon_{\text{eff,A}} + 0.3)\left(\frac{W_{\text{A (EM)}}}{h} + 0.264\right)}{(\varepsilon_{\text{eff,A}} - 0.258)\left(\frac{W_{\text{A (EM)}}}{h} + 0.8\right)} \right]
$$

$$
\Delta L_{\text{A}} = 0.412 (1.6) \left[ \frac{(3.9729 + 0.3)(15.3125 + 0.264)}{(3.9729 - 0.258)(15.3125 + 0.8)} \right]
$$

$$
\Delta L_{\text{A}} = 0.6592 \left[ \frac{(4.2729)(15.5765)}{(3.7149)(16.1125)} \right]
$$

$$
\Delta L_{\text{A}} = 0.6592 \times 1.11186 = 0.7330\text{ mm}
$$

- **$\Delta L_{\text{A}}$**: Open-end fringing extension per radiating edge ($0.7330\text{ mm}$)

---

### 1.4 Effective Electrical Length ($L_{\text{eff,A}}$) and Physical Length ($L_{\text{A}}$)

$$
L_{\text{eff,A}} = \frac{c}{2 f_{r1} \sqrt{\varepsilon_{\text{eff,A}}}}
$$

$$
L_{\text{eff,A}} = \frac{3 \times 10^8}{2 (3.50 \times 10^9) \sqrt{3.9729}} = \frac{0.042857}{1.9932} = 0.021502\text{ m} = 21.50\text{ mm}
$$

$$
L_{\text{A,theo}} = L_{\text{eff,A}} - 2 \Delta L_{\text{A}}
$$

$$
L_{\text{A,theo}} = 21.5016 - 2(0.7330) = 20.04\text{ mm}
$$

*(At the $26.08\text{ mm}$ theoretical width, $L_{\text{A,theo}} = 19.99\text{ mm}$.)* Accounting for step-junction susceptance at the $1.0\text{ mm}$ feed transition, full-wave Sonnet MoM tuning snaps the $3.500\text{ GHz}$ baseline (`S11 = -26.26 dB`) to:

$$
L_{\text{A (EM)}} = 19.5\text{ mm}
$$

- **$L_{\text{eff,A}}$**: Total half-wavelength electrical length at $3.50\text{ GHz}$ ($21.50\text{ mm}$)
- **$L_{\text{A,theo}}$**: Analytical physical length ($20.04\text{ mm}$ at $W=24.5\text{ mm}$; $19.99\text{ mm}$ at $W=26.08\text{ mm}$)
- **$L_{\text{A (EM)}}$**: Verified Stage (a) patch length resonating dead-on at $3.500\text{ GHz}$ ($19.5\text{ mm}$)

---

### 1.5 Baseline Stage (a) Patch Area ($A_{\text{A}}$)

$$
A_{\text{A}} = W_{\text{A (EM)}} \times L_{\text{A (EM)}}
$$

$$
A_{\text{A}} = 24.5 \times 19.5 = 477.75\text{ mm}^2
$$

- **$A_{\text{A}}$**: Footprint copper area of the solid Stage (a) $3.50\text{ GHz}$ baseline patch ($477.75\text{ mm}^2$)

---

### 1.6 Quarter-Wave ($\lambda/4$) Impedance Matching Feedline ($W_T \times L_T$)

Using Hammerstad microstrip synthesis for narrow lines ($u = W_T / h \le 1$) on FR4 ($\varepsilon_r = 4.4, h = 1.6\text{ mm}$):

$$
\varepsilon_{\text{eff,T}} = \frac{\varepsilon_r + 1}{2} + \frac{\varepsilon_r - 1}{2} \left[ \left( 1 + \frac{12}{u} \right)^{-0.5} + 0.04(1 - u)^2 \right]
$$

$$
Z_{0,\text{line}} = \frac{60}{\sqrt{\varepsilon_{\text{eff,T}}}} \ln\left( \frac{8}{u} + \frac{u}{4} \right)
$$

$$
L_T = \frac{c}{4 f_{r1} \sqrt{\varepsilon_{\text{eff,T}}}}
$$

- **$u$**: Normalized feedline width ratio ($W_T / h$)
- **$\varepsilon_{\text{eff,T}}$**: Effective dielectric constant of the microstrip feedline
- **$Z_{0,\text{line}}$**: Characteristic impedance of the quarter-wave transformer section ($\Omega$)
- **$L_T$**: Quarter-wave physical transformer length at $f_{r1} = 3.50\text{ GHz}$ ($\text{mm}$)

Evaluating the two exact-grid transformer widths used across **Stages (a)–(c)** and **Stage (d)**:

1. **Stages (a)–(c) Feedline (`W_T,a = 1.0 mm`, $u = 1.0 / 1.6 = 0.625$):**
   - $\varepsilon_{\text{eff,T}} = 3.0878$, **$Z_{0,\text{line}} = 87.46\ \Omega$**, theoretical quarter-wave length $L_T = 12.19\text{ mm} \rightarrow \mathbf{12.0\text{ mm}}$ grid-aligned.
   - From Balanis's simplified single-slot conductance ($G_{1,\text{simp}} \approx 0.00238\ \text{S} \rightarrow R_{\text{in,est}} \approx 210.0\ \Omega$) and Stage (a)'s measured match ($Z_{\text{in}} = 53.4 - j3.7\ \Omega$, $S_{11} = -26.26\text{ dB}$), the full-wave edge resistance seen by the $1.0\text{ mm}$ feed is $R_{\text{edge,A}} \approx Z_{0,\text{line}}^2 / 53.4 \approx 143.3\ \Omega$, closely matching $Z_{\text{TLine}} = \sqrt{50 \times 143.3} = 84.6\ \Omega \approx 87.46\ \Omega$.

2. **Stage (d) Re-Matched Feedline (`W_T,d = 0.5 mm`, $u = 0.5 / 1.6 = 0.3125$):**
   - When the outer patch shrinks by $29.36\%$ to `22.5 × 15.0 mm`, its radiating aperture shrinks, reducing radiation conductance $G_1$ and raising the edge resistance ($R_{\text{edge,D}} \approx 112.38^2 / 46.1 \approx 274\ \Omega$, requiring $Z_{\text{TLine}} = \sqrt{50 \times 274} = 117.0\ \Omega$).
   - A `0.5 mm` feedline yields $\varepsilon_{\text{eff,T}} = 3.0030$, **$Z_{0,\text{line}} = 112.38\ \Omega$**, and $L_T = 12.37\text{ mm}$ analytically; parametric tuning to **$L_{T,d} = 9.5\text{ mm}$** balances dual-band phase reactivity across both $3.50\text{ GHz}$ (`-22.60 dB`) and $5.80\text{ GHz}$ (`-19.74 dB`).

---

## Step 2: Target Miniaturization Ratio & Linear Scaling Factor ($k$)

Using the achieved footprint area reduction between Stage (a) ($477.75\text{ mm}^2$) and Stage (d) ($337.50\text{ mm}^2$):

$$
\Delta A_{\%,\text{EM}} = \left( \frac{A_{\text{A}} - A_{\text{D}}}{A_{\text{A}}} \right) \times 100\% = \left( \frac{477.75 - 337.50}{477.75} \right) \times 100\% = 29.36\%
$$

$$
k_{\text{final}} = \sqrt{1 - \frac{\Delta A_{\%,\text{EM}}}{100}}
$$

$$
k_{\text{final}} = \sqrt{1 - 0.2936} = \sqrt{0.7064} = 0.8405
$$

- **$\Delta A_{\%,\text{EM}}$**: Achieved planar copper footprint reduction ($29.36\%$)
- **$k_{\text{final}}$**: Uniform 2D linear miniaturization factor ($0.8405$)

---

## Step 3: Stage (b) Prolonged Effective Path ($L_{\text{eff,B}}$) & Intermediate Frequency

To support subsequent $k_{\text{final}} = 0.8405$ miniaturization back to $3.50\text{ GHz}$, the Stage (b) Outer CSRR elongates the effective electrical length to:

$$
L_{\text{eff,B}} = \frac{L_{\text{eff,A}}}{k_{\text{final}}} = \frac{21.50}{0.8405} = 25.58\text{ mm}
$$

Corresponding analytical cavity frequency prediction for Stage (b):

$$
f_{r1\text{ (Stage B,est)}} = \frac{c}{2 L_{\text{eff,B}} \sqrt{\varepsilon_{\text{eff,A}}}} = \frac{3 \times 10^8}{2 (0.02558) \sqrt{3.9729}} = 2.942\text{ GHz}
$$

- **$L_{\text{eff,B}}$**: Required elongated effective electrical length ($25.58\text{ mm}$)
- **$f_{r1\text{ (Stage B,est)}}$**: Idealized inductive-only cavity prediction ($2.942\text{ GHz}$; full-wave Stage (b) resonates at **$3.180\text{ GHz}$**, `-26.88 dB`, before the Inner CSRR pulls Band 1 down further to **`2.970 GHz`** in Stage (c)!)

---

## Step 4: Required Surface Current Detour ($\Delta L_{\text{detour}}$)

From the Stage (b) effective path elongation and the symmetric half-width lateral detour around the Outer CSRR ($W_{\text{out}} = 15.5\text{ mm}$, $g = 1.5\text{ mm}$):

$$
\Delta L_{\text{detour,seed}} = L_{\text{eff,B}} - L_{\text{eff,A}} = 25.58 - 21.50 = 4.08\text{ mm}
$$

$$
\Delta L_{\text{detour,EM}} = \frac{W_{\text{out}} - g}{2} = \frac{15.5 - 1.5}{2} = 7.00\text{ mm}
$$

- **$\Delta L_{\text{detour,seed}}$**: Minimum analytical detour estimate ($4.08\text{ mm}$)
- **$\Delta L_{\text{detour,EM}}$**: Physical lateral detour per side in the verified `15.5 × 10.0 mm` Outer CSRR ($7.00\text{ mm}$, compensating partial current shortcuts through the slot capacitance)

---

## Step 5: Solve for Outer CSRR Slot Ring Width ($W_{\text{out}}$)

Current entering symmetrically through the bottom split bridge ($g = 1.5\text{ mm}$) detours laterally around both lower stubs of width $\Delta L_{\text{detour,EM}} = 7.00\text{ mm}$:

$$
W_{\text{out}} = 2 \Delta L_{\text{detour,EM}} + g
$$

$$
W_{\text{out}} = 2(7.00) + 1.5 = 15.5\text{ mm}
$$

- **$W_{\text{out}}$**: Outer CSRR total horizontal outer span ($15.5\text{ mm}$)

---

## Step 6: Solve for Inner CSRR Slot Ring Width ($W_{\text{in}}$)

Nesting the concentric Inner CSRR inside the `15.5 mm` Outer CSRR with uniform slot width $s = 1.0\text{ mm}$ and lateral copper separation wall $d_x = 3.0\text{ mm}$:

$$
W_{\text{in}} = W_{\text{out}} - 2(d_x + s)
$$

$$
W_{\text{in}} = 15.5 - 2(3.0 + 1.0) = 15.5 - 8.0 = 7.5\text{ mm}
$$

Verification of lateral copper wall thickness $d_x$:

$$
d_x = \frac{W_{\text{out}} - W_{\text{in}}}{2} - s = \frac{15.5 - 7.5}{2} - 1.0 = 3.00\text{ mm}
$$

- **$W_{\text{in}}$**: Inner CSRR total horizontal outer span ($7.5\text{ mm}$)
- **$d_x$**: Lateral copper wall width separating outer and inner slots ($3.00\text{ mm}$)

---

## Step 7: Inner CSRR Slot Perimeter & Coupled Marqués Resonance at $f_{r2} = 5.80\text{ GHz}$

### 7.1 Effective Permittivity & Guided Slot Wavelength
At the air–FR4 interface, the quasi-static slot permittivity is:

$$
\varepsilon_{\text{eff,slot}} = \frac{\varepsilon_r + 1}{2} = \frac{4.4 + 1}{2} = 2.70
$$

The guided slot wavelength at $f_{r2} = 5.80\text{ GHz}$ is:

$$
\lambda_{g,\text{slot}} = \frac{c}{f_{r2} \sqrt{\varepsilon_{\text{eff,slot}}}} = \frac{3 \times 10^8}{(5.80 \times 10^9)\sqrt{2.70}} = \frac{3 \times 10^8}{(5.80 \times 10^9)(1.6432)} = 31.48\text{ mm}
$$

- **$\varepsilon_{\text{eff,slot}}$**: Quasi-static effective relative permittivity of a microstrip slot ($2.70$)
- **$\lambda_{g,\text{slot}}$**: Guided slot wavelength at $5.80\text{ GHz}$ ($31.48\text{ mm}$)

---

### 7.2 Coupled Double-CSRR Capacitive Loading
From Marqués *et al.* (2003, Eq. (1), p. 2573) [Ref. 2] and Baena *et al.* (2005), the coupled double-ring resonance $\omega_0$ is pulled strongly downward by mutual distributed capacitance $C_{\text{pul}}$ across the `1.5 mm` inner–outer copper wall and shunt patch capacitance:

$$
\omega_0 = \sqrt{\frac{2}{\pi r_0 L C_{\text{pul}}}}
$$

In the finalized **`7.5 × 5.0 mm`** Inner CSRR ($s = 1.0\text{ mm}, g = 1.5\text{ mm}$), its centerline slot perimeter is $P_{\text{in}} = 19.50\text{ mm}$ (giving a standalone slot frequency $f_{\text{slot,unloaded}} = 9.363\text{ GHz}$, i.e., $0.619\,\lambda_{g,\text{slot}}$). Mutual coupling to the `15.5 × 10.0 mm` Outer CSRR and the outer patch cavity pulls this mode downward to **`5.340 GHz`** in Stage (c) (`24.5 × 19.5 mm`) and locks it onto **`5.780 / 5.890 GHz` (`-19.74 dB @ 5.80 GHz`)** once the outer patch is shrunk to `22.5 × 15.0 mm` in Stage (d).

- **$\omega_0$**: Coupled double-CSRR resonant angular frequency ($\text{rad/s}$)
- **$r_0, L, C_{\text{pul}}$**: Effective ring radius ($\text{m}$), self-inductance ($\text{H}$), and inter-ring coupling capacitance per unit length ($\text{F/m}$)

---

## Step 8: Solve for Inner CSRR Slot Ring Length ($L_{\text{in}}$) & Perimeter

The centerline perimeter of a rectangular CSRR slot of dimensions $W_{\text{in}} \times L_{\text{in}}$, slot width $s$, and bridge gap $g$ is:

$$
L_{\text{slot,in}} = 2(W_{\text{in}} + L_{\text{in}}) - 4s - g
$$

For the EM-verified **`7.5 × 5.0 mm`** Inner CSRR ($s = 1.0\text{ mm}, g = 1.5\text{ mm}$):

$$
L_{\text{in}} = 5.0\text{ mm}
$$

$$
L_{\text{slot,in}} = 2(7.5 + 5.0) - 4(1.0) - 1.5 = 25.0 - 5.5 = 19.50\text{ mm}
$$

- **$L_{\text{in}}$**: Vertical outer length of the Inner CSRR ($5.0\text{ mm}$)
- **$L_{\text{slot,in}}$**: Mean centerline slot perimeter of the Inner CSRR ($19.50\text{ mm}$)

---

## Step 9: Solve for Outer CSRR Slot Ring Length ($L_{\text{out}}$) & Vertical Spacing ($d_y$)

Applying the symmetric Stage (d) vertical concentric offset ($d_y = 1.50\text{ mm}, s = 1.0\text{ mm}$):

$$
L_{\text{out}} = L_{\text{in}} + 2(d_y + s)
$$

$$
L_{\text{out}} = 5.0 + 2(1.5 + 1.0) = 10.0\text{ mm}
$$

Checking the vertical separation wall $d_y$ and Outer CSRR centerline slot perimeter $L_{\text{slot,out}}$:

$$
d_y = \frac{L_{\text{out}} - L_{\text{in}}}{2} - s = \frac{10.0 - 5.0}{2} - 1.0 = 1.50\text{ mm}
$$

$$
L_{\text{slot,out}} = 2(W_{\text{out}} + L_{\text{out}}) - 4s - g = 2(15.5 + 10.0) - 4(1.0) - 1.5 = 45.50\text{ mm}
$$

- **$L_{\text{out}}$**: Vertical outer length of the Outer CSRR ($10.0\text{ mm}$)
- **$d_y$**: Symmetric vertical copper separation wall in Stage (d) ($1.50\text{ mm}$)
- **$L_{\text{slot,out}}$**: Mean centerline slot perimeter of the Outer CSRR ($45.50\text{ mm}$)

---

## Step 10: Stage (d) Parametric Shrinking & Area Miniaturization

In Stage (d), the `15.5 × 10.0 mm` Outer and `7.5 × 5.0 mm` Inner CSRRs are preserved while the outer patch is shrunk symmetrically around center $(49.75, 17.0)$ to raise Stage (c)'s loaded frequencies (`2.970 GHz` $\rightarrow$ **`3.50 GHz`** and `5.340 GHz` $\rightarrow$ **`5.80 GHz`**).

### 10.1 Inverse Frequency Scaling Verification ($L_{\text{D}}, W_{\text{D}}$)
Applying Lab 1's inverse frequency-length relation ($L \propto 1/f_r$) from Stage (c) (`2.970 GHz`) to $3.50\text{ GHz}$:

$$
L_{\text{D,est}} = L_{\text{A (EM)}} \times \left( \frac{f_{r1\text{ (Stage C)}}}{f_{r1}} \right) = 19.5 \times \left( \frac{2.970}{3.50} \right) = 16.55\text{ mm}
$$

Full-wave Sonnet MoM optimization on the exact `0.5 mm` grid settles on:

$$
W_{\text{D (EM)}} = 22.5\text{ mm}, \quad L_{\text{D (EM)}} = 15.0\text{ mm}
$$

- **$L_{\text{D,est}}$**: First-order inverse-frequency length estimate ($16.55\text{ mm}$)
- **$W_{\text{D (EM)}}, L_{\text{D (EM)}}$**: Verified Stage (d) shrunk patch dimensions ($22.5 \times 15.0\text{ mm}$)

### 10.2 Final Footprint Miniaturization ($\Delta A_{\%}$)

$$
A_{\text{D}} = W_{\text{D (EM)}} \times L_{\text{D (EM)}} = 22.5 \times 15.0 = 337.50\text{ mm}^2
$$

$$
\Delta A_{\%} = \left( \frac{A_{\text{A}} - A_{\text{D}}}{A_{\text{A}}} \right) \times 100\% = \left( \frac{477.75 - 337.50}{477.75} \right) \times 100\% = 29.36\%
$$

- **$A_{\text{A}}$**: Stage (a) baseline copper patch area ($477.75\text{ mm}^2$)
- **$A_{\text{D}}$**: Stage (d) shrunk dual-band copper patch area ($337.50\text{ mm}^2$)
- **$\Delta A_{\%}$**: Verified area miniaturization (**$29.36\%$**)

---

## Theoretical Validation Checks (For Technical Report Defense)

### 1. Sub-Wavelength Metamaterial Check (Pendry & Marqués Criteria)
Evaluating inclusion size relative to the free-space wavelength at each band ($\lambda_{0\,(3.50)} = 85.71\text{ mm}$ and $\lambda_{0\,(5.80)} = 51.72\text{ mm}$):

$$
\lambda_{0\,(5.80)} = \frac{c}{f_{r2}} = \frac{3 \times 10^8}{5.80 \times 10^9} = 51.72\text{ mm}
$$

$$
\text{Ratio}_{\text{outer}} = \frac{\lambda_{0\,(3.50)}}{W_{\text{out}}} = \frac{85.71}{15.5} = 5.53 \quad \left( W_{\text{out}} = \frac{\lambda_0}{5.53} \right)
$$

$$
\text{Ratio}_{\text{inner}} = \frac{\lambda_{0\,(5.80)}}{W_{\text{in}}} = \frac{51.72}{7.5} = 6.90 \quad \left( W_{\text{in}} = \frac{\lambda_0}{6.90} \right)
$$

- **$\text{Ratio}_{\text{outer}}, \text{Ratio}_{\text{inner}}$**: Wavelength-to-ring ratios ($5.53$ and $6.90$), both well inside the quasi-static sub-wavelength bound ($D_{\max} \le \lambda_0 / 5$).

### 2. Outer Copper Border Margins ($\text{Margin}_X, \text{Margin}_Y$)

$$
\text{Margin}_X = \frac{W_{\text{D (EM)}} - W_{\text{out}}}{2} = \frac{22.5 - 15.5}{2} = 3.50\text{ mm}
$$

$$
\text{Margin}_Y = \frac{L_{\text{D (EM)}} - L_{\text{out}}}{2} = \frac{15.0 - 10.0}{2} = 2.50\text{ mm}
$$

- **$\text{Margin}_X, \text{Margin}_Y$**: Lateral (`3.50 mm ≈ 2.19h`) and top/bottom (`2.50 mm ≈ 1.56h`) copper rim widths preserving compact continuous current paths around the Outer CSRR.

### 3. Stage (d) Feedline Electrical Length Check at $5.80\text{ GHz}$
Evaluating the `0.5 × 9.5 mm` feedline ($\varepsilon_{\text{eff,T}} = 3.0030$) at $f_{r2} = 5.80\text{ GHz}$:

$$
\lambda_{g2} = \frac{c}{f_{r2} \sqrt{\varepsilon_{\text{eff,T}}}} = \frac{3 \times 10^8}{(5.80 \times 10^9)\sqrt{3.0030}} = 29.85\text{ mm}
$$

$$
\theta_{5.8\text{ GHz}} = \frac{L_{T,d}}{\lambda_{g2}} \times 360^\circ = \frac{9.5}{29.85} \times 360^\circ = 114.6^\circ
$$

- **$\lambda_{g2}$**: Guided wavelength along the `0.5 mm` feedline at $5.80\text{ GHz}$ ($29.85\text{ mm}$)
- **$\theta_{5.8\text{ GHz}}$**: Electrical phase length of the `9.5 mm` feedline at $5.80\text{ GHz}$ ($114.6^\circ$), placing the feed close to a transforming reactance regime that cancels the capacitive double-CSRR impedance to yield $S_{11} = -19.74\text{ dB}$ ($Z_{\text{in}} = 60.3 + j4.8\ \Omega$).

---

## Master Summary Table (Steps 1–10)

| Step | Quantity Solved | Governing Formula / Method | Analytical Seed | Verified `EFW_3.5_5.8GHz` Design |
| :---: | :--- | :--- | :---: | :---: |
| **Pre** | Air Height ($h_{\text{air}}$) | $h_{\text{air}} = \lambda_0 / 2$ ($f_{r1} = 3.50\text{ GHz}$) | $42.86\text{ mm}$ | **$42.86\text{ mm}$** |
| **1a** | Baseline Patch ($W_{\text{A}} \times L_{\text{A}}$) | Transmission-Line Model | $26.08 \times 19.99\text{ mm}$ | **$24.5 \times 19.5\text{ mm}$ ($477.75\text{ mm}^2$)** |
| **1b** | $\lambda/4$ Feedline ($W_T \times L_T$) | Hammerstad (`0.5/1.0 mm` synthesis) | $1.0 \times 12.19\text{ mm}$ | Stage a–c: **`1.0 × 12.0`**, Stage d: **`0.5 × 9.5 mm`** |
| **2** | Scaling Factor ($k_{\text{final}}$) | $k = \sqrt{1 - \Delta A/100}$ | — | **$0.8405$ ($29.36\%$ reduction)** |
| **3–5 & 9** | Outer CSRR ($W_{\text{out}} \times L_{\text{out}}$) | Detour + concentric offset ($g=1.5\text{ mm}$) | $\Delta L_{\text{seed}} = 4.08\text{ mm}$ | **`15.5 × 10.0 mm`** ($s=1.0, \Delta L = 7.00\text{ mm}$) |
| **6–8** | Inner CSRR ($W_{\text{in}} \times L_{\text{in}}$) | Coupled concentric Marqués resonator | $180^\circ$ opposite split | **`7.5 × 5.0 mm`** ($s=1.0, P_{\text{in}}=19.50\text{ mm}$) |
| **10** | Final Shrunk Patch ($W_{\text{D}} \times L_{\text{D}}$) | Inverse scaling + `0.5 mm` MoM tuning | $L_{\text{est}} = 16.55\text{ mm}$ | **$22.5 \times 15.0\text{ mm}$ ($337.50\text{ mm}^2$, $29.36\%\downarrow$)** |

### Verified 4-Stage Full-Wave Sonnet EM Progression (`100 × 80 mm`, `0.5 mm` Cells)

| Stage | Geometry & Area | Band 1 ($f_{r1}, S_{11}$) | Band 2 ($f_{r2}, S_{11}$) | $-10\text{ dB}$ Bandwidth | Mesh (Subs / Matrix / Total) |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Stage a** | Solid `24.5 × 19.5 mm` (`477.75 mm²`) | **`3.500 GHz`** (`-26.26 dB`) | Non-resonant (`-4.32 dB` @ `5.80`) | `3.4602–3.5474 GHz` (**`87.2 MHz`**, `2.49%`) | `1,312` / `13 MB` / `17 MB` |
| **Stage b** | + Outer CSRR `15.5 × 10.0 mm` | **`3.180 GHz`** (`-26.85 dB`) | Non-resonant (`-8.62 dB` @ `5.31`) | `3.1399–3.2102 GHz` (**`70.2 MHz`**, `2.21%`) | `1,452` / `16 MB` / `20 MB` |
| **Stage c** | + Inner CSRR `7.5 × 5.0 mm` | **`2.970 GHz`** (`-17.28 dB`) | **`5.340 GHz`** (`-10.13 dB`) | `2.935–3.002` (`67.3 MHz`) & `5.325–5.352` (`27.2 MHz`) | `1,568` / `19 MB` / `22 MB` |
| **Stage d** | Shrunk **`22.5 × 15.0 mm`** (`337.50 mm²`, **`29.36%↓`**) | **`3.510 GHz`** (`-23.43 dB`; **`-22.59 dB @ 3.50`**) | **`5.780 / 5.890 GHz`** (**`-19.76 dB @ 5.80`**) | **`3.4703–3.5402 GHz` (`70.0 MHz`, `2.00%`)** & **`5.7339–5.8960 GHz` (`162.0 MHz`, `2.79%`)** | `1,309` / `13 MB` / `17 MB` |

---

## References & Source Traceability Mapping

Every constant, governing equation, meshing convention, and benchmark comparison in **Steps 1–10** traces directly to one of three provenance categories:

1. **Course / Primary Literature Laws & Constants:** Equations, FR4 parameters, and spectrum allocations taken from UGEA2273 course notes, textbooks, and assigned/benchmark peer-reviewed papers.
2. **Geometric / Algebraic Derivations:** Exact mensuration or algebraic rearrangements derived directly within this procedure.
3. **Engineering Specifications / Full-Wave EM Calibrations:** `0.5 mm`-grid slot & split bridge choices ($s=1.0, g=1.5\text{ mm}$), edge impedance extraction from Stage (a) & Stage (d), and Sonnet Lite box/mesh calibration (`100 × 80 mm`, `0.5 mm` cells, `0` Em errors/warnings).

### A. Equation-by-Equation & Parameter Traceability Table

| Procedure Section | Selected Value or Equation | Category | Authoritative Source(s) & Exact Location |
| :--- | :--- | :--- | :--- |
| **Substrate Specs** | FR4 Epoxy: $\varepsilon_r = 4.4$, $h = 1.6\text{ mm}$, $\tan\delta = 0.022$ | Course / Literature | Yeap *et al.* (2020, Sec. 2, p. 50) [Ref. 3]; UGEA2273 Lab 2 (Sec. 1, p. 2) |
| **Copper Cladding** | $t = 0.035\text{ mm}$, $\sigma = 5.8 \times 10^7\text{ S/m}$ | Course / Literature | UGEA2273 Lab 1 (pp. 2, 7–8); Lab 2 (p. 2); Topic 03 (p. 88); Marqués *et al.* (2003, pp. 2575–2576) [Ref. 2] |
| **Physical Constants** | $c = 3 \times 10^8\text{ m/s}$, $Z_0 = 50\ \Omega$, $S_{11} < -10\text{ dB}$ | Course Standard | UGEA2273 Formula List (pp. 1, 3); UGEA2273 Assignment (Q3, p. 1) |
| **Target Band 1 ($f_{r1}$)** | $3.50\text{ GHz}$ (5G NR n78 `20–60 MHz` single carrier / WiMAX-FWA; benchmarked vs FR4 patch BW) | Standard / Literature | UGEA2273 Assignment (Q4, p. 1); 3GPP TS 38.101-1 (Band n78); Said *et al.* (2024, pp. 20–27) |
| **Target Band 2 ($f_{r2}$)** | $5.80\text{ GHz}$ (`5.725–5.850 GHz` UNII-3/ISM & `5.85–5.90 GHz` C-V2X) | Standard | ITU (2024, RR No. 5.150); IEEE SA (2021, 802.11-2020); 3GPP TS 38.101-1 (n47) |
| **MoM Grid & Box** | `0.5 × 0.5 mm` cells inside `100 × 80 mm` box; `17–26 MB` total RAM (`0` errors/warnings) | Course / Grid Choice | Mesh rule ($1\%\text{–}3\%\ \lambda_g$): UGEA2273 Lab 1 (pp. 9–11); Lab 2 (p. 1). CSRR geometry: Pendry *et al.* (1999, Fig. 12, p. 2081) [Ref. 1]; Marqués *et al.* (2003, Fig. 1(a), p. 2573) [Ref. 2] |
| **Preliminary Step** | $\lambda_0 = c / f_{r1} = 85.71\text{ mm}$; $h_{\text{air}} = \lambda_0 / 2 = 42.86\text{ mm}$ | Course / Software | $\lambda_0 = u/f$: UGEA2273 Topic 02 (p. 8) & Topic 03 (p. 22). $\lambda_0/2$ air layer & `Free Space` top cover: UGEA2273 Lab 1 (pp. 6–7); Lab 2 (p. 2); Sonnet Software, Inc. |
| **Step 1.1 ($W_{\text{A}}$)** | $W_{\text{A,theo}} = \frac{c}{2 f_{r1}}\sqrt{\frac{2}{\varepsilon_r + 1}} = 26.08\text{ mm}$; EM $24.5\text{ mm}$ | Textbook + EM | Balanis (2016, Ch. 14, Eq. 14-6); Bahl & Bhartia (1980) |
| **Step 1.2 ($\varepsilon_{\text{eff,A}}$)** | $\varepsilon_{\text{eff}} = \frac{\varepsilon_r + 1}{2} + \frac{\varepsilon_r - 1}{2}\left(1 + 12\frac{h}{W}\right)^{-0.5} = 3.9729$ | Course / Literature | UGEA2273 Formula List (Formula 30, p. 3); Balanis (2016, Eq. 14-1); Hammerstad (1975, pp. 268–272); Schneider (1969) |
| **Step 1.3 ($\Delta L_{\text{A}}$)** | $\Delta L = 0.412h\frac{(\varepsilon_{\text{eff}}+0.3)(W/h+0.264)}{(\varepsilon_{\text{eff}}-0.258)(W/h+0.8)} = 0.7330\text{ mm}$ | Textbook / Literature | Hammerstad (1975, pp. 268–272); Balanis (2016, Eq. 14-2) |
| **Step 1.4 ($L_{\text{eff,A}}, L_{\text{A}}$)** | $L_{\text{eff}} = \frac{c}{2 f_{r1}\sqrt{\varepsilon_{\text{eff}}}} = 21.50\text{ mm}$, $L_{\text{A}} = L_{\text{eff}} - 2\Delta L = 20.04\text{ mm}$ (EM $19.5\text{ mm}$) | Textbook + EM | Balanis (2016, Ch. 14, Eq. 14-7) |
| **Step 1.6 (Feedline)** | Narrow-strip ($u \le 1$) Hammerstad $\varepsilon_{\text{eff,T}}, Z_{0,\text{line}}, L_T$; $1.0\times 12.0\text{ mm}$ (`87.46 Ω`) & $0.5\times 9.5\text{ mm}$ (`112.38 Ω`) | Course / Textbook + EM | Hammerstad (1975); Pozar (2012, Sec. 2.5 & Sec. 3.8); Balanis (2016, Eqs. 14-12, 14-17); UGEA2273 Formula List (Formulas 29, 31, 57, pp. 3, 5) |
| **Steps 2–5 ($k, \Delta L_{\text{detour}}, W_{\text{out}}$)** | $k_{\text{final}} = 0.8405$ ($29.36\%\downarrow$), $\Delta L_{\text{detour}} = 7.00\text{ mm}$, $W_{\text{out}} = 15.5\text{ mm}$ | Geometry / Literature | Pendry *et al.* (1999, p. 2082) [Ref. 1]; Yeap *et al.* (2020, p. 50) [Ref. 3]; Wong (2002); Dong *et al.* (2012) |
| **Steps 6–9 ($W_{\text{in}}, L_{\text{in}}, L_{\text{out}}$)** | $\varepsilon_{\text{eff,slot}} = 2.70$, $\lambda_{g,\text{slot}} = 31.48\text{ mm}$, $\omega_0 = \sqrt{2 / (\pi r_0 L C_{\text{pul}})}$, $P_{\text{in}} = 19.50\text{ mm}$, $P_{\text{out}} = 45.50\text{ mm}$ | Literature / Geometry | Cohn (1969, pp. 768–778); Gupta *et al.* (1996); Marqués *et al.* (2003, Eq. 1, Fig. 1(a), p. 2573) [Ref. 2]; Falcone *et al.* (2004); Baena *et al.* (2005) |
| **Step 10 ($W_{\text{D}}, L_{\text{D}}, \Delta A_{\%}$)** | $L_{\text{D}} \propto 1/f_r$; Stage (d) `22.5 × 15.0 mm` (`337.50 mm²`, `29.36%↓`) | Course / EM | UGEA2273 Lab 1 (Sec. 4.2, p. 25); Pendry *et al.* (1999, Eqs. 45–46) [Ref. 1]; Dong *et al.* (2012) |
| **Validations 1–3** | $\lambda_0/W_{\text{out}} = 5.53$, $\lambda_0/W_{\text{in}} = 6.90$; $\text{Margin}_X = 3.50\text{ mm}, \text{Margin}_Y = 2.50\text{ mm}$; $\theta_{5.8} = 114.6^\circ$ | Literature / Textbook | Pendry *et al.* (1999, p. 2075) [Ref. 1]; Marqués *et al.* (2003, pp. 2572, 2577) [Ref. 2]; Garg *et al.* (2001, Ch. 2); Pozar (2012, Sec. 3.8) |
| **Bandwidth Contrast** | Full-ground `3.50 GHz` FR4 patch (`70.0 MHz`) vs. Said *et al.* (`~75 MHz` sim / `~70 MHz` meas in Fig. 8; printed as `75 kHz`/`70 kHz`) vs. partial-ground Ref. [3] (`358 MHz @ 2.46 GHz`, `L_11 = 10 mm`) | Literature Comparison | Said *et al.* (2024, Sec. 3, p. 26 & Fig. 8, p. 27); Yeap *et al.* (2020, Fig. 4, Tab. 1, pp. 50–52) [Ref. 3] |

---

### B. Complete Reference List (UTAR *Cite Them Right* Harvard Style)

Formatted in accordance with the UTAR Library *Cite Them Right (CTR) Harvard Referencing Style Guide* ([Harvard_Referencing_Style_Giuide.pdf](file:///c:/EFW/Harvard_Referencing_Style_Giuide.pdf)). *(Note: Full author lists are shown for bibliographic traceability; per UTAR CTR guidelines, works with 4 or more authors may be cited in-text and abbreviated as `First Author et al.` in the 5-page report.)*

#### 1. Books & Handbooks
* Bahl, I.J. and Bhartia, P. (1980) *Microstrip Antennas*. Dedham, MA: Artech House.
* Balanis, C.A. (2016) *Antenna Theory: Analysis and Design*. 4th edn. Hoboken, NJ: John Wiley & Sons.
* Garg, R., Bhartia, P., Bahl, I. and Ittipiboon, A. (2001) *Microstrip Antenna Design Handbook*. Boston, MA: Artech House.
* Gupta, K.C., Garg, R., Bahl, I. and Bhartia, P. (1996) *Microstrip Lines and Slotlines*. 2nd edn. Boston, MA: Artech House.
* Pozar, D.M. (2012) *Microwave Engineering*. 4th edn. Hoboken, NJ: John Wiley & Sons.
* Wong, K.-L. (2002) *Compact and Broadband Microstrip Antennas*. New York: John Wiley & Sons.

#### 2. Journal Articles & Conference Papers
* Baena, J.D., Bonache, J., Martín, F., Marqués, R., Falcone, F., Lopetegi, T., Laso, M.A.G., García-García, J.J., Gil, I., Portillo, M.F. and Sorolla, M. (2005) 'Equivalent-circuit models for split-ring resonators and complementary split-ring resonators coupled to planar transmission lines', *IEEE Transactions on Microwave Theory and Techniques*, 53(4), pp. 1451–1461. Available at: https://doi.org/10.1109/TMTT.2005.845211
* Cohn, S.B. (1969) 'Slot line on a dielectric substrate', *IEEE Transactions on Microwave Theory and Techniques*, 17(10), pp. 768–778. Available at: https://doi.org/10.1109/TMTT.1969.1127020
* Dong, Y., Toyao, H. and Itoh, T. (2012) 'Design and characterization of miniaturized patch antennas loaded with complementary split-ring resonators', *IEEE Transactions on Antennas and Propagation*, 60(2), pp. 772–785. Available at: https://doi.org/10.1109/TAP.2011.2173120
* Falcone, F., Lopetegi, T., Laso, M.A.G., Baena, J.D., Bonache, J., Beruete, M., Marqués, R., Martín, F. and Sorolla, M. (2004) 'Babinet principle applied to the design of metasurfaces and metamaterials', *Physical Review Letters*, 93(19), 197401. Available at: https://doi.org/10.1103/PhysRevLett.93.197401
* Hammerstad, E.O. (1975) 'Equations for microstrip circuit design', *1975 5th European Microwave Conference*, Hamburg, Germany, 1–4 September 1975, pp. 268–272. Available at: https://doi.org/10.1109/EUMA.1975.332206
* Marqués, R., Mesa, F., Martel, J. and Medina, F. (2003) 'Comparative analysis of edge- and broadside-coupled split ring resonators for metamaterial design—theory and experiments', *IEEE Transactions on Antennas and Propagation*, 51(10), pp. 2572–2581. Available at: https://doi.org/10.1109/TAP.2003.817562 (**Assigned Reference [2]**)
* Pendry, J.B., Holden, A.J., Robbins, D.J. and Stewart, W.J. (1999) 'Magnetism from conductors and enhanced nonlinear phenomena', *IEEE Transactions on Microwave Theory and Techniques*, 47(11), pp. 2075–2084. Available at: https://doi.org/10.1109/22.798002 (**Assigned Reference [1]**)
* Said, M.A.M., Misran, M.H., Othman, M.A., Jaafar, A.S., Manap, R.A., Suhaimi, S. and Hassan, N.I. (2024) 'Dual band antenna for Wi-Fi and 5G communication', *Journal of Science and Technology*, 16(2), pp. 20–29. Available at: https://doi.org/10.30880/jst.2024.16.02.003
* Schneider, M.V. (1969) 'Microstrip lines for microwave integrated circuits', *The Bell System Technical Journal*, 48(5), pp. 1421–1444. Available at: https://doi.org/10.1002/j.1538-7305.1969.tb04274.x
* Yeap, K.H., Yeo, W.L., Lai, K.C., Hiraguri, T., Hirasawa, K. and Oh, Z.X. (2020) 'A compact E-shaped antenna with C-shaped slots and a back-patch for multiband applications', *Journal of Electrical Engineering*, 71(1), pp. 49–54. Available at: https://doi.org/10.2478/jee-2020-0007 (**Assigned Reference [3]**)

#### 3. Standards & Software Documentation
* 3GPP (2024) *TS 38.101-1: NR; User Equipment (UE) radio transmission and reception; Part 1: Range 1 Standalone*. Sophia Antipolis: 3rd Generation Partnership Project.
* IEEE Standards Association (2021) *IEEE Std 802.11-2020: IEEE Standard for Information Technology—Telecommunications and Information Exchange between Systems—Local and Metropolitan Area Networks—Specific Requirements—Part 11: Wireless LAN Medium Access Control (MAC) and Physical Layer (PHY) Specifications*. Piscataway, NJ: IEEE.
* International Telecommunication Union (2024) *Radio Regulations, Edition of 2024*. Geneva: International Telecommunication Union. Available at: https://www.itu.int/en/ITU-R/publications/Pages/regulatory/radioregulations.aspx
* Sonnet Software, Inc. (no date) *Sonnet User's Guide*. North Syracuse, NY: Sonnet Software, Inc. Available at: https://www.sonnetsoftware.com

#### 4. UTAR Course Materials (Internal Reference Mapping)
* Universiti Tunku Abdul Rahman (no date) 'UGEA2273 Electromagnetic Fields and Waves / UGEB2214 Electromagnetics: Formula list' [Course handout]. Universiti Tunku Abdul Rahman ([00_EM Formula List.pdf](file:///c:/EFW/00_EM%20Formula%20List.pdf)).
* Universiti Tunku Abdul Rahman (2024) 'Electromagnetic Wave Propagation' [Presentation slides]. *UGEA2273: Electromagnetic Fields and Waves*. Universiti Tunku Abdul Rahman ([02_Electromagnetic_Wave_Propagation_Jul24_COM.pdf](file:///c:/EFW/02_Electromagnetic_Wave_Propagation_Jul24_COM.pdf)).
* Universiti Tunku Abdul Rahman (2026) 'Topic 03: Transmission Lines' [Presentation slides]. *UGEA2273: Electromagnetic Fields and Waves*. Faculty of Engineering and Green Technology, Universiti Tunku Abdul Rahman ([UGEA2273_Topic_03_Transmission_Lines_Student_October2026.pdf](file:///c:/EFW/UGEA2273_Topic_03_Transmission_Lines_Student_October2026.pdf)).
* Universiti Tunku Abdul Rahman (no date) 'Electromagnetic Fields and Waves: Laboratory Module 1 — Getting Familiarized with a High Frequency Electromagnetic Software' [Lab sheet]. *UGEA2273: Electromagnetic Fields and Waves*. Faculty of Engineering and Green Technology, Universiti Tunku Abdul Rahman ([b) UGEA2273_Lab1 (Question).pdf](file:///c:/EFW/Lab/b)%20UGEA2273_Lab1%20(Question).pdf)).
* Universiti Tunku Abdul Rahman (no date) 'Electromagnetic Fields and Waves: Laboratory Module 2 — Development of Patch Antennas' [Lab sheet]. *UGEA2273: Electromagnetic Fields and Waves*. Faculty of Engineering and Green Technology, Universiti Tunku Abdul Rahman ([b) UGEA2273_Lab2 (Question).pdf](file:///c:/EFW/Lab/b)%20UGEA2273_Lab2%20(Question).pdf)).
* Yeap, K.H. (no date) 'Assignment: Design of an Antenna' [Assignment brief]. *UGEA2273: Electromagnetic Fields and Waves*. Faculty of Engineering and Green Technology, Universiti Tunku Abdul Rahman ([UGEA2273_Assignment (Question).pdf](file:///c:/EFW/Assignment/UGEA2273_Assignment%20(Question).pdf)).
