<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<script type="text/javascript">
$(document).ready(function(){
 var serverurl = <%: Url.Content("~") %>;

 $("#btndeleteprovincia").click(function() {
  var answer = confirm("Delete provincia");    
    if (answer== true){ 
	var data = "&id=" + encodeURIComponent($("#provinciaid").val());
	$.post(serverurl + "provincia/delete",data , function(result) {
     alert(result);
 	 $.gridprovinciadel($("#provinciaid").val()); 
     $("#divprovincia form")[0].reset();
 }).error(function() { alert(result); });
 }
  return false;
  });



 $("#divprovincia form").validate({
   rules:{    
provinciaid : { maxlength:5},
nombre : { maxlength:20}   },    
  submitHandler: function(form) {    
  if ($("#newprovincia").is(":checked")){
   $('#newprovincia').val('add');
   $('#provinciaid').val(0);
    }
   var data =  $("#divprovincia form").serialize();
$.post(serverurl + "provincia/save",data, function(result) {
  alert(result);
  if ($("#newprovincia").is(":checked")){
    $.gridprovincia();
  }      
  else{      
    $.gridprovinciarow($("#provinciaid").val());
  }      
  $("#divprovincia form")[0].reset(); 
 }).error(function() { alert(result); });
  return false;
  }
  });
});</script>
<div id="divprovincia"  title="Provincia"  >
<form action="" method="post" >
<% 
   dentista.Controllers.VrightsController security = new dentista.Controllers.VrightsController(); 
if (security.Validate(1,"writer","provincia")){%> 
<label for="newprovincia">New</label><input type="checkbox" name="newprovincia" id="newprovincia" value="1"/>
<input type="submit" name="save" id="save" value="Save"/>
<% }%>
<hr/>
<table>
<tr><td></td><td>  <input type="hidden" id="provinciaid" name="provinciaid"/> </td></tr>
<tr><td><label for="nombre">Nombre</label></td><td>  <input type="textbox" id="nombre" name="nombre"/> </td></tr>
</table>
</form>
<% 
if (security.Validate(1,"deleter","provincia")){%> 
<input type="button" name="btndeleteprovincia" id="btndeleteprovincia" value="Delete" />
<% }%>
</div>
