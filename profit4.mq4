int tik1,tik2;
double vremya=iOpen(NULL,PERIOD_W1,0);
extern double lot=0.01;
extern double open = 100;
extern double tp = 400;
extern double sl = 1;
extern double tp_sell,tp_buy,skolko;
//int Magic= DayOfYear();
int Magic= 111;

int start()
{



datetime exp = CurTime() + 3600;//60*60*24*5


if(!profit()) tp_buy=vremya+tp*Point;tp_sell=vremya-tp*Point;


if(profit() && profit()>0) return;



if(profit() && profit()<0){

skolko = Skolko_BUY()+Skolko_SELL();

if(Skolko()!=0)tp_buy=vremya+tp*Point+skolko*50*Point;
               tp_sell=vremya-tp*Point-skolko*50*Point;
                           }
                         
//Print(DayOfYear());                    
Print(skolko);





int i,n,NumberOfLong;

n=OrdersTotal();NumberOfLong=0;
for (i=n-1; i>=0; i--)
{

if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
if (OrderMagicNumber() != Magic) continue;
if(OrderCloseTime()==0) 
NumberOfLong++;

}


 
if(Ask-Bid < 10*Point){
if (NumberOfLong==0)
{ 
//надо сделать это
tik1 = OrderSend(Symbol(), OP_BUYSTOP, lot, vremya+open*Point, 3, vremya+sl*Point, tp_buy, "Open",Magic,exp);
tik2 = OrderSend(Symbol(), OP_SELLSTOP, lot, vremya-open*Point, 3, vremya-sl*Point, tp_sell, "Open", Magic,exp);
//Print(lot);
return(0); 
} 

if (NumberOfLong==1)
{ 
//Ask-iLow(NULL,PERIOD_W1,1)>0

if (Ask-(vremya+1*Point)<0){
tik1 = OrderSend(Symbol(), OP_BUYSTOP, lot, vremya+open*Point, 3, vremya+sl*Point, tp_buy, "Open",Magic,exp);

}
if (Ask-(vremya-1*Point)>0){
tik2 = OrderSend(Symbol(), OP_SELLSTOP, lot, vremya-open*Point, 3, vremya-sl*Point, tp_sell, "Open", Magic,exp);
}

}
}
return(0);
}

//////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////

//////////////////////////////////////////////////////////////////////////////////////
double profit() {
int ticket = GetLastOrderHist();
if (ticket == -1) return (0);
if (!OrderSelect(ticket, SELECT_BY_TICKET, MODE_HISTORY)) return (0);
return (OrderProfit());
}
//////////////////////////////////////////////////////////////////////////////////////NormalizeDouble(frUP + 5*Point,Digits);




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
//////////////////////////////////////////////////////////////////////////////////////NormalizeDouble(frUP + 5*Point,Digits);


int Skolko_BUY() 
{
int PosCnt = 0;
int cnt = HistoryTotal();
for (int i = cnt-1; i >=0; i--) {

if (!OrderSelect(i, SELECT_BY_POS, MODE_HISTORY)) continue;
//if (OrderSymbol() != Symbol()) continue;
if (OrderMagicNumber() != Magic) continue;


int type = OrderType();
if (type != OP_BUY) continue;

if (OrderProfit() > 0) break;

PosCnt++;
}

return (PosCnt);
}
//////////////////////////////////////////////////////////////////////////////////////NormalizeDouble(frUP + 5*Point,Digits);


int Skolko_SELL() 
{
int PosCnt = 0;
int cnt = HistoryTotal();
for (int i = cnt-1; i >=0; i--) {

if (!OrderSelect(i, SELECT_BY_POS, MODE_HISTORY)) continue;
//if (OrderSymbol() != Symbol()) continue;
if (OrderMagicNumber() != Magic) continue;


int type = OrderType();
if (type != OP_SELL) continue;

if (OrderProfit() > 0) break;

PosCnt++;
}

return (PosCnt);
}
//////////////////////////////////////////////////////////////////////////////////////NormalizeDouble(frUP + 5*Point,Digits);


int Skolko() 
{
int PosCnt = 0;
int cnt = HistoryTotal();
for (int i = cnt-1; i >=0; i--) {

if (!OrderSelect(i, SELECT_BY_POS, MODE_HISTORY)) continue;
//if (OrderSymbol() != Symbol()) continue;
if (OrderMagicNumber() != Magic) continue;


int type = OrderType();
if (type != OP_SELL && type !=OP_BUY) continue;

if (OrderProfit() > 0) break;

PosCnt++;
}

return (PosCnt);
}


