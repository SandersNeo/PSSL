﻿////////////////////////////////////////////////////////////////////////////////
// Общего назначения (сервер): для серверных функций общего назначения

#Область ПрограммныйИнтерфейс

// Возвращает имя информационной базы.
// 
// Возвращаемое значение:
//   - Строка - Имя информационной базы.
//
Функция ПолучитьИмяИнформационнойБазы() Экспорт
	
	СтрокаПодключения = СтрокаСоединенияИнформационнойБазы();
	
	НомерСимвола = СтрНайти(СтрокаПодключения, "File=");
	Если НомерСимвола > 0 Тогда
		
		// Это Файловая база.
		СтрокаСправа = Сред(СтрокаПодключения, НомерСимвола + 6);
		
		Возврат Сред(СтрокаСправа, 1, СтрДлина(СтрокаСправа) - 2);
	КонецЕсли;
	
	НомерСимвола = СтрНайти(СтрокаПодключения, "Ref=");
	Если НомерСимвола > 0 Тогда
		
		// Это серверная база.
		СтрокаСправа = Сред(СтрокаПодключения, НомерСимвола + 5);
		
		Возврат Сред(СтрокаСправа, 1, СтрДлина(СтрокаСправа) - 2);
	КонецЕсли;
	
	Возврат "";
	
Конецфункции

// Возвращает значение предопределенного элемента ПВХ по имени.
//
// Параметры:
//  Имя - Строка - Имя переменной ПВХ.
//  ИспользоватьКэш - Булево - Признак получения данных из кэша.
// 
// Возвращаемое значение:
//  - ПроизвольныйТип - Значение переменной ПВХ.
//  - Массив - Массив значений переменной ПВХ.
// 
Функция ПолучитьПредопределенноеЗначение(Имя, ИспользоватьКэш = Ложь) Экспорт
	
	Если ИспользоватьКэш Тогда
		Возврат __ОбщегоНазначенияПовтИсп.ПолучитьПредопределенноеЗначение(Имя);
	Иначе
		Возврат ПланыВидовХарактеристик.__ПредопределенныеЗначения.ПолучитьЗначение(Имя);
	КонецЕсли;
	
КонецФункции

// Возвращает соответствие предопределенных элементов ПВХ по имени.
//
// Параметры:
//  Имя - Строка - Имена переменных ПВХ, перечисленные через запятую.
//  ВРазрезеКлючей - Булево - Признак получения данных в виде соответствия, где Ключ - Имя переменной.
//  ИспользоватьКэш - Булево - Признак получения данных из кэша.
// 
// Возвращаемое значение:
//  - Соответствие - Соответствие имен и значений переменных ПВХ.
//  - Массив - Массив значений переменных ПВХ.
//
Функция ПолучитьПредопределенныеЗначения(Имена, ВРазрезеКлючей = Ложь, ИспользоватьКэш = Ложь) Экспорт
	
	Если ИспользоватьКэш Тогда
		Возврат __ОбщегоНазначенияПовтИсп.ПолучитьПредопределенныеЗначения(Имена, ВРазрезеКлючей);
	Иначе
		Возврат ПланыВидовХарактеристик.__ПредопределенныеЗначения.ПолучитьЗначения(Имена, ВРазрезеКлючей);
	КонецЕсли;
	
КонецФункции

// Возвращает таблицу соответствий по отбору.
//
// Параметры:
//  ТипСоответствия - Перечисление.__ТипСоответствияОбъектовИБ - Тип соответствия.
//  Объект1 - ПроизвольныйТип - Объект1.
//  Объект2 - ПроизвольныйТип - Объект2.
//  Объект3 - ПроизвольныйТип - Объект3.
//  ИспользоватьКэш - Булево - Признак получения данных из кэша.
// 
// Возвращаемое значение:
//  - ТаблицаЗначений - Таблица соответствий по отбору.
//
Функция ПолучитьСоответствиеОбъектовИБ(ТипСоответствия, Объект1 = Неопределено, Объект2 = Неопределено, Объект3 = Неопределено, ИспользоватьКэш = Ложь) Экспорт
	
	Если ИспользоватьКэш Тогда
		Возврат __ОбщегоНазначенияПовтИсп.ПолучитьСоответствиеОбъектовИБ(ТипСоответствия, Объект1, Объект2, Объект3);
	Иначе
		Возврат РегистрыСведений.__СоответствияОбъектовИБ.ПолучитьСоответствиеОбъектовИБ(ТипСоответствия, Объект1, Объект2, Объект3);
	КонецЕсли;
	
КонецФункции

