abstract class InputEvents{}

class ViewCustomerCodeClickedEvent extends InputEvents{
  
  final String customerName , customerCode ;

  ViewCustomerCodeClickedEvent(this.customerName, this.customerCode);
}

class ViewItemcodeClickedEvent extends InputEvents{

  final String itemName , itemCode;

  ViewItemcodeClickedEvent({required this.itemName, required this.itemCode});
}

class ViewProductionAreaClickedEvent extends InputEvents{

  final String countryName , code;

  ViewProductionAreaClickedEvent({required this.countryName, required this.code});
}


class QuantityFetchEvent extends InputEvents{
 
  final String quantityType;

  QuantityFetchEvent({required this.quantityType});

}

class KokoshijiFetchEvent extends InputEvents{

  final String kakoshiji;

  KokoshijiFetchEvent({required this.kakoshiji});

}

class ViewUnitItemPriceClickedEvent extends InputEvents{
  
  final String itemPrice , itemCode , itemName ;

  ViewUnitItemPriceClickedEvent({required this.itemPrice, required this.itemCode, required this.itemName});
}

class PrintButtonClickedEvent extends InputEvents{}


class NextScreenButtonClickedEvent extends InputEvents{}