(*DANG TAT DAT*)
(* # use "hol.ml";;  *)

needs "Multivariate/flyspeck.ml";;
(* needs "update_database_310.ml";; *)
prioritize_real();;

(* Fan definition*)
let graph = new_definition `graph (E:(real^3 ->bool)->bool)  <=>  (!e. E e ==> (e HAS_SIZE 2))`;;

let fan11 = new_definition `fan11 (V:real^3 -> bool)  <=>  FINITE V`;;

let fan21 = new_definition `fan21 (x:real^3,V:real^3 -> bool)  <=>   ~(x IN V)`;;

let fan31 = new_definition `fan31 (V:real^3 -> bool,E:(real^3 ->bool)->bool) = E UNION {{v}| v IN V}`;;

let fan41 = new_definition `fan41 (x:real^3,E:(real^3 ->bool)->bool) <=>(!e. (e IN E) ==> ~(collinear({x} UNION e)))`;;
 
let fan51 = new_definition `fan51 (x:real^3,V:real^3 -> bool,E:(real^3 ->bool)->bool) <=> (!e1 e2. (e1 IN fan31(V,E)) /\(e2 IN fan31(V,E))==> ((aff_ge {x} e1) INTER (aff_ge {x} e2) = aff_ge {x} (e1 INTER e2)))`;;

let new_fan = new_definition `new_fan(x:real^3,V,E) <=> ((UNIONS E) SUBSET V) /\ graph(E) /\ fan11(V) /\ fan21(x,V) /\ fan41(x,E) /\ fan51(x,V,E)`;;


(*Contravening Hypermap*)

let packing = new_definition `packing (S:real^3 -> bool) = (!u v. (u IN S) /\ (v IN S) /\ ~(u = v) ==> (&2 <= dist( u, v)))`;;

let h0 = new_definition `h0 = #1.26`;;  (*Definition Const real number*)

let V = new_definition `V (x:real^3) (S:real^3 -> bool) = {v:real^3|(v IN S) /\ (x IN S) /\ ~(v = x) /\ (dist(v,x) <= (&2)*h0)}`;;

let ESTD = new_definition `ESTD (V (x:real^3) (S:real^3 -> bool)) = {{v,w}|(v IN (V x S)) /\ (w IN (V x S))/\ ~(v = w) /\ dist(v,w) <= (&2)*h0}`;;

let ECNT = new_definition `ECNT (V (x:real^3) (S:real^3 -> bool)) = {{v,w}|(v IN (V x S)) /\ (w IN (V x S))/\ ~(v = w) /\ dist(v,w) = &2}`;;

(* UBHDEUU*)

(* Let Proof (x,V,ESTD) is a fan*)
let them1 = prove(`!x (y:real^3)(S:real^3 -> bool).(packing S) /\ (x IN S) /\ (y IN S)/\ ~(x = y) ==> (&2 <= dist(x,y))`,REWRITE_TAC [packing] THEN REPEAT STRIP_TAC THEN ASM_MESON_TAC [packing]);;

let cautruc1 = prove (`!(x:real^3)(S:real^3->bool).(packing S) /\ (x IN S) ==> (V x S) SUBSET (S INTER (ball(x,(&2*h0 + &1))))`,REPEAT GEN_TAC THEN STRIP_TAC THEN REWRITE_TAC [ball;V;SUBSET;INTER] THEN STRIP_TAC THEN REWRITE_TAC [IN_ELIM_THM] THEN STRIP_TAC THEN ASM_REWRITE_TAC [] THEN SUBGOAL_THEN `&2 * h0 < &2 * h0 + &1` ASSUME_TAC THENL [ARITH_TAC;SUBGOAL_THEN `dist(x':real^3,x:real^3) < &2 * h0 + &1` ASSUME_TAC THENL [ASM_ARITH_TAC;SUBGOAL_THEN `dist(x':real^3,x:real^3) = dist(x,x')` ASSUME_TAC THENL [MESON_TAC [DIST_SYM];ASM_ARITH_TAC]]]);;

(* USE the lemma5.1( KIUMVTC) *)
let KIUMVTC = prove (`!(x:real^3) (b:real) (S:real^3 -> bool). &0 <= b /\ packing S ==> FINITE (S INTER ball (x,b))`, CHEAT_TAC);;

let cautruc2 = prove(`!(x:real^3)(S:real^3 -> bool).  (x IN S)/\ (packing S) ==> FINITE (S INTER (ball(x,(&2*h0 + &1))))`,REPEAT GEN_TAC THEN STRIP_TAC THEN SUBGOAL_THEN `&0 <= &2*h0 + &1` ASSUME_TAC THENL [REWRITE_TAC [h0] THEN ARITH_TAC;ASM_MESON_TAC [KIUMVTC]]);;

let them2 = prove(`!(x:real^3) (y:real^3)(S:real^3 -> bool). (x IN S)/\(packing S) ==> (FINITE(V x S))`,REPEAT GEN_TAC THEN STRIP_TAC THEN SUBGOAL_THEN `!x b S. &0 <= b /\ packing S ==> FINITE (S INTER ball (x,b))` ASSUME_TAC THENL [MESON_TAC [KIUMVTC];SUBGOAL_THEN `FINITE ((S:real^3->bool) INTER (ball(x:real^3,(&2*h0 + &1))))` ASSUME_TAC THENL [ASM_MESON_TAC [cautruc2];SUBGOAL_THEN `(V (x:real^3) (S:real^3->bool)) SUBSET (S INTER (ball(x,(&2*h0 + &1))))` ASSUME_TAC THENL [ASM_MESON_TAC [cautruc1];ASM_MESON_TAC [FINITE_SUBSET]]]]);;

let them3 = prove(`!(x:real^3)(S:real^3 -> bool). (packing S) /\ (x IN S) ==> ~(x IN (V x S))`,REWRITE_TAC [packing] THEN REWRITE_TAC [V] THEN REWRITE_TAC [IN_ELIM_THM]);;

let cautruc3 = prove(`!(a:real^3)(b:real^3)(c:real^3).(~(a = b))/\ (~(b = c)) /\ (~(c = a))/\ (dist(a,b) <= &2*h0) /\ (&2 <= dist(a,b))/\ (dist(b,c) <= &2*h0) /\ (&2 <= dist(b,c))/\ (dist(c,a) <= &2*h0) /\ (&2 <= dist(c,a))==> (~(angle(a,b,c)= &0))`,REPEAT GEN_TAC THEN STRIP_TAC THEN REWRITE_TAC [ANGLE_EQ_0_DIST_ABS] THEN ASM_REWRITE_TAC[] THEN STRIP_TAC THEN SUBGOAL_THEN `dist(c:real^3,b:real^3) = dist(b,c)` ASSUME_TAC THENL [ASM_MESON_TAC [DIST_SYM];SUBGOAL_THEN `&2 <= dist(c:real^3,b:real^3)` ASSUME_TAC THENL [ASM_ARITH_TAC;SUBGOAL_THEN `  --dist (c:real^3,b:real^3) <= -- &2` ASSUME_TAC THENL [ASM_MESON_TAC [REAL_LE_NEG];SUBGOAL_THEN `dist (a:real^3,b:real^3) - dist (c:real^3,b) <= &2*h0 - &2` ASSUME_TAC THENL [ASM_ARITH_TAC;SUBGOAL_THEN `dist (c:real^3,b:real^3) <= &2 * h0` ASSUME_TAC THENL [ASM_ARITH_TAC;SUBGOAL_THEN `-- (&2*h0) <= --dist (c:real^3,b:real^3)` ASSUME_TAC THENL [ASM_MESON_TAC [REAL_LE_NEG];SUBGOAL_THEN `&2 - &2*h0 <= dist (a:real^3,b:real^3) - dist (c:real^3,b)` ASSUME_TAC THENL[ASM_ARITH_TAC;SUBGOAL_THEN `-- (&2*h0 - &2) = -- &2*h0 + -- (-- &2) ` ASSUME_TAC THENL [REAL_ARITH_TAC THEN POP_ASSUM MP_TAC THEN REWRITE_TAC[REAL_NEG_NEG] THEN STRIP_TAC;SUBGOAL_THEN `-- (&2*h0 - &2) <= dist (a:real^3,b:real^3) - dist (c:real^3,b)` ASSUME_TAC THENL [ASM_ARITH_TAC;SUBGOAL_THEN `abs (dist (a:real^3,b:real^3) - dist (c:real^3,b)) <= &2*h0 - &2` ASSUME_TAC THENL [ASM_MESON_TAC [REAL_BOUNDS_LE];SUBGOAL_THEN `dist(a:real^3,c:real^3) = dist (c:real^3,a:real^3)` ASSUME_TAC THENL [MESON_TAC [DIST_SYM];SUBGOAL_THEN `&2 <= dist(a:real^3,c:real^3)` ASSUME_TAC THENL [ASM_ARITH_TAC;SUBGOAL_THEN `&2*h0 - &2 < &2` ASSUME_TAC THENL[REWRITE_TAC [h0] THEN ARITH_TAC;SUBGOAL_THEN ` &2*h0 - &2 < dist (a:real^3,c:real^3)` ASSUME_TAC THENL [ASM_ARITH_TAC;SUBGOAL_THEN `abs (dist (a:real^3,b:real^3) - dist (c:real^3,b)) < dist(a,c)` ASSUME_TAC THENL [ASM_ARITH_TAC;ASM_ARITH_TAC]]]]]]]]]]]]]]]);;
(*Proff~(angle (a,b,c) = pi)*)
let cautruc4 = prove(`!(a:real^3)(b:real^3)(c:real^3).(~(a = b))/\ (~(b = c)) /\ (~(c = a))/\ (dist(a,b) <= &2*h0) /\ (&2 <= dist(a,b))/\ (dist(b,c) <= &2*h0) /\ (&2 <= dist(b,c))/\ (dist(c,a) <= &2*h0) /\ (&2 <= dist(c,a))==> (~(angle(a,b,c)= pi))`,REPEAT GEN_TAC THEN STRIP_TAC THEN STRIP_TAC THEN SUBGOAL_THEN `between (b:real^3) (a:real^3,c:real^3)` ASSUME_TAC THENL [ASM_MESON_TAC [BETWEEN_ANGLE];SUBGOAL_THEN `dist (a:real^3,c:real^3) = dist (a,b) + dist (b,c:real^3)` ASSUME_TAC THENL [ASM_MESON_TAC [between];SUBGOAL_THEN `&2 + &2 <= dist (a:real^3,b:real^3) + dist (b,c:real^3)` ASSUME_TAC THENL[ASM_ARITH_TAC;SUBGOAL_THEN `&2 + &2 <= dist(a:real^ 3,c:real^3)` ASSUME_TAC THENL [ASM_ARITH_TAC;SUBGOAL_THEN `dist(c:real^3,a:real^3) = dist(a:real^3,c)` ASSUME_TAC THENL[MESON_TAC [DIST_SYM];SUBGOAL_THEN `&2 + &2 <= dist(c:real^3,a:real^3)` ASSUME_TAC THENL [ASM_ARITH_TAC;SUBGOAL_THEN `&2*h0 < &2 + &2` ASSUME_TAC THENL [REWRITE_TAC [h0] THEN ARITH_TAC;SUBGOAL_THEN `&2*h0 < dist(c:real^3,a:real^3)` ASSUME_TAC THENL [ASM_ARITH_TAC;ASM_ARITH_TAC]]]]]]]]);;

let cautruc5 = prove(`!(a:real^3)(b:real^3)(c:real^3).(~(a = b))/\ (~(b = c)) /\ (~(c = a))/\ (dist(a,b) <= &2*h0) /\ (&2 <= dist(a,b))/\ (dist(b,c) <= &2*h0) /\ (&2 <= dist(b,c))/\ (dist(c,a) <= &2*h0) /\ (&2 <= dist(c,a))==>(~(angle(a,b,c)= &0))/\ (~(angle(a,b,c)= pi))`,REPEAT GEN_TAC THEN STRIP_TAC THEN STRIP_TAC THENL [ASM_MESON_TAC [cautruc3];ASM_MESON_TAC [cautruc4]]);;


let cautruc6 = prove(`!(a:real^3)(b:real^3)(c:real^3).(~(a=b)) /\ (~(b=c)) /\ (~(angle (a,b,c) = &0))/\ (~(angle (a,b,c) = pi)) ==> ~(collinear{a,b,c})`,REPEAT GEN_TAC THEN STRIP_TAC THEN SUBGOAL_THEN `~(a:real^3 = b:real^3) /\ ~(b = c:real^3)==> (collinear {a, b, c} <=> angle (a,b,c) = &0 \/ angle (a,b,c) = pi)` ASSUME_TAC THENL [STRIP_TAC THEN ASM_MESON_TAC[COLLINEAR_ANGLE];POP_ASSUM MP_TAC THEN ASM_REWRITE_TAC[]]);;

let cautruc7 = prove(`!(a:real^3)(b:real^3)(c:real^3).(~(a = b))/\ (~(b = c)) /\ (~(c = a))/\ (dist(a,b) <= &2*h0 /\ (&2 <= dist(a,b)) /\ (&2 <= dist(b,c)))/\ (dist(c,a) <= &2*h0) /\ (&2 <= dist(c,a))==> (~(angle(a,b,c)= pi))`,REPEAT GEN_TAC THEN STRIP_TAC THEN STRIP_TAC THEN SUBGOAL_THEN `between (b:real^3) (a:real^3,c:real^3)` ASSUME_TAC THENL [ASM_MESON_TAC [BETWEEN_ANGLE];SUBGOAL_THEN `dist (a:real^3,c:real^3) = dist (a,b) + dist (b,c:real^3)` ASSUME_TAC THENL [ASM_MESON_TAC [between];SUBGOAL_THEN `&2 + &2 <= dist (a:real^3,b:real^3) + dist (b,c:real^3)` ASSUME_TAC THENL[ASM_ARITH_TAC;SUBGOAL_THEN `&2 + &2 <= dist(a:real^ 3,c:real^3)` ASSUME_TAC THENL [ASM_ARITH_TAC;SUBGOAL_THEN `dist(c:real^3,a:real^3) = dist(a:real^3,c)` ASSUME_TAC THENL[MESON_TAC [DIST_SYM];SUBGOAL_THEN `&2 + &2 <= dist(c:real^3,a:real^3)` ASSUME_TAC THENL [ASM_ARITH_TAC;SUBGOAL_THEN `&2*h0 < &2 + &2` ASSUME_TAC THENL [REWRITE_TAC [h0] THEN ARITH_TAC;SUBGOAL_THEN `&2*h0 < dist(c:real^3,a:real^3)` ASSUME_TAC THENL [ASM_ARITH_TAC;ASM_ARITH_TAC]]]]]]]]);;

let IN1 = prove(`!(x:A)(a:A)(b:A). x IN {a,b}  <=> (x = a) \/ (x = b) `,REPEAT GEN_TAC THEN REWRITE_TAC[IN_INSERT; NOT_IN_EMPTY]);;

let IN2 = prove(`!(x:A)(a:A)(b:A)(c:A). x IN {a,b,c}  <=> (x = a) \/ (x = b) \/ (x = c) `,REPEAT GEN_TAC THEN REWRITE_TAC[IN_INSERT; NOT_IN_EMPTY]);;

let SUBSET1 = prove(`!(a:real^3)(b:real^3)(x:real^3).{a,b,x} SUBSET ({x} UNION {a,b})`,REPEAT GEN_TAC THEN REWRITE_TAC [SUBSET;UNION] THEN GEN_TAC THEN REWRITE_TAC [IN2;IN1;IN_ELIM_THM] THEN STRIP_TAC THENL [ASM_MESON_TAC[];ASM_MESON_TAC[];REWRITE_TAC [IN_SING] THEN ASM_MESON_TAC []]);;

let them4 = prove( `!(a:real^3)(b:real^3)(x:real^3)(S:real^3 -> bool). (packing S) /\ (x IN S) /\ ({a,b} IN (ESTD(V x S))) ==> ~(collinear ({x} UNION {a,b}))`,REWRITE_TAC [ESTD;V;IN_ELIM_PAIR_THM;IN_ELIM_THM] THEN REPEAT GEN_TAC THEN STRIP_TAC THEN ASM_REWRITE_TAC [] THEN STRIP_TAC  THEN SUBGOAL_THEN `&2 <= dist(v:real^3,x:real^3)` ASSUME_TAC THENL [ASM_MESON_TAC [them1];SUBGOAL_THEN `&2 <= dist(w:real^3,x:real^3)` ASSUME_TAC THENL [ASM_MESON_TAC [them1];SUBGOAL_THEN `&2 <= dist(v:real^3,w:real^3)` ASSUME_TAC THENL [ASM_MESON_TAC [them1];SUBGOAL_THEN `dist(v:real^3,x:real^3) = dist(x,v)` ASSUME_TAC THENL [MESON_TAC [DIST_SYM];SUBGOAL_THEN `dist(x:real^3,v:real^3) <= &2*h0` ASSUME_TAC THENL [ASM_ARITH_TAC;SUBGOAL_THEN `&2 <= dist(x:real^3,v:real^3)` ASSUME_TAC THENL [ASM_ARITH_TAC;SUBGOAL_THEN `v:real^3 = x:real^3 <=> x = v` ASSUME_TAC THENL [MESON_TAC [EQ_SYM_EQ];SUBGOAL_THEN `(~(x:real^3 = v:real^3))` ASSUME_TAC THENL [ASM_MESON_TAC[];SUBGOAL_THEN `(~(angle(v:real^3,w:real^3,x:real^3) = &0)) /\ (~(angle(v,w,x) = pi))` ASSUME_TAC THENL [ASM_MESON_TAC [cautruc5];SUBGOAL_THEN `{v:real^3,w:real^3,x:real^3} SUBSET ({x} UNION {v,w})` ASSUME_TAC THENL [MESON_TAC [SUBSET1];
SUBGOAL_THEN `collinear ({v:real^3,w:real^3,x:real^3})` ASSUME_TAC THENL [ASM_MESON_TAC [COLLINEAR_SUBSET];SUBGOAL_THEN `~collinear ({v:real^3,w:real^3,x:real^3})` ASSUME_TAC THENL [ASM_MESON_TAC [cautruc6];ASM_ARITH_TAC]]]]]]]]]]]]);;

let eunion = new_definition `Eunion (x:real^3) (S:real^3->bool) = UNIONS ( ESTD (V x S))`;;

let them5 = prove(`!(x:real^3)(S:real^3 -> bool).(Eunion x S) SUBSET (V x S)`,REPEAT GEN_TAC THEN REWRITE_TAC [eunion;ESTD;UNIONS;SUBSET;IN_ELIM_THM] THEN GEN_TAC THEN STRIP_TAC THEN POP_ASSUM MP_TAC THEN ASM_REWRITE_TAC[] THEN REWRITE_TAC [IN1] THEN STRIP_TAC THENL [ASM_REWRITE_TAC[];ASM_REWRITE_TAC[]]);;

let them6 = prove(`!(x:real^3)(S:real^3 -> bool) e. e IN (ESTD(V x S)) ==> (e HAS_SIZE 2)`,REPEAT GEN_TAC THEN REWRITE_TAC [HAS_SIZE_2_EXISTS;ESTD;IN_ELIM_THM] THEN STRIP_TAC THEN ASM_REWRITE_TAC[] THEN EXISTS_TAC `v:real^3` THEN EXISTS_TAC `w:real^3` THEN STRIP_TAC THENL [ASM_MESON_TAC[];STRIP_TAC THEN REWRITE_TAC [IN1]]);;

let them7 = prove(`!(x:real^3) (S:real^3 -> bool). (packing S) /\ (x IN S) ==> !e. e IN ESTD (V x S) ==>  ~collinear ({x} UNION e)`,REPEAT GEN_TAC THEN STRIP_TAC THEN GEN_TAC THEN REWRITE_TAC [ESTD;V;IN_ELIM_THM] THEN STRIP_TAC THEN ASM_REWRITE_TAC[] THEN SUBGOAL_THEN `{v:real^3,w:real^3} IN  (ESTD (V x S))` ASSUME_TAC THENL [REWRITE_TAC [ESTD;V;IN_ELIM_THM] THEN EXISTS_TAC `v:real^3` THEN EXISTS_TAC `w:real^3` THEN REPEAT STRIP_TAC THENL [ASM_REWRITE_TAC[];ASM_REWRITE_TAC[];POP_ASSUM MP_TAC THEN REWRITE_TAC[] THEN ASM_REWRITE_TAC[];ASM_REWRITE_TAC[];ASM_REWRITE_TAC[];ASM_REWRITE_TAC[];POP_ASSUM MP_TAC THEN REWRITE_TAC[] THEN ASM_REWRITE_TAC[];ASM_REWRITE_TAC[];POP_ASSUM MP_TAC THEN REWRITE_TAC[] THEN ASM_REWRITE_TAC[];ASM_ARITH_TAC;ARITH_TAC];ASM_MESON_TAC [them4]]);;

(*My definition--------------------------------------- To proof this lemma! i'll proof it later *)


let sigma_set1 = new_definition `sigma_set1 (x:real^3) (S:real^3->bool) = (ESTD(V x S)) UNION {{v}|v IN (V x S)}`;; 

let dn1 = prove(`!(v:real^3)(v':real^3). (~(v = v')) ==> {v} INTER {v'} = {}`,CHEAT_TAC);;
let dn111 = prove(`!(v:real^3)(v':real^3) (w:real^3). (~(v = v')) /\ (~(v = w)) ==> {v} INTER {v',w} = {}`,CHEAT_TAC);;
let dn112 = prove(`!(v:real^3)(v':real^3)(w:real^3) (w':real^3).(~({v, w} = {v', w'}))/\ (~(v = v')) /\ (~(v = w')) /\ (~(w = v')) /\ (~(w = w')) ==> {v,w} INTER {v',w'} = {}`,CHEAT_TAC);; 

let dn2 = prove (`!x:real^3. aff_ge {x} {}={x}`, CHEAT_TAC );; 

let dn3 = prove (`!x:real^3 v:real^3. aff_ge {x} {v}={y:real^3 |  ?t1:real t2:real. (t2 >= &0)/\ (t1 + t2= &1) /\ (y = t1 % x + t2 % v)}`,CHEAT_TAC);; 

let dn4 = prove (`!x:real^3 v:real^3 w:real^3. aff_ge {x} {v,w} = {y:real^3 |  ?t1:real (t2:real) t3:real. (t2 >= &0) /\ (t3 >= &0)  /\ (t1 + t2 + t3 = &1) /\ (y = t1 % x + t2 % v + t3 % w)}`, CHEAT_TAC);; 

let dn5 = prove (`!(v:real^3)(v':real^3)(w:real^3).(~(v=v')) /\ (~(v=w)) ==> {v} INTER {v',w} = {}`,CHEAT_TAC);; 
let dn51 =prove (`!(v:real^3)(v':real^3)(w:real^3).(~(v' = v)) /\ (~(v' = w)) ==> {v,w} INTER {v'} = {}`,CHEAT_TAC);;

let dn6 = prove (`!(v':real^3)(w:real^3). {v'} INTER {v',w} = {v'}`,CHEAT_TAC);;
let dn61 = prove (`!(v':real^3)(w:real^3). {w} INTER {v',w} = {w}`,CHEAT_TAC);;
let dn62 =  prove (`!(v':real^3)(w:real^3). {v,w} INTER {v} = {v}`,CHEAT_TAC);;
let dn63 =  prove (`!(v':real^3)(w:real^3). {v,w} INTER {w} = {w}`,CHEAT_TAC);;

let dn7 =  prove (`!(v:real^3)(v':real^3)(w:real^3).(v = w) ==> {v} INTER {v',w} = {v}`,CHEAT_TAC);;

let dn8 =  prove (`!(v:real^3)(v':real^3)(w:real^3)(w':real^3).{v',w'} INTER {v',w'} = {v',w'}`,CHEAT_TAC);;

let dn9 =  prove (`!(v:real^3)(v':real^3)(w:real^3)(w':real^3). ~({v,w} = {v',w'}) ==> {v',w} INTER {v',w'} = {v'}`,CHEAT_TAC);;
let dn91 =  prove (`!(v:real^3)(v':real^3)(w:real^3)(w':real^3). ~({v,w} = {v',w'}) ==> {w',w} INTER {v',w'} = {w'}`,CHEAT_TAC);;
let dn92 =  prove (`!(v:real^3)(v':real^3)(w':real^3). ~({v,w} = {v',w'}) ==> ({v, v'} INTER {v', w'}) = {v'}`,CHEAT_TAC);;
let dn93 =  prove (`!(v:real^3)(v':real^3)(w':real^3). ~({v,w} = {v',w'}) ==> ({v, w'} INTER {v', w'}) = {w'}`,CHEAT_TAC);;

let dn10 = prove (`!(v:real^3)(v':real^3)(x:real^3).( (a:real) % v + (b:real) % v' + (c:real) % x = vec 0) ==> a = &0 /\ b = &0 /\ c = &0`,CHEAT_TAC);;

let dn11 = prove (`!(v:real^3)(v':real^3)(x:real^3)(w:real^3).( (a:real) % v + (b:real) % v' + (c:real) % x + (d:real) % w = vec 0) ==> a = &0 /\ b = &0 /\ c = &0 /\ d = &0`,CHEAT_TAC);;

let dn12 =  prove (`!(v:real^3)(v':real^3)(x:real^3)(w:real^3)(w':real^3).( (a:real) % v + (b:real) % v' + (c:real) % x + (d:real) % w + (e:real)%w' = vec 0) ==> a = &0 /\ b = &0 /\ c = &0 /\ d = &0 /\ e = &0`,CHEAT_TAC);;

let logic1 = prove(`!p q r. p /\ (p \/ r) = p`,CHEAT_TAC);;
(*-------------------------------------------------------------------------*)

(*4 SUBGOAL*)
(*SUB1*)
(*Case v = v' *)
let SUBCASE1 = prove (`!(v:real^3) (v':real^3) (x:real^3)(S:real^3->bool).(v IN S) /\ (x IN S ) /\ (v' IN S) /\ (~(v = x)) /\ (~(v' = x)) /\ (dist (v,x) <= &2 * h0) /\ (dist (v',x) <= &2 * h0) /\ (e1 = {v}) /\ (e2 = {v'}) /\ (v = v') ==> (!x'.x' IN  {y | ?t1 t2. t2 >= &0 /\ t1 + t2 = &1 /\ y = t1 % x + t2 % v} INTER {y | ?t1 t2. t2 >= &0 /\ t1 + t2 = &1 /\ y = t1 % x + t2 % v'} ==> x' IN aff_ge {x} ({v} INTER {v'}))`, REPEAT GEN_TAC THEN ASM_REWRITE_TAC[] THEN STRIP_TAC  THEN REWRITE_TAC [IN_SING;SING_GSPEC;INTER;IN_ELIM_THM] THEN ASM_REWRITE_TAC[] THEN REWRITE_TAC [IN_SING;SING_GSPEC;dn3;IN_ELIM_THM]);;

let SUBCASE2 = prove(`!(v:real^3) (v':real^3) (x:real^3)(S:real^3->bool).(v IN S) /\ (x IN S ) /\ (v' IN S) /\ (~(v = x)) /\ (~(v' = x)) /\ (dist (v,x) <= &2 * h0) /\ (dist (v',x) <= &2 * h0) /\ (e1 = {v}) /\ (e2 = {v'}) /\ (~(v = v')) ==> (!x'.x' IN  {y | ?t1 t2. t2 >= &0 /\ t1 + t2 = &1 /\ y = t1 % x + t2 % v} INTER {y | ?t1 t2. t2 >= &0 /\ t1 + t2 = &1 /\ y = t1 % x + t2 % v'} ==> x' IN aff_ge {x} ({v} INTER {v'}))`,REPEAT GEN_TAC THEN STRIP_TAC THEN SUBGOAL_THEN `{v:real^3} INTER {v':real^3} = {}` ASSUME_TAC THENL [ASM_MESON_TAC[dn1];ASM_REWRITE_TAC[]] THEN REWRITE_TAC [INTER;dn2;IN_SING;IN_ELIM_THM] THEN REPEAT STRIP_TAC THEN SUBGOAL_THEN `(x':real^3) - ((t1':real) % (x:real^3) + (t2':real) % (v':real^3)) = vec 0` ASSUME_TAC THENL [POP_ASSUM MP_TAC THEN VECTOR_ARITH_TAC;POP_ASSUM MP_TAC THEN ASM_REWRITE_TAC[]] THEN REWRITE_TAC[VECTOR_ARITH `(t1 % x + t2 % v) - (t1' % x + t2' % v')= ((t1:real)- (t1':real)) % (x:real^3) + (t2:real) % (v:real^3) + (--(t2':real) % (v':real^3))`] THEN STRIP_TAC THEN SUBGOAL_THEN `(t1:real - t1':real) = &0 /\ t2:real = &0 /\ --t2':real = &0` ASSUME_TAC THENL [ASM_MESON_TAC [dn10];SUBGOAL_THEN `((t1:real) = (t1':real))` ASSUME_TAC THENL [ASM_MESON_TAC[REAL_SUB_0];SUBGOAL_THEN `(t1':real) + &0 = &1` ASSUME_TAC THENL [ASM_MESON_TAC[];SUBGOAL_THEN `(t1':real) = &1` ASSUME_TAC THENL [ASM_ARITH_TAC;ASM_REWRITE_TAC[] THEN VECTOR_ARITH_TAC]]]]);;

let cautruc8 = prove(`!(v:real^3) (v':real^3) (x:real^3)(S:real^3->bool).(v IN S) /\ (x IN S) /\ (v' IN S) /\ (~(v=x)) /\ (~(v'=x)) /\ (dist (v,x) <= &2 * h0) /\ (dist (v',x) <= &2 * h0) /\ e1 = {v} /\ e2 = {v'} ==> aff_ge {x} e1 INTER aff_ge {x} e2 = aff_ge {x} (e1 INTER e2)`,REPEAT GEN_TAC THEN STRIP_TAC THEN REWRITE_TAC [EXTENSION;GSYM SUBSET_ANTISYM_EQ;SUBSET] THEN ASM_REWRITE_TAC[] THEN REWRITE_TAC [IN_ELIM_THM] THEN ASM_REWRITE_TAC[] THEN STRIP_TAC THENL [REWRITE_TAC [dn3] THEN GEN_TAC THEN REWRITE_TAC [IN_ELIM_THM] THEN ASM_CASES_TAC `v:real^3 = v':real^3` THENL[ASM_MESON_TAC [SUBCASE1];ASM_MESON_TAC [SUBCASE2]];ASM_CASES_TAC `v:real^3 = v':real^3` THENL [ASM_REWRITE_TAC[] THEN REWRITE_TAC [IN_SING;SING_GSPEC;INTER;IN_ELIM_THM];GEN_TAC THEN SUBGOAL_THEN `{v:real^3} INTER {v':real^3} = {}` ASSUME_TAC] THENL [ASM_MESON_TAC[dn1];ASM_REWRITE_TAC[]] THEN REWRITE_TAC [dn2;IN_SING;dn3;INTER;IN_ELIM_THM] THEN REPEAT STRIP_TAC THENL [EXISTS_TAC `&1` THEN EXISTS_TAC `&0` THEN ASM_REWRITE_TAC[] THEN STRIP_TAC THENL [ARITH_TAC;STRIP_TAC THENL [ARITH_TAC;VECTOR_ARITH_TAC]];EXISTS_TAC `&1` THEN EXISTS_TAC `&0` THEN STRIP_TAC THENL [ARITH_TAC;STRIP_TAC THENL [ARITH_TAC;ASM_REWRITE_TAC[]THEN VECTOR_ARITH_TAC]]]]);;

(*--------------------------------------------------------------------------------------*)
(*SUB2*)
let SUBCASE3 = prove(`!(v:real^3) (v':real^3) (x:real^3)(S:real^3->bool). (v IN S) /\ (x IN S) /\ (~(v = x)) /\ (dist (v,x) <= &2 * h0) /\ ( e1 = {v})/\ ( v' IN S) /\ ( ~(v' = x)) /\ ( dist (v',x) <= &2 * h0) /\ ( w IN S) /\ ( ~(w = x)) /\ (dist (w,x) <= &2 * h0) /\ (~(v' = w)) /\ (dist (v',w) <= &2 * h0) /\ (e2 = {v', w}) /\ (v = v') ==>(?t1 t2. t2 >= &0 /\ t1 + t2 = &1 /\ x' = t1 % x + t2 % v) /\(?t1 t2 t3. t2 >= &0 /\ t3 >= &0 /\ t1 + t2 + t3 = &1 /\ x' = t1 % x + t2 % v' + t3 % w) ==> x' IN aff_ge {x} {x | x IN {v} /\ x IN {v', w}}`,REPEAT GEN_TAC THEN STRIP_TAC THEN ASM_REWRITE_TAC [] THEN STRIP_TAC THEN REWRITE_TAC [GSYM INTER;dn6;dn3;IN_ELIM_THM] THEN EXISTS_TAC `t1:real` THEN EXISTS_TAC `t2:real` THEN STRIP_TAC THENL [ASM_MESON_TAC[];STRIP_TAC THENL [ASM_MESON_TAC[];ASM_MESON_TAC[]]]);;

let SUBCASE4 = prove(`!(v:real^3) (v':real^3) (x:real^3)(w:real^3)(S:real^3->bool). (v IN S) /\ (x IN S) /\ (~(v = x)) /\ (dist (v,x) <= &2 * h0) /\ ( e1 = {v})/\ ( v' IN S) /\ ( ~(v' = x)) /\ ( dist (v',x) <= &2 * h0) /\ ( w IN S) /\ ( ~(w = x)) /\ (dist (w,x) <= &2 * h0) /\ (~(v' = w)) /\ (dist (v',w) <= &2 * h0) /\ (e2 = {v', w}) /\ ~(v = v') /\ (v = w) ==>(?t1 t2. t2 >= &0 /\ t1 + t2 = &1 /\ x' = t1 % x + t2 % v) /\(?t1 t2 t3. t2 >= &0 /\ t3 >= &0 /\ t1 + t2 + t3 = &1 /\ x' = t1 % x + t2 % v' + t3 % w) ==> x' IN aff_ge {x} {x | x IN {v} /\ x IN {v', w}}`,REPEAT GEN_TAC THEN STRIP_TAC THEN ASM_REWRITE_TAC [] THEN STRIP_TAC THEN REWRITE_TAC [GSYM INTER;dn61;dn3;IN_ELIM_THM] THEN EXISTS_TAC `t1:real` THEN EXISTS_TAC `t2:real` THEN STRIP_TAC THENL [ASM_MESON_TAC[];STRIP_TAC THENL [ASM_MESON_TAC[];ASM_MESON_TAC[]]]);;

let SUBCASE5 = prove( `!(v:real^3) (v':real^3) (x:real^3)(w:real^3)(S:real^3->bool). (v IN S) /\ (x IN S) /\ (~(v = x)) /\ (dist (v,x) <= &2 * h0) /\ ( e1 = {v})/\ ( v' IN S) /\ ( ~(v' = x)) /\ ( dist (v',x) <= &2 * h0) /\ ( w IN S) /\ ( ~(w = x)) /\ (dist (w,x) <= &2 * h0) /\ (~(v' = w)) /\ (dist (v',w) <= &2 * h0) /\ (e2 = {v', w}) /\ ~(v = v') /\ ~(v = w) ==>(?t1 t2. t2 >= &0 /\ t1 + t2 = &1 /\ x' = t1 % x + t2 % v) /\(?t1 t2 t3. t2 >= &0 /\ t3 >= &0 /\ t1 + t2 + t3 = &1 /\ x' = t1 % x + t2 % v' + t3 % w) ==> x' IN aff_ge {x} {x | x IN {v} /\ x IN {v', w}}`,REPEAT GEN_TAC THEN STRIP_TAC THEN REWRITE_TAC [GSYM INTER] THEN SUBGOAL_THEN `({v:real^3} INTER {v':real^3, w:real^3}) = {}` ASSUME_TAC THENL [ASM_MESON_TAC [dn111];ASM_REWRITE_TAC[]] THEN STRIP_TAC THEN REWRITE_TAC [dn2;IN_SING] THEN SUBGOAL_THEN `(x':real^3) - ((t1':real) % (x:real^3) + (t2':real) % (v':real^3) + (t3:real) % (w:real^3)) = vec 0` ASSUME_TAC THENL [POP_ASSUM MP_TAC THEN VECTOR_ARITH_TAC;POP_ASSUM MP_TAC THEN  ASM_REWRITE_TAC[] THEN REWRITE_TAC[VECTOR_ARITH `(t1 % x + t2 % v) - (t1' % x + t2' % v' + t3 % w) = ((t1:real)- (t1':real)) % (x:real^3) +((t2:real)%(v:real^3)) + (--(t2':real)%(v':real^3)) + (--(t3:real)%(w:real^3))`] THEN STRIP_TAC THEN SUBGOAL_THEN `((t1:real)- (t1':real)) = &0 /\ (t2:real) = &0 /\  (--(t2':real)) = &0 /\ (--(t3:real)) = &0` ASSUME_TAC THENL [ASM_MESON_TAC [dn11];SUBGOAL_THEN `t1:real = t1':real` ASSUME_TAC THENL [ASM_ARITH_TAC;SUBGOAL_THEN `(t1:real) + &0 = &1` ASSUME_TAC THENL [ASM_ARITH_TAC;SUBGOAL_THEN `t1:real = &1` ASSUME_TAC THENL [ASM_ARITH_TAC;SUBGOAL_THEN `t1':real = &1` ASSUME_TAC THENL [ASM_ARITH_TAC;ASM_REWRITE_TAC[] THEN VECTOR_ARITH_TAC]]]]]]);;

let SUBCASE6 = prove( `!(v:real^3) (v':real^3) (x:real^3)(w:real^3)(S:real^3->bool).  (v IN S) /\ (x IN S) /\ (~(v = x)) /\ (dist (v,x) <= &2 * h0) /\ ( e1 = {v})/\ ( v' IN S) /\ ( ~(v' = x)) /\ ( dist (v',x) <= &2 * h0) /\ ( w IN S) /\ ( ~(w = x)) /\ (dist (w,x) <= &2 * h0) /\ (~(v' = w)) /\ (dist (v',w) <= &2 * h0) /\ (e2 = {v', w})/\ (v = v')==> !x'. x' IN aff_ge {x} {x | x IN {v} /\ x IN {v', w}} ==> x' IN aff_ge {x} {v} /\ x' IN aff_ge {x} {v', w}`,REPEAT GEN_TAC THEN STRIP_TAC THEN ASM_REWRITE_TAC [] THEN STRIP_TAC THEN REWRITE_TAC [GSYM INTER;dn6;dn3;dn4;IN_ELIM_THM] THEN REPEAT STRIP_TAC THENL [EXISTS_TAC `t1:real` THEN EXISTS_TAC `t2:real` THEN STRIP_TAC THENL [ASM_ARITH_TAC;STRIP_TAC THENL [ASM_ARITH_TAC;POP_ASSUM MP_TAC THEN VECTOR_ARITH_TAC]];EXISTS_TAC `t1:real` THEN EXISTS_TAC `t2:real` THEN EXISTS_TAC `&0` THEN STRIP_TAC THENL [ASM_ARITH_TAC;STRIP_TAC THENL [ASM_ARITH_TAC;STRIP_TAC THENL [ASM_ARITH_TAC;POP_ASSUM MP_TAC THEN VECTOR_ARITH_TAC]]]]);;

let SUBCASE7 = prove(`!(v:real^3) (v':real^3) (x:real^3)(w:real^3)(S:real^3->bool).  (v IN S) /\ (x IN S) /\ (~(v = x)) /\ (dist (v,x) <= &2 * h0) /\ ( e1 = {v})/\ ( v' IN S) /\ ( ~(v' = x)) /\ ( dist (v',x) <= &2 * h0) /\ ( w IN S) /\ ( ~(w = x)) /\ (dist (w,x) <= &2 * h0) /\ (~(v' = w)) /\ (dist (v',w) <= &2 * h0) /\ (e2 = {v', w})/\ ~(v = v') /\ (v = w)==> !x'. x' IN aff_ge {x} {x | x IN {v} /\ x IN {v', w}} ==> x' IN aff_ge {x} {v} /\ x' IN aff_ge {x} {v', w}`,REPEAT GEN_TAC THEN STRIP_TAC THEN ASM_REWRITE_TAC [] THEN STRIP_TAC THEN REWRITE_TAC [GSYM INTER;dn61;dn3;dn4;IN_ELIM_THM] THEN REPEAT STRIP_TAC THENL [EXISTS_TAC `t1:real` THEN EXISTS_TAC `t2:real` THEN STRIP_TAC THENL[ASM_ARITH_TAC;STRIP_TAC THENL [ASM_ARITH_TAC;POP_ASSUM MP_TAC THEN VECTOR_ARITH_TAC]];EXISTS_TAC `t1:real` THEN EXISTS_TAC `&0` THEN EXISTS_TAC `t2:real`THEN STRIP_TAC THENL [ASM_ARITH_TAC;STRIP_TAC THENL [ASM_ARITH_TAC;STRIP_TAC THENL [ASM_ARITH_TAC;POP_ASSUM MP_TAC THEN VECTOR_ARITH_TAC]]]]);;

let SUBCASE8 = prove(`!(v:real^3) (v':real^3) (x:real^3)(w:real^3)(S:real^3->bool).  (v IN S) /\ (x IN S) /\ (~(v = x)) /\ (dist (v,x) <= &2 * h0) /\ ( e1 = {v})/\ ( v' IN S) /\ ( ~(v' = x)) /\ ( dist (v',x) <= &2 * h0) /\ ( w IN S) /\ ( ~(w = x)) /\ (dist (w,x) <= &2 * h0) /\ (~(v' = w)) /\ (dist (v',w) <= &2 * h0) /\ (e2 = {v', w})/\ ~(v = v') /\ ~(v = w)==> !x'. x' IN aff_ge {x} {x | x IN {v} /\ x IN {v', w}} ==> x' IN aff_ge {x} {v} /\ x' IN aff_ge {x} {v', w}`,REPEAT GEN_TAC THEN STRIP_TAC THEN REWRITE_TAC [GSYM INTER] THEN SUBGOAL_THEN `({v:real^3} INTER {v':real^3, w:real^3}) = {}` ASSUME_TAC THENL [ASM_MESON_TAC [dn111];ASM_REWRITE_TAC[]] THEN STRIP_TAC THEN REWRITE_TAC [dn2;IN_SING;dn3;dn4;IN_ELIM_THM] THEN REPEAT STRIP_TAC THENL [EXISTS_TAC `&1` THEN EXISTS_TAC `&0` THEN STRIP_TAC THENL[ASM_ARITH_TAC;STRIP_TAC THENL [ASM_ARITH_TAC;POP_ASSUM MP_TAC THEN VECTOR_ARITH_TAC]];EXISTS_TAC `&1` THEN EXISTS_TAC `&0` THEN EXISTS_TAC `&0` THEN STRIP_TAC THENL [ASM_ARITH_TAC;STRIP_TAC THENL[ASM_ARITH_TAC;STRIP_TAC THENL [ASM_ARITH_TAC;POP_ASSUM MP_TAC THEN VECTOR_ARITH_TAC]]]]);;

let cautruc9 = prove(`!(v:real^3) (v':real^3)(w:real^3) (x:real^3)(S:real^3->bool).(v IN S) /\ (x IN S) /\ (~(v = x)) /\ (dist (v,x) <= &2 * h0) /\ (e1 = {v}) /\ (v' IN S)/\ (~(v' = x)) /\ (dist (v',x) <= &2 * h0) /\ (w IN S) /\ (~(w = x)) /\ (dist (w,x) <= &2 * h0) /\ (~(v' = w)) /\ (dist (v',w) <= &2 * h0) /\  (e2 = {v', w}) ==> {x' | x' IN aff_ge {x} e1 /\ x' IN aff_ge {x} e2} = aff_ge {x} {x | x IN e1 /\ x IN e2}`,REPEAT GEN_TAC THEN STRIP_TAC THEN REWRITE_TAC [EXTENSION;GSYM SUBSET_ANTISYM_EQ] THEN REWRITE_TAC [SUBSET] THEN REWRITE_TAC [IN_ELIM_THM] THEN ASM_REWRITE_TAC[] THEN STRIP_TAC THENL (*----*) [REWRITE_TAC [dn3;dn4] THEN GEN_TAC THEN REWRITE_TAC [IN_ELIM_THM] (*v = v'*) THEN ASM_CASES_TAC `(v:real^3 = v':real^3)` THENL [ASM_MESON_TAC [SUBCASE3];(*v = w*) ASM_CASES_TAC `(v:real^3 = w:real^3)` THENL[ASM_MESON_TAC [SUBCASE4]; (* ~(v = v') /\ ~(v = w) *) ASM_MESON_TAC [SUBCASE5]]];(*Small Cases*)(*v = v'*) ASM_CASES_TAC `(v:real^3 = v':real^3)` THENL[ASM_MESON_TAC [SUBCASE6]; (*v = w*) ASM_CASES_TAC `(v:real^3 = w:real^3)` THENL[ASM_MESON_TAC [SUBCASE7];(* ~(v = v') /\ ~(v = w) *) ASM_MESON_TAC [SUBCASE8]]]]);;

