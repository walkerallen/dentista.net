using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using dentista;

namespace dentista.Controllers{ 
public class VrightsController : Controller{
    private dentistaEntities db = new dentistaEntities();
    
 public ActionResult Index(){
  return View();
   }
  public  ActionResult Create(){
return View();
}
 public  ActionResult Jqgrid(string sidx, string sord, int page, int rows){
	int pageIndex = page;
	int pageSize = rows;
	int startRow = (pageIndex * pageSize) + 1;
	var record = db.vrights.ToList();
	int totalRecords = record.Count();
	var totalPages = (int) Math.Ceiling(totalRecords/(float) pageSize);
		var data = new
	{
	total = totalPages,
	page,
	records = totalRecords,
	rows = (from item in record
	select new
	{
	id = item.rightsareaid.ToString(),
	cell = new[]
	{
item.section.ToString().Trim(),item.reader.ToString().Trim(),item.writer.ToString().Trim(),item.deleter.ToString().Trim(),item.rightsuserid.ToString().Trim(),item.rightsareaid.ToString().Trim(),item.usuarioid.ToString().Trim()}
 }).ToArray()
};
return Json(data,JsonRequestBehavior.AllowGet);
}
 /*
 [HttpPost]
  public JsonResult Save(string newvrights,string section ,short reader,short writer,short deleter,int rightsuserid,int rightsareaid,int usuarioid){
 var record=new Vrights();
  try{
   if (newvrights!="add") {
  record = db.Vrights.Find();
  }
  record.section=section;record.reader=reader;record.writer=writer;record.deleter=deleter;record.rightsuserid=rightsuserid;record.rightsareaid=rightsareaid;record.usuarioid=usuarioid; if (newvrights=="add") {
   db.Vrights.Add(record);
   }
   db.SaveChanges();
  }catch (Exception e){
  return Json (e.Message);}
  return Json("Ready");
   }
  */

 [HttpPost]
public Boolean Validate(int userid,string action,string table ){
    //var valid = db.vrights..Single(c => c.usuarioid == userid);
      //var student = ctx.ExecuteStoreQuery<Student>("Select * from Student where StudentName = 'StudentName1'", null).ToList();

    var valid =  db.ExecuteStoreQuery<vrights>("select * from vrights where usuarioid=" + userid + " and section='" + table + "' and " + action + "=1").ToList();
   
     if (valid.Count()>0) {
        return true;
    }else
     { return true; }
 }
 }


 }
