puts "cleaning db..."

PerfumeDupe.destroy_all
PerfumePerfumer.destroy_all
PerfumeNote.destroy_all
Note.destroy_all
SeasonVote.destroy_all
Perfumer.destroy_all
Perfume.destroy_all
Brand.destroy_all

puts "db cleaned"

# =============================================================================
# MySillage Seeds - Part 1/4
# Brands: Creed, Maison Francis Kurkdjian, Dior, Tom Ford, Parfums de Marly
# =============================================================================
# This file creates:
# - Brands (luxury + dupe brands)
# - Perfumers
# - Notes
# - Perfumes with discontinued/reformulated status
# - Dupe relationships
# =============================================================================

puts "🌸 Starting MySillage Seeds - Part 1..."
puts "=" * 60

# =============================================================================
# HELPER METHODS
# =============================================================================

def find_or_create_brand(name:, country:, description: nil, logo: nil)
  Brand.find_or_create_by!(name: name) do |b|
    b.country = country
    b.description = description
    b.logo = logo
  end
end

def find_or_create_perfumer(name:, bio: nil, photo: nil)
  Perfumer.find_or_create_by!(name: name) do |p|
    p.bio = bio
    p.photo = photo
  end
end

def find_or_create_note(name:, family:)
  Note.find_or_create_by!(name: name) do |n|
    n.family = family
  end
end

def create_perfume_with_notes(brand:, name:, description:, gender:, launch_year:,
                               perfumers: [], top_notes: [], heart_notes: [], base_notes: [],
                               discontinued: false, reformulated: false, image: nil)

  perfume = Perfume.find_or_create_by!(brand: brand, name: name) do |p|
    p.description = description
    p.gender = gender
    p.launch_year = launch_year
    p.image = image
    p.discontinued = discontinued
    p.reformulated = reformulated
  end

  # Associate perfumers
  perfumers.each do |perfumer|
    PerfumePerfumer.find_or_create_by!(perfume: perfume, perfumer: perfumer)
  end

  # Associate notes
  top_notes.each do |note|
    PerfumeNote.find_or_create_by!(perfume: perfume, note: note, note_type: 'top')
  end

  heart_notes.each do |note|
    PerfumeNote.find_or_create_by!(perfume: perfume, note: note, note_type: 'heart')
  end

  base_notes.each do |note|
    PerfumeNote.find_or_create_by!(perfume: perfume, note: note, note_type: 'base')
  end

  perfume
end

def create_dupe(original:, dupe:)
  PerfumeDupe.find_or_create_by!(original_perfume: original, dupe: dupe)
end

# =============================================================================
# BRANDS - LUXURY HOUSES
# =============================================================================
puts "\n📦 Creating luxury brands..."

creed = find_or_create_brand(
  name: "Creed",
  country: "France",
  description: "Founded in 1760, Creed is a luxury fragrance house known for its artisanal approach and royal clientele. The brand has created bespoke fragrances for historical figures including Napoleon Bonaparte and Queen Victoria."
)

mfk = find_or_create_brand(
  name: "Maison Francis Kurkdjian",
  country: "France",
  description: "Founded in 2009 by master perfumer Francis Kurkdjian, the house has quickly become one of the most prestigious names in modern perfumery, known for Baccarat Rouge 540 and sophisticated compositions."
)

dior = find_or_create_brand(
  name: "Dior",
  country: "France",
  description: "Christian Dior's fashion house has been creating iconic fragrances since 1947 with Miss Dior. Today, Dior remains a pillar of luxury perfumery with classics like Sauvage, J'adore, and Miss Dior."
)

tom_ford = find_or_create_brand(
  name: "Tom Ford",
  country: "USA",
  description: "Launched in 2006, Tom Ford Beauty revolutionized the fragrance industry with bold, provocative scents. The Private Blend collection represents some of the most sought-after niche fragrances."
)

pdm = find_or_create_brand(
  name: "Parfums de Marly",
  country: "France",
  description: "Founded in 2009, Parfums de Marly draws inspiration from the opulent court of King Louis XV and the prestigious Château de Marly. Known for rich, sophisticated oriental and woody fragrances."
)

# =============================================================================
# BRANDS - DUPE/CLONE HOUSES
# =============================================================================
puts "📦 Creating dupe brands..."

armaf = find_or_create_brand(
  name: "Armaf",
  country: "UAE",
  description: "Sterling Parfums' brand known for high-quality affordable clones of luxury fragrances."
)

al_haramain = find_or_create_brand(
  name: "Al Haramain",
  country: "UAE",
  description: "Established in 1970, Al Haramain is one of the oldest fragrance houses in the Middle East, known for both oriental originals and inspired fragrances."
)

lattafa = find_or_create_brand(
  name: "Lattafa",
  country: "UAE",
  description: "Popular Middle Eastern brand offering quality inspired fragrances at accessible prices."
)

afnan = find_or_create_brand(
  name: "Afnan",
  country: "UAE",
  description: "Premium Arabian perfume house known for Supremacy line and quality clones."
)

rasasi = find_or_create_brand(
  name: "Rasasi",
  country: "UAE",
  description: "Established in 1979, Rasasi creates both original compositions and inspired fragrances."
)

montblanc = find_or_create_brand(
  name: "Montblanc",
  country: "Germany",
  description: "Luxury brand known for writing instruments, leather goods, and sophisticated fragrances including Explorer."
)

zara = find_or_create_brand(
  name: "Zara",
  country: "Spain",
  description: "Fast fashion giant with a surprisingly sophisticated fragrance line offering quality dupes at very accessible prices."
)

dossier = find_or_create_brand(
  name: "Dossier",
  country: "USA",
  description: "Direct-to-consumer brand specializing in creating 'inspired by' versions of luxury fragrances."
)

alexandria = find_or_create_brand(
  name: "Alexandria Fragrances",
  country: "USA",
  description: "American clone house known for high-quality inspired fragrances with excellent performance."
)

alt = find_or_create_brand(
  name: "ALT. Fragrances",
  country: "USA",
  description: "American brand creating affordable alternatives to popular luxury scents."
)

paris_corner = find_or_create_brand(
  name: "Paris Corner",
  country: "UAE",
  description: "Middle Eastern brand under Zimaya, known for quality inspired fragrances."
)

fragrance_world = find_or_create_brand(
  name: "Fragrance World",
  country: "UAE",
  description: "Arabian perfume house known for affordable inspired fragrances with good performance."
)

maison_alhambra = find_or_create_brand(
  name: "Maison Alhambra",
  country: "UAE",
  description: "Lattafa's premium line offering higher-quality inspired fragrances."
)

puts "✅ Created #{Brand.count} brands"

# =============================================================================
# PERFUMERS
# =============================================================================
puts "\n👃 Creating perfumers..."

# Creed perfumers
olivier_creed = find_or_create_perfumer(
  name: "Olivier Creed",
  bio: "Sixth-generation master perfumer and current head of Creed, responsible for iconic creations like Aventus and Green Irish Tweed."
)

erwin_creed = find_or_create_perfumer(
  name: "Erwin Creed",
  bio: "Seventh generation of the Creed family, working alongside his father Olivier on modern creations."
)

# MFK perfumers
francis_kurkdjian = find_or_create_perfumer(
  name: "Francis Kurkdjian",
  bio: "French-Armenian master perfumer, created Le Male for Jean Paul Gaultier before founding his own house. Known for Baccarat Rouge 540."
)

# Dior perfumers
francois_demachy = find_or_create_perfumer(
  name: "François Demachy",
  bio: "Dior's exclusive in-house perfumer since 2006, creator of Sauvage and many Dior classics."
)

edmond_roudnitska = find_or_create_perfumer(
  name: "Edmond Roudnitska",
  bio: "Legendary perfumer, created Dior's Eau Sauvage and is considered one of the greatest perfumers of the 20th century."
)

# Tom Ford perfumers
jacques_cavallier = find_or_create_perfumer(
  name: "Jacques Cavallier Belletrud",
  bio: "Master perfumer at Louis Vuitton and Firmenich, created numerous Tom Ford Private Blend fragrances."
)

olivier_gillotin = find_or_create_perfumer(
  name: "Olivier Gillotin",
  bio: "Givaudan perfumer known for work with Tom Ford including Tobacco Vanille and Tuscan Leather."
)

sonia_constant = find_or_create_perfumer(
  name: "Sonia Constant",
  bio: "Firmenich perfumer who created Tom Ford's Lost Cherry."
)

rodrigo_flores_roux = find_or_create_perfumer(
  name: "Rodrigo Flores-Roux",
  bio: "Master perfumer who created Tom Ford Oud Wood."
)

# PDM perfumers
hamid_merati = find_or_create_perfumer(
  name: "Hamid Merati-Kashani",
  bio: "Perfumer behind many Parfums de Marly successes including Layton and Herod."
)

quentin_bisch = find_or_create_perfumer(
  name: "Quentin Bisch",
  bio: "Givaudan perfumer known for his work with Parfums de Marly and Jean Paul Gaultier."
)

puts "✅ Created #{Perfumer.count} perfumers"

# =============================================================================
# NOTES
# =============================================================================
puts "\n🌿 Creating notes..."

# Citrus family
bergamot = find_or_create_note(name: "Bergamot", family: "citrus")
lemon = find_or_create_note(name: "Lemon", family: "citrus")
orange = find_or_create_note(name: "Orange", family: "citrus")
grapefruit = find_or_create_note(name: "Grapefruit", family: "citrus")
lime = find_or_create_note(name: "Lime", family: "citrus")
mandarin = find_or_create_note(name: "Mandarin", family: "citrus")
pink_pepper = find_or_create_note(name: "Pink Pepper", family: "spicy")
black_pepper = find_or_create_note(name: "Black Pepper", family: "spicy")

# Fruity family
apple = find_or_create_note(name: "Apple", family: "fruity")
pineapple = find_or_create_note(name: "Pineapple", family: "fruity")
blackcurrant = find_or_create_note(name: "Blackcurrant", family: "fruity")
peach = find_or_create_note(name: "Peach", family: "fruity")
cherry = find_or_create_note(name: "Cherry", family: "fruity")
plum = find_or_create_note(name: "Plum", family: "fruity")
raspberry = find_or_create_note(name: "Raspberry", family: "fruity")

# Floral family
rose = find_or_create_note(name: "Rose", family: "floral")
jasmine = find_or_create_note(name: "Jasmine", family: "floral")
iris = find_or_create_note(name: "Iris", family: "floral")
violet = find_or_create_note(name: "Violet", family: "floral")
lavender = find_or_create_note(name: "Lavender", family: "floral")
geranium = find_or_create_note(name: "Geranium", family: "floral")
ylang_ylang = find_or_create_note(name: "Ylang-Ylang", family: "floral")
tuberose = find_or_create_note(name: "Tuberose", family: "floral")
orange_blossom = find_or_create_note(name: "Orange Blossom", family: "floral")
lily = find_or_create_note(name: "Lily of the Valley", family: "floral")

# Woody family
sandalwood = find_or_create_note(name: "Sandalwood", family: "woody")
cedar = find_or_create_note(name: "Cedar", family: "woody")
vetiver = find_or_create_note(name: "Vetiver", family: "woody")
oud = find_or_create_note(name: "Oud", family: "woody")
birch = find_or_create_note(name: "Birch", family: "woody")
patchouli = find_or_create_note(name: "Patchouli", family: "woody")
guaiac = find_or_create_note(name: "Guaiac Wood", family: "woody")

# Oriental/Spicy family
vanilla = find_or_create_note(name: "Vanilla", family: "oriental")
tonka = find_or_create_note(name: "Tonka Bean", family: "oriental")
amber = find_or_create_note(name: "Amber", family: "oriental")
benzoin = find_or_create_note(name: "Benzoin", family: "oriental")
incense = find_or_create_note(name: "Incense", family: "oriental")
saffron = find_or_create_note(name: "Saffron", family: "spicy")
cardamom = find_or_create_note(name: "Cardamom", family: "spicy")
cinnamon = find_or_create_note(name: "Cinnamon", family: "spicy")
nutmeg = find_or_create_note(name: "Nutmeg", family: "spicy")
clove = find_or_create_note(name: "Clove", family: "spicy")

# Musk/Animalic family
musk = find_or_create_note(name: "Musk", family: "musk")
white_musk = find_or_create_note(name: "White Musk", family: "musk")
ambergris = find_or_create_note(name: "Ambergris", family: "animalic")
leather = find_or_create_note(name: "Leather", family: "animalic")
castoreum = find_or_create_note(name: "Castoreum", family: "animalic")

# Fresh/Aromatic family
mint = find_or_create_note(name: "Mint", family: "aromatic")
basil = find_or_create_note(name: "Basil", family: "aromatic")
eucalyptus = find_or_create_note(name: "Eucalyptus", family: "aromatic")
sage = find_or_create_note(name: "Sage", family: "aromatic")
rosemary = find_or_create_note(name: "Rosemary", family: "aromatic")
green_tea = find_or_create_note(name: "Green Tea", family: "aromatic")

# Aquatic/Green family
sea_notes = find_or_create_note(name: "Sea Notes", family: "aquatic")
green_notes = find_or_create_note(name: "Green Notes", family: "green")
grass = find_or_create_note(name: "Grass", family: "green")

# Gourmand family
tobacco = find_or_create_note(name: "Tobacco", family: "gourmand")
coffee = find_or_create_note(name: "Coffee", family: "gourmand")
chocolate = find_or_create_note(name: "Chocolate", family: "gourmand")
honey = find_or_create_note(name: "Honey", family: "gourmand")
caramel = find_or_create_note(name: "Caramel", family: "gourmand")
almond = find_or_create_note(name: "Almond", family: "gourmand")
praline = find_or_create_note(name: "Praline", family: "gourmand")

# Additional notes
oakmoss = find_or_create_note(name: "Oakmoss", family: "woody")
labdanum = find_or_create_note(name: "Labdanum", family: "oriental")
elemi = find_or_create_note(name: "Elemi", family: "aromatic")
myrrh = find_or_create_note(name: "Myrrh", family: "oriental")
frankincense = find_or_create_note(name: "Frankincense", family: "oriental")
ambroxan = find_or_create_note(name: "Ambroxan", family: "synthetic")
iso_e_super = find_or_create_note(name: "Iso E Super", family: "synthetic")

# Notes manquantes à ajouter dans la section notes
galbanum = find_or_create_note(name: "Galbanum", family: "green")
juniper_berry = find_or_create_note(name: "Juniper Berry", family: "aromatic")
fir_resin = find_or_create_note(name: "Fir Resin", family: "woody")
cashmere = find_or_create_note(name: "Cashmere", family: "musk")
coriander = find_or_create_note(name: "Coriander", family: "spicy")
blood_orange = find_or_create_note(name: "Blood Orange", family: "citrus")
peony = find_or_create_note(name: "Peony", family: "floral")
rosewood = find_or_create_note(name: "Rosewood", family: "woody")
melon = find_or_create_note(name: "Melon", family: "fruity")
blackberry = find_or_create_note(name: "Blackberry", family: "fruity")
sichuan_pepper = find_or_create_note(name: "Sichuan Pepper", family: "spicy")
licorice = find_or_create_note(name: "Licorice", family: "gourmand")
hawthorn = find_or_create_note(name: "Hawthorn", family: "floral")
apricot = find_or_create_note(name: "Apricot", family: "fruity")
cacao = find_or_create_note(name: "Cacao", family: "gourmand")
dried_fruits = find_or_create_note(name: "Dried Fruits", family: "fruity")
thyme = find_or_create_note(name: "Thyme", family: "aromatic")
suede = find_or_create_note(name: "Suede", family: "animalic")
bitter_almond = find_or_create_note(name: "Bitter Almond", family: "gourmand")
cherry_liqueur = find_or_create_note(name: "Cherry Liqueur", family: "gourmand")
turkish_rose = find_or_create_note(name: "Turkish Rose", family: "floral")
truffle = find_or_create_note(name: "Truffle", family: "gourmand")
orchid = find_or_create_note(name: "Orchid", family: "floral")
lotus = find_or_create_note(name: "Lotus", family: "floral")
neroli = find_or_create_note(name: "Neroli", family: "floral")
davana = find_or_create_note(name: "Davana", family: "fruity")
rum = find_or_create_note(name: "Rum", family: "gourmand")
pepper = find_or_create_note(name: "Pepper", family: "spicy")
heliotrope = find_or_create_note(name: "Heliotrope", family: "floral")
dates = find_or_create_note(name: "Dates", family: "fruity")
green_apple = find_or_create_note(name: "Green Apple", family: "fruity")
litchi = find_or_create_note(name: "Litchi", family: "fruity")
rhubarb = find_or_create_note(name: "Rhubarb", family: "fruity")
cashmeran = find_or_create_note(name: "Cashmeran", family: "woody")
tangerine = find_or_create_note(name: "Tangerine", family: "citrus")
ginger = find_or_create_note(name: "Ginger", family: "spicy")
white_pepper = find_or_create_note(name: "White Pepper", family: "spicy")
clary_sage = find_or_create_note(name: "Clary Sage", family: "aromatic")
artemisia = find_or_create_note(name: "Artemisia", family: "aromatic")
pear = find_or_create_note(name: "Pear", family: "fruity")
strawberry = find_or_create_note(name: "Strawberry", family: "fruity")
cherry = find_or_create_note(name: "Cherry", family: "fruity")
coconut = find_or_create_note(name: "Coconut", family: "gourmand")
fig = find_or_create_note(name: "Fig", family: "fruity")

