import React from "react";

export default function Footer() {
  return (
    <footer className="bg-white border-t border-slate-200 py-8 px-6">
      <div className="max-w-7xl mx-auto flex justify-between items-center">
        <span className="font-bold text-lg text-slate-700">MySillage</span>
        <div className="flex space-x-6 text-slate-500 text-sm">
          <a href="#" className="hover:text-slate-800 transition">À propos</a>
          <a href="#" className="hover:text-slate-800 transition">CGU</a>
          <a href="#" className="hover:text-slate-800 transition">Contact</a>
        </div>
      </div>
    </footer>
  );
}
