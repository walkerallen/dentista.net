<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
Index
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<script type="text/javascript">
$(document).ready(function(){
 var serverurl = "/";
 $.gridestadocivil=function gridestadocivil(){
   $("#estadocivil").jqGrid("setGridParam",{url:  serverurl+"estadocivil/jqgrid" ,datatype: "json"}).trigger("reloadGrid");}


 $.gridestadocivilrow=function gridestadocivilrow(id){
  $.ajax({
   type: "post",
   dataType:"json",
   data:{id:id},
   url : serverurl+"estadocivil/detail/",
   success: function(msg){
   $.each(msg, function(index, value) {
 $("#estadocivil").setCell(id, "descripcion", msg.descripcion);
   });
   }
   });
   }


 $.gridestadocivildetail=function gridestadocivildetail(id){
  $.ajax({
   type: "post",
   dataType:"json",
   data:{id:id},
   url : serverurl+"estadocivil/detail/",
   success: function(msg){
   $.each(msg, function(index, ret) {
$("#descripcion").val(ret.descripcion);
   });
   }
   });
   }


 $.gridestadocivildel=function gridestadocivildel(id){
 $("#estadocivil").jqGrid("delRowData",id);
  }

$("#estadocivil").jqGrid({
  url:serverurl+"estadocivil/jqgrid",
  datatype: "json",
 colNames:['ESTADOCIVILID','DESCRIPCION','dummy'],

 colModel:[{name:'estadocivilid', index:'estadocivilid', width:85}, 
{name:'descripcion', index:'descripcion', width:85}, 
{name:'dummy', index:'dummy', hidden:true}],
  rowNum:50,
  height:350,
  rowList:[10,20,30,50,100],
  gridview: true,
  pager:"#estadocivilpager",
  sortname:"estadocivilid",
  viewrecords: true,
  sortorder: "desc",
  ignoreCase: true,
  loadonce:true,
  caption:"ESTADOCIVIL",
  onSelectRow:
     function(estadocivilid){ 
       var ret = $("#estadocivil").jqGrid("getRowData",estadocivilid); 
	  $("#estadocivilid").val(estadocivilid);
$("#descripcion").val(ret.descripcion);
	  }
}).navGrid("#estadocivilpager",{edit:false,add:false,del:false},
	 {	  
		bSubmit: "Save",
		bCancel: "Close",
		closeAfterEdit: false,
		closeOnEscape:true
	  }
	);


 $("#estadocivil").jqGrid("filterToolbar");

});</script>
<table><tr><td>
<table id="estadocivil"> </table>
<div id="estadocivilpager"></div>
<td/>
<td valign="top">
<% Html.RenderPartial("~/Views/estadocivil/create.ascx"); %>
</td>
</tr></table>
</asp:Content>
