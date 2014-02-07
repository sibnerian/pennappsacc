var getMain = function(req, res) {
    console.log("I change automagically")
	res.render('index.jade');
};

var routes = {
	main: getMain
};

module.exports = routes;