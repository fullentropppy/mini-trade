﻿
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// © Гриценко Даниил 2021-2023г. | Модуль формы
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ОбработчикиКомандФормы

// Команда Поступление товаров (подменю  Создать);
//  Открывает форму нового документа Поступление товаров.
//
&НаКлиенте
Процедура СоздатьПоступлениеТоваров(Команда)
	
	ОткрытьФорму("Документ.ПоступлениеТоваров.ФормаОбъекта");
	
КонецПроцедуры

// Команда Продажа товаров (подменю  Создать);
//  Открывает форму нового документа Продажа товаров.
//
&НаКлиенте
Процедура СоздатьПродажуТоваров(Команда)
	
	ОткрытьФорму("Документ.ПродажаТоваров.ФормаОбъекта");
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовТаблицыФормыСписок

// Обработчик события Список при активизации строки.
//
&НаКлиенте
Процедура СписокПриАктивизацииСтроки(Элемент)
	
	ТекущиеДанные = Элемент.ТекущиеДанные;
	Если ТекущиеДанные = Неопределено Тогда
		Возврат;
	КонецЕсли;
	
	//////////////////////////////////////////////////////////////////////////////////////////////
	// Установка видимости команд создания на основании в зависимости от выбранного типа документа.
	
	ЗначениеВидимостиПродажаТоваров 		= Ложь;
	ЗначениеВидимостьПеремещениеТоваров		= Ложь;
	ЗначениеВидимостьСписаниеТоваров		= Ложь;
	ЗначениеВидимостиУстановкаЦенТоваров 	= Ложь;
	
	ТекущийТип = ТекущиеДанные.Тип;
	Если ТекущийТип = Тип("ДокументСсылка.ПоступлениеТоваров") Тогда
		ЗначениеВидимостиПродажаТоваров 		= Истина;
		ЗначениеВидимостьПеремещениеТоваров		= Истина;
		ЗначениеВидимостьСписаниеТоваров		= Истина;
		ЗначениеВидимостиУстановкаЦенТоваров 	= Истина;
	ИначеЕсли ТекущийТип = Тип("ДокументСсылка.ПродажаТоваров") Тогда
		ЗначениеВидимостиУстановкаЦенТоваров = Истина;	
	КонецЕсли;
	
	КомандыСозданияНаОсновании = Элементы.ПодменюСоздатьНаОсновании.ПодчиненныеЭлементы;
	Если Не КомандыСозданияНаОсновании.Найти("ФормаДокументПродажаТоваровСоздатьНаОсновании") = Неопределено Тогда
		КомандыСозданияНаОсновании.ФормаДокументПродажаТоваровСоздатьНаОсновании.Видимость = ЗначениеВидимостиПродажаТоваров;
	КонецЕсли;
	Если Не КомандыСозданияНаОсновании.Найти("ФормаДокументПеремещениеТоваровСоздатьНаОсновании") = Неопределено Тогда
		КомандыСозданияНаОсновании.ФормаДокументПеремещениеТоваровСоздатьНаОсновании.Видимость= ЗначениеВидимостьПеремещениеТоваров;
	КонецЕсли;
	Если Не КомандыСозданияНаОсновании.Найти("ФормаДокументСписаниеТоваровСоздатьНаОсновании") = Неопределено  Тогда
		КомандыСозданияНаОсновании.ФормаДокументСписаниеТоваровСоздатьНаОсновании.Видимость	= ЗначениеВидимостьСписаниеТоваров;
	КонецЕсли;
	Если Не КомандыСозданияНаОсновании.Найти("ФормаДокументУстановкаЦенТоваровСоздатьНаОсновании") = Неопределено Тогда
		КомандыСозданияНаОсновании.ФормаДокументУстановкаЦенТоваровСоздатьНаОсновании.Видимость	= ЗначениеВидимостиУстановкаЦенТоваров;
	КонецЕсли;
			
КонецПроцедуры

#КонецОбласти
