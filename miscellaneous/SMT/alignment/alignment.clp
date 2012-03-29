;(deffunction get_tam_info ($?post)
;;	(printout t ?word " ===== "?tam "======="?post crlf)
;	(bind ?count 2)
;;	(bind ?index (str-index "_" ?tam))
; ;       (while (neq ?index FALSE)
;  ;              (bind ?count (+ ?count 1))
;   ;             (bind ?tam (sub-string (+ ?index 1) 1000 ?tam))
;    ;            (bind ?index (str-index "_" ?tam))
;     ;   )
;;	(printout t ?count "--------" crlf)
;        (loop-for-count (?i 1 ?count )
;                        (bind ?j (nth$ 1 $?post))
;                     ;   (bind $?word (create$ $?word ?j))
;                       (bind $?post (delete-member$ $?post ?j))
;			
;        )
;	(printout t  " ------" $?post crlf)
;)



;The area has got the digamber jain temple which houses the birds hospital.
(defrule modify_wrd_mng_for_VP
(declare (salience 150))
?f0<-(manual_id-node-word-root-tam ?id ?n&VGF|VGNN $?word - kara - ?tam)
(manual_hin_sen $?pre ?w $?word $?post)
?f1<-(manual_id-node-word-root-tam ? ? ?w - ? - ?)
(not (modified_word_id ?id))
=>
	(retract ?f0 ?f1)
	(assert (manual_id-node-word-root-tam ?id ?n ?w $?word - kara - ?tam))
	(assert (modified_word_id ?id))
)

(defrule same_grp_mng
(declare (salience 110))
?f<-(manual_id-node-word-root-tam ?m_id ? $?grp_mng - ? - ?)
?f1<-(anu_id-node-word-root-tam ?a_id ? $?grp_mng - ? - ?)
?f0<-(manual_hin_sen $?pre $?grp_mng $?post)
=>
        (retract ?f0 ?f ?f1)
        (assert (anu_id-manual_id-anu_grp_mng-man_grp_mng  ?a_id ?m_id $?grp_mng - $?grp_mng))
        (assert (manual_hin_sen $?pre $?post))
)



(defrule vb_exact_mng
(declare (salience 100))
?f<-(manual_id-node-word-root-tam ?m_id ?n&VGF|VGNN $?w - ?root - ?tam)
?f1<-(anu_id-node-word-root-tam  ?a_id VP $?w1 - ?root - ?tam)
?f0<-(manual_hin_sen $?pre $?w $?post)
=>
	(retract ?f0 ?f ?f1)
        (bind ?count 0)
	(bind ?tam (implode$ (create$ ?tam)))
        (bind ?index (str-index "_" ?tam))
        (while (neq ?index FALSE) 
                (bind ?count (+ ?count 1))
                (bind ?tam (sub-string (+ ?index 1) 1000 ?tam))
                (bind ?index (str-index "_" ?tam))
        )
        (loop-for-count (?i 1 (- ?count 1))
                       (bind $?post (delete-member$ $?post ?i)) 
        )
	(assert (anu_id-manual_id-anu_grp_mng-man_grp_mng ?a_id ?m_id $?w1 - $?w))
        (assert (manual_hin_sen $?pre $?post))

) 


(defrule vb_with_same_tam
(declare (salience 90))
?f<-(manual_id-node-word-root-tam ?m_id ?n&VGF|VGNN $?word - ?root - ?tam)
?f1<-(anu_id-node-word-root-tam  ?a_id VP $?w1 - ?root1 - ?tam)
?f0<-(manual_hin_sen $?pre $?word $?post)
=>
	(retract ?f0 ?f ?f1)
        (bind ?count 0) 
        (bind ?tam (implode$ (create$ ?tam)))
        (bind ?index (str-index "_" ?tam))
        (while (neq ?index FALSE) 
                (bind ?count (+ ?count 1))
                (bind ?tam (sub-string (+ ?index 1) 1000 ?tam))
                (bind ?index (str-index "_" ?tam))
        )
        (loop-for-count (?i 1 ?count )
			(bind ?j (nth$ 1 $?post))
			(bind $?word (create$ $?word ?j))
                       (bind $?post (delete-member$ $?post ?j))         
        )
        (assert (anu_id-manual_id-anu_grp_mng-man_grp_mng ?a_id ?m_id $?w1 - $?word ))
        (assert (manual_hin_sen $?pre $?post))
)

