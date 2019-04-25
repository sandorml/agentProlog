generate_pos(BoardHeight,BoardWidth,Dirty,Obstacles,Childs,Corral,Pos):-
	A is random(BoardHeight),
	B is random(BoardWidth),
	append([A],[B],Pos),
	not(member(Pos,Dirty)),
	not(member(Pos,Obstacles)),
	not(member(Pos,Childs)),
	not(member(Pos,Corral)),!.

generate_pos(BoardHeight,BoardWidth,Dirty,Obstacles,Childs,Corral,Pos):-
		generate_pos(BoardHeight,BoardWidth,Dirty,Obstacles,Childs,Corral,Pos).

generate_obstacle(BoardHeight,BoardWidth,ObstacleCount,Dirty,Obstacles,Childs,Corral,ResultObstacles):-
	ObstacleCount > 0,
	X is ObstacleCount-1,
	generate_pos(BoardHeight,BoardWidth,Dirty,Obstacles,Childs,Corral,Pos),
	Result = [Pos|Obstacles],
	generate_obstacle(BoardHeight,BoardWidth,X,Dirty,Result,Childs,Corral,Result2),
	append([],Result2,ResultObstacles),!.

generate_obstacle(BoardHeight,BoardWidth,0,Dirty,Obstacles,Childs,Corral,ResultObstacles):- 
	ResultObstacles = Obstacles.
			
generate_dirty(BoardHeight,BoardWidth,DirtinessCount,Dirty,Obstacles,Childs,Corral,ResultDirtiness):-
	DirtinessCount > 0,
	X is DirtinessCount-1,
	generate_pos(BoardHeight,BoardWidth,Dirty,Obstacles,Childs,Corral,Pos),
	Result = [Pos|Dirty],
	generate_dirty(BoardHeight,BoardWidth,X,Result,Obstacles,Childs,Corral,Result2),
	append([],Result2,ResultDirtiness),!.

generate_dirty(BoardHeight,BoardWidth,0,Dirty,Obstacles,Childs,Corral,ResultDirtiness):- 
	ResultDirtiness = Dirty.

generate_childs(BoardHeight,BoardWidth,ChildsCount,Dirty,Obstacles,Childs,Corral,ResultChilds):-
	ChildsCount > 0,
	X is ChildsCount-1,
	generate_pos(BoardHeight,BoardWidth,Dirty,Obstacles,Childs,Corral,Pos),
	Result = [Pos|Childs],
	generate_childs(BoardHeight,BoardWidth,X,Dirty,Obstacles,Result,Corral,Result2),
	append([],Result2,ResultChilds),!.

generate_childs(BoardHeight,BoardWidth,0,Dirty,Obstacles,Childs,Corral,ResultChilds):- 
	ResultChilds = Childs.

sample(L, R) :- 
	length(L, Len), 
	random(0, Len, Random), 
	nth0(Random, L, R).

generate_corral(BoardHeight, BoardWidth, CorralCount, Corrales, CorralResult) :-
	CorralCount > 0,
	C is CorralCount-1,
	random(0, 4, R),
    sample(Corrales,[X,Y]),
    ((R =:= 0, X1 is X + 1,
        append([X1],[Y],Pos),
        X1 > -1, X1 < BoardWidth, Y > -1, Y < BoardHeight);
     (R =:= 1, X1 is X - 1,
        append([X1],[Y],Pos),
        X1 > -1, X1 < BoardWidth, Y > -1, Y < BoardHeight);
     (R =:= 2, Y1 is Y + 1,
        append([X],[Y1],Pos),
        X > -1, X < BoardWidth, Y1 > -1, Y1 < BoardHeight);
     (R =:= 3, Y1 is Y - 1,
        append([X],[Y1],Pos),
        X > -1, X < BoardWidth, Y1 > -1, Y1 < BoardHeight)),

	not(member(Pos, Corrales)),
	Result = [Pos|Corrales],
			
	generate_corral(BoardHeight, BoardWidth, C, Result, Result2),
	append([],Result2,CorralResult),!.


generate_corral(BoardHeight, BoardWidth,0, Corrales, CorralResult) :-
	CorralResult = Corrales.

generate_corral(BoardHeight, BoardWidth,CorralCount, Corrales, CorralResult) :-
	generate_corral(BoardHeight, BoardWidth,CorralCount, Corrales, CorralResult).

