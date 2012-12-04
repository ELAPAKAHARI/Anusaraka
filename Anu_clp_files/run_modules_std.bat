 ;========================== PARSE MAPPING MODULE =======================================
 (load "global_path.clp")
 (bind ?*path* (str-cat ?*path* "/Anu_clp_files/parser_tree_correction_rules.bclp"))
 (bload ?*path*)
 (load-facts "sd_category_tmp.dat")
 (load-facts "sd_word_tmp.dat")
 (load-facts "E_constituents_info_tmp.dat")
 (load-facts "Node_category_tmp.dat")
 (load-facts "morph.dat")
 (run)
 (save-facts "E_constituents_info_tmp1.dat" local Head-Level-Mother-Daughters)
 (save-facts "Node_category_tmp1.dat" local  Node-Category)
 (save-facts "sd_category_tmp1.dat" local id-sd_cat)
 (clear)
 ;--------------------------------------------------------------------------------
 (load "global_path.clp")
 (bind ?*path* (str-cat ?*path* "/Anu_clp_files/parser_tree_modification_rules.bclp"))
 (bload ?*path*)
 (load-facts "E_constituents_info_tmp1.dat")
 (load-facts "Node_category_tmp1.dat")
 (load-facts "sd_word_tmp.dat")
 (load-facts "sd_category_tmp1.dat") 
 (run)
 (save-facts "E_constituents_info_tmp2.dat" local Head-Level-Mother-Daughters)
 (save-facts "Node_category_tmp2.dat" local  Node-Category)
 (clear)
 ;--------------------------------------------------------------------------------
 ; join words with apostrophe to single word. (e.g This is Ram's book -> Ram's (single word))
 (load "global_path.clp")
 (bind ?*path* (str-cat ?*path* "/Anu_clp_files/sd_combining_apostrophe.bclp"))
 (bload ?*path*)
 (load-facts "sd_numeric_word_tmp.dat")
 (load-facts "sd_word_tmp.dat")
 (load-facts "sd_category_tmp1.dat")
 (load-facts "sd-tree_relations_tmp.dat")
 (load-facts "E_constituents_info_tmp2.dat")
 (load-facts "Node_category_tmp2.dat")
 (open "sd_word.dat" l_fp "w")
 (open "sd_numeric_word.dat" l_n_w_fp "w")
 (open "sd-relations_tmp1.dat" l_r_fp "w")
 (open "sd_category_tmp2.dat" l_c_fp "w")
 (run)
 (save-facts "E_constituents_info_tmp3.dat" local Head-Level-Mother-Daughters)
 (save-facts "Node_category_tmp3.dat" local  Node-Category)
 (clear)
 ;--------------------------------------------------------------------------------
 (load "global_path.clp")
 (bind ?*path* (str-cat ?*path* "/Anu_clp_files/replace_head_word_with_id.clp"))
 (load ?*path*)
 (load-facts "E_constituents_info_tmp3.dat")
 (load-facts "sd_word.dat")
 (load-facts "Node_category_tmp3.dat")
 (run)
 (save-facts "E_constituents_info_tmp4.dat" local Head-Level-Mother-Daughters)
 (save-facts "Node_category_tmp4.dat" local  Node-Category)
 (clear)
 ;--------------------------------------------------------------------------------
 (load "global_path.clp")
 (bind ?*path* (str-cat ?*path* "/Anu_clp_files/handling_punctuations.clp"))
 (load ?*path*)
 (load-facts "E_constituents_info_tmp4.dat")
 (load-facts "Node_category_tmp4.dat")
 (load-facts "sd_word.dat")
 (run)
 (save-facts "E_constituents_info_tmp5.dat" local Head-Level-Mother-Daughters)
 (save-facts "Node_category.dat" local  Node-Category)
 (save-facts "parser_punctuation_info.dat" local mother-punct_head-left_punctuation mother-punct_head-right_punctuation mother-punct_head-punctuation)
 (clear)
 ;--------------------------------------------------------------------------------
 ; mapping between parser-generated id and original word id
 (load "global_path.clp")
 (bind ?*path* (str-cat ?*path* "/Anu_clp_files/parserid_wordid_mapping.bclp"))
 (bload ?*path*)
 (load-facts "sd_numeric_word.dat")
 (load-facts "original_word.dat")
 (open "parserid_wordid_mapping.dat" link_word_fp "w")
 (run)
 (clear)
 ;--------------------------------------------------------------------------------
 ; Determine pos category from link parser
 (load "global_path.clp")
 (bind ?*path* (str-cat ?*path* "/Anu_clp_files/sd_category.bclp"))
 (bload ?*path*)
 (load-facts "sd_category_tmp2.dat")
 (load-facts "sd_word.dat")
 (load-facts "parserid_wordid_mapping.dat")
 (load-facts "ner.dat")
 (open "sd_category_info.dat" sd_cat_fp "w")
 (run)
 (clear)
 ;---------------------------------------------------------------------------------
 (load "global_path.clp")
 (bind ?*path* (str-cat ?*path* "/Anu_clp_files/cat_rule.bclp"))
 (bload ?*path*)
 (load-facts "pos_cat.dat")
 (load-facts "sd_category_info.dat")
 (load-facts "parserid_wordid_mapping.dat")
 (open "parser_pos_cat.dat" cat_fp "w")
 (run)
 (clear)
 ;-----------------------------------------------------------------------------------
 (load "global_path.clp")
 (bind ?*path* (str-cat ?*path* "/Anu_clp_files/root_rule.bclp"))
 (bload ?*path*)
 (load-facts "parser_pos_cat.dat")
 (load-facts "morph.dat")
 (load-facts "original_word.dat")
 (load-facts "morph_root_tobe_choosen.dat")
 (load-facts "parserid_wordid_mapping.dat")
 (open "root_tmp.dat" rt_fp "w")
 (open "preferred_morph_tmp.dat" pre_fp "w")
 (run)
 (clear)
 ;-----------------------------------------------------------------------------------
 ; Generate lwg from both parser and default lwg database.
 (load "global_path.clp")
 (defglobal ?*path1* = ?*path*)
 (bind ?*path* (str-cat ?*path* "/Anu_clp_files/sd_lwg_rules.clp"))
 (load ?*path*)
 (load-facts "E_constituents_info_tmp5.dat")
 (load-facts "Node_category.dat")
 (load-facts "preferred_morph_tmp.dat")
 (load-facts "parser_punctuation_info.dat")
 (load-facts "sd_word.dat")
 (run) 
 (save-facts "lwg_info_tmp.dat" local root-verbchunk-tam-parser_chunkids verb_type-verb-causative_verb-tam)
 (save-facts "E_constituents_info_tmp6.dat" local Head-Level-Mother-Daughters)
 (clear)
 ;-------------------------------------------------------------------------------------
 (load "global_path.clp")
 (bind ?*path* (str-cat ?*path* "/Anu_clp_files/sd_relation_rules.bclp"))
 (bload ?*path*)
 (load-facts "sd-relations_tmp1.dat")
 (load-facts "sd-basic_relations_tmp1.dat")
 (load-facts "sd-propagation_relations_tmp1.dat")
 (load-facts "sd_word.dat")
 (load-facts "lwg_info_tmp.dat")
 (load-facts "parserid_wordid_mapping.dat")
 (load-facts "parser_pos_cat.dat")
 (open "relations_tmp.dat" open-file "a")
 (open "relations_debug.dat" debug_fp "a")
 (open "word.dat" open-word "a")
 (open "original_word.dat" open-orign "a")
 (open "hindi_meanings_tmp.dat" hmng_fp "a")
 (run)
 (clear)
 ;----------------------------------------------------------------------
 ; mapping parser id back to original word id (e.g P1 -> 1)
 (load "global_path.clp")
 (bind ?*path* (str-cat ?*path* "/Anu_clp_files/parser_id_mapping.bclp"))
 (bload ?*path*)
 (load-facts "lwg_info_tmp.dat")
 (load-facts "original_word.dat")
 (load-facts "root_tmp.dat")
 (load-facts "preferred_morph_tmp.dat")
 (load-facts "relations_tmp.dat")
 (load-facts "parser_pos_cat.dat")
 (load-facts "E_constituents_info_tmp6.dat")
 (load-facts "parserid_wordid_mapping.dat")
 (open "root.dat" root_fp "a")
 (open "preferred_morph.dat" pre_morph_fp "a")
 (open "lwg_info.dat" lwg_fp "a")
 (open "relations.dat" file "a")
 (open "relations_tmp1.dat" file1 "a")
 (open "cat_consistency_check.dat" cat_cons_fp "a")
 (open "E_constituents_info.dat" e_cons_fp "a")
 (run)
 (clear)
 ;----------------------------------------------------------------------
 (load "global_path.clp")
 (bind ?*path* (str-cat ?*path* "/Anu_clp_files/prawiniXi.clp"))
 (load ?*path*)
 (load-facts "E_constituents_info.dat")
 (load-facts "word.dat")
 (load-facts "Node_category.dat")
 (run)
 (save-facts "prawiniXi.dat" local head_id-prawiniXi_id-grp_ids prawiniXi_id-node-category)
 (clear)
 ;----------------------------------------------------------------------
 (load "global_path.clp")
 (bind ?*path* (str-cat ?*path* "/Anu_clp_files/parse_scope.clp"))
 (load ?*path*)
 (load-facts "E_constituents_info.dat")
 (load-facts "Node_category.dat")
 (load-facts "lwg_info.dat")
 (load-facts "punctuation_info.dat")
 (load-facts "prawiniXi.dat")
 (load-facts "word.dat")
 (run)
 (save-facts "sd_scope.dat" local mot-cat-head-level-praW_id-first_id-last_id-l_punc-r_punc mot-cat-praW_id-largest_group)
 (clear)
 ;----------------------------------------------------------------------
 ; Generate hindi Pada for the sentence.
 ; with in paxa ordering (e.g to reach your potential --> hindi ((your) (potential)(to reach))
 (load "global_path.clp")
 (bind ?*path* (str-cat ?*path* "/Anu_clp_files/sd_pada.clp"))
 (load ?*path*)
 (load-facts "prawiniXi.dat")
 (load-facts "word.dat")
 (load-facts "lwg_info.dat")
 (load-facts "to_be_included_in_paxa.dat")
 (open "pada_id_info.dat" pada_fp "w")
 (open "agmt_control_fact.dat" agmt_cntrl_fp "w")
 (open "pada_control_fact.dat" pada_cntrl_fp "w")
 (assert (index 1))
 (assert (English-list))
 (run)
 (close agmt_cntrl_fp)
 (close pada_cntrl_fp)
 (close pada_fp)
 (clear)
 ;================================ TRANSFER MODULE ===================================================
 ;~~~~~~~~~~~~~~~~~~~~WSD MODULE ~~~~~~~~~~~~~~~~~~~~~~~~~~
 (defmodule MAIN (export ?ALL)
                 (export deftemplate ?ALL))
 (deftemplate word-morph(slot original_word)(slot morph_word)(slot root)(slot category)(slot suffix)(slot number))
 (deftemplate pada_info (slot group_head_id (default 0))(slot group_cat (default 0))(multislot group_ids (default 0))(slot vibakthi (default 0))(slot gender (default 0))(slot number (default 0))(slot case (default 0))(slot person (default 0))(slot H_tam (default 0))(slot tam_source (default 0))(slot preceeding_part_of_verb (default 0)) (multislot preposition (default 0))(slot Hin_position (default 0))(slot pada_head (default 0)))
 (load-facts "meaning_to_be_decided.dat")
 (load-facts "word.dat")
 (load-facts "original_word.dat")
 (load-facts "root.dat")
 (load-facts "relations.dat")
 (load-facts "lwg_info.dat")
 (load-facts "pada_id_info.dat")
 (load-facts "morph.dat")
 (load-facts "cat_consistency_check.dat")
 (load-facts "preferred_morph.dat")
 (load* "global_path.clp")
 (load-facts "sand_box.dat")
 (load-facts "domain.dat")
 (defmodule WSD_MODULE (export ?ALL)
                       (import MAIN ?ALL)
                       (import MAIN deftemplate ?ALL))
 (set-current-module WSD_MODULE)
 (bind ?path1 (str-cat ?*path* "/Anu_clp_files/wsd_meaning.clp"))
 (defglobal ?*prov_dir* = ?*provisional_wsd_path*)
 (defglobal ?*wsd_dir* = "anu_testing/WSD/wsd_rules/canonical_form_wsd_rules/")
 (load* ?path1)
 (open "debug_file.dat" wsd_fp "a")
 (focus WSD_MODULE)
 (run)
 (focus WSD_MODULE)
 (undefrule *)
 (defrule retract_cntrl_fact
 (declare (salience -9999))
 ?f0<-(file_loaded ?id)
 =>
 (retract ?f0)
 )
 (run)
 (focus WSD_MODULE)
 (save-facts "wsd_facts_output.dat" local)
 (clear)
 ;----------------------------------------------------------------------
 ; take prefered morph according to wsd root
 (load "global_path.clp")
 (bind ?*path* (str-cat ?*path* "/Anu_clp_files/preferred_morph_consistency_check.bclp"))
 (bload ?*path*)
 (load-facts "root.dat")
 (load-facts "preferred_morph.dat")
 (load-facts "wsd_facts_output.dat")
 (open "revised_preferred_morph.dat" morph_cons_fp "a")
 (open "revised_root.dat" rev_rt_fp "a")
 (run)
 (clear)
 ;----------------------------------------------------------------------
 ; Generate tam for all verbs
 (load "global_path.clp")
 (bind ?*path* (str-cat ?*path* "/Anu_clp_files/tam_id.bclp"))
 (bload ?*path*)
 (load-facts "lwg_info.dat")
 (load-facts "meaning_to_be_decided.dat")
 (load-facts "revised_preferred_morph.dat")
 (load-facts "morph.dat")
 (load-facts "original_word.dat")
 (load-facts "E_constituents_info.dat")
 (load-facts "Node_category.dat")
 (open "tam_id.dat" tam_id_fp "a")
 (run)
 (clear)
 ;----------------------------------------------------------------------
 ; tam disambiguation in wsd rule
 (defmodule MAIN (export ?ALL))
 (load-facts "revised_root.dat")
 (load-facts "word.dat")
 (load-facts "cat_consistency_check.dat")
 (load-facts "relations.dat")
 (load-facts "meaning_to_be_decided.dat")
 (load-facts "tam_id.dat")
 (load-facts "revised_preferred_morph.dat")
 (load-facts "original_word.dat")
 (load* "global_path.clp")
 (load-facts "sand_box.dat")
 (load-facts "domain.dat")
 (defmodule WSD_TAM_MODULE (export ?ALL)
                       (import MAIN ?ALL))
 (set-current-module WSD_TAM_MODULE)
 (bind ?path1 (str-cat ?*path* "/Anu_clp_files/wsd_tam_meaning.clp"))
 (bind ?wsd_path (str-cat "anu_testing" "/WSD/wsd_rules/canonical_form_wsd_rules/"))
 (defglobal ?*prov_dir* = ?*provisional_wsd_path*)
 (defglobal ?*wsd_dir* = ?wsd_path)
 (load ?path1)
 (focus WSD_TAM_MODULE)
 (run)
 (focus WSD_TAM_MODULE)
 (undefrule *)
 (defrule retract_cntrl_fact
 (declare (salience -9999))
 ?f0<-(file_loaded ?id)
 =>
 (retract ?f0)
 )
 (run)
 (focus WSD_TAM_MODULE)
 (save-facts "wsd_tam_facts_output.dat" local)
 (clear)
 ;----------------------------------------------------------------------
 ; tam consistency check (more weightage to wsd then default)
 (load "global_path.clp")
 (bind ?*path* (str-cat ?*path* "/Anu_clp_files/tam_meaning.bclp"))
 (bload ?*path*)
 (load-facts "wsd_tam_facts_output.dat")
 (load-facts "lwg_info.dat")
 (load-facts "tam_id.dat")
 (load-facts "wsd_facts_output.dat")
 (load-facts "pada_id_info.dat")
 (load-facts "meaning_to_be_decided.dat")
 (load-facts "cat_consistency_check.dat")
 (run)
 (save-facts "hindi_tam_info.dat" local pada_info conj_head-left_head-right_head)
 (clear)
 ;----------------------------------------------------------------------
 (load "global_path.clp")
 (bind ?*path* (str-cat ?*path* "/Anu_clp_files/multi_word_expressions.bclp"))
 (bload ?*path*)
 (load-facts "original_word.dat")
 (load-facts "domain.dat")
 (assert (index 1))
 (assert (English-list))
 (run)
 (save-facts "multi_word_expressions.dat" local ids-cmp_mng-head-cat-mng_typ-priority ids-phy_cmp_mng-head-cat-mng_typ-priority)
 (clear)
 ;-----------------------------------------------------------------------
 ; Generate hindi meaning for every english word (priority -> compl.sen, compound,wsd,default etc..)
 (load "global_path.clp")
 (bind ?*path* (str-cat ?*path* "/Anu_clp_files/hindi_meaning.bclp"))
 (bload ?*path*)
 (load-facts "cat_consistency_check.dat")
 (load-facts "meaning_to_be_decided.dat")
 (load-facts "relations_tmp1.dat")
 (load-facts "sen_phrase.dat")
 (load-facts "multi_word_expressions.dat")
 (load-facts "revised_root.dat")
 (load-facts "wsd_facts_output.dat")
 (load-facts "wsd_tam_facts_output.dat")
 (load-facts "lwg_info.dat")
 (load-facts "original_word.dat")
 (load-facts "word.dat")
 (load-facts "domain.dat")
 (open "proper_nouns.dat" p_noun "w")
 (open "hindi_meanings_tmp.dat" fp "a")
 (open "hindi_meanings_tmp1.dat" fp1 "a")
 (open "catastrophe.dat" fp2 "w")
 (assert (default-cat)) 
 (run)
 (close p_noun)
 (clear)
 ;----------------------------------------------------------------------
 ; modify the hindi verb root to causative form (e.g KAnA_kilA --> KAnA-KilavA)
 (load "global_path.clp")
 (bind ?*path* (str-cat ?*path* "/Anu_clp_files/causative_verb_mng.bclp"))
 (bload ?*path*)
 (load-facts "meaning_to_be_decided.dat")
 (load-facts "lwg_info.dat")
 (load-facts "original_word.dat")
 (load-facts "hindi_meanings_tmp.dat")
 (load-facts "wsd_facts_output.dat")
 (load-facts "wsd_tam_facts_output.dat")
 (load-facts "cat_consistency_check.dat")
 (open "hindi_meanings.dat" caus_mng_fp "a")
 (run)
 (clear)
 ;----------------------------------------------------------------------
 ; Across paxa ordering
 (load "global_path.clp")
 (bind ?*path* (str-cat ?*path* "/Anu_clp_files/H_ordering_rules.clp"))
 (load ?*path*)
 (load-facts "original_word.dat")
 (load-facts "relations_tmp1.dat")
 (load-facts "E_constituents_info.dat")
 (load-facts "Node_category.dat")
 (load-facts "cat_consistency_check.dat")
 (load-facts "hindi_tam_info.dat")
 (open "hin_order_debug.dat" order_debug "a")
 (run)
 (save-facts "ordered_constituents.dat" local Head-Level-Mother-Daughters Node-Category)
 (save-facts "hindi_id_order_tmp.dat" local hindi_id_order)
 (clear)
 ;---------------------------------------------------------------------------------
 (load "global_path.clp")
 (bind ?*path* (str-cat ?*path* "/Anu_clp_files/get_constituency_tree.bclp"))
 (bload ?*path*)
 (load-facts "hindi_rev_order.dat")
 (assert (daughter ROOT1))
 (assert (Cons-tree))
 (run)
 (save-facts "rev_constituency_tree.dat" local Cons-tree)
 (clear)
 ;=================================  LANGUAGE GENERATION MODULE =================================
 ; Determine gender of all hindi words
 (load "global_path.clp")
 (bind ?*path* (str-cat ?*path* "/Anu_clp_files/gender_info.bclp"))
 (bload ?*path*)
 (load-facts "meaning_to_be_decided.dat")
 (load-facts "cat_consistency_check.dat")
 (load-facts "original_word.dat")
 (load-facts "hindi_meanings.dat")
 (open "gender_tmp.dat" gen_fp "a")
 (run)
 (clear)
 ;----------------------------------------------------------------------
 ; Determine viBakwi for each pada taking information from wsd,tam,shasthi-pronouns
 (load "global_path.clp")
 (bind ?*path* (str-cat ?*path* "/Anu_clp_files/vibakthi.bclp"))
 (bload ?*path*)
 (assert (load_yA_tams_with_ne))
 (load-facts "hindi_meanings.dat")
 (load-facts "pada_control_fact.dat")
 (load-facts "relations_tmp1.dat")
 (load-facts "wsd_tam_facts_output.dat")
 (load-facts "hindi_tam_info.dat")
 (load-facts "wsd_facts_output.dat")
 (load-facts "multi_word_expressions.dat")
 (load-facts "original_word.dat")
 (load-facts "revised_root.dat")
 (run)
 (save-facts "vibakthi_info.dat" local pada_info conj_head-left_head-right_head)
 (clear)
 ;----------------------------------------------------------------------
 ; Decide the verb agreement with padas.
 (load "global_path.clp")
 (bind ?*path* (str-cat ?*path* "/Anu_clp_files/agreement.bclp"))
 (bload ?*path*)
 (load-facts "vibakthi_info.dat")
 (load-facts "relations_tmp1.dat")
 (load-facts "agmt_control_fact.dat")
 (load-facts "hindi_meanings.dat")
 (load-facts "original_word.dat")
 (open "verb_agreement.dat" agrmt_fp "a")
 (open "agreement_debug.dat" agrmt_db "a")
 (run)
 (clear)
 ;----------------------------------------------------------------------
 ; Determine the number of each word.
 (load "global_path.clp")
 (bind ?*path* (str-cat ?*path* "/Anu_clp_files/number.bclp"))
 (bload ?*path*)
 (load-facts "word.dat")
 (load-facts "revised_preferred_morph.dat")
 (load-facts "verb_agreement.dat")
 (load-facts "wsd_facts_output.dat")
 (load-facts "lwg_info.dat")
 (assert (std-parser-num))
 (run)
 (save-facts "number.dat" local id-number-src)
 (clear)
 ;--------------------------------------------------------------------------
 ; intra-paxa aggreement (e.g A fat boy -> ek motA ladakA)
 (load "global_path.clp")
 (bind ?*path* (str-cat ?*path* "/Anu_clp_files/GNP_agreement.bclp"))
 (bload ?*path*)
 (load-facts "vibakthi_info.dat")
 (load-facts "verb_agreement.dat")
 (load-facts "original_word.dat")
 (load-facts "relations_tmp1.dat")
 (load-facts "number.dat")
 (load-facts "gender_tmp.dat")
 (load-facts "hindi_meanings.dat")
 (load-facts "pada_control_fact.dat")
 (load-facts "cat_consistency_check.dat")
 (open "GNP_errors.txt" err_fp "a")
 (open "GNP_debug.dat" gnp_fp "a")
 (open "gender.dat" gender_fp "a")
 (run)
 (save-facts "GNP_agmt_info.dat" local pada_info conj_head-left_head-right_head)
 (close gnp_fp)
 (close gender_fp)
 (clear)
 ;-------------------------------------------------------------------------------
 ; Adding extra hindi word and reorder the hindi sentence (e.g Are you going ?  -> kyA Aap jA rahe ho ?)
 (load "global_path.clp")
 (bind ?*path* (str-cat ?*path* "/Anu_clp_files/hindi_sent_reorder.bclp"))
 (bload ?*path*)
 (load-facts "relations_tmp1.dat")
 (load-facts "word.dat")
 (load-facts "revised_root.dat")
 (load-facts "cat_consistency_check.dat")
 (load-facts "GNP_agmt_info.dat")
 (load-facts "hindi_id_order_tmp.dat")
 (load-facts "lwg_info.dat")
 (load-facts "parser_type.dat")
 (load-facts "ordered_constituents.dat")
 (load-facts "Node_category.dat")
 (load-facts "hindi_meanings.dat")
 (open "hindi_id_reorder_debug.dat" h_id_reorder_fp "a")
 (run)
 (save-facts "hindi_id_order.dat" local hindi_id_order)
 (clear)
 ;--------------------------------------------------------------------------
 (load "global_path.clp")
 (bind ?*path* (str-cat ?*path* "/Anu_clp_files/insert_punctuation.clp"))
 (load ?*path*)
 (load-facts "ordered_constituents.dat")
; (load-facts "Node_category.dat")
 (load-facts "parser_punctuation_info.dat")
 (load-facts "hindi_id_order.dat")
 (load-facts "word.dat")
 (run)
 (save-facts "hindi_punctuation.dat" local  hid-punc_head-left_punctuation hid-punc_head-right_punctuation)
 (clear)
 ;--------------------------------------------------------------------------
 ; prepare Apertium input for final hindi word generation.
 (load "global_path.clp")
 (bind ?*path* (str-cat ?*path* "/Anu_clp_files/prepare_apertium_input.bclp"))
 (bload ?*path*)
 (assert (load_facts))
 (load-facts "word.dat")
 (load-facts "lwg_info.dat")
 (load-facts "original_word.dat")
 (load-facts "GNP_agmt_info.dat")
 (load-facts "hindi_meanings.dat")
 (load-facts "relations_tmp1.dat")
 (load-facts "wsd_facts_output.dat")
 (load-facts "wsd_tam_facts_output.dat")
 (load-facts "hindi_id_order.dat")
 (load-facts "verb_agreement.dat")
 (load-facts "number.dat")
 (load-facts "gender.dat")
 (load-facts "cat_consistency_check.dat")
 (load-facts "revised_preferred_morph.dat")
 (load-facts "tam_id.dat")
 (open "id_Apertium_input.dat" fp5 "a")
 (open "apertium_input_debug.dat" aper_debug "a")
 (run)
 (clear)
 ;--------------------------------------------------------------------------
 ; For html output generate paxasUwra layer for each word.
 (load "global_path.clp")
 (bind ?*path* (str-cat ?*path* "/Anu_clp_files/padasuthra.bclp"))
 (bload ?*path*)
 (load-facts "original_word.dat")
 (load-facts "word.dat")
 (load-facts "revised_root.dat")
 (load-facts "cat_consistency_check.dat")
 (load-facts "hindi_meanings.dat")
 (open "padasuthra.dat" paxasUwra_fp "a")
 (run)
 (close paxasUwra_fp)
 (clear)
 ;--------------------------------------------------------------------------
 (load "global_path.clp")
 (defglobal ?*path1* = ?*path*)
 (bind ?*path* (str-cat ?*path* "/Anu_clp_files/catastrophe.clp"))
 (load ?*path*)
 (bind ?*path1* (str-cat ?*path1* "/Anu_clp_files/idioms.clp"))
 (load ?*path1*)
 (load-facts "word.dat")
 (load-facts "lwg_info.dat")
 (load-facts "relations.dat")
 (load-facts "root.dat")
 (load-facts "punctuation_info.dat")
 (load-facts "revised_preferred_morph.dat")
 (assert (comma_list ))
 (assert (index 1))
 (assert (English-list))
 (open "catastrophe.dat" catas_fp "a")
 (run)
 (clear)
 ;--------------------------------------------------------------------------
 (load "global_path.clp")
 (bind ?*path* (str-cat ?*path* "/Anu_clp_files/sd_chunker.clp"))
 (load ?*path*)
 (load-facts "E_constituents_info.dat")
 (load-facts "Node_category.dat")
 (load-facts "lwg_info.dat")
 (load-facts "word.dat")
 (run)
 (save-facts "sd_chunk.dat" local chunk-ids)
 (clear)
 ;--------------------------------------------------------------------------
 (load "global_path.clp")
 (bind ?*path* (str-cat ?*path* "/Anu_clp_files/get_all_possible_roots.clp"))
 (load ?*path*)
 (load-facts "morph.dat")
 (load-facts "revised_root.dat")
 (load-facts "original_word.dat")
 (open "get_all_roots.dat" get_fp "a");
 (run)
 (exit)
