import React, { useState, useEffect } from "react";
import Navbar from "./Navbar";
import Footer from "./Footer";
import PerfumeCard from "./PerfumeCard";

export default function App({ recommended, latest, userSignedIn, currentUser }) {
  const [currentSlide, setCurrentSlide] = useState(0);
  const [searchQuery, setSearchQuery] = useState("");
  const root = document.getElementById("react-root");
  const totalPerfumes = root.dataset.totalPerfumes;

  const carouselSlides = [
    { id: 1, title: "Votre parfum idéal existe", subtitle: "Laissez notre IA le trouver pour vous", icon: "💫" },
    { id: 2, title: "Marketplace sécurisée", subtitle: "Des milliers d'offres vérifiées", icon: "🛡️" },
    { id: 3, title: "Créez votre collection", subtitle: "Organisez et partagez vos parfums", icon: "📚" },
  ];

  useEffect(() => {
    const interval = setInterval(() => setCurrentSlide((prev) => (prev + 1) % carouselSlides.length), 4000);
    return () => clearInterval(interval);
  }, []);

  return (
    <div className="min-h-screen bg-slate-50 text-slate-800">
      <Navbar
        searchQuery={searchQuery}
        setSearchQuery={setSearchQuery}
        userSignedIn={userSignedIn}
        currentUser={currentUser}
        />

      <div className="h-16"></div>

      <section className="py-8 px-6">
        <div className="max-w-7xl mx-auto">
          <div className="relative h-64 md:h-72 rounded-3xl overflow-hidden bg-gradient-to-br from-slate-700 to-slate-900">
            {carouselSlides.map((slide, index) => (
              <div
                key={slide.id}
                className={`absolute inset-0 transition-all duration-700 ${
                  index === currentSlide
                    ? "opacity-100 translate-x-0"
                    : index < currentSlide
                    ? "opacity-0 -translate-x-full"
                    : "opacity-0 translate-x-full"
                }`}
              >
                <div className="h-full flex items-center justify-between px-12">
                  <div>
                    <h2 className="text-3xl md:text-4xl font-bold mb-3 text-slate-50">{slide.title}</h2>
                    <p className="text-lg text-slate-300 mb-6">{slide.subtitle}</p>
                    <button className="bg-white text-slate-700 px-6 py-2.5 rounded-lg font-semibold hover:bg-slate-100 transition">
                      Découvrir
                    </button>
                  </div>
                  <span className="text-8xl hidden md:block">{slide.icon}</span>
                </div>
              </div>
            ))}
            <div className="absolute bottom-4 left-1/2 -translate-x-1/2 flex space-x-2">
              {carouselSlides.map((_, index) => (
                <button
                  key={index}
                  onClick={() => setCurrentSlide(index)}
                  className={`h-1.5 rounded-full transition-all ${
                    index === currentSlide ? "w-8 bg-white" : "w-1.5 bg-white/40"
                  }`}
                />
              ))}
            </div>
          </div>
        </div>
      </section>

      <section className="py-16 px-6 bg-slate-100">
        <div className="max-w-7xl mx-auto">
          <div className="flex justify-between items-end mb-10">
            <div>
              <span className="text-slate-600 font-medium">Pour vous</span>
              <h2 className="text-3xl font-bold mt-1 text-slate-800">Parfums conseillés</h2>
            </div>
            <button className="text-slate-600 hover:text-slate-800 font-medium flex items-center gap-2 transition">
              Voir plus <span>→</span>
            </button>
          </div>
          <div className="grid md:grid-cols-2 lg:grid-cols-4 gap-6">
            {recommended.map((perfume) => (
              <PerfumeCard key={perfume.id} perfume={perfume} />
            ))}
          </div>
        </div>
      </section>

      <section className="py-16 px-6">
        <div className="max-w-7xl mx-auto">
          <div className="flex justify-between items-end mb-10">
            <div>
              <span className="text-slate-600 font-medium">Nouveautés</span>
              <h2 className="text-3xl font-bold mt-1 text-slate-800">Dernières sorties</h2>
            </div>
          </div>
          <div className="grid md:grid-cols-3 gap-6">
            {latest.map((perfume) => (
              <a
                href={`/perfumes/${perfume.id}`}
                key={perfume.id}
                className="group bg-white rounded-2xl p-6 border border-slate-200 hover:border-slate-400 hover:shadow-lg transition cursor-pointer"
              >
                <div className="flex items-center justify-between mb-4">
                  <span className="bg-slate-200 text-slate-700 px-3 py-1 rounded-full text-sm font-medium">
                    {perfume.launch_year}
                  </span>
                  <span className="text-slate-400 text-sm">{perfume.gender}</span>
                </div>
                <p className="text-slate-500 font-medium mb-1">{perfume.brand?.name}</p>
                <h3 className="text-xl font-bold mb-4 text-slate-800">{perfume.name}</h3>
                <button className="text-sm text-slate-600 font-medium group-hover:text-slate-800 transition">
                  Découvrir →
                </button>
              </a>
            ))}
          </div>
        </div>
      </section>

      <section className="py-16 px-6">
        <div className="max-w-7xl mx-auto">
          <div className="grid lg:grid-cols-2 gap-12 items-center">
            <div>
              <h2 className="text-4xl font-bold mb-6 text-slate-800">
                La parfumerie<br />
                <span className="text-slate-500">réinventée</span>
              </h2>
              <p className="text-slate-500 text-lg mb-8 leading-relaxed">
                MySillage combine l'expertise de milliers de passionnés avec l'intelligence artificielle
                pour vous aider à découvrir les parfums qui vous correspondent vraiment.
              </p>
              <div className="space-y-4">
                <div className="flex items-start space-x-4">
                  <div className="w-10 h-10 bg-slate-200 rounded-lg flex items-center justify-center flex-shrink-0">
                    <span>🎯</span>
                  </div>
                  <div>
                    <h4 className="font-semibold mb-1 text-slate-800">Recommandations précises</h4>
                    <p className="text-slate-500 text-sm">Basées sur votre profil olfactif unique</p>
                  </div>
                </div>
                <div className="flex items-start space-x-4">
                  <div className="w-10 h-10 bg-slate-200 rounded-lg flex items-center justify-center flex-shrink-0">
                    <span>💬</span>
                  </div>
                  <div>
                    <h4 className="font-semibold mb-1 text-slate-800">Assistant IA conversationnel</h4>
                    <p className="text-slate-500 text-sm">Discutez naturellement pour affiner vos recherches</p>
                  </div>
                </div>
                <div className="flex items-start space-x-4">
                  <div className="w-10 h-10 bg-slate-200 rounded-lg flex items-center justify-center flex-shrink-0">
                    <span>🤝</span>
                  </div>
                  <div>
                    <h4 className="font-semibold mb-1 text-slate-800">Communauté de confiance</h4>
                    <p className="text-slate-500 text-sm">Échangez avec des passionnés vérifiés</p>
                  </div>
                </div>
              </div>
            </div>
            <div className="grid grid-cols-2 gap-4">
              <div className="bg-white rounded-2xl p-6 border border-slate-200 shadow-sm">
                <div className="text-4xl font-bold text-slate-700 mb-2">{totalPerfumes}</div>
                <div className="text-slate-500">Parfums</div>
              </div>
              <div className="bg-white rounded-2xl p-6 border border-slate-200 shadow-sm">
                <div className="text-4xl font-bold text-slate-700 mb-2">45k+</div>
                <div className="text-slate-500">Membres</div>
              </div>
              <div className="bg-white rounded-2xl p-6 border border-slate-200 shadow-sm">
                <div className="text-4xl font-bold text-slate-700 mb-2">8k+</div>
                <div className="text-slate-500">Annonces</div>
              </div>
              <div className="bg-white rounded-2xl p-6 border border-slate-200 shadow-sm">
                <div className="text-4xl font-bold text-slate-700 mb-2">98%</div>
                <div className="text-slate-500">Satisfaction</div>
              </div>
            </div>
          </div>
        </div>
      </section>

      {userSignedIn === false ? (
      <section className="py-20 px-6">
        <div className="max-w-3xl mx-auto text-center">
          <div className="bg-gradient-to-br from-slate-700 to-slate-900 rounded-3xl p-12">
            <h2 className="text-3xl font-bold mb-4 text-slate-50">Prêt à découvrir votre parfum idéal ?</h2>
            <p className="text-slate-300 mb-8">
              Créez votre profil Nez en 2 minutes et recevez des recommandations personnalisées.
            </p>
            <button className="bg-white text-slate-700 px-8 py-4 rounded-xl font-semibold hover:bg-slate-100 transition">
              Commencer maintenant
            </button>
          </div>
        </div>
      </section>
      ) : (
        <div></div>
      )}
      <Footer />
    </div>
  );
}
