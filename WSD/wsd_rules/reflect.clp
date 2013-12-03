;##############################################################################
;#  Copyright (C) 2002-2005 Preeti Pradhan (pradhan.preet@gmail.com)
;#
;#  This program is free software; you can redistribute it and/or
;#  modify it under the terms of the GNU General Public License
;#  as published by the Free Software Foundation; either
;#  version 2 of the License, or (at your option) any later
;#  version.
;#
;#  This program is distributed in the hope that it will be useful,
;#  but WITHOUT ANY WARRANTY; without even the implied warranty of
;#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;#  GNU General Public License for more details.
;#
;#  You should have received a copy of the GNU General Public License
;#  along with this program; if not, write to the Free Software
;#  Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
;
;##############################################################################
;(15-11-13)
;Before I decide, I need time to reflect. 
;isase pahale ki mEM nirNaya lU, muJe vicAra karane ke lie samaya cAhiye
;isase pahale ki mEM niScaya karawA hUz, muJe vicAra karane ke lie samaya kI AvaSyakawA hE. (This translation also accepted)
(defrule reflect_vicAra_kara
(declare (salience 800))
(id-root ?id reflect)
?mng <-(meaning_to_be_decided ?id)
(id-cat_coarse ?id verb)
(or (and (kriyA-subject  ?id ?id1) (id-root ?id1  ?str&:(and (not (numberp ?str))(gdbm_lookup_p "animate.gdbm" ?str)))) (kriyA-on_saMbanXI  ?id ?))
=>
(retract ?mng)
(assert (id-wsd_root_mng ?id vicAra_kara ))
(if ?*debug_flag* then
(printout wsd_fp "(dir_name-file_name-rule_name-id-wsd_root_mng   " ?*wsd_dir* "  reflect.clp	reflect_vicAra_kara   "  ?id " vicAra_kara )" crlf))
)

;(15-11-13)
;This material absorbs the sound, and does not reflect it. 
;yaha paxArWa Xvani soKa lewA hE, Ora ise parAvarwiwa_nahIM karawA hE.
(defrule reflect_parAvarwiwa_kara 
(declare (salience 700))
(id-root ?id reflect)
?mng <-(meaning_to_be_decided ?id)
(id-cat_coarse ?id verb)
(or(kriyA-object  ?id ?id1)(kriyA-subject  ?id ?id1))
(id-root ?id1 sunlight|heat|light|material)
=>
(retract ?mng)
(assert (id-wsd_root_mng ?id parAvarwiwa_kara ))
(if ?*debug_flag* then
(printout wsd_fp "(dir_name-file_name-rule_name-id-wsd_root_mng   " ?*wsd_dir* "  reflect.clp	reflect_parAvarwiwa_kara   "  ?id " parAvarwiwa_kara )" crlf))
)

;(15-11-13)
;His face was reflected in the mirror. 
;usakA ceharA xarpaNa meM prawibiMbiwa huA
(defrule reflect_prawibiMbiwa_ho
(declare (salience 600))
(id-root ?id reflect)
(id-word ?id reflected)
?mng <-(meaning_to_be_decided ?id)
(id-cat_coarse ?id verb)
=>
(retract ?mng)
(assert (id-wsd_root_mng ?id prawibiMbiwa_ho ))
(if ?*debug_flag* then
(printout wsd_fp "(dir_name-file_name-rule_name-id-wsd_root_mng   " ?*wsd_dir* "  reflect.clp	reflect_prawibiMbiwa_ho   "  ?id " prawibiMbiwa_ho )" crlf))
)

;#############################Defaults rule#######################################
;(15-11-13)
;The statistics reflect a change in people's spending habits. 
;Azkade logoM ke Karca karane kI AxawoM meM parivarwana xaraSAwe hEM.
(defrule reflect_xaraSA
(declare (salience 500))
(id-root ?id reflect)
?mng <-(meaning_to_be_decided ?id)
(id-cat_coarse ?id verb)
=>
(retract ?mng)
(assert (id-wsd_root_mng ?id xaraSA ))
(if ?*debug_flag* then
(printout wsd_fp "(dir_name-file_name-rule_name-id-wsd_root_mng   " ?*wsd_dir* "  reflect.clp	reflect_xaraSA   "  ?id " xaraSA )" crlf))
)
;################### Additional Examples ####################
;He saw himself reflected in the shop window.
;She could see herself reflected in his eyes.
;The windows reflected the bright afternoon sunlight.
;Our newspaper aims to reflect the views of the local community.
;His music reflects his interest in African culture.
;She was left to reflect on the implications of her decision.
;On the way home he reflected that the interview had gone well.
;She reflected how different it could have been.
;‘It could all have been so different,’ she reflected.
;In prison, he had plenty of time to reflect on the crimes he had committed.
