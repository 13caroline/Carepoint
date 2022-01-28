var createError = require('http-errors');
const express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
const bodyParser = require('body-parser');
const router = require('express').Router();
// Add the swagger module and the yaml loader
const swaggerUi = require('swagger-ui-express');
YAML = require('yamljs');
swaggerDocument = YAML.load('./openapi-part2.yaml');

// Routes
var indexRouter = require('./routes/index');
var usersRouter = require('./routes/users');
var jobOfferRouter = require('./routes/joboffer');
var searchRouter = require('./routes/search');
var categoryRouter = require('./routes/category');
var areaRouter = require('./routes/area');
var companyRouter = require('./routes/company');
var locationRouter = require('./routes/location');
var subscriptionRouter = require('./routes/subscription');
var serviceProvRouter = require('./routes/serviceProvider');
var addRouter = require('./routes/add');
var reviewRouter = require('./routes/review');
var messageRouter = require('./routes/message');


// Para construir a DB----------------------------------------------------------------------------------------------------------
require('./models/Config/Database_build')
    // -----------------------------------------------------------------------------------------------------------------------------


var app = express();
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }))
app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());

// Add headers before the routes are defined
app.use(function (req, res, next) {

    // Website you wish to allow to connect
    res.setHeader('Access-Control-Allow-Origin', '*');

    // Request methods you wish to allow
    res.setHeader('Access-Control-Allow-Methods', 'GET, POST, OPTIONS, PUT, PATCH, DELETE');

    // Request headers you wish to allow
    res.setHeader('Access-Control-Allow-Headers', 'X-Requested-With,content-type');

    // Set to true if you need the website to include cookies in the requests sent
    // to the API (e.g. in case you use sessions)
    res.setHeader('Access-Control-Allow-Credentials', false);

    // Pass to next layer of middleware
    next();
});

app.use('/', indexRouter);
app.use('/users', usersRouter);
app.use('/joboffer', jobOfferRouter);
app.use('/search', searchRouter);
app.use('/category', categoryRouter);
app.use('/area', areaRouter);
app.use('/company', companyRouter);
app.use('/location', locationRouter);
app.use('/subscription', subscriptionRouter);
app.use('/serviceProvider', serviceProvRouter);
app.use('/add', addRouter);
app.use('/review', reviewRouter);
app.use('/message', messageRouter);
// Add the documentation route
app.use('/api-docs', swaggerUi.serve, swaggerUi.setup(swaggerDocument));

// catch 404 and forward to error handler
app.use(function(req, res, next) {
    next(createError(404));
});

// error handler
app.use(function(err, req, res, next) {
    // set locals, only providing error in development
    res.locals.message = err.message;
    res.locals.error = req.app.get('env') === 'development' ? err : {};

    // render the error page
    res.status(err.status || 500).jsonp({ error: err.message });
});

module.exports = app;
