(deftemplate manual_word_info (slot head_id (default 0))(multislot word (default 0))(multislot root (default 0))(multislot vibakthi (default 0))(multislot group_ids (default 0)))


(defglobal ?*fp* = dic_fp1)
(defglobal ?*fp1* = dic_fp2)
;;------------------------------------------------------------------------------------------------------------
;Eng sen ::- The lens nearest the [object], called the objective, forms a real, inverted, magnified [image] of the [object].
;Man sen ::- बिंब के सबसे निकट के लेंस को अभिदृश्यक ( @objective ) कहते हैं जो बिंब का वास्तविक , उलटा , आवर्धित प्रतिबिंब बनाता है .
;Anu tran ::- लक्ष्य बुलाया, वस्तु निकट, लेन्स वस्तु का एक विशिष्ट, उलटा कर, आवर्धन कर प्रतिबिंब बनाता है.
(defrule align_poten_man_id3
(declare (salience 1002))
?f<-(man_id-candidate_ids ?mid $?list1 ?aid $?list2 ?aid1  $?list3)
?f1<-(man_id-candidate_ids ?mid1 $?list1 ?aid $?list2 ?aid1  $?list3)
?f4<-(man_id-candidate_ids ?mid3 $?list1 ?aid $?list2 ?aid1  $?list3)
(test (and (< ?mid3 ?mid) (< ?mid3 ?mid1)))
(not (mng_has_been_aligned ?mid))
(not (mng_has_been_aligned ?mid1))
(not (mng_has_been_filled ?aid))
(not (mng_has_been_filled ?aid1))
(test (or (neq (length $?list1) 0) (neq (length $?list2) 0)(neq (length $?list3) 0)))
?f2<-(manual_word_info (head_id ?mid) (word $?man_mng) (group_ids $?mids ?id))
?f3<-(manual_word_info (head_id ?mid1) (word $?man_mng1) (group_ids $?mids1 ?id1))
(mot-cat-praW_id-largest_group ? NP|PP ? $?grp)
(anu_id-anu_mng-sep-man_id-man_mng_tmp ?aid2 $?anu_mng2 - ?mid2 $? )
(test (integerp (member$ ?aid $?grp)))
(test (integerp (member$ ?aid1 $?grp)))
(test (integerp (member$ ?aid2 $?grp)))
(test (eq (+ ?id1 1) ?mid2))
(id-Apertium_output ?aid $?anu_mng)
(id-Apertium_output ?aid1 $?anu_mng1)
=>
        (retract ?f ?f1 ?f2 ?f3)
        (if (eq (length $?anu_mng) 0) then (bind $?anu_mng (create$ -)))
        (if (eq (length $?anu_mng1) 0) then (bind $?anu_mng1 (create$ -)))
        (assert (mng_has_been_aligned ?mid))
        (assert (mng_has_been_filled ?aid))
        (assert (mng_has_been_aligned ?mid1))
        (assert (mng_has_been_filled ?aid1))
        (assert (phrasal_aligned_mng ?aid  ?mid))
        (assert (anu_id-anu_mng-sep-man_id-man_mng ?aid $?anu_mng - ?mid $?mids ?id))
        (assert (anu_id-anu_mng-sep-man_id-man_mng_tmp ?aid $?anu_mng - ?mid $?mids ?id))
        (assert (phrasal_aligned_mng ?aid1  ?mid1))
	(assert (anu_id-anu_mng-sep-man_id-man_mng ?aid1 $?anu_mng1 - ?mid1 $?mids1 ?id1))
        (assert (anu_id-anu_mng-sep-man_id-man_mng_tmp ?aid1 $?anu_mng1 - ?mid1 $?mids1 ?id1))
        (assert (man_id-root-src-rule_name ?mid -  heuristics align_poten_man_id3))
        (assert (man_id-root-src-rule_name ?mid1 -  heuristics align_poten_man_id3))
        
)


