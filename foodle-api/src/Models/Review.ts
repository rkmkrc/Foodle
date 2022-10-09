import { Meal } from './Meal';
import { User } from './User';

export class Review {
	private title: string;
	private text: string;
	private date: Date;
	private score: number;
	private upVoters: User[];
	private downViewers: User[];
	private meal: Meal;

	constructor(title: string, text: string, date: Date, score: number, upVoters: User[], downViewers: User[], meal: Meal) {
		this.title = title;
		this.text = text;
		this.date = date;
		this.score = score;
		this.upVoters = upVoters;
		this.downViewers = downViewers;
		this.meal = meal;
	}

	public getMeal(): Meal {
		return this.meal;
	}

	public setMeal(meal: Meal): void {
		this.meal = meal;
	}

	public getTitle(): string {
		return this.title;
	}

	public setTitle(title: string): void {
		this.title = title;
	}

	public getText(): string {
		return this.text;
	}

	public setText(text: string): void {
		this.text = text;
	}

	public getDate(): Date {
		return this.date;
	}

	public setDate(date: Date): void {
		this.date = date;
	}

	public getScore(): number {
		return this.score;
	}

	public setScore(score: number): void {
		this.score = score;
	}

	public getUpVoters(): User[] {
		return this.upVoters;
	}

	public setUpVoters(upVoters: User[]): void {
		this.upVoters = upVoters;
	}

	public getDownViewers(): User[] {
		return this.downViewers;
	}

	public setDownViewers(downViewers: User[]): void {
		this.downViewers = downViewers;
	}

	calculateScore(): void {}
}
