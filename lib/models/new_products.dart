
class JsonProduct {
  final String product;
  int prAmount;
  JsonProduct({
    required this.product,
    required this.prAmount,
  });

 }
List<String>selectedJsonProducts=[];
List<String>selectedNewJsonProducts=[];
List <JsonProduct>newJson =[];

void addUserCartDetails(
    {
      required String product,
      required int prAmount,
    })
{
  final newDetails=JsonProduct(
    product: product,
    prAmount: prAmount,
  );
  newJson.add(newDetails);
}

