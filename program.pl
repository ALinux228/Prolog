% Задание 1: Определить, в каком из двух чисел больше цифр
% Подсчет количества цифр в числе
count_digits(0, 1) :- !.
count_digits(N, Count) :-
    N > 0,
    N1 is N // 10,
    count_digits(N1, Count1),
    Count is Count1 + 1.
count_digits(N, Count) :-
    N < 0,
    N1 is -N,
    count_digits(N1, Count).

% Сравнение количества цифр в двух числах
more_digits(First, Second, Result) :-
    count_digits(First, C1),
    count_digits(Second, C2),
    (   C1 > C2 -> Result = first
    ;   C1 < C2 -> Result = second
    ;   Result = equal
    ).


% Задание 2: Сумма элементов, оканчивающихся на заданную цифру
% Последняя цифра числа
last_digit(N, D) :-
    D is abs(N) mod 10.

% Сумма элементов, оканчивающихся на заданную цифру
sum_ending_with([], _, 0).
sum_ending_with([H|T], Digit, Sum) :-
    last_digit(H, Last),
    (   Last =:= Digit ->
        sum_ending_with(T, Digit, Sum1),
        Sum is H + Sum1
    ;   sum_ending_with(T, Digit, Sum)
    ).


% Задание 3: Объединение множеств
% Проверка принадлежности
member_of(X, [X|_]).
member_of(X, [_|T]) :-
    member_of(X, T).

% Удаление дубликатов
remove_duplicates([], []).
remove_duplicates([H|T], R) :-
    member_of(H, T),
    remove_duplicates(T, R).
remove_duplicates([H|T], [H|R]) :-
    not(member_of(H, T)),
    remove_duplicates(T, R).

% Объединение множеств
union_sets(Set1, Set2, Union) :-
    append(Set1, Set2, Combined),
    remove_duplicates(Combined, Union).


% Задание 4: Логическая задача
solve :-
    member(A, [true, false]),
    member(B, [true, false]),
    member(C, [true, false]),
    
    % Вычисляем истинность условий
    ( (A, B, C) -> C1 = 1 ; (not(A) -> C1 = 1 ; C1 = 0) ),
    ( (A, C) -> C2 = 1 ; (not(A), not(C)) -> C2 = 1 ; C2 = 0 ),
    ( (C, B) -> C3 = 1 ; (not(C) -> C3 = 1 ; C3 = 0) ),
    
    C1 + C2 + C3 =:= 2,
    
    write('A = '), write(A), nl,
    write('B = '), write(B), nl,
    write('C = '), write(C), nl.

start :-
    nl,
    write('1. Compare digits count'), nl,
    write('2. Sum of elements ending with digit'), nl,
    write('3. Union of sets'), nl,
    write('4. Logic task'), nl,
    write('0. Exit'), nl,
    write('Choice: '),
    read(Choice),
    run_task(Choice).

run_task(0) :- write('Goodbye!'), nl.
run_task(1) :-
    write('Enter first number: '),
    read(A),
    write('Enter second number: '),
    read(B),
    more_digits(A, B, R),
    write('Result: '), write(R), nl,
    start.
run_task(2) :-
    write('Enter list (e.g., [12,25,32,45,52]): '),
    read(List),
    write('Enter digit: '),
    read(Digit),
    sum_ending_with(List, Digit, Sum),
    write('Sum = '), write(Sum), nl,
    start.
run_task(3) :-
    write('Enter first set (list): '),
    read(Set1),
    write('Enter second set (list): '),
    read(Set2),
    union_sets(Set1, Set2, Union),
    write('Union: '), write(Union), nl,
    start.
run_task(4) :-
    solve,
    start.
run_task(_) :-
    write('Invalid choice'), nl,
    start.
