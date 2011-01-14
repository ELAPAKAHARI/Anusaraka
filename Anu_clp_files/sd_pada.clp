 (defglobal ?*vachan_file* = vachan_fp)
 (defglobal ?*agmt_cntrl_file* = agmt_cntrl_fp)
 (defglobal ?*pada_cntrl_file* = pada_cntrl_fp)
 (defglobal ?*dbug* = pada_debug_fp)
 (defglobal ?*errfp* = err_file)

 (defrule end
 (declare (salience -100))
 =>
	(close ?*vachan_file*)
	(close ?*agmt_cntrl_file*)
	(close ?*pada_cntrl_file*)
	(close ?*dbug*)
        (close ?*errfp*)
 )  
 ;--------------------------------------------------------------------------------------------------------------------- 

 (deffunction print_in_ctrl_fact_files (?paxa_head)
	(printout	?*vachan_file*	"(vachan_to_be_decided	"	?paxa_head	")"	crlf)	
	(printout	?*agmt_cntrl_file*	"(agmt_control_fact	"	?paxa_head	")"	crlf)	
	(printout	?*pada_cntrl_file*	"(pada_control_fact	"	?paxa_head	")"	crlf)	
 )
 ;---------------------------------------------------------------------------------------------------------------------
 (deftemplate pada_info (slot group_head_id (default 0))(slot group_cat (default 0))(multislot group_ids (default 0))(slot vibakthi (default 0))(slot gender (default 0))(slot number (default 0))(slot case (default 0))(slot person (default 0))(slot H_tam (default 0))(slot tam_source (default 0))(slot preceeding_part_of_verb (default 0)) (slot preposition (default 0))(slot Hin_position (default 0)))
 ;---------------------------------------------------------------------------------------------------------------------
 (defrule pada_count
 (declare (salience 10000))
 (to_be_included_in_paxa 1)
 =>
 (assert (count 0))
 )
 ;---------------------------------------------------------------------------------------------------------------------
  (defrule retract_cntrl_fact
  (declare (salience 2000))
  (has_been_included_in_paxa ?id)
  ?f<-(to_be_included_in_paxa ?id)
  =>
  (retract ?f)
  )
 ;--------------------------------------------------------------------------------------------------------------------- 
 (defrule kriyA_pada
 (declare (salience 1002))
 (root-verbchunk-tam-chunkids ? ? ? $?ids ?kri)
 ?f<-(to_be_included_in_paxa ?kri)
  =>
 (retract ?f)
 (assert (pada_info (group_head_id ?kri) (group_cat VP) (group_ids $?ids ?kri)))
 (printout       ?*dbug* "(Rule_name-pada_head_id-pada_type-ids  kriyA_pada     P"?kri   "	PP	"?kri")"crlf)
 (bind ?len (length $?ids))
 (loop-for-count (?i 1 ?len)
                  (bind ?j (nth$ ?i $?ids))
                  (assert (has_been_included_in_paxa ?j))
 )
 (print_in_ctrl_fact_files ?kri)
 )
 ;---------------------------------------------------------------------------------------------------------------------
 (defrule to-infinitive_pada
 (declare (salience 1002))
 (using-parser-ids to-infinitive  ?to ?inf)
 ?f<-(to_be_included_in_paxa ?inf)
 ?f1<-(to_be_included_in_paxa ?to) ;Added by Manju
 =>
 (retract ?f ?f1)
 (assert (pada_info (group_head_id ?inf) (group_cat infinitive) (group_ids  ?to ?inf)))
 (printout       ?*dbug* "(Rule_name-pada_head_id-pada_type-ids  to-infinitive_pada     P"?inf   "	PP	" ?to" "?inf ")"crlf)
 (print_in_ctrl_fact_files ?inf)
 )
 ;---------------------------------------------------------------------------------------------------------------------
 ;Added by Shirisha Manju
 (defrule conj_pada_and_or
 (declare (salience 1001))
 (rel_name-ids	conj  ?id  ?id1)
 (rel_name-ids	cc  ?id ?and)
 ?f<-(to_be_included_in_paxa ?id)
 ?f1<-(to_be_included_in_paxa ?id1)
 ?f2<-(to_be_included_in_paxa ?and)
 (id-word ?and and|or)
 =>
	(retract ?f ?f1 ?f2)
	(assert (pada_info (group_head_id ?and) (group_cat PP) (group_ids  ?id ?and ?id1)))
	(printout       ?*dbug* "(Rule_name-pada_head_id-pada_type-ids  conj_pada_and_or    P"?and   "      PP      " ?id" "?and" "?id1 ")"crlf)
	(print_in_ctrl_fact_files ?and)
 )
 ;Bill is big and honest .  There are three boys and four girls in the park .
 ;---------------------------------------------------------------------------------------------------------------------
 (defrule PP_pada
 (declare (salience 1000))
 (using-parser-ids  ?rel  ?kri ?PP)
 (test (or (eq ?rel kriyA-subject)(eq ?rel kriyA-object)(eq ?rel saMjFA-saMjFA_samAnAXikaraNa)(eq ?rel subject-subject_samAnAXikaraNa)(eq ?rel kriyA-kriyA_viSeRaNa)(eq ?rel kriyA-upasarga)(eq ?rel to-infinitive)(eq ?rel kriyA-dummy_subject))) 
 ?f<-(to_be_included_in_paxa ?PP)
  => 
 (retract ?f)
 (assert (pada_info (group_head_id ?PP) (group_cat PP) (group_ids  ?PP)))
 (printout       ?*dbug* "(Rule_name-pada_head_id-pada_type-ids  PP_pada     P"?PP   "	PP	" ?PP")"crlf)
 (print_in_ctrl_fact_files ?PP)
 )
 ;---------------------------------------------------------------------------------------------------------------------
 (defrule PP_pada1
 (declare (salience 1000))
 (using-parser-ids  ?rel  ?kri ?PP)
 (test (neq (str-index "-" ?rel)  FALSE))
 (test (neq (str-index "_" ?rel)  FALSE))
 (test (eq (sub-string 1 (- (str-index "-" ?rel) 1) ?rel) "kriyA"))
 (test (eq (sub-string (+ (+ (str-index "-" ?rel) 1) (- (str-index "_" ?rel)  (str-index "-" ?rel))) (length ?rel) ?rel) "saMbanXI"))
 ?f<-(to_be_included_in_paxa ?PP)
  =>
 (retract ?f)
 (assert (pada_info (group_head_id ?PP) (group_cat PP) (group_ids  ?PP)(preposition 0)))
 (printout       ?*dbug* "(Rule_name-pada_head_id-pada_type-ids  PP_pada1     P"?PP   "	PP	" ?PP")"crlf)
 (print_in_ctrl_fact_files ?PP)
 )
 ;---------------------------------------------------------------------------------------------------------------------
 (defrule PP_pada2
 (declare (salience 1000))
 (using-parser-ids  ?rel  ?PP ?)
 (test (eq ?rel kriyA-kqxanwa_viSeRaNa))
 ?f<-(to_be_included_in_paxa ?PP)
  =>
 (retract ?f)
 (assert (pada_info (group_head_id ?PP) (group_cat PP) (group_ids  ?PP)))
 (printout       ?*dbug* "(Rule_name-pada_head_id-pada_type-ids  PP_pada2     P"?PP   "	PP	" ?PP")"crlf)
 (print_in_ctrl_fact_files ?PP)
 )
 ;---------------------------------------------------------------------------------------------------------------------
 (defrule viSeRaNa_pada
 (declare (salience 990))
 (using-parser-ids  ?rel ?viSeRya ?viSeRaNa)
 (test (or (eq ?rel viSeRya-det_viSeRaNa)(eq ?rel viSeRya-viSeRaNa)(eq ?rel samAsa)(eq ?rel kriyA-kqxanwa_viSeRaNa)(eq ?rel viSeRya-saMKyA_viSeRaNa)(eq ?rel viSeRaNa-viSeRaka)))
 ?f<-(to_be_included_in_paxa ?viSeRaNa)
 ?f1<-(pada_info (group_ids  $?id ?viSeRya $?ids)(group_cat PP|infinitive))
   =>
 (retract ?f)
 (bind $?grp_ids (sort > (create$ $?id ?viSeRya $?ids ?viSeRaNa)))
 (modify ?f1 (group_ids $?grp_ids))
 )
 ;Ex : We have very different ideas about disciplining children .
 ;Modified by Shirisha Manju : 
                  ; added viSeRaNa-viSeRaka relation and 
                  ; removed (group_head_id  ?viSeRya) and modified (group_ids $?grp_ids) as (group_ids  $?id ?viSeRya $?ids)
 ;---------------------------------------------------------------------------------------------------------------------
 (defrule RaRTI_viSeRaNa
 (declare (salience 1000))
 (using-parser-ids  viSeRya-RaRTI_viSeRaNa ?viSeRya ?viSeRaNa)
 ?f<-(to_be_included_in_paxa ?viSeRaNa)
 =>
 (retract ?f)
 (assert (pada_info (group_head_id ?viSeRaNa) (group_cat PP) (group_ids  ?viSeRaNa)(vibakthi kA)))
 (printout       ?*dbug* "(Rule_name-pada_head_id-pada_type-ids  RaRTI_viSeRaNa      P"?viSeRaNa   "	PP	" ?viSeRaNa")"crlf)
 (print_in_ctrl_fact_files ?viSeRaNa)
 )
 ;---------------------------------------------------------------------------------------------------------------------
 (defrule add_prep
 (declare (salience 900))
 (rel_name-ids prep ?kriyA ?prep)
 (rel_name-ids pobj|pcomp  ?prep ?prep_saM)
 ?f1<-(pada_info (group_head_id ?prep_saM)(preposition 0))
 ?f<-(to_be_included_in_paxa ?prep)
 =>
  (retract ?f)
  (modify ?f1 (preposition ?prep)))
 ;---------------------------------------------------------------------------------------------------------------------
 ;Ex. Where did they come from? Who did you talk to?
 (defrule stranded_prep
 (declare (salience 900))
 (rel_name-ids advmod ?kriyA ?head)
 (rel_name-ids prep ?kriyA ?prep)
 ?f1<-(pada_info (group_head_id ?head)(preposition 0))
 ?f<-(to_be_included_in_paxa ?prep)
 (not (id-word ?head always)) ;Ex: He is always looking at himself in the mirror .
 =>
  (retract ?f)
  (modify ?f1 (preposition ?prep))
 )
 ;---------------------------------------------------------------------------------------------------------------------
