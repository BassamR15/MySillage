import React, { useState } from 'react';
import Modal, { modalStyles } from './ui/Modal';

export default function PriceAlertModal({ 
  perfumeId, 
  priceAlert, 
  volumes, 
  onClose, 
  onSuccess 
}) {
  const [alertMaxPrice, setAlertMaxPrice] = useState(priceAlert?.max_price_cents / 100 || 50);
  const [alertMinQuantity, setAlertMinQuantity] = useState(priceAlert?.min_quantity_ml || 50);

  const handleCreate = () => {
    fetch(`/perfumes/${perfumeId}/price_alert`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
      },
      body: JSON.stringify({
        price_alert: {
          max_price_cents: alertMaxPrice * 100,
          min_quantity_ml: alertMinQuantity
        }
      })
    })
      .then(res => res.json())
      .then(data => {
        if (data.success) {
          onSuccess(data.price_alert);
        }
      });
  };

  const handleDelete = () => {
    fetch(`/perfumes/${perfumeId}/price_alert`, {
      method: 'DELETE',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
      }
    })
      .then(res => res.json())
      .then(data => {
        if (data.success) {
          onSuccess(null);
        }
      });
  };

  return (
    <Modal title="🔔 Alerte Prix" onClose={onClose}>
      <div className={modalStyles.field}>
        <label className={modalStyles.label}>Prix maximum (€)</label>
        <input
          type="number"
          value={alertMaxPrice}
          onChange={(e) => setAlertMaxPrice(parseInt(e.target.value) || 0)}
          className={modalStyles.input}
        />
      </div>

      <div className={modalStyles.field}>
        <label className={modalStyles.label}>Quantité minimum (ml)</label>
        <select
          value={alertMinQuantity}
          onChange={(e) => setAlertMinQuantity(parseInt(e.target.value))}
          className={modalStyles.input}
        >
          {volumes.map(vol => (
            <option key={vol.size} value={parseInt(vol.size)}>
              {vol.size}
            </option>
          ))}
        </select>
      </div>

      <div className={modalStyles.buttons}>
        {priceAlert && (
          <button className={modalStyles.deleteBtn} onClick={handleDelete}>
            Supprimer
          </button>
        )}
        <button className={modalStyles.cancelBtn} onClick={onClose}>
          Annuler
        </button>
        <button className={modalStyles.confirmBtn} onClick={handleCreate}>
          {priceAlert ? 'Modifier' : 'Créer'}
        </button>
      </div>
    </Modal>
  );
}