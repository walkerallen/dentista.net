using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using dentista.Models;
namespace dentista.Controllers{ 
public class CantonController : Controller{
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
	var record = db.canton.ToList();
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
	id = item.cantonid.ToString(),
	cell = new[]
	{
item.cantonid.ToString().Trim(),item.nombre.ToString().Trim(),item.provinciaid.ToString().Trim()}
 }).ToArray()
};
return Json(data,JsonRequestBehavior.AllowGet);
}
[HttpPost]
 public JsonResult Delete(short id){ 
try{
canton canton = db.canton.Single(c => c.cantonid == id); 
  if (canton != null){
  db.canton.DeleteObject(canton);
  db.SaveChanges();
  }
  }
  catch (Exception e){
  return Json(e.Message);}
  return Json("Ready");
        }
public JsonResult All(){
 var record = from cs in db.canton 
         select new {
cantonid = cs.cantonid,
nombre = cs.nombre,
provinciaid = cs.provinciaid  };
return Json(record, JsonRequestBehavior.AllowGet);
 }
[HttpPost]
public JsonResult Detail(short id){
 var record = from cs in db.canton 
     where cs.cantonid==id
         select new {
cantonid = cs.cantonid,
nombre = cs.nombre,
provinciaid = cs.provinciaid  };
 return Json(record, JsonRequestBehavior.AllowGet);
 }
[HttpPost]
public JsonResult Save(string newcanton,short cantonid,string nombre ,short provinciaid){
 var record=new canton();
try{
 if (newcanton!="add") {
record = db.canton.Single(c => c.cantonid==cantonid);
}
record.cantonid=cantonid;record.nombre=nombre;record.provinciaid=provinciaid; if (newcanton=="add") {
 db.canton.AddObject(record);
 }
 db.SaveChanges();
}catch (Exception e){
return Json (e.Message);}
return Json("Ready");
 }
 }
 }
