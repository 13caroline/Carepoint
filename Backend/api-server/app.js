var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');
var bodyParser = require('body-parser');


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

// Para construir a DB----------------------------------------------------------------------------------------------------------
require('./models/Config/Database_build')
    // -----------------------------------------------------------------------------------------------------------------------------


var app = express();

app.use(bodyParser.urlencoded({ extended: true }))
app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());



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