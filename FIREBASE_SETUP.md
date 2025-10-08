# Firebase Setup Instructions

## 1. Создание проекта Firebase

1. Перейдите на [Firebase Console](https://console.firebase.google.com/)
2. Нажмите "Создать проект"
3. Введите название проекта: `qadam1-app`
4. Включите Google Analytics (опционально)
5. Создайте проект

## 2. Настройка аутентификации

1. В Firebase Console перейдите в раздел "Authentication"
2. Нажмите "Get started"
3. Перейдите на вкладку "Sign-in method"
4. Включите "Phone" провайдер
5. Настройте тестовые номера телефонов для разработки

## 3. Настройка Firestore

1. В Firebase Console перейдите в раздел "Firestore Database"
2. Нажмите "Create database"
3. Выберите "Start in test mode" (для разработки)
4. Выберите регион (например, us-central1)

## 4. Настройка Android приложения

1. В Firebase Console нажмите "Add app" → Android
2. Введите package name: `com.example.qadam1`
3. Скачайте `google-services.json`
4. Замените файл `android/app/google-services.json` на скачанный

## 5. Настройка iOS приложения (если нужно)

1. В Firebase Console нажмите "Add app" → iOS
2. Введите bundle ID: `com.example.qadam1`
3. Скачайте `GoogleService-Info.plist`
4. Добавьте файл в `ios/Runner/GoogleService-Info.plist`

## 6. Настройка правил безопасности Firestore

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Users can read and write their own data
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
  }
}
```

## 7. Тестирование

1. Запустите приложение: `flutter run`
2. Введите номер телефона
3. Проверьте получение SMS
4. Введите код подтверждения
5. Проверьте создание пользователя в Firestore

## 8. Важные замечания

- Для продакшена обязательно настройте правила безопасности Firestore
- Настройте тестовые номера телефонов для разработки
- Включите reCAPTCHA для защиты от спама
- Настройте квоты для SMS в Firebase Console

## 9. Troubleshooting

- Убедитесь, что `google-services.json` находится в правильной папке
- Проверьте, что все зависимости установлены: `flutter pub get`
- Убедитесь, что номер телефона в правильном формате (+7XXXXXXXXXX)
- Проверьте логи в Firebase Console для отладки
