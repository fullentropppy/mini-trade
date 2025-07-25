﻿
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// © Гриценко Даниил 2021-2023г. | Модуль команды
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ОбработчикиСобытий

// Обработчик события Обработка команды.
//
&НаКлиенте
Процедура ОбработкаКоманды(ПараметрКоманды, ПараметрыВыполненияКоманды)
	
	ТекущийПользователь = ОбщегоНазначенияВызовСервера.ЗначениеПараметраСеанса("ТекущийПользователь");
	
	ПараметрыФормы = Новый Структура();
	ПараметрыФормы.Вставить("ИндивидуальнаяНастройка");
	ПараметрыФормы.Вставить("Пользователь", ТекущийПользователь);
	
	ОткрытьФорму("Обработка.ПерсональныеНастройки.Форма.ПерсональныеНастройки", ПараметрыФормы);
	
КонецПроцедуры

#КонецОбласти