puts "✅ Created #{Note.count} notes"

# =============================================================================
# PERFUMES - CREED
# =============================================================================
puts "\n🍾 Creating Creed perfumes..."

# --- CREED AVENTUS ---
aventus = create_perfume_with_notes(
  brand: creed,
  name: "Aventus",
  description: "A fruity, smoky masterpiece celebrating strength, power and success. One of the most influential fragrances of the 21st century.",
  gender: "male",
  launch_year: 2010,
  perfumers: [olivier_creed, erwin_creed],
  top_notes: [pineapple, bergamot, blackcurrant, apple],
  heart_notes: [birch, jasmine, patchouli],
  base_notes: [musk, oakmoss, ambergris, vanilla],
  reformulated: true
)

# Aventus DUPES
cdnim = create_perfume_with_notes(
  brand: armaf,
  name: "Club de Nuit Intense Man",
  description: "The most famous Aventus clone. Strong lemon opening that mellows into a smoky, fruity dry down remarkably similar to Aventus.",
  gender: "male",
  launch_year: 2015,
  top_notes: [lemon, pineapple, bergamot, blackcurrant, apple],
  heart_notes: [birch, jasmine, rose],
  base_notes: [musk, ambergris, patchouli, vanilla]
)

laventure = create_perfume_with_notes(
  brand: al_haramain,
  name: "L'Aventure",
  description: "Smooth, fruity Aventus alternative. Less harsh opening than CDNIM with excellent longevity.",
  gender: "male",
  launch_year: 2016,
  top_notes: [bergamot, lemon, elemi],
  heart_notes: [jasmine, lily],
  base_notes: [musk, amber, patchouli]
)

supremacy_silver = create_perfume_with_notes(
  brand: afnan,
  name: "Supremacy Silver",
  description: "Highly praised Aventus alternative with excellent performance and close scent profile.",
  gender: "male",
  launch_year: 2016,
  top_notes: [pineapple, apple, bergamot, blackcurrant],
  heart_notes: [birch, rose, jasmine],
  base_notes: [musk, ambergris, oakmoss, vanilla]
)

explorer = create_perfume_with_notes(
  brand: montblanc,
  name: "Explorer",
  description: "Designer take on the Aventus DNA. Smoother, more accessible, but less complex.",
  gender: "male",
  launch_year: 2019,
  top_notes: [bergamot, pink_pepper],
  heart_notes: [leather, vetiver],
  base_notes: [patchouli, oakmoss, ambroxan]
)

create_dupe(original: aventus, dupe: cdnim)
create_dupe(original: aventus, dupe: laventure)
create_dupe(original: aventus, dupe: supremacy_silver)
create_dupe(original: aventus, dupe: explorer)

# --- CREED GREEN IRISH TWEED ---
git = create_perfume_with_notes(
  brand: creed,
  name: "Green Irish Tweed",
  description: "A fresh, green classic evoking the Irish countryside. Elegant and timeless masculinity.",
  gender: "male",
  launch_year: 1985,
  perfumers: [olivier_creed],
  top_notes: [lemon, find_or_create_note(name: "Verbena", family: "citrus")],
  heart_notes: [iris, violet],
  base_notes: [sandalwood, ambergris, musk],
  reformulated: true
)

# GIT DUPES
tres_nuit = create_perfume_with_notes(
  brand: armaf,
  name: "Tres Nuit",
  description: "Very close clone of Green Irish Tweed at a fraction of the price.",
  gender: "male",
  launch_year: 2015,
  top_notes: [lemon],
  heart_notes: [violet, iris],
  base_notes: [sandalwood, musk]
)

cool_water = create_perfume_with_notes(
  brand: find_or_create_brand(name: "Davidoff", country: "Switzerland"),
  name: "Cool Water",
  description: "The classic fresh aquatic that shares DNA with Green Irish Tweed. Some say GIT was inspired by this.",
  gender: "male",
  launch_year: 1988,
  top_notes: [mint, green_notes, lavender],
  heart_notes: [jasmine, geranium],
  base_notes: [sandalwood, cedar, musk, amber]
)

create_dupe(original: git, dupe: tres_nuit)
create_dupe(original: git, dupe: cool_water)

# --- CREED SILVER MOUNTAIN WATER ---
smw = create_perfume_with_notes(
  brand: creed,
  name: "Silver Mountain Water",
  description: "Fresh, aquatic, and invigorating. Inspired by the exhilarating sight of the snow-capped Swiss Alps.",
  gender: "unisex",
  launch_year: 1995,
  perfumers: [olivier_creed],
  top_notes: [bergamot, mandarin, green_notes],
  heart_notes: [green_tea, blackcurrant],
  base_notes: [musk, sandalwood, galbanum]
)

# SMW DUPES
silver_shade = create_perfume_with_notes(
  brand: armaf,
  name: "Sillage",
  description: "Fresh, clean alternative to Silver Mountain Water with good performance.",
  gender: "unisex",
  launch_year: 2017,
  top_notes: [bergamot, mandarin],
  heart_notes: [green_notes],
  base_notes: [musk, sandalwood]
)

create_dupe(original: smw, dupe: silver_shade)

# --- CREED MILLESIME IMPERIAL ---
millesime = create_perfume_with_notes(
  brand: creed,
  name: "Millésime Impérial",
  description: "Aquatic, salty freshness with a distinctive melon note. Elegant seaside sophistication.",
  gender: "unisex",
  launch_year: 1995,
  perfumers: [olivier_creed],
  top_notes: [bergamot, lemon, sea_notes],
  heart_notes: [iris],
  base_notes: [musk, amber, sandalwood]
)

# MI DUPES
sean_john_unforgivable = create_perfume_with_notes(
  brand: find_or_create_brand(name: "Sean John", country: "USA"),
  name: "Unforgivable",
  description: "Often compared to Millésime Impérial for its similar aquatic-salty profile.",
  gender: "male",
  launch_year: 2006,
  top_notes: [bergamot, mandarin, grapefruit],
  heart_notes: [orange_blossom],
  base_notes: [cedar, amber, musk]
)

create_dupe(original: millesime, dupe: sean_john_unforgivable)

# --- CREED VIKING ---
viking = create_perfume_with_notes(
  brand: creed,
  name: "Viking",
  description: "Fresh, spicy, and powerful. A tribute to Nordic warrior strength and character.",
  gender: "male",
  launch_year: 2017,
  perfumers: [olivier_creed, erwin_creed],
  top_notes: [bergamot, lemon, pink_pepper, mint],
  heart_notes: [rose, lavender, geranium],
  base_notes: [sandalwood, patchouli, vetiver, leather]
)

# --- CREED ROYAL OUD ---
royal_oud = create_perfume_with_notes(
  brand: creed,
  name: "Royal Oud",
  description: "Sophisticated oud composition with cedar and galbanum. Less challenging than traditional ouds.",
  gender: "unisex",
  launch_year: 2011,
  perfumers: [olivier_creed],
  top_notes: [lemon, bergamot, pink_pepper],
  heart_notes: [cedar, galbanum],
  base_notes: [oud, sandalwood, musk]
)

# --- CREED VIRGIN ISLAND WATER ---
viw = create_perfume_with_notes(
  brand: creed,
  name: "Virgin Island Water",
  description: "Tropical paradise in a bottle. Coconut, lime, and white rum evoke Caribbean beaches.",
  gender: "unisex",
  launch_year: 2007,
  perfumers: [olivier_creed],
  top_notes: [lime, mandarin, grapefruit],
  heart_notes: [jasmine, ylang_ylang],
  base_notes: [musk, white_musk]
)

# VIW DUPES
club_de_nuit_untold = create_perfume_with_notes(
  brand: armaf,
  name: "Club de Nuit Untold",
  description: "Tropical, coconut-lime fragrance inspired by Virgin Island Water.",
  gender: "unisex",
  launch_year: 2021,
  top_notes: [lime, mandarin],
  heart_notes: [ylang_ylang, jasmine],
  base_notes: [musk, sandalwood]
)

create_dupe(original: viw, dupe: club_de_nuit_untold)

# --- CREED AVENTUS COLOGNE ---
aventus_cologne = create_perfume_with_notes(
  brand: creed,
  name: "Aventus Cologne",
  description: "Fresh, citrusy take on Aventus. Ginger and mandarin create a brighter, more casual scent.",
  gender: "male",
  launch_year: 2019,
  perfumers: [olivier_creed, erwin_creed],
  top_notes: [grapefruit, mandarin, blackcurrant],
  heart_notes: [ginger, cardamom],
  base_notes: [sandalwood, musk, birch]
)

# Aventus Cologne DUPES
eternal_zeus = create_perfume_with_notes(
  brand: alexandria,
  name: "Eternal Zeus",
  description: "Very close clone of Aventus Cologne with excellent performance.",
  gender: "male",
  launch_year: 2020,
  top_notes: [grapefruit, mandarin, blackcurrant],
  heart_notes: [ginger],
  base_notes: [sandalwood, musk]
)

create_dupe(original: aventus_cologne, dupe: eternal_zeus)

# --- CREED ORIGINAL SANTAL ---
original_santal = create_perfume_with_notes(
  brand: creed,
  name: "Original Santal",
  description: "Rich, creamy sandalwood with spices. Warm, sensual, and sophisticated.",
  gender: "unisex",
  launch_year: 2005,
  perfumers: [olivier_creed],
  top_notes: [cinnamon, orange],
  heart_notes: [sandalwood, juniper_berry = find_or_create_note(name: "Juniper Berry", family: "aromatic")],
  base_notes: [vanilla, musk, tonka]
)

# --- CREED HIMALAYA ---
himalaya = create_perfume_with_notes(
  brand: creed,
  name: "Himalaya",
  description: "Fresh, woody, and invigorating. Captures the crisp air of the Himalayan mountains.",
  gender: "male",
  launch_year: 2002,
  perfumers: [olivier_creed],
  top_notes: [bergamot, lemon, grapefruit],
  heart_notes: [sandalwood, cedar],
  base_notes: [musk, ambergris]
)

# --- CREED BOIS DU PORTUGAL ---
bois_du_portugal = create_perfume_with_notes(
  brand: creed,
  name: "Bois du Portugal",
  description: "Lavender and woody elegance. A distinguished, sophisticated gentleman's fragrance.",
  gender: "male",
  launch_year: 1987,
  perfumers: [olivier_creed],
  top_notes: [bergamot, lavender],
  heart_notes: [cedar, sandalwood],
  base_notes: [amber, vanilla, musk]
)

puts "✅ Created Creed perfumes"

# =============================================================================
# PERFUMES - MAISON FRANCIS KURKDJIAN
# =============================================================================
puts "\n🍾 Creating MFK perfumes..."

# --- MFK BACCARAT ROUGE 540 ---
br540 = create_perfume_with_notes(
  brand: mfk,
  name: "Baccarat Rouge 540",
  description: "Luminous, crystal-like blend of jasmine, saffron, and amberwood. The modern classic that defined a new olfactory genre.",
  gender: "unisex",
  launch_year: 2015,
  perfumers: [francis_kurkdjian],
  top_notes: [saffron, jasmine],
  heart_notes: [cedar, ambergris],
  base_notes: [amber, fir_resin = find_or_create_note(name: "Fir Resin", family: "woody")]
)

# BR540 DUPES
cloud = create_perfume_with_notes(
  brand: find_or_create_brand(name: "Ariana Grande", country: "USA"),
  name: "Cloud",
  description: "Popular affordable dupe for BR540. Sweet, creamy, and widely accessible.",
  gender: "female",
  launch_year: 2018,
  top_notes: [lavender, pear],
  heart_notes: [praline],
  base_notes: [vanilla, musk, cashmere = find_or_create_note(name: "Cashmere", family: "musk")]
)

burberry_her = create_perfume_with_notes(
  brand: find_or_create_brand(name: "Burberry", country: "UK"),
  name: "Her",
  description: "Fruity-floral with similar DNA to BR540. Berry notes with a sweet dry down.",
  gender: "female",
  launch_year: 2018,
  top_notes: [blackcurrant, cherry, raspberry],
  heart_notes: [jasmine, violet],
  base_notes: [amber, musk]
)

rouge_540 = create_perfume_with_notes(
  brand: lattafa,
  name: "Bade'e Al Oud Amethyst",
  description: "Middle Eastern interpretation of BR540 at a fraction of the price.",
  gender: "unisex",
  launch_year: 2020,
  top_notes: [saffron],
  heart_notes: [cedar],
  base_notes: [amber, ambergris]
)

create_dupe(original: br540, dupe: cloud)
create_dupe(original: br540, dupe: burberry_her)
create_dupe(original: br540, dupe: rouge_540)

# --- MFK GRAND SOIR ---
grand_soir = create_perfume_with_notes(
  brand: mfk,
  name: "Grand Soir",
  description: "Rich amber perfection. Warm, balsamic, and enveloping for elegant evening occasions.",
  gender: "unisex",
  launch_year: 2016,
  perfumers: [francis_kurkdjian],
  top_notes: [labdanum],
  heart_notes: [amber, benzoin],
  base_notes: [vanilla, tonka]
)

# Grand Soir DUPES
amber_nuit = create_perfume_with_notes(
  brand: maison_alhambra,
  name: "Amber Nuit",
  description: "Affordable alternative to Grand Soir with similar amber-vanilla richness.",
  gender: "unisex",
  launch_year: 2021,
  top_notes: [labdanum],
  heart_notes: [amber],
  base_notes: [vanilla, benzoin]
)

create_dupe(original: grand_soir, dupe: amber_nuit)

# --- MFK OEUD SATIN MOOD ---
oud_satin_mood = create_perfume_with_notes(
  brand: mfk,
  name: "Oud Satin Mood",
  description: "Velvety rose and oud combination. Luxurious, smooth, and deeply romantic.",
  gender: "unisex",
  launch_year: 2017,
  perfumers: [francis_kurkdjian],
  top_notes: [violet],
  heart_notes: [rose, oud],
  base_notes: [vanilla, benzoin]
)

# OSM DUPES
velvet_rose = create_perfume_with_notes(
  brand: lattafa,
  name: "Velvet Rose",
  description: "Rose-oud blend inspired by Oud Satin Mood.",
  gender: "unisex",
  launch_year: 2020,
  top_notes: [rose],
  heart_notes: [oud],
  base_notes: [vanilla, musk]
)

create_dupe(original: oud_satin_mood, dupe: velvet_rose)

# --- MFK GENTLE FLUIDITY GOLD ---
gf_gold = create_perfume_with_notes(
  brand: mfk,
  name: "Gentle Fluidity Gold",
  description: "Intoxicating blend of vanilla, amber, and juniper. Warm, sensual, and addictive.",
  gender: "unisex",
  launch_year: 2019,
  perfumers: [francis_kurkdjian],
  top_notes: [juniper_berry, coriander = find_or_create_note(name: "Coriander", family: "spicy"), nutmeg],
  heart_notes: [amber],
  base_notes: [vanilla, musk, sandalwood]
)

