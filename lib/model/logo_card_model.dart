class LogoDataModel {
  String name;
  String isFavorite;
  String skills;
  String imageUrl;
  String title;
  String heading;
  String description;
  String price1;
  String price2;
  String price3;
  String? price;
  String plan;
  String planDescription;
  String? rating;
  String? reviews;

  LogoDataModel({
    required this.name,
    required this.isFavorite,
    required this.skills,
    required this.imageUrl,
    required this.title,
    required this.heading,
    required this.description,
    required this.price,
    required this.price1,
    required this.price2,
    required this.price3,
    required this.plan,
    required this.planDescription,
    required this.rating,
    required this.reviews,
  });
}

List<LogoDataModel> tempData = [
  LogoDataModel(
      name: "Sai",
      isFavorite: "false",
      skills: "Fultter, Dart",
      imageUrl: "assets/image1.jpg",
      title: 'Web App UI/UX',
      heading:
          'Develop your web application with nextjs reacts mongodb firebase typescript',
      description: '''Hello,
I'm Adnan Abbas a Full Stack Developer having 3 years of experience working with modern technologies like ReactS, Redux, NextS, Typescript, Nodes, MongoDb, Firebase, Prismic and all other related technologies.''',
      price: "₹ 2500",
      price1: "₹ 2500",
      price2: "₹ 3500",
      price3: "₹ 4500",
      plan: 'Platinum Plan for Web App Ui/Ux',
      planDescription:
          '''2-3 Pages Bug-Free Modern website with Responsive design, Premium Themes, Elegant & Unique Design.''',
      rating: "4.5",
      reviews: "345"),
  LogoDataModel(
      name: "Saidutt",
      isFavorite: "false",
      skills: "Fultter, Dart",
      imageUrl: "assets/image3.jpg",
      title: 'Mobile App UI/UX',
      heading:
          'Do mobile app development ios android app development, app creation, flutter app',
      description:
          '''Looking for a reliable team to handle your mobile app development? Welcome to Value Coders, where we deliver cutting-edge Android and iOS apps using Flutter, ensuring high performance and an outstanding user experience.
// Our team specializes in crafting custom mobile solutions tailored to your specific needs. Whether you're launching a new app or enhancing an existing one, we provide end-to-end services that cover everything from the initial design to final deployment.''',
      price: "₹ 2500",
      price1: "₹ 2500",
      price2: "₹ 3500",
      price3: "₹ 4500",
      plan: 'Platinum Plan for Mobile App Ui/Ux',
      planDescription:
          '''2-3 Pages Bug-Free Modern website with Responsive design, Premium Themes, Elegant & Unique Design.''',
      rating: "4.5",
      reviews: "345"),
];

List<LogoDataModel> logoData = [];

