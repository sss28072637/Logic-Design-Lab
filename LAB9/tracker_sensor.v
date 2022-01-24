//black => 1 white => 0

module tracker_sensor(clk, reset, left_track, right_track, mid_track, state);
    input clk;
    input reset;
    input left_track, right_track, mid_track;
    output reg [1:0] state;

    // TODO: Receive three tracks and make your own policy.
    // Hint: You can use output state to change your action.
    always @(posedge clk or posedge reset) begin
        if(reset) begin
            state <= 2'b10; 
        end
        else begin
            if(left_track) begin
                state <= 2'b11;
            end
            else if(right_track) begin
                state <= 2'b01;
            end
            else begin
                state <= 2'b10;
            end
        end
    end


endmodule