# --- MFK GENTLE FLUIDITY SILVER ---
gf_silver = create_perfume_with_notes(
  brand: mfk,
  name: "Gentle Fluidity Silver",
  description: "Fresh, aromatic counterpart to Gold. Juniper and musk create a light, airy feel.",
  gender: "unisex",
  launch_year: 2019,
  perfumers: [francis_kurkdjian],
  top_notes: [juniper_berry, nutmeg],
  heart_notes: [amber],
  base_notes: [vanilla, musk, sandalwood]
)

# --- MFK AQUA UNIVERSALIS ---
aqua_universalis = create_perfume_with_notes(
  brand: mfk,
  name: "Aqua Universalis",
  description: "Pure, bright, and luminous. Clean citrus and white flowers for a fresh-from-the-shower feel.",
  gender: "unisex",
  launch_year: 2009,
  perfumers: [francis_kurkdjian],
  top_notes: [bergamot, lemon, orange],
  heart_notes: [lily, jasmine],
  base_notes: [white_musk]
)

# --- MFK PETIT MATIN ---
petit_matin = create_perfume_with_notes(
  brand: mfk,
  name: "Petit Matin",
  description: "Gentle wake-up scent. Lemon and musk with a clean, fresh character.",
  gender: "unisex",
  launch_year: 2016,
  perfumers: [francis_kurkdjian],
  top_notes: [lemon, mint, bergamot],
  heart_notes: [rose, jasmine],
  base_notes: [musk]
)

# --- MFK À LA ROSE ---
a_la_rose = create_perfume_with_notes(
  brand: mfk,
  name: "À la rose",
  description: "Pure, radiant rose bouquet. Fresh and elegant femininity.",
  gender: "female",
  launch_year: 2014,
  perfumers: [francis_kurkdjian],
  top_notes: [rose],
  heart_notes: [rose, violet],
  base_notes: [musk, cedar]
)

# --- MFK AMYRIS HOMME ---
amyris_homme = create_perfume_with_notes(
  brand: mfk,
  name: "Amyris Homme",
  description: "Smooth, woody elegance. Amyris wood and iris create sophisticated masculinity.",
  gender: "male",
  launch_year: 2012,
  perfumers: [francis_kurkdjian],
  top_notes: [orange, mandarin],
  heart_notes: [iris],
  base_notes: [sandalwood, amyris = find_or_create_note(name: "Amyris", family: "woody"), tonka]
)

puts "✅ Created MFK perfumes"

# =============================================================================
# PERFUMES - DIOR
# =============================================================================
puts "\n🍾 Creating Dior perfumes..."

# --- DIOR SAUVAGE ---
sauvage_edt = create_perfume_with_notes(
  brand: dior,
  name: "Sauvage Eau de Toilette",
  description: "Fresh, raw, and noble. Bergamot with Ambroxan creates an addictive signature scent.",
  gender: "male",
  launch_year: 2015,
  perfumers: [francois_demachy],
  top_notes: [bergamot, pink_pepper],
  heart_notes: [geranium, lavender, elemi],
  base_notes: [ambroxan, cedar, labdanum]
)

# Sauvage DUPES
bleu_de_chanel = create_perfume_with_notes(
  brand: find_or_create_brand(name: "Chanel", country: "France"),
  name: "Bleu de Chanel",
  description: "Not a direct clone but often compared to Sauvage. Different DNA but similar appeal.",
  gender: "male",
  launch_year: 2010,
  top_notes: [grapefruit, lemon, mint],
  heart_notes: [ginger, nutmeg, jasmine],
  base_notes: [incense, cedar, sandalwood]
)

hunter_intense = create_perfume_with_notes(
  brand: armaf,
  name: "Hunter Intense",
  description: "Budget-friendly Sauvage alternative with similar fresh-spicy DNA.",
  gender: "male",
  launch_year: 2017,
  top_notes: [bergamot, pink_pepper],
  heart_notes: [lavender],
  base_notes: [ambroxan, cedar]
)

create_dupe(original: sauvage_edt, dupe: hunter_intense)

# --- DIOR SAUVAGE EDP ---
sauvage_edp = create_perfume_with_notes(
  brand: dior,
  name: "Sauvage Eau de Parfum",
  description: "Richer, spicier take on Sauvage with vanilla warmth.",
  gender: "male",
  launch_year: 2018,
  perfumers: [francois_demachy],
  top_notes: [bergamot, mandarin],
  heart_notes: [lavender, sichuan_pepper = find_or_create_note(name: "Sichuan Pepper", family: "spicy")],
  base_notes: [vanilla, ambroxan, cedar]
)

# --- DIOR SAUVAGE ELIXIR ---
sauvage_elixir = create_perfume_with_notes(
  brand: dior,
  name: "Sauvage Elixir",
  description: "The most concentrated Sauvage. Rich, spicy, and long-lasting.",
  gender: "male",
  launch_year: 2021,
  perfumers: [francois_demachy],
  top_notes: [grapefruit, cinnamon],
  heart_notes: [nutmeg, lavender],
  base_notes: [licorice = find_or_create_note(name: "Licorice", family: "gourmand"), sandalwood, amber]
)

# --- DIOR HOMME ---
dior_homme = create_perfume_with_notes(
  brand: dior,
  name: "Dior Homme",
  description: "Elegant iris-cacao combination. Sophisticated masculinity with a powdery touch.",
  gender: "male",
  launch_year: 2005,
  top_notes: [lavender, sage, bergamot],
  heart_notes: [iris, amber],
  base_notes: [vetiver, cedar, leather],
  reformulated: true
)

# --- DIOR HOMME INTENSE ---
dior_homme_intense = create_perfume_with_notes(
  brand: dior,
  name: "Dior Homme Intense",
  description: "Rich, deep iris and amber. The most sensual of the Dior Homme line.",
  gender: "male",
  launch_year: 2011,
  top_notes: [lavender, iris],
  heart_notes: [iris, amber, pear],
  base_notes: [vetiver, cedar, vanilla]
)

# DHI DUPES
dhi_clone = create_perfume_with_notes(
  brand: dossier,
  name: "Ambery Iris",
  description: "Direct inspired-by version of Dior Homme Intense.",
  gender: "male",
  launch_year: 2019,
  top_notes: [lavender],
  heart_notes: [iris],
  base_notes: [vanilla, vetiver]
)

create_dupe(original: dior_homme_intense, dupe: dhi_clone)

# --- MISS DIOR ---
miss_dior = create_perfume_with_notes(
  brand: dior,
  name: "Miss Dior Eau de Parfum",
  description: "Modern floral with rose and fresh notes. Feminine elegance redefined.",
  gender: "female",
  launch_year: 2017,
  perfumers: [francois_demachy],
  top_notes: [blood_orange = find_or_create_note(name: "Blood Orange", family: "citrus"), bergamot, mandarin],
  heart_notes: [rose, peony = find_or_create_note(name: "Peony", family: "floral")],
  base_notes: [musk, rosewood = find_or_create_note(name: "Rosewood", family: "woody")]
)

# --- J'ADORE ---
jadore = create_perfume_with_notes(
  brand: dior,
  name: "J'adore",
  description: "Opulent floral bouquet. The ultimate feminine luxury fragrance.",
  gender: "female",
  launch_year: 1999,
  perfumers: [],
  top_notes: [bergamot, melon = find_or_create_note(name: "Melon", family: "fruity")],
  heart_notes: [jasmine, rose, ylang_ylang, tuberose],
  base_notes: [musk, blackberry = find_or_create_note(name: "Blackberry", family: "fruity"), vanilla]
)

# --- DIOR EAU SAUVAGE ---
eau_sauvage = create_perfume_with_notes(
  brand: dior,
  name: "Eau Sauvage",
  description: "The original 1966 classic. Fresh, citrusy elegance that defined modern masculinity.",
  gender: "male",
  launch_year: 1966,
  perfumers: [edmond_roudnitska],
  top_notes: [lemon, bergamot],
  heart_notes: [vetiver, oakmoss, basil],
  base_notes: [musk, amber]
)

# --- DIOR FAHRENHEIT ---
fahrenheit = create_perfume_with_notes(
  brand: dior,
  name: "Fahrenheit",
  description: "Revolutionary petrol-violet-leather combination. Unique and unmistakable.",
  gender: "male",
  launch_year: 1988,
  top_notes: [lavender, mandarin, hawthorn = find_or_create_note(name: "Hawthorn", family: "floral")],
  heart_notes: [violet, nutmeg, cedar],
  base_notes: [leather, sandalwood, amber],
  reformulated: true
)

# --- DIOR POISON ---
poison = create_perfume_with_notes(
  brand: dior,
  name: "Poison",
  description: "Provocative and dramatic. The iconic 80s powerhouse fragrance.",
  gender: "female",
  launch_year: 1985,
  top_notes: [coriander, plum, orange],
  heart_notes: [tuberose, orange_blossom, jasmine],
  base_notes: [amber, sandalwood, musk, honey],
  reformulated: true
)

# --- DIOR HYPNOTIC POISON ---
hypnotic_poison = create_perfume_with_notes(
  brand: dior,
  name: "Hypnotic Poison",
  description: "Intoxicating vanilla-almond blend. Sensual and addictive.",
  gender: "female",
  launch_year: 1998,
  top_notes: [almond, apricot = find_or_create_note(name: "Apricot", family: "fruity")],
  heart_notes: [jasmine, rose, lily],
  base_notes: [vanilla, sandalwood, musk]
)

puts "✅ Created Dior perfumes"

# =============================================================================
# PERFUMES - TOM FORD
# =============================================================================
puts "\n🍾 Creating Tom Ford perfumes..."

# --- TOM FORD TOBACCO VANILLE ---
tobacco_vanille = create_perfume_with_notes(
  brand: tom_ford,
  name: "Tobacco Vanille",
  description: "Warm, spicy tobacco with sweet vanilla. The ultimate cozy, luxurious scent.",
  gender: "unisex",
  launch_year: 2007,
  perfumers: [olivier_gillotin],
  top_notes: [tobacco, ginger],
  heart_notes: [tonka, cacao = find_or_create_note(name: "Cacao", family: "gourmand"), vanilla],
  base_notes: [dried_fruits = find_or_create_note(name: "Dried Fruits", family: "fruity"), benzoin]
)

# TV DUPES
tobacco_mandarin = create_perfume_with_notes(
  brand: lattafa,
  name: "Raghba",
  description: "Sweet, vanilla-tobacco blend reminiscent of Tobacco Vanille.",
  gender: "unisex",
  launch_year: 2015,
  top_notes: [cardamom],
  heart_notes: [vanilla, saffron],
  base_notes: [musk, sandalwood]
)

tobacco_kilian_angel = create_perfume_with_notes(
  brand: fragrance_world,
  name: "Tobacco Vanilla",
  description: "Direct interpretation of the Tom Ford classic.",
  gender: "unisex",
  launch_year: 2020,
  top_notes: [tobacco],
  heart_notes: [tonka, vanilla],
  base_notes: [benzoin, cacao]
)

create_dupe(original: tobacco_vanille, dupe: tobacco_mandarin)
create_dupe(original: tobacco_vanille, dupe: tobacco_kilian_angel)

# --- TOM FORD OUD WOOD ---
oud_wood = create_perfume_with_notes(
  brand: tom_ford,
  name: "Oud Wood",
  description: "Sophisticated oud with sandalwood and vetiver. Accessible, refined, and elegant.",
  gender: "unisex",
  launch_year: 2007,
  perfumers: [rodrigo_flores_roux],
  top_notes: [oud, rosewood, cardamom],
  heart_notes: [sandalwood, vetiver],
  base_notes: [tonka, amber]
)

# Oud Wood DUPES
just_oud = create_perfume_with_notes(
  brand: lattafa,
  name: "Ameer Al Oud",
  description: "Budget-friendly oud-sandalwood blend inspired by Oud Wood.",
  gender: "unisex",
  launch_year: 2018,
  top_notes: [oud],
  heart_notes: [sandalwood, rose],
  base_notes: [musk, amber]
)

zara_oud = create_perfume_with_notes(
  brand: zara,
  name: "Oud Couture",
  description: "Surprisingly good Oud Wood alternative at Zara prices.",
  gender: "unisex",
  launch_year: 2019,
  top_notes: [oud],
  heart_notes: [sandalwood, vetiver],
  base_notes: [amber, musk]
)

create_dupe(original: oud_wood, dupe: just_oud)
create_dupe(original: oud_wood, dupe: zara_oud)

# --- TOM FORD TUSCAN LEATHER ---
tuscan_leather = create_perfume_with_notes(
  brand: tom_ford,
  name: "Tuscan Leather",
  description: "Bold raspberry-leather combination. Raw, sensual, and unapologetically luxurious.",
  gender: "unisex",
  launch_year: 2007,
  perfumers: [olivier_gillotin],
  top_notes: [raspberry, saffron],
  heart_notes: [jasmine, thyme = find_or_create_note(name: "Thyme", family: "aromatic")],
  base_notes: [leather, amber, suede = find_or_create_note(name: "Suede", family: "animalic")]
)

# TL DUPES
la_tosca = create_perfume_with_notes(
  brand: rasasi,
  name: "La Yuqawam",
  description: "Popular Tuscan Leather alternative with similar raspberry-leather profile.",
  gender: "male",
  launch_year: 2014,
  top_notes: [raspberry, saffron],
  heart_notes: [jasmine],
  base_notes: [leather, amber, oud]
)

create_dupe(original: tuscan_leather, dupe: la_tosca)

# --- TOM FORD LOST CHERRY ---
lost_cherry = create_perfume_with_notes(
  brand: tom_ford,
  name: "Lost Cherry",
  description: "Luscious cherry liqueur meets almond and bitter cherry. Sweet, decadent indulgence.",
  gender: "unisex",
  launch_year: 2018,
  perfumers: [sonia_constant],
  top_notes: [cherry, bitter_almond = find_or_create_note(name: "Bitter Almond", family: "gourmand")],
  heart_notes: [cherry_liqueur = find_or_create_note(name: "Cherry Liqueur", family: "gourmand"), turkish_rose = find_or_create_note(name: "Turkish Rose", family: "floral")],
  base_notes: [vanilla, tonka, sandalwood, cedar]
)

# LC DUPES
cherry_punk = create_perfume_with_notes(
  brand: lattafa,
  name: "Teriaq",
  description: "Cherry-almond fragrance inspired by Lost Cherry.",
  gender: "unisex",
  launch_year: 2021,
  top_notes: [cherry, bitter_almond],
  heart_notes: [rose],
  base_notes: [vanilla, tonka]
)

lush_cherry = create_perfume_with_notes(
  brand: fragrance_world,
  name: "Lush Cherry",
  description: "Direct clone of Lost Cherry at a fraction of the price.",
  gender: "unisex",
  launch_year: 2021,
  top_notes: [cherry],
  heart_notes: [rose, jasmine],
  base_notes: [vanilla, sandalwood]
)

create_dupe(original: lost_cherry, dupe: cherry_punk)
create_dupe(original: lost_cherry, dupe: lush_cherry)

# --- TOM FORD BLACK ORCHID ---
black_orchid = create_perfume_with_notes(
  brand: tom_ford,
  name: "Black Orchid",
  description: "Dark, mysterious, and seductive. Rich florals with chocolate and patchouli.",
  gender: "female",
  launch_year: 2006,
  top_notes: [truffle = find_or_create_note(name: "Truffle", family: "gourmand"), blackcurrant, ylang_ylang],
  heart_notes: [orchid = find_or_create_note(name: "Orchid", family: "floral"), jasmine, lotus = find_or_create_note(name: "Lotus", family: "floral")],
  base_notes: [patchouli, chocolate, vanilla, incense]
)

# BO DUPES
black_orchid_clone = create_perfume_with_notes(
  brand: zara,
  name: "Black Amber",
  description: "Zara's interpretation of dark, orchid-like fragrances.",
  gender: "female",
  launch_year: 2018,
  top_notes: [blackcurrant],
  heart_notes: [jasmine, ylang_ylang],
  base_notes: [patchouli, vanilla, amber]
)

create_dupe(original: black_orchid, dupe: black_orchid_clone)

