program p;
const eps = 0.001;
type TF = function (x:real): real;
{$F+}
function f (x:real): real;  begin f:= exp(ln(2)*x) + 1 end;
function g (x:real): real;  begin g:= exp(ln(x)*5) end;
function e (x:real): real;  begin e:= (1 - x)/3 end;
var s, x1, x2, x3: real;
procedure root (f, g: TF;  a, b, eps1: real; var x: real);
var c: real;
begin
   c := (a*(f(b) - g(b)) - b*(f(a) - g(a))) / (f(b) - g(b)- f(a) + g(a));
   while (f(c) - g(c))*(f(c + eps1)-g(c + eps1)) > 0 do
     c := (c*(f(b) - g(b)) - b*(f(c) - g(c))) / (f(b) - g(b)- f(c) + g(c));
   x := c;
end;
function integral(f:TF;a,b,eps2:real):real;
var n, i: integer; st, fin, sum0, sum1, i1, i2, h: real;
begin
  i := 1; n := 10; sum1 := 0; h := (b-a)/n; st := f(a); fin:= f(b);
  while i < n do begin
    sum1 := sum1 + f(a+i*h);
    i := i + 2;
  end;
  i := 2; sum0 := 0;
  while i < n do begin
    sum0 := sum0 + f(a+i*h);
    i := i + 2;
  end;
  i1 := (h/3)*(st + 4*sum1 + 2*sum0 + fin);
  n := n*2; h := h/2; i := 1;
  sum0 := sum0 + sum1; sum1 := 0;
  while i < n do begin
    sum1 := sum1 + f(a+i*h);
    i := i + 2;
  end;
  i2 := (h/3)*(st + 4*sum1 + 2*sum0 + fin);
  while (abs(i1 - i2))/15 >= eps2 do begin
     i1 := i2; n := n*2; h := h/2; i := 1;
     sum0 := sum0 + sum1; sum1 := 0;
     while i < n do begin
       sum1 := sum1 + f(a+i*h);
       i := i + 2;
     end;
     i2 := (h/3)*(st + 4*sum1 + 2*sum0 + fin);
  end;
  integral := i2;
end;
begin
  root(f, g, 1, 5, 0.00001, x1);
  root(f, e, -3, -1, 0.00001, x2);
  root(g, e, 0.5, 2, 0.00001, x3);
  s := integral(f, x2, x1, 0.00001) - integral(g, x3, x1, 0.00001) - integral(e, x2, x3, 0.00001);
  writeln(s:0:3);
end.

