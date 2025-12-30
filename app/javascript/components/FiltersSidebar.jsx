import React from 'react';
import styles from './FiltersSidebar.module.scss';

export default function FiltersSidebar({ filters, setFilters, brands, families }) {
  
  // Toggle une valeur dans un tableau de filtres
  const toggleFilter = (filterName, value) => {
    const currentValues = filters[filterName];
    const newValues = currentValues.includes(value)
      ? currentValues.filter(v => v !== value)  // Enlève si déjà présent
      : [...currentValues, value];               // Ajoute sinon
    
    setFilters({ ...filters, [filterName]: newValues });
  };

  // Reset tous les filtres
  const clearFilters = () => {
    setFilters({
      brands: [],
      genders: [],
      families: [],
      priceMin: '',
      priceMax: ''
    });
  };

  // Options de genre (en dur car fixe)
  const genderOptions = [
    { value: 'male', label: 'Homme' },
    { value: 'female', label: 'Femme' },
    { value: 'unisex', label: 'Unisexe' }
  ];

  return (
    <aside className={styles.sidebar}>
      <div className={styles.header}>
        <h2 className={styles.title}>Filtres</h2>
        <button onClick={clearFilters} className={styles.clearBtn}>
          Réinitialiser
        </button>
      </div>

      {/* Filtre Marques */}
      <div className={styles.filterGroup}>
        <label className={styles.filterLabel}>Marques</label>
        <div className={styles.filterOptions}>
          {brands?.map(brand => (
            <div
              key={brand.id}
              className={styles.filterOption}
              onClick={() => toggleFilter('brands', brand.id)}
            >
              <div className={`${styles.checkbox} ${filters.brands.includes(brand.id) ? styles.checked : ''}`}>
                {filters.brands.includes(brand.id) && '✓'}
              </div>
              <span className={styles.filterText}>{brand.name}</span>
            </div>
          ))}
        </div>
      </div>

      {/* Filtre Genre */}
      <div className={styles.filterGroup}>
        <label className={styles.filterLabel}>Genre</label>
        <div className={styles.filterOptions}>
          {genderOptions.map(gender => (
            <div
              key={gender.value}
              className={styles.filterOption}
              onClick={() => toggleFilter('genders', gender.value)}
            >
              <div className={`${styles.checkbox} ${filters.genders.includes(gender.value) ? styles.checked : ''}`}>
                {filters.genders.includes(gender.value) && '✓'}
              </div>
              <span className={styles.filterText}>{gender.label}</span>
            </div>
          ))}
        </div>
      </div>

      {/* Filtre Familles Olfactives */}
      <div className={styles.filterGroup}>
        <label className={styles.filterLabel}>Famille Olfactive</label>
        <div className={styles.filterOptions}>
          {families?.map(family => (
            <div
              key={family}
              className={styles.filterOption}
              onClick={() => toggleFilter('families', family)}
            >
              <div className={`${styles.checkbox} ${filters.families.includes(family) ? styles.checked : ''}`}>
                {filters.families.includes(family) && '✓'}
              </div>
              <span className={styles.filterText}>{family}</span>
            </div>
          ))}
        </div>
      </div>

      {/* Filtre Prix */}
      <div className={styles.filterGroup}>
        <label className={styles.filterLabel}>Prix</label>
        <div className={styles.priceInputs}>
          <input
            type="number"
            className={styles.priceInput}
            placeholder="Min €"
            value={filters.priceMin}
            onChange={(e) => setFilters({ ...filters, priceMin: e.target.value })}
          />
          <span className={styles.priceSeparator}>—</span>
          <input
            type="number"
            className={styles.priceInput}
            placeholder="Max €"
            value={filters.priceMax}
            onChange={(e) => setFilters({ ...filters, priceMax: e.target.value })}
          />
        </div>
      </div>
    </aside>
  );
}