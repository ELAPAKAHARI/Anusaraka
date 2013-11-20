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
;(7-11-13)
;The snow created further problems. [Cambridge Learner’s Dictionary]
;baraPa ne Ora aXika samasyAez uwwapanna kIM.
(defrule create_uwwapanna_kara
(declare (salience 700))
(id-root ?id create)
?mng <-(meaning_to_be_decided ?id)
(id-cat_coarse ?id verb)
(kriyA-object  ?id ?id1)
(id-root ?id1 feeling|confusion|problem|job)
=>
(retract ?mng)
(assert (id-wsd_root_mng ?id uwwapanna_kara ))
(if ?*debug_flag* then
(printout wsd_fp "(dir_name-file_name-rule_name-id-wsd_root_mng   " ?*wsd_dir* "  create.clp	create_uwwapanna_kara   "  ?id "  uwwapanna_kara )" crlf))
)
;#############################Defaults rule#######################################
;(7-11-13)
;The Bible says that God created the world. [Cambridge Learner’s Dictionary]
;bAibila kahawI hE ki ISvara ne viSva banAyA hE.
(defrule create_banA
(declare (salience 500))
(id-root ?id create)
?mng <-(meaning_to_be_decided ?id)
(id-cat_coarse ?id verb)
=>
(retract ?mng)
(assert (id-wsd_root_mng ?id banA))
(if ?*debug_flag* then
(printout wsd_fp "(dir_name-file_name-rule_name-id-wsd_root_mng   " ?*wsd_dir* "  create.clp	create_banA   "  ?id "  banA )" crlf))
)
;################### Need to be handled ####################
;The reorganization has created a lot of bad feeling.
;--> obj of create should be feeling instead of lot
;################### Additional Examples ####################
;The project will create more than 500 jobs. 
;The government plans to create more jobs for young people.
;The announcement only succeeded in creating confusion.
;They've painted it red to create a feeling of warmth.
;Scientists disagree about how the universe was created.
;The main purpose of industry is to create wealth.
;Create a new directory and put all your files into it.
;Try this new dish, created by our head chef.
;The company is trying to create a young energetic image.
;The government has created eight new peers.
;He was created a baronet in 1715.
;It's important to create a good impression when you meet a new client. 
;Charles Schulz created the characters 'Snoopy' and 'Charlie Brown.


