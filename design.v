module sequencedetector_1101 (
  input logic clk,
  input logic rst,
  input logic in,
  output logic out
);
  parameter s0 = 2'b00,
  			s1 = 2'b01,
  			s2 = 2'b10,
  			s3 = 2'b11;
  logic [1:0] state, next_state;
  
  always_ff @(posedge clk or posedge rst) begin
    if (rst)
      state <= s0;
    else
      state <= next_state;
  end
  
  always_comb begin
    case(state)
      s0:begin
        if (in)
          next_state = s1;
        else
          next_state = s0;
      end
      s1:begin
        if (in)
          next_state = s2;
        else
          next_state = s0;
      end
      s2:begin
        if (in)
          next_state = s2;
        else
          next_state = s3;
      end
      s3:begin
        if(in)
          next_state = s1;
        else
          next_state = s0;
      end
      
      
      default: next_state = s0;
      
    endcase
  end
      
  always_comb begin
    out = 1'b0;
    case(state)
      s3:begin
        if(in)
          out = 1'b1;
      end
    endcase
  end
endmodule