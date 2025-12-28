// app/javascript/pages/Perfumes/Show.jsx
import React, { useState } from 'react';

export default function Show({ perfume, userSignedIn, currentUser, userSeasonVotes, userReviews }) {
  const [selectedVolume, setSelectedVolume] = useState(1);
  const [isWishlisted, setIsWishlisted] = useState(false);
  const [seasonVotes, setSeasonVotes] = useState({
    spring: userSeasonVotes?.spring || false,
    summer: userSeasonVotes?.summer || false,
    fall: userSeasonVotes?.fall || false,
    winter: userSeasonVotes?.winter || false
  });
  const [dayNightVotes, setDayNightVotes] = useState({
    day: userSeasonVotes?.day || false,
    night: userSeasonVotes?.night ||false
  });
  const [longevityVote, setLongevityVote] = useState(userReviews?.rating_longevity || null);
  const [sillageVote, setSillageVote] = useState(userReviews?.rating_sillage || null);
  const [valueVote, setValueVote] = useState(userReviews?.rating_value || null);

  const handleSeasonClick = (season) => {
    if (!userSignedIn) return;
    const newValue = !seasonVotes[season];
    setSeasonVotes(prev => ({
      ...prev,
      [season]: newValue
    }));
    
    // Envoyer au serveur (on fera ça après)
  };

   const handleDayNightClick = (dayNight) => {
    if (!userSignedIn) return;
    const newValue = !dayNightVotes[dayNight];
    setDayNightVotes(prev => ({
      ...prev,
      [dayNight]: newValue
    }));
    
    // Envoyer au serveur (on fera ça après)
  };

  const handleLongevityClick = (value) => {
    if (!userSignedIn) return;
    const newValue = longevityVote === value ? null : value;
    setLongevityVote(newValue);
    
    // Envoyer au serveur (on fera ça après)
  };

  const handleSillageClick = (value) => {
    if (!userSignedIn) return;
    const newValue = sillageVote === value ? null : value;
    setSillageVote(newValue);
    
    // Envoyer au serveur (on fera ça après)
  };

  const handleValueClick = (value) => {
    if (!userSignedIn) return;
    const newValue = valueVote === value ? null : value;
    setValueVote(newValue);
    
    // Envoyer au serveur (on fera ça après)
  };

  // Volumes fictifs pour l'instant
  const volumes = [
    { size: "50ml", price: 120 },
    { size: "100ml", price: 185 },
    { size: "150ml", price: 240 }
  ];

  return (
    <div style={styles.container}>
      {/* Header */}
      <header style={styles.header}>
        <div style={styles.logo}>My<span style={styles.logoAccent}>Sillage</span></div>
        <nav style={styles.nav}>
          <a href="/" style={styles.navLink}>Découvrir</a>
          <a href="/marketplace" style={styles.navLink}>Marketplace</a>
          <a href="/brands" style={styles.navLink}>Maisons</a>
        </nav>
        <div style={styles.headerRight}>
          {userSignedIn ? (
            <div style={styles.avatar}>{currentUser?.username?.[0]?.toUpperCase() || 'U'}</div>
          ) : (
            <a href="/login" style={styles.navLink}>Connexion</a>
          )}
        </div>
      </header>

      {/* Main Content */}
      <main style={styles.mainGrid}>
        {/* Left Column */}
        <div>
          <div style={styles.mainImageContainer}>
            <img
              src={perfume.placeholder_image}
              alt={perfume.name}
              style={styles.mainImage}
            />
          </div>
  
          {/* Parfumeur Card */}
          <div style={styles.parfumeurCard}>
            <div style={styles.parfumeurItem}>
              <span style={styles.parfumeurIcon}></span>
              <div>
                <span style={styles.parfumeurLabel}>Parfumeur</span>
                <span style={styles.parfumeurValue}>
                  {perfume.perfumers?.map(p => p.name).join(', ') || 'Non renseigné'}
                </span>
              </div>
            </div>
            <div style={styles.parfumeurDivider} />
            <div style={styles.parfumeurItem}>
              <span style={styles.parfumeurIcon}></span>
              <div>
                <span style={styles.parfumeurLabel}>Année</span>
                <span style={styles.parfumeurValue}>{perfume.launch_year || 'N/A'}</span>
              </div>
            </div>
            <div style={styles.parfumeurDivider} />
            <div style={styles.parfumeurItem}>
              <span style={styles.parfumeurIcon}></span>
              <div>
                <span style={styles.parfumeurLabel}>Concentration</span>
                <span style={styles.parfumeurValue}>{perfume.concentration || 'EDP'}</span>
              </div>
            </div>
          </div>
        </div>

        {/* Right Column */}
        <div>
          <div style={styles.productHeader}>
            <div style={styles.topTag}>
              <span style={styles.brandTag}>{perfume.brand?.name}</span>
              <span style={styles.brandTag}>{perfume.gender}</span>
            </div>
            <h1 style={styles.productName}>{perfume.name}</h1>
            <p style={styles.tagline}>{perfume.tagline || perfume.description?.slice(0, 60) + '...'}</p>

            <div style={styles.ratingRow}>
              <span style={styles.ratingStars}>{'★'.repeat(4)}☆</span>
              <span style={styles.ratingScore}>4.5</span>
              <span style={styles.ratingCount}>({perfume.reviews?.length || 0} avis)</span>
            </div>
          </div>

          {/* Accords */}
          <div style={styles.accordsSection}>
            <h3 style={styles.sectionTitle}>
              <span>🎨</span> Accords Principaux
            </h3>
            <div style={styles.accordsList}>
              {perfume.notes?.slice(0, 5).map((note, idx) => (
                <div key={idx} style={styles.accordItem}>
                  <div style={styles.accordHeader}>
                    <span style={styles.accordName}>{note.name}</span>
                  </div>
                  <div style={styles.accordBarBg}>
                    <div style={{
                      ...styles.accordBarFill,
                      width: `${90 - idx * 15}%`
                    }} />
                  </div>
                </div>
              ))}
            </div>
          </div>
        </div>
      </main>

      {/* Full Width Sections */}
      <div style={styles.fullWidthContainer}>
        {/* Notes */}
        <div style={styles.notesCenterWrapper}>
          <div style={styles.notesCard}>
            <h3 style={styles.sectionTitleCentered}>
              <span>🌿</span> Notes Olfactives
            </h3>

            {Object.entries(perfume.notes_ordered).map(([type, notes]) => {
              const typeLabels = { top: 'Tête', heart: 'Cœur', base: 'Fond' };
              const typeIcons = { top: '🍃', heart: '🌸', base: '🪵' };

              return (
                <div key={type} style={styles.notesTier}>
                  <div style={styles.tierHeaderCentered}>
                    <span style={styles.tierIcon}>{typeIcons[type]}</span>
                    <span style={styles.tierLabel}>Notes de {typeLabels[type]}</span>
                  </div>
                  <div style={styles.notesChipsCentered}>
                    {notes.length > 0 ? notes.map((note, idx) => (
                      <span key={idx} style={styles.noteChip}>{note}</span>
                    )) : (
                      <span style={styles.noteChip}>Non renseigné</span>
                    )}
                  </div>
                </div>
              );
            })}
          </div>
        </div>
        
        {/* Votes de la Communauté */}
        <div style={styles.votesSection}>
          <h3 style={styles.sectionTitle}>
            <span>📊</span> Votes de la Communauté
          </h3>

          <div style={styles.votesGrid}>
            {/* Première ligne */}
            <div style={styles.votesRow}>

              {/* Saisons */}
              <div style={{...styles.voteBlock, flex: 2}}>
                <span style={styles.voteBlockLabel}>Quand le porter ?</span>
                <div style={styles.seasonGrid}>
                  {[
                    { key: 'spring', label: 'Printemps', icon: '🌸' },
                    { key: 'summer', label: 'Été', icon: '☀️' },
                    { key: 'fall', label: 'Automne', icon: '🍂' },
                    { key: 'winter', label: 'Hiver', icon: '❄️' }
                  ].map(season => (
                    <div 
                      key={season.key} 
                      style={{
                        ...styles.seasonBtn,
                        ...(seasonVotes[season.key] ? styles.seasonBtnActive : {}),
                        cursor: userSignedIn ? 'pointer' : 'default'
                      }}
                      onClick={() => handleSeasonClick(season.key)}
                    >
                      <span style={styles.seasonIcon}>{season.icon}</span>
                      <span style={styles.seasonLabel}>{season.label}</span>
                      <div style={styles.seasonBarBg}>
                        <div style={{
                          ...styles.seasonBarFill,
                          width: `${perfume.preferred_season?.[season.key]?.percentage || 0}%`
                        }} />
                      </div>
                      <span style={styles.seasonVotes}>
                        {perfume.preferred_season?.[season.key]?.count || 0} votes
                      </span>
                    </div>
                  ))}
                </div>
              </div>
              
              {/* Jour/Nuit */}
              <div style={{...styles.voteBlock, flex: 1}}>
                <span style={styles.voteBlockLabel}>Jour ou Nuit ?</span>
                <div style={styles.dayNightGrid}>
                  {[
                    { key: 'day', label: 'Jour', icon: '☀️' },
                    { key: 'night', label: 'Nuit', icon: '🌙' }
                  ].map(time => (
                    <div 
                      key={time.key} 
                      style={{
                        ...styles.dayNightBtn,
                        ...(dayNightVotes[time.key] ? styles.seasonBtnActive : {}),
                        cursor: userSignedIn ? 'pointer' : 'default'
                      }}
                      onClick={() => handleDayNightClick(time.key)}
                    >
                      <span style={styles.dayNightIcon}>{time.icon}</span>
                      <span>{time.label}</span>
                      <span style={styles.dayNightPercent}>
                        {perfume.preferred_time?.[time.key]?.percentage || 0}%
                      </span>
                    </div>
                  ))}
                </div>
              </div>

              {/* Longévité */}
              <div style={{...styles.voteBlock, flex: 1}}>
                <span style={styles.voteBlockLabel}>⏱ Longévité</span>
                <div style={styles.ratingBars}>
                  {[
                    { key: 1, label: 'Très faible' },
                    { key: 2, label: 'Faible' },
                    { key: 3, label: 'Modérée' },
                    { key: 4, label: 'Longue' },
                    { key: 5, label: 'Éternelle' }
                  ].map(item => (
                    <div 
                      key={item.key} 
                      style={{
                        ...styles.ratingRow,
                        ...(longevityVote === item.key ? styles.ratingRowActive : {}),
                        cursor: userSignedIn ? 'pointer' : 'default'
                      }}
                      onClick={() => handleLongevityClick(item.key)}
                      >
                      <span style={styles.ratingLabelText}>{item.label}</span>
                      <div style={styles.ratingBarBg}>
                        <div style={{
                          ...styles.ratingBarFill,
                          width: `${perfume.longevity_distribution?.[item.key]?.percentage || 0}%`
                        }} />
                      </div>
                      <span style={styles.ratingCount}>
                        {perfume.longevity_distribution?.[item.key]?.count || 0}
                      </span>
                    </div>
                  ))}
                </div>
              </div>

              {/* Sillage */}
              <div style={{...styles.voteBlock, flex: 1}}>
                <span style={styles.voteBlockLabel}>💨 Sillage</span>
                <div style={styles.ratingBars}>
                  {[
                    { key: 1, label: 'Intime' },
                    { key: 2, label: 'Modéré' },
                    { key: 3, label: 'Fort' },
                    { key: 4, label: 'Énorme' }
                  ].map(item => (
                    <div 
                      key={item.key} 
                      style={{
                        ...styles.ratingRow,
                        ...(sillageVote === item.key ? styles.ratingRowActive : {}),
                        cursor: userSignedIn ? 'pointer' : 'default'
                      }}
                      onClick={() => handleSillageClick(item.key)}
                      >
                      <span style={styles.ratingLabelText}>{item.label}</span>
                      <div style={styles.ratingBarBg}>
                        <div style={{
                          ...styles.ratingBarFill,
                          width: `${perfume.sillage_distribution?.[item.key]?.percentage || 0}%`
                        }} />
                      </div>
                      <span style={styles.ratingCount}>
                        {perfume.sillage_distribution?.[item.key]?.count || 0}
                      </span>
                    </div>
                  ))}
                </div>
              </div>
            </div>

            {/* Deuxième ligne - Rapport Qualité/Prix */}
            <div style={styles.voteBlock}>
              <span style={styles.voteBlockLabel}>💰 Rapport Qualité/Prix</span>
              <div style={styles.ratingBars}>
                {[
                  { key: 1, label: 'Trop cher' },
                  { key: 2, label: 'Cher' },
                  { key: 3, label: 'Correct' },
                  { key: 4, label: 'Bon' },
                  { key: 5, label: 'Excellent' }
                ].map(item => (
                  <div 
                    key={item.key} 
                    style={{
                      ...styles.ratingRow, 
                      ...(valueVote === item.key ? styles.ratingRowActive : {}),
                      cursor: userSignedIn ? 'pointer' : 'default'
                    }}
                    onClick={() => handleValueClick(item.key)}
                    >
                    <span style={styles.ratingLabelText}>{item.label}</span>
                    <div style={styles.ratingBarBg}>
                      <div style={{
                        ...styles.ratingBarFill,
                        width: `${perfume.value_distribution?.[item.key]?.percentage || 0}%`
                      }} />
                    </div>
                    <span style={styles.ratingCount}>
                      {perfume.value_distribution?.[item.key]?.count || 0}
                    </span>
                  </div>
                ))}
              </div>
            </div>
          </div>
        </div>

        {/* Prix & Marketplace */}
        <div style={styles.commerceGrid}>
          <div style={styles.priceCard}>
            <div style={styles.priceHeader}>
              <span style={styles.priceLabel}>Prix neuf</span>
              <button
                style={{...styles.wishlistBtn, ...(isWishlisted ? styles.wishlistBtnActive : {})}}
                onClick={() => setIsWishlisted(!isWishlisted)}
              >
                {isWishlisted ? '❤️' : '🤍'}
              </button>
            </div>
            <div style={styles.priceAmount}>
              <span style={styles.priceBig}>{volumes[selectedVolume].price}€</span>
              <span style={styles.priceUnit}>/ {volumes[selectedVolume].size}</span>
            </div>
            <div style={styles.volumeSelector}>
              {volumes.map((vol, idx) => (
                <button
                  key={idx}
                  style={{...styles.volumeBtn, ...(selectedVolume === idx ? styles.volumeBtnActive : {})}}
                  onClick={() => setSelectedVolume(idx)}
                >
                  <span style={styles.volSize}>{vol.size}</span>
                  <span style={styles.volPrice}>{vol.price}€</span>
                </button>
              ))}
            </div>
            <button style={styles.addToCollectionBtn}>
              ➕ Ajouter à ma collection
            </button>
          </div>

          <div style={styles.marketplaceCard}>
            <div style={styles.marketHeader}>
              <h4 style={styles.marketTitle}>🏪 Marketplace</h4>
              <span style={styles.offersBadge}>Bientôt disponible</span>
            </div>
            <p style={{ color: '#a89f91', textAlign: 'center', padding: '2rem 0' }}>
              Les offres de la communauté arrivent bientôt !
            </p>
          </div>
        </div>

        {/* Histoire */}
        <div style={styles.descriptionCard}>
          <h3 style={styles.sectionTitle}>
            <span>📖</span> L'Histoire
          </h3>
          <p style={styles.descriptionText}>
            {perfume.description || 'Description à venir...'}
          </p>
        </div>
      </div>
    </div>
  );
}

