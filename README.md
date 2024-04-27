# Wireless Sensor Network (WSN) Simulation

This MATLAB code simulates the energy consumption of a wireless sensor network (WSN) with a base station and multiple sensor nodes. The simulation compares the performance of an optimal base station position against a fixed base station position over multiple rounds.

## Overview

The simulation consists of the following components:

1. **Network Setup**: Parameters such as the number of nodes, network size, initial energy levels, total simulation rounds, and energy decay rate are defined.

2. **Node Position Generation**: Random positions are generated for the sensor nodes within the specified network size.

3. **Optimal Base Station Position Calculation**: The mean position of all nodes is calculated as the optimal base station position.

4. **Fixed Base Station Position**: A fixed base station position is set at the center of the network.

5. **Node Energy Initialization**: Initial energy levels for all nodes are set.

6. **Simulation Loop**: The main simulation loop runs for the specified number of rounds. It simulates energy consumption for each node based on its distance from the optimal and fixed base station positions. It calculates the average energy level and the number of active nodes for each round.

7. **Result Visualization**: The simulation results are visualized through plots showing the network topology, comparison of active nodes, and comparison of average node energy between the optimal and fixed base station scenarios.

8. **Energy Consumption Calculation**: The total energy consumption for both the optimal and fixed base station scenarios is calculated and displayed.

9. **Node Energy Display**: Individual node energies are displayed for specific rounds.

## Usage

1. **Setting Parameters**: Modify the parameters in the code to customize the simulation according to your requirements.

2. **Running the Simulation**: Execute the MATLAB script to run the simulation.

3. **Viewing Results**: After the simulation completes, view the plotted results to analyze the performance of the optimal and fixed base station scenarios.

## Files

- `wsn_simulation.m`: MATLAB script containing the simulation code.
- `README.md`: This README file providing an overview of the simulation.

## Dependencies

- MATLAB R2019b or later.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.

## Author

- Ibrahim TOSUN - 19014502