(*SUB3 like SUB2*)

let SUBCASE31 = prove( `!(v:real^3) (v':real^3)(w:real^3) (x:real^3)(S:real^3->bool).( v IN S) /\ (x IN S) /\ (~(v = x)) /\ (dist (v,x) <= &2 * h0) /\ (w IN S) /\ (~(w = x)) /\ (dist (w,x) <= &2 * h0) /\ (~(v = w)) /\ (dist (v,w) <= &2 * h0) /\ (e1 = {v, w}) /\ (v' IN S) /\ (~(v' = x)) /\ (dist (v',x) <= &2 * h0) /\ (e2 = {v'})/\ (v' = v)==>  x' IN {y | ?t1 t2 t3. t2 >= &0 /\ t3 >= &0 /\ t1 + t2 + t3 = &1 /\ y = t1 % x + t2 % v + t3 % w} INTER{y | ?t1 t2. t2 >= &0 /\ t1 + t2 = &1 /\ y = t1 % x + t2 % v'} ==> x' IN aff_ge {x} ({v, w} INTER {v'})`,REPEAT GEN_TAC THEN STRIP_TAC THEN ASM_REWRITE_TAC [] THEN REWRITE_TAC [dn62;dn3;INTER;IN_ELIM_THM] THEN STRIP_TAC THEN EXISTS_TAC `t1':real` THEN EXISTS_TAC `t2':real` THEN STRIP_TAC THENL [ASM_ARITH_TAC;STRIP_TAC THENL [ASM_ARITH_TAC;POP_ASSUM MP_TAC THEN VECTOR_ARITH_TAC]]);;

