import * as Crypto from 'crypto-js';

export class UserCredentials {
	private userID: number;
	private userName: string;
	private email: string;
	private phoneNumber: string;
	private hashedPassword: string;
	private accessToken: string;

	constructor(
		userID: number,
		userName: string,
		email: string,
		phoneNumber: string,
		hashedPassword: string,
		accessToken: string = ''
	) {
		this.userID = userID;
		this.userName = userName;
		this.email = email;
		this.phoneNumber = phoneNumber;
		this.hashedPassword = hashedPassword;
		this.accessToken = accessToken;
	}

	public getUserID(): number {
		return this.userID;
	}

	public setUserID(userID: number): void {
		this.userID = userID;
	}

	public getUserName(): string {
		return this.userName;
	}

	public setUserName(userName: string): void {
		this.userName = userName;
	}

	public getEmail(): string {
		return this.email;
	}

	public setEmail(email: string): void {
		this.email = email;
	}

	public getPhoneNumber(): string {
		return this.phoneNumber;
	}

	public setPhoneNumber(phoneNumber: string): void {
		this.phoneNumber = phoneNumber;
	}

	public getHashedPassword(): string {
		return this.hashedPassword;
	}

	public setHashedPassword(hashedPassword: string): void {
		this.hashedPassword = hashedPassword;
	}

	public getAccessToken(): string {
		return this.accessToken;
	}

	public generateAccessToken(): string {
		const digest = Crypto.SHA256(
			Date.now().toString() +
			this.userName +
			this.email +
			this.phoneNumber +
			this.hashedPassword
		).toString(Crypto.enc.Base64);
		this.accessToken = digest;
		return this.accessToken;
	}
}
