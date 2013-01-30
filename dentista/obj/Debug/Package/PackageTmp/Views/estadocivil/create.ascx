<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<script type="text/javascript">
$(document).ready(function(){
 var serverurl = "/";

 $("#btndeleteestadocivil").click(function() {
  var answer = confirm("Delete estadocivil");    
    if (answer== true){ 
	var data = "&id=" + encodeURIComponent($("#estadocivilid").val());
	$.post(serverurl + "estadocivil/delete",data , function(result) {
     alert(result);
 	 $.gridestadocivildel($("#estadocivilid").val()); 
     $("#divestadocivil form")[0].reset();
 }).error(function() { alert(result); });
 }
  return false;
  });



 $("#divestadocivil form").validate({
   rules:{    
estadocivilid : { maxlength:5},
descripcion : { maxlength:50}   },    
  submitHandler: function(form) {    
  if ($("#newestadocivil").is(":checked")){
   $('#newestadocivil').val('add');
   $('#estadocivilid').val(0);
    }
   var data =  $("#divestadocivil form").serialize();
$.post(serverurl + "estadocivil/save",data, function(result) {
  alert(result);
  if ($("#newestadocivil").is(":checked")){
    $.gridestadocivil();
  }      
  else{      
    $.gridestadocivilrow($("#estadocivilid").val());
  }      
  $("#divestadocivil form")[0].reset(); 
 }).error(function() { alert(result); });
  return false;
  }
  });
});</script>
<div id="divestadocivil"  title="Estadocivil"  >
<form action="" method="post" >
<% 
 app.Controllers.vrightController security = new app.Controllers.vrightController(); 
if (security.Validate("writer","estadocivil")){%> 
<label for="newestadocivil">New</label><input type="checkbox" name="newestadocivil" id="newestadocivil" value="1"/>
<input type="submit" name="save" id="save" value="Save"/>
<% }%>
<hr/>
<table>
<tr><td></td><td>  <input type="hidden" id="estadocivilid" name="estadocivilid"/> </td></tr>
<tr><td><label for="descripcion">Descripcion</label></td><td>  <input type="textbox" id="descripcion" name="descripcion"/> </td></tr>
</table>
</form>
<% 
if (security.Validate("deleter","estadocivil")){%> 
<input type="button" name="btndeleteestadocivil" id="btndeleteestadocivil" value="Delete" />
<% }%>
</div>
