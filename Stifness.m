%%
%%% Arian Velayati, PhD
%%%% This script is used to find the Young's modulus of rocks using the 50%
%%%% max peak stress method

clc; clear; close;
%% Input

ea = load('ea.txt'); % Axial strain (%)
Sd = load('sd.txt'); % Deviatoric Stress (MPa)
%% Calculations

Sd_m = max(Sd); % Max Sd value
Sd_mh = 0.5*Sd_m; % Half Sd_m
r = find(Sd>Sd_mh); %find the row in which the 0.5 half peak stress can be found

n = 100; % arbitrary row distancing from the 
f = polyfit(ea(r(1)-n:(r(1)+n)), Sd(r(1)-n:r(1)+n),1); %Fitting a linear tanget around 50% of peak s1

fout = f;
for i = 1:10
    % f = polyfit(ea((r(1)+n):r(1)), Sd((r(1)+n):r(1)),1)
    n = n + 100; % Change 100 based on the number of data points 
f = polyfit(ea(r(1)-n:(r(1)+n)), Sd(r(1)-n:r(1)+n),1);
fout = [fout;f];
if (fout(i+1,1)-fout(i,1))/fout(i+1,1) < 0.01
    disp('Optimal n is: '); disp(n); 
    disp('E (GPa) is: '); disp(f(:,1)/10)
     break
end
end

 
 %% plot
 
scatter(ea,Sd)
hold on 
x = linspace(ea(r(1)-n),ea(r(1)+n),100);
y = f(1).*x+f(2);
plot(x,y,'r','LineWidth',5)
xlabel('Strain (%)')
ylabel('Stress (MPa)')
legend('Experimental Data','50% tangent method')
 
