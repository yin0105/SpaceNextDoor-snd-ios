//
//  Ext+EmptyView.swift
//  WeFresh-iOS
//
//  Created by PacoKe on 2020/3/23.
//  Copyright © 2020 Watthanai Chotcheewasunthorn. All rights reserved.
//

import Foundation
import UIKit
import LYEmptyView


extension LYEmptyView {

    //MARK: Profile Setting
    enum EmptyType: Int {
        case EmptyAddress  = 0
        case EmptyOrderHistory = 1
        case EmptyOrderGoing = 2
        case EmptySearch = 3
        case EmptyFound = 4
        case EmptyCoupons = 5
        case EmptyCart = 6
        case EmptyProducts = 7
        case EmptyPayment = 8
        
        func emptyActionView(_ btnClickBlock: LYActionTapBlock!) -> LYEmptyView {
            let tmp : LYEmptyView
            switch self {
            case .EmptyAddress:
                tmp = LYEmptyView.emptyActionView(with: WFImages.imgEmptyAddresses.image,
                                                  titleStr: WFStrings.noSavedAddressYet,
                                                  detailStr: WFStrings.youHaveNotSavedAnyLocationYet,
                                                  btnTitleStr: WFStrings.addressAddNow.uppercased(),
                                                  btnClick: {
                                                    btnClickBlock!()})
            case .EmptyOrderHistory:
                tmp = LYEmptyView.emptyActionView(with: WFImages.imgEmptyOrder.image,
                                                  titleStr: WFStrings.noOrderHistory,
                                                  detailStr: WFStrings.onceYourOrderHaveBeenCompletedYouCanViewYourOrderDetailsAndReorderHere,
                                                  btnTitleStr: WFStrings.startShoppingNow.uppercased(),
                                                  btnClick: {
                                                    btnClickBlock!()})
            case .EmptyOrderGoing:
                tmp = LYEmptyView.emptyActionView(with: WFImages.imgEmptyOrder.image,
                                                  titleStr: WFStrings.noOngoingOrderNow,
                                                  detailStr: WFStrings.onceYouPlaceAnOrderYouCanViewYourOrderDetailsAndTrackYourOrderHere,
                                                  btnTitleStr: WFStrings.startShoppingNow.uppercased(),
                                                  btnClick: {
                                                    btnClickBlock!()})
            case .EmptyFound:
                tmp = LYEmptyView.emptyActionView(with: WFImages.imgNoProduct.image,
                                                  titleStr: WFStrings.notFound,
                                                  detailStr: WFStrings.noMatchingProductPleaseCheckSpellingAndTryAgain,
                                                  btnTitleStr: WFStrings.EmptyFound.searchNow.uppercased(),
                                                  btnClick: {
                                                    btnClickBlock!()})
            case .EmptySearch:
                tmp = LYEmptyView.emptyActionView(with: WFImages.imgEmpty.image,
                                                  titleStr: WFStrings.notSearchYet,
                                                  detailStr: WFStrings.pleaseTypeYourKeywordInTheSearchBoxToFindYourItem,
                                                  btnTitleStr: WFStrings.EmptySearch.searchNow.uppercased(),
                                                  btnClick: {
                                                    btnClickBlock!()})

            case .EmptyCoupons:
                tmp = LYEmptyView.emptyActionView(with: WFImages.imgEmptyCoupon.image,
                                                  titleStr: WFStrings.stayTuneForCoupons,
                                                  detailStr: WFStrings.emptyCouponsStatus,
                                                  btnTitleStr: WFStrings.continueShopping.uppercased(),
                                                  btnClick: {
                                                    btnClickBlock!()})
                tmp.contentViewOffset +=  IS_IPHONE_X ? STATUS_NAV_BAR_Y : 120
            case .EmptyCart:
                tmp = LYEmptyView.emptyActionView(with: WFImages.imgEmptyCart.image,
                                                  titleStr: WFStrings.yourCartIsEmpty,
                                                  detailStr: WFStrings.YouHavenTAddedAnythingToYourCartYet.startShoppingAndAddItemsNow,
                                                  btnTitleStr: WFStrings.continueShopping.uppercased(),
                                                  btnClick: {
                                                    btnClickBlock!()})
            case .EmptyProducts:
                tmp = LYEmptyView.emptyActionView(with: WFImages.imgEmptyProduct.image,
                                                  titleStr: WFStrings.noProducts,
                                                  detailStr: "",//Language.myLocalizedString(key:"This is description up to 2 line \nthis is description up to 2 line"),
                                                  btnTitleStr: WFStrings.tryAgain.uppercased(),
                                                  btnClick: {
                                                    btnClickBlock!()})
            case .EmptyPayment:
                tmp = LYEmptyView.emptyActionView(with: WFImages.imgEmpty.image,
                                                  titleStr: WFStrings.noSavedPaymentYet,
                                                  detailStr: WFStrings.youHaveNotAddedAnyPaymentMethodsYet,
                                                  btnTitleStr: WFStrings.paymentAddNow.uppercased(),
                                                  btnClick: {
                                                    btnClickBlock!()})
            }
            tmp.detailLabMaxLines = 3
            tmp.titleLabFont = Font.bd2.font
            tmp.titleLabTextColor = .trout
            tmp.detailLabFont = Font.bd1.font
            tmp.actionBtnBackGroundColor = UIColor.buttonBlue.withAlphaComponent(0.3)
            tmp.actionBtnTitleColor = UIColor.buttonBlue
            tmp.actionBtnWidth = SCREEN_WIDTH * 0.7
            tmp.actionBtnHeight = 50
            tmp.actionBtnCornerRadius = 10
            tmp.actionBtnFont = Font.bd1.font

            return tmp
        }
    }
}