(defrule align_poten_man_id2
(declare (salience 1001))
?f<-(man_id-candidate_ids ?mid $?list1 ?aid $?list2 ?aid1  $?list3)
?f1<-(man_id-candidate_ids ?mid1 $?list1 ?aid $?list2 ?aid1  $?list3)
(test (< ?mid ?mid1))
(not (mng_has_been_aligned ?mid))
(not (mng_has_been_aligned ?mid1))
(not (mng_has_been_filled ?aid))
(not (mng_has_been_filled ?aid1))
(test (or (neq (length $?list1) 0) (neq (length $?list2) 0)(neq (length $?list3) 0)))
?f2<-(manual_word_info (head_id ?mid) (word $?man_mng) (group_ids $?mids ?id))
?f3<-(manual_word_info (head_id ?mid1) (word $?man_mng1) (group_ids $?mids1 ?id1))
(mot-cat-praW_id-largest_group ? NP|PP ? $?grp)
(anu_id-anu_mng-sep-man_id-man_mng_tmp ?aid2 $?anu_mng2 - ?mid2 $? )
(test (integerp (member$ ?aid $?grp)))
(test (integerp (member$ ?aid1 $?grp)))
(test (integerp (member$ ?aid2 $?grp)))
(test (eq (+ ?id1 1) ?mid2))
(id-Apertium_output ?aid $?anu_mng)
(id-Apertium_output ?aid1 $?anu_mng1)
=>
        (retract ?f ?f1 ?f2 ?f3)
        (assert (mng_has_been_aligned ?mid))
        (assert (mng_has_been_filled ?aid))
        (assert (mng_has_been_aligned ?mid1))
        (assert (mng_has_been_filled ?aid1))
        (if (eq (length $?anu_mng) 0) then (bind $?anu_mng (create$ -)))
        (if (eq (length $?anu_mng1) 0) then (bind $?anu_mng1 (create$ -)))
        (assert (phrasal_aligned_mng ?aid  ?mid))
        (assert (anu_id-anu_mng-sep-man_id-man_mng ?aid $?anu_mng - ?mid $?mids ?id))
        (assert (anu_id-anu_mng-sep-man_id-man_mng_tmp ?aid $?anu_mng - ?mid $?mids ?id))
        (assert (phrasal_aligned_mng ?aid1  ?mid1))
        (assert (anu_id-anu_mng-sep-man_id-man_mng ?aid1 $?anu_mng1 - ?mid1 $?mids1 ?id1))
        (assert (anu_id-anu_mng-sep-man_id-man_mng_tmp ?aid1 $?anu_mng1 - ?mid1 $?mids1 ?id1))
        (assert (man_id-root-src-rule_name ?mid -  heuristics align_poten_man_id2))
        (assert (man_id-root-src-rule_name ?mid1 -  heuristics align_poten_man_id2))
)



(defrule align_poten_man_id
(declare (salience 1000))
?f<-(man_id-candidate_ids ?mid $?list1 ?aid $?list2)
(not (mng_has_been_aligned ?mid))
(not (mng_has_been_filled ?aid))
(test (or (neq (length $?list1) 0) (neq (length $?list2) 0)))
?f1<-(manual_word_info (head_id ?mid) (word $?man_mng) (group_ids $?mids ?id))
(mot-cat-praW_id-largest_group ? NP|PP ? $?grp)
(anu_id-anu_mng-sep-man_id-man_mng_tmp ?aid1 $?anu_mng1 - ?mid1 $? )
(test (integerp (member$ ?aid $?grp)))
(test (integerp (member$ ?aid1 $?grp)))
(test (eq (+ ?id 1) ?mid1))
(id-Apertium_output ?aid $?anu_mng)
=>
	(retract ?f ?f1)
        (if (eq (length $?anu_mng) 0) then (bind $?anu_mng (create$ -)))
        (assert (mng_has_been_aligned ?mid))
        (assert (mng_has_been_filled ?aid))
        (assert (phrasal_aligned_mng ?aid  ?mid))
        (assert (anu_id-anu_mng-sep-man_id-man_mng ?aid $?anu_mng - ?mid $?mids ?id))
        (assert (anu_id-anu_mng-sep-man_id-man_mng_tmp ?aid $?anu_mng - ?mid $?mids ?id))
        (assert (man_id-root-src-rule_name ?mid -  heuristics align_poten_man_id))
)

(defrule align_poten_man_id1
(declare (salience 1000))
?f<-(man_id-candidate_ids ?mid $?list1 ?aid $?list2)
(not (mng_has_been_aligned ?mid))
(not (mng_has_been_filled ?aid))
(test (or (neq (length $?list1) 0) (neq (length $?list2) 0)))
?f1<-(manual_word_info (head_id ?mid) (word $?man_mng) (group_ids $?mids))
(anu_id-anu_mng-sep-man_id-man_mng_tmp ?aid1 $?anu_mng1 - ?mid1 $? ?id)
(test (numberp ?id))
(test (eq (+ ?id 1) ?mid))
(mot-cat-praW_id-largest_group ? NP|PP ? $?grp)
(test (integerp (member$ ?aid $?grp)))
(test (integerp (member$ ?aid1 $?grp)))
(id-Apertium_output ?aid $?anu_mng)
=>      
        (retract ?f ?f1)
        (if (eq (length $?anu_mng) 0) then (bind $?anu_mng (create$ -))) 
        (assert (mng_has_been_aligned ?mid))
        (assert (mng_has_been_filled ?aid))
        (assert (phrasal_aligned_mng ?aid  ?mid))
        (assert (anu_id-anu_mng-sep-man_id-man_mng ?aid $?anu_mng - ?mid $?mids))
        (assert (anu_id-anu_mng-sep-man_id-man_mng_tmp ?aid $?anu_mng - ?mid $?mids))
        (assert (man_id-root-src-rule_name ?mid -  heuristics align_poten_man_id1))
)


