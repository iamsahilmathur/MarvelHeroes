

class Marvel{

   String name;
   String profileImage;
   String howGotPow;
   String weapons;

   Marvel({required this.name,required this.profileImage,required this.howGotPow,required this.weapons});


    factory Marvel.fromJson(Map<String, dynamic> json) => Marvel(
      name: json["name"],
      profileImage: json["profile_image"],
      howGotPow: json["howGotPow"],
      weapons: json["weapons"],
   );


   Map<String, dynamic> toJson() => {
      "name": name,
      "profile_image": profileImage,
      "howGotPow": howGotPow,
      "weapons" : weapons
   };


}
