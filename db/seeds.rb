# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

#
# Spree::Core::Engine.load_seed if defined?(Spree::Core)
# Spree::Auth::Engine.load_seed if defined?(Spree::Auth)


Category.transaction do
	admin_user = AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password')
	seller_user = User.create!(name: 'Seller', email: 'seller@example.com', password: 'password', password_confirmation: 'password', mobile: '9199621123', is_approved: true, user_type: User::USER_TYPE_SELLER)
	unapproved_seller_user = User.create!(name: 'Unapproved Seller', email: 'unapproved_seller@example.com', password: 'password', password_confirmation: 'password', mobile: '9198621223', is_approved: false, user_type: User::USER_TYPE_SELLER)
	buyer_user = User.create!(name: 'Buyer', email: 'buyer@example.com', password: 'password', password_confirmation: 'password', mobile: '9196621123', is_approved: true, user_type: User::USER_TYPE_BUYER)

  c1 = Category.create!(name: 'Bags')
  c2 = Category.create!(name: 'Clothes')
  c3 = Category.create!(name: 'Accessories')
  c4 = Category.create!(name: 'Furniture')

  jute_bag_url = 'http://pimg.tradeindia.com/00540247/b/2/Eco-Friendly-Jute-Bags.jpg'
  yellow_bag_url = 'http://img.tradeindia.com/fp/1/681/576.jpg'
  sack_bag_url = 'http://cdn.shopify.com/s/files/1/1017/2183/products/potatosack_grande.png?v=1444288705'

  Product.create!(categories: [c1], creator_id: seller_user.id, name: 'Sack', description: 'Heavy duty bag. Able to load 20 kgs. Sack - A stuff sack is a type of drawstring bag, usually used for storing camping items. Stuff sacks are commonly used for the storage of sleeping bags, which are otherwise bulky and difficult to manage.', price: 80, available_quantity: 15, image: URI.encode(sack_bag_url), is_approved: true)
  Product.create!(categories: [c1], creator_id: seller_user.id, name: 'Yellow Bag', description: 'Light and eco friendly colors. Bag - A bag (also known regionally as a sack) is a common tool in the form of a non-rigid container. The use of bags predates recorded history, with the earliest bags being no more than lengths of animal skin, cotton, or woven plant fibers, folded up at the edges and secured in that shape with strings of the same material', price: 10, available_quantity: 36, image: URI.encode(yellow_bag_url), is_approved: true)
  Product.create!(categories: [c1], creator_id: seller_user.id, name: 'Jute Bag', description: 'Stylish Bag at low price. Jute - Jute is a long, soft, shiny vegetable fiber that can be spun into coarse, strong threads. It is produced primarily from plants in the genus Corchorus, which was once classified with the family Tiliaceae, and more recently with Malvaceae. The primary source of the fiber is Corchorus olitorius, but it is considered inferior to Corchorus capsularis.', price: 150, available_quantity: 5, image: URI.encode(jute_bag_url), is_approved: true)

  Product.create!(categories: [c2], creator_id: seller_user.id, name: 'Used Clothes', description: 'Light used clothes. Cloth - Clothing (also called clothes) is fiber and textile material worn on the body. The wearing of clothing is mostly restricted to human beings and is a feature of nearly all human societies. The amount and type of clothing worn depends on physical, social and geographic considerations. Some clothing types can be gender-specific', price: 80, available_quantity: 67, image: URI.encode('https://s3-media1.fl.yelpcdn.com/bphoto/Nx443ww-X5Z6mhslzismZw/ls.jpg'), is_approved: true)

  Product.create!(categories: [c2], creator_id: seller_user.id, name: 'Single Used Clothes', description: 'Light used clothes with zero damage at very low price. Cloth - Clothing (also called clothes) is fiber and textile material worn on the body. The wearing of clothing is mostly restricted to human beings and is a feature of nearly all human societies. The amount and type of clothing worn depends on physical, social and geographic considerations. Some clothing types can be gender-specific', price: 100, available_quantity: 200, image: URI.encode('http://www.gaebler.com/images/startbiz/Used-Clothing-Store.jpg'), is_approved: true)
  Product.create!(categories: [c2], creator_id: seller_user.id, name: 'Hand loomed Rug', is_approved: false,
                  description: 'high Quality hand loomed Rug at reasonable price. Rug - A carpet is a textile floor covering typically consisting of an upper layer of pile attached to a backing. The pile was traditionally made from wool, but, since the 20th century, synthetic fibers such as polypropylene, nylon or polyester are often used, as these fibers are less expensive than wool. The pile usually consists of twisted tufts which are typically heat-treated to maintain their structure.', price: 100,
                  available_quantity: 45, image: URI.encode('http://images.prod.meredith.com/product/970415213a65985f8fd53455210758f5/7dc762a7bf0e1c44d6405a4f7635694cc18c49002c59709576c7c1eeeb6d7b5a/m/naturalarearugs-hand-woven-newbury-jute-rug-by-artisan-rug-maker-8-x-10-green'))


  Product.create!(categories: [c3],
                  name: 'Home Decor', creator_id: seller_user.id, is_approved: true,
                  description: 'Beautifully crafted in such a way that adds more look to your home. Decor - Interior design is the art and science of enhancing the interiors, sometimes including the exterior, of a space or building, to achieve a healthier and more aesthetically pleasing environment for the end user. An interior designer is someone who plans, researches, coordinates, and manages such projects. Interior design is a multifaceted profession that includes conceptual development, space planning, site inspections, programming, research, communicating with the stakeholders of a project, construction management, and execution of the design.',
                  price: 150, available_quantity: 3,
                  image: URI.encode('http://www.arenaturals.com/assets/images/eco_friendly_home_decor.jpg'))


  Product.create!(categories: [c3],
                  name: 'Decorative Bangles', creator_id: seller_user.id, is_approved: false,
                  description: 'This definitely looks great in hand if you wear. Very robust and withstands all the Accidental shocks. Bangle - Bangles are rigid bracelets, usually from metal, wood, or plastic. They are traditional ornaments worn mostly by South Asian women in India, Nepal, Pakistan and Bangladesh. It is a common tradition to see a new bride wearing glass bangles at her wedding and the honeymoon will end when the last bangle breaks. Bangles also have a very traditional value in Hinduism and it is considered inauspicious to be bare armed for a married woman.',
                  price: 120, available_quantity: 13,
                  image: URI.encode('https://s-media-cache-ak0.pinimg.com/736x/60/a2/eb/60a2eb51057e2b4a1df6378bbd586f41.jpg'))

  Product.create!(categories: [c4],
                  name: 'Wooden Chair', creator_id: seller_user.id, is_approved: true,
                  description: 'Long life bamboo chairs, and it provides greater comfort. Wood - Wood is a porous and fibrous structural tissue found in the stems and roots of trees, and other woody plants. It has been used for thousands of years for both fuel and as a construction material. It is an organic material, a natural composite of cellulose fibers (which are strong in tension) embedded in a matrix of lignin which resists compression. Wood is sometimes defined as only the secondary xylem in the stems of trees',
                  price: 400, available_quantity: 7,
                  image: URI.encode('http://www.arenaturals.com/assets/images/eco_friendly_home_decor.jpg'))

  Product.create!(categories: [c4],
                  name: 'Bamboo Swing', creator_id: seller_user.id, is_approved: true,
                  description: 'You will feel heaven on swinging on this chair. Bamboo - Giant bamboos are the largest members of the grass family. In bamboo, the internodal regions of the stem are usually hollow and the vascular bundles in the cross section are scattered throughout the stem instead of in a cylindrical arrangement. The dicotyledonous woody xylem is also absent. The absence of secondary growth wood causes the stems of monocots, including the palms and large bamboos, to be columnar rather than tapering',
                  price: 250, available_quantity: 19,
                  image: URI.encode('http://3.imimg.com/data3/CC/JC/MY-3541114/cane-swing-500x500.jpg'))
end
