addpath(genpath("functions/part1"))
addpath(genpath("functions/part3"))
addpath(genpath("plot_functions"))
addpath(genpath("evaluation_functions"))

clear; 
close all; 
clc;

dataset_path = './data/';
rng(42);
seed = rng;

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                    Load Data                               %%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

table = readtable(strcat(dataset_path, 'magic_data.csv'), 'ReadVariableNames', false);
data = table2array(table)';

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                 Task 10  prepare_data.m                     %%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

[X, unique_cards] = prepare_data(data);

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                   Run kmeans                               %%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

K = 8;
init='sample';
type='L2';
MaxIter = 1000;
plot_iter = 0;
[labels, Mu, ~] =  kmeans(X, K, init, type, MaxIter, plot_iter);

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%                Task 12 recommend_cards.m                    %%
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

deck = zeros(length(unique_cards),1);
% try to add different cards
deck(612) = 1;
deck(36) = 4;

% add cards until the deck contains 60 cards
while sum(deck) < 60
    cards = recommend_cards(deck, Mu, type);
    % select the most recommanded card until you can't add more of it (4
    % times)
    for j = 1:length(cards)
        if deck(cards(j)) < 4
            deck(cards(j)) = deck(cards(j)) + 1;
            break
        end
    end
end

display_deck(deck, unique_cards)