// Styles (identiques à la v4)
const styles = {
  container: {
    fontFamily: "'DM Sans', -apple-system, sans-serif",
    background: '#f8f5f0',
    color: '#2d2a26',
    minHeight: '100vh'
  },
  header: {
    padding: '1rem 3rem',
    display: 'flex',
    justifyContent: 'space-between',
    alignItems: 'center',
    background: 'rgba(248,245,240,0.95)',
    backdropFilter: 'blur(10px)',
    position: 'sticky',
    top: 0,
    zIndex: 100,
    borderBottom: '1px solid #e8e0d5'
  },
  logo: { fontFamily: "'Playfair Display', serif", fontSize: '1.8rem', color: '#6b5d4d' },
  logoAccent: { fontStyle: 'italic', color: '#9caa97' },
  nav: { display: 'flex', gap: '2rem' },
  navLink: { color: '#6b5d4d', textDecoration: 'none', fontSize: '0.9rem' },
  headerRight: { display: 'flex', alignItems: 'center', gap: '0.8rem' },
  avatar: {
    width: 40, height: 40, borderRadius: 12,
    background: 'linear-gradient(135deg, #9caa97, #7a9a75)',
    color: 'white', display: 'flex', alignItems: 'center', justifyContent: 'center', fontWeight: 600
  },
  mainGrid: {
    display: 'grid',
    gridTemplateColumns: '400px 1fr',
    gap: '3rem',
    padding: '1.5rem 3rem',
    maxWidth: 1400,
    margin: '0 auto',
    alignItems: 'start'
  },
  mainImageContainer: { marginBottom: '1rem' },
  mainImage: { width: '100%', borderRadius: '24', height: '377px', objectFit: 'contain' },
  thumbnails: { display: 'flex', gap: '0.8rem', justifyContent: 'center', marginBottom: '1.5rem' },
  thumbnail: {
    width: 70, height: 70, background: 'white', borderRadius: 14,
    padding: '0.4rem', cursor: 'pointer', border: '2px solid transparent'
  },
  thumbnailActive: { borderColor: '#9caa97' },
  thumbnailImg: { width: '100%', height: '100%', objectFit: 'contain' },
  parfumeurCard: {
    background: 'white', borderRadius: 20, padding: '1.5rem',
    display: 'flex', justifyContent: 'space-between', alignItems: 'center'
  },
  parfumeurItem: { display: 'flex', alignItems: 'center', gap: '0.8rem', flex: 1 },
  parfumeurIcon: { fontSize: '1.5rem' },
  parfumeurLabel: {
    display: 'block', fontSize: '0.65rem', color: '#a89f91',
    textTransform: 'uppercase', letterSpacing: '0.05em', marginBottom: '0.15rem'
  },
  parfumeurValue: { display: 'block', fontWeight: 600, fontSize: '0.9rem', color: '#5a4d3f' },
  parfumeurDivider: { width: 1, height: 40, background: '#e8e0d5', margin: '0 0.5rem' },
  productHeader: { marginBottom: '1.5rem' },
  topTag: { display: 'flex' , justifyContent: 'flex-start' , gap: '0.5rem' },
  brandTag: {
    display: 'inline-block', background: '#e8e0d5', padding: '0.4rem 1rem',
    borderRadius: 20, fontSize: '0.75rem', textTransform: 'uppercase',
    letterSpacing: '0.08em', color: '#6b5d4d', marginBottom: '0.8rem'
  },
  productName: {
    fontFamily: "'Playfair Display', serif", fontSize: '2.8rem',
    fontWeight: 400, lineHeight: 1.1, marginBottom: '0.4rem'
  },
  tagline: {
    fontFamily: "'Playfair Display', serif", fontSize: '1.1rem',
    fontStyle: 'italic', color: '#a89f91', marginBottom: '1rem'
  },
  ratingRow: { display: 'flex', alignItems: 'center', gap: '0.5rem' },
  ratingStars: { color: '#c4a77d', fontSize: '1.1rem' },
  ratingScore: { fontWeight: 600, fontSize: '1.1rem', color: '#5a4d3f' },
  ratingCount: { color: '#a89f91', fontSize: '0.9rem' },
  accordsSection: { background: 'white', borderRadius: 20, padding: '1.5rem' },
  sectionTitle: {
    fontFamily: "'Playfair Display', serif", fontSize: '1.2rem',
    marginBottom: '1rem', display: 'flex', alignItems: 'center', gap: '0.6rem'
  },
  accordsList: { display: 'flex', flexDirection: 'column', gap: '0.8rem' },
  accordItem: {},
  accordHeader: { display: 'flex', justifyContent: 'space-between', marginBottom: '0.3rem' },
  accordName: { fontSize: '0.85rem', fontWeight: 500 },
  accordBarBg: { height: 8, background: '#f0ebe3', borderRadius: 4, overflow: 'hidden' },
  accordBarFill: { height: '100%', borderRadius: 4, background: '#9caa97' },
  fullWidthContainer: {
    padding: '2rem 3rem 4rem', maxWidth: 1400, margin: '0 auto'
  },
  notesCenterWrapper: { display: 'flex', justifyContent: 'center', marginBottom: '2rem' },
  notesCard: { background: 'white', borderRadius: 20, padding: '2rem', maxWidth: 700, width: '100%' },
  sectionTitleCentered: {
    fontFamily: "'Playfair Display', serif", fontSize: '1.3rem',
    marginBottom: '1.5rem', display: 'flex', alignItems: 'center', justifyContent: 'center', gap: '0.6rem'
  },
  notesTier: { marginBottom: '1.5rem' },
  tierHeaderCentered: {
    display: 'flex', alignItems: 'center', justifyContent: 'center', gap: '0.5rem', marginBottom: '1rem'
  },
  tierIcon: { fontSize: '1.3rem' },
  tierLabel: {
    fontSize: '0.85rem', fontWeight: 600, textTransform: 'uppercase',
    letterSpacing: '0.05em', color: '#6b5d4d'
  },
  notesChipsCentered: { display: 'flex', flexWrap: 'wrap', gap: '0.6rem', justifyContent: 'center' },
  noteChip: {
    display: 'inline-flex', alignItems: 'center', gap: '0.4rem',
    background: '#f8f5f0', padding: '0.6rem 1rem', borderRadius: 20, fontSize: '0.85rem'
  },
  commerceGrid: { display: 'grid', gridTemplateColumns: '1fr 1fr', gap: '2rem', marginBottom: '2rem' },
  priceCard: { background: 'white', borderRadius: 20, padding: '2rem' },
  priceHeader: { display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '0.5rem' },
  priceLabel: { fontSize: '0.85rem', color: '#a89f91', textTransform: 'uppercase', fontWeight: 500 },
  wishlistBtn: {
    width: 40, height: 40, borderRadius: '50%', background: '#f8f5f0',
    border: 'none', fontSize: '1.2rem', cursor: 'pointer'
  },
  wishlistBtnActive: { background: '#fce4ec' },
  priceAmount: { marginBottom: '1.5rem' },
  priceBig: { fontFamily: "'Playfair Display', serif", fontSize: '2.8rem', color: '#5a4d3f' },
  priceUnit: { color: '#a89f91', fontSize: '1rem', marginLeft: '0.3rem' },
  volumeSelector: { display: 'flex', gap: '0.8rem', marginBottom: '1.5rem' },
  volumeBtn: {
    flex: 1, padding: '1rem', background: '#f8f5f0', border: '2px solid transparent',
    borderRadius: 12, textAlign: 'center', cursor: 'pointer', fontFamily: 'inherit'
  },
  volumeBtnActive: { background: 'white', borderColor: '#9caa97' },
  volSize: { display: 'block', fontWeight: 600, fontSize: '1rem', marginBottom: '0.2rem' },
  volPrice: { fontSize: '0.8rem', color: '#a89f91' },
  addToCollectionBtn: {
    width: '100%', padding: '1.1rem', background: '#9caa97', border: 'none',
    borderRadius: 50, color: 'white', fontFamily: 'inherit', fontSize: '1rem',
    fontWeight: 500, cursor: 'pointer'
  },
  marketplaceCard: { background: 'white', borderRadius: 20, padding: '2rem' },
  marketHeader: { display: 'flex', justifyContent: 'space-between', alignItems: 'center', marginBottom: '1.5rem' },
  marketTitle: { fontSize: '1.2rem', fontWeight: 600, margin: 0 },
  offersBadge: { background: '#e8e0d5', color: '#6b5d4d', padding: '0.35rem 0.9rem', borderRadius: 20, fontSize: '0.8rem' },
  descriptionCard: { background: 'white', borderRadius: 20, padding: '2rem' },
  descriptionText: { fontSize: '1.05rem', lineHeight: 1.9, color: '#5a4d3f', margin: 0 },
  votesSection: {
    background: 'white',
    borderRadius: 20,
    padding: '2rem',
    marginBottom: '2rem'
  },
  votesGrid: {
    display: 'flex',
    flexDirection: 'column',
    gap: '2rem'
  },
  votesRow: {
    display: 'flex',
    gap: '1.5rem'
  },
  voteBlock: {
    display: 'flex',
    flexDirection: 'column',
    gap: '0.75rem'
  },
  voteBlockLabel: {
    fontSize: '1rem',
    fontWeight: 600,
    color: '#5a4d3f'
  },
  seasonGrid: {
    display: 'grid',
    gridTemplateColumns: 'repeat(4, 1fr)',
    gap: '0.5rem'
  },
  seasonBtn: {
    background: '#f8f5f0',
    borderRadius: 12,
    padding: '0.75rem',
    textAlign: 'center'
  },
  seasonIcon: {
    display: 'block',
    fontSize: '1.5rem',
    marginBottom: '0.25rem'
  },
  seasonLabel: {
    display: 'block',
    fontSize: '0.7rem',
    fontWeight: 500,
    marginBottom: '0.5rem'
  },
  seasonBarBg: {
    height: 4,
    background: '#e8e0d5',
    borderRadius: 2,
    marginBottom: '0.25rem'
  },
  seasonBarFill: {
    height: '100%',
    background: '#9caa97',
    borderRadius: 2
  },
  seasonVotes: {
    fontSize: '0.65rem',
    color: '#a89f91'
  },
  dayNightGrid: {
    display: 'flex',
    flexDirection: 'column',
    gap: '0.5rem'
  },
  dayNightBtn: {
    background: '#f8f5f0',
    borderRadius: 12,
    padding: '1rem',
    display: 'flex',
    alignItems: 'center',
    gap: '0.5rem'
  },
  dayNightIcon: {
    fontSize: '1.25rem'
  },
  dayNightPercent: {
    marginLeft: 'auto',
    fontWeight: 600,
    color: '#9caa97'
  },
  ratingBars: {
    display: 'flex',
    flexDirection: 'column',
    gap: '0.4rem'
  },
  ratingRow: {
    display: 'flex',
    alignItems: 'center',
    gap: '0.5rem'
  },
  ratingLabel: {
    width: '1rem',
    fontSize: '0.8rem',
    fontWeight: 500,
    color: '#5a4d3f'
  },
  ratingBarBg: {
    flex: 1,
    height: 8,
    background: '#f0ebe3',
    borderRadius: 4,
    overflow: 'hidden'
  },
  ratingBarFill: {
    height: '100%',
    background: '#9caa97',
    borderRadius: 4
  },
  ratingCount: {
    width: '2rem',
    fontSize: '0.7rem',
    color: '#a89f91',
    textAlign: 'right'
  },
  valueRatingRow: {
    display: 'flex',
    justifyContent: 'space-between',
    gap: '1rem'
  },
  valueRatingItem: {
    flex: 1,
    display: 'flex',
    flexDirection: 'column',
    alignItems: 'center',
    gap: '0.5rem'
  },
  valueBarContainer: {
    width: '100%',
    height: 80,
    background: '#f0ebe3',
    borderRadius: 8,
    display: 'flex',
    flexDirection: 'column',
    justifyContent: 'flex-end',
    overflow: 'hidden'
  },
  valueBarFill: {
    width: '100%',
    background: '#9caa97',
    borderRadius: '8px 8px 0 0'
  },
  valueLabel: {
    fontSize: '0.75rem',
    fontWeight: 500,
    color: '#5a4d3f',
    textAlign: 'center'
  },
  valueCount: {
    fontSize: '0.7rem',
    color: '#a89f91'
  },
  ratingLabelText: {
    width: '5rem',
    fontSize: '0.8rem',
    color: '#5a4d3f'
  },
  seasonBtnActive: {
    background: '#e8f5e9',
    border: '2px solid #9caa97'
  },
  ratingRowActive: {
    background: '#e8f5e9',
    borderRadius: 8,
    padding: '0.2rem'
  }
};
