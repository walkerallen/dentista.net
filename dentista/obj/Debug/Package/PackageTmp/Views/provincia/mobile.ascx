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



 $("#save").click(function(){
  $("#divprovincia").validate({ 
   rules:{    
provinciaid : { maxlength:5},
nombre : { maxlength:20}   },    
  submitHandler: function(form) {    
  if ($("#newprovincia").is(":checked")){
   $('#newprovincia').val('add');
   $('#provinciaid').val(0);
    }
   var data =  $("#divprovincia").serialize();
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
  });
});</script>
<div data-role="page">
<div data-role="content">
<form id="divprovincia" action="" method="post" >
<label for="newprovincia">New</label><input type="checkbox" name="newprovincia" id="newprovincia" value="1"/>
<input type="submit" name="save" id="save" value="Save"/>
<table>
<tr><td></td><td>  <input type="hidden" id="provinciaid" name="provinciaid"/> </td></tr>
<tr><td><label for="nombre"  class="ui-hidden-accessible">Nombre</label></td><td>  <input placeholder="Nombre" type="textbox" id="nombre" name="nombre"/> </td></tr>
</table>
</form>
<input type="button" name="btndeleteprovincia" id="btndeleteprovincia" value="Delete" />
</div>
</div>
