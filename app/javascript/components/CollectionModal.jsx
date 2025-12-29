import React, { useState } from 'react';
import Modal, { modalStyles } from './ui/Modal';

export default function CollectionModal({ 
  perfumeId, 
  volumes, 
  collectedVolumes,
  initialBaseQuantity,
  onClose, 
  onSuccess 
}) {
  const [baseQuantity, setBaseQuantity] = useState(initialBaseQuantity);
  const [remainingQuantity, setRemainingQuantity] = useState(initialBaseQuantity);

  const handleCreate = () => {
    fetch(`/perfumes/${perfumeId}/collection`, {
      method: 'POST',
      headers: {
        'Content-Type': 'application/json',
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').content
      },
      body: JSON.stringify({
        collection: {
          base_quantity_ml: baseQuantity,
          quantity_ml: remainingQuantity
        }
      })
    })
      .then(res => res.json())
      .then(data => {
        if (data.success) {
          onSuccess(baseQuantity);
        }
      });
  };

  return (
    <Modal title="Ajouter à ma collection" onClose={onClose}>
      <div className={modalStyles.field}>
        <label className={modalStyles.label}>Quantité de base</label>
        <select
          value={baseQuantity}
          onChange={(e) => {
            const value = parseInt(e.target.value);
            setBaseQuantity(value);
            setRemainingQuantity(value);
          }}
          className={modalStyles.input}
        >
          {volumes
            .filter(vol => !collectedVolumes.includes(parseInt(vol.size)))
            .map(vol => (
              <option key={vol.size} value={parseInt(vol.size)}>
                {vol.size}
              </option>
            ))
          }
        </select>
      </div>

      <div className={modalStyles.field}>
        <label className={modalStyles.label}>Quantité restante (ml)</label>
        <input
          type="number"
          value={remainingQuantity}
          onChange={(e) => {
            const value = parseInt(e.target.value) || 0;
            if (value <= baseQuantity && value >= 0) {
              setRemainingQuantity(value);
            }
          }}
          min={0}
          max={baseQuantity}
          className={modalStyles.input}
        />
      </div>

      <div className={modalStyles.buttons}>
        <button className={modalStyles.cancelBtn} onClick={onClose}>
          Annuler
        </button>
        <button className={modalStyles.confirmBtn} onClick={handleCreate}>
          Ajouter
        </button>
      </div>
    </Modal>
  );
}