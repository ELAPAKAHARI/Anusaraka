
;Added by Meena(20.4.10)
;My watch was broken.
(defrule was_en_tam00
(declare (salience 5000))
(id-TAM ?id was_en)
?mng <-(meaning_to_be_decided ?id)
(id-word ?id1 disappoint|break|relate|bless)
=>
(retract ?mng)
(assert (id-E_tam-H_tam_mng ?id was_en WA))
(if ?*debug_flag* then
(printout wsd_fp "(dir_name-file_name-rule_name-id-H_tam_mng  " ?*wsd_dir* "  was_en_tam.clp    was_en_tam00  "  ?id "  WA )" crlf))
(assert (id-tam_type ?id passive))
)




;She was born in Patna.
(defrule was_en_tam0
(declare (salience 5000))
(id-TAM ?id was_en)
?mng <-(meaning_to_be_decided ?id)
(id-word ?id1 born)
=>
(retract ?mng)
(assert (id-E_tam-H_tam_mng ?id was_en yA_WA))
(if ?*debug_flag* then
(printout wsd_fp "(dir_name-file_name-rule_name-id-H_tam_mng  " ?*wsd_dir* "  was_en_tam.clp  	was_en_tam0  "  ?id "  yA_WA )" crlf))
(assert (id-tam_type ?id passive))
)



;Added "call" in the list (Meena 23.3.11)
;He was called simply Clint Jr. because his Daddy was Clint Sr..
; Protoplasm is known as the physical basis for life.
(defrule was_en_tam1
(declare (salience 4900))
(id-TAM ?id was_en)
?mng <-(meaning_to_be_decided ?id)
(id-root ?id1  know|call)
=>
(retract ?mng)
(assert (id-E_tam-H_tam_mng ?id was_en yA_jAwA_WA))
(if ?*debug_flag* then
(printout wsd_fp "(dir_name-file_name-rule_name-id-H_tam_mng  " ?*wsd_dir* "  was_en_tam.clp  	was_en_tam1  "  ?id "  yA_jAwA_WA )" crlf))
(assert (id-tam_type ?id passive))
)




;Added by Meena(19.4.11)
;The silver was tarnished by the long exposure to the air.
(defrule was_en_tam02
(declare (salience 4900))
(id-TAM ?id was_en)
?mng <-(meaning_to_be_decided ?id)
(id-root ?id tarnish|destroy);Added destroy by Manju Suggested by Preeti (21-08-13) Ex: The building was completely destroyed by fire.
=>
(retract ?mng)
(assert (id-E_tam-H_tam_mng ?id was_en 0_gayA_WA))
(if ?*debug_flag* then
(printout wsd_fp "(dir_name-file_name-rule_name-id-H_tam_mng  " ?*wsd_dir* "  was_en_tam.clp    was_en_tam02  "  ?id "  0_gayA_WA )" crlf))
(assert (id-tam_type ?id passive))
)

;Modified by Meena(14.4.10)
(defrule was_en_tam2
(declare (salience 4800))
(id-TAM ?id was_en)
?mng <-(meaning_to_be_decided ?id)
(or(kriyA-subject ?id ?id1)(kriyA-object ?id ?id1))
(or(id-root ?id2 about|for|in|out|with|by)(kriyA-kriyA_viSeRaNa ?id ?id2))
(not(id-root ?id1 spell))
;(test(> ?id2 ?id))
=>
(retract ?mng)
(assert (id-E_tam-H_tam_mng ?id was_en yA_gayA_WA))
(if ?*debug_flag* then
(printout wsd_fp "(dir_name-file_name-rule_name-id-H_tam_mng  " ?*wsd_dir* "  was_en_tam.clp    was_en_tam2  "  ?id "  yA_gayA_WA )" crlf))
(assert (id-tam_type ?id passive))
)





;Salience reduced by Meena(20.4.10)
;The fruit was eaten.
(defrule was_en_tam3
(declare (salience 0))
;(declare (salience 4800))
(id-TAM ?id was_en)
?mng <-(meaning_to_be_decided ?id)
=>
(retract ?mng)
;(assert (id-E_tam-H_tam_mng ?id was_en yA_huA_WA))
(assert (id-E_tam-H_tam_mng ?id was_en yA_gayA_WA))
(if ?*debug_flag* then
(printout wsd_fp "(dir_name-file_name-rule_name-id-H_tam_mng  " ?*wsd_dir* "  was_en_tam.clp  	was_en_tam3  "  ?id "  yA_gayA_WA )" crlf))
(assert (id-tam_type ?id passive))
)




;She was asked about the pay increase but made no comment.
(defrule was_en_tam4
(declare (salience 4850))
(id-TAM ?id was_en)
?mng <-(meaning_to_be_decided ?id)
(id-root ?id ask|found)
=>
(retract ?mng)
(assert (id-E_tam-H_tam_mng ?id were_en yA_gayA_WA))
;(assert (root_id-TAM-vachan ?id were_en p))
(assert (kriyA_id-subject_viBakwi ?id se))
(if ?*debug_flag* then
(printout wsd_fp "(dir_name-file_name-rule_name-id-H_tam_mng  " ?*wsd_dir* "  was_en_tam.clp   was_en_tam4  "  ?id "  yA_gayA_WA )" crlf)
(printout wsd_fp "(dir_name-file_name-rule_name-root_id-TAM-vachan  " ?*wsd_dir* "  was_en_tam.clp   was_en_tam4  "  ?id " were_en p )" crlf))
(assert (id-tam_type ?id passive))
)



