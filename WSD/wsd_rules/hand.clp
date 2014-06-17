
(defrule hand0
(declare (salience 5000))
(id-root ?id hand)
?mng <-(meaning_to_be_decided ?id)
(id-word ?id handed )
(id-cat_coarse ?id adjective)
=>
(retract ?mng)
(assert (id-wsd_word_mng ?id hAWoM_vAlA))
(if ?*debug_flag* then
(printout wsd_fp "(dir_name-file_name-rule_name-id-wsd_word_mng  " ?*wsd_dir* "  hand.clp  	hand0   "  ?id "  hAWoM_vAlA )" crlf))
)

;"handed","Adj","1.hAWoM vAlA"
;vaha KAlI"handed"hE 
;
;
;$$$ MODIFIED BY PRACHI RATHORE
;SALIENCE REDUCED FROM 4900 TO 200
(defrule hand1
;(declare (salience 4900))
(declare (salience 200))
(id-root ?id hand)
?mng <-(meaning_to_be_decided ?id)
(id-word ?id handed )
(id-cat_coarse ?id verb)
=>
(retract ?mng)
(assert (id-wsd_root_mng ?id xe))
;(assert (id-H_vib_mng ?id ed_en)) ;Suggested by Sukhada(20-05-13)
(if ?*debug_flag* then
(printout wsd_fp "(dir_name-file_name-rule_name-id-wsd_root_mng  " ?*wsd_dir* "  hand.clp  	hand1   "  ?id "  xe )" crlf)
;(printout wsd_fp "(dir_name-file_name-rule_name-id-H_vib_mng  " ?*wsd_dir* "  hand.clp       hand1   "  ?id " ed_en)" crlf))
))

(defrule hand2
(declare (salience 4800))
(id-root ?id hand)
?mng <-(meaning_to_be_decided ?id)
(id-word ?id1 down)
(kriyA-upasarga ?id ?id1)
(kriyA-object ?id ?)
(id-cat_coarse ?id verb)
=>
(retract ?mng)
(assert (affecting_id-affected_ids-wsd_group_root_mng ?id ?id1 Age_baDZA))
(if ?*debug_flag* then
(printout wsd_fp "(dir_name-file_name-rule_name-affecting_id-affected_ids-wsd_group_root_mng   " ?*wsd_dir* " hand.clp	hand2  "  ?id "  " ?id1 "  Age_baDZA  )" crlf))
)

;One generation handed down to another
;eka pIDZI xUsarI pIDZI ko Age baDZAwI hE
(defrule hand3
(declare (salience 4700))
(id-root ?id hand)
?mng <-(meaning_to_be_decided ?id)
(id-word ?id1 in)
(kriyA-upasarga ?id ?id1)
(kriyA-object ?id ?)
(id-cat_coarse ?id verb)
=>
(retract ?mng)
(assert (affecting_id-affected_ids-wsd_group_root_mng ?id ?id1 xe))
(if ?*debug_flag* then
(printout wsd_fp "(dir_name-file_name-rule_name-affecting_id-affected_ids-wsd_group_root_mng   " ?*wsd_dir* " hand.clp	hand3  "  ?id "  " ?id1 "  xe  )" crlf))
)

;Please hand in this book to my teacher.
;kqpyA yaha kiwAba mere SikRaka ko xe xenA
(defrule hand4
(declare (salience 4600))
(id-root ?id hand)
?mng <-(meaning_to_be_decided ?id)
(id-word ?id1 on)
(kriyA-upasarga ?id ?id1)
(kriyA-object ?id ?)
(id-cat_coarse ?id verb)
=>
(retract ?mng)
(assert (affecting_id-affected_ids-wsd_group_root_mng ?id ?id1 xe))
(if ?*debug_flag* then
(printout wsd_fp "(dir_name-file_name-rule_name-affecting_id-affected_ids-wsd_group_root_mng   " ?*wsd_dir* " hand.clp	hand4  "  ?id "  " ?id1 "  xe  )" crlf))
)

