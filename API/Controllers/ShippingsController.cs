using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using System.Web.Http.Description;
using API.Models;

namespace API.Controllers
{
    public class ShippingsController : ApiController
    {
        private TryAgainChallengeEntities db = new TryAgainChallengeEntities();

        // GET: api/Shippings
        public IQueryable<Shipping> GetShippings()
        {
            return db.Shippings;
        }

        // GET: api/Shippings/5
        [ResponseType(typeof(Shipping))]
        public IHttpActionResult GetShipping(string id)
        {
            Shipping shipping = db.Shippings.Find(id);
            if (shipping == null)
            {
                return NotFound();
            }

            return Ok(shipping);
        }

        // PUT: api/Shippings/5
        [ResponseType(typeof(void))]
        public IHttpActionResult PutShipping(string id, Shipping shipping)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            if (id != shipping.ShippingMeth)
            {
                return BadRequest();
            }

            db.Entry(shipping).State = EntityState.Modified;

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateConcurrencyException)
            {
                if (!ShippingExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }

            return StatusCode(HttpStatusCode.NoContent);
        }

        // POST: api/Shippings
        [ResponseType(typeof(Shipping))]
        public IHttpActionResult PostShipping(Shipping shipping)
        {
            if (!ModelState.IsValid)
            {
                return BadRequest(ModelState);
            }

            db.Shippings.Add(shipping);

            try
            {
                db.SaveChanges();
            }
            catch (DbUpdateException)
            {
                if (ShippingExists(shipping.ShippingMeth))
                {
                    return Conflict();
                }
                else
                {
                    throw;
                }
            }

            return CreatedAtRoute("DefaultApi", new { id = shipping.ShippingMeth }, shipping);
        }

        // DELETE: api/Shippings/5
        [ResponseType(typeof(Shipping))]
        public IHttpActionResult DeleteShipping(string id)
        {
            Shipping shipping = db.Shippings.Find(id);
            if (shipping == null)
            {
                return NotFound();
            }

            db.Shippings.Remove(shipping);
            db.SaveChanges();

            return Ok(shipping);
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }

        private bool ShippingExists(string id)
        {
            return db.Shippings.Count(e => e.ShippingMeth == id) > 0;
        }
    }
}