// ignore_for_file: public_member_api_docs, sort_constructors_first
class UserRaiz {
  final String id;
  final String token;
  final String name;
  final String email;
  final String profilePicture;
  final String? country;
  final String? state;
  final String? city;
  UserRaiz({
    required this.id,
    required this.token,
    required this.name,
    required this.email,
    required this.profilePicture,
    this.country,
    this.state,
    this.city,
  });
}
