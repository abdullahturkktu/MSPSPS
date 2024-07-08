clc;
clear;

rng('shuffle')

numWorkers = 12;
pool = parpool('local', numWorkers, 'IdleTimeout', Inf); % Süresiz

activities = [12 16 20];
pactivities = [5 7 9];
workers = [60 80 100];
skills = [5 10 15];

% Toplam deney sayýsý
number_of_experiment = size(activities,2)*size(skills,2)*size(workers,2);

[ tut_pactivity_set, tut_single_skill_set_of_worker, tut_task_time_of_each_skill, tut_skill_matrix,...
    tut_total_skill_number, tut_predecessor_matrix, tut_successor_matrix, cost_GAS1HM, cost_GAS1HT,...
    cost_GAS2HM, cost_GAS2HT, cost_GAS3HM, cost_GAS3HT, cost_GAS4HM, cost_GAS4HT,...
    time_GAS1HM, time_GAS1HT, time_GAS2HM, time_GAS2HT, time_GAS3HM, time_GAS3HT, time_GAS4HM, time_GAS4HT,...
    tut_GAS1HM_final_best_p_activity, tut_GAS1HT_final_best_p_activity, tut_GAS2HM_final_best_p_activity,...
    tut_GAS2HT_final_best_p_activity, tut_GAS3HM_final_best_p_activity, tut_GAS3HT_final_best_p_activity,...
    tut_GAS4HM_final_best_p_activity, tut_GAS4HT_final_best_p_activity, tut_GAS1HM_final_best_p_worker,...
    tut_GAS1HT_final_best_p_worker, tut_GAS2HM_final_best_p_worker, tut_GAS2HT_final_best_p_worker,...
    tut_GAS3HM_final_best_p_worker, tut_GAS3HT_final_best_p_worker, tut_GAS4HM_final_best_p_worker,...
    tut_GAS4HT_final_best_p_worker, tut_single_HM_proficiency_level, tut_single_HT_proficiency_level,...
    tut_multi_skill_set_of_worker, tut_multi_HM_proficiency_level, tut_multi_HT_proficiency_level,...
    tut_single_HM_worker_cost, tut_single_HT_worker_cost, tut_multi_HM_worker_cost, tut_multi_HT_worker_cost]...
                                                            = all_datas_sets( number_of_experiment, pactivities );

