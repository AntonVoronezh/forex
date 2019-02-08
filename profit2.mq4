int tik1,tik2;
extern double lotmin = 0.01; 
extern double lotmax = 0.1; 
extern double lotmax_2 = 0.2;
extern double lotmax_3 = 0.4;
extern double lot; 
 
extern double open = 300;
extern double tp = 600;
extern double sl = 1;

int start()
{
if(!LastOrder()) {lot=lotmin;}
if(LastOrder()>0) {lot=lotmin;}
//if(LastOrder()< LastOrder_1()) {lot=lotmax;if(LastOrder()<0 && LastOrder_1()<0){lot=lotmax_2;}}
if(LastOrder()<0 && LastOrder()<-10) 
{
lot=0.1;

}


//if(LastOrder()<0) lot=lotmax;
//return(lot);

Comment(LastOrder_1());
datetime exp = CurTime() + 3600;//60*60*24*5





int i,n,NumberOfLong;

n=OrdersTotal();NumberOfLong=0;
for (i=n-1; i>=0; i--)
{
if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
//if(OrderSymbol()==Symbol())//OrderMagicNumber()==MAGIC OrderType()==OP_BUY||OrderType()== OP_SELL)
if(OrderCloseTime()==0) 
NumberOfLong++;
Print(n);
}

if(Ask-Bid < 10*Point){
if (NumberOfLong==0)
{ 
//надо сделать это
tik1 = OrderSend(Symbol(), OP_BUYSTOP, lot, iOpen(NULL,PERIOD_W1,0)+open*Point, 3, iOpen(NULL,PERIOD_W1,0)+sl*Point, iOpen(NULL,PERIOD_W1,0)+tp*Point, "Open",3600,exp);
tik2 = OrderSend(Symbol(), OP_SELLSTOP, lot, iOpen(NULL,PERIOD_W1,0)-open*Point, 3, iOpen(NULL,PERIOD_W1,0)-sl*Point, iOpen(NULL,PERIOD_W1,0)-tp*Point, "Open", 255,exp);

return(0); 
} 

if (NumberOfLong==1)
{ 
//надо сделать это iOpen(NULL,PERIOD_H1,0)>Ask
if (OrderType()==OP_SELLSTOP && iOpen(NULL,PERIOD_W1,0)+1*Point>Ask){
tik1 = OrderSend(Symbol(), OP_BUYSTOP, lot, iOpen(NULL,PERIOD_W1,0)+open*Point, 3, iOpen(NULL,PERIOD_W1,0)+sl*Point, iOpen(NULL,PERIOD_W1,0)+tp*Point, "Open",3600,exp);

}
if (OrderType()==OP_BUYSTOP && iOpen(NULL,PERIOD_W1,0)-1*Point<Bid){
tik2 = OrderSend(Symbol(), OP_SELLSTOP, lot, iOpen(NULL,PERIOD_W1,0)-open*Point, 3, iOpen(NULL,PERIOD_W1,0)-sl*Point, iOpen(NULL,PERIOD_W1,0)-tp*Point, "Open", 255,exp);
}
return(0); 
}
}
}
//////////////////////////////////////////////////////////////////////////////////////

int LastOrder(int type = -1) 
{
double Profit;
int ticket = -1;
datetime dt = 0;
int cnt = OrdersHistoryTotal();
for (int i=1; i < cnt; i++) {
if (!OrderSelect(i, SELECT_BY_POS, MODE_HISTORY)) continue;
if (type != -1 && OrderType() != type) continue;
if (OrderType()==OP_BUY || OrderType()==OP_SELL) {
if (OrderCloseTime() > dt) {
dt = OrderCloseTime();
ticket = OrderTicket();
Profit = OrderCommission()+OrderSwap()+OrderProfit();
}
}
}
return (Profit);
}


//////////////////////////////////////////////////////////////////////////////////

int LastOrder_1(int type = -1) 
{
double Profit;
int ticket = -1;
datetime dt = 0;
int cnt = OrdersHistoryTotal()-1;
for (int i=1; i < cnt; i++) {
if (!OrderSelect(i, SELECT_BY_POS, MODE_HISTORY)) continue;
if (type != -1 && OrderType() != type) continue;
if (OrderType()==OP_BUY || OrderType()==OP_SELL) {
if (OrderCloseTime() > dt) {
dt = OrderCloseTime();
ticket = OrderTicket();
Profit = OrderCommission()+OrderSwap()+OrderProfit();
}
}
}
return (Profit);
}


//////////////////////////////////////////////////////////////////////////////////

double LastOrder_2(string sy="", int op=-1, int mn=-1) {
  datetime t;
  double   r=-1;
  int      i, k=OrdersHistoryTotal()-2;

  if (sy=="0") sy=Symbol();
  for (i=0; i<k; i++) {
    if (OrderSelect(i, SELECT_BY_POS, MODE_HISTORY)) {
      if (OrderSymbol()==sy || sy=="") {
        if (OrderType()==OP_BUY || OrderType()==OP_SELL) {
          if (op<0 || OrderType()==op) {
            if (mn<0 || OrderMagicNumber()==mn) {
              if (t<OrderCloseTime()) {
                t=OrderCloseTime();
                r=OrderTakeProfit();
              }
            }
          }
        }
      }
    }
  }
  return(r);
}
