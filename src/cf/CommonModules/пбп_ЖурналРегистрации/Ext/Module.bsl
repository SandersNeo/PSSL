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

#Область ПрограммныйИнтерфейс

#КонецОбласти

#Область СлужебныйПрограммныйИнтерфейс

#Область МетодыАналогиБСП

// Аналог метода БСП. Записывает сообщение в журнал регистрации.
//
//  Параметры: 
//   ИмяСобытия       - Строка - имя события для журнала регистрации.
//   Уровень          - УровеньЖурналаРегистрации - уровни важности событий журнала регистрации.
//   ОбъектМетаданных - ОбъектМетаданных - объект метаданных, к которому относится событие.
//   Данные           - ЛюбаяСсылка
//                    - Число
//                    - Строка
//                    - Дата
//                    - Булево
//                    - Неопределено
//                    - Тип - данные, с которыми связано событие.
//                      Рекомендуется указывать ссылки на объекты данных (элементы справочников, документы, к которым
//                      относится событие).
//   Комментарий      - Строка - комментарий для события журнала.
//
Процедура ДобавитьСообщениеДляЖурналаРегистрации(Знач ИмяСобытия, Знач Уровень,
		Знач ОбъектМетаданных = Неопределено, Знач Данные = Неопределено, Знач Комментарий = "") Экспорт
		
	Если ПустаяСтрока(ИмяСобытия) Тогда
		ИмяСобытия = "Событие"; // не локализуется, чтобы не допускать остановки запуска в частично переведенной конфигурации
	КонецЕсли;

	ЗаписьЖурналаРегистрации(ИмяСобытия, Уровень, ОбъектМетаданных, Данные, Комментарий, РежимТранзакцииЗаписиЖурналаРегистрации.Независимая);
	
КонецПроцедуры

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

#КонецОбласти
