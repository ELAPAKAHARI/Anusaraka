(defglobal ?*lf-f* = lf)

(deftemplate score (slot anu_id (default 0))(slot man_id (default 0))(slot weightage_sum (default 0))(multislot heuristics (default 0))(multislot rule_names (default 0)))

(deftemplate alignment (slot anu_id (default 0))(slot man_id (default 0))(multislot anu_meaning (default 0))(multislot man_meaning(default 0)))

(deftemplate manual_word_info (slot head_id (default 0))(multislot word (default 0))(multislot word_components (default 0))(multislot root (default 0))(multislot root_components (default 0))(multislot vibakthi (default 0))(multislot vibakthi_components (default 0))(multislot group_ids (default 0)))

;------------------------------- verb related rules -----------------------------------------
;Eng: The time involved [varies] greatly according to climate, weather and crop.
;Man: jalavAyu, mOsama Ora Pasala ke anurUpa lAgawa samaya [baxalawA][rahawA hE].
(defrule combine_verb_using_dic_and_score
?f0<-(left_over_ids $?pre ?mid $?po)
(score (anu_id ?aid) (man_id ?mid) (heuristics $? dictionary $?))
?f1<-(alignment (anu_id ?aid) (man_id ?mid1) (anu_meaning $?mng) (man_meaning $?m1))
(chunk_name-chunk_ids-words VGNN ?mid - ?m)
(chunk_name-chunk_ids-words VGF =(+ ?mid 1) $?ids - $?m1)
(manual_word_info (head_id ?mid) (word ?m))
=>
	(retract ?f0 ?f1)
	(assert (alignment (anu_id ?aid) (man_id ?mid) (anu_meaning $?mng) (man_meaning ?m $?m1)))
	(assert (left_over_ids $?pre $?po))
)
;----------------------------------------------------------------------------------------------
; wA/wI hE 
;A direct line from the Prayag Station of Allahabad also goes to Banaras Cantonment through Kashi.
;ilAhAbAxa ke prayAga steSana se BI eka sIXI lAina kASI howe hue banArasa CAvanI waka [jAwI] [hE] .
;One can go to the Cantonment through Banaras City with this route too.
;isa rAswe se BI banArasa sitI howe hue CAvanI jA [sakawe] [hEM] .
(defrule group_WA_hEM
?f1<-(alignment (anu_id ?aid) (man_id ?mid) (anu_meaning $?m) (man_meaning ?m1))
(manual_word_info (head_id ?id&:(=(+ ?mid 1) ?id)) (word ?m2&hE|hEM))
(test (or (eq (sub-string (- (length ?m1) 1) (length ?m1) ?m1  ) "wI") (eq (sub-string (- (length ?m1) 1) (length ?m1) ?m1  ) "we")))
?f0<-(left_over_ids $?pre ?id $?po)
=>
        (retract ?f0 ?f1)
        (assert (left_over_ids $?pre $?po))
        (assert (alignment (anu_id ?aid)  (man_id ?mid) (anu_meaning $?m) (man_meaning ?m1 ?m2)))
)
;----------------------------------------------------------------------------------------------
;if noun is aligned in verb slot then combine the next word if it is the only left over word
;Amidst all this the guide began to [track] tiger.
;isa bIca gAida ne tAigara ko [trEka] [karanA] SurU kara xiyA .
(defrule group_next_word
?f<-(left_over_ids ?id)
?f0<-(alignment (anu_id ?aid) (man_id =(- ?id 1)) (anu_meaning $?amng) (man_meaning ?mng))
(id-cat_coarse ?aid verb)
(chunk_name-chunk_ids NP =(- ?id 1)) 
(manual_word_info (head_id ?id) (word $?mng1))
=>
	(retract ?f ?f0)
	(assert (alignment (anu_id ?aid) (man_id ?id ) (anu_meaning $?amng) (man_meaning ?mng $?mng1)))
)
;----------------------------------------------------------------------------------------------
;The first model of atom was proposed by J. J. Thomson in 1898.
;[san][1898 meM] je. je. toYmasana ne paramANu kA pahalA moYdala praswAviwa kiyA .
(defrule group_prev_word_for_no
?f<-(alignment (anu_id ?id) (man_id ?mid) (anu_meaning ?no meM) (man_meaning ?no meM))
(id-cat_coarse ?id number)
?f1<-(manual_word_info (head_id ?mid1&:(=(- ?mid 1) ?mid1)) (word san))
?f0<-(left_over_ids $?p ?mid1 $?p0)
=>
	(retract ?f ?f0 ?f1)
	(assert (alignment (anu_id ?id) (man_id ?mid) (anu_meaning ?no meM) (man_meaning san ?no meM))	)
	(assert (left_over_ids $?p $?p0))
)

;----------------------- to get leftover_anu_ids ----------------------------------------
(defrule get_left_anu_ids
(declare (salience -7))
?f<-(hindi_id_order $?pre ?id $?po)
(alignment (anu_id ?id) )
=>
	(retract ?f)
	(assert (hindi_id_order $?pre $?po))
)

