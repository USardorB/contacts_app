import 'package:contacts_app/data/datasources/remote/network_service.dart';
import 'package:contacts_app/data/datasources/remote_data_sources.dart';
import 'package:contacts_app/data/models/user_model.dart';
import 'package:contacts_app/presentation/pages/last_main.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeTab(),
    ),
  );
}

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final TextEditingController _controllerContact = TextEditingController();
  late final UserRemoteDataSource userDataSource;
  List<UserModel> users = [];
  bool isLoading = true;
  String? errorMessage;
  List<UserModel> filteredNames = [];

  void _searchNames() {
    final query = _controllerContact.text.toLowerCase();
    setState(
      () {
        if (query.isEmpty) {
          filteredNames = [];
        } else {
          filteredNames = users
              .where((user) => user.name.toLowerCase().contains(query))
              .toList();
        }
      },
    );
  }

  @override
  void dispose() {
    _controllerContact.removeListener(_searchNames);
    _controllerContact.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    final networkService = NetworkServiceImpl(
      baseUrl: 'https://jsonplaceholder.typicode.com',
    );
    userDataSource = UserRemoteDataSourceImpl(networkService);
    load();
    _controllerContact.addListener(_searchNames);
  }

  Future<void> load() async {
    try {
      setState(() {
        isLoading = true;
        errorMessage = null;
      });

      final usersList = await userDataSource.getAllUsers();

      setState(() {
        users = usersList;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMessage = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: 60, right: 20, left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (isLoading)
              const Center(child: CircularProgressIndicator())
            else if (errorMessage != null)
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Error: $errorMessage'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: load,
                      child: const Text('Retry'),
                    ),
                  ],
                ),
              )
            else if (users.isNotEmpty)
              Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage:
                        NetworkImage(NetworkServiceImpl.pictureUrl.first),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        users.first.name,
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        "${users.length} Contacts",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  ),
                  Spacer(),
                  Container(
                    alignment: Alignment.center,
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '!',
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            SizedBox(
              height: 12,
            ),
            Text(
              "Favorite",
              style: TextStyle(
                fontSize: 22,
              ),
            ),
            SizedBox(
              height: 100,
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: users.length > 5 ? 5 : users.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: CircleAvatar(
                      radius: 30,
                      child: ClipOval(
                        child: Image.network(
                          NetworkServiceImpl.pictureUrl[
                              index % NetworkServiceImpl.pictureUrl.length],
                          fit: BoxFit.cover,
                          width: 60,
                          height: 60,
                          errorBuilder: (context, error, stackTrace) {
                            return Container(
                              width: 60,
                              height: 60,
                              color: Colors.grey.shade300,
                              child: Icon(Icons.person,
                                  color: Colors.grey.shade600),
                            );
                          },
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            TextField(
              controller: _controllerContact,
              decoration: InputDecoration(
                hintText: 'Search',
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.grey.shade100,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(13),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            Expanded(
              child: _controllerContact.text.isNotEmpty && filteredNames.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 64,
                            color: Colors.grey.shade400,
                          ),
                          SizedBox(height: 16),
                          Text(
                            'No contacts found',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.grey.shade600,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            'Try searching with a different name',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey.shade500,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: _controllerContact.text.isEmpty
                          ? users.length
                          : filteredNames.length,
                      itemBuilder: (context, index) {
                        final user = _controllerContact.text.isEmpty
                            ? users[index]
                            : filteredNames[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: ListTile(
                            trailing: GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DetailPage(
                                      user: user,
                                      imageUlr:
                                          NetworkServiceImpl.pictureUrl[index],
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: 48,
                                height: 48,
                                child: Text(
                                  '●●●',
                                  style: TextStyle(
                                    fontSize: 5,
                                  ),
                                ),
                              ),
                            ),
                            leading: CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(
                                NetworkServiceImpl.pictureUrl[
                                    users.indexOf(user) %
                                        NetworkServiceImpl.pictureUrl.length],
                              ),
                              onBackgroundImageError: (exception, stackTrace) {
                                // Handle error silently
                              },
                              child: null,
                            ),
                            title: Text(user.name),
                            subtitle: Text(user.company.name),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
