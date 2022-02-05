const mail_config = require('../models/Config/Nodemail_config')

var Out = module.exports;

Out.sendMail = (email, assunto, msg) => {
    var mailOptions = {
        from: "carepointapp@gmail.com",
        to: email,
        subject: assunto,
        text: msg
    }

    return mail_config.transporter.sendMail(mailOptions);
}