% Deney tasarýmý için ana döngü
for i = 1:size(pactivities,2)
    if i == 1
        number_of_pactivity = pactivities(1,1);
    elseif i == 2
        number_of_pactivity = pactivities(1,2);
    elseif i == 3
        number_of_pactivity = pactivities(1,3);
    end
    
    for j= 1:number_of_experiment
        if j ==1
            number_of_activity = activities(1,1);
            number_of_skill = skills(1,1);
            number_of_worker = workers(1,1);
        elseif j == 2
            number_of_activity = activities(1,1);
            number_of_skill = skills(1,1);
            number_of_worker = workers(1,2);
        elseif j == 3
            number_of_activity = activities(1,1);
            number_of_skill = skills(1,1);
            number_of_worker = workers(1,3);
        elseif j == 4
            number_of_activity = activities(1,1);
            number_of_skill = skills(1,2);
            number_of_worker = workers(1,1);
        elseif j == 5
            number_of_activity = activities(1,1);
            number_of_skill = skills(1,2);
            number_of_worker = workers(1,2);
        elseif j == 6
            number_of_activity = activities(1,1);
            number_of_skill = skills(1,2);
            number_of_worker = workers(1,3);
        elseif j == 7
            number_of_activity = activities(1,1);
            number_of_skill = skills(1,3);
            number_of_worker = workers(1,1); 
        elseif j == 8
            number_of_activity = activities(1,1);
            number_of_skill = skills(1,3);
            number_of_worker = workers(1,2); 
        elseif j == 9
            number_of_activity = activities(1,1);
            number_of_skill = skills(1,3);
            number_of_worker = workers(1,3);
        elseif j == 10
            number_of_activity = activities(1,2);
            number_of_skill = skills(1,1);
            number_of_worker = workers(1,1);
        elseif j == 11
            number_of_activity = activities(1,2);
            number_of_skill = skills(1,1);
            number_of_worker = workers(1,2);
        elseif j == 12
            number_of_activity = activities(1,2);
            number_of_skill = skills(1,1);
            number_of_worker = workers(1,3);
        elseif j == 13
            number_of_activity = activities(1,2);
            number_of_skill = skills(1,2);
            number_of_worker = workers(1,1);
        elseif j == 14
            number_of_activity = activities(1,2);
            number_of_skill = skills(1,2);
            number_of_worker = workers(1,2);
        elseif j == 15
            number_of_activity = activities(1,2);
            number_of_skill = skills(1,2);
            number_of_worker = workers(1,3);
        elseif j == 16
            number_of_activity = activities(1,2);
            number_of_skill = skills(1,3);
            number_of_worker = workers(1,1);
        elseif j == 17
            number_of_activity = activities(1,2);
            number_of_skill = skills(1,3);
            number_of_worker = workers(1,2);
        elseif j == 18
            number_of_activity = activities(1,2);
            number_of_skill = skills(1,3);
            number_of_worker = workers(1,3);
        elseif j == 19
            number_of_activity = activities(1,3);
            number_of_skill = skills(1,1);
            number_of_worker = workers(1,1);
        elseif j == 20
            number_of_activity = activities(1,3);
            number_of_skill = skills(1,1);
            number_of_worker = workers(1,2);
        elseif j == 21
            number_of_activity = activities(1,3);
            number_of_skill = skills(1,1);
            number_of_worker = workers(1,3);
        elseif j == 22
            number_of_activity = activities(1,3);
            number_of_skill = skills(1,2);
            number_of_worker = workers(1,1);
        elseif j == 23
            number_of_activity = activities(1,3);
            number_of_skill = skills(1,2);
            number_of_worker = workers(1,2);
        elseif j == 24
            number_of_activity = activities(1,3);
            number_of_skill = skills(1,2);
            number_of_worker = workers(1,3);
        elseif j == 25
            number_of_activity = activities(1,3);
            number_of_skill = skills(1,3);
            number_of_worker = workers(1,1);
        elseif j == 26
            number_of_activity = activities(1,3);
            number_of_skill = skills(1,3);
            number_of_worker = workers(1,2);
        elseif j == 27
            number_of_activity = activities(1,3);
            number_of_skill = skills(1,3);
            number_of_worker = workers(1,3); 
        end
        
        %% Algoritmalar için gerekli girdi deðerlerlerinin belirlenmesi
        
        % Her bir deneydeki faktörler (A,B,W,S) için setler
        skill_set = 1:number_of_skill;
        activity_set = 1:number_of_activity;
        worker_set = 1:number_of_worker;
        while(1)
            cp1 = randi(number_of_activity-1);
            cp2 = cp1 + number_of_pactivity;
        if cp2 <= number_of_activity-1, break, end
        end
        pactivity_set = activity_set(1,cp1+1:cp2);
        tut_pactivity_set{j,i} = pactivity_set;
        
        % Aktivitelerin gerektirdiði beceri türleri ile bu aktivitelere
        % atanan toplam iþçi sayýlarýnýn belirlenmesi
        [ skill_matrix, total_skill_number ] = number_of_skills_and_workers( number_of_activity, number_of_skill, number_of_worker );
        tut_skill_matrix{j,i} = skill_matrix;
        tut_total_skill_number{j,i} = total_skill_number;
        
        % Tek becerili iþçi setleri, iþçilerin homojen yeterlilik
        % seviyeleri ile heterojen yeterlilik seviyelerinin belirlenmesi
        [ single_skill_set_of_worker, single_HM_proficiency_level, single_HT_proficiency_level,...
                                                        single_HM_worker_cost, single_HT_worker_cost ] = ...
                                                        single_skill_matrix( number_of_worker, number_of_skill,...
                                                        total_skill_number );
        tut_single_skill_set_of_worker{j,i} = single_skill_set_of_worker;
        tut_single_HM_proficiency_level{j,i} = single_HM_proficiency_level;
        tut_single_HT_proficiency_level{j,i} = single_HT_proficiency_level;
        tut_single_HM_worker_cost{j,i} = single_HM_worker_cost;
        tut_single_HT_worker_cost{j,i} = single_HT_worker_cost;
        
        % Çoklu becerili iþçi setleri, iþçilerin homojen yeterlilik
        % seviyeleri ile heterojen yeterlilik seviyelerinin belirlenmesi 
        [ multi_skill_set_of_worker, multi_HM_proficiency_level, multi_HT_proficiency_level,...
                                                        multi_HM_worker_cost, multi_HT_worker_cost ] = ...
                                                        multi_skill_matrix( number_of_worker, number_of_skill,...
                                                        total_skill_number );
        tut_multi_skill_set_of_worker{j,i} = multi_skill_set_of_worker;
        tut_multi_HM_proficiency_level{j,i} = multi_HM_proficiency_level;
        tut_multi_HT_proficiency_level{j,i} = multi_HT_proficiency_level;
        tut_multi_HM_worker_cost{j,i} = multi_HM_worker_cost;
        tut_multi_HT_worker_cost{j,i} = multi_HT_worker_cost;
        
        % Her bir aktivite için iþlem sürelerinin (PT) belirlenmesi
        [ task_time_of_each_skill ] = task_times( number_of_activity, skill_matrix, number_of_skill );
        tut_task_time_of_each_skill{j,i} = task_time_of_each_skill;

        % Aktiviteler arasýndaki öncelik iliþkilerinin belirlenmesi
        [ predecessor_matrix ] = predecence_relationship( number_of_activity, pactivity_set );
        tut_predecessor_matrix{j,i} = predecessor_matrix;
         
        % Aktiviteler arasýndaki ardýl iliþkilerinin belirlenmesi
        [ successor_matrix ] = successor_relationship( number_of_activity, predecessor_matrix );
        tut_successor_matrix{j,i} = successor_matrix;
        
