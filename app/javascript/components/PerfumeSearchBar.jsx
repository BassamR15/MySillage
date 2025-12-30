import styles from './PerfumeSearchBar.module.scss';

export default function SearchBar({ query, onChange, onSearch }) {
  return (
    <div className={styles.searchBar}>
      <input
        type="text"
        className={styles.searchInput}
        placeholder="Rechercher un parfum, une marque, une note..."
        value={query}
        onChange={(e) => onChange(e.target.value)}
      />
      <button className={styles.searchBtn} onClick={onSearch}>
        <span>🔍</span>
        Rechercher
      </button>
    </div>
  );
}