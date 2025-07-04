# 🎬 Movie App

A simple iOS application that displays movies from a remote source with offline support using Core Data.

---

## ✨ **Features**

- **Fetch all movies** from a remote API.
- **View movie details** including:
  - **Poster Image**
  - **Title**
  - **Rating**
  - **Release Date**
  - **Overview**
- **Mark movies as favorites** using Core Data.
- **Offline mode**: If there's no internet connection, movies are loaded from Core Data.

---

## 📱 **Screens**

### 🗂 All Movies Screen
- Displays a list of movies retrieved from the internet.
- Each item shows the movie **poster**, **name**, and **rating**.

### 📄 Movie Details Screen
- Shows full details when a movie is selected.
- Allows user to **add or remove** movie from favorites.

---

## 🛠️ **Technologies Used**

- **Swift**
- **UIKit**
- **Core Data** – for local persistence and offline access
- **Alamofire** – for API networking
- **Kingfisher** – to load and cache poster images
- **NWPathMonitor** – to detect internet connectivity
- **Cosmos** – to display Rating
  I used Package Manager to add Pods.

---

## 🔌 **Offline Support**

- On app launch:
  - If connected to the internet: Movies are fetched from the remote API and stored in Core Data.
  - If not connected: Data is loaded from Core Data.
- User favorites are always saved locally and persist across app restarts.

---

## 🖼️ **Movie Poster URL Handling**

Each movie contains a `poster_path`, which is combined with TMDb's base URL to display images:


Example:

```swift
let fullImageURL = "https://image.tmdb.org/t/p/w500\(posterPath)"
