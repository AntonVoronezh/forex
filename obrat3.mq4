//+------------------------------------------------------------------+
//|                                        
//|                              Copyright © 2018, ANTON
//|                                         
//+------------------------------------------------------------------+
int tik1,tik2,tik3,tik4;
static datetime lastbar;
extern double lot=0.25;
extern double lot2=0.75;
int Magic= 111;
int Magic2= 222;
extern double old_loss,old_open;
 
int init()
{
lastbar=Time[Bars-1];
   return(0);
}
 
int deinit()
{
   return(0);
}
 
int start()
{ 
/////////////////////////////////////////////////////////////////////////////////////////////
if (Time[0]>lastbar)
{
lastbar=Time[0]; 
datetime exp = CurTime() + 86400;//60*60*24*5

tik1 = OrderSend(Symbol(), OP_SELLLIMIT, lot, iOpen(NULL,PERIOD_D1,0)+200*Point, 3, iOpen(NULL,PERIOD_D1,0)+800*Point, iOpen(NULL,PERIOD_D1,0)+1*Point, "Open",Magic,exp);
tik2 = OrderSend(Symbol(), OP_BUYLIMIT, lot, iOpen(NULL,PERIOD_D1,0)-200*Point, 3, iOpen(NULL,PERIOD_D1,0)-800*Point, iOpen(NULL,PERIOD_D1,0)-1*Point, "Open", Magic,exp);

}
/////////////////////////////////////////////////////////////////////////////////////////////
  //инициализация параметров
  bool flag = false;
  int ticket = 0;
 // double lots = lot;
  int old_order_type;
  //int old_order_type = -1;
 datetime dt = 0;
  //ищем среди всех открытых ордеров открытый советником ордер 
  RefreshRates();
  for ( int trade = OrdersTotal() - 1; trade >= 0; trade-- ) 
  {
      //проверяем есть ли среди всех открытых ордеров именно тот ордер, который открыт данным советником.
      //ВНИМАНИЕ! MagicNumber - должен быть свой для каждого советника!
      if ( OrderSelect(trade, SELECT_BY_POS, MODE_TRADES) && (OrderType() == OP_BUY || OrderType() == OP_SELL) && OrderMagicNumber() == Magic)
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
     if ( OrderSelect(trade, SELECT_BY_POS, MODE_HISTORY) && OrderMagicNumber() == Magic && OrderType() == OP_BUY || OrderType() == OP_SELL )
     {if (OrderCloseTime() > dt) {dt = OrderCloseTime();
         if ( OrderProfit()<0 ) //lots = lot;   //последний закрытый советником ордер был прибыльным или безубыточным, значит, следующий ордер открываем с начальным объемом
                    //else lots = 2*OrderLots(); //последний закрытый советником ордер был убыточным, значит, следующий ордер открываем удвоенным объемом
                old_loss = OrderStopLoss();
                old_open = OrderOpenPrice();
                old_order_type = OrderType(); //запоминаем тип ордера - прокупка или продажа.
                flag = true;
                break; //прекращаем поиск
     }}
     //if (!OrderSelect(ticket, SELECT_BY_TICKET, MODE_HISTORY)) return (0);
  }Print(OrderProfit());
  if ( !flag )  return (0);
   //   old_order_type = OP_BUY; //в истории нет ордеров открытых этим советников, значит, стартуем с покупок
  //если раньше покупали, то теперь продаем
  if ( old_order_type == OP_BUY )
  {
      tik3 = OrderSend(Symbol(), OP_SELL, lot2, NormalizeDouble(Bid, Digits), 3, Bid+600*Point, Bid-200*Point, "Open",Magic,0);
      //ticket = OrderSend(Symbol(), OP_SELL, NormalizeDouble(lots,2),  NormalizeDouble(Bid, Digits), slip, NormalizeDouble(Ask+stoploss*Point, Digits), NormalizeDouble(Ask-takeprofit*Point, Digits), "Martingale-Sell", Magic, 0, Red);
      Sleep (1000); //задержка в одну секунду для обрабатки запроса торговым сервером брокера
      return (0);  
  }
  //если раньше продавали, то теперь покупаем
  if ( old_order_type == OP_SELL )
  {
      tik3 = OrderSend(Symbol(), OP_BUY, lot2, NormalizeDouble(Ask, Digits), 3, Ask-600*Point, Ask+200*Point, "Open",Magic,0);
      //ticket = OrderSend(Symbol(), OP_BUY, NormalizeDouble(lots,2), NormalizeDouble(Ask, Digits), slip, NormalizeDouble(Bid-stoploss*Point, Digits), NormalizeDouble(Bid+takeprofit*Point, Digits), "Martingale-Buy", Magic, 0, Green);
      Sleep (1000); //задержка в одну секунду для обрабатки запроса торговым сервером брокера
      return (0);  
  }               
  return (0);  
  }