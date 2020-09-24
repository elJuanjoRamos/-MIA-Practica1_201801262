const express = require('express');
var path = require('path');
var logger = require('morgan');
var path = require('path');


var mysql = require('./config/database.config');
const port = 3000;

var app = express();




// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'pug');

app.get('/', function(req, res){
	res.render('index.pug', { mensaje: 'Aplicacion iniciada' });
 });
//CONFIGURACION DE BODY-PARSER


app.use(logger('dev'));
app.use(express.static(path.join(__dirname, 'public')));
app.use('/jquery', express.static(path.join(__dirname, 'node_modules/jquery/dist')));


app.use(function(req, res, next) {
  res.setHeader('Access-Control-Allow-Origin', '*');
  res.setHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE');
  res.setHeader('Access-Control-Allow-Headers', 'X-Requested-With, Content-Type, Authorization');
    next();
});


var temporal = require('./routes/temporal.route');


app.use("/", temporal);



//app.get('/crearModelo', async function(req, res) {

	


	/*mysql.query(query, async function(err, res){
		if (err) {
			throw err;
		}
		console.log("tabla creada")
	})*///
//	res.send("Funciono")
//});




// catch 404 and forward to error handler
/*app.use(function(req, res, next) {
	
	var err = new Error('Not Found');
	err.status = 404;
	next(err);
  });
  
  // error handler
  app.use(function(err, req, res, next) {
	// set locals, only providing error in development
	res.locals.message = err.message;
	res.locals.error = req.app.get('env') === 'development' ? err : {};
  
	// render the error page
	res.status(err.status || 500);
	res.render('error');
  });*/
  
  app.listen(port, function() {
	console.log("The server is running at: " + port);
  });