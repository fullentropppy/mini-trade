﻿
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// © Гриценко Даниил 2021-2023г. | Общий модуль ЗапасыСерверПовтИсп
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

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
	
	ВключенОбщийКонтроль 	= Константы.КонтролироватьОстаткиТоваров.Получить();
	ТребуетсяКонтроль 		= ВключенОбщийКонтроль;

	Если ВключенОбщийКонтроль И Не Склад = Неопределено И ПолучитьФункциональнуюОпцию("ВестиУчетПоСкладам") Тогда
		ВключенКонтрольПоСкладам 	= ПолучитьФункциональнуюОпцию("КонтролироватьОстаткиТоваровПоСкладам");
		ВключенКонтрольНаСкладе		= ОбщегоНазначенияСервер.ЗначениеРеквизитаОбъекта(Склад, "КонтролироватьОстаткиТоваров");
		ТребуетсяКонтроль 			= ?(ВключенКонтрольПоСкладам, ВключенКонтрольНаСкладе, Истина); 	
	КонецЕсли;
	
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
	
	ТребуетсяКонтрольОстатков = ТребуетсяКонтрольОстатковТоваров(Склад);
	Если ТребуетсяКонтрольОстатков Тогда
		Свойство 			= ПланыВидовХарактеристик.ДополнительныеСвойстваПользователей.ПроведениеБезКонтроляОстатков;
		РазрешеноПроведение = ПользователиСервер.ЗначениеДополнительногоСвойства(Свойство, Пользователь);
		ПроведениеДоступно 	= ?(РазрешеноПроведение = Неопределено, Ложь, РазрешеноПроведение); 
	Иначе
		ПроведениеДоступно = Ложь;		
	КонецЕсли;
	
	Возврат ПроведениеДоступно;
	
КонецФункции

#КонецОбласти