import React, { useState, useEffect, useRef } from 'react';
import { Link, router } from '@inertiajs/react';
import PriceAlertModal from '../../components/PriceAlertModal';
import SearchBar from '../../components/PerfumeSearchBar';
import FiltersSidebar from '../../components/FiltersSidebar';
import PerfumeCard from '../../components/PerfumeCard2';
import Dropdown from '../../components/Dropdown';
import styles from './Index.module.scss';

export default function Index({ perfumes, totalCount, brands, families, userSignedIn, currentUser, currentOrder, currentSearch, currentFilters, sidebarOpen: initialSidebarOpen }) {
  const [searchQuery, setSearchQuery] = useState(currentSearch);
  const [selectedPerfume, setSelectedPerfume] = useState(null);
  const [filters, setFilters] = useState({
    brands: currentFilters?.brands || [],
    genders: currentFilters?.genders || [],
    families: currentFilters?.families || [],
    priceMin: '',
    priceMax: ''
  });
  const [order, setOrder] = useState(currentOrder);
  const [displayedPerfumes, setDisplayedPerfumes] = useState(perfumes || []);
  const [sidebarOpen, setSidebarOpen] = useState(initialSidebarOpen || false);
  
  const isFirstRender = useRef(true);

  useEffect(() => {
    if (isFirstRender.current) {
      isFirstRender.current = false;
      return;
    }

    const timer = setTimeout(() => {
      applyFilters();
    }, 300);

    return () => clearTimeout(timer);
  }, [filters]);

  const applyFilters = () => {
    router.get('/perfumes', {
      search: searchQuery,
      order: order,
      brands: filters.brands,
      genders: filters.genders,
      families: filters.families,
      sidebar: sidebarOpen
    }, { preserveState: false });
  };

  const handleSearch = () => {
    router.get('/perfumes', { 
      search: searchQuery, 
      order: order,
      brands: filters.brands,
      genders: filters.genders,
      families: filters.families
    });
  };

  const handleOrderChange = (newOrder) => {
    setOrder(newOrder);
    router.get('/perfumes', { 
      search: searchQuery, 
      order: newOrder,
      brands: filters.brands,
      genders: filters.genders,
      families: filters.families
    });
  };

  const loadMore = () => {
    const offset = displayedPerfumes.length;
    const params = new URLSearchParams({
      offset: offset,
      search: searchQuery,
      order: order
    });
    
    filters.brands.forEach(b => params.append('brands[]', b));
    filters.genders.forEach(g => params.append('genders[]', g));
    filters.families.forEach(f => params.append('families[]', f));
    
    fetch(`/perfumes.json?${params.toString()}`)
      .then(res => res.json())
      .then(data => {
        setDisplayedPerfumes([...displayedPerfumes, ...data.perfumes]);
      });
  };

  const sortOptions = [
    { value: 'popularity', label: 'Popularité' },
    { value: 'newest', label: 'Nouveautés' },
    { value: 'price_asc', label: 'Prix croissant' },
    { value: 'price_desc', label: 'Prix décroissant' },
    { value: 'rating', label: 'Meilleures notes' }
  ];

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

      <div className={`${styles.mainLayout} ${!sidebarOpen ? styles.noSidebar : ''}`}>
        {/* Sidebar Filtres */}
        {sidebarOpen && (
          <FiltersSidebar
            filters={filters}
            setFilters={setFilters}
            brands={brands}
            families={families}
            onClose={() => setSidebarOpen(false)}
          />
        )}

        {/* Contenu principal */}
        <main className={styles.content}>
          {/* Hero + Search */}
          <section className={styles.hero}>
            <h1 className={styles.heroTitle}>Répertoire des <em>Parfums</em></h1>
            <p className={styles.heroSubtitle}>Plus de {totalCount} parfums à découvrir</p>
            <SearchBar 
              query={searchQuery} 
              onChange={setSearchQuery}
              onSearch={handleSearch}
            />
          </section>

          {/* Barre de résultats */}
          <div className={styles.resultsBar}>
            <span className={styles.resultsCount}>
              {totalCount || 0} parfums trouvés
            </span>
            <div className={styles.resultsRight}>
              {!sidebarOpen && (
                <button 
                  className={styles.openFiltersBtn}
                  onClick={() => setSidebarOpen(true)}
                >
                  ☰ Filtres
                </button>
              )}
              <Dropdown
                value={order}
                options={sortOptions}
                placeholder="Trier"
                onChange={handleOrderChange}
              />
            </div>
          </div>

          {/* Grille de parfums */}
          <section className={styles.grid}>
            {displayedPerfumes.map(perfume => (
              <PerfumeCard
                key={perfume.id}
                perfume={perfume}
                userSignedIn={userSignedIn}
                onPriceAlertClick={setSelectedPerfume}
              />
            ))}
          </section>

          {/* Bouton Charger plus */}
          {displayedPerfumes.length < totalCount && (
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
          volumes={[{ size: '30ml' }, { size: '50ml' }, { size: '100ml' }]}
          onClose={() => setSelectedPerfume(null)}
          onSuccess={() => setSelectedPerfume(null)}
        />
      )}
    </div>
  );
}