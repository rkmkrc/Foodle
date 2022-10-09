import { UserCredentials } from '#Models/UserCredentials';
import nodemailer from 'nodemailer';

const transporter = nodemailer.createTransport({
	host: 'smtp-mail.outlook.com',
	secure: false,
	auth: {
		user: process.env.EMAIL_FROM,
		pass: process.env.EMAIL_PASS,
	},
	port: 587,
	tls: {
		ciphers: 'SSLv3'
	}
});

export const sendOTP = async (userCredentials: UserCredentials, otp: string) => {
	const userName = userCredentials.getUserName();
	const email = userCredentials.getEmail();
	const text = '<div style="font-family: Helvetica,Arial,sans-serif;min-width:1000px;overflow:auto;line-height:2"><div style="margin:50px auto;width:70%;padding:20px 0"><div style="border-bottom:1px solid #eee"><a href="" style="font-size:1.4em;color: #00466a;text-decoration:none;font-weight:600">Foodle</a></div><p style="font-size:1.1em">Hi,</p><p>Hello ' + userName + '! Here is your verification code. </p><h2 style="background: #00466a;margin: 0 auto;width:max-content;padding: 0 10px;color: #fff;border-radius: 4px;">' + otp + '</h2><p style="font-size:0.9em;">Regards,<br />Foodle</p><hr style="border:none;border-top:1px solid #eee" ><div style="float:right;padding:8px 0;color:#aaa;font-size:0.8em;line-height:1;font-weight:300"><p>Foodle</p><p>Marmara University</p><p>Istanbul</p></div></div></div>';
	//const text = 'Hello ' + userName + '! Here is your verification code: ' + otp;

	var mailOptions = {
		from: process.env.EMAIL_FROM,
		to: email,
		subject: 'Verification code from Foodle',
		html: text,
	};

	transporter.sendMail(mailOptions, (error, info) => {
		if (error) {
			console.log(error);
		} else {
			console.log('Email is sent: ' + info.response);
		}
	});
};
