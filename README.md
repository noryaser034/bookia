# 📚 Bookia — Modern Flutter Bookstore App

![Flutter](https://img.shields.io/badge/Flutter-3.x-blue?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.x-blue?logo=dart)
![State Management](https://img.shields.io/badge/State%20Management-Cubit-purple)
![Architecture](https://img.shields.io/badge/Architecture-Feature%20Based-green)
![API](https://img.shields.io/badge/API-Dio-orange)
![Navigation](https://img.shields.io/badge/Navigation-GoRouter-red)
![Localization](https://img.shields.io/badge/Localization-Arabic%20%26%20English-darkgreen)

**Bookia** is a premium Bookstore application built with **Flutter**, featuring a sleek modern design, robust feature-based architecture, and full backend integration. This project demonstrates advanced Flutter concepts, including multi-language support (English & Arabic), real-time API communication, and efficient state management using Cubit.

---

## ✨ Key Features & Highlights

### 🌍 Global Localization & RTL
- Full **Arabic & English** support with correct **RTL (Right-to-Left)** and **LTR** text direction.
- On-the-fly language switching from the Home Screen with persistent locale saving.
- Complete UI translation for all major static strings and navigation labels.

### 🔐 Authentication Flow
- **Onboarding:** Professionally designed Splash and Welcome screens.
- **Login/Register:** Complete with validation, social auth buttons, and API integration.
- **Enhanced Security:** Forgot password, OTP verification, and secure password reset.

### 📚 Product Discovery & Details
- **Dynamic Content:** Home screen with auto-sliding banners and "Best Seller" collections fetched from APIs.
- **Search System:** Real-time search by book title with input debouncing for performance.
- **Rich Details:** Comprehensive book detail screen including descriptions, pricing, and actions.

### 🛒 Cart & Wishlist Management
- **Persistence:** Local caching of wishlist and cart IDs for instant UI feedback.
- **Dynamic Cart:** Real-time quantity updates, removal, and automatic total price calculation.
- **Wishlist Sync:** Seamlessly add or remove books from your favorites list.

### 📦 Order Tracking & History
- **Place Order:** Multi-step process including checkout verification and governorate selection.
- **Order Tracking:** Detailed order history with status checks and single-order retrieval by ID.
- **Detailed Summaries:** Breakdown of delivery addresses, ordered items, and payment summaries.

### 👤 Profile & Settings
- **Identity:** Edit personal info (Name, Phone, Address) and upload a profile picture.
- **Security:** In-app reset password functionality.
- **Session Management:** Secure token-based logout with cleared local cache.

---

## 📱 Screenshots Preview

### 🔹 Onboarding & Authentication
| Splash | Welcome | Login | Register |
|:---:|:---:|:---:|:---:|
| <img src="screen_shots/splash_screen.png" width="180"/> | <img src="screen_shots/welcome_screen.png" width="180"/> | <img src="screen_shots/Login_screen.png" width="180"/> | <img src="screen_shots/register_screen.png" width="180"/> |

| Forgot Password | OTP Verification | New Password | Success |
|:---:|:---:|:---:|:---:|
| <img src="screen_shots/forget_password_screen.png" width="180"/> | <img src="screen_shots/otp_verification_screen.png" width="180"/> | <img src="screen_shots/create_new_password_screen.png" width="180"/> | <img src="screen_shots/password_cahnged_screen.png" width="180"/> |

### 🔹 Home, Search & Details
| Home (English) | Search Results | Book Details |
|:---:|:---:|:---:|
| <img src="screen_shots/home_screen.png" width="220"/> | <img src="screen_shots/search_screen.png" width="220"/> | <img src="screen_shots/details_screen.png" width="220"/> |

### 🔹 Wishlist, Cart & Checkout
| Wishlist | Cart | Place Order | Order Success |
|:---:|:---:|:---:|:---:|
| <img src="screen_shots/wish_list_screen.png" width="180"/> | <img src="screen_shots/cart_screen.png" width="180"/> | <img src="screen_shots/place_order_screen.png" width="180"/> | <img src="screen_shots/Order_success_screen.png" width="180"/> |

### 🔹 Profile & Orders History
| Profile | Edit Profile | My Orders | Order Details |
|:---:|:---:|:---:|:---:|
| <img src="screen_shots/Profile_screen.png" width="180"/> | <img src="screen_shots/edit_profile_screen.png" width="180"/> | <img src="screen_shots/my_orders_screen.png" width="180"/> | <img src="screen_shots/order_details_screen.png" width="180"/> |

---

## 🛠 Tech Stack & Packages

- **Core:** [Flutter SDK](https://flutter.dev) (3.x), [GoRouter](https://pub.dev/packages/go_router) for deep-linkable routing.
- **State Management:** [Flutter Bloc / Cubit](https://pub.dev/packages/flutter_bloc) for predictable state flows.
- **Networking:** [Dio](https://pub.dev/packages/dio) for efficient HTTP requests and interceptors.
- **Local Storage:** [SharedPreferences](https://pub.dev/packages/shared_preferences) for token and locale persistence.
- **Localization:** [Flutter Localizations](https://api.flutter.dev/flutter/flutter_localizations/flutter_localizations-library.html) for RTL/LTR support.
- **UI Enhancements:**
  - [Flutter SVG](https://pub.dev/packages/flutter_svg) for high-quality icons.
  - [Shimmer](https://pub.dev/packages/shimmer) for skeleton loading.
  - [Carousel Slider](https://pub.dev/packages/carousel_slider) & [Smooth Page Indicator](https://pub.dev/packages/smooth_page_indicator).
  - [Cached Network Image](https://pub.dev/packages/cached_network_image) for optimized image loading.
  - [Pinput](https://pub.dev/packages/pinput) for smooth OTP inputs.

---

## 🏗 Project Architecture

The app follows a professionally structured **Feature-Based Architecture**, ensuring high maintainability and scalability.

```text
    lib/
    ├── app_root/
    │   └── app_root.dart           # App-level config (Routes, Themes, Locales)
    ├── core/
    │   ├── constants/              # Fonts, Images, Strings
    │   ├── cubits/                 # Global Cubits (AppCubit)
    │   ├── localization/           # Multi-language logic
    │   ├── services/               # API (Dio) and Local (SharedPref) services
    │   ├── styles/                 # Colors and Typography
    │   └── widgets/                # Common reusable components (MainButtons, Shimmers)
    ├── features/
    │   ├── auth/                   # Authentication screens and business logic
    │   ├── home/                   # Main Home and Search modules
    │   ├── orders/                 # History and Details of orders
    │   ├── cart/                   # Shopping Cart logic
    │   ├── wish_list/              # Managed favorites
    │   ├── profile_folder/         # User management components
    │   └── welcome/                # Onboarding flow
    └── main.dart                   # Entry point
```

---

## 🧠 State Management Patterns

The project utilizes **Cubits** for predictable state isolation per feature:

| Cubit | Responsibility |
|---|---|
| **AppCubit** | Global locale management and persistence. |
| **AuthCubit** | Login, Registration, OTP, and Password Reset flows. |
| **HomeCubit** | Banners and Best Seller catalogs fetch. |
| **CartCubit** | Item management, quantity updates, and Checkout request. |
| **WishListCubit** | Management of favorite items and local ID synchronization. |
| **SearchCubit** | Real-time product search and catalog loading. |
| **MyOrderCubit** | Fetching and filtering order history. |
| **EditProfileCubit** | Managing user profile updates and image selection. |

---

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (v3.x suggested)
- Android Studio / VS Code
- Stable Internet Connection for API calls

### Installation
1. **Clone the repo:**
   ```bash
   git clone https://github.com/[your-username]/bookia.git
   ```
2. **Install dependencies:**
   ```bash
   flutter pub get
   ```
3. **Run the app:**
   ```bash
   flutter run
   ```

---

## 👨‍💻 Developed By

**Mina Adly**  
*Flutter Developer & Professional Warehouse Manager*

Passionate about building modern, clean, and scalable mobile applications using Flutter. Focused on clean architecture, optimized state management, and high-quality user experiences.

### 📬 Contact & Collaboration
I'm interested in freelance opportunities and open for collaboration. Feel free to reach out!

- **GitHub:** https://github.com/KingNarmar
- **LinkedIn:** https://www.linkedin.com/in/mina-bushra-733993317/
- **Email:** adlymina99@gmail.com
- **Mobile:** +971581255496 - +201555212015

---

### ⭐ Show your support
If you find this project helpful for your learning, please give it a star! It helps more people discover this repository.