int tik1,tik2;
extern double lot_sell,lot_buy;
extern double tp = 250;//a
extern double sl = -1500;
int  Magic_sell= 101001;
int  Magic_buy= 101002;
static datetime lastbar;
extern double minus_all,minis_this;
int ticket2_buy=5555555555555;
int ticket2_sell=5555555555555;
extern double kolvo_buy,kolvo_sell; 


int init()
{
return(0);
lastbar=Time[Bars-1];
}

int start()
{

int ticket_sell = Last_sell();
if (!ticket_sell);lot_sell = 0.01;
if (OrderSelect(ticket_sell, SELECT_BY_TICKET, MODE_HISTORY));

if (OrderProfit() < 0)
   {

   lot_sell = OrderLots()*7;
   
   }

if (OrderProfit() > 0)
   {

   lot_sell = 0.01;

   }
   
//===================================================
int ticket_buy = Last_buy();
if (!ticket_buy);lot_buy = 0.01;
if (OrderSelect(ticket_buy, SELECT_BY_TICKET, MODE_HISTORY));

if (OrderProfit() < 0)
   {

   lot_buy = OrderLots()*7;
   
   }

if (OrderProfit() > 0)
   {
   lot_buy = 0.01;
   }



//Comment("kolvo- ",kolvo,"       minus- ",minus,"        тикет- ",GetLastOrderHist()," " );


if (Time[0]>lastbar)
{
lastbar=Time[0]; 

Print("-------------------------------minus- ",kolvo_sell);

if(Ask-Bid < 10*Point){ 
if(Hour()==0){


if(CountBuy()==0){tik1 = OrderSend(Symbol(), OP_BUY, lot_buy, Ask, 3, Ask+sl*Point, Ask+tp*Point,"Buy2" ,Magic_buy);}
if(CountSell()==0){tik2 = OrderSend(Symbol(), OP_SELL, lot_sell, Bid, 3, Bid-sl*Point, Bid-tp*Point, "Close2", Magic_sell);}
       
 }
 }
 }     
 }        

     






  
  
int Last_sell(int type = -1) 
{
int ticket = -1;
datetime dt = 0;
int cnt = HistoryTotal();

for (int i=0; i < cnt; i++) {
if (!OrderSelect(i, SELECT_BY_POS, MODE_HISTORY)) continue;

if (OrderMagicNumber() != Magic_sell) continue;
if (type != -1 && OrderType() != type) continue;
if (OrderType()==OP_BUY || OrderType()==OP_SELL) {
if (OrderCloseTime() > dt) {
dt = OrderCloseTime();
ticket = OrderTicket();
}
}
}
return (ticket);
}

int Last_buy(int type = -1) 
{
int ticket = -1;
datetime dt = 0;
int cnt = HistoryTotal();

for (int i=0; i < cnt; i++) {
if (!OrderSelect(i, SELECT_BY_POS, MODE_HISTORY)) continue;

if (OrderMagicNumber() != Magic_buy) continue;
if (type != -1 && OrderType() != type) continue;
if (OrderType()==OP_BUY || OrderType()==OP_SELL) {
if (OrderCloseTime() > dt) {
dt = OrderCloseTime();
ticket = OrderTicket();
}
}
}
return (ticket);
}


int CountSell()
  {
   int count=0;
   for(int trade=OrdersTotal()-1;trade>=0; trade--)
     {
      OrderSelect(trade,SELECT_BY_POS,MODE_TRADES);
      if(OrderMagicNumber()==Magic_sell)
        {
         if(OrderType()==OP_SELL)
            count++;
        }
     }

   return(count);
}



int CountBuy()
  {
   int count=0;
   for(int trade=OrdersTotal()-1;trade>=0; trade--)
     {
      OrderSelect(trade,SELECT_BY_POS,MODE_TRADES);
      if(OrderMagicNumber()==Magic_buy)
        {
         if(OrderType()==OP_BUY)
            count++;
        }
     }

   return(count);
}