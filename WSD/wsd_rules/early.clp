
(defrule early0
(declare (salience 5000))
(id-root ?id early)
?mng <-(meaning_to_be_decided ?id)
(id-word ?id earlier )
(id-cat_coarse ?id adjective)
=>
(retract ?mng)
(assert (id-wsd_word_mng ?id pahale_kA))
(if ?*debug_flag* then
(printout wsd_fp "(dir_name-file_name-rule_name-id-wsd_word_mng  " ?*wsd_dir* "  early.clp  	early0   "  ?id "  pahale_kA )" crlf))
)

; earlier version
(defrule early1
(declare (salience 4900))
(id-root ?id early)
?mng <-(meaning_to_be_decided ?id)
(id-word ?id earlier )
(id-cat_coarse ?id adverb)
=>
(retract ?mng)
(assert (id-wsd_word_mng ?id isase_pahale))
(if ?*debug_flag* then
(printout wsd_fp "(dir_name-file_name-rule_name-id-wsd_word_mng  " ?*wsd_dir* "  early.clp  	early1   "  ?id "  isase_pahale )" crlf))
)

;"earlier","Adv","1.pahale_[kA]"
;The workers went on vacation earlier in this season.
;
;Rules generated by wasp machine
(defrule early2
(declare (salience 4800))
(id-root ?id early)
?mng <-(meaning_to_be_decided ?id)
(id-word ?id earliest )
(id-cat_coarse ?id adjective)
=>
(retract ?mng)
(assert (id-wsd_word_mng ?id SurU_SurU_meM))
(if ?*debug_flag* then
(printout wsd_fp "(dir_name-file_name-rule_name-id-wsd_word_mng  " ?*wsd_dir* "  early.clp  	early2   "  ?id "  SurU_SurU_meM )" crlf))
)



;Added by Meena(6.9.10)
;The project will start early next month .
(defrule early3
(declare (salience 4600))
(id-root ?id early)
?mng <-(meaning_to_be_decided ?id)
(or(kriyA-kAlavAcI  ?id1 ?kAlv)(kriyA-in_saMbanXI  ?id1 ?saM))  
(not(or(id-root ?kAlv morning|evening|night)(id-root ?saM morning|evening|night)))
(kriyA-kriyA_viSeRaNa  ?id1 ?id)
=>
(retract ?mng)
(assert (id-wsd_root_mng ?id SurU_meM))
(if ?*debug_flag* then
(printout wsd_fp "(dir_name-file_name-rule_name-id-wsd_root_mng   " ?*wsd_dir* "  early.clp     early3   "  ?id " SurU_meM  )" crlf))
)



;Added by Meena(6.9.10)
;I got up early in the morning . 
(defrule early4
(declare (salience 4600))
(id-root ?id early)
?mng <-(meaning_to_be_decided ?id)
(or(kriyA-in_saMbanXI  ?id1 ?saM)(kriyA-kAlavAcI  ?id1 ?kAlv))
(not(or(id-root ?kAlv month|year|week)(id-root ?saM month|year|week)))
(kriyA-kriyA_viSeRaNa  ?id1 ?id)
=>
(retract ?mng)
(assert (id-wsd_root_mng ?id jalxI))
(if ?*debug_flag* then
(printout wsd_fp "(dir_name-file_name-rule_name-id-wsd_root_mng   " ?*wsd_dir* "  early.clp     early4   "  ?id "  jalxI )" crlf))
)



;Salience reduced and meaning changed by Meena(6.9.10)
(defrule early5
(declare (salience 0))
(id-root ?id early)
?mng <-(meaning_to_be_decided ?id)
(id-cat_coarse ?id adverb)
=>
(retract ?mng)
(assert (id-wsd_root_mng ?id jalxI))
(if ?*debug_flag* then
(printout wsd_fp "(dir_name-file_name-rule_name-id-wsd_root_mng   " ?*wsd_dir* "  early.clp 	early5   "  ?id "  jalxI )" crlf))
)


;"early","Adv","1.jalxI"
;He has to go to school early today .



