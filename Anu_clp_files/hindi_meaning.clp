 (defglobal ?*PropN_file* =  p_noun)
 (defglobal ?*hin_mng_file* = fp)
 (defglobal ?*hin_mng_file1* = fp1)
 (defglobal ?*catastrophe_file* = fp2)

 (deffunction never-called ()
 (assert (prep_id-relation-anu_ids))
 (assert (No complete linkages found))
 (assert (missing-level-id) )
 (assert (id-original_word) )
 (assert (verb_type-verb-causative_verb-tam) )
 (assert (addition-level-word-sid) )
 (assert (affecting_id-affected_ids-wsd_group_word_mng))
 (assert (affecting_id-affected_ids-wsd_group_root_mng))
 (assert (id-wsd_number) )
 (assert (id-wsd_root))
 (assert (ids-cmp_mng-head-cat-mng_typ-priority))
 (assert (verb_type-verb-kriyA_mUla-tam))
 (assert (id-sen_mng))
 (assert (id-tam_type))
 (assert (kriyA_id-object2_viBakwi))
 (assert (kriyA_id-object1_viBakwi))
 (assert (kriyA_id-object_viBakwi))
 (assert (kriyA_id-subject_viBakwi))
 (assert (id-H_vib_mng))
 (assert (make_verbal_noun))
 (assert (root_id-TAM-vachan))
 (assert (id-E_tam-H_tam_mng))
 (assert (id-preceeding_part_of_verb))
 (assert (meaning_has_been_decided))
 (assert (id-cat))
 (assert (id-cat_coarse))
 (assert (root-verbchunk-tam-chunkids))
 (assert (id-attach_emphatic))
 (assert (conjunction-components))
 (assert (E_word-wx_word))
 (assert (id-last_word))
 (assert (id-word))
 (assert (Domain))
 (assert (id-eng-src))
 (assert (id-attach_eng_mng))
 (assert (id-wsd_viBakwi))
 (assert (id-HM-source))
 (assert (id-domain_type))
 )

 ;------------------------------------------ Functions ---------------------------------------------------------
 ;Added by Shirisha Manju (30-07-13)
 (deffunction get_first_mng (?wrd ?cat ?dbase)
	(bind ?mng (gdbm_lookup ?dbase (str-cat ?wrd "_" ?cat)))
        (if (neq ?mng "FALSE") then
        	(if (neq (str-index "/" ?mng) FALSE) then
                	(bind ?h_mng (sub-string  1 (- (str-index "/" ?mng) 1) ?mng))
            	else
                	(bind ?h_mng  ?mng)
           	)
	)
 )
 ;-------------------------------------------- Rules ------------------------------------------------------------
 ;Added by Shirisha Manju
 ;remove control fact for template meanings and compound meanings
 (defrule mng_decided
 (declare (salience 9900))
 (or (id-HM-source ?id ? Template_root_mng|Template_word_mng)(compound_meaning_decided ?id))
 ?mng<-(meaning_to_be_decided ?id)
 =>
        (retract ?mng)
 )
 ;--------------------------------------------------------------------------------------------------------------
 ;Added by Roja (05-07-14)
 ;If category is symbol then hindi meaning is same as Original Word.
 ;A can be expressed as a sum of two vectors — one obtained by multiplying [a] by a real number and the other obtained by multiplying [b] by another real number.
 (defrule decide_mng_symbols
 (declare (salience 9800))
 (id-cat_coarse ?id symbol)
 ?mng<-(meaning_to_be_decided ?id)
 (id-original_word ?id  ?original_wrd)
 =>
	(retract ?mng)
	(printout ?*hin_mng_file* "(id-HM-source  " ?id "  @" ?original_wrd"    Symbol)" crlf)
        (printout ?*hin_mng_file1* "(id-HM-source-grp_ids  " ?id "  @"?original_wrd"    Symbol)" crlf)
 )
 ;======================================== PropN rules ==========================================================
 ;Rule Modified by Roja(19-02-14). Added 'number' in category fact, also added 'if ...else' loop. Ex: 1963 And 1966's popular films were based on novels Godhan and Gaban, respectively .
 ;Added by Shirisha Manju (26-08-13)
 ;The explanation of the results led to the birth of Rutherford's planetary model of atom.
 (defrule modify_word_for_apos
 (declare (salience 9700))
 (id-cat_coarse ?id PropN|number)
 ?mng<-(meaning_to_be_decided ?id)
 ?f0<-(id-original_word ?id ?word)
 ?f1<-(id-word ?id ?wrd)
 (test (neq (numberp ?word) TRUE))
 (test (neq (str-index "'s" ?word) FALSE))
 =>
        (retract ?f0 ?f1)
        (bind ?n_word (string-to-field (sub-string 1 (- (str-index "'s" ?word) 1) ?word)))
        (assert (id-original_word ?id ?n_word))
	(if (eq ?id number) then 
	        (assert (id-word ?id ?n_word))
	else
        	(assert (id-word ?id (lowcase ?n_word)))
	)
 )
 ;--------------------------------------------------------------------------------------------------------------
 ;Added by Shirisha Manju (16-08-13) Suggested by Chaitanya Sir
 ;Dear brothers, from today I shall be talking to you about Shrimad [Bhagavad-Gita].
 ;The bond between the [Gita] and me transcends reason.
 (defrule get_PropN_mng
 (declare (salience 9600))
 (id-cat_coarse ?id PropN)
 ?f<-(meaning_to_be_decided ?id)
 (id-original_word ?id ?wrd)
 (test (neq (gdbm_lookup "proper_noun_dic.gdbm" ?wrd) "FALSE"))
 =>
        (bind ?mng (gdbm_lookup "proper_noun_dic.gdbm" ?wrd ))
        (if (neq ?mng "FALSE") then
                (retract ?f)
                (printout ?*hin_mng_file* "(id-HM-source   "?id"   "?mng"   proper_noun_dic)" crlf)
                (printout ?*hin_mng_file1* "(id-HM-source-grp_ids   "?id"   "?mng"   proper_noun_dic "?id")" crlf)
        )
 )
 ;--------------------------------------------------------------------------------------------------------------
 ;The guard made Dipu halt, and helped the Princess off his back.
 ;Added by Shirisha Manju (14-05-13) Suggested by Chaitanya Sir
 (defrule get_PropN_mng_with_prev_word_the
 (declare (salience 9500))
 (id-cat_coarse ?id PropN)
 ?mng<-(meaning_to_be_decided ?id)
 (id-word =(- ?id 1) the)
 (id-root ?id ?rt)
 (test (neq (gdbm_lookup "default-iit-bombay-shabdanjali-dic.gdbm" (str-cat (lowcase ?rt) "_noun")) "FALSE"))
 =>
        (bind ?f_mng (get_first_mng (lowcase ?rt) noun default-iit-bombay-shabdanjali-dic.gdbm))
        (if (neq ?f_mng "FALSE") then
                (retract ?mng)
                (printout ?*hin_mng_file* "(id-HM-source   "?id"   "?f_mng"   Default_meaning)" crlf)
                (printout ?*hin_mng_file1* "(id-HM-source-grp_ids   "?id"   "?f_mng"   Default_meaning "?id")" crlf)
        )
 )
 ;====================================== Generate default category ================================================
 ;Added by Roja (01-08-12). 
 ;Generating dummy categories.
 (defrule generate_dummy_cat
 (declare (salience 9400))
 (default-cat)
 =>
 (assert (default-cat noun))
 (assert (default-cat verb))
 (assert (default-cat adverb))
 (assert (default-cat adjective))
 (assert (default-cat PropN))
 (assert (default-cat conjunction))
 (assert (default-cat pronoun))
 (assert (default-cat determiner))
 (assert (default-cat wh-adverb))
 (assert (default-cat verbal_noun))
 (assert (default-cat UNDEFINED))
 (assert (default-cat wh-determiner))
 (assert (default-cat preposition))
 (assert (default-cat number))
 (assert (default-cat wh-pronoun))
 )
 ;========================================= Physics WSD/default meaning ========================================
 ;Added by Shirisha Manju (29-09-14)
 ;For a circle, the two [foci] merge into one and the semi-major axis becomes the radius of the circle.[NCERT]
