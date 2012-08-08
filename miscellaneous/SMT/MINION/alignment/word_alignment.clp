(deftemplate pada_info (slot group_head_id (default 0))(slot group_cat (default 0))(multislot group_ids (default 0))(slot vibakthi (default 0))(slot gender (default 0))(slot number (default 0))(slot case (default 0))(slot person (default 0))(slot H_tam (default 0))(slot tam_source (default 0))(slot preceeding_part_of_verb (default 0)) (multislot preposition (default 0))(slot Hin_position (default 0))(slot pada_head (default 0)))

(deffunction assert_control_fact(?fact_name $?ids)
                (loop-for-count (?i 1 (length $?ids))
                                (bind ?j (nth$ ?i $?ids))
                                (if (eq ?fact_name mng_has_been_aligned) then
	                                (assert (mng_has_been_aligned ?j))
                                else (if (eq ?fact_name mng_has_been_filled) then
        	                        (assert (mng_has_been_filled ?j))
                                else (if (eq ?fact_name rm_aligned_fact) then
                	                (assert (rm_aligned_fact ?j))
                                else (if (eq ?fact_name rm_filled_fact) then
                        	        (assert (rm_filled_fact ?j)))))
                                )
                 )
)
(deffunction remove_character(?char ?str ?replace_char)
                        (bind ?new_str "")
                        (bind ?index (str-index ?char ?str))
                        (if (neq ?index FALSE) then
                        (while (neq ?index FALSE)
                        (bind ?new_str (str-cat ?new_str (sub-string 1 (- ?index 1) ?str) ?replace_char))
                        (bind ?str (sub-string (+ ?index 1) (length ?str) ?str))
                        (bind ?index (str-index ?char ?str))
                        )
                        )
                (bind ?new_str (explode$ (str-cat ?new_str (sub-string 1 (length ?str) ?str))))
)
;-------------------------------------------------------------------------------------
;Counts the number of verbs of anusaaraka sentence
(defrule verb_count_of_anu
(declare (salience 1001))
(pada_info (group_cat VP)(group_head_id  ?vid))
?f<-(anu_verb_count-verbs ?anu_verb_count $?verbs) 
(test (eq (member$ ?vid $?verbs) FALSE))
=>
	(retract ?f)
	(bind ?anu_verb_count (+ ?anu_verb_count 1))
        (bind $?verbs (create$ $?verbs ?vid))
	(assert (anu_verb_count-verbs ?anu_verb_count $?verbs))
)

;-------------------------------------------------------------------------------------
;Counts the number of verbs of manual sentence
(defrule verb_count_of_manual
(declare (salience 1001))
(manual_id-node-word-root-tam  ?vid   VGF $?)
?f<-(man_verb_count-verbs ?man_verb_count $?verbs)
(head_id-grp_ids ?vid ?mid $?)
(test (eq (member$ ?mid $?verbs) FALSE))
=>
	(retract ?f)
        (bind ?man_verb_count (+ ?man_verb_count 1))
        (bind $?verbs (create$ $?verbs ?mid))
        (assert (man_verb_count-verbs ?man_verb_count $?verbs))
)
;-------------------------------------------------------------------------------------
(defglobal ?*count* = 0)

(defrule get_current_word
(manual_id-cat-word-root-vib-grp_ids ?mid $?)
(not (manual_id-cat-word-root-vib-grp_ids ?mid1&:(< ?mid1 ?mid) $?))
=>
        (assert (current_id ?mid))
        (bind ?*count* 0)
        (assert (count_fact 0))
)

(defrule update_count_fact
(declare (salience 903))
(current_id ?mid)
?f<-(count_fact ?count)
?f1<-(update_count_fact ?new_count)
=>
	(retract ?f ?f1)
        (assert (count_fact ?new_count))
)

;-------------------------------------------------------------------------------------
(defrule exact_match_using_multi_word_dic
(declare (salience 902))
(current_id ?mid)
(multi_word_expression-dbase_name-mng $?e_words ? $?mng)
(multi_word_expression-grp_ids $?e_words $?aids)
(manual_id-node-word-root-tam ?h_mid ? $?mng - $? - $?)
(head_id-grp_ids ?h_mid ?mid $?grp)
(not (prov_assignment ?aid ?mid))
=>
	(bind ?*count* (+ ?*count* 1))
        (assert (update_count_fact ?*count*))
        (assert (anu_ids-sep-manual_ids $?aids - ?mid $?grp))
        (assert (prov_assignment (nth$ (length $?aids) $?aids) ?mid))
)

