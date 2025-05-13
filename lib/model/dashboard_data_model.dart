class DashBoardDataModel {
  final UserStats? users;
  final CraneStats? cranes;
  final List<DataCount>? dataCounts;
  final int? totalAdvertising;
  final List<CountryMapData>? countryMapsDatas;

  DashBoardDataModel({
     this.users,
     this.cranes,
     this.dataCounts,
     this.totalAdvertising,
     this.countryMapsDatas,
  });

  factory DashBoardDataModel.fromJson(Map<String, dynamic> json) {
    return DashBoardDataModel(
      users: UserStats.fromJson(json['users']),
      cranes: CraneStats.fromJson(json['cranes']),
      dataCounts: (json['dataCounts'] as List)
          .map((e) => DataCount.fromJson(e))
          .toList(),
      totalAdvertising: json['totalAdvertising'],
      countryMapsDatas: (json['countryMapsDatas'] as List)
          .map((e) => CountryMapData.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'users': users?.toJson(),
        'cranes': cranes?.toJson(),
        'dataCounts': dataCounts?.map((e) => e.toJson()).toList(),
        'totalAdvertising': totalAdvertising,
        'countryMapsDatas':
            countryMapsDatas?.map((e) => e.toJson()).toList(),
      };
}

class UserStats {
  final int iso;
  final int android;
  final int totalUser;
  final int detetedUsers;

  UserStats({
    required this.iso,
    required this.android,
    required this.totalUser,
    required this.detetedUsers,
  });

  factory UserStats.fromJson(Map<String, dynamic> json) {
    return UserStats(
      iso: json['iso'],
      android: json['android'],
      totalUser: json['totalUser'],
      detetedUsers: json['detetedUsers'],
    );
  }

  Map<String, dynamic> toJson() => {
        'iso': iso,
        'android': android,
        'totalUser': totalUser,
        'detetedUsers': detetedUsers,
      };
}

class CraneStats {
  final int rental;
  final int sell;
  final int total;

  CraneStats({
    required this.rental,
    required this.sell,
    required this.total,
  });

  factory CraneStats.fromJson(Map<String, dynamic> json) {
    return CraneStats(
      rental: json['rental'],
      sell: json['sell'],
      total: json['total'],
    );
  }

  Map<String, dynamic> toJson() => {
        'rental': rental,
        'sell': sell,
        'total': total,
      };
}

class DataCount {
  final String name;
  final int value;

  DataCount({
    required this.name,
    required this.value,
  });

  factory DataCount.fromJson(Map<String, dynamic> json) {
    return DataCount(
      name: json['name'],
      value: json['value'],
    );
  }

  Map<String, dynamic> toJson() => {
        'name': name,
        'value': value,
      };
}

class CountryMapData {
  final String country;
  final int usersCount;

  CountryMapData({
    required this.country,
    required this.usersCount,
  });

  factory CountryMapData.fromJson(Map<String, dynamic> json) {
    return CountryMapData(
      country: json['country'],
      usersCount: json['usersCount'],
    );
  }

  Map<String, dynamic> toJson() => {
        'country': country,
        'usersCount': usersCount,
      };
}
