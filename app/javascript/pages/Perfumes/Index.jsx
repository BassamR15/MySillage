import React, { useState } from 'react';
import { Link } from '@inertiajs/react';
import PriceAlertModal from '../../components/PriceAlertModal';
import SearchBar from '../../components/PerfumeSearchBar';
import FiltersSidebar from '../../components/FiltersSidebar';
import PerfumeCard from '../../components/PerfumeCard2';
import styles from './Index.module.scss';
import { router } from '@inertiajs/react';

export default function Index({ perfumes, brands, families, userSignedIn, currentUser }) {
  const [searchQuery, setSearchQuery] = useState('');
  const [selectedPerfume, setSelectedPerfume] = useState(null);
  const [filters, setFilters] = useState({
    brands: [],
    genders: [],
    families: [],
    priceMin: '',
    priceMax: ''
  });
  const handleSearch = () => {
    router.get('/perfumes', { search: searchQuery });
  };
  const [order, setOrder] = useState('popularity');
  const [visibleCount, setVisibleCount] = useState(12);

  // Charger plus de parfums
  const loadMore = () => {
    setVisibleCount(visibleCount + 12);
  };

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

      <div className={styles.mainLayout}>
        {/* Sidebar Filtres */}
        <FiltersSidebar
          filters={filters}
          setFilters={setFilters}
          brands={brands}
          families={families}
        />

        {/* Contenu principal */}
        <main className={styles.content}>
          {/* Hero + Search */}
          <section className={styles.hero}>
            <h1 className={styles.heroTitle}>Explorez notre Collection</h1>
            <p className={styles.heroSubtitle}>Plus de 10 000 parfums à découvrir</p>
            <SearchBar 
              query={searchQuery} 
              onChange={setSearchQuery}
              onSearch={handleSearch}
            />
          </section>

          {/* Barre de résultats */}
          <div className={styles.resultsBar}>
            <span className={styles.resultsCount}>
              {perfumes?.length || 0} parfums trouvés
            </span>
            <select
              className={styles.sortSelect}
              value={order}
              onChange={(e) => setOrder(e.target.value)}
            >
              <option value="popularity">Popularité</option>
              <option value="newest">Nouveautés</option>
              <option value="price_asc">Prix croissant</option>
              <option value="price_desc">Prix décroissant</option>
              <option value="rating">Meilleures notes</option>
            </select>
          </div>

          {/* Grille de parfums */}
          <section className={styles.grid}>
            {perfumes?.slice(0, visibleCount).map(perfume => (
              <PerfumeCard
                key={perfume.id}
                perfume={perfume}
                userSignedIn={userSignedIn}
                onPriceAlertClick={setSelectedPerfume}
              />
            ))}
          </section>

          {/* Bouton Charger plus */}
          {visibleCount < perfumes?.length && (
            <div className={styles.loadMore}>
              <button className={styles.loadMoreBtn} onClick={loadMore}>
                Charger plus de parfums
              </button>
            </div>
          )}
        </main>
      </div>

      {/* Modal Price Alert */}
      {selectedPerfume && (
        <PriceAlertModal
          perfumeId={selectedPerfume.id}
          priceAlert={null}
          onClose={() => setSelectedPerfume(null)}
          onSuccess={() => setSelectedPerfume(null)}
        />
      )}
    </div>
  );
}