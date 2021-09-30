// FUTURS - Companies Model

class Companies {
  late String companyID;
  late String companyName;
  late String companyDescription;
  late String companyPhotoUrl;
  late String companyContact;
  late String companyCategory;

  Companies({
    required this.companyID,
    required this.companyName,
    required this.companyDescription,
    required this.companyPhotoUrl,
    required this.companyContact,
    required this.companyCategory,
  });

  Companies.fromJson(Map<String, dynamic> json) {
    companyID = json['company_id'];
    companyName = json['company_name'];
    companyDescription = json['company_description'];
    companyPhotoUrl = json['company_photo_url'];
    companyContact = json['company_contact'];
    companyCategory = json['company_category'];
  }
}