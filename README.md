# 💙 Namer App (Flutter)

A beautiful, responsive Flutter application that generates random word pairs. Users can browse through infinite suggestions, "like" their favorites, and manage a saved list.

This project is based on the official [Write your first Flutter app](https://docs.flutter.dev/get-started/codelab) codelab, with enhanced functionality for deleting favorites.

## ✨ Features

* **Infinite Generation:** Instantly generate cool, random word pairs (e.g., "blue-sky", "wild-code") using the `english_words` package.
* **Favorites Management:** * **Like:** Save word pairs you love to a dedicated list.
    * **Unlike:** Remove them instantly if you change your mind.
    * **Delete:** A specific "Trash" icon in the favorites list allows for easy removal of items.
* **Responsive Design:**
    * Adapts to screen size using `LayoutBuilder`.
    * Switches between a bottom navigation bar (mobile) and a side navigation rail (desktop/web).
* **State Management:** Built using `Provider` (`ChangeNotifierProvider`) to efficiently manage app state across different screens.
* **Smooth Animations:** Includes animated transitions when switching words or resizing the window.

## 📸 Screenshots

| Generator Page | Favorites Page |
| :---: | :---: |
| <img width="1918" height="971" alt="image" src="https://github.com/user-attachments/assets/d9db300d-5316-4da1-9fa0-eb5a99a44659" />
 | <img width="1917" height="971" alt="image" src="https://github.com/user-attachments/assets/b4af873f-ec62-4e15-9767-8f2209dbf3e7" />
 |

## 🛠️ Prerequisites

Before you begin, ensure you have met the following requirements:

* **Flutter SDK:** [Install Flutter](https://docs.flutter.dev/get-started/install) for your operating system.
* **VS Code:** Recommended editor with the **Flutter** and **Dart** extensions installed.

## 🚀 Getting Started

To get a local copy up and running, follow these simple steps.

### 1. Clone the repository
```bash
git clone [https://github.com/your-username/namer-app.git](https://github.com/your-username/namer-app.git)
