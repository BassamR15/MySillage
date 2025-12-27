# frozen_string_literal: true

# =============================================================================
# 🌸 MYSILLAGE DATABASE SEEDS
# =============================================================================
# Importe 21 marques, ~2700 parfums et ~1000 dupes depuis les fichiers JSON
# Utilise des URLs d'images directes (pas d'upload Cloudinary)
# =============================================================================

require 'json'

puts "=" * 70
puts "🌸 MYSILLAGE - IMPORTATION DE LA BASE DE DONNÉES"
puts "=" * 70
puts

# =============================================================================
# CONFIGURATION
# =============================================================================

JSON_FILES = {
  "Amouage" => "amouage_normalized.json",
  "Creed" => "creed_normalized.json",
  "Dior" => "dior_normalized.json",
  "Frédéric Malle" => "frederic_malle_normalized.json",
  "Givenchy" => "givenchy_normalized.json",
  "Gucci" => "gucci_normalized.json",
  "Guerlain" => "guerlain_normalized.json",
  "Initio" => "initio_normalized.json",
  "Jean Paul Gaultier" => "jpg_normalized.json",
  "Louis Vuitton" => "louis_vuitton_normalized.json",
  "Maison Crivelli" => "maison_crivelli_normalized.json",
  "Maison Margiela" => "maison_margiela_normalized.json",
  "Matière Première" => "matiere_premiere_normalized.json",
  "Maison Francis Kurkdjian" => "mfk_normalized.json",
  "Nishane" => "nishane_normalized.json",
  "Ormaie" => "ormaie_normalized.json",
  "Parfums de Marly" => "parfums_de_marly_normalized.json",
  "SHL 777" => "shl_777_normalized.json",
  "Tom Ford" => "tom_ford_normalized.json",
  "Xerjoff" => "xerjoff_normalized.json",
  "Yves Saint Laurent" => "ysl_normalized.json"
}.freeze

JSON_BASE_PATH = Rails.root.join('db', 'data')

# =============================================================================
# URLs des photos des parfumeurs (Wikipedia, Fragrantica, sites officiels)
# =============================================================================

