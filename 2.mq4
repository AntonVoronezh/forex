int tik1,tik2;
static datetime lastbar;


int init()
{
lastbar=Time[Bars-1];
}
int start()
{
datetime exp = CurTime() + 86400;//60*60*24

if (Time[0]>lastbar)
{
lastbar=Time[0];


tik1 = OrderSend(Symbol(), OP_BUYSTOP, 0.1, iOpen(NULL,PERIOD_D1,0)+10*Point, 3, iOpen(NULL,PERIOD_D1,0)+1*Point, iOpen(NULL,PERIOD_D1,0)+1500*Point, "Open",3600,exp);
tik2 = OrderSend(Symbol(), OP_SELLSTOP, 0.1, iOpen(NULL,PERIOD_D1,0)-10*Point, 3, iOpen(NULL,PERIOD_D1,0)-1*Point, iOpen(NULL,PERIOD_D1,0)-1500*Point, "Open", 255,exp);

 


return(0);
}

 

}