// Возвращает таблицу значений с датами за период
//
// Параметры:
//  НачалоПериода	 - Дата - Начало периода.
//  ОкончаниеПериода - Дата - Конец периода.
//  Интервал		 - Строка - одно из следующих значений:
//             (Секунда, Минута, Час, День, Неделя, Месяц, Квартал, Полугодие, Год)
// 
// Возвращаемое значение:
//  ТаблицаЗначений - Таблица значений с датами за период. Содержит одну колонку "Период".
//
Функция ПолучитьТаблицуДатЗаПериод(НачалоПериода, ОкончаниеПериода, Интервал = "День") Экспорт
	
	ТаблицаИнтервалов = Новый ТаблицаЗначений;
	ТаблицаИнтервалов.Колонки.Добавить("Период", Новый ОписаниеТипов("Дата"));
	
	Запрос = Новый Запрос;
	Запрос.Текст = "ВЫБРАТЬ
		|	НАЧАЛОПЕРИОДА(&НачалоПериода, ДЕНЬ) КАК Период
		|
		|УПОРЯДОЧИТЬ ПО
		|	Период
		|ИТОГИ ПО
		|	Период ПЕРИОДАМИ(%Интервал%, &НачалоПериода, &ОкончаниеПериода)";
	
	Запрос.Текст = СтрЗаменить(Запрос.Текст, "%Интервал%", Интервал);
	
	Запрос.УстановитьПараметр("НачалоПериода", НачалоПериода);
	Запрос.УстановитьПараметр("ОкончаниеПериода", ОкончаниеПериода);
	
	Выборка = Запрос.Выполнить().Выбрать(ОбходРезультатаЗапроса.ПоГруппировкам, "Период", "ВСЕ");
	Пока Выборка.Следующий() Цикл
		ЗаполнитьЗначенияСвойств(ТаблицаИнтервалов.Добавить(), Выборка);
	КонецЦикла;
	
	Возврат ТаблицаИнтервалов;
	
КонецФункции

//Устанавливает элемент отбор динамического списка
//
//Параметры:
//Список			- обрабатываемый динамический список,
//ИмяПоля			- имя поля компоновки, отбор по которому нужно установить,
//ВидСравнения		- вид сравнения отбора, по умолчанию - Равно,
//ПравоеЗначение 	- значение отбора
//
Процедура УстановитьЭлементОтбораСписка(Список, ИмяПоля, ПравоеЗначение, ВидСравнения = Неопределено, Представление = "") Экспорт
	
	ЭлементОтбора = Список.Отбор.Элементы.Добавить(Тип("ЭлементОтбораКомпоновкиДанных"));
	ЭлементОтбора.ЛевоеЗначение		= Новый ПолеКомпоновкиДанных(ИмяПоля);
	ЭлементОтбора.ВидСравнения		= ?(ВидСравнения = Неопределено, ВидСравненияКомпоновкиДанных.Равно, ВидСравнения);
	ЭлементОтбора.Использование		= Истина;
	ЭлементОтбора.ПравоеЗначение	= ПравоеЗначение;
	ЭлементОтбора.Представление		= Представление;
	
КонецПроцедуры

//Изменяет элемент отбора динамического списка
//
//Параметры:
//Список         - обрабатываемый динамический список,
//ИмяПоля        - имя поля компоновки, отбор по которому нужно установить,
//ВидСравнения   - вид сравнения отбора, по умолчанию - Равно,
//ПравоеЗначение - значение отбора,
//Установить     - признак необходимости установить отбор
//
Процедура ИзменитьЭлементОтбораСписка(Список, ИмяПоля, ПравоеЗначение = Неопределено, Установить = Ложь, ВидСравнения = Неопределено) Экспорт
	
	УдалитьЭлементОтбораСписка(Список, ИмяПоля);
	
	Если Установить Тогда
		
		УстановитьЭлементОтбораСписка(Список, ИмяПоля, ПравоеЗначение, ВидСравнения);
		
	КонецЕсли;
	
КонецПроцедуры

//Удаляет элемент отбора динамического списка
//
//Параметры:
//Список  - обрабатываемый динамический список,
//ИмяПоля - имя поля компоновки, отбор по которому нужно удалить
//
Процедура УдалитьЭлементОтбораСписка(Список, ИмяПоля) Экспорт
	
	ЭлементыДляУдаления = Новый Массив;
	
	ЭлементыОтбора = Список.Отбор.Элементы;
	ПолеКомпоновки = Новый ПолеКомпоновкиДанных(ИмяПоля);
	
	Для Каждого ЭлементОтбора Из ЭлементыОтбора Цикл
		Если ТипЗнч(ЭлементОтбора) = Тип("ЭлементОтбораКомпоновкиДанных")
			И ЭлементОтбора.ЛевоеЗначение = ПолеКомпоновки Тогда
			ЭлементыДляУдаления.Добавить(ЭлементОтбора);
		КонецЕсли;
	КонецЦикла;
	
	Для Каждого ЭлементОтбораДляУдаления Из ЭлементыДляУдаления Цикл
		
		ЭлементыОтбора.Удалить(ЭлементОтбораДляУдаления);
		
	КонецЦикла;
	
КонецПроцедуры

// Функция возвращает полный текст ошибки возникающей при исключении
//
// Параметры:
//	ЗаголовокОшибки - Строка - описание действия повлекшего ошибку
//	ТекстИсключения - Строка - подробное представление ошибки
//	ДополнительныеСообщения - Массив - массив дополнительных сообщений
Функция ПолучениеПолногоТекстаОшибкиПриИсключении(ЗаголовокОшибки, ТекстИсключения, ДополнительныеСообщения) Экспорт

	ТекстОшибки = ЗаголовокОшибки;
	Для Каждого Сообщение Из ДополнительныеСообщения Цикл
		ТекстОшибки = ТекстОшибки + Символы.ПС + Сообщение.Текст;
	КонецЦикла;
	ТекстОшибки = ТекстОшибки + Символы.ПС + ТекстИсключения;
	
	Возврат ТекстОшибки;