PERFUMER_PHOTOS = {
  "Alberto Morillas" => "https://upload.wikimedia.org/wikipedia/commons/thumb/8/8a/Alberto_Morillas.jpg/220px-Alberto_Morillas.jpg",
  "Thierry Wasser" => "https://www.guerlain.com/dw/image/v2/BDMS_PRD/on/demandware.static/-/Library-Sites-guerlain-shared/default/dw3ccacb13/2023/thierry-wasser.jpg",
  "Jacques Cavallier" => "https://upload.wikimedia.org/wikipedia/commons/thumb/1/1a/Jacques_Cavallier.jpg/220px-Jacques_Cavallier.jpg",
  "Jacques Cavallier Belletrud" => "https://upload.wikimedia.org/wikipedia/commons/thumb/1/1a/Jacques_Cavallier.jpg/220px-Jacques_Cavallier.jpg",
  "Jacques Cavallier-Belletrud" => "https://upload.wikimedia.org/wikipedia/commons/thumb/1/1a/Jacques_Cavallier.jpg/220px-Jacques_Cavallier.jpg",
  "François Demachy" => "https://upload.wikimedia.org/wikipedia/commons/thumb/9/9f/Fran%C3%A7ois_Demachy.jpg/220px-Fran%C3%A7ois_Demachy.jpg",
  "Francis Kurkdjian" => "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4e/Francis_Kurkdjian.jpg/220px-Francis_Kurkdjian.jpg",
  "Dominique Ropion" => "https://upload.wikimedia.org/wikipedia/commons/thumb/0/0e/Dominique_Ropion.jpg/220px-Dominique_Ropion.jpg",
  "Jean-Claude Ellena" => "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5a/Jean-Claude_Ellena.jpg/220px-Jean-Claude_Ellena.jpg",
  "Olivier Polge" => "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3c/Olivier_Polge.jpg/220px-Olivier_Polge.jpg",
  "Olivier Cresp" => "https://upload.wikimedia.org/wikipedia/commons/thumb/8/81/Olivier_Cresp.jpg/220px-Olivier_Cresp.jpg",
  "Christine Nagel" => "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/Christine_Nagel.jpg/220px-Christine_Nagel.jpg",
  "Maurice Roucel" => "https://upload.wikimedia.org/wikipedia/commons/thumb/7/79/Maurice_Roucel.jpg/220px-Maurice_Roucel.jpg",
  "Calice Becker" => "https://upload.wikimedia.org/wikipedia/commons/thumb/3/3e/Calice_Becker.jpg/220px-Calice_Becker.jpg",
  "Annick Menardo" => "https://upload.wikimedia.org/wikipedia/commons/thumb/0/07/Annick_Menardo.jpg/220px-Annick_Menardo.jpg",
  "Daniela Andrier" => "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d3/Daniela_Andrier.jpg/220px-Daniela_Andrier.jpg",
  "Daniela (Roche) Andrier" => "https://upload.wikimedia.org/wikipedia/commons/thumb/d/d3/Daniela_Andrier.jpg/220px-Daniela_Andrier.jpg",
  "Bertrand Duchaufour" => "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b0/Bertrand_Duchaufour.jpg/220px-Bertrand_Duchaufour.jpg",
  "Sophia Grojsman" => "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a3/Sophia_Grojsman.jpg/220px-Sophia_Grojsman.jpg",
  "Pierre Bourdon" => "https://upload.wikimedia.org/wikipedia/commons/thumb/f/f1/Pierre_Bourdon.jpg/220px-Pierre_Bourdon.jpg",
  "Edmond Roudnitska" => "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e4/Edmond_Roudnitska.jpg/220px-Edmond_Roudnitska.jpg",
  "Michel Roudnitska" => "https://upload.wikimedia.org/wikipedia/commons/thumb/9/9e/Michel_Roudnitska.jpg/220px-Michel_Roudnitska.jpg",
  "Nathalie Lorson" => "https://upload.wikimedia.org/wikipedia/commons/thumb/9/9b/Nathalie_Lorson.jpg/220px-Nathalie_Lorson.jpg",
  "Fabrice Pellegrin" => "https://upload.wikimedia.org/wikipedia/commons/thumb/f/fc/Fabrice_Pellegrin.jpg/220px-Fabrice_Pellegrin.jpg",
  "Antoine Maisondieu" => "https://upload.wikimedia.org/wikipedia/commons/thumb/a/ab/Antoine_Maisondieu.jpg/220px-Antoine_Maisondieu.jpg",
  "Christophe Laudamiel" => "https://upload.wikimedia.org/wikipedia/commons/thumb/c/c4/Christophe_Laudamiel.jpg/220px-Christophe_Laudamiel.jpg",
  "Anne Flipo" => "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a8/Anne_Flipo.jpg/220px-Anne_Flipo.jpg",
  "Jean-Paul Guerlain" => "https://upload.wikimedia.org/wikipedia/commons/thumb/7/7b/Jean-Paul_Guerlain.jpg/220px-Jean-Paul_Guerlain.jpg",
  "Olivier Creed" => "https://www.creedfragrance.com/on/demandware.static/-/Library-Sites-CreedSharedLibrary/default/olivier-creed.jpg",
  "Aurélien Guichard" => "https://www.fragrantica.com/images/perfumers/aurelien-guichard.jpg",
  "Aurelien Guichard" => "https://www.fragrantica.com/images/perfumers/aurelien-guichard.jpg",
  "Carlos Benaïm" => "https://www.fragrantica.com/images/perfumers/carlos-benaim.jpg",
  "Edouard Flechier" => "https://www.fragrantica.com/images/perfumers/edouard-flechier.jpg",
  "Édouard Fléchier" => "https://www.fragrantica.com/images/perfumers/edouard-flechier.jpg",
  "Jean-Louis Sieuzac" => "https://www.fragrantica.com/images/perfumers/jean-louis-sieuzac.jpg",
  "Olivia Giacobetti" => "https://www.fragrantica.com/images/perfumers/olivia-giacobetti.jpg",
  "Ralf Schwieger" => "https://www.fragrantica.com/images/perfumers/ralf-schwieger.jpg",
  "Ilias Ermenidis" => "https://www.fragrantica.com/images/perfumers/ilias-ermenidis.jpg",
  "Sophie Labbe" => "https://www.fragrantica.com/images/perfumers/sophie-labbe.jpg",
  "Louise Turner" => "https://www.fragrantica.com/images/perfumers/louise-turner.jpg",
  "Yann Vasnier" => "https://www.fragrantica.com/images/perfumers/yann-vasnier.jpg",
  "Michel Almairac" => "https://www.fragrantica.com/images/perfumers/michel-almairac.jpg",
  "Sylvaine Delacourte" => "https://www.fragrantica.com/images/perfumers/sylvaine-delacourte.jpg",
  "Nathalie Feisthauer" => "https://www.fragrantica.com/images/perfumers/nathalie-feisthauer.jpg",
  "Karine Dubreuil" => "https://www.fragrantica.com/images/perfumers/karine-dubreuil.jpg",
  "Sonia Constant" => "https://www.fragrantica.com/images/perfumers/sonia-constant.jpg",
  "Honorine Blanc" => "https://www.fragrantica.com/images/perfumers/honorine-blanc.jpg",
  "Fanny Bal" => "https://www.fragrantica.com/images/perfumers/fanny-bal.jpg",
  "Delphine Jelk" => "https://www.fragrantica.com/images/perfumers/delphine-jelk.jpg",
  "Emilie Coppermann" => "https://www.fragrantica.com/images/perfumers/emilie-coppermann.jpg",
  "Jorge Lee" => "https://www.fragrantica.com/images/perfumers/jorge-lee.jpg",
  "Pierre Negrin" => "https://www.fragrantica.com/images/perfumers/pierre-negrin.jpg",
  "Pierre Wargnye" => "https://www.fragrantica.com/images/perfumers/pierre-wargnye.jpg",
  "Pierre-Constantin Guéros" => "https://www.fragrantica.com/images/perfumers/pierre-constantin-gueros.jpg",
  "Alexandra Carlin" => "https://www.fragrantica.com/images/perfumers/alexandra-carlin.jpg",
  "Alienor Massenet" => "https://www.fragrantica.com/images/perfumers/alienor-massenet.jpg",
  "Bruno Jovanovic" => "https://www.fragrantica.com/images/perfumers/bruno-jovanovic.jpg",
  "Cécile Zarokian" => "https://www.fragrantica.com/images/perfumers/cecile-zarokian.jpg",
  "Christophe Raynaud" => "https://www.fragrantica.com/images/perfumers/christophe-raynaud.jpg",
  "Daniel Moliere" => "https://www.fragrantica.com/images/perfumers/daniel-moliere.jpg",
  "Dorothée Piot" => "https://www.fragrantica.com/images/perfumers/dorothee-piot.jpg",
  "Hamid Merati-Kashani" => "https://www.fragrantica.com/images/perfumers/hamid-merati-kashani.jpg",
  "Jean Guichard" => "https://www.fragrantica.com/images/perfumers/jean-guichard.jpg",
  "Jean-Marc Chaillan" => "https://www.fragrantica.com/images/perfumers/jean-marc-chaillan.jpg",
  "Jean-Pierre Bethouart" => "https://www.fragrantica.com/images/perfumers/jean-pierre-bethouart.jpg",
  "Jean-Pierre Béthouart" => "https://www.fragrantica.com/images/perfumers/jean-pierre-bethouart.jpg",
  "Julien Rasquinet" => "https://www.fragrantica.com/images/perfumers/julien-rasquinet.jpg",
  "Olivier Gillotin" => "https://www.fragrantica.com/images/perfumers/olivier-gillotin.jpg",
  "Richard Herpin" => "https://www.fragrantica.com/images/perfumers/richard-herpin.jpg",
  "Richard Ibanez" => "https://www.fragrantica.com/images/perfumers/richard-ibanez.jpg",
  "Rodrigo Flores-Roux" => "https://www.fragrantica.com/images/perfumers/rodrigo-flores-roux.jpg",
  "Serge de Oliveira" => "https://www.fragrantica.com/images/perfumers/serge-de-oliveira.jpg",
  "Stéphane Humbert Lucas" => "https://www.fragrantica.com/images/perfumers/stephane-humbert-lucas.jpg",
  "Yves Cassar" => "https://www.fragrantica.com/images/perfumers/yves-cassar.jpg",
  "Sergio Momo" => "https://www.fragrantica.com/images/perfumers/sergio-momo.jpg",
  "Quentin Bisch" => "https://www.fragrantica.com/images/perfumers/quentin-bisch.jpg",
  "Marie Salamagne" => "https://www.fragrantica.com/images/perfumers/marie-salamagne.jpg",
  "Lucas Sieuzac" => "https://www.fragrantica.com/images/perfumers/lucas-sieuzac.jpg",
  "Beatrice Piquet" => "https://www.fragrantica.com/images/perfumers/beatrice-piquet.jpg",
  "Gaël Montero" => "https://www.fragrantica.com/images/perfumers/gael-montero.jpg",
  "Jordi Fernández" => "https://www.fragrantica.com/images/perfumers/jordi-fernandez.jpg",
  "Nicolas Bonneville" => "https://www.fragrantica.com/images/perfumers/nicolas-bonneville.jpg",
  "Violaine Collas" => "https://www.fragrantica.com/images/perfumers/violaine-collas.jpg",
  "Ane Ayo" => "https://www.fragrantica.com/images/perfumers/ane-ayo.jpg",
  "Angelos Balamis" => "https://www.fragrantica.com/images/perfumers/angelos-balamis.jpg",
  "Ann Gottlieb" => "https://www.fragrantica.com/images/perfumers/ann-gottlieb.jpg",
  "Celine Ripert" => "https://www.fragrantica.com/images/perfumers/celine-ripert.jpg",
  "Chris Maurice" => "https://www.fragrantica.com/images/perfumers/chris-maurice.jpg",
  "Daniel Maurel" => "https://www.fragrantica.com/images/perfumers/daniel-maurel.jpg",
  "Elise Benat" => "https://www.fragrantica.com/images/perfumers/elise-benat.jpg",
  "Francis Fabron" => "https://www.fragrantica.com/images/perfumers/francis-fabron.jpg",
  "Françoise Donche" => "https://www.fragrantica.com/images/perfumers/francoise-donche.jpg",
  "Leslie Girard" => "https://www.fragrantica.com/images/perfumers/leslie-girard.jpg",
  "Marc Zini" => "https://www.fragrantica.com/images/perfumers/marc-zini.jpg",
  "Maurice Roger" => "https://www.fragrantica.com/images/perfumers/maurice-roger.jpg",
  "Meabh McCurtin" => "https://www.fragrantica.com/images/perfumers/meabh-mccurtin.jpg",
  "Michèle Saramito" => "https://www.fragrantica.com/images/perfumers/michele-saramito.jpg",
  "Nathalie Cetto" => "https://www.fragrantica.com/images/perfumers/nathalie-cetto.jpg",
  "Nathalie Templer" => "https://www.fragrantica.com/images/perfumers/nathalie-templer.jpg",
  "Paul Leger" => "https://www.fragrantica.com/images/perfumers/paul-leger.jpg",
  "Paul Vacher" => "https://www.fragrantica.com/images/perfumers/paul-vacher.jpg",
  "Randa Hammami" => "https://www.fragrantica.com/images/perfumers/randa-hammami.jpg",
  "Sofia Bardelli" => "https://www.fragrantica.com/images/perfumers/sofia-bardelli.jpg",
  "Stephanie Bakouche" => "https://www.fragrantica.com/images/perfumers/stephanie-bakouche.jpg",
  "Suzy Le Helley" => "https://www.fragrantica.com/images/perfumers/suzy-le-helley.jpg",
  "Sylvain Cara" => "https://www.fragrantica.com/images/perfumers/sylvain-cara.jpg",
  "Christine Nagel / Delphine Jelk" => "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a0/Christine_Nagel.jpg/220px-Christine_Nagel.jpg",
  "Julien Rasquinet & Paul Guerlain" => "https://www.fragrantica.com/images/perfumers/julien-rasquinet.jpg",
  "Olivier Cresp & Hamid Merati-Kashani" => "https://upload.wikimedia.org/wikipedia/commons/thumb/8/81/Olivier_Cresp.jpg/220px-Olivier_Cresp.jpg",
  "Stéphane Humbert Lucas & Karine Chevallier" => "https://www.fragrantica.com/images/perfumers/stephane-humbert-lucas.jpg",
  "Thierry Wasser & Delphine Jelk" => "https://www.guerlain.com/dw/image/v2/BDMS_PRD/on/demandware.static/-/Library-Sites-guerlain-shared/default/dw3ccacb13/2023/thierry-wasser.jpg",
  "Tom Ford / Michel Almairac" => "https://www.fragrantica.com/images/perfumers/michel-almairac.jpg",
  "Christian Carbonnel, Laura Santander" => "https://www.fragrantica.com/images/perfumers/christian-carbonnel.jpg"
}.freeze