;kisI vqwwa ke lie xonoM [nABiyAz] eka xUsare meM vilIna hokara eka ho jAwI hEM waWA arXa xIrGa akRa vqwwa kI wrijyA bana jAwI hE.
 (defrule get_phy_wsd_word_mng
 (declare (salience 9300))
 (Domain physics)
 (id-domain_type ?id physics)
 ?mng<-(meaning_to_be_decided ?id)
 (id-wsd_word_mng ?id ?hmng)
 =>
        (retract ?mng)
        (printout ?*hin_mng_file* "(id-HM-source   "?id"   " ?hmng "   WSD_word_mng)" crlf)
        (printout ?*hin_mng_file1* "(id-HM-source-grp_ids   "?id"   " ?hmng "   WSD_word_mng "?id")" crlf)
 )
 ;--------------------------------------------------------------------------------------------------------------
 ;Added by Shirisha Manju (29-09-14)
 ;It is different at interfaces of different [pairs] of liquids and solids. 
 ;xravoM waWA TosoM ke viBinna [yugmoM] ke aMwarApqRToM para yaha Binna - Binna howA hE.
 (defrule get_phy_wsd_root_mng
 (declare (salience 9200))
 (Domain physics)
 (id-domain_type ?id physics)
 ?mng<-(meaning_to_be_decided ?id)
 (id-wsd_root_mng ?id ?hmng)
 =>
        (retract ?mng)
        (printout ?*hin_mng_file* "(id-HM-source   "?id"   " ?hmng "   WSD_root_mng)" crlf)
        (printout ?*hin_mng_file1* "(id-HM-source-grp_ids   "?id"   " ?hmng "   WSD_root_mng "?id")" crlf)
 )
 ;--------------------------------------------------------------------------------------------------------------
 ;Added by Shirisha Manju (26-08-13).
 ; If root is '-' then check original word in dicionary with same category.
 (defrule phy_default_mng_with_org_wrd_with_same_cat
 (declare (salience 9100))
 (Domain physics)
 (id-root ?id -)
 (id-original_word ?id  ?org_wrd)
 ?mng<-(meaning_to_be_decided ?id)
 (id-cat_coarse ?id ?cat)
 (test (neq (numberp ?org_wrd) TRUE))
 (test (neq (gdbm_lookup "phy_dictionary.gdbm" (str-cat ?org_wrd "_" ?cat)) "FALSE"))
 =>
	(bind ?f_mng (get_first_mng ?org_wrd ?cat phy_dictionary.gdbm))
        (if (neq ?f_mng "FALSE") then
		(retract ?mng)
		(printout ?*hin_mng_file* "(id-HM-source   "?id"   "?f_mng"   Physics_Glossary)" crlf)
		(printout ?*hin_mng_file1* "(id-HM-source-grp_ids   "?id"   "?f_mng"   Physics_Glossary "?id")" crlf)
        )
 )
 ;--------------------------------------------------------------------------------------------------------------
 ;Added by Shirisha Manju (26-08-13).
 ;If root is '-' then check original word in dicionary with different category.
 (defrule phy_default_mng_with_diff_cat_with_org_wrd
 (declare (salience 9000))
 (Domain physics)
 (id-root ?id -)
 (id-original_word ?id  ?org_wrd)
 ?mng<-(meaning_to_be_decided ?id)
 (id-cat_coarse ?id ?cat)
 (test (neq (numberp ?org_wrd) TRUE))
 (default-cat ?cat1)
 (test (neq ?cat ?cat1))
 (test (neq (gdbm_lookup "phy_dictionary.gdbm" (str-cat ?org_wrd "_" ?cat1)) "FALSE"))
 =>
        (bind ?f_mng (get_first_mng ?org_wrd ?cat1 phy_dictionary.gdbm))
        (if (neq ?f_mng "FALSE") then
                (retract ?mng)
                (printout ?*hin_mng_file* "(id-HM-source   "?id"   "?f_mng"   Physics_Glossary)" crlf)
                (printout ?*hin_mng_file1* "(id-HM-source-grp_ids   "?id"   "?f_mng"   Physics_Glossary "?id")" crlf)
           	(printout ?*catastrophe_file* "(sen_type-id-phrase Default_mng_with_different_category "?id"  " ?org_wrd")" crlf)
        )
 )
 ;--------------------------------------------------------------------------------------------------------------
 ; Added by Shirisha Manju (19-11-12)
 (defrule get_mng_from_phy_dic_with_same_cat
 (declare (salience 8900))
 (Domain physics)
 (id-root ?id ?rt)
 ?mng<-(meaning_to_be_decided ?id)
 (id-cat_coarse ?id ?cat)
 (test (neq (numberp ?rt) TRUE))
 (test (neq (gdbm_lookup "phy_dictionary.gdbm" (str-cat ?rt "_" ?cat)) "FALSE"))
 =>
        (bind ?f_mng (get_first_mng ?rt ?cat phy_dictionary.gdbm))
        (if (neq ?f_mng "FALSE") then
                (retract ?mng)
                (printout ?*hin_mng_file* "(id-HM-source   "?id"   "?f_mng"   Physics_Glossary)" crlf)
                (printout ?*hin_mng_file1* "(id-HM-source-grp_ids   "?id"   "?f_mng"   Physics_Glossary "?id")" crlf)
        )
 )
 ;--------------------------------------------------------------------------------------------------------------
 ; In [Kinematics], we study ways to describe motion without going into the causes of motion. 
 ; Added by Shirisha Manju (19-11-12)
 (defrule get_mng_from_phy_dic_with_diff_cat
 (declare (salience 8800))
 (Domain physics)
 (id-cat_coarse ?id PropN)
 (id-root ?id ?rt)
 ?mng<-(meaning_to_be_decided ?id)
 (test (neq (numberp ?rt) TRUE))
 (test (neq (gdbm_lookup "phy_dictionary.gdbm" (str-cat (lowcase ?rt) "_noun")) "FALSE"))
 =>
        (bind ?f_mng (get_first_mng (lowcase ?rt) noun phy_dictionary.gdbm))
        (if (neq ?f_mng "FALSE") then
                (retract ?mng)
                (printout ?*hin_mng_file* "(id-HM-source   "?id"   "?f_mng"   Physics_Glossary)" crlf)
                (printout ?*hin_mng_file1* "(id-HM-source-grp_ids   "?id"   "?f_mng"   Physics_Glossary "?id")" crlf)
                (printout ?*catastrophe_file* "(sen_type-id-phrase Default_mng_with_different_category "?id"  " ?rt")" crlf)
        )
 )
 ;=========================================== WSD and Idiom meaning ===========================================
 (defrule idiom_word_mng
 (declare (salience 8300))
 (id-idiom_word_mng ?id ?HM)
 ?mng<-(meaning_to_be_decided ?id)
 =>
        (retract ?mng)
        (printout ?*hin_mng_file* "(id-HM-source   "?id"   " ?HM "   Idiom_word_mng)" crlf)
        (printout ?*hin_mng_file1* "(id-HM-source-grp_ids   "?id"   " ?HM "   Idiom_word_mng "?id")" crlf)
 )
 ;--------------------------------------------------------------------------------------------------------------
 (defrule wsd_word_mng
 (declare (salience 8200))
 ?mng<-(meaning_to_be_decided ?id)
 (id-wsd_word_mng ?id ?h_word)
 =>
        (retract ?mng)
        (printout ?*hin_mng_file* "(id-HM-source   "?id"   " ?h_word "    WSD_word_mng)" crlf)
        (printout ?*hin_mng_file1* "(id-HM-source-grp_ids   "?id"   " ?h_word "    WSD_word_mng "?id")" crlf)
 )
 ;--------------------------------------------------------------------------------------------------------------
 (defrule idiom_root_mng
 (declare (salience 8100))
 (id-idiom_root_mng ?id ?HM)
 ?mng<-(meaning_to_be_decided ?id)
 =>
        (retract ?mng)
        (printout ?*hin_mng_file* "(id-HM-source   "?id"   " ?HM "   Idiom_root_mng)" crlf)
        (printout ?*hin_mng_file1* "(id-HM-source-grp_ids   "?id"   " ?HM "   Idiom_root_mng "?id")" crlf)
 )
 ;--------------------------------------------------------------------------------------------------------------
 (defrule wsd_root_mng
 (declare (salience 8000))
 ?mng<-(meaning_to_be_decided ?id)
 (id-wsd_root_mng ?id ?h_word)
 =>
        (retract ?mng)
        (printout ?*hin_mng_file* "(id-HM-source   "?id"   " ?h_word "   WSD_root_mng)" crlf)
        (printout ?*hin_mng_file1* "(id-HM-source-grp_ids   "?id"   " ?h_word "   WSD_root_mng "?id")" crlf)
 )
 ;========================================== Default single word meaning =======================================
 ;Added by Shirisha Manju (09-05-13)
 ; We see leaves falling from trees and water flowing [down] a dam. 
 (defrule modify_cat_for_particle
 (declare (salience 7910))
 ?f0<-(id-cat_coarse ?id particle)
 (meaning_to_be_decided ?id)
 =>
        (retract ?f0)
        (assert (id-cat_coarse ?id preposition))
 )
 ;--------------------------------------------------------------------------------------------------------------
 ;Added by Roja (05-03-13).
 ;checking original word in dictionary (when root is '-') when same category.
 (defrule default_hindi_mng-same-cat_with-org_wrd
 (declare (salience 7900))
 (id-root ?id -)
 (id-original_word ?id  ?org_wrd)
 ?mng<-(meaning_to_be_decided ?id)
 (id-cat_coarse ?id ?cat)
 (test (neq (numberp ?org_wrd) TRUE))
 (test (neq (gdbm_lookup "default-iit-bombay-shabdanjali-dic.gdbm" (str-cat ?org_wrd "_" ?cat)) "FALSE"))
 =>
	(bind ?f_mng (get_first_mng ?org_wrd ?cat default-iit-bombay-shabdanjali-dic.gdbm))
        (if (neq ?f_mng "FALSE") then
		(retract ?mng)
		(printout ?*hin_mng_file* "(id-HM-source   "?id"   "?f_mng"   Default_meaning)" crlf)
		(printout ?*hin_mng_file1* "(id-HM-source-grp_ids   "?id"   "?f_mng"   Default_meaning "?id")" crlf)
        )
 )
 ;--------------------------------------------------------------------------------------------------------------
 ;Added by Roja (05-03-13).
 ;checking original word in dictionary (when root is '-') and when category is different.
 (defrule default_hindi_mng-different-cat_with_org_wrd
 (declare (salience 7800))
 (id-root ?id -)
 (id-original_word ?id  ?org_wrd)
 ?mng<-(meaning_to_be_decided ?id)
 (id-cat_coarse ?id ?cat)
 (test (neq (numberp ?org_wrd) TRUE))
 (default-cat ?cat1)
 (test (neq ?cat ?cat1))
 (test (neq (gdbm_lookup "default-iit-bombay-shabdanjali-dic.gdbm" (str-cat ?org_wrd "_" ?cat1)) "FALSE"))
 =>
	(bind ?f_mng (get_first_mng ?org_wrd ?cat1 default-iit-bombay-shabdanjali-dic.gdbm))
        (if (neq ?f_mng "FALSE") then
                (retract ?mng)
                (printout ?*hin_mng_file* "(id-HM-source   "?id"   "?f_mng"   Default_meaning)" crlf)
                (printout ?*hin_mng_file1* "(id-HM-source-grp_ids   "?id"   "?f_mng"   Default_meaning "?id")" crlf)
           (printout ?*catastrophe_file* "(sen_type-id-phrase Default_mng_with_different_category "?id"  " ?org_wrd")" crlf)
        )
 )
 ;--------------------------------------------------------------------------------------------------------------
 ;Rule re-modified by Roja (01-08-12). 
 ;Getting Hindi meaning from default dictionary when there is a same category 
 ;Assuming first meaning always has 'Defualt'.
 ;Modified by Shirisha Manju (04-02-12) removed if condition to check for "number" in action part instead added in rule part
 (defrule default_hindi_mng-same-cat_with_root
 (declare (salience 7700))
 (id-root ?id ?rt)
 ?mng<-(meaning_to_be_decided ?id)
 (id-cat_coarse ?id ?cat)
 (test (neq (numberp ?rt) TRUE))
 (test (neq (gdbm_lookup "default-iit-bombay-shabdanjali-dic.gdbm" (str-cat ?rt "_" ?cat)) "FALSE"))
 =>
	(bind ?f_mng (get_first_mng ?rt ?cat default-iit-bombay-shabdanjali-dic.gdbm))
        (if (neq ?f_mng "FALSE") then
                (retract ?mng)
                (printout ?*hin_mng_file* "(id-HM-source   "?id"   "?f_mng"   Default_meaning)" crlf)
                (printout ?*hin_mng_file1* "(id-HM-source-grp_ids   "?id"   "?f_mng"   Default_meaning "?id")" crlf)
        )
 )
 ;--------------------------------------------------------------------------------------------------------------
 ;Added by Roja (01-08-12).
 ;Getting Hindi meaning from default dictionary when there is a different category.
 ;Also asserting a fact (sen_type-id-phrase Default_mng_with_different_category) as a warning message in catastrophe.dat
 ;Assuming first meaning always has 'Defualt'.
 (defrule default_hindi_mng-different-cat_with_root
 (declare (salience 7600))
 (id-root ?id ?rt)
 ?mng<-(meaning_to_be_decided ?id)
 (id-cat_coarse ?id ?cat)
 (test (neq (numberp ?rt) TRUE))
 (default-cat ?cat1)
 (test (neq ?cat ?cat1))
 (test (neq (gdbm_lookup "default-iit-bombay-shabdanjali-dic.gdbm" (str-cat ?rt "_" ?cat1)) "FALSE"))
 =>
	(bind ?f_mng (get_first_mng ?rt ?cat1 default-iit-bombay-shabdanjali-dic.gdbm))
        (if (neq ?f_mng "FALSE") then
                (retract ?mng)
                (printout ?*hin_mng_file* "(id-HM-source   "?id"   "?f_mng"   Default_meaning)" crlf)
                (printout ?*hin_mng_file1* "(id-HM-source-grp_ids   "?id"   "?f_mng"   Default_meaning "?id")" crlf)
	        (printout ?*catastrophe_file* "(sen_type-id-phrase Default_mng_with_different_category "?id"  " ?rt")" crlf)
        )
 )
 ;--------------------------------------------------------------------------------------------------------------
 ;Added by Roja (24-05-14).
 ;Getting Hindi meaning from default dictionary with original word same category
 (defrule default_hindi_mng-same-cat_with_org_wrd
 (declare (salience 7500))
 ?mng<-(meaning_to_be_decided ?id)
 (id-cat_coarse ?id ?cat)
 (id-original_word ?id ?org_wrd)
 (test (neq (numberp ?org_wrd) TRUE))
 (test (neq (gdbm_lookup "default-iit-bombay-shabdanjali-dic.gdbm" (str-cat ?org_wrd "_" ?cat)) "FALSE"))
 =>
        (bind ?f_mng (get_first_mng ?org_wrd ?cat default-iit-bombay-shabdanjali-dic.gdbm))
        (if (neq ?f_mng "FALSE") then
                (retract ?mng)
                (printout ?*hin_mng_file* "(id-HM-source   "?id"   "?f_mng"   Default_meaning)" crlf)
                (printout ?*hin_mng_file1* "(id-HM-source-grp_ids   "?id"   "?f_mng"   Default_meaning "?id")" crlf)
        )
 )
 ;--------------------------------------------------------------------------------------------------------------
 ;Added by Roja (24-05-14).
 ;Getting Hindi meaning from default dictionary with original word when there is a different category.
 ;Also asserting a fact (sen_type-id-phrase Default_mng_with_different_category) as a warning message in catastrophe.dat
 ;Assuming first meaning always has 'Defualt'.
 (defrule default_hindi_mng-different-cat_with_org_wrd
 (declare (salience 7300))
 ?mng<-(meaning_to_be_decided ?id)
 (id-original_word ?id ?org_wrd)
 (id-cat_coarse ?id ?cat)
 (default-cat ?cat1)
 (test (neq (numberp ?org_wrd) TRUE))
 (test (neq ?cat ?cat1))
 (test (neq (gdbm_lookup "default-iit-bombay-shabdanjali-dic.gdbm" (str-cat ?org_wrd "_" ?cat1)) "FALSE"))
 =>
        (bind ?f_mng (get_first_mng ?org_wrd ?cat1 default-iit-bombay-shabdanjali-dic.gdbm))
        (if (neq ?f_mng "FALSE") then
                (retract ?mng)
                (printout ?*hin_mng_file* "(id-HM-source   "?id"   "?f_mng"   Default_meaning)" crlf)
                (printout ?*hin_mng_file1* "(id-HM-source-grp_ids   "?id"   "?f_mng"   Default_meaning "?id")" crlf)
                (printout ?*catastrophe_file* "(sen_type-id-phrase Default_mng_with_different_category "?id"  " ?org_wrd")" crlf)
        )
 )
 ;--------------------------------------------------------------------------------------------------------------
 ;Added by Roja (24-05-14).
 ;Getting Hindi meaning from default dictionary lowcasing original word same category
 (defrule default_hindi_mng-same-cat_with_org_wrd_lc
 (declare (salience 7200))
 ?mng<-(meaning_to_be_decided ?id)
 (id-cat_coarse ?id ?cat)
 (id-original_word ?id ?org_wrd)
 (test (neq (numberp ?org_wrd) TRUE))
 (test (neq (gdbm_lookup "default-iit-bombay-shabdanjali-dic.gdbm" (str-cat (lowcase ?org_wrd) "_" ?cat)) "FALSE"))
 =>
        (bind ?f_mng (get_first_mng (lowcase ?org_wrd) ?cat default-iit-bombay-shabdanjali-dic.gdbm))
        (if (neq ?f_mng "FALSE") then
                (retract ?mng)
                (printout ?*hin_mng_file* "(id-HM-source   "?id"   "?f_mng"   Default_meaning)" crlf)
                (printout ?*hin_mng_file1* "(id-HM-source-grp_ids   "?id"   "?f_mng"   Default_meaning "?id")" crlf)
        )
 )
 ;--------------------------------------------------------------------------------------------------------------
 ;Added by Roja (24-05-14).
 ;Getting Hindi meaning from default dictionary lowcasing original word when there is a different category.
 ;Also asserting a fact (sen_type-id-phrase Default_mng_with_different_category) as a warning message in catastrophe.dat
 ;Assuming first meaning always has 'Defualt'.
 (defrule default_hindi_mng-different-cat_with_org_wrd_lc
 (declare (salience 7100))
 ?mng<-(meaning_to_be_decided ?id)
 (id-original_word ?id ?org_wrd)
 (id-cat_coarse ?id ?cat)
 (default-cat ?cat1)
 (test (neq (numberp ?org_wrd) TRUE))
 (test (neq ?cat ?cat1))
 (test (neq (gdbm_lookup "default-iit-bombay-shabdanjali-dic.gdbm" (str-cat (lowcase ?org_wrd) "_" ?cat1)) "FALSE"))
 =>
        (bind ?f_mng (get_first_mng (lowcase ?org_wrd) ?cat1 default-iit-bombay-shabdanjali-dic.gdbm))
        (if (neq ?f_mng "FALSE") then
                (retract ?mng)
                (printout ?*hin_mng_file* "(id-HM-source   "?id"   "?f_mng"   Default_meaning)" crlf)
                (printout ?*hin_mng_file1* "(id-HM-source-grp_ids   "?id"   "?f_mng"   Default_meaning "?id")" crlf)
                (printout ?*catastrophe_file* "(sen_type-id-phrase Default_mng_with_different_category "?id"  " ?org_wrd")" crlf)
        )
 )
 ;--------------------------------------------------------------------------------------------------------------
 ;Added by Shirisha Manju Suggested by Chaitanya Sir (18-7-14)
 (defrule get_mng_from_transliterate_mng
 (declare (salience 7410))
 (id-word ?id ?word)
 ?f<-(meaning_to_be_decided ?id)
 (test (neq (numberp ?word) TRUE))
 (test (neq (gdbm_lookup "transliterate_meaning.gdbm" ?word ) "FALSE"))
 =>
	(bind ?mng (gdbm_lookup "transliterate_meaning.gdbm" ?word ))
        (if (neq ?mng "FALSE") then
                (retract ?f)
                (printout ?*hin_mng_file* "(id-HM-source   "?id"   "?mng"   transliterate_meaning_dic)" crlf)
                (printout ?*hin_mng_file1* "(id-HM-source-grp_ids   "?id"   "?mng"   transliterate_meaning_dic "?id")" crlf)
        )
 )
 ;--------------------------------------------------------------------------------------------------------------
  ;Getting meaning for Proper noun 
  (defrule test_for_PropN
  (declare (salience 7400))
  (id-cat_coarse ?id PropN)
  (id-word ?id ?word)
  ?mng<-(meaning_to_be_decided ?id)
  (test (neq (numberp ?word) TRUE))
  =>
       (retract ?mng)
       (bind ?wx_notation (str-cat "@PropN-" ?word "-PropN")) 
       (printout ?*hin_mng_file* "(id-HM-source   "?id"   "?wx_notation"   transliterate_mng)" crlf)
       (printout ?*hin_mng_file1* "(id-HM-source-grp_ids   "?id"   "?wx_notation"   transliterate_mng "?id")" crlf)
       (printout ?*PropN_file* ?word crlf)
 )
 ;--------------------------------------------------------------------------------------------------------------
 ;Added by Shirisha Manju (04-02-12)
 ;That would be the lowest level since the early 1970s.
 ;Seven of nine states have grown each year since 1980, including New York, which lost 4% of its population during the 1970s.
 (defrule default_mng
 (declare (salience 7000))
 (id-original_word ?id  ?original_wrd)
 ?mng<-(meaning_to_be_decided ?id)
 =>
        (retract ?mng)
        (printout ?*hin_mng_file* "(id-HM-source   "?id"    @"?original_wrd"   Original_word)" crlf)
	(printout ?*hin_mng_file1* "(id-HM-source-grp_ids   "?id"    @"?original_wrd"   Original_word "?id")" crlf)
 )
 ;--------------------------------------------------------------------------------------------------------------
 (defrule end
 (declare (salience 100))
 =>
	(close ?*hin_mng_file*)
 )
 ;--------------------------------------------------------------------------------------------------------------
