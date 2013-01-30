<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
Index
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<script type="text/javascript">
$(document).ready(function(){
 var serverurl = <%: Url.Content("~") %>;
 $.gridprovincia=function gridprovincia(){
   $("#provincia").jqGrid("setGridParam",{url:  serverurl+"provincia/jqgrid" ,datatype: "json"}).trigger("reloadGrid");}


 $.gridprovinciarow=function gridprovinciarow(id){
  $.ajax({
   type: "post",
   dataType:"json",
   data:{id:id},
   url : serverurl+"provincia/detail/",
   success: function(msg){
   $.each(msg, function(index, value) {
 $("#provincia").setCell(id, "nombre", value.nombre);
   });
   }
   });
   }


 $.gridprovinciadetail=function gridprovinciadetail(id){
  $.ajax({
   type: "post",
   dataType:"json",
   data:{id:id},
   url : serverurl+"provincia/detail/",
   success: function(msg){
   $.each(msg, function(index, ret) {
$("#nombre").val(ret.nombre);

   });
   }
   });
   }


 $.gridprovinciadel=function gridprovinciadel(id){
 $("#provincia").jqGrid("delRowData",id);
  }

$("#provincia").jqGrid({
  url:serverurl+"provincia/jqgrid",
  datatype: "json",
 colNames:['PROVINCIAID','NOMBRE'],

 colModel:[{name:'provinciaid', index:'provinciaid', width:150}, 
{name:'nombre', index:'nombre', width:350}],
  rowNum:50,
  height:350,
  rowList:[10,20,30,50,100],
  gridview: true,
  pager:"#provinciapager",
  sortname:"provinciaid",
  viewrecords: true,
  sortorder: "desc",
  ignoreCase: true,
  loadonce:true,
  caption:"PROVINCIA",
  onSelectRow:
     function(provinciaid){ 
       var ret = $("#provincia").jqGrid("getRowData",provinciaid); 
	  $("#provinciaid").val(provinciaid);
$("#nombre").val(ret.nombre);
	  }
}).navGrid("#provinciapager",{edit:false,add:false,del:false},
	 {	  
		bSubmit: "Save",
		bCancel: "Close",
		closeAfterEdit: false,
		closeOnEscape:true
	  }
	);


 $("#provincia").jqGrid("filterToolbar");

});</script>
<table><tr><td>
<table id="provincia"> </table>
<div id="provinciapager"></div>
<td/>
<td valign="top">
<% Html.RenderPartial("~/Views/provincia/create.ascx"); %>
</td>
</tr></table>
</asp:Content>
