-*/fontawesome-pro-5.14.0-web/*, -/*/css/lib/*, -*/js/lib/jquery-2.2.1.*, -/*public/js/lib/turbolinks.js/*, -*/js/lib/bootstrap3.js, -*css/assistant_font.css, -*js/lib/linkify.min.js, -*lib/vue.js, -*public/lib/*, -*public/js/lib*

Write me a python Flask webserver that 
* connects to a MongoDB via MONGODB_URI.
* has "get" and "post" endpoints.
* The "post" endpoint will return a placeholder "ping"
* The "get" endpoint will return a list of all 'projects' in the MongoDB "projects" collection.

Add a "worker.py" file that runs in the background (so we can use it on Heroku. also supply a Procfile) and every 10 seconds pulls all "projects" in the "projects" collection that have a 'status' field of 'new'. 

For any such project (with status 'new'), the worker.py will
a) update the status to 'in-progress'
b) update the field 'started_algo' to the current time
c) pull the field 'dna' and send it to a method called "calc_variant". This method will flip the 'dna' string val. The worker.py will then take the calculated variant, and 
c1) add a new document to collection called "variants", with project_id referencing the project and 'dna' field with the calculated variant.