КонецФункции

// Процедура удаляет экземпляр регламентного задания.
// 
// Параметры:
//  КлючЗадания - Строка - Ключ регламентного задания
//
Процедура УдалитьЭкземплярРегламентногоЗадания(КлючЗадания) Экспорт
	
	// ++ Обход ошибки отстутствия модуля БСП, не переносить
	РегламентныеЗаданияСервер = Неопределено;
	// -- Обход ошибки отстутствия модуля БСП, не переносить
	
	ОтборЗадания = Новый Структура;
	ОтборЗадания.Вставить("Ключ", КлючЗадания);
	МассивРегламентныхЗаданий = РегламентныеЗаданияСервер.НайтиЗадания(ОтборЗадания);
	
	Если МассивРегламентныхЗаданий.Количество() Тогда
		РегламентноеЗадание = МассивРегламентныхЗаданий[0];
		РегламентныеЗаданияСервер.УдалитьЗадание(РегламентноеЗадание.УникальныйИдентификатор);
	КонецЕсли;
	
КонецПроцедуры

// Процедура выполняет запись элемента справочника.
// 
// Параметры:
//  ТекущийОбъект  - СправочникОбъект.
//  Заголовок      - Строка (По умолчанию = "").
//  РежимСообщений - Строка: "Нет","Все","Ошибки" (По умолчанию = "Все").
//  РежимЗагрузки  - Булево (По умолчанию = Ложь).
// 
// Возвращаемое значение:
//   Булево - действие выполнено.
// 
Функция ЗаписатьСправочник(ТекущийОбъект, Заголовок = "", РежимСообщений = "Все", РежимЗагрузки = Ложь) Экспорт
	
	// ++ Обход ошибки отстутствия модуля БСП, не переносить
	ОбщегоНазначения = Неопределено;
	// -- Обход ошибки отстутствия модуля БСП, не переносить
	
	ДействиеВыполнено = Ложь;
	
	РежимыВывода = ОпределитьРежимыВывода(РежимСообщений);
	
	Попытка
		
		Если РежимЗагрузки Тогда
			ТекущийОбъект.ОбменДанными.Загрузка = Истина;
			ДействиеВыполнено				 	= Истина;
		Иначе
			ДействиеВыполнено = ТекущийОбъект.ПроверитьЗаполнение();
		КонецЕсли; 
		
		Если ДействиеВыполнено Тогда
			
			ТекущийОбъект.Записать();
			Если РежимыВывода.ВыводитьИнформацию Тогда
				ТекстСообщения = НСтр("ru='Записан справочник ""%1"".';en='Directory ""%1"" saved.'");
				ТекстСообщения = СтрШаблон(ТекстСообщения, ТекущийОбъект.Ссылка);
				ОбщегоНазначения.СообщитьПользователю(ТекстСообщения);	
			КонецЕсли;
		КонецЕсли;
	Исключение
		
		ДействиеВыполнено = Ложь;
		
		Если РежимыВывода.ВыводитьОшибки Тогда
			ОбщегоНазначения.СообщитьПользователю(КраткоеПредставлениеОшибки(ИнформацияОбОшибке()));
		КонецЕсли;
		
		ЗаписьЖурналаРегистрации("__.ОшибкаЗаписиСправочника", УровеньЖурналаРегистрации.Ошибка,,,
								 ПодробноеПредставлениеОшибки(ИнформацияОбОшибке()));
		
	КонецПопытки;
	
	Возврат ДействиеВыполнено;
	
КонецФункции // ЗаписатьСправочник()

