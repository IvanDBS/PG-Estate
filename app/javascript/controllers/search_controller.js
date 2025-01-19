import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["form", "expandedForm", "loading", "results"]
  static values = {
    url: String,
    debounce: Number
  }

  initialize() {
    this.cache = new Map()
    this.submit = this.debounce(this.submit.bind(this), this.debounceValue)
    this.expanded = false
  }

  // Debounce function to limit rate of function calls
  debounce(func, wait) {
    let timeout
    return function executedFunction(...args) {
      const later = () => {
        clearTimeout(timeout)
        func(...args)
      }
      clearTimeout(timeout)
      timeout = setTimeout(later, wait)
    }
  }

  // Toggle search form expansion
  toggleForm(event) {
    event.preventDefault()
    this.expanded = !this.expanded
    this.expandedFormTarget.classList.toggle('show', this.expanded)
  }

  // Handle form submission
  async submit(event) {
    if (event) event.preventDefault()
    
    const formData = new FormData(this.formTarget)
    const queryString = new URLSearchParams(formData).toString()
    
    // Check cache first
    if (this.cache.has(queryString)) {
      this.updateResults(this.cache.get(queryString))
      return
    }

    this.loadingTarget.classList.remove('d-none')
    
    try {
      const response = await fetch(`${this.urlValue}?${queryString}`, {
        headers: {
          'Accept': 'text/html',
          'X-Requested-With': 'XMLHttpRequest'
        }
      })
      
      if (!response.ok) throw new Error('Network response was not ok')
      
      const html = await response.text()
      this.cache.set(queryString, html)
      this.updateResults(html)
      
    } catch (error) {
      console.error('Search error:', error)
      this.resultsTarget.innerHTML = '<div class="alert alert-danger">An error occurred while searching. Please try again.</div>'
    } finally {
      this.loadingTarget.classList.add('d-none')
    }
  }

  // Update results container with new content
  updateResults(html) {
    this.resultsTarget.innerHTML = html
  }

  // Handle input changes
  inputChanged() {
    this.submit()
  }

  // Reset search form and clear cache
  reset(event) {
    event.preventDefault()
    this.formTarget.reset()
    this.cache.clear()
    this.submit()
  }

  // Clean up when controller is disconnected
  disconnect() {
    this.cache.clear()
  }
} 