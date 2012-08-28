==Invamatic

Invamatic is Copyright (c) 2012 Applied Platonics, LLC
Released as-is, with no warranty, etc, under the GPLv3

===What's Invamatic

Invamatic is a rails-based application for keeping track of
electronics parts inventory at Applied Platonics, including:

 * The ability to have multiple suppliers for each "item" in your inventory
 * The ability to create "kits" of "items" in your inventory
 * A set of translation tools for invoices from common suppliers
 * A utility to compute the cost of a kit given the average cost of the parts you have on-hand
 * A utility to compute how many units of a given kit can be kitted up right now
 * A utility to trivially update the inventory after building N of a given kit

There should probably be a web UI, what with it being a rails project
and all, but that's not really something that's come up at AP.  Sorry
folks.

Also, note that the average price per part is currently an
approximation: it uses the historical average cost, not the average
cost of what's actually on hand at the moment. Also, it rounds to the
cent, which is perhaps a bit too aggressive for some especially cheap
parts.

===About this release

There is precious little user documentation here; consider this a
developers-only release.  It's mostly a fast touchup of what AP uses
internally after people were looking for something like it on a
mailing list.

===Data Model

The data model here is a bit subtle, because the problem itself is subtle.

The core of the system is in "parts."  These are slightly abstract
things, like "1/4W 10k resistor, ammo pack."  The internal identifier
for these is "part_id" (following the rails convention).

There are also "kits," which are made up of N of a bunch of parts.
You can import new kit BOMs, then "build" kits.  This will update the
parts inventory appropriately, and add lines to the KitActions table
representing what was just done.  There isn't really an "inventory"
for kits at this time, though it wouldn't be too hard to add one.

Finally, there are "Order Lines," which are the actual line items on
invoices from suppliers. These are correlated back to part_ids, so the
four different vendors' 10k resistors at Mouser can all be linked to
the same part_id, as can those you get from Jameco, Digikey, Tayda,
etc. The price for each part is attached to the order line: since
prices will change over time, we need to keep track of the average
cost of the parts on hand in order to compute the current actual cost
of the kit's materials.

There's a table which ties vendors' local part numbers over to
invamatic's internal part_ids. This means that you need to define what
each part from a given vendor is only once, and the system will do the
Right Thing with any invoices containing it in the future.


=== Usage

==== Importing data

Every vendor has a very different-looking invoice from all the others,
and nobody offers a decent interchange formated one. So, we have a
bunch of ugly perl scripts in the imported_data/ directories, one for
each vendor. There should be READMEs for each vendor, describing how
to go from their invoice to the proper input format. 

   NB: You'll need to manually edit the TSV's part_id column to map
   any new supplier's part number into its internal part_id.

Once you have the file prep'd for import:

  ./script/import_inventory.rb "jameco" ./imported_data/jameco/OrderF3023812.tsv

It should spit out lots of internal verbosity at you about how it's
working.

==== Importing kits

Importing kits is kind of awful right now.  The relevant script is in script/import_kits.rb, and it wants input like this:

  "name"	"description"	"part_ids"
  "Analog Shield v0.1"	"Analog Input Shield"	"504,1;75,6;20,6;1,1;24,1;600,1"

Where the stuff in part_ids is a semicolon-delimited list of comma
separated part_id,count pairs.

I'm very, very, very sorry about this horrific beast. But not sorry
enough to rewrite it right now.


==== Planning for building kits (capacity and costing)

You can get a list of all the kit specifications in your system by
running:

  ./script/runner ./script/howmany.rb

It will give you a list of kits, with their kit_id. Once you know the
kit_id of what you want to plan out, run:

  ./script/runner ./script/howmany.rb kit_id

And it will tell you how many of that kit you can build with the parts
on hand.

To get the cost for a kit, find its kit_id, then run

  ./script/runner ./script/howmuch.rb kit_id

And it will print out a table of how much that kit's parts will cost,
along with a 2x-rule-of-thumb MSRP (which is too low, should be
higher).


====Building kits

Once you've gone through and built out a bunch of kits, and need to
update inventory accordingly, you do:

  ./script/runner ./script/mk_kit.rb kit_id N

This will update the parts on hand, removing enough of each part to
make N kits.


===Support

For any and all support issues, please see your local supplier of
sacrificial chickens. I'm happy to help people who are helping
themselves, but, unfortunately don't have enough time to offer much
support. I will happily consider pull requests, though, especially if
you're interested in adding a web UI for people who aren't as
horrifically CLI-oriented as myself.

  - Josh Myer, Applied Platonics, LLC <josh@appliedplatonics.com>