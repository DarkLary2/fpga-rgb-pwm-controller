# FPGA-Based RGB LED Controller with PWM Driver & FSM State Machine

A modular, hardware-efficient **SystemVerilog/Verilog** implementation of an RGB LED controller driven by an Finite State Machine (FSM) and parameterized Pulse-Width Modulation (PWM) modules. The system features multi-state color sequencing (Red, Green, Blue, White, and Off) triggered via a debounced physical button, alongside synchronous status monitoring on a multiplexed 7-segment display.

Implemented and verified on the **RealDigital Boolean Board** (Xilinx Spartan-7 FPGA).

---

##  Key Architectural Features

* **Finite State Machine (FSM) Controller:** A robust control unit managing 5 distinct system states, driving color-specific enable lines (`en_red`, `en_green`, `en_blue`) based on clean async-to-sync button triggers.
* **Parameterized PWM Cores:** Fully parameterized modules featuring dynamic `limit_period` and `limit_duty_cycle` definitions allowing precise independent intensity control per color channel.
* **Hardware Glitch Mitigation:** Integrated an operational debouncer module utilizing custom clock-cycle thresholds to effectively eliminate switch contact bounces and prevent metastability during state transitions.
* **Dual ROM-Based Display Mapping:** Specialized `rom_cifra` and `rom_segmente` modules to handle localized digit selection and segment rendering corresponding directly to the FSM's active state.

---

## System Architecture Block Diagram

The project is structured into fully decoupled, reusable hardware blocks:

```text
               +----------------------------------------+
               |                 TOP                    |
               |                                        |
  btn_in ----->|  +-----------+     +-------------+     |
               |  | Debounce  |---->| FSM Control |     |
               |  +-----------+     +-------------+     |
               |                           |            |
               |           +---------------+------------+
               |           |               |            |
               |     (en_red)       (en_green)    (en_blue)
               |           v               v            v
               |     +-----------+   +-----------+   +-----------+
               |     |  PWM Red  |   | PWM Green |   | PWM Blue  |
               |     +-----------+   +-----------+   +-----------+
               |           |               |            |
               |           v               v            v
               |        out_red        out_green     out_blue (LED RGB)
               +----------------------------------------+
