// app/javascript/pages/Perfumes/Show.jsx
import React, { useState } from 'react';

export default function Show({ perfume, userSignedIn, currentUser }) {
  const [selectedVolume, setSelectedVolume] = useState(1);
  const [isWishlisted, setIsWishlisted] = useState(false);

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

            { perfume.notes_ordered.forEach( family => {
              if family === :
            });}

            {['top', 'heart', 'base'].map(type => {
              const typeLabels = { top: 'Tête', heart: 'Cœur', base: 'Fond' };
              const typeIcons = { top: '🍃', heart: '🌸', base: '🪵' };
              const notes = perfume.notes?.filter(n =>
                perfume.perfume_notes?.find(pn => pn.note_type === type)
              ) || [];

              return (
                <div key={type} style={styles.notesTier}>
                  <div style={styles.tierHeaderCentered}>
                    <span style={styles.tierIcon}>{typeIcons[type]}</span>
                    <span style={styles.tierLabel}>Notes de {typeLabels[type]}</span>
                  </div>
                  <div style={styles.notesChipsCentered}>
                    {notes.length > 0 ? notes.map((note, idx) => (
                      <span key={idx} style={styles.noteChip}>{note.name}</span>
                    )) : (
                      <span style={styles.noteChip}>Non renseigné</span>
                    )}
                  </div>
                </div>
              );
            })}
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
  descriptionText: { fontSize: '1.05rem', lineHeight: 1.9, color: '#5a4d3f', margin: 0 }
};
