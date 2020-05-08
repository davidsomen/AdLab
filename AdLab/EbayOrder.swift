//
//  EbayFulfilment.swift
//  AdLab
//
//  Created by David Somen on 06/05/2020.
//  Copyright © 2020 David Somen. All rights reserved.
//

import Foundation

public struct EBAmount: Decodable {
    public var convertedFromCurrency : String!
    public var convertedFromValue : String!
    public var currency : String!
    public var value : String!
}

public struct EBBuyer: Decodable {
    public var username : String!
}

public struct EBCancelStatus: Decodable {
    //public var cancelRequests : [Any]!
    public var cancelState : String!
}

public struct EBContactAddress: Decodable {
    public var addressLine1 : String!
    public var addressLine2 : String!
    public var city : String!
    public var countryCode : String!
    public var postalCode : String!
    public var stateOrProvince : String!
}

public struct EBDeliveryCost: Decodable {
    public var shippingCost : EBShippingCost!
}

public struct EBDeliveryDiscount: Decodable {
    public var convertedFromCurrency : String!
    public var convertedFromValue : String!
    public var currency : String!
    public var value : String!
}

public struct EBFulfillmentStartInstruction: Decodable {
    public var ebaySupportedFulfillment : Bool!
    public var fulfillmentInstructionsType : String!
    public var shippingStep : EBShippingStep!
}

public struct EBHoldAmount: Decodable {
    public var convertedFromCurrency : String!
    public var convertedFromValue : String!
    public var currency : String!
    public var value : String!
}

public struct EBLineItem: Decodable {
    //public var appliedPromotions : [Any]!
    public var deliveryCost : EBDeliveryCost!
    public var legacyItemId : String!
    public var lineItemCost : EBLineItemCost!
    public var lineItemFulfillmentInstructions : EBLineItemFulfillmentInstruction!
    public var lineItemFulfillmentStatus : String!
    public var lineItemId : String!
    public var listingMarketplaceId : String!
    public var properties : EBProperty!
    public var purchaseMarketplaceId : String!
    public var quantity : Int!
    public var soldFormat : String!
    //public var taxes : [Any]!
    public var title : String!
    public var total : EBTotal!
}

public struct EBLineItemCost: Decodable {
    public var convertedFromCurrency : String!
    public var convertedFromValue : String!
    public var currency : String!
    public var value : String!
}

public struct EBLineItemFulfillmentInstruction: Decodable {
    public var guaranteedDelivery : Bool!
}

public struct EBOrder: Decodable {
    public var buyer : EBBuyer!
    public var buyerCheckoutNotes : String!
    public var cancelStatus : EBCancelStatus!
    public var creationDate : String!
    public var ebayCollectAndRemitTax : Bool!
    public var fulfillmentHrefs : [String]!
    public var fulfillmentStartInstructions : [EBFulfillmentStartInstruction]!
    public var lastModifiedDate : String!
    public var legacyOrderId : String!
    public var lineItems : [EBLineItem]!
    public var orderFulfillmentStatus : String!
    public var orderId : String!
    public var orderPaymentStatus : String!
    public var paymentSummary : EBPaymentSummary!
    public var pricingSummary : EBPricingSummary!
    public var salesRecordReference : String!
    public var sellerId : String!
}

public struct EBPayment: Decodable {
    public var amount : EBAmount!
    public var paymentDate : String!
    public var paymentHolds : [EBPaymentHold]!
    public var paymentMethod : String!
    public var paymentReferenceId : String!
    public var paymentStatus : String!
}

public struct EBPaymentHold: Decodable {
    public var holdAmount : EBHoldAmount!
    public var holdReason : String!
    public var holdState : String!
    public var releaseDate : String!
}

public struct EBPaymentSummary: Decodable {
    public var payments : [EBPayment]!
    //public var refunds : [Any]!
    public var totalDueSeller : EBTotalDueSeller!
}

public struct EBPriceSubtotal: Decodable {
    public var convertedFromCurrency : String!
    public var convertedFromValue : String!
    public var currency : String!
    public var value : String!
}

public struct EBPricingSummary: Decodable {
    public var deliveryCost : EBDeliveryCost!
    public var deliveryDiscount : EBDeliveryDiscount!
    public var priceSubtotal : EBPriceSubtotal!
    public var total : EBTotal!
}

public struct EBPrimaryPhone: Decodable {
    public var phoneNumber : String!
}

public struct EBProperty: Decodable {
    public var buyerProtection : Bool!
}

public struct EBRoot: Decodable {
    public var href : String!
    public var limit : Int!
    public var offset : Int!
    public var orders : [EBOrder]!
    public var total : Int!
}

public struct EBShippingCost: Decodable {
    public var convertedFromCurrency : String!
    public var convertedFromValue : String!
    public var currency : String!
    public var value : String!
}

public struct EBShippingStep: Decodable {
    public var shippingServiceCode : String!
    public var shipTo : EBShipTo!
}

public struct EBShipTo: Decodable {
    public var contactAddress : EBContactAddress!
    public var fullName : String!
    public var primaryPhone : EBPrimaryPhone!
    public var email: String!
}

public struct EBTotal: Decodable {
    public var convertedFromCurrency : String!
    public var convertedFromValue : String!
    public var currency : String!
    public var value : String!
}

public struct EBTotalDueSeller: Decodable {
    public var convertedFromCurrency : String!
    public var convertedFromValue : String!
    public var currency : String!
    public var value : String!
}