(defrule delete_mng_filled
(declare (salience 900))
(phrasal_aligned_mng ?aid  ?mid)
?f<-(anu_id-candidate_ids ?aid1 $?pre ?mid $?pos)
=>
	(retract ?f)
	(assert (anu_id-candidate_ids ?aid1 $?pre $?pos))
)


(defrule align_single_candidate_id
(declare (salience 890))
(anu_id-candidate_ids ?aid ?mid) 
(not (mng_has_been_aligned ?mid))
(not (mng_has_been_filled ?aid))
?f1<-(manual_word_info (head_id ?mid) (word $?man_mng) (group_ids $?mids))
(id-Apertium_output ?aid $?anu_mng)
=>
        (retract ?f1)
        (if (eq (length $?anu_mng) 0) then (bind $?anu_mng (create$ -)))
        (assert (mng_has_been_aligned ?mid))
        (assert (mng_has_been_filled ?aid))
        (assert (phrasal_aligned_mng ?aid ?mid))
        (assert (anu_id-anu_mng-sep-man_id-man_mng ?aid $?anu_mng - ?mid $?mids))
        (assert (anu_id-anu_mng-sep-man_id-man_mng_tmp ?aid $?anu_mng - ?mid $?mids))
        (assert (man_id-root-src-rule_name ?mid -  heuristics align_single_candidate_id))
)
;------------------------------------------------------------------------------------------------------------

(defrule align_restricted_left_over_wrds1
(declare (salience -197))
(anu_id-word-possible_mngs ?aid ?word $?pos_mngs)
?f<-(manual_word_info (head_id ?mid) (word $?man_mng&:(subsetp $?man_mng $?pos_mngs)) (group_ids $?mids))
(not (mng_has_been_aligned ?mid))
(not (mng_has_been_filled ?aid))
(id-Apertium_output ?aid $?anu_mng)
=>
        (retract ?f)
        (if (eq (length $?anu_mng) 0) then (bind $?anu_mng (create$ -)))
        (assert (mng_has_been_aligned ?mid))
        (assert (mng_has_been_filled ?aid))
        (assert (phrasal_aligned_mng ?aid  ?mid))
        (assert (anu_id-anu_mng-sep-man_id-man_mng ?aid $?anu_mng - ?mid $?mids))
        (assert (anu_id-anu_mng-sep-man_id-man_mng_tmp ?aid $?anu_mng - ?mid $?mids))
        (assert (man_id-root-src-rule_name ?mid -  restricted_word_match align_restricted_left_over_wrds1))
)

(defrule align_restricted_left_over_wrds2
(declare (salience -197))
(man_id-word-possible_mngs ?mid ?word $?pos_mngs)
?f<-(manual_word_info (head_id ?mid) (word $?man_mng) (group_ids $?mids))
(not (mng_has_been_aligned ?mid))
(not (mng_has_been_filled ?aid))
(id-word ?aid $?anu_mng&:(subsetp $?anu_mng $?pos_mngs))
=>
        (retract ?f)
        (if (eq (length $?anu_mng) 0) then (bind $?anu_mng (create$ -)))
        (assert (mng_has_been_aligned ?mid))
        (assert (mng_has_been_filled ?aid))
        (assert (phrasal_aligned_mng ?aid  ?mid))
        (assert (anu_id-anu_mng-sep-man_id-man_mng ?aid $?anu_mng - ?mid $?mids))
        (assert (anu_id-anu_mng-sep-man_id-man_mng_tmp ?aid $?anu_mng - ?mid $?mids))
        (assert (man_id-root-src-rule_name ?mid -  restricted_word_match align_restricted_left_over_wrds2))
)

(defrule align_restricted_left_over_wrds3
(declare (salience -198))
(anu_id-word-possible_mngs ?aid ?word $?pos_mngs)
(not (mng_has_been_filled ?aid))
(id-word ?aid ?word)
=>
        (assert (mng_has_been_filled ?aid))
)


(defrule align_restricted_left_over_wrds4
(declare (salience -198))
(man_id-word-possible_mngs ?mid ?word $?pos_mngs)
(not (mng_has_been_aligned ?mid))
=>
	(assert (mng_has_been_aligned ?mid))
)

