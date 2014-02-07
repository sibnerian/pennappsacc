var express = require('express');
var routes = require('./routes/routes.js');
var app = express();
 
app.configure(function(){
	app.set('view engine', 'html');
	app.engine('html', require('jqtpl/lib/express').render);
});

app.get('/', routes.main);

console.log('PennApps Accelerator website');
app.listen(8080).on('error', function(){
	console.log("[Err] Server initiation failed. Port in use?");
});
console.log('Server running on port 8080. Now open http://localhost:8080/ your browser.');