# =============================================================================
# URLs des logos des marques (Wikipedia, sites officiels)
# =============================================================================

BRAND_LOGOS = {
  "Amouage" => "https://upload.wikimedia.org/wikipedia/commons/thumb/4/4a/Amouage_logo.svg/200px-Amouage_logo.svg.png",
  "Creed" => "https://upload.wikimedia.org/wikipedia/commons/thumb/6/6e/Creed_Aventus_logo.png/200px-Creed_Aventus_logo.png",
  "Dior" => "https://upload.wikimedia.org/wikipedia/commons/thumb/a/a8/Dior_Logo.svg/200px-Dior_Logo.svg.png",
  "Frédéric Malle" => "https://upload.wikimedia.org/wikipedia/commons/thumb/8/8e/Editions_de_Parfums_Fr%C3%A9d%C3%A9ric_Malle_logo.svg/200px-Editions_de_Parfums_Fr%C3%A9d%C3%A9ric_Malle_logo.svg.png",
  "Givenchy" => "https://upload.wikimedia.org/wikipedia/commons/thumb/e/ee/Givenchy_Logo.svg/200px-Givenchy_Logo.svg.png",
  "Gucci" => "https://upload.wikimedia.org/wikipedia/commons/thumb/7/79/1960s_Gucci_Logo.svg/200px-1960s_Gucci_Logo.svg.png",
  "Guerlain" => "https://upload.wikimedia.org/wikipedia/commons/thumb/b/b5/Guerlain_logo.svg/200px-Guerlain_logo.svg.png",
  "Initio" => "https://initioparfums.com/cdn/shop/files/INITIO_LOGO_BLACK.png",
  "Jean Paul Gaultier" => "https://upload.wikimedia.org/wikipedia/commons/thumb/e/e7/Jean_Paul_Gaultier_Logo.svg/200px-Jean_Paul_Gaultier_Logo.svg.png",
  "Louis Vuitton" => "https://upload.wikimedia.org/wikipedia/commons/thumb/7/76/Louis_Vuitton_logo_and_wordmark.svg/200px-Louis_Vuitton_logo_and_wordmark.svg.png",
  "Maison Crivelli" => "https://www.maisoncrivelli.com/cdn/shop/files/logo-maison-crivelli.png",
  "Maison Margiela" => "https://upload.wikimedia.org/wikipedia/commons/thumb/3/32/Maison_Margiela_logo.svg/200px-Maison_Margiela_logo.svg.png",
  "Matière Première" => "https://www.matierepremiere-parfums.com/cdn/shop/files/MP_LOGO.png",
  "Maison Francis Kurkdjian" => "https://upload.wikimedia.org/wikipedia/commons/thumb/8/8e/Maison_Francis_Kurkdjian_logo.svg/200px-Maison_Francis_Kurkdjian_logo.svg.png",
  "Nishane" => "https://www.nishane.com.tr/wp-content/uploads/2020/06/nishane-logo.png",
  "Ormaie" => "https://ormaie.com/cdn/shop/files/ORMAIE_LOGO.png",
  "Parfums de Marly" => "https://upload.wikimedia.org/wikipedia/commons/thumb/5/5f/Parfums_de_Marly_logo.svg/200px-Parfums_de_Marly_logo.svg.png",
  "SHL 777" => "https://www.stephaleleu.com/cdn/shop/files/777_logo.png",
  "Tom Ford" => "https://upload.wikimedia.org/wikipedia/commons/thumb/4/47/Tom_Ford_Logo.png/200px-Tom_Ford_Logo.png",
  "Xerjoff" => "https://upload.wikimedia.org/wikipedia/commons/thumb/9/9e/Xerjoff_logo.svg/200px-Xerjoff_logo.svg.png",
  "Yves Saint Laurent" => "https://upload.wikimedia.org/wikipedia/commons/thumb/2/2e/Yves_Saint_Laurent_Logo.svg/200px-Yves_Saint_Laurent_Logo.svg.png"
}.freeze

