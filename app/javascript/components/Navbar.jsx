import React, { useState, useEffect, useRef } from "react";

export default function Navbar({ userSignedIn, currentUser }) {
  const [searchQuery, setSearchQuery] = useState("");
  const [profileOpen, setProfileOpen] = useState(false);
  const [searchOpen, setSearchOpen] = useState(false);
  const [results, setResults] = useState({ perfumes: [], brands: [], notes: [], perfumers: [] });
  const [loading, setLoading] = useState(false);
  const searchRef = useRef(null);

  // Fermer les dropdowns quand on clique ailleurs
  useEffect(() => {
    const handleClick = (e) => {
      setProfileOpen(false);
      if (searchRef.current && !searchRef.current.contains(e.target)) {
        setSearchOpen(false);
      }
    };
    document.addEventListener("click", handleClick);
    return () => document.removeEventListener("click", handleClick);
  }, []);

  // Appel API avec debounce
  useEffect(() => {
    if (searchQuery.length < 2) {
      setResults({ perfumes: [], brands: [], notes: [], perfumers: [] });
      setSearchOpen(false);
      return;
    }

    setLoading(true);

    const timer = setTimeout(() => {
      fetch(`/api/search?q=${encodeURIComponent(searchQuery)}`)
        .then((res) => res.json())
        .then((data) => {
          setResults(data);
          setSearchOpen(true);
          setLoading(false);
        })
        .catch(() => setLoading(false));
    }, 300);

    return () => clearTimeout(timer);
  }, [searchQuery]);

  const hasResults = results.perfumes?.length > 0 || results.brands?.length > 0 ||
                     results.notes?.length > 0 || results.perfumers?.length > 0;

  return (
    <>
      <nav className="fixed top-0 w-full z-50 bg-white/95 backdrop-blur-sm border-b border-slate-200">
        <div className="max-w-[1600px] mx-auto px-6">
          <div className="flex items-center h-16 gap-2">
            {/* Logo */}
            <a href="/" className="flex items-center space-x-2 mr-4">
              <div className="flex items-center space-x-1">
                <img
                  src="/mysillage-midnight-clean1.png"
                  alt="MySillage logo"
                  className="w-auto h-12 object-contain"
                />
              </div>
            </a>

            {/* Navigation */}
            <a href="/perfumers" className="flex items-center space-x-1.5 px-3 py-2 rounded-lg text-slate-500 hover:text-slate-800 hover:bg-slate-100 transition">
              <span>👃</span>
              <span className="font-medium text-sm">Nez</span>
            </a>
            <a href="/perfumes" className="flex items-center space-x-1.5 px-3 py-2 rounded-lg text-slate-500 hover:text-slate-800 hover:bg-slate-100 transition">
              <span>🧴</span>
              <span className="font-medium text-sm">Parfums</span>
            </a>
            <a href="/listings" className="flex items-center space-x-1.5 px-3 py-2 rounded-lg text-slate-500 hover:text-slate-800 hover:bg-slate-100 transition">
              <span>🛍️</span>
              <span className="font-medium text-sm">Marketplace</span>
            </a>
            <a href="/discover" className="flex items-center space-x-1.5 px-3 py-2 rounded-lg text-slate-500 hover:text-slate-800 hover:bg-slate-100 transition">
              <span>🧭</span>
              <span className="font-medium text-sm">Découvrir</span>
            </a>

            {/* Search */}
            <div className="ml-auto">
              <div className="relative">
                <span className="absolute left-4 top-1/2 -translate-y-1/2 text-slate-400 text-lg">🔍</span>
                <input
                  type="text"
                  placeholder="Rechercher un parfum, une marque, une note..."
                  className="w-96 bg-slate-100 border border-slate-200 rounded-xl px-5 py-2.5 pl-12 text-base focus:outline-none focus:border-slate-400 focus:bg-white transition placeholder-slate-400"
                  value={searchQuery}
                  onChange={(e) => setSearchQuery(e.target.value)}
                  onFocus={() => searchQuery.length >= 2 && setSearchOpen(true)}
                />
                {loading && <span className="absolute right-4 top-1/2 -translate-y-1/2 text-slate-400">⏳</span>}
                {!loading && searchQuery && (
                  <button
                    onClick={() => { setSearchQuery(""); setSearchOpen(false); }}
                    className="absolute right-4 top-1/2 -translate-y-1/2 text-slate-400 hover:text-slate-600"
                  >
                    ✕
                  </button>
                )}
              </div>
            </div>

            {/* Profile */}
            <div className="relative ml-2">
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
                      <div className="py-2">
                        <a href="/collections" className="flex items-center space-x-3 px-4 py-2.5 text-slate-600 hover:bg-slate-100 transition">
                          <span>📚</span>
                          <span>Ma Collection</span>
                        </a>
                        <a href="/wishlists" className="flex items-center space-x-3 px-4 py-2.5 text-slate-600 hover:bg-slate-100 transition">
                          <span>💎</span>
                          <span>Wishlist</span>
                        </a>
                        <a href="/notifications" className="flex items-center space-x-3 px-4 py-2.5 text-slate-600 hover:bg-slate-100 transition">
                          <span>🔔</span>
                          <span>Notifications</span>
                        </a>
                      </div>
                      <div className="border-t border-slate-100 py-2">
                        <a href="/settings" className="flex items-center space-x-3 px-4 py-2.5 text-slate-600 hover:bg-slate-100 transition">
                          <span>⚙️</span>
                          <span>Paramètres</span>
                        </a>
                        <a href="/users/sign_out" data-turbo-method="delete" className="flex items-center space-x-3 px-4 py-2.5 text-slate-500 hover:bg-slate-100 transition">
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

      {/* Search Dropdown - Pleine largeur */}
      {searchOpen && hasResults && (
        <div className="fixed top-16 left-0 right-0 z-40 px-6" ref={searchRef}>
          <div className="max-w-[1600px] mx-auto bg-white border border-slate-200 rounded-2xl shadow-xl overflow-hidden">
            <div className="grid grid-cols-3 divide-x divide-slate-100">

              {/* Parfums */}
              <div className="p-4">
                <h3 className="text-xs font-semibold text-slate-400 uppercase tracking-wider mb-3 flex items-center gap-2">
                  <span>🧴</span> Parfums
                </h3>
                <div className="space-y-1">
                  {results.perfumes?.length > 0 ? results.perfumes.map((item) => (
                    <a key={item.id} href={`/perfumes/${item.id}`} className="flex items-center gap-3 px-3 py-2 rounded-lg hover:bg-slate-100 transition">
                      <img src={item.placeholder_image} alt={item.name} className="w-10 h-10 object-cover rounded" />
                      <div>
                        <p className="font-medium text-slate-800">{item.name}</p>
                        <p className="text-sm text-slate-500">{item.brand}</p>
                      </div>
                    </a>
                  )) : <p className="text-sm text-slate-400 px-3">Aucun parfum</p>}
                </div>
              </div>

              {/* Marques */}
              <div className="p-4">
                <h3 className="text-xs font-semibold text-slate-400 uppercase tracking-wider mb-3 flex items-center gap-2">
                  <span>🏷️</span> Marques
                </h3>
                <div className="space-y-1">
                  {results.brands?.length > 0 ? results.brands.map((item) => (
                    <a key={item.id} href={`/brands/${item.id}`} className="flex items-center gap-3 px-3 py-2 rounded-lg hover:bg-slate-100 transition">
                      <img src={item.logo} alt={item.name} className="w-10 h-10 object-contain" />
                      <p className="font-medium text-slate-800 flex-1">{item.name}</p>
                      <span className="text-xs bg-slate-200 text-slate-600 px-2 py-0.5 rounded-full">{item.count}</span>
                    </a>
                  )) : <p className="text-sm text-slate-400 px-3">Aucune marque</p>}
                </div>
              </div>

              {/* Notes & Nez */}
              <div className="p-4">
                <h3 className="text-xs font-semibold text-slate-400 uppercase tracking-wider mb-3 flex items-center gap-2">
                  <span>🌿</span> Notes
                </h3>
                <div className="space-y-1 mb-4">
                  {results.notes?.length > 0 ? results.notes.map((item) => (
                    <a key={item.id} href={`/notes/${item.id}`} className="flex items-center gap-3 px-3 py-2 rounded-lg hover:bg-slate-100 transition">
                      <img src={item.image} alt={item.name} className="w-10 h-10 object-cover rounded" />
                      <div>
                        <p className="font-medium text-slate-800">{item.name}</p>
                        <p className="text-sm text-slate-500">{item.family}</p>
                      </div>
                    </a>
                  )) : <p className="text-sm text-slate-400 px-3">Aucune note</p>}
                </div>

                <h3 className="text-xs font-semibold text-slate-400 uppercase tracking-wider mb-3 flex items-center gap-2">
                  <span>👃</span> Nez
                </h3>
                <div className="space-y-1">
                  {results.perfumers?.length > 0 ? results.perfumers.map((item) => (
                    <a key={item.id} href={`/perfumers/${item.id}`} className="flex items-center gap-3 px-3 py-2 rounded-lg hover:bg-slate-100 transition">
                      <img src={item.photo} alt={item.name} className="w-10 h-10 object-cover rounded-full" />
                      <p className="font-medium text-slate-800 flex-1">{item.name}</p>
                      <span className="text-xs bg-slate-200 text-slate-600 px-2 py-0.5 rounded-full">{item.count}</span>
                    </a>
                  )) : <p className="text-sm text-slate-400 px-3">Aucun nez</p>}
                </div>
              </div>

            </div>

            {/* Footer */}
            <div className="border-t border-slate-100 p-3 bg-slate-50">
              <a href={`/search?q=${encodeURIComponent(searchQuery)}`} className="flex items-center justify-center space-x-2 py-2 text-slate-600 hover:text-slate-800 font-medium transition">
                <span>Voir tous les résultats pour "{searchQuery}"</span>
                <span>→</span>
              </a>
            </div>
          </div>
        </div>
      )}
    </>
  );
}
