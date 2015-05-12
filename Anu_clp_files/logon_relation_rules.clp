(defglobal ?*fp* = open-file)
(defglobal ?*fp1* = open-file1)
(defglobal ?*dbug* = debug_fp)

 (deffunction find_sub-str_before_last_underscore (?str)
 (bind ?len 0)(bind ?len1 0)
 (bind ?str1 ?str)
 (bind ?str_len (length ?str))
 (while (neq (str-index "_" ?str) FALSE)
 (bind ?index (str-index "_" ?str))
 (bind ?str (sub-string (+ ?index (+ ?len 1)) ?str_len ?str1) )
 (bind ?len (+ ?index ?len))
 )
 (bind ?str4 (sub-string 1 (- ?len 1) ?str1))
 (bind ?str2 ?str4)
 (if (neq (str-index "_" ?str4) FALSE) then
 (bind ?str4_len (length ?str4))
 (while (neq (str-index "_" ?str4) FALSE)
 (bind ?index1 (str-index "_" ?str4))
 (bind ?str4 (sub-string (+ ?index1 (+ ?len1 1)) ?str4_len ?str2) )
 (bind ?len1 (+ ?index1 ?len1))
 ))
 (printout t ?str4 crlf)
 (bind ?str ?str4)
 )

 (deffunction find_sub-str_after_last_underscore (?str)
 (bind ?len 0)(bind ?len1 0)
 (bind ?str1 ?str)
 (bind ?str_len (length ?str))
 (while (neq (str-index "_" ?str) FALSE)
 (bind ?index (str-index "_" ?str))
 (bind ?str (sub-string (+ ?index (+ ?len 1)) ?str_len ?str1) )
 (bind ?len (+ ?index ?len))
 )
 (bind ?str (sub-string (+ ?len 1) ?str_len ?str1))
 )


 ;------------------------------------------------------------------------------------------------------------------------
 ;Eg: He has been frequently coming.
 ;e3:_come_v_1<23:30>[ARG1 x5] ==> (relation_name-id-args_with_ids _come_v_1 5 ARG0 e3 5 ARG1 x5 1)
 (defrule kriyA_sub_rule
 (relation_name-id-args_with_ids ?rel  ?kriyA  ARG0 ?  ?kriyA  ARG1 ? ?sub $?) 
 (test (eq (find_sub-str_before_last_underscore ?rel) "v"))
 (test (neq (find_sub-str_after_last_underscore ?rel) "modal"))
 (test (neq (find_sub-str_after_last_underscore ?rel) "there"));[There] was a red mark on the door.
 =>
 (printout       ?*fp*   "(kriyA-subject    "?kriyA"	"?sub")"crlf)
 (printout       ?*fp1*   "(prep_id-relation-anu_ids  -     kriyA-subject    "?kriyA"	"?sub")"crlf)
 (printout       ?*dbug* "(prep_id-Rule-Rel-ids  -   kriyA_sub_rule   kriyA-subject   "?kriyA"	"?sub")"crlf)
 )
 ;------------------------------------------------------------------------------------------------------------------------
 (defrule kriyA_obj_rule
 (relation_name-id-args_with_ids ?rel  ?kriyA  ARG0 ?  ?kriyA  ARG1 ? ?sub ARG2 ? ?obj $?)
 (test (eq (find_sub-str_before_last_underscore ?rel) "v"))
 (test (neq (find_sub-str_after_last_underscore ?rel) "modal"))
 (id-word ?obj ~what) ;[What] is the purpose of Dharma?
 =>
 (printout       ?*fp*   "(kriyA-object     "?kriyA"	"?obj")"crlf)
 (printout       ?*fp1*   "(prep_id-relation-anu_ids  -   kriyA-object	"?kriyA"	"?obj")"crlf)
 (printout       ?*dbug* "(prep_id-Rule-Rel-ids   -	kriyA_obj_rule	kriyA-object	"?kriyA"	"?obj")"crlf)
 )
 ;------------------------------------------------------------------------------------------------------------------------
 ;Eg: He has been frequently coming.
 ;e9:_frequent_a_1<12:22>[ARG1 e3] ==>  (relation_name-id-args_with_ids _frequent_a_1 4 ARG0 e9 4 ARG1 e3 5)
 (defrule kriyA-kriyA_viSeRaNa_rule
 (relation_name-id-args_with_ids ?rel  ?kriyA_viSeRaNa  ARG0 ?  ?kriyA_viSeRaNa  ARG1 ? ?kriyA $?)
 (test (eq (sub-string  (length (sub-string 4 (length ?rel) ?rel)) (length ?rel) ?rel) "_a_1"))
 (id-logon_cat  ?kriyA VBG)
 =>
 (printout       ?*fp*   "(kriyA-kriyA_viSeRaNa    "?kriyA"	"?kriyA_viSeRaNa")"crlf)
 (printout       ?*fp1*   "(prep_id-relation-anu_ids  -     kriyA-kriyA_viSeRaNa    "?kriyA"	"?kriyA_viSeRaNa")"crlf)
 (printout       ?*dbug* "(prep_id-Rule-Rel-ids  -   kriyA-kriyA_viSeRaNa_rule   kriyA-kriyA_viSeRaNa   "?kriyA"	"?kriyA_viSeRaNa")"crlf)
 )
 ;------------------------------------------------------------------------------------------------------------------------
 ;Eg: Rama is a good boy.
 ;e14:_good_a_at-for-of<10:14>[ARG1 x9] ==> (relation_name-id-args_with_ids _good_a_at-for-of  4 ARG0 e14  4  ARG1 x9 5 )
 (defrule viSeRya-viSeRaNa_rule
 (relation_name-id-args_with_ids ?rel&~def_implicit_q  ?viSeRaNa  ARG0 ?  ?viSeRaNa  ARG1 ? ?viSeRya $?)
 (test (or (eq (sub-string  (length (sub-string 12 (length ?rel) ?rel)) (length ?rel) ?rel) "_a_at-for-of")(eq (sub-string  (length (sub-string 4 (length ?rel) ?rel)) (length ?rel) ?rel) "_a_1")(eq (sub-string  (length (sub-string 2 (length ?rel) ?rel)) (length ?rel) ?rel) "_a")))
 (test (neq ?viSeRya ?viSeRaNa));I went there with my mother.;[This job] will not take much effort. 
 =>
 (printout       ?*fp*   "(viSeRya-viSeRaNa    "?viSeRya"	"?viSeRaNa")"crlf)
 (printout       ?*fp1*   "(prep_id-relation-anu_ids  -     viSeRya-viSeRaNa    "?viSeRya"	"?viSeRaNa")"crlf)
 (printout       ?*dbug* "(prep_id-Rule-Rel-ids  -   viSeRya-viSeRaNa_rule   viSeRya-viSeRaNa   "?viSeRya"	"?viSeRaNa")"crlf)
 )
 ;------------------------------------------------------------------------------------------------------------------------
 ; Eg: There was a marked difference in the prices of dishes.
 ; e9:_mark_v_1<12:18>[ARG2 x4] ==> (relation_name-id-args_with_ids _mark_v_1  4 ARG0 e9  4  ARG2 x4 5 )
 (defrule  viSeRya-viSeRaNa1
 (relation_name-id-args_with_ids ?rel&~def_implicit_q  ? ARG0 ? ?viSeRaNa  ARG2 ? ?viSeRya)
 =>
 (printout       ?*fp*   "(viSeRya-viSeRaNa    "?viSeRya"       "?viSeRaNa")"crlf)
 (printout       ?*fp1*   "(prep_id-relation-anu_ids  -     viSeRya-viSeRaNa    "?viSeRya"      "?viSeRaNa")"crlf)
 (printout       ?*dbug* "(prep_id-Rule-Rel-ids  -   viSeRya-viSeRaNa_rule1   viSeRya-viSeRaNa   "?viSeRya"      "?viSeRaNa")"crlf)
 )
 ;------------------------------------------------------------------------------------------------------------------------
 ;We had wasted our journey.
 ;_2:def_explicit_q<14:17>[BV x9] ==> (relation_name-id-args_with_ids def_explicit_q  4  BV x9 5 )
 (defrule viSeRya-RaRTI_viSeRaNa_rule
 (relation_name-id-args_with_ids def_explicit_q  ?RaRTI_viSeRaNa  BV ? ?viSeRya)
 =>
 (printout       ?*fp*   "(viSeRya-RaRTI_viSeRaNa    "?viSeRya"       "?RaRTI_viSeRaNa")"crlf)
 (printout       ?*fp1*   "(prep_id-relation-anu_ids  -     viSeRya-RaRTI_viSeRaNa    "?viSeRya"      "?RaRTI_viSeRaNa")"crlf)
 (printout       ?*dbug* "(prep_id-Rule-Rel-ids  -   viSeRya-RaRTI_viSeRaNa_rule   viSeRya-RaRTI_viSeRaNa   "?viSeRya"      "?RaRTI_viSeRaNa")"crlf)
 )
 ;------------------------------------------------------------------------------------------------------------------------
 ;Eg: Rama is a good boy.
 ;e3:_be_v_id<5:7>[ARG1 x6, ARG2 x9] ==> (relation_name-id-args_with_ids _be_v_id 2 ARG0 e3 2 ARG1 x6 1 ARG2 x9 5)
 (defrule subject-subject_samAnAXikaraNa_rule
 (relation_name-id-args_with_ids _be_v_id ?  ARG0 ?  ?  ARG1 ? ?subject ARG2 ? ?subject_samAnAXikaraNa $?)
 =>
 (printout       ?*fp*   "(subject-subject_samAnAXikaraNa   "?subject"	"?subject_samAnAXikaraNa")"crlf)
 (printout       ?*fp1*   "(prep_id-relation-anu_ids  -     subject-subject_samAnAXikaraNa    "?subject"	"?subject_samAnAXikaraNa")"crlf)
 (printout       ?*dbug* "(prep_id-Rule-Rel-ids  -   subject-subject_samAnAXikaraNa_rule   subject-subject_samAnAXikaraNa   "?subject"	"?subject_samAnAXikaraNa")"crlf)
 )
 ;------------------------------------------------------------------------------------------------------------------------
 ;Eg: Rama is a good boy.
 ;_2:_a_q<8:9>[BV x9] ==> (relation_name-id-args_with_ids _a_q 3 BV x9 5)
 (defrule viSeRya-det_viSeRaNa_rule
 (relation_name-id-args_with_ids ?rel&_a_q|_the_q|_this_q_dem  ?det_viSeRaNa  BV ? ?viSeRya)
 (test (neq ?det_viSeRaNa ?viSeRya)) 
 =>
 (printout       ?*fp*   "(viSeRya-det_viSeRaNa    "?viSeRya"	"?det_viSeRaNa")"crlf)
 (printout       ?*fp1*   "(prep_id-relation-anu_ids  -     viSeRya-det_viSeRaNa    "?viSeRya"	"?det_viSeRaNa")"crlf)
 (printout       ?*dbug* "(prep_id-Rule-Rel-ids  -   viSeRya-det_viSeRaNa_rule   viSeRya-det_viSeRaNa   "?viSeRya"	"?det_viSeRaNa")"crlf)
 )
 ;------------------------------------------------------------------------------------------------------------------------
 ;Eg: This is a sample sentence for Anusaraka.
 ;e15:compound<10:25>[ARG1 x9, ARG2 x14] ==> (relation_name-id-args_with_ids compound  5 ARG0 e15  5  ARG1 x9 5  ARG2 x14 4 )
 (defrule samAsa_viSeRya-samAsa_viSeRaNa_rule
 (relation_name-id-args_with_ids compound ?samAsa_viSeRya ARG0 ? ? ARG1 ? ?samAsa_viSeRya ARG2 ? ?samAsa_viSeRaNa)
  =>
 (printout       ?*fp*   "(samAsa_viSeRya-samAsa_viSeRaNa    "?samAsa_viSeRya"	"?samAsa_viSeRaNa")"crlf)
 (printout       ?*fp1*   "(prep_id-relation-anu_ids  -     samAsa_viSeRya-samAsa_viSeRaNa    "?samAsa_viSeRya"	"?samAsa_viSeRaNa")"crlf)
 (printout       ?*dbug* "(prep_id-Rule-Rel-ids  -   samAsa_viSeRya-samAsa_viSeRaNa_rule   samAsa_viSeRya-samAsa_viSeRaNa   "?samAsa_viSeRya"	"?samAsa_viSeRaNa")"crlf)
 )
 ;------------------------------------------------------------------------------------------------------------------------
 ;Eg: This is a sample sentence for Anusaraka.
 ;21:_for_p<26:29>[ARG1 x9, ARG2 x22] ==> (relation_name-id-args_with_ids _for_p  6 ARG0 e21  6  ARG1 x9 5  ARG2 x22 7 )
 (defrule viSeRya-prep_saMbanXI_rule
 (relation_name-id-args_with_ids ?rel  ? ARG0 ? ?prep  ARG1 ? ?viSeRya  ARG2 ? ?prep_saMbanXI )
 (test (eq (sub-string  (length (sub-string 2 (length ?rel) ?rel)) (length ?rel) ?rel) "_p"))
 (id-word ?prep ?p_wrd)
 (id-logon_cat  ?viSeRya NN)
  =>
 (printout       ?*fp*   "(viSeRya-"?p_wrd"_saMbanXI    "?viSeRya"	"?prep_saMbanXI")"crlf)
 (printout       ?*fp1*   "(prep_id-relation-anu_ids  "?prep"     viSeRya-"?p_wrd"_saMbanXI    "?viSeRya"	"?prep_saMbanXI")"crlf)
 (printout       ?*dbug* "(prep_id-Rule-Rel-ids  "?prep"   viSeRya-prep_saMbanXI_rule	 viSeRya-"?p_wrd"_saMbanXI   "?viSeRya"	"?prep_saMbanXI")"crlf)
 )
 ;------------------------------------------------------------------------------------------------------------------------
 ;He heard the sound of rain from the kitchen.
 ;x9:_sound_n_of<13:18>[ARG1 x14] ==> (relation_name-id-args_with_ids _sound_n_of  4 ARG0 x9  4  ARG1 x14 6 )
 (defrule viSeRya-prep_saMbanXI_rule1
 (relation_name-id-args_with_ids ?rel  ? ARG0 ? ?viSeRya ARG1 ? ?prep_saMbanXI)
 (test (eq (find_sub-str_before_last_underscore ?rel) "n"))
 (id-word ?prep ?p_wrd)
 (test (eq (string-to-field (find_sub-str_after_last_underscore ?rel)) ?p_wrd))
  =>
 (printout       ?*fp*   "(viSeRya-"?p_wrd"_saMbanXI    "?viSeRya"      "?prep_saMbanXI")"crlf)
 (printout       ?*fp1*   "(prep_id-relation-anu_ids  "?prep"     viSeRya-"?p_wrd"_saMbanXI    "?viSeRya"       "?prep_saMbanXI")"crlf)
 (printout       ?*dbug* "(prep_id-Rule-Rel-ids  "?prep"   viSeRya-prep_saMbanXI_rule1    viSeRya-"?p_wrd"_saMbanXI   "?viSeRya" "?prep_saMbanXI")"crlf)
 )
 ;------------------------------------------------------------------------------------------------------------------------
 ;Eg: I will give up smoking. 
 ;e3:_give_v_up<7:11>[ARG1 x5, ARG2 x9] ==> (relation_name-id-args_with_ids _give_v_up  3 ARG0 e3  3  ARG1 x5 1  ARG2 x9 5 ) 
 (defrule kriyA-upasarga_rule
 (relation_name-id-args_with_ids ?rel  ? ARG0 ? ?kriyA $?)
 (test (eq (find_sub-str_before_last_underscore ?rel) "v"))
 (id-word ?u_id ?upasarga)
 (test (eq (string-to-field (find_sub-str_after_last_underscore ?rel)) ?upasarga))
 (test (> ?u_id ?kriyA))
 =>
 (printout       ?*fp*   "(kriyA-upasarga    "?kriyA"      "?u_id")"crlf)
 (printout       ?*fp1*   "(prep_id-relation-anu_ids  -     kriyA-upasarga    "?kriyA"       "?u_id")"crlf)
 (printout       ?*dbug* "(prep_id-Rule-Rel-ids  -   kriyA-upasarga_rule    kriyA-upasarga   "?kriyA" "?u_id")"crlf)
 )
 ;------------------------------------------------------------------------------------------------------------------------
 ;Eg: All are going to school.
 ;e9:_to_p<14:16>[ARG1 e3, ARG2 x10] ==> (relation_name-id-args_with_ids _to_p  4 ARG0 e9  4  ARG1 e3 3  ARG2 x10 5 )
 (defrule kriyA-prep_saMbanXI_rule
 (relation_name-id-args_with_ids ?rel  ? ARG0 ? ?prep  ARG1 ? ?kriyA  ARG2 ? ?prep_saMbanXI )
 (test (or (eq (sub-string  (length (sub-string 2 (length ?rel) ?rel)) (length ?rel) ?rel) "_p")(eq (sub-string  (length (sub-string 6 (length ?rel) ?rel)) (length ?rel) ?rel) "_p_dir")))
 (id-word ?prep ?p_wrd)
 (id-logon_cat  ?kriyA VBG|VBD|VB)
  =>
 (printout       ?*fp*   "(kriyA-"?p_wrd"_saMbanXI    "?kriyA"      "?prep_saMbanXI")"crlf)
 (printout       ?*fp1*   "(prep_id-relation-anu_ids  "?prep"     kriyA-"?p_wrd"_saMbanXI    "?kriyA"       "?prep_saMbanXI")"crlf)
 (printout       ?*dbug* "(prep_id-Rule-Rel-ids  "?prep"   kriyA-prep_saMbanXI_rule    kriyA-"?p_wrd"_saMbanXI   "?kriyA" "?prep_saMbanXI")"crlf)
 )
 ;------------------------------------------------------------------------------------------------------------------------
 ;Eg: There was a red mark on the door.
 ;e3:_be_v_there<6:9>[ARG1 x4] ==> (relation_name-id-args_with_ids _be_v_there  2 ARG0 e3  2  ARG1 x4 5 )
 (defrule kriyA-aBihiwa_rule
 (relation_name-id-args_with_ids ?rel  ?kriyA ARG0 ?  ?kriyA  ARG1 ? ?aBihiwa)
 (id-word ?d_sub_id ?dummy_subject)
 (test (eq (find_sub-str_before_last_underscore ?rel) "v"))
 (test (eq (string-to-field (find_sub-str_after_last_underscore ?rel)) ?dummy_subject))
  =>
 (printout       ?*fp*   "(kriyA-aBihiwa    "?kriyA"      "?aBihiwa")"crlf)
 (printout       ?*fp1*   "(prep_id-relation-anu_ids  -     kriyA-aBihiwa    "?kriyA"       "?aBihiwa")"crlf)
 (printout       ?*dbug* "(prep_id-Rule-Rel-ids  -   kriyA-aBihiwa_rule    kriyA-aBihiwa   "?kriyA" "?aBihiwa")"crlf)
 
 (printout       ?*fp*   "(kriyA-dummy_subject    "?kriyA"      "?d_sub_id")"crlf)
 (printout       ?*fp1*   "(prep_id-relation-anu_ids  -     kriyA-dummy_subject    "?kriyA"       "?d_sub_id")"crlf)
 (printout       ?*dbug* "(prep_id-Rule-Rel-ids  -   kriyA-aBihiwa_rule    kriyA-dummy_subject   "?kriyA" "?d_sub_id")"crlf)
 )
 ;------------------------------------------------------------------------------------------------------------------------
 ;Eg: I will not do it.
 ;e10:neg<7:10>[ARG1 e3] ==> (relation_name-id-args_with_ids neg  3 ARG0 e10  3  ARG1 e3 4 )
 (defrule kriyA-kriyA_niReXaka_rule
 (relation_name-id-args_with_ids neg  ? ARG0 ? ?kriyA_niReXaka  ARG1 ? ?kriyA)
  =>
 (printout       ?*fp*   "(kriyA-kriyA_niReXaka    "?kriyA"      "?kriyA_niReXaka")"crlf)
 (printout       ?*fp1*   "(prep_id-relation-anu_ids  -     kriyA-kriyA_niReXaka    "?kriyA"       "?kriyA_niReXaka")"crlf)
 (printout       ?*dbug* "(prep_id-Rule-Rel-ids  -   kriyA-kriyA_niReXaka_rule    kriyA-kriyA_niReXaka   "?kriyA" "?kriyA_niReXaka")"crlf)

 (printout       ?*fp*   "(niReXawmaka_vAkya)"crlf)
 (printout       ?*fp1*   "(prep_id-relation-anu_ids  -     niReXawmaka_vAkya)"crlf)
 (printout       ?*dbug* "(prep_id-Rule-Rel-ids  -   kriyA-kriyA_niReXaka_rule    niReXawmaka_vAkya)"crlf)
 )
 ;------------------------------------------------------------------------------------------------------------------------
 ;Eg: I went there with my mother.
 ;e9:loc_nonsp<7:12>[ARG1 e3, ARG2 x10]  ==> (relation_name-id-args_with_ids loc_nonsp  3 ARG0 e9  3  ARG1 e3 2  ARG2 x10 3 )
 (defrule kriyA-aXikaraNavAcI_rule
 (relation_name-id-args_with_ids loc_nonsp  ? ARG0 ?  ?  ARG1 ? ?kriyA  ARG2 ? ?aXikaraNavAcI)
 =>
 (printout       ?*fp*   "(kriyA-aXikaraNavAcI    "?kriyA"      "?aXikaraNavAcI")"crlf)
 (printout       ?*fp1*   "(prep_id-relation-anu_ids  -     kriyA-aXikaraNavAcI    "?kriyA"       "?aXikaraNavAcI")"crlf)
 (printout       ?*dbug* "(prep_id-Rule-Rel-ids  -   kriyA-aXikaraNavAcI_rule    kriyA-aXikaraNavAcI   "?kriyA" "?aXikaraNavAcI")"crlf)
 )
 ;------------------------------------------------------------------------------------------------------------------------
 