new_dirty(BoardHeight, BoardWidth, [X,Y],Pos):-
	%How to use
	% new_dirty(BoardHeight,BoardWidth, [5,4], Pos),
	% write(Pos).
	random(0, 8, R),	
	((R =:= 0, X1 is X + 1,
        append([X1],[Y],Pos),
        X1 > -1, X1 < BoardWidth, Y > -1, Y < BoardHeight);
     (R =:= 1, X1 is X - 1,
        append([X1],[Y],Pos),
        X1 > -1, X1 < BoardWidth, Y > -1, Y < BoardHeight);
     (R =:= 2, Y1 is Y + 1,
        append([X],[Y1],Pos),
        X > -1, X < BoardWidth, Y1 > -1, Y1 < BoardHeight);
     (R =:= 3, Y1 is Y - 1,
        append([X],[Y1],Pos),
		X > -1, X < BoardWidth, Y1 > -1, Y1 < BoardHeight);
	 (R =:= 4, X1 is X + 1, Y1 is Y+1,
        append([X1],[Y1],Pos),
        X1 > -1, X1 < BoardWidth, Y1 > -1, Y1 < BoardHeight);
     (R =:= 5, X1 is X - 1 , Y1 is Y-1,
        append([X1],[Y1],Pos),
        X1 > -1, X1 < BoardWidth, Y1 > -1, Y1 < BoardHeight);
     (R =:= 6, X1 is X + 1, Y1 is Y-1,
        append([X1],[Y1],Pos),
        X1 > -1, X1 < BoardWidth, Y1 > -1, Y1 < BoardHeight);
     (R =:= 7, X1 is X - 1, Y1 is Y+1,
        append([X1],[Y1],Pos),
        X1 > -1, X1 < BoardWidth, Y1 > -1, Y1 < BoardHeight)),!.

new_dirty(BoardHeight, BoardWidth, [X,Y],Pos):-
	Pos = [].


inList(Item, List, R):-
	member(Item, List), R is 1, !.	

inList(Item, List, R):-
	not(member(Item, List)), R is 0.

countChildsAround([X,Y], Childs, R):-
	X1 is X + 1,
	inList([X1,Y], Childs, R1),
	Y1 is Y+1,
	inList([X,Y1], Childs, R2),
	inList([X1,Y1], Childs, R3),
	X2 is X-1,
	inList([X2,Y], Childs, R4),
	Y2 is Y-1,
	inList([X,Y2], Childs, R5),
	inList([X2,Y2], Childs, R6),
	inList([X1,Y2], Childs, R7),
	inList([X2,Y1], Childs, R8),
	R is R1+R2+R3+R4+R5+R6+R7+R8.

add_list_set(Dirty,Obstacles,Item,List,Result):-
	length(Item, L),
	L > 0,
	not(member(Item,Dirty)),
	not(member(Item,Obstacles)),
	not(member(Item, List)),
	append([Item],List,Result).
	
add_list_set(Dirty,Obstacles, Item,List,R):-
	R = List.
		
dirty_result(BoardHeight, BoardWidth,Dirty,Obstacles,0, PosChild, DirtyResult):-
	new_dirty(BoardHeight, BoardWidth, PosChild,Pos1),
	add_list_set(Dirty,Obstacles,Pos1,[],DirtyResult),!.

dirty_result(BoardHeight, BoardWidth,Dirty,Obstacles,1, PosChild, DirtyResult):-
	new_dirty(BoardHeight, BoardWidth, PosChild,Pos1),
	new_dirty(BoardHeight, BoardWidth, PosChild,Pos2),

	add_list_set(Dirty,Obstacles,Pos1,[],DirtyResult1),
	add_list_set(Dirty,Obstacles,Pos2,DirtyResult1,DirtyResult),!.

dirty_result(BoardHeight, BoardWidth,Dirty,Obstacles,R, PosChild, DirtyResult):-
	new_dirty(BoardHeight, BoardWidth, PosChild,Pos1),
	new_dirty(BoardHeight, BoardWidth, PosChild,Pos2),
	new_dirty(BoardHeight, BoardWidth, PosChild,Pos3),
	new_dirty(BoardHeight, BoardWidth, PosChild,Pos4),
	new_dirty(BoardHeight, BoardWidth, PosChild,Pos5),
	new_dirty(BoardHeight, BoardWidth, PosChild,Pos6),
	
	add_list_set(Dirty,Obstacles,Pos1,[],DirtyResult1),
	add_list_set(Dirty,Obstacles,Pos2,DirtyResult1,DirtyResult2),
	
	add_list_set(Dirty,Obstacles,Pos3,DirtyResult2,DirtyResult3),
	add_list_set(Dirty,Obstacles,Pos4,DirtyResult3,DirtyResult4),
	add_list_set(Dirty,Obstacles,Pos5,DirtyResult4,DirtyResult5),
	add_list_set(Dirty,Obstacles,Pos6,DirtyResult5,DirtyResult).


