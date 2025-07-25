﻿
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// © Гриценко Даниил 2021-2023г. | Общий модуль ЗапасыСервер
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

// Выполняет контроль наличия свободных остатков товаров на складе списания.
//
// Параметры:
//  СписокТоваров	 - Массив		 				- проверяемый список списываемых товаров;
//  Склад			 - СправочникСсылка.Склады	 	- проверяемый склад списания.
//  МоментВремени	 - МоментВремени
//  Отказ			 - Булево
//
Процедура ПроконтролироватьОстаткиТоваров(СписокТоваров, Склад, МоментВремени, Отказ) Экспорт
	
	ТребуетсяКонтрольОстатков = ТребуетсяКонтрольОстатковТоваров(Склад);
	Если Не ТребуетсяКонтрольОстатков Тогда
		Возврат;
	КонецЕсли;
	
	ИнтервалВремени = Новый Граница(МоментВремени, ВидГраницы.Включая);
	
	ПараметрыКонтроля = Новый Структура;
	ПараметрыКонтроля.Вставить("ИнтервалВремени", 	ИнтервалВремени);
	ПараметрыКонтроля.Вставить("СкладСписания", 	Склад);
	ПараметрыКонтроля.Вставить("СписываемыеТовары", СписокТоваров);
	
	ЕстьОтрицательныеОстатки = ЕстьОтрицательныеОстаткиТоваровПриСписании(ПараметрыКонтроля);
	Если ЕстьОтрицательныеОстатки Тогда
		Отказ = Истина;
	КонецЕсли;
	
КонецПроцедуры

// Проверяет превышение расхода свободных остатков товаров на складе списания.
//
//  ПараметрыКонтроля - Структура - структура из параметров контроля:
//	 * СписываемыеТовары	- Массив 					- проверяемый список списываемых товаров.
//	 * СкладСписания		- СправочникСсылка.Склады 	- проверяемый склад списания;	
//	 * ИнтервалВремени		- Граница 					- проверяемый интервал времени;
//
Функция ЕстьОтрицательныеОстаткиТоваровПриСписании(ПараметрыКонтроля) Экспорт
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
		"ВЫБРАТЬ
		|	ОстаткиТоваровОстатки.Товар.Представление КАК Товар,
		|	ОстаткиТоваровОстатки.КоличествоОстаток КАК Остаток
		|ИЗ
		|	РегистрНакопления.ОстаткиТоваров.Остатки(
		|			&ИнтервалВремени,
		|			Склад = &Склад
		|				И Товар В (&Товары)) КАК ОстаткиТоваровОстатки
		|ГДЕ
		|	ОстаткиТоваровОстатки.КоличествоОстаток < 0";
	
	Запрос.УстановитьПараметр("ИнтервалВремени", 	ПараметрыКонтроля.ИнтервалВремени);
	Запрос.УстановитьПараметр("Склад", 				ПараметрыКонтроля.СкладСписания);
	Запрос.УстановитьПараметр("Товары", 			ПараметрыКонтроля.СписываемыеТовары);
	
	Результат = Запрос.Выполнить();
	Если Результат.Пустой() Тогда
		Возврат Ложь;
	КонецЕсли;
			
	// Если после записи в регистр образуются отрицательные остатки,
	// то выводится информация о недостатке остатков.		
	УчетПоСкладам 			= ПолучитьФункциональнуюОпцию("ВестиУчетПоСкладам");
	ШаблонТекстаСообщения 	= ?(УчетПоСкладам, 
		НСтр("ru = 'На складе ""%1"" недостаточно товара ""%2"" для списания в количестве %3'"),
		НСтр("ru = 'Недостаточно товара ""%1"" для списания в количестве %2'"));
	
	Выборка = Результат.Выбрать();
	Пока Выборка.Следующий() Цикл
		Товар 			= Выборка.Товар;
		Остаток 		= Выборка.Остаток;
		ТекстСообщения 	= ?(УчетПоСкладам,
			СтрШаблон(ШаблонТекстаСообщения, ПараметрыКонтроля.СкладСписания, Товар, - Остаток),
			СтрШаблон(ШаблонТекстаСообщения, Товар, - Остаток)); 
			
		ОбщегоНазначенияКлиентСервер.СообщитьПользователю(ТекстСообщения);
	КонецЦикла;
	
	Возврат Истина;
	
КонецФункции

// Определяет необходимость выполнения контроля наличия свободных остатков на складе списания. 
//
// Параметры:
//  Склад - СправочникСсылка.Склады - проверяемый склад списания. Если не указан, 
//									  необходимость контроля будет определена в целом.
// 
// Возвращаемое значение:
//   - Булево 
//
Функция ТребуетсяКонтрольОстатковТоваров(Склад = Неопределено) Экспорт
	
	ТребуетсяКонтроль = ЗапасыСерверПовтИсп.ТребуетсяКонтрольОстатковТоваров(Склад);
	Возврат ТребуетсяКонтроль;
		
КонецФункции

// Определяет для пользователя возможность проведения без  контроля наличия свободных остатков товаров на складе списания.
//
// Параметры:
//  Склад 			- СправочникСсылка.Склады		- проверяемый склад списания. Если не указан, 
//									  				  необходимость контроля будет определена в целом; 
//	Пользователь 	- СправочникСсылка.Пользователи - проверяемый пользователь. Если не указан, 
//													  то будет выбран текущий пользователь.
// 
// Возвращаемое значение:
//   - Булево 
//
Функция ДоступноПроведениеБезКонтроляОстатковТоваров(Склад = Неопределено, Пользователь = Неопределено) Экспорт
	
	ПроведениеДоступно = ЗапасыСерверПовтИсп.ДоступноПроведениеБезКонтроляОстатковТоваров(Склад, Пользователь);
	Возврат ПроведениеДоступно;
	
КонецФункции

#КонецОбласти