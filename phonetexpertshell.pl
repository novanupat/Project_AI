% easyexpert.pl - a simple shell for use with Prolog
% knowledge bases is in    file.knb
/*-------- How to run  ------
1. Install SWI prolog
2. copy 2 file to desktop: easyexpert.pl,vacation.knb
3. double click easyexpert.pl
4. run.
5. load.
6. solve.
7. why.
8. quit.
---------------------------*/

:-dynamic known/1, answer/1.


run :-
	greeting,
	repeat,
	write('ช่องกรอกข้อมูล >>> '),
	read(X),
	do(X),
	X == 5,
	writeln('>>>>ขอบคุณที่ใช้บริการ<<<<'),
	writeln('นาย ปฐวี เงินไทย B5408924'),
	writeln('นาย อนุภัทร สำเภา B5427956'), !.

greeting :-
	write('ระบบค้นหาโทรศัพท์ที่เหมาะสมสำหรับคุณ'), nl,
	native_help.

do(0) :- native_help, !.
do(1) :- load_kb, !.
do(2) :- solve, !.
do(3) :- solveee, !.
do(4):-why,!.
do(5).
do(X) :-
	write(X),
	write(' คำสั่งผิดพลาด'), nl,
	fail.

native_help :-
	write('พิมพ์\n   0.=ช่วยเหลือ.\n   1.=โหลดไฟล์อื่นๆ\n   2.=รันไฟล์อื่นๆที่โหลดเข้ามา\n   3.=หาโทรศัพท์ที่เหมาะสำหรับคุณ\n   4.=ทำไมถึงได้โทรศัพท์นี้\n   5.=ออก'),nl.
	

load_kb :-
	write('ใส่ชื่อไฟล์ตามรูปแบบนี้ (ex. ''vacation.knb''.): \n'),
	read(F),
	reconsult(F).

solve :-
	retractall(known( _) ),retractall(answer(_)),
        %abolish(known,3),
	top_goal(X),
	write('\nคำตอบที่ได้รับคือ '),write(X),nl,assert(answer(X)),nl.

solveee :-	
	reconsult('phone.knb'),
	retractall(known( _) ),retractall(answer(_)),
        %abolish(known,3),
	top_goal(X),
	write('\nคำตอบที่ได้รับคือ '),write(X),nl,assert(answer(X)),nl.
solveee :-
	write('\nคำตอบที่ได้รับคือ ไม่พบโทรศัพท์เหมาะสำหรับคุณ.\n'),nl.

menuask(Pred,Value,Menu):-menuask(Pred,Menu),atomic_list_concat([Pred,'(',Value,')'],X),
                   term_to_atom(T,X),known(T),!.
menuask(Pred,_):-atomic_list_concat([Pred,'(','_',')'],X),
                   term_to_atom(T,X),known(T),!.
menuask(Attribute,Menu):-
	nl,write('เลือก '),write(Attribute),write(' ที่เหมาะสำหรับคุณ'),nl,
	writeln(Menu),
	write('เลือก  choice ที่เหมาะสำหรับคุณ >>> '),read(V),
	atomic_list_concat([Attribute,'(',V,')'],X),term_to_atom(T,X),asserta(known(T))	.

why:- answer(A),write('\nโทรศัพท์ ที่เหมาะสำหรับคุณคือ '),writeln(A),
    findall( X , known(X),Result),writeln('สิ่งที่เราเจอคือ'),
    writeln(Result),nl.