(defrule exact_match_using_multi_word_dic2
(declare (salience 902))
(current_id ?mid)
(multi_word_expression-dbase_name-mng $?e_words ? $?mng)
(multi_word_expression-grp_ids $?e_words $?aids)
(manual_id-cat-word-root-vib-grp_ids ?mid ? $?mng - $? - $? - $?)
(not (prov_assignment ?aid ?mid))
=>
        (bind ?*count* (+ ?*count* 1))
        (assert (update_count_fact ?*count*))
        (assert (anu_ids-sep-manual_ids $?aids - ?mid))
        (assert (prov_assignment (nth$ (length $?aids) $?aids) ?mid))
)

(defrule exact_match_using_multi_word_dic4
(declare (salience 902))
(current_id ?mid)
(manual_id-cat-word-root-vib-grp_ids ?mid ? $?mng - $? - $? - $?grp_ids1)
(manual_id-cat-word-root-vib-grp_ids ?mid1&:(+ ?mid 1) ? $?mng1 - $? - $?vib - $?grp_ids2)
(id-org_wrd-root-dbase_name-mng ? ? ?root ? $?dic_mng)
(id-root ?aid ?root)
(test (eq (create$  $?mng $?mng1) (create$ $?dic_mng)))
(not (prov_assignment ?aid ?mid))
=>
        (bind ?*count* (+ ?*count* 1))
        (assert (update_count_fact ?*count*))
        (assert (anu_ids-sep-manual_ids ?aid - $?grp_ids1 $?grp_ids2))
        (assert (prov_assignment ?aid ?mid))
)

;-------------------------------------------------------------------------------------
(defrule exact_match_with_anu_output ;[manual group match]
(declare (salience 901))
(current_id ?mid)
(manual_id-node-word-root-tam ?h_mid ? $?mng1 - $? - $?)
(head_id-grp_ids ?h_mid ?mid $?grp)
(id-Apertium_output ?aid $?mng1)
(not (prov_assignment ?aid ?mid))
=>
        (bind ?*count* (+ ?*count* 1))
        (assert (update_count_fact ?*count*))
        (assert (anu_ids-sep-manual_ids ?aid - ?mid $?grp))
        (assert (prov_assignment ?aid ?mid))
)
;-------------------------------------------------------------------------------------
(defrule exact_match_with_anu_output1 ;[manual word match with vib]
(declare (salience 901))
(current_id ?mid)
(manual_id-cat-word-root-vib-grp_ids ?mid ? $?mng1 - $? - $?vib - $?grp_ids)
(id-Apertium_output ?aid $?mng1)
(test (neq $?vib 0))
(not (prov_assignment ?aid ?mid))
=>
        (bind ?*count* (+ ?*count* 1))
        (assert (update_count_fact ?*count*))
        (assert (anu_ids-sep-manual_ids ?aid - $?grp_ids))
        (assert (prov_assignment ?aid ?mid))
)

;-------------------------------------------------------------------------------------
(defrule man_grp_match_with_dic
(declare (salience 900))
(current_id ?mid)
(manual_id-node-word-root-tam ?h_mid ? $?mng1 - $? - $?)
(head_id-grp_ids ?h_mid ?mid $?grp)
(id-org_wrd-root-dbase_name-mng ? ? ?e_noun ? $?mng1)
(id-root ?aid ?e_noun)
(not (prov_assignment ?aid ?mid))
=>
	(bind ?*count* (+ ?*count* 1))
        (assert (update_count_fact ?*count*))
        (assert (anu_ids-sep-manual_ids ?aid - ?mid $?grp))
        (assert (prov_assignment ?aid ?mid))
)
;-------------------------------------------------------------------------------------
(defrule exact_match_with_anu_output2 ;[manual word match]
(declare (salience 900))
(current_id ?mid)
(manual_id-cat-word-root-vib-grp_ids ?mid ? $?mng - $? - 0 - $?)
(id-Apertium_output ?aid $?mng)
(not (prov_assignment ?aid ?mid))
=>
        (bind ?*count* (+ ?*count* 1))
        (assert (update_count_fact ?*count*))
        (assert (anu_ids-sep-manual_ids ?aid - ?mid))
        (assert (prov_assignment ?aid ?mid))
)

