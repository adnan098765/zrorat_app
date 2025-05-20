import 'package:flutter/material.dart';
import '../AppColors/app_colors.dart';

class OrderTrackingScreen extends StatelessWidget {
  final String orderId;

  const OrderTrackingScreen({
    super.key,
    required this.orderId,
  });

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Track Order"),
        backgroundColor: AppColors.appColor,
        foregroundColor: AppColors.whiteTheme,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildOrderHeader(orderId),
              const SizedBox(height: 30),
              _buildTrackingTimeline(context),
              const SizedBox(height: 30),
              _buildEstimatedDelivery(),
              const SizedBox(height: 30),
              _buildContactSupport(context, width, height),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderHeader(String orderId) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Order ID",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              Text(
                "#$orderId",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Order Date",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              Text(
                _getFormattedDate(),
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Status",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              ),
              Text(
                "In Progress",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTrackingTimeline(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Order Progress",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          height: 120,
          child: Row(
            children: [
              _buildTimelineColumn(
                icon: Icons.attach_money,
                title: "Payment",
                subtitle: "Completed",
                isCompleted: true,
                isFirst: true,
              ),
              _buildTimelineDivider(isCompleted: true),
              _buildTimelineColumn(
                icon: Icons.check_circle,
                title: "Confirmed",
                subtitle: "Order Accepted",
                isCompleted: true,
              ),
              _buildTimelineDivider(isCompleted: false),
              _buildTimelineColumn(
                icon: Icons.local_shipping,
                title: "Processing",
                subtitle: "In Progress",
                isCompleted: false,
              ),
              _buildTimelineDivider(isCompleted: false),
              _buildTimelineColumn(
                icon: Icons.celebration,
                title: "Completed",
                subtitle: "Not started",
                isCompleted: false,
                isLast: true,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTimelineColumn({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool isCompleted,
    bool isFirst = false,
    bool isLast = false,
  }) {
    return Expanded(
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isCompleted ? AppColors.appColor : Colors.grey.shade300,
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: 22,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            title,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: isCompleted ? Colors.black : Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: 12,
              color: isCompleted ? AppColors.appColor : Colors.grey,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildTimelineDivider({required bool isCompleted}) {
    return Container(
      width: 30,
      height: 2,
      color: isCompleted ? AppColors.appColor : Colors.grey.shade300,
      margin: const EdgeInsets.only(top: 20),
    );
  }

  Widget _buildEstimatedDelivery() {
    // Calculate estimated delivery date (today + 3 days)
    final today = DateTime.now();
    final estimatedDate = today.add(const Duration(days: 3));

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.access_time, color: Colors.green),
              SizedBox(width: 8),
              Text(
                "Estimated Completion",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            "${estimatedDate.day} ${_getMonthName(estimatedDate.month)}, ${estimatedDate.year}",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Your order is in progress and will be completed within 3 days",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactSupport(BuildContext context, double width, double height) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Need Help?",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            "Contact our customer support team if you have any questions about your order.",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {
              // Add contact support functionality
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Connecting to support..."),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.appColor,
              minimumSize: Size(width, height * 0.06),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            icon: const Icon(Icons.support_agent, color: Colors.white),
            label: const Text(
              "Contact Support",
              style: TextStyle(
                fontSize: 16,
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getFormattedDate() {
    final now = DateTime.now();
    return "${now.day} ${_getMonthName(now.month)}, ${now.year}";
  }

  String _getMonthName(int month) {
    const months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return months[month - 1];
  }
}