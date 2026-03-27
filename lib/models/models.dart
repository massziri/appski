class Business {
  final String businessId;
  final String nameEn;
  final String nameMk;
  final String category;
  final String descriptionEn;
  final String descriptionMk;
  final String address;
  final String suburb;
  final String state;
  final double latitude;
  final double longitude;
  final String phone;
  final String email;
  final String website;
  final String imageUrl;
  final String status;
  final double rating;
  final int reviewCount;

  Business({
    required this.businessId,
    required this.nameEn,
    required this.nameMk,
    required this.category,
    required this.descriptionEn,
    required this.descriptionMk,
    required this.address,
    required this.suburb,
    required this.state,
    this.latitude = 0,
    this.longitude = 0,
    required this.phone,
    required this.email,
    required this.website,
    required this.imageUrl,
    this.status = 'published',
    this.rating = 0,
    this.reviewCount = 0,
  });

  String getName(String lang) => lang == 'mk' ? nameMk : nameEn;
  String getDescription(String lang) => lang == 'mk' ? descriptionMk : descriptionEn;
}

class Organisation {
  final String organisationId;
  final String nameEn;
  final String nameMk;
  final String type;
  final String descriptionEn;
  final String descriptionMk;
  final String phone;
  final String email;
  final String website;
  final String address;
  final String suburb;
  final String state;
  final double latitude;
  final double longitude;
  final String imageUrl;
  final List<String> galleryUrls;
  final String president;
  final String secretary;
  final String founded;
  final String membershipInfo;
  final Map<String, String> socialLinks;
  final String status;

  Organisation({
    required this.organisationId,
    required this.nameEn,
    required this.nameMk,
    required this.type,
    required this.descriptionEn,
    required this.descriptionMk,
    required this.phone,
    required this.email,
    required this.website,
    required this.address,
    required this.suburb,
    required this.state,
    this.latitude = 0,
    this.longitude = 0,
    required this.imageUrl,
    this.galleryUrls = const [],
    required this.president,
    required this.secretary,
    required this.founded,
    required this.membershipInfo,
    this.socialLinks = const {},
    this.status = 'published',
  });

  String getName(String lang) => lang == 'mk' ? nameMk : nameEn;
  String getDescription(String lang) => lang == 'mk' ? descriptionMk : descriptionEn;
}

class Recipe {
  final String recipeId;
  final String titleEn;
  final String titleMk;
  final String category;
  final List<String> ingredientsEn;
  final List<String> ingredientsMk;
  final List<String> instructionsEn;
  final List<String> instructionsMk;
  final int prepTime;
  final String difficulty;
  final String imageUrl;

  Recipe({
    required this.recipeId,
    required this.titleEn,
    required this.titleMk,
    required this.category,
    required this.ingredientsEn,
    required this.ingredientsMk,
    required this.instructionsEn,
    required this.instructionsMk,
    required this.prepTime,
    required this.difficulty,
    required this.imageUrl,
  });

  String getTitle(String lang) => lang == 'mk' ? titleMk : titleEn;
  List<String> getIngredients(String lang) => lang == 'mk' ? ingredientsMk : ingredientsEn;
  List<String> getInstructions(String lang) => lang == 'mk' ? instructionsMk : instructionsEn;
}

class Event {
  final String eventId;
  final String titleEn;
  final String titleMk;
  final String descriptionEn;
  final String descriptionMk;
  final DateTime startDate;
  final DateTime endDate;
  final String venue;
  final String venueAddress;
  final String organiserName;
  final String ticketUrl;
  final String imageUrl;
  final String status;
  final String category;

  Event({
    required this.eventId,
    required this.titleEn,
    required this.titleMk,
    required this.descriptionEn,
    required this.descriptionMk,
    required this.startDate,
    required this.endDate,
    required this.venue,
    required this.venueAddress,
    required this.organiserName,
    required this.ticketUrl,
    required this.imageUrl,
    this.status = 'published',
    this.category = 'community',
  });

  String getTitle(String lang) => lang == 'mk' ? titleMk : titleEn;
  String getDescription(String lang) => lang == 'mk' ? descriptionMk : descriptionEn;
}

class NewsArticle {
  final String newsId;
  final String titleEn;
  final String titleMk;
  final String bodyEn;
  final String bodyMk;
  final String category;
  final DateTime publishedAt;
  final String featuredImage;
  final String author;
  final int readingTime;