;-------------------------------------------------------------------------------------
;But, today's rapidly changing business environment has forced the accountants to reassess their roles and functions both within the organization and the society. 
(defrule word_and_vib_match_with_anu_hindi_root
(declare (salience 890))
(current_id ?mid)
(manual_id-cat-word-root-vib-grp_ids ?mid ? $? - $?noun - $?vib -  $?grp)
(test (neq $?vib 0))
(id-HM-source ?aid $?noun ?)
(pada_info (group_head_id  ?aid)(vibakthi ?vib1))
(test (eq (implode$ (create$ (remove_character "_" (implode$ (create$ ?vib1)) " "))) (implode$ (create$ $?vib))))
(not (prov_assignment ?aid ?mid))
=>
        (bind ?*count* (+ ?*count* 1))
        (assert (update_count_fact ?*count*))
        (assert (anu_ids-sep-manual_ids ?aid - $?grp))
        (assert (prov_assignment ?aid ?mid))
)

(defrule word_and_vib_match_with_anu_hindi_root1
(declare (salience 890))
(current_id ?mid)
(manual_id-cat-word-root-vib-grp_ids ?mid ? $? - $?noun - $?vib -  $?grp)
(test (neq $?vib 0))
(id-HM-source ?aid $?noun ?)
(not (prov_assignment ?aid ?mid))
=>
        (bind ?*count* (+ ?*count* 1))
        (assert (update_count_fact ?*count*))
        (assert (anu_ids-sep-manual_ids ?aid - $?grp))
        (assert (prov_assignment ?aid ?mid))
)
;-------------------------------------------------------------------------------------
(defrule word_match_with_anu_hindi_root
(declare (salience 890))
(current_id ?mid)
(manual_id-cat-word-root-vib-grp_ids ?mid ? $? - $?noun - 0 -  $?grp)
(id-HM-source ?aid $?noun ?)
(pada_info (group_head_id  ?aid)(vibakthi 0))
(not (prov_assignment ?aid ?mid))
=>
        (bind ?*count* (+ ?*count* 1))
        (assert (update_count_fact ?*count*))
        (assert (anu_ids-sep-manual_ids ?aid - $?grp))
        (assert (prov_assignment ?aid ?mid))
)

;-------------------------------------------------------------------------------------
;If only one verb is present in both the manual and anusaaraka sentences then make direct alignment.
(defrule single_verb_group_match_with_anu
(declare (salience 890))
(current_id ?mid)
(anu_verb_count-verbs 1 ?aid)
(man_verb_count-verbs 1 ?mid)
(manual_id-node-word-root-tam ?m_h_id VGF $?man_mng - $? - $?)
(head_id-grp_ids ?m_h_id ?mid $?grp)
(id-Apertium_output ?aid $?anu_mng)
(not (prov_assignment ?aid ?mid))
=>
        (bind ?*count* (+ ?*count* 1))
        (assert (update_count_fact ?*count*))
        (assert (anu_ids-sep-manual_ids ?aid - ?mid $?grp))
        (assert (prov_assignment ?aid ?mid))
     
)
;-------------------------------------------------------------------------------------
;Check for manual verb[root] and tam match in the dictionary
(defrule verb_match_using_dic
(declare (salience 880))
(current_id ?mid)
(manual_id-node-word-root-tam  ?man_g_id   VGF   $?verb_mng - $?v_root - $?tam)
(head_id-grp_ids ?man_g_id ?mid $?grp_ids)
(id-org_wrd-root-dbase_name-mng ? ? ?root ? $?v_root)
(e_tam-id-dbase_name-mng ?e_tam ? ? $?tam)
(id-root ?aid ?root)
(not (prov_assignment ?aid ?mid))
=>
        (bind ?*count* (+ ?*count* 1))
        (assert (update_count_fact ?*count*))
        (assert (anu_ids-sep-manual_ids ?aid - ?mid $?grp_ids))
        (assert (prov_assignment ?aid ?mid))
)

(defrule verb_with_only_root_match_using_dic
(declare (salience 879))
(current_id ?mid)
(manual_id-node-word-root-tam  ?man_g_id   VGF   $?verb_mng - $?v_root - $?)
(head_id-grp_ids ?man_g_id ?mid $?grp_ids)
(id-org_wrd-root-dbase_name-mng ? ? ?root ? $?v_root)
(id-root ?aid ?root)
(not (prov_assignment ?aid ?mid))
=>
        (bind ?*count* (+ ?*count* 1))
        (assert (update_count_fact ?*count*))
        (assert (anu_ids-sep-manual_ids ?aid - ?mid $?grp_ids))
        (assert (prov_assignment ?aid ?mid))
)