(defrule rm_det_ids
(declare (salience -8))
?f<-(hindi_id_order $?pre ?id $?po)
(id-cat_coarse ?id determiner)
=>
        (retract ?f)
        (assert (hindi_id_order $?pre $?po))
)

;Therefore, an atom must also contain some [positive charge] to neutralise the negative charge of the electrons.
;man: isalie, ilektroYna ke qNa AveSa ko niRpraBAviwa karane ke lie paramANu meM [XanAwmaka AveSa] BI avaSya honA cAhie.
;anu: isalie, paramANu ko ilektroYna kA qNAwmaka AveSa niRpraBAviwa karanA kuCa [XanAwmaka AveSa] BI honA cAhie.
(defrule rm_comp_ids
(declare (salience -8))
?f<-(hindi_id_order $?pre ?id $?po)
(alignment (anu_id ?id1) (man_id ?) (anu_meaning $?mng) (man_meaning $?mng))
(ids-cmp_mng-head-cat-mng_typ-priority $?ids ? ? ? ? ?)
(test (eq (integerp (member$ ?id $?ids)) TRUE))
(test (eq (integerp (member$ ?id1 $?ids)) TRUE))
=>
        (retract ?f)
        (assert (hindi_id_order $?pre $?po))
)
;--------------------------align single_anu_id single_man_id-----------------------------
(defrule align_single_id
(declare (salience -9))
?f<-(left_over_ids ?id)
?f1<-(hindi_id_order ?aid)
(id-Apertium_output ?aid $?amng)
(manual_word_info (head_id ?id) (word $?mng))
(not (msg_printed))
=>
	(retract ?f ?f1)
	(assert (alignment (anu_id ?aid) (man_id ?id ) (anu_meaning $?amng) (man_meaning $?mng)))
	(printout t "single alignment" crlf)
)

;------------------------------ conjunction rules ---------------------------------------
;(defrule modify_using_man_scope
;(declare (salience 10))
;?f0<-(alignment (anu_id ?aid) (man_id ?mid) (anu_meaning $?amng) (man_meaning $?man_mng))
;(score (anu_id ?aid) (man_id ?mid))
;(manual_word_info (head_id ?mid1) (group_ids $?ids =(- ?mid 1)))
;(alignment (anu_id ?aid1) (man_id ?mid1) )
;(test (neq ?aid1 =(- ?aid 1)))
;?f2<-(score (anu_id ?aid2) (man_id ?mid)) 
;?f1<-(alignment (anu_id ?aid2) (man_id ?mid2) (anu_meaning $?amng1) (man_meaning $?man_mng1))
;(test (neq ?aid2 ?aid))
;=>
;	(retract ?f0 ?f1 ?f2)
;	(assert (alignment (anu_id ?aid) (man_id ?mid2) (anu_meaning $?amng1) (man_meaning $?man_mng1)))
;	(assert (alignment (anu_id ?aid2) (man_id ?mid) (anu_meaning $?amng) (man_meaning $?man_mng)))
;)

;(defrule get_left_over_conj_comp
;(alignment (anu_id ?aid) (man_id ?mid) (anu_meaning $?) (man_meaning Ora|yA))
;(alignment (anu_id ?aid1&:(=(- ?aid 1) ?aid1)) (man_id ?mid1&:(=(- ?mid 1) ?mid1)) (anu_meaning $?) (man_meaning $?))
;?f0<-(left_over_ids $?pre ?id&:(=(+ ?mid 1) ?id) $?po)
;(manual_word_info (head_id ?id) (word $?man_mng))
;(id-Apertium_output ?id1&:(=(+ ?aid 1) ?id1) $?amng)
;=>
;	(retract ?f0)
;	(assert (left_over_ids $?pre $?po))
;	(assert (alignment (anu_id ?id1)  (man_id ?id) (anu_meaning $?amng) (man_meaning $?man_mng)))
;)
;----------------------------------------------------------------------------------------------------

;================== to print left over info in html ====================

(defrule print_info
(declare (salience -10))
(left_over_ids ?id $?)
(not (msg_printed))
=>
       (printout ?*lf-f* "Nth layer Un-assigned words:  " )
       (assert (msg_printed))
)

(defrule print_single_left_over_wrd
(declare (salience -11))
?f0<-(left_over_ids ?id)
(manual_word_info (head_id ?id) (word $?mng))
=>
	(retract ?f0)
	(printout ?*lf-f* (wx_utf8 (implode$ (create$ $?mng))) crlf)
)

(defrule print_left_over_wrd
(declare (salience -11))
?f0<-(left_over_ids ?id $?po ?lid)
(manual_word_info (head_id ?id) (word $?mng))
;(manual_word_info (head_id ?id) (word ?mng))
=>
        (retract ?f0)
	(assert (left_over_ids $?po ?lid))
	(bind ?m (string-to-field (str-cat (wx_utf8 (implode$ (create$ $?mng))) ",") ))
; 	(bind ?m (string-to-field (str-cat (wx_utf8 ?mng) ",")))
        (printout ?*lf-f* ?m " ")
)

