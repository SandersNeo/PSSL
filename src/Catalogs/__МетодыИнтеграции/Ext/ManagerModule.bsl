﻿// Библиотека проектных подсистем для упрощения разработки архитектуры на 1С: Предприятие 8,
// включая доработку типовых конфигураций.
//
// Copyright First BIT company
//
//   Licensed under the Apache License, Version 2.0 (the "License");
//   you may not use this file except in compliance with the License.
//   You may obtain a copy of the License at
//
//       http://www.apache.org/licenses/LICENSE-2.0
//
//   Unless required by applicable law or agreed to in writing, software
//   distributed under the License is distributed on an "AS IS" BASIS,
//   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//   See the License for the specific language governing permissions and
//   limitations under the License.
//
// URL:    https://github.com/firstBitSportivnaya/PSSL/
//

#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

Процедура ЗаполнитьПредопределенныеСоответствия() Экспорт
	
	ТЗПредопределенныхЗначений = __ИнтеграцииПереопределяемый.ПредопределенныеЗначенияМетодыИнтеграции();
	
	ТЗПредопределенныхЗначенийКСозданию = __ПредопределенныеЗначения.ПредопределенныеЗначенияКСозданию(
		ТЗПредопределенныхЗначений,
		"Справочник.__МетодыИнтеграции");
	
	Для Каждого СтрокаТаблицы Из ТЗПредопределенныхЗначенийКСозданию Цикл
		
		__ПредопределенныеЗначения.СоздатьПредопределенноеЗначение(СтрокаТаблицы, Справочники.__МетодыИнтеграции);
		
	КонецЦикла;
	
КонецПроцедуры

//  Получает структуру параметров метода интеграции со значениями по умолчанию
//
// Параметры:
//   *МетодИнтеграции - СправочникСсылка.__МетодыИнтеграции - ссылка на метод, параметры которого получаем.
//   *ЗаполнятьПоУмолчанию - Булево - добавлять ли в возвращаемую структуру значения по умолчанию
//   	**Ложь - возвращает структуру вида ИмяПараметра<Строка>:ТипЗначения<ПеречислениеСсылка.__ТипыJSON>
//   	**Истина - возвращает структуру вида ИмяПараметра<Строка>:ЗначениеПоУмолчанию<Строка>
// Возвращаемое значение:
//   Структура
Функция ПолучитьСтруктуруПараметровREST(МетодИнтеграции, ЗаполнятьПоУмолчанию = Ложь) Экспорт

	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	__МетодыИнтеграцииПараметрыREST.Имя КАК Имя,
		|	__МетодыИнтеграцииПараметрыREST.Тип КАК Тип,
		|	__МетодыИнтеграцииПараметрыREST.ЗначениеПоУмолчанию КАК ЗначениеПоУмолчанию
		|ИЗ
		|	Справочник.__МетодыИнтеграции.ПараметрыREST КАК __МетодыИнтеграцииПараметрыREST
		|ГДЕ
		|	__МетодыИнтеграцииПараметрыREST.Ссылка = &МетодИнтеграции";
	
	Запрос.УстановитьПараметр("МетодИнтеграции", МетодИнтеграции);
	
	РезультатЗапроса = Запрос.Выполнить();
	
	Выборка = РезультатЗапроса.Выбрать();
	
	Результат = Новый Структура;
	
	Пока Выборка.Следующий() Цикл
		Имя = Выборка.Имя; 
		
		Если ЗаполнятьПоУмолчанию Тогда
			Результат.Вставить(Имя, ПривестиЗначениеПоУмолчаниюREST(Выборка.ЗначениеПоУмолчанию, Выборка.Тип));	
		Иначе	
			Результат.Вставить(Имя, Выборка.Тип);
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат Результат;
КонецФункции

//  Получает структуру параметров метода интеграции со значениями по умолчанию
//
// Параметры:
//   Значение - СправочникСсылка.__МетодыИнтеграции - ссылка на метод, параметры которого получаем.
//   ТипJSON - ПеречислениеСсылка.__ТипыJSON - добавлять ли в возвращаемую структуру значения по умолчанию
//
// Возвращаемое значение:
//   Строка - приведенное к JSON поле типа
Функция ПривестиЗначениеПоУмолчаниюREST(Значение, ТипJSON) Экспорт
	
	Если Не ЗначениеЗаполнено(Значение) Тогда
		Если ТипJSON = Перечисления.__ТипыJSON.Строка Тогда
			Возврат "";
		ИначеЕсли ТипJSON = Перечисления.__ТипыJSON.Число Тогда
			Возврат 0;
		Иначе
			Возврат "null";
		КонецЕсли;
	КонецЕсли;	
	
	Если ТипJSON = Перечисления.__ТипыJSON.Булево Тогда
		Возврат ?(Значение, "true", "false");
	ИначеЕсли ТипJSON = Перечисления.__ТипыJSON.Дата Тогда
		Возврат Формат(Значение, "ДФ=yyyy-MM-dd");
	ИначеЕсли ТипJSON = Перечисления.__ТипыJSON.Число Тогда
		Возврат Формат(Значение, "ЧГ=0");
	КонецЕсли;
	
КонецФункции

#КонецОбласти

#КонецЕсли