;Modified by Meena(23.9.10)
;Added by Meena(7.9.10)
;These are some of my early attempts at sculpture .
;He must get up early in the morning .
(defrule early6
(declare (salience 4700))
(id-root ?id early)
?mng <-(meaning_to_be_decided ?id)
(viSeRya-viSeRaNa ?id1 ?id)
(id-word ?id1 ?word)
=>
(retract ?mng)
(if (eq ?word morning) then
    (assert (id-wsd_root_mng ?id jalxI))
else	;Added else statement and moved assert statement into else part ( by Roja(12-09-13) )
(assert (id-wsd_root_mng ?id prAramBika))
)
(if ?*debug_flag* then
(if (eq ?word morning) then
        (printout wsd_fp "(dir_name-file_name-rule_name-id-wsd_root_mng   " ?*wsd_dir* "  early.clp      early6   "  ?id "  jalxI )" crlf)
else
(printout wsd_fp "(dir_name-file_name-rule_name-id-wsd_root_mng   " ?*wsd_dir* "  early.clp     early6   "  ?id " prAramBika  )" crlf)
)
))


;Added by Meena(7.9.10)
;We meet the hero quite early in the film . 
(defrule early7
(declare (salience 4700))
(id-root ?id early)
?mng <-(meaning_to_be_decided ?id)
(viSeRaNa-viSeRaka ?id ?id1)
;(viSeRya-in_saMbanXI  ?id ?)
=>
(retract ?mng)
(assert (id-wsd_root_mng ?id AramBa_meM))
(if ?*debug_flag* then
(printout wsd_fp "(dir_name-file_name-rule_name-id-wsd_root_mng   " ?*wsd_dir* "  early.clp     early7   "  ?id " AramBa_meM  )" crlf))
)



;Added by Meena(7.9.10)
(defrule early8
(declare (salience 0))
(id-root ?id early)
?mng <-(meaning_to_be_decided ?id)
(id-cat_coarse ?id adjective)
=>
(retract ?mng)
(assert (id-wsd_root_mng ?id AramBika))
(if ?*debug_flag* then
(printout wsd_fp "(dir_name-file_name-rule_name-id-wsd_root_mng   " ?*wsd_dir* "  early.clp     early8   "  ?id " AramBika  )" crlf))
)



;

;@@@ Added by Sukhada (12-05-14). Automatically generated this rule.
(defrule sub_samA_early6
(declare (salience 4700))
(id-root ?id early)
?mng <-(meaning_to_be_decided ?id)
(subject-subject_samAnAXikaraNa ?id1 ?id)
(id-word ?id1 ?word)
=>
(retract ?mng)
(if (eq ?word morning) then
    (assert (id-wsd_root_mng ?id jalxI))
else	;Added else statement and moved assert statement into else part ( by Roja(12-09-13) )
(assert (id-wsd_root_mng ?id prAramBika))
)
(if ?*debug_flag* then
(if (eq ?word morning) then
        (printout wsd_fp "(dir_name-file_name-rule_name-id-wsd_root_mng   " ?*wsd_dir* "  early.clp      early6   "  ?id "  jalxI )" crlf)
else
(printout wsd_fp "(dir_name-file_name-rule_name-id-wsd_root_mng " ?*wsd_dir* " early.clp   sub_samA_early6   "   ?id " prAramBika )" crlf)
)
))

;@@@ Added by Sukhada (12-05-14). Automatically generated this rule.
(defrule obj_samA_early6
(declare (salience 4700))
(id-root ?id early)
?mng <-(meaning_to_be_decided ?id)
(object-object_samAnAXikaraNa ?id1 ?id)
(id-word ?id1 ?word)
=>
(retract ?mng)
(if (eq ?word morning) then
    (assert (id-wsd_root_mng ?id jalxI))
else	;Added else statement and moved assert statement into else part ( by Roja(12-09-13) )
(assert (id-wsd_root_mng ?id prAramBika))
)
(if ?*debug_flag* then
(if (eq ?word morning) then
        (printout wsd_fp "(dir_name-file_name-rule_name-id-wsd_root_mng   " ?*wsd_dir* "  early.clp      early6   "  ?id "  jalxI )" crlf)
else
(printout wsd_fp "(dir_name-file_name-rule_name-id-wsd_root_mng " ?*wsd_dir* " early.clp   obj_samA_early6   "   ?id " prAramBika )" crlf)
)
))
