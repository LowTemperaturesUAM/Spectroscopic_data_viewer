%This function calculates  the radial profile of a matrix being able to
%decide the origin, size and direction of the profile.

%Inputs:
        %Center       : Array of the origin of the radial profile in pixels[X0,Y0]
        %Matrix       : Matrix to calculate profile
        %NOfPoints    : Length of the radial profile wanted (pixels)
        %MaximumRadius: Maximum radius to calculate the profile (pixels).
        %AngleLim     : Upper and lower bounds of angle values between -180
        %and 180 degrees. 
%The chosen circular section is given by the area between the angles
%specified, starting with the first value and turning in the
%counterclockwise direction

% If AngleLim is not given it is assumed a complete radial average

function [R_values, profile_complete] = radialProfileV3(Center,  Matrix, NOfPoints, MaximumRadius, AngleLim)
    [Filas, Columnas] = size(Matrix);
%     SizeOfRings = TamanhoImagen/NOfPoints;
    Step = MaximumRadius/NOfPoints;
    
    %Creation of a cartesian matrix of X and Y centered in "center"
    indX = (1:Columnas) - Center(1);
    indY = (1:Filas) - Center(2);
    Z = indX + 1i*indY';

    %Obtain distance to center of every pixel
    CordMod = abs(Z);
    % Obtain angle(deg) direction respect to center. Zero is towards right.
    CordAng = rad2deg(angle(Z));
    
    %Assume full circle if empty or missing
    if nargin < 5 || isempty(AngleLim)
        AngleLim = [-180, 180];
        Inverted= false;
    else
        if any(abs(AngleLim)>180) %check angles out of bounds
            error('The angles provided are outside the expected bounds. Please keep the values between -180 and 180 degrees')
        end

        % Check order of angle limits
        Inverted = AngleLim(2) <= AngleLim(1);
    end

    
    if Inverted
        % Establish condition for circular section
        Condition = CordAng>=AngleLim(1) | CordAng<=AngleLim(2);
    else
        Condition = CordAng>=AngleLim(1) & CordAng<=AngleLim(2);
    end


    

    % Always include center point.
    Condition(Center(2), Center(1)) = 1;

    % Create auxiliar matrix to preserve matrix size.
    Mtemp = nan(size(Matrix));
    Mtemp(Condition) = CordMod(Condition);

    % Obtain every possible radius and calculate mean of matrix at it
    R_values = unique(CordMod(Condition));
    profile_complete = arrayfun(@(x) mean(Matrix(Mtemp==x),'all'), R_values);


    %Array that controls the points to do the profile.
    %ValoresValidos = linspace(0,MaximumRadius,NOfPoints)';
    
    %Obtain the RadialProfile array by interpolation.
    %RadialProfile = interp1(R_values, profile_complete, ValoresValidos);


    