let SUBCASE32 = prove(`!(v:real^3) (v':real^3)(w:real^3) (x:real^3)(S:real^3->bool).( v IN S) /\ (x IN S) /\ (~(v = x)) /\ (dist (v,x) <= &2 * h0) /\ (w IN S) /\ (~(w = x)) /\ (dist (w,x) <= &2 * h0) /\ (~(v = w)) /\ (dist (v,w) <= &2 * h0) /\ (e1 = {v, w}) /\ (v' IN S) /\ (~(v' = x)) /\ (dist (v',x) <= &2 * h0) /\ (e2 = {v'})/\ (~(v' = v)) /\ (v' = w)==>  x' IN {y | ?t1 t2 t3. t2 >= &0 /\ t3 >= &0 /\ t1 + t2 + t3 = &1 /\ y = t1 % x + t2 % v + t3 % w} INTER{y | ?t1 t2. t2 >= &0 /\ t1 + t2 = &1 /\ y = t1 % x + t2 % v'} ==> x' IN aff_ge {x} ({v, w} INTER {v'})`,REPEAT GEN_TAC THEN STRIP_TAC THEN ASM_REWRITE_TAC [] THEN REWRITE_TAC [dn63;dn3;INTER;IN_ELIM_THM] THEN STRIP_TAC THEN EXISTS_TAC `t1':real` THEN EXISTS_TAC `t2':real` THEN STRIP_TAC THENL [ASM_ARITH_TAC;STRIP_TAC THENL [ASM_ARITH_TAC;POP_ASSUM MP_TAC THEN VECTOR_ARITH_TAC]]);;

