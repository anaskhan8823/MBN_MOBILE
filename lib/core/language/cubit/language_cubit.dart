import 'package:dalil_2020_app/core/cache/cache_helper.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../helper/app_toast.dart';
part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit() :super(LanguageState(locale: Locale(CachHelper.lang ??'ar'),
   fontFamily:(CachHelper.lang ?? 'ar') == 'ar' ? 'STV' :'Poppins',

  ));
  void changeLanguage (String langCode,BuildContext context) async {
    if (state.locale.languageCode != langCode) {
      String newFont = langCode == 'ar' ? 'STV' :'Poppins';
      CachHelper.lang=langCode;
      CachHelper.saveData();
      emit(LanguageState(locale: Locale(langCode),fontFamily: newFont ));
      await  EasyLocalization.of(context)?.setLocale(Locale(langCode));
    }
  }

  void restartApplication()async {
    CachHelper.lang=='en'?
    AppToast.success("language change successfully to english"):
    AppToast.success("تم تغيير اللغة الي اللغه العربية بنجاح");
  }

}
