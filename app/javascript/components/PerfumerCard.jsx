import React from 'react';
import { Link } from '@inertiajs/react';
import styles from './PerfumerCard.module.scss';

export default function PerfumerCard({ perfumer}) {
	const initials = perfumer.name.split(' ').map(word => word[0].toUpperCase()).join('');

  return (
    <Link href={`/perfumers/${perfumer.id}`} className={styles.perfumerCard}>
			<div className={styles.avatar}>
				<span>{initials}</span>
			</div>
			<div className={styles.info}>
				<div className={styles.name}>
					<h3>{perfumer.name}</h3>
				</div>
				<div className={styles.brands}>
					<span>{perfumer.brands.join(' • ')}</span>
				</div>
				<div className={styles.stats}>
						<span>🧪 {perfumer.perfumes_count}</span>
						<span>★ {perfumer.rating || 'Bientôt disponible'}</span>
				</div>
			</div>
			<span className={styles.arrow}>→</span>
		</Link>
  )
}
