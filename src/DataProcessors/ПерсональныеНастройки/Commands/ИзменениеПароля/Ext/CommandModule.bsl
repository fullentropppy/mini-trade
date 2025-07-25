﻿
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// © Гриценко Даниил 2021-2023г. | Модуль команды
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ОбработчикиСобытий

// Обработчик события Обработка команды.
//
&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	Если ЗапрещеноИзменятьПароль() Тогда
		ТекстПредупреждения = НСтр("ru = 'Изменение пароля запрещено!
										 |Не установлена аутентификация средствами 
										 |1С:Предприятия или установлен запрет 
										 |на самостоятельное изменение пароля'");
		ПоказатьПредупреждение(, ТекстПредупреждения);
	Иначе
		ОткрытьФорму("Обработка.ПерсональныеНастройки.Форма.ИзменениеПароля");
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Возвращает признак невозможности изменять пароль для текущего пользователя информационной базы.
// 
// Возвращаемое значение:
//   - Булево
//
&НаСервере
Функция ЗапрещеноИзменятьПароль()
		
	ПользовательИБ 			= ПользователиИнформационнойБазы.ТекущийПользователь();
	ЗапрещеноИзменятьПароль	= Не ПользовательИБ.АутентификацияСтандартная ИЛИ ПользовательИБ.ЗапрещеноИзменятьПароль;
		
	Возврат ЗапрещеноИзменятьПароль;
	
КонецФункции

#КонецОбласти