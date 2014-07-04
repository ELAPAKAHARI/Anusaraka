 ; This file is written by Shirisha Manju

 (deffunction never-called ()
 (assert (id-sd_cat))
 (assert (parserid-word))
 (assert (word-nertype))
 )

 (defglobal ?*cat_fp* = sd_cat_fp) 

 (deffunction string_to_integer (?parser_id)
; Removes the first character from the input symbol which is assumed to contain digits only from the second position onward; length should be less than 10000]
 (string-to-field (sub-string 2 10000 ?parser_id)))


  ;------------------------------------------------------------------------------------------
  ; NOTE: PropN info is extracted from NER so handling NNPS category before NER rule.
  ; NNPS -- A Grateful Dead/Allman [Brothers] concert in Washington D.C., that July, presented an unexpected opportunity to serve as a dry-run for our upcoming trip.
  (defrule NNPS_rule
  (declare (salience 15))
  ?f0<-(id-sd_cat        ?id     NNPS)
  (id-sd_cat ?id1 NNP)
  (test (eq (- (string_to_integer ?id) 1) (string_to_integer ?id1)))
  =>
         (printout ?*cat_fp* "(parser_id-cat_coarse  "?id" PropN)" crlf)
         (retract ?f0)
  )
  ;------------------------------------------------------------------------------------------
  (defrule NNP_to_NN
  (declare (salience 13))
  ?f0<-(id-sd_cat   ?pid NNP)
  (not (has_been_modified ?pid))
  =>
	(retract ?f0)
	(assert (id-sd_cat   ?pid NN))
	(assert (has_been_modified ?pid))
  )
  ;------------------------------------------------------------------------------------------
  ;Modified fact (word-wordid-nertype) to (word-nertype) 
  ;Modified this rule by Roja (06-06-13) Suggested by Chaitanya sir
  (defrule PropN_rule_from_NER
  (declare (salience 12))
  (word-nertype ?word&~of PERSON|LOCATION|ORGANIZATION) ;The Zongle [of] Bongle Dongle resigned today. 
  (parserid-word P1 ?word)
  ;(parserid-word ?pid ?word)
  ?f0<-(id-sd_cat   P1 ?)
;  ?f0<-(id-sd_cat   ?pid ?)
  =>
        (printout ?*cat_fp* "(parser_id-cat_coarse	P1	 PropN)" crlf)
;        (printout ?*cat_fp* "(parser_id-cat_coarse  "?pid " PropN)" crlf)
        (retract ?f0)
  )
  ;------------------------------------------------------------------------------------------
  ;Added by Roja(13-06-13) ;Ex: John's family is renovating their kitchen.
  (defrule PropN_rule_from_NER1
  (declare (salience 12))
  (word-nertype ?word PERSON|LOCATION|ORGANIZATION)
;  (parserid-word ?pid ?wrd)
  (parserid-word P1's ?wrd)
  ?f0<-(id-sd_cat   P1's ?)
  ;?f0<-(id-sd_cat   ?pid ?)
  (test (neq (str-index "'s" ?wrd) FALSE))
  (test (eq ?word (string-to-field (sub-string 1 (- (str-index "'s" ?wrd) 1) ?wrd))))
  =>
	(printout ?*cat_fp* "(parser_id-cat_coarse  P1's	 PropN)" crlf)
;	(printout ?*cat_fp* "(parser_id-cat_coarse  "?pid " PropN)" crlf)
	(retract ?f0)
  )
  ;------------------------------------------------------------------------------------------
;  ;(Added by S.Maha Laxmi 4-07-11)(Suggested by Sukahada)
;  ; #Ex. We ate at Joe's Diner last week. The Master said, if I did not go, how would you ever see? 
;  ;(removed  sd_category.py and handled that part using NN_to_NNP rule )
;  (defrule NN_to_NNP
;  (declare (salience 11))
;  ?f0<-(id-sd_cat   ?pid NN)
;  (parserid-word ?pid ?word)
;  (test (neq ?pid P1))
;  (test (eq (upcase (sub-string 1 1 ?word)) (sub-string 1 1 ?word)))
;  (test (eq (numberp (string-to-field (sub-string 1 1 ?word))) FALSE));Ex: One can reach kumbhalgarh by road from udaipur (84km) and ranakpur which is 18km from kumbhalgarh. (Added by Roja 19-11-12) 
;  (test (eq (str-index "SYMBOL-" ?word) FALSE));Added this condition to avoid words with SYMBOL to convert to NNP category (Added by Roja 18-10-12) EX:  In one-dimensional motion, there are only two directions (backward and forward, upward and downward) in which an object can move, and these two directions can easily be specified by + and — signs. 
;  =>
; 	(retract ?f0)
;	(assert (id-sd_cat   ?pid NNP))
;  )
  ;------------------------------------------------------------------------------------------
  ; We camped on Nilgiri hills during summer. He went to Agra and saw the Tajmahal.
  ; As will be explained later, there are several types of modulation, abbreviated as AM, FM and PM.
  (defrule PropN_rule
  (declare (salience 10))
  (id-word_cap_info ?id&~1  first_cap|all_caps)
  (parserid-wordid   ?pid  ?id)
  ?f0<-(id-sd_cat  ?pid ?)
   =>
        (printout ?*cat_fp* "(parser_id-cat_coarse  "?pid"   PropN)" crlf)
        (retract ?f0)
  )
  ;------------------------------------------------------------------------------------------
  ;Suggested by Chaitanya Sir 04-06-14 
  ;They are [educated]. 
  (defrule modify_VBN_cat
  (declare (salience 5))
  ?f0<-(id-sd_cat  ?id  VBN)
  (Head-Level-Mother-Daughters ?id ? ?ADJP ?VBN)
  (Node-Category ?ADJP ADJP)
  (Node-Category ?VBN VBN)
  =>
	(printout ?*cat_fp* "(parser_id-cat_coarse  "?id"  adjective)" crlf)
   	(retract ?f0)
  )
  ;------------------------------------------------------------------------------------------
  ;He disputed that our program was superior . (PRP$) 
  (defrule PRP_rule
  ?f0<-(id-sd_cat	?id	PRP|PRP$)
  =>
 	(printout ?*cat_fp* "(parser_id-cat_coarse  "?id"  pronoun)" crlf)
  	(retract ?f0)
  )
  ;------------------------------------------------------------------------------------------
  ; NNS -- How many people died .
  (defrule NN_rule
  ?f0<-(id-sd_cat        ?id     ?cat&NN|NNS)
  =>
 	(printout ?*cat_fp* "(parser_id-cat_coarse  "?id"  noun)" crlf)
         (retract ?f0)
  )
  ;------------------------------------------------------------------------------------------
  (defrule VB_rule
  ?f0<-(id-sd_cat        ?id     VB|VBZ|VBN|VBG|VBD|VBP)
  =>
         (printout ?*cat_fp* "(parser_id-cat_coarse  "?id"  verb)" crlf)
         (retract ?f0)
  )
  ;------------------------------------------------------------------------------------------
  ;[There] was a red mark on the door. 
  (defrule RB_rule
  ?f0<-(id-sd_cat        ?id     RB|RBR|RBS|EX)
  =>
         (printout ?*cat_fp* "(parser_id-cat_coarse  "?id"  adverb)" crlf)
         (retract ?f0)
  )
  ;------------------------------------------------------------------------------------------
  (defrule RP_rule
  ?f0<-(id-sd_cat        ?id     RP)
  =>
         (printout ?*cat_fp* "(parser_id-cat_coarse  "?id"  particle)" crlf)
         (retract ?f0)
  )
  ;------------------------------------------------------------------------------------------
  (defrule JJ_rule
  ?f0<-(id-sd_cat        ?id     JJ|JJR|JJS)
  =>
 	(printout ?*cat_fp* "(parser_id-cat_coarse  "?id"  adjective)" crlf)
         (retract ?f0)
  )
  ;------------------------------------------------------------------------------------------
  ;If you use that strategy, he will wipe you out.
  ;Since I know English, he spoke to me.
  (defrule IN_rule
  ?f0<-(id-sd_cat        ?id     IN)
  (Head-Level-Mother-Daughters ? ? ?IN ?id)
  (Head-Level-Mother-Daughters ? ? ?Mot ?IN $?)
  (Node-Category ?Mot ?cat&PP|SBAR)
  =>
	(if (eq ?cat PP) then
		(printout ?*cat_fp* "(parser_id-cat_coarse  "?id"  preposition)" crlf)
	else
		(printout ?*cat_fp* "(parser_id-cat_coarse  "?id"  conjunction)" crlf)
	)	
        (retract ?f0)
  )
  ;------------------------------------------------------------------------------------------
  ;[All] these numbers have the same number of significant figures (digits 2, 3, 0, 8), namely four.
  ;[Such] a dilemma does not occur in the wave picture of light.
  (defrule DT_rule
  ?f0<-(id-sd_cat        ?id     DT|PDT)
  =>
         (printout ?*cat_fp* "(parser_id-cat_coarse  "?id"  determiner)" crlf)
         (retract ?f0)
  )
  ;------------------------------------------------------------------------------------------
  (defrule MD
  ?f0<-(id-sd_cat        ?id     MD)
  =>
         (printout ?*cat_fp* "(parser_id-cat_coarse  "?id"  verb)" crlf)
         (retract ?f0)
  )
  ; MD may be modal verb or verb
  ;------------------------------------------------------------------------------------------
  (defrule CC_rule
  ?f0<-(id-sd_cat        ?id     CC)
  =>
         (printout ?*cat_fp* "(parser_id-cat_coarse  "?id"  conjunction)" crlf)
         (retract ?f0)
  )
  ;------------------------------------------------------------------------------------------
  ;In which school do you study?
  ;Added by Roja(06-08-12)
  (defrule WDT_rule
  ?f0<-(id-sd_cat        ?id     WDT)
  =>
         (printout ?*cat_fp* "(parser_id-cat_coarse  "?id"  wh-determiner)" crlf)
         (retract ?f0)
  )
  ;------------------------------------------------------------------------------------------
  ;When did the accident happen?
  (defrule WRB_rule
  ?f0<-(id-sd_cat        ?id     WRB)
  =>
         (printout ?*cat_fp* "(parser_id-cat_coarse  "?id"  wh-adverb)" crlf)
         (retract ?f0)
  )
  ;------------------------------------------------------------------------------------------
  ;Equation (6.1) can be extended [to] curved surfaces and nonuniform fields. 
  ;Added by Roja(17-07-13)
  (defrule TO_rule
  ?f0<-(id-sd_cat        ?id     TO)
  =>
         (printout ?*cat_fp* "(parser_id-cat_coarse  "?id"  preposition)" crlf)
         (retract ?f0)
  )
  ;------------------------------------------------------------------------------------------
  ;Added by Roja(17-07-13)
  ;Hence, all the [three] will have negative signs. 
  (defrule CD_rule
  ?f0<-(id-sd_cat        ?id     CD)
  =>
         (printout ?*cat_fp* "(parser_id-cat_coarse  "?id"  number)" crlf)
         (retract ?f0)
  )
  ;------------------------------------------------------------------------------------------
  ;Added by Roja(17-07-13)
  ;[What] is the nature of physical laws? 
  (defrule WP_rule
  ?f0<-(id-sd_cat        ?id     WP|WP$)
  =>
         (printout ?*cat_fp* "(parser_id-cat_coarse  "?id"  wh-pronoun)" crlf)
         (retract ?f0)
  )
  ;------------------------------------------------------------------------------------------
  ;Added by Roja(27-12-13)
  ;[No], it isn't.
  (defrule UH_rule
  ?f0<-(id-sd_cat        ?id     UH)
  =>
         (printout ?*cat_fp* "(parser_id-cat_coarse  "?id"  interjection)" crlf)
         (retract ?f0)
  )
  ;------------------------------------------------------------------------------------------
  ;Added by Roja(29-05-14)
  ;A can be expressed as a sum of two vectors — one obtained by multiplying [a] by a real number and the other obtained by multiplying [b] by another real number.
  (defrule SYM_rule
  ?f0<-(id-sd_cat        ?id     SYM)
  =>
         (printout ?*cat_fp* "(parser_id-cat_coarse  "?id"  symbol)" crlf)
         (retract ?f0)
  )
  ;------------------------------------------------------------------------------------------
  (defrule close_cat_file
  (declare (salience -100))
  =>
  	(close ?*cat_fp*)
  )
  ;------------------------------------------------------------------------------------------
