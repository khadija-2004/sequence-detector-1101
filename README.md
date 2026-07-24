# README – 1101 Sequence Detector

## Overview

This project implements a **1101 Sequence Detector** using a **Finite State Machine (FSM)** in SystemVerilog. The detector monitors a serial input stream and asserts the output whenever the binary sequence **1101** is detected. The design uses four states to track the progress of the incoming sequence and includes a testbench to verify its functionality.

## Design Description

* Implemented using a synchronous FSM.
* State transitions occur on the rising edge of the clock.
* An active-high reset initializes the FSM to the starting state.
* The output is generated based on the current state and input, making it a **Mealy FSM**.
* The detector supports **overlapping sequence detection**, allowing consecutive occurrences of the target sequence to be recognized without restarting the entire detection process.

## State Description

| State | Description                                         |
| ----- | --------------------------------------------------- |
| S0    | Initial state; waiting for the first `1`.           |
| S1    | First `1` detected.                                 |
| S2    | Two consecutive `1`s detected (`11`).               |
| S3    | Sequence `110` detected; waiting for the final `1`. |

When the FSM is in **S3** and the next input is `1`, the sequence **1101** is detected and the output is asserted.

## Inputs and Output

### Inputs

* **clk** – System clock.
* **rst** – Active-high reset.
* **in** – Serial input bit stream.

### Output

* **out** – Goes high when the sequence **1101** is detected.

## Testbench

The testbench verifies the design using the following scenarios:

* Reset operation.
* Non-matching input sequence (`101010`) to ensure no false detection.
* Standard sequence (`1101`) to verify correct detection.
* Overlapping sequence (`1101101`) to verify that overlapping occurrences are detected correctly.
* Waveform generation using **dump.vcd** for simulation analysis.

## Files

* `design.v` – FSM implementation of the sequence detector.
* `testbench.v` – Testbench for functional verification.

## Expected Behavior

* The FSM remains in the initial state until the first `1` is received.
* The output remains low for all non-matching input patterns.
* The output is asserted when the sequence **1101** is detected.
* The FSM continues tracking the input stream to support overlapping sequence detection.
