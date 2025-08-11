import 'dart:async';

import 'package:contacts_app/feature/home/data/datasources/remote/network_service.dart';
import 'package:contacts_app/feature/home/data/models/user_model.dart';
import 'package:contacts_app/feature/home/presentation/pages/detail_page.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class HomeTab extends StatefulWidget {
  final List<UserModel> users;
  final bool isLoading;
  final String? errorMessage;
  final VoidCallback onRefresh;

  const HomeTab({
    super.key,
    required this.users,
    required this.isLoading,
    required this.errorMessage,
    required this.onRefresh,
  });

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final TextEditingController _searchController = TextEditingController();
  List<UserModel> _filteredUsers = [];
  Timer? _debounceTimer;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _debounceTimer?.cancel();
    super.dispose();
  }

  void _onSearchChanged() {
    _debounceTimer?.cancel();
    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      if (mounted) {
        final query = _searchController.text.toLowerCase();
        setState(() {
          if (query.isEmpty) {
            _filteredUsers = [];
          } else {
            _filteredUsers = widget.users
                .where((user) => user.name.toLowerCase().contains(query))
                .toList();
          }
        });
      }
    });
  }

  void _onUserTap(UserModel user) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => DetailPage(
          user: user,
          imageUrl:
              NetworkServiceImpl.getProfileImage(widget.users.indexOf(user)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Add shimmer animation to the entire page when loading
    if (widget.isLoading) {
      return Scaffold(
        body: Shimmer(
          duration: const Duration(seconds: 2),
          interval: const Duration(seconds: 4),
          color: Colors.white,
          colorOpacity: 0.3,
          enabled: true,
          direction: const ShimmerDirection.fromLTRB(),
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.only(top: 60, right: 20, left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildShimmerHeaderSection(),
                  const SizedBox(height: 12),
                  _buildShimmerFavoritesSection(),
                  _buildShimmerSearchField(),
                  Expanded(
                    child: _buildShimmerContactsList(),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () async => widget.onRefresh(),
        child: Padding(
          padding: const EdgeInsets.only(top: 60, right: 20, left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (widget.errorMessage != null)
                _buildErrorWidget()
              else if (widget.users.isNotEmpty)
                _buildHeaderSection(),
              const SizedBox(height: 12),
              _buildFavoritesSection(),
              _buildSearchField(),
              Expanded(
                child: _buildContactsList(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// --- Error widget ---
  Widget _buildErrorWidget() {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Error: ${widget.errorMessage}'),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: widget.onRefresh,
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  /// --- Header section ---
  Widget _buildHeaderSection() {
    return Row(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(NetworkServiceImpl.getProfileImage(0)),
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.users.first.name,
              style: const TextStyle(fontSize: 20),
            ),
            Text(
              "${widget.users.length} Contacts",
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
          ],
        ),
        const Spacer(),
        Container(
          alignment: Alignment.center,
          height: 40,
          width: 40,
          decoration: BoxDecoration(
            color: Colors.grey.shade300,
            shape: BoxShape.circle,
          ),
          child: const Text(
            '!',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildShimmerHeaderSection() {
    return Row(
      children: [
        Shimmer(
          duration: const Duration(seconds: 2),
          color: Colors.white,
          colorOpacity: 0.3,
          enabled: true,
          direction: const ShimmerDirection.fromLTRB(),
          child: Container(
            width: 60,
            height: 60,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Shimmer(
              duration: const Duration(seconds: 2),
              color: Colors.white,
              colorOpacity: 0.3,
              enabled: true,
              direction: const ShimmerDirection.fromLTRB(),
              child: Container(width: 120, height: 20, color: Colors.white),
            ),
            const SizedBox(height: 8),
            Shimmer(
              duration: const Duration(seconds: 2),
              color: Colors.white,
              colorOpacity: 0.3,
              enabled: true,
              direction: const ShimmerDirection.fromLTRB(),
              child: Container(width: 80, height: 14, color: Colors.white),
            ),
          ],
        ),
        const Spacer(),
        Shimmer(
          duration: const Duration(seconds: 2),
          color: Colors.white,
          colorOpacity: 0.3,
          enabled: true,
          direction: const ShimmerDirection.fromLTRB(),
          child: Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
            ),
          ),
        ),
      ],
    );
  }

  /// --- Favorites section ---
  Widget _buildFavoritesSection() {
    if (widget.users.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Favorite",
          style: TextStyle(fontSize: 22),
        ),
        SizedBox(
          height: 100,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: widget.users.length > 5 ? 5 : widget.users.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: CircleAvatar(
                  radius: 30,
                  backgroundImage: NetworkImage(
                    NetworkServiceImpl.getProfileImage(index),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildShimmerFavoritesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Shimmer(
          duration: const Duration(seconds: 2),
          color: Colors.white,
          colorOpacity: 0.3,
          enabled: true,
          direction: const ShimmerDirection.fromLTRB(),
          child: Container(
            width: 80,
            height: 22,
            color: Colors.white,
            margin: const EdgeInsets.only(bottom: 8),
          ),
        ),
        SizedBox(
          height: 100,
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: Shimmer(
                  duration: const Duration(seconds: 2),
                  color: Colors.white,
                  colorOpacity: 0.3,
                  enabled: true,
                  direction: const ShimmerDirection.fromLTRB(),
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  /// --- Search field ---
  Widget _buildSearchField() {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: 'Search',
        prefixIcon: const Icon(Icons.search, color: Colors.grey),
        filled: true,
        fillColor: Colors.grey.shade100,
        contentPadding:
            const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        border: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(13)),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  Widget _buildShimmerSearchField() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Shimmer(
        duration: const Duration(seconds: 2),
        color: Colors.white,
        colorOpacity: 0.3,
        enabled: true,
        direction: const ShimmerDirection.fromLTRB(),
        child: Container(
          height: 44,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(13),
          ),
        ),
      ),
    );
  }

  /// --- Contacts list ---
  Widget _buildContactsList() {
    if (_searchController.text.isNotEmpty && _filteredUsers.isEmpty) {
      return _buildNoResultsFound();
    }

    final usersToShow =
        _searchController.text.isEmpty ? widget.users : _filteredUsers;

    if (usersToShow.isEmpty) {
      return const Center(
        child: Text('No contacts available'),
      );
    }

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: usersToShow.length,
      itemBuilder: (context, index) {
        final user = usersToShow[index];
        return _buildContactListItem(user, index);
      },
    );
  }

  Widget _buildShimmerContactsList() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: 8,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Shimmer(
            duration: const Duration(seconds: 2),
            color: Colors.white,
            colorOpacity: 0.3,
            enabled: true,
            direction: const ShimmerDirection.fromLTRB(),
            child: ListTile(
              leading: Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
              title: Container(
                width: double.infinity,
                height: 16,
                color: Colors.white,
                margin: const EdgeInsets.only(bottom: 8),
              ),
              subtitle: Container(
                width: 120,
                height: 12,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNoResultsFound() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.search_off, size: 64, color: Colors.grey),
          SizedBox(height: 16),
          Text(
            'No contacts found',
            style: TextStyle(fontSize: 18, color: Colors.grey),
          ),
          SizedBox(height: 8),
          Text(
            'Try searching with a different name',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildContactListItem(UserModel user, int index) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: ListTile(
        trailing: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => _onUserTap(user),
          child: Container(
            alignment: Alignment.center,
            width: 48,
            height: 48,
            child: const Icon(Icons.more_vert, size: 20),
          ),
        ),
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(
            NetworkServiceImpl.getProfileImage(widget.users.indexOf(user)),
          ),
        ),
        title: Text(user.name),
        subtitle: Text(user.company.name),
      ),
    );
  }
}
