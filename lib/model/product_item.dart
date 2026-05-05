import 'package:collection/collection.dart'; 

class ProductItem {
  final String id;
  final String name;
  final double price;
  double numbersOfProduct;
  final String imagePath;
  final String description; // Added description for details page

  ProductItem({
    required this.id,
    required this.name,
    required this.price,
     this.numbersOfProduct=1.0,
    required this.imagePath,
    this.description = 'No description available.', // Default description
  });

  // Convert a ProductItem object to a Map object
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'numbersOfproduct':numbersOfProduct,
      'imagePath': imagePath,
      'description': description,
    };
  }

  // Create a ProductItem object from a Map object
  factory ProductItem.fromMap(Map<String, dynamic> map) {
    return ProductItem(
      id: map['id'] as String,
      name: map['name'] as String,
      price: (map['price'] as num).toDouble(),
      numbersOfProduct: (map['numbersOfProduct']as num).toDouble(),
      imagePath: map['imagePath'] as String,
      description: map['description'] as String? ?? 'No description available.',
    );
  }

  // Create a copy of the ProductItem object with optional updates
  ProductItem copyWith({
    String? id,
    String? name,
    double? price,
    String? imagePath,
    String? description,
    double? numbersOfProduct
  }) {
    return ProductItem(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      imagePath: imagePath ?? this.imagePath,
      description: description ?? this.description,
      numbersOfProduct:numbersOfProduct ?? this.numbersOfProduct,
    );
  }

}

// Example of using unmodifiable list (optional, for safety)
List<ProductItem> get sampleProducts => UnmodifiableListView<ProductItem>([
  ProductItem(
    id: '1',
    name: 'SamSung A07',
    price: 26600000, // Price in Toman
    imagePath: 'assets/A07.webp',
    description:
        'The Galaxy A07 debuts a slimmer 7.6 mm flat design for effortless handling, features an upgraded processor from 12 nm to 6 nm for faster load times and smoother multitasking, and carries an IP54 rating that repels dust and 360° water spray for added durability.',
  ),
  ProductItem(
    id: '2',
    name: 'M5 Ipad Pro 2025',
    price: 349900000,
    imagePath: 'assets/Ipad pro 2025.webp',
    description:
        'The M5 processor with significantly fast 10 core GPU with Ray Tracing and 16 core neural engine are the big changes. The M5 iPad Pro also has faster charging, improved WiFi, more RAM and storage, and Apples new 5G cellular modem.',
  ),
  ProductItem(
    id: '3',
    name: 'Iphon 12 Pro max',
    price: 15500000,
    imagePath: 'assets/iphon 12 promax.webp',
    description:
        'The Apple A14 Bionic chipset, 6GB of RAM, and 6-core processor power the smartphone. The 6.7" Super Retina XDR OLED display is high-def and supports HDR10 and Dolby Vision. Stay connected on the go with 5G LTE, GPS, dual-band Wi-Fi 6, and Bluetooth 5.0.',
  ),
  ProductItem(
    id: '4',
    name: 'Iphon 16CH',
    price: 266000000,
    imagePath: 'assets/Iphon16.webp',
    description:
        'The iPhone 16 Pro Max display has rounded corners that follow a beautiful curved design, and these corners are within a standard rectangle. When measured as a standard rectangular shape, the screen is 6.86 inches diagonally',
  ),
  ProductItem(
    id: '5',
    name: 'Iphon 17CH',
    price: 314000000,
    imagePath: 'assets/Iphon17CH.webp',
    description:
        'iPhone 17 Pro Max. The most powerful iPhone ever. Brilliant 6.9-inch display, aluminium unibody design, A19 Pro chip, all 48MP rear cameras and best-ever battery life. With all 48MP rear cameras and 8x optical-quality zoom the widest zoom range ever in an iPhone.',
  ),
  ProductItem(
    id: '6',
    name: 'MacBookair',
    price: 298950000,
    imagePath: 'assets/MacBook air.webp',
    description:
        'Apple 2025 MacBook Air 13-inch Laptop with M4 chip: Built for Apple Intelligence, 13.6-inch Liquid Retina Display, 16GB Unified Memory, 256GB SSD Storage, 12MP Center Stage Camera, Touch ID; Sky Blue. The video showcases the product in use. The video guides you through product setup.',
  ),
  ProductItem(
    id: '7',
    name: 'MacBook Pro',
    price: 385000000,
    imagePath: 'assets/MacBook pro MDE04.webp',
    description:
        'Apple 2025 MacBook Pro Laptop with Apple M5 chip with 10‑core CPU and 10‑core GPU: Built for AI, 14.2-inch Liquid Retina XDR Display, 16GB Unified Memory, 1TB SSD Storage; Space Black.',
  ),
  ProductItem(
    id: '8',
    name: 'MacBook Neo',
    price: 200000000,
    imagePath: 'assets/MacBook Neo.webp',
    description:
        'The MacBook Neo features a 13-inch Liquid Retina display with a resolution of 2408 × 1506 and has a 218 ppi pixel density. It has two USB-C ports (one USB 10Gbps port with support for DisplayPort 1.4, and one USB 2.0 port), a headphone jack, Wi-Fi 6E, and Bluetooth 6.',
  ),
  ProductItem(
    id: '9',
    name: 'S25 FE',
    price: 140000000,
    imagePath: 'assets/S25 FE.webp',
    description:
        'The Samsung S25 FE boasts power and flagship performance that competes with much pricier models, making it excellent value if you want a phone made with multitasking and gaming in mind. Powered by the Exynos 2400 processor, the S25 FE delivers impressive thermal control and a smooth and responsive experience',
  ),
  ProductItem(
    id: '10',
    name: 'S25 Ulrta',
    price: 291000000,
    imagePath: 'assets/S25 ulrta.webp',
    description:
        'The S25 Ultra has a titanium body and a glass back, similar to the S24 Ultra; however, the phone features rounded corners, unlike the S24 Ultrs squared corners. Additionally, the S25 Ultra uses Gorilla Glass Armor 2 for its front display and rear panel, improving durability and reducing glare.',
  ),
  ProductItem(
    id: '11',
    name: 'Surface 14.5 inch',
    price: 137000000,
    imagePath: 'assets/surface 14.5.webp',
    description:
        'The laptop has an i5-6300U processor with a speed of 2.30 GHz, 8 GB of RAM, and a 250 GB SSD for storage. It comes in a sleek silver color and has Wi-Fi and USB-C connectivity. The laptop runs on Windows 10 Pro and has a maximum resolution of 3000x2000.',
  ),
  ProductItem(
    id: '12',
    name: 'Surface pro  11',
    price: 330000000,
    imagePath: 'assets/surface pro 11.webp',
    description:
        'With Snapdragon X Plus, your workflows become smarter, faster, and more intuitive than ever before! -Extreme Immersive Visual Experience: The 13" PixelSense Flow display delivers breathtaking visuals with a sharp 2880 x 1920 resolution and a virtually edge-to-edge design.',
  ),
]);
