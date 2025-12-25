# E-Commerce Flutter Application

A modern, feature-rich e-commerce mobile and web application built with Flutter, demonstrating best practices in UI/UX design, state management, and API integration.

## 📱 Features

- **User Authentication** - Login with email/password, auto-login with test credentials, skip-to-browse functionality
- **Home Screen** - Dynamic banners, circular category navigation, multiple product sections (Featured, Daily Best Selling, Recently Added, Popular, Trending)
- **Product Catalog** - Grid view with filters, sorting, discount badges, quantity selectors
- **Product Details** - High-quality images, pricing with discounts, descriptions, related products
- **Shopping Cart** - Add/remove items, quantity management, real-time price calculation, cart summary
- **State Management** - Provider pattern for efficient state handling
- **Responsive Design** - Optimized for mobile, tablet, desktop, and web platforms

## 🛠️ Technical Stack

### Flutter Version
- **Flutter:** 3.35.7 (Stable Channel)
- **Dart:** 3.9.2
- **DevTools:** 2.48.0

### Dependencies
```yaml
dependencies:
  flutter:
    sdk: flutter
  
  # State Management
  provider: ^6.1.1
  
  # HTTP Client
  http: ^1.2.2
  
  # Image Caching
  cached_network_image: ^3.3.1
  
  # Local Storage
  shared_preferences: ^2.2.2
  
  # UI Components
  carousel_slider: ^5.1.1
  flutter_svg: ^2.2.3
  
  # Fonts
  google_fonts: ^6.1.0
```

## 🚀 Getting Started

### Prerequisites
- Flutter SDK 3.35.7 or higher
- Dart SDK 3.9.2 or higher
- Android Studio / VS Code with Flutter extensions
- Chrome / Edge browser (for web deployment)
- Windows 10+ / macOS / Linux

### Installation Steps

1. **Clone the Repository**
   ```bash
   git clone <repository-url>
   cd ecommerce_app
   ```

2. **Install Dependencies**
   ```bash
   flutter pub get
   ```

3. **Verify Flutter Setup**
   ```bash
   flutter doctor
   ```

4. **Run the Application**

   **For Web (Recommended):**
   ```bash
   flutter run -d chrome
   # or
   flutter run -d edge
   ```

   **For Desktop (Windows):**
   ```bash
   flutter run -d windows
   ```

   **For Mobile:**
   ```bash
   # Android
   flutter run -d <device-id>
   
   # iOS (macOS only)
   flutter run -d <device-id>
   ```

5. **Build for Production**

   **Web:**
   ```bash
   flutter build web
   ```

   **Windows:**
   ```bash
   flutter build windows
   ```

   **Android:**
   ```bash
   flutter build apk --release
   ```

## 🏗️ Project Structure

```
lib/
├── main.dart                 # Application entry point
├── models/                   # Data models
│   ├── user_model.dart
│   ├── product_model.dart
│   ├── category_model.dart
│   ├── banner_model.dart
│   └── cart_item_model.dart
├── providers/                # State management (Provider)
│   ├── auth_provider.dart
│   ├── home_provider.dart
│   ├── product_provider.dart
│   └── cart_provider.dart
├── screens/                  # UI Screens
│   ├── login_screen.dart
│   ├── home_screen.dart
│   ├── product_list_screen.dart
│   ├── product_detail_screen.dart
│   └── cart_screen.dart
├── services/                 # API & Business Logic
│   └── api_service.dart
├── utils/                    # Utilities & Constants
│   ├── api_constants.dart
│   ├── colors.dart
│   ├── text_styles.dart
│   └── validators.dart
└── widgets/                  # Reusable Components
    ├── product_card.dart
    ├── category_card.dart
    ├── custom_button.dart
    ├── custom_text_field.dart
    ├── loading_widget.dart
    └── error_widget.dart
```

## 🎯 State Management

This application uses **Provider** for state management, following best practices:

### Providers Implemented:
1. **AuthProvider** - User authentication, session management
2. **HomeProvider** - Home screen data, banners, categories, featured products
3. **ProductProvider** - Product catalog, filtering, sorting
4. **CartProvider** - Shopping cart operations, in-memory storage

### Why Provider?
- ✅ Official Flutter recommendation
- ✅ Simple, lightweight, and performant
- ✅ Excellent for medium-sized applications
- ✅ Easy to test and maintain
- ✅ Built-in change notification system

## 🌐 API Integration

### Base URLs
- **API Base:** `https://sungod.demospro2023.in.net/api`
- **Image Base:** `https://sungod.demospro2023.in.net`

### Test Credentials
- **Email:** `mobile@alisonsgroup.com`
- **Password:** `12345678`

### API Endpoints Used
- `POST /login` - User authentication
- `POST /home/en` - Home screen data
- `POST /products/en` - Product listing
- `POST /product-details/en/{slug}` - Product details
- `POST /cart/add/en` - Add to cart

