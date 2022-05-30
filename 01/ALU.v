module ALU (
    x,y,zx,nx,zy,ny,f,no,out,zr,ng
);
input x;
input y;
input zx;
input nx;
input zy;
input ny;
input f;
input no;

output out;
output zr;
output ng;

reg tempx;
wire tempnotx;

always @* //NOTE: You are describing combo logic, since there is no clock signal
begin

      if(zx == 0)
        tempx = 0;
      else 
        tempx = x;
        
end
not g1(tempnotx, tempx);
    
endmodule