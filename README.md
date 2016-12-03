# RYLocalizer
RYLocalizer - класс, который позволяет переключать язык приложения на лету. Локализация приложения происходит в коде.

# Usage
По умолчанию используется язык системы или язык, указанный в классе по умолчанию. 
## Локализация

```Swift
let stringValue = RYLocalizer.shared.local("What translate")
```
Если использовать String Extension: 
```Swift
let stringValue = "What translate".localized()
```

## Settings 
Установка языка по коду:

```Swift
RYLocalizer.shared.languageCode = "de"
```

Установка языка по названию:
```Swift
RYLocalizer.shared.setupLanguageByTitle("Deutsch»)
```
Список используемых языков:
```Swift
RYLocalizer.shared.languagesListTitle()
```

# Example
Пример показывает работу с классом RYLocalizer для 5ти языков: English, Czech, German, Russian, Ukrainian (default).

# Adding
Для класса RYLocalizer сделаны Unit Tests.
