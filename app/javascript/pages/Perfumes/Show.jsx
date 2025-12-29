// app/javascript/pages/Perfumes/Show.jsx
import React, { useState } from 'react';
import PriceAlertModal from '../../components/PriceAlertModal';
import CollectionModal from '../../components/CollectionModal';
import styles from './Show.module.scss';

export default function Show({ perfume, userSignedIn, currentUser, userSeasonVotes, userReviews, userWishlist, userCollectedVolumes, userPriceAlert }) {
  const [selectedVolume, setSelectedVolume] = useState(1);
  const [isWishlisted, setIsWishlisted] = useState(userWishlist || false);
  const [collectedVolumes, setCollectedVolumes] = useState(userCollectedVolumes || []);
  const [showCollectionModal, setShowCollectionModal] = useState(false);
  const [baseQuantity, setBaseQuantity] = useState(100);
  const [showPriceAlertModal, setShowPriceAlertModal] = useState(false);
  const [priceAlert, setPriceAlert] = useState(userPriceAlert || null);

  const [seasonVotes, setSeasonVotes] = useState({
    spring: userSeasonVotes?.spring || false,
    summer: userSeasonVotes?.summer || false,
    fall: userSeasonVotes?.fall || false,
    winter: userSeasonVotes?.winter || false
  });
  
  const [seasonCounts, setSeasonCounts] = useState({
    spring: { count: perfume.preferred_season?.spring?.count || 0, percentage: perfume.preferred_season?.spring?.percentage || 0 },
    summer: { count: perfume.preferred_season?.summer?.count || 0, percentage: perfume.preferred_season?.summer?.percentage || 0 },
    fall: { count: perfume.preferred_season?.fall?.count || 0, percentage: perfume.preferred_season?.fall?.percentage || 0 },
    winter: { count: perfume.preferred_season?.winter?.count || 0, percentage: perfume.preferred_season?.winter?.percentage || 0 }
  });

  const [dayNightVotes, setDayNightVotes] = useState({
    day: userSeasonVotes?.day || false,
    night: userSeasonVotes?.night || false
  });

  const [dayNightCounts, setDayNightCounts] = useState({
    day: { count: perfume.preferred_time?.day?.count || 0, percentage: perfume.preferred_time?.day?.percentage || 0 },
    night: { count: perfume.preferred_time?.night?.count || 0, percentage: perfume.preferred_time?.night?.percentage || 0 }
  });

  const [longevityCounts, setLongevityCounts] = useState({
    1: { count: perfume.longevity_distribution?.[1]?.count || 0, percentage: perfume.longevity_distribution?.[1]?.percentage || 0 },
    2: { count: perfume.longevity_distribution?.[2]?.count || 0, percentage: perfume.longevity_distribution?.[2]?.percentage || 0 },
    3: { count: perfume.longevity_distribution?.[3]?.count || 0, percentage: perfume.longevity_distribution?.[3]?.percentage || 0 },
    4: { count: perfume.longevity_distribution?.[4]?.count || 0, percentage: perfume.longevity_distribution?.[4]?.percentage || 0 },
    5: { count: perfume.longevity_distribution?.[5]?.count || 0, percentage: perfume.longevity_distribution?.[5]?.percentage || 0 }
  });

  const [sillageCounts, setSillageCounts] = useState({
    1: { count: perfume.sillage_distribution?.[1]?.count || 0, percentage: perfume.sillage_distribution?.[1]?.percentage || 0 },
    2: { count: perfume.sillage_distribution?.[2]?.count || 0, percentage: perfume.sillage_distribution?.[2]?.percentage || 0 },
    3: { count: perfume.sillage_distribution?.[3]?.count || 0, percentage: perfume.sillage_distribution?.[3]?.percentage || 0 },
    4: { count: perfume.sillage_distribution?.[4]?.count || 0, percentage: perfume.sillage_distribution?.[4]?.percentage || 0 }
  });

  const [valueCounts, setValueCounts] = useState({
    1: { count: perfume.value_distribution?.[1]?.count || 0, percentage: perfume.value_distribution?.[1]?.percentage || 0 },
    2: { count: perfume.value_distribution?.[2]?.count || 0, percentage: perfume.value_distribution?.[2]?.percentage || 0 },
    3: { count: perfume.value_distribution?.[3]?.count || 0, percentage: perfume.value_distribution?.[3]?.percentage || 0 },
    4: { count: perfume.value_distribution?.[4]?.count || 0, percentage: perfume.value_distribution?.[4]?.percentage || 0 },
    5: { count: perfume.value_distribution?.[5]?.count || 0, percentage: perfume.value_distribution?.[5]?.percentage || 0 }
  });

  const [longevityVote, setLongevityVote] = useState(userReviews?.rating_longevity || null);
  const [sillageVote, setSillageVote] = useState(userReviews?.rating_sillage || null);
  const [valueVote, setValueVote] = useState(userReviews?.rating_value || null);

  const handleWishlistClick = () => {
    if (!userSignedIn) return;
    const method = isWishlisted ? 'DELETE' : 'POST';
    setIsWishlisted(!isWishlisted);
    
    fetch(`/perfumes/${perfume.id}/wishlist`, {
      method: method,
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
      }
    });
  };

  const handleSeasonClick = (season) => {
    if (!userSignedIn) return;
    
    const newValue = !seasonVotes[season];
    const newSeasonVotes = { ...seasonVotes, [season]: newValue };
    
    setSeasonVotes(newSeasonVotes);
    
    setSeasonCounts(prev => {
      const newCount = newValue ? prev[season].count + 1 : prev[season].count - 1;
      const newCounts = { ...prev, [season]: { ...prev[season], count: newCount } };
      const total = Object.values(newCounts).reduce((sum, s) => sum + s.count, 0);
      
      return {
        spring: { count: newCounts.spring.count, percentage: total > 0 ? Math.round((newCounts.spring.count / total) * 100) : 0 },
        summer: { count: newCounts.summer.count, percentage: total > 0 ? Math.round((newCounts.summer.count / total) * 100) : 0 },
        fall: { count: newCounts.fall.count, percentage: total > 0 ? Math.round((newCounts.fall.count / total) * 100) : 0 },
        winter: { count: newCounts.winter.count, percentage: total > 0 ? Math.round((newCounts.winter.count / total) * 100) : 0 }
      };
    });
    
    fetch(`/perfumes/${perfume.id}/season_votes`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
      },
      body: JSON.stringify({ season_vote: newSeasonVotes })
    });
  };

  const handleDayNightClick = (dayNight) => {
    if (!userSignedIn) return;
    
    const newValue = !dayNightVotes[dayNight];
    const newDayNightVotes = { ...dayNightVotes, [dayNight]: newValue };
    
    setDayNightVotes(newDayNightVotes);
    
    setDayNightCounts(prev => {
      const newCount = newValue ? prev[dayNight].count + 1 : prev[dayNight].count - 1;
      const newCounts = { ...prev, [dayNight]: { ...prev[dayNight], count: newCount } };
      const total = Object.values(newCounts).reduce((sum, s) => sum + s.count, 0);
      
      return {
        day: { count: newCounts.day.count, percentage: total > 0 ? Math.round((newCounts.day.count / total) * 100) : 0 },
        night: { count: newCounts.night.count, percentage: total > 0 ? Math.round((newCounts.night.count / total) * 100) : 0 }
      };
    });
  
    fetch(`/perfumes/${perfume.id}/season_votes`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
      },
      body: JSON.stringify({ season_vote: newDayNightVotes })
    });
  };

  const handleRatingClick = (type, value) => {
    if (!userSignedIn) return;
    const configs = {
      longevity: {
        vote: longevityVote,
        setVote: setLongevityVote,
        setCounts: setLongevityCounts,
        maxKey: 5,
        field: 'rating_longevity'
      },
      sillage: {
        vote: sillageVote,
        setVote: setSillageVote,
        setCounts: setSillageCounts,
        maxKey: 4,
        field: 'rating_sillage'
      },
      value: {
        vote: valueVote,
        setVote: setValueVote,
        setCounts: setValueCounts,
        maxKey: 5,
        field: 'rating_value'
      }
    };

    const config = configs[type];
    const oldValue = config.vote;
    const newValue = oldValue === value ? null : value;
    
    config.setVote(newValue);

    config.setCounts(prev => {
      const newCounts = { ...prev };
      
      if (oldValue !== null && newCounts[oldValue]) {
        newCounts[oldValue] = { ...newCounts[oldValue], count: newCounts[oldValue].count - 1 };
      }
      if (newValue !== null && newCounts[newValue]) {
        newCounts[newValue] = { ...newCounts[newValue], count: newCounts[newValue].count + 1 };
      }
      
      const total = Object.values(newCounts).reduce((sum, item) => sum + item.count, 0);
      
      const result = {};
      for (let i = 1; i <= config.maxKey; i++) {
        result[i] = {
          count: newCounts[i]?.count || 0,
          percentage: total > 0 ? Math.round(((newCounts[i]?.count || 0) / total) * 100) : 0
        };
      }
      return result;
    });

    fetch(`/perfumes/${perfume.id}/reviews`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
      },
      body: JSON.stringify({ review: { [config.field]: newValue } })
    });
  };
  
  const volumes = [
    { size: "50ml", price: 120 },
    { size: "100ml", price: 185 },
    { size: "150ml", price: 240 }
  ];

  return (
    <div className={styles.container}>
      {/* Header */}
      <header className={styles.header}>
        <div className={styles.logo}>My<span className={styles.logoAccent}>Sillage</span></div>
        <nav className={styles.nav}>
          <a href="/" className={styles.navLink}>Découvrir</a>
          <a href="/marketplace" className={styles.navLink}>Marketplace</a>
          <a href="/brands" className={styles.navLink}>Maisons</a>
        </nav>
        <div className={styles.headerRight}>
          {userSignedIn ? (
            <div className={styles.avatar}>{currentUser?.username?.[0]?.toUpperCase() || 'U'}</div>
          ) : (
            <a href="/login" className={styles.navLink}>Connexion</a>
          )}
        </div>
      </header>

      {/* Main Content */}
      <main className={styles.mainGrid}>
        {/* Left Column */}
        <div>
          <div className={styles.mainImageContainer}>
            <img
              src={perfume.placeholder_image}
              alt={perfume.name}
              className={styles.mainImage}
            />
          </div>
  
          {/* Parfumeur Card */}
          <div className={styles.parfumeurCard}>
            <div className={styles.parfumeurItem}>
              <span className={styles.parfumeurIcon}></span>
              <div>
                <span className={styles.parfumeurLabel}>Parfumeur</span>
                <span className={styles.parfumeurValue}>
                  {perfume.perfumers?.map(p => p.name).join(', ') || 'Non renseigné'}
                </span>
              </div>
            </div>
            <div className={styles.parfumeurDivider} />
            <div className={styles.parfumeurItem}>
              <span className={styles.parfumeurIcon}></span>
              <div>
                <span className={styles.parfumeurLabel}>Année</span>
                <span className={styles.parfumeurValue}>{perfume.launch_year || 'N/A'}</span>
              </div>
            </div>
            <div className={styles.parfumeurDivider} />
            <div className={styles.parfumeurItem}>
              <span className={styles.parfumeurIcon}></span>
              <div>
                <span className={styles.parfumeurLabel}>Concentration</span>
                <span className={styles.parfumeurValue}>{perfume.concentration || 'EDP'}</span>
              </div>
            </div>
          </div>
        </div>

        {/* Right Column */}
        <div>
          <div className={styles.productHeader}>
            <div className={styles.topTag}>
              <span className={styles.brandTag}>{perfume.brand?.name}</span>
              <span className={styles.brandTag}>{perfume.gender}</span>
              {userSignedIn && (
                <button 
                  className={`${styles.brandTag} ${styles.priceAlertTag} ${priceAlert ? styles.priceAlertTagActive : ''}`}
                  onClick={() => setShowPriceAlertModal(true)}
                >
                  {priceAlert ? '🔔 Alerte active' : 'Ajouter une alerte🔕'}
                </button>
              )}
            </div>
            <h1 className={styles.productName}>{perfume.name}</h1>
            <p className={styles.tagline}>{perfume.tagline || perfume.description?.slice(0, 60) + '...'}</p>

            <div className={styles.ratingRow}>
              <span className={styles.ratingStars}>{'★'.repeat(4)}☆</span>
              <span className={styles.ratingScore}>4.5</span>
              <span className={styles.ratingCount}>({perfume.reviews?.length || 0} avis)</span>
            </div>
          </div>

          {/* Accords */}
          <div className={styles.accordsSection}>
            <h3 className={styles.sectionTitle}>
              <span>🎨</span> Accords Principaux
            </h3>
            <div className={styles.accordsList}>
              {perfume.notes?.slice(0, 5).map((note, idx) => (
                <div key={idx} className={styles.accordItem}>
                  <div className={styles.accordHeader}>
                    <span className={styles.accordName}>{note.name}</span>
                  </div>
                  <div className={styles.accordBarBg}>
                    <div 
                      className={styles.accordBarFill}
                      style={{ width: `${90 - idx * 15}%` }}
                    />
                  </div>
                </div>
              ))}
            </div>
          </div>
        </div>
      </main>

      {/* Full Width Sections */}
      <div className={styles.fullWidthContainer}>
        {/* Notes */}
        <div className={styles.notesCenterWrapper}>
          <div className={styles.notesCard}>
            <h3 className={styles.sectionTitleCentered}>
              <span>🌿</span> Notes Olfactives
            </h3>

            {Object.entries(perfume.notes_ordered).map(([type, notes]) => {
              const typeLabels = { top: 'Tête', heart: 'Cœur', base: 'Fond' };
              const typeIcons = { top: '🍃', heart: '🌸', base: '🪵' };

              return (
                <div key={type} className={styles.notesTier}>
                  <div className={styles.tierHeaderCentered}>
                    <span className={styles.tierIcon}>{typeIcons[type]}</span>
                    <span className={styles.tierLabel}>Notes de {typeLabels[type]}</span>
                  </div>
                  <div className={styles.notesChipsCentered}>
                    {notes.length > 0 ? notes.map((note, idx) => (
                      <span key={idx} className={styles.noteChip}>{note}</span>
                    )) : (
                      <span className={styles.noteChip}>Non renseigné</span>
                    )}
                  </div>
                </div>
              );
            })}
          </div>
        </div>
        
        {/* Votes de la Communauté */}
        <div className={styles.votesSection}>
          <h3 className={styles.sectionTitle}>
            <span>📊</span> Votes de la Communauté
          </h3>

          <div className={styles.votesGrid}>
            {/* Première ligne */}
            <div className={styles.votesRow}>

              {/* Saisons */}
              <div className={styles.voteBlock} style={{ flex: 2 }}>
                <span className={styles.voteBlockLabel}>Quand le porter ?</span>
                <div className={styles.seasonGrid}>
                  {[
                    { key: 'spring', label: 'Printemps', icon: '🌸' },
                    { key: 'summer', label: 'Été', icon: '☀️' },
                    { key: 'fall', label: 'Automne', icon: '🍂' },
                    { key: 'winter', label: 'Hiver', icon: '❄️' }
                  ].map(season => (
                    <div 
                      key={season.key} 
                      className={`${styles.seasonBtn} ${seasonVotes[season.key] ? styles.seasonBtnActive : ''}`}
                      style={{ cursor: userSignedIn ? 'pointer' : 'default' }}
                      onClick={() => handleSeasonClick(season.key)}
                    >
                      <span className={styles.seasonIcon}>{season.icon}</span>
                      <span className={styles.seasonLabel}>{season.label}</span>
                      <div className={styles.seasonBarBg}>
                        <div 
                          className={styles.seasonBarFill}
                          style={{ width: `${seasonCounts[season.key]?.percentage || 0}%` }}
                        />
                      </div>
                      <span className={styles.seasonVotes}>
                        {seasonCounts[season.key]?.count || 0} votes
                      </span>
                    </div>
                  ))}
                </div>
              </div>
              
              {/* Jour/Nuit */}
              <div className={styles.voteBlock} style={{ flex: 1 }}>
                <span className={styles.voteBlockLabel}>Jour ou Nuit ?</span>
                <div className={styles.dayNightGrid}>
                  {[
                    { key: 'day', label: 'Jour', icon: '☀️' },
                    { key: 'night', label: 'Nuit', icon: '🌙' }
                  ].map(time => (
                    <div 
                      key={time.key} 
                      className={`${styles.dayNightBtn} ${dayNightVotes[time.key] ? styles.seasonBtnActive : ''}`}
                      style={{ cursor: userSignedIn ? 'pointer' : 'default' }}
                      onClick={() => handleDayNightClick(time.key)}
                    >
                      <span className={styles.dayNightIcon}>{time.icon}</span>
                      <span>{time.label}</span>
                      <span className={styles.dayNightPercent}>
                        {dayNightCounts[time.key]?.percentage || 0}%
                      </span>
                    </div>
                  ))}
                </div>
              </div>

              {/* Longévité */}
              <div className={styles.voteBlock} style={{ flex: 1 }}>
                <span className={styles.voteBlockLabel}>⏱ Longévité</span>
                <div className={styles.ratingBars}>
                  {[
                    { key: 1, label: 'Très faible' },
                    { key: 2, label: 'Faible' },
                    { key: 3, label: 'Modérée' },
                    { key: 4, label: 'Longue' },
                    { key: 5, label: 'Éternelle' }
                  ].map(item => (
                    <div 
                      key={item.key} 
                      className={`${styles.ratingRowVote} ${longevityVote === item.key ? styles.ratingRowActive : ''}`}
                      style={{ cursor: userSignedIn ? 'pointer' : 'default' }}
                      onClick={() => handleRatingClick('longevity', item.key)}
                    >
                      <span className={styles.ratingLabelText}>{item.label}</span>
                      <div className={styles.ratingBarBg}>
                        <div 
                          className={styles.ratingBarFill}
                          style={{ width: `${longevityCounts[item.key]?.percentage || 0}%` }}
                        />
                      </div>
                      <span className={styles.ratingCountVote}>
                        {longevityCounts[item.key]?.count || 0}
                      </span>
                    </div>
                  ))}
                </div>
              </div>

              {/* Sillage */}
              <div className={styles.voteBlock} style={{ flex: 1 }}>
                <span className={styles.voteBlockLabel}>💨 Sillage</span>
                <div className={styles.ratingBars}>
                  {[
                    { key: 1, label: 'Intime' },
                    { key: 2, label: 'Modéré' },
                    { key: 3, label: 'Fort' },
                    { key: 4, label: 'Énorme' }
                  ].map(item => (
                    <div 
                      key={item.key} 
                      className={`${styles.ratingRowVote} ${sillageVote === item.key ? styles.ratingRowActive : ''}`}
                      style={{ cursor: userSignedIn ? 'pointer' : 'default' }}
                      onClick={() => handleRatingClick('sillage', item.key)}
                    >
                      <span className={styles.ratingLabelText}>{item.label}</span>
                      <div className={styles.ratingBarBg}>
                        <div 
                          className={styles.ratingBarFill}
                          style={{ width: `${sillageCounts[item.key]?.percentage || 0}%` }}
                        />
                      </div>
                      <span className={styles.ratingCountVote}>
                        {sillageCounts[item.key]?.count || 0}
                      </span>
                    </div>
                  ))}
                </div>
              </div>
            </div>

            {/* Deuxième ligne - Rapport Qualité/Prix */}
            <div className={styles.voteBlock}>
              <span className={styles.voteBlockLabel}>💰 Rapport Qualité/Prix</span>
              <div className={styles.ratingBars}>
                {[
                  { key: 1, label: 'Trop cher' },
                  { key: 2, label: 'Cher' },
                  { key: 3, label: 'Correct' },
                  { key: 4, label: 'Bon' },
                  { key: 5, label: 'Excellent' }
                ].map(item => (
                  <div 
                    key={item.key} 
                    className={`${styles.ratingRowVote} ${valueVote === item.key ? styles.ratingRowActive : ''}`}
                    style={{ cursor: userSignedIn ? 'pointer' : 'default' }}
                    onClick={() => handleRatingClick('value', item.key)}
                  >
                    <span className={styles.ratingLabelText}>{item.label}</span>
                    <div className={styles.ratingBarBg}>
                      <div 
                        className={styles.ratingBarFill}
                        style={{ width: `${valueCounts[item.key]?.percentage || 0}%` }}
                      />
                    </div>
                    <span className={styles.ratingCountVote}>
                      {valueCounts[item.key]?.count || 0}
                    </span>
                  </div>
                ))}
              </div>
            </div>
          </div>
        </div>

        {/* Prix & Marketplace */}
        <div className={styles.commerceGrid}>
          <div className={styles.priceCard}>
            <div className={styles.priceHeader}>
              <span className={styles.priceLabel}>Prix neuf</span>
              <button
                className={`${styles.wishlistBtn} ${isWishlisted ? styles.wishlistBtnActive : ''}`}
                onClick={handleWishlistClick}
              >
                {isWishlisted ? '❤️' : '🤍'}
              </button>
            </div>
            <div className={styles.priceAmount}>
              <span className={styles.priceBig}>{volumes[selectedVolume].price}€</span>
              <span className={styles.priceUnit}>/ {volumes[selectedVolume].size}</span>
            </div>
            <div className={styles.volumeSelector}>
              {volumes.map((vol, idx) => {
                const sizeNumber = parseInt(vol.size); 
                const isCollected = collectedVolumes.includes(sizeNumber);
                
                return (
                  <button
                    key={idx}
                    className={`${styles.volumeBtn} ${selectedVolume === idx ? styles.volumeBtnActive : ''} ${isCollected ? styles.volumeBtnCollected : ''}`}
                    onClick={() => !isCollected && setSelectedVolume(idx)}
                    disabled={isCollected}
                  >
                    <span className={styles.volSize}>{vol.size}</span>
                    <span className={styles.volPrice}>{vol.price}€</span>
                    {isCollected && <span className={styles.collectedBadge}>✓</span>}
                  </button>
                );
              })}
            </div>
            <button 
              className={`${styles.addToCollectionBtn} ${collectedVolumes.includes(parseInt(volumes[selectedVolume].size)) ? styles.btnDisabled : ''}`}
              onClick={() => {
                if (!userSignedIn) return;
                const size = parseInt(volumes[selectedVolume].size);
                if (collectedVolumes.includes(size)) return;
                setBaseQuantity(size);
                setShowCollectionModal(true);
              }}
              disabled={collectedVolumes.includes(parseInt(volumes[selectedVolume].size))}
            >
              {collectedVolumes.includes(parseInt(volumes[selectedVolume].size)) 
                ? '✓ Dans votre collection' 
                : '➕ Ajouter à ma collection'}
            </button>
          </div>

          <div className={styles.marketplaceCard}>
            <div className={styles.marketHeader}>
              <h4 className={styles.marketTitle}>🏪 Marketplace</h4>
              <span className={styles.offersBadge}>Bientôt disponible</span>
            </div>
            <p className={styles.marketPlaceholder}>
              Les offres de la communauté arrivent bientôt !
            </p>
          </div>
        </div>

        {/* Histoire */}
        <div className={styles.descriptionCard}>
          <h3 className={styles.sectionTitle}>
            <span>📖</span> L'Histoire
          </h3>
          <p className={styles.descriptionText}>
            {perfume.description || 'Description à venir...'}
          </p>
        </div>
      </div>

      {/* Modal Collection */}
      {showCollectionModal && (
        <CollectionModal
          perfumeId={perfume.id}
          volumes={volumes}
          collectedVolumes={collectedVolumes}
          initialBaseQuantity={baseQuantity}
          onClose={() => setShowCollectionModal(false)}
          onSuccess={(newBaseQuantity) => {
            setCollectedVolumes([...collectedVolumes, newBaseQuantity]);
            setShowCollectionModal(false);
          }}
        />
      )}

      {/* Modal Price Alert */}
      {showPriceAlertModal && (
        <PriceAlertModal
          perfumeId={perfume.id}
          priceAlert={priceAlert}
          volumes={volumes}
          onClose={() => setShowPriceAlertModal(false)}
          onSuccess={(newPriceAlert) => {
            setPriceAlert(newPriceAlert);
            setShowPriceAlertModal(false);
          }}
        />
      )}
    </div>
  );
}