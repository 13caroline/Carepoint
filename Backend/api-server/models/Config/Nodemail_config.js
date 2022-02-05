const nodemailer = require('nodemailer')

const transporter = nodemailer.createTransport({
    service: "Gmail",
    auth: {
        user: "carepointapp@gmail.com",
        pass: "projPei2021"
    }
});

module.exports = {
    transporter: transporter
}