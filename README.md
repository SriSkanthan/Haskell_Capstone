# Modeling Marine Litter Accumulation Dynamics in Estuarine Regions via Functional Fold Operations

## Overview

Marine litter accumulation in estuarine environments is a growing environmental concern. Estuaries act as transition zones between rivers and oceans where floating waste transported by river flow, tides, and human activities tends to accumulate.

This project demonstrates how **functional programming concepts in Haskell** can be used to model and simulate litter accumulation dynamics. The system represents environmental processes as events and processes them sequentially using **fold operations**, allowing the model to compute cumulative litter accumulation over time.

The project focuses on applying **functional design principles** rather than large-scale environmental data analysis.

---

## Problem Statement

Estuarine regions receive litter from multiple sources such as:

- River inflows
- Ocean tides
- Coastal human activity

At the same time, litter may decrease due to:

- Cleanup operations
- Natural degradation

The challenge is to model how litter **accumulates or decreases over time** when these events occur sequentially.

This project models these changes using **functional fold operations**, where the current litter state is updated step-by-step based on a sequence of environmental events.

---

## Technology Stack

### Programming Language
- **Haskell**

### Functional Programming Concepts Used
- Fold operations (`foldl`)
- Pattern matching
- Algebraic data types
- Higher-order functions
- Pure functional state transformations

### Tools
- GHC (Glasgow Haskell Compiler)
- Command Line / Terminal
- Basic Haskell modules

---

## Project Structure
marine-litter-model/
│
├── src/
│ ├── Main.hs
│ ├── Types.hs
│ ├── Events.hs
│ ├── Simulation.hs
│
├── data/
│ └── sample_events.txt
│
└── README.md


---

## Solution Approach

The solution models marine litter accumulation as a **series of environmental events** that affect the litter state in an estuary.

Each event either **adds** or **removes** litter from the system. By representing these events as data structures, the program processes them sequentially and updates the litter state accordingly.

The key concept used is the **fold operation**, which allows us to apply a state transition function repeatedly across a list of events.

---

## System Design

### Event Representation

Environmental processes are represented as events such as:

- `RiverInput`
- `OceanInput`
- `Cleanup`
- `Degradation`

Each event modifies the current litter amount.

Example event representation:

```haskell
data Event
  = RiverInput Double
  | OceanInput Double
  | Cleanup Double
  | Degradation Double
```

### Dataset Requirement

This project does not require large datasets.

The objective is to demonstrate functional modeling using fold operations, so small synthetic datasets or manually defined event sequences are sufficient.

### Example input may simply be a list of events representing daily environmental processes.

### Possible Extensions 

-The model can be extended in several ways:
- Simulating multiple estuarine regions
- Introducing different litter categories (plastic, metal, organic)
- Adding probabilistic event generation
- Integrating real environmental datasets
- Visualizing litter accumulation trends over time

### Key Learning Outcomes

- Applying functional programming to environmental modeling
- Using fold operations to simulate cumulative processes
- Designing systems using algebraic data types
- Modeling real-world processes using pure functional transformations