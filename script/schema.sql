DROP TABLE IF EXISTS users;
DROP TABLE IF EXISTS products;
DROP TABLE IF EXISTS cart_items;
DROP TABLE IF EXISTS cart;

CREATE TABLE users (
  id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  username TEXT NOT NULL UNIQUE,
  password TEXT NOT NULL,
  email TEXT NOT NULL UNIQUE,
  firstname TEXT NOT NULL,
  lastname TEXT NOT NULL,
  is_admin INT NOT NULL CHECK(is_admin >= 0 and is_admin <= 1)
);

CREATE TABLE products (
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  name TEXT NOT NULL, 
  description TEXT NOT NULL,
  price INT NOT NULL,
  stock INT NOT NULL,
  image_url TEXT NOT NULL
);


CREATE TABLE cart(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  user_id INTEGER NOT NULL,
  order_complete INT NOT NULL,
  FOREIGN KEY (user_id) REFERENCES users(id),
  CHECK(order_complete >= 0 and order_complete <= 1)
);

CREATE TABLE cart_items(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  cart_id INTEGER NOT NULL,
  product_id INTEGER NOT NULL,
  price_at_purchase INTEGER NOT NULL,
  quantity INTEGER NOT NULL,
  FOREIGN KEY (cart_id) REFERENCES cart(id)
  FOREIGN KEY (product_id) REFERENCES products(id)
);

INSERT INTO 
	users(username, password, email, firstname, lastname, is_admin)
VALUES
	('admin', 'password', 'admin@petazon.com', 'Tim', 'Janssen', 1);

INSERT INTO 
  products(name, description, price, stock, image_url)
