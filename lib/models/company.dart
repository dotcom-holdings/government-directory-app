
class Company{
  String id;
  String name;
  String address;
  String paddress;
  String telephone;
  String mobile;
  String fax;
  String email;
  String website;
  String about_us;
  String hours;
  String status;
  String facebook;
  String twitter;
  String youtube;
  String linkedn;
  String instagram;
  String skype;
  String classified_banner_promo_link;
  String promotions_ad_link;

  Company({
    this.id,
    this.name,
    this.address,
    this.paddress,
    this.telephone,
    this.mobile,
    this.fax,
    this.email,
    this.website,
    this.about_us,
    this.hours,
    this.status,
    this.facebook,
    this.twitter,
    this.youtube,
    this.linkedn,
    this.instagram,
    this.skype,
    this.classified_banner_promo_link,
    this.promotions_ad_link
  });

  factory Company.fromjson(Map<String, dynamic> json) => new Company(
    id: json['id'],
    name: json['name'],
    address: json['address'],
    paddress: json['paddress'],
    telephone: json['telephone'],
    mobile: json['mobile'],
    fax: json['fax'],
    email: json['email'],
    website: json['website'],
    about_us: json['about_us'],
    hours: json['hours'],
    status: json['status'],
    facebook: json['facebook'],
    twitter: json['twitter'],
    youtube: json['youtube'],
    linkedn: json['linkedn'],
    instagram: json['instagram'],
    skype: json['skype'],
    classified_banner_promo_link: json['classified_banner_promo_link'],
    promotions_ad_link: json['promotions_ad_link']
  );

  Map<String, dynamic> toJson() => {

  };
}