abstract class IOrderRepository {
  Future<bool> sendOrder(Map<String, int> order);
}
