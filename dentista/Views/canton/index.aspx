<%@ Page Title="" Language="C#" MasterPageFile="~/Views/Shared/Site.Master" Inherits="System.Web.Mvc.ViewPage" %>
<asp:Content ID="Content1" ContentPlaceHolderID="TitleContent" runat="server">
Index
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
<script type="text/javascript">
$(document).ready(function(){
 var serverurl = <%: Url.Content("~") %>;
 $.gridcanton=function gridcanton(){
   $("#canton").jqGrid("setGridParam",{url:  serverurl+"canton/jqgrid" ,datatype: "json"}).trigger("reloadGrid");}


 $.gridcantonrow=function gridcantonrow(id){
  $.ajax({
   type: "post",
   dataType:"json",
   data:{id:id},
   url : serverurl+"canton/detail/",
   success: function(msg){
   $.each(msg, function(index, value) {
 $("#canton").setCell(id, "nombre", value.nombre);
 $("#canton").setCell(id, "provinciaid", value.provinciaid);
   });
   }
   });
   }


 $.gridcantondetail=function gridcantondetail(id){
  $.ajax({
   type: "post",
   dataType:"json",
   data:{id:id},
   url : serverurl+"canton/detail/",
   success: function(msg){
   $.each(msg, function(index, ret) {
$("#nombre").val(ret.nombre);
$("#provinciaid").val(ret.provinciaid);
   });
   }
   });
   }


 $.gridcantondel=function gridcantondel(id){
 $("#canton").jqGrid("delRowData",id);
  }

$("#canton").jqGrid({
  url:serverurl+"canton/jqgrid",
  datatype: "json",
 colNames:['CANTONID','NOMBRE','PROVINCIAID'],

 colModel:[{name:'cantonid', index:'cantonid', width:85}, 
{name:'nombre', index:'nombre', width:150}, 
{name:'provinciaid', index:'provinciaid', width:100}],
  rowNum:50,
  height:350,
  rowList:[10,20,30,50,100],
  gridview: true,
  pager:"#cantonpager",
  sortname:"cantonid",
  viewrecords: true,
  sortorder: "desc",
  ignoreCase: true,
  loadonce:true,
  caption:"CANTON",
  onSelectRow:
     function(cantonid){ 
       var ret = $("#canton").jqGrid("getRowData",cantonid); 
	  $("#cantonid").val(cantonid);
$("#nombre").val(ret.nombre);
$("#provinciaid").val(ret.provinciaid);
	  }
}).navGrid("#cantonpager",{edit:false,add:false,del:false},
	 {	  
		bSubmit: "Save",
		bCancel: "Close",
		closeAfterEdit: false,
		closeOnEscape:true
	  }
	);


 $("#canton").jqGrid("filterToolbar");

});</script>
<table><tr><td>
<table id="canton"> </table>
<div id="cantonpager"></div>
<td/>
<td valign="top">
<% Html.RenderPartial("~/Views/canton/create.ascx"); %>
</td>
</tr></table>
</asp:Content>