//   {
//     "name": "Sai",
//     "isFavorite": "false",
//     "skills": "vd",
//     'imageUrl': 'assets/image1.jpg',
//     'title': 'Web App UI/UX',
//     'heading':
//         'Develop your web application with nextjs reacts mongodb firebase typescript',
//     'description': '''Hello,
// I'm Adnan Abbas a Full Stack Developer having 3 years of experience working with modern technologies like ReactS, Redux, NextS, Typescript, Nodes, MongoDb, Firebase, Prismic and all other related technologies.''',
//     'rating': "33",
//     'reviews': "33",
//     'price1': "₹ 2500",
//     'price2': "₹ 3000",
//     'price3': "₹ 4000",
//     'plan': 'Platinum Plan for Web App Ui/Ux',
//     'planDescription':
//         '''2-3 Pages Bug-Free Modern website with Responsive design, Premium Themes, Elegant & Unique Design.'''
//   },
//   {
//     'imageUrl': 'assets/image2.jpg',
//     "isFavorite": "false",
//     "skills": "vd",
//     'title': 'Mobile App UI/UX',
//     'heading':
//         'Do mobile app development ios android app development, app creation, flutter app',
//     'description':
//         '''Looking for a reliable team to handle your mobile app development? Welcome to Value Coders, where we deliver cutting-edge Android and iOS apps using Flutter, ensuring high performance and an outstanding user experience.
// Our team specializes in crafting custom mobile solutions tailored to your specific needs. Whether you're launching a new app or enhancing an existing one, we provide end-to-end services that cover everything from the initial design to final deployment.''',
//     'rating': "4.7",
//     'reviews': "20.0",
//     'price1': "₹ 2500",
//     'price2': "₹ 3000",
//     'price3': "₹ 4000",
//     'price': 30.0,
//     'plan': 'Gold Plan for Mobile App Ui/Ux',
//     'planDescription':
//         '''2-3 Pages Bug-Free Modern website with Responsive design, Premium Themes, Elegant & Unique Design.'''
//   },
//   {
//     'imageUrl': 'assets/image3.jpg',
//     "isFavorite": "false",
//     'title': 'E-commerce Platform UI/UX',
//     'heading': 'Build your professional dropshipping shopify store',
//     'description': '''Certified Shopify Dropshipping Expert
// Are you looking to create yourself a new source of income, quit your job or better yet GROW YOUR ONLINE EMPIRE!?
// Shopify Dropshipping has allowed me to work from anywhere in the world and provide more than I could have ever imagined for my family. Nothing is stopping you from doing the same!''',
//     'rating': "4.9",
//     'reviews': "40.0",
//     'price1': "₹ 2500",
//     'price2': "₹ 3000",
//     'price': 30.0,
//     'price3': "₹ 4000",
//     'plan': 'Bronze Plan for E-commerce Platform Ui/Ux',
//     'planDescription':
//         '''Responsive Layout design + 4 pages + payment gateway + 7 Products + 2 Categories'''
//   },
//   {
//     'imageUrl': 'assets/image4.jpg',
//     "isFavorite": "false",
//     'title': 'Landing Page UI/UX',
//     'heading':
//         'Design modern wordpress landing page elementor and elementor pro landing page',
//     'description':
//         '''If you are looking for elementor landing page Design or modern wordpress landing page Expert!
// Luckily I am the right choice for you!
// Hi, I am wordpress, ecommerce & wordpress landing page elementor expert.I build Elegent looking responsive modern wordpress landing page. I have huge experience of elementor landing page design. I re-build wordpress landing page elementor or elementor landing page from scratches like your drawing, PSD, or Demos.''',
//     'rating': " 4.6",
//     'reviews': "18.0",
//     'price1': "₹ 2500",
//     'price2': "₹ 3000",
//     'price3': "₹ 4000",
//     'price': 30.0,
//     'plan': 'Silver Plan fo rLanding Page Ui/Ux',
//     'planDescription': '''Basic+
// Custom Design > Up to 8 sections
// •Product launching > Mailchimp integ > Chatbot'''
//   },
//   {
//     'imageUrl': 'assets/image5.jpg',
//     "isFavorite": "false",
//     'title': 'Dashboard UI/UX',
//     'heading':
//         'Do figma website design, figma design website, website ui ux or dashboard design',
//     'description':
//         '''Are you in need of an expert Ul/UX designer for website ui ux design, Figma website design, dashboard design or SaaS landing page?
// You're at the right place!
// At Nextul, we are a dedicated team of website ui ux designers with over three years of experience in creating aesthetically pleasing, clean, balanced, and modern minimal layouts for digital products and services that enhance people's lives.''',
//     'rating': " 4.9",
//     'reviews': "45.0",
//     'price': 30.0,
//     'price1': "₹ 2500",
//     'price2': "₹ 3000",
//     'price3': "₹ 4000",
//     'plan': 'Silver Plan fo rLanding Page Ui/Ux',
//     'planDescription':
//         '''Custom Figma website design (up to 5 pages) | Figma source | Knock to discuss for Dashboard'''
//   },
//   {
//     'imageUrl': 'assets/image6.jpg',
//     "isFavorite": "false",
//     'title': 'Animated Logo Design',
//     'heading': 'Create 3d after effects animated logo intro video',
//     'description':
//         '''Ignite your brand's visual presence with over 5 years of expertise in the dynamic realms of motion design and video editing. Specializing in transforming static identities into captivating visual stories, my focus revolves around animated branding experiences.
// Dive into a world where your logo comes alive through unique video expressions, immersive 3D animations, and impactful intros. Steering clear of character animation, 3D modeling, and rigging, l channel all my energy into crafting distinctive visual narratives that elevate your brand identity.''',
//     'rating': "4.5",
//     'reviews': "15.0",
//     'price': 30.0,
//     'price1': "₹ 2500",
//     'price2': "₹ 3000",
//     'price3': "₹ 4000",
//     'plan': 'Gold Plan for Animated Logo Design',
//     'planDescription':
//         '''Simple 3D logo animation from my templates collection (for custom work contact me first)'''
//   },
