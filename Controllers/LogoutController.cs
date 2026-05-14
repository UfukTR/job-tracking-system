using System.Web.Security;
using System.Web.Mvc;

namespace JobTrackingSystem.Controllers
{
    [Authorize]
    public class LogoutController : Controller
    {
        // GET: Logout
        public ActionResult Index()
        {
            FormsAuthentication.SignOut();
            Session.Clear();
            Session.Abandon();
            return RedirectToAction("Index", "Login");
        }
    }
}
