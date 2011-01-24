; mapping between parser-generated id and original word id
 (load "global_path.clp")
 (bind ?*path* (str-cat ?*path* "/Anu_clp_files/ol_parserid_wordid_mapping.bclp"))
 (bload ?*path*)
 (load-facts "ol_resid_wordid_mapping_tmp.dat")
 (load-facts "morph.dat")
 (load-facts "word.dat")
 (load-facts "transformed_word_id.dat")
 (open "ol_resid_wordid_mapping.dat" ol_word_fp1 "a")
 (open "parserid_wordid_mapping.dat" ol_word_fp "a")
 (run)
 (clear)
 ;----------------------------------------------------------------------------
; Determine root of each word after cat consistency
 (load "global_path.clp")
 (bind ?*path* (str-cat ?*path* "/Anu_clp_files/root_rule.bclp"))
 (bload ?*path*)
 (load-facts "ol_cat_info.dat")
 (load-facts "morph.dat")
 (load-facts "original_word.dat")
 (load-facts "morph_root_tobe_choosen.dat")
 (load-facts "parserid_wordid_mapping.dat")
 (open "root_tmp.dat" rt_fp "a")
 (open "preferred_morph_tmp.dat" pre_fp "a")
 (run)
 (clear)
 ;-----------------------------------------------------------------------------------
 ; modify the root accordingly (e.g Broken window - > broken(adj) but take root (broken-verb)
 (load "global_path.clp")
 (bind ?*path* (str-cat ?*path* "/Anu_clp_files/root_consistency_check.clp"))
 (load ?*path*)
 (load-facts "original_word.dat")
 (load-facts "morph.dat")
 (load-facts "ol_cat_info.dat")
 (load-facts "root_tmp.dat")
 (load-facts "parserid_wordid_mapping.dat")
 (open "root_consistency_check_tmp.dat" root_cons_tmp_fp "a")
 (run)
 (clear)
 ;------------------------------------------------------------------------
 ;Desambiguating LWG:
 (load "global_path.clp")
 (bind ?*path* (str-cat ?*path* "/Anu_clp_files/lwg_disambiguation.bclp"))
 (bload ?*path*)
 (load-facts "ol_resid_wordid_mapping.dat")
 (load-facts "ol_original_relation_tmp.dat")
 (load-facts "ol_lwg_res_info.dat")
 (load-facts "root_tmp.dat")
 (open "ol_original_relations.dat" ol_rel "a")
 (open "ol_lwg_info.dat" ol_lwg_fp "a")
 (run)
 (clear)

 ;----------------------------------------------------------------------
 ;Modifying category
 (load "global_path.clp")
 (bind ?*path* (str-cat ?*path* "/Anu_clp_files/modify_ol_cat.bclp"))
 (bload ?*path*)
 (load-facts "ol_original_relations.dat")
 (load-facts "ol_cat_info.dat")
 (load-facts "ol_nonfinite.dat")
 (load-facts "ol_resid_wordid_mapping.dat")
 (open "ol_cat_info_tmp1.dat" ol_cat_file "a")
 (run)
 (clear)
 ;------------------------------------------------------------------------
 ;Modifying relations 
 (load "global_path.clp")
 (bind ?*path* (str-cat ?*path* "/Anu_clp_files/modify_ol_relations.bclp"))
 (bload ?*path*)
 (load-facts "ol_cat_info_tmp1.dat")
 (load-facts "word.dat")
 (load-facts "parserid_wordid_mapping.dat")
 (load-facts "ol_resid_wordid_mapping.dat")
 (load-facts "ol_original_relations.dat")
 (load-facts "ol_lwg_info.dat")
 (load-facts "ol_pada_tmp.dat")
 (open "ol_relations.dat" ol_rel_file "a")
 (open "ol_relation_debug.dat" ol_rel_debug_file "a")
 (run)
 (clear)

 ;----------------------------------------------------------------------
 ; mapping parser id back to original word id (e.g L1 -> 1)
 (load "global_path.clp")
 (bind ?*path* (str-cat ?*path* "/Anu_clp_files/ol_parser_id_mapping.bclp"))
 (bload ?*path*)
 (load-facts "ol_lwg_info.dat")
 (load-facts "word.dat")
 (load-facts "original_word.dat")
 (load-facts "root_consistency_check_tmp.dat")
 (load-facts "preferred_morph_tmp.dat")
 (load-facts "ol_relations.dat")
 (load-facts "ol_cat_info_tmp1.dat")
 (load-facts "parserid_wordid_mapping.dat")
 (load-facts "ol_resid_wordid_mapping.dat")
 (load-facts "ol_number.dat")
 (open "root.dat" root_fp "a")
 (open "preferred_morph.dat" pre_morph_fp "a")
 (open "lwg_info.dat" lwg_fp "a")
 (open "relations.dat" file "a")
 (open "relations_tmp1.dat" file1 "a")
 (open "relations_id_map_debug.dat" rel_debug "a")
 (open "meaning_has_been_decided.dat" mng_dcd_fp "a")
 (open "cat_consistency_check.dat" cat_cons_fp "a")
 (open "number_tmp.dat" num_fp "a")
 (run)
 (clear)
 ;----------------------------------------------------------------------
 ;Deleting and/or modifying padas
 (load "global_path.clp")
 (bind ?*path* (str-cat ?*path* "/Anu_clp_files/modify_ol_pada.bclp"))
 (bload ?*path*)
 (load-facts "ol_resid_wordid_mapping.dat")
 (load-facts "ol_pada_tmp.dat")
 (load-facts "ol_prep.dat")
 (load-facts "ol_relations.dat")
 (open "ol_vachan_to_be_decided.dat" vachan_fp "a")
 (open "ol_agmt_control_fact.dat" agmt_cntrl_fp "a")
 (open "ol_pada_control_fact.dat" pada_cntrl_fp "a")
 (open "ol_pada.dat" ol_pada_file "a")
 (open "ol_pada_debug.dat" ol_pada_debug_fp "a")
 (run)
 (clear)
 ;----------------------------------------------------------------------------
 ;Mapping pada ids
 (load "global_path.clp")
 (bind ?*path* (str-cat ?*path* "/Anu_clp_files/ol_pada_id_mapping.clp"))
 (load ?*path*)
 (load-facts "parserid_wordid_mapping.dat")
 (load-facts "ol_pada.dat")
 (load-facts "ol_vachan_to_be_decided.dat")
 (load-facts "ol_agmt_control_fact.dat")
 (load-facts "ol_pada_control_fact.dat")
 (load-facts "ol_resid_wordid_mapping.dat")
 (open "pada_id_info.dat" map_pada "a")
 (run)
 (save-facts "vachan_to_be_decided.dat" local vachan_to_be_decided)
 (save-facts "agmt_control_fact.dat" local agmt_control_fact)
 (save-facts "pada_control_fact.dat" local pada_control_fact)
 (clear)
 ;~~~~~~~~~~~~~~~~~~~~WSD MODULE ~~~~~~~~~~~~~~~~~~~~~~~~~~
 (defmodule MAIN (export ?ALL)
                 (export deftemplate ?ALL))
 (deftemplate word-morph(slot original_word)(slot morph_word)(slot root)(slot category)(slot suffix)(slot number))
 (load-facts "meaning_to_be_decided.dat")
 (load-facts "word.dat")
 (load-facts "original_word.dat")
 (load-facts "root.dat")
 (load-facts "relations.dat")
 (load-facts "lwg_info.dat")
 (load-facts "morph.dat")
 (load-facts "cat_consistency_check.dat")
 ;(load-facts "meaning_has_been_decided.dat")
 (load-facts "preferred_morph.dat")
 (load-facts "sent_type.dat")
 (load* "global_path.clp")
 (defmodule WSD_MODULE (export ?ALL)
                       (import MAIN ?ALL)
                       (import MAIN deftemplate ?ALL))
 (set-current-module WSD_MODULE)
 (bind ?path1 (str-cat ?*path* "/Anu_clp_files/wsd_meaning.clp"))
 (defglobal ?*prov_dir* = ?*provisional_wsd_path*)
 (defglobal ?*wsd_dir* = "anu_testing/WSD/wsd_rules/")
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
 (load-facts "morph.dat")
 (load-facts "preferred_morph.dat")
 (load-facts "wsd_facts_output.dat")
 (open "revised_preferred_morph.dat" morph_cons_fp "a")
 (open "revised_root.dat" rev_rt_fp "a")
 (run)
 (clear)
 ;----------------------------------------------------------------------
 ; Generate tam for all verbs
 (load "global_path.clp")
 (bind ?*path* (str-cat ?*path* "/Anu_clp_files/vibakthi_id.bclp"))
 (bload ?*path*)
 (load-facts "lwg_info.dat")
 (load-facts "meaning_to_be_decided.dat")
 (load-facts "revised_preferred_morph.dat")
 (load-facts "morph.dat")
 (load-facts "original_word.dat")
 (open "vibakthi_id.dat" vib_id_fp "a")
 (open "tam_id.dat" tam_id_fp "a")
 (run)
 (clear)
 ;----------------------------------------------------------------------
 ;Generate equivalent hindi tam for every english tam
 (load "global_path.clp")
 (bind ?*path* (str-cat ?*path* "/Anu_clp_files/hindi_tam_rules.bclp"))
 (bload ?*path*)
 (load-facts "lwg_info.dat")
 (open "hindi_tam_tmp.dat" Hin_tam "a")
 (run)
 (clear)
 ;--------------------------------------------------------------------
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
 (defmodule WSD_TAM_MODULE (export ?ALL)
                       (import MAIN ?ALL))
 (set-current-module WSD_TAM_MODULE)
 (bind ?path1 (str-cat ?*path* "/Anu_clp_files/wsd_tam_meaning.clp"))
 (bind ?wsd_path (str-cat "anu_testing" "/WSD/wsd_rules/"))
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
 (load-facts "hindi_tam_tmp.dat")
 (load-facts "wsd_facts_output.dat")
 (load-facts "pada_id_info.dat")
 (load-facts "meaning_to_be_decided.dat")
 (run)
 (save-facts "hindi_tam_info.dat" local pada_info)
 (clear)
 ;----------------------------------------------------------------------
 ; Generate hindi meaning for every english word (priority -> compl.sen, compound,wsd,default etc..)
 (load "global_path.clp")
 (bind ?*path* (str-cat ?*path* "/Anu_clp_files/hindi_meaning.bclp"))
 (bload ?*path*)
 (load-facts "cat_consistency_check.dat")
 (load-facts "meaning_to_be_decided.dat")
 (load-facts "relations.dat")
 (load-facts "sen_phrase.dat")
 (load-facts "compound_phrase.dat")
 (load-facts "revised_root.dat")
 (load-facts "wsd_facts_output.dat")
 (load-facts "wsd_tam_facts_output.dat")
 (load-facts "lwg_info.dat")
 (load-facts "original_word.dat")
 (open "hindi_meanings_tmp.dat" fp "a")
 (run)
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
 ; Determine gender of all hindi words
 (load "global_path.clp")
 (bind ?*path* (str-cat ?*path* "/Anu_clp_files/gender_info.bclp"))
 (bload ?*path*)
 (load-facts "meaning_to_be_decided.dat")
 (load-facts "cat_consistency_check.dat")
 (load-facts "original_word.dat")
 (load-facts "hindi_meanings.dat")
 (open "gender.dat" gen_fp "a")
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
 (load-facts "relations.dat")
 (load-facts "wsd_tam_facts_output.dat")
 (load-facts "hindi_tam_tmp.dat")
 (load-facts "hindi_tam_info.dat")
 (load-facts "wsd_facts_output.dat")
 (load-facts "compound_phrase.dat")
 (load-facts "original_word.dat")
 (load-facts "revised_root.dat")
 (assert (index 1))
 (assert (hin_mng_list))
 (run)
 (save-facts "vibakthi_info.dat" local pada_info)
 (clear)
 ;----------------------------------------------------------------------
 ; Decide the verb agreement with padas.
 (load "global_path.clp")
 (bind ?*path* (str-cat ?*path* "/Anu_clp_files/agreement.bclp"))
 (bload ?*path*)
 (load-facts "vibakthi_info.dat")
 (load-facts "relations.dat")
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
 (bind ?*path* (str-cat ?*path* "/Anu_clp_files/ol_number.clp"))
 (load ?*path*)
 (load-facts "morph.dat")
 (load-facts "word.dat")
 (load-facts "verb_agreement.dat")
 (load-facts "wsd_facts_output.dat")
 (load-facts "number_tmp.dat")
 (open "number.dat" num_fp1 "a")
 (run)
 (clear)
  ;--------------------------------------------------------------------------
 ; intra-paxa aggreement (e.g A fat boy -> ek motA ladakA)
 (load "global_path.clp")
 (bind ?*path* (str-cat ?*path* "/Anu_clp_files/GNP_agreement.bclp"))
 (bload ?*path*)
 (load-facts "vibakthi_info.dat")
 (load-facts "verb_agreement.dat")
 (load-facts "original_word.dat")
 (load-facts "relations.dat")
 (load-facts "number.dat")
 (load-facts "gender.dat")
 (load-facts "hindi_meanings_tmp.dat")
 (load-facts "pada_control_fact.dat")
 (open "GNP_errors.txt" err_fp "a")
 (open "GNP_debug.dat" gnp_fp "a")
 (run)
 (save-facts "GNP_agmt_info.dat" local pada_info)
 (close gnp_fp)
 (clear)
  ;-------------------------------------------------------------------------------
 ; with in paxa ordering (e.g to reach your potential --> hindi ((your) (potential)(to reach))
 (load "global_path.clp")
 (bind ?*path* (str-cat ?*path* "/Anu_clp_files/pada_point_concept_rules.clp"))
 (load ?*path*)
 (load-facts "relations_tmp1.dat")
 (load-facts "relations.dat")
 (load-facts "original_word.dat")
 (load-facts "to_be_included_in_paxa.dat")
 (load-facts "lwg_info.dat")
 (load-facts "word.dat")
 (load-facts "cat_consistency_check.dat")
 (open "pada_point_debug.dat" pada_point_debug "a")
 (assert (index 1))
 (assert (Eng_sen))
 (run)
 (save-facts "pada_info.dat" local current_id-group_members id-current_id relation-anu_ids pada_head-preposition_id )
 (save-facts "pada_with_point_concept.dat" local pada_info)
 (clear)
  ;---------------------------------------------------------------------------------
 ; Across paxa ordering
 (load "global_path.clp")
 (bind ?*path* (str-cat ?*path* "/Anu_clp_files/hindi_position.bclp"))
 (bload ?*path*)
 (load-facts "word.dat")
 (load-facts "chunk.dat")
 (load-facts "lwg_info.dat")
 (load-facts "Eng_id_order.dat")
 (load-facts "punctuation_info.dat")
 (load-facts "pada_info.dat")
 (open "hin_pos_debug.dat" hin_pos_debug "a")
 (run)
 (save-facts "hindi_id_order.dat" local hindi_id_order)
 (save-facts "hindi_position.dat" local pada_info)
 (clear)
 ;---------------------------------------------------------------------------------
 ; Addin extra hindi word and reorder the hindi sentence (e.g Are you going ?  -> kyA Aap jA rahe ho ?)
 (load "global_path.clp")
 (bind ?*path* (str-cat ?*path* "/Anu_clp_files/ol_hindi_sent_reorder.bclp"))
 (bload ?*path*)
 (load-facts "relations.dat")
 (load-facts "sent_type.dat")
 (load-facts "word.dat")
 (load-facts "revised_root.dat")
 (load-facts "cat_consistency_check.dat")
 (load-facts "GNP_agmt_info.dat")
 (load-facts "hindi_id_order.dat")
 (load-facts "hindi_meanings.dat")
 (load-facts "ol_resid_wordid_mapping.dat")
 (open "hindi_id_reorder_debug.dat" h_id_reorder_fp "a")
 (run)
 (save-facts "hindi_id_reorder.dat" local hindi_id_order)
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
 (load-facts "relations.dat")
 (load-facts "wsd_facts_output.dat")
 (load-facts "wsd_tam_facts_output.dat")
 (load-facts "hindi_id_reorder.dat")
 (load-facts "verb_agreement.dat")
 (load-facts "number.dat")
 (load-facts "gender.dat")
 (load-facts "sen_phrase.dat")
 (load-facts "cat_consistency_check.dat")
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
 (exit)
