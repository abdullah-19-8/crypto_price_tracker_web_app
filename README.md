# Crypto Price Tracker Web App

Crypto Price Tracker is a simple web application that allows users to track real-time cryptocurrency prices using WebSocket technology. Users can input the desired cryptocurrency symbol and view key market data such as current price, highest price, lowest price, volume, change percentage, and VWAP.

## Features
- Real-time cryptocurrency price tracking.
- User-friendly interface for searching and tracking different cryptocurrencies.
- WebSocket integration for live market data updates.
- Support for popular cryptocurrency symbols.

## Technologies Used

- Flutter: A UI toolkit for building natively compiled applications for mobile, web, and desktop from a single codebase.
- GoRouter: A declarative router for Flutter that simplifies navigation in your app.
- WebSocket: A communication protocol that provides full-duplex communication channels over a single TCP connection, commonly used for real-time applications.

## Getting Started

1. Clone the repository:

git clone https://github.com/abdullah-19-8/crypto_price_tracker_web_app.git

2. Install dependencies:

flutter pub get

3. Run the application:

flutter run -d chrome

## Usage

1. Enter the desired cryptocurrency symbol in the search bar.
2. Press the "Search" button or hit Enter to track the selected cryptocurrency.
3. View real-time market data for the selected cryptocurrency.



## Deploying

flutter clean
flutter pub get

flutter build web --base-href /crypto_tracking/ --release

cd build/web
git init
git add .
git commit -m "Deploy"
git remote add origin https://github.com/abdullah-19-8/crypto_tracking.git
git push -u --force origin main