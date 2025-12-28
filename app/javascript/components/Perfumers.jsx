import React, { useState, useEffect } from "react";

export default function Perfumers({ perfumers }) {
  const root = document.getElementById("react-perfumers");

  useEffect(() => {
    const interval = setInterval(() => setCurrentSlide((prev) => (prev + 1) % carouselSlides.length), 4000);
    return () => clearInterval(interval);
  }, []);

  return (
    <div>test</div>
  );
}
