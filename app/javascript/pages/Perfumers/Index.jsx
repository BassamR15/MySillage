import React, { useState, useEffect } from 'react';
import { Link } from '@inertiajs/react';
import PerfumerCard from '../../components/PerfumerCard';
import styles from './Index.module.scss';

export default function Index({ perfumers, perfumersCount, perfumesCount, userSignedIn, currentUser, featuredPerfumer }) {
  const [windowScroll, setWindowScroll] = useState(0);
  useEffect(() => {
    const handleScroll = () => setWindowScroll(window.scrollY);
    window.addEventListener('scroll', handleScroll);
    
    return () => window.removeEventListener('scroll', handleScroll);
  }, []);

  const groupedPerfumers = perfumers.reduce((acc, perfumer) => {
    const letter = perfumer.name[0].toUpperCase();
    if (!acc[letter]) {
      acc[letter] = [];
    }
    acc[letter].push(perfumer);
    return acc;
  }, {});

  const availableLetters = Object.keys(groupedPerfumers).sort();

  const alphabet = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'.split('');

  const scrollToLetter = (letter) => {
    const element = document.getElementById(`letter-${letter}`);
    if (element) {
      element.scrollIntoView({ behavior: 'smooth', block: 'start' });
    }
  };

  const scrollToAlphabet = () => {
    const alphabetNav = document.getElementById('alphabet-nav')
    alphabetNav.scrollIntoView({behavior: 'smooth', block: 'start'})
  }

  return (
    <div className={styles.container}>
      {/* Header */}
      <header className={styles.header}>
        <Link href="/" className={styles.logo}>
          My<span className={styles.logoAccent}>Sillage</span>
        </Link>
        <nav className={styles.nav}>
          <Link href="/perfumes" className={styles.navLink}>Découvrir</Link>
          <Link href="/marketplace" className={styles.navLink}>Marketplace</Link>
          <Link href="/perfumers" className={`${styles.navLink} ${styles.active}`}>Parfumeurs</Link>
          <Link href="/brands" className={styles.navLink}>Maisons</Link>
        </nav>
        <div className={styles.headerRight}>
          {userSignedIn ? (
            <div className={styles.avatar}>
              {currentUser?.username?.[0]?.toUpperCase() || 'U'}
            </div>
          ) : (
            <Link href="/login" className={styles.loginBtn}>Connexion</Link>
          )}
        </div>
      </header>

      <main className={styles.mainContainer}>
        {/* Hero */}
        <div className={styles.hero}>
          <h1 className={styles.heroTitle}>Répertoire des <em>Parfumeurs</em></h1>
          <p className={styles.heroSubtitle}>{perfumersCount} maîtres parfumeurs référencés</p>
        </div>

        {/* Stats */}
        <section className={styles.statsSection}>
          <div className={styles.statCard}>
            <div className={styles.statNumber}>{perfumersCount}</div>
            <div className={styles.statLabel}>Parfumeurs</div>
          </div>
          <div className={styles.statCard}>
            <div className={styles.statNumber}>{perfumesCount}</div>
            <div className={styles.statLabel}>Créations</div>
          </div>
          <div className={styles.statCard}>
            <div className={styles.statNumber}>{perfumesCount}</div>
            <div className={styles.statLabel}>Créations</div>
          </div>
          <div className={styles.statCard}>
            <div className={styles.statNumber}>{perfumesCount}</div>
            <div className={styles.statLabel}>Créations</div>
          </div>
        </section>

        {/* Featured Perfumer */}
        {featuredPerfumer && (
          <section className={styles.featuredSection}>
            <div className={styles.featuredImage}>
              <div className={styles.featuredInitials}>
                {featuredPerfumer.name.split(' ').map(word => word[0]).join('')}
              </div>
            </div>
            <div className={styles.featuredContent}>
              <p className={styles.featuredLabel}>✨ Parfumeur du mois</p>
              <h2 className={styles.featuredName}>{featuredPerfumer.name}</h2>
              <p className={styles.featuredBrands}>{featuredPerfumer.brands?.join(' • ')}</p>
              <p className={styles.featuredBio}>{featuredPerfumer.bio}</p>
              <div className={styles.featuredStats}>
                <div className={styles.featuredStat}>
                  <span className={styles.featuredStatValue}>{featuredPerfumer.perfumes_count}</span>
                  <span className={styles.featuredStatLabel}>créations</span>
                </div>
                <div className={styles.featuredStat}>
                  <span className={styles.featuredStatValue}>{featuredPerfumer.rating || 'N/A'}</span>
                  <span className={styles.featuredStatLabel}>note moyenne</span>
                </div>
              </div>
              <Link href={`/perfumers/${featuredPerfumer.id}`} className={styles.featuredBtn}>
                Découvrir son univers →
              </Link>
            </div>
          </section>
        )}

        {/* Alphabet Navigation */}
        <nav id='alphabet-nav' className={styles.alphabetNav}>
          {alphabet.map(letter => (
            <button
              key={letter}
              className={`${styles.letterLink} ${availableLetters.includes(letter) ? '' : styles.disabled}`}
              onClick={() => scrollToLetter(letter)}
              disabled={!availableLetters.includes(letter)}
            >
              {letter}
            </button>
          ))}
        </nav>

        {/* Perfumers List by Letter */}
        <section className={styles.perfumersList}>
          {availableLetters.map(letter => (
            <div key={letter} id={`letter-${letter}`} className={styles.letterSection}>
              <div className={styles.letterHeader}>
                <span className={styles.letterBig}>{letter}</span>
                <div className={styles.letterLine}></div>
                <span className={styles.letterCount}>{groupedPerfumers[letter].length} parfumeurs</span>
              </div>
              <div className={styles.letterPerfumers}>
                {groupedPerfumers[letter].map(perfumer => (
                  <PerfumerCard key={perfumer.id} perfumer={perfumer} />
                ))}
              </div>
            </div>
          ))}
        </section>

        {windowScroll > 300 && (
          <button 
            className={styles.backToTop}
            onClick={scrollToAlphabet}
          >
            ↑
          </button>
        )}
      </main>
    </div>
  );
}