// Преобразует текст формата XML в таблицу значений,
// при этом колонки таблицы формируются на основе описания в XML.
// 
// Параметры:
//  ТекстXML - Текст в формате XML.
//      Схема XML:
// 			<?xml version="1.0" encoding="utf-8"?>
// 			<xs:schema attributeFormDefault="unqualified" 
// 						elementFormDefault="qualified" xmlns:xs="http:// www.w3.org/2001/XMLSchema">
//			  <xs:element name="Items">
//			 	<xs:complexType>
// 				  <xs:sequence>
// 					<xs:element maxOccurs="unbounded" name="Item">
// 					  <xs:complexType>
// 						<xs:attribute name="Code" type="xs:integer" use="required" />
// 						<xs:attribute name="Name" type="xs:string" use="required" />
// 						<xs:attribute name="Socr" type="xs:string" use="required" />
// 						<xs:attribute name="Index" type="xs:string" use="required" />
// 					  </xs:complexType>
// 					</xs:element>
// 				  </xs:sequence>
// 				  <xs:attribute name="Description" type="xs:string" use="required" />
// 				  <xs:attribute name="Columns" type="xs:string" use="required" />
// 				</xs:complexType>
// 			 </xs:element>
//			 </xs:schema> 
//      Примеры XML-файлов см. в демонстрационной конфигурации.
// 
// Пример использования:
//   КлассификаторТаблица = ПрочитатьXMLВТаблицу(РегистрыСведений.АдресныйКлассификатор.
//       ПолучитьМакет("КлассификаторАдресныхОбъектовРоссии").ПолучитьТекст());
// 
// Возвращаемое значение:
//  ТаблицаЗначений.
// 
Функция ПрочитатьXMLВТаблицу(ТекстXML) Экспорт
	
	Чтение = Новый ЧтениеXML;
	Чтение.УстановитьСтроку(ТекстXML);
	
	// Прочитаем первый узел и проверим его.
	Если Не Чтение.Прочитать() Тогда
		ВызватьИсключение("Пустой XML");
	ИначеЕсли Чтение.Имя <> "Items" Тогда
		ВызватьИсключение(НСтр("ru='Ошибка в структуре XML';en='Ошибка в структуре XML'"));
	КонецЕсли;
	
	// Получим описание таблицы и создадим ее.
	ИмяТаблицы = Чтение.ПолучитьАтрибут("Description");
	ИменаКолонок = СтрЗаменить(Чтение.ПолучитьАтрибут("Columns"), ",", Символы.ПС);
	Колонок = СтрЧислоСтрок(ИменаКолонок);
	
	ТаблицаЗначений = Новый ТаблицаЗначений;
	Для Сч = 1 По Колонок Цикл
		ТаблицаЗначений.Колонки.Добавить(СтрПолучитьСтроку(ИменаКолонок, Сч), Новый ОписаниеТипов("Строка"));
	КонецЦикла;
	
	// Заполним значения в таблице.
	Пока Чтение.Прочитать() Цикл
		
		Если Чтение.ТипУзла <> ТипУзлаXML.НачалоЭлемента Тогда
			Продолжить;
		ИначеЕсли Чтение.Имя <> "Item" Тогда
			ВызватьИсключение(НСтр("ru='Ошибка в структуре XML';en='Ошибка в структуре XML'"));
		КонецЕсли;
		
		новСтр = ТаблицаЗначений.Добавить();
		Для Сч = 1 По Колонок Цикл
			ИмяКолонки = СтрПолучитьСтроку(ИменаКолонок, Сч);
			новСтр[Сч-1] = Чтение.ПолучитьАтрибут(ИмяКолонки);
		КонецЦикла;
		
	КонецЦикла;
	
	// Заполним результат.
	Результат = Новый Структура;
	Результат.Вставить("ИмяТаблицы", ИмяТаблицы);
	Результат.Вставить("Данные", ТаблицаЗначений);
	
	Возврат Результат;
	
КонецФункции // ПрочитатьXMLВТаблицу()

// Функция определяет режимы вывода сообщений.
// 
// Параметры:
//  РежимСообщений - Строка - "Нет","Все","Ошибки".
// 
// Возвращаемое значение:
//  Структура.
// 
Функция ОпределитьРежимыВывода(РежимСообщений) Экспорт
	
	РежимыВывода       = Новый Структура("ВыводитьОшибки,ВыводитьИнформацию");
	
	РежимыВывода.ВыводитьОшибки     = ВРег(РежимСообщений)= ВРег("Все") ИЛИ ВРег(РежимСообщений) = ВРег("Ошибки");
	РежимыВывода.ВыводитьИнформацию = ВРег(РежимСообщений)= ВРег("Все");
	
	Возврат РежимыВывода;
	
КонецФункции // ОпределитьРежимВывода()

// Функция выполняет произвольный код с параметрами.
// Вставлено: 02.02.2009.
// 
// Параметры:
//  Текст функции       - Произвольный.
//  СтруктураПараметров - Массив структур (Номер, Значение) .
//  Переменные          - Структура.
// 
// Возвращаемое значение:
//   Неопределено, в случае успешного выполнения, Описание ошибки, в случае неудачи.
// 
Функция ВыполнитьПользовательскуюФункциюСПараметрами(ТекстФункции, СтруктураПараметров, Переменные) Экспорт
	
	// Служебные переменные для передачи параметров функции.
	Перем П1, П2, П3, П4, П5, П6, П7, П8, П9, П10;
	
	Для Каждого Параметр Из СтруктураПараметров Цикл
		
		Если Параметр.Номер = 1 Тогда
			П1 = Параметр.Значение;
			ТекстФункции = СтрЗаменить(ТекстФункции, Параметр.Параметр, "П1");
		ИначеЕсли Параметр.Номер = 2 Тогда
			П2 = Параметр.Значение;
			ТекстФункции = СтрЗаменить(ТекстФункции, Параметр.Параметр, "П2");
		ИначеЕсли Параметр.Номер = 3 Тогда
			П3 = Параметр.Значение;
			ТекстФункции = СтрЗаменить(ТекстФункции, Параметр.Параметр, "П3");
		ИначеЕсли Параметр.Номер = 4 Тогда
			П4 = Параметр.Значение;
			ТекстФункции = СтрЗаменить(ТекстФункции, Параметр.Параметр, "П4");
		ИначеЕсли Параметр.Номер = 5 Тогда
			П5 = Параметр.Значение;
			ТекстФункции = СтрЗаменить(ТекстФункции, Параметр.Параметр, "П5");
		ИначеЕсли Параметр.Номер = 6 Тогда
			П6 = Параметр.Значение;
			ТекстФункции = СтрЗаменить(ТекстФункции, Параметр.Параметр, "П6");
		ИначеЕсли Параметр.Номер = 7 Тогда
			П7 = Параметр.Значение;
			ТекстФункции = СтрЗаменить(ТекстФункции, Параметр.Параметр, "П7");
		ИначеЕсли Параметр.Номер = 8 Тогда
			П8 = Параметр.Значение;	
			ТекстФункции = СтрЗаменить(ТекстФункции, Параметр.Параметр, "П8");
		ИначеЕсли Параметр.Номер = 9 Тогда
			П9 = Параметр.Значение;	
			ТекстФункции = СтрЗаменить(ТекстФункции, Параметр.Параметр, "П9");
		ИначеЕсли Параметр.Номер = 10 Тогда
			П10 = Параметр.Значение;
			ТекстФункции = СтрЗаменить(ТекстФункции, Параметр.Параметр, "П10");
		КонецЕсли;
		
	КонецЦикла;
	
	Результат = Неопределено;
	
	Попытка
		// АПК:487-выкл ВыполнитьВБезопасномРежиме не используется, т.к. выполняется безопасный код.
		Выполнить(ТекстФункции);
		// АПК:487-вкл
	Исключение
		ВызватьИсключение КраткоеПредставлениеОшибки(ИнформацияОбОшибке());
	КонецПопытки;
	
	Возврат Результат;
	
