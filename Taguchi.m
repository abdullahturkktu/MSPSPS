clc;
clear;

numWorkers = 12;
pool = parpool('local', numWorkers, 'IdleTimeout', Inf); % Süresiz

number_of_activity = 16;
number_of_pactivity = 7;
number_of_worker = 80;
number_of_skill = 10;
workers = number_of_worker;

% Algoritmalar için gerekli girdi deðerlerlerinin belirlenmesi
        
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
        
        % Aktivitelerin gerektirdiði beceri türleri ile bu aktivitelere
        % atanan toplam iþçi sayýlarýnýn belirlenmesi
        [ skill_matrix, total_skill_number ] = number_of_skills_and_workers( number_of_activity, number_of_skill, number_of_worker );
        
        % Tek becerili iþçi setleri, iþçilerin homojen yeterlilik
        % seviyeleri ile heterojen yeterlilik seviyelerinin belirlenmesi
        [ single_skill_set_of_worker, single_HM_proficiency_level, single_HT_proficiency_level,...
                                                        single_HM_worker_cost, single_HT_worker_cost ] = ...
                                                        single_skill_matrix( number_of_worker, number_of_skill,...
                                                        total_skill_number );
        
        % Çoklu becerili iþçi setleri, iþçilerin homojen yeterlilik
        % seviyeleri ile heterojen yeterlilik seviyelerinin belirlenmesi 
        [ multi_skill_set_of_worker, multi_HM_proficiency_level, multi_HT_proficiency_level,...
                                                        multi_HM_worker_cost, multi_HT_worker_cost ] = ...
                                                        multi_skill_matrix( number_of_worker, number_of_skill,...
                                                        total_skill_number );
        
        % Her bir aktivite için iþlem sürelerinin (PT) belirlenmesi
        [ task_time_of_each_skill ] = task_times( number_of_activity, skill_matrix, number_of_skill );

        % Aktiviteler arasýndaki öncelik iliþkilerinin belirlenmesi
        [ predecessor_matrix ] = predecence_relationship( number_of_activity, pactivity_set );
         
        % Aktiviteler arasýndaki ardýl iliþkilerinin belirlenmesi
        [ successor_matrix ] = successor_relationship( number_of_activity, predecessor_matrix );
        
%         % Malzeme akýþlarý bilgileri
%         [ fij, cij, dij ] = material_flow( successor_matrix, number_of_activity );
        
        % Bekleme olan istasyonlarýn belirlenmesi
        [ swc_single, swc_multi ] = waiting( number_of_activity, predecessor_matrix );

% Parametre ve seviyeleri
A = [50 100 150];
B = [0.7 0.8 0.9];
C = [0.01 0.05 0.1];
D = [300 500 700];

parametre_ve_seviyeleri = [A;B;C;D];

% Ortogonal array (L9 Ortogonal Dizi)
orthogonal_array = [1	1	1	1;
                    1	2	2	2;
                    1	3	3	3;
                    2	1	2	3;
                    2	2	3	1;
                    2	3	1	2;
                    3	1	3	2;
                    3	2	1	3;
                    3	3	2	1];

run_number = 1;
number_of_algorithm = 8;
deney = zeros(size(orthogonal_array,1),size(orthogonal_array,2));
time = zeros(size(orthogonal_array,1),number_of_algorithm);
objective = zeros(size(orthogonal_array,1),number_of_algorithm);
final_best_p_activity = cell(size(orthogonal_array,1),number_of_algorithm);
final_best_p_worker = cell(size(orthogonal_array,1),number_of_algorithm);

a = 1;
while(1)

deney(a,:) = orthogonal_array(a,:);

        % Algoritmalarýn genetik algoritma ile çözümü
        % Genetik algoritma baþlangýç parametre deðerleri
        
        population_size = A(1,deney(a,1));
        crprob = B(1,deney(a,2));
        mutprob = C(1,deney(a,3));
        iteration_number = D(1,deney(a,4));
        number_of_elit_individuals = 2;
        
for b = 1:run_number
               
% GAS1HM: Genetic algorithm with single-skilled and homogeneous workers for scenario 1
tic;         
        [ cost ] = GAS1HM( population_size, number_of_activity,...
                                                        single_skill_set_of_worker, single_HM_proficiency_level,...
                                                        task_time_of_each_skill,skill_matrix, total_skill_number,...
                                                        predecessor_matrix, iteration_number, number_of_elit_individuals,...
                                                        successor_matrix, crprob, mutprob, number_of_skill,...
                                                        number_of_worker, single_HM_worker_cost, swc_single);
        objective(a,1) = min(cost);
time_GAS1HM = toc;
time(a,1) = time_GAS1HM;

% GAS1HT: Genetic algorithm with single-skilled and heterogeneous workers for scenario 1
tic;
        [ cost ] = GAS1HT( population_size, number_of_activity,...
                                                        single_skill_set_of_worker, single_HT_proficiency_level,...
                                                        task_time_of_each_skill,skill_matrix, total_skill_number,...
                                                        predecessor_matrix, iteration_number, number_of_elit_individuals,...
                                                        successor_matrix, crprob, mutprob, number_of_skill,...
                                                        number_of_worker, single_HT_worker_cost, swc_single);
        objective(a,2) = min(cost);
time_GAS1HT = toc;
time(a,2) = time_GAS1HT;

