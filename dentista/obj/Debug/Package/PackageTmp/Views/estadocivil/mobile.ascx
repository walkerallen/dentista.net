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



 $("#save").click(function(){
  $("#divestadocivil").validate({ 
   rules:{    
estadocivilid : { maxlength:5},
descripcion : { maxlength:50}   },    
  submitHandler: function(form) {    
  if ($("#newestadocivil").is(":checked")){
   $('#newestadocivil').val('add');
   $('#estadocivilid').val(0);
    }
   var data =  $("#divestadocivil").serialize();
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
  });
});</script>
<div data-role="page">
<div data-role="content">
<form id="divestadocivil" action="" method="post" >
<label for="newestadocivil">New</label><input type="checkbox" name="newestadocivil" id="newestadocivil" value="1"/>
<input type="submit" name="save" id="save" value="Save"/>
<table>
<tr><td></td><td>  <input type="hidden" id="estadocivilid" name="estadocivilid"/> </td></tr>
<tr><td><label for="descripcion"  class="ui-hidden-accessible">Descripcion</label></td><td>  <input placeholder="Descripcion" type="textbox" id="descripcion" name="descripcion"/> </td></tr>
</table>
</form>
<input type="button" name="btndeleteestadocivil" id="btndeleteestadocivil" value="Delete" />
</div>
</div>
