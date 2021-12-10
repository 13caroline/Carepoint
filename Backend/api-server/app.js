var createError = require('http-errors');
var express = require('express');
var path = require('path');
var cookieParser = require('cookie-parser');
var logger = require('morgan');

var indexRouter = require('./routes/index');
var usersRouter = require('./routes/users');
var jobOfferRouter = require('./routes/joboffer');


//Para testar!!!----------------------------------------------------------------------------------------------------------
const Location = require("./models/location");
const Location_Model = require("./models/location");
const User = require("./models/user");

const Message = require("./models/message")
const Review = require("./models/review")

const File = require("./models/file");
const Subscription = require("./models/subscription");
const Company = require("./models/company");
const Add = require("./models/add");

const ServiceProvider = require("./models/serviceProvider")

const Area = require("./models/area")
const Category = require("./models/category")
const JobOffer = require("./models/joboffer")

const Category_has_ServiceProvider = require("./models/category_has_serviceProvider")
const Category_x_TimeSlots = require("./models/category_x_timeSlots");
const category_Has_ServiceProvider = require('./models/category_has_serviceProvider');


//-------------------------------------------------------------------------------------------------------------------------




var app = express();

app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(cookieParser());

app.use('/', indexRouter);
app.use('/users', usersRouter);
app.use('/joboffer', jobOfferRouter);

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
  res.status(err.status || 500).jsonp({error: err.message});
});

module.exports = app;
