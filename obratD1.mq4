int tik1,tik2;
 extern double lot=0.01;
extern double open = 50;//300-350
extern double tp = 0;//550
extern double sl = 100;
extern double hod = 1;
extern double lot_new; 
int Magic= 400800;
static datetime lastbar;
extern double kolvo = 0; 
int ticket2=5555555555555;
extern double minus =0;
extern double m_l_1,m_l_2,m_l_3,m_l_4,m_l_5,m_l_6,m_l_7,m_l_8; 
extern double nedelya = 1.00001;

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

     if(kolvo==1){m_l_1 = 1000-(1000+OrderProfit());minus=m_l_1;}
     if(kolvo==2){m_l_2 = 1000-(1000+OrderProfit());minus=m_l_1+m_l_2;}
     if(kolvo==3){m_l_3 = 1000-(1000+OrderProfit());minus=m_l_1+m_l_2+m_l_3;}          
     if(kolvo==4){m_l_4 = 1000-(1000+OrderProfit());minus=m_l_1+m_l_2+m_l_3+m_l_4;}
     if(kolvo==5){m_l_5 = 1000-(1000+OrderProfit());minus=m_l_1+m_l_2+m_l_3+m_l_4+m_l_5;}
     if(kolvo==6){m_l_6 = 1000-(1000+OrderProfit());minus=m_l_1+m_l_2+m_l_3+m_l_4+m_l_5+m_l_6;}
     if(kolvo==7){m_l_7 = 1000-(1000+OrderProfit());minus=m_l_1+m_l_2+m_l_3+m_l_4+m_l_5+m_l_6+m_l_7;}     
     if(kolvo==8){m_l_8 = 1000-(1000+OrderProfit());minus=m_l_1+m_l_2+m_l_3+m_l_4+m_l_5+m_l_6+m_l_7+m_l_8;}      
//
lot = NormalizeDouble((minus/100)/hod+0.01*kolvo,2);
}

if (OrderProfit() > 0)
{kolvo=0;minus=0;}



Comment("kolvo- ",kolvo,"       minus- ",minus,"        tiket- ",GetLastOrderHist()," " );


//TrailingPositions();


int a=OrdersTotal();
for (int f=a-1; f>=0; f--)
{
if(OrderSelect(f,SELECT_BY_POS,MODE_TRADES))
if (OrderMagicNumber() != Magic) continue;
if(OrderCloseTime()==0) 
if(lot!=OrderLots())OrderDelete(OrderTicket());
}



datetime exp = CurTime() + 432000;//


int i,n,NumberOfLong;
n=OrdersTotal();NumberOfLong=0;
for (i=n-1; i>=0; i--)
{
if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
if (OrderMagicNumber() != Magic) continue;
if(OrderCloseTime()==0) 
NumberOfLong++;
}
////
if(nedelya!=iOpen(NULL,PERIOD_D1,0))
//if (Time[0]>lastbar)
{
lastbar=Time[0]; 
 
         int aa=OrdersTotal();
         for (int ff=aa-1; ff>=0; ff--)
         {
         if(OrderSelect(ff,SELECT_BY_POS,MODE_TRADES))
         if (OrderMagicNumber() != Magic) continue;
         if(OrderCloseTime()==0) 
         OrderDelete(OrderTicket());
         }
         

 nedelya=iOpen(NULL,PERIOD_D1,0);       
}

////
if(Ask-Bid < 10*Point){
if (NumberOfLong==0)
{ 
      if (Ask-iOpen(NULL,PERIOD_D1,0)<0 ){
      tik2 = OrderSend(Symbol(), OP_SELLLIMIT, lot, iOpen(NULL,PERIOD_D1,0)+open*Point, 3, iOpen(NULL,PERIOD_D1,0)+sl*Point, iOpen(NULL,PERIOD_D1,0)+tp*Point, "Open", Magic,exp);
      }
      if (Ask-iOpen(NULL,PERIOD_D1,0)>0 ){
      tik1 = OrderSend(Symbol(), OP_BUYLIMIT, lot, iOpen(NULL,PERIOD_D1,0)-open*Point, 3, iOpen(NULL,PERIOD_D1,0)-sl*Point, iOpen(NULL,PERIOD_D1,0)-tp*Point, "Open",Magic,exp);
      }
return(0); 
}

if (NumberOfLong==1)
{ 


if (Ask-iOpen(NULL,PERIOD_D1,0)<0 && CountSell()==0){
tik2 = OrderSend(Symbol(), OP_SELLLIMIT, lot, iOpen(NULL,PERIOD_D1,0)+open*Point, 3, iOpen(NULL,PERIOD_D1,0)+sl*Point, iOpen(NULL,PERIOD_D1,0)+tp*Point, "Open", Magic,exp);
}
if (Ask-iOpen(NULL,PERIOD_D1,0)>0 && CountBuy()==0){
tik1 = OrderSend(Symbol(), OP_BUYLIMIT, lot, iOpen(NULL,PERIOD_D1,0)-open*Point, 3, iOpen(NULL,PERIOD_D1,0)-sl*Point, iOpen(NULL,PERIOD_D1,0)-tp*Point, "Open",Magic,exp);
}
//return(0); 
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
 int lMinProfit = 10;
 int sMinProfit = 10;
 int lTrailingStop = 500;
 int sTrailingStop = 500;
 int lTrailingStep = 10;
 int sTrailingStep = 10;


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
      if(OrderSymbol()==Symbol() && OrderMagicNumber()==Magic)
        {
         if(OrderType()==OP_BUYLIMIT)
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
      if(OrderSymbol()==Symbol() && OrderMagicNumber()==Magic)
        {
         if(OrderType()==OP_SELLLIMIT)
            count++;
        }
     }

   return(count);
}