;Ex. From where did they come?
; (defrule stranded_prep1
; (declare (salience 1000))
; (rel_name-ids advmod ?head1 ?prep1)
; ?f<-(to_be_included_in_paxa ?head1)
; ?f1<-(to_be_included_in_paxa ?prep1)
; (id-word ?prep1 aboard|about|above|across|after|against|along|alongside|amid|amidst|among|amongst|around|as|aside|astride|at|athwart|atop|barring|before|behind|below|beneath|beside|besides|between|beyond|but|by|circa|concerning|despite|down|during|except|excluding|failing|following|for|from|given|in|including|inside|into|like|mid|minus|near|next|notwithstanding|of|off|on|onto|opposite|out|outside|over|pace|past|per|plus|qua|regarding|round|save|since|than|through|throughout|till|times|to|toward|towards|under|underneath|unlike|until|up|upon|versus|via|with|within|without|worth)
;  =>
; (retract ?f ?f1)
; (assert (pada_info (group_head_id ?head1) (group_cat PP) (group_ids  ?head1) (preposition ?prep1)))
 ;(printout       ?*dbug* "(Rule_name-pada_head_id-pada_type-ids  stranded_prep1      P"?head1    "       PP      "?head1" "?prep1")"crlf)
; (print_in_ctrl_fact_files ?head1)
; )
;---------------------------------------------------------------------------------------------------------------------
 (defrule default_pada
 ?f<-(to_be_included_in_paxa ?PP)
  =>
 (retract ?f)
 (assert (pada_info (group_head_id ?PP) (group_cat PP) (group_ids  ?PP)))
 (printout       ?*dbug* "(Rule_name-pada_head_id-pada_type-ids   default_pada	p"?PP	"	PP	" ?PP")"crlf)
 (print_in_ctrl_fact_files ?PP)
 )
 ;---------------------------------------------------------------------------------------------------------------------