make_dirty(BoardHeight, BoardWidth,Dirty,Obstacles, PosChild, Childs, DirtyResult):-
	countChildsAround(PosChild, Childs, R),
	dirty_result(BoardHeight, BoardWidth,Dirty,Obstacles,R, PosChild, DirtyResult).



move_obstacle(BoardHeight, BoardWidth, Dirty,Obstacles,Childs,Corral, [I,J], [X,Y], Result):-
	X1 is X+I,
	Y1 is Y+J,
	not(member([X1,Y1], Obstacles)),
	not(member([X1,Y1],Dirty)),
	not(member([X1,Y1],Childs)),
	not(member([X1,Y1],Corral)),
	X1 < BoardWidth,
	X1 > -1,
	Y1 < BoardHeight,
	Y1 > -1,
	delete(Obstacles, [X,Y], Result2),
	append([[X1,Y1]],Result2, Result),!.

move_obstacle(BoardHeight, BoardWidth, Dirty,Obstacles,Childs,Corral, [I,J], [X,Y], Result):-
	X1 is X+I,
	Y1 is Y+J,
	member([X1,Y1], Obstacles),
	move_obstacle(BoardHeight, BoardWidth, Dirty,Obstacles,Childs,Corral, [I,J], [X1,Y1], Result2),
	delete(Result2, [X,Y], Result3),	
	append(Result3,[], Result4),
	append([[X1,Y1]],Result4, Result),!.

move_obstacle(BoardHeight, BoardWidth, Dirty,Obstacles,Childs,Corral, [I,J], [X,Y], Obstacles).



% Helpers Predicates
adjacent(X, Y, X1, Y):- X1 is X+1.
adjacent(X, Y, X1, Y):- X1 is X-1.
adjacent(X, Y, X, Y1):- Y1 is Y+1.
adjacent(X, Y, X, Y1):- Y1 is Y-1.
adjacent(X, Y, X1, Y1):- X1 is X+1, Y1 is Y+1.
adjacent(X, Y, X1, Y1):- X1 is X-1, Y1 is Y-1.
adjacent(X, Y, X1, Y1):- X1 is X+1, Y1 is Y-1.
adjacent(X, Y, X1, Y1):- X1 is X-1, Y1 is Y+1.


is_dirt(X, Y, Dirtlist):- member((X, Y), Dirtlist).
inside_enviroment(X, Y, N, M):-
	X >= 0,X < N, 
	Y >= 0,Y < M.

% temporary almost dirty definition
is_very_dirty(Dirts, _, _, N, M):- 
	length(Dirts, Size), 
	N * M * 60 / 100 =< Size + N + M.

%=====================================================================+

% BFS Helpers Predicates
visited(Node, [LastPath|[]]):-member(Node, LastPath), !.
visited(Node, [Path|Paths]):-
	member(Node, Path);
	visited(Node, Paths).

expand([[[X, Y]|Path]|Paths], N, M, Obstacles, Extended):-
    findall(
        [[U,V], [X, Y]|Path],
        (
            adjacent(X, Y, U, V),	
            inside_enviroment(U, V, N, M),
            not(member([U, V], Obstacles)),
        not(visited([U,V], [[[X, Y]|Path]|Paths]))
    )
, Extended).

% BFS(PathsQueue, Rows, Cols, Obstacles, Goals, Solution)
% returns the first shortest path to a goal from the list of goals
bfs([[Node|Path]|_], _, _, _, GoalsList, Solution):-
	member(Node, GoalsList),
	reverse([Node|Path], Solution),	!.

bfs(PathsQueue, N, M, Obstacles, GoalsList, Solution):-
	PathsQueue = [_|Paths],
	expand(PathsQueue, N, M, Obstacles, Extended),
	append(Paths, Extended, Path1),
	bfs(Path1, N, M, Obstacles, GoalsList, Solution).

%=====================================================================+

% ver que no pase por una casilla que tiene ninnos con un ninno ya cargado
% camina el robot.
robot1(BoardHeight,BoardWidth, Pos, Childs, Dirty,Obstacles, ChildsResult, DirtyResult, NewPos):-
	member(Pos, Dirty),
	writeln('se encontro suciedad en'),
	writeln(Pos),
	delete(Dirty, Pos, DirtyResult),
	NewPos = Pos,
	writeln('se queda en el mismo lugar'),
	ChildsResult = Result,!.

