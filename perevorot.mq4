//+------------------------------------------------------------------+
//|                                     Для Гарэгин Диноян(mmgp).mq4 |
//|                              Copyright © 2013, MoneyInNetwork.ru |
//|                                         http://moneyinnetwork.ru |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2013, MoneyInNetwork.ru"
#property link      "http://moneyinnetwork.ru"
extern string s1 = "Объем для первой сделки серии, лот";
extern double Lot = 0.01;
extern string s2 = "Уровень стоп-лосса, пипсов";
extern double stoploss = 100;
extern string s3 = "Уровень тейк-профита, пипсов";
extern double takeprofit = 100;
extern string s4 = "Уникальная метка для ордеров, открываемых только этим советником";
extern double MagicNumber = 600;
extern string s5 = "Максимальное отклонение от запрошенной цены, пипсов";
extern double slip = 15;
 
int init()
{
   return(0);
}
 
int deinit()
{
   return(0);
}
 
int start()
{ 
  //инициализация параметров
  int ticket = 0;
  int old_order_type = OP_SELL;
 
  //ищем среди всех открытых ордеров открытый советником ордер 
  RefreshRates();
  for ( int trade = OrdersTotal() - 1; trade >= 0; trade-- ) 
  {
      //проверяем есть ли среди всех открытых ордеров именно тот ордер, который открыт данным советником.
      if ( OrderSelect(trade, SELECT_BY_POS, MODE_TRADES) && (OrderType() == OP_BUY || OrderType() == OP_SELL) && OrderMagicNumber() == MagicNumber && OrderSymbol() == Symbol() )
      {
          //если есть незакрытый ордер - выходим
          return (0);        
      }
  }
  //нет открытых ордеров - ищем в истории закрытых ордеров последний закрытый именно этим советником ордер 
  for ( trade = OrdersHistoryTotal() - 1; trade >= 0; trade-- ) 
  {
     if ( OrderSelect(trade, SELECT_BY_POS, MODE_HISTORY) && OrderMagicNumber() == MagicNumber && OrderSymbol() == Symbol() )
     {
         old_order_type = OrderType();
         if ( OrderProfit()<0 ) //последний закрытый советником ордер был убыточным, значит, следующий ордер открываем в направлении, противоположном закрытому с убытком
         {
                break; //прекращаем поиск
         }
     }
  }
  //если раньше покупали, то теперь продаем
  if ( old_order_type == OP_BUY )
  {
      ticket = OrderSend(Symbol(), OP_SELL, Lot,  NormalizeDouble(Bid, Digits), slip, NormalizeDouble(Ask+stoploss*Point, Digits), NormalizeDouble(Ask-takeprofit*Point, Digits), "Martingale-Sell", MagicNumber, 0, Red);
      Sleep (2000); //задержка в 2 секунды для обработки запроса торговым сервером брокера
      return (0);  
  }
  //если раньше продавали, то теперь покупаем
  if ( old_order_type == OP_SELL )
  {
      ticket = OrderSend(Symbol(), OP_BUY, Lot, NormalizeDouble(Ask, Digits), slip, NormalizeDouble(Bid-stoploss*Point, Digits), NormalizeDouble(Bid+takeprofit*Point, Digits), "Martingale-Buy", MagicNumber, 0, Green);
      Sleep (2000); //задержка в 2 секунды для обработки запроса торговым сервером брокера
      return (0);  
  }               
}  