# --- TOM FORD NOIR EXTREME ---
noir_extreme = create_perfume_with_notes(
  brand: tom_ford,
  name: "Noir Extreme",
  description: "Warm, spicy, and gourmand. Cardamom and amber with kulfi ice cream accord.",
  gender: "male",
  launch_year: 2015,
  top_notes: [cardamom, nutmeg, mandarin],
  heart_notes: [rose, jasmine],
  base_notes: [amber, vanilla, sandalwood, tonka]
)

# --- TOM FORD NEROLI PORTOFINO ---
neroli_portofino = create_perfume_with_notes(
  brand: tom_ford,
  name: "Neroli Portofino",
  description: "Mediterranean freshness. Neroli, citrus, and amber evoke the Italian Riviera.",
  gender: "unisex",
  launch_year: 2011,
  top_notes: [bergamot, mandarin, lemon],
  heart_notes: [neroli = find_or_create_note(name: "Neroli", family: "floral"), orange_blossom, jasmine],
  base_notes: [amber, musk]
)

# NP DUPES
milestone = create_perfume_with_notes(
  brand: armaf,
  name: "Milestone",
  description: "Fresh citrus-neroli fragrance inspired by Neroli Portofino.",
  gender: "unisex",
  launch_year: 2016,
  top_notes: [bergamot, lemon],
  heart_notes: [neroli, orange_blossom],
  base_notes: [amber, musk]
)

create_dupe(original: neroli_portofino, dupe: milestone)

# --- TOM FORD BITTER PEACH ---
bitter_peach = create_perfume_with_notes(
  brand: tom_ford,
  name: "Bitter Peach",
  description: "Luscious peach with rum and vanilla. Fruity-gourmand indulgence.",
  gender: "unisex",
  launch_year: 2020,
  top_notes: [peach, blood_orange, cardamom],
  heart_notes: [davana = find_or_create_note(name: "Davana", family: "fruity"), rum = find_or_create_note(name: "Rum", family: "gourmand")],
  base_notes: [sandalwood, tonka, vanilla, benzoin]
)

# BP DUPES
peach_punch = create_perfume_with_notes(
  brand: fragrance_world,
  name: "Bitter Peach",
  description: "Direct clone of Tom Ford Bitter Peach.",
  gender: "unisex",
  launch_year: 2021,
  top_notes: [peach],
  heart_notes: [rum, vanilla],
  base_notes: [sandalwood, tonka]
)

create_dupe(original: bitter_peach, dupe: peach_punch)

puts "✅ Created Tom Ford perfumes"

# =============================================================================
# PERFUMES - PARFUMS DE MARLY
# =============================================================================
puts "\n🍾 Creating Parfums de Marly perfumes..."

# --- PDM LAYTON ---
layton = create_perfume_with_notes(
  brand: pdm,
  name: "Layton",
  description: "Apple, vanilla, and cardamom masterpiece. Sweet, spicy, and incredibly crowd-pleasing.",
  gender: "male",
  launch_year: 2016,
  perfumers: [hamid_merati],
  top_notes: [apple, bergamot, mandarin],
  heart_notes: [jasmine, violet, cardamom],
  base_notes: [vanilla, sandalwood, pepper = find_or_create_note(name: "Pepper", family: "spicy"), guaiac]
)

# Layton DUPES
khamrah = create_perfume_with_notes(
  brand: lattafa,
  name: "Khamrah",
  description: "Popular Layton alternative with boozy-vanilla warmth.",
  gender: "unisex",
  launch_year: 2022,
  top_notes: [bergamot, cinnamon, nutmeg],
  heart_notes: [praline, dates = find_or_create_note(name: "Dates", family: "fruity")],
  base_notes: [vanilla, tonka, benzoin, amber]
)

al_qiam = create_perfume_with_notes(
  brand: lattafa,
  name: "Al Qiam Gold",
  description: "Very close clone of Layton with excellent performance.",
  gender: "unisex",
  launch_year: 2022,
  top_notes: [apple, bergamot],
  heart_notes: [jasmine, cardamom],
  base_notes: [vanilla, sandalwood]
)

create_dupe(original: layton, dupe: khamrah)
create_dupe(original: layton, dupe: al_qiam)

# --- PDM HEROD ---
herod = create_perfume_with_notes(
  brand: pdm,
  name: "Herod",
  description: "Tobacco, cinnamon, and vanilla. Sophisticated smoky sweetness.",
  gender: "male",
  launch_year: 2012,
  perfumers: [hamid_merati],
  top_notes: [cinnamon, pepper, iso_e_super],
  heart_notes: [tobacco, incense],
  base_notes: [vanilla, tonka, cedar, musk]
)

# Herod DUPES
perseus = create_perfume_with_notes(
  brand: maison_alhambra,
  name: "Perseus",
  description: "Very close clone of Herod at a fraction of the price.",
  gender: "male",
  launch_year: 2021,
  top_notes: [cinnamon, pepper],
  heart_notes: [tobacco],
  base_notes: [vanilla, tonka, cedar]
)

create_dupe(original: herod, dupe: perseus)

# --- PDM PEGASUS ---
pegasus = create_perfume_with_notes(
  brand: pdm,
  name: "Pegasus",
  description: "Almond, vanilla, and sandalwood. Clean, elegant, and versatile.",
  gender: "male",
  launch_year: 2011,
  top_notes: [bergamot, heliotrope = find_or_create_note(name: "Heliotrope", family: "floral"), almond],
  heart_notes: [jasmine, bitter_almond, lavender],
  base_notes: [vanilla, sandalwood, amber, musk]
)

# Pegasus DUPES
arabians_tonka = create_perfume_with_notes(
  brand: montale = find_or_create_brand(name: "Montale", country: "France"),
  name: "Arabians Tonka",
  description: "Similar almond-vanilla-sandalwood profile to Pegasus.",
  gender: "unisex",
  launch_year: 2018,
  top_notes: [bergamot],
  heart_notes: [almond],
  base_notes: [vanilla, tonka, sandalwood]
)

create_dupe(original: pegasus, dupe: arabians_tonka)

# --- PDM SEDLEY ---
sedley = create_perfume_with_notes(
  brand: pdm,
  name: "Sedley",
  description: "Fresh, minty, and invigorating. Clean spearmint with geranium.",
  gender: "male",
  launch_year: 2019,
  top_notes: [mint, bergamot, grapefruit],
  heart_notes: [geranium, lavender],
  base_notes: [sandalwood, musk]
)

# --- PDM PERCIVAL ---
percival = create_perfume_with_notes(
  brand: pdm,
  name: "Percival",
  description: "Fresh, clean, and modern. Fruity-woody with excellent mass appeal.",
  gender: "male",
  launch_year: 2018,
  top_notes: [bergamot, mandarin, green_notes],
  heart_notes: [geranium, lavender, jasmine],
  base_notes: [musk, amber, cedar]
)

# --- PDM CARLISLE ---
carlisle = create_perfume_with_notes(
  brand: pdm,
  name: "Carlisle",
  description: "Rich, spicy rose and oud. Dark, luxurious, and long-lasting.",
  gender: "unisex",
  launch_year: 2015,
  top_notes: [green_apple = find_or_create_note(name: "Green Apple", family: "fruity"), nutmeg],
  heart_notes: [rose, patchouli, oud],
  base_notes: [vanilla, musk, cedar]
)

# --- PDM DELINA ---
delina = create_perfume_with_notes(
  brand: pdm,
  name: "Delina",
  description: "Modern feminine floral. Rose, peony, and litchi create fresh elegance.",
  gender: "female",
  launch_year: 2017,
  top_notes: [litchi = find_or_create_note(name: "Litchi", family: "fruity"), rhubarb = find_or_create_note(name: "Rhubarb", family: "fruity"), bergamot],
  heart_notes: [peony, rose, vanilla],
  base_notes: [musk, cedar, cashmeran = find_or_create_note(name: "Cashmeran", family: "woody")]
)

# Delina DUPES
yara = create_perfume_with_notes(
  brand: lattafa,
  name: "Yara",
  description: "Popular Delina dupe with similar fruity-floral profile.",
  gender: "female",
  launch_year: 2021,
  top_notes: [tangerine = find_or_create_note(name: "Tangerine", family: "citrus"), heliotrope],
  heart_notes: [peony, jasmine],
  base_notes: [vanilla, musk, sandalwood]
)

create_dupe(original: delina, dupe: yara)

# --- PDM GODOLPHIN ---
godolphin = create_perfume_with_notes(
  brand: pdm,
  name: "Godolphin",
  description: "Leathery, fruity, and complex. Rich dried fruits with leather backbone.",
  gender: "male",
  launch_year: 2012,
  top_notes: [plum, raspberry],
  heart_notes: [iris, rose],
  base_notes: [leather, oud, amber]
)

# --- PDM OAJAN ---
oajan = create_perfume_with_notes(
  brand: pdm,
  name: "Oajan",
  description: "Decadent honey, cinnamon, and benzoin. Rich oriental gourmand.",
  gender: "unisex",
  launch_year: 2013,
  top_notes: [cinnamon, honey],
  heart_notes: [benzoin, sandalwood],
  base_notes: [amber, vanilla, musk]
)

puts "✅ Created PDM perfumes"

# =============================================================================
# SUMMARY
# =============================================================================
puts "\n" + "=" * 60
puts "🎉 SEEDS PART 1 COMPLETE!"
puts "=" * 60
puts "📊 Statistics:"
puts "   - Brands: #{Brand.count}"
puts "   - Perfumers: #{Perfumer.count}"
puts "   - Notes: #{Note.count}"
puts "   - Perfumes: #{Perfume.count}"
puts "   - Dupe relationships: #{PerfumeDupe.count}"
puts "=" * 60


# =============================================================================
# MySillage Seeds - Part 2/4
# Brands: Initio, YSL, Gucci, Maison Margiela, Givenchy
# =============================================================================
# Run this AFTER seeds_part1.rb
# =============================================================================

puts "🌸 Starting MySillage Seeds - Part 2..."
puts "=" * 60

# Helper methods
def find_or_create_brand(name:, country:, description: nil)
  Brand.find_or_create_by!(name: name) { |b| b.country = country; b.description = description }
end

def find_or_create_perfumer(name:, bio: nil)
  Perfumer.find_or_create_by!(name: name) { |p| p.bio = bio }
end

def find_or_create_note(name:, family:)
  Note.find_or_create_by!(name: name) { |n| n.family = family }
end

def create_perfume_with_notes(brand:, name:, description:, gender:, launch_year:,
                               perfumers: [], top_notes: [], heart_notes: [], base_notes: [],
                               discontinued: false, reformulated: false)
  perfume = Perfume.find_or_create_by!(brand: brand, name: name) do |p|
    p.description = description
    p.gender = gender
    p.launch_year = launch_year
    p.discontinued = discontinued
    p.reformulated = reformulated
  end
  perfumers.each { |pf| PerfumePerfumer.find_or_create_by!(perfume: perfume, perfumer: pf) }
  top_notes.each { |n| PerfumeNote.find_or_create_by!(perfume: perfume, note: n, note_type: 'top') }
  heart_notes.each { |n| PerfumeNote.find_or_create_by!(perfume: perfume, note: n, note_type: 'heart') }
  base_notes.each { |n| PerfumeNote.find_or_create_by!(perfume: perfume, note: n, note_type: 'base') }
  perfume
end

def create_dupe(original:, dupe:)
  PerfumeDupe.find_or_create_by!(original_perfume: original, dupe: dupe)
end

# =============================================================================
# BRANDS
# =============================================================================
puts "\n📦 Creating brands..."

initio = find_or_create_brand(name: "Initio Parfums Privés", country: "France",
  description: "Founded in 2015, Initio explores the power of scent to seduce and heal.")

ysl = find_or_create_brand(name: "Yves Saint Laurent", country: "France",
  description: "Legendary fashion house creating iconic fragrances since 1964.")

gucci = find_or_create_brand(name: "Gucci", country: "Italy",
  description: "Italian luxury house with a rich perfume heritage.")

margiela = find_or_create_brand(name: "Maison Margiela", country: "France",
  description: "Avant-garde house known for the Replica collection - fragrances that capture memories.")

givenchy = find_or_create_brand(name: "Givenchy", country: "France",
  description: "Founded by Hubert de Givenchy in 1952, creating elegant fragrances.")

# Dupe brands
lattafa = find_or_create_brand(name: "Lattafa", country: "UAE")
armaf = find_or_create_brand(name: "Armaf", country: "UAE")
maison_alhambra = find_or_create_brand(name: "Maison Alhambra", country: "UAE")
paris_corner = find_or_create_brand(name: "Paris Corner", country: "UAE")
zara = find_or_create_brand(name: "Zara", country: "Spain")
lalique = find_or_create_brand(name: "Lalique", country: "France")

# =============================================================================
# PERFUMERS
# =============================================================================
puts "\n👃 Creating perfumers..."

alberto_morillas = find_or_create_perfumer(name: "Alberto Morillas", bio: "Creator of CK One, Acqua di Gio")
dominique_ropion = find_or_create_perfumer(name: "Dominique Ropion", bio: "Legendary IFF perfumer")
anne_flipo = find_or_create_perfumer(name: "Anne Flipo", bio: "IFF perfumer, La Nuit de l'Homme")
marie_salamagne = find_or_create_perfumer(name: "Marie Salamagne", bio: "Firmenich, By the Fireplace creator")
daniela_andrier = find_or_create_perfumer(name: "Daniela Andrier", bio: "Givaudan, Replica fragrances")

# =============================================================================
# NOTES
# =============================================================================
puts "\n🌿 Setting up notes..."

