﻿
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
// © Гриценко Даниил 2021-2023г. | Общий модуль ОбщегоНазначенияКлиентСерверГлобальный
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

#Область ПрограммныйИнтерфейс

#Область СтандартныеЗначения

// Возвращает пустой уникальный идентификатор: 00000000-0000-0000-0000-000000000000.
//
// Параметры:
//  Строкой	- Булево - вернуть уникальный идентификатор преобразованный в строку. 
// 
// Возвращаемое значение:
//   - УникальныйИдентификатор, Строка 
//
Функция глПустойУникальныйИдентификатор(Строкой = Ложь) Экспорт
	
	УИДСтрокой	= "00000000-0000-0000-0000-000000000000";
	УИД			= ?(Строкой, УИДСтрокой, Новый УникальныйИдентификатор(УИДСтрокой));  
	
	Возврат УИД;
	
КонецФункции

// Возвращает пустую дату: 01.01.0001. 0:00:00.
// 
// Возвращаемое значение:
//   - Дата
//
Функция глПустаяДата() Экспорт
	
	ПустаяДата = Дата(1, 1, 1);
	Возврат ПустаяДата;
	
КонецФункции

// Возвращает макисмально возможную дату: 31.12.3999 23:59:59.
// 
// Возвращаемое значение:
//   - Дата
//
Функция глМаксимальнаяДата() Экспорт
	
	МаксимальнаяДата = Дата(3999, 12, 31, 23, 59, 59);
	Возврат МаксимальнаяДата;
	
КонецФункции

#КонецОбласти

#Область ОписаниеТипов

// Возвращает описание типа Срока.
//
// Параметры:
//  ДлинаСтроки		- Число	 - максимальная длина строки; 
//  ПеременнаяДлина	- Булево - использовать переменное ограничение длины строки.
// 
// Возвращаемое значение:
//   - ОписаниеТипов 
//
Функция глОписаниеСтроки(ДлинаСтроки = 0, ПеременнаяДлина = Истина) Экспорт
	
	ОграничениеДлины	= ?(ПеременнаяДлина, ДопустимаяДлина.Переменная, ДопустимаяДлина.Фиксированная);
	КвалификаторСтроки	= Новый КвалификаторыСтроки(ДлинаСтроки, ОграничениеДлины);
	ОписаниеСтроки 		= Новый ОписаниеТипов("Строка",,,, КвалификаторСтроки);
	
	Возврат ОписаниеСтроки;
	
КонецФункции

// Возвращает описание типа Число.
//
// Параметры:
//  ЧислоРазрядов				- Число		- общее число разрядов целой и дробной частей;  
//  ЧислоРазрядовДробнойЧасти	- Число		- число разрядов дробной части; 
//  Неотрицательное				- Булево	- использовать ограничение отрицательный знак числа. 
// 
// Возвращаемое значение:
//   - ОписаниеТипов 
//
Функция глОписаниеЧисла(ЧислоРазрядов = 17, ЧислоРазрядовДробнойЧасти = 2, Неотрицательное = Ложь) Экспорт
	
	ОграничениеЗнака	= ?(Неотрицательное, ДопустимыйЗнак.Неотрицательный, ДопустимыйЗнак.Любой);  
	КвалификаторЧисла 	= Новый КвалификаторыЧисла(ЧислоРазрядов, ЧислоРазрядовДробнойЧасти, ОграничениеЗнака);
	ОписаниеЧисла		= Новый ОписаниеТипов("Число",,, КвалификаторЧисла);
	
	Возврат ОписаниеЧисла;
	
КонецФункции

// Возваращает описание типа Дата.
//
// Параметры:
//  ЧастиДаты - ЧастиДаты - состав описания типа Дата. Если не указано, 
//							то будет выбран состав с датой и временем.
// 
// Возвращаемое значение:
//   - ОписаниеТипов
//
Функция глОписаниеДаты(СоставДаты = Неопределено) Экспорт
	
	ТекущийСоставДаты 	= ?(СоставДаты = Неопределено, ЧастиДаты.ДатаВремя, СоставДаты);
	КвалификаторДаты	= Новый КвалификаторыДаты(ТекущийСоставДаты);
	ОписаниеДаты 		= Новый ОписаниеТипов("Дата",,,,, КвалификаторДаты);
	
	Возврат ОписаниеДаты;
	
КонецФункции

// Возвращает описание типа Булево.
// 
// Возвращаемое значение:
//   - ОписаниеТипов 
//
Функция глОписаниеБулево() Экспорт
	
	ОписаниеБулево = Новый ОписаниеТипов("Булево");
	Возврат ОписаниеБулево;
	
КонецФункции

// Возвращает описание типа УникальныйИдентификатор.
// 
// Возвращаемое значение:
//   - ОписаниеТипов 
//
Функция глОписаниеУникальногоИдентификатора() Экспорт
	
	ОписаниеУникальногоИдентификатора = Новый ОписаниеТипов("УникальныйИдентификатор");
	Возврат ОписаниеУникальногоИдентификатора;
	
КонецФункции

#КонецОбласти

#КонецОбласти
