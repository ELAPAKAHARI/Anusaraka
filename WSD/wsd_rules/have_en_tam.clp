 ;Added by sheetal(18-01-10).
(defrule have_en_tam0
(declare (salience 5000))
(id-TAM ?id have_en)
?mng <-(meaning_to_be_decided ?id)
(id-root ?id1 way)
(id-root =(- ?id1 1) the)
=>
(retract ?mng)
(assert (id-E_tam-H_tam_mng ?id have_en yA_hE))
(if ?*debug_flag* then
(printout wsd_fp "(dir_name-file_name-rule_name-id-H_tam_mng  " ?*wsd_dir* "  have_en_tam.clp        have_en_tam0  "  ?id "  yA_hE )" crlf))
)
;Do it the way you have always done it .

