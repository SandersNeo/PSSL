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

#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Параметры.Свойство("Режим", Режим);
	
	Если Параметры.Свойство("ЗначенияЗаполнения") Тогда
		АдресЗначений = ПоместитьВоВременноеХранилище(Параметры.ЗначенияЗаполнения, УникальныйИдентификатор);
	КонецЕсли;
	
	НадписьСинтаксис = НСтр("ru = '?(<ЛогическоеВыражение>,<ВыражениеЕслиИстина>,<ВыражениеЕслиЛожь>)';
		|en = '?(<BolleanExpression>,<ExpressionIfTrue>,<ExpressionIfFalse>)'");
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

&НаКлиенте
Процедура ЛогическоеВыражениеПриИзменении(Элемент)
	
	ОбновитьВыражениеРезультат();
	
КонецПроцедуры

&НаКлиенте
Процедура ЛогическоеВыражениеНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	ОткрытьФормуВыбораПоля("ЛогическоеВыражение");
	
КонецПроцедуры

&НаКлиенте
Процедура ВыражениеИстинаПриИзменении(Элемент)
	
	ОбновитьВыражениеРезультат();
	
КонецПроцедуры

&НаКлиенте
Процедура ВыражениеИстинаНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	ОткрытьФормуВыбораПоля("ВыражениеИстина");
	
КонецПроцедуры

&НаКлиенте
Процедура ВыражениеЛожьПриИзменении(Элемент)
	
	ОбновитьВыражениеРезультат();
	
КонецПроцедуры

&НаКлиенте
Процедура ВыражениеЛожьНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
	
	ОткрытьФормуВыбораПоля("ВыражениеЛожь");
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура КомандаОК(Команда)
	
	ОбновитьВыражениеРезультат();
	ОповеститьОВыборе(Новый Структура("Поле", ВыражениеРезультат));
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Выполняет обновление результирующего выражения.
//
&НаКлиенте
Процедура ОбновитьВыражениеРезультат()
	
	ВыражениеРезультат = СтрШаблон("?(%1, %2, %3)", ЛогическоеВыражение, ВыражениеИстина, ВыражениеЛожь);
	
КонецПроцедуры

// Открывает помошник для выбора поля.
//
&НаКлиенте
Процедура ОткрытьФормуВыбораПоля(ИмяПриемника)
	
	ПараметрыФормы = Новый Структура;
	
	ПараметрыФормы.Вставить("Режим", Режим);
	
	Если Не ПустаяСтрока(АдресЗначений) Тогда
		ПараметрыФормы.Вставить("АдресЗначений", АдресЗначений);
	КонецЕсли;
	ПараметрыФормы.Вставить("ИмяПриемника", ИмяПриемника);
	
	ОткрытьФорму("ОбщаяФорма.пбп_ФормаВыбораПоля", ПараметрыФормы, ЭтотОбъект);
	
 КонецПроцедуры

&НаКлиенте
Процедура ОбработкаВыбора(ВыбранноеЗначение, ИсточникВыбора)
	
	Если ИсточникВыбора.ИмяФормы = "ОбщаяФорма.пбп_ФормаВыбораПоля" Тогда
		Если ТипЗнч(ВыбранноеЗначение) = Тип("Структура") Тогда
			Элементы[ВыбранноеЗначение.ИмяПриемника].ВыделенныйТекст = ВыбранноеЗначение.Поле;
		КонецЕсли;
		ОбновитьВыражениеРезультат();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти
