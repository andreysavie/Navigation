//
//  FavoriteViewModel.swift
//  Navigation
//
//  Created by Андрей Рыбалкин on 13.07.2022.
//

import UIKit

final class FavoriteViewModel {
    
    public var favoritePosts = [
        
    Post(author: "habr",
                      title: "«Юрент» вошел в экосистему МТС",
                      description: "Сервис проката самокатов «Юрент» привлек более 2 млрд рублей от МТС и фондов VPE Capital и VEB в ходе последнего раунда финансирования. МТС вложила в сервис 740 млн рублей став лид-инвестором, фонд прямых инвестиций VPE Capital — 700 млн руб., венчурный фонд VEB Ventures — 650 млн руб. Об этом сообщает издание Inc.",
                      image: "post_3",
                      likes: 241,
                      views: 54430),
    Post(author: "Aleksey Truth",
                      title: "Кем пообедал древний крокодил?",
                      description: "Австралийские и американские палеонтологи впервые описали окаменелость крокодила, в брюшной полости которого, вот сюрприз, нашлись останки еды, то бишь динозавра. Как показало дальнейшее изучение, ученые имеют дело с ранее неописанным видом крокодиловидного мелового периода, которого они назвали убийцей динозавров — Confractosuchus sauroktonos.",
                      image: "post_4",
                      likes: 76,
                      views: 8965),
    Post(author: "Sergey Nepravda",
                      title: "27 февраля Samsung представит Galaxy Book",
                      description: "Издание Verge сообщает, что южнокорейская компания Samsung представит ноутбук Galaxy Book 27 февраля в рамках выставки мобильной индустрии Mobile World Congress. Трансляция мероприятия пройдет Samsung Newsroom и на канале компании в Youtube.",
                      image: "post_5",
                      likes: 20,
                      views: 2420)
]
    
    func numberOfRows() -> Int {
        return favoritePosts.count
    }
    
    func cellViewModel(forIndexPath indexPath: IndexPath) -> PostTableViewCellViewModel? {
        let post = favoritePosts[indexPath.row]
        return PostTableViewCellViewModel(post: post)
    }


}