(defrule align_left_over_wrds_using_phrasal_data
(declare (salience -199))
?f<-(manual_word_info (head_id ?mid) (word $?man_mng)(group_ids $?mids))
(anu_id-anu_mng-man_mng         ?aid    ?  $?man_mng)
(not (mng_has_been_aligned ?mid))
(not (mng_has_been_filled ?aid))
(id-original_word ?aid ?)
(id-Apertium_output ?aid $?anu_mng)
=>
        (retract ?f)
        (if (eq (length $?anu_mng) 0) then (bind $?anu_mng (create$ -)))
        (assert (mng_has_been_aligned ?mid))
        (assert (mng_has_been_filled ?aid))
        (assert (phrasal_aligned_mng ?aid  ?mid))
        (assert (anu_id-anu_mng-sep-man_id-man_mng ?aid $?anu_mng - ?mid $?mids))
        (assert (anu_id-anu_mng-sep-man_id-man_mng_tmp ?aid $?anu_mng - ?mid $?mids))
        (assert (man_id-root-src-rule_name ?mid -  default_pharasal_match align_left_over_wrds_using_phrasal_data))
)

(defrule align_left_over_wrds_using_phrasal_data1
(declare (salience -200))
?f<-(manual_word_info (head_id ?mid) (word $?man_mng)(group_ids $?mids))
(anu_id-anu_mng-man_mng         ?aid    ?  $? ?man_mng1 $?)
(test (member$ ?man_mng1 $?man_mng))
(not (mng_has_been_aligned ?mid))
(not (mng_has_been_filled ?aid))
(id-original_word ?aid ?)
(id-Apertium_output ?aid $?anu_mng)
=>
        (retract ?f)
        (if (eq (length $?anu_mng) 0) then (bind $?anu_mng (create$ -)))
        (assert (mng_has_been_aligned ?mid))
        (assert (mng_has_been_filled ?aid))
        (assert (phrasal_aligned_mng ?aid  ?mid))
        (assert (anu_id-anu_mng-sep-man_id-man_mng ?aid $?anu_mng - ?mid $?mids))
        (assert (anu_id-anu_mng-sep-man_id-man_mng_tmp ?aid $?anu_mng - ?mid $?mids))
        (assert (man_id-root-src-rule_name ?mid -  default_pharasal_match align_left_over_wrds_using_phrasal_data1))
)
;-------------------------------------------------------------------------------------

(defrule replace_id_with_word_for_nos
(declare (salience -500))
?f<-(anu_id-anu_mng-sep-man_id-man_mng_tmp ?aid $?anu_mng - ?mid $?pre ?id $?pos)
?f1<-(manual_id-word ?id ?h_mng)
(test (numberp ?h_mng))
(phrasal_aligned_mng ?aid  ?mid)
=>
        (retract ?f ?f1)
        (bind ?h_mng (string-to-field (str-cat @ ?h_mng)))
        (assert (anu_id-anu_mng-sep-man_id-man_mng_tmp ?aid $?anu_mng - ?mid $?pre ?h_mng $?pos))
        
)

(defrule replace_id_with_word
(declare (salience -501))
?f<-(anu_id-anu_mng-sep-man_id-man_mng_tmp ?aid $?anu_mng - ?mid $?pre ?id $?pos)
?f1<-(manual_id-word ?id $?h_mng)
(phrasal_aligned_mng ?aid  ?mid)
=>
        (retract ?f ?f1)
        (if (member$ ?h_mng (create$ @PUNCT-Comma @PUNCT-Dot @PUNCT-QuestionMark @PUNCT-DoubleQuote @PUNCT-DoubleQuote @PUNCT-Semicolon @PUNCT-Colon @PUNCT-SingleQuote @PUNCT-OpenParen @PUNCT-ClosedParen @PUNCT-Exclamation @SYM-Dollar)) then
        (assert (anu_id-anu_mng-sep-man_id-man_mng_tmp ?aid $?anu_mng - ?mid $?pre $?pos))
        else
        (assert (anu_id-anu_mng-sep-man_id-man_mng_tmp ?aid $?anu_mng - ?mid $?pre $?h_mng $?pos)))
)
;-------------------------------------------------------------------------------------
(defrule print_to_file
(declare (salience -1000))
?f<-(anu_id-anu_mng-sep-man_id-man_mng_tmp ?aid $?anu_mng - ?mid $?man_mng)
(phrasal_aligned_mng ?aid  ?mid)
(man_id-root-src-rule_name ?mid ?root  ?src ?rule_name)
=>
	(retract ?f)
        (printout ?*fp* "(anu_id-anu_mng-sep-man_id-man_mng_tmp "?aid" "(implode$ $?anu_mng)" - "?mid" "(implode$ $?man_mng)")" crlf)
        (printout ?*fp1* "(man_id-root-src-rule_name "?mid" "?root"  "?src" "?rule_name")" crlf)
)

