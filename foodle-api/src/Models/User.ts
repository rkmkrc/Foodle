import { Review } from './Review';
import { UserCredentials } from './UserCredentials';
import { UserInfo } from './UserInfo';

export class User {
	private userInfo: UserInfo;
	private userCredantials: UserCredentials;
	private reviews: Review[];
	private followers: User[];
	private following: User[];

	constructor(
		userInfo: UserInfo,
		userCredantials: UserCredentials,
		reviews: Review[],
		followers: User[],
		following: User[]
	) {
		this.userInfo = userInfo;
		this.userCredantials = userCredantials;
		this.reviews = reviews;
		this.followers = followers;
		this.following = following;
	}

	public getUserInfo(): UserInfo {
		return this.userInfo;
	}

	public setUserInfo(userInfo: UserInfo): void {
		this.userInfo = userInfo;
	}

	public getUserCredantials(): UserCredentials {
		return this.userCredantials;
	}

	public setUserCredantials(userCredantials: UserCredentials): void {
		this.userCredantials = userCredantials;
	}

	public getReviews(): Review[] {
		return this.reviews;
	}

	public setReviews(reviews: Review[]): void {
		this.reviews = reviews;
	}

	public getFollowers(): User[] {
		return this.followers;
	}

	public setFollowers(followers: User[]): void {
		this.followers = followers;
	}

	public getFollowing(): User[] {
		return this.following;
	}

	public setFollowing(following: User[]): void {
		this.following = following;
	}
}
