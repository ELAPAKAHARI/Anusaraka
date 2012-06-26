 ;----------------------------------------------------------------------
 (load "global_path.clp")
 (bind ?*path* (str-cat ?*path* "/Anu_clp_files/English_sentence.bclp"))
 (bload ?*path*)
 (load-facts "word.dat")
 (load-facts "vibakthi_info.dat")
 (load-facts "punctuation_info.dat")
 (load-facts "hindi_id_order.dat")
 (open "hin_eng_sent.dat" e_sen_fp "a")
 (run)
 (clear)
 ;----------------------------------------------------------------------
 (load "global_path.clp")
 (bind ?*path* (str-cat ?*path* "/Anu_clp_files/hindi_sentence.bclp"))
 (bload ?*path*)
 (load-facts "word.dat")
 (load-facts "parser_type.dat")
 (load-facts "id_Apertium_output.dat")
 (load-facts "hindi_id_order.dat")
 (load-facts "hindi_punctuation.dat")
 (load-facts "punctuation_info.dat")
 (load-facts "original_word.dat")
 (load-facts "underscore_hyphen_replace_info.dat")
 (open "hindi_sentence.dat" h_sen_fp "a")
 (run)
 (clear)
 ;--------------------------------------------------------------------------
 (load "global_path.clp")
 (bind ?*path* (str-cat ?*path* "/Anu_clp_files/eng_hin_pos.clp"))
 (load ?*path*)
 (load-facts "Eng_id_order.dat")
 (load-facts "hindi_id_order.dat")
 (load-facts "lwg_info.dat")
 (load-facts "GNP_agmt_info.dat")
 (load-facts "hindi_meanings.dat")
 (load-facts "hindi_meanings_tmp1.dat")
 (load-facts "original_word.dat")
 (load-facts "id_Apertium_output.dat")
 (assert (index 1))
 (assert (English_Sen))
 (open "position.dat" pos_fp "a")
 (run)
 (close pos_fp)
 (clear)
 ;--------------------------------------------------------------------------
 (load "global_path.clp")
 (bind ?*path* (str-cat ?*path* "/miscellaneous/SMT/alignment/get_wx.clp"))
 (load ?*path*)
 (load-facts "hindi_meanings.dat")
 (load-facts "wx_output.dat")
 (load-facts "word.dat")
 (run)
 (save-facts "hin_mng_without_@.dat" local id-HM-source)
 (save-facts "wx_agrep_output.dat" local eng_word-man_wx_word)
 (clear)
 ;--------------------------------------------------------------------------
 (load "global_path.clp")
 (bind ?*path* (str-cat ?*path* "/miscellaneous/SMT/alignment/get_anu_grp_mng.clp"))
 (load ?*path*)
 (load-facts "id_Apertium_output.dat")
 (load-facts "hin_mng_without_@.dat")
 (load-facts "sd_scope.dat")
 (load-facts "GNP_agmt_info.dat")
 (load-facts "to_be_included_in_paxa.dat")
 (open "anu_grp_mng.dat" ap_grp_fp "w")
 (open "aper_op_without_@.dat" ap_fp "w")
 (run)
; (save-facts "id_Apertium_output_new.dat" local id-Apertium_output)
 (close ap_fp)
 (close ap_grp_fp)
 (clear)
 ;--------------------------------------------------------------------------
 (load "global_path.clp")
 (bind ?*path* (str-cat ?*path* "/miscellaneous/SMT/alignment/change_manual_id.clp"))
 (load ?*path*)
 (load-facts "manual_word_tmp.dat")
 (load-facts "manual_ids_tmp.dat") 
 (load-facts "shallow_parser_root_tmp.dat")
 (run)
 (save-facts "manual_word.dat" local manual_id-word-cat)
 (save-facts "manual_ids_tmp.dat" local head_id-grp_ids)
 (save-facts "shallow_parser_root_tmp1.dat" local id-node-word-root)
 (clear)
 ;--------------------------------------------------------------------------
 (load "global_path.clp")
 (bind ?*path* (str-cat ?*path* "/miscellaneous/SMT/alignment/get_man_grp_mng.clp"))
 (load ?*path*)
 (load-facts "shallow_parser_GNP_info.dat")
 (load-facts "shallow_parser_output.dat.tmp7")
 (load-facts "manual_ids_tmp.dat")
 (load-facts "shallow_parser_root_tmp1.dat")
 (open  "manual_group_mng.dat" vb_fp "a")
 (run)
 (save-facts "manual_ids.dat" local head_id-grp_ids)
 (save-facts "shallow_parser_root.dat" local id-node-word-root)
 (close vb_fp)
 (clear)
 ;--------------------------------------------------------------------------
 (load "global_path.clp")
 (bind ?*path* (str-cat ?*path* "/miscellaneous/SMT/alignment/get_dbase_mng.clp"))
 (load ?*path*)
 (load-facts "revised_root.dat")
 (load-facts "original_word.dat") 
 (load-facts "cat_consistency_check.dat")
 (load-facts "lwg_info.dat")
 (assert (index 1))
 (assert (English-list))
 (run)
 (save-facts "database_mng.dat" local id-org_wrd-root-dbase_name-mng e_tam-id-dbase_name-mng multi_word_expression-dbase_name-mng multi_word_expression-grp_ids) 
 (clear)
 ;--------------------------------------------------------------------------
