﻿#Область ПрограммныйИнтерфейс

// Процедура создает запись справочника История интеграции с информацией о событии интеграции
//
// Параметры:
//	СтруктураЗаписиИстории - Структура - описание действия повлекшего ошибку
//	ЭтоЗагрузка - Булево - Истина если это Загрузка, Ложь если это Выгрузка
//
Процедура СоздатьСообщениеИсторииИнтеграции(СтруктураЗаписиИстории, ЭтоЗагрузка) Экспорт
	
	// ++ Обход ошибки отстутствия модуля БСП, не переносить
	Пользователи = Неопределено;
	// -- Обход ошибки отстутствия модуля БСП, не переносить
	
	УстановитьПривилегированныйРежим(Истина);
	
	ДополнительноОбработатьЗапросыИнтеграцииПередЗаписьюВИсторию(СтруктураЗаписиИстории);
	
	НовоеСообщение = Справочники.__ИсторияИнтеграции.СоздатьЭлемент();
	НовоеСообщение.ДатаИнтеграции = ТекущаяДатаСеанса();
	НовоеСообщение.ДатаИнтеграцииВМиллисекундах = ТекущаяУниверсальнаяДатаВМиллисекундах();
	НовоеСообщение.Код = Новый УникальныйИдентификатор();
	НовоеСообщение.Ошибка = ЗначениеЗаполнено(СтруктураЗаписиИстории.ОписаниеОшибки);
	НовоеСообщение.Пользователь = Пользователи.ТекущийПользователь();
	НовоеСообщение.ДлительностьОбмена = НовоеСообщение.ДатаИнтеграции - СтруктураЗаписиИстории.ДатаНачалаИнтеграции;
	НовоеСообщение.ДлительностьВызова = СтруктураЗаписиИстории.ДлительностьВызова;
	Если ЭтоЗагрузка Тогда
		Если НовоеСообщение.Ошибка Тогда
			НовоеСообщение.Статус = Перечисления.__СтатусыИнтеграции.ОшибкаЗагрузки;
		Иначе
			НовоеСообщение.Статус = Перечисления.__СтатусыИнтеграции.Загружено;
		КонецЕсли;
	Иначе
		Если НовоеСообщение.Ошибка Тогда
			НовоеСообщение.Статус = Перечисления.__СтатусыИнтеграции.ОшибкаВыгрузки;
		Иначе
			НовоеСообщение.Статус = Перечисления.__СтатусыИнтеграции.Выгружено;
		КонецЕсли;
	КонецЕсли;
	ЗаполнитьЗначенияСвойств(НовоеСообщение, СтруктураЗаписиИстории);
	Для Каждого Строка Из СтруктураЗаписиИстории.ОбъектыИнтеграции Цикл
		НоваяСтрока = НовоеСообщение.ОбъектыИнтеграции.Добавить();
		ЗаполнитьЗначенияСвойств(НоваяСтрока, Строка);
	КонецЦикла;
	
	НовоеСообщение.Записать();
	
КонецПроцедуры

// Функция возвращает структуру со всеми необходимыми значениями для заполнения записи истории интеграции
//
// Возвращаемое значение:
//	Строка
Функция ПолучитьСтруктуруЗаписиИстории() Экспорт
	
	СтруктураЗаписиИстории = Новый Структура;
	СтруктураЗаписиИстории.Вставить("МетодИнтеграции",			"");
	СтруктураЗаписиИстории.Вставить("ЗапросВходящий",			"");
	СтруктураЗаписиИстории.Вставить("ЗапросИсходящий",			"");
	СтруктураЗаписиИстории.Вставить("ИнтегрируемаяСистема",		Неопределено);
	СтруктураЗаписиИстории.Вставить("ОписаниеОшибки",			"");
	СтруктураЗаписиИстории.Вставить("ПротоколОбмена",			"");
	СтруктураЗаписиИстории.Вставить("ДатаНачалаИнтеграции",		ТекущаяДатаСеанса());
	СтруктураЗаписиИстории.Вставить("ДлительностьВызова",		0);
	СтруктураЗаписиИстории.Вставить("ФорматЗапросаИнтеграции",	Перечисления.__ФорматыЗапросовИнтеграции.XML);
	ОбъектыИнтеграции = Новый ТаблицаЗначений;
	ОбъектыИнтеграции.Колонки.Добавить("ОбъектИнтеграции");
	ОбъектыИнтеграции.Колонки.Добавить("СозданОбновлен");
	СтруктураЗаписиИстории.Вставить("ОбъектыИнтеграции", ОбъектыИнтеграции);
	
	Возврат СтруктураЗаписиИстории;
	
КонецФункции

// Функция форматирует XML запрос в строковом виде для удобного чтения
//
// Параметры:
//	XMLТекст - Строка - XML запрос в строковом виде
//	ИспользоватьОтступы - Булево - по-умолчанию Ложь
// Возвращаемое значение:
//	Строка
Функция ОтформатироватьXMLЧерезDOM(XMLТекст, ИспользоватьОтступы = Ложь) Экспорт
	
	ЧтениеXML = Новый ЧтениеXML;
	ЧтениеXML.УстановитьСтроку(XMLТекст);
	
	ПостроительDOM = Новый ПостроительDOM;
	ДокументDOM = ПостроительDOM.Прочитать(ЧтениеXML);
	
	ЗаписьXML = Новый ЗаписьXML;
	ЗаписьXML.УстановитьСтроку(Новый ПараметрыЗаписиXML(,, ИспользоватьОтступы, ИспользоватьОтступы));
	
	ЗаписьDOM = Новый ЗаписьDOM;
	ЗаписьDOM.Записать(ДокументDOM, ЗаписьXML);
	
	Возврат ЗаписьXML.Закрыть();
	
