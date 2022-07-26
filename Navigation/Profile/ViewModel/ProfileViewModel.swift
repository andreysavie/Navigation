//
//  ProfileModel.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 12.05.2022.
//

import Foundation
import UIKit

final class ProfileViewModel {
    
    public var posts = [
        
        Post(
            author: "Jorge Mickael",
            title: "В работе Telegram произошёл сбой",
            description: "По состоянию на 17.57 мск было зафиксировано 233 жалобы: 54% пользователей жалуется на проблемы с подключением к серверу, 24% - на неполадки в работе приложения, еще 21% - на проблемы с отправкой сообщений.",
            image: UIImage(named: "post_1")!,
            likes: 213,
            views: 40443, personalID: "82DFCFE5-AEB2-4339-82D8-E23EDD3B9EC6"),
        Post(
            author: "Anna Egorova",
            title: "Приложение соцсети Трампа запустили в App Store",
            description: "В онлайн-магазине App Store разместили приложение соцсети бывшего американского президента Дональда Трампа Truth Social. Приложение можно скачать, однако пока в нем можно только зарегистрироваться: остальные функции не работают, сообщает телеканал 360",
            image: UIImage(named: "post_2")!,
            likes: 112,
            views: 32300, personalID: "f2D0A1FD6-BBF5-4E2F-AC27-D5657930A7E4"),
        Post(
            author: "Sergey Nepravda",
            title: "«Юрент» вошел в экосистему МТС",
            description: "Сервис проката самокатов «Юрент» привлек более 2 млрд рублей от МТС и фондов VPE Capital и VEB в ходе последнего раунда финансирования. МТС вложила в сервис 740 млн рублей став лид-инвестором, фонд прямых инвестиций VPE Capital — 700 млн руб., венчурный фонд VEB Ventures — 650 млн руб. Об этом сообщает издание Inc.",
            image: UIImage(named: "post_3")!,
            likes: 241,
            views: 54430, personalID: "B6249399-C405-47C7-8AAE-A9D8047CA373"),
        Post(
            author: "Kim Yan",
            title: "Кем пообедал древний крокодил?",
            description: "Австралийские и американские палеонтологи впервые описали окаменелость крокодила, в брюшной полости которого, вот сюрприз, нашлись останки еды, то бишь динозавра. Как показало дальнейшее изучение, ученые имеют дело с ранее неописанным видом крокодиловидного мелового периода, которого они назвали убийцей динозавров — Confractosuchus sauroktonos.",
            image: UIImage(named: "post_4")!,
            likes: 76,
            views: 8965, personalID: "47ED6624-2FF8-4D4F-BCE5-611ACD399159"),
        Post(
            author: "Sendy Leeket",
            title: "27 февраля Samsung представит Galaxy Book",
            description: "Издание Verge сообщает, что южнокорейская компания Samsung представит ноутбук Galaxy Book 27 февраля в рамках выставки мобильной индустрии Mobile World Congress. Трансляция мероприятия пройдет Samsung Newsroom и на канале компании в Youtube.",
            image: UIImage(named: "post_5")!,
            likes: 20,
            views: 2420, personalID: "2BFA79CD-FD73-49BD-9DA9-0C14655E8D80")
    ]
    
    func numberOfRows() -> Int {
        return posts.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> PostTableViewCellViewModel? {
        let post = posts[indexPath.row]
        return PostTableViewCellViewModel(post: post)
    }
}
