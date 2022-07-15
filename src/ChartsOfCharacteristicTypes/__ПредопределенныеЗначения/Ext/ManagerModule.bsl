﻿#Если Сервер Или ТолстыйКлиентОбычноеПриложение Или ВнешнееСоединение Тогда

#Область ПрограммныйИнтерфейс

// Возвращает значение ПВХ по имени.
//
// Параметры:
//  Имя - Строка - Имя переменной ПВХ.
// 
// Возвращаемое значение:
//  ПроизвольныйТип - Значение переменной ПВХ.
// 
Функция ПолучитьЗначение(Имя) Экспорт
	
	// ++ Обход ошибки отстутствия модуля БСП, не переносить
	ОбщегоНазначения = Неопределено;
	ОбщегоНазначенияКлиентСервер = Неопределено;
	// -- Обход ошибки отстутствия модуля БСП, не переносить
	
	УстановитьПривилегированныйРежим(Истина);
	
	Значение = Неопределено;
	
	Если ПланыВидовХарактеристик.__ПредопределенныеЗначения[Имя].СписокЗначений Тогда
		Значение = ОбщегоНазначения.ВыгрузитьКолонку(
			ПланыВидовХарактеристик.__ПредопределенныеЗначения[Имя].ЗначенияЭлементов, "Значение", Истина);
	ИначеЕсли ПланыВидовХарактеристик.__ПредопределенныеЗначения[Имя].Пароль Тогда
		
		ДанныеХранилища = ОбщегоНазначения.ПрочитатьДанныеИзБезопасногоХранилища(
			Строка(ПланыВидовХарактеристик.__ПредопределенныеЗначения[Имя].УникальныйИдентификатор()));
		
		Если ТипЗнч(ДанныеХранилища) = Тип("Структура") Тогда
			Значение = ОбщегоНазначенияКлиентСервер.СвойствоСтруктуры(ДанныеХранилища, "bit_password", "");
		Иначе
			Значение = "";
		КонецЕсли;
	Иначе
		Значение = ПланыВидовХарактеристик.__ПредопределенныеЗначения[Имя].Значение;
	КонецЕсли;
	
	УстановитьПривилегированныйРежим(Ложь);
	
	Возврат Значение;
	
КонецФункции

#КонецОбласти // ПрограммныйИнтерфейс

#Область СлужебныеПроцедурыИФункции

#КонецОбласти // СлужебныеПроцедурыИФункции

#КонецЕсли