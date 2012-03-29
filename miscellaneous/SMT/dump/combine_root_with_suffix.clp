;(defrule get_aper_fmt
;(declare (salience 10))
;(id-node-root-cat-gen-num-per-case-tam ?id ?node ?root ?cat ?gen ?no ?p ?c ?tam)
;(test (or (eq ?node VGF)(eq ?node VGNN)))
;?f0<-(position-cat-man_grp_mng	?id  ?node $?grp_mng ?punc - -)
;(test (neq (str-index "_" ?tam) FALSE))
;=>
;	(if (eq ?no sg) then (bind ?no s)
;	else (if (eq ?no pl) then (bind ?no p))
;	)
;	(if (eq ?p 1) then (bind ?p u)
;	else 	(if (eq ?p 2) then (bind ?p m)
;	 	else	(if (or (eq ?p 3)(eq ?p any)) then (bind ?p a))
;		)
;	)	
;        (bind ?tam (str-cat ?tam","?gen","?no","?p))
; 	(bind ?mng (string-to-field (gdbm_lookup "AllTam.gdbm" ?tam)))
;	(retract ?f0)
;	(if (eq ?punc .) then
;	(assert (position-cat-man_grp_mng   ?id  VGF $?grp_mng ?punc - $?grp_mng ?mng ?punc))
;	else
;	(assert (position-cat-man_grp_mng   ?id  VGF $?grp_mng ?punc - $?grp_mng ?punc ?mng))
;	)
;)
;
;;Mandi is comparatively hotter than other hill stations of himachal pradesh.
;(defrule get_aper_fmt1
;(declare (salience 10))
;(id-node-root-cat-gen-num-per-case-tam ?id ?node&VGF|VGNN ?root ?cat ?gen ?no ?p ?c ?tam)
;?f0<-(position-cat-man_grp_mng  ?id  ?node $?grp_mng ?punc - -)
;=>
;        (if (eq ?no sg) then (bind ?no s)
;        else (if (eq ?no pl) then (bind ?no p))
;        )
;        (if (eq ?p 1) then (bind ?p u)
;        else    (if (eq ?p 2) then (bind ?p m)
;                else    (if (or (eq ?p 3)(eq ?p any)) then (bind ?p a))
;                )
;        )
;        (bind ?tam (str-cat ?tam","?gen","?no","?p))
;        (bind ?mng (string-to-field (gdbm_lookup "AllTam.gdbm" ?tam)))
;        (retract ?f0)
;	(if (eq ?punc .) then
;	        (assert (position-cat-man_grp_mng   ?id  VGF $?grp_mng ?punc - $?grp_mng ?mng ?punc))
;	else
;		(assert (position-cat-man_grp_mng   ?id  VGF $?grp_mng ?punc - $?grp_mng ?punc ?mng));
;	)
;;        (assert (position-cat-man_grp_mng   ?id  VGF $?grp_mng - ?head ?mng))
;)

;imArawa n f pl 3 o 0_kA)
(defrule get_NP_mng
(id-node-root-cat-gen-num-per-case-tam ?id ?node ?root ?cat ?g ?n ?p ?c ?vib&~0&~-)
?f0<-(position-cat-man_grp_mng  ?id  ?node $?grp_mng - -)
(test (neq (str-index "_" ?vib) FALSE))
=>
        (retract ?f0)
        (bind ?v (string-to-field (sub-string (+ (str-index "_" ?vib) 1) (length ?vib) ?vib)))
        (assert (position-cat-man_grp_mng  ?id  ?node $?grp_mng - $?grp_mng ?v) )
)

;Apa pn f sg any d kA)
(defrule get_NP_mng1
(id-node-root-cat-gen-num-per-case-tam ?id ?node ?root ?cat ?g ?n ?p ?c ?vib&~0&~-)
?f0<-(position-cat-man_grp_mng  ?id  ?node $?grp_mng - -)
=>
        (retract ?f0)
        (assert (position-cat-man_grp_mng  ?id  ?node $?grp_mng - $?grp_mng ?vib) )
)



(defrule default_rule
(declare (salience -10))
?f0<-(position-cat-man_grp_mng  ?id  ?node $?grp_mng - 0|-|any)
=>
	(retract ?f0)
        (assert (position-cat-man_grp_mng   ?id  ?node $?grp_mng - $?grp_mng))
)