;Please hand in this book to my teacher.
;kqpyA yaha kiwAba mere SikRaka ko xe xenA
(defrule hand5
(declare (salience 4500))
(id-root ?id hand)
?mng <-(meaning_to_be_decided ?id)
(id-word ?id1 out)
(kriyA-upasarga ?id ?id1)
(kriyA-object ?id ?)
(id-cat_coarse ?id verb)
=>
(retract ?mng)
(assert (affecting_id-affected_ids-wsd_group_root_mng ?id ?id1 xe))
(if ?*debug_flag* then
(printout wsd_fp "(dir_name-file_name-rule_name-affecting_id-affected_ids-wsd_group_root_mng   " ?*wsd_dir* " hand.clp	hand5  "  ?id "  " ?id1 "  xe  )" crlf))
)

;Please hand in this book to my teacher.
;kqpyA yaha kiwAba mere SikRaka ko xe xenA
(defrule hand6
(declare (salience 4400))
(id-root ?id hand)
?mng <-(meaning_to_be_decided ?id)
(id-word ?id1 over)
(kriyA-upasarga ?id ?id1)
(kriyA-object ?id ?)
(id-cat_coarse ?id verb)
=>
(retract ?mng)
(assert (affecting_id-affected_ids-wsd_group_root_mng ?id ?id1 xe))
(if ?*debug_flag* then
(printout wsd_fp "(dir_name-file_name-rule_name-affecting_id-affected_ids-wsd_group_root_mng   " ?*wsd_dir* " hand.clp	hand6  "  ?id "  " ?id1 "  xe  )" crlf))
)

;Please hand in this book to my teacher.
;kqpyA yaha kiwAba mere SikRaka ko xe xenA
(defrule hand7
(declare (salience 4300))
(id-root ?id hand)
?mng <-(meaning_to_be_decided ?id)
(id-cat_coarse ?id noun)
=>
(retract ?mng)
(assert (id-wsd_root_mng ?id hAWa))
(if ?*debug_flag* then
(printout wsd_fp "(dir_name-file_name-rule_name-id-wsd_root_mng   " ?*wsd_dir* "  hand.clp 	hand7   "  ?id "  hAWa )" crlf))
)

;"hand","N","1.hAWa"
;My hand is clean .
;merA hAWa sAPa hE .
;--"2.GadZI_kI_suI"
;He broke the clock's hands.
;usane GadZI kI suI wodZa xI.
;

;$$$ MODIFIED BY PRACHI RATHORE
;SALIENCE REDUCED FROM 4200 TO 100
(defrule hand8
(declare (salience 100))
(id-root ?id hand)
?mng <-(meaning_to_be_decided ?id)
(id-cat_coarse ?id verb)
=>
(retract ?mng)
(assert (id-wsd_root_mng ?id xe))
(assert (kriyA_id-object_viBakwi ?id ko))
(if ?*debug_flag* then
(printout wsd_fp "(dir_name-file_name-rule_name-id-wsd_root_mng   " ?*wsd_dir* "  hand.clp 	hand8   "  ?id "  xe )" crlf)
(printout wsd_fp "(dir_name-file_name-rule_name-kriyA_id-object_viBakwi   " ?*wsd_dir* "  hand.clp      hand8   "  ?id " ko )" crlf)
)
)


;@@@ Added by Prachi Rathore[21-1-14]
;I'll hand you over to my boss.[OALD]
;मैं मेरे बॉस को आपको सौंप दूँगा . 
(defrule hand9
(declare (salience 4500))
(id-root ?id hand)
?mng <-(meaning_to_be_decided ?id)
(id-cat_coarse ?id verb)
(kriyA-upasarga ?id ?id1)
(id-word ?id1 over)
(kriyA-object ?id ?id2)
(id-root ?id2 ?str&:(and (not (numberp ?str))(gdbm_lookup_p "animate.gdbm" ?str)))
=>
(retract ?mng)
(assert (affecting_id-affected_ids-wsd_group_root_mng ?id ?id1 sOMpa_xe))
(if ?*debug_flag* then
(printout wsd_fp "(dir_name-file_name-rule_name-affecting_id-affected_ids-wsd_group_root_mng   " ?*wsd_dir* " hand.clp	hand9  "  ?id "  " ?id1 "  sOMpa_xe  )" crlf))
)