%si bfs da falso es que no hay camino
robot1(BoardHeight,BoardWidth, Pos, Childs, Dirty,Obstacles, ChildsResult, DirtyResult, NewPos):-
	bfs([[Pos]], BoardHeight, BoardWidth, Obstacles, Dirty, Path),
	length(Path, L),
	L >=1,
	nth0(1, Path, NewPos),
	DirtyResult= Dirty,
	ChildsResult= Childs.

moveChild(BoardHeight, BoardWidth, [X,Y],Dirty,Childs,Corral, Obstacles, ResultObstacles, ResultChilds):-
	sample([[1,0],[0,1],[-1,0],[0,-1],[1,1],[-1,-1],[1,-1],[-1,1]],[I,J]),
	X1 is X+I,
	Y1 is Y+J,
	X1 < BoardWidth, 
	X1 > -1,
	Y1 < BoardHeight, 
	Y1 > -1,
	not(member([X1,Y1],Childs)),
	member([X1,Y1], Obstacles),
	move_obstacle(BoardHeight, BoardWidth, Dirty,Obstacles,Childs,Corral, [I,J], [X1,Y1], ResultObstacles),
	delete(Childs, [X,Y], List2),
	% ResultChilds = [],
	append([[X1,Y1]], List2, ResultChilds),!.
	


moveChild(BoardHeight, BoardWidth, [X,Y],Dirty,Childs,Corral, Obstacles, ResultObstacles, ResultChilds):-
	sample([[1,0],[0,1],[-1,0],[0,-1],[1,1],[-1,-1],[1,-1],[-1,1]],[I,J]),
	X1 is X+I,
	Y1 is Y+J,
	X1 < BoardWidth, X1 > -1,
	Y1 < BoardHeight, Y1 > -1,
	not(member([X1,Y1],Childs)),
	not(member([X1,Y1], Obstacles)),
	ResultObstacles = Obstacles,
	delete(Childs, [X,Y], List2),
	append([[X1,Y1]], List2, ResultChilds),!.



moveChild(BoardHeight, BoardWidth, [X,Y],Dirty,Childs,Corral, Obstacles, ResultObstacles, ResultChilds):-
	ResultObstacles = Obstacles,
	ResultChilds = Childs.



% aqui se esta partiendo en algun lugar
itChilds(BoardHeight, BoardWidth, Length, Dirty,Obstacles, Childs,Corral, DirtyResult, ObstaclesResult, ChildsResult):-
	Length > 0,
	Pos is Length - 1,
	writeln(Childs),		
	nth0(Pos, Childs, PosChild),
	%	ensucia
	make_dirty(BoardHeight, BoardWidth, Dirty,Obstacles, PosChild, Childs, DirtyResult2),
	writeln('++++++++++++DirtyResult2++++++++++++'),
	writeln(DirtyResult2),
	writeln('++++++++++++----------------------++++++++++++'),
	append(DirtyResult2, Dirty, DirtyResult),
	writeln(DirtyResult),
	writeln('++++++++++++----------------------++++++++++++'),
	%	mover
	writeln(Childs),
	moveChild(BoardHeight, BoardWidth, PosChild,DirtyResult3,Childs,Corral, Obstacles, ObstaclesResult, ChildsResult),
	writeln('++++++++++++-----ChildsResult-------++++++++++++'),
	writeln(ChildsResult).
	% % writeln('Childs'),
	% % writeln(Childs),
	% %	proximo ninno
	% itChilds(BoardHeight,BoardWidth, Pos, Dirty,ResultObstacles, ResultChilds,Corral, DirtyResult4, ObstaclesResult1, ChildsResult),
	% writeln('+++++++++++++++++++++++++++Childs+++++++++++++++++++++++++'),		
	% writeln('ChildsResult'),
	% writeln(ChildsResult),
	%union(ResultObstacles, Obstacles, ObstaclesResult),
	% %union(ChildsResult1, Childs, ChildsResult),	
	% union(DirtyResult3, DirtyResult4, DirtyResult), !.

itChilds(BoardHeight, BoardWidth, Length, Dirty,Obstacles, Childs,Corral, DirtyResult, ObstaclesResult, ChildsResult):-
	DirtyResult = Dirty,
	ObstaclesResult = Obstacles,
	writeln('+++++++++++++++++++++++++++Viene a ponerlo por defecto+++++++++++++++++++++++++'),		
	writeln(Length),		
	ChildsResult = Childs.
	

	


child(BoardHeight,BoardWidth, Childs, Dirty,Obstacles,Corral, DirtyResult, ObstaclesResult, ChildsResult):-
	length(Childs, L),	
	write('hay'),
	write(L),
	writeln('ninnos'),
	itChilds(BoardHeight, BoardWidth, L, Dirty,Obstacles, Childs, Corral,DirtyResult, ObstaclesResult, ChildsResult).
	
	
	
	
