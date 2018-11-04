clc
%rp=0.2;
%rg=0.5;
%cp=2;
%cg=2;


function okay(rp, rg, cp, cg)
  x1_values = zeros(1, 100);
  x2_values = zeros(1, 100);
  disp(' we have to minimize f = 100(x1^2-x2)^2+(1-x1)^2 i.e. rosenbrock function')
  p=input('Enter the no. of particles in a swarm ');           %no. of particles
  it=input('Enter the no. of iterations ');
  x1=zeros(p,it); 
  x2=zeros(p,it);
  v1=zeros(p,it);
  v2=zeros(p,it);
  f=zeros(p,it);
  fp=zeros(1,p);  
  df=zeros(1,(it-1));

  T=input('Enter the tolerance value ');
  % Initial values i.e. 0th iteration
   x1(:,1)=[1.2886 0.7572 1.6232 1.0657 0.7015 1.8780 1.7519 1.1003 1.2450 1.1741];
   x2(:,1)=[0.4155 0.6025 0.9418 0.4610 1.6886 0.3895 0.4518 0.3414 0.4553 0.8714];
   v1(:,1)=[0.0326 0.5612 0.8819 0.6692 0.1904 0.3689 0.4607 0.9816 0.1564 0.8555];   
   v2(:,1)=[0.2518 0.2904 0.6171 0.2653 0.8244 0.9827 0.7302 0.3439 0.5841 0.1078];   
  %x1(:,1)=unifrnd(0,2,1,p);
  %x2(:,1)=unifrnd(0,2,1,p);
  %v1(:,1)=rand(1,p);
  %v2(:,1)=rand(1,p);
  % i=0;
  % disp (sprintf('enter the values of %dth iteration positions of %d particles for variable x1',i,p))
  % for j=1:p
  %     x1(j,1)=input(sprintf('enter the value of x1(%d,%d)',j,i));
  % end
  % disp (sprintf('enter the values of 0th iteration positions of %d particles for variable x2',p))
  % for j=1:p
  %     x2(j,1)=input(sprintf('enter the value of x2(%d,%d)',j,i));
  % end    
  % disp (sprintf('enter the values of 0th iteration positions of %d particles for variable v1',p))
  % for j=1:p
  %     v1(j,1)=input(sprintf('enter the value of v1(%d,%d)',j,i));
  % end
  % disp (sprintf('enter the values of 0th iteration positions of %d particles for variable v2',p))
  % for j=1:p
  %     v2(j,1)=input(sprintf('enter the value of v2(%d,%d)',j,i));
  % end
  for j=1:p
      f(j,1)= 100*( (x1(j,1))^2 - x2(j,1) )^2 + (1- x1(j,1))^2 ;
  end


  %Initial personal besst values
  x1p=x1(:,1);
  x2p=x2(:,1);

  %for Initial Global best values updation
  fmin=min(f(:,1));
  for k=1:p
      if f(k,1)==fmin
          gb=k;
      else
      end
  end
  %Initial global best value
  x1g=zeros(p);
  x2g=zeros(p);
  for k=1:p
  x1g(k) = x1(gb,1);
  x2g(k) = x2(gb,1);
  end
  fgm = min(f(:,1));

  % fig=zeros(1,485);
  % t=zeros(1,485);


  for i=1:it
      %disp(sprintf('This is %d no. of iteration',i))

  %for inertia weight W
      wmax=0.9;
      wmin=0.4;
      w = wmax-i*((wmax-wmin)/it); 
        
      for j=1:p
          v1(j,(i+1)) = w*v1(j,i) + rp*cp*(x1p(j)-x1(j,i)) + rg*cg*(x1g(j)-x1(j,i));
          v2(j,(i+1)) = w*v2(j,i) + rp*cp*(x2p(j)-x2(j,i)) + rg*cg*(x2g(j)-x2(j,i));
          x1(j,(i+1)) = x1(j,i) + v1(j,(i+1));
          x2(j,(i+1)) = x2(j,i) + v2(j,(i+1));
          f(j,(i+1))= 100*( (x1(j,(i+1)))^2 - x2(j,(i+1)) )^2 + (1- x1(j,(i+1)))^2 ;
      end

  %To find change in the values of f
      for j=1:p
          df(j,i)= abs(f(j,(i+1))-f(j,i)) ;
      end
     
  %personal best values updation
      for j=1:p
          fp(j)= 100*( (x1p(j))^2 - x2p(j) )^2 + (1- x1p(j))^2 ;
      end
      for k=1:p
          if f(k,i)< fp(k)
              x1p(k)=x1(k,i);
              x2p(k)=x2(k,i);
          else
          end
      end
      
  %for Global best values updation
      if min(f(:,(i+1)))<fgm
          fgm=min(f(:,(i+1)));
      else
      end
      
      for j=1:i
          for k=1:p
          if f(k,i)==fgm
              for l=1:p
                  x1g(l) = x1(k,i);     %global best values
                  x2g(l) = x2(k,i);
              end
          else
          end
          end
      end
      
      %uncomment these 3 lines below this
      %print = [x1(:,i) x2(:,i) v1(:,i) v2(:,i) f(:,i)];
      %disp('     x1        x2        v1        v2        f')
      %disp(' x1 x2 ')
      %print = [x1(:,i) x2(:,i)];
      %disp(print)
      x1_values(i) = x1(:,i)(1);
      x2_values(i) = x2(:,i)(1);
      disp(' x1first x2first ')
      print2 = [x1(:,i)(1) x2(:,i)(1)];
      disp(print2)
      %disp(x1_values);
      %disp(x2_values);
      
  %     fig(i) = figure('Position', [100 100 500 350]);
  %     t(i) = uitable('Parent', fig(i), 'Position', [25 25 450 200]);
  %     print = [x1(:,i) x2(:,i) v1(:,i) v2(:,i) f(:,i)];
  %     set(t(i), 'Data', print);
  %     set(t(i), 'ColumnName', {'x1', 'x2', 'v1', 'v2', 'f'});
      
  %Stoping criterion
      ki=0;
      for j=1:p
          if (df(j,i)<=10^(-T))10
          
              ki=ki+1;
          end
      end
      if ki >= p
          break
      end

  end
  [r,c]=find(f==fgm);
  minf=100*( (x1g(j))^2 - x2g(1) )^2 + (1- x1g(1))^2;
  disp(sprintf('min value of function is %d and at values of x1=%d and x2=%d ',minf,x1g(1),x2g(1)))
  %plot(x1_values, x2_values);
  plot(x1_values, x2_values);
end



okay(0.2,0.3,2,2);

