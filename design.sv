`timescale 1ns / 1ns
module traffic_light
(input clk,rst,
 output reg[5:0] z
);
reg[3:0] time_count;
  
reg[1:0] state,next_state;
  
parameter goH=2'b00, waitH=2'b01, waitF=2'b11, goF=2'b10;
  
parameter time_s1=4'd3, time_s2=4'd1, time_s3=4'd3, time_s4=4'd1;
  
parameter led1=6'b001100, led2=6'b010100, led3=6'b100001, led4=6'b100010;
             
always@(posedge clk or posedge rst)
  begin if(rst) begin state<=goH; end
        else state<=next_state;
end


always@(next_state or rst or time_count)
  begin if(rst) next_state=goH;
        else begin
                case(state)
                  goH:begin if(time_count==0) next_state<=waitH;
                            else next_state<=goH;
                    end
                  waitH:begin if(time_count==0) next_state<=goF;
                            else next_state<=waitH;
                    end
                  goF:begin if(time_count==0) next_state<=waitF;
                            else next_state<=goF;
                    end
                  waitF:begin if(time_count==0) next_state<=goH;
                            else next_state<=waitF;
                    end
                default:next_state<=goH;
                endcase
                end
end


always@(posedge clk)
begin if(rst) time_count<=time_s1;
        else begin 
              case(next_state)
                goH:begin z=led1;
                            if(time_count==0) time_count=time_s1-1;
                            else time_count=time_count-1;end
                waitH:begin z=led2;
                            if(time_count==0) time_count=time_s2-1;
                            else time_count=time_count-1;end
                goF:begin z=led3;
                            if(time_count==0) time_count=time_s3-1;
                            else time_count=time_count-1;end
                waitF:begin z=led4;
                            if(time_count==0) time_count=time_s4-1;
                            else time_count=time_count-1;end
                endcase
                end
end
endmodule

