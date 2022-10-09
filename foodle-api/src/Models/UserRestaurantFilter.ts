import { RestaurantType } from "#Types/types";

export class GPS {
    public x: number;
    public y: number;

    constructor(
        x: number,
        y: number
    ) {
        this.x = x;
        this.y = y;
    }
}

export class UserRestaurantFilter {
    public userGPS: GPS;
    public restaurantType: string;

    constructor(
        userGPS: GPS,
        restaurantType: string
    ) {
        this.userGPS = userGPS;
        this.restaurantType = restaurantType;
    }
}