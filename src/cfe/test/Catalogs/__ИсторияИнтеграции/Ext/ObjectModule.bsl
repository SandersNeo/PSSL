﻿
&ИзменениеИКонтроль("ПередУдалением")
Процедура тст_ПередУдалением(Отказ)

	Если ОбменДанными.Загрузка Тогда
		Возврат;
	КонецЕсли;

	#Удаление
	ОбменДанными.Загрузка = Истина;
	#КонецУдаления
	#Вставка
	//Проверка
	#КонецВставки
	ДополнительныеСвойства.Вставить("ОтключитьМеханизмРегистрацииОбъектов", Истина);

КонецПроцедуры
