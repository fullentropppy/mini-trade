﻿
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// © Гриценко Даниил 2021-2023г. | Модуль формы
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ОбработчикиСобытийФормы

// Обработчик события При создании на сервере.
//
&НаСервере
Процедура ПриСозданииНаСервере(Отказ, СтандартнаяОбработка)
	
	ИндивидуальнаяНастройка = Параметры.Свойство("ИндивидуальнаяНастройка");
	Если ИндивидуальнаяНастройка Тогда
		ПараметрПользовательПередан = Параметры.Свойство("Пользователь", Пользователь);
		Если Не ПараметрПользовательПередан ИЛИ Не ЗначениеЗаполнено(Пользователь) Тогда
			ТекстИсключения = НСтр("ru = 'Неверный параметр формы Пользователь:
				|параметр не передан или значение параметра не заполнено!'");
			ВызватьИсключение ТекстИсключения;
		КонецЕсли;
	КонецЕсли;
	
	АвтоЗаголовок = Ложь;
	Если ИндивидуальнаяНастройка Тогда
		Заголовок						= НСтр("ru = 'Настройки пользователя: '") + Пользователь;
		Элементы.Пользователь.Видимость = Ложь;
		Элементы.Разделитель1.Видимость = Ложь;		
	Иначе		
		АвтоЗаголовок	= Ложь;
		Заголовок		= НСтр("ru = 'Настройки пользователей'");
		Пользователь 	= ПараметрыСеанса.ТекущийПользователь;	
	КонецЕсли;
		
	ЗаполнитьДанныеИУстановитьУсловноеОформление();	
	
КонецПроцедуры

// Обработчик события Перед закрытием.
//
&НаКлиенте
Процедура ПередЗакрытием(Отказ, ЗавершениеРаботы, ТекстПредупреждения, СтандартнаяОбработка)
	
	ФормыКлиент.ПроверитьМодифицированностьПередЗакрытием(ЭтаФорма, Отказ);
		
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиСобытийЭлементовШапкиФормы

// Обработчик события Пользователь начало выбора.
//
&НаКлиенте
Процедура ПользовательНачалоВыбора(Элемент, ДанныеВыбора, СтандартнаяОбработка)
		
	Если Модифицированность Тогда
		СтандартнаяОбработка = Ложь;
		
		ДополнительныеПараметры = Новый Структура();
		ОписаниеОповещения 		= Новый ОписаниеОповещения("ПользовательОбработкаВыбораПослеОтвета", ЭтаФорма);
		ТекстВопроса = НСтр("ru = 'Перед выбором другого пользователя необходимо " 
			+ "записать настройки текущего пользователя. Записать?'");		
		ПоказатьВопрос(ОписаниеОповещения, ТекстВопроса, РежимДиалогаВопрос.ДаНет);
	КонецЕсли;
	
КонецПроцедуры

// Обработчик события Пользователь обработка выбора.
//
&НаКлиенте
Процедура ПользовательОбработкаВыбора(Элемент, ВыбранноеЗначение, СтандартнаяОбработка)
	
	СтандартнаяОбработка = Ложь;
	
	// Проверка выбранного пользователя на возможность работы с его персональными настройками.
	ИмяПользователяИБ = ПользователиВызовСервера.ПользовательИБПоПользователю(ВыбранноеЗначение, Истина);
	Если ИмяПользователяИБ = Неопределено Тогда
		ТекстПредупреждения = НСтр("ru = 'Выбранный пользователь не сопоставлен с пользователем информационной базы. "
			+ "Выберите другого пользователя'");
		ПоказатьПредупреждение(, ТекстПредупреждения);
	Иначе
		Пользователь = ВыбранноеЗначение;
		ЗаполнитьДанныеИУстановитьУсловноеОформление();
	КонецЕсли;
	
КонецПроцедуры

#КонецОбласти

#Область ОбработчикиКомандФормы

// Команда Записать.
//
&НаКлиенте
Процедура Записать(Команда)
	
	ЗаписатьДанные();
	
КонецПроцедуры

// Команда Записать и закрыть.
//
&НаКлиенте
Процедура ЗаписатьИЗакрыть(Команда)
	
	ЗаписатьДанные();
	Закрыть();
	
КонецПроцедуры

#КонецОбласти

#Область СлужебныеПроцедурыИФункции

// Завершение выполнения обработчика ПередЗакрытием. 
//
&НаКлиенте
Процедура ПроверитьМодифицированностьПередЗакрытиемПослеОтвета(РезультатВопроса, ДополнительныеПараметры) Экспорт
	
	Если РезультатВопроса = КодВозвратаДиалога.Да Тогда
		ЗаписатьДанные();
		Закрыть();
	ИначеЕсли РезультатВопроса = КодВозвратаДиалога.Нет Тогда
		Модифицированность = Ложь;
		Закрыть();
    КонецЕсли;	
	
КонецПроцедуры

// Завершение выполнения обработчика ПользовательНачалоВыбора. 
//
&НаКлиенте
Процедура ПользовательОбработкаВыбораПослеОтвета(РезультатВопроса, ДополнительныеПараметры) Экспорт
	
	Если РезультатВопроса = КодВозвратаДиалога.Да Тогда
		ЗаписатьДанные();
	КонецЕсли;
	
КонецПроцедуры

// Записывает указанные данные на форме в хранилище общих настроек.
//
&НаКлиенте
Процедура ЗаписатьДанные()
	
	Если ИндивидуальнаяНастройка Тогда
		ЗаписатьВПараметрыПриложения = Истина;
	Иначе
		ТекущийПользователь 			= ОбщегоНазначенияВызовСервера.ЗначениеПараметраСеанса("ТекущийПользователь");
		ЗаписатьВПараметрыПриложения 	= Пользователь = ТекущийПользователь;
	КонецЕсли;
	
	Если ЗаписатьВПараметрыПриложения Тогда
		// Обновление значения ключа структуры глобальной переменной глПараметрыПриложения.
		глПараметрыПриложения.ЗапрашиватьПодтверждение = ЗапрашиватьПодтверждение;
	КонецЕсли;
	
	// Сохранение настроек.
	ЗаписатьДанныеНаСервере();
	
КонецПроцедуры

// Заполняет данные настроек текущего пользователя и устанавливает условное оформление формы.
//
&НаСервере
Процедура ЗаполнитьДанныеИУстановитьУсловноеОформление()
	
	УстановитьПривилегированныйРежим(Истина);

	ИдентификаторПользователяИБ = Пользователь.ИдентификаторПользователяИБ;
	ВыбранныйПользовательИБ		= ПользователиСервер.ПользовательИБПоИдентификаторуПользователяИБ(ИдентификаторПользователяИБ);
	ИмяВладельцаНастроек		= ВыбранныйПользовательИБ.Имя;
	
	//////////////////////////////////////////////////////////////
	// Определение состава и значений настроек владельца настроек.
	
	// Определение наличия права создания новых документов Поступление товаров у владельца настроек.
	ЕстьПравоДобавленияПоступленияТоваров = ПравоДоступа("Добавление", Метаданные.Документы.ПоступлениеТоваров, ВыбранныйПользовательИБ);
	Элементы.ОсновнойВидЦенПоступленияТоваров.Видимость = ЕстьПравоДобавленияПоступленияТоваров;
	ОсновнойВидЦенПоступленияТоваров = ?(ЕстьПравоДобавленияПоступленияТоваров,
		ПерсональныеНастройкиСервер.ЗначениеОсновнойВидЦенПоступленияТоваров(ИмяВладельцаНастроек), Неопределено);	
	
	// Определение наличия права создания новых документов Продажа товаров у владельца настроек.
	ЕстьПравоДобавленияПродажиТоваров = ПравоДоступа("Добавление", Метаданные.Документы.ПродажаТоваров, ВыбранныйПользовательИБ);
	Элементы.ОсновнойВидЦенПродажаТоваров.Видимость = ЕстьПравоДобавленияПродажиТоваров;
	ОсновнойВидЦенПродажаТоваров = ?(ЕстьПравоДобавленияПродажиТоваров,
		ПерсональныеНастройкиСервер.ЗначениеОсновнойВидЦенПродажаТоваров(ИмяВладельцаНастроек), Неопределено);	
		
	// Определение видимости группы Маркетинг, в зависимости от того, может ли воспользоваться пользователь настройками этой группы.
	МаркетингВидимость 				= ЕстьПравоДобавленияПоступленияТоваров И ЕстьПравоДобавленияПродажиТоваров;	
	Элементы.Маркетинг.Видимость 	= МаркетингВидимость;
	Элементы.Отступ1.Видимость 		= МаркетингВидимость;
	
	// Определение видимости группы Прочее, в зависимости от того, может ли воспользоваться пользователь настройками этой группы. 
	Если ПравоДоступа("Добавление", Метаданные.Документы.ПеремещениеТоваров, ВыбранныйПользовательИБ)
	 ИЛИ ЕстьПравоДобавленияПоступленияТоваров
	 ИЛИ ЕстьПравоДобавленияПродажиТоваров Тогда
	 	ПрочееВидимость = Истина;
	Иначе
		ПрочееВидимость = Ложь;
	КонецЕсли;
	
	ОсновнойСклад = ?(ПрочееВидимость, 
		ПерсональныеНастройкиСервер.ЗначениеОсновнойСклад(ИмяВладельцаНастроек), Неопределено); 
		
		Элементы.Прочее.Видимость 	= ПрочееВидимость;
	Элементы.Отступ2.Видимость 	= ПрочееВидимость;
	
	// Загрузка остальных настроек.
	ФИОДляПечати				= ПерсональныеНастройкиСервер.ЗначениеФИОДляПечати(ИмяВладельцаНастроек);
	ЗапрашиватьПодтверждение 	= ПерсональныеНастройкиСервер.ЗначениеЗапрашиватьПодтверждение(ИмяВладельцаНастроек);	
	
	УстановитьПривилегированныйРежим(Ложь);
	
КонецПроцедуры

// Записывает указанные данные на форме в хранилище общих настроек.
//
&НаСервере
Процедура ЗаписатьДанныеНаСервере()
	
	Если Элементы.Маркетинг.Видимость Тогда
		Если Элементы.ОсновнойВидЦенПоступленияТоваров.Видимость Тогда
			ПерсональныеНастройкиСервер.УстановитьЗначениеОсновнойВидЦенПоступленияТоваров(ОсновнойВидЦенПоступленияТоваров, ИмяВладельцаНастроек);
		КонецЕсли;
		
		Если Элементы.ОсновнойВидЦенПродажаТоваров.Видимость Тогда
			ПерсональныеНастройкиСервер.УстановитьЗначениеОсновнойВидЦенПродажаТоваров(ОсновнойВидЦенПродажаТоваров, ИмяВладельцаНастроек);
		КонецЕсли;
	КонецЕсли;
	
	Если Элементы.Прочее.Видимость Тогда
		ПерсональныеНастройкиСервер.УстановитьЗначениеОсновнойСклад(ОсновнойСклад, ИмяВладельцаНастроек);
	КонецЕсли;
	
	ПерсональныеНастройкиСервер.УстановитьЗначениеФИОДляПечати(ФИОДляПечати, ИмяВладельцаНастроек);
	ПерсональныеНастройкиСервер.УстановитьЗначениеЗапрашиватьПодтверждение(ЗапрашиватьПодтверждение, ИмяВладельцаНастроек);
	
	Модифицированность = Ложь;
	
КонецПроцедуры

#КонецОбласти