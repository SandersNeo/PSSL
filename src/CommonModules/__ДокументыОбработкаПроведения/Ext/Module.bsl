﻿////////////////////////////////////////////////////////////////////////////////
// Документы событие "Обработка проведения" (вызов сервера): обработка событий при проведении

#Область ПрограммныйИнтерфейс

// Возникает при проведении документа.
// Основное назначение процедуры-обработчика данного события - генерация движений по документу. Выполняется в транзакции записи.
//
// Параметры:
//  Источник		 - ДокументОбъект - Объект, обрабатываемый подпиской на события.
//  Отказ			 - Булево - Признак проведения документа.
//  РежимПроведения	 - РежимПроведенияДокумента - Текущий режим проведения.
//
Процедура ДокументыОбработкаПроведения(Источник, Отказ, РежимПроведения) Экспорт
	
	Если Отказ Или Источник.ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	ИмяМетода = __ОбщегоНазначенияПовтИсп.ДокументыОбработкаПроведения().Получить(ТипЗнч(Источник));
	Если ЗначениеЗаполнено(ИмяМетода) Тогда
		Попытка
			Выполнить(СтрШаблон("%1(Источник, Отказ, РежимПроведения)", ИмяМетода));
		Исключение
			ВызватьИсключение СтрШаблон("%1%2Имя метода: %3", ОписаниеОшибки(), Символы.ПС, ИмяМетода);
		КонецПопытки;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти // ПрограммныйИнтерфейс

#Область СлужебныеПроцедурыИФункции

#КонецОбласти