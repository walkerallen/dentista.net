<%@ Control Language="C#" Inherits="System.Web.Mvc.ViewUserControl" %>
<meta name="viewport" content="width=device-width, initial-scale=1">
 <link href="../../Content/jquery.mobile-1.1.1.css" rel="stylesheet" type="text/css" />
<link href="../../Content/jquery.mobile.theme-1.1.1.min.css" rel="stylesheet" type="text/css" />
<link href="../../Content/jquery.mobile.structure-1.1.1.min.css" rel="stylesheet" type="text/css" />
<script src="<%: Url.Content("~/Scripts/jquery.min.js") %>" type="text/javascript"></script>
<script src="<%: Url.Content("~/Scripts/jquery.custom.min.js") %>" type="text/javascript"></script>
<script src="<%: Url.Content("~/Scripts/jquery.validate.min.js") %>" type="text/javascript"></script>
<script src="<%: Url.Content("~/Scripts/jquery.mobile-1.1.1.min.js") %>" type="text/javascript"></script>
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



 $("#save").click(function(){
  $("#divtipoidentificacion").validate({ 
   rules:{    
tipoidentificacionid : { maxlength:5},
descripcion : { maxlength:50}   },    
  submitHandler: function(form) {    
  if ($("#newtipoidentificacion").is(":checked")){
   $('#newtipoidentificacion').val('add');
   $('#tipoidentificacionid').val(0);
    }
   var data =  $("#divtipoidentificacion").serialize();
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
  });
});</script>
<div data-role="page">
<div data-role="content">
<form id="divtipoidentificacion" action="" method="post" >
<label for="newtipoidentificacion">New</label><input type="checkbox" name="newtipoidentificacion" id="newtipoidentificacion" value="1"/>
<input type="submit" name="save" id="save" value="Save"/>
<table>
<tr><td></td><td>  <input type="hidden" id="tipoidentificacionid" name="tipoidentificacionid"/> </td></tr>
<tr><td><label for="descripcion"  class="ui-hidden-accessible">Descripcion</label></td><td>  <input placeholder="Descripcion" type="textbox" id="descripcion" name="descripcion"/> </td></tr>
</table>
</form>
<input type="button" name="btndeletetipoidentificacion" id="btndeletetipoidentificacion" value="Delete" />
</div>
</div>