%         % Malzeme akýþlarý bilgileri
%         [ fij, cij, dij ] = material_flow( successor_matrix, number_of_activity );
        
        % Bekleme olan istasyonlarýn belirlenmesi
        [ swc_single, swc_multi ] = waiting( number_of_activity, predecessor_matrix );
         
        %% Algoritmalarýn genetik algoritma ile çözümü
        
        % Genetik algoritma baþlangýç parametre deðerleri
        crprob = 0.9;
        mutprob = 0.1;
        iteration_number = 700;
        population_size = 50;
        number_of_elit_individuals = 2;

% GAS1HM: Genetic algorithm with single-skilled and homogeneous workers for scenario 1
tic;         
        [ cost, best_p_activity, best_p_worker ] = GAS1HM( population_size, number_of_activity,...
                                                        single_skill_set_of_worker, single_HM_proficiency_level,...
                                                        task_time_of_each_skill,skill_matrix, total_skill_number,...
                                                        predecessor_matrix, iteration_number, number_of_elit_individuals,...
                                                        successor_matrix, crprob, mutprob, number_of_skill,...
                                                        number_of_worker, single_HM_worker_cost, swc_single);
        cost_GAS1HM(j,i) = min(cost);
        min_index = find(min(cost) == cost(:,1));
        tut_GAS1HM_final_best_p_activity{j,i} = best_p_activity(min_index(1,1),:);
        tut_GAS1HM_final_best_p_worker{j,i} = best_p_worker(min_index(1,1),:);
time_GAS1HM(j,i) = toc;