(defrule to_infinitive_pada
(declare (salience 879))
(current_id ?mid)
(pada_info (group_head_id ?aid) (group_cat infinitive))
(manual_id-node-word-root-tam  ?man_g_id    ~VGF  $? - $?v_root - $?tam)
(test (or (eq $?tam "isake bAxa meM")(eq $?tam "nA") (eq $?tam "nA ke liye")(eq  $?tam "waka")(eq $?tam "ne") (eq $?tam "ne kI")(eq $?tam "ne kA") (eq $?tam "ne vAlA")(eq $?tam "ne se") (eq $?tam "ne ke liye") (eq $?tam "0 kara")(eq $?tam "ke liye") (eq $?tam "kI ora") (eq $?tam  "se") (eq $?tam "kA")(eq $?tam "meM")(eq $?tam "ke sAmane")(eq $?tam "ke karIba")(eq $?tam "ora")(eq $?tam "ko")))
(head_id-grp_ids ?man_g_id ?mid $?grp_ids)
(id-org_wrd-root-dbase_name-mng ? ? ?root ? $?v_root)
(id-root ?aid ?root)
(not (prov_assignment ?aid ?mid))
=>
        (bind ?*count* (+ ?*count* 1))
        (assert (update_count_fact ?*count*))
        (assert (anu_ids-sep-manual_ids ?aid - ?mid $?grp_ids))
        (assert (prov_assignment ?aid ?mid))
)
;-------------------------------------------------------------------------------------
;Check for manual word and vibakthi match in the dictionary
(defrule word_and_vib_match_using_dic
(declare (salience 870))
(current_id ?mid)
(manual_id-cat-word-root-vib-grp_ids ?mid ? $?noun - $? - $?vib - $?grp_ids)
(test (neq $?vib 0))
(id-org_wrd-root-dbase_name-mng ? ? ?e_noun ? $?noun)
(id-org_wrd-root-dbase_name-mng ? ? ?e_vib ? $?vib)
(id-root ?e_noun_id ?e_noun)
(id-root ?e_vib_id ?e_vib)
(pada_info (group_head_id  ?e_noun_id)(preposition ?e_vib_id))
(not (prov_assignment ?e_noun_id ?mid))
=>
        (bind ?*count* (+ ?*count* 1))
        (assert (update_count_fact ?*count*))
        (assert (anu_ids-sep-manual_ids ?e_noun_id - $?grp_ids))
        (assert (prov_assignment ?e_noun_id ?mid))
)

(defrule root_and_vib_match_using_dic1
(declare (salience 870))
(current_id ?mid)
(manual_id-cat-word-root-vib-grp_ids ?mid ? $? - $?noun - $?vib - $?grp_ids)
(test (neq $?vib 0))
(id-org_wrd-root-dbase_name-mng ? ? ?e_noun ? $?noun)
(id-org_wrd-root-dbase_name-mng ? ? ?e_vib ? $?vib)
(id-root ?e_noun_id ?e_noun)
(id-root ?e_vib_id ?e_vib)
(pada_info (group_head_id  ?e_noun_id)(preposition ?e_vib_id))
(not (prov_assignment ?e_noun_id ?mid))
=>
        (bind ?*count* (+ ?*count* 1))
        (assert (update_count_fact ?*count*))
        (assert (anu_ids-sep-manual_ids ?e_noun_id - $?grp_ids))
        (assert (prov_assignment ?e_noun_id ?mid))
)

(defrule root_and_vib_match_using_dic2
(declare (salience 870))
(current_id ?mid)
(manual_id-cat-word-root-vib-grp_ids ?mid ? $?word - $? - $?vib - $?grp_ids)
(man_word-root-cat      $?word   $?noun ?)
(test (neq $?vib 0))
(id-org_wrd-root-dbase_name-mng ? ? ?e_noun ? $?noun)
(id-org_wrd-root-dbase_name-mng ? ? ?e_vib ? $?vib)
(id-root ?e_noun_id ?e_noun)
(id-root ?e_vib_id ?e_vib)
(pada_info (group_head_id  ?e_noun_id)(preposition ?e_vib_id))
(not (prov_assignment ?e_noun_id ?mid))
=>
        (bind ?*count* (+ ?*count* 1))
        (assert (update_count_fact ?*count*))
        (assert (anu_ids-sep-manual_ids ?e_noun_id - $?grp_ids))
        (assert (prov_assignment ?e_noun_id ?mid))
)

