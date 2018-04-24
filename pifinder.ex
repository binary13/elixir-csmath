defmodule Pi do
  def find(num) do
    list(num) |> List.last()
  end
  
  def list(num), do: calc(1,0,1,1,3,3,num,[],0)
 
  defp calc(_q,_r,_t,_k,_n,_l,num,list,c) when c==num do
    list
  end
  
  defp calc(q,r,t,k,n,l,num,list,c) when (4*q + r - t) < n*t do
    calc(q*10, 10*(r-n*t), t, k, div(10*(3*q+r), t) - 10*n, l,num, list++[n], c+1)
  end
  defp calc(q,r,t,k,_n,l,num,list,c) do
    calc(q*k, (2*q+r)*l, t*l, k+1, div(q*7*k+2+r*l, t*l), l+2, num, list, c)
  end
end