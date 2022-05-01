class StoreEvents {
  const StoreEvents();
}

class ListInitialized extends StoreEvents {
  const ListInitialized({required this.map});

  final Map<String, int> map;
}

class ItemCounterIncrement extends StoreEvents {
  const ItemCounterIncrement({required this.itemName});

  final String itemName;
}

class ItemCounterDecrement extends StoreEvents {
  const ItemCounterDecrement({required this.itemName});

  final String itemName;
}

class ItemCounterReset extends StoreEvents {
  const ItemCounterReset({required this.itemName});

  final String itemName;
}

class ResetAllCounters extends StoreEvents {
  const ResetAllCounters();
}
