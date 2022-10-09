import { RestaurantType } from '#Types/types';
import { Meal } from './Meal';
import { Review } from './Review';

export class Restaurant {
	private name: string;
	private restaurantID: number;
	private description: string;
	private locationInfo: string;
	private restaurantType: string;
	private review: Review[];
	private score: number;
	private menu: Meal[];

	constructor(
		name: string,
		ID: number,
		description: string,
		locationInfo: string,
		restaurantType: string,
		review: Review[],
		score: number,
		menu: Meal[]
	) {
		this.name = name;
		this.restaurantID = ID;
		this.description = description;
		this.locationInfo = locationInfo;
		this.restaurantType = restaurantType;
		this.review = review;
		this.score = score;
		this.menu = menu;
	}

	public getMenu(): Meal[] {
		return this.menu;
	}

	public setMenu(menu: Meal[]): void {
		this.menu = menu;
	}

	public getName(): string {
		return this.name;
	}

	public setName(name: string): void {
		this.name = name;
	}

	public getRestaurantID(): number {
		return this.restaurantID;
	}

	public setRestaurantID(restaurantID: number): void {
		this.restaurantID = restaurantID;
	}

	public getDescription(): string {
		return this.description;
	}

	public setDescription(description: string): void {
		this.description = description;
	}

	public getLocationInfo(): string {
		return this.locationInfo;
	}

	public setLocationInfo(locationInfo: string): void {
		this.locationInfo = locationInfo;
	}

	public getRestaurantType(): string {
		return this.restaurantType;
	}

	public setRestaurantType(restaurantType: string): void {
		this.restaurantType = restaurantType;
	}

	public getReview(): Review[] {
		return this.review;
	}

	public setReview(review: Review[]): void {
		this.review = review;
	}

	public getScore(): number {
		return this.score;
	}

	public setScore(score: number): void {
		this.score = score;
	}

	updateRestaurantScore(): void { }
}
