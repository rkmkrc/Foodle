export const RestaurantType = [
	'Lahmacun',
	'Mantı',
	'Desserts',
	'Street Food',
	'Vegan',
	'World Cuisine',
	'Burger',
	'Fish',
	'Toast & Sandwich',
	'Ice Cream',
	'Vegetarian',
	'Pide ',
	'Pizza',
	'Doner',
	'Çiğ Köfte',
	'Borek',
	'Fit',
	'Homemade Meals',
	'Kebab',
	'Salad',
	'Chicken',
	'Drinks',
	'Breakfast',
	'Steak',
	'Meatballs',
	'Asian Cuisine',
	'Coffee',
]

export const Gender = {
	male: 'M',
	female: 'F',
	other: "O"
}

export type reviewBody = {
	rate: number,
	text: string,
	photos: string,
	userID: number,
	mealID: number,
}