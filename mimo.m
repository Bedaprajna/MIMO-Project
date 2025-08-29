% Massive MIMO Simulation: Capacity vs Number of Antennas
clc; clear; close all;

% Parameters
SNR_dB = 0:5:30;           % SNR in dB range
SNR = 10.^(SNR_dB/10);     % Convert dB to linear scale
Nt = [4 16 64 128];        % Number of transmit antennas (MIMO -> Massive MIMO)
Nr = 4;                    % Number of receive antennas (fixed)

% Capacity calculation
capacity = zeros(length(Nt), length(SNR));

for i = 1:length(Nt)
    for j = 1:length(SNR)
        % Random channel matrix (Nr x Nt)
        H = (randn(Nr,Nt(i)) + 1j*randn(Nr,Nt(i)))/sqrt(2);
        
        % Channel capacity formula: C = log2(det(I + (SNR/Nt)*H*H'))
        capacity(i,j) = real(log2(det(eye(Nr) + (SNR(j)/Nt(i))*(H*H'))));
    end
end

% Plot results
figure;
plot(SNR_dB, capacity(1,:), '-o','LineWidth',2); hold on;
plot(SNR_dB, capacity(2,:), '-s','LineWidth',2);
plot(SNR_dB, capacity(3,:), '-^','LineWidth',2);
plot(SNR_dB, capacity(4,:), '-d','LineWidth',2);

xlabel('SNR (dB)');
ylabel('Channel Capacity (bits/sec/Hz)');
title('MIMO vs Massive MIMO Capacity');
legend('4x4 MIMO','16x4 MIMO','64x4 Massive MIMO','128x4 Massive MIMO','Location','NorthWest');
grid on;
