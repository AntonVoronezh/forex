int tik1,tik2;
 extern double lot=0.01;
extern double open = 150;//300-350
extern double tp = 300;//550
extern double sl = 1.5;
extern double hod = 0.75;
extern double lot_new; 
int Magic= 300600;
static datetime lastbar;
extern double kolvo = 0; 
int ticket2=5555555555555;
int ticket2_=5555555555555;
extern double minus_kolvo=0;
extern double minus=0;
extern double plus=0;
extern double sutki=0;
extern double sutki_kolvo=0;
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

if (OrderSelect(ticket, SELECT_BY_TICKET, MODE_HISTORY));
if (OrderProfit() < 0 && ticket2!=ticket){
kolvo=kolvo+1;ticket2=ticket;

minus=minus+1000-(1000+OrderProfit());
minus_kolvo=minus_kolvo+1000-(1000+OrderProfit());

      /////
      if(sutki_kolvo==0){lot=0.03;
      //lot = NormalizeDouble((minus/100)/hod,2);

      //if(kolvo<3){lot=0.03;}else{
      lot = NormalizeDouble((minus/100)/hod,2);//}
      }
      if(sutki_kolvo!=0){//lot=0.02;
      //if(kolvo<3){lot=0.03;}else{
      lot = NormalizeDouble(((1000-sutki_kolvo+minus)/100)/hod,2);//}
      //lot = NormalizeDouble(((1000-sutki_kolvo+minus)/100)/hod,2);
      }
      ////

}

if (OrderProfit() > 0 && ticket2_!=ticket)
{kolvo=0;minus_kolvo=0;plus=plus+OrderProfit();ticket2_=ticket;
      if(sutki_kolvo==0){lot=0.03;}
      if(sutki_kolvo!=0){lot=0.03;
      //lot = NormalizeDouble(((1000-(sutki_kolvo-plus))/100)/hod,2);
      
      }
      
}
//if(minus<3){lot=0.02;}
//if(minus>10){lot=0.02;}
//if(plus>1000-sutki_kolvo+5){lot=0.02;}
//if(plus>10){lot=0.02;}


     if(nedelya!=iOpen(NULL,PERIOD_D1,0))
                                             
     {
       nedelya=iOpen(NULL,PERIOD_D1,0); 
       sutki=plus-minus;
       if(sutki>0){sutki_kolvo=0;}
       if(sutki<0){sutki_kolvo=1000+sutki;}
       if(plus==0 && minus==0){sutki_kolvo=0;}
       Print("-------------------------------plus- ",plus,"       minus- ",minus,"        sutki- ",sutki," ");
       //Print("-------------------------------plus- ",plus,"       minus- ",minus,"        sutki- ",1000-sutki_kolvo," ");
       sutki=0; plus=0; minus=0;     
     }



Comment("kolvo- ",kolvo,"       minus- ",minus,"        тикет- ",GetLastOrderHist()," " );

TrailingPositions();



//Print(plus-minus);// ||    
//if(minus>20){chas_1=7;chas_2=Hour();}
//if(plus-minus>1.5){chas_1=7;chas_2=Hour();}
//else{chas_1=7;chas_2=22;}

if (Time[0]>lastbar)
{
lastbar=Time[0]; 
datetime exp = CurTime() + 3600;//86400

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

if(Ask-Bid < 10*Point){ 
//if(Hour()>8 && Hour()<11 || Hour()>14 && Hour()<17 ){
//if(Hour()>chas_1 && Hour()<chas_2){
if(Hour()>9 && Hour()<11){
//if(CountBuy()==0){tik1 = OrderSend(Symbol(), OP_BUYSTOP, lot, iOpen(NULL,PERIOD_H1,0)+open*Point, 3, iOpen(NULL,PERIOD_H1,0)+sl*Point, iOpen(NULL,PERIOD_H1,0)+tp*Point, "Open",Magic,exp);}
if(CountSell()==0){tik2 = OrderSend(Symbol(), OP_SELLSTOP, lot, iOpen(NULL,PERIOD_H1,0)-open*Point, 3, iOpen(NULL,PERIOD_H1,0)-sl*Point, iOpen(NULL,PERIOD_H1,0)-tp*Point, "Open", Magic,exp);}
          }
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