;Added by Meena(20.4.10)
;Someone laughed suddenly and the spell was broken .
(defrule was_en_tam5
(declare (salience 0))
;(declare (salience 4800))
(id-TAM ?id was_en)
?mng <-(meaning_to_be_decided ?id)
(id-word ?id1 spell)
(kriyA-subject ?id ?id1)
=>
(retract ?mng)
;(assert (id-E_tam-H_tam_mng ?id was_en yA_huA_WA))
(assert (id-E_tam-H_tam_mng ?id was_en 0_gayA_WA))
(if ?*debug_flag* then
(printout wsd_fp "(dir_name-file_name-rule_name-id-H_tam_mng  " ?*wsd_dir* "  was_en_tam.clp    was_en_tam5  "  ?id "  0_gayA_WA )" crlf))
(assert (id-tam_type ?id passive))
)




;Modified by Meena(1.8.11)
;Uttar pradesh is a land of cultural and geographical diversity, which is blessed by an innumerable perennial rivers, dense forests, and fertile soil. 
;The fruit is eaten by the child.
(defrule was_en_tam6
(declare (salience 4800))
(id-TAM ?id was_en)
?mng <-(meaning_to_be_decided ?id)
(id-root =(+ ?id 1) as|by|for|of)
(id-root  ?id ?root)
=>
;(retract ?mng)
(if (eq ?root bless) then
        (assert (id-E_tam-H_tam_mng ?id was_en WA ))       
        (retract ?mng)
(if ?*debug_flag* then
(printout wsd_fp "(dir_name-file_name-rule_name-id-H_tam_mng   " ?*wsd_dir* "  was_en_tam.clp      was_en_tam6   "  ?id "  WA )" crlf)
)
else
(retract ?mng)
(assert (id-E_tam-H_tam_mng ?id was_en yA_gayA_WA))
(if ?*debug_flag* then
(printout wsd_fp "(dir_name-file_name-rule_name-id-H_tam_mng  " ?*wsd_dir* "  was_en_tam.clp     was_en_tam2  "  ?id "  yA_gayA_WA )" crlf))
(assert (id-tam_type ?id passive))
))

;@@@ Added by Pramila(BU) on 13-02-2014
;Tiredness was etched on his face.   ;oald
;थकान उसके चेहरे पर साफ झलक रही थी.
(defrule was_en_tam7
(declare (salience 4800))
(id-TAM ?id was_en)
?mng <-(meaning_to_be_decided ?id)
(kriyA-on_saMbanXI  ?id ?id1)
(viSeRya-RaRTI_viSeRaNa  ?id1 ?id2)
(id-root ?id2 ?str&:(and (not (numberp ?str))(gdbm_lookup_p "human.gdbm" ?str)))
(id-root ?id etch)
=>
(retract ?mng)
(assert (id-E_tam-H_tam_mng ?id was_en 0_rahA_WA))
(if ?*debug_flag* then
(printout wsd_fp "(dir_name-file_name-rule_name-id-H_tam_mng  " ?*wsd_dir* "  was_en_tam.clp    was_en_tam7  "  ?id "  0_rahA_WA )" crlf))
(assert (id-tam_type ?id passive))
)


;@@@ Added by Prachi Rathore[17-2-14]
;She was terrified on seeing the terrific scene in the cinema.[shiksharthi-kosh]
;वह चलचित्र में भयानक दृश्य को देखने पर डर गयी थी .  
(defrule was_en_tam8
(declare (salience 4800))
(id-TAM ?id was_en)
?mng <-(meaning_to_be_decided ?id)
(kriyA-karma ?id ?id1)
(id-root ?id terrify)
=>
(retract ?mng)
(assert (id-E_tam-H_tam_mng ?id was_en 0_gayA_WA))
(if ?*debug_flag* then
(printout wsd_fp "(dir_name-file_name-rule_name-id-H_tam_mng  " ?*wsd_dir* "  was_en_tam.clp    was_en_tam8  "  ?id "  0_gayA_WA )" crlf))
(assert (id-tam_type ?id passive))
)


;@@@ Added by Prachi Rathore[5-3-14]
;Our team was thrashed 18-0.[shiksharthi-kosh]
;हमारी टीम 18 के मुकाबले 0 से हार गयी 
(defrule was_en_tam9
(declare (salience 4800))
(id-TAM ?id was_en)
?mng <-(meaning_to_be_decided ?id)
(kriyA-karma ?id ?id1)
(id-root ?id thrash)
=>
(retract ?mng)
(assert (id-E_tam-H_tam_mng ?id was_en yA))
(if ?*debug_flag* then
(printout wsd_fp "(dir_name-file_name-rule_name-id-H_tam_mng  " ?*wsd_dir* "  was_en_tam.clp    was_en_tam999999999  "  ?id "  yA )" crlf))
(assert (id-tam_type ?id passive))
)
