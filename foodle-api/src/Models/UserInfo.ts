import { Gender } from '#Types/types';

export class UserInfo {
	private name: string;
	private surname: string;
	private birthDate: Date;
	private gender: string;
	private userScore: number;
	private userID: number;
	private userPhoto: string;

	constructor(
		userID: number,
		name: string,
		surname: string,
		birthDate: Date,
		gender: string,
		userScore: number,
		userPhoto: string
	) {
		this.name = name;
		this.surname = surname;
		this.birthDate = birthDate;
		this.gender = gender;
		this.userScore = userScore;
		this.userID = userID;
		this.userPhoto = userPhoto;
	}

	public getName(): string {
		return this.name;
	}

	public setName(name: string): void {
		this.name = name;
	}

	public getSurname(): string {
		return this.surname;
	}

	public setSurname(surname: string): void {
		this.surname = surname;
	}

	public getBirthDate(): Date {
		return this.birthDate;
	}

	public setBirthDate(birthDate: Date): void {
		this.birthDate = birthDate;
	}

	public getGender(): string {
		return this.gender;
	}

	public setGender(gender: string): void {
		this.gender = gender;
	}

	public getUserScore(): number {
		return this.userScore;
	}

	public setUserScore(userScore: number): void {
		this.userScore = userScore;
	}

	public getUserID(): number {
		return this.userID;
	}

	public setUserID(userID: number): void {
		this.userID = userID;
	}

	public setUserPhoto(userPhoto: string): void {
		this.userPhoto = userPhoto;
	}

	public getUserPhoto(): string {
		return this.userPhoto;
	}

	updateUserScore(score: number): void {
		return;
	}
}
