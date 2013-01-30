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
$("#provinciaid").append("<option value='" + value.provinciaid + "'>" + value.provinciaid + "</option>");
 });
  }
});

 $("#save").click(function(){
  $("#divcanton").validate({ 
   rules:{    
cantonid : { maxlength:5},
nombre : { maxlength:50},
provinciaid : { maxlength:5}   },    
  submitHandler: function(form) {    
  if ($("#newcanton").is(":checked")){
   $('#newcanton').val('add');
   $('#cantonid').val(0);
    }
   var data =  $("#divcanton").serialize();
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
  });
});</script>
<div data-role="page">
<div data-role="content">
<form id="divcanton" action="" method="post" >
<label for="newcanton">New</label><input type="checkbox" name="newcanton" id="newcanton" value="1"/>
<input type="submit" name="save" id="save" value="Save"/>
<table>
<tr><td></td><td>  <input type="hidden" id="cantonid" name="cantonid"/> </td></tr>
<tr><td><label for="nombre"  class="ui-hidden-accessible">Nombre</label></td><td>  <input placeholder="Nombre" type="textbox" id="nombre" name="nombre"/> </td></tr>
<tr><td><label for="provinciaid">Provinciaid</label> </td><td>  <select id="provinciaid" name="provinciaid"></select> </td></tr>
</table>
</form>
<input type="button" name="btndeletecanton" id="btndeletecanton" value="Delete" />
</div>
</div>