;-------------------------------------------------------------------------------------
;Check for manual  word match in the dictionary
(defrule noun-word_with_0_vib
(declare (salience 850))
(current_id ?mid)
(manual_id-cat-word-root-vib-grp_ids ?mid ~VM $?mng - $? - 0 - $?)
(id-org_wrd-root-dbase_name-mng ? ? ?e_word ? $?mng)
(id-root ?eid ?e_word)
(not (prov_assignment ?eid ?mid))
=>
        (bind ?*count* (+ ?*count* 1))
        (assert (update_count_fact ?*count*))
        (assert (anu_ids-sep-manual_ids ?eid - ?mid))
        (assert (prov_assignment ?eid ?mid))
)

(defrule noun-word_with_0_vib1
(declare (salience 850))
(current_id ?mid)
(manual_id-cat-word-root-vib-grp_ids ?mid ~VM $? - $?mng - 0 - $?)
(id-org_wrd-root-dbase_name-mng ? ? ?e_word ? $?mng)
(id-root ?eid ?e_word)
(not (prov_assignment ?eid ?mid))
=>
        (bind ?*count* (+ ?*count* 1))
        (assert (update_count_fact ?*count*))
        (assert (anu_ids-sep-manual_ids ?eid - ?mid))
        (assert (prov_assignment ?eid ?mid))
)

;-------------------------------------------------------------------------------------
;Check for manual word having vibakthi in the dictionary for which only match for word is found.
(defrule noun-word_with_vib-pres-and-no-match
(declare (salience 840))
(current_id ?mid)
(or (manual_id-cat-word-root-vib-grp_ids ?mid ? $?noun - $? - $?vib - $?grp_ids)(manual_id-cat-word-root-vib-grp_ids ?mid ? $? - $?noun - $?vib - $?grp_ids))
(test (neq $?vib 0))
(id-org_wrd-root-dbase_name-mng ? ? ?e_word ? $?noun)
(id-root ?eid ?e_word)
(id-root ?e_vib_id ?e_vib)
(pada_info (group_head_id  ?eid)(preposition ?e_vib_id))
(not (id-org_wrd-root-dbase_name-mng ? ? ?e_vib ? $?vib))
(not (prov_assignment ?eid ?mid))
=>
        (bind ?*count* (+ ?*count* 1))
        (assert (update_count_fact ?*count*))
        (assert (anu_ids-sep-manual_ids ?eid - $?grp_ids))
        (assert (prov_assignment ?eid ?mid))
)

;-------------------------------------------------------------------------------------
;look for synonyms in hindi wordnet
(defrule lookup_man_word_in_hindi_wordnet
(declare (salience 500))
(current_id ?mid)
(manual_id-cat-word-root-vib-grp_ids ?mid ? $?word - $?h_root - $? - $?grp_ids)
(test (neq (gdbm_lookup "hindi_wordnet_dic2.gdbm" (implode$ (create$ $?h_root))) "FALSE"))
(id-org_wrd-root-dbase_name-mng ? ? ?e_root ? $?mng)
(id-root ?aid ?e_root)
(test (neq (gdbm_lookup "hindi_wordnet_dic2.gdbm" (implode$ (create$ $?mng))) "FALSE"))
(not (prov_assignment ?aid ?mid))
(not (anu_id-man_id ?aid ?mid))
=>
	(assert (anu_id-man_id ?aid ?mid))
        (bind ?dic_val (gdbm_lookup "hindi_wordnet_dic1.gdbm" (gdbm_lookup "hindi_wordnet_dic2.gdbm" (implode$ (create$ $?h_root)))))
        (bind ?dic_val (remove_character "/" ?dic_val " "))
        (if (neq ?dic_val "FALSE") then
            (if (and (member$ $?h_root ?dic_val)(member$ $?mng ?dic_val)) then
		(bind ?*count* (+ ?*count* 1))
	        (assert (update_count_fact ?*count*))
	        (assert (anu_ids-sep-manual_ids ?aid - $?grp_ids))
	        (assert (prov_assignment ?aid ?mid))
            )
        )
)
;-------------------------------------------------------------------------------------
(defrule check_match_with_english_word
(declare (salience 830))
(current_id ?mid)
(manual_id-cat-word-root-vib-grp_ids ?mid ? $?word - $? - $? - $?)
(or (id-word ?eid $?word)(id-original_word ?eid $?word))
(not (prov_assignment ?eid ?mid))
=>
        (bind ?*count* (+ ?*count* 1))
        (assert (update_count_fact ?*count*))
        (assert (anu_ids-sep-manual_ids ?eid - ?mid))
        (assert (prov_assignment ?eid ?mid))
)

