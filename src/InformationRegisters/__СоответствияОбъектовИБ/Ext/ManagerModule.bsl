﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// Возвращает таблицу соответствий по отбору.
//
// Параметры:
//  ТипСоответствия - Перечисление.__ТипСоответствияОбъектовИБ - Тип соответствия.
//  Объект1 - ПроизвольныйТип - Объект1.
//  Объект2 - ПроизвольныйТип - Объект2.
//  Объект3 - ПроизвольныйТип - Объект3.
// 
// Возвращаемое значение:
//  - ТаблицаЗначений - Таблица соответствий по отбору.
// 
Функция ПолучитьСоответствиеОбъектовИБ(ТипСоответствия, Объект1 = Неопределено, Объект2 = Неопределено, Объект3 = Неопределено) Экспорт
	
	УстановитьПривилегированныйРежим(Истина);
	
	Запрос = Новый Запрос;
	
	ТекстЗапроса = "ВЫБРАТЬ
		|	__СоответствияОбъектовИБ.ТипСоответствия КАК ТипСоответствия,
		|	__СоответствияОбъектовИБ.Объект1 КАК Объект1,
		|	__СоответствияОбъектовИБ.Объект2 КАК Объект2,
		|	__СоответствияОбъектовИБ.Объект3 КАК Объект3
		|ИЗ
		|	РегистрСведений.__СоответствияОбъектовИБ КАК __СоответствияОбъектовИБ
		|ГДЕ
		|	__СоответствияОбъектовИБ.ТипСоответствия = &ТипСоответствия";
	
	Если ЗначениеЗаполнено(Объект1) Тогда
		
		ТекстЗапроса = СтрШаблон("%1%2И __СоответствияОбъектовИБ.Объект1 = &Объект1", ТекстЗапроса, Символы.ПС);
		Запрос.УстановитьПараметр("Объект1", Объект1);
		
	КонецЕсли;
	
	Если ЗначениеЗаполнено(Объект2) Тогда
		
		ТекстЗапроса = СтрШаблон("%1%2И __СоответствияОбъектовИБ.Объект2 = &Объект1", ТекстЗапроса, Символы.ПС);
		Запрос.УстановитьПараметр("Объект2", Объект2);
		
	КонецЕсли;
	
	Если ЗначениеЗаполнено(Объект3) Тогда
		
		ТекстЗапроса = СтрШаблон("%1%2И __СоответствияОбъектовИБ.Объект3 = &Объект1", ТекстЗапроса, Символы.ПС);
		Запрос.УстановитьПараметр("Объект3", Объект3);
		
	КонецЕсли;
	
	Запрос.Текст = ТекстЗапроса;
	Запрос.УстановитьПараметр("ТипСоответствия", ТипСоответствия);
	
	Результат = Запрос.Выполнить();
	
	Возврат Результат.Выгрузить();
	
КонецФункции

#КонецОбласти // ПрограммныйИнтерфейс

#КонецЕсли