КонецФункции // ВыполнитьПользовательскуюФункциюСПараметрами()

// Добавляет новую строку "СтрокаТекста" к тексту "Текст".
// 
// Параметры:
//  Текст        - Строка.
// 	СтрокаТекста - Строка.
// 
Процедура ДобавитьСтрокуКТексту(Текст, СтрокаТекста) Экспорт
	
	Текст = Текст + ?(СокрЛП(Текст) = "", "", Символы.ПС) + СтрокаТекста;
	
КонецПроцедуры // ДобавитьСтрокуКТексту()

// Функция по массиву типов создает список выбора для быстрого выбора составного типа.
// 
// Параметры:
//  МассивТипов - Массив.
// 
// Возвращаемое значение:
//  СписокЗначений.
// 
Функция ПодготовитьСписокВыбораТипа(МассивТипов) Экспорт
	
	СписокВыбора = Новый СписокЗначений;
	Для каждого ТекТип Из МассивТипов Цикл
		
		ОбъектМетаданных = Метаданные.НайтиПоТипу(ТекТип);
		Если ОбъектМетаданных = Неопределено Тогда
			ТекПредставление = Строка(ТекТип);
		Иначе
			ТекПредставление = ОбъектМетаданных.Синоним;
		КонецЕсли;
		
		СписокВыбора.Добавить(ТекТип,ТекПредставление);
	КонецЦикла;
	
	Возврат СписокВыбора;
	
КонецФункции // ПодготовитьСписокВыбораТипа()

// Функция определяет имя объекта ссылочного типа по описанию типов.
// 
// Параметры:
//  ОписаниеТипов   - ОписаниеТипов - содержит тип, имя объекта которого нужно определить.
//  ИмяКоллекции    - Строка - имя коллекции объектов метаданных: "Справочники","Документы" и т.п.
//  НачалоИмениТипа - Строка - начало строкового представления типа : "СправочникСсылка", "ДокументСсылка" и т.п.
// 
// Возвращаемое значение:
//  РезСтруктура   - Структура (Ключи: "Имя","Синоним","ИмяТипа"; Значения: Строка) 
//                   Неопределено (если имя не удалось определить). 
//
Функция ПолучитьИмяОбъектаПоОписаниюТипов(ОписаниеТипов, ИмяКоллекции, НачалоИмениТипа) Экспорт
	
	РезСтруктура = Неопределено;
	
	Для каждого Мета Из Метаданные[ИмяКоллекции] Цикл
		
		ИмяТипа = НачалоИмениТипа + "." + Мета.Имя;
		Если ОписаниеТипов.СодержитТип(Тип(ИмяТипа)) Тогда
			
			РезСтруктура = Новый Структура;
			РезСтруктура.Вставить("Имя", Мета.Имя);
			РезСтруктура.Вставить("Синоним", Мета.Синоним);
			РезСтруктура.Вставить("ИмяТипа", ИмяТипа);
			
			Прервать;
		КонецЕсли;
	КонецЦикла;
	
	Возврат РезСтруктура;
	
КонецФункции // ПолучитьИмяОбъектаПоОписаниюТипов()

// Функция получает имя объекта по имени формы.
// 
// Параметры:
//  ИмяФормы - Строка.
//  
// Возвращаемое значение:
//   Строка.
// 
Функция ПолучитьИмяОбъектаПоИмениФормы(ИмяФормы, ПолноеИмя = Истина) Экспорт
	
	МассивИмениФормы = __СтроковыеФункцииКлиентСервер.РазобратьСтрокуСРазделителями(ИмяФормы, ".");
	Результат = ?(ПолноеИмя, МассивИмениФормы[0] + ".", "") + МассивИмениФормы[1];
	
	Возврат Результат;
	