# =============================================================================
# NORMALISATION DES NOMS DE MARQUES (pour éviter les doublons)
# =============================================================================

BRAND_NAME_ALIASES = {
  "YSL" => "Yves Saint Laurent",
  "JPG" => "Jean Paul Gaultier",
  "MFK" => "Maison Francis Kurkdjian",
  "ELDO" => "Etat Libre d'Orange",
  "CK" => "Calvin Klein",
  "DKNY" => "Donna Karan",
  "BDK Parfums" => "BDK Parfums",
  "ALT Fragrances" => "ALT Fragrances",
  "ALT. Fragrances" => "ALT Fragrances",
  "Dua Brand" => "Dua Fragrances",
  "The Dua Brand" => "Dua Fragrances",
  "Dua" => "Dua Fragrances",
  "Alexandria" => "Alexandria Fragrances",
  "Alexandria Fragrances UK" => "Alexandria Fragrances",
  "Alexandria UK" => "Alexandria Fragrances",
  "Maison Alhambra (Lattafa)" => "Maison Alhambra",
  "French Avenue (Fragrance World)" => "French Avenue",
  "Paris Corner (Emir)" => "Paris Corner",
  "Lattafa Pride" => "Lattafa",
  "Volare (Lattafa)" => "Lattafa",
  "Al-Rehab" => "Al Rehab",
  "Julianna's Perfume" => "Julianna's Perfumes",
  "Juliana's Perfume" => "Julianna's Perfumes",
  "Creaparfum" => "CreaParfum",
  "Divain" => "DIVAIN"
}.freeze

