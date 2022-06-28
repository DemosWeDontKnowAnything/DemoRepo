%-----------------------------------------------------------
% This short (and not well written) MATLAB script is meant
% to generate 4 3D surface plots of example 2x2 matrices, as
% well as documenting some basic information/properties to 
% understand the results.
%-----------------------------------------------------------

%-----------------------------------------------------------
% SHORTENED BACKGROUND INFORMATION
%
% These 4 matrices represent different classes of matrices:
%
% - positive definite
% - negative definite
% - indefinite
% - positive semidefinite
%
% The quadratic form of a matrix can be defined as:
%              
%      Q(A) = x' A x
%
% where
%
%      x = [x1  x2]'
%
% and the entries are varied over a region (and act as the
% independent variables in the surface plot). For a generic
% 2x2 matrix
%
%          +-        -+
%          |  a    b  |
%      A = |          |
%          |  c    d  |
%          +-        -+
%
% a the quadratic form can be written simply as:
%
%                 2                     2
%      Q(A) = a x1  + (b+c) x1 x2 + d x2
% 
% Closed form representations of the quadratic form become
% cumbersome for higher dimension matrices.
%
% Note that while a matrix has one quadratic representation,
% a quadratic form *DOES NOT* represent only one matrix.
% This can be most easily seen in our general Q(A) form for
% a 2x2 matrix. The (b+c) term has an infinite number of
% solutions for b+c = someValue.
%
% The definiteness of a matrix can be defined based on its
% quadratic form. A matrix is:
%
% positive definite if Q(x) > 0
% positive semidefinite if Q(x) >= 0
% negative definite if Q(x) < 0
% negagative semidefinite if Q(x) <= 0
% indefinite if Q(x) can be both positive/negative
%
%               n
% for x != 0 ∈ R
%-----------------------------------------------------------



% Positive-Definite Matrix 
% req eigenvalues > 0
%   +-        -+
%   |  2    1  |
%   |          |
%   |  1    3  |
%   +-        -+
posDef = [2 1; 1 3];

% Negative-Definite Matrix
% req eigenvalues < 0
%   +-          -+
%   |  -2    -1  |
%   |            |
%   |  -1    -3  |
%   +-          -+
negDef = [-2 -1; -1 -3];

% Indefinite / Singular matrix
% req determinant = 0
% eigenvalue sign indeterminant
%   +-        -+
%   |  3    6  |
%   |          |
%   | -2   -4  |
%   +-        -+
sing = [3, 6; -2, -4];

% Positive-Semidefinite Matrix
% req eigenvalues >= 0
% symmetric
% rows are not linearly independent
%   +-        -+
%   |  1    2  |
%   |          |
%   |  2    4  |
%   +-        -+
inDef = [1, 2; 2, 4];


% sampling points
xi = -2:.1:2;

% initialize output containers
quadform1 = zeros( length(xi) );
quadform2 = zeros( length(xi) );
quadform3 = zeros( length(xi) );
quadform4 = zeros( length(xi) );

% double loop
for i = 1 : length(xi)

    for j = 1 : length(xi)

        % create w vector
        % note: here we transpose the vector to create a 
        % column vector in order to match the traditional
        % way of writing the qudratic form
        x = [xi(i) xi(j)]';

        nFact = 1;
        % compute the normalization factor. if we enable
        % this, the surfaces are transformed into a 
        % representation that will show the eigenvector
        % solutions. The ridges/valleys in the resulting
        % 3D surface correspond to the eigenvectors
        %nFact = w' * w;

        % compute quad form of posDef
        quadform1(i,j) = x' * posDef * x / nFact;
        quadform2(i,j) = x' * negDef * x / nFact;
        quadform3(i,j) = x' * inDef  * x / nFact;
        quadform4(i,j) = x' * sing   * x / nFact;


    end % end of j loop
end % end of i loop

% plotting stuff
figure(1), clf
surf(xi, xi, quadform1')
title("Positive Definite")
xlabel('w1')
ylabel('w2')
zlabel('f(x)')
rotate3d on
axis square

figure(2), clf
surf(xi, xi, quadform2')
title("Negative Definite")
xlabel('w1')
ylabel('w2')
zlabel('f(x)')
rotate3d on
axis square

figure(3), clf
surf(xi, xi, quadform4')
title("Singular / Indefinite")
xlabel('w1')
ylabel('w2')
zlabel('f(x)')
rotate3d on
axis square

figure(4), clf
surf(xi, xi, quadform3')
title("Positive Semidefinite")
xlabel('w1')
ylabel('w2')
zlabel('f(x)')
rotate3d on
axis square