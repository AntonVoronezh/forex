int tik1,tik2;
 extern double lot;
extern double open = 300;
extern double tp = 600;
extern double sl = 1;
int Magic= 222;




int start()
{
lot=GetLots_minus();
//lot=0.1;
TrailingPositions();

datetime exp = CurTime() + 432000;//60*60*24*5



//if (Ask-iOpen(NULL,PERIOD_W1,0)>0){Print (open);}
//if (Ask-iOpen(NULL,PERIOD_W1,0)<0){Print (tp);}


int i,n,NumberOfLong;

n=OrdersTotal();NumberOfLong=0;
for (i=n-1; i>=0; i--)
{
if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
if (OrderMagicNumber() != Magic) continue;
if(OrderCloseTime()==0) 
NumberOfLong++;
if(lot!=OrderLots())OrderDelete(OrderTicket());
}

if(Ask-Bid < 10*Point){

if (NumberOfLong==0)
{ 
tik1 = OrderSend(Symbol(), OP_BUYSTOP, lot, iOpen(NULL,PERIOD_W1,0)+open*Point, 3, iOpen(NULL,PERIOD_W1,0)+sl*Point, iOpen(NULL,PERIOD_W1,0)+tp*Point, "Open",Magic,exp);
tik2 = OrderSend(Symbol(), OP_SELLSTOP, lot, iOpen(NULL,PERIOD_W1,0)-open*Point, 3, iOpen(NULL,PERIOD_W1,0)-sl*Point, iOpen(NULL,PERIOD_W1,0)-tp*Point, "Open", Magic,exp);
return(0); 
}

if (NumberOfLong==1)
{ 
Print(CountBuy());
//надо сделать это iOpen(NULL,PERIOD_H1,0)>AskNormalizeDouble(Open[0]+15*Point,Digits)
if (Ask-iOpen(NULL,PERIOD_W1,0)<0 && CountBuy()==0){
tik1 = OrderSend(Symbol(), OP_BUYSTOP, lot, iOpen(NULL,PERIOD_W1,0)+open*Point, 3, iOpen(NULL,PERIOD_W1,0)+sl*Point, iOpen(NULL,PERIOD_W1,0)+tp*Point, "Open",Magic,exp);

}
if (Ask-iOpen(NULL,PERIOD_W1,0)>0 && CountSell()==0){
tik2 = OrderSend(Symbol(), OP_SELLSTOP, lot, iOpen(NULL,PERIOD_W1,0)-open*Point, 3, iOpen(NULL,PERIOD_W1,0)-sl*Point, iOpen(NULL,PERIOD_W1,0)-tp*Point, "Open", Magic,exp);
}
//return(0); 
}
}
}

//////////////////////////////////////////////////////////////////////////////////////


double GetLots_minus() {
int lastprofit = -1; //- принимает значения -1/1. 
//-1 - увеличение лота после минусовой сделки до первой плюсовой.
//1 - увеличение лота после плюсовой сделки до первой минусовой.
double lotmin = 0.02; //- начальное значение
double lotmax = 0.9; //- потолок
double lotstep = 0.01; //- приращение лота 


int ticket = GetLastOrderHist();
if (ticket == -1) return (lotmin);

if (!OrderSelect(ticket, SELECT_BY_TICKET, MODE_HISTORY)) return (lotmin);
if (OrderProfit()*lastprofit < 0) return (lotmin);

     if(OrderLots()==0.02){lot = 0.06;}
     if(OrderLots()==0.06){lot = 0.15;}
     if(OrderLots()==0.15){lot = 0.31;}
     if(OrderLots()==0.31){lot = 0.63;}
     if(OrderLots()==0.63){lot = 1.26;}
return (lot);
}
//////////////////////////////////////////////////////////////////////////////////////
double GetLots_minuskkk() {
int lastprofit = -1; //- принимает значения -1/1. 
//-1 - увеличение лота после минусовой сделки до первой плюсовой.
//1 - увеличение лота после плюсовой сделки до первой минусовой.
double lotmin = 0.15; //- начальное значение
double lotmax = 0.6; //- потолок
double lotstep = 0.01; //- приращение лота 


int ticket = GetLastOrderHist();
if (ticket == -1) return (lotmin);

if (!OrderSelect(ticket, SELECT_BY_TICKET, MODE_HISTORY)) return (lotmin);
if (OrderProfit()*lastprofit < 0) return (lotmin);

//lot = MathMin(OrderLots() + lotstep, lotmax);

if(OrderLots()<0.15) lot = MathMin(OrderLots()*2, lotmax);
else lot = MathMin(OrderLots()*2, lotmax);
return (lot);
}
//////////////////////////////////////////////////////////////////////////////////////


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
 int lTrailingStop = 300;
 int sTrailingStop = 300;
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



///////////////////////////////////////
int GetTYPE() 
{
int ticket = -1;
int i,n;
n=OrdersTotal();
for (i=n-1; i>=0; i--)
{
if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
if (OrderMagicNumber() != Magic) continue;
if(OrderCloseTime()==0) 

ticket=OrderType();


}
return (ticket);
}

/////////////////////////////////////



int CountBuy()
  {
   int count=0;
   for(int trade=OrdersTotal()-1;trade>=0; trade--)
     {
      OrderSelect(trade,SELECT_BY_POS,MODE_TRADES);
      if(OrderSymbol()==Symbol() && OrderMagicNumber()==Magic)
        {
         if(OrderType()==OP_BUYSTOP)
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
         if(OrderType()==OP_SELLSTOP)
            count++;
        }
     }

   return(count);
  }