# 🧺asdf Transition Delay Fault ATPG on 16×16 Multiplier

This repository presents a complete flow of **DFT scan insertion**, **transition delay fault ATPG**, and **simulation validation** for a 16×16 unsigned multiplier using **Synopsys DC Shell, TetraMAX, and VCS**. The project demonstrates how to achieve full transition fault coverage and waveform verification through industry-standard EDA tools.

---

## 🔧 Tools Used

* 🧱 **Design Compiler (DC Shell)** – RTL synthesis and scan insertion
* 🧬 **TetraMAX** – ATPG and fault coverage analysis
* ▶️ **VCS + Verdi** – Simulation and waveform debugging
* 📦 **TSMC 65nm Standard Cell Library** – Cell mapping and synthesis

---

## 📘 Project Workflow

| Phase                             | Description                                                            |
| --------------------------------- | ---------------------------------------------------------------------- |
| **1. RTL Design**                 | Created a synthesizable 16×16 multiplier (`mult16x16.v`)               |
| **2. Synthesis + Scan Insertion** | Inserted scan chains with `synth_mult16x16.tcl` in DC Shell            |
| **3. Timing & DFT Constraints**   | Defined using `mult16x16.sdc` and scan protocol `.spf`                 |
| **4. ATPG**                       | Performed transition fault pattern generation in TetraMAX (`atpg.tcl`) |
| **5. Simulation**                 | Simulated scan patterns in VCS; verified behavior in Verdi             |
| **6. Analysis**                   | Achieved 100% transition fault coverage with 106 patterns              |

---

## ✅ ATPG Results

* **Fault Model**: Transition (slow-to-rise/fall)
* **Total Transition Faults**: 5694
* **Detected Faults**: 5694
* **Untestable Faults**: 0
* **ATPG Patterns Generated**: 106
* **Fault Coverage**: 🟢 **100.00%**

---

## 📂 Project Structure

```
transition-delay-fault-atpg/
├── mult16x16.v                    # RTL source code
├── mult16x16_scan.v               # Synthesized + scan-inserted netlist
├── mult16x16.sdc                  # Timing constraints
├── mult16x16.spf                  # Scan protocol
├── synth_mult16x16.tcl            # DC Shell synthesis + DFT script
├── atpg.tcl                       # TetraMAX ATPG script
├── mult16x16_delay_patterns.stil  # Generated ATPG patterns
├── testbench.v                    # VCS-compatible testbench for simulation
├── report/
│   ├── fault_coverage.rpt
│   ├── patterns.rpt
│   └── untestable.rpt
├── waveform/
│   └── screenshot.png             # Waveform captured in Verdi
└── README.md
```

---

## 🗈️ Waveform Snapshot

> Scan patterns and DUT activity verified using Verdi

![Waveform](waveform/screenshot.png)

---

## ▶️ How to Run

```bash
# Compile using VCS
vcs -full64 -debug_all testbench.v mult16x16_scan.v \
    -v /path/to/tcbn65gplushpbwp.v \
    -R -gui

# View waveforms in Verdi or DVE
```

---

## ✍️ Author

* 👤 **Nandagopan KM**
* 🎓 M.Tech VLSI Design, VIT Vellore
* 📧 [nandagopankm111@gmail.com](mailto:nandagopankm111@gmail.com)

---

## 📄 License

This project is for academic and educational use only.
You may adapt or reuse it with appropriate credit.
Consider applying an open-source license like [MIT License](https://choosealicense.com/licenses/mit/).