КонецФункции // ПолучитьИмяОбъектаПоИмениФормы()

#Область ОтладкаВременныхТаблиц

// Функция возвращает все поля указанной временной таблицы из менеджера временных таблиц.
// Используется для просмотра временных таблиц в отладчике.
//
// Параметры:
//  ЗапросМенеджер - Запрос, МенеджерВременныхТаблиц - запрос (для вычленения текста запроса) или менеджер.
//  ИмяВременнойТаблицы - Строка - Имя временной таблицы
// 
// Возвращаемое значение:
//  - ТаблицаЗначений - Результат временной таблицы запроса.
//
// Пример вызова функции:
//    ЗапасыСервер.ПоказатьВременнуюТаблицу(МенеджерВременныхТаблиц, "ТаблицаТоваров")
//
Функция ПоказатьВременнуюТаблицу(ЗапросМенеджер, ИмяВременнойТаблицы) Экспорт
	
	ЗакрытьМенеджерВременныхТаблиц = Ложь;
	
	Если ТипЗнч(ЗапросМенеджер) = Тип("Запрос") Тогда
		Если ЗапросМенеджер.МенеджерВременныхТаблиц = Неопределено Тогда
			МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
			ЗакрытьМенеджерВременныхТаблиц = Истина;
			ЗапросМенеджер.МенеджерВременныхТаблиц = МенеджерВременныхТаблиц;
		Иначе
			МенеджерВременныхТаблиц = ЗапросМенеджер.МенеджерВременныхТаблиц;
		КонецЕсли;
		
		ЗапросМенеджер.Выполнить();
	Иначе
		МенеджерВременныхТаблиц = ЗапросМенеджер;
	КонецЕсли;
	
	ДанныеТаблицы = ЗапросВыполнитьВыгрузить("ВЫБРАТЬ * ИЗ " + ИмяВременнойТаблицы,, МенеджерВременныхТаблиц);
	
	Если ЗакрытьМенеджерВременныхТаблиц Тогда
		МенеджерВременныхТаблиц.Закрыть();
		ЗапросМенеджер.МенеджерВременныхТаблиц = Неопределено;
	КонецЕсли;
	
	Возврат ДанныеТаблицы;
	
КонецФункции

// Функция возвращает результат запроса.
//
// Параметры:
//  ТекстЗапроса - Строка - текст исполняемого запроса.
//  ПараметрыЗапроса - Соответствие - Соответствие параметров запроса.
//  МенеджерВременныхТаблиц - МенеджерВременныхТаблиц - Менеджер временных таблиц запроса.
// 
// Возвращаемое значение:
//  - ТаблицаЗначений - Результат выполнения запроса.
//
Функция ЗапросВыполнитьВыгрузить(ТекстЗапроса, ПараметрыЗапроса = Неопределено,
	МенеджерВременныхТаблиц = Неопределено) Экспорт
	
	Запрос = Новый Запрос(ТекстЗапроса);
	
	Если МенеджерВременныхТаблиц <> Неопределено Тогда
		Запрос.МенеджерВременныхТаблиц = МенеджерВременныхТаблиц;
	КонецЕсли;
	
	Если ЗначениеЗаполнено(ПараметрыЗапроса) Тогда
		Для Каждого Параметр Из ПараметрыЗапроса Цикл
			Запрос.УстановитьПараметр(Параметр.Ключ, Параметр.Значение);
		КонецЦикла;
	КонецЕсли;
	
	Возврат Запрос.Выполнить().Выгрузить();
	
КонецФункции

