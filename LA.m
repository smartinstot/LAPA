%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% ELEC 4700 Laplace Equation by Iteration PA Assignment %
%%%%%%%%% By David Bascelli and Patrobas Adewumi %%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% Paramaters %%
% Grid size
grid_x = 10;
grid_y = 10;

% Step size
dx = 1E-9;
dy = dx;

numsteps = grid_x*grid_y;

% boundary conditions
left_BC = 1; % V
right_BC = 1; % V/m
top_BC = 0; % V/m
bottom_BC = 0; % V/m

V = zeros(grid_x, grid_y);
V_imbox = zeros(grid_x, grid_y);
% Boundary conditions are constant
V(1,:) = top_BC;
V(grid_x,:) = bottom_BC;
V(:,1) = left_BC;
V(:,grid_x) = right_BC;

f1 = figure("Name","iterative");
f2 = figure("Name","imbox");
while (numsteps > 0)
    numsteps = numsteps - 1;
    
    % Iterative
    for i=2:(grid_x-1)
        for j=2:(grid_y-1)
            V(i,j) = 0.25*(V(i-1,j) + V(i+1,j) + V(i,j-1) + V(i,j+1));
        end
    end
    
    % Plot iterative
    figure(f1)
    hold on;
    contourf(V);
    xlim([1 grid_x]);
    ylim([1 grid_y]);
    [Ex, Ey] = gradient(V);
    quiver(-Ex,-Ey,'w');
    hold off;
    

   
    V_imbox = imboxfilt(V_imbox);
     % Reapply boundry conditions
    V_imbox(1,:) = top_BC;
    V_imbox(grid_x,:) = bottom_BC;
    V_imbox(:,1) = left_BC;
    V_imbox(:,grid_x) = right_BC;
    
    


    % Plot image tool box
    figure(f2);
    hold on;
    contourf(V_imbox);
    xlim([1 grid_x]);
    ylim([1 grid_y]);
    [Ex_imbox, Ey_imbox] = gradient(V_imbox);
    quiver(-Ex,-Ey,'w');
    hold off;
end