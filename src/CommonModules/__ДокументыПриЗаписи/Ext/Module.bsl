﻿////////////////////////////////////////////////////////////////////////////////
// Документы событие "При записи" (вызов сервера): обработка событий при записи

#Область ПрограммныйИнтерфейс

// Возникает при записи объекта.
// Процедура-обработчик вызывается после записи объекта в базу данных, но до окончания транзакции записи.
//
// Параметры:
//  Источник - ДокументОбъект - Объект, обрабатываемый подпиской на события.
//  Отказ	 - Булево - Признак отказа от записи документа.
//
Процедура ДокументыПриЗаписи(Источник, Отказ) Экспорт
	
	Если Отказ Или Источник.ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	ИмяМетода = __ОбщегоНазначенияПовтИсп.ДокументыПриЗаписи().Получить(ТипЗнч(Источник));
	Если ЗначениеЗаполнено(ИмяМетода) Тогда
		Попытка
			Выполнить(СтрШаблон("%1(Источник, Отказ)", ИмяМетода));
		Исключение
			ВызватьИсключение СтрШаблон("%1%2Имя метода: %3", ОписаниеОшибки(), Символы.ПС, ИмяМетода);
		КонецПопытки;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти // ПрограммныйИнтерфейс

#Область СлужебныеПроцедурыИФункции

#КонецОбласти