simulation(BoardHeight,BoardWidth, Pos, Childs, Dirty,Obstacles,CorralResult, DirtyResult, ObstaclesResult, ChildsResult3, NewPos):-
	writeln('robot se va a mover'),
	robot1(BoardHeight,BoardWidth, Pos, Childs, Dirty,Obstacles, ChildsResult, DirtyResult1, NewPos),
	writeln('los ninnos se van a mover'),
	% child(BoardHeight,BoardWidth, Childs, DirtyResult1,Obstacles,CorralResult, DirtyResult, ObstaclesResult, ChildsResult).
	nth0(0, ChildsResult, PosChild),
	make_dirty(BoardHeight, BoardWidth, DirtyResult1,Obstacles, PosChild, ChildsResult, DirtyResult2),
	append(DirtyResult2, DirtyResult1, DirtyResult),	
	moveChild(BoardHeight, BoardWidth, PosChild,DirtyResult,ChildsResult,CorralResult, Obstacles, ObstaclesResult, ChildsResult3).
	


%	bfs([[[0, 1]]], BoardHeight, BoardWidth, [[1,1],[2,2],[3,3],[4,1],[5,1],[6,1]], [[5,5]], Path),


main:-
	BoardHeight = 15,
	BoardWidth = 15,
	Time = 0,
	TimeChange = 5,
	ChildsCount = 5,
	DirtinessPercent = 17,
	ObstaclePercent = 10,
	DirtinessCount is round((DirtinessPercent/100)*BoardHeight*BoardWidth),
	ObstacleCount is round((ObstaclePercent/100)*BoardHeight*BoardWidth),
	Dirty = [],
	Obstacles = [],
	Childs = [],
	generate_pos(BoardHeight,BoardWidth,[],[],[],[],Corral),
	generate_corral(BoardHeight, BoardWidth, ChildsCount, [Corral], CorralResult),
	generate_obstacle(BoardHeight,BoardWidth,ObstacleCount,Dirty,Obstacles,Childs,CorralResult,ObstaclesEnv),
	generate_dirty(BoardHeight,BoardWidth,DirtinessCount,Dirty,ObstaclesEnv,Childs,CorralResult,ResultDirtiness),
	generate_childs(BoardHeight,BoardWidth,ChildsCount,ResultDirtiness,ObstaclesEnv,Childs,CorralResult,ResultChilds),
	
	%selecciona un ninno y lo para que ejecute la accion de ensuciar
	%nth0(0, ResultChilds, Elem),
	%make_dirty(BoardHeight, BoardWidth,ResultDirtiness,ObstaclesEnv, Elem, ResultChilds, DirtyResult),
	%writeln(Elem),
	%write(DirtyResult),


	%bfs([[[0, 1]]], BoardHeight, BoardWidth, [[1,1],[2,2],[3,3],[4,1],[5,1],[6,1]], [[5,5]], Path),
	%writeln(Path).



	%move_obstacle(BoardHeight, BoardWidth, [],[[1,1],[2,2],[3,3],[4,1],[5,1],[6,1]],[],[], [1,1], [0,0], Result),
	%writeln(Result).
	

	%generate_pos(BoardHeight,BoardWidth,ResultDirtiness,ObstaclesEnv,ResultChilds,Corral,Robot).
	%Falta calcular los corrales
	%write(ObstaclesEnv).

	generate_pos(BoardHeight,BoardWidth,ResultDirtiness,ObstaclesEnv,ResultChilds,CorralResult,Robot),

	
	writeln('--------------antes-------------'),
	writeln('Robot'),
	writeln(Robot),
	writeln('ResultDirtiness'),
	writeln(ResultDirtiness),
	writeln('ObstaclesEnv'),
	writeln(ObstaclesEnv),
	writeln('ResultChilds'),
	writeln(ResultChilds),
	writeln('CorralResult'),
	writeln(CorralResult),
	writeln('--------------+++++++-------------'),


	simulation(BoardHeight,BoardWidth, Robot, ResultChilds, ResultDirtiness,ObstaclesEnv,CorralResult, DirtyResult, ObstaclesResult, ChildsResult, NewPos),
	
	writeln('--------------despues-------------'),
	writeln('Robot'),	
	writeln(NewPos),
	writeln('ResultDirtiness'),
	writeln(DirtyResult),
	writeln('ObstaclesEnv'),
	writeln(ObstaclesResult),
	writeln('ResultChilds'),
	writeln(ChildsResult),
	writeln('--------------+++++++-------------').

	