def normalize_brand_name(name)
  return name if name.blank?
  BRAND_NAME_ALIASES[name] || name
end

# =============================================================================
# HELPERS
# =============================================================================

def unsplash_url(search_term, size = "400x400")
  encoded = CGI.escape(search_term)
  "https://source.unsplash.com/featured/#{size}/?#{encoded}"
end

def guess_note_family(name)
  n = name.downcase
  case n
  when /rose|jasmin|iris|violet|fleur|flower|orchid|magnolia|lily|peony|gardenia|tuberose|ylang|neroli|blossom|freesia|lilac|carnation|mimosa|lotus|hibiscus|cyclamen|narciss|muguet|pivoine|tubéreuse|gardénia|violette|orchidée|géranium|oeillet|œillet|héliotrope|osmanthus|champaca|frangipani|tiaré|plumeria|dahlia|amaryllis|floraux|floral/
    'Floral'
  when /citron|lemon|orange|bergamot|grapefruit|mandarin|lime|yuzu|cedrat|citrus|agrume|clémentine|kumquat|pomelo|tangerine|petitgrain|zeste|pamplemousse|cédrat|bigarade/
    'Citrus'
  when /bois|wood|cedar|cèdre|santal|sandal|vétiver|vetiver|patchouli|oud|agarwood|gaiac|gaïac|cypress|cyprès|hinoki|teck|pin|pine|sapin|fir|spruce|birch|bouleau|oak|chêne|mahogany|acajou|rosewood|palissandre|palo santo|mousse|moss|amyris|cypriol/
    'Woody'
  when /vanille|vanilla|tonka|chocolat|chocolate|cacao|café|coffee|caramel|praline|praliné|miel|honey|amande|almond|pistache|noisette|hazelnut|coco|coconut|sucre|sugar|cream|crème|guimauve|marshmallow|meringue|lait|milk|frangipane|réglisse|licorice|gourmand|dessert|sweet|bonbon|candy|madeleine|kulfi|bubblegum/
    'Gourmand'
  when /musc|musk|ambre|amber|ambrox|cashmer|oriental/
    'Musky'
  when /cuir|leather|tabac|tobacco|castoreum|daim|suede|suède|fumé|fume|smoke|cendre|ash|goudron|tar/
    'Leather'
  when /poivre|pepper|cannelle|cinnamon|cardamom|cardamome|gingembre|ginger|safran|saffron|girofle|clove|muscade|nutmeg|cumin|coriandre|coriander|anis|badiane|épice|spice|piment|chili|paprika|galanga|carvi|fenouil/
    'Spicy'
  when /encens|incense|frankincense|benjoin|benzoin|myrrhe|myrrh|labdanum|opoponax|résine|resin|styrax|tolu|baume|balsam|elemi|élémi|élemi|ciste|cistus|galbanum|mastic|oliban/
    'Resinous'
  when /pêche|peach|abricot|apricot|framboise|raspberry|fraise|strawberry|cassis|blackcurrant|mûre|blackberry|cerise|cherry|pomme|apple|poire|pear|figue|fig|prune|plum|ananas|pineapple|mangue|mango|litchi|lychee|passion|goyave|guava|kiwi|melon|pastèque|watermelon|grenade|pomegranate|nectarine|canneberge|cranberry|myrtille|blueberry|groseille|gooseberry|mirabelle|fruit|baies|berry|rhubarb|rhubarbe|datte|tamarin|dragon/
    'Fruity'
  when /lavande|lavender|menthe|mint|romarin|rosemary|thym|thyme|basilic|basil|sauge|sage|estragon|tarragon|armoise|artemisia|absinthe|angélique|angelica|eucalyptus|verveine|verbena|laurier|bay|genièvre|genévrier|juniper|oregano|origan|gentiane|herbe|herb|foin|hay|fougère|fern|myrte|davana|cannabis|camomille|chamomile|aromat/
    'Aromatic'
  when /marin|marine|ocean|sea|aqua|water|eau|brise|sel|salt|algue|seaweed|calone|ozon/
    'Aquatic'
  when /feuille|leaf|leaves|vert|green|thé|tea|maté|mate|olivier|olive|ivy|lierre|tomate|tomato|concombre|cucumber|galbanum/
    'Green'
  else
    'Other'
  end
