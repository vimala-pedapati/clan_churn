import 'dart:convert';

UploadLogoResponse clientUploadLogoResponseFromJson(String str) => UploadLogoResponse.fromJson(json.decode(str));

String clientUploadLogoResponseToJson(UploadLogoResponse data) => json.encode(data.toJson());

class UploadLogoResponse {
    String filename;
    String imageUrl;

    UploadLogoResponse({
        required this.filename,
        required this.imageUrl,
    });

    factory UploadLogoResponse.fromJson(Map<String, dynamic> json) => UploadLogoResponse(
        filename: json["filename"],
        imageUrl: json["image_url"],
    );

    Map<String, dynamic> toJson() => {
        "filename": filename,
        "image_url": imageUrl,
    };
}