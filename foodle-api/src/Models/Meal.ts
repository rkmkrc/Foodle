export class Meal {
	private name: string;
	private description: string;
	private content: string;
	private price: number;

	constructor(name: string, description: string, content: string, price: number) {
		this.name = name;
		this.description = description;
		this.content = content;
		this.price = price;
	}

	public getPrice(): number {
		return this.price;
	}

	public setPrice(price: number): void {
		this.price = price;
	}

	public getName(): string {
		return this.name;
	}

	public setName(name: string): void {
		this.name = name;
	}

	public getDescription(): string {
		return this.description;
	}

	public setDescription(description: string): void {
		this.description = description;
	}

	public getContent(): string {
		return this.content;
	}

	public setContent(content: string): void {
		this.content = content;
	}
}
