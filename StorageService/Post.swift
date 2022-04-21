//
//  Post.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 21.02.2022.
//

import Foundation
import UIKit

public struct Post {
    
    public var author: String
    public var title: String
    public var description: String
    public var image: String
    public var likes: Int
    public var views: Int
}
    
let post_1 = Post(author: "Sergey Smirnov",
                  title: "В работе Telegram произошёл сбой",
                  description: "По состоянию на 17.57 мск было зафиксировано 233 жалобы: 54% пользователей жалуется на проблемы с подключением к серверу, 24% - на неполадки в работе приложения, еще 21% - на проблемы с отправкой сообщений.",
                  image: "post_1",
                  likes: 213,
                  views: 40443)

let post_2 = Post(author: "RIA NEWS",
                  title: "Приложение соцсети Трампа запустили в App Store",
                  description: "В онлайн-магазине App Store разместили приложение соцсети бывшего американского президента Дональда Трампа Truth Social. Приложение можно скачать, однако пока в нем можно только зарегистрироваться: остальные функции не работают, сообщает телеканал 360",
                  image: "post_2",
                  likes: 112,
                  views: 32300)

let post_3 = Post(author: "habr",
                  title: "«Юрент» вошел в экосистему МТС",
                  description: "Сервис проката самокатов «Юрент» привлек более 2 млрд рублей от МТС и фондов VPE Capital и VEB в ходе последнего раунда финансирования. МТС вложила в сервис 740 млн рублей став лид-инвестором, фонд прямых инвестиций VPE Capital — 700 млн руб., венчурный фонд VEB Ventures — 650 млн руб. Об этом сообщает издание Inc.",
                  image: "post_3",
                  likes: 241,
                  views: 54430)

let post_4 = Post(author: "Aleksey Truth",
                  title: "Кем пообедал древний крокодил?",
                  description: "Австралийские и американские палеонтологи впервые описали окаменелость крокодила, в брюшной полости которого, вот сюрприз, нашлись останки еды, то бишь динозавра. Как показало дальнейшее изучение, ученые имеют дело с ранее неописанным видом крокодиловидного мелового периода, которого они назвали убийцей динозавров — Confractosuchus sauroktonos.",
                  image: "post_4",
                  likes: 76,
                  views: 8965)

let post_5 = Post(author: "Sergey Nepravda",
                  title: "27 февраля Samsung представит Galaxy Book",
                  description: "Издание Verge сообщает, что южнокорейская компания Samsung представит ноутбук Galaxy Book 27 февраля в рамках выставки мобильной индустрии Mobile World Congress. Трансляция мероприятия пройдет Samsung Newsroom и на канале компании в Youtube.",
                  image: "post_5",
                  likes: 20,
                  views: 2420)

public var posts: [Post] = [post_1, post_2, post_3, post_4, post_5]