% GAS2HM: Genetic algorithm with single-skilled and homogeneous workers for scenario 2
tic;         
        [ cost ] = GAS2HM( population_size, number_of_activity,...
                                                        single_skill_set_of_worker, single_HM_proficiency_level,...
                                                        task_time_of_each_skill,skill_matrix, total_skill_number,...
                                                        predecessor_matrix, iteration_number, number_of_elit_individuals,...
                                                        successor_matrix, crprob, mutprob, number_of_skill,...
                                                        single_HM_worker_cost, swc_single );
        objective(a,3) = min(cost);
time_GAS2HM = toc;
time(a,3) = time_GAS2HM;

% GAS2HT: Genetic algorithm with single-skilled and heterogeneous workers for scenario 2
tic;
        [ cost ] = GAS2HT( population_size, number_of_activity,...
                                                        single_skill_set_of_worker, single_HT_proficiency_level,...
                                                        task_time_of_each_skill,skill_matrix, total_skill_number,...
                                                        predecessor_matrix, iteration_number, number_of_elit_individuals,...
                                                        successor_matrix, crprob, mutprob, number_of_skill,...
                                                        single_HT_worker_cost, swc_single );
        objective(a,4) = min(cost);
time_GAS2HT = toc;
time(a,4) = time_GAS2HT;

% GAS3HM: Genetic algorithm with cross-trained and homogeneous workers for scenario 3
tic;
        [ cost ] = GAS3HM( population_size, number_of_activity,...
                                                        multi_skill_set_of_worker, multi_HM_proficiency_level,...
                                                        task_time_of_each_skill,skill_matrix, total_skill_number,...
                                                        predecessor_matrix, iteration_number, number_of_elit_individuals,...
                                                        successor_matrix, crprob, mutprob, number_of_skill,...
                                                        multi_HM_worker_cost, swc_multi );
        objective(a,5) = min(cost);
time_GAS3HM = toc;
time(a,5) = time_GAS3HM;

% GAS3HT: Genetic algorithm with cross-trained and heterogeneous workers for scenario 3
tic;
        [ cost ] = GAS3HT( population_size, number_of_activity,...
                                                        multi_skill_set_of_worker, multi_HT_proficiency_level,...
                                                        task_time_of_each_skill,skill_matrix, total_skill_number,...
                                                        predecessor_matrix, iteration_number, number_of_elit_individuals,...
                                                        successor_matrix, crprob, mutprob, number_of_skill,...
                                                        multi_HT_worker_cost, swc_multi );
        objective(a,6) = min(cost);
time_GAS3HT = toc;
time(a,6) = time_GAS3HT;

% GAS4HM: Genetic algorithm with cross-trained and homogeneous workers for scenario 4
tic;
        [ cost ] = GAS4HM( population_size, number_of_activity,...
                                                        multi_skill_set_of_worker, multi_HM_proficiency_level,...
                                                        task_time_of_each_skill,skill_matrix, total_skill_number,...
                                                        predecessor_matrix, iteration_number, number_of_elit_individuals,...
                                                        successor_matrix, crprob, mutprob, number_of_skill,...
                                                        multi_HM_worker_cost, swc_multi );
        objective(a,7) = min(cost);
time_GAS4HM = toc;
time(a,7) = time_GAS4HM;

% GAS4HT: Genetic algorithm with cross-trained and heterogeneous workers for scenario 4
tic;
        [ cost ] = GAS4HT( population_size, number_of_activity,...
                                                        multi_skill_set_of_worker, multi_HT_proficiency_level,...
                                                        task_time_of_each_skill,skill_matrix, total_skill_number,...
                                                        predecessor_matrix, iteration_number, number_of_elit_individuals,...
                                                        successor_matrix, crprob, mutprob, number_of_skill,...
                                                        multi_HT_worker_cost, swc_multi );
        objective(a,8) = min(cost);
time_GAS4HT = toc;
time(a,8) = time_GAS4HT;

% plot(makespan,'LineWidth',2)
% title(sprintf('Experiment%d, Run%d',a,b),'fontweight','bold','fontsize',16);
% xlabel('Number of Iteration','fontweight','bold','fontsize',16);
% ylabel('Makespan','fontweight','bold','fontsize',16);
% filename = sprintf('Deney%dRun%d.jpg',a,b);
% saveas(gcf,filename)
% close(gcf);
% time(a,b) = toc;
% objective(a,b) = min(makespan);
% min_index = find(min(makespan) == makespan(:,1));
% final_best_p_activity{a,b} = best_p_activity(min_index(1,1),:);
% final_best_p_worker{a,b} = best_p_worker(min_index(1,1),:);

end

a = a+1;
if a > size(orthogonal_array,1), break, end;
end

algorithm = sprintf('Taguchi Sonuçlar.xlsx');
filename_Tag = sprintf('%s',algorithm);
xlswrite(filename_Tag,objective,1);
xlswrite(filename_Tag,time,2);
% xlswrite(filename_Tag,processing_times,3);
xlswrite(filename_Tag,skill_matrix,4);
xlswrite(filename_Tag,predecessor_matrix,5);
xlswrite(filename_Tag,successor_matrix,6);
xlswrite(filename_Tag,total_skill_number,7);
xlswrite(filename_Tag,pactivity_set,8);
 
