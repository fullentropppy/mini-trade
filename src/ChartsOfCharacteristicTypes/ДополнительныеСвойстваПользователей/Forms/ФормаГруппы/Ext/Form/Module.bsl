﻿
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// © Гриценко Даниил 2021-2023г. | Модуль формы
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ОбработчикиСобытийФормы

// Обработчик события При чтении на сервере.
//
&НаСервере
Процедура ПриЧтенииНаСервере(ТекущийОбъект)
	
	ФормыКлиентСервер.УстановитьДанныеСостоянияСправочника(ЭтаФорма);
	
КонецПроцедуры

// Обработчик события При создании на сервере.
//
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	Если Объект.Ссылка.Пустая() Тогда
		ФормыКлиентСервер.УстановитьДанныеСостоянияСправочника(ЭтаФорма);	
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