let SUBCASE33 = prove(`!(v:real^3) (v':real^3)(w:real^3) (x:real^3)(S:real^3->bool).( v IN S) /\ (x IN S) /\ (~(v = x)) /\ (dist (v,x) <= &2 * h0) /\ (w IN S) /\ (~(w = x)) /\ (dist (w,x) <= &2 * h0) /\ (~(v = w)) /\ (dist (v,w) <= &2 * h0) /\ (e1 = {v, w}) /\ (v' IN S) /\ (~(v' = x)) /\ (dist (v',x) <= &2 * h0) /\ (e2 = {v'})/\ (~(v' = v)) /\ (~(v' = w)) ==>  x' IN {y | ?t1 t2 t3. t2 >= &0 /\ t3 >= &0 /\ t1 + t2 + t3 = &1 /\ y = t1 % x + t2 % v + t3 % w} INTER{y | ?t1 t2. t2 >= &0 /\ t1 + t2 = &1 /\ y = t1 % x + t2 % v'} ==> x' IN aff_ge {x} ({v, w} INTER {v'})`,REPEAT GEN_TAC THEN STRIP_TAC THEN REWRITE_TAC [GSYM INTER] THEN SUBGOAL_THEN `({v:real^3,w:real^3} INTER {v':real^3}) = {}` ASSUME_TAC THENL [ASM_MESON_TAC [dn51];ASM_REWRITE_TAC[]] THEN REWRITE_TAC [dn2;IN_SING;INTER;IN_ELIM_THM] THEN STRIP_TAC THEN SUBGOAL_THEN `(x':real^3) - ((t1':real) % (x:real^3) + (t2':real) % (v':real^3)) = vec 0` ASSUME_TAC THENL [POP_ASSUM MP_TAC THEN VECTOR_ARITH_TAC;POP_ASSUM MP_TAC THEN ASM_REWRITE_TAC[]] THEN REWRITE_TAC[VECTOR_ARITH `(t1 % x + t2 % v + t3 % w) - (t1' % x + t2' % v') = ((t1:real)- (t1':real)) % (x:real^3) +((t2:real)%(v:real^3)) + (--(t2':real)%(v':real^3)) + (t3:real)%(w:real^3)`] THEN STRIP_TAC THEN SUBGOAL_THEN `((t1:real)- (t1':real)) = &0 /\ (t2:real) = &0 /\  (--(t2':real)) = &0 /\ ((t3:real)) = &0` ASSUME_TAC THENL [ASM_MESON_TAC [dn11];SUBGOAL_THEN `t1:real = t1':real` ASSUME_TAC THENL [ASM_ARITH_TAC;SUBGOAL_THEN `(t1:real) + &0 + &0 = &1` ASSUME_TAC THENL [ASM_ARITH_TAC;SUBGOAL_THEN `t1:real = &1` ASSUME_TAC THENL [ASM_ARITH_TAC;SUBGOAL_THEN `t1':real = &1` ASSUME_TAC THENL [ASM_ARITH_TAC;ASM_REWRITE_TAC[] THEN VECTOR_ARITH_TAC]]]]]);;

