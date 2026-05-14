using System.Linq;
using System.Web.Mvc;
using System.Web.Security;
using JobTrackingSystem.Models;

namespace JobTrackingSystem.Controllers
{
    public class LoginController : Controller
    {
        private IsTakipDBContext db = new IsTakipDBContext();

        // GET: Login
        public ActionResult Index()
        {
            if (User.Identity.IsAuthenticated)
            {
                return RedirectToDashboard();
            }
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Index(string personelKullaniciAd, string personelParola)
        {
            if (!ModelState.IsValid)
            {
                return View();
            }

            var personel = db.Personeller.FirstOrDefault(
                p => p.PersonelKullaniciAd == personelKullaniciAd && 
                     p.PersonelParola == personelParola);

            if (personel == null)
            {
                ModelState.AddModelError("", "Kullanıcı adı veya parola hatalı!");
                return View();
            }

            // Set authentication cookie
            FormsAuthentication.SetAuthCookie(personel.PersonelId.ToString(), false);
            Session["PersonelId"] = personel.PersonelId;
            Session["PersonelAdSoyad"] = personel.PersonelAdSoyad;
            Session["YetkiTurId"] = personel.PersonelYetkiTurId;

            return RedirectToDashboard();
        }

        private ActionResult RedirectToDashboard()
        {
            if (Session["YetkiTurId"] != null)
            {
                int yetkiTurId = (int)Session["YetkiTurId"];
                if (yetkiTurId == 1) // Admin/Yönetici
                {
                    return RedirectToAction("Index", "Yonetici");
                }
                else if (yetkiTurId == 2) // Employee/Çalışan
                {
                    return RedirectToAction("Index", "Calisan");
                }
            }
            return RedirectToAction("Index");
        }
    }
}
