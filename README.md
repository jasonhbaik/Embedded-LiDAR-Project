
<img src="images/IMG_7257.mp4" width="600">


# 3D Spatial Mapping System 

An embedded spatial measurement system featuring $360^{\circ}$ room mapping capabilities. The system coordinates a Time-of-Flight (ToF) distance sensor and a stepper motor using an MSP432E401Y microcontroller, with 3D visualization and post-processing performed in MATLAB.

---

## 🧠 Design

This system is designed as a modular embedded sensing platform that separates real-time data acquisition from computationally intensive processing. An MSP432E401Y microcontroller manages sensor control, motor actuation, and serial communication, while MATLAB is used for coordinate transformation and visualization.

The VL53L1X ToF sensor is mounted on a stepper motor to enable angular sweeping in the $y$–$z$ plane. Linear displacement along the $x$-axis is introduced manually in fixed increments, allowing volumetric reconstruction of the surrounding environment. This architecture enables reliable data collection while keeping embedded firmware lightweight and deterministic.

---

## 🧭 Approach

1. **System Initialization**  
   Upon reset, the microcontroller initializes peripherals and waits for a user button press to begin scanning.

2. **Distance Sampling**  
   The VL53L1X emits infrared pulses and computes distance using time-of-flight principles. At each motor position, 64 distance samples are collected at uniform angular intervals, covering a full $360^{\circ}$ rotation.

3. **Motor Control & Synchronization**  
   The stepper motor advances incrementally between measurements, ensuring stable positioning before each ToF reading.

4. **Data Transmission**  
   Distance values are streamed to a host PC over UART as comma-separated values.

5. **Post-Processing & Visualization**  
   MATLAB parses incoming serial data, converts polar measurements into Cartesian coordinates using sine and cosine relationships, and renders the resulting 3D geometry using mesh-based visualization.

---

## 📊 Results

The system successfully reconstructs the geometric layout of indoor environments, including walls, floors, and ceilings. Scans taken in hallways and enclosed spaces demonstrate clear spatial structure with consistent depth profiles across successive slices.

Measurement accuracy is limited by sensor quantization and floating-point precision, resulting in a maximum theoretical error of approximately 0.5 mm. Reflective surfaces such as glass introduce artifacts due to infrared interference, leading to localized distortions in reconstructed meshes.

Overall scan performance is primarily constrained by stepper motor rotation speed and the ToF sensor’s sampling rate. Despite these limitations, the system demonstrates a robust proof-of-concept for low-cost embedded 3D spatial mapping.

---

## 🛠️ Technical Specifications
- **Microcontroller:** MSP432E401Y  
- **Sensor:** VL53L1X Time-of-Flight sensor (940 nm infrared)  
- **Actuator:** Stepper motor (28BYJ-48 or equivalent)  
- **Bus Speed:** 26 MHz  
- **Communication:**  
  - I²C (100 kbps) for sensor data  
  - UART (115200 baud) for PC communication  
- **Programming Languages:**  
  - Embedded C (Keil µVision)  
  - MATLAB (visualization & processing)

---

## 🏗️ System Architecture

The system integrates three primary modules to generate a 3D spatial map:

- **Data Acquisition**  
  The VL53L1X ToF sensor measures distance by calculating photon round-trip travel time after emitting infrared pulses.

- **Sensing Mechanism**  
  A stepper motor rotates the sensor through 64 angular slices (5.625° per slice), completing a full $360^{\circ}$ scan at each x-axis position.

- **Coordinate Transformation**  
  Raw polar distance data is transmitted to MATLAB and converted into Cartesian coordinates ($x, y, z$) using sine and cosine transformations before visualization.

---

## 💻 Hardware Connectivity

| Component | MCU Pin(s) | Function |
| :--- | :--- | :--- |
| **VL53L1X (ToF Sensor)** | PB2 (SCL), PB3 (SDA) | I²C communication |
| **Stepper Motor Driver** | PH0 – PH3 | Motor phase control (IN1–IN4) |
| **User Button** | PJ0 | Start/continue scan |
| **LED Indicators** | PF4, PF0, PN0 | Measurement, UART transmit, scan complete |

---

## 🚀 How to Run

1. **Hardware Setup**  
   Connect the ToF sensor, stepper motor, button, and LEDs according to the hardware connectivity table.

2. **Firmware Upload**  
   Build and flash the embedded C firmware to the MSP432E401Y using Keil µVision.

3. **MATLAB Configuration**  
   Open the MATLAB processing script and set the correct serial port (e.g., `COM5`) and baud rate (115200).

4. **Execute Scan**  
   Run the MATLAB script, then press the **PJ0** button on the microcontroller to begin data acquisition and 3D mapping.

---

## 📈 Performance & Limitations

- **Angular Resolution:** 64 distance samples per full rotation  
- **Accuracy:** Maximum quantization error of approximately 0.5 mm  
- **Environmental Sensitivity:** Reflective surfaces such as glass can introduce measurement artifacts  
- **System Bottleneck:** Overall scan time is primarily limited by stepper motor rotation speed and sensor sampling rate  
