class Profile {
  String name;
  String profession;
  String email;
  int phone;
  String address;
  String bio;
  DateTime birthday;

  Profile({
    this.name = 'Mulyana',
    this.profession = 'Flutter Developer',
    this.email = 'mulyanan@solecode.com',
    this.phone = 085770302069,
    this.address = 'Binong Permai',
    this.bio = 'waegsehdrfjtgkyhuj',
    DateTime? birthday,
  }) : birthday = birthday ?? DateTime.now();
}

final profile = Profile(); 
