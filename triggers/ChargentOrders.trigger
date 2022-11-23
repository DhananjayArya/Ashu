trigger ChargentOrders on ChargentOrders__ChargentOrder__c (after insert) {

    ChargentOrderHandler.handleOne(trigger.newMap.keySet());
}