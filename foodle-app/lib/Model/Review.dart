class Review {
  late String name;
  late int reviewID;
  late int userID;
  late int mealID;
  late String text;
  late String date;
  late int score;
  late double rate;
  late String? photos;
  late int restaurantID;
  late String? description;
  late String? foodContent;
  late double price;

  Review(
      this.name,
      this.reviewID,
      this.userID,
      this.mealID,
      this.text,
      this.date,
      this.score,
      this.rate,
      this.photos,
      this.restaurantID,
      this.description,
      this.foodContent); //;
/* 
  Restaurant.fromJson(Map<String, dynamic> json)
      : restaurantID = json["restaurantInfo"]['restaurantid'],
        name = json["restaurantInfo"]["name"],
        type = json["restaurantInfo"]["type"],
        rate = json["restaurantInfo"]["rate"],
        latitude = json["restaurantInfo"]["latitude"],
        longitude = json["restaurantInfo"]["longitude"],
        photos = json["restaurantInfo"]["photos"],
        reviewCount = json["restaurantInfo"]["reviewcount"]; */

  Review.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        reviewID = json['reviewid'],
        userID = json['userid'],
        mealID = json['mealid'],
        text = json['text'],
        date = json['date'],
        score = json['score'],
        rate = json["rate"]+.0,
        photos = json["photos"],
        restaurantID = json['restaurantid'],
        description = json["description"],
        foodContent = json["foodcontent"],
        price = json["price"]+.0;

  /* "restaurantInfo": {
        "restaurantid": 72,
        "name": "Escape Café",
        "type": "Toast & Sandwich",
        "rate": 2.335714285714286,
        "latitude": 41.05736,
        "longitude": 29.319033,
        "photos": null
    }, */

}