// Формирует список полей временных таблиц.
//
// Параметры:
//  ЗапросМенеджер - Запрос, МенеджерВременныхТаблиц - запрос (для вычленения текста запроса) или менеджер 
//		временных таблиц (имена временных таблиц в этом случае надо передавать явно).
//  ИменаВременныхТаблиц	- Строка - строка с именами интересующих временных таблиц (обязательный параметр при передаче 
//		менеджера ВТ вместо запроса в первом параметре).
// 
// Возвращаемое значение:
//  Массив - Поля временных таблицы, находящиеся в менеджере или запросе.
//
// Пример вызова функции:
//      ПросмотрВременныхТаблиц(Запрос, "")
//
Функция ПоляВременныхТаблиц(ЗапросМенеджер, ИменаВременныхТаблиц = "") Экспорт
	
	// Предварительная обработка параметров:
	Если ТипЗнч(ЗапросМенеджер) = Тип("МенеджерВременныхТаблиц") Тогда
		Если ИменаВременныхТаблиц = "" Тогда
			Возврат "Укажите имена временных таблиц через запятую";
		Иначе
			Запрос = Новый Запрос;
			Запрос.МенеджерВременныхТаблиц = ЗапросМенеджер;
		КонецЕсли;
	Иначе
		Запрос = ЗапросМенеджер;
	КонецЕсли;
	
	ТекстЗапроса = ВРег(Запрос.Текст);
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, Символы.Таб, " ");
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, Символы.ВТаб, " ");
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, Символы.НПП, " ");
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, ")", ") ");
	ТекстЗапроса = СтрЗаменить(ТекстЗапроса, "(", " (");
	
	ОчищенныйТекстЗапроса = "";
	Для НомерСтроки = 1 По СтрЧислоСтрок(ТекстЗапроса) Цикл
		
		ОчереднаяСтрока = СтрПолучитьСтроку(ТекстЗапроса, НомерСтроки);
		ПозицияКомментария = СтрНайти(ОчереднаяСтрока, "//");
		
		Если ПозицияКомментария > 0 Тогда
			ОчереднаяСтрока = Лев(ОчереднаяСтрока,ПозицияКомментария-1);
		КонецЕсли;
		
		ОчищенныйТекстЗапроса = ОчищенныйТекстЗапроса + " " + ОчереднаяСтрока;
	КонецЦикла;
	
	ТекстЗапроса = ОчищенныйТекстЗапроса;
	
	// Парсинг текста запроса и получение из него имен временных таблиц	
	ВременныеТаблицыЗапроса = новый Массив;
	
	Если НЕ ИменаВременныхТаблиц = "" Тогда
		
		СписокДополнительныхИмен = СтрЗаменить(ИменаВременныхТаблиц, ",", Символы.ПС);
		Для Счетчик = 1 По СтрЧислоСтрок(СписокДополнительныхИмен) Цикл
			ТекСтрока = СтрПолучитьСтроку(СписокДополнительныхИмен, Счетчик);
			ВременныеТаблицыЗапроса.Добавить(ТекСтрока);
		КонецЦикла;
		
	КонецЕсли;
	
	ВременнаяТаблица = НайтиИменаТаблицПоРасположениюСлов(ТекстЗапроса, "ПОМЕСТИТЬ");
	Для Каждого КлючЗначение Из ВременнаяТаблица Цикл
		ВременныеТаблицыЗапроса.Добавить(КлючЗначение.Ключ);
	КонецЦикла;
	
	ВременнаяТаблица = НайтиИменаТаблицПоРасположениюСлов(ТекстЗапроса, "ИЗ", "КАК");
	Для Каждого КлючЗначение Из ВременнаяТаблица Цикл
		ВременныеТаблицыЗапроса.Добавить(КлючЗначение.Ключ);
	КонецЦикла;
	
	ВременнаяТаблица = НайтиИменаТаблицПоРасположениюСлов(ТекстЗапроса, "СОЕДИНЕНИЕ", "КАК");
	Для Каждого КлючЗначение Из ВременнаяТаблица Цикл
		ВременныеТаблицыЗапроса.Добавить(КлючЗначение.Ключ);
	КонецЦикла;
	
	УничтожаемыеВременныеТаблицы = НайтиИменаТаблицПоРасположениюСлов(ТекстЗапроса, "УНИЧТОЖИТЬ");
	Для Каждого КлючЗначение Из УничтожаемыеВременныеТаблицы Цикл
		ВременныеТаблицыЗапроса.Добавить(КлючЗначение.Ключ);
	КонецЦикла;
	
	Ответ = Новый Структура;
	
	Если Запрос.МенеджерВременныхТаблиц = Неопределено тогда
		
		// На случай, если ВТ удаляются в тексте запроса, сложнейший алгоритм предварительно скопирует их
		Смещение = 0;
		Если УничтожаемыеВременныеТаблицы.Количество() Тогда
			Для Каждого КлючИЗначение Из УничтожаемыеВременныеТаблицы Цикл
				
				ПозицияУничтожения = КлючИЗначение.Значение + Смещение;
				ИмяВТ = КлючИЗначение.Ключ ;
				НовыйПодзапросКопирования   = "ВЫБРАТЬ * ПОМЕСТИТЬ КОПИЯ" + ИмяВТ + " ИЗ "+ ИмяВТ + ";";
				
				ТекстЗапроса = Лев(ТекстЗапроса, ПозицияУничтожения - 1) + НовыйПодзапросКопирования + Прав(
					ТекстЗапроса, СтрДлина(ТекстЗапроса) - (ПозицияУничтожения - 1));
					
				Смещение = Смещение + НовыйПодзапросКопирования;
			КонецЦикла;
		КонецЕсли;
		
		// Выполняем запрос для создания интересующих нас таблиц
		ЗапросТМП = Новый Запрос;
		ЗапросТМП.МенеджерВременныхТаблиц = Новый МенеджерВременныхТаблиц;
		Для Каждого Параметр Из Запрос.Параметры Цикл
			ЗапросТМП.УстановитьПараметр(Параметр.Ключ, Параметр.Значение);
		КонецЦикла;
		
		ЗапросТМП.Текст = ТекстЗапроса;
		ЗапросТМП.Выполнить();
		
		ЗаполнитьТаблицыПоСпискуИмен(Ответ, ВременныеТаблицыЗапроса, ЗапросТМП.МенеджерВременныхТаблиц);
		
		ЗапросТМП.МенеджерВременныхТаблиц.Закрыть();
		
	Иначе
		
		// Это надо запускать после выполнения запроса, чтобы временные таблицы уже были созданы	
		ОтсутствующиеИменаТаблиц = ЗаполнитьТаблицыПоСпискуИмен(
			Ответ, ВременныеТаблицыЗапроса, Запрос.МенеджерВременныхТаблиц);
		
		Для Каждого ИмяТаблицы Из ОтсутствующиеИменаТаблиц Цикл
			
			Если УничтожаемыеВременныеТаблицы.Получить(ИмяТаблицы) = Неопределено Тогда
				СообщениеОбОшибке = "Таблица еще не создана либо имя задано не верно";
			Иначе
				СообщениеОбОшибке = "Таблица уничтожается при выполнении пакета";
			КонецЕсли;
			
			Ответ.Вставить(ИмяТаблицы, СообщениеОбОшибке);
			
		КонецЦикла;
		
	КонецЕсли;
	
	Возврат Ответ;
	