(defrule vb_with_same_root
(declare (salience 90))
?f<-(manual_id-node-word-root-tam ?m_id ?n&VGF|VGNN $?word - ?root - ?tam)
?f1<-(anu_id-node-word-root-tam  ?a_id VP $?w1 - ?root - ?tam1)
?f0<-(manual_hin_sen $?pre $?word $?post)
=>
	(retract ?f0 ?f ?f1)
        (bind ?count 0)
	(bind ?tam (implode$ (create$ ?tam)))
        (bind ?index (str-index "_" ?tam))
        (while (neq ?index FALSE)
                (bind ?count (+ ?count 1))
                (bind ?tam (sub-string (+ ?index 1) 1000 ?tam))
                (bind ?index (str-index "_" ?tam))
	)
        (loop-for-count (?i 1 ?count )
                        (bind ?j (nth$ 1 $?post))
                        (bind $?word (create$ $?word ?j))
                       (bind $?post (delete-member$ $?post ?j))
        )
        (assert (anu_id-manual_id-anu_grp_mng-man_grp_mng ?a_id ?m_id $?w1 - $?word))
        (assert (manual_hin_sen $?pre $?post))
) 

;Young children are taken to the temples and are introduced to the letters of the alphabet in front of saraswati, the goddess of wisdom and learning.
(defrule np_with_same_head
(declare (salience 80))
?f<-(manual_id-node-word-root-tam ?m_id ?n $?word - ?head - ?tam)
?f1<-(anu_id-node-word-root-tam  ?a_id ? $?w1 - ?head - ?tam1)
?f0<-(manual_hin_sen $?pre $?word $?post)
=>
        (retract ?f0 ?f ?f1)
 	(bind ?count 0)
	(bind ?tam (implode$ (create$ ?tam)))
        (bind ?index (str-index "_" ?tam))
        (while (neq ?index FALSE)
                (bind ?count (+ ?count 1))
                (bind ?tam (sub-string (+ ?index 1) 1000 ?tam))
                (bind ?index (str-index "_" ?tam))
        )
        (loop-for-count (?i 1 ?count )
                        (bind ?j (nth$ 1 $?post))
                        (bind $?word (create$ $?word ?j))
                       (bind $?post (delete-member$ $?post ?j))
        )
        (assert (anu_id-manual_id-anu_grp_mng-man_grp_mng ?a_id ?m_id $?w1 - $?word))
        (assert (manual_hin_sen $?pre $?post))
)

(defrule np_with_some_same_mng
(declare (salience 60))
?f<-(manual_id-node-word-root-tam ?m_id ?n&~VGF&~VGNN $?m ?wrd $?m1 - ?head - ?tam)
?f1<-(anu_id-node-word-root-tam  ?a_id ?n1&~VP $?a ?wrd $?a1 - ?head1 - ?tam1)
?f0<-(manual_hin_sen $?pre $?m ?wrd $?m1 $?post)
=>
	(retract ?f0 ?f ?f1)
	(bind $?word (create$ $?m ?wrd $?m1))
        (bind ?count 0)
        (bind ?tam (implode$ (create$ ?tam)))
        (bind ?index (str-index "_" ?tam))
        (while (neq ?index FALSE)
                (bind ?count (+ ?count 1))
                (bind ?tam (sub-string (+ ?index 1) 1000 ?tam))
                (bind ?index (str-index "_" ?tam))
        )
        (loop-for-count (?i 1 ?count )
                        (bind ?j (nth$ 1 $?post))
                        (bind $?word (create$ $?word ?j))
                       (bind $?post (delete-member$ $?post ?j))
        )
        (assert (anu_id-manual_id-anu_grp_mng-man_grp_mng ?a_id ?m_id $?a ?wrd $?a1 - $?word))
        (assert (manual_hin_sen $?pre $?post))
)

