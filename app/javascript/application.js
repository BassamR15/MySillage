import React from "react"
import { createRoot } from "react-dom/client"
import App from "./components/App"

document.addEventListener("DOMContentLoaded", () => {
  const container = document.getElementById("react-root")
  if (container) {
    const root = createRoot(container)

    const recommended = JSON.parse(container.dataset.recommended || "[]")
    const latest = JSON.parse(container.dataset.latest || "[]")
    const userSignedIn = container.dataset.userSignedIn === "true"
    const currentUser = container.dataset.currentUser ? JSON.parse(container.dataset.currentUser) : null

    root.render(<App
      recommended={recommended}
      latest={latest}
      userSignedIn={userSignedIn}
      currentUser={currentUser}
    />)
  }
})
