import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../core/style/app_colors.dart';
import '../add_product/units/add_product_form.dart';
import '../add_product/units/add_product_salary.dart';
import '../shop_owner_details/add_store/units/contact.dart';
import '../shop_owner_details/add_store/units/details.dart';
import '../shop_owner_details/add_store/units/general_information.dart';
import '../shop_owner_details/add_store/units/store_details.dart';
class StepperAndNavAddProductCubit extends Cubit<int> {
  StepperAndNavAddProductCubit() : super(0);
  final formKey = GlobalKey<FormState>();
  final tabs = <Widget>[
  const GeneralInformation(),
    const Contact(),
    const Details(),
    const StoreDetails()
  ];
  final tabsOfProduct = <Widget>[
    const AddProductForm(),
    const AddProductSalary(),
  ];
  final tbsOfProductFamilies = <Widget>[
     AddProductForm(color: AppColors.primaryProductive,),
     AddProductSalary(color: AppColors.primaryProductive,),
  ];
  final List<String> sections = [
    'Information',
    'Contact',
    'Categories',
    'time',
  ];
  final List<String> productSection = [
    'Information',
    'Contact',
  ];
  int activeStep = 0;
  onStepReached(index) {
    activeStep = index;
    emit(index);
  }

  void nextSection(index) {
    if (activeStep < sections.length - 1) {
      activeStep = index;
      activeStep++;
    }
    emit(activeStep);
  }
  void next(index) {
    if (activeStep < productSection.length - 1) {
      activeStep = index;
      activeStep++;
    }
    emit(activeStep);
  }

  void backSection(index) {
    if (activeStep == 0) {
      return;
    }

    if (activeStep < sections.length - 1 || activeStep == 3) {
      activeStep = index;
      activeStep--;
    }
    emit(activeStep);
  }
}