КонецФункции

// Функция возвращает структуру с настройками для интеграции
//
// Параметры:
//	НастройкаИнтеграции - СправочникСсылка.__НастройкиИнтеграции - Ссылка на элемент справочника Настройки интеграции
// Возвращаемое значение:
//	Структура
Функция ПолучитьСтруктуруНастроекИнтеграции(НастройкаИнтеграции) Экспорт
	
	// ++ Обход ошибки отстутствия модуля БСП, не переносить
	ОбщегоНазначения = Неопределено;
	// -- Обход ошибки отстутствия модуля БСП, не переносить
	
	УстановитьПривилегированныйРежим(Истина);
	
	СтруктураНастроек = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(НастройкаИнтеграции, "Сервер, Порт");
	ДанныеБезопасногоХранилища = ОбщегоНазначения.ПрочитатьДанныеИзБезопасногоХранилища(НастройкаИнтеграции);
	
	Для Каждого КлючИЗначение Из ДанныеБезопасногоХранилища Цикл
		СтруктураНастроек.Вставить(КлючИЗначение.Ключ, КлючИЗначение.Значение);
	КонецЦикла;
	
	УстановитьПривилегированныйРежим(Ложь);
	
	Возврат СтруктураНастроек;
	
КонецФункции

// Функция возвращает структуру с настройками для интеграции
//
// Параметры:
//	МетодИнтеграции - СправочникСсылка.__МетодыИнтеграции - Ссылка на элемент справочника Методы интеграции
// Возвращаемое значение:
//	Структура
Функция ПолучитьСтруктуруМетодаИНастроекИнтеграции(МетодИнтеграции) Экспорт
	
	// ++ Обход ошибки отстутствия модуля БСП, не переносить
	ОбщегоНазначения = Неопределено;
	ОбщегоНазначенияКлиентСервер = Неопределено;
	// -- Обход ошибки отстутствия модуля БСП, не переносить
	
	СтруктураМетодаИНастроек = ОбщегоНазначения.ЗначенияРеквизитовОбъекта(МетодИнтеграции, "НастройкаИнтеграции, Метод");
	СтруктураНастроек = ПолучитьСтруктуруНастроекИнтеграции(СтруктураМетодаИНастроек.НастройкаИнтеграции);
	ОбщегоНазначенияКлиентСервер.ДополнитьСтруктуру(СтруктураМетодаИНастроек, СтруктураНастроек);
	
	Возврат СтруктураМетодаИНастроек;
	
КонецФункции

#КонецОбласти // ПрограммныйИнтерфейс

#Область СлужебныеПроцедурыИФункции

// Процедура обрабатывает запросы в структуре записи истории
Процедура ДополнительноОбработатьЗапросыИнтеграцииПередЗаписьюВИсторию(СтруктураЗаписиИстории)
	
	Если НЕ ПустаяСтрока(СтруктураЗаписиИстории.ЗапросИсходящий) И СтрНайти(СтруктураЗаписиИстории.ЗапросИсходящий, "xml") <> 0 Тогда
		
		ОчиститьДлинныеАтрибутыСообщенияXML(СтруктураЗаписиИстории.ЗапросИсходящий);
		
	КонецЕсли;
	
	Если НЕ ПустаяСтрока(СтруктураЗаписиИстории.ЗапросВходящий) И СтрНайти(СтруктураЗаписиИстории.ЗапросВходящий, "xml") <> 0 Тогда
		
		ОчиститьДлинныеАтрибутыСообщенияXML(СтруктураЗаписиИстории.ЗапросВходящий);
		
	КонецЕсли;
	
КонецПроцедуры

// Процедура очищает XML строку от длинных записей (например base64 строк)
Процедура ОчиститьДлинныеАтрибутыСообщенияXML(XMLСтрока)
	
	ЧтениеXML = Новый ЧтениеXML;
	ЧтениеXML.УстановитьСтроку(XMLСтрока);
	
	ПостроительDOM = Новый ПостроительDOM;
	ДокументDOM = ПостроительDOM.Прочитать(ЧтениеXML);
	
	ТребуетсяПерезаписатьXML = Ложь;
	
	//Перебрать все узлы
	ИтераторДерева = Новый ОбходДереваDOM(ДокументDOM);
	Пока ИтераторДерева.СледующийУзел() <> Неопределено Цикл
		Если ТипЗнч(ИтераторДерева.ТекущийУзел) = Тип("ЭлементDOM") Тогда
			Если СтрДлина(ИтераторДерева.ТекущийУзел.ТекстовоеСодержимое) > 1000 Тогда
				ИтераторДерева.ТекущийУзел.ТекстовоеСодержимое = "X";
				ТребуетсяПерезаписатьXML = Истина;
			КонецЕсли;
		КонецЕсли;
	КонецЦикла;
	
	Если ТребуетсяПерезаписатьXML Тогда
		
		ЗаписьXML = Новый ЗаписьXML;
		ЗаписьXML.УстановитьСтроку(Новый ПараметрыЗаписиXML(, , Истина, Истина));
		
		ЗаписьDOM = Новый ЗаписьDOM;
		ЗаписьDOM.Записать(ДокументDOM, ЗаписьXML);
		
		XMLСтрока = ЗаписьXML.Закрыть();
		
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти // СлужебныеПроцедурыИФункции