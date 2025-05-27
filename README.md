# 🛍️ Flutter E-Commerce App

A Flutter application showcasing an E-commerce platform with features like categories, product listings, product details, add-to-cart functionality, similar product views, and integrated search.

## 🚀 Getting Started

Follow the steps below to set up and run the project locally:

```bash
flutter clean
flutter pub get
flutter packages pub run build_runner build

```

## Features

- Dashboard (Categories, Products)
- Product Details
- Add to Cart
- Products with Search 
- Home Search 

This project architecture uses MVVM Architecture pattern with Provider

- data (Data layer logic)
- domain (Interact/Business Logic)
- presentation (UI/Views/State management)

## Folder Structure


```text
lib/
├── core/               # Core utilities and global helpers
│   ├── error_handling/ # Error models and handling logic
│   ├── retrofit/       # Network layer using Retrofit
│   ├── routes/         # App route configuration
│   ├── utils/          # Utility functions and constants
│   └── widgets/        # Reusable UI widgets
├── features/           # Feature modules
│   ├── data/           # Data layer (models, API, repositories)
│   ├── domain/         # Business logic and use cases
│   └── presentation/   # UI, views, and view models
└── main.dart           # App entry point
```

Please refer the below video to understand the app


## 📸 Swagger Api's

https://api.escuelajs.co/docs#/

## 📸 Demo Video

▶️ [Watch the Demo Video on Google Drive](https://drive.google.com/file/d/1waF2odeD0FqJf2Dlk_Pfh4sZqHRWxkmM/view?usp=drive_link)





