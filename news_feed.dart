import 'package:flutter/material.dart';

class NewsFeedPage extends StatefulWidget {
  const NewsFeedPage({super.key});

  @override
  State<NewsFeedPage> createState() => _NewsFeedPageState();
}

class _NewsFeedPageState extends State<NewsFeedPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final ScrollController _scrollController = ScrollController();
  bool _showFloatingButton = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 5, vsync: this);
    _scrollController.addListener(() {
      setState(() {
        _showFloatingButton = _scrollController.offset > 200;
      });
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: NestedScrollView(
        controller: _scrollController,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              expandedHeight: 120.0,
              floating: true,
              pinned: true,
              snap: false,
              backgroundColor: Color(0xFF4B5EFC),
              elevation: 4, // Added elevation for more professional look
              actions: [
                Padding(
                  padding: EdgeInsets.only(right: 50.0),
                  child: Transform.scale(
                    scale: 3.5,
                    child: SizedBox(
                      height: 120,
                      width: 50,
                      child: Image.asset(
                        'assets/logo.png',
                        fit: BoxFit.cover,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
              flexibleSpace: FlexibleSpaceBar(
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFF5A6CFF), // Slightly lighter shade for gradient
                            Color(0xFF4B5EFC),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              bottom: TabBar(
                controller: _tabController,
                isScrollable: true,
                indicatorColor: Colors.white,
                indicatorWeight: 3,
                labelColor: Colors.white, // Ensuring text is white
                unselectedLabelColor: Colors.white.withOpacity(0.7), // Semi-transparent white for unselected
                tabs: [
                  Tab(icon: Icon(Icons.warning_amber_rounded, color: Colors.white), text: "Alerts"),
                  Tab(icon: Icon(Icons.star_rate_rounded, color: Colors.white), text: "Reviews"),
                  Tab(icon: Icon(Icons.forum_rounded, color: Colors.white), text: "Community"),
                  Tab(icon: Icon(Icons.lightbulb_outline, color: Colors.white), text: "Advice"),
                  Tab(icon: Icon(Icons.newspaper_rounded, color: Colors.white), text: "News"),
                ],
              ),
            ),
          ];
        },
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildAlertsFeed(),
            _buildReviewsFeed(),
            _buildCommunityFeed(),
            _buildAdviceFeed(),
            _buildNewsFeed(),
          ],
        ),
      ),
      floatingActionButton: _showFloatingButton
          ? FloatingActionButton(
              backgroundColor: Color(0xFF4B5EFC),
              foregroundColor: Colors.white, // Ensuring icon is white
              elevation: 6, // Increased elevation for better visibility
              child: Icon(Icons.arrow_upward),
              onPressed: () {
                _scrollController.animateTo(
                  0,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOut,
                );
              },
            )
          : null,
    );
  }

  Widget _buildAlertsFeed() {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        _buildPriorityAlert(
          "Route 102 Delay",
          "Delays of 15-20 minutes expected due to emergency maintenance at Main St station.",
          Colors.orange[700]!,
          Icons.timer,
        ),
        _buildAlert(
          "Track Maintenance",
          "Weekend service changes on Route 205. Check alternative routes.",
          Colors.blue,
          Icons.build,
        ),
        _buildAlert(
          "Weather Advisory",
          "Potential delays on all northern routes due to expected snowfall tonight.",
          Colors.indigo,
          Icons.cloud,
        ),
      ],
    );
  }

  Widget _buildReviewsFeed() {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        _buildReviewCard(
          "Jessica M.",
          "assets/avatars/user1.png",
          "Bus 201 - Downtown Express",
          "Clean, comfortable and arrived exactly on schedule. Driver was very courteous.",
          4.8,
          Colors.green[700]!,
          "2 hours ago",
        ),
        _buildReviewCard(
          "Michael T.",
          "assets/avatars/user2.png",
          "Route 33 - Airport Shuttle",
          "Plenty of space for luggage and clear announcements for stops. Perfect for travelers.",
          4.5,
          Colors.green[700]!,
          "Yesterday",
        ),
        _buildReviewCard(
          "Sophia L.",
          "assets/avatars/user3.png",
          "Route 505 - Express",
          "Crowded during rush hour but still maintained schedule. Need more buses on this route.",
          3.5,
          Colors.orange[700]!,
          "2 days ago",
        ),
      ],
    );
  }

  Widget _buildCommunityFeed() {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        _buildDiscussionCard(
          "Best routes to avoid downtown traffic?",
          "I've been taking Route 78 but it's always stuck in traffic after 5PM. Any suggestions for alternatives?",
          "Transit Enthusiast",
          "assets/avatars/user4.png",
          15,
          8,
        ),
        _buildDiscussionCard(
          "Weekend service reliability poll",
          "For those who use transit on weekends, which lines have you found most reliable? I'm creating a community map of dependable routes.",
          "MapMaster",
          "assets/avatars/user5.png",
          42,
          23,
        ),
        _buildDiscussionCard(
          "App feature requests thread",
          "What features would you like to see added to the transit app? I'll compile suggestions and send them to the development team.",
          "App Developer",
          "assets/avatars/user6.png",
          67,
          31,
        ),
      ],
    );
  }

  Widget _buildAdviceFeed() {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        _buildAdviceCard(
          "Rush Hour Tips",
          "Try routes 82 or 96 instead of main lines during peak hours. They take slightly longer but are much less crowded.",
          Icons.access_time,
          Colors.purple[700]!,
        ),
        _buildAdviceCard(
          "Money Saving Tip",
          "Weekend passes offer unlimited rides and are 40% cheaper than buying individual tickets. Perfect for exploring the city.",
          Icons.savings,
          Colors.green[700]!,
        ),
        _buildAdviceCard(
          "Rainy Day Commute",
          "Stations at Central Square and Riverside have covered waiting areas. Plan transfers through these stations during bad weather.",
          Icons.umbrella,
          Colors.blue[700]!,
        ),
      ],
    );
  }

  Widget _buildNewsFeed() {
    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        _buildNewsCard(
          "Major Road Construction",
          "Highway 101 renovation begins next week. Expect increased transit demand on routes 55, 67, and 82.",
          "Metropolitan Transport Authority",
          "assets/icons/mta_icon.png",
          "2 hours ago",
        ),
        _buildNewsCard(
          "New Express Service",
          "Starting next month, new express buses will connect the university district with downtown, cutting travel time by 15 minutes.",
          "Transit Planning Department",
          "assets/icons/planning_icon.png",
          "Yesterday",
        ),
        _buildNewsCard(
          "Holiday Schedule Changes",
          "All transit services will operate on modified schedules during the upcoming holiday weekend. Download the updated timetables.",
          "Transit Communications",
          "assets/icons/schedule_icon.png",
          "2 days ago",
        ),
      ],
    );
  }

  Widget _buildPriorityAlert(
      String title, String content, Color color, IconData icon) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: BorderSide(color: color, width: 2.0),
      ),
      elevation: 5,
      margin: EdgeInsets.only(bottom: 16.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          gradient: LinearGradient(
            colors: [color.withOpacity(0.1), Colors.white],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(icon, color: color, size: 24),
                      SizedBox(width: 10),
                      Text(
                        "PRIORITY ALERT",
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          color: color,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      "LIVE",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Text(
                title,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              SizedBox(height: 5),
              Text(
                content,
                style: TextStyle(fontSize: 15, color: Colors.black87),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                    onPressed: () {},
                    style: OutlinedButton.styleFrom(
                      foregroundColor: color,
                      side: BorderSide(color: color),
                    ),
                    child: Text('Find Alternatives'),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: color,
                      foregroundColor: Colors.white,
                      elevation: 2, // Adding elevation for better visibility
                    ),
                    child: Text('See Details'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAlert(
      String title, String content, Color? color, IconData icon) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      elevation: 3,
      margin: EdgeInsets.only(bottom: 16.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 22),
                SizedBox(width: 10),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              content,
              style: TextStyle(fontSize: 15, color: Colors.black87),
            ),
            SizedBox(height: 10), // Added space
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {},
                  style: TextButton.styleFrom(
                    foregroundColor: color,
                  ),
                  child: Text('More Info'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildReviewCard(String username, String avatar, String serviceName,
      String reviewText, double rating, Color ratingColor, String timeAgo) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      elevation: 3,
      margin: EdgeInsets.only(bottom: 16.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundColor: Colors.grey[200],
                  backgroundImage: AssetImage(avatar),
                ),
                SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      username,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Text(
                      timeAgo,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: ratingColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.star, color: Colors.white, size: 16),
                      SizedBox(width: 4),
                      Text(
                        rating.toString(),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Text(
              serviceName,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
                color: Color(0xFF4B5EFC),
              ),
            ),
            SizedBox(height: 6),
            Text(
              reviewText,
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildReactionButton(Icons.thumb_up_outlined, "Helpful", 12, Colors.grey[700]!),
                _buildReactionButton(Icons.comment_outlined, "Comment", 3, Colors.grey[700]!),
                _buildReactionButton(Icons.share_outlined, "Share", 2, Colors.grey[700]!),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReactionButton(IconData icon, String label, int count, Color color) {
    return TextButton.icon(
      onPressed: () {},
      icon: Icon(icon, size: 16, color: color),
      label: Text(
        "$label ($count)",
        style: TextStyle(color: color, fontSize: 12),
      ),
      style: TextButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      ),
    );
  }

  Widget _buildDiscussionCard(String title, String content, String username,
      String avatar, int comments, int likes) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      elevation: 3,
      margin: EdgeInsets.only(bottom: 16.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: Colors.grey[200],
                  backgroundImage: AssetImage(avatar),
                ),
                SizedBox(width: 10),
                Text(
                  username,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                Spacer(),
                Text(
                  "3h ago",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 6),
            Text(
              content,
              style: TextStyle(fontSize: 14, color: Colors.black87),
            ),
            SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.comment, size: 16, color: Colors.grey[600]),
                SizedBox(width: 4),
                Text(
                  "$comments comments",
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
                SizedBox(width: 16),
                Icon(Icons.thumb_up, size: 16, color: Colors.grey[600]),
                SizedBox(width: 4),
                Text(
                  "$likes likes",
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            Divider(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.add_comment_outlined, size: 16, color: Colors.white),
                  label: Text("Comment", style: TextStyle(color: Colors.white)),
                  style: TextButton.styleFrom(
                    backgroundColor: Color(0xFF4B5EFC),
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.thumb_up_outlined, size: 16, color: Color(0xFF4B5EFC)),
                  label: Text("Like", style: TextStyle(color: Color(0xFF4B5EFC))),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: Color(0xFF4B5EFC), width: 1),
                    ),
                  ),
                ),
                TextButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.share_outlined, size: 16, color: Color(0xFF4B5EFC)),
                  label: Text("Share", style: TextStyle(color: Color(0xFF4B5EFC))),
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(color: Color(0xFF4B5EFC), width: 1),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAdviceCard(
      String title, String content, IconData icon, Color color) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      elevation: 3,
      margin: EdgeInsets.only(bottom: 16.0),
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                    size: 24,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        content,
                        style: TextStyle(fontSize: 14, color: Colors.black87),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.bookmark_border_outlined, size: 18),
                  label: Text("Save"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: color,
                    foregroundColor: Colors.white,
                    elevation: 2,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                ),
                SizedBox(width: 8),
                OutlinedButton.icon(
                  onPressed: () {},
                  icon: Icon(Icons.share_outlined, size: 18),
                  label: Text("Share"),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: color,
                    side: BorderSide(color: color),
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsCard(String title, String content, String source,
      String sourceIcon, String timeAgo) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      elevation: 3,
      margin: EdgeInsets.only(bottom: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 6,
            decoration: BoxDecoration(
              color: Color(0xFF4B5EFC),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.0),
                topRight: Radius.circular(12.0),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 10,
                          backgroundColor: Colors.grey[200],
                          backgroundImage: AssetImage(sourceIcon),
                        ),
                        SizedBox(width: 8),
                        Text(
                          source,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        timeAgo,
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.grey[700],
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  content,
                  style: TextStyle(fontSize: 14, color: Colors.black87),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.visibility_outlined,
                          size: 14,
                          color: Colors.grey[600],
                        ),
                        SizedBox(width: 4),
                        Text(
                          "328 views",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF4B5EFC),
                        foregroundColor: Colors.white,
                        textStyle: TextStyle(fontWeight: FontWeight.bold),
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                        elevation: 2,
                      ),
                      child: Text("Read More"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}