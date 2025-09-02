# 🚗 Transport Car Project (PIC16F877A Assembly)

This project implements a **transport car simulation** using the **PIC16F877A microcontroller** and **Assembly language**.  
The program controls a sequence of LEDs to represent the movement of a transport vehicle between different points, including loading/unloading stages, waiting times, and directional control.

---

## 📖 About the Project
Developed as part of a university project at **UFSC - Universidade Federal de Santa Catarina**, this system demonstrates:
- Microcontroller programming in Assembly
- Use of GPIO ports for input and output
- Timing routines using software delays
- State machine logic for simulating movement and operations

The vehicle is represented by LEDs on **PORTD**, and control signals are received from **PORTB**.

---

## ✨ Features
- **Initialization**  
  - Configures PORTB pins as **inputs** (control buttons/sensors)  
  - Configures PORTD pins as **outputs** (LEDs representing vehicle state)  

- **Main Loop**  
  - Waits for a command on PORTB before starting movement  
  - Resets LEDs to default idle state  

- **Movement (Right Direction)**  
  - LEDs on PORTD light up sequentially (B → C → D) to simulate moving right  
  - Stops at point B if triggered  

- **Loading/Unloading at Point B**  
  - Activates LEDs representing “loading” and “ready” states  
  - Includes a **1-second delay** and **5-second delay** to simulate real operations  

- **Movement (Left Direction)**  
  - LEDs on PORTD light up in reverse order (D → C → B) to simulate moving left  
  - Returns to idle waiting state if interrupted  

- **Delay Routines**  
  - **Blink delay (~250ms)** for LED transitions  
  - **1-second delay**  
  - **5-second delay**  

---

## ⚙️ Hardware Requirements
- **Microcontroller**: PIC16F877A  
- **Clock**: 4 MHz XT oscillator  
- **LEDs** connected to PORTD (pins RD0–RD7)  
- **Switches** or control inputs connected to PORTB (pins RB0–RB3)  

---

## 🛠️ How to Assemble and Run
1. Save the code into a file (e.g., `carro.asm`).  
2. Assemble using **MPASM** (included in MPLAB):  
   ```bash
   mpasmwin carro.asm
