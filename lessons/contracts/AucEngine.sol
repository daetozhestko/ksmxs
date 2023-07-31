// По просьбам зрителей, предлагаю решить следующую задачу. 
// Сделать контракт-аукцион (по принципу "английский аукцион", то есть когда нужно делать всё более и более высокие ставки, перебивая другие).
//  При развёртывании контракта указываем название товара, изначальную цену и адрес продавца (кому потом деньги начислять). 
// Продавец может быть владельцем контракта. Затем сделать функцию "ставка", которая принимает определённую сумму денег от потенциального покупателя. 
// Ставка должна быть больше текущей цены, тк суть аукциона в том, чтобы "перебить" ставку другого. 
// Аукцион может закончиться либо по какому-то условию, либо если продавец вызвал функцию "закончить", либо по какому-то ещё принципу. 
// В этот момент больше ставок уже делать нельзя, а продавец получает свои деньги. Нужно подумать также о том, что люди, чьи ставки "перебили", должны иметь возможность забрать деньги обратно. 
// В идеале, написать для этого контракта тесты. В одном из следующих уроков, возможно, посмотрим, как это сделать.

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
 contract AucEngine {
    address public owner;
    uint constant DURATION = 2 days;
    // immutable
    uint constant FEE =10;
    struct Auction{
        address payable seller;
        uint startingPrice;
        uint finalPrice;
        uint startAt;
        uint endsAt;
        uint discountRate;
        string item;
        bool stopped;
    }

    Auction [] public auctions;

    event AuctionCreated(uint index,string itemName, uint startingPrice, uint  duration);
    event AuctionEnded(uint index, uint finalPrice,address winner);

    constructor() {
        owner =msg.sender;
    }
    
    function createAuction(uint _startingPrice,uint _discountRate,string memory _item, uint _duration) external{
        uint duration =_duration == 0 ? DURATION : _duration;

        require(_startingPrice >= _discountRate * duration,"Incorrect satring  price");

        Auction memory newAuction =Auction({
            seller: payable(msg.sender),
            startingPrice: _startingPrice,
            finalPrice: _startingPrice,
            startAt: block.timestamp,
            endsAt: block.timestamp + duration,
            discountRate: _discountRate,
            item: _item,
            stopped: false
        });

        auctions.push(newAuction);

        emit AuctionCreated(auctions.length -1 ,_item, _startingPrice, duration);

    }

    function getPriceFor(uint index) public view returns(uint){
        Auction memory cAuction =auctions[index];
        require(!cAuction.stopped,"stopped!");
        uint elaplsed = block.timestamp-cAuction.startAt;
        uint discount = cAuction.discountRate*elaplsed;
        return cAuction.startingPrice -discount;
    }

    function buy(uint index) external payable{
        Auction storage   cAuction =auctions[index];
        require(!cAuction.stopped,"stopped!");
        require(block.timestamp < cAuction.endsAt,"ended!");
        uint cPrice =getPriceFor(index);
        require(msg.value>= cPrice,"not enough funds!");
        cAuction.stopped =true;
        cAuction.finalPrice = cPrice;
        uint refund =msg.value -cPrice;
        if(refund>0){
            payable(msg.sender).transfer(refund);
        }
        cAuction.seller.transfer(
            cPrice -((cPrice * FEE)/100)
        );
        emit AuctionEnded(index,cPrice,msg.sender);
    }
 }