  NewsArticle({
    required this.newsId,
    required this.titleEn,
    required this.titleMk,
    required this.bodyEn,
    required this.bodyMk,
    required this.category,
    required this.publishedAt,
    required this.featuredImage,
    this.author = 'MCA Admin',
    this.readingTime = 3,
  });

  String getTitle(String lang) => lang == 'mk' ? titleMk : titleEn;
  String getBody(String lang) => lang == 'mk' ? bodyMk : bodyEn;
}

class RadioStation {
  final String stationId;
  final String name;
  final String streamUrl;
  final String logoUrl;
  final String region;
  final String genre;
  final bool isLive;

  RadioStation({
    required this.stationId,
    required this.name,
    required this.streamUrl,
    required this.logoUrl,
    required this.region,
    required this.genre,
    this.isLive = true,
  });
}

class TvChannel {
  final String channelId;
  final String name;
  final String descriptionEn;
  final String descriptionMk;
  final String streamUrl;
  final String streamType;
  final String websiteUrl;
  final String logoUrl;
  final bool is24x7;
  final bool active;

  TvChannel({
    required this.channelId,
    required this.name,
    required this.descriptionEn,
    required this.descriptionMk,
    required this.streamUrl,
    required this.streamType,
    required this.websiteUrl,
    required this.logoUrl,
    this.is24x7 = true,
    this.active = true,
  });
}

class TourismPlace {
  final String placeId;
  final String nameEn;
  final String nameMk;
  final String region;
  final String category;
  final String descriptionEn;
  final String descriptionMk;
  final String imageUrl;
  final List<String> galleryUrls;
  final double latitude;
  final double longitude;
  final String tipsEn;
  final String tipsMk;

  TourismPlace({
    required this.placeId,
    required this.nameEn,
    required this.nameMk,
    required this.region,
    required this.category,
    required this.descriptionEn,
    required this.descriptionMk,
    required this.imageUrl,
    this.galleryUrls = const [],
    this.latitude = 0,
    this.longitude = 0,
    this.tipsEn = '',
    this.tipsMk = '',
  });

  String getName(String lang) => lang == 'mk' ? nameMk : nameEn;
  String getDescription(String lang) => lang == 'mk' ? descriptionMk : descriptionEn;
}

class OrthodoxDay {
  final String dateKey;
  final String julianDate;
  final List<String> saintsEn;
  final List<String> saintsMk;
  final String feastType; // great_feast, regular, fast
  final String fastingRule; // oil_allowed, fish, strict, none
  final List<String> readings;

  OrthodoxDay({
    required this.dateKey,
    required this.julianDate,
    required this.saintsEn,
    required this.saintsMk,
    required this.feastType,
    required this.fastingRule,
    this.readings = const [],
  });

  List<String> getSaints(String lang) => lang == 'mk' ? saintsMk : saintsEn;
}

class Banner {
  final String bannerId;
  final String titleEn;
  final String titleMk;
  final String imageUrl;
  final String linkType;
  final String linkId;
  final String externalUrl;
  final int displayOrder;
  final bool active;

  Banner({
    required this.bannerId,
    this.titleEn = '',
    this.titleMk = '',
    required this.imageUrl,
    this.linkType = 'none',
    this.linkId = '',
    this.externalUrl = '',
    this.displayOrder = 0,
    this.active = true,
  });
}

class WeatherData {
  final String cityKey;
  final double currentTemp;
  final String condition;
  final String icon;
  final List<HourlyForecast> hourlyForecast;
  final List<DailyForecast> dailyForecast;

  WeatherData({
    required this.cityKey,
    required this.currentTemp,
    required this.condition,
    this.icon = '☀️',
    this.hourlyForecast = const [],
    this.dailyForecast = const [],
  });
}

class HourlyForecast {
  final String time;
  final double temp;
  final String icon;

  HourlyForecast({required this.time, required this.temp, this.icon = '☀️'});
}

class DailyForecast {
  final String day;
  final double high;
  final double low;
  final String icon;
  final String condition;

  DailyForecast({required this.day, required this.high, required this.low, this.icon = '☀️', this.condition = 'Sunny'});
}

class Submission {
  final String type;
  final String submitterName;
  final String submitterEmail;
  final String submitterPhone;
  final Map<String, dynamic> data;

  Submission({
    required this.type,
    required this.submitterName,
    required this.submitterEmail,
    required this.submitterPhone,
    required this.data,
  });
}
