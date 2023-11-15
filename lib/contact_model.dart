class Contact {
  String name;
  String email;
  String phone;

  String gender;
  Contact({
    required this.name,
    required this.email,
    required this.phone,
    required this.gender,
  });
}

List<Contact> contactData = [
  Contact(
    name: "Budi",
    email: "budi@budi.com",
    phone: "081234567890",
    gender: "Male",
  ),
  Contact(
    name: "Siti",
    email: "siti@siti.com",
    phone: "081234567890",
    gender: "Female",
  ),
];
