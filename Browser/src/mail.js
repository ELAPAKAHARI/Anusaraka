<style type="text/css">
/* popup_box DIV-Styles*/
#popup_box {
display:none;
position:fixed;
_position:absolute;
height:160px;
width:37%;
background:#FFFFFF;
left: 20%;
top: 150px;
z-index:100;
margin-left: 15px;  
border:2px solid #ff0000;
opacity:0;
padding:15px;
font-size:15px;
-moz-box-shadow: 0 0 5px #ff0000;
-webkit-box-shadow: 0 0 5px #ff0000;
box-shadow: 0 0 5px #ff0000;
}

a{
cursor: pointer;
text-decoration:none;
}

/* This is for the positioning of the Close Link */
#popupBoxClose {
font-size:20px;
line-height:15px;
right:5px;
top:5px;
position:absolute;
color:#6fa5e2;
font-weight:500;
}
</style>
<div id="popup_box">
<textarea name="message" id="message" rows="5" style="width:80%;" readonly></textarea><br/><br/>
Suggestion : <input type="text" id="sug" name="sug"/><br/>
<input type="submit" value="Send Email" style="float:right;" onclick="mail();return false;">
<a id="popupBoxClose">Close</a>
</div>
<style type="text/css">
            .opaqueLayer
            {
                display:none;
                position:absolute;
                top:0px;
                left:0px;
                opacity:0.6;
                filter:alpha(opacity=60);
                background-color: #000000;
                z-Index:1;
            }
