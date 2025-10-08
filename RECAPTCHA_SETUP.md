# 🔧 Настройка reCAPTCHA для Firebase веб-версии

## 🚨 Проблема
Flutter веб-версия требует специальной настройки reCAPTCHA для отправки SMS через Firebase.

## ✅ Решение

### 1. **Настройка в Firebase Console:**

1. Откройте [Firebase Console](https://console.firebase.google.com)
2. Выберите проект "qadam-1"
3. Перейдите в **Authentication > Sign-in method**
4. В разделе **Phone** нажмите **Web setup**
5. Добавьте домены:
   - `localhost` (для разработки)
   - `your-domain.com` (для продакшена)
6. Скопируйте **reCAPTCHA site key**: `6Lcd-uArAAAAACGdQLLdYcSgh_6AZT-D-wYNSOJ3`

### 2. **Настройка в коде:**

#### A. Обновите `web/index.html`:
```html
<!-- reCAPTCHA -->
<script src="https://www.google.com/recaptcha/api.js?render=6Lcd-uArAAAAACGdQLLdYcSgh_6AZT-D-wYNSOJ3" async defer></script>

<!-- reCAPTCHA container -->
<div id="recaptcha-container"></div>
```

#### B. Обновите `web/firebase-config.js`:
```javascript
// Initialize reCAPTCHA verifier
let recaptchaVerifier;
try {
  recaptchaVerifier = new RecaptchaVerifier(auth, 'recaptcha-container', {
    'size': 'invisible',
    'callback': (response) => {
      console.log('reCAPTCHA solved');
    },
    'expired-callback': () => {
      console.log('reCAPTCHA expired');
    }
  });
  
  // Render the reCAPTCHA widget
  recaptchaVerifier.render().then((widgetId) => {
    console.log('reCAPTCHA widget rendered with ID:', widgetId);
  });
} catch (error) {
  console.log('reCAPTCHA verifier error:', error);
}
```

### 3. **Альтернативное решение - использование мобильной версии:**

Для тестирования реальных SMS используйте мобильную версию:

```bash
# Android
flutter run -d android

# iOS
flutter run -d ios
```

### 4. **Текущий статус:**

- ✅ **Мобильная версия**: Работает с реальными SMS
- ⚠️ **Веб-версия**: В тестовом режиме (требует настройки reCAPTCHA)
- ✅ **Firebase**: Настроен правильно
- ✅ **reCAPTCHA ключ**: Получен

## 🎯 **Рекомендации:**

1. **Для разработки**: Используйте мобильную версию для тестирования SMS
2. **Для продакшена**: Настройте reCAPTCHA правильно для веб-версии
3. **Для тестирования**: Используйте тестовые номера в Firebase Console

## 📱 **Тестирование:**

### Мобильная версия:
1. Запустите: `flutter run -d android`
2. Введите реальный номер: `+77771234567`
3. Получите SMS на телефон
4. Введите код из SMS

### Веб-версия (тестовый режим):
1. Запустите: `flutter run -d chrome`
2. Введите любой номер
3. Получите тестовый verificationId
4. Введите любой 6-значный код
5. Получите сообщение о тестовом режиме