end

def map_gender(gender)
  return 'unisex' if gender.blank?

  case gender.to_s.downcase
  when /femme|woman|female|pour elle/
    'female'
  when /homme|man|male|pour lui/
    'male'
  else
    'unisex'
  end
end

def get_note_search_term(note_name)
  mappings = {
    /rose/ => "rose flower",
    /jasmin/ => "jasmine flower",
    /iris/ => "iris flower",
    /violet/ => "violet flower",
    /tubéreuse|tuberose/ => "tuberose flower",
    /pivoine|peony/ => "peony flower",
    /magnolia/ => "magnolia flower",
    /gardénia|gardenia/ => "gardenia flower",
    /muguet|lily of the valley/ => "lily of the valley",
    /lys|lily/ => "lily flower",
    /orchidée|orchid/ => "orchid flower",
    /ylang/ => "ylang ylang flower",
    /néroli|neroli/ => "neroli orange blossom",
    /fleur d'oranger|orange blossom/ => "orange blossom",
    /freesia/ => "freesia flower",
    /lilas|lilac/ => "lilac flower",
    /mimosa/ => "mimosa flower",
    /lotus/ => "lotus flower",
    /géranium|geranium/ => "geranium flower",
    /oeillet|œillet|carnation/ => "carnation flower",
    /héliotrope|heliotrope/ => "heliotrope flower",
    /bergamot/ => "bergamot citrus",
    /citron|lemon/ => "lemon citrus",
    /orange/ => "orange fruit",
    /mandarin/ => "mandarin orange",
    /pamplemousse|grapefruit/ => "grapefruit",
    /lime/ => "lime citrus",
    /yuzu/ => "yuzu citrus",
    /cédrat/ => "citron cedrat",
    /cèdre|cedar/ => "cedar wood",
    /santal|sandal/ => "sandalwood",
    /vétiver|vetiver/ => "vetiver grass",
    /patchouli/ => "patchouli leaves",
    /oud|agarwood/ => "oud agarwood incense",
    /cyprès|cypress/ => "cypress tree",
    /pin|pine/ => "pine tree",
    /sapin|fir/ => "fir tree",
    /bouleau|birch/ => "birch tree",
    /chêne|oak/ => "oak tree",
    /poivre|pepper/ => "black pepper",
    /cannelle|cinnamon/ => "cinnamon sticks",
    /cardamom/ => "cardamom pods",
    /gingembre|ginger/ => "ginger root",
    /safran|saffron/ => "saffron spice",
    /girofle|clove/ => "cloves spice",
    /muscade|nutmeg/ => "nutmeg",
    /encens|incense|frankincense/ => "incense frankincense",
    /benjoin|benzoin/ => "benzoin resin",
    /myrrhe|myrrh/ => "myrrh resin",
    /labdanum/ => "labdanum resin",
    /vanille|vanilla/ => "vanilla beans",
    /tonka/ => "tonka beans",
    /chocolat|chocolate/ => "chocolate",
    /cacao/ => "cacao beans",
    /café|coffee/ => "coffee beans",
    /caramel/ => "caramel",
    /miel|honey/ => "honey",
    /amande|almond/ => "almonds",
    /noisette|hazelnut/ => "hazelnuts",
    /coco|coconut/ => "coconut",
    /pêche|peach/ => "peach fruit",
    /abricot|apricot/ => "apricot fruit",
    /framboise|raspberry/ => "raspberry",
    /fraise|strawberry/ => "strawberry",
    /cassis|blackcurrant/ => "blackcurrant",
    /cerise|cherry/ => "cherry fruit",
    /pomme|apple/ => "apple fruit",
    /poire|pear/ => "pear fruit",
    /figue|fig/ => "fig fruit",
    /ananas|pineapple/ => "pineapple",
    /mangue|mango/ => "mango fruit",
    /lavande|lavender/ => "lavender field",
    /menthe|mint/ => "mint leaves",
    /romarin|rosemary/ => "rosemary herb",
    /thym|thyme/ => "thyme herb",
    /basilic|basil/ => "basil herb",
    /sauge|sage/ => "sage herb",
    /musc|musk/ => "musk perfume abstract",
    /ambre|amber/ => "amber stone",
    /cuir|leather/ => "leather texture",
    /tabac|tobacco/ => "tobacco leaves",
    /mousse|moss/ => "moss nature",
    /fougère|fern/ => "fern plant"
  }

  mappings.each do |pattern, term|
    return term if note_name.downcase.match?(pattern)
  end

  note_name.downcase.gsub(/[^a-z\s]/, '')
