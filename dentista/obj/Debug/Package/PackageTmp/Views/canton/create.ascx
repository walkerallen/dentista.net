<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<script type="text/javascript">
$(document).ready(function(){
 var serverurl = <%: Url.Content("~") %>;

 $("#btndeletecanton").click(function() {
  var answer = confirm("Delete canton");    
    if (answer== true){ 
	var data = "&id=" + encodeURIComponent($("#cantonid").val());
	$.post(serverurl + "canton/delete",data , function(result) {
     alert(result);
 	 $.gridcantondel($("#cantonid").val()); 
     $("#divcanton form")[0].reset();
 }).error(function() { alert(result); });
 }
  return false;
  });


$.ajax({
url : serverurl+"provincia/all",
type : "post",
dataType: "json",
async:false,
success: function (response) {
$.each(response, function(index, value) {
$("#provinciaid").append("<option value='" + value.provinciaid + "'>" + value.nombre + "</option>");
 });
  }
});

 $("#divcanton form").validate({
   rules:{    
cantonid : { maxlength:5},
nombre : { maxlength:50},
provinciaid : { maxlength:5}   },    
  submitHandler: function(form) {    
  if ($("#newcanton").is(":checked")){
   $('#newcanton').val('add');
   $('#cantonid').val(0);
    }
   var data =  $("#divcanton form").serialize();
$.post(serverurl + "canton/save",data, function(result) {
  alert(result);
  if ($("#newcanton").is(":checked")){
    $.gridcanton();
  }      
  else{      
    $.gridcantonrow($("#cantonid").val());
  }      
  $("#divcanton form")[0].reset(); 
 }).error(function() { alert(result); });
  return false;
  }
  });
});</script>
<div id="divcanton"  title="Canton"  >
<form action="" method="post" >
<% 
 dentista.Controllers.VrightsController security = new dentista.Controllers.VrightsController(); 
if (security.Validate(1,"writer","canton")){%> 
<label for="newcanton">New</label><input type="checkbox" name="newcanton" id="newcanton" value="1"/>
<input type="submit" name="save" id="save" value="Save"/>
<% }%>
<hr/>
<table>
<tr><td></td><td>  <input type="hidden" id="cantonid" name="cantonid"/> </td></tr>
<tr><td><label for="nombre">Nombre</label></td><td>  <input type="textbox" id="nombre" name="nombre"/> </td></tr>
<tr><td><label for="provinciaid">Provincia</label> </td><td>  <select id="provinciaid" name="provinciaid"></select> </td></tr>
</table>
</form>
<% 
if (security.Validate(1,"deleter","canton")){%> 
<input type="button" name="btndeletecanton" id="btndeletecanton" value="Delete" />
<% }%>
</div>
