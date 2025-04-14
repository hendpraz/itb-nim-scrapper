import 'dart:io';

import 'package:http/http.dart' as http;

void main() async {
  final bearerToken = "Bearer <token>";

  final cvid = "<cvid token>";

  final nimCode = {
    '101': 'Matematika',
    '102': 'Fisika',
    '103': 'Astronomi',
    '104': 'Mikrobiologi',
    '105': 'Kimia',
    '106': 'Biologi',
    '107': 'Sains dan Teknologi Farmasi',
    '108': 'Aktuaria',
    '109': 'Teknik Oseanografi',
    '112': 'Rekayasa Hayati',
    '114': 'Rekayasa Pertanian',
    '115': 'Rekayasa Kehutanan',
    '116': 'Farmasi Klinik dan Komunitas',
    '119': 'Teknologi Pasca Panen',
    '120': 'Teknik Geologi',
    '121': 'Teknik Pertambangan',
    '122': 'Teknik Perminyakan',
    '123': 'Teknik Geofisika',
    '125': 'Teknik Metalurgi',
    '128': 'Meteorologi',
    '129': 'Oseanografi',
    '130': 'Teknik Kimia',
    '131': 'Teknik Mesin',
    '132': 'Teknik Elektro',
    '133': 'Teknik Fisika',
    '134': 'Teknik Industri',
    '135': 'Teknik Informatika',
    '136': 'Aeronotika dan Astronotika',
    '137': 'Teknik Material',
    '143': 'Teknik Pangan',
    '144': 'Manajemen Rekayasa Industri',
    '145': 'Teknik Bioenergi dan Kemurgi',
    '150': 'Teknik Sipil',
    '151': 'Teknik Geodesi dan Geomatika',
    '152': 'Arsitektur',
    '153': 'Teknik Lingkungan',
    '154': 'Perencanaan Wilayah dan Kota',
    '155': 'Teknik Kelautan',
    '157': 'Rekayasa Infrastruktur Lingkungan',
    '158': 'Teknik dan Pengelolaan Sumber Daya Air',
    '160': 'Fakultas Matematika dan Ilmu Pengetahuan Alam',
    '161': 'Sekolah Ilmu Teknologi Hayati - Sains',
    '162': 'Sekolah Farmasi',
    '163': 'Fakultas Ilmu dan Teknologi Kebumian',
    '164': 'Fakultas Teknik Pertambangan dan Perminyakan',
    '165': 'Sekolah Teknik Elektro dan Informatika - Rekayasa',
    '166': 'Fakultas Teknik Sipil dan Lingkungan',
    '167': 'Fakultas Teknik Industri',
    '168': 'Fakultas Seni Rupa dan Desain',
    '169': 'Fakultas Teknik Mesin dan Dirgantara',
    '170': 'Seni Rupa',
    '171': 'Desain',
    '172': 'Kriya',
    '173': 'Desain Interior',
    '174': 'Desain Komunikasi Visual',
    '175': 'Desain Produk',
    '180': 'Teknik Tenaga Listrik',
    '181': 'Teknik Telekomunikasi',
    '182': 'Sistem Teknologi dan Informasi',
    '183': 'Teknik Biomedis',
    '190': 'Manajemen',
    '192': 'Kewirausahaan',
    '196': 'Sekolah Teknik Elektro dan Informatika - Komputasi',
    '197': 'Sekolah Bisnis dan Manajemen',
    '198': 'Sekolah Ilmu Teknologi Hayati - Rekayasa',
    '199': 'Sekolah Arsitektur, Perencanaan dan Pengembangan Kebijakan',
    '201': 'Matematika',
    '202': 'Fisika',
    '203': 'Astronomi',
    '205': 'Kimia',
    '206': 'Biologi',
    '207': 'Farmasi',
    '208': 'Aktuaria',
    '209': 'Sains Komputasi',
    '211': 'Bioteknologi',
    '213': 'Biomanajemen',
    '220': 'Teknik Geologi',
    '221': 'Rekayasa Pertambangan',
    '222': 'Teknik Perminyakan',
    '223': 'Teknik Geofisika',
    '224': 'Sains Kebumian',
    '225': 'Teknik Metalurgi',
    '226': 'Teknik Panas Bumi',
    '227': 'Teknik Air Tanah',
    '230': 'Teknik Kimia',
    '231': 'Teknik Mesin',
    '232': 'Teknik Elektro',
    '233': 'Teknik Fisika',
    '234': 'Teknik dan Manajemen Industri',
    '235': 'Informatika',
    '236': 'Aeronotika dan Astronotika',
    '237': 'Ilmu dan Teknik Material',
    '238': 'Instrumentasi dan Kontrol',
    '239': 'Studi Pertahanan',
    '240': 'Studi Pembangunan',
    '242': 'Transportasi',
    '249': 'Ilmu dan Rekayasa Nuklir',
    '250': 'Teknik Sipil',
    '251': 'Teknik Geodesi dan Geomatika',
    '252': 'Arsitektur',
    '253': 'Teknik Lingkungan',
    '254': 'Perencanaan Wilayah dan Kota',
    '255': 'Teknik Kelautan',
    '256': 'Rancang Kota',
    '269': 'Sistem dan Teknik Jalan Raya',
    '270': 'Seni Rupa',
    '271': 'Desain',
    '289': 'Arsitektur Lanskap',
    '290': 'Sains Manajemen',
    '291': 'Administrasi Bisnis',
    '301': 'Matematika',
    '302': 'Fisika',
    '303': 'Astronomi',
    '305': 'Kimia',
    '306': 'Biologi',
    '307': 'Farmasi',
    '320': 'Teknik Geologi',
    '321': 'Rekayasa Pertambangan',
    '322': 'Teknik Perminyakan',
    '323': 'Teknik Geofisika',
    '324': 'Sains Kebumian',
    '330': 'Teknik Kimia',
    '331': 'Teknik Mesin',
    '332': 'Teknik Elektro dan Informatika',
    '333': 'Teknik Fisika',
    '334': 'Teknik dan Manajemen Industri',
    '336': 'Aeronotika dan Astronotika',
    '337': 'Ilmu dan Teknik Material',
    '342': 'Transportasi',
    '349': 'Rekayasa Nuklir',
    '350': 'Teknik Sipil',
    '351': 'Teknik Geodesi dan Geomatika',
    '352': 'Arsitektur',
    '353': 'Teknik Lingkungan',
    '354': 'Perencanaan Wilayah dan Kota',
    '370': 'Ilmu Seni Rupa dan Desain',
    '371': 'Desain',
    '390': 'Sains Manajemen',
    '901': 'Pengajaran Matematika',
    '902': 'Pengajaran Fisika',
    '905': 'Pengajaran Kimia',
    '907': 'Profesi Apoteker',
    '950': 'Pengelolaan Sumberdaya Air (PSDA)',
    '957': 'Terapan Perencanaan Kepariwisataan',
  };

  final headers = {
    'x-ms-session-id': '3fc0fd31-9e5d-4f2b-aa78-bbdbf2fec0c3',
    'clientrequestid': '6ef24d2c-1124-4698-8cd9-d5ab71960065',
    'x-anchormailbox':
        'Oid:b0f9f34f-cea3-4f8e-b1ce-23a72606531c@db6e1183-4c65-405c-82ce-7cd53fa6e9dc',
    'x-client-flights': 'IncludeHistoryInBMDynamic,EnableSelfSuggestion',
    'x-client-version': 'T2.1',
    'x-cafelatencyheaderenabled': '1',
    'authorization': bearerToken,
    'client-request-id': '6ef24d2c-1124-4698-8cd9-d5ab71960065',
    'content-type': 'application/json',
    'x-ms-request-id': '6ef24d2c-1124-4698-8cd9-d5ab71960065',
    'User-Agent':
        'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/123.0.0.0 Mobile Safari/537.36',
    'x-client-localtime': '2024-05-24T15:29:28.844Z',
    'Referer': 'https://teams.microsoft.com/',
    'client-session-id': '3fc0fd31-9e5d-4f2b-aa78-bbdbf2fec0c3',
  };

  final params = {
    'scenario': 'powerbar',
  };

  final angkatan = '21';
  final splitter = "\n";

  for (final code in nimCode.keys) {
    final size = 500;
    final query = '$code$angkatan';

    print("Fetching $query");

    final data =
        '{"EntityRequests":[{"Query":{"QueryString":"$query","DisplayQueryString":"$query"},"EntityType":"People","Size":$size,"Fields":["Id","MRI","DisplayName","EmailAddresses","CompanyName","JobTitle","ImAddress","ExternalDirectoryObjectId","PeopleType","PeopleSubtype","Phones","ConcatenatedId","UserPrincipalName","GivenName","Surname","Cid"],"Filter":{"And":[{"Or":[{"Term":{"PeopleType":"Person"}},{"Term":{"PeopleType":"Other"}}]},{"Or":[{"Term":{"PeopleSubtype":"OrganizationUser"}},{"Term":{"PeopleSubtype":"Guest"}}]}]},"Provenances":["Mailbox","Directory"],"From":0},{"Query":{"QueryString":"$query"},"EntityType":"File","Size":3},{"Query":{"QueryString":"$query"},"EntityType":"Chat","Size":5},{"Query":{"QueryString":"$query"},"EntityType":"Team","Size":3},{"Query":{"QueryString":"$query"},"EntityType":"Channel","Size":4,"Filter":{"Or":[{"Term":{"ChannelType":"Standard"}},{"Term":{"ChannelType":"Shared"}}]}},{"Query":{"QueryString":"$query"},"EntityType":"Text","Size":2}],"Scenario":{"Name":"powerbar"},"Cvid": "$cvid","AppName":"Microsoft Teams","LogicalId":"4c91875d-6cd8-47b5-b32e-586a9a6716a2"}';

    final url =
        Uri.parse('https://substrate.office.com/search/api/v1/suggestions')
            .replace(queryParameters: params);

    final res = await http.post(url, headers: headers, body: data);
    final status = res.statusCode;
    if (status != 200) throw Exception('http.post error: statusCode= $status');

    // append to file
    final file = await File('data/output_jurusan_21_new.txt').create();
    await file.writeAsString("${res.body}$splitter",
        mode: FileMode.writeOnlyAppend);

    print("Done fetching $query - Length response: ${res.body.length}");
  }
}
