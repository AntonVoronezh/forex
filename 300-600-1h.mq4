int tik1,tik2;
 extern double lot=0.01;
extern double open = 10;//300-350
extern double tp = 20;//550
extern double sl = 1;
extern double hod = 0.1;
extern double lot_new; 
int Magic= 300600;
static datetime lastbar;
extern double kolvo = 0; 
int ticket2=5555555555555;
extern double minus =0;
extern double m_l_1,m_l_2,m_l_3,m_l_4,m_l_5,m_l_6,m_l_7,m_l_8,m_l_9; 
extern double nedelya = 1.00001;
double chas_1,chas_2;

int init()
{
return(0);
lastbar=Time[Bars-1];
}

int start()
{
///*
int ticket = GetLastOrderHist();
if (!ticket);lot = 0.01;
if (OrderSelect(ticket, SELECT_BY_TICKET, MODE_HISTORY));
if (OrderProfit() < 0){
if (ticket2!=ticket)
kolvo=kolvo+1;ticket2=ticket;

minus=minus+(1000-(1000+OrderProfit()));
          
//
lot = 0.01+kolvo*0.01;


//lot = NormalizeDouble((minus/100)/hod,2);
}
if (OrderProfit() > 0)
{kolvo=0;minus=0;}





Comment("kolvo- ",kolvo,"       minus- ",minus,"        тикет- ",GetLastOrderHist()," " );

TrailingPositions();

int a=OrdersTotal();
for (int f=a-1; f>=0; f--)
{
if(OrderSelect(f,SELECT_BY_POS,MODE_TRADES))
if (OrderMagicNumber() != Magic) continue;
if(OrderCloseTime()==0) 
if(lot!=OrderLots())OrderDelete(OrderTicket());
      if (OrderType()==OP_SELL)
      {//OrderClose( OrderTicket(), OrderLots(), MarketInfo(OrderSymbol(), MODE_ASK), 5, Red );
      }
            if (OrderType()==OP_BUY)
      {//OrderClose( OrderTicket(), OrderLots(), MarketInfo(OrderSymbol(), MODE_BID), 5, Red );
      }
}



if (Time[0]>lastbar)
{
lastbar=Time[0]; 
datetime exp = CurTime() + 3600;//86400

int aa=OrdersTotal();
for (int ff=aa-1; ff>=0; ff--)
{
if(OrderSelect(ff,SELECT_BY_POS,MODE_TRADES))
if (OrderMagicNumber() != Magic) continue;
if(OrderCloseTime()==0) 
if(lot!=OrderLots()){
      if (OrderType()==OP_SELL)
      {//OrderClose( OrderTicket(), OrderLots(), MarketInfo(OrderSymbol(), MODE_ASK), 5, Red );
      }
            if (OrderType()==OP_BUY)
      {//OrderClose( OrderTicket(), OrderLots(), MarketInfo(OrderSymbol(), MODE_BID), 5, Red );
      }}
}

//if(kolvo<5){chas_1=9;chas_2=12;}
//if(kolvo>5){chas_1=7;chas_2=22;}

if(Ask-Bid < 10*Point){ Print(kolvo);
//if(Hour()>chas_1 && Hour()<chas_2){
//if(Hour()>7 && Hour()<9){
if(CountBuy()==0){tik1 = OrderSend(Symbol(), OP_BUYSTOP, lot, iOpen(NULL,PERIOD_H1,0)+open*Point, 3, iOpen(NULL,PERIOD_H1,0)+sl*Point, iOpen(NULL,PERIOD_H1,0)+tp*Point, "Open",Magic,exp);}
if(CountSell()==0){tik2 = OrderSend(Symbol(), OP_SELLSTOP, lot, iOpen(NULL,PERIOD_H1,0)-open*Point, 3, iOpen(NULL,PERIOD_H1,0)-sl*Point, iOpen(NULL,PERIOD_H1,0)-tp*Point, "Open", Magic,exp);}
         // }
}
 }           
 } 







//////////////////////////////////////////////////////////////////////////////////////

void TrailingPositions() 
{
/*
MinProfit - когда профит достигает указанное количество пунктов, трейлинг начинает работу
TrailingStop - величина трала
TrailingStep - шаг
l - префикс для лонгов
s - префикс для шортов
*/
 bool UseTrailing = true;
 int lMinProfit = 1;
 int sMinProfit = 1;
 int lTrailingStop = 300;
 int sTrailingStop = 300;
 int lTrailingStep = 100;
 int sTrailingStep = 100;


int cnt = OrdersTotal();

for (int i=0; i<cnt; i++) {
if (!(OrderSelect(i, SELECT_BY_POS, MODE_TRADES))) continue;
if (OrderSymbol() != Symbol()) continue; 
if (OrderMagicNumber() != Magic) continue;

if (OrderType() == OP_BUY) {
if (Bid-OrderOpenPrice() > lMinProfit*Point) {
if (OrderStopLoss() < Bid-(lTrailingStop+lTrailingStep-1)*Point) {
OrderModify(OrderTicket(), OrderOpenPrice(), Bid-lTrailingStop*Point, OrderTakeProfit(), 0, Blue);
}
}
}

if (OrderType() == OP_SELL) {
if (OrderOpenPrice()-Ask > sMinProfit*Point) {
if (OrderStopLoss() > Ask+(sTrailingStop+sTrailingStep-1)*Point || OrderStopLoss() == 0) {
OrderModify(OrderTicket(), OrderOpenPrice(), Ask+sTrailingStop*Point, OrderTakeProfit(), 0, Blue);
}
}
}
}

}



int GetLastOrderHist(int type = -1) 
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



int CountBuy()
  {
   int count=0;
   for(int trade=OrdersTotal()-1;trade>=0; trade--)
     {
      OrderSelect(trade,SELECT_BY_POS,MODE_TRADES);
      if(OrderMagicNumber()==Magic)
        {
         if(OrderType()==OP_BUY || OrderType()==OP_BUYSTOP)
            count++;
        }
     }
   return(count);
  }
//============== Считаем селл-ордера =============== 
int CountSell()
  {
   int count=0;
   for(int trade=OrdersTotal()-1;trade>=0; trade--)
     {
      OrderSelect(trade,SELECT_BY_POS,MODE_TRADES);
      if(OrderMagicNumber()==Magic)
        {
         if(OrderType()==OP_SELL || OrderType()==OP_SELLSTOP)
            count++;
        }
     }

   return(count);
}