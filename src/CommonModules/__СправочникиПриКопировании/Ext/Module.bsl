﻿////////////////////////////////////////////////////////////////////////////////
// Справочники событие "При копировании" (вызов сервера): обработка событий при копировании

#Область ПрограммныйИнтерфейс

// Возникает при создании элемента справочника копированием.
//
// Параметры:
//  Источник			 - СправочникОбъект - Объект, обрабатываемый подпиской на события.
//  ОбъектКопирования	 - СправочникОбъект - Исходный элемент, который является источником копирования.
//
Процедура СправочникиПриКопировании(Источник, ОбъектКопирования) Экспорт
	
	Если Источник.ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	ИмяМетода = __ОбщегоНазначенияПовтИсп.СправочникиПриКопировании().Получить(ТипЗнч(Источник));
	Если ЗначениеЗаполнено(ИмяМетода) Тогда
		Попытка
			Выполнить(СтрШаблон("%1(Источник, ОбъектКопирования)", ИмяМетода));
		Исключение
			ВызватьИсключение СтрШаблон("%1%2Имя метода: %3", ОписаниеОшибки(), Символы.ПС, ИмяМетода);
		КонецПопытки;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти // ПрограммныйИнтерфейс

#Область СлужебныеПроцедурыИФункции

#КонецОбласти // СлужебныеПроцедурыИФункции