;-------------------------------------------------------------------------------------

(defrule exact_match_using_multi_word_dic3
(declare (salience 802))
(current_id ?mid)
(multi_word_expression-dbase_name-mng $?e_words ? $?mng)
(multi_word_expression-grp_ids $?e_words $?aids)
(manual_id-node-word-root-tam ?h_mid ? $?pre $?mng $?pos - $? - $?)
(head_id-grp_ids ?h_mid $?pre_id ?mid $?pos_id)
(test (eq (length $?pre) (length $?pre_id)))
(not (prov_assignment ?aid ?mid))
=>
        (bind ?*count* (+ ?*count* 1))
        (assert (update_count_fact ?*count*))
	(bind ?len_pre (length $?pre))
	(bind ?len (length $?mng))
        (bind $?grp (create$ ))
        (loop-for-count (?i 1 ?len)
			(bind ?j (nth$ ?i (create$ ?mid $?pos_id)))
			(bind $?grp (create$ $?grp ?j))
        )
        (assert (anu_ids-sep-manual_ids $?aids - $?grp))
        (assert (prov_assignment (nth$ (length $?aids) $?aids) ?mid))
)
;-------------------------------------------------------------------------------------
(defrule check_count_1
(declare (salience -50))
?f<-(current_id ?mid)
(count_fact 1)
?f2<-(anu_ids-sep-manual_ids $?aids - $?mids)
?f3<-(prov_assignment ?aid ?mid)
(test (member$ ?aid $?aids))
(id-Apertium_output ?aid $?anu_mng)
(test (> (length $?anu_mng) 0))
(test (member$ ?mid $?mids))
=>
        (retract ?f2)
        (bind $?man_grp (create$ ))
        (assert_control_fact mng_has_been_aligned $?mids)
        (assert_control_fact mng_has_been_filled $?aids)
        (assert (anu_id-anu_mng-sep-man_id-man_mng ?aid $?anu_mng - ?mid $?mids))              
        (assert (anu_id-anu_mng-sep-man_id-man_mng_tmp ?aid $?anu_mng - ?mid $?mids))              
        (assert (id-confidence_level ?mid 8))
)
;-------------------------------------------------------------------------------------

(defrule check_count_value_gt_than_1
(declare (salience -50))
?f<-(current_id ?mid)
(count_fact ?count)
(test (> ?count 1))
?f2<-(anu_ids-sep-manual_ids ?aid - $?mids)
?f3<-(prov_assignment ?aid ?mid)
(test (member$ ?mid $?mids))
=>
         (retract ?f2)
	 (assert (potential_assignment_vacancy_id-candidate_id ?aid ?mid)) 
)
;-------------------------------------------------------------------------------------

(defrule check_count_value_0
(declare (salience -200))
?f<-(current_id ?hid)
?f1<-(count_fact ?count)
?f2<-(manual_id-cat-word-root-vib-grp_ids ?hid $?)
=>
        (retract ?f ?f1 ?f2) 
)


(defrule remove_prov_ass_facts
(declare (salience 2000))
?f1<-(prov_assignment ?aid ?mid)
?f2<-(current_id ?mid1)
(test (neq ?mid ?mid1))
=>
	(retract ?f1)
)
;-------------------------------------------------------------------------------------
;From the sixteenth century onwards, great strides were made in science in Europe. 
;solahavAz SawAbxI Age se, baDiyA lambe kaxama yUropa meM vijFAna meM [banAe gaye We].
;solahavIM SawAbxI se yUropa meM vijFAna ke kRewra meM awyaXika pragawi [huI].
;(defrule combine_group1
;(declare (salience -99))
;?f<-(potential_assignment_vacancy_id-candidate_id ?aid ?mid)
;?f1<-(potential_assignment_vacancy_id-candidate_id ?aid1 ?mid)
;(id-Apertium_output ?aid1 $?anu_mng)
;(test (neq (length $?anu_mng) 0))
;(test (eq ?aid1 (+ ?aid 1)))
;(manual_id-cat-word-root-vib-grp_ids ?mid ? $? - $? - $? - $?grp_ids)
;=>
;         (retract ?f ?f1)
;         (assert (anu_id-anu_mng-sep-man_id-man_mng ?aid1 $?anu_mng - ?mid $?grp_ids))
;         (assert (anu_id-anu_mng-sep-man_id-man_mng_tmp ?aid1 $?anu_mng - ?mid $?grp_ids))
;	 (assert_control_fact mng_has_been_aligned $?grp_ids)
;         (assert_control_fact mng_has_been_filled ?aid1)
;
;)

