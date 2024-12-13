![Flutter](https://img.shields.io/badge/Flutter-v3.x-blue?logo=flutter&style=flat)
![Dart](https://img.shields.io/badge/Dart-v3.x-blue?logo=dart&style=flat)
![License](https://img.shields.io/badge/license-MIT-green)


# ✨ Flutter Project Structure

This document outlines the folder structure and architecture for a Flutter project using the following technologies:

- 🌱 **Riverpod** for state management
- ⚙️ **GetIt** for dependency injection
- 🌐 **Dio** and **Retrofit** for API requests
- 📦 **Floor** for local database storage
- 📱 **Admob** for ad integration
- 🛒 **IAP** for in-app purchases

---

## 📂 Folder Structure

```plaintext
lib/
├── core/           # Core layer (shared utilities, constants, DI setup)
│   ├── di.dart     # Dependency injection setup (manages dependencies)
│   ├── utils/      # Utility classes and helper functions
│   ├── constants/  # Constants, configuration, shared values
├── data/           # Data layer (API, local storage, repositories)
│   ├── models/     # Data models (e.g., UserModel)
│   ├── sources/    # Data sources (Remote and Local)
│   ├── repositories/  # Repository implementations
├── domain/         # Domain layer (Entities, UseCases)
│   ├── entities/   # Core business models
│   ├── usecases/   # UseCase classes
├── presentation/   # Presentation layer (UI, ViewModels)
│   ├── viewmodels/ # State management with Riverpod
│   ├── screens/    # UI screens and widgets
├── optional/       # Flexing
│   ├── admob       # Admob package
│   ├── iap         # In-app purchase package
├── main.dart       # Entry point for the app
```

---

### 🌟 **1. core/**
The core layer contains shared utilities, constants, and dependency injection setup.

- **`di.dart`**: Manages dependency injection setup using **GetIt**.
- **`utils/`**: Utility classes and helper functions (e.g., date formatting, string utilities, etc.).
- **`constants/`**: Contains constants, configuration, and shared values (e.g., API endpoints, theme colors, etc.).

### 🌐 **2. data/**
The data layer is responsible for handling data from APIs, local storage, and repositories.

- **`models/`**: Contains data models (e.g., `UserModel`, `VideoModel`).
- **`sources/`**:
  - **`remote/`**: For handling API calls using **Dio** and **Retrofit**.
  - **`local/`**: For managing local database storage using **Floor**.
- **`repositories/`**: Implements the repository pattern to abstract data sources and provide data to the domain layer.

### 🧩 **3. domain/**
The domain layer contains business logic, entities, and use cases.

- **`entities/`**: Defines core business models (e.g., `User`, `Video`).
- **`usecases/`**: Contains use case classes that encapsulate specific business rules and logic.

### 🎨 **4. presentation/**
The presentation layer manages the UI and state management.

- **`viewmodels/`**: State management using **Riverpod** (e.g., `UserViewModel`, `VideoViewModel`).
- **`screens/`**:
  - Contains UI screens and widgets (e.g., `HomeScreen`, `SettingsScreen`).
  - Each screen can have subfolders for widgets and styles if needed.

### 🛠️ **5. optional/**
This folder is for optional features like ads and in-app purchases.

- **`admob/`**: Implements Admob integration for showing ads.
- **`iap/`**: Handles in-app purchases using an IAP package.

### 🚀 **6. main.dart**
The entry point for the application. It initializes the app, sets up dependency injection, and runs the root widget.

---

## 🛠️ Technologies Used

### 🌱 **Riverpod**
Used for state management. ViewModels in the `viewmodels/` folder use Riverpod for managing application state.

### ⚙️ **GetIt**
Used for dependency injection. All dependencies are registered in `core/di.dart`.

### 🌐 **Dio and Retrofit**
- **Dio**: For HTTP requests.
- **Retrofit**: For generating API clients. API sources are implemented in `data/sources/remote/`.

### 📦 **Floor**
Used for local database storage. Local data sources are implemented in `data/sources/local/`.

### 📱 **Admob**
For showing ads. Implementation details are in `optional/admob/`.

### 🛒 **IAP**
For handling in-app purchases. Code is organized in `optional/iap/`.

---

## 🔄 Example Workflows

### 🌐 **API Call Workflow**
1. **Presentation Layer**:
   - A `ViewModel` in `presentation/viewmodels/` triggers the use case.
2. **Domain Layer**:
   - The use case in `domain/usecases/` processes the request.
3. **Data Layer**:
   - The repository in `data/repositories/` fetches data from the remote source (`data/sources/remote/`) or local source (`data/sources/local/`).
4. **Core Layer**:
   - Utility functions or constants in `core/` may be used.

### 🎛️ **State Management Example**
- **Riverpod** providers are defined for each ViewModel. For example:
  ```dart
  final users = ref.watch(userViewModelProvider.select((value) => value.valueOrNull?.users ?? []));
  ```

### ⚙️ **Dependency Injection Example**
- Register dependencies in `core/di.dart`:
  ```dart
  GetIt.I.registerLazySingleton<ApiClient>(() => ApiClient(Dio()));
  ```

