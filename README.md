# 🧪 Transition Delay Fault ATPG on 16×16 Multiplier

This project demonstrates the synthesis, scan insertion, and delay fault ATPG of a 16×16 unsigned multiplier using **Synopsys DC Shell, TetraMAX, and VCS**. The goal is to identify and simulate **transition (delay) faults** in a scan-inserted gate-level netlist, validate patterns using simulation, and analyze waveform-level behavior.

---

## 🔧 Tools Used

- 🔲 **Design Compiler (DC Shell)** – RTL synthesis and scan insertion
- 🧩 **TetraMAX** – ATPG and fault coverage analysis
- ▶️ **VCS + Verdi** – Simulation and waveform debugging
- 📦 **TSMC 65nm Standard Cell Library** – Cell mapping and synthesis

---

## 📘 Project Description

| Phase | Description |
|-------|-------------|
| **1. RTL Design** | Created a synthesizable 16×16 multiplier (`mult16x16.v`) |
| **2. Synthesis + Scan Insertion** | Used `synth_mult16x16.tcl` to insert scan chains |
| **3. DFT Setup** | Defined DFT signals and timing constraints (`.spf`, `.sdc`) |
| **4. ATPG** | Ran transition fault ATPG via TetraMAX (`atpg.tcl`) |
| **5. Simulation** | Simulated scan patterns using VCS and verified in Verdi |
| **6. Analysis** | Achieved 100% transition fault coverage with 106 patterns |

---

## ✅ Results

- **ATPG Fault Model**: Transition (slow-to-rise/fall)
- **Total Transition Faults**: 5694  
- **Detected Faults**: 5694  
- **Fault Coverage**: 🟢 **100.00%**
- **Patterns Generated**: 106 full-sequential scan patterns

---

## 📂 Project Structure