# Core notes
bergamot = find_or_create_note(name: "Bergamot", family: "citrus")
lemon = find_or_create_note(name: "Lemon", family: "citrus")
orange = find_or_create_note(name: "Orange", family: "citrus")
mandarin = find_or_create_note(name: "Mandarin", family: "citrus")
grapefruit = find_or_create_note(name: "Grapefruit", family: "citrus")
pink_pepper = find_or_create_note(name: "Pink Pepper", family: "spicy")
black_pepper = find_or_create_note(name: "Black Pepper", family: "spicy")
cardamom = find_or_create_note(name: "Cardamom", family: "spicy")
saffron = find_or_create_note(name: "Saffron", family: "spicy")
cinnamon = find_or_create_note(name: "Cinnamon", family: "spicy")
nutmeg = find_or_create_note(name: "Nutmeg", family: "spicy")
clove = find_or_create_note(name: "Clove", family: "spicy")
ginger = find_or_create_note(name: "Ginger", family: "spicy")
rose = find_or_create_note(name: "Rose", family: "floral")
jasmine = find_or_create_note(name: "Jasmine", family: "floral")
iris = find_or_create_note(name: "Iris", family: "floral")
lavender = find_or_create_note(name: "Lavender", family: "floral")
violet = find_or_create_note(name: "Violet", family: "floral")
tuberose = find_or_create_note(name: "Tuberose", family: "floral")
orange_blossom = find_or_create_note(name: "Orange Blossom", family: "floral")
ylang_ylang = find_or_create_note(name: "Ylang-Ylang", family: "floral")
neroli = find_or_create_note(name: "Neroli", family: "floral")
geranium = find_or_create_note(name: "Geranium", family: "floral")
peony = find_or_create_note(name: "Peony", family: "floral")
gardenia = find_or_create_note(name: "Gardenia", family: "floral")
heliotrope = find_or_create_note(name: "Heliotrope", family: "floral")
vanilla = find_or_create_note(name: "Vanilla", family: "oriental")
tonka = find_or_create_note(name: "Tonka Bean", family: "oriental")
amber = find_or_create_note(name: "Amber", family: "oriental")
benzoin = find_or_create_note(name: "Benzoin", family: "oriental")
musk = find_or_create_note(name: "Musk", family: "musk")
white_musk = find_or_create_note(name: "White Musk", family: "musk")
sandalwood = find_or_create_note(name: "Sandalwood", family: "woody")
cedar = find_or_create_note(name: "Cedar", family: "woody")
vetiver = find_or_create_note(name: "Vetiver", family: "woody")
oud = find_or_create_note(name: "Oud", family: "woody")
patchouli = find_or_create_note(name: "Patchouli", family: "woody")
guaiac = find_or_create_note(name: "Guaiac Wood", family: "woody")
cashmeran = find_or_create_note(name: "Cashmeran", family: "woody")
leather = find_or_create_note(name: "Leather", family: "animalic")
tobacco = find_or_create_note(name: "Tobacco", family: "gourmand")
coffee = find_or_create_note(name: "Coffee", family: "gourmand")
honey = find_or_create_note(name: "Honey", family: "gourmand")
praline = find_or_create_note(name: "Praline", family: "gourmand")
rum = find_or_create_note(name: "Rum", family: "gourmand")
coconut = find_or_create_note(name: "Coconut", family: "gourmand")
ambroxan = find_or_create_note(name: "Ambroxan", family: "synthetic")
iso_e_super = find_or_create_note(name: "Iso E Super", family: "synthetic")
# Fruits
apple = find_or_create_note(name: "Apple", family: "fruity")
pear = find_or_create_note(name: "Pear", family: "fruity")
peach = find_or_create_note(name: "Peach", family: "fruity")
plum = find_or_create_note(name: "Plum", family: "fruity")
raspberry = find_or_create_note(name: "Raspberry", family: "fruity")
strawberry = find_or_create_note(name: "Strawberry", family: "fruity")
blackcurrant = find_or_create_note(name: "Blackcurrant", family: "fruity")
# Additional
smoke = find_or_create_note(name: "Smoke", family: "aromatic")
chestnut = find_or_create_note(name: "Chestnut", family: "gourmand")
carrot = find_or_create_note(name: "Carrot Seeds", family: "aromatic")
green_notes = find_or_create_note(name: "Green Notes", family: "green")
cypress = find_or_create_note(name: "Cypress", family: "woody")
sage = find_or_create_note(name: "Sage", family: "aromatic")
basil = find_or_create_note(name: "Basil", family: "aromatic")
clary_sage = find_or_create_note(name: "Clary Sage", family: "aromatic")
bitter_almond = find_or_create_note(name: "Bitter Almond", family: "gourmand")
milk = find_or_create_note(name: "Milk", family: "gourmand")
brown_sugar = find_or_create_note(name: "Brown Sugar", family: "gourmand")
green_tea = find_or_create_note(name: "Green Tea", family: "aromatic")
aldehydes = find_or_create_note(name: "Aldehydes", family: "synthetic")
lily_valley = find_or_create_note(name: "Lily of the Valley", family: "floral")
styrax = find_or_create_note(name: "Styrax", family: "oriental")
moss = find_or_create_note(name: "Moss", family: "woody")
mimosa = find_or_create_note(name: "Mimosa", family: "floral")
orchid = find_or_create_note(name: "Orchid", family: "floral")
anise = find_or_create_note(name: "Anise", family: "spicy")
white_pepper = find_or_create_note(name: "White Pepper", family: "spicy")
coriander = find_or_create_note(name: "Coriander", family: "spicy")
carnation = find_or_create_note(name: "Carnation", family: "floral")
juniper_berry = find_or_create_note(name: "Juniper Berry", family: "aromatic")

# =============================================================================
# INITIO PERFUMES
# =============================================================================
puts "\n🍾 Creating Initio perfumes..."

side_effect = create_perfume_with_notes(
  brand: initio, name: "Side Effect",
  description: "Addictive vanilla-tobacco with rum and cinnamon. Sweet, boozy, and long-lasting.",
  gender: "unisex", launch_year: 2016,
  top_notes: [cinnamon, rum],
  heart_notes: [tobacco, benzoin],
  base_notes: [vanilla, sandalwood, musk]
)

oud_for_greatness = create_perfume_with_notes(
  brand: initio, name: "Oud for Greatness",
  description: "Luxurious oud with saffron and lavender. Powerful and opulent.",
  gender: "unisex", launch_year: 2018,
  top_notes: [saffron, lavender, nutmeg],
  heart_notes: [oud],
  base_notes: [musk, amber]
)

# OFG Dupe
oud_glory = create_perfume_with_notes(
  brand: lattafa, name: "Oud for Glory",
  description: "Very close clone of Oud for Greatness at a fraction of the price.",
  gender: "unisex", launch_year: 2022,
  top_notes: [saffron, lavender],
  heart_notes: [oud],
  base_notes: [musk]
)
create_dupe(original: oud_for_greatness, dupe: oud_glory)

musk_therapy = create_perfume_with_notes(
  brand: initio, name: "Musk Therapy",
  description: "Clean, sensual white musk. Skin-like and deeply calming.",
  gender: "unisex", launch_year: 2016,
  top_notes: [bergamot, rose],
  heart_notes: [white_musk],
  base_notes: [sandalwood, amber]
)

rehab = create_perfume_with_notes(
  brand: initio, name: "Rehab",
  description: "Lavender-vanilla-tonka seduction. Smooth, creamy, and addictive.",
  gender: "unisex", launch_year: 2017,
  top_notes: [lavender],
  heart_notes: [tonka, vanilla],
  base_notes: [sandalwood, cashmeran, musk]
)

atomic_rose = create_perfume_with_notes(
  brand: initio, name: "Atomic Rose",
  description: "Explosive rose with oud and animalic undertones. Bold and provocative.",
  gender: "unisex", launch_year: 2019,
  top_notes: [bergamot, rose],
  heart_notes: [rose, oud],
  base_notes: [amber, musk, vanilla]
)

puts "✅ Created Initio perfumes"

# =============================================================================
# YSL PERFUMES
# =============================================================================
puts "\n🍾 Creating YSL perfumes..."

la_nuit = create_perfume_with_notes(
  brand: ysl, name: "La Nuit de l'Homme",
  description: "Cardamom, lavender, and cedar. The quintessential date night fragrance.",
  gender: "male", launch_year: 2009, reformulated: true,
  perfumers: [anne_flipo, dominique_ropion],
  top_notes: [cardamom, bergamot, carrot],
  heart_notes: [lavender, cedar, violet],
  base_notes: [vetiver, tonka]
)

# La Nuit Dupe
encre_noire_sport = create_perfume_with_notes(
  brand: lalique, name: "Encre Noire Sport",
  description: "Often compared to La Nuit for similar woody-lavender DNA.",
  gender: "male", launch_year: 2013,
  top_notes: [grapefruit, bergamot],
  heart_notes: [vetiver, cypress],
  base_notes: [musk, cashmeran]
)
create_dupe(original: la_nuit, dupe: encre_noire_sport)

y_edp = create_perfume_with_notes(
  brand: ysl, name: "Y Eau de Parfum",
  description: "Fresh apple, sage, and ambergris. Modern and mass-appealing.",
  gender: "male", launch_year: 2018,
  top_notes: [apple, ginger, bergamot],
  heart_notes: [sage, juniper_berry, geranium],
  base_notes: [ambroxan, cedar, tonka]
)

libre = create_perfume_with_notes(
  brand: ysl, name: "Libre",
  description: "Lavender meets orange blossom. Bold feminine freedom.",
  gender: "female", launch_year: 2019,
  top_notes: [lavender, mandarin, blackcurrant],
  heart_notes: [jasmine, orange_blossom],
  base_notes: [vanilla, cedar, musk]
)

black_opium = create_perfume_with_notes(
  brand: ysl, name: "Black Opium",
  description: "Coffee, vanilla, and white flowers. Addictive feminine.",
  gender: "female", launch_year: 2014,
  top_notes: [pink_pepper, orange, pear],
  heart_notes: [coffee, jasmine, bitter_almond],
  base_notes: [vanilla, patchouli, cedar]
)

# Black Opium Dupe
zara_nuit = create_perfume_with_notes(
  brand: zara, name: "Nuit",
  description: "Sweet coffee-vanilla inspired by Black Opium.",
  gender: "female", launch_year: 2017,
  top_notes: [pink_pepper],
  heart_notes: [coffee, jasmine],
  base_notes: [vanilla, patchouli]
)
create_dupe(original: black_opium, dupe: zara_nuit)

lhomme = create_perfume_with_notes(
  brand: ysl, name: "L'Homme",
  description: "Ginger, vetiver, and white pepper. Clean, elegant, office-friendly.",
  gender: "male", launch_year: 2006, reformulated: true,
  top_notes: [ginger, bergamot, lemon],
  heart_notes: [violet, white_pepper],
  base_notes: [vetiver, cedar, tonka]
)

kouros = create_perfume_with_notes(
  brand: ysl, name: "Kouros",
  description: "Bold animalic fougère. The legendary powerhouse from the 80s.",
  gender: "male", launch_year: 1981, reformulated: true,
  top_notes: [coriander, clary_sage],
  heart_notes: [carnation, jasmine, geranium],
  base_notes: [musk, honey, leather]
)

mon_paris = create_perfume_with_notes(
  brand: ysl, name: "Mon Paris",
  description: "Romantic Paris in a bottle. Strawberry, peony, and white musk.",
  gender: "female", launch_year: 2016,
  top_notes: [strawberry, raspberry, bergamot],
  heart_notes: [peony, jasmine],
  base_notes: [patchouli, white_musk, ambroxan]
)

puts "✅ Created YSL perfumes"

# =============================================================================
# GUCCI PERFUMES
# =============================================================================
puts "\n🍾 Creating Gucci perfumes..."

guilty_homme = create_perfume_with_notes(
  brand: gucci, name: "Guilty Pour Homme",
  description: "Italian lemon, lavender, and cedar. Sophisticated masculinity.",
  gender: "male", launch_year: 2011,
  top_notes: [lemon, lavender, bergamot],
  heart_notes: [orange_blossom, neroli],
  base_notes: [cedar, patchouli, amber]
)

guilty_absolute = create_perfume_with_notes(
  brand: gucci, name: "Guilty Absolute",
  description: "Dark, woody, and leathery. Challenging and sophisticated.",
  gender: "male", launch_year: 2017, perfumers: [alberto_morillas],
  top_notes: [leather],
  heart_notes: [cypress, vetiver],
  base_notes: [patchouli, leather]
)

bloom = create_perfume_with_notes(
  brand: gucci, name: "Bloom",
  description: "White floral explosion. Tuberose and jasmine create a lush garden.",
  gender: "female", launch_year: 2017, perfumers: [alberto_morillas],
  top_notes: [green_notes],
  heart_notes: [tuberose, jasmine],
  base_notes: [sandalwood, musk]
)

memoire = create_perfume_with_notes(
  brand: gucci, name: "Mémoire d'une Odeur",
  description: "Roman chamomile and jasmine. Unique, genderless, nostalgic.",
  gender: "unisex", launch_year: 2019, perfumers: [alberto_morillas],
  top_notes: [bitter_almond],
  heart_notes: [jasmine, musk],
  base_notes: [cedar, sandalwood, vanilla]
)

flora_gardenia = create_perfume_with_notes(
  brand: gucci, name: "Flora Gorgeous Gardenia",
  description: "Radiant gardenia with pear and brown sugar. Fresh, sweet femininity.",
  gender: "female", launch_year: 2021, perfumers: [alberto_morillas],
  top_notes: [pear, pink_pepper],
  heart_notes: [gardenia, jasmine],
  base_notes: [patchouli, brown_sugar, musk]
)

gucci_homme_2 = create_perfume_with_notes(
  brand: gucci, name: "Gucci pour Homme II",
  description: "Tea, cinnamon, and tobacco. Elegant discontinued classic.",
  gender: "male", launch_year: 2007, discontinued: true,
  top_notes: [bergamot, violet, green_tea],
  heart_notes: [cinnamon, jasmine],
  base_notes: [tobacco, amber, musk]
)

rush = create_perfume_with_notes(
  brand: gucci, name: "Rush",
  description: "Synthetic tropical cocktail. Cult 90s classic with peach and patchouli.",
  gender: "female", launch_year: 1999,
  top_notes: [peach],
  heart_notes: [gardenia, coriander, rose],
  base_notes: [patchouli, vanilla, vetiver]
)

puts "✅ Created Gucci perfumes"

# =============================================================================
# MAISON MARGIELA REPLICA
# =============================================================================
puts "\n🍾 Creating Maison Margiela perfumes..."

by_the_fireplace = create_perfume_with_notes(
  brand: margiela, name: "By the Fireplace",
  description: "Cozy fire, burning wood, and chestnuts. Winter comfort in a bottle.",
  gender: "unisex", launch_year: 2015, perfumers: [marie_salamagne],
  top_notes: [clove, pink_pepper, orange],
  heart_notes: [chestnut, guaiac, smoke],
  base_notes: [vanilla, cashmeran, benzoin]
)

# By the Fireplace Dupe
khamrah_qahwa = create_perfume_with_notes(
  brand: lattafa, name: "Khamrah Qahwa",
  description: "Smoky, warm fragrance with fireplace vibes.",
  gender: "unisex", launch_year: 2023,
  top_notes: [coffee, saffron],
  heart_notes: [praline],
  base_notes: [vanilla, benzoin, oud]
)
create_dupe(original: by_the_fireplace, dupe: khamrah_qahwa)

jazz_club = create_perfume_with_notes(
  brand: margiela, name: "Jazz Club",
  description: "Smoky jazz bar atmosphere. Tobacco, rum, and leather.",
  gender: "male", launch_year: 2013, perfumers: [marie_salamagne],
  top_notes: [pink_pepper, lemon, neroli],
  heart_notes: [rum, clary_sage, tobacco],
  base_notes: [vetiver, tonka, vanilla, styrax]
)

coffee_break = create_perfume_with_notes(
  brand: margiela, name: "Coffee Break",
  description: "Morning coffee ritual. Lavender latte with milk foam.",
  gender: "unisex", launch_year: 2018, perfumers: [marie_salamagne],
  top_notes: [lavender, bergamot],
  heart_notes: [coffee, milk],
  base_notes: [vanilla, musk, cedar]
)

beach_walk = create_perfume_with_notes(
  brand: margiela, name: "Beach Walk",
  description: "Sun-kissed skin on the shore. Coconut, salt, and heliotrope.",
  gender: "unisex", launch_year: 2012, perfumers: [daniela_andrier],
  top_notes: [bergamot, lemon, pink_pepper],
  heart_notes: [ylang_ylang, coconut, heliotrope],
  base_notes: [musk, cedar, benzoin]
)

whispers_library = create_perfume_with_notes(
  brand: margiela, name: "Whispers in the Library",
  description: "Old books, wood, and vanilla. Intellectual coziness.",
  gender: "unisex", launch_year: 2019, perfumers: [daniela_andrier],
  top_notes: [black_pepper],
  heart_notes: [cedar, vetiver],
  base_notes: [benzoin, tonka, vanilla]
)

lazy_sunday = create_perfume_with_notes(
  brand: margiela, name: "Lazy Sunday Morning",
  description: "Fresh white sheets and skin. Clean, floral, and comforting.",
  gender: "unisex", launch_year: 2012, perfumers: [daniela_andrier],
  top_notes: [pear, aldehydes, lily_valley],
  heart_notes: [iris, rose],
  base_notes: [white_musk, ambroxan]
)

bubble_bath = create_perfume_with_notes(
  brand: margiela, name: "Bubble Bath",
  description: "Clean soapy comfort. Fresh bathroom after a warm bath.",
  gender: "unisex", launch_year: 2020,
  top_notes: [bergamot, lavender, pink_pepper],
  heart_notes: [rose, jasmine, coconut],
  base_notes: [white_musk, cedar, iso_e_super]
)

autumn_vibes = create_perfume_with_notes(
  brand: margiela, name: "Autumn Vibes",
  description: "Stroll through fallen leaves. Woody, earthy, and nostalgic.",
  gender: "unisex", launch_year: 2021,
  top_notes: [cardamom, pink_pepper, bergamot],
  heart_notes: [styrax, cedar],
  base_notes: [musk, moss]
)

puts "✅ Created Maison Margiela perfumes"

# =============================================================================
# GIVENCHY PERFUMES
# =============================================================================
puts "\n🍾 Creating Givenchy perfumes..."

gentleman_edp = create_perfume_with_notes(
  brand: givenchy, name: "Gentleman Eau de Parfum",
  description: "Lavender and iris with a heart of whiskey accord. Modern dandyism.",
  gender: "male", launch_year: 2018,
  top_notes: [lavender, cardamom, pear],
  heart_notes: [iris, orange_blossom],
  base_notes: [patchouli, vanilla, leather]
)