% GAS1HT: Genetic algorithm with single-skilled and heterogeneous workers for scenario 1
tic;
        [ cost, best_p_activity, best_p_worker ] = GAS1HT( population_size, number_of_activity,...
                                                        single_skill_set_of_worker, single_HT_proficiency_level,...
                                                        task_time_of_each_skill,skill_matrix, total_skill_number,...
                                                        predecessor_matrix, iteration_number, number_of_elit_individuals,...
                                                        successor_matrix, crprob, mutprob, number_of_skill,...
                                                        number_of_worker, single_HT_worker_cost, swc_single);
        cost_GAS1HT(j,i) = min(cost);
        min_index = find(min(cost) == cost(:,1));
        tut_GAS1HT_final_best_p_activity{j,i} = best_p_activity(min_index(1,1),:);
        tut_GAS1HT_final_best_p_worker{j,i} = best_p_worker(min_index(1,1),:);
time_GAS1HT(j,i) = toc;

% GAS2HM: Genetic algorithm with single-skilled and homogeneous workers for scenario 2
tic;         
        [ cost, best_p_activity, best_p_worker ] = GAS2HM( population_size, number_of_activity,...
                                                        single_skill_set_of_worker, single_HM_proficiency_level,...
                                                        task_time_of_each_skill,skill_matrix, total_skill_number,...
                                                        predecessor_matrix, iteration_number, number_of_elit_individuals,...
                                                        successor_matrix, crprob, mutprob, number_of_skill,...
                                                        single_HM_worker_cost, swc_single );
        cost_GAS2HM(j,i) = min(cost);
        min_index = find(min(cost) == cost(:,1));
        tut_GAS2HM_final_best_p_activity{j,i} = best_p_activity(min_index(1,1),:);
        tut_GAS2HM_final_best_p_worker{j,i} = best_p_worker(min_index(1,1),:);
time_GAS2HM(j,i) = toc;

% GAS2HT: Genetic algorithm with single-skilled and heterogeneous workers for scenario 2
tic;
        [ cost, best_p_activity, best_p_worker ] = GAS2HT( population_size, number_of_activity,...
                                                        single_skill_set_of_worker, single_HT_proficiency_level,...
                                                        task_time_of_each_skill,skill_matrix, total_skill_number,...
                                                        predecessor_matrix, iteration_number, number_of_elit_individuals,...
                                                        successor_matrix, crprob, mutprob, number_of_skill,...
                                                        single_HT_worker_cost, swc_single );
        cost_GAS2HT(j,i) = min(cost);
        min_index = find(min(cost) == cost(:,1));
        tut_GAS2HT_final_best_p_activity{j,i} = best_p_activity(min_index(1,1),:);
        tut_GAS2HT_final_best_p_worker{j,i} = best_p_worker(min_index(1,1),:);
time_GAS2HT(j,i) = toc;

% GAS3HM: Genetic algorithm with cross-trained and homogeneous workers for scenario 3
tic;
        [ cost, best_p_activity, best_p_worker ] = GAS3HM( population_size, number_of_activity,...
                                                        multi_skill_set_of_worker, multi_HM_proficiency_level,...
                                                        task_time_of_each_skill,skill_matrix, total_skill_number,...
                                                        predecessor_matrix, iteration_number, number_of_elit_individuals,...
                                                        successor_matrix, crprob, mutprob, number_of_skill,...
                                                        multi_HM_worker_cost, swc_multi );
        cost_GAS3HM(j,i) = min(cost);
        min_index = find(min(cost) == cost(:,1));
        tut_GAS3HM_final_best_p_activity{j,i} = best_p_activity(min_index(1,1),:);
        tut_GAS3HM_final_best_p_worker{j,i} = best_p_worker(min_index(1,1),:);
time_GAS3HM(j,i) = toc;

