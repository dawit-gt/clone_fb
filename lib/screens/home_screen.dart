  import 'package:flutter/material.dart';
  import '../services/api_service.dart';
  import '../services/unsplash_service.dart';
  import '../models/user_model.dart';
  import '../models/post_model.dart';
  import '../widgets/post_card.dart';
  import '../widgets/facebook_mobile_header.dart';
  import '../widgets/create_post_widget.dart';
  import '../widgets/facebook_tab_bar.dart';
import '../widgets/facebook_stories.dart';


  class HomeScreen extends StatefulWidget {
    const HomeScreen({super.key});

    @override
    State<HomeScreen> createState() => _HomeScreenState();
  }

  class _HomeScreenState extends State<HomeScreen> {
    final ScrollController _controller = ScrollController();

    List<UserModel> users = [];
    List<Widget> feed = [];
    int skip = 0;
    bool loading = false;

    @override
    void initState() {
      super.initState();
      loadInitial();
      _controller.addListener(scrollListener);
    }

    Future<void> loadInitial() async {
      users = await ApiService.fetchUsers();
      feed = [
        const CreatePostWidget(), // Add the "What's on your mind" section at the top
        const SizedBox(height: 8),
            // 🔵 STORIES
      FacebookStories(users: users.take(10).toList()),

      const SizedBox(height: 8),

      ];
      await loadMore();
    }

    void scrollListener() {
      if (_controller.position.pixels >
              _controller.position.maxScrollExtent - 400 &&
          !loading) {
        loadMore();
      }
    }

    Future<void> loadMore() async {
      loading = true;
      final posts = await ApiService.fetchPosts(skip, 5);
      skip += 5;

      for (PostModel post in posts) {
        final user = users.firstWhere(
          (u) => u.id == post.userId,
          orElse: () => users[0],
        );
        final image = await UnsplashService.getImage(post.tags);

        feed.add(PostCard(user: user, text: post.body, image: image));
      }

      setState(() {});
      loading = false;
    }

    @override
    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(110), // header + tabs height
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 1,
            automaticallyImplyLeading: false,
            flexibleSpace: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: const [
                  // 🔵 Facebook Header (logo, search, messenger)
                  FacebookMobileHeader(),

                  // 🔵 Tabs BELOW header
                  Divider(height: 1),
                  FacebookTabBar(),
                ],
              ),
            ),
          ),
        ),

        body: ListView.builder(
          controller: _controller,
          padding: const EdgeInsets.all(12),
          itemCount: feed.length,
          itemBuilder: (context, index) => feed[index],
        ),
      );
    }

  }
