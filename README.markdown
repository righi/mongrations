Mongrations
===========

Mongrations aims to be similar to ActiveRecord's data migrations, except
instead of worrying about schema changes, offering a way to change data when
necessary. 

Example: You decide after a few weeks of running an application that you want
to add timestamps, and want to display the created_at time for an application.

You could put a default timestamp into the model (and in this case that might
be appropriate), but you might also just want to say, "everything needs to get
a new timestamp that doesn't already have one, let's say when the US beat
Canada in hockey in the Olympics."

How to use
===========
You can add this as a plugin into your rails application.

Example
=======

To generate a mongration, just do:

`rails generate mongration whatever_you_want_your_mongration_to_be`

To run it, do

`rake mongo:mongrate`

Other rake tasks added have been `mongo:mongrate:redo`, `mongo:mongrate:up`, `mongo:mongrate:down`, `mongo:mongrate:rollback`.


Dependencies
============

You need Mongo and MongoMapper for this to be of any use.
This is tested with rails 3.it 'll not support the older version .
please use https://github.com/terrbear/mongrations for rails older version.


License
=======
Released under the MIT license