end

# =============================================================================
# CACHES
# =============================================================================

@brands_cache = {}
@perfumers_cache = {}
@notes_cache = {}
@collections_cache = {}
@all_dupes_to_create = []

# =============================================================================
# NETTOYAGE
# =============================================================================

puts "🧹 Nettoyage de la base de données..."

PerfumeDupe.delete_all
PerfumeNote.delete_all
PerfumePerfumer.delete_all
Perfume.delete_all
BrandCollection.delete_all
Note.delete_all
Perfumer.delete_all
Brand.delete_all

puts "✅ Base nettoyée"
puts

# =============================================================================
# IMPORT DES NOTES AVEC IMAGE_URL
# =============================================================================

puts "🎨 Importation des notes..."

notes_file = Rails.root.join('db', 'data', 'notes_base_images.json')
if File.exist?(notes_file)
  notes_data = JSON.parse(File.read(notes_file))
  notes_data.each do |name, data|
    search_term = data['search_term'] || get_note_search_term(name)
    note = Note.create!(
      name: name,
      family: data['family'] || guess_note_family(name),
      image_url: unsplash_url(search_term)
    )
    @notes_cache[name] = note
    print "."
  end
  puts
  puts "   ✅ #{Note.count} notes importées"
else
  puts "   ⚠️ Fichier notes_base_images.json non trouvé, les notes seront créées à la volée"
end

puts

# =============================================================================
# IMPORT DES MARQUES ET PARFUMS
# =============================================================================