# Gentleman Dupe
gent_irresistible = create_perfume_with_notes(
  brand: maison_alhambra, name: "Gent Irresistible",
  description: "Affordable alternative to Gentleman EDP.",
  gender: "male", launch_year: 2022,
  top_notes: [lavender, cardamom],
  heart_notes: [iris],
  base_notes: [patchouli, vanilla]
)
create_dupe(original: gentleman_edp, dupe: gent_irresistible)

gentleman_intense = create_perfume_with_notes(
  brand: givenchy, name: "Gentleman Eau de Parfum Intense",
  description: "Darker, spicier version with tobacco and leather.",
  gender: "male", launch_year: 2021,
  top_notes: [cardamom, ginger],
  heart_notes: [iris, tobacco],
  base_notes: [patchouli, leather, vanilla]
)

linterdit = create_perfume_with_notes(
  brand: givenchy, name: "L'Interdit",
  description: "White florals and vetiver. Modern take on the forbidden.",
  gender: "female", launch_year: 2018,
  top_notes: [pear, bergamot],
  heart_notes: [tuberose, orange_blossom, jasmine],
  base_notes: [patchouli, vetiver, ambroxan]
)

# L'Interdit Dupe
eclaire = create_perfume_with_notes(
  brand: lattafa, name: "Eclaire",
  description: "White floral with vetiver inspired by L'Interdit.",
  gender: "female", launch_year: 2021,
  top_notes: [pear, bergamot],
  heart_notes: [tuberose, orange_blossom],
  base_notes: [patchouli, vetiver, musk]
)
create_dupe(original: linterdit, dupe: eclaire)

pi = create_perfume_with_notes(
  brand: givenchy, name: "Pi",
  description: "Warm vanilla and benzoin with neroli. Mathematical precision in scent.",
  gender: "male", launch_year: 1998, reformulated: true,
  top_notes: [mandarin, neroli, basil],
  heart_notes: [geranium, anise],
  base_notes: [vanilla, benzoin, tonka, cedar]
)

amarige = create_perfume_with_notes(
  brand: givenchy, name: "Amarige",
  description: "Bold floral explosion. Mimosa, gardenia, and violet.",
  gender: "female", launch_year: 1991, reformulated: true,
  top_notes: [violet, plum, orange_blossom, neroli],
  heart_notes: [gardenia, mimosa, ylang_ylang],
  base_notes: [musk, sandalwood, vanilla]
)

irresistible = create_perfume_with_notes(
  brand: givenchy, name: "Irresistible Eau de Parfum",
  description: "Rose with pear and ambroxan. Joyful and radiant femininity.",
  gender: "female", launch_year: 2020,
  top_notes: [pear],
  heart_notes: [rose, iris],
  base_notes: [ambroxan, musk, cedar]
)

ange_demon = create_perfume_with_notes(
  brand: givenchy, name: "Ange ou Démon",
  description: "Duality of angel and demon. Floral-oriental mystique.",
  gender: "female", launch_year: 2006,
  top_notes: [mandarin, saffron],
  heart_notes: [lily_valley, orchid],
  base_notes: [tonka, vanilla, sandalwood]
)

very_irresistible = create_perfume_with_notes(
  brand: givenchy, name: "Very Irresistible",
  description: "Fresh rose and anise. Playful and charming.",
  gender: "female", launch_year: 2003,
  top_notes: [anise, lemon],
  heart_notes: [rose, peony, violet],
  base_notes: [patchouli, vanilla, musk]
)

puts "✅ Created Givenchy perfumes"

# =============================================================================
# SUMMARY
# =============================================================================
puts "\n" + "=" * 60
puts "🎉 SEEDS PART 2 COMPLETE!"
puts "=" * 60
puts "📊 Statistics:"
puts "   - Brands: #{Brand.count}"
puts "   - Perfumers: #{Perfumer.count}"
puts "   - Notes: #{Note.count}"
puts "   - Perfumes: #{Perfume.count}"
puts "   - Dupe relationships: #{PerfumeDupe.count}"
puts "=" * 60

# =============================================================================
# MySillage Seeds - Part 3/4
# Brands: Louis Vuitton, Xerjoff, Frédéric Malle, Amouage, Jean Paul Gaultier
# =============================================================================
# Run this AFTER seeds_part2.rb
# =============================================================================

puts "🌸 Starting MySillage Seeds - Part 3..."
puts "=" * 60

# Helper methods
def find_or_create_brand(name:, country:, description: nil)
  Brand.find_or_create_by!(name: name) { |b| b.country = country; b.description = description }
end

def find_or_create_perfumer(name:, bio: nil)
  Perfumer.find_or_create_by!(name: name) { |p| p.bio = bio }
end

def find_or_create_note(name:, family:)
  Note.find_or_create_by!(name: name) { |n| n.family = family }
end

def create_perfume_with_notes(brand:, name:, description:, gender:, launch_year:,
                               perfumers: [], top_notes: [], heart_notes: [], base_notes: [],
                               discontinued: false, reformulated: false)
  perfume = Perfume.find_or_create_by!(brand: brand, name: name) do |p|
    p.description = description
    p.gender = gender
    p.launch_year = launch_year
    p.discontinued = discontinued
    p.reformulated = reformulated
  end
  perfumers.each { |pf| PerfumePerfumer.find_or_create_by!(perfume: perfume, perfumer: pf) }
  top_notes.each { |n| PerfumeNote.find_or_create_by!(perfume: perfume, note: n, note_type: 'top') }
  heart_notes.each { |n| PerfumeNote.find_or_create_by!(perfume: perfume, note: n, note_type: 'heart') }
  base_notes.each { |n| PerfumeNote.find_or_create_by!(perfume: perfume, note: n, note_type: 'base') }
  perfume
end

def create_dupe(original:, dupe:)
  PerfumeDupe.find_or_create_by!(original_perfume: original, dupe: dupe)
end

# =============================================================================
# BRANDS
# =============================================================================
puts "\n📦 Creating brands..."

louis_vuitton = find_or_create_brand(name: "Louis Vuitton", country: "France",
  description: "Legendary luxury house entering fine fragrance in 2016 with Jacques Cavallier Belletrud as master perfumer.")

xerjoff = find_or_create_brand(name: "Xerjoff", country: "Italy",
  description: "Founded in 2003 in Turin, Italy. Ultra-luxury niche house known for exceptional quality and ornate bottles.")

frederic_malle = find_or_create_brand(name: "Frédéric Malle", country: "France",
  description: "Founded in 2000, Editions de Parfums Frédéric Malle gives full creative freedom to world's best perfumers.")

amouage = find_or_create_brand(name: "Amouage", country: "Oman",
  description: "The gift of kings. Founded in 1983 in Oman, Amouage represents Middle Eastern luxury at its finest.")

jpg = find_or_create_brand(name: "Jean Paul Gaultier", country: "France",
  description: "Iconic fashion designer's fragrance line since 1993. Known for Le Male and provocative bottle designs.")

# Dupe brands
lattafa = find_or_create_brand(name: "Lattafa", country: "UAE")
armaf = find_or_create_brand(name: "Armaf", country: "UAE")
maison_alhambra = find_or_create_brand(name: "Maison Alhambra", country: "UAE")
fragrance_world = find_or_create_brand(name: "Fragrance World", country: "UAE")
al_haramain = find_or_create_brand(name: "Al Haramain", country: "UAE")
paris_corner = find_or_create_brand(name: "Paris Corner", country: "UAE")
rasasi = find_or_create_brand(name: "Rasasi", country: "UAE")

# =============================================================================
# PERFUMERS
# =============================================================================
puts "\n👃 Creating perfumers..."

jacques_cavallier = find_or_create_perfumer(name: "Jacques Cavallier Belletrud",
  bio: "Louis Vuitton's master perfumer and Firmenich icon. Creator of L'Eau d'Issey and Gaultier².")

sergio_momo = find_or_create_perfumer(name: "Sergio Momo",
  bio: "Founder and nose of Xerjoff. Italian luxury perfumery visionary.")

dominique_ropion = find_or_create_perfumer(name: "Dominique Ropion",
  bio: "IFF master perfumer behind Portrait of a Lady and Carnal Flower.")

maurice_roucel = find_or_create_perfumer(name: "Maurice Roucel",
  bio: "Creator of Musc Ravageur and 24 Faubourg. Known for sensual compositions.")

jean_claude_ellena = find_or_create_perfumer(name: "Jean-Claude Ellena",
  bio: "Minimalist master, longtime Hermès exclusive perfumer.")

francis_kurkdjian = find_or_create_perfumer(name: "Francis Kurkdjian",
  bio: "Creator of Le Male, founder of MFK. French-Armenian master perfumer.")

# =============================================================================
# NOTES
# =============================================================================
puts "\n🌿 Setting up notes..."

# Core notes
bergamot = find_or_create_note(name: "Bergamot", family: "citrus")
lemon = find_or_create_note(name: "Lemon", family: "citrus")
orange = find_or_create_note(name: "Orange", family: "citrus")
mandarin = find_or_create_note(name: "Mandarin", family: "citrus")
grapefruit = find_or_create_note(name: "Grapefruit", family: "citrus")
pink_pepper = find_or_create_note(name: "Pink Pepper", family: "spicy")
black_pepper = find_or_create_note(name: "Black Pepper", family: "spicy")
cardamom = find_or_create_note(name: "Cardamom", family: "spicy")
saffron = find_or_create_note(name: "Saffron", family: "spicy")
cinnamon = find_or_create_note(name: "Cinnamon", family: "spicy")
nutmeg = find_or_create_note(name: "Nutmeg", family: "spicy")
clove = find_or_create_note(name: "Clove", family: "spicy")
ginger = find_or_create_note(name: "Ginger", family: "spicy")
rose = find_or_create_note(name: "Rose", family: "floral")
jasmine = find_or_create_note(name: "Jasmine", family: "floral")
iris = find_or_create_note(name: "Iris", family: "floral")
lavender = find_or_create_note(name: "Lavender", family: "floral")
violet = find_or_create_note(name: "Violet", family: "floral")
tuberose = find_or_create_note(name: "Tuberose", family: "floral")
orange_blossom = find_or_create_note(name: "Orange Blossom", family: "floral")
ylang_ylang = find_or_create_note(name: "Ylang-Ylang", family: "floral")
neroli = find_or_create_note(name: "Neroli", family: "floral")
vanilla = find_or_create_note(name: "Vanilla", family: "oriental")
tonka = find_or_create_note(name: "Tonka Bean", family: "oriental")
amber = find_or_create_note(name: "Amber", family: "oriental")
benzoin = find_or_create_note(name: "Benzoin", family: "oriental")
incense = find_or_create_note(name: "Incense", family: "oriental")
frankincense = find_or_create_note(name: "Frankincense", family: "oriental")
myrrh = find_or_create_note(name: "Myrrh", family: "oriental")
musk = find_or_create_note(name: "Musk", family: "musk")
white_musk = find_or_create_note(name: "White Musk", family: "musk")
sandalwood = find_or_create_note(name: "Sandalwood", family: "woody")
cedar = find_or_create_note(name: "Cedar", family: "woody")
vetiver = find_or_create_note(name: "Vetiver", family: "woody")
oud = find_or_create_note(name: "Oud", family: "woody")
patchouli = find_or_create_note(name: "Patchouli", family: "woody")
leather = find_or_create_note(name: "Leather", family: "animalic")
tobacco = find_or_create_note(name: "Tobacco", family: "gourmand")
coffee = find_or_create_note(name: "Coffee", family: "gourmand")
honey = find_or_create_note(name: "Honey", family: "gourmand")
caramel = find_or_create_note(name: "Caramel", family: "gourmand")
ambroxan = find_or_create_note(name: "Ambroxan", family: "synthetic")
mint = find_or_create_note(name: "Mint", family: "aromatic")
apple = find_or_create_note(name: "Apple", family: "fruity")
pear = find_or_create_note(name: "Pear", family: "fruity")
peach = find_or_create_note(name: "Peach", family: "fruity")
plum = find_or_create_note(name: "Plum", family: "fruity")
raspberry = find_or_create_note(name: "Raspberry", family: "fruity")
blackcurrant = find_or_create_note(name: "Blackcurrant", family: "fruity")
magnolia = find_or_create_note(name: "Magnolia", family: "floral")
osmanthus = find_or_create_note(name: "Osmanthus", family: "floral")
carnation = find_or_create_note(name: "Carnation", family: "floral")
cumin = find_or_create_note(name: "Cumin", family: "spicy")
orris = find_or_create_note(name: "Orris", family: "floral")
labdanum = find_or_create_note(name: "Labdanum", family: "oriental")
castoreum = find_or_create_note(name: "Castoreum", family: "animalic")

# =============================================================================
# LOUIS VUITTON PERFUMES
# =============================================================================
puts "\n🍾 Creating Louis Vuitton perfumes..."

imagination = create_perfume_with_notes(
  brand: louis_vuitton, name: "Imagination",
  description: "Citrus tea journey. Fresh, clean, and refined masculinity.",
  gender: "male", launch_year: 2021, perfumers: [jacques_cavallier],
  top_notes: [bergamot, orange, grapefruit],
  heart_notes: [orange_blossom, jasmine],
  base_notes: [ambroxan, cedar, musk]
)

ombre_nomade = create_perfume_with_notes(
  brand: louis_vuitton, name: "Ombre Nomade",
  description: "Dark, intense oud with raspberry and rose. Mysterious and opulent.",
  gender: "unisex", launch_year: 2018, perfumers: [jacques_cavallier],
  top_notes: [raspberry, saffron],
  heart_notes: [rose, oud],
  base_notes: [benzoin, amber, musk]
)

# Ombre Nomade Dupe
ombre_clone = create_perfume_with_notes(
  brand: fragrance_world, name: "Ombre Nomade",
  description: "Direct clone of Louis Vuitton's dark oud masterpiece.",
  gender: "unisex", launch_year: 2022,
  top_notes: [raspberry, saffron],
  heart_notes: [rose, oud],
  base_notes: [benzoin, amber]
)
create_dupe(original: ombre_nomade, dupe: ombre_clone)

afternoon_swim = create_perfume_with_notes(
  brand: louis_vuitton, name: "Afternoon Swim",
  description: "Mediterranean freshness. Citrus splash with amber warmth.",
  gender: "unisex", launch_year: 2019, perfumers: [jacques_cavallier],
  top_notes: [mandarin, bergamot, lemon],
  heart_notes: [orange_blossom, ginger],
  base_notes: [amber, musk]
)

meteore = create_perfume_with_notes(
  brand: louis_vuitton, name: "Météore",
  description: "Fresh ozonic with pepper and woods. Modern masculine energy.",
  gender: "male", launch_year: 2020, perfumers: [jacques_cavallier],
  top_notes: [bergamot, pink_pepper, mint],
  heart_notes: [violet, jasmine],
  base_notes: [vetiver, musk, cedar]
)

au_hasard = create_perfume_with_notes(
  brand: louis_vuitton, name: "Au Hasard",
  description: "Sandalwood journey. Creamy, elegant, and hypnotic.",
  gender: "male", launch_year: 2018, perfumers: [jacques_cavallier],
  top_notes: [cardamom, black_pepper],
  heart_notes: [sandalwood, ginger],
  base_notes: [amber, musk]
)

le_jour_se_leve = create_perfume_with_notes(
  brand: louis_vuitton, name: "Le Jour se Lève",
  description: "Morning sunrise. Mandarin and magnolia freshness.",
  gender: "female", launch_year: 2018, perfumers: [jacques_cavallier],
  top_notes: [mandarin, blackcurrant],
  heart_notes: [magnolia, jasmine, rose],
  base_notes: [musk, ambroxan]
)

puts "✅ Created Louis Vuitton perfumes"

# =============================================================================
# XERJOFF PERFUMES
# =============================================================================
puts "\n🍾 Creating Xerjoff perfumes..."

naxos = create_perfume_with_notes(
  brand: xerjoff, name: "Naxos",
  description: "Sicilian honey, tobacco, and lavender. Sweet Mediterranean warmth.",
  gender: "unisex", launch_year: 2015, perfumers: [sergio_momo],
  top_notes: [lavender, bergamot, lemon],
  heart_notes: [honey, cinnamon],
  base_notes: [tobacco, vanilla, tonka, cashmeran = find_or_create_note(name: "Cashmeran", family: "woody")]
)

