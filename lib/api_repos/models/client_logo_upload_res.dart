import 'dart:convert';

ClientUploadLogoResponse clientUploadLogoResponseFromJson(String str) => ClientUploadLogoResponse.fromJson(json.decode(str));

String clientUploadLogoResponseToJson(ClientUploadLogoResponse data) => json.encode(data.toJson());

class ClientUploadLogoResponse {
    String filename;
    String imageUrl;

    ClientUploadLogoResponse({
        required this.filename,
        required this.imageUrl,
    });

    factory ClientUploadLogoResponse.fromJson(Map<String, dynamic> json) => ClientUploadLogoResponse(
        filename: json["filename"],
        imageUrl: json["image_url"],
    );

    Map<String, dynamic> toJson() => {
        "filename": filename,
        "image_url": imageUrl,
    };
}