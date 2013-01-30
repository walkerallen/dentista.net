<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<script type="text/javascript">
$(document).ready(function(){
 var serverurl = "/";

 $("#btndeletetipoidentificacion").click(function() {
  var answer = confirm("Delete tipoidentificacion");    
    if (answer== true){ 
	var data = "&id=" + encodeURIComponent($("#tipoidentificacionid").val());
	$.post(serverurl + "tipoidentificacion/delete",data , function(result) {
     alert(result);
 	 $.gridtipoidentificaciondel($("#tipoidentificacionid").val()); 
     $("#divtipoidentificacion form")[0].reset();
 }).error(function() { alert(result); });
 }
  return false;
  });



 $("#divtipoidentificacion form").validate({
   rules:{    
tipoidentificacionid : { maxlength:5},
descripcion : { maxlength:50}   },    
  submitHandler: function(form) {    
  if ($("#newtipoidentificacion").is(":checked")){
   $('#newtipoidentificacion').val('add');
   $('#tipoidentificacionid').val(0);
    }
   var data =  $("#divtipoidentificacion form").serialize();
$.post(serverurl + "tipoidentificacion/save",data, function(result) {
  alert(result);
  if ($("#newtipoidentificacion").is(":checked")){
    $.gridtipoidentificacion();
  }      
  else{      
    $.gridtipoidentificacionrow($("#tipoidentificacionid").val());
  }      
  $("#divtipoidentificacion form")[0].reset(); 
 }).error(function() { alert(result); });
  return false;
  }
  });
});</script>
<div id="divtipoidentificacion"  title="Tipoidentificacion"  >
<form action="" method="post" >
<% 
 dentistacs.Controllers.VrightsController security = new dentistacs.Controllers.VrightsController(); 
//if (security.Validate("","writer","tipoidentificacion")){%> 
<label for="newtipoidentificacion">New</label><input type="checkbox" name="newtipoidentificacion" id="newtipoidentificacion" value="1"/>
<input type="submit" name="save" id="save" value="Save"/>
<% //}%>
<hr/>
<table>
<tr><td></td><td>  <input type="hidden" id="tipoidentificacionid" name="tipoidentificacionid"/> </td></tr>
<tr><td><label for="descripcion">Descripcion</label></td><td>  <input type="textbox" id="descripcion" name="descripcion"/> </td></tr>
</table>
</form>
<% 
    //if (security.Validate("", "deleter", "tipoidentificacion"))
    //{%> 
<input type="button" name="btndeletetipoidentificacion" id="btndeletetipoidentificacion" value="Delete" />
<% //}%>
</div>