VALUES
    (
      "Victor Super Premium Dog Food (40 lbs)", "One of our top selling formulas, VICTOR Hi-Pro Plus is a nutrient-dense, multi-meat formula packed with high levels of quality protein to support the nutritional needs of growing puppies, pregnant and lactating females, and high-performing dogs. With scientifically advanced and nutritionally complete ingredients, this formula promotes sustained energy and healthy immune and digestive systems.", 5399, 100, "https://m.media-amazon.com/images/I/81QKEvc49KL._AC_SS450_.jpg"
    ),
    (
      "Purina Pro Plan Large/Giant breed (34 lbs)", "We know dogs 50 lbs and over can benefit from specialized nutrition to support their unique needs--from puppy to adult to senior. So we have an entire line of Pro Plan Large Breed and Giant Breed formulas. Each formula has specific nutrients for joint health, and a protein to fat ratio that supports an ideal body condition. Plus all of our great-tasting dry formulas are fortified with live probiotics for digestive and immune health.", 5248, 100, "https://assets.petco.com/petco/image/upload/f_auto,q_auto/2986205-center-1"
    ),
    (
      "Milk-Bone Dog Treats", "Contains (1) 10 Pound box of Dog Treats for dogs over 50 Pounds. Wholesome and tasty dog treats — now with even MORE meaty taste compared to the Milk-Bone Original biscuits you know and love", 1248, 100, "https://m.media-amazon.com/images/I/81mh79Yip6S._AC_SL1500_.jpg"
    ),
    (
      "Purina Fancy Feast Natural Wet Cat Food Variety Pack", "Thirty (30) 3 ounces Cans - Purina Fancy Feast Gourmet Naturals Poultry & Beef Adult Wet Cat Food Variety Pack. Natural ingredients with added vitamins, minerals and nutrients", 3699, 100, "https://m.media-amazon.com/images/I/91rQQnUhzLL._AC_SL1500_.jpg"
    ),
    (
      "Cat Toy Laser Pointer", "Rich Patterns: Adjust the pointer of the funny cat toy to the red light state, you can easily switch gears to get five different patterns. Funny indoor cat toys can print the red dots、butterfly、smiley、star. Multiple pattern changes inspire pets' interest, so your cat will never be bored. Easy to Carry: Kitten toy, similar to the size of a pen, with a solid stainless steel shell with a pen clip. It can be easily put into a pocket and used anytime, anywhere.", 1199, 100, "https://m.media-amazon.com/images/I/61GB-PScR6L._AC_SL1500_.jpg"
    ),
    (
      "Cat Toy Rotating Butterfly", "Cat toys box comes with 1 track toy, 1 automatic cat toys, 1 rolling balls, 2 butterfly toys, designed with an unique UFO shape for all indoor cats, a flying butterfly wand on surface, featuring chase balls inside.", 2199, 100, "https://m.media-amazon.com/images/I/71MzGP3vfVL._AC_SL1500_.jpg"
    ),
    (
      "Tough Dog Chew Toy", "Chewing is Instinctive needs for dogs, dogs love to chew, durable chew toys designed for extreme chewers, and all chewing habits. Dog Chew Toy like a wood stick for a paw-friendly grip so your love can quickly grab it and get a good chew going. Think about it: dogs don't have thumbs. Durable dog toys for aggressive chewers weigh between 15lbs to 90lbs to satisfy their chewing needs.", 1485, 100, "https://m.media-amazon.com/images/I/71Mt--QzT0S._AC_SL1500_.jpg"
    ),
    (
      "Wild Harvest Bird Seed", "FOR SMALL BIRDS: This nutrient-rich universal blend food is ideal for canaries, parakeets, finches and other small birds.", 322, 100, "https://m.media-amazon.com/images/I/817CK5y6pyL._AC_SL1500_.jpg"
    ),
    (
      "8 Pack Bird Toy Set", "What you get :Package include 8 pieces difference type bird entertaining toys to meet your various needs for bird parrots,perfect size for parrotlets, parakeets, cockatiels, lovebirds and etc.", 1399, 100, "https://m.media-amazon.com/images/I/51yHVxAZCoL._AC_.jpg" 
    ),
    (
      "Puppy Pee Pads", "Thickened wee wee pads for dogs and 6-layer protection design makes our dog pee pee pads more absorbent than the most puppy potty pads on the market.", 2499, 100, "https://m.media-amazon.com/images/I/718JS-vaRHS._AC_SL1500_.jpg"
    ),
    (
      "Aqueon Tropical Flakes", "Natural ingredients and colors with added vitamins, minerals and trace nutrients", 599, 100, "https://m.media-amazon.com/images/I/8188zyUuHiL._AC_SL1500_.jpg"
    ),
    (
      "3 Aquarium Kit", "AQUARIUM KIT: Half-moon shape allows 180-degree panoramic viewing starter kit has everything you need.  Bubbling disc automatically cycles through a rainbow of LED light colors. Includes air pump-driven Tetra Whisper Internal Power Filter to keep your tank clean and provide a healthy environment for a pet fish.", 3999, 100, "https://m.media-amazon.com/images/I/910PTntnXRL._AC_SL1500_.jpg"
    ),
    (
      "Baby Turtle Nutri Stick", "A blend of wild sword prawns & akiami paste shrimp, and vegetables + seaweed. A perfect 6:4 meat/vegetable protein ratio.", 699, 100, "https://m.media-amazon.com/images/I/91z9dwL8VeL._AC_SL1500_.jpg"
    ),
    (
      "Wild Harvest Hamster Food", "Advanced Nutrition Diets In Flip Top Container. More Convenient Than Screw Top Containers. Unique mix of ingredients create an irresistible blend to replicate diets found in a natural habitat and encourage foraging behaviors.", 1049, 100, "https://m.media-amazon.com/images/I/81XfrWjPtmL._AC_SL1500_.jpg"
    ),
    (
      "Dog Toy Soccer Ball", "Complying with the exact same standard as children's toys, the dog ball is made of premium PU that is the matiral of standard soccer ball so that it can be kicked and bounces as well. Note, our dog soccer medium balls is suitable for 20-40lbs dogs, HEAVY DOG PET needs to choose our Large one(Large size, fits 30-90lbs).", 1599, 100, "https://m.media-amazon.com/images/I/61fXR7NzobL._AC_SL1080_.jpg"
    ),
    (
      "Doggoz Dog Bandanas", "4 set dog bandana made with 100% fresh cotton to style your dog and have him feeling great with a fancy new look.", 1499, 100, "https://m.media-amazon.com/images/I/81Y21TxpeoL._AC_SL1500_.jpg"
    ),
    (
      "Quiet Spinner Hamster Wheel", "Super Silent 10-Inch Hamster Wheel - Niteangel Silent Spinner Hamster wheel designed with Dual Ball bearings, it brings your little hamster endless running happiness, also brings you a quiet night even if your hamster on the race track to run & hamster wheel is spinning.", 3199, 100, "https://m.media-amazon.com/images/I/61xCfgl2ZDL._AC_SL1500_.jpg"
    ),
    (
      "Kaytee Supreme Rabbit Food 5lb", "Natural seeds and grains. Kaytee is a Veterinarian Recommended Brand. No artificial colors or flavors. High quality ingredients. Naturally preserved for ideal freshness. Specially formulated for rabbits", 682, 100, "https://m.media-amazon.com/images/I/81uPSErFkJL._AC_SL1500_.jpg"
    ),
    (
      "Canple Pet Bowl Set", " Set of 2 dog Bowls, 12 oz (350ml) each, provides a full dinner set one for food one for water, designed for puppy small dogs and cats.", 2098, 100, "https://m.media-amazon.com/images/I/61acVvqJbZS._AC_SL1500_.jpg"
    ),
    (
      "Cat Tunnel", "Made of cloth material, which is friendly to your pets. soft durable. A vent design so that cats can freely get in and out of the tunnel. Sound paper design, which makes sounds interesting and attracts cats' attention. Fun toy for cats to play, gives your kitty more ways to have fun, provides hours of exercise ,self-amusement and hiding away.", 2598, 100, "https://m.media-amazon.com/images/I/514IUlr-qaL._AC_SL1500_.jpg"
    ),
    (
      "Dog Chewy Toy", "This kind of dog squeaky dog toys is more attractive to dogs, can be made funny sounds and more exciting when they chewing. It stimulates the dog's hunting instinct and allows the dog to release energy. Increased interaction between dog and owner.", 1899, 100, "https://m.media-amazon.com/images/I/71c-Btl1whS._AC_SL1500_.jpg"
    ),
    (
      "Large Dog Bed", "Large dog bed with quality pp fiber, non-toxic and eco-friendly. Soft coral fleece soft and comfortable, soft filling offers joint and muscle pain relief, different from others.", 3599, 100, "https://m.media-amazon.com/images/I/71mEw80g8xL._AC_SL1500_.jpg"
    ),
    (
      "Cat Tree Tower Condo", "The multi-level cat tree is composed of good quality 0.5in particle board with 400g skin-friendly plush covering, reinforced posts are wrapped with natural sisal rope for cats to scratch and sharpen their claws without damaging your own furniture.", 5999, 100, "https://m.media-amazon.com/images/I/81vnkRKZOzL._AC_SL1500_.jpg"
    ),
    (
      "Reptile Heat Lamp", "UV lamps can effectively provide high penetration and easier absorption to promote the healthy development of reptile bones. and make your pet reptile’s enclosure more homely and comfortable with the use of heat lamps with clamp for reptiles.", 2199, 100, "https://m.media-amazon.com/images/I/71sC4uwWqoL._AC_SL1500_.jpg"
    ),
    (
      "Floating Turtle Platform", "Suit for the turtle which length below 20 cm.Strong suction cups, four support frame at the bottom with four suction cups. Fixed to the bottom of the tank durable. Floating island design, a large triangular terrace automatically float plane", 1388, 100, "https://m.media-amazon.com/images/I/61zIjbq9sUL._AC_SL1000_.jpg"
    ),
    (
      "Blueberry Dog Collar", "Size Medium. The collar does not stretch itself, please make sure leave ONLY 2 fingers between collar and dog neck. A properly fitting collar and harness won't leave any room for your dog to chew. The collar is not for tie out. NEVER leave your dog unattended with a collar on.", 899, 100, "https://m.media-amazon.com/images/I/71L7vO+Y5dS._AC_SL1500_.jpg"
    ),
    (
      "Dog Knitted Soft Sweater", "Material: Woolen. Keeps your pet dog warmer and more cute. Easy to wash and dry", 799, 100, "https://m.media-amazon.com/images/I/611nW4d0z2L._AC_SL1015_.jpg"
    ),
    (
      "Dog Seat Cover", "Forget about those cheap dog car seat covers that get ruined after a single use! Active Pets introduces a back seat cover with the latest in materials technology and a unique mesh window for easy communication with your dog. The mesh opening provides better air circulation and reduces anxiety and stress for your dog! Enjoy a 100% waterproof barrier between your seats and mud, water or fur. Experience this back seat dog cover for cars and SUVs with a peaceful mind!", 3056, 100, "https://m.media-amazon.com/images/I/91KBfIO+bEL._AC_SL1500_.jpg"
    ),
    (
      "5FT Strong Dog Leash", "Made of high-quality nylon climbing rope and metal buckle, strong and durable.", 999, 100, "https://m.media-amazon.com/images/I/71UzP01VFtS._AC_SL1500_.jpg"
    ),
    (
      "Dog Harness", "Recommended Breeds: Medium to Large Dogs, such as Golden Retriever, Huskie, Labrador, Alaska, German Shepherd, Akita, etc. Please measure the size carefully before purchasing this present for your puppy. Make your puppy stand out with this Classic Black Harness!", 1998, 100, "https://m.media-amazon.com/images/I/61AztER-+-L._AC_SL1500_.jpg"
    ),
    (
      "Automatic Pet Feeder", "Flexible Timed Feeding: No more pre-dawn wake up calls, or worry when you are overtime at night! Easy to program PETLIBRO automatic cat feeder with timer to dispense food in right time, 1-4 meals per day and up to 9 portions per meal customized healthy diet for your cats and dogs.", 6999, 100, "https://m.media-amazon.com/images/I/61zfcdEJE5L._AC_SL1500_.jpg"
    ),
    (
      "Pet Carrier TSA Approved", "With airline-approved design, you can take your pet to go to everywhere. This pet carrier provides two connecting loop handles for balanced carrying as a dual seat belt or luggage strap to secure transport.", 2199, 100, "https://m.media-amazon.com/images/I/813v3252ylL._AC_SL1500_.jpg"
    ),
    (
      "Pet Grooming Gloves", "With enhanced 255 silicone grooming tips, mimics the touch of your hand for a soft and relaxing massage; This flexible, slip-on grooming gloves allow you to brush away dirt and loose hair from cats and dogs.", 1321, 100, "https://m.media-amazon.com/images/I/713JHXyZS9L._AC_SL1000_.jpg"
    ),
    (
      "Folding Pet Steps", "Help your best friend climb up on the sofa or bed all by themselves. Small size supports pets up to 150 lbs; large size supports pets up to 200 lbs. Nonskid feet, fabric tread covers and siderails keep the steps from moving and your pet from sliding", 4295, 100, "https://m.media-amazon.com/images/I/91JaqHRowfL._AC_SL1500_.jpg"
    ),
    (
      "Sliding Glass Dog Door", "Insulates your home in cold and hot temperatures using the award-winning Endura Flap pet door and dual-pane LoE glass that keeps your home temperature consistent without sacrificing your natural light", 29999, 100, "https://m.media-amazon.com/images/I/71GymvA-LJL._AC_SL1500_.jpg"
    ),
    (
      "Foldable Metal Dog Playpen", "Secure double latch step-through door access, Exercise Pen / Pet Playpen folds flat for convenient storage", 6299, 100, "https://m.media-amazon.com/images/I/81sXycH+evL._AC_SL1500_.jpg"
    ),
    (
      "Pet Water Fountain", "The Veken pump is ultra-quiet (measured below 40dB) and low consumption which means that it normally lasts between 2.5 - 4 years!", 2799, 100, "https://m.media-amazon.com/images/I/61KQhzEnZBL._AC_SL1500_.jpg"
    ),
    (
      "Waterproof Pet Bed Cover", "Guaranteed!This premium protector prevents almost all types of moisture and liquids from leaking through. Perfect for those with dogs and cats!", 2699, 100, "https://m.media-amazon.com/images/I/516YXwMK4gL._AC_.jpg"
    ),
    (
      "Dog Bed Cot", " Raised dog bed helps pets stay cool in warm spring and summer months by allowing air to circulate and keeps pets off wet/cold ground with ground clearance", 3499, 100, "https://m.media-amazon.com/images/I/71KV03f5gvS._AC_SL1500_.jpg"
    ),
    (
      "Orthopedic Cooling Gel Dog Bed", "The classic bolstered sofa design promotes ultimate comfort and security, providing high-loft orthopedic cushion support as well as a super cozy nestling and burrowing space for dogs and cats", 6299, 100, "https://m.media-amazon.com/images/I/71Kadw7BZrL._AC_SL1500_.jpg"
    ),
    (
      "Fish Air Bubble Increaser", "This Air Bubbler will increase the amount of bubbles inside any fishtank by a lot!", 599, 100, "https://m.media-amazon.com/images/I/71JLLRNSsoL._AC_SL1000_.jpg"
    ),
    (
      "Aquarium Castle Decoration", "1 pc resin castle aquarium decoration with doors for fish swimming through and hiding. Tips: please sink the product in the clean water for 10 minutes before using.", 1299, 100, "https://m.media-amazon.com/images/I/81A83sFlzlL._AC_SL1500_.jpg"
    ),
    (
      "Cat Window Perch", "Package include 1 x Window-Mounted Cat Bed, 1 x Free Fleece Blanket, 1 x English Manual, 1 x Exquisite Gift Box, easy to install and no need any tool. Prefect match gives your cats comfortable and fun seat in the house.", 2799, 100, "https://m.media-amazon.com/images/I/81Vg5sSzKZL._AC_SL1500_.jpg"
    ),
    (
      "Silvervine Catnip Balls", "100% Natural and Non-toxic: the catnip balls are made of pure natural plant extracts, no chemical additives contained. Rest assured this toy is no harm to your favorite kitty. Includes 3 different flavors.", 1094, 100, "https://m.media-amazon.com/images/I/61MFSSVIb2L._AC_SL1000_.jpg"
    ),
    (
      "Cat Litter Mat", "Special & Large Cat Litter Box Rug: The honeycomb design holes are big and deep enough to catch and trap litter granules effectively. The double Layer kitty trapper mats with medium size could collect large amounts of cat litter so that you could dump it easily back into the litter box.", 1549, 100, "https://m.media-amazon.com/images/I/71qEt-3aHcL._AC_SL1500_.jpg"
    ),
    (
      "Stackable Cat Condo", "It's a cat cove and cozy nap pad in one something every cat is sure to love!", 8574, 100, "https://m.media-amazon.com/images/I/91Hm11As2IL._AC_SL1500_.jpg"
    ),
    (
      "Sofa Pet Cover", "Guaranteed! This premium protector prevents almost all types of moisture and liquids from leaking through. Perfect for those with dogs and cats!", 1999, 100, "https://m.media-amazon.com/images/I/51GmeHju5eL._AC_SL1000_.jpg"
    ),
    (
      "Light Up Dog Collar", "Our lighted dog collar is made of high quality nylon webbing fabric, and this collar has double rows of lights, it’s very bright and high visible. Glow in the dark, keep your dogs and cats be seen & safe at night.", 1266, 100, "https://m.media-amazon.com/images/I/51GVd0A+geL._AC_SL1000_.jpg"
    ),
    (
      "Dog Nail Set", "The dog nail trimmer has 3 size ports with 2 speed,which is suitable for all kinds of pets. You can adjust an appropriate model to trim your pets' nail according to their size. Get our pet nail grinder,will help you to save more money to trim pet's nail at home.", 1598, 100, "https://m.media-amazon.com/images/I/619-4EQiAhL._AC_SL1500_.jpg"
    ),
    (
      "Dog Barn House", "This Dog house's all plastic construction and rear air ventilations system fleas and provides long lasting protection; Also useful for outdoor cats and strays; For pets between 25 to 50 pounds.", 7999, 100, "https://m.media-amazon.com/images/I/91GBnbdRQdL._AC_SL1500_.jpg"
    );


INSERT INTO 
	cart(user_id, order_complete)
VALUES
	(1, 1);

INSERT INTO 
	cart_items(cart_id, product_id, price_at_purchase, quantity)
VALUES
	(1, 1, 5399, 1);

