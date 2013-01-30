using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using dentista;

namespace dentista.Controllers{ 
public class ProvinciaController : Controller{

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
    var record = db.provincia.ToList(); 
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
	id = item.provinciaid.ToString(),
	cell = new[]
	{
item.provinciaid.ToString().Trim(),item.nombre.ToString().Trim()}
 }).ToArray()
};
return Json(data,JsonRequestBehavior.AllowGet);
}

[HttpPost]
 public JsonResult Delete(short id)
 { 
try{
    provincia provincia = db.provincia.Single(c => c.provinciaid == id);
     if (provincia != null){
         db.provincia.DeleteObject(provincia);
        db.SaveChanges();
    }
 }
  catch (Exception e){
  return Json(e.Message);}
  return Json("Ready");
        }

public JsonResult All(){

    var record = from cs in db.provincia                       
                       select new {
                           provinciaid = cs.provinciaid,
                           nombre = cs.nombre
      };

    return Json(record, JsonRequestBehavior.AllowGet);
 }


[HttpPost]
public JsonResult Detail(short id){
   var record = from cs in db.provincia
                where cs.provinciaid==id
               select new
               {
                   provinciaid = cs.provinciaid,
                   nombre = cs.nombre
               };

  return Json(record, JsonRequestBehavior.AllowGet);


 }
[HttpPost]
public JsonResult Save(string newprovincia,short provinciaid,string nombre ){
    var record = new provincia();
try{
if (newprovincia!="add") {
    record = db.provincia.Single(c => c.provinciaid == provinciaid);
}
record.nombre = nombre;
if (newprovincia == "add"){
    db.provincia.AddObject(record);
}

db.SaveChanges();
}catch (Exception e){
return Json (e.Message);}
return Json("Ready");
 }
 }
 }
