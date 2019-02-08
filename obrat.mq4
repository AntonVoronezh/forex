int tik1,tik2;
 extern double lot;
extern double open = 100;
extern double tp = 600;
extern double sl = 1;
int Magic= 111;
static datetime lastbar;

int init()
{
return(0);
lastbar=Time[Bars-1];
}

int start()
{
if (Time[0]>lastbar)
{
lastbar=Time[0]; 
lot=GetLots_minus();


//if(profit() && profit()>0) return;

//Comment(LastOrder_1());
datetime exp = CurTime() + 3600;//60*60*24*5
double skolko = Skolko_BUY()+Skolko_SELL();

Print(skolko);



int i,n,NumberOfLong;

n=OrdersTotal();NumberOfLong=0;
for (i=n-1; i>=0; i--)
{
if(OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
if (OrderMagicNumber() != Magic) continue;
if(OrderCloseTime()==0)
//if (CurTime() - OrderCloseTime() < 24*60*60) return; 
NumberOfLong++;

}


if(Ask-Bid < 10*Point){
if (NumberOfLong==0)
{ 
//надо сделать это
tik1 = OrderSend(Symbol(), OP_SELLLIMIT, lot, iOpen(NULL,PERIOD_D1,0)+200*Point, 3, iOpen(NULL,PERIOD_D1,0)+400*Point, iOpen(NULL,PERIOD_D1,0)+1*Point, "Open",Magic,exp);
tik2 = OrderSend(Symbol(), OP_BUYLIMIT, lot, iOpen(NULL,PERIOD_D1,0)-200*Point, 3, iOpen(NULL,PERIOD_D1,0)-400*Point, iOpen(NULL,PERIOD_D1,0)-1*Point, "Open", Magic,exp);

return(0); 
} 

if (NumberOfLong==1)
{ 
//надо сделать это iOpen(NULL,PERIOD_H1,0)>Ask
if (OrderType()==OP_SELLSTOP && iOpen(NULL,PERIOD_W1,0)+1*Point>Ask){
//tik1 = OrderSend(Symbol(), OP_BUYSTOP, lot, iOpen(NULL,PERIOD_W1,0)+open*Point, 3, iOpen(NULL,PERIOD_W1,0)+sl*Point, iOpen(NULL,PERIOD_W1,0)+tp*Point, "Open",Magic,exp);

}
if (OrderType()==OP_BUYSTOP && iOpen(NULL,PERIOD_W1,0)-1*Point<Bid){
//tik2 = OrderSend(Symbol(), OP_SELLSTOP, lot, iOpen(NULL,PERIOD_W1,0)-open*Point, 3, iOpen(NULL,PERIOD_W1,0)-sl*Point, iOpen(NULL,PERIOD_W1,0)-tp*Point, "Open", Magic,exp);
}
return(0); 
}
}
}
}
//////////////////////////////////////////////////////////////////////////////////////
int return1() {
int orders = 0;
int cnt = HistoryTotal();
for (int i=0; i < cnt; i++) {
if (!OrderSelect(i, SELECT_BY_POS, MODE_HISTORY)) continue;
if (OrderMagicNumber() != Magic) continue;

if (CurTime() - OrderCloseTime() > 60*60) continue;

int type = OrderType();
if (type == OP_BUY || type == OP_SELL) 
{
if (OrderProfit() < 0) orders++; 
if (OrderProfit() > 0) orders++;
}
}

if (orders > 0) return(OrderCloseTime());
}
//////////////////////////////////////////////////////////////////////////////////////
int return11() {
int ticket = GetLastOrderHist();
if (ticket == -1) return (0);
if (!OrderSelect(ticket, SELECT_BY_TICKET, MODE_HISTORY)) return (0);
if (OrderType() == OP_BUY || OrderType() == OP_SELL) 
if (CurTime() - OrderCloseTime() > 24*60*60) return(false);
if (CurTime() - OrderCloseTime() < 24*60*60) return(true);
}
//////////////////////////////////////////////////////////////////////////////////////NormalizeDouble(frUP + 5*Point,Digits);

//////////////////////////////////////////////////////////////////////////////////////
double profit() {
int ticket = GetLastOrderHist();
if (ticket == -1) return (0);
if (!OrderSelect(ticket, SELECT_BY_TICKET, MODE_HISTORY)) return (0);
return (OrderProfit());
}
//////////////////////////////////////////////////////////////////////////////////////NormalizeDouble(frUP + 5*Point,Digits);


double GetLots_minus() {
int lastprofit = -1; //- принимает значения -1/1. 
//-1 - увеличение лота после минусовой сделки до первой плюсовой.
//1 - увеличение лота после плюсовой сделки до первой минусовой.
double lotmin = 0.01; //- начальное значение
double lotmax = 1.0; //- потолок
double lotstep = 0.01; //- приращение лота 
double skolko = Skolko_BUY()+Skolko_SELL();

int ticket = GetLastOrderHist();
if (ticket == -1) return (lotmin);

if (!OrderSelect(ticket, SELECT_BY_TICKET, MODE_HISTORY)) return (lotmin);
if (OrderProfit()*lastprofit < 0) return (lotmin);

//lot = OrderLots();
if(skolko<4) lot = lotmin;
else lot = lotmin*10;
return (lot);
}
//////////////////////////////////////////////////////////////////////////////////////
double GetLots_plus() {
int lastprofit; //- принимает значения -1/1. 
//-1 - увеличение лота после минусовой сделки до первой плюсовой.
//1 - увеличение лота после плюсовой сделки до первой минусовой.
double lotmin = 0.01; //- начальное значение
double lotmax_plus = 0.4; //- потолок
double lotmax_minus = 3.5; //- потолок
double lotstep_plus = 0.01; //- приращение лота 
double lotstep_minus = 0.1; //- приращение лота 

int ticket = GetLastOrderHist();
if (ticket == -1) return (lotmin);

if (!OrderSelect(ticket, SELECT_BY_TICKET, MODE_HISTORY)) return (lotmin);
if(OrderProfit()>0)
{
lastprofit = 1;
if (OrderProfit()*lastprofit < 0) return (lotmin);
lot = MathMin(OrderLots() + lotstep_plus, lotmax_plus);
}
if(OrderProfit()<0)
{
lastprofit = -1;
if (OrderProfit()*lastprofit < 0) return (lotmin);
if(OrderLots()<1.1) lot = MathMin(OrderLots()*1.5, lotmax_minus);
else lot = MathMin(OrderLots()*2, lotmax_minus);
}


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
//////////////////////////////////////////////////////////////////////////////////////