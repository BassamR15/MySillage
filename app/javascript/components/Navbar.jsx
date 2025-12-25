import React, { useState, useEffect } from "react";

export default function Navbar({ searchQuery, setSearchQuery, userSignedIn, currentUser }) {
  const [profileOpen, setProfileOpen] = useState(false);

  useEffect(() => {
    const handleClick = () => setProfileOpen(false);
    if (profileOpen) {
      document.addEventListener('click', handleClick);
      return () => document.removeEventListener('click', handleClick);
    }
  }, [profileOpen]);

  return (
    <nav className="fixed top-0 w-full z-50 bg-white/95 backdrop-blur-sm border-b border-slate-200">
      <div className="max-w-[1600px] mx-auto px-6">
        <div className="flex items-center h-16 gap-2">
          <div className="flex items-center space-x-2 mr-4">
            <div className="w-9 h-9 bg-gradient-to-br from-slate-600 to-slate-800 rounded-lg flex items-center justify-center">
              <span className="text-slate-100 font-bold text-lg">M</span>
            </div>
            <span className="text-xl font-bold text-slate-700">MySillage</span>
          </div>

          <a href="/perfumers" className="flex items-center space-x-1.5 px-3 py-2 rounded-lg text-slate-500 hover:text-slate-800 hover:bg-slate-100 transition">
            <span>👃</span>
            <span className="font-medium text-sm">Nez</span>
          </a>
          <a href="/perfumes" className="flex items-center space-x-1.5 px-3 py-2 rounded-lg text-slate-500 hover:text-slate-800 hover:bg-slate-100 transition">
            <span>🧴</span>
            <span className="font-medium text-sm">Parfums</span>
          </a>
          <a href="/marketplace" className="flex items-center space-x-1.5 px-3 py-2 rounded-lg text-slate-500 hover:text-slate-800 hover:bg-slate-100 transition">
            <span>🛍️</span>
            <span className="font-medium text-sm">Marketplace</span>
          </a>
          <a href="#" className="flex items-center space-x-1.5 px-3 py-2 rounded-lg text-slate-500 hover:text-slate-800 hover:bg-slate-100 transition">
            <span>🧭</span>
            <span className="font-medium text-sm">Découvrir</span>
          </a>

          <div className="ml-auto">
            <div className="relative">
              <span className="absolute left-4 top-1/2 -translate-y-1/2 text-slate-400 text-lg">🔍</span>
              <input
                type="text"
                placeholder="Rechercher un parfum, une marque, une note..."
                className="w-96 bg-slate-100 border border-slate-200 rounded-xl px-5 py-3 pl-12 text-base focus:outline-none focus:border-slate-400 focus:bg-white transition placeholder-slate-400"
                value={searchQuery}
                onChange={(e) => setSearchQuery(e.target.value)}
              />
            </div>
          </div>

          <div className="relative">
            {userSignedIn ? (
              <>
                <button
                  onClick={(e) => { e.stopPropagation(); setProfileOpen(!profileOpen); }}
                  className="flex items-center space-x-2 px-3 py-2 rounded-lg hover:bg-slate-100 transition"
                >
                  <div className="w-8 h-8 bg-gradient-to-br from-slate-600 to-slate-800 rounded-full flex items-center justify-center text-white">
                    <span>👤</span>
                  </div>
                  <span className="font-medium text-slate-500 text-sm">{currentUser?.username || "Mon Profil"}</span>
                  <span className="text-slate-400 text-xs">{profileOpen ? '▲' : '▼'}</span>
                </button>

                {profileOpen && (
                  <div className="absolute right-0 top-full mt-2 w-56 bg-white border border-slate-200 rounded-xl shadow-xl overflow-hidden">
                    <div className="p-3 border-b border-slate-100">
                      <p className="font-medium text-slate-800">{currentUser?.username}</p>
                      <p className="text-xs text-slate-500">{currentUser?.email}</p>
                    </div>
                    <div className="py-2">
                      <a href="/collections" className="flex items-center space-x-3 px-4 py-2.5 text-slate-600 hover:bg-slate-100 hover:text-slate-800 transition">
                        <span>📚</span>
                        <span>Ma Collection </span>
                      </a>
                      <a href="/wishlists" className="flex items-center space-x-3 px-4 py-2.5 text-slate-600 hover:bg-slate-100 hover:text-slate-800 transition">
                        <span>💎</span>
                        <span>Wishlist</span>
                      </a>
                      <a href="/notifications" className="flex items-center space-x-3 px-4 py-2.5 text-slate-600 hover:bg-slate-100 hover:text-slate-800 transition">
                        <span>🔔</span>
                        <span>Notifications</span>
                      </a>
                    </div>
                    <div className="border-t border-slate-100 py-2">
                      <a href="/settings" className="flex items-center space-x-3 px-4 py-2.5 text-slate-600 hover:bg-slate-100 hover:text-slate-800 transition">
                        <span>⚙️</span>
                        <span>Paramètres</span>
                      </a>
                      <a href="/users/sign_out" data-turbo-method="delete" className="flex items-center space-x-3 px-4 py-2.5 text-slate-500 hover:bg-slate-100 hover:text-slate-800 transition">
                        <span>🚪</span>
                        <span>Déconnexion</span>
                      </a>
                    </div>
                  </div>
                )}
              </>
            ) : (
              <div className="flex items-center space-x-2">
                <a href="/users/sign_in" className="px-4 py-2 text-slate-600 hover:text-slate-800 font-medium transition">
                  Connexion
                </a>
                <a href="/users/sign_up" className="px-4 py-2 bg-slate-700 text-white rounded-lg font-medium hover:bg-slate-800 transition">
                  Inscription
                </a>
              </div>
            )}
          </div>
        </div>
      </div>
    </nav>
  );
}
