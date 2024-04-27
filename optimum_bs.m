% Network Parameters
numNodes = 75; % Number of nodes in the network
networkSize = 25; % Size of the network (25x25 grid)
initEnergy = 500; % Initial energy of each node
totalRounds = 30; % Total number of simulation rounds
decayRate = 10; % Energy decay rate per round

% Generate Random Node Positions
NodePosX = randi([0, networkSize], 1, numNodes);
NodePosY = randi([0, networkSize], 1, numNodes);

% Function to Calculate Optimal Base Station Position
[OptimalStationX, OptimalStationY] = calculateOptimalPosition(NodePosX, NodePosY);

% Fixed Base Station Position
FixedStationX = networkSize / 2;
FixedStationY = networkSize / 2;

% Initialize Node Energy Levels
NodeEnergyOpt = ones(1, numNodes) * initEnergy;
NodeEnergyFixed = ones(1, numNodes) * initEnergy;

% Initialize Result Arrays
[avgEnergyOpt, avgEnergyFixed, activeNodesOpt, activeNodesFixed] = ...
    initializeResultArrays(totalRounds);

% Main Simulation Loop
for currentRound = 1:totalRounds
    [NodeEnergyOpt, NodeEnergyFixed, activeNodesOpt(currentRound), ...
     activeNodesFixed(currentRound), avgEnergyOpt(currentRound), ...
     avgEnergyFixed(currentRound)] = ...
        simulateRound(NodePosX, NodePosY, NodeEnergyOpt, NodeEnergyFixed, ...
                      OptimalStationX, OptimalStationY, FixedStationX, ...
                      FixedStationY, decayRate, currentRound);
end

% Plot Results
plotResults(NodePosX, NodePosY, OptimalStationX, OptimalStationY, ...
            FixedStationX, FixedStationY, activeNodesOpt, activeNodesFixed, ...
            avgEnergyOpt, avgEnergyFixed, totalRounds);

% Calculate and Display Total Energy Consumption
array_total_optbase_energy = sum(avgEnergyOpt);
array_total_base_energy = sum(avgEnergyFixed);

disp('Total Energy Consumption for Optimal Base Station:');
disp(array_total_optbase_energy);

disp('Total Energy Consumption for Fixed Base Station:');
disp(array_total_base_energy);

% Flag to indicate if all nodes are dead
allNodesDead = false;

% Main Simulation Loop with Energy Display
for currentRound = 1:totalRounds
    [NodeEnergyOpt, NodeEnergyFixed, activeNodesOpt(currentRound), ...
     activeNodesFixed(currentRound), avgEnergyOpt(currentRound), ...
     avgEnergyFixed(currentRound)] = ...
        simulateRound(NodePosX, NodePosY, NodeEnergyOpt, NodeEnergyFixed, ...
                      OptimalStationX, OptimalStationY, FixedStationX, ...
                      FixedStationY, decayRate, currentRound);

    % Display individual node energies for specific rounds
    if ismember(currentRound, [1, 5, 10, 15, 20]) % Example rounds to display
        fprintf('\nRound %d:\n', currentRound);
        disp('Node Energies for Optimal Base Station:');
        disp(NodeEnergyOpt);
        disp('Node Energies for Fixed Base Station:');
        disp(NodeEnergyFixed);
    end
end

% ***************************************************************
% ******************* FUCTION DEFINITIONS ***********************
% ***************************************************************

% Calculate the mean position of nodes as the optimal base station location

function [optX, optY] = calculateOptimalPosition(X, Y)
    optX = mean(X);
    optY = mean(Y);
end

% Initialize arrays to store simulation results for each round
function [avgEOpt, avgEFixed, activeNOpt, activeNFixed] = ...
    initializeResultArrays(rounds)
    avgEOpt = zeros(1, rounds);
    avgEFixed = zeros(1, rounds);
    activeNOpt = zeros(1, rounds);
    activeNFixed = zeros(1, rounds);
end

% Simulate a round of the network operation
function [energyOpt, energyFixed, activeOpt, activeFixed, avgEOpt, avgEFixed] = ...
    simulateRound(X, Y, energyOpt, energyFixed, optX, optY, fixedX, fixedY, decay, roundNum)
    activeOpt = sum(energyOpt > 0);
    activeFixed = sum(energyFixed > 0);
    for i = 1:length(X)
        distOpt = sqrt((X(i) - optX)^2 + (Y(i) - optY)^2);
        distFixed = sqrt((X(i) - fixedX)^2 + (Y(i) - fixedY)^2);
        energyOpt(i) = max(energyOpt(i) - decay * distOpt, 0);
        energyFixed(i) = max(energyFixed(i) - decay * distFixed, 0);
    end
    avgEOpt = mean(energyOpt);
    avgEFixed = mean(energyFixed);
end

% *************************************************************************
% ******************* VISUALIZATION OF THE SIMULATION *********************
% *************************************************************************
function plotResults(X, Y, optX, optY, fixedX, fixedY, activeNOpt, activeNFixed, avgEOpt, avgEFixed, rounds)
    % Plot Network Topology
    figure('Name', 'Network Topology');
    scatter(X, Y, 50, 'MarkerEdgeColor', 'k', 'MarkerFaceColor', [0 0.5 0.5], 'LineWidth', 1.5); hold on;
    plot(optX, optY, 'p', 'MarkerSize', 12, 'MarkerEdgeColor', 'b', 'MarkerFaceColor', 'c', 'LineWidth', 2);
    plot(fixedX, fixedY, 'h', 'MarkerSize', 12, 'MarkerEdgeColor', 'm', 'MarkerFaceColor', 'y', 'LineWidth', 2);
    grid minor; axis([0 25 0 25]);
    legend('Nodes', 'Optimal Station', 'Fixed Station');
    title('Node Distribution and Base Station Positions');
    
    % Plot Active Nodes Comparison
    figure('Name', 'Comparison of Active Nodes');
    plot(1:rounds, activeNOpt, 'b--', 1:rounds, activeNFixed, 'r:', 'LineWidth', 1.5);
    xlabel('Round'); ylabel('Active Nodes');
    legend('Optimal Station', 'Fixed Station');
    title('Active Nodes - Optimal vs Fixed Base Stations');
    grid on;
    
    % Plot Average Node Energy Comparison
    figure('Name', 'Comparison of Average Node Energy');
    plot(1:rounds, avgEOpt, 'b--', 1:rounds, avgEFixed, 'r:', 'LineWidth', 1.5);
    xlabel('Round'); ylabel('Average Node Energy');
    legend('Optimal Station', 'Fixed Station');
    title('Average Node Energy - Optimal vs Fixed Base Stations');
    grid on;
end