let SUBCASE34 = prove( `!(v:real^3) (v':real^3)(w:real^3) (x:real^3)(S:real^3->bool).( v IN S) /\ (x IN S) /\ (~(v = x)) /\ (dist (v,x) <= &2 * h0) /\ (w IN S) /\ (~(w = x)) /\ (dist (w,x) <= &2 * h0) /\ (~(v = w)) /\ (dist (v,w) <= &2 * h0) /\ (e1 = {v, w}) /\ (v' IN S) /\ (~(v' = x)) /\ (dist (v',x) <= &2 * h0) /\ (e2 = {v'})/\ ((v' = v))==> !x'. x' IN aff_ge {x} ({v, w} INTER {v'}) ==> x' IN aff_ge {x} {v, w} INTER aff_ge {x} {v'}`,REPEAT GEN_TAC THEN STRIP_TAC THEN ASM_REWRITE_TAC [] THEN STRIP_TAC THEN REWRITE_TAC [dn62;dn3;dn4;INTER;IN_ELIM_THM] THEN REPEAT STRIP_TAC THENL [EXISTS_TAC `t1:real` THEN EXISTS_TAC `t2:real` THEN EXISTS_TAC `&0` THEN STRIP_TAC THENL [ASM_ARITH_TAC;STRIP_TAC THENL [ASM_ARITH_TAC;STRIP_TAC THENL [ASM_ARITH_TAC;POP_ASSUM MP_TAC THEN VECTOR_ARITH_TAC]]];EXISTS_TAC `t1:real` THEN EXISTS_TAC `t2:real` THEN STRIP_TAC THENL [ASM_ARITH_TAC;STRIP_TAC THENL [ASM_ARITH_TAC;POP_ASSUM MP_TAC THEN VECTOR_ARITH_TAC]]]);;

let SUBCASE35 = prove(`!(v:real^3) (v':real^3)(w:real^3) (x:real^3)(S:real^3->bool).( v IN S) /\ (x IN S) /\ (~(v = x)) /\ (dist (v,x) <= &2 * h0) /\ (w IN S) /\ (~(w = x)) /\ (dist (w,x) <= &2 * h0) /\ (~(v = w)) /\ (dist (v,w) <= &2 * h0) /\ (e1 = {v, w}) /\ (v' IN S) /\ (~(v' = x)) /\ (dist (v',x) <= &2 * h0) /\ (e2 = {v'})/\ (~(v' = v)) /\ (v' = w) ==> !x'. x' IN aff_ge {x} ({v, w} INTER {v'}) ==> x' IN aff_ge {x} {v, w} INTER aff_ge {x} {v'}`,REPEAT GEN_TAC THEN STRIP_TAC THEN ASM_REWRITE_TAC [] THEN STRIP_TAC THEN REWRITE_TAC [dn63;dn3;dn4;INTER;IN_ELIM_THM] THEN REPEAT STRIP_TAC THENL [EXISTS_TAC `t1:real` THEN EXISTS_TAC `&0` THEN EXISTS_TAC `t2:real` THEN STRIP_TAC THENL [ASM_ARITH_TAC;STRIP_TAC THENL [ASM_ARITH_TAC;STRIP_TAC THENL [ASM_ARITH_TAC;POP_ASSUM MP_TAC THEN VECTOR_ARITH_TAC]]];EXISTS_TAC `t1:real` THEN EXISTS_TAC `t2:real` THEN STRIP_TAC THENL [ASM_ARITH_TAC;STRIP_TAC THENL [ASM_ARITH_TAC;POP_ASSUM MP_TAC THEN VECTOR_ARITH_TAC]]]);;

let SUBCASE36 = prove( `!(v:real^3) (v':real^3)(w:real^3) (x:real^3)(S:real^3->bool).( v IN S) /\ (x IN S) /\ (~(v = x)) /\ (dist (v,x) <= &2 * h0) /\ (w IN S) /\ (~(w = x)) /\ (dist (w,x) <= &2 * h0) /\ (~(v = w)) /\ (dist (v,w) <= &2 * h0) /\ (e1 = {v, w}) /\ (v' IN S) /\ (~(v' = x)) /\ (dist (v',x) <= &2 * h0) /\ (e2 = {v'})/\ (~(v' = v)) /\ (~(v' = w)) ==> !x'. x' IN aff_ge {x} ({v, w} INTER {v'}) ==> x' IN aff_ge {x} {v, w} INTER aff_ge {x} {v'}`,REPEAT GEN_TAC THEN STRIP_TAC THEN SUBGOAL_THEN `({v:real^3,w:real^3} INTER {v':real^3}) = {}` ASSUME_TAC THENL [ASM_MESON_TAC [dn51];ASM_REWRITE_TAC[]] THEN STRIP_TAC THEN REWRITE_TAC [dn2;IN_SING] THEN STRIP_TAC THEN REWRITE_TAC [dn3;dn4;INTER;IN_ELIM_THM] THEN STRIP_TAC THENL [EXISTS_TAC `&1` THEN EXISTS_TAC `&0` THEN EXISTS_TAC `&0` THEN STRIP_TAC THENL [ASM_ARITH_TAC;STRIP_TAC THENL [ASM_ARITH_TAC;STRIP_TAC THENL [ASM_ARITH_TAC;POP_ASSUM MP_TAC THEN VECTOR_ARITH_TAC]]];EXISTS_TAC `&1` THEN EXISTS_TAC `&0` THEN STRIP_TAC THENL [ASM_ARITH_TAC;STRIP_TAC THENL [ASM_ARITH_TAC;POP_ASSUM MP_TAC THEN VECTOR_ARITH_TAC]]]);;



