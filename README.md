# PG Estate

A modern real estate platform built with Ruby on Rails, allowing users to list and browse properties with a beautiful, responsive interface.

## Features

- 🏠 Property Listings: Users can create, view, and manage property listings
- 🖼️ Image Upload: Multiple image upload support for properties using CarrierWave
- 👤 User Profiles: Detailed user profiles with avatars and contact information
- 🔍 Search & Filter: Advanced property search and filtering capabilities
- 📱 Responsive Design: Beautiful, mobile-first interface using Bootstrap 5
- 🔒 Authentication: Secure user authentication with Devise

## Tech Stack

- Ruby on Rails 7
- PostgreSQL
- Bootstrap 5
- CarrierWave for image uploads
- Devise for authentication
- Bootstrap Icons
- Stimulus.js for JavaScript interactions

## Setup

1. Clone the repository:
```bash
git clone https://github.com/yourusername/pg-estate.git
cd pg-estate
```

2. Install dependencies:
```bash
bundle install
```

3. Setup database:
```bash
rails db:create
rails db:migrate
```

4. Start the server:
```bash
rails server
```

5. Visit `http://localhost:3000` in your browser