; (load "global_path.clp")
; (bind ?*path* (str-cat ?*path* "/miscellaneous/SMT/alignment/get_possible_anu_ids_for_man_mng.clp"))
; (load ?*path*)
; (load-facts "shallow_parser_root.dat")
; (load-facts "database_mng.dat")
; (load-facts "manual_word.dat")
; (load-facts "manual_hindi_sen.dat")
; (load-facts "word.dat")
; (load-facts "revised_root.dat")
; (run)
; (save-facts "alignment_possibilities.dat" local manual_id-root-anu_id anu_id-man-position-candidate_match)
 ;--------------------------------------------------------------------------
; (load "global_path.clp")
; (bind ?*path* (str-cat ?*path* "/miscellaneous/SMT/alignment/group_alignment.clp"))
; (load ?*path*)
; (load-facts "anu_grp_mng.dat")
; (load-facts "manual_group_mng.dat")
; (load-facts "shallow_parser_root.dat")
; (load-facts "revised_root.dat")
; (load-facts "database_mng.dat")
; (load-facts "aper_op_without_@.dat")
; (run)
; (save-facts "alignment.dat" local anu_id-a_grp_mng-sep-manual_id-m_grp_mng-man_grp_ids) 
; (clear)
 ;--------------------------------------------------------------------------
 (load "global_path.clp")
 (bind ?*path* (str-cat ?*path* "/miscellaneous/SMT/alignment/manual_lwg.clp"))
 (load ?*path*)
 (load-facts "manual_word.dat")
 (load-facts "manual_group_mng.dat")
 (load-facts "manual_ids.dat")
 (load-facts "shallow_parser_root.dat")
 (run)
 ;(save-facts "manual_lwg.dat" local manual_id-word-cat)
 (save-facts "manual_lwg.dat" local manual_id-cat-word-root-vib-grp_ids)
; (save-facts "manual_noun_grouping.dat" local manual_id-noun-vib-grp_ids)
 (clear)
 ;--------------------------------------------------------------------------
 (load "global_path.clp")
 (bind ?*path* (str-cat ?*path* "/miscellaneous/SMT/alignment/word_alignment.clp"))
 (load ?*path*)
 (load-facts "word.dat")
 (load-facts "manual_word.dat")
 (load-facts "manual_lwg.dat")
 (load-facts "database_mng.dat")
 (load-facts "aper_op_without_@.dat")
 (load-facts "shallow_parser_root.dat")
 ;(load-facts "pada_id_info.dat")
 (load-facts "GNP_agmt_info.dat")
; (load-facts "manual_noun_grouping.dat")
 (load-facts "manual_ids.dat")
 (load-facts "sd_scope.dat")
 (load-facts "manual_group_mng.dat")
 (load-facts "revised_root.dat")
 (load-facts "wx_agrep_output.dat")
 (assert (anu_verb_count-verbs 0))
 (assert (man_verb_count-verbs 0))
 (run)
 (save-facts "word_alignment_tmp.dat" local anu_id-anu_mng-sep-man_id-man_mng anu_id-anu_mng-sep-man_id-man_mng_tmp)
 (save-facts "potential_assignment.dat" local anu_verb_count-verbs man_verb_count-verbs potential_assignment_vacancy_id-candidate_id)
 (save-facts "anu_aligned_ids.dat" local mng_has_been_filled)
 (save-facts "man_aligned_ids.dat" local mng_has_been_aligned)
 (save-facts "confidence_level_tmp.dat" local id-confidence_level)
 (clear)
 ;--------------------------------------------------------------------------
 (load "global_path.clp")
 (bind ?*path* (str-cat ?*path* "/miscellaneous/SMT/alignment/default_word_alignment.clp"))
 (load ?*path*)
 (load-facts "potential_assignment.dat")
 (load-facts "GNP_agmt_info.dat")
 (load-facts "anu_aligned_ids.dat")
 (load-facts "man_aligned_ids.dat")
 (load-facts "manual_group_mng.dat")
 (load-facts "aper_op_without_@.dat")
 (load-facts "manual_word.dat")
 (load-facts "manual_lwg.dat")
 (load-facts "manual_ids.dat")
 (load-facts "word_alignment_tmp.dat")
 ;(load-facts "manual_noun_grouping.dat")
 (load-facts "hindi_id_order.dat")
 (load-facts "revised_root.dat")
 (load-facts "shallow_parser_root.dat")
 (load-facts "database_mng.dat")
 (load-facts "confidence_level_tmp.dat")
 (run)
 (save-facts "word_alignment.dat" local anu_id-anu_mng-sep-man_id-man_mng)
 (save-facts "confidence_level.dat" local id-confidence_level)
 (clear)
 (exit)