# Naxos Dupe
naxos_clone = create_perfume_with_notes(
  brand: lattafa, name: "Khamrah",
  description: "Popular Naxos/honey-tobacco alternative with boozy warmth.",
  gender: "unisex", launch_year: 2022,
  top_notes: [bergamot, cinnamon, nutmeg],
  heart_notes: [find_or_create_note(name: "Praline", family: "gourmand")],
  base_notes: [vanilla, tonka, benzoin]
)
create_dupe(original: naxos, dupe: naxos_clone)

nio = create_perfume_with_notes(
  brand: xerjoff, name: "Nio",
  description: "Fresh Italian citrus cocktail. Bergamot and lavender elegance.",
  gender: "male", launch_year: 2010, perfumers: [sergio_momo],
  top_notes: [bergamot, lemon, grapefruit],
  heart_notes: [lavender, neroli],
  base_notes: [musk, cedar, vetiver]
)

erba_pura = create_perfume_with_notes(
  brand: xerjoff, name: "Erba Pura",
  description: "Fruity ambery sweetness. Citrus meets vanilla in perfect harmony.",
  gender: "unisex", launch_year: 2019, perfumers: [sergio_momo],
  top_notes: [orange, lemon, bergamot],
  heart_notes: [peach, find_or_create_note(name: "Fruits", family: "fruity")],
  base_notes: [amber, vanilla, musk, white_musk]
)

# Erba Pura Dupes
erba_clone = create_perfume_with_notes(
  brand: maison_alhambra, name: "Lovely Cherie",
  description: "Sweet fruity-amber inspired by Erba Pura.",
  gender: "unisex", launch_year: 2022,
  top_notes: [orange, bergamot],
  heart_notes: [peach],
  base_notes: [vanilla, amber, musk]
)
create_dupe(original: erba_pura, dupe: erba_clone)

mefisto = create_perfume_with_notes(
  brand: xerjoff, name: "Mefisto",
  description: "Italian citrus explosion. Bergamot and lavender with ginger spice.",
  gender: "male", launch_year: 2008, perfumers: [sergio_momo],
  top_notes: [bergamot, grapefruit, apple],
  heart_notes: [lavender, ginger, sage = find_or_create_note(name: "Sage", family: "aromatic")],
  base_notes: [vetiver, cedar, musk, leather]
)

alexandria_ii = create_perfume_with_notes(
  brand: xerjoff, name: "Alexandria II",
  description: "Royal incense and iris. Powdery elegance with oriental depth.",
  gender: "unisex", launch_year: 2009, perfumers: [sergio_momo],
  top_notes: [bergamot, pink_pepper],
  heart_notes: [iris, jasmine, incense],
  base_notes: [sandalwood, musk, amber]
)

more_than_words = create_perfume_with_notes(
  brand: xerjoff, name: "More Than Words",
  description: "Gourmand elegance. Pistachio and sandalwood in luxurious harmony.",
  gender: "unisex", launch_year: 2017, perfumers: [sergio_momo],
  top_notes: [bergamot, osmanthus],
  heart_notes: [find_or_create_note(name: "Pistachio", family: "gourmand"), jasmine],
  base_notes: [sandalwood, musk, vanilla]
)

renaissance = create_perfume_with_notes(
  brand: xerjoff, name: "Renaissance",
  description: "Citrus aromatic freshness. Clean and elegant Italian style.",
  gender: "unisex", launch_year: 2008, perfumers: [sergio_momo],
  top_notes: [bergamot, grapefruit, pink_pepper],
  heart_notes: [geranium = find_or_create_note(name: "Geranium", family: "floral"), violet],
  base_notes: [vetiver, cedar, musk]
)

puts "✅ Created Xerjoff perfumes"

# =============================================================================
# FRÉDÉRIC MALLE PERFUMES
# =============================================================================
puts "\n🍾 Creating Frédéric Malle perfumes..."

portrait_lady = create_perfume_with_notes(
  brand: frederic_malle, name: "Portrait of a Lady",
  description: "Dark rose masterpiece. Turkish rose with patchouli and incense.",
  gender: "female", launch_year: 2010, perfumers: [dominique_ropion],
  top_notes: [blackcurrant, raspberry],
  heart_notes: [rose, clove],
  base_notes: [patchouli, incense, sandalwood, benzoin]
)

# Portrait of a Lady Dupe
portrait_clone = create_perfume_with_notes(
  brand: lattafa, name: "Nebras",
  description: "Dark rose-patchouli blend inspired by Portrait of a Lady.",
  gender: "female", launch_year: 2021,
  top_notes: [raspberry],
  heart_notes: [rose],
  base_notes: [patchouli, incense, benzoin]
)
create_dupe(original: portrait_lady, dupe: portrait_clone)

musc_ravageur = create_perfume_with_notes(
  brand: frederic_malle, name: "Musc Ravageur",
  description: "Animalic musk with amber and vanilla. Sensual and provocative.",
  gender: "unisex", launch_year: 2000, perfumers: [maurice_roucel],
  top_notes: [bergamot, lavender],
  heart_notes: [clove, cinnamon],
  base_notes: [musk, amber, vanilla, sandalwood]
)

carnal_flower = create_perfume_with_notes(
  brand: frederic_malle, name: "Carnal Flower",
  description: "The ultimate tuberose. Narcotic, powerful, and unforgettable.",
  gender: "unisex", launch_year: 2005, perfumers: [dominique_ropion],
  top_notes: [find_or_create_note(name: "Melon", family: "fruity"), bergamot],
  heart_notes: [tuberose, jasmine, ylang_ylang],
  base_notes: [musk, coconut = find_or_create_note(name: "Coconut", family: "gourmand")]
)

the_moon = create_perfume_with_notes(
  brand: frederic_malle, name: "The Moon",
  description: "Mysterious leather and iris. Dark, powdery elegance.",
  gender: "unisex", launch_year: 2021,
  top_notes: [bergamot],
  heart_notes: [iris, leather],
  base_notes: [musk, amber]
)

eau_de_magnolia = create_perfume_with_notes(
  brand: frederic_malle, name: "Eau de Magnolia",
  description: "Fresh magnolia with bergamot. Light, elegant spring scent.",
  gender: "unisex", launch_year: 2014, perfumers: [jean_claude_ellena],
  top_notes: [bergamot, grapefruit],
  heart_notes: [magnolia],
  base_notes: [white_musk]
)

angeliques_sous_la_pluie = create_perfume_with_notes(
  brand: frederic_malle, name: "Angéliques sous la Pluie",
  description: "Rain-soaked angelica. Fresh, green, and meditative.",
  gender: "unisex", launch_year: 2000, perfumers: [jean_claude_ellena],
  top_notes: [find_or_create_note(name: "Angelica", family: "aromatic"), juniper_berry = find_or_create_note(name: "Juniper Berry", family: "aromatic")],
  heart_notes: [find_or_create_note(name: "Hemlock", family: "green")],
  base_notes: [musk]
)

puts "✅ Created Frédéric Malle perfumes"

# =============================================================================
# AMOUAGE PERFUMES
# =============================================================================
puts "\n🍾 Creating Amouage perfumes..."

interlude_man = create_perfume_with_notes(
  brand: amouage, name: "Interlude Man",
  description: "Smoky incense explosion. Challenging, complex, and unforgettable.",
  gender: "male", launch_year: 2012,
  top_notes: [bergamot, oregano = find_or_create_note(name: "Oregano", family: "aromatic"), black_pepper],
  heart_notes: [incense, amber, labdanum],
  base_notes: [oud, sandalwood, castoreum]
)

# Interlude Man Dupe
interlude_clone = create_perfume_with_notes(
  brand: rasasi, name: "La Yuqawam Homme",
  description: "Smoky incense fragrance inspired by Interlude Man.",
  gender: "male", launch_year: 2015,
  top_notes: [bergamot, black_pepper],
  heart_notes: [incense, amber],
  base_notes: [oud, sandalwood]
)
create_dupe(original: interlude_man, dupe: interlude_clone)

reflection_man = create_perfume_with_notes(
  brand: amouage, name: "Reflection Man",
  description: "Elegant iris and neroli. Sophisticated and timeless masculine.",
  gender: "male", launch_year: 2007,
  top_notes: [neroli, pink_pepper, rosemary = find_or_create_note(name: "Rosemary", family: "aromatic")],
  heart_notes: [iris, jasmine, ylang_ylang],
  base_notes: [sandalwood, vetiver, cedar]
)

# Reflection Man Dupe
reflection_clone = create_perfume_with_notes(
  brand: armaf, name: "Opus",
  description: "Elegant iris fragrance inspired by Reflection Man.",
  gender: "male", launch_year: 2019,
  top_notes: [neroli, pink_pepper],
  heart_notes: [iris, jasmine],
  base_notes: [sandalwood, vetiver]
)
create_dupe(original: reflection_man, dupe: reflection_clone)

jubilation_xxv = create_perfume_with_notes(
  brand: amouage, name: "Jubilation XXV Man",
  description: "Rich oriental tapestry. Frankincense with dried fruits and spices.",
  gender: "male", launch_year: 2008,
  top_notes: [orange, blackcurrant, bergamot],
  heart_notes: [frankincense, orchid = find_or_create_note(name: "Orchid", family: "floral"), rose],
  base_notes: [oud, honey, amber, musk]
)

lyric_man = create_perfume_with_notes(
  brand: amouage, name: "Lyric Man",
  description: "Powdery rose with woods. Poetic and refined masculinity.",
  gender: "male", launch_year: 2008,
  top_notes: [rose, nutmeg, cardamom],
  heart_notes: [frankincense, orris, iris],
  base_notes: [sandalwood, musk, amber]
)

journey_man = create_perfume_with_notes(
  brand: amouage, name: "Journey Man",
  description: "Tobacco and herbs. Rugged adventurer spirit.",
  gender: "male", launch_year: 2014,
  top_notes: [cardamom, black_pepper, bergamot],
  heart_notes: [tobacco, find_or_create_note(name: "Clary Sage", family: "aromatic")],
  base_notes: [leather, amber, oud]
)

honour_man = create_perfume_with_notes(
  brand: amouage, name: "Honour Man",
  description: "Refined pepper and woods. Distinguished gentleman's scent.",
  gender: "male", launch_year: 2011,
  top_notes: [black_pepper, nutmeg],
  heart_notes: [frankincense, rose],
  base_notes: [cedar, vetiver, musk]
)

dia_woman = create_perfume_with_notes(
  brand: amouage, name: "Dia Woman",
  description: "Luminous white florals. Jasmine and musk elegance.",
  gender: "female", launch_year: 2002,
  top_notes: [bergamot, cardamom],
  heart_notes: [jasmine, lily_valley = find_or_create_note(name: "Lily of the Valley", family: "floral"), rose],
  base_notes: [musk, sandalwood, cedar]
)

puts "✅ Created Amouage perfumes"

# =============================================================================
# JEAN PAUL GAULTIER PERFUMES
# =============================================================================
puts "\n🍾 Creating Jean Paul Gaultier perfumes..."

le_male = create_perfume_with_notes(
  brand: jpg, name: "Le Male",
  description: "The iconic barbershop. Mint, lavender, and vanilla in perfect balance.",
  gender: "male", launch_year: 1995, perfumers: [francis_kurkdjian],
  top_notes: [mint, lavender, bergamot, cardamom],
  heart_notes: [orange_blossom, cumin, cinnamon],
  base_notes: [vanilla, tonka, sandalwood, amber],
  reformulated: true
)

# Le Male Dupes
le_male_clone = create_perfume_with_notes(
  brand: armaf, name: "Derby Club House Blanche",
  description: "Mint-lavender-vanilla inspired by Le Male.",
  gender: "male", launch_year: 2016,
  top_notes: [mint, lavender],
  heart_notes: [orange_blossom],
  base_notes: [vanilla, tonka]
)
create_dupe(original: le_male, dupe: le_male_clone)

le_male_le_parfum = create_perfume_with_notes(
  brand: jpg, name: "Le Male Le Parfum",
  description: "Richer, more oriental Le Male with vanilla and leather.",
  gender: "male", launch_year: 2020,
  top_notes: [cardamom, lavender],
  heart_notes: [iris, leather],
  base_notes: [vanilla, amber, benzoin]
)

ultra_male = create_perfume_with_notes(
  brand: jpg, name: "Ultra Male",
  description: "Sweet, pear-forward clubbing scent. Intense and seductive.",
  gender: "male", launch_year: 2015,
  top_notes: [pear, bergamot, mint, lavender],
  heart_notes: [cinnamon, cumin, orange_blossom],
  base_notes: [vanilla, amber, black_vanilla = find_or_create_note(name: "Black Vanilla", family: "gourmand")]
)

# Ultra Male Dupe
ultra_clone = create_perfume_with_notes(
  brand: al_haramain, name: "Amber Oud Gold Edition",
  description: "Sweet pear-vanilla fragrance with Ultra Male vibes.",
  gender: "unisex", launch_year: 2017,
  top_notes: [bergamot],
  heart_notes: [amber],
  base_notes: [vanilla, musk]
)
create_dupe(original: ultra_male, dupe: ultra_clone)

scandal = create_perfume_with_notes(
  brand: jpg, name: "Scandal",
  description: "Honey and gardenia seduction. Sweet, provocative feminine.",
  gender: "female", launch_year: 2017,
  top_notes: [blood_orange = find_or_create_note(name: "Blood Orange", family: "citrus"), mandarin],
  heart_notes: [gardenia = find_or_create_note(name: "Gardenia", family: "floral"), honey],
  base_notes: [patchouli, caramel, benzoin]
)

scandal_pour_homme = create_perfume_with_notes(
  brand: jpg, name: "Scandal Pour Homme",
  description: "Caramel and vetiver masculinity. Sweet meets fresh.",
  gender: "male", launch_year: 2021,
  top_notes: [bergamot, lemon],
  heart_notes: [caramel, lavender],
  base_notes: [vetiver, tonka, musk]
)

classique = create_perfume_with_notes(
  brand: jpg, name: "Classique",
  description: "The iconic corset. Tuberose, rose, and vanilla femininity.",
  gender: "female", launch_year: 1993,
  top_notes: [rose, bergamot, orange_blossom],
  heart_notes: [tuberose, jasmine, iris],
  base_notes: [vanilla, sandalwood, amber],
  reformulated: true
)

puts "✅ Created Jean Paul Gaultier perfumes"

# =============================================================================
# SUMMARY
# =============================================================================
puts "\n" + "=" * 60
puts "🎉 SEEDS PART 3 COMPLETE!"
puts "=" * 60
puts "📊 Statistics:"
puts "   - Brands: #{Brand.count}"
puts "   - Perfumers: #{Perfumer.count}"
puts "   - Notes: #{Note.count}"
puts "   - Perfumes: #{Perfume.count}"
puts "   - Dupe relationships: #{PerfumeDupe.count}"
puts "=" * 60


# =============================================================================
# MySillage Seeds - Part 4/4
# Brands: Maison Crivelli, Matière Première, Ormaie Paris, Stéphane Humbert Lucas 777
# =============================================================================
# Run this AFTER seeds_part3.rb
# =============================================================================

puts "🌸 Starting MySillage Seeds - Part 4..."
puts "=" * 60

# Helper methods
def find_or_create_brand(name:, country:, description: nil)
  Brand.find_or_create_by!(name: name) { |b| b.country = country; b.description = description }
end

def find_or_create_perfumer(name:, bio: nil)
  Perfumer.find_or_create_by!(name: name) { |p| p.bio = bio }
end

def find_or_create_note(name:, family:)
  Note.find_or_create_by!(name: name) { |n| n.family = family }
end

def create_perfume_with_notes(brand:, name:, description:, gender:, launch_year:,
                               perfumers: [], top_notes: [], heart_notes: [], base_notes: [],
                               discontinued: false, reformulated: false)
  perfume = Perfume.find_or_create_by!(brand: brand, name: name) do |p|
    p.description = description
    p.gender = gender
    p.launch_year = launch_year
    p.discontinued = discontinued
    p.reformulated = reformulated
  end
  perfumers.each { |pf| PerfumePerfumer.find_or_create_by!(perfume: perfume, perfumer: pf) }
  top_notes.each { |n| PerfumeNote.find_or_create_by!(perfume: perfume, note: n, note_type: 'top') }
  heart_notes.each { |n| PerfumeNote.find_or_create_by!(perfume: perfume, note: n, note_type: 'heart') }
  base_notes.each { |n| PerfumeNote.find_or_create_by!(perfume: perfume, note: n, note_type: 'base') }
  perfume