КонецФункции

#КонецОбласти // ОтладкаВременныхТаблиц

#КонецОбласти // ПрограммныйИнтерфейс

#Область СлужебныеПроцедурыИФункции

Функция ЗаполнитьТаблицыПоСпискуИмен(СтруктураОтвета, МассивИменТаблиц, Менеджер)
	
	ОтсутствующиеИменаТаблиц = Новый Массив;
	
	Запрос = Новый Запрос;
	Запрос.МенеджерВременныхТаблиц = Менеджер;
	
	Для Каждого ИмяТаблицы Из МассивИменТаблиц Цикл
		Если НЕ СтруктураОтвета.Свойство(ИмяТаблицы) Тогда
			
			Запрос.Текст = "ВЫБРАТЬ * ИЗ " + ИмяТаблицы + " КАК " + ИмяТаблицы;
			Попытка
				СтруктураОтвета.Вставить(ИмяТаблицы, Запрос.Выполнить().Выгрузить());
			Исключение
				СтруктураОтвета.Вставить(ИмяТаблицы, ОписаниеОшибки());
				ОтсутствующиеИменаТаблиц.Добавить(ИмяТаблицы);
			КонецПопытки;
			
		КонецЕсли;
	КонецЦикла;
	
	Возврат ОтсутствующиеИменаТаблиц;
	
КонецФункции

Функция НайтиИменаТаблицПоРасположениюСлов(Знач Текст, ПервоеИскомоеСлово, ВтороеИскомоеСлово = "")
	
	СписокИгнорируемыхСимволов = Новый СписокЗначений;
	СписокИгнорируемыхСимволов.Добавить(Символы.ПС);
	СписокИгнорируемыхСимволов.Добавить(Символы.ВК);
	СписокИгнорируемыхСимволов.Добавить(Символы.НПП);
	СписокИгнорируемыхСимволов.Добавить(Символы.Таб);
	СписокИгнорируемыхСимволов.Добавить(" ");
	
	СписокРазделителей = Новый СписокЗначений;
	СписокРазделителей.Добавить("(");
	СписокРазделителей.Добавить(")");
	СписокРазделителей.Добавить(".");
	СписокРазделителей.Добавить(",");
	СписокРазделителей.Добавить(";");
	СписокРазделителей.Добавить("&");
	
	НайденныеИмена = Новый Структура;
	ПервоеИскомоеСлово = ВРег(ПервоеИскомоеСлово);
	ВтороеИскомоеСлово = ВРег(ВтороеИскомоеСлово);
	
	Пока Истина Цикл
		
		Найдено = Найти(Текст, " " + ВРег(ПервоеИскомоеСлово) + " ");
		Если Найдено > 0 Тогда
			
			Текст = СокрЛП(Прав(Текст, СтрДлина(Текст) - Найдено - СтрДлина(ПервоеИскомоеСлово) - 1));
			СоставляемоеСлово = "";
			НайденноеСлово = "";
			
			Для НомерСтроки = 1 По СтрДлина(Текст) Цикл
				
				ОчереднойСимвол = Сред(Текст, НомерСтроки, 1);
				
				Если НЕ СписокРазделителей.НайтиПоЗначению(ОчереднойСимвол) = Неопределено Тогда
					
					СоставляемоеСлово = "";
					НайденноеСлово = "";
					
					Прервать;
					
				ИначеЕсли НЕ СписокИгнорируемыхСимволов.НайтиПоЗначению(ОчереднойСимвол) = Неопределено Тогда
					
					Если СоставляемоеСлово = "" Тогда
						Продолжить;
					Иначе
						Если НайденноеСлово = "" Тогда
							
							НайденноеСлово = СоставляемоеСлово;
							СоставляемоеСлово = "";
							
							Если ВтороеИскомоеСлово = "" Тогда
								Прервать;
							КонецЕсли;
							
						Иначе
							
							Если НЕ СоставляемоеСлово = ВтороеИскомоеСлово Тогда
								НайденноеСлово = "";
							КонецЕсли;
							
							Прервать;
							
						КонецЕсли;
					КонецЕсли;
				Иначе
					СоставляемоеСлово = СоставляемоеСлово + ОчереднойСимвол;
				КонецЕсли;
				
			КонецЦикла;
			
			Если НЕ НайденноеСлово = "" Тогда
				НайденныеИмена.Вставить(НайденноеСлово, Найдено);
			КонецЕсли;
		Иначе
			Прервать;
		КонецЕсли;
		
	КонецЦикла;
	
	Возврат НайденныеИмена;
	
КонецФункции

#КонецОбласти // СлужебныеПроцедурыИФункции