﻿
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// © Гриценко Даниил 2021-2023г. | Общий модуль ЗапасыВызовСервера
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
	
	ТребуетсяКонтроль = ЗапасыСервер.ТребуетсяКонтрольОстатковТоваров(Склад);
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
	
	ПроведениеДоступно = ЗапасыСервер.ДоступноПроведениеБезКонтроляОстатковТоваров(Склад, Пользователь);
	Возврат ПроведениеДоступно;
	
КонецФункции

#КонецОбласти