% GAS3HT: Genetic algorithm with cross-trained and heterogeneous workers for scenario 3
tic;
        [ cost, best_p_activity, best_p_worker ] = GAS3HT( population_size, number_of_activity,...
                                                        multi_skill_set_of_worker, multi_HT_proficiency_level,...
                                                        task_time_of_each_skill,skill_matrix, total_skill_number,...
                                                        predecessor_matrix, iteration_number, number_of_elit_individuals,...
                                                        successor_matrix, crprob, mutprob, number_of_skill,...
                                                        multi_HT_worker_cost, swc_multi );
        cost_GAS3HT(j,i) = min(cost);
        min_index = find(min(cost) == cost(:,1));
        tut_GAS3HT_final_best_p_activity{j,i} = best_p_activity(min_index(1,1),:);
        tut_GAS3HT_final_best_p_worker{j,i} = best_p_worker(min_index(1,1),:);
time_GAS3HT(j,i) = toc;

% GAS4HM: Genetic algorithm with cross-trained and homogeneous workers for scenario 4
tic;
        [ cost, best_p_activity, best_p_worker ] = GAS4HM( population_size, number_of_activity,...
                                                        multi_skill_set_of_worker, multi_HM_proficiency_level,...
                                                        task_time_of_each_skill,skill_matrix, total_skill_number,...
                                                        predecessor_matrix, iteration_number, number_of_elit_individuals,...
                                                        successor_matrix, crprob, mutprob, number_of_skill,...
                                                        multi_HM_worker_cost, swc_multi );
        cost_GAS4HM(j,i) = min(cost);
        min_index = find(min(cost) == cost(:,1));
        tut_GAS4HM_final_best_p_activity{j,i} = best_p_activity(min_index(1,1),:);
        tut_GAS4HM_final_best_p_worker{j,i} = best_p_worker(min_index(1,1),:);
time_GAS4HM(j,i) = toc;

% GAS4HT: Genetic algorithm with cross-trained and heterogeneous workers for scenario 4
tic;
        [ cost, best_p_activity, best_p_worker ] = GAS4HT( population_size, number_of_activity,...
                                                        multi_skill_set_of_worker, multi_HT_proficiency_level,...
                                                        task_time_of_each_skill,skill_matrix, total_skill_number,...
                                                        predecessor_matrix, iteration_number, number_of_elit_individuals,...
                                                        successor_matrix, crprob, mutprob, number_of_skill,...
                                                        multi_HT_worker_cost, swc_multi );
        cost_GAS4HT(j,i) = min(cost);
        min_index = find(min(cost) == cost(:,1));
        tut_GAS4HT_final_best_p_activity{j,i} = best_p_activity(min_index(1,1),:);
        tut_GAS4HT_final_best_p_worker{j,i} = best_p_worker(min_index(1,1),:);
time_GAS4HT(j,i) = toc;

    end
end

algorithm1 = sprintf('1-Run1_cost.xlsx');
filename1 = sprintf('%s',algorithm1);
xlswrite(filename1,cost_GAS1HM,1);
xlswrite(filename1,cost_GAS1HT,2);
xlswrite(filename1,cost_GAS2HM,3);
xlswrite(filename1,cost_GAS2HT,4);
xlswrite(filename1,cost_GAS3HM,5);
xlswrite(filename1,cost_GAS3HT,6);
xlswrite(filename1,cost_GAS4HM,7);
xlswrite(filename1,cost_GAS4HT,8);

algorithm2 = sprintf('2-Run1_time.xlsx');
filename2 = sprintf('%s',algorithm2);
xlswrite(filename2,time_GAS1HM,1);
xlswrite(filename2,time_GAS1HT,2);
xlswrite(filename2,time_GAS2HM,3);
xlswrite(filename2,time_GAS2HT,4);
xlswrite(filename2,time_GAS3HM,5);
xlswrite(filename2,time_GAS3HT,6);
xlswrite(filename2,time_GAS4HM,7);
xlswrite(filename2,time_GAS4HT,8);

