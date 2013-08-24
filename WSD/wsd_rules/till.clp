
(defrule till0
(declare (salience 5000))
(id-root ?id till)
?mng <-(meaning_to_be_decided ?id)
(id-cat_coarse ?id noun)
=>
(retract ?mng)
(assert (id-wsd_root_mng ?id golaka))
(if ?*debug_flag* then
(printout wsd_fp "(dir_name-file_name-rule_name-id-wsd_root_mng   " ?*wsd_dir* "  till.clp 	till0   "  ?id "  golaka )" crlf))
)

;"till","N","1.golaka"
;The pawn-broker keeps the money in the till.
;
(defrule till1
(declare (salience 4900))
(id-root ?id till)
?mng <-(meaning_to_be_decided ?id)
(id-cat_coarse ?id verb)
=>
(retract ?mng)
(assert (id-wsd_root_mng ?id Kewa_jowa))
(if ?*debug_flag* then
(printout wsd_fp "(dir_name-file_name-rule_name-id-wsd_root_mng   " ?*wsd_dir* "  till.clp 	till1   "  ?id "  Kewa_jowa )" crlf))
)

;"till","VT","1.Kewa_jowanA"
;The farmer tills the land.
;

;Added by Abhinav Gupta (IIT BHU) , 5-7-2013 .
;She stayed up till 2.
;Come home till 10 at night.
(defrule till2
(declare (salience 4850))
(id-root ?id till)
?mng <-(meaning_to_be_decided ?id)
(id-cat_coarse =(+ ?id 1) number)
(id-cat_coarse ?id preposition)
=>
(retract ?mng)
(assert (id-wsd_root_mng ?id waka))
(if ?*debug_flag* then
(printout wsd_fp "(dir_name-file_name-rule_name-id-wsd_root_mng   " ?*wsd_dir* "  till.clp 	till2   "  ?id "  waka )" crlf))
)


;Added by Shirisha Manju (15-08-13)
;Everything was fine till she came home.
;We will do nothing till you get those prosecutions done.
;We will not do anything till you get those prosecutions done.
;We'll feed you till you are stuffed.
;I want to live to hear music till i am dead.
;I will wait here till you come.
(defrule till3
(declare (salience 4700))
(id-root ?id till)
?mng <-(meaning_to_be_decided ?id)
(id-cat_coarse ?id conjunction)
=>
(retract ?mng)
(assert (id-wsd_root_mng ?id jabawaka))
(if ?*debug_flag* then
(printout wsd_fp "(dir_name-file_name-rule_name-id-wsd_root_mng   " ?*wsd_dir* "  till.clp 	till3   "  ?id "  jabawaka )" crlf))
)