;This causes a major upheaval in science. 
;yaha vijFAna meM eka muKya kAyApalata kA kAraNa howA hE.
;ये प्रेक्षण ही विज्ञान में महान क्रांति का कारण बनते हैं .
;The macroscopic domain includes phenomena at the laboratory, terrestrial and astronomical scales.
;sWUla praBAva kRewra meM prayogaSAlA  , pArWiva waWA KagolIya swara kI pariGatanAez sammiliwa howI hEM .
(defrule combine_group 
(declare (salience -99))
?f<-(anu_id-anu_mng-sep-man_id-man_mng ?aid $?anu_mng - ?mid $?man_ids)
?f4<-(anu_id-anu_mng-sep-man_id-man_mng_tmp ?aid $?anu_mng - ?mid $?man_ids)
?f1<-(anu_id-anu_mng-sep-man_id-man_mng ?aid $?anu_mng - ?mid1 $?man_ids1)
?f5<-(anu_id-anu_mng-sep-man_id-man_mng_tmp ?aid $?anu_mng - ?mid1 $?man_ids1)
(test (neq ?mid ?mid1))
(test (or (eq (+ (nth$ (length $?man_ids) $?man_ids) 1) (nth$ 1 $?man_ids1)) (subsetp $?man_ids $?man_ids1) (subsetp $?man_ids $?man_ids1)))
?f2<-(id-confidence_level ?mid 8)
?f3<-(id-confidence_level ?mid1 8)
=>
         (retract ?f ?f1 ?f4 ?f5)
	 (if (subsetp $?man_ids $?man_ids1) then
		(assert (anu_id-anu_mng-sep-man_id-man_mng ?aid $?anu_mng - ?mid1 $?man_ids1))
        	(assert (anu_id-anu_mng-sep-man_id-man_mng_tmp ?aid $?anu_mng - ?mid1 $?man_ids1))
	else (if (subsetp $?man_ids $?man_ids1) then
		(assert (anu_id-anu_mng-sep-man_id-man_mng ?aid $?anu_mng - ?mid $?man_ids))
        	(assert (anu_id-anu_mng-sep-man_id-man_mng_tmp ?aid $?anu_mng - ?mid $?man_ids))
	else
	         (assert (anu_id-anu_mng-sep-man_id-man_mng ?aid $?anu_mng - ?mid $?man_ids $?man_ids1))
        	 (assert (anu_id-anu_mng-sep-man_id-man_mng_tmp ?aid $?anu_mng - ?mid $?man_ids $?man_ids1))))
)

(defrule combine_group2
(declare (salience -100))
?f<-(anu_id-anu_mng-sep-man_id-man_mng ?aid $?anu_mng - ?mid $?man_ids)
?f4<-(anu_id-anu_mng-sep-man_id-man_mng_tmp ?aid $?anu_mng - ?mid $?man_ids)
?f1<-(anu_id-anu_mng-sep-man_id-man_mng ?aid $?anu_mng - ?mid1 $?man_ids1)
?f5<-(anu_id-anu_mng-sep-man_id-man_mng_tmp ?aid $?anu_mng - ?mid1 $?man_ids1)
(test (neq ?mid ?mid1))
?f2<-(id-confidence_level ?mid 8)
?f3<-(id-confidence_level ?mid1 8)
=>
          (retract ?f ?f1 ?f4 ?f5)
          (assert (potential_assignment_vacancy_id-candidate_id ?aid ?mid))
          (assert (potential_assignment_vacancy_id-candidate_id ?aid ?mid1))
          (assert_control_fact rm_aligned_fact $?man_ids $?man_ids1)
          (assert_control_fact rm_filled_fact ?aid)
)


(defrule rm_man_aligned_fact
(rm_aligned_fact ?mid)
?f<-(mng_has_been_aligned ?mid)
=>
	(retract ?f)
)

