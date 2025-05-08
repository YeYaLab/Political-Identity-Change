% Number of times to scramble
num_scrambles = 1000;

% Preallocate a matrix to store the scrambled vectors
scrambled_vectors_general = zeros(numel(general_vector_no_neutral), num_scrambles);

% Scramble the vector multiple times
for i = 1:num_scrambles
    % Generate a random permutation
    permutation = randperm(numel(general_vector_no_neutral));
    
    % Scramble the vector using the permutation
    scrambled_vector = general_vector_no_neutral(permutation);
    
    % Store the scrambled vector
    scrambled_vectors_general(:, i) = scrambled_vector;
end

% Define the size of the vector and the number of scrambles
vector_size = 126;
num_scrambles = 1000;

% Initialize the matrix to store the scrambles
null_mat_ED_vec_ideology = zeros(vector_size, num_scrambles);

% Perform the scrambles
for i = 1:num_scrambles
    % Create a copy of the original vector
    scrambled_vector = ideology_vector_no_neutral;
    
    % Shuffle the elements of the vector randomly
    scrambled_vector = scrambled_vector(randperm(vector_size));
    
    % Store the scrambled vector in the matrix
    null_mat_ED_vec_ideology(:, i) = scrambled_vector;
end




% Initialize the matrix to store the scrambles
null_mat_ED_vec_ingroup = zeros(vector_size, num_scrambles);

% Perform the scrambles
for i = 1:num_scrambles
    % Create a copy of the original vector
    scrambled_vector = ingroup_vector_no_neutral;
    
    % Shuffle the elements of the vector randomly
    scrambled_vector = scrambled_vector(randperm(vector_size));
    
    % Store the scrambled vector in the matrix
    null_mat_ED_vec_ingroup(:, i) = scrambled_vector;
end




% Initialize the matrix to store the scrambles
null_mat_ED_vec_trust = zeros(vector_size, num_scrambles);

% Perform the scrambles
for i = 1:num_scrambles
    % Create a copy of the original vector
    scrambled_vector = trust_vector;
    
    % Shuffle the elements of the vector randomly
    scrambled_vector = scrambled_vector(randperm(vector_size));
    
    % Store the scrambled vector in the matrix
    null_mat_ED_vec_trust(:, i) = scrambled_vector;
end



% Initialize the matrix to store the scrambles
null_mat_ED_vec_general = zeros(vector_size, num_scrambles);

% Perform the scrambles
for i = 1:num_scrambles
    % Create a copy of the original vector
    scrambled_vector = general_vector_no_neutral;
    
    % Shuffle the elements of the vector randomly
    scrambled_vector = scrambled_vector(randperm(vector_size));
    
    % Store the scrambled vector in the matrix
    null_mat_ED_vec_general(:, i) = scrambled_vector;
end




