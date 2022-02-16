const nodemailer = require('nodemailer')

const transporter = nodemailer.createTransport({
    service: "Gmail",
    auth: {
        user: "", //mail here
        pass: "" //password here
    }
});

module.exports = {
    transporter: transporter
}
