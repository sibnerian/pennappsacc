var express = require('express');
var routes = require('./routes/routes.js');
var path = require('path')
var app = express();

app.set('port', process.env.PORT || 3000);
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');
app.use(express.favicon());
app.use(express.logger('dev'));
app.use(express.json());
app.use(express.urlencoded());
app.use(express.methodOverride());
app.use(app.router);
app.use(express.static(path.join(__dirname, 'public')));

app.get('/', routes.main);

console.log('PennApps Accelerator website');
app.listen(app.get('port')).on('error', function(){
	console.log("[Err] Server initiation failed. Port in use?");
});
console.log('Server running on port ' + app.get('port') + '. Now open http://localhost:' + app.get('port') +'/ in your browser.');