### HTTP Client
- Using `http: ^1.2.2` package instead of Dio for better cross-platform compatibility
- Proper error handling with try-catch blocks
- Timeout configuration (30 seconds)
- JSON parsing with type safety

## 🎨 UI/UX Design

### Design System
- **Colors:** Custom brown theme with orange accents
- **Typography:** Google Fonts for modern, clean text
- **Spacing:** Consistent 8px grid system
- **Icons:** Material Icons with custom SVG support
- **Images:** Network images with caching and placeholders

### Key UI Features
- Responsive layouts for all screen sizes
- Smooth animations and transitions
- Pull-to-refresh functionality
- Loading states with shimmer effects
- Error states with retry options
- Empty states with helpful messages

## 📋 Assumptions Made

1. **Authentication:**
   - Auto-login with test credentials when user skips login
   - Session maintained in memory (no persistence across app restarts)
   - Token-based authentication with id + token parameters

2. **API Response:**
   - All API responses follow the format: `{success: 1, data: {...}}`
   - User credentials are in `customerdata` object
   - Images are relative paths (prepended with image base URL)

3. **Cart Functionality:**
   - Cart data stored in-memory only (no backend sync)
   - No user-specific cart (local state only)
   - Cart cleared on app restart

4. **Product Management:**
   - Products cannot be edited or deleted from the app
   - Inventory/stock management handled by backend
   - Price formatting uses currency symbol from API response

5. **Platform Support:**
   - Primary target: Web and Mobile
   - Windows desktop supported with limitations
   - Image caching optimized for mobile networks

## ⚠️ Known Issues / Limitations

### Current Limitations

1. **Desktop Platform (Windows):**
   - Some SSL certificate validation issues
   - Network requests may require firewall configuration
   - Recommended to use Web platform for testing

2. **Cart Functionality:**
   - **No Persistence:** Cart data clears on app restart
   - **No Backend Sync:** Cart is local-only, not synced with server
   - **No Multi-device Support:** Cart

 doesn't sync across devices

3. **API Integration:**
   - **GET APIs Only:** Only consuming GET/POST endpoints as specified
   - **No Order Management:** Order creation not implemented
   - **No Payment Gateway:** Payment functionality not included
   - **No User Registration:** Only login with existing credentials

4. **Image Loading:**
   - Depends on network connectivity
   - Some images may not load if URL is invalid
   - Large images may take time on slow networks

5. **Search & Filters:**
   - Search functionality not fully implemented
   - Advanced filtering (price range, ratings) not available
   - Sort functionality UI present but backend integration pending

6. **User Profile:**
   - Profile screen not implemented
   - Password change not available
   - Address management not included

### Browser Compatibility
- ✅ **Fully Supported:** Chrome, Edge, Firefox (latest versions)
- ⚠️ **Limited Support:** Safari (some CSS animations may not work)
- ❌ **Not Supported:** Internet Explorer

### Performance Notes
- First load may be slower due to image downloads
- Subsequent loads faster with cached images
- Web platform may have 1-2 second initial load time

## 🧪 Testing

### Test Scenarios Covered
1. ✅ Login with valid credentials
2. ✅ Skip login and browse as guest
3. ✅ Navigate between screens
4. ✅ Add products to cart
5. ✅ Update cart quantities
6. ✅ Remove items from cart
7. ✅ View product details
8. ✅ Browse categories

### Manual Testing Steps
1. Run the app on Edge: `flutter run -d edge`
2. Test login with: `mobile@alisonsgroup.com` / `12345678`
3. Click "Skip" to browse without login
4. Navigate through categories and products
5. Add items to cart and verify count
6. Adjust quantities in cart
7. Verify total price calculation

## 🔧 Troubleshooting

### Common Issues

**Issue:** "Invalid Customer Id" error
- **Solution:** Auto-login is configured, just retry. Credentials are stored in `customerdata` object.

**Issue:** Network error on Windows
- **Solution:** Use web platform instead: `flutter run -d edge`

**Issue:** Images not loading
- **Solution:** Check internet connection, images come from external URLs

**Issue:** App crashes on startup
- **Solution:** Run `flutter clean && flutter pub get` and rebuild

## 📝 Code Quality

- ✅ Clean code with proper naming conventions
- ✅ Reusable widgets and components
- ✅ No hardcoded values (constants used)
- ✅ Comprehensive error handling
- ✅ Type-safe API parsing
- ✅ Const constructors for optimization
- ✅ No unused imports or code

## 🚀 Future Enhancements

- [ ] User registration and profile management
- [ ] Order history and tracking
- [ ] Payment gateway integration
- [ ] Product reviews and ratings
- [ ] Wishlist functionality
- [ ] Advanced search with filters
- [ ] Multi-language support
- [ ] Dark mode theme
- [ ] Cart persistence with backend sync
- [ ] Push notifications
- [ ] Social media sharing

## 📄 License

This project is developed as part of a Flutter assessment/demonstration.

## 👥 Contact

For any queries or issues:
- Repository: [Project Repository URL]
- Email: [Your Email]

---

**Built with ❤️ using Flutter**
