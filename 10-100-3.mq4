int tik1,tik2;
extern double lot;
extern double tp = 150;//550
extern double sl = -1500;
int  Magic = 10100;
static datetime lastbar;
extern double minus_all,minis_this;
int ticket2=5555555555555;
extern double kolvo = 0; 


int init()
{
return(0);
lastbar=Time[Bars-1];
}

int start()
{

int ticket = Last();
if (!ticket);lot = 0.05;
if (OrderSelect(ticket, SELECT_BY_TICKET, MODE_HISTORY));

if (OrderProfit() < 0 && ticket2!=ticket)
   {ticket2=ticket;
   kolvo=1;
   minus_all=1000-(1000+OrderProfit());
   lot = 0.05;
   
   }

if (OrderProfit() > 0 && ticket2!=ticket)
   {
   //if(kolvo>0){lot_buy = 0.04;kolvo=kolvo-1;}
   lot = 0.05;
   minus_all=0;
   }



//Comment("kolvo- ",kolvo,"       minus- ",minus,"        тикет- ",GetLastOrderHist()," " );


if (Time[0]>lastbar)
{
lastbar=Time[0]; 

 Print("-------------------------------minus- ",minus_all);

if(Ask-Bid < 10*Point){ 
if(Hour()==0){

 if(kolvo>0){lot = 0.5;kolvo=kolvo-1;}
//if(minus_all>50){lot = 0.35;}

if(CountBuy()==0){tik1 = OrderSend(Symbol(), OP_BUY, lot, Ask, 3, Ask+sl*Point, Ask+tp*Point,"Buy2" ,Magic);}
if(CountSell()==0){tik2 = OrderSend(Symbol(), OP_SELL, lot, Bid, 3, Bid-sl*Point, Bid-tp*Point, "Close2", Magic);}
       
 }
 }
 }           
 }        

     






  
  
int Last(int type = -1) 
{
int ticket = -1;
datetime dt = 0;
int cnt = HistoryTotal();

for (int i=0; i < cnt; i++) {
if (!OrderSelect(i, SELECT_BY_POS, MODE_HISTORY)) continue;

if (OrderMagicNumber() != Magic) continue;
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
      if(OrderMagicNumber()==Magic)
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
      if(OrderMagicNumber()==Magic)
        {
         if(OrderType()==OP_BUY)
            count++;
        }
     }

   return(count);
}