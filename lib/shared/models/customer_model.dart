class Customer {
  final int id;
  final String name;
  final String surname;
  final String gsmNo;
  final int corporationId;
  final int roleId;
  final bool isActive;
  final String username;
  final String password;

  Customer({this.id, this.name, this.surname, this.gsmNo, this.corporationId, this.roleId, this.isActive, this.username, this.password });

  ///Object to map
  Map <String, dynamic> toMap() => {
    'id' : id,
    'name' : name,
    'surname' : surname,
    'gsmNo' : gsmNo,
    'corporationId' : corporationId,
    'roleId' : roleId,
    'isActive' : isActive,
    'username' : username,
    'password' : password
  };

  ///Map to object
  factory Customer.fromMap(Map map) => Customer(
    id : map['id'],
    name : map['name'],
    surname : map['surname'],
    gsmNo : map['gsmNo'],
    corporationId : map['corporationId'],
    roleId : map['roleId'],
    isActive : map['isActive'],
    username : map['username'],
    password : map['password'],
  );
}