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

////////////////////////////////////////////////////////////////////////////////
// Работа с диалогами (клиент): для клиентских методов работы с диалогами.

#Область ПрограммныйИнтерфейс

// Осуществляет выбор составного типа из списка в управляемой форме.
//
// Параметры:
//  ТекущаяФорма  - Форма
//  ЭлементВладелец - ЭлементУправления
//  Контейнер     - Объект,СтрокаТабличнойЧасти
//  ИмяРеквизита  - Строка
//  СписокВыбора  - Список с типами, которые выбираем
//  СтандартнаяОбработка - Булево
//
Процедура НачалоВыбораСоставного(ТекущаяФорма
								,ЭлементВладелец
								,Контейнер
								,ИмяРеквизита
								,СписокВыбора
								,СтандартнаяОбработка) Экспорт
	
	Если Контейнер = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	ЭлементВладелец.ВыбиратьТип = Ложь;
	
	ТекущееЗначение = Контейнер[ИмяРеквизита];
	Если ТекущееЗначение = Неопределено Тогда
		
		СтандартнаяОбработка = Ложь;
		ЭлементВладелец.ВыбиратьТип = Истина;
		
		ДополнительныеПараметры = Новый Структура;
		ДополнительныеПараметры.Вставить("Контейнер", Контейнер);
		ДополнительныеПараметры.Вставить("ИмяРеквизита", ИмяРеквизита);
		ДополнительныеПараметры.Вставить("ЭлементВладелец", ЭлементВладелец);
		ДополнительныеПараметры.Вставить("СтандартнаяОбработка", СтандартнаяОбработка);
		ТекущаяФорма.ПоказатьВыборИзСписка(
			Новый ОписаниеОповещения("НачалоВыбораСоставного_Завершение", ЭтотОбъект, ДополнительныеПараметры), СписокВыбора);
	КонецЕсли;
	
КонецПроцедуры

// Процедура - Начало выбора составного завершение
//
// Параметры:
//  Результат			 - Произвольный - Результат выбора данных
//  ПараметрыОповещения	 - Структура - Параметры передаваемые в оповещение
//
Процедура НачалоВыбораСоставного_Завершение(Результат, ПараметрыОповещения) Экспорт
	
	Если Результат = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти // ПрограммныйИнтерфейс

#Область СлужебныеПроцедурыИФункции

#КонецОбласти // СлужебныеПроцедурыИФункции
