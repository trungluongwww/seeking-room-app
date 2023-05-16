// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:roomeasy/form/file/file.dart';

class RoomCreateFormModel {
  final String name;
  final String description;
  final int rentPerMonth;
  final int deposit;
  final int squareMetre;
  final String provinceId;
  final String districtId;
  final String wardId;
  final String address;
  final List<String> convenienceIds;
  final List<FileFormModel> files;
  RoomCreateFormModel({
    required this.name,
    required this.description,
    required this.rentPerMonth,
    required this.deposit,
    required this.squareMetre,
    required this.provinceId,
    required this.districtId,
    required this.wardId,
    required this.address,
    required this.convenienceIds,
    required this.files,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'description': description,
      'rentPerMonth': rentPerMonth,
      'deposit': deposit,
      'squareMetre': squareMetre,
      'provinceId': provinceId,
      'districtId': districtId,
      'wardId': wardId,
      'address': address,
      'convenienceIds': convenienceIds,
      'files': files.map((x) => x.toMap()).toList(),
    };
  }

  RoomCreateFormModel copyWith({
    String? name,
    String? description,
    int? rentPerMonth,
    int? deposit,
    int? squareMetre,
    String? provinceId,
    String? districtId,
    String? wardId,
    String? address,
    List<String>? convenienceIds,
    List<FileFormModel>? files,
  }) {
    return RoomCreateFormModel(
      name: name ?? this.name,
      description: description ?? this.description,
      rentPerMonth: rentPerMonth ?? this.rentPerMonth,
      deposit: deposit ?? this.deposit,
      squareMetre: squareMetre ?? this.squareMetre,
      provinceId: provinceId ?? this.provinceId,
      districtId: districtId ?? this.districtId,
      wardId: wardId ?? this.wardId,
      address: address ?? this.address,
      convenienceIds: convenienceIds ?? this.convenienceIds,
      files: files ?? this.files,
    );
  }
}