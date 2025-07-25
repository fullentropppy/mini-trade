﻿
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// © Гриценко Даниил 2021-2023г. | Модуль формы
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ОбработчикиСобытийФормы

// Обработчик события При создании на сервере.
//
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	// Финансы.
	ВалютаУчета = "RUB"; // Предопределенная валюта.
	
	// Склад.
	ВестиУчетПоСкладам						= ПолучитьФункциональнуюОпцию("ВестиУчетПоСкладам");
	КонтролироватьОстаткиТоваров 			= Константы.КонтролироватьОстаткиТоваров.Получить();
	КонтролироватьОстаткиТоваровПоСкладам 	= ПолучитьФункциональнуюОпцию("КонтролироватьОстаткиТоваровПоСкладам");
	
	Элементы.ГруппаКонтролироватьОстаткиТоваровПоСкладам.Видимость = КонтролироватьОстаткиТоваровПоСкладам;
	
	// Редактирование документов.
	ИспользоватьДатыЗапретаРедактирования = ПолучитьФункциональнуюОпцию("ИспользоватьДатыЗапретаРедактирования");
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

// Обработчик события Вести учет по складам при изменении.
//
&НаКлиенте
Процедура ВестиУчетПоСкладамПриИзменении(Элемент)
	
	ОбщегоНазначенияВызовСервера.УстановитьЗначениеКонстанты("ВестиУчетПоСкладам", ВестиУчетПоСкладам); 
	
	ЗначениеВидимость = ?(ВестиУчетПоСкладам, КонтролироватьОстаткиТоваров, ВестиУчетПоСкладам);	
	Элементы.ГруппаКонтролироватьОстаткиТоваровПоСкладам.Видимость = ЗначениеВидимость;	
	
	ОбновитьИнтерфейс();
	
КонецПроцедуры

// Обработчик события Контролировать остатки товаров при изменении.
//
&НаКлиенте
Процедура КонтролироватьОстаткиТоваровПриИзменении(Элемент)
	
	ОбщегоНазначенияВызовСервера.УстановитьЗначениеКонстанты(
		"КонтролироватьОстаткиТоваров", КонтролироватьОстаткиТоваров);	
	
	ЗначениеВидимости = ?(ВестиУчетПоСкладам, КонтролироватьОстаткиТоваров, ВестиУчетПоСкладам);
	Элементы.ГруппаКонтролироватьОстаткиТоваровПоСкладам.Видимость = ЗначениеВидимости;
	
	ОбновитьИнтерфейс();
	
КонецПроцедуры

// Обработчик события  Контролировать остатки товаров по складам при изменении.
//
&НаКлиенте
Процедура КонтролироватьОстаткиТоваровПоСкладамПриИзменении(Элемент)
	
	ОбщегоНазначенияВызовСервера.УстановитьЗначениеКонстанты(
		"КонтролироватьОстаткиТоваровПоСкладам", КонтролироватьОстаткиТоваровПоСкладам);			
	
	ОбновитьИнтерфейс();
		
КонецПроцедуры

// Обработчик события Использовать даты запрета редактирования при изменении.
//
&НаКлиенте
Процедура ИспользоватьДатыЗапретаРедактированияПриИзменении(Элемент)
	
	ОбщегоНазначенияВызовСервера.УстановитьЗначениеКонстанты(
		"ИспользоватьДатыЗапретаРедактирования", ИспользоватьДатыЗапретаРедактирования);
	ОбновитьИнтерфейс();
	
КонецПроцедуры

#КонецОбласти


#Область ОбработчикиКомандФормы

// Гиперссылка Реквизиты организации;
//  Открывает форму обработки Реквизиты организации.
//
&НаКлиенте
Процедура ОткрытьРеквизитыОрганизации(Команда)
	
	ОткрытьФорму("Обработка.РеквизитыОрганизации.Форма");
	
КонецПроцедуры

// Гиперссылка Управление датами запрета редактирования;
//  Открывает форму обработки Управление датами запрета редактирования.
//
&НаКлиенте
Процедура ОткрытьУправлениеДатамиЗапретаРедактирования(Команда)
	
	ОткрытьФорму("Обработка.УправлениеДатамиЗапретаРедактирования.Форма.Форма");
	
КонецПроцедуры

// Гиперссылка Даты запрета редактирования;
//  Открывает регистр сведений Даты запрета редактирования.
//
&НаКлиенте
Процедура ОткрытьДатыЗапретаРедактирования(Команда)
	
	ОткрытьФорму("РегистрСведений.ДатыЗапретаРедактирования.Форма.ФормаСписка");
	
КонецПроцедуры

#КонецОбласти