JSON_FILES.each do |brand_display_name, filename|
  filepath = File.join(JSON_BASE_PATH, filename)

  unless File.exist?(filepath)
    puts "⚠️  Fichier non trouvé: #{filename}"
    next
  end

  puts "📦 #{brand_display_name}..."

  begin
    data = JSON.parse(File.read(filepath))

    # Création de la marque avec logo_url
    # Le JSON peut avoir brand comme string ou comme hash
    brand_data = data['brand']
    if brand_data.is_a?(Hash)
      brand_name = brand_data['name'] || brand_display_name
      brand_country = brand_data['country']
      brand_description = brand_data['description']
    else
      brand_name = brand_data || brand_display_name
      brand_country = data['country']
      brand_description = data['description']
    end

    brand = Brand.create!(
      name: brand_name,
      country: brand_country,
      description: brand_description,
      logo_url: BRAND_LOGOS[brand_display_name]
    )
    @brands_cache[brand_name] = brand

    # Collection par défaut
    default_collection = BrandCollection.create!(
      brand: brand,
      name: "Hors Collection"
    )
    @collections_cache["#{brand.id}_Hors Collection"] = default_collection

    perfumes_count = 0

    # Import des parfums
    data['perfumes']&.each do |p_data|
      # Gestion de la collection
      collection_name = p_data['collection'].presence || "Hors Collection"
      collection_key = "#{brand.id}_#{collection_name}"

      collection = @collections_cache[collection_key]
      unless collection
        collection = BrandCollection.create!(
          brand: brand,
          name: collection_name
        )
        @collections_cache[collection_key] = collection
      end

      # Création du parfum
      perfume = Perfume.create!(
        name: p_data['name'],
        brand: brand,
        brand_collection: collection,
        description: p_data['description'],
        gender: map_gender(p_data['gender']),
        launch_year: p_data['year'],
        price_cents: ((p_data['retail_price_eur'] || 0) * 100).to_i,
        concentration: p_data['concentration']
      )

      perfumes_count += 1

      # Parfumeur avec photo_url
      perfumer_name = p_data['perfumer']
      if perfumer_name.present? && !['Non spécifié', 'N/A', 'Non communiqué', 'Not disclosed', 'Various'].include?(perfumer_name)
        perfumer = @perfumers_cache[perfumer_name]
        unless perfumer
          perfumer = Perfumer.create!(
            name: perfumer_name,
            photo_url: PERFUMER_PHOTOS[perfumer_name]
          )
          @perfumers_cache[perfumer_name] = perfumer
        end

        PerfumePerfumer.create!(perfume: perfume, perfumer: perfumer)
      end

      # Notes du parfum
      notes_hash = p_data['notes'] || {}
      %w[top heart base].each do |position|
        (notes_hash[position] || []).each do |note_name|
          next if note_name.blank?

          note = @notes_cache[note_name]
          unless note
            search_term = get_note_search_term(note_name)
            note = Note.create!(
              name: note_name,
              family: guess_note_family(note_name),
              image_url: unsplash_url(search_term)
            )
            @notes_cache[note_name] = note
          end

          PerfumeNote.find_or_create_by!(
            perfume: perfume,
            note: note,
            note_type: position
          )
        end
      end

      # Stocker les dupes pour traitement ultérieur (GLOBAL)
      p_data['dupes']&.each do |d_data|
        @all_dupes_to_create << {
          original_perfume: perfume,
          dupe_brand_name: d_data['brand'],
          dupe_name: d_data['name'],
          similarity: d_data['similarity'] || 85,
          price_eur: d_data['price_eur'] || 0
        }
      end
    end

    puts "   ✅ #{perfumes_count} parfums, #{BrandCollection.where(brand: brand).count} collections"

  rescue StandardError => e
    puts "   ❌ Erreur: #{e.message}"
    puts e.backtrace.first(3).join("\n")
  end
end

# =============================================================================
# CRÉATION DES DUPES (après toutes les marques principales)
# =============================================================================

puts
puts "🔄 Création des dupes..."

@all_dupes_to_create.each do |dupe_data|
  # Normaliser le nom de la marque du dupe
  normalized_brand_name = normalize_brand_name(dupe_data[:dupe_brand_name])

  # Marque du dupe - chercher d'abord dans le cache
  dupe_brand = @brands_cache[normalized_brand_name]
  unless dupe_brand
    dupe_brand = Brand.create!(name: normalized_brand_name)
    @brands_cache[normalized_brand_name] = dupe_brand

    default_coll = BrandCollection.create!(
      brand: dupe_brand,
      name: "Hors Collection"
    )
    @collections_cache["#{dupe_brand.id}_Hors Collection"] = default_coll
  end

  # Collection du dupe
  dupe_collection = @collections_cache["#{dupe_brand.id}_Hors Collection"]
  unless dupe_collection
    dupe_collection = BrandCollection.find_or_create_by!(
      brand: dupe_brand,
      name: "Hors Collection"
    )
    @collections_cache["#{dupe_brand.id}_Hors Collection"] = dupe_collection
  end

  # Parfum dupe
  dupe_perfume = Perfume.find_by(name: dupe_data[:dupe_name], brand: dupe_brand)
  unless dupe_perfume
    dupe_perfume = Perfume.create!(
      name: dupe_data[:dupe_name],
      brand: dupe_brand,
      brand_collection: dupe_collection,
      price_cents: (dupe_data[:price_eur] * 100).to_i,
      gender: 'unisex'
    )
  end

  # Relation dupe
  PerfumeDupe.find_or_create_by!(
    original_perfume: dupe_data[:original_perfume],
    dupe: dupe_perfume
  ) do |pd|
    pd.similarity = dupe_data[:similarity]
  end
end

puts "   ✅ #{PerfumeDupe.count} dupes créés"

# =============================================================================
# RÉSUMÉ
# =============================================================================

puts
puts "=" * 70
puts "🎉 IMPORTATION TERMINÉE!"
puts "=" * 70
puts
puts "📊 Statistiques:"
puts "   - Marques:      #{Brand.count}"
puts "   - Collections:  #{BrandCollection.count}"
puts "   - Parfumeurs:   #{Perfumer.count}"
puts "   - Notes:        #{Note.count}"
puts "   - Parfums:      #{Perfume.count}"
puts "   - Dupes:        #{PerfumeDupe.count}"
puts
puts "=" * 70
