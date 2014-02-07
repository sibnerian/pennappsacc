var getMain = function(req, res) {
	res.render('index.html');
};

var routes = {
	main: getMain
};

module.exports = routes;