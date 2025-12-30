import React, { useState } from 'react';
import styles from './FiltersSidebar.module.scss';

export default function FiltersSidebar({ filters, setFilters, brands, families, onClose }) {
  const [brandSearch, setBrandSearch] = useState('');
  const [openSections, setOpenSections] = useState({
    brands: true,
    genders: true,
    families: filters.families.length > 0
  });

  const filteredBrands = brands?.filter(brand => 
    brand.name.toLowerCase().includes(brandSearch.toLowerCase())
  ) || [];

  const toggleFilter = (filterName, value) => {
    const currentValues = filters[filterName];
    const newValues = currentValues.includes(value)
      ? currentValues.filter(v => v !== value)
      : [...currentValues, value];
    
    setFilters({ ...filters, [filterName]: newValues });
  };

  const toggleSection = (section) => {
    setOpenSections({ ...openSections, [section]: !openSections[section] });
  };

  const clearFilters = () => {
    setFilters({
      brands: [],
      genders: [],
      families: []
    });
  };

  const genderOptions = [
    { value: 'male', label: 'Homme' },
    { value: 'female', label: 'Femme' },
    { value: 'unisex', label: 'Unisexe' }
  ];

  return (
    <aside className={styles.sidebar}>
      <div className={styles.header}>
        <h2 className={styles.title}>Filtres</h2>
        <div className={styles.headerButtons}>
          <button onClick={clearFilters} className={styles.clearBtn}>
            Réinitialiser
          </button>
          <button onClick={onClose} className={styles.closeBtn}>
            ✕
          </button>
        </div>
      </div>

      {/* Filtre Marques */}
      <div className={styles.filterGroup}>
        <div className={styles.filterHeader} onClick={() => toggleSection('brands')}>
          <label className={styles.filterLabel}>Marques</label>
          <span className={`${styles.arrow} ${openSections.brands ? styles.arrowOpen : ''}`}></span>
        </div>
        {openSections.brands && (
          <>
            <input
              type="text"
              className={styles.brandSearchInput}
              placeholder="Rechercher une marque..."
              value={brandSearch}
              onChange={(e) => setBrandSearch(e.target.value)}
            />
            <div className={styles.filterOptions}>
              {filteredBrands.map(brand => (
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
          </>
        )}
      </div>

      {/* Filtre Genre */}
      <div className={styles.filterGroup}>
        <div className={styles.filterHeader} onClick={() => toggleSection('genders')}>
          <label className={styles.filterLabel}>Genre</label>
          <span className={`${styles.arrow} ${openSections.genders ? styles.arrowOpen : ''}`}></span>
        </div>
        {openSections.genders && (
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
        )}
      </div>

      {/* Filtre Familles Olfactives */}
      <div className={styles.filterGroup}>
        <div className={styles.filterHeader} onClick={() => toggleSection('families')}>
          <label className={styles.filterLabel}>Famille Olfactive</label>
          <span className={`${styles.arrow} ${openSections.families ? styles.arrowOpen : ''}`}></span>
        </div>
        {openSections.families && (
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
        )}
      </div>
    </aside>
  );
}