extern double Lot = 0.01;
extern double stoploss = 500;
extern double takeprofit = 500;
extern double MagicNumber;
extern double slip = 3;
 
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
MagicNumber = DayOfYear();
 
  //инициализация параметров
  bool flag = false;
  int ticket = 0;
  double lots = Lot;
  int old_order_type = -1;
 
  //ищем среди всех открытых ордеров открытый советником ордер 
  RefreshRates();
  for ( int trade = OrdersTotal() - 1; trade >= 0; trade-- ) 
  {
      //проверяем есть ли среди всех открытых ордеров именно тот ордер, который открыт данным советником.
      //ВНИМАНИЕ! MagicNumber - должен быть свой для каждого советника!
      if ( OrderSelect(trade, SELECT_BY_POS, MODE_TRADES) && (OrderType() == OP_BUY || OrderType() == OP_SELL) && OrderMagicNumber() == MagicNumber && OrderSymbol() == Symbol() )
      {
            flag = true; //значение флага наличия ордера - ордер открыт
            break; //закончим поиск
      }        
  }
  //ордер советником открыт - выходим без действий, ожидая его закрытия по тейк профиту или стоп лоссу.
  if ( flag )
  {
      return (0);
  }
  //нет открытых ордеров - ищем в истории закрытых ордеров последний закрытый именно этим советником ордер 
  flag = false;
  for ( trade = OrdersHistoryTotal() - 1; trade >= 0; trade-- ) 
  {
     if ( OrderSelect(trade, SELECT_BY_POS, MODE_HISTORY) && OrderMagicNumber() == MagicNumber && OrderSymbol() == Symbol() )
     {
         if ( OrderProfit()>=0 ) lots = Lot;   //последний закрытый советником ордер был прибыльным или безубыточным, значит, следующий ордер открываем с начальным объемом
                    else lots = 5*OrderLots(); //последний закрытый советником ордер был убыточным, значит, следующий ордер открываем удвоенным объемом
                old_order_type = OrderType(); //запоминаем тип ордера - прокупка или продажа.
                flag = true;
                break; //прекращаем поиск
     }
  }
  if ( !flag ) 
      old_order_type = OP_BUY; //в истории нет ордеров открытых этим советников, значит, стартуем с покупок
  //если раньше покупали, то теперь продаем
  if ( old_order_type == OP_BUY )
  {
      ticket = OrderSend(Symbol(), OP_SELL, NormalizeDouble(lots,2),  NormalizeDouble(Bid, Digits), slip, NormalizeDouble(Ask+stoploss*Point, Digits), NormalizeDouble(Ask-takeprofit*Point, Digits), "Martingale-Sell", MagicNumber, 0, Red);
      Sleep (1000); //задержка в одну секунду для обрабатки запроса торговым сервером брокера
      return (0);  
  }
  //если раньше продавали, то теперь покупаем
  if ( old_order_type == OP_SELL )
  {
      ticket = OrderSend(Symbol(), OP_BUY, NormalizeDouble(lots,2), NormalizeDouble(Ask, Digits), slip, NormalizeDouble(Bid-stoploss*Point, Digits), NormalizeDouble(Bid+takeprofit*Point, Digits), "Martingale-Buy", MagicNumber, 0, Green);
      Sleep (1000); //задержка в одну секунду для обрабатки запроса торговым сервером брокера
      return (0);  
  }               
  return (0); 
  
  } 