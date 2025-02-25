# Руководство по написанию тестов YAxUnit

## Шаг 1: Клонирование репозитория

Для начала работы вам необходимо клонировать репозиторий с GitHub. Вы можете сделать это, выполнив следующую команду в Git:

```bash
git clone https://github.com/firstBitSportivnaya/PSSL.git
```

## Шаг 2: Загрузка конфигурации
После клонирования репозитория загрузите конфигурацию в информационную базу из каталога:
```bash
PSSL/src/cf/
```
## Шаг 3: Добавление расширения конфигурации
Далее необходимо добавить расширение конфигурации YAxUnit, используйте файлы из следующего каталога:
```bash
PSSL/src/cfe/YAXUnit
```
После добавления расширения в режиме 1С:Предприятие должна появиться панель управления YAxUnit, которая отображается в виде подсистемы.

## Шаг 4: Создание тестов
### Определение тестируемой функции
Допустим в вашей конфигурации есть общий модуль **пбп_ОбщегоНазначенияВспомогательныеФункции** в котором есть функция определения четности числа:

```1C
Функция ЧетноеЧисло(Число) Экспорт
    Возврат Число % 2 = 0;
КонецФункции
```
В данном примере рассмотрим написание тестов для этой функции.

### Составление тестового набора
Для начала необходимо составить тестовый набор для проверки функции, стараясь покрыть пограничные случаи:
| Число | Результат   |
|-------|-------------|
| 2     | Четное      |
| 1     | Нечетное    |
| 0     | Четное      |
| -1    | Нечетное    |
| -2    | Четное      |
| 100   | Четное      |
| 99    | Нечетное    |

### Создание модуля для тестов
Создайте новый модуль в расширении YAxUnit, который принято называть по названию объекта, в котором находится тестируемая функция. Для нашего случая это будет модуль **ОМ__ОбщегоНазначенияВспомогательныеФункции**.

### Написание теста
Теперь напишем сам тест, для этого внутри **ОМ__ОбщегоНазначенияВспомогательныеФункции** создаем процедуру **ИсполняемыеСценарии()**:
```1C
Процедура ИсполняемыеСценарии() Экспорт
    // Создание группы тестов
    ЮТТесты.ДобавитьТестовыйНабор("Проверка функции ЧетноеЧисло")
        // Добавление конкретного теста в группу
        .ДобавитьТест("ТестЧетноеЧисло")
            // Передача параметров в тест
            .СПараметрами(Новый Структура("Число, ОжидаемыйРезультат", 2, Истина))
            .СПараметрами(Новый Структура("Число, ОжидаемыйРезультат", 1, Ложь))
            .СПараметрами(Новый Структура("Число, ОжидаемыйРезультат", 0, Истина))
            .СПараметрами(Новый Структура("Число, ОжидаемыйРезультат", -1, Ложь))
            .СПараметрами(Новый Структура("Число, ОжидаемыйРезультат", -2, Истина))
            .СПараметрами(Новый Структура("Число, ОжидаемыйРезультат", 100, Истина))
            .СПараметрами(Новый Структура("Число, ОжидаемыйРезультат", 99, Ложь));
КонецПроцедуры
```
#### Структура процедуры ИсполняемыеСценарии()
Процедура обычно содержит вызовы методов для добавления тестов. Основной метод — **ДобавитьТестовыйНабор()**, который создает группу тестов. В каждую группу затем добавляются конкретные тесты с помощью метода **ДобавитьТест()**. Эти тесты могут иметь параметры, задаваемые через метод **СПараметрами()**.

#### Написание самого теста
Сам тест реализуется в отдельной процедуре, которая вызывается из **ИсполняемыеСценарии()** через **ДобавитьТест()**. В этой процедуре вы описываете логику тестирования.

Пример процедуры теста:
```1C
Процедура ТестЧетноеЧисло(Параметры) Экспорт
    // Вызов тестируемой функции
    Результат = пбп_ОбщегоНазначенияВспомогательныеФункции.ЧетноеЧисло(Параметры.Число);
    
    // Проверка результата
    ЮТест.ОжидаетЧто(Результат).Равно(Параметры.ОжидаемыйРезультат);
КонецПроцедуры
```
 Теперь при запуске конфигурации в режиме 1С:Предприятие, в подсистеме YAxUnit должен отобразиться наш тест.
 Запускаем тест и видим результат его работы.

Полную и исчерпывающую информацию по работе с расширением можно найти в документации [YAXUnit](https://bia-technologies.github.io/yaxunit/).
