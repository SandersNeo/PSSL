﻿////////////////////////////////////////////////////////////////////////////////
// Работа с коллекциями (клиент, сервер): Модуль содержит методы работы с универсальными коллекциями значений.

#Область ПрограммныйИнтерфейс

#Область РаботаСМассивами

// Функция ищет элемент в массиве. Если находит - возвращает его индекс, иначе -1.
// 
Функция ВернутьИндексВМассиве(МассивДанные, Элемент) Экспорт 
	
	Если МассивДанные = Неопределено Тогда
		Возврат -1;
	КонецЕсли;
	
	Для ИндексЭлемента = 0 По МассивДанные.ВГраница() Цикл
		
		Если  (МассивДанные[ИндексЭлемента] = Элемент) Тогда
			Возврат ИндексЭлемента;
		КонецЕсли;
	КонецЦикла;
	
	// Не нашли элемент
	Возврат -1;
	
КонецФункции // ВернутьИндексВМассиве()

// Функция определяет входит ли в массив переданное значение или нет.
// 
// Параметры:
//  ТекущийМассив  - Массив.
//  ЗначениеПоиска - Произвольный.
// 
// Возвращаемое значение:
//   Булево.
// 
Функция МассивСодержит(ТекущийМассив, ЗначениеПоиска)  Экспорт

	флМассивСодержит = ТекущийМассив.Найти(ЗначениеПоиска) <> Неопределено;
	
	Возврат флМассивСодержит;
	
КонецФункции // МассивСодержит()

// Процедура находит по значению элемент массива и удаляет его.
// 
// Параметры:
//  МассивЭлементов - Массив
//  Значение 		- Строка
// 
Процедура УдалитьЭлементМассиваПоЗначению(МассивЭлементов, Значение) Экспорт
	
	Индекс = МассивЭлементов.Найти(Значение);
	Если Индекс <> Неопределено Тогда
		МассивЭлементов.Удалить(Индекс);
	КонецЕсли;

КонецПроцедуры // УдалитьЭлементМассиваПоЗначению()

// Удаляет повторяющиеся элементы массива.
// 
// Параметры:
//  ИсходныйМассив 		- Массив.
//  УдалитьНеопределено - Булево (По умолчанию = Ложь).
// 
// Возвращаемое значение:
//  Массив.
// 
Функция УдалитьПовторяющиесяЭлементыМассива(ИсходныйМассив, УдалитьНеопределено = Ложь) Экспорт
	
	НовыйМассив = Новый Массив;
	
	Для Каждого ЭлементМассива Из ИсходныйМассив Цикл
		
		Если Не МассивСодержит(НовыйМассив, ЭлементМассива) 
			И Не (ЭлементМассива = Неопределено И УдалитьНеопределено) Тогда
			НовыйМассив.Добавить(ЭлементМассива);
		КонецЕсли;
	КонецЦикла;
	
	Возврат НовыйМассив;
	
КонецФункции // УдалитьПовторяющиесяЭлементыМассива()

// Процедура преобразовывает массив строк в массив чисел. 
// В случае невозможности преобразования элемента, элементу присваивается -1.
// 
// Параметры:
//  МассивСтрок - Массив
// 
Процедура ПреобразоватьМассивСтрокВЧисла(МассивСтрок) Экспорт
	
	Для й = 1 По МассивСтрок.Количество() Цикл
		
		Попытка
			МассивСтрок[й - 1] = Число(МассивСтрок[й - 1]);
		Исключение
			МассивСтрок[й - 1] = -1;
		КонецПопытки;
	КонецЦикла;
	
КонецПроцедуры // ПреобразоватьМассивСтрокВЧисла()

#КонецОбласти

#Область РаботаСДеревьями

// Функция выполняет поиск элемента дерева в коллекции.
// 
// Параметры:
//  Коллекция - ДанныеФормыКоллекцияЭлементовДерева. 
//  СтрОтбор  - Структура.
// 
// Возвращаемое значение:
//  ТекЭлемент - ДанныеФормыЭлементДерева.
// 
Функция НайтиЭлементДерева(Коллекция, СтрОтбор) Экспорт
	
	НайденныйЭлемент = Неопределено;
	
	Для Каждого Эл Из Коллекция Цикл
		
		флСовпадение = Истина;
		Для Каждого КиЗ Из СтрОтбор Цикл
			
			Если Не Эл[КиЗ.Ключ] = КиЗ.Значение Тогда
				
				флСовпадение = Ложь;
				Прервать;
			КонецЕсли;
		КонецЦикла; // СтрОтбор
		
		Если флСовпадение Тогда
			
			НайденныйЭлемент = Эл;
			Прервать;
		КонецЕсли;
	КонецЦикла;
	
	Возврат НайденныйЭлемент;
	
КонецФункции // НайтиЭлементДерева()

#КонецОбласти

#Область РаботаСоСписками

// Функция выполняет поиск элемента списка значени по представлению.
//
// Параметры:
//   Список           - СписокЗначений.
//   Представление    - Строка.
//   УчитыватьРегистр - Булево.
//
// Возвращаемое значение:
//  НайденныйЭлемент - ЭлементСпискаЗначений.
//
Функция НайтиЭлементСпискаПоПредставлению(Список, Представление, УчитыватьРегистр = Ложь) Экспорт
	
	НайденныйЭлемент = Неопределено;
	
	Для Каждого ЭС Из Список Цикл
	
		Если УчитыватьРегистр Тогда
			
			Если ЭС.Представление = Представление Тогда
				
				НайденныйЭлемент = ЭС;
				Прервать;
			КонецЕсли;
		Иначе
			
			Если ВРег(ЭС.Представление) = ВРег(Представление) Тогда
				
				НайденныйЭлемент = ЭС;
				Прервать;
			КонецЕсли;
		КонецЕсли;
	КонецЦикла;
	
	Возврат НайденныйЭлемент;
	
КонецФункции // НайтиЭлементСпискаПоПредставлению()

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#КонецОбласти