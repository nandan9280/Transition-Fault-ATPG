# 🧪 Transition Fault ATPG and Timing-Aware Fault Coverage for Synthesized Multiplier

This project performs **ATPG generation and timing-aware simulation** for a scan-inserted 16×16 multiplier using Synopsys tools including Design Compiler, TetraMAX, and VCS.

---

## 🔧 Tools Used

* **Design Compiler (DC Shell)** – RTL synthesis and scan insertion
* **TetraMAX** – Transition Delay ATPG pattern generation
* **VCS** – Gate-level simulation
* **Verdi** – Waveform and scan chain debugging
* **TSMC 65nm Standard Cell Library** – Used for synthesis and netlist mapping

---

## ✅ Key Results

* **Total Transition Faults:** 5694
* **Detected Faults:** 5694
* **Untestable Faults:** 0
* **ATPG Patterns Generated:** 106
* **Fault Coverage:** ✅ 100.00%

---

## 🏗️ Workflow Overview

### 1. RTL Design and Scan Insertion

* Designed a 16×16 multiplier in Verilog
* Synthesized using Design Compiler
* Scan chains inserted during synthesis

### 2. Transition Fault ATPG

* Used TetraMAX for Transition Delay ATPG
* Generated 106 launch-capture test patterns

### 3. Timing-Aware Simulation (SDF)

* Exported SDF from Design Compiler: `time_1.sdf`
* Annotated delays on DUT using:

```bash
-sdf max:mult16x16_test.dut:time_1.sdf
```

* Simulated using VCS:

```bash
vcs -V -top mult16x16_test -R \
  mult16x16_testbench.v mult16x16_scan.v \
  -debug_all \
  -sdf max:mult16x16_test.dut:time_1.sdf \
  -v /path/to/tsmc65nm_std_cells.v \
  -full64 -kdb -gui +neg_tchk +sdfverbose
```

* Analyzed propagation delay and scan path via waveform in Verdi

### 4. Functional and Timing Validation

* Verified output `y` against input `a` and `b` under real delays
* Observed scan shifting and transition propagation
* Demonstrated proper delay annotation and transition detection behavior

---

## 📁 Project Files

* `mult16x16_scan.v` – Gate-level netlist with scan insertion
* `mult16x16_testbench.v` – Testbench with scan stimulus
* `time_1.sdf` – Standard Delay Format file with annotated cell delays
* `*.pattern` – Generated ATPG vectors

---

## 📷 Screenshots

Waveform results showing annotated propagation delay and fault simulation.

---

## 📝 Author

Nandagopan KM – M.Tech VLSI Design – VIT Vellore

🔗 [LinkedIn](https://www.linkedin.com/in/nandagopankm/) | 📫 [nandagopankm111@gmail.com](mailto:nandagopankm111@gmail.com)
