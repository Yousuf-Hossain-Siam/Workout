// // lib/features/home/widgets/home_header.dart (Ensure your HomeHeader looks like this or similar)

// import 'package:flutter/material.dart';

// class HomeHeader extends StatelessWidget {
//   final String name;
//   final String image; // This can now be a path OR a URL
//   final VoidCallback notificationTap;

//   const HomeHeader({
//     Key? key,
//     required this.name,
//     required this.image,
//     required this.notificationTap,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // Determine if the 'image' string is a network URL or a local asset path
//     bool isNetworkImage = image.startsWith('http://') || image.startsWith('https://');

//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       children: [
//         // User Profile Section
//         Row(
//           children: [
//             CircleAvatar(
//               radius: 25, // Adjust size as needed
//               backgroundColor: Colors.grey.shade200, // Placeholder background
//               // Conditionally set the background image
//               backgroundImage: isNetworkImage
//                   ? NetworkImage(image) as ImageProvider // Use NetworkImage for URLs
//                   : AssetImage(image), // Use AssetImage for local paths
//               onBackgroundImageError: isNetworkImage
//                   ? (exception, stackTrace) {
//                       debugPrint('Error loading network image: $exception');
//                       // Optional: Fallback to a local asset or icon if network image fails
//                     }
//                   : null, // No error handling needed for static assets typically
//               // You can add a child for a fallback icon if image is truly missing/error
//               child: image.isEmpty && !isNetworkImage ? const Icon(Icons.person, color: Colors.grey) : null,
//             ),
//             const SizedBox(width: 10),
//             Text(
//               'Hello, $name!', // Display the dynamic name
//               style: const TextStyle(
//                 fontSize: 20,
//                 fontWeight: FontWeight.bold,
//                 color: Colors.black, // Or your app's primary text color
//               ),
//             ),
//           ],
//         ),
//         // Notification Icon
//         GestureDetector(
//           onTap: notificationTap,
//           child: const Icon(Icons.notifications, color: Colors.black), // Or your preferred icon color
//         ),
//       ],
//     );
//   }
// }