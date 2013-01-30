<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
Index
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<script type="text/javascript">
$(document).ready(function(){
 var serverurl = "/";
 $.gridtipoidentificacion=function gridtipoidentificacion(){
   $("#tipoidentificacion").jqGrid("setGridParam",{url:  serverurl+"tipoidentificacion/jqgrid" ,datatype: "json"}).trigger("reloadGrid");}


 $.gridtipoidentificacionrow=function gridtipoidentificacionrow(id){
  $.ajax({
   type: "post",
   dataType:"json",
   data:{id:id},
   url : serverurl+"tipoidentificacion/detail/",
   success: function(msg){
   $.each(msg, function(index, value) {
 $("#tipoidentificacion").setCell(id, "descripcion", msg.descripcion);
   });
   }
   });
   }


 $.gridtipoidentificaciondetail=function gridtipoidentificaciondetail(id){
  $.ajax({
   type: "post",
   dataType:"json",
   data:{id:id},
   url : serverurl+"tipoidentificacion/detail/",
   success: function(msg){
   $.each(msg, function(index, ret) {
$("#descripcion").val(ret.descripcion);
   });
   }
   });
   }


 $.gridtipoidentificaciondel=function gridtipoidentificaciondel(id){
 $("#tipoidentificacion").jqGrid("delRowData",id);
  }

$("#tipoidentificacion").jqGrid({
  url:serverurl+"tipoidentificacion/jqgrid",
  datatype: "json",
 colNames:['TIPOIDENTIFICACIONID','DESCRIPCION','dummy'],

 colModel:[{name:'tipoidentificacionid', index:'tipoidentificacionid', width:85}, 
{name:'descripcion', index:'descripcion', width:85}, 
{name:'dummy', index:'dummy', hidden:true}],
  rowNum:50,
  height:350,
  rowList:[10,20,30,50,100],
  gridview: true,
  pager:"#tipoidentificacionpager",
  sortname:"tipoidentificacionid",
  viewrecords: true,
  sortorder: "desc",
  ignoreCase: true,
  loadonce:true,
  caption:"TIPOIDENTIFICACION",
  onSelectRow:
     function(tipoidentificacionid){ 
       var ret = $("#tipoidentificacion").jqGrid("getRowData",tipoidentificacionid); 
	  $("#tipoidentificacionid").val(tipoidentificacionid);
$("#descripcion").val(ret.descripcion);
	  }
}).navGrid("#tipoidentificacionpager",{edit:false,add:false,del:false},
	 {	  
		bSubmit: "Save",
		bCancel: "Close",
		closeAfterEdit: false,
		closeOnEscape:true
	  }
	);


 $("#tipoidentificacion").jqGrid("filterToolbar");

});</script>
<table><tr><td>
<table id="tipoidentificacion"> </table>
<div id="tipoidentificacionpager"></div>
<td/>
<td valign="top">
<% Html.RenderPartial("~/Views/tipoidentificacion/create.ascx"); %>
</td>
</tr></table>
</asp:Content>