let cautruc10 = prove(`!(v:real^3) (v':real^3)(w:real^3) (x:real^3)(S:real^3->bool).( v IN S) /\ (x IN S) /\ (~(v = x)) /\ (dist (v,x) <= &2 * h0) /\ (w IN S) /\ (~(w = x)) /\ (dist (w,x) <= &2 * h0) /\ (~(v = w)) /\ (dist (v,w) <= &2 * h0) /\ (e1 = {v, w}) /\ (v' IN S) /\ (~(v' = x)) /\ (dist (v',x) <= &2 * h0) /\ (e2 = {v'}) ==> aff_ge {x} e1 INTER aff_ge {x} e2 = aff_ge {x} (e1 INTER e2)`,REPEAT GEN_TAC THEN STRIP_TAC THEN REWRITE_TAC [EXTENSION;GSYM SUBSET_ANTISYM_EQ;SUBSET;IN_ELIM_THM] THEN ASM_REWRITE_TAC[] THEN STRIP_TAC THENL(*----*)[REWRITE_TAC [dn3;dn4] THEN GEN_TAC THEN REWRITE_TAC [IN_ELIM_THM] THEN (*v' = v*)ASM_CASES_TAC `(v':real^3 = v:real^3)` THENL [ASM_MESON_TAC [SUBCASE31];(*v' = w*)ASM_CASES_TAC `(v':real^3 = w:real^3)` THENL [ASM_MESON_TAC [SUBCASE32];(*~(v' = v) /\ ~(v' = w)*)ASM_MESON_TAC [SUBCASE33]]];(*Small Case*)(*v = v'*)ASM_CASES_TAC `(v':real^3 = v:real^3)` THENL [ASM_MESON_TAC [SUBCASE34];(*v' = w*)ASM_CASES_TAC `(v':real^3 = w:real^3)` THENL [ASM_MESON_TAC [SUBCASE35];(* ~(v = v') /\ ~(v = w) *)ASM_MESON_TAC [SUBCASE36]]]]);;


(*SUB4*)
let SUBCASE41 = prove( `!(v:real^3)(v':real^3)(w:real^3)(w':real^3)(x:real^3)(S:real^3->bool).( v IN S) /\ ( x IN S) /\ ( ~(v = x)) /\ ( dist (v,x) <= &2 * h0) /\ (w IN S) /\ (~(w = x)) /\ ( dist (w,x) <= &2 * h0) /\ ( ~(v = w)) /\ ( dist (v,w) <= &2 * h0) /\ ( e1 = {v, w}) /\ ( v' IN S) /\ ( ~(v' = x)) /\ ( dist (v',x) <= &2 * h0) /\ ( w' IN S) /\ ( ~(w' = x)) /\ ( dist (w',x) <= &2 * h0) /\ ( ~(v' = w')) /\(dist(v',w') <= &2 * h0) /\ (e2 = {v', w'}) /\({v, w} = {v', w'})  ==> x' IN {y | ?t1 t2 t3.t2 >= &0 /\ t3 >= &0 /\ t1 + t2 + t3 = &1 /\ y = t1 % x + t2 % v + t3 % w} INTER {y | ?t1 t2 t3. t2 >= &0 /\ t3 >= &0 /\ t1 + t2 + t3 = &1 /\ y = t1 % x + t2 % v' + t3 % w'}  ==> x' IN aff_ge {x} ({v, w} INTER {v', w'})`,REPEAT GEN_TAC THEN STRIP_TAC THEN ASM_REWRITE_TAC[] THEN REWRITE_TAC [dn8;INTER;IN_ELIM_THM;dn4] THEN STRIP_TAC THEN REWRITE_TAC [IN_ELIM_THM] THEN EXISTS_TAC `t1':real` THEN EXISTS_TAC `t2':real` THEN EXISTS_TAC `t3':real` THEN STRIP_TAC THENL [ASM_ARITH_TAC;STRIP_TAC THENL [ASM_ARITH_TAC;STRIP_TAC THENL [ASM_ARITH_TAC;POP_ASSUM MP_TAC THEN VECTOR_ARITH_TAC]]]);;

let SUBCASE42 = prove(`!(v:real^3)(v':real^3)(w:real^3)(w':real^3)(x:real^3)(S:real^3->bool).( v IN S) /\ ( x IN S) /\ ( ~(v = x)) /\ ( dist (v,x) <= &2 * h0) /\ (w IN S) /\ (~(w = x)) /\ ( dist (w,x) <= &2 * h0) /\ ( ~(v = w)) /\ ( dist (v,w) <= &2 * h0) /\ ( e1 = {v, w}) /\ ( v' IN S) /\ ( ~(v' = x)) /\ ( dist (v',x) <= &2 * h0) /\ ( w' IN S) /\ ( ~(w' = x)) /\ ( dist (w',x) <= &2 * h0) /\ ( ~(v' = w')) /\(dist(v',w') <= &2 * h0) /\ (e2 = {v', w'}) /\(~({v, w} = {v', w'})) /\ (v = v') ==> x' IN {y | ?t1 t2 t3.t2 >= &0 /\ t3 >= &0 /\ t1 + t2 + t3 = &1 /\ y = t1 % x + t2 % v + t3 % w} INTER {y | ?t1 t2 t3. t2 >= &0 /\ t3 >= &0 /\ t1 + t2 + t3 = &1 /\ y = t1 % x + t2 % v' + t3 % w'}  ==> x' IN aff_ge {x} ({v, w} INTER {v', w'})`,REPEAT GEN_TAC THEN STRIP_TAC THEN ASM_REWRITE_TAC [] THEN SUBGOAL_THEN `({v':real^3,w:real^3} INTER {v':real^3, w':real^3}) = {v'}` ASSUME_TAC THENL [ASM_MESON_TAC [dn9];ASM_REWRITE_TAC[]] THEN REWRITE_TAC [INTER;dn3;IN_ELIM_THM] THEN STRIP_TAC THEN SUBGOAL_THEN `(x':real^3) - ((t1':real) % (x:real^3) + (t2':real) % (v':real^3) + (t3':real) % (w':real^3)) = vec 0` ASSUME_TAC THENL [POP_ASSUM MP_TAC THEN VECTOR_ARITH_TAC;POP_ASSUM MP_TAC THEN ASM_REWRITE_TAC[]] THEN REWRITE_TAC[VECTOR_ARITH `(t1 % x + t2 % v' + t3 % w) - (t1' % x + t2' % v' + t3' % w') = ((t1:real)- (t1':real)) % (x:real^3) + ((t2:real) - (t2':real)) % (v':real^3) + ((t3:real) % (w:real^3)) + (--(t3':real) % (w':real^3))`] THEN STRIP_TAC THEN SUBGOAL_THEN `((t1:real)- (t1':real)) = &0 /\  ((t2:real) - (t2':real)) = &0 /\ (t3:real) = &0 /\  (--(t3':real)) = &0` ASSUME_TAC THENL [ASM_MESON_TAC [dn11];SUBGOAL_THEN `(t1:real) + (t2:real) + &0 = &1` ASSUME_TAC THENL [ASM_ARITH_TAC;SUBGOAL_THEN `(t1:real) + (t2:real) = &1` ASSUME_TAC THENL [ASM_ARITH_TAC;SUBGOAL_THEN `(x':real^3) = (t1:real) % (x:real^3) + (t2:real) % (v':real^3) + &0 % (w:real^3)` ASSUME_TAC THENL [ASM_MESON_TAC[];EXISTS_TAC `t1:real` THEN EXISTS_TAC `t2:real` THEN STRIP_TAC THENL [ASM_ARITH_TAC;STRIP_TAC THENL [ASM_ARITH_TAC;ASM_REWRITE_TAC[] THEN VECTOR_ARITH_TAC]]]]]]);;

let SUBCASE43 = prove(`!(v:real^3)(v':real^3)(w:real^3)(w':real^3)(x:real^3)(S:real^3->bool).( v IN S) /\ ( x IN S) /\ ( ~(v = x)) /\ ( dist (v,x) <= &2 * h0) /\ (w IN S) /\ (~(w = x)) /\ ( dist (w,x) <= &2 * h0) /\ ( ~(v = w)) /\ ( dist (v,w) <= &2 * h0) /\ ( e1 = {v, w}) /\ ( v' IN S) /\ ( ~(v' = x)) /\ ( dist (v',x) <= &2 * h0) /\ ( w' IN S) /\ ( ~(w' = x)) /\ ( dist (w',x) <= &2 * h0) /\ ( ~(v' = w')) /\(dist(v',w') <= &2 * h0) /\ (e2 = {v', w'}) /\(~({v, w} = {v', w'})) /\ (~(v = v')) /\ (v = w') ==> x' IN {y | ?t1 t2 t3.t2 >= &0 /\ t3 >= &0 /\ t1 + t2 + t3 = &1 /\ y = t1 % x + t2 % v + t3 % w} INTER {y | ?t1 t2 t3. t2 >= &0 /\ t3 >= &0 /\ t1 + t2 + t3 = &1 /\ y = t1 % x + t2 % v' + t3 % w'}  ==> x' IN aff_ge {x} ({v, w} INTER {v', w'})`,REPEAT GEN_TAC THEN STRIP_TAC THEN ASM_REWRITE_TAC [] THEN SUBGOAL_THEN `({w':real^3,w:real^3} INTER {v':real^3, w':real^3}) = {w'}` ASSUME_TAC THENL [ASM_MESON_TAC [dn91];ASM_REWRITE_TAC[]] THEN REWRITE_TAC [INTER;dn3;IN_ELIM_THM] THEN STRIP_TAC THEN SUBGOAL_THEN `(x':real^3) - ((t1':real) % (x:real^3) + (t2':real) % (v':real^3) + (t3':real) % (w':real^3)) = vec 0` ASSUME_TAC THENL [POP_ASSUM MP_TAC THEN VECTOR_ARITH_TAC;POP_ASSUM MP_TAC THEN ASM_REWRITE_TAC[]] THEN REWRITE_TAC[VECTOR_ARITH `(t1 % x + t2 % w' + t3 % w) - (t1' % x + t2' % v' + t3' % w') = ((t1:real)- (t1':real)) % (x:real^3) + ((t2:real) - (t3':real)) % (w':real^3) + ((t3:real) % (w:real^3)) + (--(t2':real) % (v':real^3))`] THEN STRIP_TAC THEN SUBGOAL_THEN `((t1:real)- (t1':real)) = &0 /\  ((t2:real) - (t3':real)) = &0 /\ (t3:real) = &0 /\  (--(t2':real)) = &0` ASSUME_TAC THENL [ASM_MESON_TAC [dn11];SUBGOAL_THEN `(t1:real) + (t2:real) + &0 = &1` ASSUME_TAC THENL [ASM_ARITH_TAC;SUBGOAL_THEN `(t1:real) + (t2:real) = &1` ASSUME_TAC THENL [ASM_ARITH_TAC;EXISTS_TAC `t1:real` THEN EXISTS_TAC `t2:real` THEN STRIP_TAC THENL [ASM_ARITH_TAC;STRIP_TAC THENL [ASM_ARITH_TAC;ASM_REWRITE_TAC[] THEN VECTOR_ARITH_TAC]]]]]);;

let SUBCASE44 = prove(`!(v:real^3)(v':real^3)(w:real^3)(w':real^3)(x:real^3)(S:real^3->bool).( v IN S) /\ ( x IN S) /\ ( ~(v = x)) /\ ( dist (v,x) <= &2 * h0) /\ (w IN S) /\ (~(w = x)) /\ ( dist (w,x) <= &2 * h0) /\ ( ~(v = w)) /\ ( dist (v,w) <= &2 * h0) /\ ( e1 = {v, w}) /\ ( v' IN S) /\ ( ~(v' = x)) /\ ( dist (v',x) <= &2 * h0) /\ ( w' IN S) /\ ( ~(w' = x)) /\ ( dist (w',x) <= &2 * h0) /\ ( ~(v' = w')) /\(dist(v',w') <= &2 * h0) /\ (e2 = {v', w'}) /\(~({v, w} = {v', w'})) /\ (~(v = v')) /\ (~(v = w')) /\ (w = v') ==> x' IN {y | ?t1 t2 t3.t2 >= &0 /\ t3 >= &0 /\ t1 + t2 + t3 = &1 /\ y = t1 % x + t2 % v + t3 % w} INTER {y | ?t1 t2 t3. t2 >= &0 /\ t3 >= &0 /\ t1 + t2 + t3 = &1 /\ y = t1 % x + t2 % v' + t3 % w'}  ==> x' IN aff_ge {x} ({v, w} INTER {v', w'})`,REPEAT GEN_TAC THEN STRIP_TAC THEN ASM_REWRITE_TAC [] THEN SUBGOAL_THEN `({v:real^3,v':real^3} INTER {v':real^3, w':real^3}) = {v'}` ASSUME_TAC THENL [ASM_MESON_TAC [dn92];ASM_REWRITE_TAC[]] THEN REWRITE_TAC [INTER;dn3;IN_ELIM_THM] THEN STRIP_TAC THEN SUBGOAL_THEN `(x':real^3) - ((t1':real) % (x:real^3) + (t2':real) % (v':real^3) + (t3':real) % (w':real^3)) = vec 0` ASSUME_TAC THENL [POP_ASSUM MP_TAC THEN VECTOR_ARITH_TAC;POP_ASSUM MP_TAC THEN ASM_REWRITE_TAC[]] THEN REWRITE_TAC[VECTOR_ARITH `(t1 % x + t2 % v + t3 % v') - (t1' % x + t2' % v' + t3' % w') = ((t1:real)- (t1':real)) % (x:real^3) + ((t2:real)) % (v:real^3) + ((t3:real)- (t2':real)) % (v':real^3) + (--(t3':real) % (w':real^3))`] THEN STRIP_TAC THEN SUBGOAL_THEN `((t1:real)- (t1':real)) = &0 /\  ((t2:real)) = &0 /\ ((t3:real)- (t2':real)) = &0 /\  (--(t3':real)) = &0` ASSUME_TAC THENL [ASM_MESON_TAC [dn11];SUBGOAL_THEN `(t1:real) + (t3:real) + &0 = &1` ASSUME_TAC THENL [ASM_ARITH_TAC;SUBGOAL_THEN `(t1:real) + (t3:real) = &1` ASSUME_TAC THENL [ASM_ARITH_TAC;EXISTS_TAC `t1:real` THEN EXISTS_TAC `t3:real` THEN STRIP_TAC THENL [ASM_ARITH_TAC;STRIP_TAC THENL [ASM_ARITH_TAC;ASM_REWRITE_TAC[] THEN VECTOR_ARITH_TAC]]]]]);;

let SUBCASE45 = prove(`!(v:real^3)(v':real^3)(w:real^3)(w':real^3)(x:real^3)(S:real^3->bool).( v IN S) /\ ( x IN S) /\ ( ~(v = x)) /\ ( dist (v,x) <= &2 * h0) /\ (w IN S) /\ (~(w = x)) /\ ( dist (w,x) <= &2 * h0) /\ ( ~(v = w)) /\ ( dist (v,w) <= &2 * h0) /\ ( e1 = {v, w}) /\ ( v' IN S) /\ ( ~(v' = x)) /\ ( dist (v',x) <= &2 * h0) /\ ( w' IN S) /\ ( ~(w' = x)) /\ ( dist (w',x) <= &2 * h0) /\ ( ~(v' = w')) /\(dist(v',w') <= &2 * h0) /\ (e2 = {v', w'}) /\(~({v, w} = {v', w'})) /\ (~(v = v')) /\ (~(v = w')) /\ (~(w = v')) /\ (w = w') ==> x' IN {y | ?t1 t2 t3.t2 >= &0 /\ t3 >= &0 /\ t1 + t2 + t3 = &1 /\ y = t1 % x + t2 % v + t3 % w} INTER {y | ?t1 t2 t3. t2 >= &0 /\ t3 >= &0 /\ t1 + t2 + t3 = &1 /\ y = t1 % x + t2 % v' + t3 % w'}  ==> x' IN aff_ge {x} ({v, w} INTER {v', w'})`,REPEAT GEN_TAC THEN STRIP_TAC THEN ASM_REWRITE_TAC [] THEN SUBGOAL_THEN `({v:real^3,w':real^3} INTER {v':real^3, w':real^3}) = {w'}` ASSUME_TAC THENL [ASM_MESON_TAC [dn93];ASM_REWRITE_TAC[]] THEN REWRITE_TAC [INTER;dn3;IN_ELIM_THM] THEN STRIP_TAC THEN SUBGOAL_THEN `(x':real^3) - ((t1':real) % (x:real^3) + (t2':real) % (v':real^3) + (t3':real) % (w':real^3)) = vec 0` ASSUME_TAC THENL [POP_ASSUM MP_TAC THEN VECTOR_ARITH_TAC;POP_ASSUM MP_TAC THEN ASM_REWRITE_TAC[]] THEN REWRITE_TAC[VECTOR_ARITH `(t1 % x + t2 % v + t3 % w') - (t1' % x + t2' % v' + t3' % w') = ((t1:real)- (t1':real)) % (x:real^3) + ((t2:real)) % (v:real^3) + ((t3:real)- (t3':real)) % (w':real^3) + (--(t2':real) % (v':real^3))`] THEN STRIP_TAC THEN SUBGOAL_THEN `((t1:real)- (t1':real)) = &0 /\  ((t2:real)) = &0 /\ ((t3:real)- (t3':real)) = &0 /\  (--(t2':real)) = &0` ASSUME_TAC THENL [ASM_MESON_TAC [dn11];SUBGOAL_THEN `(t1:real) + (t3:real) + &0 = &1` ASSUME_TAC THENL [ASM_ARITH_TAC;SUBGOAL_THEN `(t1:real) + (t3:real) = &1` ASSUME_TAC THENL [ASM_ARITH_TAC;EXISTS_TAC `t1:real` THEN EXISTS_TAC `t3:real` THEN STRIP_TAC THENL [ASM_ARITH_TAC;STRIP_TAC THENL [ASM_ARITH_TAC;ASM_REWRITE_TAC[] THEN VECTOR_ARITH_TAC]]]]]);;

let SUBCASE46 = prove(`!(v:real^3)(v':real^3)(w:real^3)(w':real^3)(x:real^3)(S:real^3->bool).( v IN S) /\ ( x IN S) /\ ( ~(v = x)) /\ ( dist (v,x) <= &2 * h0) /\ (w IN S) /\ (~(w = x)) /\ ( dist (w,x) <= &2 * h0) /\ ( ~(v = w)) /\ ( dist (v,w) <= &2 * h0) /\ ( e1 = {v, w}) /\ ( v' IN S) /\ ( ~(v' = x)) /\ ( dist (v',x) <= &2 * h0) /\ ( w' IN S) /\ ( ~(w' = x)) /\ ( dist (w',x) <= &2 * h0) /\ ( ~(v' = w')) /\(dist(v',w') <= &2 * h0) /\ (e2 = {v', w'}) /\(~({v, w} = {v', w'})) /\ (~(v = v')) /\ (~(v = w')) /\ (~(w = v')) /\ (~(w = w')) ==> x' IN {y | ?t1 t2 t3.t2 >= &0 /\ t3 >= &0 /\ t1 + t2 + t3 = &1 /\ y = t1 % x + t2 % v + t3 % w} INTER {y | ?t1 t2 t3. t2 >= &0 /\ t3 >= &0 /\ t1 + t2 + t3 = &1 /\ y = t1 % x + t2 % v' + t3 % w'}  ==> x' IN aff_ge {x} ({v, w} INTER {v', w'})`,REPEAT GEN_TAC THEN STRIP_TAC THEN REWRITE_TAC [GSYM INTER] THEN SUBGOAL_THEN `({v:real^3,w:real^3} INTER {v':real^3, w':real^3}) = {}` ASSUME_TAC THENL [ASM_MESON_TAC [dn112];ASM_REWRITE_TAC[]] THEN REWRITE_TAC [dn2;IN_SING;INTER;IN_ELIM_THM] THEN STRIP_TAC THEN SUBGOAL_THEN `(x':real^3) - ((t1':real) % (x:real^3) + (t2':real) % (v':real^3) + (t3':real) % (w':real^3)) = vec 0` ASSUME_TAC THENL [POP_ASSUM MP_TAC THEN VECTOR_ARITH_TAC;POP_ASSUM MP_TAC THEN ASM_REWRITE_TAC[]] THEN REWRITE_TAC[VECTOR_ARITH `(t1 % x + t2 % v + t3 % w) - (t1' % x + t2' % v' + t3' % w') = ((t1:real)- (t1':real)) % (x:real^3) + (t2:real) % (v:real^3) + (t3:real) % (w:real^3) + (--(t2':real) % (v':real^3)) + (--(t3':real) % (w':real^3))`] THEN STRIP_TAC THEN SUBGOAL_THEN `((t1:real)- (t1':real)) = &0 /\  ((t2:real)) = &0 /\ ((t3:real)) = &0 /\ (--(t2':real)) = &0 /\  (--(t3':real)) = &0` ASSUME_TAC THENL [ASM_MESON_TAC [dn12];SUBGOAL_THEN `(t1:real) + &0 + &0 = &1` ASSUME_TAC THENL [ASM_ARITH_TAC;SUBGOAL_THEN `(t1:real) = &1` ASSUME_TAC THENL [ASM_ARITH_TAC;ASM_REWRITE_TAC[] THEN VECTOR_ARITH_TAC]]]);;

let SUBCASE47 = prove( `!(v:real^3)(v':real^3)(w:real^3)(w':real^3)(x:real^3)(S:real^3->bool).( v IN S) /\ ( x IN S) /\ ( ~(v = x)) /\ ( dist (v,x) <= &2 * h0) /\ (w IN S) /\ (~(w = x)) /\ ( dist (w,x) <= &2 * h0) /\ ( ~(v = w)) /\ ( dist (v,w) <= &2 * h0) /\ ( e1 = {v, w}) /\ ( v' IN S) /\ ( ~(v' = x)) /\ ( dist (v',x) <= &2 * h0) /\ ( w' IN S) /\ ( ~(w' = x)) /\ ( dist (w',x) <= &2 * h0) /\ ( ~(v' = w')) /\(dist(v',w') <= &2 * h0) /\ (e2 = {v', w'}) /\ ({v, w} = {v', w'}) ==> !x'. x' IN aff_ge {x} ({v, w} INTER {v', w'}) ==> x' IN aff_ge {x} {v, w} INTER aff_ge {x} {v', w'}`,REPEAT GEN_TAC THEN STRIP_TAC THEN ASM_REWRITE_TAC[] THEN REWRITE_TAC [dn8;INTER;IN_ELIM_THM]);;

let SUBCASE48 = prove( `!(v:real^3)(v':real^3)(w:real^3)(w':real^3)(x:real^3)(S:real^3->bool).( v IN S) /\ ( x IN S) /\ ( ~(v = x)) /\ ( dist (v,x) <= &2 * h0) /\ (w IN S) /\ (~(w = x)) /\ ( dist (w,x) <= &2 * h0) /\ ( ~(v = w)) /\ ( dist (v,w) <= &2 * h0) /\ ( e1 = {v, w}) /\ ( v' IN S) /\ ( ~(v' = x)) /\ ( dist (v',x) <= &2 * h0) /\ ( w' IN S) /\ ( ~(w' = x)) /\ ( dist (w',x) <= &2 * h0) /\ ( ~(v' = w')) /\(dist(v',w') <= &2 * h0) /\ (e2 = {v', w'}) /\ (~({v, w} = {v', w'})) /\ (v = v') ==> !x'. x' IN aff_ge {x} ({v, w} INTER {v', w'}) ==> x' IN aff_ge {x} {v, w} INTER aff_ge {x} {v', w'}`,REPEAT GEN_TAC THEN STRIP_TAC THEN ASM_REWRITE_TAC [] THEN SUBGOAL_THEN `({v':real^3,w:real^3} INTER {v':real^3, w':real^3}) = {v'}` ASSUME_TAC THENL [ASM_MESON_TAC [dn9];ASM_REWRITE_TAC[]] THEN REWRITE_TAC [INTER;dn3;IN_ELIM_THM] THEN STRIP_TAC THEN REWRITE_TAC [dn4] THEN STRIP_TAC THEN REWRITE_TAC [IN_ELIM_THM] THEN STRIP_TAC THENL [EXISTS_TAC `t1:real` THEN EXISTS_TAC `t2:real` THEN EXISTS_TAC `&0` THEN STRIP_TAC THENL [ASM_ARITH_TAC;STRIP_TAC THENL [ASM_ARITH_TAC;STRIP_TAC THENL [ASM_ARITH_TAC;POP_ASSUM MP_TAC THEN VECTOR_ARITH_TAC]]];EXISTS_TAC `t1:real` THEN EXISTS_TAC `t2:real` THEN EXISTS_TAC `&0` THEN STRIP_TAC THENL [ASM_ARITH_TAC;STRIP_TAC THENL [ASM_ARITH_TAC;STRIP_TAC THENL [ASM_ARITH_TAC;POP_ASSUM MP_TAC THEN VECTOR_ARITH_TAC]]]]);;

let SUBCASE49 = prove(`!(v:real^3)(v':real^3)(w:real^3)(w':real^3)(x:real^3)(S:real^3->bool).( v IN S) /\ ( x IN S) /\ ( ~(v = x)) /\ ( dist (v,x) <= &2 * h0) /\ (w IN S) /\ (~(w = x)) /\ ( dist (w,x) <= &2 * h0) /\ ( ~(v = w)) /\ ( dist (v,w) <= &2 * h0) /\ ( e1 = {v, w}) /\ ( v' IN S) /\ ( ~(v' = x)) /\ ( dist (v',x) <= &2 * h0) /\ ( w' IN S) /\ ( ~(w' = x)) /\ ( dist (w',x) <= &2 * h0) /\ ( ~(v' = w')) /\(dist(v',w') <= &2 * h0) /\ (e2 = {v', w'}) /\ (~({v, w} = {v', w'})) /\ (~(v = v')) /\ (v = w') ==> !x'. x' IN aff_ge {x} ({v, w} INTER {v', w'}) ==> x' IN aff_ge {x} {v, w} INTER aff_ge {x} {v', w'}`,REPEAT GEN_TAC THEN STRIP_TAC THEN ASM_REWRITE_TAC [] THEN SUBGOAL_THEN `({w':real^3,w:real^3} INTER {v':real^3, w':real^3}) = {w'}` ASSUME_TAC THENL [ASM_MESON_TAC [dn91];ASM_REWRITE_TAC[]] THEN REWRITE_TAC [INTER;dn3;IN_ELIM_THM] THEN STRIP_TAC THEN REWRITE_TAC [dn4] THEN STRIP_TAC THEN REWRITE_TAC [IN_ELIM_THM] THEN STRIP_TAC THENL [EXISTS_TAC `t1:real` THEN EXISTS_TAC `t2:real` THEN EXISTS_TAC `&0` THEN STRIP_TAC THENL [ASM_ARITH_TAC;STRIP_TAC THENL [ASM_ARITH_TAC;STRIP_TAC THENL [ASM_ARITH_TAC;POP_ASSUM MP_TAC THEN VECTOR_ARITH_TAC]]];EXISTS_TAC `t1:real` THEN EXISTS_TAC `&0` THEN EXISTS_TAC `t2:real` THEN STRIP_TAC THENL [ASM_ARITH_TAC;STRIP_TAC THENL [ASM_ARITH_TAC;STRIP_TAC THENL [ASM_ARITH_TAC;POP_ASSUM MP_TAC THEN VECTOR_ARITH_TAC]]]]);;

let SUBCASE50 = prove(`!(v:real^3)(v':real^3)(w:real^3)(w':real^3)(x:real^3)(S:real^3->bool).( v IN S) /\ ( x IN S) /\ ( ~(v = x)) /\ ( dist (v,x) <= &2 * h0) /\ (w IN S) /\ (~(w = x)) /\ ( dist (w,x) <= &2 * h0) /\ ( ~(v = w)) /\ ( dist (v,w) <= &2 * h0) /\ ( e1 = {v, w}) /\ ( v' IN S) /\ ( ~(v' = x)) /\ ( dist (v',x) <= &2 * h0) /\ ( w' IN S) /\ ( ~(w' = x)) /\ ( dist (w',x) <= &2 * h0) /\ ( ~(v' = w')) /\(dist(v',w') <= &2 * h0) /\ (e2 = {v', w'}) /\ (~({v, w} = {v', w'})) /\ (~(v = v')) /\ (~(v = w')) /\ (w = v') ==> !x'. x' IN aff_ge {x} ({v, w} INTER {v', w'}) ==> x' IN aff_ge {x} {v, w} INTER aff_ge {x} {v', w'}`,REPEAT GEN_TAC THEN STRIP_TAC THEN ASM_REWRITE_TAC [] THEN SUBGOAL_THEN `({v:real^3,v':real^3} INTER {v':real^3, w':real^3}) = {v'}` ASSUME_TAC THENL [ASM_MESON_TAC [dn92];ASM_REWRITE_TAC[]] THEN REWRITE_TAC [INTER] THEN STRIP_TAC THEN REWRITE_TAC [dn4;dn3;IN_ELIM_THM] THEN  REPEAT STRIP_TAC THENL [EXISTS_TAC `t1:real` THEN EXISTS_TAC `&0` THEN EXISTS_TAC `t2:real` THEN STRIP_TAC THENL [ASM_ARITH_TAC;STRIP_TAC THENL [ASM_ARITH_TAC;STRIP_TAC THENL [ASM_ARITH_TAC;POP_ASSUM MP_TAC THEN VECTOR_ARITH_TAC]]];EXISTS_TAC `t1:real` THEN EXISTS_TAC `t2:real` THEN EXISTS_TAC `&0` THEN STRIP_TAC THENL [ASM_ARITH_TAC;STRIP_TAC THENL [ASM_ARITH_TAC;STRIP_TAC THENL [ASM_ARITH_TAC;POP_ASSUM MP_TAC THEN VECTOR_ARITH_TAC]]]]);;

let SUBCASE51 = prove(`!(v:real^3)(v':real^3)(w:real^3)(w':real^3)(x:real^3)(S:real^3->bool).( v IN S) /\ ( x IN S) /\ ( ~(v = x)) /\ ( dist (v,x) <= &2 * h0) /\ (w IN S) /\ (~(w = x)) /\ ( dist (w,x) <= &2 * h0) /\ ( ~(v = w)) /\ ( dist (v,w) <= &2 * h0) /\ ( e1 = {v, w}) /\ ( v' IN S) /\ ( ~(v' = x)) /\ ( dist (v',x) <= &2 * h0) /\ ( w' IN S) /\ ( ~(w' = x)) /\ ( dist (w',x) <= &2 * h0) /\ ( ~(v' = w')) /\(dist(v',w') <= &2 * h0) /\ (e2 = {v', w'}) /\ (~({v, w} = {v', w'})) /\ (~(v = v')) /\ (~(v = w')) /\ (~(w = v')) /\ (w = w') ==> !x'. x' IN aff_ge {x} ({v, w} INTER {v', w'}) ==> x' IN aff_ge {x} {v, w} INTER aff_ge {x} {v', w'}`,REPEAT GEN_TAC THEN STRIP_TAC THEN ASM_REWRITE_TAC [] THEN SUBGOAL_THEN `({v:real^3,w':real^3} INTER {v':real^3, w':real^3}) = {w'}` ASSUME_TAC THENL [ASM_MESON_TAC [dn93];ASM_REWRITE_TAC[]] THEN REWRITE_TAC [INTER;dn3;IN_ELIM_THM] THEN STRIP_TAC THEN REWRITE_TAC [dn4;IN_ELIM_THM] THEN REPEAT STRIP_TAC THENL [EXISTS_TAC `t1:real` THEN EXISTS_TAC `&0` THEN EXISTS_TAC `t2:real` THEN STRIP_TAC THENL [ASM_ARITH_TAC;STRIP_TAC THENL [ASM_ARITH_TAC;STRIP_TAC THENL [ASM_ARITH_TAC;POP_ASSUM MP_TAC THEN VECTOR_ARITH_TAC]]];EXISTS_TAC `t1:real` THEN EXISTS_TAC `&0` THEN EXISTS_TAC `t2:real` THEN STRIP_TAC THENL [ASM_ARITH_TAC;STRIP_TAC THENL [ASM_ARITH_TAC;STRIP_TAC THENL [ASM_ARITH_TAC;POP_ASSUM MP_TAC THEN VECTOR_ARITH_TAC]]]]);;

let SUBCASE52 = prove( `!(v:real^3)(v':real^3)(w:real^3)(w':real^3)(x:real^3)(S:real^3->bool).( v IN S) /\ ( x IN S) /\ ( ~(v = x)) /\ ( dist (v,x) <= &2 * h0) /\ (w IN S) /\ (~(w = x)) /\ ( dist (w,x) <= &2 * h0) /\ ( ~(v = w)) /\ ( dist (v,w) <= &2 * h0) /\ ( e1 = {v, w}) /\ ( v' IN S) /\ ( ~(v' = x)) /\ ( dist (v',x) <= &2 * h0) /\ ( w' IN S) /\ ( ~(w' = x)) /\ ( dist (w',x) <= &2 * h0) /\ ( ~(v' = w')) /\(dist(v',w') <= &2 * h0) /\ (e2 = {v', w'}) /\ (~({v, w} = {v', w'})) /\ (~(v = v')) /\ (~(v = w')) /\ (~(w = v')) /\ (~(w = w')) ==> !x'. x' IN aff_ge {x} ({v, w} INTER {v', w'}) ==> x' IN aff_ge {x} {v, w} INTER aff_ge {x} {v', w'}`,REPEAT GEN_TAC THEN STRIP_TAC THEN REWRITE_TAC [GSYM INTER] THEN SUBGOAL_THEN `({v:real^3,w:real^3} INTER {v':real^3, w':real^3}) = {}` ASSUME_TAC THENL [ASM_MESON_TAC [dn112];ASM_REWRITE_TAC[]] THEN REWRITE_TAC [dn2;IN_SING;INTER;IN_ELIM_THM] THEN REPEAT STRIP_TAC THEN REWRITE_TAC [dn4;IN_ELIM_THM] THENL [EXISTS_TAC `&1` THEN EXISTS_TAC `&0` THEN EXISTS_TAC `&0` THEN STRIP_TAC THENL [ASM_ARITH_TAC;STRIP_TAC THENL [ASM_ARITH_TAC;STRIP_TAC THENL [ASM_ARITH_TAC;POP_ASSUM MP_TAC THEN VECTOR_ARITH_TAC]]];EXISTS_TAC `&1` THEN EXISTS_TAC `&0` THEN EXISTS_TAC `&0` THEN STRIP_TAC THENL [ASM_ARITH_TAC;STRIP_TAC THENL [ASM_ARITH_TAC;STRIP_TAC THENL [ASM_ARITH_TAC;POP_ASSUM MP_TAC THEN VECTOR_ARITH_TAC]]]]);;

let cautruc11 = prove(`!(v:real^3)(v':real^3)(w:real^3)(w':real^3)(x:real^3)(S:real^3->bool).( v IN S) /\ ( x IN S) /\ ( ~(v = x)) /\ ( dist (v,x) <= &2 * h0) /\ (w IN S) /\ (~(w = x)) /\ ( dist (w,x) <= &2 * h0) /\ ( ~(v = w)) /\ ( dist (v,w) <= &2 * h0) /\ ( e1 = {v, w}) /\ ( v' IN S) /\ ( ~(v' = x)) /\ ( dist (v',x) <= &2 * h0) /\ ( w' IN S) /\ ( ~(w' = x)) /\ ( dist (w',x) <= &2 * h0) /\ ( ~(v' = w')) /\(dist(v',w') <= &2 * h0) /\ (e2 = {v', w'}) ==> aff_ge {x} e1 INTER aff_ge {x} e2 = aff_ge {x} (e1 INTER e2)`,REPEAT GEN_TAC THEN STRIP_TAC THEN REWRITE_TAC [EXTENSION;GSYM SUBSET_ANTISYM_EQ;SUBSET;IN_ELIM_THM] THEN ASM_REWRITE_TAC[] THEN STRIP_TAC THENL(*-------*)[REWRITE_TAC [dn4] THEN GEN_TAC THEN REWRITE_TAC [IN_ELIM_THM] THEN (*{v,w} = {v',w'}*)ASM_CASES_TAC `{v:real^3,w:real^3} = {v':real^3,w':real^3}` THENL [ASM_MESON_TAC [SUBCASE41];(*v = v'*)ASM_CASES_TAC `(v:real^3 = v':real^3)` THENL [ASM_MESON_TAC [SUBCASE42];(*v = w*)ASM_CASES_TAC `(v:real^3 = w':real^3)` THENL [ASM_MESON_TAC [SUBCASE43];(* w = v'*)ASM_CASES_TAC `(w:real^3 = v':real^3)` THENL [ASM_MESON_TAC [SUBCASE44];(*(w = w')*)ASM_CASES_TAC `(w:real^3 = w':real^3)` THENL [ASM_MESON_TAC [SUBCASE45];(*(~({v, w} = {v', w'}))/\ (~(v = v')) /\ (~(v = w')) /\ (~(w = v')) /\ (~(w = w')) *)ASM_MESON_TAC [SUBCASE46]]]]]];(*Small Cases*)(*{v,w} = {v',w'}*)ASM_CASES_TAC `{v:real^3,w:real^3} = {v':real^3,w':real^3}` THENL [ASM_MESON_TAC [SUBCASE47];(*v = v'*)ASM_CASES_TAC `(v:real^3 = v':real^3)` THENL [ASM_MESON_TAC [SUBCASE48];(*v = w*)ASM_CASES_TAC `(v:real^3 = w':real^3)` THENL [ASM_MESON_TAC [SUBCASE49];(* w = v'*)ASM_CASES_TAC `(w:real^3 = v':real^3)` THENL [ASM_MESON_TAC [SUBCASE50];(*(w = w')*)ASM_CASES_TAC `(w:real^3 = w':real^3)` THENL [ASM_MESON_TAC [SUBCASE51];(*(~({v, w} = {v', w'}))/\ (~(v = v')) /\ (~(v = w')) /\ (~(w = v')) /\ (~(w = w')) *)ASM_MESON_TAC [SUBCASE52]]]]]]]);;


let them8 = prove(`!(x:real^3)(S:real^3 -> bool) e1 e2.(e1 IN (sigma_set1 x S)) /\ (e2 IN (sigma_set1 x S)) ==> ((aff_ge {x} e1) INTER (aff_ge {x} e2)) = aff_ge {x} (e1 INTER e2)`,REPEAT GEN_TAC THEN REWRITE_TAC [sigma_set1;ESTD;V;UNION;IN_ELIM_THM] THEN STRIP_TAC THENL [ASM_MESON_TAC [cautruc11];ASM_MESON_TAC [cautruc10];REWRITE_TAC [INTER] THEN ASM_MESON_TAC [cautruc9];ASM_MESON_TAC [cautruc8]]);;

(*-------------------------------------------------*)
(*Cause ECNT SUBSET ESTD then ESTD is general*)
let  UBHDEUU  =prove(`!(x:real^3) (S:real^3 -> bool).(packing S) /\ (x IN S) ==>  new_fan (x, V x S, ESTD(V x S))`,REPEAT GEN_TAC THEN REWRITE_TAC [new_fan;fan11;fan21;fan41;fan51] THEN REPEAT STRIP_TAC THENL [REWRITE_TAC [GSYM eunion] THEN ASM_MESON_TAC [them5];REWRITE_TAC [graph] THEN GEN_TAC THEN STRIP_TAC THEN SUBGOAL_THEN `e IN ESTD (V x S)` ASSUME_TAC THENL[ ASM_MESON_TAC [IN];POP_ASSUM MP_TAC THEN ASM_MESON_TAC[them6]];ASM_MESON_TAC [them2];POP_ASSUM MP_TAC THEN REWRITE_TAC[] THEN ASM_MESON_TAC [them3];POP_ASSUM MP_TAC THEN REWRITE_TAC[] THEN ASM_MESON_TAC [them7];POP_ASSUM MP_TAC THEN POP_ASSUM MP_TAC THEN REWRITE_TAC [fan31] THEN REWRITE_TAC [GSYM sigma_set1] THEN ASM_MESON_TAC [them8]]);;

(*=-=================================================================================================*)

needs "hypermap.ml";;
(* triangle, quadrilateral, exceptional *)
let triangles = new_definition `triangles (H:(A)hypermap) (x:A)  
 <=> (CARD (face H x)) = 3`;;

let quadilaterals = new_definition `quadilaterals (H:(A)hypermap) (x:A)
 <=> (CARD (face H x)) = 4`;;

let exceptional_faces = new_definition `exceptional_faces (H:(A)hypermap)(x:A)
 <=> (CARD (face H x)) = 5`;;

(*Type of a node*)

let triangles_set = new_definition `triangles_set (H:(A)hypermap) (x:A) = 
{triangles H y  | y IN node H x}`;;

let quadilaterals_set = new_definition ` quadilaterals_set (H:(A)hypermap) (x:A) = 
{quadilaterals H y  | y IN node H x}`;;

let  exceptional_faces_set = new_definition `exceptional_faces_set (H:(A)hypermap) (x:A) = 
{exceptional_faces H y  | y IN node H x}`;;

let set_of_triangles_meeting_node = new_definition `set_of_triangles_meeting_node (H:(A)hypermap) (x:A) = {face H (y:A) | y IN dart H /\ CARD (face H y) = 3 /\ y IN node H x}`;;

let set_of_quadrilaterals_meeting_node = new_definition `set_of_quadrilaterals_meeting_node (H:(A)hypermap) (x:A) = {face H (y:A) | y IN dart H /\ CARD (face H y) = 4 /\ y IN node H x}`;;

let set_of_exceptional_meeting_node = new_definition `set_of_exceptional_meeting_node (H:(A)hypermap) (x:A) = {face H (y:A) | y IN dart H /\ CARD (face H y) >= 5 /\ y IN node H x}`;;

let p = new_definition `p (H:(A)hypermap) (x:A)
 = CARD (set_of_triangles_meeting_node H x)`;;


let q = new_definition `q (H:(A)hypermap)(x:A)
 = CARD (set_of_quadrilaterals_meeting_node H x)`;;

let r = new_definition `r (H:(A)hypermap) (x:A)
 = CARD (set_of_exceptional_meeting_node H x )`;;

let type_of_node = new_definition `type_of_node (H:(A)hypermap) (x:A) =  (p H x,q H x,r H x )`;;
(*let type_of_node = new_definition `type_of_node (H:(A)hypermap) (x:A) =  (CARD (set_of_triangles_meeting_node H x), CARD (set_of_quadrilaterals_meeting_node H x), CARD (set_of_exceptional_meeting_node H x ))`;;*)

let tgt = new_definition `tgt = #1.541`;;

(* Definition L --> the linear interpolation*)

let atn2 = new_definition `atn2(x,y) =
    if ( abs y < x ) then atn(y / x) else
    (if (&0 < y) then ((pi / &2) - atn(x / y)) else
    (if (y < &0) then (-- (pi/ &2) - atn (x / y)) else (  pi )))`;;

let ups_x = new_definition `ups_x x1 x2 x6 = 
    --x1*x1 - x2*x2 - x6*x6 
    + &2 *x1*x6 + &2 *x1*x2 + &2 *x2*x6`;;

let arclength = new_definition `arclength a b c  =
pi/(&2) + (atn2( (sqrt (ups_x (a*a) (b*b) (c*c))),(c*c - a*a  -b*b)))`;;

(*Definition faces of hypermap of cardinality at least 7*)  

let FF = new_definition `FF (H:(A)hypermap) (x:A)  
 <=> (CARD (face H x))>= 7`;;

 
let h1 = new_definition `h1 = {x|(&1 <= x) /\ (x <= h0)}`;;

let L = new_definition `L x = 
    if x = &1 then &1 else 
    (if x = h0 then &0 else
    (if (x < h0) then ((h0 - x)/ (h0 - (&1)))
  else 
     &0))`;;

let thm_arc = `!u w. (u IN (V x S)) /\ (w IN (edge H u))  ==>  
 let dux = dist (u,x) in
 let dwx = dist (w,x) in
 let duw = dist (u,w) in
  arclength dux dwx duw >= arclength dux dwx (&2)`;;

let thm_arc1 = `!u w.(u IN (V x S)) /\ (w IN (edge H u)) ==>
  let dux = dist (u,x) in
  let dwx = dist (w,x) in
  arclength dux dwx (&2) >= (&1) - ((#0.6076)*((dux/(&2)) - (&1))) - ((#0.6076)*((dwx/(&2)) - (&1)))`;;