end

def create_dupe(original:, dupe:)
  PerfumeDupe.find_or_create_by!(original_perfume: original, dupe: dupe)
end

# =============================================================================
# BRANDS
# =============================================================================
puts "\n📦 Creating brands..."

maison_crivelli = find_or_create_brand(name: "Maison Crivelli", country: "France",
  description: "Founded in 2018, eco-conscious niche house exploring unexpected ingredient combinations and olfactory illusions.")

matiere_premiere = find_or_create_brand(name: "Matière Première", country: "France",
  description: "Founded in 2019 by perfumer Aurélien Guichard, focusing on single hero ingredients from sustainable sources.")

ormaie = find_or_create_brand(name: "Ormaie Paris", country: "France",
  description: "Founded in 2018, 100% natural luxury fragrances. Father-son house with sustainable ethos.")

shl777 = find_or_create_brand(name: "Stéphane Humbert Lucas 777", country: "France",
  description: "Founded in 2013, spiritual and oriental niche house. Known for luxurious, long-lasting compositions.")

# =============================================================================
# PERFUMERS
# =============================================================================
puts "\n👃 Creating perfumers..."

thibaud_crivelli = find_or_create_perfumer(name: "Thibaud Crivelli",
  bio: "Founder of Maison Crivelli, explores olfactory illusions and unexpected combinations.")

aurelien_guichard = find_or_create_perfumer(name: "Aurélien Guichard",
  bio: "Founder of Matière Première, third-generation perfumer from Grasse. Focuses on single-ingredient explorations.")

marie_salamagne = find_or_create_perfumer(name: "Marie Salamagne",
  bio: "Firmenich perfumer, created Ormaie fragrances and Maison Margiela Replica.")

jean_christophe_herault = find_or_create_perfumer(name: "Jean-Christophe Hérault",
  bio: "Symrise perfumer behind many Ormaie creations.")

stephane_humbert_lucas = find_or_create_perfumer(name: "Stéphane Humbert Lucas",
  bio: "Founder and nose of SHL 777, creates spiritual oriental compositions.")

# =============================================================================
# NOTES
# =============================================================================
puts "\n🌿 Setting up notes..."

bergamot = find_or_create_note(name: "Bergamot", family: "citrus")
lemon = find_or_create_note(name: "Lemon", family: "citrus")
orange = find_or_create_note(name: "Orange", family: "citrus")
mandarin = find_or_create_note(name: "Mandarin", family: "citrus")
grapefruit = find_or_create_note(name: "Grapefruit", family: "citrus")
pink_pepper = find_or_create_note(name: "Pink Pepper", family: "spicy")
black_pepper = find_or_create_note(name: "Black Pepper", family: "spicy")
cardamom = find_or_create_note(name: "Cardamom", family: "spicy")
saffron = find_or_create_note(name: "Saffron", family: "spicy")
cinnamon = find_or_create_note(name: "Cinnamon", family: "spicy")
ginger = find_or_create_note(name: "Ginger", family: "spicy")
rose = find_or_create_note(name: "Rose", family: "floral")
jasmine = find_or_create_note(name: "Jasmine", family: "floral")
iris = find_or_create_note(name: "Iris", family: "floral")
lavender = find_or_create_note(name: "Lavender", family: "floral")
tuberose = find_or_create_note(name: "Tuberose", family: "floral")
orange_blossom = find_or_create_note(name: "Orange Blossom", family: "floral")
ylang_ylang = find_or_create_note(name: "Ylang-Ylang", family: "floral")
neroli = find_or_create_note(name: "Neroli", family: "floral")
violet = find_or_create_note(name: "Violet", family: "floral")
vanilla = find_or_create_note(name: "Vanilla", family: "oriental")
tonka = find_or_create_note(name: "Tonka Bean", family: "oriental")
amber = find_or_create_note(name: "Amber", family: "oriental")
benzoin = find_or_create_note(name: "Benzoin", family: "oriental")
incense = find_or_create_note(name: "Incense", family: "oriental")
frankincense = find_or_create_note(name: "Frankincense", family: "oriental")
myrrh = find_or_create_note(name: "Myrrh", family: "oriental")
musk = find_or_create_note(name: "Musk", family: "musk")
white_musk = find_or_create_note(name: "White Musk", family: "musk")
sandalwood = find_or_create_note(name: "Sandalwood", family: "woody")
cedar = find_or_create_note(name: "Cedar", family: "woody")
vetiver = find_or_create_note(name: "Vetiver", family: "woody")
oud = find_or_create_note(name: "Oud", family: "woody")
patchouli = find_or_create_note(name: "Patchouli", family: "woody")
leather = find_or_create_note(name: "Leather", family: "animalic")
tobacco = find_or_create_note(name: "Tobacco", family: "gourmand")
coffee = find_or_create_note(name: "Coffee", family: "gourmand")
honey = find_or_create_note(name: "Honey", family: "gourmand")
fig = find_or_create_note(name: "Fig", family: "fruity")
coconut = find_or_create_note(name: "Coconut", family: "gourmand")
ambroxan = find_or_create_note(name: "Ambroxan", family: "synthetic")
green_notes = find_or_create_note(name: "Green Notes", family: "green")
sea_notes = find_or_create_note(name: "Sea Notes", family: "aquatic")
woods = find_or_create_note(name: "Woods", family: "woody")
moss = find_or_create_note(name: "Moss", family: "woody")
poppy = find_or_create_note(name: "Poppy", family: "floral")
absinthe = find_or_create_note(name: "Absinthe", family: "aromatic")
cannabis = find_or_create_note(name: "Cannabis", family: "green")
papyrus = find_or_create_note(name: "Papyrus", family: "woody")
crystal_accord = find_or_create_note(name: "Crystal Accord", family: "synthetic")

# =============================================================================
# MAISON CRIVELLI PERFUMES
# =============================================================================
puts "\n🍾 Creating Maison Crivelli perfumes..."

iris_malikhan = create_perfume_with_notes(
  brand: maison_crivelli, name: "Iris Malikhân",
  description: "Olfactory illusion: smells like leather but it's iris. Powdery, elegant, mysterious.",
  gender: "unisex", launch_year: 2018, perfumers: [thibaud_crivelli],
  top_notes: [pink_pepper, cardamom],
  heart_notes: [iris, leather],
  base_notes: [sandalwood, amber, musk]
)

hibiscus_mahajad = create_perfume_with_notes(
  brand: maison_crivelli, name: "Hibiscus Mahajád",
  description: "Tropical floral with unexpected depth. Hibiscus and coffee fusion.",
  gender: "unisex", launch_year: 2018, perfumers: [thibaud_crivelli],
  top_notes: [bergamot, ginger],
  heart_notes: [find_or_create_note(name: "Hibiscus", family: "floral"), coffee],
  base_notes: [sandalwood, vanilla, musk]
)

rose_saltifolia = create_perfume_with_notes(
  brand: maison_crivelli, name: "Rose Saltifolia",
  description: "Rose meets sea salt. Fresh, unexpected maritime floral.",
  gender: "unisex", launch_year: 2019, perfumers: [thibaud_crivelli],
  top_notes: [bergamot, sea_notes],
  heart_notes: [rose],
  base_notes: [cedar, musk, ambroxan]
)

papyrus_moleculaire = create_perfume_with_notes(
  brand: maison_crivelli, name: "Papyrus Moléculaire",
  description: "Dry papyrus with molecular freshness. Intellectual and airy.",
  gender: "unisex", launch_year: 2020, perfumers: [thibaud_crivelli],
  top_notes: [bergamot, grapefruit],
  heart_notes: [papyrus, iris],
  base_notes: [cedar, musk, crystal_accord]
)

absinthe_boreale = create_perfume_with_notes(
  brand: maison_crivelli, name: "Absinthe Boréale",
  description: "Green absinthe with northern woods. Herbal, crisp, and addictive.",
  gender: "unisex", launch_year: 2019, perfumers: [thibaud_crivelli],
  top_notes: [absinthe, bergamot],
  heart_notes: [lavender, violet],
  base_notes: [vetiver, moss, musk]
)

puts "✅ Created Maison Crivelli perfumes"

# =============================================================================
# MATIÈRE PREMIÈRE PERFUMES
# =============================================================================
puts "\n🍾 Creating Matière Première perfumes..."

santal_austral = create_perfume_with_notes(
  brand: matiere_premiere, name: "Santal Austral",
  description: "Pure Australian sandalwood exploration. Creamy, warm, and enveloping.",
  gender: "unisex", launch_year: 2019, perfumers: [aurelien_guichard],
  top_notes: [cardamom, pink_pepper],
  heart_notes: [sandalwood, ylang_ylang],
  base_notes: [vanilla, musk, amber]
)

encens_suave = create_perfume_with_notes(
  brand: matiere_premiere, name: "Encens Suave",
  description: "Smoky incense softened with florals. Sacred and sensual.",
  gender: "unisex", launch_year: 2019, perfumers: [aurelien_guichard],
  top_notes: [pink_pepper, bergamot],
  heart_notes: [incense, rose],
  base_notes: [benzoin, vanilla, musk]
)

cologne_cedrat = create_perfume_with_notes(
  brand: matiere_premiere, name: "Cologne Cédrat",
  description: "Sicilian citron in its purest form. Bright, zesty, and natural.",
  gender: "unisex", launch_year: 2019, perfumers: [aurelien_guichard],
  top_notes: [find_or_create_note(name: "Citron", family: "citrus"), bergamot, lemon],
  heart_notes: [neroli, orange_blossom],
  base_notes: [musk, woods]
)

parisian_musc = create_perfume_with_notes(
  brand: matiere_premiere, name: "Parisian Musc",
  description: "Elegant Parisian skin scent. Clean musk with iris sophistication.",
  gender: "unisex", launch_year: 2021, perfumers: [aurelien_guichard],
  top_notes: [bergamot, pink_pepper],
  heart_notes: [iris, rose],
  base_notes: [musk, sandalwood, vanilla]
)

radical_rose = create_perfume_with_notes(
  brand: matiere_premiere, name: "Radical Rose",
  description: "Rose in all its radical beauty. Fresh, green, and passionate.",
  gender: "unisex", launch_year: 2020, perfumers: [aurelien_guichard],
  top_notes: [bergamot, pink_pepper],
  heart_notes: [rose, geranium = find_or_create_note(name: "Geranium", family: "floral")],
  base_notes: [musk, cedar, patchouli]
)

french_flower = create_perfume_with_notes(
  brand: matiere_premiere, name: "French Flower",
  description: "Cannabis flower accord with a sophisticated twist. Green, floral, daring.",
  gender: "unisex", launch_year: 2019, perfumers: [aurelien_guichard],
  top_notes: [bergamot, green_notes],
  heart_notes: [cannabis, rose],
  base_notes: [patchouli, musk, woods]
)

puts "✅ Created Matière Première perfumes"

# =============================================================================
# ORMAIE PARIS PERFUMES
# =============================================================================
puts "\n🍾 Creating Ormaie Paris perfumes..."

papier_carbone = create_perfume_with_notes(
  brand: ormaie, name: "Papier Carbone",
  description: "Nostalgic carbon paper and leather. Intellectual, dry, and addictive.",
  gender: "unisex", launch_year: 2018, perfumers: [marie_salamagne],
  top_notes: [bergamot, black_pepper],
  heart_notes: [leather, violet],
  base_notes: [vetiver, cedar, musk]
)

yvonne = create_perfume_with_notes(
  brand: ormaie, name: "Yvonne",
  description: "100% natural tuberose. Lush, creamy, and intoxicating.",
  gender: "female", launch_year: 2019, perfumers: [jean_christophe_herault],
  top_notes: [bergamot, ylang_ylang],
  heart_notes: [tuberose, jasmine],
  base_notes: [sandalwood, musk]
)

le_passant = create_perfume_with_notes(
  brand: ormaie, name: "Le Passant",
  description: "Fig tree in Mediterranean sun. Green, milky, and refreshing.",
  gender: "unisex", launch_year: 2018, perfumers: [marie_salamagne],
  top_notes: [fig, bergamot],
  heart_notes: [fig, coconut],
  base_notes: [cedar, musk]
)

jardin_anglais = create_perfume_with_notes(
  brand: ormaie, name: "Jardin Anglais",
  description: "English garden in full bloom. Rose and green notes.",
  gender: "unisex", launch_year: 2020,
  top_notes: [bergamot, green_notes],
  heart_notes: [rose, violet],
  base_notes: [musk, moss]
)

puts "✅ Created Ormaie Paris perfumes"

# =============================================================================
# STÉPHANE HUMBERT LUCAS 777 PERFUMES
# =============================================================================
puts "\n🍾 Creating Stéphane Humbert Lucas 777 perfumes..."

oud_777 = create_perfume_with_notes(
  brand: shl777, name: "Oud 777",
  description: "Spiritual oud journey. Deep, resinous, and meditative.",
  gender: "unisex", launch_year: 2013, perfumers: [stephane_humbert_lucas],
  top_notes: [saffron, pink_pepper],
  heart_notes: [oud, rose],
  base_notes: [sandalwood, amber, musk]
)

khol_de_bahrein = create_perfume_with_notes(
  brand: shl777, name: "Khôl de Bahreïn",
  description: "Black kohl mystery. Smoky incense with oriental depth.",
  gender: "unisex", launch_year: 2015, perfumers: [stephane_humbert_lucas],
  top_notes: [bergamot, saffron],
  heart_notes: [incense, oud],
  base_notes: [benzoin, vanilla, musk]
)

soleil_de_jeddah = create_perfume_with_notes(
  brand: shl777, name: "Soleil de Jeddah",
  description: "Arabian sunshine. Warm spices with creamy sandalwood.",
  gender: "unisex", launch_year: 2014, perfumers: [stephane_humbert_lucas],
  top_notes: [bergamot, cardamom, ginger],
  heart_notes: [rose, jasmine],
  base_notes: [sandalwood, vanilla, amber, musk]
)

o_hira = create_perfume_with_notes(
  brand: shl777, name: "O Hira",
  description: "Japanese-inspired serenity. Hinoki wood and incense meditation.",
  gender: "unisex", launch_year: 2017, perfumers: [stephane_humbert_lucas],
  top_notes: [bergamot, pink_pepper],
  heart_notes: [find_or_create_note(name: "Hinoki", family: "woody"), incense],
  base_notes: [sandalwood, musk, amber]
)

black_gemstone = create_perfume_with_notes(
  brand: shl777, name: "Black Gemstone",
  description: "Dark precious stone. Oud, leather, and mysterious resins.",
  gender: "unisex", launch_year: 2016, perfumers: [stephane_humbert_lucas],
  top_notes: [saffron, cardamom],
  heart_notes: [oud, leather, rose],
  base_notes: [amber, benzoin, musk]
)

generation_man = create_perfume_with_notes(
  brand: shl777, name: "2022 Generation Man",
  description: "Modern masculine oriental. Fresh spices meet deep woods.",
  gender: "male", launch_year: 2022, perfumers: [stephane_humbert_lucas],
  top_notes: [bergamot, ginger, cardamom],
  heart_notes: [lavender, rose],
  base_notes: [oud, sandalwood, vanilla, amber]
)

puts "✅ Created Stéphane Humbert Lucas 777 perfumes"

# =============================================================================
# FINAL SUMMARY
# =============================================================================
puts "\n" + "=" * 60
puts "🎉 SEEDS PART 4 COMPLETE!"
puts "=" * 60
puts "📊 Final Statistics:"
puts "   - Brands: #{Brand.count}"
puts "   - Perfumers: #{Perfumer.count}"
puts "   - Notes: #{Note.count}"
puts "   - Perfumes: #{Perfume.count}"
puts "   - Dupe relationships: #{PerfumeDupe.count}"
puts "=" * 60
puts ""
puts "🌸 ALL SEEDS COMPLETE! 🌸"
puts "Your MySillage database is now populated with luxury fragrances and their dupes!"
puts "=" * 60
