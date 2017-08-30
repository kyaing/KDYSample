//
//  UIImage+Asset.swift
//  KDYWeChat
//
//  Created by mac on 16/12/20.
//  Copyright © 2016年 mac. All rights reserved.
//

import Foundation

typealias KYAsset = UIImage.AssetIdentifier

/// 统一管理图片
extension UIImage {

    enum AssetIdentifier: String {

        // Tabbar
        case TabChatNormal          = "tabbar_mainframe"
        case TabChatSelect          = "tabbar_mainframeHL"
        case TabContactsNormal      = "tabbar_contacts"
        case TabContactsSelect      = "tabbar_contactsHL"
        case TabDiscoverNormal      = "tabbar_discover"
        case TabDiscoverSelect      = "tabbar_discoverHL"
        case TabMeNormal            = "tabbar_me"
        case TabMeSelect            = "tabbar_meHL"
        
        case AvatarDefault          = "user_avatar"
        case MainBack               = "main_back"
        case AddFriends             = "barbuttonicon_add"

        // Chat
        case ChatRecording001       = "RecordingSignal001"
        case ChatRecording002       = "RecordingSignal002"
        case ChatRecording003       = "RecordingSignal003"
        case ChatRecording004       = "RecordingSignal004"
        case ChatRecording005       = "RecordingSignal005"
        case ChatRecording006       = "RecordingSignal006"
        case ChatRecording007       = "RecordingSignal007"
        case ChatRecording008       = "RecordingSignal008"

        case ChatSenderPlaying001   = "SenderVoiceNodePlaying001"
        case ChatSenderPlaying002   = "SenderVoiceNodePlaying002"
        case ChatSenderPlaying003   = "SenderVoiceNodePlaying003"
        case ChatReceiverPlaying001 = "ReceiverVoiceNodePlaying001"
        case ChatReceiverPlaying002 = "ReceiverVoiceNodePlaying002"
        case ChatReceiverPlaying003 = "ReceiverVoiceNodePlaying003"
        case ChatSenderPlaying      = "SenderVoiceNodePlaying"
        case ChatReceiverPlaying    = "ReceiverVoiceNodePlaying"

        case ChatFreindInfo         = "barbuttonicon_InfoSingle"
        case ChatMessageSendFail    = "messageSendFail"

        case ChatSenderBgNormal     = "SenderTextNodeBkg"
        case ChatSenderBgSelect     = "SenderTextNodeBkgHL"
        case ChatReceiverBgNormal   = "ReceiverTextNodeBkg"
        case ChatReceiverBgSelect   = "ReceiverTextNodeBkgHL"

        case ChatKeyboardNormal     = "tool_keyboard_1"
        case ChatKeyboardSelect     = "tool_keyboard_2"
        case ChatVoiceNormal        = "tool_voice_1"
        case ChatVoiceSelect        = "tool_voice_2"
        case ChatEmotionNormal      = "tool_emotion_1"
        case ChatEmotionSelect      = "tool_emotion_2"
        case ChatShareNormal        = "tool_share_1"
        case ChatShareSelect        = "tool_share_2"

        // Contacts
        case ContactsAddfreind      = "barbuttonicon_addfriends"
        case ContactsFriend         = "plugins_FriendNotify"
        case ContactsAddGround      = "add_friend_icon_addgroup"
        case ContactsOffical        = "add_friend_icon_offical"

        // Discover
        case DiscoverAlbumHolder    = "place_holder_album"
        case DiscoverLive           = "ff_IconLocationService"
        case DiscoverQRCode         = "ff_IconQRCode"
        case DiscoverAlubm          = "ff_IconShowAlbum"
        case DiscoverAlubmCamera    = "barbuttonicon_Camera"

        // Me
        case MeMyAlbum              = "MoreMyAlbum"
        case MeMyFavorites          = "MoreMyFavorites"
        case MeMyBankCard           = "MoreMyBankCard"
        case MeCardPackageIcon      = "MyCardPackageIcon"
        case MeExpressionShops      = "MoreExpressionShops"
        case MeSetting              = "MoreSetting"

        var image: UIImage? {
            return UIImage(assetIdentifier: self)
        }
    }

    convenience init?(assetIdentifier: AssetIdentifier) {
        self.init(named: assetIdentifier.rawValue)
    }
}

