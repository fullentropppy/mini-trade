﻿
#Область ПрограммныйИнтерфейс

// Возвращает табличный документ с версиями программы.
//
// Возвращаемое значение:
//   - ТабличныйДокумент
//
&НаСервере
Функция ВерсииПрограммы() Экспорт
	
	ВерсииПрограммы = ПолучитьМакет("ВерсииПрограммы");
	Возврат ВерсииПрограммы;
	
КонецФункции

#КонецОбласти
