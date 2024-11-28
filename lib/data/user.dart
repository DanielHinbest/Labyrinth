// TODO: refine this, maybe have mixins for online users so that they have online specific stuff
class User {
  final String? username;
  final String? avatarUrl;
  final String? email;
  final bool? isOnline;

  User({
    this.username,
    this.avatarUrl,
    this.email,
    this.isOnline = false,
  });
}