(defrule rm_anu_filled_fact
(rm_filled_fact ?aid)
?f<-(mng_has_been_filled ?aid)
=>
        (retract ?f)
)

;"As an [information system], it collects data and communicates economic information about the organization to a wide variety of users whose decisions and actions are related to its per for mance. "
;एक [सूचना]प्रणाली के रूप में यह किसी भी संगठन की आर्थिक सूचनाओं से संबंधित आंकड़े एकत्रित कर उनका संप्रेषण उन विभिन्न उपयोगकत्र्ताओं तक करता है , जिनके निर्णय एवं क्रियाएं संगठन के प्रदर्शन को प्रभावित करती है .
(defrule previous_wrd_match_with_anu
(declare (salience -499))
?f<-(anu_id-anu_mng-sep-man_id-man_mng_tmp ?aid $?anu_mng - ?mid ?id $?grp)
?f1<-(anu_id-anu_mng-sep-man_id-man_mng ?aid $?anu_mng - ?mid ?id $?grp)
(manual_id-word-cat ?mid1&:(eq ?mid1 (- ?id 1)) $?mng ?vib&~VIB)
(not (manual_id-word-cat ?id1&:(member ?id1 $?grp) $?mng ?))
(not (mng_has_been_aligned ?mid1))
?f2<-(id-confidence_level ?mid ?conf_lvl)
(test (subsetp $?mng $?anu_mng))
=>
        (retract ?f ?f1 ?f2)
	(assert (anu_id-anu_mng-sep-man_id-man_mng ?aid $?anu_mng - ?mid ?mid1 ?id $?grp))
	(assert (anu_id-anu_mng-sep-man_id-man_mng_tmp ?aid $?anu_mng - ?mid ?mid1 ?id $?grp))
	(assert_control_fact mng_has_been_aligned ?mid1)
	(bind ?conf_lvl (explode$ (str-cat ?conf_lvl , 7)))
        (assert (id-confidence_level ?mid ?conf_lvl))
)

(defrule next_wrd_match_with_anu
(declare (salience -499))
?f<-(anu_id-anu_mng-sep-man_id-man_mng_tmp ?aid $?anu_mng - ?mid $?grp ?id)
?f1<-(anu_id-anu_mng-sep-man_id-man_mng ?aid $?anu_mng - ?mid $?grp ?id)
(manual_id-word-cat ?mid1&:(eq ?mid1 (+ ?id 1)) $?mng ?vib&~VIB)
(not (mng_has_been_aligned ?mid1))
(not (manual_id-word-cat ?id1&:(member ?id1 $?grp) $?mng ?))
?f2<-(id-confidence_level ?mid ?conf_lvl)
(test (subsetp $?mng $?anu_mng))
=>
        (retract ?f ?f1 ?f2)
        (assert (anu_id-anu_mng-sep-man_id-man_mng ?aid $?anu_mng - ?mid $?grp ?id ?mid1))
        (assert (anu_id-anu_mng-sep-man_id-man_mng_tmp ?aid $?anu_mng - ?mid $?grp ?id ?mid1))
	(assert_control_fact mng_has_been_aligned ?mid1)
        (bind ?conf_lvl (explode$ (str-cat ?conf_lvl , 7)))
        (assert (id-confidence_level ?mid ?conf_lvl))
)


;-------------------------------------------------------------------------------------
(defrule replace_id_with_word
(declare (salience -500))
?f<-(anu_id-anu_mng-sep-man_id-man_mng_tmp ?aid $?anu_mng - ?mid $?pre ?id $?pos)
?f1<-(manual_id-word-cat ?id ?h_mng ?)
=>
	(retract ?f ?f1)
        (if (member$ ?h_mng (create$ @PUNCT-Comma @PUNCT-Dot @PUNCT-QuestionMark @PUNCT-DoubleQuote @PUNCT-DoubleQuote @PUNCT-Semicolon @PUNCT-Colon @PUNCT-SingleQuote @PUNCT-OpenParen @PUNCT-ClosedParen @PUNCT-Exclamation @SYM-Dollar)) then
	(assert (anu_id-anu_mng-sep-man_id-man_mng_tmp ?aid $?anu_mng - ?mid $?pre $?pos))
	else
        (assert (anu_id-anu_mng-sep-man_id-man_mng_tmp ?aid $?anu_mng - ?mid $?pre ?h_mng $?pos)))
)
