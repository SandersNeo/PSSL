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
// Общего назначения (служебный): для серверных функций общего назначения, переадресация на методы БСП или их аналоги

#Область ПрограммныйИнтерфейс

#Область ПереадресацияМетодов

// См. __ОбщегоНазначенияСервер.ВыполнитьМетодКонфигурации.
Процедура ВыполнитьМетодКонфигурации(Знач ИмяМетода, Знач Параметры = Неопределено) Экспорт
	
	Модуль = ПолучитьМодуль();
	Модуль.ВыполнитьМетодКонфигурации(ИмяМетода, Параметры);
	
КонецПроцедуры

// См. __ОбщегоНазначенияСервер.ЗаписатьДанныеВБезопасноеХранилище.
Процедура ЗаписатьДанныеВБезопасноеХранилище(Владелец, Данные, Ключ = "Пароль") Экспорт
	
	Модуль = ПолучитьМодуль();
	Модуль.ЗаписатьДанныеВБезопасноеХранилище(Владелец, Данные, Ключ);
	
КонецПроцедуры

// См. __ОбщегоНазначенияСервер.ПрочитатьДанныеИзБезопасногоХранилища.
Функция ПрочитатьДанныеИзБезопасногоХранилища(Владелец, Ключи = "Пароль", ОбщиеДанные = Неопределено) Экспорт

	Модуль = ПолучитьМодуль();
	Возврат Модуль.ПрочитатьДанныеИзБезопасногоХранилища(Владелец, Ключи, ОбщиеДанные);
	
КонецФункции

// См. __ОбщегоНазначенияСервер.СообщитьПользователю.
Процедура СообщитьПользователю(Знач ТекстСообщенияПользователю, Знач КлючДанных = Неопределено, Знач Поле = "",
	Знач ПутьКДанным = "", Отказ = Ложь) Экспорт
	
	Модуль = ПолучитьМодуль();
	Модуль.СообщитьПользователю(ТекстСообщенияПользователю, КлючДанных, Поле, ПутьКДанным, Отказ);
	
КонецПроцедуры

// См. __ОбщегоНазначенияСервер.ХранилищеОбщихНастроекСохранить.
Процедура ХранилищеОбщихНастроекСохранить(КлючОбъекта, КлючНастроек, Настройки,
			ОписаниеНастроек = Неопределено,
			ИмяПользователя = Неопределено,
			ОбновитьПовторноИспользуемыеЗначения = Ложь) Экспорт
	
	Модуль = ПолучитьМодуль();
	Модуль.ХранилищеОбщихНастроекСохранить(КлючОбъекта, КлючНастроек, Настройки, ОписаниеНастроек,
		ИмяПользователя, ОбновитьПовторноИспользуемыеЗначения);
	
КонецПроцедуры

// См. __ОбщегоНазначенияСервер.ХранилищеОбщихНастроекЗагрузить.
Функция ХранилищеОбщихНастроекЗагрузить(КлючОбъекта, КлючНастроек, ЗначениеПоУмолчанию = Неопределено, 
			ОписаниеНастроек = Неопределено, ИмяПользователя = Неопределено) Экспорт
	
	Модуль = ПолучитьМодуль();
	Возврат Модуль.ХранилищеОбщихНастроекЗагрузить(КлючОбъекта, КлючНастроек, ЗначениеПоУмолчанию, 
		ОписаниеНастроек, ИмяПользователя);
	
КонецФункции

// См. __ОбщегоНазначенияСервер.ХранилищеОбщихНастроекУдалить.
Процедура ХранилищеОбщихНастроекУдалить(КлючОбъекта, КлючНастроек, ИмяПользователя = Неопределено) Экспорт
	
	Модуль = ПолучитьМодуль();
	Модуль.ХранилищеОбщихНастроекУдалить(КлючОбъекта, КлючНастроек, ИмяПользователя);
	
КонецПроцедуры

// См. __ОбщегоНазначенияСервер.ПриНачалеВыполненияРегламентногоЗадания.
Процедура ПриНачалеВыполненияРегламентногоЗадания(РегламентноеЗадание = Неопределено) Экспорт
	
	Модуль = ПолучитьМодуль();
	Модуль.ПриНачалеВыполненияРегламентногоЗадания(РегламентноеЗадание);
	
КонецПроцедуры

// См. __ОбщегоНазначенияСервер.ЗначенияРеквизитовОбъекта.
Функция ЗначенияРеквизитовОбъекта(Ссылка, Знач Реквизиты, ВыбратьРазрешенные = Ложь, Знач КодЯзыка = Неопределено) Экспорт
	
	Модуль = ПолучитьМодуль();
	Возврат Модуль.ЗначенияРеквизитовОбъекта(Ссылка, Реквизиты, ВыбратьРазрешенные, КодЯзыка);
	
КонецФункции

// См. __ОбщегоНазначенияСервер.ЗначениеРеквизитаОбъекта.
Функция ЗначениеРеквизитаОбъекта(Ссылка, ИмяРеквизита, ВыбратьРазрешенные = Ложь, Знач КодЯзыка = Неопределено) Экспорт
	
	Модуль = ПолучитьМодуль();
	Возврат Модуль.ЗначенияРеквизитовОбъекта(Ссылка, ИмяРеквизита, ВыбратьРазрешенные, КодЯзыка);
	
КонецФункции 

// См. __ОбщегоНазначенияСервер.ОписаниеТипаСтрока.
Функция ОписаниеТипаСтрока(ДлинаСтроки) Экспорт
	
	Модуль = ПолучитьМодуль();
	Возврат Модуль.ОписаниеТипаСтрока(ДлинаСтроки);
	
КонецФункции

// См. __ОбщегоНазначенияСервер.ОписаниеТипаЧисло.
Функция ОписаниеТипаЧисло(Разрядность, РазрядностьДробнойЧасти = 0, Знач ЗнакЧисла = Неопределено) Экспорт
	
	Модуль = ПолучитьМодуль();
	Возврат Модуль.ОписаниеТипаЧисло(Разрядность, РазрядностьДробнойЧасти, ЗнакЧисла);
	
КонецФункции

#Область СериализацияXML

// См. __ОбщегоНазначенияСервер.ЗначениеВСтрокуXML.
Функция ЗначениеВСтрокуXML(Значение) Экспорт
	
	Модуль = ПолучитьМодуль();
	Возврат Модуль.ЗначениеВСтрокуXML(Значение);
	
КонецФункции

// См. __ОбщегоНазначенияСервер.ЗначениеИзСтрокиXML.
Функция ЗначениеИзСтрокиXML(СтрокаXML) Экспорт
	
	Модуль = ПолучитьМодуль();
	Возврат Модуль.ЗначениеИзСтрокиXML(СтрокаXML);
	
КонецФункции

#КонецОбласти

#КонецОбласти

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

Функция ПолучитьМодуль()
	Возврат __ОбщегоНазначенияПовтИсп.ПереадресацияОбщегоМодуля("ОбщегоНазначения", "__ОбщегоНазначенияСервер");
КонецФункции

#КонецОбласти
