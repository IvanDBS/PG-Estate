// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import * as bootstrap from "bootstrap"

// Store initialized components
let dropdowns = []
let tooltips = []
let popovers = []

// Initialize Bootstrap components
const initializeBootstrapComponents = () => {
  // Cleanup existing components
  cleanup()

  // Initialize dropdowns
  document.querySelectorAll('[data-bs-toggle="dropdown"]').forEach(element => {
    dropdowns.push(new bootstrap.Dropdown(element, {
      autoClose: 'outside'
    }))
  })

  // Initialize tooltips
  document.querySelectorAll('[data-bs-toggle="tooltip"]').forEach(element => {
    tooltips.push(new bootstrap.Tooltip(element))
  })

  // Initialize popovers
  document.querySelectorAll('[data-bs-toggle="popover"]').forEach(element => {
    popovers.push(new bootstrap.Popover(element))
  })
}

// Cleanup function
const cleanup = () => {
  dropdowns.forEach(dropdown => dropdown.dispose())
  tooltips.forEach(tooltip => tooltip.dispose())
  popovers.forEach(popover => popover.dispose())
  dropdowns = []
  tooltips = []
  popovers = []
}

// Initialize on first load
document.addEventListener('DOMContentLoaded', initializeBootstrapComponents)

// Initialize after any Turbo navigation
document.addEventListener('turbo:load', initializeBootstrapComponents)
document.addEventListener('turbo:render', initializeBootstrapComponents)
document.addEventListener('turbo:frame-render', initializeBootstrapComponents)

// Cleanup before caching
document.addEventListener('turbo:before-cache', cleanup)
