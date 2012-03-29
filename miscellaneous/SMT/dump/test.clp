(load-facts "word.dat")
(load-facts "root.dat")
(load-facts "eng_id_in_hin_ord.dat")
(load-facts "position.dat")
(load-facts "hindi_sentence_SMT.dat")
(load-facts "id_Apertium_output.dat")
(load-facts "lwg_info.dat")
(load-facts "manual_hindi_sen.dat")
(load-facts "shallow_parser_GNP_info.dat")
(load-facts "shallow_parser_output.dat.tmp7")
(assert (index 1))




(defrule split_man_sent
(declare (salience 100))
?f<-(manual_hin_sen $?sen)
?f1<-(index ?id)
(test (< ?id (length $?sen)))
=>
	(retract ?f1)
        (bind ?h (nth$ ?id $?sen))
	(assert (hid-mng ?id ?h))
        (bind ?id (+ ?id 1))
	(assert (index ?id))
)

(defrule get_verb_mng
(declare (salience 95))
(root-verbchunk-tam-chunkids ?r ?v_ch ?tam $?chunk_ids ?head)
(id-Apertium_output ?head $?mng)
?f<-(manual_hin_sen $? ?mng1)
(hid-mng ?id ?mng1)
=>
	(assert (m_id-a_id ?id - ?h ?h))
)

(defrule same_mng
(declare (salience 90))
?f<-(manual_hin_sen $?pre ?h $?pos)
?f1<-(hin_sen $?pre1 ?h $?pos1)
(hid-mng ?id ?h)
;(id-Apertium_output ?id1 $? ?h $?)
=>
	(assert (m_id-a_id ?id - ?h ?h))
        (retract ?f ?f1)
        (assert (manual_hin_sen $?pre $?pos))
        (assert (hin_sen $?pre1 $?pos1))
)

;(defrule approx_match 
;(declare (salience 80))
;?f<-(manual_hin_sen $?pre ?h $?pos)
;?f1<-(hin_sen $?pre1 ?h1 $?pos1)
;(hid-mng ?id ?h)
;(not (m_id-a_id ?id ? ? ?))
;=>
;      
;       (printout t ?h "---------" ?h1 crlf) 
;       (system "echo "?h1">jnk")
;       (system "agrep -B -y "?h" jnk >jnk1")
;       (open "jnk1" fp "r")
;       (bind $?read_file (read fp))
;       (printout t ?read_file crlf)
;       (if (eq ?read_file EOF) then
;       else (if  
;       (if (or (eq ?read_file "1 word matches within 1 errors")(eq ?read_file "1 word matches within 2 errors")) then
;       (assert (m_id-a_id ?id - ?h ?h1))
;       (system "cat jnk jnk1")
;       (retract ?f ?f1)
;       (assert (manual_hin_sen $?pre $?pos))
;       (assert (hin_sen $?pre1 $?pos1))
;       ;(system "rm jnk jnk1")
;        ))
;       (close fp)
;)


(defrule check_dic_mng
(declare (salience 70))
?f<-(manual_hin_sen $?pre ?h $?pos)
?f1<-(hin_sen $?pre1 ?h1 $?pos1)
(hid-mng ?id ?h)
;(id-Apertium_output ? $? ?h1 $?)
(id-root ?id1 ?root)
(not (m_id-a_id ?id ? ? ?))
=>

   (bind ?mng1 "")
   (bind ?new_mng "")
   (bind ?mng (gdbm_lookup "default-iit-bombay-shabdanjali-dic_firefox.gdbm" ?root))
   (if (neq  ?mng  "FALSE") then
   (bind ?at_index (str-index "@" ?mng))(bind ?cl_index (str-index ":" ?mng))
   (while (neq ?at_index FALSE)
                (bind ?mng2 ?mng)
                (bind ?mng (sub-string ?cl_index (length ?mng) ?mng))
                (bind ?at_index (str-index "@" ?mng))
                (if (neq ?at_index FALSE) then
                (bind ?mng1 (str-cat  ?mng1 (sub-string (+ ?cl_index 2) (length ?mng) ?mng)))
                (bind ?cl_index (str-index ":" ?mng))
                else
                (bind ?mng ?mng2))
  )
  (bind ?mng1 (str-cat  ?mng1 (sub-string (+ ?cl_index 2) (length ?mng) ?mng))))
  (bind ?slh_index (str-index "/" ?mng1))
  (if (neq ?slh_index FALSE) then
  (while (neq ?slh_index FALSE)   
               (bind ?new_mng (str-cat ?new_mng (sub-string 1 (- ?slh_index 1) ?mng1) " "))
               (bind ?mng1 (sub-string (+ ?slh_index 1) (length ?mng1) ?mng1))    
               (bind ?slh_index (str-index "/" ?mng1))
    )
  (bind ?new_mng (str-cat ?new_mng ?mng1))
 else
 (bind ?new_mng ?mng1))
 (bind $?default_mngs (explode$ ?new_mng))
 (printout t $?default_mngs crlf)
 (if (and (member$ ?h $?default_mngs)  (member$ ?h1 $?default_mngs)) then
 (assert (m_id-a_id ?id ?id1 ?h ?h1))
 (retract ?f ?f1)
        (assert (manual_hin_sen $?pre $?pos))
        (assert (hin_sen $?pre1 $?pos1))

 )
)
   
(watch facts)
(watch rules)