</style>
<div id="shadow" class="opaqueLayer"> </div>
<script>
function mail(){
	var message = document.getElementById("message");
	var sug = "Suggestion - " + document.getElementById('sug').value;
	var mes = "";
	var i=7, ind=0;
	var root ="";
	//To get Word information
	while(message.value[i]!=' '&&message.value[i]!='\n'){
		mes+=message.value[i];
		i++;
		//Below 'if' loop added by Roja(14-02-14)
		if(message.value[i]=='\n') { 
			message.value[i++];
			break;
		}
	}
	var j=i+7;
	//To get Root information. Below 'while' loop added by Roja(14-02-14)
	while(message.value[j]!=' '&&message.value[j]!='\n'){
			root+=message.value[j];
			j++;
		}
	
//	var data = "subject=Incorrect Translation For \"" + mes + "\"";
	var data = "subject=Testing Email Concept \"" + mes + "\"";
	data+="&email=";
	var i=7;
	var char=message.value[i++].toUpperCase();

	//storing root in lower case.
	var root_low= "";
	root_low=root.toLowerCase();

	while(char!=' ') {
		if (root_low == "be" || root_low == "beat" || root_low == "become" || root_low == "begin" || root_low == "blow" || root_low =="break" || root_low == "bring" || root_low == "build" || root_low == "burn" || root_low == "buy" || root_low == "call" || root_low == "carry" || root_low == "catch" || root_low == "choose" || root_low == "clean") {
                        data+="gsingh.nik@gmail.com";
                        data += "&message=Dear Garima,%0A%0A" + message.value + sug;
			break;
 		}
		if (root_low == "come" || root_low == "cost" || root_low == "cut" || root_low == "deal" || root_low == "do" || root_low =="employ" || root_low == "figure" || root_low == "fill" || root_low == "follow" || root_low == "in"){ 
                        data+="pramila3005@gmail.com";
                        data += "&message=Dear Pramila,%0A%0A" + message.value + sug;
                        break;
                }
		if (root_low == "draw" || root_low == "drink" || root_low == "drive" || root_low == "eat" || root_low == "fall" || root_low =="feed" || root_low == "feel" || root_low == "fight" || root_low == "find" || root_low == "fit" || root_low == "taste" || root_low == "hear" || root_low == "smell" || root_low == "touch" || root_low == "see") {
                        data+="prachirathore02@gmail.com";
                        data += "&message=Dear Prachi,%0A%0A" + message.value + sug;
                        break;
                }
		if (root_low == "flow" || root_low == "fly" || root_low == "forget" || root_low == "forgive" || root_low == "get" || root_low =="give" || root_low == "go" || root_low == "grow" || root_low == "have" || root_low == "hide") {
                        data+="sonam27virgo@gmail.com";
                        data += "&message=Dear Sonam,%0A%0A" + message.value + sug;
                        break;
                }
		if (root_low == "hit" || root_low == "hold" || root_low == "hurt" || root_low == "keep" || root_low == "know" || root_low =="lay" || root_low == "lead" || root_low == "learn" || root_low == "leave" || root_low == "lend" || root_low == "let" || root_low == "lie" || root_low == "like" || root_low == "lose" || root_low == "make") {
                        data+="singh.jagriti5@gmail.com";
                        data += "&message=Dear Jagriti,%0A%0A" + message.value + sug;
                        break;
                }
		if (root_low == "mean" || root_low == "meet" || root_low == "mine" || root_low == "pay" || root_low == "play" || root_low =="put" || root_low == "read" || root_low == "ring" || root_low == "rise" || root_low == "run") {
                        data+="roja19p@gmail.com";
                        data += "&message=Dear Roja,%0A%0A" + message.value + sug;
                        break;
                }
		if (root_low == "say" || root_low == "sell" || root_low == "send" || root_low == "set" || root_low == "shake" || root_low =="shoot" || root_low == "show" || root_low == "shut" || root_low == "sing" || root_low == "sit" || root_low == "sleep" || root_low == "speak" || root_low == "stand" || root_low == "stick" || root_low == "still" ) {	
                        data+="roja19p@gmail.com";
                        data += "&message=Dear Roja,%0A%0A" + message.value + sug;
                        break;
                }
		if (root_low == "take" || root_low == "teach" || root_low == "tell" || root_low == "think" || root_low == "throw" || root_low =="understand" || root_low == "wear" || root_low == "win" || root_low == "write" || root_low == "above") {
                        data+="roja19p@gmail.com";
                        data += "&message=Dear Roja,%0A%0A" + message.value + sug;
                        break;
                }
		if (root_low == "act" || root_low == "after" || root_low == "all" || root_low == "any" || root_low == "as" || root_low == "at" || root_low == "back" || root_low == "bear" || root_low == "brush" || root_low == "by" || root_low == "check" || root_low == "clear" || root_low == "close" || root_low == "dress" || root_low == "drop" || root_low == "have") {
                        data+="roja19p@gmail.com";
                        data += "&message=Dear 123,%0A%0A" + message.value + sug;
                        break;
                }
		if (root_low == "jump" || root_low == "kick" || root_low == "knock" || root_low == "last" || root_low == "light" || root_low =="live" || root_low == "look" || root_low == "mark" || root_low == "move" || root_low == "of") {
                        data+="roja19p@gmail.com";
                        data += "&message=Dear Roja,%0A%0A" + message.value + sug;
                        break;
                }
		if (root_low == "off" || root_low == "open" || root_low == "over" || root_low == "press" || root_low == "pull" || root_low =="right" || root_low == "seize" || root_low == "to" || root_low == "turn" || root_low == "up") {
                        data+="roja19p@gmail.com";
                        data += "&message=Dear Roja,%0A%0A" + message.value + sug;
                        break;
                }
		if(char=='A'||char=='B'){
			data+="gsingh.nik@gmail.com";
			data += "&message=Dear Garima Singh,%0A%0A" + message.value + sug;
			break;
		}
		if(char=='C'){
			data+="pradhan.preet@gmail.com";
			data += "&message=Dear Preeti,%0A%0A" + message.value + sug;
			break;
		}
		if(char=='D'||char=='E'){
			data+="pramila3005@gmail.com";
			data += "&message=Dear Pramila,%0A%0A" + message.value + sug;
			break;
		}
		if(char=='F'||char=='G'){
			data+="krithika.ns@gmail.com";
			data += "&message=Dear Krithika,%0A%0A" + message.value + sug;
			break;
		}
		if(char=='H'||char=='I'||char=='J'||char=='K'){
			data+="prachirathore02@gmail.com";
			data += "&message=Dear Prachi Rathore,%0A%0A" + message.value + sug;
			break;
		}
		if(char=='L'||char=='M'||char=='N'){
			data+="nandini.upasani@gmail.com";
			data += "&message=Dear Nandini,%0A%0A" + message.value + sug;
			break;
		}
		if(char=='O'||char=='P'){
			data+="sonam27virgo@gmail.com";
			data += "&message=Dear Sonam,%0A%0A" + message.value + sug;
			break;
		}
		if(char=='Q'||char=='R'||char=='W'||char=='X'||char=='Y'||char=='Z'){
			data+="anita.chaturvedi@gmail.com";
			data += "&message=Dear Anita,%0A%0A" + message.value + sug;
			break;
		}
		if(char=='S'){
			data+="singh.jagriti5@gmail.com";
			data += "&message=Dear Jagriti Singh,%0A%0A" + message.value + sug;
			break;
		}
		if(char=='T'||char=='U'||char=='V'){
			data+="prachirathore02@gmail.com";
			data += "&message=Dear Prachi,%0A%0A" + message.value + sug;
			break;
		}
		char=message.value[i++].toUpperCase();
	}
	var xmlhttp=new XMLHttpRequest();
	message.innerHTML="";
	document.getElementById("popup_box").style.display="none";
	document.getElementById('popup_box').style.opacity="0";
	hideLayer();
	var flag;
	xmlhttp.onreadystatechange=function()
	{
		flag=0;
		if (xmlhttp.readyState==4 ){
			flag=1;
			alert("MESSAGE HAS BEEN SUCCESSFULLY SENT");
            	}
	};
	xmlhttp.open("GET","http://127.0.0.1/mail.php?"+data,true);
	xmlhttp.send(null);
}
</script>
<script>
function getBrowserHeight() {
                var intH = 0;
                var intW = 0;
                if(document.body && (document.body.clientWidth || document.body.clientHeight)) {
                    intH = document.body.clientHeight;
                    intW = document.body.clientWidth;
                }
                return { width: parseInt(intW), height: parseInt(intH) };
            }
            function setLayerPosition() {
                var shadow = document.getElementById("shadow");
                var bws = getBrowserHeight();
                shadow.style.width = bws.width + "px";
                shadow.style.height = bws.height + "px";
                shadow = null;
            }
            function showLayer() {
                setLayerPosition();
                var shadow = document.getElementById("shadow");
                shadow.style.display = "block";
                shadow = null;
            }
            function hideLayer() {
                var shadow = document.getElementById("shadow");
                shadow.style.display = "none";
                shadow = null;
            }
