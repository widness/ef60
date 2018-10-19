using System;
using System.Linq;

namespace ef60
{
    class Program
    {

        // Print all information
        public static void print(Model1Container context)
        {
            Console.WriteLine("---------------------------");
            foreach (Hotel h in context.Hotels)
            {
                Console.WriteLine(h.Name + " " + h.Phone + " " + h.Website + " " + h.Description);
            }
        }
        static void Main(string[] args)
        {
            Model1Container context = new Model1Container();

            print(context);

            var q = from h in context.Hotels
                    where h.idHotel == 4
                    && h.Website.StartsWith("www")
                    select new { h.Name, h.Phone, h.Website };

            var hotel = q.FirstOrDefault(); // Prend uniquement le premier

            if (hotel == null)
            {
                return;
            }

            Console.WriteLine(hotel);

            // Sum
            Console.WriteLine("Sum");
            var q2 = (from h in context.Hotels
                    where h.Website.StartsWith("www")
                    select h.Category).Sum(); // Fait la some de

            Console.WriteLine(q2);

            // Group by
            Console.WriteLine("Group by");
            var q3 = from h in context.Hotels
                     where h.Website.StartsWith("www")
                     group h.Category by h.HasWifi into grouped
                     select grouped;

            foreach (var r in q3)
            {
                Console.WriteLine(r.Key + " " + r.LongCount());
            }

            var h2 = context.Hotels.Find(3); // Get id 3

            Console.WriteLine(h2.idHotel);

            // Insert
            Console.WriteLine(" -- Insert");

            Hotel nouveau = new Hotel {
                Name = "hotel4",
                Description = "desc4",
                Category = 1,
                HasWifi = true,
                Phone = "04",
                Email = "nouveau@4",
                Website = "www",
                HasParking = true,
                localite=context.localites.Find(3)
             };

            context.Hotels.Add(nouveau); // Prepare la requete

            context.SaveChanges(); // Envoie dans la base

            print(context);

            // Update
            Console.WriteLine(" -- Update");

            Hotel maj = context.Hotels.Find(4);

            maj.Description = "Nouvelle description";

            context.SaveChanges();

            print(context);

            // Delete - 1
            Console.WriteLine(" -- Delete"); 
            Hotel del = context.Hotels.Find(3);

            context.Hotels.Remove(del);
            
            context.SaveChanges();

            print(context);

            // Delete - 2
            Console.WriteLine(" -- Delete 2");
            context.Database.ExecuteSqlCommand("DELETE FROM Hotels WHERE idHotel=4");

            context.SaveChanges();

            print(context);


            // Get foreign key
            Console.WriteLine(" -- get with foreign key");
            foreach (Hotel h in context.Hotels)
            {
                Console.WriteLine(h.Name + " have this locality " + h.localite.Name);
            }

            foreach (localite l in context.localites)
            {
                Console.WriteLine(l.Name + ":");

                foreach(Hotel h in l.Hotels)
                {
                    Console.WriteLine(h.Name);
                }
            }

            // Request with Inner Join
            Console.WriteLine(" -- get with Join");
            
            foreach (Hotel h in context.Hotels.Include("Localite"))
            {
                Console.WriteLine(h.Name + " " + h.localite.Name);
            }
            
            foreach (localite l in context.localites.Include("Hotels"))
            {
                Console.WriteLine(l.Name + ":" );

                foreach (Hotel h in l.Hotels)
                {
                    Console.WriteLine(h.Name + " " + h.HasWifi);
                }
            }
             // End programm
             Console.ReadKey();
        }
    }
}
