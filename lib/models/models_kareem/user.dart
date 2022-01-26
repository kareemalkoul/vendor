class User {
  int id;
  String name;
  String slogan;
  String owner;
  int specification;
  String email;
  String accountStatus;

  User(
      {this.id,
      this.name,
      this.slogan,
      this.owner,
      this.specification,
      this.email,
      this.accountStatus});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    slogan = json['slogan'];
    owner = json['owner'];
    specification = json['specification'];
    email = json['email'];
    accountStatus = json['accountStatus'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['name'] = this.name;
  //   data['slogan'] = this.slogan;
  //   data['owner'] = this.owner;
  //   data['specification'] = this.specification;
  //   data['email'] = this.email;
  //   data['accountStatus'] = this.accountStatus;
  //   return data;
  // }
}