window.onresize = setLayerPosition;
table=document.getElementsByTagName("table");
for(i=0;i<table.length;i++)
{
table[i].ondblclick=function(){
	showLayer();
	var str = "Word - ";
	var str1 = "";
	tr = this.getElementsByTagName('tr');
	td = tr[0].getElementsByTagName('td');
	a = td[0].getElementsByTagName('a');
	span = a[0].getElementsByTagName('span');
	//To get Root information added below two lines by Roja(14-02-14)
	span1 = tr[3].getElementsByTagName('td');
	str1 = span1[0].innerHTML;

	if(span[0]==null){
		a = td[1].getElementsByTagName('a');
		span = a[0].getElementsByTagName('span');
		str += span[0].innerHTML;
	}
	else str += span[0].innerHTML;

	//getting sentence
	table1=document.getElementsByTagName("table");
	var nextsen = "";
	var man=0;
	for(i=0;i<table1.length;i++)
	{
		if(table1[i].getElementsByTagName("tr")[0].getElementsByTagName("td").length==2)man++;
		if(table1[i]==this)break;
	}
	man--;
	var k=i;
	for(j=i;j>=0;j--)
	{
		tr = table1[j].getElementsByTagName('tr');
		td = tr[0].getElementsByTagName('td');
		if(td[1]!=null){
			senno = td[0].innerHTML;
			k=j;
			break;
		}
	}
	for(j=k;j<=i;j++)
	{
		tr = table1[j].getElementsByTagName('tr');
		td = tr[0].getElementsByTagName('td');
		if(j!=k){
			a = td[0].getElementsByTagName('a');
		}
		else{
			a = td[1].getElementsByTagName('a');
		}
		span = a[0].getElementsByTagName('span');
		nextsen += span[0].innerHTML+" ";
	}
	for(j=i+1;j<table1.length;j++)
	{
		tr = table1[j].getElementsByTagName('tr');
		td = tr[0].getElementsByTagName('td');
		if(td[1]==null){
			a = td[0].getElementsByTagName('a');
			span = a[0].getElementsByTagName('span');
			nextsen += span[0].innerHTML+" ";
		}
		else{
			break;
		}
	}
	//Storing Word, Root, English Sentence and hindi Trnslation in str variable.
	str += "\nRoot -" + str1 + "\nSentence - "+nextsen + "\nHindi Translation - ";

if(top.frames["ManHindiTranslation"]){
	var fr = top.ManHindiTranslation;
	var tableid = "table"+man;
	var mansen = fr.document.getElementById(tableid);
	var manspan = mansen.getElementsByTagName("span");
	var manhnd="";
	for(i=0;i<manspan.length;i++){
		manhnd += manspan[i].innerHTML + " ";
	}
	str += "\nManual Translation - " + manhnd;
}
	document.getElementById("message").innerHTML=str;
	loadPopupBox();
};
}
function loadPopupBox() {    // To Load the Popupbox
	document.getElementById('popup_box').style.display="block";
        document.getElementById('popup_box').style.opacity="1";
}
document.getElementById('popupBoxClose').onclick= function() {           
        document.getElementById('popup_box').style.display="none";
        document.getElementById('popup_box').style.opacity="0";
	hideLayer();
}
</script>
