import React from "react";

export default function PerfumeCard({ perfume }) {
  const tags = perfume.notes?.slice(0, 2).map(n => n.name) || [];

  return (
    <a href={`/perfumes/${perfume.id}`} className="group bg-white rounded-2xl overflow-hidden border border-slate-200 hover:border-slate-400 hover:shadow-lg transition cursor-pointer">
      <div className="aspect-square bg-gradient-to-br from-slate-100 to-slate-50 flex items-center justify-center text-6xl relative">
        {perfume.image ? (
          <img src={perfume.image} alt={perfume.name} className="w-full h-full object-cover" />
        ) : (
          <span>🧴</span>
        )}
        {perfume.score && (
          <div className="absolute top-3 right-3 bg-slate-700 text-white text-xs px-2 py-1 rounded-full font-bold">
            {perfume.score}%
          </div>
        )}
      </div>
      <div className="p-5">
        <p className="text-slate-500 text-sm font-medium mb-1">{perfume.brand?.name}</p>
        <h3 className="font-bold text-lg mb-3 text-slate-800">{perfume.name}</h3>
        <div className="flex flex-wrap gap-2">
          {tags.map((tag) => (
            <span key={tag} className="px-2 py-1 bg-slate-100 rounded-full text-xs text-slate-600">
              {tag}
            </span>
          ))}
        </div>
      </div>
    </a>
  );
}
