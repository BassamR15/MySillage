// app/javascript/components/PerfumeCard.jsx
import React, { useState } from 'react';
import { Link } from '@inertiajs/react';
import styles from './PerfumeCard2.module.scss';

export default function PerfumeCard({ perfume, userSignedIn, onPriceAlertClick }) {
  const [isWishlisted, setIsWishlisted] = useState(perfume.wishlisted || false);

  const handleWishlistClick = (e) => {
    e.preventDefault();
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

  const handlePriceAlertClick = (e) => {
    e.preventDefault();
    if (!userSignedIn) return;
    onPriceAlertClick(perfume);
  };

  return (
    <Link href={`/perfumes/${perfume.id}`} className={styles.card}>
      <div className={styles.imageContainer}>
        {perfume.trending && (
          <span className={styles.badge}>🔥 Tendance</span>
        )}

        <button className={styles.wishlistBtn} onClick={handleWishlistClick}>
          {isWishlisted ? '❤️' : '🤍'}
        </button>
        

        <img
          src={perfume.placeholder_image}
          alt={perfume.name}
          className={styles.image}
        />
      </div>

      <div className={styles.content}>
        <p className={styles.brand}>{perfume.brand?.name}</p>
        <h3 className={styles.name}>{perfume.name}</h3>

        <div className={styles.notes}>
          {perfume.notes?.slice(0, 3).map((note, idx) => (
            <span key={idx} className={styles.note}>{note.name}</span>
          ))}
        </div>
        
        <div className={styles.footer}>
          <div className={styles.rating}>
            <span className={styles.stars}>★</span>
            <span className={styles.score}>{perfume.average_overall || 'N/A'}</span>
          </div>
          <button className={styles.priceAlertBtn} onClick={handlePriceAlertClick}>
            🔔
          </button>
        </div>
      </div>
    </Link>
  );
}