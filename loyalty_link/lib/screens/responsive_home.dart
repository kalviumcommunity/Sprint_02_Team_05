import 'package:flutter/material.dart';

/// ResponsiveHome – A responsive dashboard screen for LoyaltyLink.
///
/// Demonstrates:
/// - [MediaQuery] for detecting screen width/height and orientation
/// - [LayoutBuilder] for constraint-based layout switching
/// - [Expanded], [Flexible], [Wrap], [GridView] for adaptive positioning
/// - Single-column (phone) vs two-column (tablet) layout switching
class ResponsiveHome extends StatelessWidget {
  const ResponsiveHome({super.key});

  @override
  Widget build(BuildContext context) {
    // ── MediaQuery: detect device dimensions ──
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final isTablet = screenWidth > 600;
    final isLandscape = screenWidth > screenHeight;

    // ── Dynamic sizing based on screen ──
    final titleSize = isTablet ? 28.0 : 22.0;
    final subtitleSize = isTablet ? 16.0 : 13.0;
    final cardPadding = isTablet ? 20.0 : 14.0;
    final horizontalPadding = isTablet ? 32.0 : 16.0;

    return Scaffold(
      // ──────── APP BAR (Header) ────────
      appBar: AppBar(
        title: const Text(
          'LoyaltyLink Dashboard',
          style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.0),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF6C63FF),
        foregroundColor: Colors.white,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          if (isTablet)
            IconButton(
              icon: const Icon(Icons.settings_outlined),
              onPressed: () {},
            ),
        ],
      ),

