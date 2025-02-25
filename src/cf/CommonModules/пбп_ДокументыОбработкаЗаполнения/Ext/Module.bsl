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

///////////////////////////////////////////////////////////////////////////////
// Документы событие "Обработка заполнения" (вызов сервера): обработка событий при заполнении

#Область ПрограммныйИнтерфейс

// Возникает при вводе документа на основании, а также при выполнении метода Заполнить,
// при вводе на основании, а также при интерактивном вводе нового.
//
// Параметры:
//  Источник			 - ДокументОбъект - Объект, обрабатываемый подпиской на события.
//  ДанныеЗаполнения	 - Произвольный - Значение, которое используется как основание для заполнения.
//  ТекстЗаполнения		 - Строка, Неопределено - Текст, используемый для заполнения документа.
//  СтандартнаяОбработка - Булево - Признак выполнения стандартной (системной) обработки события.
//
Процедура ДокументыОбработкаЗаполнения(Источник, ДанныеЗаполнения, ТекстЗаполнения, СтандартнаяОбработка) Экспорт
	
	Если Источник.ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	ИмяМетода = пбп_ОбщегоНазначенияПовтИсп.ДокументыОбработкаЗаполнения().Получить(ТипЗнч(Источник));
	
	Если ЗначениеЗаполнено(ИмяМетода) Тогда
		Попытка
			
			ПараметрыМетода = Новый Массив;
			ПараметрыМетода.Добавить(Источник);
			ПараметрыМетода.Добавить(ДанныеЗаполнения);
			ПараметрыМетода.Добавить(ТекстЗаполнения);
			ПараметрыМетода.Добавить(СтандартнаяОбработка);
			
			пбп_ОбщегоНазначенияСервер.ВыполнитьМетодКонфигурации(ИмяМетода, ПараметрыМетода);
			
		Исключение
			ВызватьИсключение СтрШаблон("%1%2Имя метода: %3", ОписаниеОшибки(), Символы.ПС, ИмяМетода);
		КонецПопытки;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти // ПрограммныйИнтерфейс

#Область СлужебныеПроцедурыИФункции

#КонецОбласти