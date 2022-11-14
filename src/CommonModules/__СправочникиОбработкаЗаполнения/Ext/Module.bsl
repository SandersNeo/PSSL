﻿////////////////////////////////////////////////////////////////////////////////
// Справочники событие "Обработка заполнения" (вызов сервера): обработка событий при заполнении

#Область ПрограммныйИнтерфейс

// Возникает при вводе элемента справочника на основании, а также при выполнении метода Заполнить,
// а также при интерактивном вводе нового. 
//
// Параметры:
//  Источник			 - СправочникОбъект - Объект, обрабатываемый подпиской на события.
//  ДанныеЗаполнения	 - Произвольный - Значение, которое используется как основание для заполнения.
//  ТекстЗаполнения		 - Строка, Неопределено - Текст, используемый для заполнения справочника.
//  СтандартнаяОбработка - Булево - Признак выполнения стандартной (системной) обработки события.
//
Процедура СправочникиОбработкаЗаполнения(Источник, ДанныеЗаполнения, ТекстЗаполнения, СтандартнаяОбработка) Экспорт
	
	Если Источник.ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;
	
	ИмяМетода = __ОбщегоНазначенияПовтИсп.СправочникиОбработкаЗаполнения().Получить(ТипЗнч(Источник));
	Если ЗначениеЗаполнено(ИмяМетода) Тогда
		Попытка
			Выполнить(СтрШаблон("%1(Источник, ДанныеЗаполнения, ТекстЗаполнения, СтандартнаяОбработка)", ИмяМетода));
		Исключение
			ВызватьИсключение СтрШаблон("%1%2Имя метода: %3", ОписаниеОшибки(), Символы.ПС, ИмяМетода);
		КонецПопытки;
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти // ПрограммныйИнтерфейс

#Область СлужебныеПроцедурыИФункции

#КонецОбласти // СлужебныеПроцедурыИФункции