;@@@ Added by Prachi Rathore[21-1-14]
;Most of his clothes were handed down to him by his older brother.[OALD]
;उसके अधिकतर वस्त्र उसके भाई  द्वारा उसको दिये गये थे . 
(defrule hand10
(declare (salience 4500))
(id-root ?id hand)
?mng <-(meaning_to_be_decided ?id)
(id-cat_coarse ?id verb)
(kriyA-upasarga ?id ?id1)
(id-word ?id1 down)
=>
(retract ?mng)
(assert (affecting_id-affected_ids-wsd_group_root_mng ?id ?id1 xe))
(if ?*debug_flag* then
(printout wsd_fp "(dir_name-file_name-rule_name-affecting_id-affected_ids-wsd_group_root_mng   " ?*wsd_dir* " hand.clp	hand10  "  ?id "  " ?id1 "  xe  )" crlf))
)

;@@@ Added by Prachi Rathore[21-1-14]
;She picked up the wallet and handed it back to him.[OALS]
;उसने बटुआ उठाया और उसको वापस दिया . 
(defrule hand11
(declare (salience 4500))
(id-root ?id hand)
?mng <-(meaning_to_be_decided ?id)
(id-cat_coarse ?id verb)
(kriyA-upasarga ?id ?id1)
(id-word ?id1 back)
=>
(retract ?mng)
(assert (affecting_id-affected_ids-wsd_group_root_mng ?id ?id1 vApasa_xe))
(if ?*debug_flag* then
(printout wsd_fp "(dir_name-file_name-rule_name-affecting_id-affected_ids-wsd_group_root_mng   " ?*wsd_dir* " hand.clp	hand11  "  ?id "  " ?id1 "  vApasa_xe  )" crlf))
)

;@@@ Added by Prachi Rathore[21-1-14]
;She handed the job off to her assistant.[M-W]
;उसने उसके सहायक को काम दिया . 
(defrule hand12
(declare (salience 4500))
(id-root ?id hand)
?mng <-(meaning_to_be_decided ?id)
(id-cat_coarse ?id verb)
(kriyA-upasarga ?id ?id1)
(id-word ?id1 off)
=>
(retract ?mng)
(assert (affecting_id-affected_ids-wsd_group_root_mng ?id ?id1 xe))
(if ?*debug_flag* then
(printout wsd_fp "(dir_name-file_name-rule_name-affecting_id-affected_ids-wsd_group_root_mng   " ?*wsd_dir* " hand.clp	hand12  "  ?id "  " ?id1 " xe  )" crlf))
)


;@@@ Added by Prachi Rathore[21-1-14]
;The neighbours are always willing to lend a hand.[OALD]
;पडोसी सहायता प्रदान करने को हमेशा उद्यत हैं . 
(defrule hand13
(declare (salience 4500))
(id-root ?id hand)
?mng <-(meaning_to_be_decided ?id)
(id-cat_coarse ?id noun)
(or (kriyA-object  ?id1 ?id)(kriyA-object_2  ?id1 ?id))
;(viSeRya-det_viSeRaNa  ?id ?)
(id-root ?id1 give|lend|need)
=>
(retract ?mng)
(assert (id-wsd_root_mng ?id sahAyawA))
(if ?*debug_flag* then
(printout wsd_fp "(dir_name-file_name-rule_name-id-wsd_root_mng   " ?*wsd_dir* "  hand.clp 	hand13   "  ?id "  sahAyawA )" crlf))
)

;@@@ Added by Prachi Rathore[21-1-14]
;The judge has handed down his verdict.
;न्यायाधीश ने उसका फैसला सुना दिया है . 
(defrule hand14
(declare (salience 5000))
(id-root ?id hand)
?mng <-(meaning_to_be_decided ?id)
(id-cat_coarse ?id verb)
(kriyA-upasarga ?id ?id1)
(id-word ?id1 down)
(kriyA-object  ?id ?id2)
(id-root ?id2  verdict)
=>
(retract ?mng)
(assert (affecting_id-affected_ids-wsd_group_root_mng ?id ?id1 sunA_xe))
(if ?*debug_flag* then
(printout wsd_fp "(dir_name-file_name-rule_name-affecting_id-affected_ids-wsd_group_root_mng   " ?*wsd_dir* " hand.clp	hand14  "  ?id "  " ?id1 "  sunA_xe  )" crlf))
)

;"hand","V","1.xenA"
;The tenant handed the house keys to the landlord .
;kirAyexAra ne Gara kI cAbiyAz makAnamAlika ko xe xIM . 
;
