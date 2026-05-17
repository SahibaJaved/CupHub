// Menu — `image` paths tumhare `assets/` folder ki **asli file names** se match karte hain.
//
// Coffees: cappuccino.png, mocha.webp, americano.webp, expresso.jpg, latte.png,
//   coffee_flat_white.jpeg, coffee_hazelnut_latte.jpeg, coffee_cold_brew.jpeg
//
// Desserts: lava_cake.webp, cheesecake image.webp, tiramisu.webp, brownie_image.webp,
//   dessert_lemon_tart.webp, dessert_creme_brulee.webp, dessert_opera_cake.webp,
//   dessert_red_velvet.jpg

final List<Map<String, dynamic>> kCoffeeCatalog = [
  {
    'name': 'Cappuccino',
    'price': 'Rs. 420',
    'image': 'assets/cappuccino.png',
    'description':
        'The gold standard of Italian coffee culture. A precise harmony of intense espresso and velvety steamed milk, topped with a dense, cloud-like layer of froth. Finished with a light dusting of cocoa for a timeless morning ritual.',
    'basePrice': 420,
    'mediumAdd': 90,
    'largeAdd': 170,
    'extraShot': false,
  },
  {
    'name': 'Mocha',
    'price': 'Rs. 560',
    'image': 'assets/mocha.webp',
    'description':
        'An indulgent escape in a cup. We blend our signature espresso with rich, melted chocolate and silky micro-foam. It’s a luxurious, bittersweet symphony that feels more like a liquid dessert than a drink.',
    'basePrice': 560,
    'mediumAdd': 60,
    'largeAdd': 110,
    'extraShot': false,
  },
  {
    'name': 'Americano',
    'price': 'Rs. 380',
    'image': 'assets/americano.webp',
    'description':
        'Pure, bold, and unadulterated. By gently lengthening a double shot of espresso with hot artisanal water, we preserve the coffee\'s complex aromatic oils while delivering a smooth, easy-drinking finish.',
    'basePrice': 380,
    'mediumAdd': 55,
    'largeAdd': 105,
    'extraShot': false,
  },
  {
    'name': 'Espresso',
    'price': 'Rs. 290',
    'image': 'assets/expresso.jpg',
    'description':
        'The soul of our craft. A short, powerful extraction with a thick, honey-colored crema. It’s an intense burst of flavor designed for the true coffee purist who appreciates depth and character.',
    'basePrice': 290,
    'mediumAdd': 50,
    'largeAdd': 100,
    'extraShot': true,
    'extraShotPrice': 75,
  },
  {
    'name': 'Latte',
    'price': 'Rs. 460',
    'image': 'assets/latte.png',
    'description':
        'The ultimate comfort drink. Soft, mellow espresso is folded into a long pour of creamy steamed milk, creating a gentle, milky profile with just a whisper of foam. Perfect for those who love a smooth, lingering finish.',
    'basePrice': 460,
    'mediumAdd': 95,
    'largeAdd': 185,
    'extraShot': false,
  },
  {
    'name': 'Flat White',
    'price': 'Rs. 440',
    'image': 'assets/coffee_flat_white.jpeg',
    'description':
        'For the coffee lover who wants more punch than a latte. We use a double ristretto shot for a more concentrated flavor, combined with a thin, glassy layer of micro-foam that creates a heavy, velvety mouthfeel.',
    'basePrice': 440,
    'mediumAdd': 85,
    'largeAdd': 165,
    'extraShot': false,
  },
  {
    'name': 'Hazelnut Latte',
    'price': 'Rs. 510',
    'image': 'assets/coffee_hazelnut_latte.jpeg',
    'description':
        'A nostalgic classic with a nutty twist. Our creamy latte is infused with the warm, toasted notes of roasted hazelnuts, creating a fragrant and balanced sweetness that lingers beautifully on the palate.',
    'basePrice': 510,
    'mediumAdd': 90,
    'largeAdd': 175,
    'extraShot': false,
  },
  {
    'name': 'Cold Brew',
    'price': 'Rs. 395',
    'image': 'assets/coffee_cold_brew.jpeg',
    'description':
        'Patience in a glass. Steaped in cold, filtered water for 18 hours, this process eliminates acidity and bitterness, leaving behind a naturally sweet, chocolatey, and incredibly refreshing caffeine kick.',
    'basePrice': 395,
    'mediumAdd': 70,
    'largeAdd': 130,
    'extraShot': false,
  },
];

final List<Map<String, dynamic>> kDessertCatalog = [
  {
    'name': 'Lava Cake',
    'price': 520,
    'image': 'assets/lava_cake.webp',
    'description':
        'A decadent dark chocolate exterior that yields to a molten, gooey center. Served warm to ensure every spoonful is a rich, flowing experience of pure cocoa bliss.',
    'rating': '4.8',
  },
  {
    'name': 'Cheesecake',
    'price': 640,
    'image': 'assets/cheesecake image.webp',
    'description':
        'A masterpiece of texture. Our New York-style cheesecake is dense yet creamy, sitting atop a signature buttery graham cracker crust with a hint of citrus zest to balance the richness.',
    'rating': '4.7',
  },
  {
    'name': 'Tiramisu',
    'price': 720,
    'image': 'assets/tiramisu.webp',
    'description':
        'An elegant Italian classic. Light-as-air mascarpone cream layered with espresso-soaked ladyfingers and finished with a heavy veil of premium cocoa powder. A sophisticated pick-me-up.',
    'rating': '4.9',
  },
  {
    'name': 'Brownie',
    'price': 340,
    'image': 'assets/brownie_image.webp',
    'description':
        'The ultimate chocolate fix. Deeply fudgy and intensely dark, with a characteristic crackly top and a chewy, dense core. Best enjoyed slightly warmed to unlock its full aroma.',
    'rating': '4.5',
  },
  {
    'name': 'Lemon Tart',
    'price': 480,
    'image': 'assets/dessert_lemon_tart.webp',
    'description':
        'A vibrant burst of sunshine. Zesty, sharp lemon curd sits inside a crisp, buttery shortcrust shell, topped with a torched meringue peak for the perfect balance of sweet and tart.',
    'rating': '4.6',
  },
  {
    'name': 'Crème Brûlée',
    'price': 590,
    'image': 'assets/dessert_creme_brulee.webp',
    'description':
        'The art of contrast. Beneath a brittle, glass-like layer of caramelized sugar lies a silky-smooth vanilla bean custard. A simple, luxurious sensory delight.',
    'rating': '4.8',
  },
  {
    'name': 'Opera Cake',
    'price': 680,
    'image': 'assets/dessert_opera_cake.webp',
    'description':
        'A layered French architectural marvel. Alternating tiers of almond sponge, coffee-infused buttercream, and glossy chocolate ganache. It is intense, elegant, and unmistakably premium.',
    'rating': '4.9',
  },
  {
    'name': 'Red Velvet Slice',
    'price': 450,
    'image': 'assets/dessert_red_velvet.jpg',
    'description':
        'Stunningly scarlet and impossibly soft. Layers of cocoa-infused velvet sponge paired with a tangy, whipped cream cheese frosting for a classic flavor profile that is as beautiful as it is delicious.',
    'rating': '4.7',
  },
];
