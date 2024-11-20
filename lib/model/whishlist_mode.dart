class WhishlistMode {
  String imageUrl;
  String title;
  String description;
  String isLiked;

  WhishlistMode({
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.isLiked,
  });
}

List<WhishlistMode> wishlistItems = [];