      // ──────── BODY ────────
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF6C63FF), Color(0xFF1A1A2E)],
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              // ── LayoutBuilder: decide layout based on available width ──
              if (constraints.maxWidth > 800) {
                return _buildWideLayout(
                  titleSize: titleSize,
                  subtitleSize: subtitleSize,
                  cardPadding: cardPadding,
                  horizontalPadding: horizontalPadding,
                  isLandscape: isLandscape,
                );
              } else if (constraints.maxWidth > 600) {
                return _buildMediumLayout(
                  titleSize: titleSize,
                  subtitleSize: subtitleSize,
                  cardPadding: cardPadding,
                  horizontalPadding: horizontalPadding,
                );
              } else {
                return _buildNarrowLayout(
                  titleSize: titleSize,
                  subtitleSize: subtitleSize,
                  cardPadding: cardPadding,
                  horizontalPadding: horizontalPadding,
                  isLandscape: isLandscape,
                );
              }
            },
          ),
        ),
      ),

      // ──────── FOOTER: Bottom Navigation ────────
      bottomNavigationBar: NavigationBar(
        backgroundColor: const Color(0xFF1A1A2E),
        indicatorColor: const Color(0xFF6C63FF).withValues(alpha: 0.3),
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined, color: Colors.white70),
            selectedIcon: Icon(Icons.home, color: Colors.white),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.people_outline, color: Colors.white70),
            selectedIcon: Icon(Icons.people, color: Colors.white),
            label: 'Customers',
          ),
          NavigationDestination(
            icon: Icon(Icons.card_giftcard_outlined, color: Colors.white70),
            selectedIcon: Icon(Icons.card_giftcard, color: Colors.white),
            label: 'Rewards',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline, color: Colors.white70),
            selectedIcon: Icon(Icons.person, color: Colors.white),
            label: 'Profile',
          ),
        ],
        selectedIndex: 0,
        labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      ),
    );
  }

  // ════════════════════════════════════════════════════════════════
  //  WIDE LAYOUT (> 800px) – Two-column with side panel
  // ════════════════════════════════════════════════════════════════
  Widget _buildWideLayout({
    required double titleSize,
    required double subtitleSize,
    required double cardPadding,
    required double horizontalPadding,
    required bool isLandscape,
  }) {
    return Padding(
      padding: EdgeInsets.all(horizontalPadding),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Left column: Stats + Quick Actions ──
          Expanded(
            flex: 3,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildWelcomeBanner(titleSize, subtitleSize),
                  const SizedBox(height: 20),
                  _buildStatsGrid(
                    cardPadding: cardPadding,
                    crossAxisCount: 2,
                  ),
                  const SizedBox(height: 20),
                  _buildQuickActions(cardPadding),
                ],
              ),
            ),
          ),
          const SizedBox(width: 20),
          // ── Right column: Recent Activity ──
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              child: _buildRecentActivity(cardPadding, subtitleSize),
            ),
          ),
        ],
      ),
    );
  }

  // ════════════════════════════════════════════════════════════════
  //  MEDIUM LAYOUT (600–800px) – Single column, 2-col grid
  // ════════════════════════════════════════════════════════════════
  Widget _buildMediumLayout({
    required double titleSize,
    required double subtitleSize,
    required double cardPadding,
    required double horizontalPadding,
  }) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(horizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWelcomeBanner(titleSize, subtitleSize),
          const SizedBox(height: 20),
          _buildStatsGrid(cardPadding: cardPadding, crossAxisCount: 2),
          const SizedBox(height: 20),
          _buildQuickActions(cardPadding),
          const SizedBox(height: 20),
          _buildRecentActivity(cardPadding, subtitleSize),
        ],
      ),
    );
  }

  // ════════════════════════════════════════════════════════════════
  //  NARROW LAYOUT (< 600px) – Single column, 2-col grid (phone)
  // ════════════════════════════════════════════════════════════════
  Widget _buildNarrowLayout({
    required double titleSize,
    required double subtitleSize,
    required double cardPadding,
    required double horizontalPadding,
    required bool isLandscape,
  }) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(
        horizontal: horizontalPadding,
        vertical: 12,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWelcomeBanner(titleSize, subtitleSize),
          const SizedBox(height: 16),
          _buildStatsGrid(
            cardPadding: cardPadding,
            crossAxisCount: isLandscape ? 4 : 2,
          ),
          const SizedBox(height: 16),
          _buildQuickActions(cardPadding),
          const SizedBox(height: 16),
          _buildRecentActivity(cardPadding, subtitleSize),
        ],
      ),
    );
  }

  // ════════════════════════════════════════════════════════════════
  //  SHARED WIDGET BUILDERS
  // ════════════════════════════════════════════════════════════════

  /// Welcome banner with FittedBox for responsive text scaling.
  Widget _buildWelcomeBanner(double titleSize, double subtitleSize) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF7C4DFF), Color(0xFF6C63FF)],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF6C63FF).withValues(alpha: 0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              '👋 Welcome back, Business Owner!',
              style: TextStyle(
                fontSize: titleSize,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Here\'s your loyalty program overview for today.',
            style: TextStyle(
              fontSize: subtitleSize,
              color: Colors.white.withValues(alpha: 0.85),
            ),
          ),
        ],
      ),
    );
  }

  /// Stats grid – adapts columns via [crossAxisCount] parameter.
  Widget _buildStatsGrid({
    required double cardPadding,
    required int crossAxisCount,
  }) {
    final stats = [
      _StatItem(Icons.people, 'Customers', '128', Colors.blueAccent),
      _StatItem(Icons.star, 'Points Given', '3,450', Colors.amber),
      _StatItem(Icons.card_giftcard, 'Rewards', '12', Colors.greenAccent),
      _StatItem(Icons.trending_up, 'Visits Today', '24', Colors.pinkAccent),
    ];

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        childAspectRatio: 1.4,
      ),
      itemCount: stats.length,
      itemBuilder: (context, index) {
        final stat = stats[index];
        return Container(
          padding: EdgeInsets.all(cardPadding),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: Colors.white.withValues(alpha: 0.1),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.1),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(stat.icon, color: stat.color, size: 28),
              const Spacer(),
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  stat.value,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 2),
              Flexible(
                child: Text(
                  stat.label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withValues(alpha: 0.7),
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  /// Quick actions row using [Wrap] for automatic wrapping on small screens.
  Widget _buildQuickActions(double cardPadding) {
    final actions = [
      _ActionItem(Icons.person_add, 'Add Customer'),
      _ActionItem(Icons.add_circle_outline, 'Give Points'),
      _ActionItem(Icons.redeem, 'New Reward'),
      _ActionItem(Icons.qr_code_scanner, 'Scan QR'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Quick Actions',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: actions.map((action) {
            return Container(
              width: 80,
              padding: EdgeInsets.all(cardPadding * 0.6),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Colors.white.withValues(alpha: 0.1),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(action.icon, color: Colors.white, size: 28),
                  const SizedBox(height: 6),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      action.label,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  /// Recent activity list.
  Widget _buildRecentActivity(double cardPadding, double subtitleSize) {
    final activities = [
      _ActivityItem('Ravi earned 50 points', '2 min ago', Icons.star),
      _ActivityItem('Priya redeemed "Free Coffee"', '15 min ago', Icons.redeem),
      _ActivityItem('New customer: Amit Kumar', '1 hr ago', Icons.person_add),
      _ActivityItem('Meera earned 30 points', '3 hr ago', Icons.star),
      _ActivityItem('Reward "10% Off" created', '5 hr ago', Icons.card_giftcard),
    ];

    return Container(
      padding: EdgeInsets.all(cardPadding),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: Colors.white.withValues(alpha: 0.08),
        border: Border.all(color: Colors.white.withValues(alpha: 0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Recent Activity',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 12),
          ...activities.map((activity) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFF6C63FF).withValues(alpha: 0.3),
                    ),
                    child: Icon(activity.icon, color: Colors.white, size: 18),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          activity.title,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          activity.time,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withValues(alpha: 0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
        ],
      ),
    );
  }
}

// ═══════════════ Data classes ═══════════════

class _StatItem {
  final IconData icon;
  final String label;
  final String value;
  final Color color;
  const _StatItem(this.icon, this.label, this.value, this.color);
}

class _ActionItem {
  final IconData icon;
  final String label;
  const _ActionItem(this.icon, this.label);
}

class _ActivityItem {
  final String title;
  final String time;
  final IconData icon;
  const _ActivityItem(this.title, this.time, this.icon);
}
